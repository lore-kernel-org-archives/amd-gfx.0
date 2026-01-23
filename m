Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78691D7236B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B51710EA97;
	Fri, 23 Jan 2026 10:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Wm0mIet";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1B010EA97
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUcOBCKQycstBLjxVnK22DVD+PySyh5L4n9Kq78j/Pzbzkt0aBNdX9M2k1lrl8dw+5NJwA07601H2zOPQU79mPdUkrQo09auNyCBoXf3LC0uaDEAV5SsZbmvburso2+gb/XqwzbFuhgi+v7ICtOp0B7BsN+3bRwJNdUFWVykiGhg4qc6HeJZwU5HPxU5WZl9Wu9tJzSoqJ+mXCB7kXQs2xL6KwfN3yG07XxknoTfShf5s/9oHTWNt4cmOthut2LzWh66Kni6fVDkMXsVM7VcBwlq26Vss2mqWdjbMtgWaPgHVzWEt1rSeUMoFzqCDJFNDQFsT4cymG3hBxEMy+I3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEaHriSYpqMRNxeuB8hlEc37gyIDdeTaaBEfMI8256Q=;
 b=UIr6bg9/rT3uLDBAp/quZiGIl/9b6WHtRAnF//6HV/ZYQmbsYMo97OZuLPYAUxT0vUClfD+sZQeJCw0Pt1xLF00wO1ruw3Daz+65d4Hq3I0ddVatsrMgnxbDon6dkWoNaVS/9cAZNZ/WiwT/SzJNE11maXzfJ7kxcL3Dtg2aVthr4ya7wXkcBqp5YtO1fjI4cdmOOZKZH35a00Uolq74eNwlDkhkStWZEYimxc1++SgHCtEAl9Pz9hfTk2UHo6zPYAxIUmwhImL+GGQZcIIBLHPAhtUNVUfAgyMoQWdzu6027lb6W0atNkG13F//aYHdC1pUE/MmYS+dCjur2M+o9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEaHriSYpqMRNxeuB8hlEc37gyIDdeTaaBEfMI8256Q=;
 b=0Wm0mIetWOcJVrta2nbLt7i1fadftzxsVryiueNLgFsS1YsCpTbvHbHYoFAsnsWFYDVBuewkkBK+vS8qjTAHVytsFHKNW1v1EDSHxxDwdnb4dD3JoC/3x4Az5BpjFIDPsAV4bbtPzz07qPJq8PdUD+y2H3a2TYTqt7VH1alu2EY=
