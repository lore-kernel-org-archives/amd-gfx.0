Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA549E82CC0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 18:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA1710E58E;
	Wed, 27 Sep 2023 18:43:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558FF10E080
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 18:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F950wSi/JEwGI+eFcspFlSFtE+s4F4+MfZK9tbmPH98Ln1Xyqg5LEyOogGXN62MTGxMkPWFWm4LZ9H/F2DKm2IAHYyoCLvx5AKAdR5t/DUp5JcsNChvIt4WDcn7+CV7cWzAQPma+Q9M+lNFEFqX7NL3nkn4+f2pa1JM0aZHhKZjmu5ubIW0Ln6WsNTEOnuiQ97f1kxQFB8p5b83wuR5l7hRbwCEI58eBfWTG+7VerS1vQGPHu0GLkLf04z3YVxpNKLAbNEpcnY47xkz1nlI6Cobs+73QeOdlRyQQkPYkfzjK9XL9n68oZcgCC72729mZtIAhtcL+NIv4EluHuR30rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lmrKu95TGIxM8EhPuav9cMMwb6dXwAOe9hTHeF7kws=;
 b=dy9XeqnidWPLy0W9P4DXdeqALSkENst8vl3yGIQzThgiojesqNlubSU4D5ZQJJZipjJpA7rccnVF72bf7XQGpvIKWValF9bfkrn38hsv+3EOuTC+Ptsk/Hhf3vsrtKvse/UskTGkLyh6mGtnOOq81u/RzpwEP0gH5jJFu429ucYzMyXuoapMLg7Ks/8SPxhNlb/2jCgiaPA9z8iHB+pNQt8ac9Wq1e3p7N4H1fPuSI2k8Csm9O8AxrDf1oMPxxEMiVmmtS4xwRUh1xWG6s0jNFCP874jfkvxwVzCbGa4CIYGtAgExF/zuanjeuY/jogrY3Llij3vPpd0gdf3u55/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lmrKu95TGIxM8EhPuav9cMMwb6dXwAOe9hTHeF7kws=;
 b=Jzjbfzz7RJ91YC0JvczY0Cd7kwy014PXaAV+9f4CqNNpvk2VlpzRKH93IfAFXbl49wqrUWr0aUjLrhfsPQBqNyJUbV0vZnEQYyj+nYwD/dsXVXWnCn0xZI4vjLaDEErh/Zdn9qvuk8iX6F8uTEr6419kifKTNaY+5vfOhtiKWLE=
