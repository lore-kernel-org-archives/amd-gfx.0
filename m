Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311AEC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C548310E5F9;
	Thu, 24 Aug 2023 21:59:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C75C10E5E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWe808i1vLtv80jAO5iIC8DWg3O+ERPPNsRKNguNgHl8G6Pl4MmQUu+cyUEnvxlyURqiSgV0+YD2Nri199CMX8PwDgHe+RxB3Xb0LncXBGzZYwWy4+uMoJ2ObYCoz4hU60e/X6L2gqhD1IdOKKpW8E5uF5s3EFut+FAzddnneVt+9qlFv4sDWjLKalXoBdv/OPvxgDCwh0PpD0zK0nMn5cQRcrDORPBDfExohN2cGapJFljZxanBmw5yBwB7LlxUYkIgqGZsRjhuAsK9iKMb9HH/NQVcSzMMdBeUyVXfK4iaNgGZiXajrHRuKslGBK7jROUYTn4RSFbhHmKLsAkjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAxCStCukLQvMFOvDnpyuc/uVXsxN3cGYFeNuIKmKLI=;
 b=DY6ZtFWGQ+ytJPYBbt5rFUKhibkrSVOvU7k6xUWHCFELm11AWJfIxH/zi3HFCLuEvJMzy0EEoKtb6axQufJ0bpWGCT7Esl5XEA745xAVEdLlMDln86wRmRMMBBAYGe7NapVeXOR2TMXtjIH/a9wHNGUZxcsC/p2ukznj8oEoxJL5NCD1GpjMWzFIMPSpPBle6KBWf1ZAXTc/Xu3ejsCHDXy4FS2qYc69C/jYbkz1t3N5eab5fMVOWNtP8VGhUaO4ezEX3x/LOjJDxb4v1wmi5Mec2Ge9G9s5kRl2jR2HLlERIjnCuA1BnH2DqpB3XbbjAhKOCoF+Hy9zfnWAusisNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAxCStCukLQvMFOvDnpyuc/uVXsxN3cGYFeNuIKmKLI=;
 b=oG+EVoyn7CLNxVJHshIfUnlj2MC3vRPEytU9gn3fD8zermgqArUB3zgew/wntbcSQRdgLvQiOXG5NSBlr1rnAUnrCn223sdllPVdwqUWITXonYh3FQhmDZSZK9WMY7Ujl3rKxqd5iDmI2/bA+BoowDmht67g7N5SJmS1qeqhBl0=
