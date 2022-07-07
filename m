Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AA5C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 08:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E00312BA4C;
	Thu,  7 Jul 2022 08:23:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4152412BA4C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 08:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wruf2lhf/wGvK1uaaBllWVp74kWUcOYE7OqU10QoaO+WBZaJGJ+pSepXJMX1FsW+APmGS2ucMPRGyn/+WDXxPZ+3arTNnvW8hxqrczrLScG7u/OfZHZYrwsWw2MMo/n/6nP0nasB7VEeglYbO9bL0OMd5A+uX10nij0JTZGD7iePca79NpDPxq2y7a5+QMgMHP8x0B7juwH3oMCDcVEptiIgDXo/hlu81y0KJgiCYGHd2lbpjDXMBuwGCfDzPXe+QqhiMTZDlueNCW65/69XQBnmUtYl+5RJebF1g86tJc6KLuE89I/PVOPvNwEUH31UUIDNMiJbG0FuSS/4koEdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Sg23WgskfTU0wR/90B5BdWoFjnZ7fiELNnoV+tSCI=;
 b=fkdI6JTxr+mV2XJuAKwBuobiVofvOoWQvt3V6klw6jDASlREN8tTMmuDkbMmPgda+bVOf322lIq94MnMUNxhn/sk4Z+X8rIv+ZQooBW0mn6pCbPU7ctOKMQkzcZKTJ15MEqg/KxPIx8o/wz2XNQihyd4o7RZ17px//0wwfcabAkauP6Yqin0Fd4b/UF6ZdrWO9EOBMqenbiNRHrS2uXDoqEH0NpoODi0Mz9DRsqW6USpIYM7U2K0CaE7cE0W/ZCiXYhGa9Uh+ryIUyA9tnGvD7n2OM1Bg4QgP180KKKsmsgHfzBv1sVHuHKlXqxnqthAXh91Z8wgwhlJGMHpADfJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Sg23WgskfTU0wR/90B5BdWoFjnZ7fiELNnoV+tSCI=;
 b=UiG3soPats3fzWOeeJDu84TYcMuL09Ea1XhtBmDFYfjl7rkE2it3ORvdRjPguGit21Eh9LeoGw4KEUERabbKP1H5Lf5oQqEdQrnfT2EKHahv1RE+qvile9/QpRM+Olv4SNpjKHYGVTwIhax1yO2W1cxgHsTobI5D80TPFmkoBm0=
