Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913C1EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C8E10E450;
	Fri, 30 Jun 2023 11:22:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB8B10E450
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/afBnIYAcPHZy5MkZ2Qbuf+BlOxgNcslNwILD2CYr0ykSDkgVVIDfi3zSvEn25uhEGdsHifK+yhlpXAGKy5yyuN+Lk1j0mOEKDhtMJoLGU+xkATn6rxb8VbhJBTMy3+UluVE3zVNPN1ze9dEzDUZka0VhHf1Fdbk6qQ2jvbBBBCjzivuE7SWwJ41WVgteTjqL0lSMIL/VzsL5xgG7Ves8NShg3jiHOHrUw8hpMVKfElU+xPwfmSUFbpWke2WAYYNL04/ezzUpRqnhMOLfk6UkvSjGK6ZfSG9rw1FfrwPe2UyqcAKgm87LDMJallydqRSYfTf34j37EUSR4/RL2LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh/3ggson8XCzwiJFa1cfUAfiQI8hHuN3vQIS2CWV6Y=;
 b=Oruy8umJa8XLU4SoqwPtePa15Yrf/JIRw2Ih3zmoO8Fj9bn9wkjyi9ec3whvf0tR8MCwzAThP8FIFVbKziBst70rF79Pq7DQMQ4SOGeRRSvmpzGzXYIS8T4uqCj5sQE0ukrovuucV+4OrIjmRrGN9vMzBavFJ2tQiaipowgdvYjHOP0JPzXucMDaxQ/5+kV4x1IiXRgHTzreHv7ZX0jviIdUktE/EVqw5iMnkapSMFNp0PXqqIt+xY43/Vu8l9ugZFEOsPm/hX8j5RnFCXtPIXkwaJYToHHZcTDkcoZduVcFm6Lrv8PWgO6hRURHXtaCEkEAsSbowdgLd42Y2vpiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh/3ggson8XCzwiJFa1cfUAfiQI8hHuN3vQIS2CWV6Y=;
 b=cQjCoTxKXlgp4mPN+GOqsUE9HPszohC9654Gw8HXQ/ZkH9eQb/1ae+19CfY1qFG/ZHJsOShze7JYj3VM3/EaoPPklJXdyQTPlMMO8PkiLSb+5Bu6UVgqd6c1BkAdMFneDwl+Z7qN8LQH9gtjMpuu5uJWmkZRYRo5jAZaPaavCtI=
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 11:21:56 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::97) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 11:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 11:21:55 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 06:21:53 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3 chip
Date: Fri, 30 Jun 2023 19:21:35 +0800
Message-ID: <20230630112135.3347421-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c53b9fe-622e-471c-c33d-08db795c367d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfwlmHi/s8qCR7bfO9Z91oGJJHMW0obAsFfnY84pUcr9CTPcjFQiEuEvmvx/HjvVlxqqIw9nd90aMIDKXK8WRnEPhmcVdSnzS+6WUlm/IA6HKZxx+JQfHvR3NVzfEhmCLknY3ot2PkugzdP5S0fbAKVS35rBdLXMAKNfJOPfoCL98De6nmjBC6s2QPjw3USOIBF03opXZKldFpwI7pFKev6lfjAoydqzOQxccHrEkrsP+cO+5fbAhu3Nme/9r7uNV9UQrFqzacj75BYN63gywcDcz8XtWo1ifsCbLZne1NMMlKpE7g6a990sSyebUNMmHb4117G+ie14oJjjB+PGFb8CZoXONwLmEcxi0+IRHD9vd9txFF85WcolA2beQsyjmK8DwAX6XMBczuPvl/iqZv5OibrFzcCMffTrx0WKgPKZtF/B+HHZKjPoXHY+h9k/sqGMBK3xtjtNky7+ekX2ZtN9hOGRm9qbgKP1n9bk1B/ROMZAmytFXoxefhXDBI3NSQYCny5cXL8+/zc7lPLIdYHUFToeayMwaqiIQ0Uqycz+Vaj8Uol+kXXpU2xnBZnQr99peevphEzaoGVGgCqRbh5/XukKGGNEtP67KrnGCXkyeXynmZ9883ZnsxyR6Ak87gwcqGIUnxc6oCKHHKekLx014o6AQpZhc2ntFyK0mcPoyqM3Ork99I69FQDUqAXpG8wNdksX3SuU0iGsQRMg4Fa+fPouEnwnUx+ZqUtM0ivNf7wmenE/wQZHPE/vbCiQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(70206006)(186003)(26005)(4744005)(2906002)(6916009)(1076003)(82740400003)(426003)(336012)(2616005)(47076005)(40460700003)(40480700001)(16526019)(36860700001)(356005)(70586007)(5660300002)(8936002)(83380400001)(41300700001)(36756003)(6666004)(316002)(8676002)(4326008)(86362001)(7696005)(82310400005)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:21:55.9814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c53b9fe-622e-471c-c33d-08db795c367d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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
Cc: Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the dceflck sysnode is not aviable on GFX v9.4.3 chip.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ef88a0b1b57..5bf401533103 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2050,7 +2050,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
 		if (gc_ver < IP_VERSION(9, 0, 0) ||
 		    gc_ver == IP_VERSION(9, 4, 1) ||
-		    gc_ver == IP_VERSION(9, 4, 2))
+		    gc_ver == IP_VERSION(9, 4, 2) ||
+		    gc_ver == IP_VERSION(9, 4, 3))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (mp1_ver < IP_VERSION(10, 0, 0))
-- 
2.34.1

