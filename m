Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4C1D37489
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FA010E82B;
	Thu, 17 Oct 2024 13:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jDYNNgKj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2BF10E81D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=na1+sFXUrv+4RR7ZtOQr3MeBQrYFnxoqu7eoLA/1RLKXQlvEhzNPq9qHlZ9jBZNPObHKOyHRwkqyv43F+T2O/DiY4kaWEN297H27nNwVS3+rpu0AUQE0iNPIGwc+hHkDjwsMSa5XwxqtI07h5gnwZ1BgFBXj1wNA8yBJOzbGmuEK/99Lk+XWMShrdf3p8SfCz9X5e6Pf0pj8mHSwjbW+wowCfJf3HFWJmBbpeAtC0qYlCm3XfvEZtEGEsEx8ibVW0leXfCEvQ4NjVUy0woeqZbcuna8ZNzHZgnOieXsEbU0aq7kTy9+WBrtByrEcUxedXsfLaEo7hl5LaxFXrX3G5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4Cc/wz9QFub/ZYTTrqMnrU6GZI4YQ84vHym23PmAAk=;
 b=URLiHHlGBw6BeOnYdR4Kh2gErXiDULbX7UlArZB7cd6XkGrU7P19mASXu/s5lzKoSmsqNQSujqxMrPQcXh6AK1s41fdrF4vO2bDK6qKt5kbcxnGEMNbiZ/Fud/UnuaAPhAsJb/T7ramutkTzRcArIobm8HRRacxSBJMWd2iVZCeZ2RBK352xBl4AVs69cKlNmbCs1kolDZLBktFf6OI9UtoZe6IWL0AK7U8JfCLo9CWvwaaiNZUnFPE4H/QenTx4f4UQrxpfCoGVkNRYJciZo5oYrZNndobCKkJrT7tP0FlTE3t21NPMZIH5iB0ubB/eS64EyIkUoGaB/TkYAaA90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4Cc/wz9QFub/ZYTTrqMnrU6GZI4YQ84vHym23PmAAk=;
 b=jDYNNgKjHch89BdGsgazSJecZUSC+RdjY1KBfHGEk6b0FYg9qx4Thz5rPZOfdaDBuEKbFXaJJigDEi6BktKdH7Rcu7u3NvvvHev3gItUJgUQqt6TEGIdL/iw64QKrL4SoPK+R7UpVVgEzZji8RUHIQgbsk6++bt7u8wAffG6fRU=
Received: from MN2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:208:234::12)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 13:21:26 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::81) by MN2PR16CA0043.outlook.office365.com
 (2603:10b6:208:234::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:22 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 10/32] drm/amdgpu: move per inst variables to amdgpu_vcn_inst
