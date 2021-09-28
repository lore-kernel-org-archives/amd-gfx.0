Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D2BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A886101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4A886101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 775666E8BC;
	Tue, 28 Sep 2021 16:43:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A885C6E8BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc266yPL9Pt8H2BLVm0M1PAnsI+B8xGDtPa514EaChBneIsdfozflZJoeq+8JnRvuMvgfIe49t3BMI2xiiIyvYhbkSBDkt4n05ZfPixjUmgTG12IDEXxnrVN77yg8nmgwXLHZwc6REFdsO82s8B+C+JPtojXWmBjd3ujO2Le6SzJaMHPOa7Kwls18whO6gwVniUcHQhLyYJ8tQT3kHJwVua7+xlbgng4qOIXvHvVDiSRrOn4a6LDe4UWhmK5Iu2EvnaWhAWkcwL+QUEcwGFQMHvuTxOMlEnjADnzx1wa17kR74MZDf2soMGXGqeNHj/pIbO9HKfm440buMT9KQa+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9SAFQNIar4xRAEOesKDN4yQU1rf+FgCRdexkTIngc+g=;
 b=nbtLE/+9Xotmxc6SkgIh6nb5M+KWRcvvjSOy88iKryMPaDGBizgoSs0nTJShpr2m9hxCM8hVOUGxqFoL8Bk3NDnLuP0Rj4676aekmxmhIApLpuwsPmd8piH+LnFlO8XviPKfweQf2hHgGLQ0KAabNbaThiHV8e2cw6P1alM6pyzyAGzO7hm2v58jyNHLDilUoqDx/Up9ZaDGfRGwZSff6+IXIk/EHKQnCoD7CeiPMVpsFQ0pP/i9P9CuetQWwNWIVJSeMDHnD05lyWgDw0pj0l9eP3ZOVWTKbW7UVaqcMDs5EiROuGxtY747s09M2qJvzzaChDXxMvcVME++Y1qfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SAFQNIar4xRAEOesKDN4yQU1rf+FgCRdexkTIngc+g=;
 b=k9wXz9w2yOnjyuRH3YkhnQBb45IUILGX3vT0UM3z5W2lAoun+5B9+Mk+gtr3ALWhGPfy8PrdqTE5jpiYNcECuo1irlvrukgMHi9yOUojX4WkE8Qr0C/XQy5B9E9VQ+z48DJcH3srG2XECQqse5ZtYcR8kTEAYkD4RSv5q1++50k=
Received: from DM5PR21CA0039.namprd21.prod.outlook.com (2603:10b6:3:ed::25) by
 BN6PR12MB1315.namprd12.prod.outlook.com (2603:10b6:404:1f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Tue, 28 Sep 2021 16:43:49 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::95) by DM5PR21CA0039.outlook.office365.com
 (2603:10b6:3:ed::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.2 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 13/64] drm/amdgpu/gmc10.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:46 -0400
Message-ID: <20210928164237.833132-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6fd18b4-2953-4b48-b88f-08d9829f2598
X-MS-TrafficTypeDiagnostic: BN6PR12MB1315:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1315279CEDEE542CB83FBFFFF7A89@BN6PR12MB1315.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EHEq3xGZtbbJcMz39ZU2cYS9UPBqWaTGj8IzvMEqEhpMTT3OJMTr1NaRm1ZXe7FHo9vtz2d8L8TD6O/ohNCmq19H0JMKH+eWl0MmmGLSlBhYt04orSIBHbkV8fyAVmNf5C4YTvbzPuK+KOgUhMNVd6xHgVDYnHIk6SQguv5m4XkIdKpzA1/NRwYtngmg9545zQkwZaCqEuK2SSR0y6QvdAkibFX0KKo83T7UrjVX8DdFxfr9IUJzT+5AjaXdWLf8AtvaLiC2pKqLXephN4QhsKi0f/ZlYYbgGORAhhIr6BWKrXaFDEkBr2D72/2l17Jb5O9loL8L7dYPpoKRwZAGO6L5jip0IPGyWe2rqL2WtNW51Aufg4qlrYjHzq1EgkhD3zT1aX3CQipu+UToI9PiNw1eFDAJZ7EprWXTkKP+TALR3eLla/puy4kLISdhwHlAnol07Hup+KQEijm+xdHvzyCXSHCNd34mqWWE0Di76iZS640AXomyGflcy1mYYv7BKb7DHUv4BHRrI1wSKjR42W+fW9gIrpHI6vGJ+gT5G33RN4eoqRHgk4lFr7fFas+ssJGArPC2M308+xHEmJup5gPPCqu1borOYKtdjo8WvO+7PH+awgHDpINuCCGioYu6bNvJ05AkdOcJIVyOq2A8lTNOE51GCjmj5HyyFBfR+aq/YAcj8Hp4u0HXvnWmdkD739dnERUvVOFukZk8vuyb42JzYQ2Bs9QdU2zK0gpBbY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(1076003)(5660300002)(36756003)(70586007)(426003)(7696005)(16526019)(186003)(8936002)(8676002)(47076005)(86362001)(26005)(70206006)(356005)(2906002)(4326008)(54906003)(83380400001)(36860700001)(316002)(2616005)(6916009)(508600001)(82310400003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:49.0703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fd18b4-2953-4b48-b88f-08d9829f2598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1315
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

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 91 +++++++++-----------------
 1 file changed, 30 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e47104a1f559..04e0fb2ef11f 100644
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
@@ -1162,8 +1133,7 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
 	if (r)
 		return r;
 
-	if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-	    adev->asic_type <= CHIP_YELLOW_CARP)
+	if (adev->ip_versions[ATHUB_HWIP] >= IP_VERSION(2, 1, 0))
 		return athub_v2_1_set_clockgating(adev, state);
 	else
 		return athub_v2_0_set_clockgating(adev, state);
@@ -1175,8 +1145,7 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->mmhub.funcs->get_clockgating(adev, flags);
 
-	if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-	    adev->asic_type <= CHIP_YELLOW_CARP)
+	if (adev->ip_versions[ATHUB_HWIP] >= IP_VERSION(2, 1, 0))
 		athub_v2_1_get_clockgating(adev, flags);
 	else
 		athub_v2_0_get_clockgating(adev, flags);
-- 
2.31.1