Received: from BN9P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::24)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:11:11 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::95) by BN9P222CA0019.outlook.office365.com
 (2603:10b6:408:10c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:11:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:11:04 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:02:39 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:02:27 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: Add CU mask support for MQD properties
Date: Fri, 23 Jan 2026 18:01:20 +0800
Message-ID: <20260123100219.1693990-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a383a2-64ee-4485-4581-08de5a67bbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vpm2HrHDwP7y8XQgZzitighrW09H+kL/Iyq9Gmi7S6JsZQ2QqT7BEtLG8kVc?=
 =?us-ascii?Q?Q4gXm9QeSxqJheVXb3oyT4xEOAsJgETMYfDpyWM9xIWAn3oshMIjGEpPoRx0?=
 =?us-ascii?Q?vrlfnELEl9Qr84ngWZjzJ9/DJygTduwOxG5ZNjTNQk5PzTQjgCk/yr2LahI2?=
 =?us-ascii?Q?kqJk+HUgBdM7DR94irAV+1uVtjLBCGv9nyypm9FMT4NVOfN5IbzIkt0jFNx4?=
 =?us-ascii?Q?5exF9AoQ9upYxqlESZoOkIKUkgaMLyX7WQrVykBsd1VeABMcGJzB3jaJjLBt?=
 =?us-ascii?Q?knIv6BENJme9lqSCwynuhE98mBO6m8fnoGBINiSLERtfjt+JgY7O06Ldk6G8?=
 =?us-ascii?Q?dj4/hmMKwJSQpJqrJdIep5c6H+KrMFg9Ljdym8VmO94iAqHC8HOgjuQJzdsF?=
 =?us-ascii?Q?9YqR6hV6NVw/rQYmP8FI+qwlmYfCUxmkiEk/MHNUVcDdkscpTHQY+WgVTBBM?=
 =?us-ascii?Q?hDAmTd8jFxK4IhzT1XrrPHkEIjLcoaS8/Eahi0bhi0ca77uJ5bOSodI9p3m3?=
 =?us-ascii?Q?TqGuWlnZycoPuh6M/ZIosFbigiS+mJSB9u2ezmSLROjXDOW75JF23Biue6zX?=
 =?us-ascii?Q?N0pXV5NIutfnxjV0BGU8kF2l1a1oLgcmyk0mFnwaLK+1Dh/kiQas/s4/HvOS?=
 =?us-ascii?Q?gbvtm7qhCczQ2o3NSiwSXftqbd1ncS9/egWeP1mSI5Kr2YJ7NJBMyok/tgC1?=
 =?us-ascii?Q?JNAzC/FlbJD/KfV/VAMZHnQ2bt9eQppyags7zp+yblu+HtLRJO/+c0b6rvby?=
 =?us-ascii?Q?g80XjhK0na4e83svTbCQ7lkIQPINZCMIce+EbXy2eS69p4AOim7sDFJnc3N/?=
 =?us-ascii?Q?VRvrjFnmjq3cgk7SxPZmr+osXcOLPUXxlN4+ACUH3xEXz+Joh6qRcH/Djw01?=
 =?us-ascii?Q?op42bfMKds02NDCE4aCctLZX3kaCV39rGVputud4dmgCIFW+Tz6Hw39lxLRA?=
 =?us-ascii?Q?yhh7SgKEIu/sv7/8jrTKPU1Wu8PbPsrbjn/prCxrEPkxO7Vm3kUcWl6kms9T?=
 =?us-ascii?Q?dViDhsjREZ/WrryNWL33qQ8nvjaLDIBR/OzZ2pKaq4hM+wNa07jxPKimGm/4?=
 =?us-ascii?Q?n+gnVuERK9G+3UnvEau9bSd3YZK95WII01U5VMd4WBfbNj+tiCPXN5Fs/zlD?=
 =?us-ascii?Q?b0x1bJS62Km0sYKd9RxcuoeeroJW5pzYiImVUdNiAEbMScu3OiFbE7ArP/sk?=
 =?us-ascii?Q?P9QZPnrGRRqLR8xApLWqvsajmVcTkYMhf5kDoPg0aSi91bcbESKdz94YDn33?=
 =?us-ascii?Q?FIU65hI/CpK0e1Xlt3papE8EGb9jB9IRaWZ2hCxuYFftY5cScLUM8fx8hu1I?=
 =?us-ascii?Q?z6Ry1fDteFjZdL6N7wYAtDG0HQBWnlZhSDPlSdD59Ad3Vxj/1EPNCBl4fcYx?=
 =?us-ascii?Q?wgyHctV34VzUpBTiGz1d8J0lLCz2mrnw+y87UDF6yC4O1OLX0bWB3Wx9GDyQ?=
 =?us-ascii?Q?Ro9/UO8xLY1fu26inW2TsiPCUVAGS57Qfm+a8JhlQgyXRGlrdJKP9He1SX3T?=
 =?us-ascii?Q?4G9fNL7wUAcdeRrss7ByG+XOwBZs5PTxwWSzcb7gS/FiTaT2cTp4CKqrxaUF?=
 =?us-ascii?Q?vDr6Vl/aOXUiNOcceqJKvEWT42PIe2so5DO/3CTszZ0ER0mq18g5K4pRM6DL?=
 =?us-ascii?Q?gsxsssyh+YxYgZwptGMJs6cT/qNsGsL6GwE8b0b0To5xR7Tx9bECR5hQ5YaZ?=
 =?us-ascii?Q?Xiu6zQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:11:11.1599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a383a2-64ee-4485-4581-08de5a67bbcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
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

Add new fields to the amdgpu_mqd_prop structure to track CU (Compute Unit)
mask information, including the mask itself, count, flags, and a flag to
indicate if user-specified CU masking is active.

v2: Create a generic function amdgpu_gfx_mqd_symmetrically_map_cu_mask()

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 10 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 49 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 3 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 11a36c132905..a8f4f73fa0ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -789,6 +789,12 @@ struct amd_powerplay {
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
+enum amdgpu_mqd_update_flag {
+       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
+       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
+       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+};
+
 struct amdgpu_mqd_prop {
 	uint64_t mqd_gpu_addr;
 	uint64_t hqd_base_gpu_addr;
@@ -809,6 +815,10 @@ struct amdgpu_mqd_prop {
 	uint64_t fence_address;
 	bool tmz_queue;
 	bool kernel_queue;
+	uint32_t *cu_mask;
+	uint32_t cu_mask_count;
+	uint32_t cu_flags;
+	bool is_user_cu_masked;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6abe5103a78d..73e6988cb703 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -501,6 +501,55 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 			      &ring->mqd_ptr);
 }
 
+void amdgpu_gfx_mqd_symmetrically_map_cu_mask(struct amdgpu_device *adev, const uint32_t *cu_mask,
+					      uint32_t cu_mask_count, uint32_t *se_mask)
+{
+	struct amdgpu_cu_info *cu_info = &adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	uint32_t cu_per_sh[8][4] = {0};
+	int i, se, sh, cu, cu_bitmap_sh_mul;
+	int xcc_inst = ffs(adev->gfx.xcc_mask) - 1;
+	bool wgp_mode_req = amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0);
+	int cu_inc = wgp_mode_req ? 2 : 1;
+	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
+	int num_xcc, inc, inst = 0;
+
+	if (xcc_inst < 0)
+		xcc_inst = 0;
+
+	num_xcc = hweight16(adev->gfx.xcc_mask);
+	if (!num_xcc)
+		num_xcc = 1;
+
+	inc = cu_inc * num_xcc;
+
+	cu_bitmap_sh_mul = 2;
+
+	for (se = 0; se < gfx_info->max_shader_engines; se++)
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
+			cu_per_sh[se][sh] = hweight32(
+				cu_info->bitmap[xcc_inst][se % 4][sh + (se / 4) *
+				cu_bitmap_sh_mul]);
+
+	for (i = 0; i < gfx_info->max_shader_engines; i++)
+		se_mask[i] = 0;
+
+	i = inst;
+	for (cu = 0; cu < 16; cu += cu_inc) {
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
+			for (se = 0; se < gfx_info->max_shader_engines; se++) {
+				if (cu_per_sh[se][sh] > cu) {
+					if ((i / 32) < cu_mask_count && (cu_mask[i / 32] & (1 << (i % 32))))
+						se_mask[se] |= en_mask << (cu + sh * 16);
+					i += inc;
+					if (i >= cu_mask_count * 32)
+						return;
+				}
+			}
+		}
+	}
+}
+
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 585cc8e81bb2..720ed3a2c78c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -583,6 +583,8 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			   unsigned mqd_size, int xcc_id);
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id);
+void amdgpu_gfx_mqd_symmetrically_map_cu_mask(struct amdgpu_device *adev, const uint32_t *cu_mask,
+					      uint32_t cu_mask_count, uint32_t *se_mask);
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id);
-- 
2.49.0