Received: from DS0PR17CA0022.namprd17.prod.outlook.com (2603:10b6:8:191::21)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:58:57 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::64) by DS0PR17CA0022.outlook.office365.com
 (2603:10b6:8:191::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amdgpu: add PSP loading support for UMSCH
Date: Thu, 24 Aug 2023 17:58:32 -0400
Message-ID: <20230824215835.2740115-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d2e6f5-717c-495f-d497-08dba4ed50af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFmvwUgUmqoylL3O4yUTw82plhLzxiY8SgpFdBUPoe9RMsfdrTl6a/+Lwtpw9m515o/StXbF2lYh2E1czXeTYbUGG9RDzoTaR725vN3o5RvreP8T96r4kkB5LMmU9w/52ZUSq85pDkxQTMXk9G3S3nGOFKDP/8M10R6RnZgTAkvp2o97gTCMWpgZM9xwdnhu5DA+UrjwY8i4XOe/78IuQW+vvlAx83vYOPGK5ArpawZmimuexDCWIThGASp0DCdWikNWk9PH/mYFf7PTfQV2PhjUhbxaAEW/IOtNuRb9UNLMAub+HbBNrCE92QrmrZJBqc39gv5I8XCnoXoT801jd3RrKdodk5WDWhED/4XykuF7Gv1AvPI0R3GT+LcStLDIrdjxTIej/YrQjxTmXjxjxWkbxBtXgR3/eRCdCp9oB0CL6DNh6AVR6U5h5MdI1m7UxPo0suM2WGdCoVW3Jyyh21p2PzEe4xGrvKETcv/sNqjpOxPXh+ndOXm8JhkOi1umMSpqlxRjoMSRHW2ETkbbHra3sZ4hGyLRRgWBbH9EB4UPSOnuKUPDC8WjGu1V8GJ8jML8MZKOIS4TKBYzPj3KDI7HV4xm/1hiKyJMEFuFNPwkUDA8utxJ/WPZipDQrH1mShKQu1dJGnMT65PS9WmgM+xDSViYfUZnV+DsA9Q+SPhxculRtccLZZejloLp0esrCTGBtemJb7rP87vBnN8hWTRCyvws7S/1beo24lGNk5eN8svz7rkmoKDvblmZx1nYGmhdUSA802/vybXlg+u5PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(30864003)(83380400001)(7696005)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:56.9399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d2e6f5-717c-495f-d497-08dba4ed50af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add front door loading support.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c    |  21 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  54 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h |   8 ++
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   | 102 +++++++++++--------
 6 files changed, 156 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bd70715d329f..ed0955ccd3d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2399,6 +2399,15 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_VPE:
 		*type = GFX_FW_TYPE_VPE;
 		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_UCODE:
+		*type = GFX_FW_TYPE_UMSCH_UCODE;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_DATA:
+		*type = GFX_FW_TYPE_UMSCH_DATA;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER:
+		*type = GFX_FW_TYPE_UMSCH_CMD_BUFFER;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index e3b52f4436a7..eecb0efeb15f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -664,6 +664,16 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "DMCUB";
 	case AMDGPU_UCODE_ID_CAP:
 		return "CAP";
+	case AMDGPU_UCODE_ID_VPE_CTX:
+		return "VPE_CTX";
+	case AMDGPU_UCODE_ID_VPE_CTL:
+		return "VPE_CTL";
+	case AMDGPU_UCODE_ID_VPE:
+		return "VPE";
+	case AMDGPU_UCODE_ID_UMSCH_MM_UCODE:
+		return "UMSCH_MM_UCODE";
+	case AMDGPU_UCODE_ID_UMSCH_MM_DATA:
+		return "UMSCH_MM_DATA";
 	default:
 		return "UNKNOWN UCODE";
 	}
@@ -750,6 +760,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	const struct sdma_firmware_header_v2_0 *sdma_hdr = NULL;
 	const struct imu_firmware_header_v1_0 *imu_hdr = NULL;
 	const struct vpe_firmware_header_v1_0 *vpe_hdr = NULL;
+	const struct umsch_mm_firmware_header_v1_0 *umsch_mm_hdr = NULL;
 	u8 *ucode_addr;
 
 	if (!ucode->fw)
@@ -962,6 +973,16 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode_addr = (u8 *)ucode->fw->data +
 				le32_to_cpu(vpe_hdr->ctl_ucode_offset);
 			break;
+		case AMDGPU_UCODE_ID_UMSCH_MM_UCODE:
+			ucode->ucode_size = le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(umsch_mm_hdr->header.ucode_array_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_UMSCH_MM_DATA:
+			ucode->ucode_size = le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_data_offset_bytes);
+			break;
 		default:
 			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index e153dd3d6b88..ae5fa61d2890 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -507,6 +507,9 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_VPE_CTX,
 	AMDGPU_UCODE_ID_VPE_CTL,
 	AMDGPU_UCODE_ID_VPE,
+	AMDGPU_UCODE_ID_UMSCH_MM_UCODE,
+	AMDGPU_UCODE_ID_UMSCH_MM_DATA,
+	AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 21ba2c695b9f..284643e1efeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -75,6 +75,17 @@ struct umsch_mm_test {
 	uint32_t		num_queues;
 };
 
