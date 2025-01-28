Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D3CC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F4D10E5F3;
	Tue, 28 Jan 2025 09:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nHfOG3Hd";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8A610E5F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igO9BsNaCZISe/S6vri3sx0XZxJQz+nDOzrQ9PZV3/7yK7VBiOIxSlktCUZVuKehzm4szMe8d2xbqQp6NcdM95aYdzWV+WrtUK37jDJsz7reNtiSFVUIYH28UZDFdOV2itt1QsuATR24g7j8syHkKXK2uCksul6pv8xTin6/jm1hOGE3uBjWxU0u8x8qdTrgI6KraX33LFNXc0ljmejPxP2rbtHv3XzFhvU4vX4eJXw+eCUodA1OwLe7ebtJoxkxCI/WBqEV8MPsGewnZW8TMuVg/pC2JpEaNPBxi8vmcHmSsm8mAWcpiXcGlZyeBr3q6aKV+xzP2apnQ/8ACMTVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9USV4kYj8YzvI6q0gOlem/cq/Ib/S3GgmQF+o38Zezs=;
 b=HZtAfYLv4gStp977MHA8cUauoCC6d4W9aOzzYEjsuIHTVr4NPrqmknydh4yK9hC9xYUreVWfzbhKO3H/o0T2MVFfTd8qXE8vRL3v6MmG22uupG8BP5DNS1KM35B9sfrX/U6/4H7ClIz5tB52owdR/fb7CfSbCkjJO+syenMnXTEtZvMKCiDUoMGICa4h5qeOlkZyDk7y+GuywiRXqsjp637OgTOH50dymXsy6nyKkR/1J1PR+imGjiZwthr81fu3FpC5IePevNtHAkPxOSgIBkY01MZ8P51LtsCmuo44YbVqgVXN2A/d8ievkduZq8bPszAEyzWWL+wPsJjd5drl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9USV4kYj8YzvI6q0gOlem/cq/Ib/S3GgmQF+o38Zezs=;
 b=nHfOG3HdMCUBOZ8pZSW04ABlBr4GKkQHegGBD7lnQgUKNeQaIWo0k4WzWNhfSzxaI7JTgs2r9ivuW165oC6yQfTIXgAKDX535JQAZm2et7JRkXwiQIdwZ0/NLKB533bYKkEVaiDtJQaDH/uMqxhMqja6BmphcPUzre6xOtoLYVg=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Tue, 28 Jan
 2025 09:10:53 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::30) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 09:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:10:52 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:10:50 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
Date: Tue, 28 Jan 2025 14:39:43 +0530
Message-ID: <20250128090950.461291-3-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e2c617-9d67-48be-b067-08dd3f7baa58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUtqa25Gc2pBZzE1VmJnQnY4YVQwQ0g5VXMwSUs1SjlTS0xPNldOWjEyQzlw?=
 =?utf-8?B?dDI0OXlIbGdOTVNqZkZnSmxIbWMyamZLd3Y4YzNLK0ljZkdmVi9Tb21tR3VJ?=
 =?utf-8?B?d0gzMjR2bE1yQ0NXYzBwa3N5N2xFcDQ5Wk9VVjJsUlVhVlZOankzbDczZzgx?=
 =?utf-8?B?OW0rV1Rpd2RwQzR4OGg1aytjU2RCWnViRmZwRlZWOXZmUENRTEJHNWpQREV2?=
 =?utf-8?B?Lzd6QVh6bVAxZXExcm14bEs2b0tHZUJSTEpvYkhUWnlqMVA1VmRsUHZBUUFQ?=
 =?utf-8?B?WHNnYnhXU244aGFwYytxR3hwRkxFbmZvODZFdGlVTnRNekdpakx2ZkVFWU1q?=
 =?utf-8?B?V0JDeDRaN1lWS2NnZHZrNkIrKzltR0lZZVJFOTBNdHdObDlCNU9SaDZvUzlm?=
 =?utf-8?B?QndvQ1hBMFN5ZDZ0S3R1SGpTSzcyc2toOHllcXY0QTU1Rlh5dEJCTk12ZDhx?=
 =?utf-8?B?OXBpVjR3WTZBZTh3UlVGMFB4MVpyeFZEMFhmbTZJY3JQYXN1TXMyblVRMVFB?=
 =?utf-8?B?TFJjYURxM0tFZitZMXhJM0crdUltUTBLY3JsVnVFUjR4amlnTjBQRWxnZmo2?=
 =?utf-8?B?bGc4Ylc3N2dyeEwwbS9BcGRVNDh1LzdwTDJQVDRleU5Md2owclQzVlFJb210?=
 =?utf-8?B?LzFUbTY3dS9qK2hCREJybEpuNXYxazJhdWhpczZ2aVJsRkxOTlA2bGl2YzBE?=
 =?utf-8?B?RXRUaHl4bWFaL3BUZlFRb2RySEh6Qm9yaFArckVBM3M0TVEwdk1hMEhMRS9o?=
 =?utf-8?B?bkZ4dW4rYVJIQ1ZnWkUyVk94b0JQa2JOYlN4bU5wY3cxaVQ2MXFVS1hYa1Yx?=
 =?utf-8?B?dFkrUTEydVBIWEVhZjYwYkxyY1hXa1FTKzFCc2Z6TWw1QkN0TU96RWNWVTFD?=
 =?utf-8?B?b1E0cXc3eG9wWmp2eldva1MyU1BtQm9jQzFzSGg1Sjl0dnBudGVQT0JaZVFI?=
 =?utf-8?B?RURDTzc2bmoyNjEyQmg2bXNtMWlCNFBMdGNTdUJlMHk0TGFDWXVFeWVFUUJ2?=
 =?utf-8?B?SVlacFFFVTZ3VTdRaUhma3gyYUJjSXZJZlpJWjZTc01kNGpwQlVra0JkRGZa?=
 =?utf-8?B?bEdxUlVTSWV2cWc4Vm1IZExMeFNCejEwS2M0TEM3NHJ3NlUzQkkza1JjZzgy?=
 =?utf-8?B?ZXZCUENRNHo1M3VkcUowc3lMRjYzdUZTVmd5OFh5S3Z6TnBEazBDNUxTdmRy?=
 =?utf-8?B?cHgyNzlaMDVlRExiQlVRU29VNVpnNkFycmg1ajZwM3NPVmsrZ2VzOXZCcTZM?=
 =?utf-8?B?cFpxalozS29nVWxoQUxCcU9uNGtVeUUyREhuZlNoNTEySVpacTl1RzVQNExU?=
 =?utf-8?B?MStUUnJkV2lvd01qYThSVnY1Q2drMEFQdVl1WFlaOFVWZDU1N29PeHBOVmdq?=
 =?utf-8?B?TE9yS1Vtb1VNT3M0Sm9vaEpkZUI0TnM4QS94MkVKL3YrbThsdGxYOCtFYVpV?=
 =?utf-8?B?ZjZ1amR6WkhEdGZKNzFDZFdVWWl1bk83SWxJTDhoNG9jQTZad2k0Ui9LWm5Q?=
 =?utf-8?B?d3RDZElHc25FOGtqT0crWGErVDd1YXhDRlhwOUtJS29QTmowYnZxL042b0VT?=
 =?utf-8?B?dE9zRmhJN2o0Q054WHdENFZYdXdaR1Bla3VuaGFJOU1ucGcwLzVyc1hWY01m?=
 =?utf-8?B?VnhjOXZ0NXc5elh1WEk2TWZqdHhwWW8ybmI2OURUZlJQb2phL2VkQkZKM0tl?=
 =?utf-8?B?MHJtdHNIYnhQdGV0RWt0b1p1ZWEvVk9tT2pNZHpoaUJ4SDY4NkVCTk1WcU0z?=
 =?utf-8?B?SjFrZVNVNWZOSnIyaklkQWUzNVYrM0J5TDJhMlRldkN0bnNwRGhiMm1STGwz?=
 =?utf-8?B?aDBhWU84Y3NVSXVTd3p4UHBPS2xqZ3RFSXFUQk1RWUZNeks0S0dVTlJZcUwv?=
 =?utf-8?B?TVoxMFFJbGV5dkN4S1lXSEJRTkJUUnd6OGN6U1FqTE1FckE1N054T0J5T04r?=
 =?utf-8?B?WTVCVE5XWC92OWFVNFFTQVNKaHU0M1JPNTVkSTBIOUtFZzVhOUFmK3pxVnJG?=
 =?utf-8?B?VXo3bzluWkNRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:10:52.6851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e2c617-9d67-48be-b067-08dd3f7baa58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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