Received: from MWHPR07CA0005.namprd07.prod.outlook.com (2603:10b6:300:116::15)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 08:23:48 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::64) by MWHPR07CA0005.outlook.office365.com
 (2603:10b6:300:116::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 08:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 08:23:47 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 03:23:42 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix new dmub notification enabling in DM
Date: Thu, 7 Jul 2022 16:23:29 +0800
Message-ID: <20220707082329.936987-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2add4f3a-2b03-4290-892b-08da5ff203a2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5188:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKiX03/SVaSbSOrdgeaf+0gsuUanimUdCu1jA424rfwNt9LXSRa8my0fHd15msd9ZxUO3nENUzWcBWNOeX3pF1gxcdFPr+25M0z3xpIk0YP7gi82Gv7Gg5LEHFlM9BWjU/2xuSJeGsDNM/O2hXoRvxVHXTLof97PU6OFvhkornoeVkf1jwJ5U7y1xrqdMzcBuSpXO97hCShQ2jsuWuhdQ9FBa8xxs+nhQzhSdzs2lfsooH5kcLDumkTQP6/8sxT6JgNvv7qvYk85Of56PFSYmhFSt5pLL0gTkCsnv/BEktT5OiEkmZVz2rdkDt5Uq2qzMRsW2p3SKcNu09oyn2YfwyqLRIVlYaekPC6mhZXhcihrIigosFHwR1jFfAwsiqNhuKwjU0vc10xkL1insoQCxBdeSDdyhU70VwjXSdoj90i0lVB2HeBnGp/gpZqJphs8iHVvf9zY2VyC0fDa52J+9HBeoZl2bbY7TGpLzbBTRNjOlgdDwY79Xtr5GGH/i60voq48wKjVr2f+8nnuzguZ6n16YjmSN45e8TuLa90TKWSMP/orJ29dDFdw3dtbJYUuNbnqW8VyPtDSGHOSUXO3FPN6kxAKZO1Z9j/w4MHskQqcHkDd/8pyeFEJgddg94e86j2pv+g5AIqlplVKhkDdLHft+RPQ3B/fM8sjn+AXnO1SFkTk99EkNw7eF6JtGXnVRkYgIOgEtC27ZchSHLrmdp2oPldf0mW0eFl643QIHNwkRP/5Jm86zviTQ+XIBolmGdVlFdRpbeNxJBC+FWRdjMIRTF6tv2G+fa0cKGahRQ/wpfzU0efiYbFhbbK5Ea7AVziAewCyGrED7v1CAO7w+iAf0U5jNdeQ9Q7WkPZ+k1+oIGnyTUR3T4lkd7FuU20s
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(40470700004)(8936002)(478600001)(186003)(426003)(40460700003)(336012)(83380400001)(44832011)(16526019)(5660300002)(86362001)(36756003)(34020700004)(316002)(1076003)(54906003)(40480700001)(2616005)(6916009)(26005)(47076005)(82740400003)(356005)(15650500001)(41300700001)(70206006)(6666004)(81166007)(70586007)(36860700001)(2906002)(4326008)(82310400005)(8676002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 08:23:47.2179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2add4f3a-2b03-4290-892b-08da5ff203a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Changes from "Fix for dmub outbox notification enable" need to land
in DM or DMUB outbox notification would be disabled.

[How]
Enable outbox notification only after interrupt are enabled and IRQ
handlers registered. Any pending notification will be sent by DMUB
once outbox notification is enabled.

Fixes: ed7208706448 (“drm/amd/display: Fix for dmub outbox notification enable”)
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb5efb4aa2ba..de1c139ae279 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1617,7 +1617,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	adev->dm.crc_rd_wrk = amdgpu_dm_crtc_secure_display_create_work();
 #endif
-	if (dc_enable_dmub_notifications(adev->dm.dc)) {
+	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
 		init_completion(&adev->dm.dmub_aux_transfer_done);
 		adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
 		if (!adev->dm.dmub_notify) {
@@ -1653,6 +1653,13 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		goto error;
 	}
 
+	/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
+	 * It is expected that DMUB will resend any pending notifications at this point, for
+	 * example HPD from DPIA.
+	 */
+	if (dc_is_dmub_outbox_supported(adev->dm.dc))
+		dc_enable_dmub_outbox(adev->dm.dc);
+
 	/* create fake encoders for MST */
 	dm_dp_create_fake_mst_encoders(adev);
 
@@ -2625,9 +2632,6 @@ static int dm_resume(void *handle)
 		 */
 		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
 
-		if (dc_enable_dmub_notifications(adev->dm.dc))
-			amdgpu_dm_outbox_init(adev);
-
 		r = dm_dmub_hw_init(adev);
 		if (r)
 			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
@@ -2645,6 +2649,11 @@ static int dm_resume(void *handle)
 			}
 		}
 
+		if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
+			amdgpu_dm_outbox_init(adev);
+			dc_enable_dmub_outbox(adev->dm.dc);
+		}
+
 		WARN_ON(!dc_commit_state(dm->dc, dc_state));
 
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
@@ -2666,13 +2675,15 @@ static int dm_resume(void *handle)
 	/* TODO: Remove dc_state->dccg, use dc->dccg directly. */
 	dc_resource_state_construct(dm->dc, dm_state->context);
 
-	/* Re-enable outbox interrupts for DPIA. */
-	if (dc_enable_dmub_notifications(adev->dm.dc))
-		amdgpu_dm_outbox_init(adev);
-
 	/* Before powering on DC we need to re-initialize DMUB. */
 	dm_dmub_hw_resume(adev);
 
+	/* Re-enable outbox interrupts for DPIA. */
+	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
+		amdgpu_dm_outbox_init(adev);
+		dc_enable_dmub_outbox(adev->dm.dc);
+	}
+
 	/* power on hardware */
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
-- 
2.37.0

