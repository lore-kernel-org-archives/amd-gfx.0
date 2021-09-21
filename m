Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE95C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF2F61168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BF2F61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8495C6EA6A;
	Tue, 21 Sep 2021 18:07:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D811C6EA37
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z33tdw1p8v9BfjasPGfFc6rxq5GgXea1lHU69svKbyCCrkFo2i77XXqQrFlhE51FgxDlFI/CZd6XzhkfQ3jC05KfJHMNNGZrlMVmEWOMsVWTtOnrlF2QZLekQl2RiDsfd7hdCLjmEoCd7M5ehcaegneurRAaadtCOuapQD2woRBquNHCDg5HazAXO4VZKSWOolKdaONrjEZm+XQkaHpL4UQyNsk5kZD+hBF0AHLwlFsULjvdun0yq8DRMFu/Pu1AaFsM5uETROtoIZd6VBPBiP79w1jQuBFttjSKeqJSymmb773n/zXwcmdbxMu04wL0Hi9v9ZCyNdh6KYsLr/aAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=yYFD/qjoW6tKaQ+zQTDEMLjpKPq1m/Xx7B0Q10UbXwQ=;
 b=XdrTiACMujvMc5awZRzaVGKm06GLdeDcShwOnBIhdaOColBQcbD3W6fF6Tmqdoe4mBW2UnlAcOmghhzdxecJQbABin8pHPA5W67yuiCXIb7rbbIcujmS3eyUEnZ3KudNZwPWnko58plQkmeRydmgS2xJ+WXmep2xO1uHMSSNi1RTrt4xvzotHHmNhdM/q7S0sU1AUoj+Cy9DLp3xVMrgZYJY777k9ArlHjLSntZdtY41/SWp60V+MwU011l3bEaElSh75Yb8lIO164FoBi3p1GdF9l0GB1ZUSjv1PiXW9oJcPapgehbnGqRQMir+Jcc8t66m15tJUN4n+GpZT4vr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYFD/qjoW6tKaQ+zQTDEMLjpKPq1m/Xx7B0Q10UbXwQ=;
 b=hCr6ben0QF4YQF70RdyZiKOfDissY2sta+XfUapkbFJVsXx7ewn6WNyCX5VGUc2yMVtw47xCQ9ydX2OHT6yuSRTcRxs6GJi10Ie/CPD7TfmBHz8G9QGLP8zZmhlcV3NWEfngEmtgRWgWs/CSTjCVbYIGnF9+PNgsC3Z+hVD5cHg=
Received: from DM5PR11CA0016.namprd11.prod.outlook.com (2603:10b6:3:115::26)
 by DM6PR12MB4714.namprd12.prod.outlook.com (2603:10b6:5:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 18:07:48 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::5a) by DM5PR11CA0016.outlook.office365.com
 (2603:10b6:3:115::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/66] drm/amdgpu/gmc10.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:32 -0400
Message-ID: <20210921180725.1985552-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e30be9a7-3e79-45e9-35cc-08d97d2ab82f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4714:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47140BCDCB3EF2F001A72CA5F7A19@DM6PR12MB4714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Syik2UBg1pSKx9/J81VQ6baphc19NhXDCpOd0FyHbX3i1DeEaaAQDZ6rjY9JxhuDCc49oPcvDbP4PzFP9mypZeeECOP6qMCHdDaXPXJsb6w2Ut3vI37ZNRNvfaFbWw1mkt4+fUhj9EO2elhsm/oLOU9ZjgE69XwhrT7WXvhruzZrm8NucrY9anQUiH+qrrWa8W6aaYaoiJD4iGDVCTzTKeNkvp4nJegS1zPWg/RrnzPY3ce3FPSSxQ/dI8vua9YiWag5RbLDqI32chS6wHc7VJsn3VL/7pa+l9EbcrFGSFyrXgy793ZmEMZhV0iVHuRBEt7amrJSRMOrMNm6/ewuDc//9YPHSykTeppnObkYY3e8063HAdXlVXc+M7ZvoVhNb1PI7gEEGSw8/w2UkCStuH5V+k8nfGdijUCCHgvjb27e+w09CgZH+FoRVI1QlW0Ms47lPAwc1SurSk5mmbJjxrWhlmppBOlK2VGSx6zOC+BQfdQ9hioyKPIxbVmh/KCxQABCmBWBSLL2WW/7by18E4zrSaIaPh9pl2tk9nnJphaJkYg4z7I62egLXI0gCBJFunaFRd3B+XaIOG8CbxoILwKUAoJJi7F1H6CmjovCqhN6MJlX78DiaOQEhjv+d+G2C15OfGTjulel56VHmHoQrOd133vt/FtVQr7NQZbh1zh/quypkVJKtTFQYFURo9j7uk1FSEM3jPCt/lUx5NHK8ebhhUYaaaMS12Ahz8LQiAg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8676002)(4326008)(81166007)(26005)(36860700001)(6916009)(5660300002)(83380400001)(86362001)(356005)(82310400003)(2616005)(508600001)(8936002)(70586007)(70206006)(7696005)(1076003)(6666004)(2906002)(36756003)(316002)(426003)(47076005)(336012)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:48.1036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e30be9a7-3e79-45e9-35cc-08d97d2ab82f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4714
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate
IP version specific features.