Add devcoredump helper functions that can be reused for all jpeg versions.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 59 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  7 +++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index b6d2eb049f54..70f1e0e88f4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -452,3 +452,62 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
 	}
 }
+
+void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
+			       const struct amdgpu_hwip_reg_entry *reg, u32 reg_count)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	u32 inst_off, inst_id, is_powered;
+	int i, j;
+
+	if (!adev->jpeg.ip_dump)
+		return;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		inst_id = GET_INST(JPEG, i);
+		inst_off = i * reg_count;
+		/* check power status from UVD_JPEG_POWER_STATUS */
+		adev->jpeg.ip_dump[inst_off] = RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[0],
+										  inst_id));
+		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
+
+		if (is_powered)
+			for (j = 1; j < reg_count; j++)
+				adev->jpeg.ip_dump[inst_off + j] =
+					RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[j],
+									   inst_id));
+	}
+}
+
+void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p,
+				const struct amdgpu_hwip_reg_entry *reg, u32 reg_count)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	u32 inst_off, is_powered;
+	int i, j;
+
+	if (!adev->jpeg.ip_dump)
+		return;
+
+	drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		if (adev->jpeg.harvest_config & (1 << i)) {
+			drm_printf(p, "\nHarvested Instance:JPEG%d Skipping dump\n", i);
+			continue;
+		}
+
+		inst_off = i * reg_count;
+		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
+
+		if (is_powered) {
+			drm_printf(p, "Active Instance:JPEG%d\n", i);
+			for (j = 0; j < reg_count; j++)
+				drm_printf(p, "%-50s \t 0x%08x\n", reg[j].reg_name,
+					   adev->jpeg.ip_dump[inst_off + j]);
+		} else
+			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index eb2096dcf1a6..1d334f35d8a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -92,6 +92,8 @@
 		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
 	} while (0)
 
+struct amdgpu_hwip_reg_entry;
+
 enum amdgpu_jpeg_caps {
 	AMDGPU_JPEG_RRMT_ENABLED,
 };
@@ -137,6 +139,7 @@ struct amdgpu_jpeg {
 	bool	indirect_sram;
 	uint32_t supported_reset;
 	uint32_t caps;
+	u32 *ip_dump;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
@@ -161,5 +164,9 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
+			       const struct amdgpu_hwip_reg_entry *reg, u32 reg_count);
+void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p,
+				const struct amdgpu_hwip_reg_entry *reg, u32 reg_count);
 
 #endif /*__AMDGPU_JPEG_H__*/
-- 
2.25.1