Received: from CY5P221CA0141.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::14)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:43:14 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::26) by CY5P221CA0141.outlook.office365.com
 (2603:10b6:930:6a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 18:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.21 via Frontend Transport; Wed, 27 Sep 2023 18:43:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:43:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd: Move `enum drm_amdgpu_ta_fw_type` to uapi
Date: Tue, 26 Sep 2023 08:21:42 -0500
Message-ID: <20230926132143.295344-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: ee137eaa-087c-4162-b67f-08dbbf899b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23vjfbUDi+tGVeoY/f8oKtT46l3+XJKlZHAVU50pwFx5ppEb9NCi2UUdI4HHiZTQu1AtbSWRuxrfy7JB6d6wLU5uyBOMa1eDiFZ7RUP6KbMWANcys3NRBBg6QwU4lBCRufdf2Y1sLoyYLzbV3ny1QOEGrAaQsqXfYQGuBPklECI3i/EHYk4hBm3UqtUOt3Rsf+1N/s9cUYyhWxmybtUmHpUG6kjKaBH3bUxc7QS5GJ4/LpehcuY72ZXzMwSFRBxPskBRwn1y4T1HHFnolfkbcduc1+FIPAR82HjqEh9jsV+SiA3qoH2I/AVyFCh9c2EYmB3V0QbJNXrP4zgZhvBDnt7cIgiw9p3YK/9Q39rB+vH7cTiNEDLiiTgB7cOaEUr6KmtLOzSZLaUwhFPllq02B5vw/9579QIJGe9f6Ci7TDzGOM+VAPrlH82iG05d1Aflh9w+Z3yS3ivP5M/jMfX3chIw0Vle50KtaulMtVGhvKep5jCJjYykmay/WU5BD+qVE9iIKQcAha/EvI3t4eEVizTIVO6YXR1NzKo9RP3L/r+FPfgRLvCgLJ7y0+7LiWj2f5ys1J990LVZUnsrQ8dn1cpWCYnXpPmZMWmpUKU3LRQqKDYPf0rwpfEz5EQUVPGdNbf+gx6ACPubleLj/4EkzcRWu33fX220jZ65ZMQhTxQQkfNPNBH16yrPtYnElr1y3CU5OULebZs9y2LREvjfHZQsZc3346JT9041S8IFPfKrtFbZQ2gTGSGRU9FqWZK3uagJ8zudZKbHGtLtywncPqwCAyUBL0TDciPwey4GIuc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(2906002)(86362001)(36756003)(40480700001)(5660300002)(316002)(26005)(44832011)(16526019)(70206006)(70586007)(2616005)(7696005)(336012)(426003)(1076003)(6916009)(41300700001)(478600001)(8676002)(4326008)(8936002)(47076005)(356005)(40460700003)(82740400003)(36860700001)(81166007)(6666004)(83380400001)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:43:13.8561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee137eaa-087c-4162-b67f-08dbbf899b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enum values used by the ioctl `AMDGPU_INFO_FW_VERSION`/`AMDGPU_INFO_FW_TA`
are not exported so clients need to keep their own copy of the definitions
while looking up firmware versions for the TA.

Move this to uapi instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
--
v1->v2:
 * Rename while moving (Alex)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   | 18 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 12 ------------
 include/uapi/drm/amdgpu_drm.h             | 12 ++++++++++++
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 081bd28e2443..6eff7eb18322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -311,32 +311,32 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		break;
 	case AMDGPU_INFO_FW_TA:
 		switch (query_fw->index) {
-		case TA_FW_TYPE_PSP_XGMI:
+		case AMDGPU_TA_FW_TYPE_PSP_XGMI:
 			fw_info->ver = adev->psp.xgmi_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.xgmi_context.context
 						   .bin_desc.feature_version;
 			break;
-		case TA_FW_TYPE_PSP_RAS:
+		case AMDGPU_TA_FW_TYPE_PSP_RAS:
 			fw_info->ver = adev->psp.ras_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.ras_context.context
 						   .bin_desc.feature_version;
 			break;
-		case TA_FW_TYPE_PSP_HDCP:
+		case AMDGPU_TA_FW_TYPE_PSP_HDCP:
 			fw_info->ver = adev->psp.hdcp_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.hdcp_context.context
 						   .bin_desc.feature_version;
 			break;
-		case TA_FW_TYPE_PSP_DTM:
+		case AMDGPU_TA_FW_TYPE_PSP_DTM:
 			fw_info->ver = adev->psp.dtm_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.dtm_context.context
 						   .bin_desc.feature_version;
 			break;
-		case TA_FW_TYPE_PSP_RAP:
+		case AMDGPU_TA_FW_TYPE_PSP_RAP:
 			fw_info->ver = adev->psp.rap_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.rap_context.context
 						   .bin_desc.feature_version;
 			break;
-		case TA_FW_TYPE_PSP_SECUREDISPLAY:
+		case AMDGPU_TA_FW_TYPE_PSP_SECUREDISPLAY:
 			fw_info->ver = adev->psp.securedisplay_context.context.bin_desc.fw_version;
 			fw_info->feature =
 				adev->psp.securedisplay_context.context.bin_desc
@@ -1536,8 +1536,8 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	uint8_t smu_program, smu_major, smu_minor, smu_debug;
 	int ret, i;
 
-	static const char *ta_fw_name[TA_FW_TYPE_MAX_INDEX] = {
-#define TA_FW_NAME(type)[TA_FW_TYPE_PSP_##type] = #type
+	static const char *ta_fw_name[AMDGPU_TA_FW_TYPE_MAX_INDEX] = {
+#define TA_FW_NAME(type)[AMDGPU_TA_FW_TYPE_PSP_##type] = #type
 		TA_FW_NAME(XGMI),
 		TA_FW_NAME(RAS),
 		TA_FW_NAME(HDCP),
@@ -1689,7 +1689,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 		   fw_info.feature, fw_info.ver);
 
 	query_fw.fw_type = AMDGPU_INFO_FW_TA;
-	for (i = TA_FW_TYPE_PSP_XGMI; i < TA_FW_TYPE_MAX_INDEX; i++) {
+	for (i = AMDGPU_TA_FW_TYPE_PSP_XGMI; i < AMDGPU_TA_FW_TYPE_MAX_INDEX; i++) {
 		query_fw.index = i;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 72ee66db182c..bf9eb53cd4fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3291,38 +3291,38 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 			    le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 
 	switch (desc->fw_type) {
-	case TA_FW_TYPE_PSP_ASD:
+	case AMDGPU_TA_FW_TYPE_PSP_ASD:
 		psp->asd_context.bin_desc.fw_version        = le32_to_cpu(desc->fw_version);
 		psp->asd_context.bin_desc.feature_version   = le32_to_cpu(desc->fw_version);
 		psp->asd_context.bin_desc.size_bytes        = le32_to_cpu(desc->size_bytes);
 		psp->asd_context.bin_desc.start_addr        = ucode_start_addr;
 		break;
-	case TA_FW_TYPE_PSP_XGMI:
+	case AMDGPU_TA_FW_TYPE_PSP_XGMI:
 		psp->xgmi_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->xgmi_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->xgmi_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
-	case TA_FW_TYPE_PSP_RAS:
+	case AMDGPU_TA_FW_TYPE_PSP_RAS:
 		psp->ras_context.context.bin_desc.fw_version        = le32_to_cpu(desc->fw_version);
 		psp->ras_context.context.bin_desc.size_bytes        = le32_to_cpu(desc->size_bytes);
 		psp->ras_context.context.bin_desc.start_addr        = ucode_start_addr;
 		break;
-	case TA_FW_TYPE_PSP_HDCP:
+	case AMDGPU_TA_FW_TYPE_PSP_HDCP:
 		psp->hdcp_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->hdcp_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->hdcp_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
-	case TA_FW_TYPE_PSP_DTM:
+	case AMDGPU_TA_FW_TYPE_PSP_DTM:
 		psp->dtm_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->dtm_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->dtm_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
-	case TA_FW_TYPE_PSP_RAP:
+	case AMDGPU_TA_FW_TYPE_PSP_RAP:
 		psp->rap_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->rap_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->rap_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
-	case TA_FW_TYPE_PSP_SECUREDISPLAY:
+	case AMDGPU_TA_FW_TYPE_PSP_SECUREDISPLAY:
 		psp->securedisplay_context.context.bin_desc.fw_version =
 			le32_to_cpu(desc->fw_version);
 		psp->securedisplay_context.context.bin_desc.size_bytes =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index ae5fa61d2890..73a84af54d70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -145,18 +145,6 @@ struct ta_firmware_header_v1_0 {
 	struct psp_fw_legacy_bin_desc securedisplay;
 };
 
-enum ta_fw_type {
-	TA_FW_TYPE_UNKOWN,
-	TA_FW_TYPE_PSP_ASD,
-	TA_FW_TYPE_PSP_XGMI,
-	TA_FW_TYPE_PSP_RAS,
-	TA_FW_TYPE_PSP_HDCP,
-	TA_FW_TYPE_PSP_DTM,
-	TA_FW_TYPE_PSP_RAP,
-	TA_FW_TYPE_PSP_SECUREDISPLAY,
-	TA_FW_TYPE_MAX_INDEX,
-};
-
 /* version_major=2, version_minor=0 */
 struct ta_firmware_header_v2_0 {
 	struct common_firmware_header header;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 984fc16577ca..f982b167feeb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -912,6 +912,18 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_MMR_SH_INDEX_SHIFT	8
 #define AMDGPU_INFO_MMR_SH_INDEX_MASK	0xff
 
+enum drm_amdgpu_ta_fw_type {
+	AMDGPU_TA_FW_TYPE_UNKOWN,
+	AMDGPU_TA_FW_TYPE_PSP_ASD,
+	AMDGPU_TA_FW_TYPE_PSP_XGMI,
+	AMDGPU_TA_FW_TYPE_PSP_RAS,
+	AMDGPU_TA_FW_TYPE_PSP_HDCP,
+	AMDGPU_TA_FW_TYPE_PSP_DTM,
+	AMDGPU_TA_FW_TYPE_PSP_RAP,
+	AMDGPU_TA_FW_TYPE_PSP_SECUREDISPLAY,
+	AMDGPU_TA_FW_TYPE_MAX_INDEX,
+};
+
 struct drm_amdgpu_query_fw {
 	/** AMDGPU_INFO_FW_* */
 	__u32 fw_type;
-- 
2.34.1

