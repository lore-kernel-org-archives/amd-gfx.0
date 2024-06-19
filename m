Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E4DC27C79
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 16:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D432810E107;
	Wed, 19 Jun 2024 16:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZ30v+RM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E594A10E107
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 16:31:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm2NNRLny3AI16tCwqmI6X9204mhv/j+XYT7Cw58JgVlREQVqQbcWtNxVxyRbJqsZNikTrqp4AYaPMNaNnl9r0JWuce9K92Zw8NdEnh9DuFrGbAN79j8pCV0v3jrE3cgOxpxdfRUGNH+mV5fY9TxRsWbmJiLkKceik0AlhgoDqS+qHaD1M2/VhaBKKiTOE2/aDlpdjZ73DHenSp3yPkDmIcY35E84GMDoHGkb1n5B9GuYx0Q4tp+5dBAlLRS05UCioUt21fqStbMexseoBSI7TsX5dnUN2PrRS5H5UhsessjhCKN6zfwcOa6fYIP1v7LwpdYX0sS4G5t6dzp9j+xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWjyFlv0xQunMF8b8lMzBLQx7XI8wnshyqdpckcIJ1o=;
 b=f6cm6Lc7kCpuU0FHv/P0Iwi8izs2MaAUOSo5UQpO9Tf2hEKaQoOFgHip5v5Vb/5QrsB5K7dJrZTpH6xZB890DkG6eAkKKdEddfjDdf1dPRHh/Pp3sepVQmx/8mFi2+E00FCxlJey9FeMuoSTan6bQ+wlRj+HhFv9IDxOlVH0jp03e1p880duj7bEx3wUS2X29Wk0fXaGDsMjDSOyw4/ZZtGhySgT+ypIlLBvqNqxqd3rekUwWJxg2RT8mDjZMoE9uB+V9xJPNir4Whww6UPDKbM5WNclgeRkeWFr8SyFoq8XrpaoV9r6awENz+DFYjiqs4KKtbEwATHBbK6NlOzavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWjyFlv0xQunMF8b8lMzBLQx7XI8wnshyqdpckcIJ1o=;
 b=dZ30v+RMA21LRXGJzpiyImoFGyp1r1Tgc4N4plV9hPidRzRQLZ12b0R5ERyelu9KaWGTKuQHaMdSTOutKuvp02nTtUKUKsW5e9HqNzA6pi8YgKHxlpeuUin+Z1nNhla6qLar+FCtMxj/HHvu2OFrGzrtUXoEmAeoaWgbz/aHh78=
Received: from PH1PEPF000132EF.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::37)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 16:31:51 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2a01:111:f403:f90c::) by PH1PEPF000132EF.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Wed, 19 Jun 2024 16:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 19 Jun 2024 16:31:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 11:31:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 11:31:49 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 11:31:48 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to
 read/write under sriov in TLB
