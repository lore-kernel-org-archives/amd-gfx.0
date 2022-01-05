Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50678C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jan 2022 22:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38C710E42B;
	Wed,  5 Jan 2022 22:36:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9627810E48A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jan 2022 22:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqzIMZksDhhY/yqy81nSgkrURxJABpNEMZiJzoNazmvFlASOJLY0FjGV619Fce+gJlQ6xTxzmgUpKSR8oI620AueBbklFwoZ6ZGxkmz1yQUmIC9HQEJcxNtNUQpkX/90jbPqDC9tFUKNcfj/VCZi/lBRlmq5zzCznX66EotywtuTLUc8gr4q94kbD2hIV0lQSsWA/7vsMYXaDdx81vKKWlBWOIKEIwIt1auJgxIBGHzBNFfluIV7LeuUgvrQed1VIMZWq776cdycdczApFli5EF+P0sorScr1Cz8zAG9ynQFC7d9UFYa4lqVGlVtumEmgXmmwd/+hL5lSSPnsOqYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+3FRKy7CJdQr4+FV1FDoYQvlu2G5Yd4HGaDFgTUDcM=;
 b=V8IcV+aXqYY4/Rw6fXwj52A3NK8o3tR/dgBtLm2n2CvDZyB2b3VRsayNnAC/dG2ZKYcloAPIVfD09xZTCJh0n0eMhuttgKeJ3rIqGmUsSUZxlrQ2AxBr4clY9p866gVVpcZmwe+JT4jog9EJSwPIn/OoQj4rmWfszMv6TOM++LiP8j3aOs6TOvoe+UBZIf1cweCcmBEET8JNcjuI+WUVU0ReBa4Jjc77xqUPyipEwb5bds4Q31GQ37Cc0MF/TWWhcOYpPXYc22VeSJy2lQOKfkGAi3xRYpk9OPktoKZe8mAbSSP4//Y2TqPCiWmULCamhya/ohKoui0hmNz4wL5+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+3FRKy7CJdQr4+FV1FDoYQvlu2G5Yd4HGaDFgTUDcM=;
 b=v/Nc3ldxdbsb2aUUSxYZHNXwPvZBQ1M5S9BUqQrfIHM+Jbs9gdJTsDnmXerLDm02TqJ6pq51//BiR6CeC93znbtIW8MIAsv9obFAH11K5e5ZPpdFuJXcfKVAwUCutasadvvStYQdApdZDwiGjdVBtRsHANu5FuRhBxp455s7tw4=