Date: Thu, 17 Oct 2024 09:20:31 -0400
Message-ID: <20241017132053.53214-11-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d80440-9f07-4992-2ae6-08dceeae9a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RtUHhJEU3QfUwuCFsI7VRGUed8mM6XAej5v2eajJ+j6Sl20QVTpB430EEwB1?=
 =?us-ascii?Q?eZAWH1vTEK+0yfAXfdgSt8hKwFsetlk7xZEIo0nTaC0Guk3xnxa3FZDFXvpo?=
 =?us-ascii?Q?AVqGZVRn6no7GHFbypetVDxdjaWHwANUy59WAyc4BiazOe9TsKJlCK5LcLid?=
 =?us-ascii?Q?CxIz7543VRHmow8a/T9GocIF/m0Oos4dO1prpA9VkjzoXE4epKE317xrDCTA?=
 =?us-ascii?Q?C6f3elrmYrcIElgFPpdybJJbhZXELME0lthm7zJwDJFN4Cbe2mmDi073P8PT?=
 =?us-ascii?Q?Yuc1wpMC4Z+riyTNCEy+HbkcnVFmTo2IkCQe/fs2hdG1ryGf9//lJY4sWnSU?=
 =?us-ascii?Q?SaP8yxppNOopYiE0ZsWJ1weEHcdILE1/PIi+OcqNFeJ0Gq8HrPrXK5YsGHAy?=
 =?us-ascii?Q?vnp5bvsLfM5cqI4OwkzJ/GSRiCnRyb0BuONQza3FVPQfTEopWHmNlpAbn1mV?=
 =?us-ascii?Q?cZHLlZ+1TuNIUlRRzCxtoRZnE8CKTpWIktyPoL5/3qtJ2QLTP5jvv6G1JuBU?=
 =?us-ascii?Q?AwFaBwQKiR39PQgUId8/W5ITNWw2iujDDCENddzgp6F45v1A6Ns2IrtZp6+C?=
 =?us-ascii?Q?A8kqZAcdPQ+HhFr6lgzLCIRVI+7bhFJaQMKYJ3y0kz4uQdofVHcRipAXb9Ta?=
 =?us-ascii?Q?ZT6ZywT0+zG8TV6OkQLKJuQk+ikCT3UVikhsRwrlo6HS6yypk+Ga2qDHH0I9?=
 =?us-ascii?Q?8yseuvJT9UIs3LXhNAAPWxga0Z0LytdSml2mJ8X6r2wBOMWN5wZcLe16bIOP?=
 =?us-ascii?Q?0EUmFRzGnqhKr9ehmT1F3gkkQAAiCiLUH/NQnKiKmcREMDq9A/YFnOeHJ64s?=
 =?us-ascii?Q?fC/RaoDR7lsv8MVxjl5mF1r6862EKv5dNcBMrssR3PBvtKC+88DKq/LffjFw?=
 =?us-ascii?Q?zUDpHdvyIB/GqxsneCyaDG/+IVRowSMTr7xH4M4H5EeR5cOOt0sHY3FyxlBg?=
 =?us-ascii?Q?RbYKR/EZGCwOzKgT04UddzUbZntW997NIReOTo3s9AHSUEtLbp84XmYsZldL?=
 =?us-ascii?Q?SzU0ak6bFHh1/aUYNMG6jI9It3Qp3P8X+C7Nj1D/kJvfOIPfhkuM0h34g1y7?=
 =?us-ascii?Q?xhlCabkL+fAWnQkmh5DxH48kbPnqrnskdjn+s77DKl0N22qb6atEhfXcuYjW?=
 =?us-ascii?Q?B1KdaEC4jOS5kT6SaP9Qngpuzy2BLtRahwH0b8he7aImX+hxq5n3BMjicNQG?=
 =?us-ascii?Q?whYDl71tvYZvXe/+5zdnJxdV0J+X/bNKs4vqnY9eqBPq/F75blJ1PKzUNDwE?=
 =?us-ascii?Q?xs4gj5ViEsY6zhfB0BNX58kBSeVi9sLKqDUNT4VnYXqWLvfkijhBsqjF6dFR?=
 =?us-ascii?Q?gwP84QhDY3fVdUqdClpOpdubnkkq2fHJvfscxyj9myqtZiLWxXUnH9Dm1tBu?=
 =?us-ascii?Q?W+QlMRgULmQZmUggntQuAax1rZcgKxXeuD+Vo5XnTvCpgmYTIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:25.6793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d80440-9f07-4992-2ae6-08dceeae9a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Move all per instance variables from amdgpu_vcn to amdgpu_vcn_inst.

Move adev->vcn.fw[i] from amdgpu_vcn to amdgpu_vcn_inst.
Move adev->vcn.vcn_config[i] from amdgpu_vcn to amdgpu_vcn_inst.
Move adev->vcn.vcn_codec_disable_mask[i] from amdgpu_vcn to amdgpu_vcn_inst.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 20 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  4 ++--
 11 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9f9a1867da72..71f5ee9f6031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1340,7 +1340,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 */
 				if (adev->vcn.num_vcn_inst <
 				    AMDGPU_MAX_VCN_INSTANCES) {
-					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+					adev->vcn.inst[adev->vcn.num_vcn_inst].vcn_config =
 						ip->revision & 0xc0;
 					adev->vcn.num_vcn_inst++;
 					adev->vcn.inst_mask |=
@@ -1705,7 +1705,7 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 		 * so this won't overflow.
 		 */
 		for (v = 0; v < adev->vcn.num_vcn_inst; v++) {
-			adev->vcn.vcn_codec_disable_mask[v] =
+			adev->vcn.inst[v].vcn_codec_disable_mask =
 				le32_to_cpu(vcn_info->v1.instance_info[v].fuse_data.all_bits);
 		}
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43f44cc201cb..7ebcab8d1bd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -99,11 +99,11 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
-			r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], "amdgpu/%s_%d.bin", ucode_prefix, i);
+			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
 		else