Date: Thu, 20 Jun 2024 00:31:47 +0800
Message-ID: <20240619163147.1706778-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afbf716-694f-470e-9243-08dc907d5287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|376011|82310400023|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PBbKrmNqs/MoyQCGB6xP/msKlrr1e6e381C+NWbgOXSGpITShVtTNcO3PNV3?=
 =?us-ascii?Q?+PU8L9lkIfjTMZ2+K/3eeFXZg/U2Gb6w6QXiWmGiw7R9c+mN4gOY6xwyeLea?=
 =?us-ascii?Q?W2ex2igQxWp/WH754taNSAcUUuJHxoigqViNFH04ln8trlc9bU+dm4bxgYL+?=
 =?us-ascii?Q?v8mrIS4dQDzXR/lJm2DoJTlVsJHbGoV3PdkjuEK20UpMAGby60kcPWMOiOPw?=
 =?us-ascii?Q?x5La81eKOprSwQu+KZjBeXpKXG6OpI41hjeYRycYotfYUCBkiHmIt/kyHuBE?=
 =?us-ascii?Q?oAoCu6w49XmEx9KR7LaxYB34On6N97OVwL7703HKU9clls/ieMYHEkWzFaM1?=
 =?us-ascii?Q?eYj2jheQWwiOvyfEQYT33i7kaIrwwql38BSh8RI3ouzrvc7misHvmF3jR0Rv?=
 =?us-ascii?Q?gEE5HCwec+BNmy5F3A1ZkjDe7fSgZ5+qlZr2LDAmEB7cTfltK7z8WZplDGCe?=
 =?us-ascii?Q?BbrnaPsKpJamg0wvffUPINhehbPNo/RN5zy+K380Xd2FTjeD4iK/2lpqu+34?=
 =?us-ascii?Q?3qgV/APywPcV1kdBsgeaH1YIZdTI6t4aGyM0+uogclguOq1Ht2y3oxBKtaZu?=
 =?us-ascii?Q?WO0dwWlgKm80XA86dqBTOLst2g4rpI6tMOvabpDK04z6gRvYsEpc39SuPCjS?=
 =?us-ascii?Q?5qWelXSx9dEwLEAhnCFl5v3/Hgy/zIXiD8Q50pakwjetwIJePztZ1h6c7Jtk?=
 =?us-ascii?Q?ve3eVgOnd9BaJVhNXQXLQOxS3HGmXk9TRIepy2ln+23u72rgcUEpd2pAWaw2?=
 =?us-ascii?Q?b2+/RGRQzRXXdbm7DPsIe2bkZYRsL3omZLuarqYKAYwm02YRKzQlGICnpRpb?=
 =?us-ascii?Q?rFp1856mYGT3MUZqjUn67Ue79MBf6HOYBRPqRbmjMmj+pL7j9SoKFfukoLX1?=
 =?us-ascii?Q?VvkxOcc2kcdNXuFS3MCoSn4rS/pYRw/GYvFh/3F/V9QLpydLjkHk7ax65sHK?=
 =?us-ascii?Q?Pn6e3n3js8CAz7xVrdMf/u/hMa/nBqaAIHcM2k329mqX6f2I3WQFf63xtJve?=
 =?us-ascii?Q?MDF5h7DZ2IO01bbFPKbOKv3OiS+c9V28SbFRMI9xKnjvV/EDXPA1raPOHROD?=
 =?us-ascii?Q?MGRWINt2WuIi2ldrIckrxdaB/noStLaZ04+YL/9c4wEn0eNVejWTLM82/SEZ?=
 =?us-ascii?Q?oOjcKI0bfg4qgQb5HhMjrezfPonogDZ5lOo5dwsEjAHwv/L1L3ReFZJOuSZ7?=
 =?us-ascii?Q?azr2mVI1ZNDu+P2iCQdNqm5Hg0hvykIAiPR3nRgtTsE2EEnY3SOoEx/f2dG3?=
 =?us-ascii?Q?8rP/K8i5L2327fN619MXQdNEhYPiC6d+Y0y672fMGBypVgTaHRtm8tWnj997?=
 =?us-ascii?Q?8kGB7rADbDldZtktQzrJqAmmym3rlh8tXD+lB28EL9DobXNBE5d1eFDQzO0C?=
 =?us-ascii?Q?dr6653XoSzTRHxJNor/EL6RYMOcPoZszZ5Qd/yo0D3QYiqHNVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(82310400023)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 16:31:50.8758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afbf716-694f-470e-9243-08dc907d5287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
RLCG will mask xcd out and always assume it's accessing its own xcd

[TODO]
later will add the normalization in sriovw/rreg after fixing bugs

v2
rename the normalized macro, add ip block type for further use

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  5 ++++-
 6 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 083f353cff6e..eb2e7312bf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -636,6 +636,8 @@ struct amdgpu_asic_funcs {
 	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
 				 enum amdgpu_reg_state reg_state, void *buf,
 				 size_t max_size);
+	/* normalize offset to keep in lower 16-bit */
+	u32 (*normalize_reg_offset)(u32 hwip, u32 offset);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 2c9a0aa41e2d..9b4bea2ca7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -1085,3 +1085,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 
 	return size;
 }
+
+u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset)
+{
+	u32 normalized_offset;
+
+	switch (hwip) {
+	case GC_HWIP:
+		normalized_offset = offset & 0xffff;
+		break;
+	default:
+		normalized_offset = offset;
+		break;
+	}
+
+	return normalized_offset;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 88b4644f8e96..1d24e19f304d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* Select lower 16 bits to write in local xcc
+		 * for MMHUB it uses xcc0, NO cross AID reg offset
+		 */
+		if (AMDGPU_IS_GFXHUB(vmhub)) {
+			req = NORMALIZE_XCC_REG_OFFSET(GC, req);
+			ack = NORMALIZE_XCC_REG_OFFSET(GC, ack);
+		}
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8d16dacdc172..e6e61fc77080 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
+	.normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 282584a48be0..f1e974604e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
+u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..ddf0aad51821 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,7 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
 	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
 
-#endif
+#define NORMALIZE_XCC_REG_OFFSET(ip, offset) \
+	((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
+	adev->asic_funcs->normalize_reg_offset(ip##_HWIP, offset) : offset)
+#endif
\ No newline at end of file
-- 
2.34.1