v2: squash in gmc fixes
v3: rebase

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 91 +++++++++-----------------
 1 file changed, 30 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 41c3a0d70b7c..b488257ff201 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -133,7 +133,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		 * the new fast GRBM interface.
 		 */
 		if ((entry->vmid_src == AMDGPU_GFXHUB_0) &&
-		    (adev->asic_type < CHIP_SIENNA_CICHLID))
+		    (adev->ip_versions[GC_HWIP] < IP_VERSION(10, 3, 0)))
 			RREG32(hub->vm_l2_pro_fault_status);
 
 		status = RREG32(hub->vm_l2_pro_fault_status);
@@ -268,7 +268,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 * to avoid a false ACK due to the new fast GRBM interface.
 	 */
 	if ((vmhub == AMDGPU_GFXHUB_0) &&
-	    (adev->asic_type < CHIP_SIENNA_CICHLID))
+	    (adev->ip_versions[GC_HWIP] < IP_VERSION(10, 3, 0)))
 		RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
 				  hub->eng_distance * eng, hub_ip);
 
@@ -657,8 +657,8 @@ static void gmc_v10_0_set_gmc_funcs(struct amdgpu_device *adev)
 
 static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[UMC_HWIP]) {
+	case IP_VERSION(8, 7, 0):
 		adev->umc.max_ras_err_cnt_per_query = UMC_V8_7_TOTAL_CHANNEL_NUM;
 		adev->umc.channel_inst_num = UMC_V8_7_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V8_7_UMC_INSTANCE_NUM;
@@ -674,9 +674,9 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 
 static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 3, 0):
+	case IP_VERSION(2, 4, 0):
 		adev->mmhub.funcs = &mmhub_v2_3_funcs;
 		break;
 	default:
@@ -687,13 +687,13 @@ static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_device *adev)
 
 static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 3):
 		adev->gfxhub.funcs = &gfxhub_v2_1_funcs;
 		break;
 	default:
@@ -800,23 +800,9 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
-	if (amdgpu_gart_size == -1) {
-		switch (adev->asic_type) {
-		case CHIP_NAVI10:
-		case CHIP_NAVI14:
-		case CHIP_NAVI12:
-		case CHIP_SIENNA_CICHLID:
-		case CHIP_NAVY_FLOUNDER:
-		case CHIP_VANGOGH:
-		case CHIP_DIMGREY_CAVEFISH:
-		case CHIP_BEIGE_GOBY:
-		case CHIP_YELLOW_CARP:
-		case CHIP_CYAN_SKILLFISH:
-		default:
-			adev->gmc.gart_size = 512ULL << 20;
-			break;
-		}
-	} else
+	if (amdgpu_gart_size == -1)
+		adev->gmc.gart_size = 512ULL << 20;
+	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
 	gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
@@ -871,17 +857,17 @@ static int gmc_v10_0_sw_init(void *handle)
 		adev->gmc.vram_vendor = vram_vendor;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-	case CHIP_CYAN_SKILLFISH:
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 3):
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
@@ -989,21 +975,6 @@ static int gmc_v10_0_sw_fini(void *handle)
 
 static void gmc_v10_0_init_golden_registers(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-	case CHIP_CYAN_SKILLFISH:
-		break;
-	default:
-		break;
-	}
 }
 
 /**
@@ -1161,8 +1132,7 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
 	if (r)
 		return r;
 
-	if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-	    adev->asic_type <= CHIP_YELLOW_CARP)
+	if (adev->ip_versions[ATHUB_HWIP] >= IP_VERSION(2, 1, 0))
 		return athub_v2_1_set_clockgating(adev, state);
 	else
 		return athub_v2_0_set_clockgating(adev, state);
@@ -1174,8 +1144,7 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->mmhub.funcs->get_clockgating(adev, flags);
 
-	if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-	    adev->asic_type <= CHIP_YELLOW_CARP)
+	if (adev->ip_versions[ATHUB_HWIP] >= IP_VERSION(2, 1, 0))
 		athub_v2_1_get_clockgating(adev, flags);
 	else
 		athub_v2_0_get_clockgating(adev, flags);
-- 
2.31.1