-			r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], "amdgpu/%s.bin", ucode_prefix);
+			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
 		if (r) {
-			amdgpu_ucode_release(&adev->vcn.fw[i]);
+			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
 			return r;
 		}
 	}
@@ -151,7 +151,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	adev->vcn.using_unified_queue =
 		amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[0]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[0].fw->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 
 	/* Bit 20-23, it is encode major and non-zero for new naming convention.
@@ -270,7 +270,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
 
-		amdgpu_ucode_release(&adev->vcn.fw[j]);
+		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
 	}
 
 	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
@@ -282,7 +282,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
-	int vcn_config = adev->vcn.vcn_config[vcn_instance];
+	int vcn_config = adev->vcn.inst[vcn_instance].vcn_config;
 
 	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK))
 		ret = true;
@@ -356,12 +356,12 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			const struct common_firmware_header *hdr;
 			unsigned int offset;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.fw[i]->data;
+			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 					memcpy_toio(adev->vcn.inst[i].cpu_addr,
-						    adev->vcn.fw[i]->data + offset,
+						    adev->vcn.inst[i].fw->data + offset,
 						    le32_to_cpu(hdr->ucode_size_bytes));
 					drm_dev_exit(idx);
 				}
@@ -1057,7 +1057,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.fw[i]->data;
+			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
 			/* currently only support 2 FW instances */
 			if (i >= 2) {
 				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
@@ -1065,7 +1065,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 			}
 			idx = AMDGPU_UCODE_ID_VCN + i;
 			adev->firmware.ucode[idx].ucode_id = idx;
-			adev->firmware.ucode[idx].fw = adev->vcn.fw[i];
+			adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2a1f3dbb14d3..fc2efa53f3f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -297,6 +297,9 @@ struct amdgpu_vcn_inst {
 	atomic_t		dpg_enc_submission_cnt;
 	struct amdgpu_vcn_fw_shared fw_shared;
 	uint8_t			aid_id;
+	const struct firmware	*fw; /* VCN firmware */
+	uint8_t			vcn_config;
+	uint32_t		vcn_codec_disable_mask;
 };
 
 struct amdgpu_vcn_ras {
@@ -306,15 +309,12 @@ struct amdgpu_vcn_ras {
 struct amdgpu_vcn {
 	unsigned		fw_version;
 	struct delayed_work	idle_work;
-	const struct firmware	*fw[AMDGPU_MAX_VCN_INSTANCES];	/* VCN firmware */
 	unsigned		num_enc_rings;
 	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
-	uint8_t			 vcn_config[AMDGPU_MAX_VCN_INSTANCES];
-	uint32_t		 vcn_codec_disable_mask[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
 	struct mutex		 vcn_pg_lock;
 	struct mutex		vcn1_jpeg1_workaround;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 37ff3c140e81..553ad1efef03 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -345,7 +345,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
  */
 static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -412,7 +412,7 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 
 static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index bda39d2dd7be..670b8b4c89f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -372,7 +372,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
  */
 static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
 	if (amdgpu_sriov_vf(adev))
@@ -428,7 +428,7 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 
 static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1920,7 +1920,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 
 		init_table += header->vcn_table_offset;
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 
 		MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
 			SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index aa6c01f5854e..f9d34b8de874 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -466,7 +466,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 		/* cache window 0: fw */
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
@@ -515,7 +515,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 
 static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1288,7 +1288,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 			SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 		/* mc resume*/
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V1_0_INSERT_DIRECT_WT(
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index dbe432e765c1..79e5adddd97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -490,7 +490,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
  */
 static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -540,7 +540,7 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 
 static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1375,7 +1375,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 			mmUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 37e60d6e11b5..8ab02e5bcdd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -422,7 +422,7 @@ static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -482,7 +482,7 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 {
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -1334,7 +1334,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 			regUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index a7aab3102aca..323ad6e34a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -377,7 +377,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
 	uint32_t offset, size, vcn_inst;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	vcn_inst = GET_INST(VCN, inst_idx);
@@ -452,7 +452,7 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -939,7 +939,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 		MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, 0, regUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 895f82b9e81b..eceed8cdb3bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -370,7 +370,7 @@ static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -431,7 +431,7 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index dfc974ff4f6b..234f245e2792 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -334,7 +334,7 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -395,7 +395,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
-- 
2.34.1