+int umsch_mm_psp_update_sram(struct amdgpu_device *adev, u32 ucode_size)
+{
+	struct amdgpu_firmware_info ucode = {
+		.ucode_id = AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
+		.mc_addr = adev->umsch_mm.cmd_buf_gpu_addr,
+		.ucode_size = ucode_size,
+	};
+
+	return psp_execute_ip_fw_load(&adev->psp, &ucode);
+}
+
 static int map_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
 			  uint64_t addr, uint32_t size)
@@ -601,6 +612,22 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
 		le32_to_cpu(umsch_mm_hdr->umsch_mm_data_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(umsch_mm_hdr->umsch_mm_data_start_addr_hi)) << 32);
 
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		struct amdgpu_firmware_info *info;
+
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_UMSCH_MM_UCODE];
+		info->ucode_id = AMDGPU_UCODE_ID_UMSCH_MM_UCODE;
+		info->fw = adev->umsch_mm.fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_size_bytes), PAGE_SIZE);
+
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_UMSCH_MM_DATA];
+		info->ucode_id = AMDGPU_UCODE_ID_UMSCH_MM_DATA;
+		info->fw = adev->umsch_mm.fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(umsch_mm_hdr->umsch_mm_ucode_data_size_bytes), PAGE_SIZE);
+	}
+
 	return 0;
 }
 
@@ -668,6 +695,17 @@ int amdgpu_umsch_mm_allocate_ucode_data_buffer(struct amdgpu_umsch_mm *umsch)
 	return 0;
 }
 
+void* amdgpu_umsch_mm_add_cmd(struct amdgpu_umsch_mm *umsch,
+			      void* cmd_ptr, uint32_t reg_offset, uint32_t reg_data)
+{
+	uint32_t* ptr = (uint32_t *)cmd_ptr;
+
+	*ptr++ = (reg_offset << 2);
+	*ptr++ = reg_data;
+
+	return ptr;
+}
+
 static void umsch_mm_agdb_index_init(struct amdgpu_device *adev)
 {
 	uint32_t umsch_mm_agdb_start;
@@ -698,6 +736,17 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 	adev->umsch_mm.sch_ctx_gpu_addr = adev->wb.gpu_addr +
 					  (adev->umsch_mm.wb_index * 4);
 
+	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &adev->umsch_mm.cmd_buf_obj,
+				    &adev->umsch_mm.cmd_buf_gpu_addr,
+				    (void **)&adev->umsch_mm.cmd_buf_ptr);
+	if (r) {
+		dev_err(adev->dev, "failed to allocate cmdbuf bo %d\n", r);
+		amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
+		return r;
+	}
+
 	mutex_init(&adev->umsch_mm.mutex_hidden);
 
 	umsch_mm_agdb_index_init(adev);
@@ -761,6 +810,11 @@ static int umsch_mm_sw_fini(void *handle)
 	amdgpu_ring_fini(&adev->umsch_mm.ring);
 
 	mutex_destroy(&adev->umsch_mm.mutex_hidden);
+
+	amdgpu_bo_free_kernel(&adev->umsch_mm.cmd_buf_obj,
+			      &adev->umsch_mm.cmd_buf_gpu_addr,
+			      (void **)&adev->umsch_mm.cmd_buf_ptr);
+
 	amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
index 660150c630e7..d83fdf2da464 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -147,6 +147,10 @@ struct amdgpu_umsch_mm {
 	uint64_t			data_start_addr;
 	uint32_t			data_size;
 
+	struct amdgpu_bo		*cmd_buf_obj;
+	uint64_t			cmd_buf_gpu_addr;
+	uint32_t			*cmd_buf_ptr;
+
 	uint32_t			wb_index;
 	uint64_t			sch_ctx_gpu_addr;
 	uint32_t			*sch_ctx_cpu_addr;
@@ -163,12 +167,16 @@ struct amdgpu_umsch_mm {
 	struct mutex			mutex_hidden;
 };
 
+int umsch_mm_psp_update_sram(struct amdgpu_device *adev, u32 ucode_size);
+
 int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, int ndws);
 int amdgpu_umsch_mm_query_fence(struct amdgpu_umsch_mm *umsch);
 
 int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch);
 int amdgpu_umsch_mm_allocate_ucode_buffer(struct amdgpu_umsch_mm *umsch);
 int amdgpu_umsch_mm_allocate_ucode_data_buffer(struct amdgpu_umsch_mm *umsch);
