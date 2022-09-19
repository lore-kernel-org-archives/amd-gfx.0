Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A7EC54EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 13:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDECB10E084;
	Mon, 19 Sep 2022 13:42:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D2410E084
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 13:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA4fUv5RNIv1M+HisugmzN4K1679zTAUzEvxg6oVYgLT5QNi2CJI5F/3q8dfO/EIV8hKV9Gu6QSf60dT5yZ9aIKmx+4jI89sTlz9KO8SDDMleyCKB0EMtIBYS/cVkCRxRPWAjrB+u2ndzdH67/2sIwsnIQDqrQQcvdDAOM7PUn50nSTA9CLCkTR5so0SEAhC/pFU5xvmJvFL2VlbdT3+5IeGFbzV0J8/sebUCmvdZVLu2uui4Z2vC+WYKQEhxZSp9uo1TpOLBiAuzDz3ShkNuUfvyVv5nmLekigD794uvFHucjxKwZgODusmzN74QsRtu9Ab3592LdXgXSyWUdop6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQHj9d3vVbnV35nFzT3DVFJEhU06OidFjUO7QoqtNf4=;
 b=ntfzycH0t0JLcXpVvYRa9vZCJMcWqMRc+ZFR6VdfuaoAO8sgb3xkI8LmOZp9Z9HlVhFPpj5atCa0g9i1eVGjS3EW0oCOqPGzJVuiJYnDG1Bw4IIIEjdKsTsQ347P8MTmdwU7qhvqJXG21BAdnGoT5d6WSwwh0g4u6u7QYo7+YhpHydwfCRiAeMV1xEJDtt//T6bsj5fyut7aHCCkCwbfgioVy/C+CSN6jomlodqFlTJxmPmCdcTdgQ/OHuPNpSYFwu6BHceeNYqKkmC2YauSqtSbjafw0Ok+6nq6RQZ1HCfNHN/62R+Ub//O5w6yVEm1+QRIPpu+4zLhNwYotsLq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQHj9d3vVbnV35nFzT3DVFJEhU06OidFjUO7QoqtNf4=;
 b=oQAwMi1lGn7PZAEy8HGVS2XLDEF2cgB6/3OYx5aeCRXqq48MniuyL//QLwY/s1k4vywhl7UssRFPcT7KqvN68NrN7W6c5qrraE8JFV+TN4NavsEtPJshGD7GL9b9l4fk3NpKl93mKYdo72n8A6ER1VVCmNRPGkdcTWdnjQz7GSc=
