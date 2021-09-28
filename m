Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDAFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695EF61262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 695EF61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F416E8C2;
	Tue, 28 Sep 2021 16:44:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 835F36E8C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4LOAdAR930MA7pqIc0t+aGptc80MsEHkS4zPk5Y0nuTXwq5OSK6mQ79qZl5dYaj5LSukoHfkyswgXaxfTkdr9yScrUMDRCGCqElTPAomlGkAFwLzdA8FxEsop22qiK3Xdv+8C1i8C5ut5wDz4Z1ukCfD7FuHMjOi/h9laewT01I65YhzFSzR4EXWkxeUTf0ek09dp7tIExvTQvHMw/548Nu35kJYtdkFrlMBVIp8v1XkcyKRrvvUnMR13bJz5mqEsKB7LaVSAhKAEOFBLA+XNBIF5taRoWsphRMZ1zkn4VHkXdW2ueMFlnQcmL64CY6qOV5gorFQ5019SzN+J8dPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qnIG2EA9Mv4Zic0aAy86fhd0/3OfPuWkXHXC5f7Z7aQ=;
 b=MT/5K+0h0T4PSt/ZVe8EcevfwuKrr988s58Q153alvifivwMWjM0zX3N5oqPT4Qt29ny734Sem4fB8OYGFnHZd+4R0bE9zo1V6GfXpgSGRC/qx9MA96TuxmHLsobJqrWmWGsW12KVcN69X8wg9cLndLnJ8GvvJnJCKbByCoQ4okd0vb4l/4jESUV0a0SwvGB/7X22kKmmcf/Bpc8tE+Xoo1u6HIkambYXEDsvrPQ0rhaOx+TnW2ReHNVAOfO4f8gNlrTULZpXctFtK/tJQRVFF4zuB9RsxbzZqCmHDHFnbq3L/TFEAppJ64EP7jZfqxNulNV7DgrvJXuGTwLJXajVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnIG2EA9Mv4Zic0aAy86fhd0/3OfPuWkXHXC5f7Z7aQ=;
 b=ucW3LOjrv5d3KSAHzJZIjQ7ehpUAjqU/WlbENy8KULcaNreaTp7DDMIn2Gl0ZaPgYewd9efvt9cV8Knxv8au2kScHe86Etu0FRE+kHodBzyIL0+DTat6tqanC9FKgZDZ3ZfXBERL03EqMUdoHGrNKlZ0rwYfr3Zl5AoIbiT6o4M=
Received: from DM5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:3:93::26) by
 BN6PR12MB1684.namprd12.prod.outlook.com (2603:10b6:405:6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 16:44:04 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::8) by DM5PR20CA0016.outlook.office365.com
 (2603:10b6:3:93::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 17/64] drm/amdgpu/mmhub2.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:50 -0400
Message-ID: <20210928164237.833132-18-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c65bb50-7730-479f-594a-08d9829f2e6c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1684:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1684E37C730D7D79901F3E65F7A89@BN6PR12MB1684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFAnME05yaYIANoyM0fWnkHromPPyD91x3OzyMFd53ZZ43iHmO+OOd4Oqny5ia9+pq2LT0a4s5h80wKh/HP2lpKuw0dZnaxxJJwRXi9/r5CjUxWkgLzakY/a636omu9QH1gGgU6pf7W1xD3JVodgH0bSD2RP41HrSkT9+jc1uYkVStVMJ8oOCWT5dxqCaZFNXJH2RHrGPZKh4xeM+x/jhAtGoaVjqfrJllGe4erMa7izlz6LYjGysB/2VgniAPwWXzIAf6YP+/nS1Q0HbionmyZ46xxRJ/wBJ9qVEN8QTN+G3eSB8e42XlSE/yYtGtmXA+0AmDPGVcBE673a0QkCaySvPqcC7NOp1hWUO9N5jE9CdIiDyuwPVGNq9dKtvlJ7+Nq6znS55KF/3rUZpwMFUlpKwyki3VeUpucrzkV8TniKzRLugGThN4++8d6SFwAc4QFz+w1bYKQZdiUodrHtLGQHtGGVWq4ExzFGPU1aRQfJXCK45JJLRe9ft7gvkuv89a2lQaOAPHQDuShhU3JSWU0gB34t8B09LkiAKSOIfaYQkxno2E0RzuChCztKusozNpFoVP5VbsMC+OrTg4FDOpsgK2nux+2h8Vg2yNEVqdX3cCiqc1c6X7vb5PBP3UpirKUCVPyBtc0XFLyZuullaUoR94WrCQFPpyyvN/71uXs0LLhE2iHNN6y6kjXKY0p+PJ7ezL6afawB2nrRRC+jJl+aenIcIHgtS45qZl/iKOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(36756003)(81166007)(2906002)(5660300002)(66574015)(7696005)(6916009)(356005)(82310400003)(508600001)(26005)(70206006)(8936002)(8676002)(2616005)(336012)(426003)(1076003)(6666004)(4326008)(16526019)(83380400001)(86362001)(36860700001)(54906003)(316002)(186003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:03.8700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c65bb50-7730-479f-594a-08d9829f2e6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1684
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

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 73 +++++++++++--------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 7ded6b2f058e..e0cb919b4814 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -153,18 +153,16 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI12:
-	case CHIP_NAVI14:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
 		mmhub_cid = mmhub_client_ids_navi1x[cid][rw];
 		break;
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
 		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(2, 1, 2):
 		mmhub_cid = mmhub_client_ids_beige_goby[cid][rw];
 		break;
 	default:
@@ -571,11 +569,10 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
 		return;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
@@ -606,11 +603,10 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 			  DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		if (def != data)
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 		if (def1 != data1)
@@ -633,11 +629,10 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 	if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
 		return;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		break;
 	default:
@@ -651,11 +646,10 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
 
 	if (def != data) {
-		switch (adev->asic_type) {
-		case CHIP_SIENNA_CICHLID:
-		case CHIP_NAVY_FLOUNDER:
-		case CHIP_DIMGREY_CAVEFISH:
-		case CHIP_BEIGE_GOBY:
+		switch (adev->ip_versions[MMHUB_HWIP]) {
+		case IP_VERSION(2, 1, 0):
+		case IP_VERSION(2, 1, 1):
+		case IP_VERSION(2, 1, 2):
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 			break;
 		default:
@@ -671,14 +665,12 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		mmhub_v2_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		mmhub_v2_0_update_medium_grain_light_sleep(adev,
@@ -698,11 +690,10 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
-- 
2.31.1