+void* amdgpu_umsch_mm_add_cmd(struct amdgpu_umsch_mm *umsch,
+			      void* cmd_ptr, uint32_t reg_offset, uint32_t reg_data);
 
 int amdgpu_umsch_mm_ring_init(struct amdgpu_umsch_mm *umsch);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 0683a8cb044d..d3dec5f21bec 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -34,9 +34,22 @@
 #include "umsch_mm_4_0_api_def.h"
 #include "umsch_mm_v4_0.h"
 
+#define WREG32_SOC15_UMSCH(ptr, reg, value) \
+({	void *ret = ptr; 										\
+	do { 												\
+		uint32_t reg_offset = adev->reg_offset[VCN_HWIP][0][reg##_BASE_IDX] + reg; 		\
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)					\
+			ret = amdgpu_umsch_mm_add_cmd((&adev->umsch_mm), (ptr), (reg_offset), (value)); \
+		else											\
+			WREG32(reg_offset, value);							\
+	} while (0);											\
+	ret;												\
+})
+
 static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 {
 	struct amdgpu_device *adev = umsch->ring.adev;
+	void* ptr = umsch->cmd_buf_ptr;
 	uint32_t data;
 	int r;
 
@@ -50,88 +63,95 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 
 	data = RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
 	data = REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL, MES_CORE_SOFT_RESET, 0);
-	WREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL, data);
+	ptr = WREG32_SOC15_UMSCH(ptr, regUMSCH_MES_RESET_CTRL, data);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_INVALIDATE_ICACHE, 1);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_RESET, 1);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_ACTIVE, 0);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_HALT, 1);
-	WREG32_SOC15(VCN, 0, regVCN_MES_CNTL, data);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_CNTL, data);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, VMID, 0);
 	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, EXE_DISABLE, 0);
 	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, CACHE_POLICY, 0);
-	WREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_CNTL, data);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_CNTL, data);
+
+
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_INTR_ROUTINE_START,
+				 lower_32_bits(adev->umsch_mm.irq_start_addr >> 2));
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_INTR_ROUTINE_START,
-		     lower_32_bits(adev->umsch_mm.irq_start_addr >> 2));
-	WREG32_SOC15(VCN, 0, regVCN_MES_INTR_ROUTINE_START_HI,
-		     upper_32_bits(adev->umsch_mm.irq_start_addr >> 2));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_INTR_ROUTINE_START_HI,
+				 upper_32_bits(adev->umsch_mm.irq_start_addr >> 2));
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_PRGRM_CNTR_START,
-		     lower_32_bits(adev->umsch_mm.uc_start_addr >> 2));
-	WREG32_SOC15(VCN, 0, regVCN_MES_PRGRM_CNTR_START_HI,
-		     upper_32_bits(adev->umsch_mm.uc_start_addr >> 2));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_PRGRM_CNTR_START,
+				 lower_32_bits(adev->umsch_mm.uc_start_addr >> 2));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_PRGRM_CNTR_START_HI,
+				 upper_32_bits(adev->umsch_mm.uc_start_addr >> 2));
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_INSTR_BASE_LO, 0);
-	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_INSTR_BASE_HI, 0);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_BASE_LO, 0);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_BASE_HI, 0);
 
 	data = adev->umsch_mm.uc_start_addr + adev->umsch_mm.ucode_size - 1;
