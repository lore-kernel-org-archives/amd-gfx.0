Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934FCC6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3472610EB79;
	Thu, 15 Sep 2022 17:01:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245C210E21F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwXEjEuTytQP9K7CkRAnvQ8+Rz6Pjf2O4oSIG16mQTipshJYeg3A0HM9yYUPx4f6aNX+gnTT3ip0+Os92/gjz+dOcNPRLu1fHPptn2x8sq742wgzRRTwvwO8vr54nwsvvA/GyO0KFlTtduBVNaMdyywaowsZwDyI44F9sc8psmY9lSV/nrux+7EfqeQDaKvL8zDV2rYYly3NxKRthEB4TVpxk3TS7s8160eqHONQXoXXpo0Ni8aK1pY1U6lkVjOFAReXpaEfEVw/bIpkHOO/+mNXeRa/ISr/Vt/xNeYsb+CYYSba0eAITCCW1fo1U0YPjeHESfthGDKhFFs7/e9iJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am2CifQhxI7AudMoMLvWi/28ljn/QAP3A+peMFzik90=;
 b=QU8hC5tvPP/EedOTOsYN+N3/UWDhBUpQU1cuQ+ST7oUJ9SVsnPCfi4dKWXvr7oSavDf+Yhqumd80SPY9GAzgDm8sevO2/Wz2le99QrdAuZy8wkkCIjQHXDXivy2B6EOdGb4W94qsoaney86UlDRp2hYYr2xlnrX75cG9EZw2SybQPHkEmg9uhgN1y0u7HwwAQ4/2CtG3KuElBK5z//w+LRpzHZdxW/4Z+p5DZH1EbDFkx0/CvUBnW6RAWUC8GJM8ULF/aXuyvLfNineTRA/HyKo7/FFt1mt869JNhuFpE3kvK7uqYz3mwRnLdU6zdHZZdV1w2mXa8jddUuerIDHYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am2CifQhxI7AudMoMLvWi/28ljn/QAP3A+peMFzik90=;
 b=ERs9DsjYJRyrpG9A/kzSqGjh8zcydLSLY7u+4U6uYrfvsxMzcfZmz3ASaRqMok5GwvfJH0odG7BDIbpMG3j0zCagU1QOGj0lZh46uXtchBa543pA0ebTHEbLLpGNbIMtrdImNBLndhtHnjvnCt/uEqC543jel6Trd6jWHmy0VUU=