Received: from MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) by BYAPR12MB3016.namprd12.prod.outlook.com
 (2603:10b6:a03:dc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 22:36:14 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::69) by MWHPR1601CA0016.outlook.office365.com
 (2603:10b6:300:da::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16 via Frontend
 Transport; Wed, 5 Jan 2022 22:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 22:36:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 16:36:12 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amd/display: Use requested power state to avoid
 HPD WA during s0ix
Date: Wed, 5 Jan 2022 16:35:58 -0600
Message-ID: <20220105223558.22848-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105223558.22848-1-mario.limonciello@amd.com>
References: <20220105223558.22848-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11eca145-4825-421c-a8ad-08d9d09bc82e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3016:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB301665D5D9DBB7DBCB368183E24B9@BYAPR12MB3016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbAS6Eh+v8+tyyWTfDQZNQHxOO3AXlJYcxm0ioUKCuLwyLumam39LztgDAUj4hf1mpiTPjTQZvB9yF8y08BaONEjy5zcCoTu1ZGNoXOi5Xi+9TCj6bk2VcD284Uj9fledfqFflmCLSlgQm1n9va58lmd310ON+CWcjxSoUUDR95hBHbXwDaisMOGcTfI1DzOXcwXFoBkIu3CNI/xEgDgOm3DqIR59upJk7LIhWoCQnPjvW3O/WCO8c1y0T0VrObfN+cm4ADRkdMCt/JrgmvwR7HQMMbyBg3yXPwUMI+v1JhjqqTAqSPctGgXx97nmRgqUTIysbWBOL/hhwML8cgShVlW2+SPyq9F86/YA85EfdhJ6vKy4WldW7RBm/RAC7dDxnn4sjJMy/XwC1KzlE7SvPXHob1MdkNhd4vkV16EaPPFsLmTEbeRh1tllF9k6Vqi293K/jzdMZLooAwCZjbQ16Q0qgjbcJ/otFZD+OdJqtBuzAvT3TCQFP1N2BBnEZ6WH2cLD+e4flkffkhZgiu+K4Sgz0rkVa82c4Kz9WS8C4cz4LC64HKrCjGo+jbGAqfzMq9zX+dzdhf3raty0j2o4mXr+DNP1dxOnE93wRw/OQvuQZH8gAeEO/nHa/RFF264N6Lc1XNjvQpH4/ZhOd30ejzHsLPIG2aE8ojFxWwgHCU8Ad+/paWYS3oKMDnO3Pc63h6xRVCCs7Bt26x4NmyG8TGg6LgfK/bWe3tcUOE9SATgbPqCFI99Xkqupx/edHJKWU4T1f55xbUb/TUXRqZfiVr0Ma9itXLe6+laCfmHy4NS5n2X3TM231g5OJZw+2iMu2ywO9CpzDTeuphF1r009hbkco3tnIPSeNzYfgVMrXKV/xOCvw77JHDaej4v9FR6SNdvYYNQjSrFRh3S0/v1Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(336012)(36860700001)(186003)(44832011)(426003)(2616005)(47076005)(36756003)(4326008)(54906003)(6666004)(316002)(7696005)(6916009)(86362001)(16526019)(356005)(966005)(5660300002)(2906002)(8676002)(8936002)(83380400001)(81166007)(70206006)(26005)(40460700001)(70586007)(508600001)(82310400004)(1076003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:36:14.5082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eca145-4825-421c-a8ad-08d9d09bc82e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3016
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>, spasswolf@web.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The WA from commit 5965280abd30 ("drm/amd/display: Apply w/a for
hard hang on HPD") causes a regression in s0ix where the system will
fail to resume properly.  This may be because an HPD was active the last
time clocks were updated but clocks didn't get updated again during s0ix.

So add an extra call to update clocks as part of the suspend routine:
dm_suspend->dc_set_power_state->clk_mgr_optimize_pwr_state

In case HPD is set during this time, also check if the call happened during
suspend to allow overriding the WA.

Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reported-by: Scott Bruce <smbruce@gmail.com>
Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
Reported-by: spasswolf@web.de
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215436
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1821
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1852
Fixes: 5965280abd30 ("drm/amd/display: Apply w/a for hard hang on HPD")
Fixes: 1bd3bc745e7f ("drm/amd/display: Extend w/a for hard hang on HPD to dcn20")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v2->v3:
 * stop depending on adev, get value of power state from display core
changes from v1->v2:
 * Add fallthrough statement
 * Extend case to check if call was explicitly in s0ix since #1852 showed hpd_state
   can be set at this time too
 * Adjust commit message and title
 * Add extra commit and bug fixed to metadata
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c                  | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index fbda42313bfe..44311a971236 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -157,7 +157,8 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 			}
 
 			/* if we can go lower, go lower */
-			if (display_count == 0 && !hpd_state) {
+			if (display_count == 0 &&
+			   (dc->current_state->power_state == DC_ACPI_CM_POWER_STATE_D3 || !hpd_state)) {
 				rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
 				/* update power state */
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2954485b474c..bad5129facbc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3301,6 +3301,9 @@ void dc_set_power_state(
 		}
 
 		break;
+	case DC_ACPI_CM_POWER_STATE_D3:
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
+		fallthrough;
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
 		/* Zero out the current context so that on resume we start with
-- 
2.25.1

