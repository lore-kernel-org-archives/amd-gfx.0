Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A3EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 04:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BCC10E63C;
	Fri, 11 Aug 2023 04:28:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6160D10E63C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 04:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJNXzre1c9GLZyR+R8vu1Zbz8ewm87eNTbGL70ox/2LFYWKwnBy6eCAZVcAV4Wd/Mvgg58e+OZiiQJB3iJQ3aTTy5+o3nr8bw8SEKdyMMIjNjVmDUs9x71Fqo/oIMC5GqsMKBTrJuEeApvjwC/uSbc9o44EFn3/fdM6aGX6aKxyRwqHKbmp4gXJRaLINa3Z8xg8Z/MTCasx9Mh7SoOinY4mIvNASLNyQDcSCsPImTdWGGZ0Ef3UxuuIc0QtpfrtjvgUMuiiHMjtNCQg4DPvw/7iVSYHmyWheW2bmWDzdmmF21Hzop2uwpxNWT7llQ0EkLRRa6EEGF3VhiwRi1yEeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI8E/LREvXi26rjfKNvLB4HTHh0OOpdfSUuei67Ns/s=;
 b=ZXbUHGLO4Ot5nfG2mTqzRBmGChBQ9CJkDNlaie3aF+VPMSmlQLCK0RHp2nMsE+Zvrn1rHsQOFprRyBMOmr+GOuwq2/h8myryB6dKTaFibxG17QDmtkGhBkaac/UGJetFs8E37TeMG6upJOvXP4jDmlImaeNMq+7hPs39HsIgK4GfvVcZdr2fpy5P1ZQZ1C9lqzUpw0jPxpAZIbPtrA2Gc+2TF9mOJ/LuP39JQ9ZgTlgmqYm9a0T2tykPdkdOAjjj+iYhLfIqU5wG+CXspXRownkS1auhSAmnAyWR/rZBTpt+CXghJOPk2KuA4y8rq6xusspKOKed5LEMAj79snQyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI8E/LREvXi26rjfKNvLB4HTHh0OOpdfSUuei67Ns/s=;
 b=H3W1/mH/TmQFiMbQSrqRnSA2rXuVMX1PL9WdoJX1tyQuuKVOTnP2jsKOvLARDfIkZUvCUhhsiUFQKheRcBDQ8vklznDMgNXDs2/DNhl3edHi3O6/xbOP7/PS/o7iV8csWyLXI5xlUu+3XySOW0QyltzLqOc72jgne9klE365Yu8=
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 04:28:11 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::dd) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 04:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 04:28:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 23:28:10 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Thu, 10 Aug 2023 23:28:09 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add unique_id for gc 11.0.3
Date: Fri, 11 Aug 2023 12:28:06 +0800
Message-ID: <20230811042806.767993-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e0138e-09f9-4ab6-3927-08db9a235ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeoilCla9oS8OAf/SRXPi6yK+NXqC7X04aKSmxLWrG9f7aUYI/X1Lrvvh2C1fsVZqZ6dl3fQ2kfiBSgVaQticEgxCSuK4e3y5nC1OyuqTBBFTVZLWYTY1pVLlWzzQCDnGZrW7P6vY0SSAxl5+p2uR6mfyjkp/9+sInF5dRb3wmXpBoy6gy+yZTjZXq96tUh/w7fS6AZojF/iX6Yw7oFFTSejGtSh37K+nvzi20J7RT0+7G0GDQJi0omZ3v8/BeDGraYjS4rI+bFmOfKOWYKCI1/FjxS6gTMVwH8xJyXrxjcqWnrvaI7036Aa4mGlUu0ba//bRWn/oNxKGmFzzpYEAkIucHT53PC76pA+aGdKoBX+MF/v2Jao5jTz13l45XfLZF8hPDukP5Sxf9pMA+eWGHngL0cMHxt0sNCsxFm22KJw4ZgK5B61ZMdjUGB+HgXZevqkV6cVW8VJzRCHshWE4J6+rdDKx22Wsd/A84/RVwh1jMe9/GbOkkdxmWPgceb0qnpeshdbsKLDpwU6D1ySQs5hFAFXL4DjnJ49QeWPIqleb7bVpMXrjHEs4Y8CBy89rKsTCqMAvTM4dU8Y/t7qrrPNQWb0NJy55gMaTcov1xCiTquAAMTE1CWpI/EXA2pF1V+m+evXKTldMWkPN1d1bFoDsIui65Zl7BtvqpZfGyotNf6s2RfelA6H9/ckUylTYviThDqoVzsSimT7Vlx3FoYY/lx60WvK/S88b6zxON35z3fujD23GJWmEe7QExT/rh1VtiuL2a2ZgsQFUa15dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(82310400008)(186006)(1800799006)(451199021)(40470700004)(36840700001)(46966006)(70206006)(41300700001)(81166007)(70586007)(5660300002)(4326008)(316002)(356005)(6916009)(82740400003)(44832011)(8936002)(8676002)(336012)(26005)(83380400001)(7696005)(478600001)(36860700001)(1076003)(2616005)(426003)(36756003)(40480700001)(40460700003)(6666004)(86362001)(2906002)(47076005)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 04:28:10.9428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e0138e-09f9-4ab6-3927-08db9a235ef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm/amd/pm: add unique_id for gc 11.0.3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5aed023f7402..c69701da94ea 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2076,6 +2076,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
+		case IP_VERSION(11, 0, 3):
 			*states = ATTR_STATE_SUPPORTED;
 			break;
 		default:
-- 
2.34.1

