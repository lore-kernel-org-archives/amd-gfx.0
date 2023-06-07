Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80360C7EE29
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA5710E4D9;
	Wed,  7 Jun 2023 12:17:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E7FB10E4D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utnlhoyfam73rNMv5VONd1VziqHYzMXEgW9DuXsanFkKk8g727I01zGydbHSU2wTWyAYAUsPVCBtKSZfUzmWekkZM3g5pflUAaWEE+g0y4Yj3vjpUSfiTYrgOVmKRaDxV7ALsAOP46A8jzbp2+x6LdeaW8Hw7HWzI/VXRiLmxGF1h/HFgpcksKnIGXiAFc0VtFOZAI0rG7DulZcOflyLPl6NV1bM5gkss53rceQjjUeg7lPvb0n1EL+kWZ2wgUS+4aoIAHWTlPfa8K8U3VtosBNuzY2x0gYvut5aZi9waJ6h0ra8HYTANZX1RgTTpj4kxqH+RRCZ4dBViUHY+467Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e932Y7+o4A+XICGZeCqkkXsFk7wlvJCRVXQ7ptuA1ns=;
 b=dDLRb21zwhZpYjS5g3IxR2p1wxBTGjtCEOwzJTRETIr9jsrCou5O1HbyFiLIzhvLhdfGh8ShG+Sgzyit0QR/NUueaJsH3X27jPD3XIykFpLM2pQIDo4uUKNYE/N33BtzSsG7vBeyMSspoM7K7/8tKqZz7ehEvsxpCJQjqVEC8MATnL10xfQemBZQM+KUHzwg6icWYM9CnnpJoQVEWJUgDhFoDJ8WDZ2mhu4TkYsUCzR2B5kNmflA1kcuG/lCmDi+wOVCAh/XkY9x561KHNEO57abZ2t6H59AAFeYg2qgWern39zMtANGwPZ9t8v2F3AZVfgINFH7TJW8SNkF+GwyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e932Y7+o4A+XICGZeCqkkXsFk7wlvJCRVXQ7ptuA1ns=;
 b=F0MZ8Znr2KV3NAkfZt001pIKCp7hdHg1SZ82lMH53Pd1rd+eJoSCZRxjS4DP9714uepLavJK1GvxaQBe/v8UpaZT0Etmwa7NJQAsR5n/zF0JtMC2GVZqYZzk0CPHEl7cqfnsRFiOk0sDn/XKnq7xDk2HO0qGw+Ii0CUbx2Ym6rk=
Received: from CY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:930::19) by
 SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:17:07 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::37) by CY5PR13CA0005.outlook.office365.com
 (2603:10b6:930::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:07 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:17:03 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/20] drm/amd/display: Bug fix in
 dcn315_populate_dml_pipes_from_context
Date: Wed, 7 Jun 2023 20:15:42 +0800
Message-ID: <20230607121548.1479290-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 4870bc5a-b5c4-49fd-e5e0-08db67511cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MxuoKSaEuZc/FPENTZ6abbcmJiM74JcMqj/Y5/LzwMGdFOknj0uOm5kx3Kdy7a+EMeG2vvTncoc/FnFOtQ0IPgsrmH/Qh02Kv0+vTRX4Yjw6DNi1gir8ygrkoH03paITCXb8b9rxIG78P8VmLOWM/6vKTTsU5C4UtNA0c8v6d/4T65sZEXh2b+x/YOLU5OdwoR8zG/NmHhNDsdr4M8ab7dBZuaywjj2iYZRD8sMJWFUB9ZSfvYWOLAJRro3gBtZN1XxfsySlwaNsrxpP6jp406TpMD1OHWtY6qqGeuN9SBdDTdjbrRllIVu/MC2QxAi/C8XDWSceqGeefXf0AlbIysP3bNLvqMhnRcMmb4fOyt1Ug9pf67v9iMGuB5iy/DyL+Ep0ZnmGFmg8z83j9LTx6AI6vXIpwnfGCpI5HbMO0VNBj+VumIisBkYri0fEPjRWAXiyvQ91X9UjaxHYgte9zzGCF4xR4+Naul0alMvs5dhypxYSfcPFHq0gWVqPGjogMZcoyHHUM5Po6yVNyJm5lezYJerj5igSIjZeaERr+l7neTnD5EMxgZxdGTQFuuMwUi2fCAQiw62Eo5BGZzTvY/QMb9OnvBjiKDzmI77Sf+fKbDOf1GWPqWECYWZ/NFMYtUx1EDd/fvuh5s+yL6ZPNjnZX//NujvdA4Ekj1x6Pw9ovGsKWuq367CUnsKKURQZVGpMthqu+lE2CNPgozObJdTBMMLre8jiF4FQN+pMHxeYgbPFV9+8qgRXq8lDpmUFjZxfdFdK16yOhB3m4GI6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(70586007)(7696005)(6666004)(82740400003)(2906002)(356005)(70206006)(81166007)(54906003)(44832011)(8676002)(8936002)(36756003)(5660300002)(86362001)(41300700001)(6916009)(316002)(40480700001)(4326008)(478600001)(40460700003)(426003)(336012)(2616005)(1076003)(26005)(186003)(82310400005)(36860700001)(16526019)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:07.4641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4870bc5a-b5c4-49fd-e5e0-08db67511cc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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
Cc: stylon.wang@amd.com, Artem Grishin <artem.grishin@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Artem Grishin <artem.grishin@amd.com>

[Why]
When iterating over all pipes in the loop, the CRB allocation algorithm
may potentially skip some of the pipes. Previously, the current pipe
index didn't get updated in this case, causing incorrect outcome.

[How]
Increment the pipe index when skipping over a pipe in the loop.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Artem Grishin <artem.grishin@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 0cc853964781..f1153941907e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1742,6 +1742,7 @@ static int dcn315_populate_dml_pipes_from_context(
 			/* Do not use asymetric crb if not enough for pstate support */
 			if (remaining_det_segs < 0) {
 				pipes[pipe_cnt].pipe.src.det_size_override = 0;
+				pipe_cnt++;
 				continue;
 			}
 
-- 
2.40.1