-	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_INSTR_MASK_LO, lower_32_bits(data));
-	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_INSTR_MASK_HI, upper_32_bits(data));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_MASK_LO, lower_32_bits(data));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_MASK_HI, upper_32_bits(data));
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_LO,
-		     lower_32_bits(adev->umsch_mm.ucode_fw_gpu_addr));
-	WREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_HI,
-		     upper_32_bits(adev->umsch_mm.ucode_fw_gpu_addr));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_LO,
+				 lower_32_bits(adev->umsch_mm.ucode_fw_gpu_addr));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_HI,
+				 upper_32_bits(adev->umsch_mm.ucode_fw_gpu_addr));
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_MIBOUND_LO, 0x1FFFFF);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_MIBOUND_LO, 0x1FFFFF);
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_BASE0_LO,
-		     lower_32_bits(adev->umsch_mm.data_start_addr));
-	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_BASE0_HI,
-		     upper_32_bits(adev->umsch_mm.data_start_addr));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_BASE0_LO,
+				 lower_32_bits(adev->umsch_mm.data_start_addr));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_BASE0_HI,
+				 upper_32_bits(adev->umsch_mm.data_start_addr));
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_MASK0_LO,
-		     lower_32_bits(adev->umsch_mm.data_size - 1));
-	WREG32_SOC15(VCN, 0, regVCN_MES_LOCAL_MASK0_HI,
-		     upper_32_bits(adev->umsch_mm.data_size - 1));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_MASK0_LO,
+				 lower_32_bits(adev->umsch_mm.data_size - 1));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_MASK0_HI,
+				 upper_32_bits(adev->umsch_mm.data_size - 1));
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_DC_BASE_LO,
-		     lower_32_bits(adev->umsch_mm.data_fw_gpu_addr));
-	WREG32_SOC15(VCN, 0, regVCN_MES_DC_BASE_HI,
-		     upper_32_bits(adev->umsch_mm.data_fw_gpu_addr));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_DC_BASE_LO,
+				 lower_32_bits(adev->umsch_mm.data_fw_gpu_addr));
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_DC_BASE_HI,
+				 upper_32_bits(adev->umsch_mm.data_fw_gpu_addr));
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_MDBOUND_LO, 0x3FFFF);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_MDBOUND_LO, 0x3FFFF);
 
 	data = RREG32_SOC15(VCN, 0, regUVD_UMSCH_FORCE);
 	data = REG_SET_FIELD(data, UVD_UMSCH_FORCE, IC_FORCE_GPUVM, 1);
 	data = REG_SET_FIELD(data, UVD_UMSCH_FORCE, DC_FORCE_GPUVM, 1);
-	WREG32_SOC15(VCN, 0, regUVD_UMSCH_FORCE, data);
+	ptr = WREG32_SOC15_UMSCH(ptr, regUVD_UMSCH_FORCE, data);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
 	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-	WREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL, data);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_OP_CNTL, data);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-	WREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL, data);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_OP_CNTL, data);
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_GP0_LO, 0);
-	WREG32_SOC15(VCN, 0, regVCN_MES_GP0_HI, 0);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP0_LO, 0);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP0_HI, 0);
 
-	WREG32_SOC15(VCN, 0, regVCN_MES_GP1_LO, 0);
-	WREG32_SOC15(VCN, 0, regVCN_MES_GP1_HI, 0);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP1_LO, 0);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP1_HI, 0);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_INVALIDATE_ICACHE, 0);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_RESET, 0);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_HALT, 0);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_ACTIVE, 1);
-	WREG32_SOC15(VCN, 0, regVCN_MES_CNTL, data);
+	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_CNTL, data);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		umsch_mm_psp_update_sram(adev,
+					 (u32)((uintptr_t)ptr - (uintptr_t)umsch->cmd_buf_ptr));
+	}
 
 	r = SOC15_WAIT_ON_RREG(VCN, 0, regVCN_MES_MSTATUS_LO, 0xAAAAAAAA, 0xFFFFFFFF);
 	if (r) {
-- 
2.41.0