Received: from BN9PR03CA0842.namprd03.prod.outlook.com (2603:10b6:408:13d::7)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 13:42:09 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::3) by BN9PR03CA0842.outlook.office365.com
 (2603:10b6:408:13d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 13:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 13:42:09 +0000
Received: from david-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 08:42:08 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [v2] drm/amd: Add IMU fw version to fw version queries
Date: Mon, 19 Sep 2022 09:41:52 -0400
Message-ID: <20220919134152.332411-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: ba412b36-81f4-4420-f062-08da9a44bfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExAB78etJX4svpj6MOvUUWtqYiLGeo6xvz8JnhfeeqrSEx40YYbTGx1fu+9pZ8JjAAt5lM+3exvzLQ8fcpv3sXCRcg9kBv9zjFd8g0QHbPw0o1cdtbJnbeFS6jDu1Ciul42fxHXvLfB/wksFBvCumX7m0wZr2GZIdXWOGpMOCF/3hf4CT5JcxtLaVShm39sNPFB3UKNWNPdMaYJEyzur3wWO1Q6+v+30Xdjbw7TgYW+8dVkBLTm7h1JIsZYcGwhpD7QArGVPdiZFcQ7nUgl8KvbJywfT4Pbfa/46GfZBqGfMMWIiiMRCiEfEQKR8RE/Uw8cfdydnIBlogklagyLr60VA4lZ7fGFsOya9YoNwTXJYfdkXASjzQxBp412LUvDMYi4T57zPohaGxZNzdUBW+eXgsb6ywiLyGHSXNyjwKMbt7Ie/3laUDMbetvYP3xsWqb5TenYt7/0Yhy2LHtlxewc5CflOcFlbTX5dnqtVCODAMzEJG2mpZEX4uyy52Cw64Rt9hJL8AkSzzc5evp/5vMWfZ4e4uApUZrIzzWfBzEqfCXsh9CBd6Sn0I3Rus2GuFuO/j9WANYxdNH114eT3viQFCyfkFoLUqs68UJbPIi1oqkZSenoA8Qgw0Yh/e99AfiAIjcRoj1I48NnQ04XWTTdYjQ6LCI/KwGkecvmEHAMIf/B7NJoeZu1bExHy35RoGbvmSYkzm4SkDPYu8oTHLcOtZm+KkDBI672/OtJsBhMmOZkDPVVJWPzpJfgvBGS4jb3C0goutlallSb0ADv4+vOW+vO7YGp38TNnTGZlkdNplK+8QeymLDreHk+TOGyK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(426003)(336012)(82310400005)(186003)(7696005)(16526019)(8676002)(5660300002)(81166007)(70586007)(2906002)(70206006)(82740400003)(316002)(26005)(478600001)(2616005)(41300700001)(36860700001)(40480700001)(356005)(1076003)(86362001)(6666004)(47076005)(40460700003)(54906003)(6916009)(8936002)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 13:42:09.0940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba412b36-81f4-4420-f062-08da9a44bfbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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
Cc: David Francis <David.Francis@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IMU is a new firmware for GFX11.

There are four means by which firmware version can be queried
from the driver: device attributes, vf2pf, debugfs,
and the AMDGPU_INFO_FW_VERSION option in the amdgpu info ioctl.

Add IMU as an option for those four methods.

V2: Added debugfs

CC: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  1 +
 include/uapi/drm/amdgpu_drm.h               |  2 ++
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1369c25448dc..56753c3574b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -328,6 +328,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->ver = adev->psp.cap_fw_version;
 		fw_info->feature = adev->psp.cap_feature_version;
 		break;
+	case AMDGPU_INFO_FW_IMU:
+		fw_info->ver = adev->gfx.imu_fw_version;
+		fw_info->feature = 0;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1488,6 +1492,15 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 			   fw_info.feature, fw_info.ver);
 	}
 
+	/* IMU */
+	query_fw.fw_type = AMDGPU_INFO_FW_IMU;
+	query_fw.index = 0;
+	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
+	if (ret)
+		return ret;
+	seq_printf(m, "IMU feature version: %u, firmware version: 0x%08x\n",
+		   fw_info.feature, fw_info.ver);
+
 	/* PSP SOS */
 	query_fw.fw_type = AMDGPU_INFO_FW_SOS;
 	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 939c8614f0e3..a576a50fad25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -630,6 +630,7 @@ FW_VERSION_ATTR(rlc_srlg_fw_version, 0444, gfx.rlc_srlg_fw_version);
 FW_VERSION_ATTR(rlc_srls_fw_version, 0444, gfx.rlc_srls_fw_version);
 FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);
 FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);
+FW_VERSION_ATTR(imu_fw_version, 0444, gfx.imu_fw_version);
 FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos.fw_version);
 FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_context.bin_desc.fw_version);
 FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras_context.context.bin_desc.fw_version);
@@ -651,7 +652,8 @@ static struct attribute *fw_attrs[] = {
 	&dev_attr_ta_ras_fw_version.attr, &dev_attr_ta_xgmi_fw_version.attr,
 	&dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
 	&dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
-	&dev_attr_dmcu_fw_version.attr, NULL
+	&dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
+	NULL
 };
 
 static const struct attribute_group fw_attr_group = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e4af40b9a8aa..38c46f09d784 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -547,6 +547,7 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_IMU,      adev->gfx.imu_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
 			    adev->psp.asd_context.bin_desc.fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index e78e4c27b62a..6c97148ca0ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -70,6 +70,7 @@ enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID_RLC_SRLS,
 	AMD_SRIOV_UCODE_ID_MEC,
 	AMD_SRIOV_UCODE_ID_MEC2,
+	AMD_SRIOV_UCODE_ID_IMU,
 	AMD_SRIOV_UCODE_ID_SOS,
 	AMD_SRIOV_UCODE_ID_ASD,
 	AMD_SRIOV_UCODE_ID_TA_RAS,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c2c9c674a223..3e00cec47f52 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -755,6 +755,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_FW_TOC		0x15
 	/* Subquery id: Query CAP firmware version */
 	#define AMDGPU_INFO_FW_CAP		0x16
+	/* Subquery id: Query IMU firmware version */
+	#define AMDGPU_INFO_FW_IMU		0x17
 
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
-- 
2.25.1

