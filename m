Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE779C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 02:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E7C61002
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 02:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90E7C61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04F689D3E;
	Mon, 25 Oct 2021 02:31:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B156B89D3E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 02:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC7sYGnWiMwe1auhaV+7RM+5eAT9/4O2FFzY+uQg41YV0hX2w489coK4ESdtodHvkyyQPzXeRp9IApi8FlySgW+bklUy+2lBu2SSxiwK32nsjr9zAdSGmpt7hqOEp2eC7B8iLLKTLgPU61BO62FQP5/HktrwF7Y4yEwAZuG7dmsIpjFn7V8cE6XOxjbX0fagPZ1/MZQwOBA5ECD16qMabK7HcrczurRXQSCf1hnAfvw9+0a8e+c6/r0IARxQ8N0UR9lyE/py3QmwfQ4vc2ZQhA8yZRdGmBRMQrXVQ9tUohzp7HQpLRN24jcQ9PaugZO8LouJ8o1qCU5tfHI7shuPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/WtytMl/1tK+tzBD7XnQgIKadEI64POKEj0vaXrOHQ=;
 b=kcg72mvd/kghqbDzJhzhZqDyI2vnE3kpAyZdFMivNzgV2+ljw9zGtyZFqljun6cXZ4y+6vvvy1TVDWc46vxVPH9ZvZHJxvftoMyB2vvY40On3ysP8FzKmuQaBRjTgqQKdxEp4eA8q0CzS6Ui1JPObyVX62SJlVxmGPehdBB0K79yNHw0OedWfr6EFZPBSZrHL7yoy5BuoX4gf+mnObKTmCHdmRNwlfxMlaiy6X07vDG3S6STv1VjzH2yxDnmMIPl8U9PHG1uIPujT5FovXueGatmS0kOnCQnsuwTb/3p9wHdxY5+b0hB3dE+jw3EtdhwRKwjJvg+CQ3Bz7QX5Osi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/WtytMl/1tK+tzBD7XnQgIKadEI64POKEj0vaXrOHQ=;
 b=1FN4bQiYx0Sp/Xr8JCQ/O+Z/lQsQ3R1VFS67KkFzU6sAQZN6r834WCC9o6dDzQfyN4jUd+JYqQ6Ymq5rq0hjjbFDo9RDNvZb+wFV0rwEIw2xQgmLhh784cXnGj8bjwvwpu1KIAwCVBEACp8+CWyI96yMKNUrHpauF4vfBg19weU=
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by MW2PR12MB2475.namprd12.prod.outlook.com (2603:10b6:907:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 02:31:26 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::b1) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 02:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 02:31:26 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 21:31:24 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: John Clements <john.clements@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Update TA version output in driver
Date: Mon, 25 Oct 2021 10:31:12 +0800
Message-ID: <20211025023112.22059-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc77f9c1-2f61-45be-2511-08d9975f8b47
X-MS-TrafficTypeDiagnostic: MW2PR12MB2475:
X-Microsoft-Antispam-PRVS: <MW2PR12MB247577A3B5DC6858D056347491839@MW2PR12MB2475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfFfbsRw4zo2rV5fYHHFSpnl2WHX85wMZym+AR2KngIVrx46Jub2bjawyKzsREWiZS/ioiON6oFCal+krZTcJsVvTBdLVX4RY/8kXekX4wtobeGcc5EPXy/PC9sHABpTQj6pCRyQNHWoL3vuaF4mMIVVdI4c1q8c8ePGxUWRWrEWy+MA0U3V3Xzgwmr74CtlqslgIV/f6MXlBNrNKqpiZyXnNPWf5oI9NZi8FgUG/gHJVitYjP4K/4wksmUSJs/Q9J2Izi8JImWd2qfX3NW3RGD4MmiEFFdh5Y4n35HCGAhnQmNVCz5XfmhV3lVGgERxCksX3tVLGxTvinsmzOflYLGWAQtb+n5CuOKs0lXpvC2AuxTLJrvs7rxAESv1Nr3tPB95voC+jfmtjmRotO7gaAf3Z6Tch1T7ihWUoWdcOF3S8DWju0SB/WHSj/0O8vNBoCTZh8tGafg9OeTbbwVcmxEG1IcaZbWB1+YbN8P/5zvufx/HQs1Jk33ng4FhOQfUjnmXsJRbt/TFjm06WXBame00v/ZbvbnvJWIHghg7eEsyFOwpCM8ZCqF27TMirhI9Mvy7L1hOHfcQsxo0/gP2sPeHBSdwH+SRAPlRFC8o/NP+OoSTu8FhDUl5U90RYP7jNCcoBSvRfX7e2c6Foi2L6JRFtCMKtVoC0ABfecehYoimByvAb8uhF6IHp4UiLK7lsdWeTdcXJ6bf9spmaMIMKHxEUJbAZNG4kq0D66Y/1eA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(83380400001)(6916009)(70586007)(6666004)(16526019)(81166007)(356005)(1076003)(7696005)(54906003)(82310400003)(8676002)(30864003)(36860700001)(508600001)(2906002)(186003)(336012)(8936002)(44832011)(70206006)(316002)(5660300002)(47076005)(4326008)(2616005)(36756003)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 02:31:26.3558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc77f9c1-2f61-45be-2511-08d9975f8b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2475
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