Received: from DM6PR03CA0017.namprd03.prod.outlook.com (2603:10b6:5:40::30) by
 CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.15; Thu, 15 Sep 2022 17:00:57 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::4b) by DM6PR03CA0017.outlook.office365.com
 (2603:10b6:5:40::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.9 via Frontend Transport; Thu, 15 Sep 2022 17:00:57 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:00:48 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: support print rlc v2_x ucode hdr
Date: Fri, 16 Sep 2022 01:00:25 +0800
Message-ID: <20220915170027.23010-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170027.23010-1-Hawking.Zhang@amd.com>
References: <20220915170027.23010-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: e65ff2d8-d8e2-4088-4fdd-08da973bdbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01ceS+Gxn9HpB8iSSLbybVJeEANjE1MmNcxSRyeY0lDgo75FuxoDxrH9RaJQvTGwMLQDqnUXlo5L54vTu2sDTLsj98aMqKf2v9shA9r+rZmV0t5I12GYbf2KBWXhf18K/QJtamNRuDpMdakfqpTecQVYoiV4VWe9CIq+ZXItC8IAXUfr5qj0RmaUMzskn4f+Zz3LfcKh3RIhmwymPVTyjMlyMnTrTx0Gyg4rX9o5oSF1bW3XVXdVNzCtUkv84VgSXPnnRFqmO8XrTtzbxBcDXDcuBKkOROpw2ftMiotNlhnnx+r6BLBeLVu5R/0SiAEaqwYMGRh6ShbvqJDuUCwLiBNz/nlPbms57PCDvGWUufqqN+ZYc+0WWL1pUnJpSK4XgQUCKBurSQjCLsxjzHS7YER91BRq9zorY1FCK0fbFEhxDweXKCDFex2NO/T7zEDzlBwa5XfUgkZMeMsZciamNc4ZM+pYLENtocBsCJOb9VesxoTShiH0j7Xvv1bxk75A2AZS+B+RCfqT5UbRW7ps1O4XcCCl0J60yf/HTC1237bRM7ngpDe9QRI4U9ri3XaNr67DvFlRwxV7CGd5RYAzNZTI34ZSbv2odowroEMZAy5NHS+u5fIG8oZ6TGQw8b+pUSTmRjLRfd/X4NTYumTIGj7FkTy2hSYRiHNhH3gwYPZbyCAPThGoZn5qwJUHBKP5y4tAZX7qnDVruUY1Due+PJjgPyc5Eba3vlbKDTOpJ3xWFoBchkrNXzEEB4L6BX258D9lq3I5CyYnJe3CuFXUcueOm4T632MSkbQSO00nBG0O5iBapSVvj3OChYegixMr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(70586007)(70206006)(40460700003)(4326008)(6636002)(316002)(8936002)(110136005)(86362001)(5660300002)(8676002)(41300700001)(426003)(6666004)(40480700001)(2906002)(356005)(82310400005)(81166007)(82740400003)(36756003)(478600001)(30864003)(47076005)(1076003)(186003)(83380400001)(2616005)(26005)(336012)(7696005)(36860700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:00:57.3819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65ff2d8-d8e2-4088-4fdd-08da973bdbf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add rlc v2_x support to print_rlc_hdr helper

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 168 +++++++++++++++-------
 1 file changed, 118 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 939c8614f0e3..dd0bc649a57d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -164,70 +164,138 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 	} else if (version_major == 2) {
 		const struct rlc_firmware_header_v2_0 *rlc_hdr =
 			container_of(hdr, struct rlc_firmware_header_v2_0, header);
+		const struct rlc_firmware_header_v2_1 *rlc_hdr_v2_1 =
+			container_of(rlc_hdr, struct rlc_firmware_header_v2_1, v2_0);
+		const struct rlc_firmware_header_v2_2 *rlc_hdr_v2_2 =
+			container_of(rlc_hdr_v2_1, struct rlc_firmware_header_v2_2, v2_1);
+		const struct rlc_firmware_header_v2_3 *rlc_hdr_v2_3 =
+			container_of(rlc_hdr_v2_2, struct rlc_firmware_header_v2_3, v2_2);
+		const struct rlc_firmware_header_v2_4 *rlc_hdr_v2_4 =
+			container_of(rlc_hdr_v2_3, struct rlc_firmware_header_v2_4, v2_3);
 
-		DRM_DEBUG("ucode_feature_version: %u\n",
-			  le32_to_cpu(rlc_hdr->ucode_feature_version));
-		DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(rlc_hdr->jt_offset));
-		DRM_DEBUG("jt_size: %u\n", le32_to_cpu(rlc_hdr->jt_size));
-		DRM_DEBUG("save_and_restore_offset: %u\n",
-			  le32_to_cpu(rlc_hdr->save_and_restore_offset));
-		DRM_DEBUG("clear_state_descriptor_offset: %u\n",
-			  le32_to_cpu(rlc_hdr->clear_state_descriptor_offset));
-		DRM_DEBUG("avail_scratch_ram_locations: %u\n",
-			  le32_to_cpu(rlc_hdr->avail_scratch_ram_locations));
-		DRM_DEBUG("reg_restore_list_size: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_restore_list_size));
-		DRM_DEBUG("reg_list_format_start: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_start));
-		DRM_DEBUG("reg_list_format_separate_start: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_separate_start));
-		DRM_DEBUG("starting_offsets_start: %u\n",
-			  le32_to_cpu(rlc_hdr->starting_offsets_start));
-		DRM_DEBUG("reg_list_format_size_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_size_bytes));
-		DRM_DEBUG("reg_list_format_array_offset_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
-		DRM_DEBUG("reg_list_size_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_size_bytes));
-		DRM_DEBUG("reg_list_array_offset_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
-		DRM_DEBUG("reg_list_format_separate_size_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_separate_size_bytes));
-		DRM_DEBUG("reg_list_format_separate_array_offset_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_format_separate_array_offset_bytes));
-		DRM_DEBUG("reg_list_separate_size_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_separate_size_bytes));
-		DRM_DEBUG("reg_list_separate_array_offset_bytes: %u\n",
-			  le32_to_cpu(rlc_hdr->reg_list_separate_array_offset_bytes));
-		if (version_minor == 1) {
-			const struct rlc_firmware_header_v2_1 *v2_1 =
-				container_of(rlc_hdr, struct rlc_firmware_header_v2_1, v2_0);
+		switch (version_minor) {
+		case 0:
+			/* rlc_hdr v2_0 */
+			DRM_DEBUG("ucode_feature_version: %u\n",
+				  le32_to_cpu(rlc_hdr->ucode_feature_version));
+			DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(rlc_hdr->jt_offset));
+			DRM_DEBUG("jt_size: %u\n", le32_to_cpu(rlc_hdr->jt_size));
+			DRM_DEBUG("save_and_restore_offset: %u\n",
+				  le32_to_cpu(rlc_hdr->save_and_restore_offset));
+			DRM_DEBUG("clear_state_descriptor_offset: %u\n",
+				  le32_to_cpu(rlc_hdr->clear_state_descriptor_offset));
+			DRM_DEBUG("avail_scratch_ram_locations: %u\n",
+				  le32_to_cpu(rlc_hdr->avail_scratch_ram_locations));
+			DRM_DEBUG("reg_restore_list_size: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_restore_list_size));
+			DRM_DEBUG("reg_list_format_start: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_format_start));
+			DRM_DEBUG("reg_list_format_separate_start: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_format_separate_start));
+			DRM_DEBUG("starting_offsets_start: %u\n",
+				  le32_to_cpu(rlc_hdr->starting_offsets_start));
+			DRM_DEBUG("reg_list_format_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_format_size_bytes));
+			DRM_DEBUG("reg_list_format_array_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_format_array_offset_bytes));
+			DRM_DEBUG("reg_list_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_size_bytes));
+			DRM_DEBUG("reg_list_array_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_array_offset_bytes));
+			DRM_DEBUG("reg_list_format_separate_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_format_separate_size_bytes));
+			DRM_DEBUG("reg_list_format_separate_array_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_format_separate_array_offset_bytes));
+			DRM_DEBUG("reg_list_separate_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_separate_size_bytes));
+			DRM_DEBUG("reg_list_separate_array_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr->reg_list_separate_array_offset_bytes));
+			break;
+		case 1:
+			/* rlc_hdr v2_1 */
 			DRM_DEBUG("reg_list_format_direct_reg_list_length: %u\n",
-				  le32_to_cpu(v2_1->reg_list_format_direct_reg_list_length));
+				  le32_to_cpu(rlc_hdr_v2_1->reg_list_format_direct_reg_list_length));
 			DRM_DEBUG("save_restore_list_cntl_ucode_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_cntl_ucode_ver));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_ucode_ver));
 			DRM_DEBUG("save_restore_list_cntl_feature_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_cntl_feature_ver));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_feature_ver));
 			DRM_DEBUG("save_restore_list_cntl_size_bytes %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_cntl_size_bytes));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_size_bytes));
 			DRM_DEBUG("save_restore_list_cntl_offset_bytes: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_cntl_offset_bytes));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_cntl_offset_bytes));
 			DRM_DEBUG("save_restore_list_gpm_ucode_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_gpm_ucode_ver));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_ucode_ver));
 			DRM_DEBUG("save_restore_list_gpm_feature_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_gpm_feature_ver));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_feature_ver));
 			DRM_DEBUG("save_restore_list_gpm_size_bytes %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_gpm_size_bytes));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_size_bytes));
 			DRM_DEBUG("save_restore_list_gpm_offset_bytes: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_gpm_offset_bytes));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_gpm_offset_bytes));
 			DRM_DEBUG("save_restore_list_srm_ucode_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_srm_ucode_ver));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_ucode_ver));
 			DRM_DEBUG("save_restore_list_srm_feature_ver: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_srm_feature_ver));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_feature_ver));
 			DRM_DEBUG("save_restore_list_srm_size_bytes %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_srm_size_bytes));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_size_bytes));
 			DRM_DEBUG("save_restore_list_srm_offset_bytes: %u\n",
-				  le32_to_cpu(v2_1->save_restore_list_srm_offset_bytes));
+				  le32_to_cpu(rlc_hdr_v2_1->save_restore_list_srm_offset_bytes));
+			break;
+		case 2:
+			/* rlc_hdr v2_2 */
+			DRM_DEBUG("rlc_iram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_2->rlc_iram_ucode_size_bytes));
+			DRM_DEBUG("rlc_iram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_2->rlc_iram_ucode_offset_bytes));
+			DRM_DEBUG("rlc_dram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_2->rlc_dram_ucode_size_bytes));
+			DRM_DEBUG("rlc_dram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_2->rlc_dram_ucode_offset_bytes));
+			break;
+		case 3:
+			/* rlc_hdr v2_3 */
+			DRM_DEBUG("rlcp_ucode_version: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_version));
+			DRM_DEBUG("rlcp_ucode_feature_version: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_feature_version));
+			DRM_DEBUG("rlcp_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_size_bytes));
+			DRM_DEBUG("rlcp_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_3->rlcp_ucode_offset_bytes));
+			DRM_DEBUG("rlcv_ucode_version: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_version));
+			DRM_DEBUG("rlcv_ucode_feature_version: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_feature_version));
+			DRM_DEBUG("rlcv_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_size_bytes));
+			DRM_DEBUG("rlcv_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_3->rlcv_ucode_offset_bytes));
+			break;
+		case 4:
+			/* rlc_hdr v2_4 */
+			DRM_DEBUG("global_tap_delays_ucode_size_bytes :%u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->global_tap_delays_ucode_size_bytes));
+			DRM_DEBUG("global_tap_delays_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->global_tap_delays_ucode_offset_bytes));
+			DRM_DEBUG("se0_tap_delays_ucode_size_bytes :%u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->se0_tap_delays_ucode_size_bytes));
+			DRM_DEBUG("se0_tap_delays_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->se0_tap_delays_ucode_offset_bytes));
+			DRM_DEBUG("se1_tap_delays_ucode_size_bytes :%u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->se1_tap_delays_ucode_size_bytes));
+			DRM_DEBUG("se1_tap_delays_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->se1_tap_delays_ucode_offset_bytes));
+			DRM_DEBUG("se2_tap_delays_ucode_size_bytes :%u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->se2_tap_delays_ucode_size_bytes));
+			DRM_DEBUG("se2_tap_delays_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->se2_tap_delays_ucode_offset_bytes));
+			DRM_DEBUG("se3_tap_delays_ucode_size_bytes :%u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->se3_tap_delays_ucode_size_bytes));
+			DRM_DEBUG("se3_tap_delays_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_4->se3_tap_delays_ucode_offset_bytes));
+			break;
+		default:
+			DRM_ERROR("Unknown RLC v2 ucode: v2.%u\n", version_minor);
+			break;
 		}
 	} else {
 		DRM_ERROR("Unknown RLC ucode version: %u.%u\n", version_major, version_minor);
-- 
2.17.1