TA version should only be displayed in firmware version column.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c    |  4 ++--
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2955ea4a62bf4..dfe667ea8b058e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -340,32 +340,32 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 	case AMDGPU_INFO_FW_TA:
 		switch (query_fw->index) {
 		case TA_FW_TYPE_PSP_XGMI:
-			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->ver = adev->psp.xgmi_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.xgmi_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_RAS:
-			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->ver = adev->psp.ras_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.ras_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_HDCP:
-			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->ver = adev->psp.hdcp_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.hdcp_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_DTM:
-			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->ver = adev->psp.dtm_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.dtm_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_RAP:
-			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->ver = adev->psp.rap_context.context.bin_desc.fw_version;
 			fw_info->feature = adev->psp.rap_context.context
 						   .bin_desc.feature_version;
 			break;
 		case TA_FW_TYPE_PSP_SECUREDISPLAY:
-			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->ver = adev->psp.securedisplay_context.context.bin_desc.fw_version;
 			fw_info->feature =
 				adev->psp.securedisplay_context.context.bin_desc
 					.feature_version;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index fd04e83031d642..c641f84649d6bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1115,7 +1115,7 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
 static bool psp_xgmi_peer_link_info_supported(struct psp_context *psp)
 {
 	return psp->adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 2) &&
-		psp->xgmi_context.context.bin_desc.feature_version >= 0x2000000b;
+		psp->xgmi_context.context.bin_desc.fw_version >= 0x2000000b;
 }
 
 /*
@@ -3108,32 +3108,32 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 		psp->asd_context.bin_desc.start_addr        = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_XGMI:
-		psp->xgmi_context.context.bin_desc.feature_version  = le32_to_cpu(desc->fw_version);
+		psp->xgmi_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->xgmi_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->xgmi_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_RAS:
-		psp->ras_context.context.bin_desc.feature_version   = le32_to_cpu(desc->fw_version);
+		psp->ras_context.context.bin_desc.fw_version        = le32_to_cpu(desc->fw_version);
 		psp->ras_context.context.bin_desc.size_bytes        = le32_to_cpu(desc->size_bytes);
 		psp->ras_context.context.bin_desc.start_addr        = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_HDCP:
-		psp->hdcp_context.context.bin_desc.feature_version  = le32_to_cpu(desc->fw_version);
+		psp->hdcp_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->hdcp_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->hdcp_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_DTM:
-		psp->dtm_context.context.bin_desc.feature_version  = le32_to_cpu(desc->fw_version);
+		psp->dtm_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->dtm_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->dtm_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_RAP:
-		psp->rap_context.context.bin_desc.feature_version  = le32_to_cpu(desc->fw_version);
+		psp->rap_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->rap_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->rap_context.context.bin_desc.start_addr       = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_SECUREDISPLAY:
-		psp->securedisplay_context.context.bin_desc.feature_version =
+		psp->securedisplay_context.context.bin_desc.fw_version =
 			le32_to_cpu(desc->fw_version);
 		psp->securedisplay_context.context.bin_desc.size_bytes =
 			le32_to_cpu(desc->size_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 920c4f6ac9146f..ca335050261891 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -527,8 +527,8 @@ FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);
 FW_VERSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);
 FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos.fw_version);
 FW_VERSION_ATTR(asd_fw_version, 0444, psp.asd_context.bin_desc.fw_version);
-FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras_context.context.bin_desc.feature_version);
-FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.xgmi_context.context.bin_desc.feature_version);
+FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras_context.context.bin_desc.fw_version);
+FW_VERSION_ATTR(ta_xgmi_fw_version, 0444, psp.xgmi_context.context.bin_desc.fw_version);
 FW_VERSION_ATTR(smc_fw_version, 0444, pm.fw_version);
 FW_VERSION_ATTR(sdma_fw_version, 0444, sdma.instance[0].fw_version);
 FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 88c4177b708ac8..8899c219defab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -535,9 +535,9 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
 			    adev->psp.asd_context.bin_desc.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_RAS,
-			    adev->psp.ras_context.context.bin_desc.feature_version);
+			    adev->psp.ras_context.context.bin_desc.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_TA_XGMI,
-			    adev->psp.xgmi_context.context.bin_desc.feature_version);
+			    adev->psp.xgmi_context.context.bin_desc.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SMC,      adev->pm.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA,     adev->sdma.instance[0].fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SDMA2,    adev->sdma.instance[1].fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 59644015dfc3ee..ed2293686f0de3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -84,7 +84,7 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 
 		ta_hdr = (const struct ta_firmware_header_v1_0 *)
 				 adev->psp.ta_fw->data;
-		adev->psp.hdcp_context.context.bin_desc.feature_version =
+		adev->psp.hdcp_context.context.bin_desc.fw_version =
 			le32_to_cpu(ta_hdr->hdcp.fw_version);
 		adev->psp.hdcp_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->hdcp.size_bytes);
@@ -92,7 +92,7 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 			(uint8_t *)ta_hdr +
 			le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 
-		adev->psp.dtm_context.context.bin_desc.feature_version =
+		adev->psp.dtm_context.context.bin_desc.fw_version =
 			le32_to_cpu(ta_hdr->dtm.fw_version);
 		adev->psp.dtm_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->dtm.size_bytes);
@@ -100,7 +100,7 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
 			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->dtm.offset_bytes);
 
-		adev->psp.securedisplay_context.context.bin_desc.feature_version =
+		adev->psp.securedisplay_context.context.bin_desc.fw_version =
 			le32_to_cpu(ta_hdr->securedisplay.fw_version);
 		adev->psp.securedisplay_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->securedisplay.size_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 21a325ea49cb30..2176ef85f137e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -151,7 +151,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 				goto out2;
 
 			ta_hdr = (const struct ta_firmware_header_v1_0 *)adev->psp.ta_fw->data;
-			adev->psp.xgmi_context.context.bin_desc.feature_version =
+			adev->psp.xgmi_context.context.bin_desc.fw_version =
 				le32_to_cpu(ta_hdr->xgmi.fw_version);
 			adev->psp.xgmi_context.context.bin_desc.size_bytes =
 				le32_to_cpu(ta_hdr->xgmi.size_bytes);
@@ -159,7 +159,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 				(uint8_t *)ta_hdr +
 				le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
 			adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
-			adev->psp.ras_context.context.bin_desc.feature_version =
+			adev->psp.ras_context.context.bin_desc.fw_version =
 				le32_to_cpu(ta_hdr->ras.fw_version);
 			adev->psp.ras_context.context.bin_desc.size_bytes =
 				le32_to_cpu(ta_hdr->ras.size_bytes);
@@ -192,7 +192,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 				goto out2;
 
 			ta_hdr = (const struct ta_firmware_header_v1_0 *)adev->psp.ta_fw->data;
-			adev->psp.hdcp_context.context.bin_desc.feature_version =
+			adev->psp.hdcp_context.context.bin_desc.fw_version =
 				le32_to_cpu(ta_hdr->hdcp.fw_version);
 			adev->psp.hdcp_context.context.bin_desc.size_bytes =
 				le32_to_cpu(ta_hdr->hdcp.size_bytes);
@@ -203,7 +203,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 
 			adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
 
-			adev->psp.dtm_context.context.bin_desc.feature_version =
+			adev->psp.dtm_context.context.bin_desc.fw_version =
 				le32_to_cpu(ta_hdr->dtm.fw_version);
 			adev->psp.dtm_context.context.bin_desc.size_bytes =
 				le32_to_cpu(ta_hdr->dtm.size_bytes);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 281bc4d7f0a1aa..a2588200ea5809 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -84,7 +84,7 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 
 		ta_hdr = (const struct ta_firmware_header_v1_0 *)
 				 adev->psp.ta_fw->data;
-		adev->psp.hdcp_context.context.bin_desc.feature_version =
+		adev->psp.hdcp_context.context.bin_desc.fw_version =
 			le32_to_cpu(ta_hdr->hdcp.fw_version);
 		adev->psp.hdcp_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->hdcp.size_bytes);
@@ -94,7 +94,7 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 
 		adev->psp.ta_fw_version = le32_to_cpu(ta_hdr->header.ucode_version);
 
-		adev->psp.dtm_context.context.bin_desc.feature_version =
+		adev->psp.dtm_context.context.bin_desc.fw_version =
 			le32_to_cpu(ta_hdr->dtm.fw_version);
 		adev->psp.dtm_context.context.bin_desc.size_bytes =
 			le32_to_cpu(ta_hdr->dtm.size_bytes);
-- 
2.17.1

