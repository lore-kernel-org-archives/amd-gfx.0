Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF80C0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFD310E761;
	Wed, 29 Jan 2025 08:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AWV2/cJ0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF2110E761
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9g52EPn1LnY/oNYw9Bt+5Mv2CsEpUHelkBe9zepwQUBYn6X6Gv11mr6oPyRpDXE/Pws4l6YNiGMIyYeZy9JScRySYHYomvf5AG4aJwDg31oe9VXlKbdCZ6WiSyoUh/5LT9bdr/8v7JPho65aiVNJZUnbYOmHZcc8QenhypIOr/UtdpsACEuQ7noqAF/qizp/SKC999jcx73ZlE9XixC0ExjLpP9tWAOxYnkwjBdQGRqY4YmiQoIg2iYBG3m0UB8jhGi0N4y6qsCHKIZUv7hTu6GfEnDFKDnoqbX4CSM5u/Imj+T9/Z/fG88SnK7fF1g/QnR0z8xh3HeUsZm+zNP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POKa/57wHdzAr5pPoSF7suBPo+ptsglC+zc5ywuw1J0=;
 b=R/9iupuIFM5DthaI6pd9XfpxO7+4JxNCFmQiJ0FPx9HUKPIs7bwjFWafi5Gc76s9PpeRgcyxTTh1VPiIeu6Esdc/yJHCAc4erodFa1KlvZAdzI6KqJ/mSMu4QXFSIQYUVaKRXjidUHBpPWSyNNSw+ieluIhLzmpfEm7M6mDMcBeXyJkJ7y51uKDm8lxAY9/1cUi9a7ScKgCVROuBlWWQrcPSAPi7XQUHIBTMgP8Nspo2D9TlNDVrOIR6nDZasPJ3JgdvYlcfC7bFrpscLRPf1oRUMyDYF//8I31rcnOiAqYoaH/qK/PHye2vVD+t23aOYgggZLknW0jO5v/i9DPwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POKa/57wHdzAr5pPoSF7suBPo+ptsglC+zc5ywuw1J0=;
 b=AWV2/cJ0MZ+qhhR6mIilnq85MeB7LBF7IZwSF6AyE4aozbeNTQlNVF2cMEFVi7liM2STMuD928YgZeBCxPiYw8IX39cKKAdSOK3OQI7wxOZUYYDielwjupvNw3MWkryq+yfH7NqWSfELTem1VHBbxe/aKSiCNbqq3MfbDIkaSUI=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 08:47:33 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::a9) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 08:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:47:33 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:47:31 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
Date: Wed, 29 Jan 2025 14:16:36 +0530
Message-ID: <20250129084643.507727-3-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3f4223-d2ec-4f67-7f14-08dd404192b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1FWMm5KLzNWOUt2cnJaMUxUSlFNTndUYWRWZXJzOXBPNXRVYnhqZk9maGkw?=
 =?utf-8?B?TkYyU2J4WUJnUmVzeERBY0Q3Vy9xTS9qdDQvLytzMEM3QUtUVzNLQlRzUGxv?=
 =?utf-8?B?T05IT3d1VU8xdWJwa1ZUdXdtOEM5TnVYZ0UrZ3ZxTlAxTDI0Ykl2NlRIcnB6?=
 =?utf-8?B?bDdMRWV0bjhKQWVKQjV2aEloRW9ZNzJ0RGZKTTB6eXhkUi9TeW9hdTdkOEpU?=
 =?utf-8?B?R0Zta2QyWXF4SUlMcERybVlhc3hTWnRWUDFQSnpwQ0U5MW03SHZucXpycTVa?=
 =?utf-8?B?N0JRNnFtNWx2cE5Jdzh3emtKa0hQenZRTjdOaTZqRnYzTVM2bU1sTUZ0QWM1?=
 =?utf-8?B?N1VjZVp3Rk1hY2FFM2RFY3MzWHJwNGpnOW9yalZGTCt3MFJsUjZFME9ESlh4?=
 =?utf-8?B?NFROYXRqbjFDb1l0Yy85Mm1VWloxUE1oLzdncDVtdkxmMEx6MXV2eDFHUEpS?=
 =?utf-8?B?YjVVcFlzSGFJZHYrVitDcjlEL2x4RVFwYUNTS3h4SEI1enY2dGNMd2toelZm?=
 =?utf-8?B?Z2Z5WUJreUFkbXVIQS9WVzNVOXR6SVZQOGFIUlFtNFoxSG5SMkt0S3U0VWhL?=
 =?utf-8?B?VmNLWUhKMW45SkpPVlA3WkhseHFncGdWb2VPVENxTlI3QVBJcllhdkxiaWZ6?=
 =?utf-8?B?dXVkZGZLUEVSUTMwYmtWRnhoNmc4a2h1R1R5QjVtUHp1QitIN0NsdWczLytS?=
 =?utf-8?B?eDFYRys4a3pLWFVkSHJVTHAyblA1TzcrcWk4SEswQjkwTnVJWFNEcUM2cU1L?=
 =?utf-8?B?bnlTUFN4T3k3TTc5WWwyblpqL3pTMUtUWjB4aFJDNzNjUExmaVpKV1MwSHRt?=
 =?utf-8?B?ZCtEOTJNempTU3VHOWpjTzluazNMRHlnbHcwMmZNbWozTVRWRUx2bHhTUHNS?=
 =?utf-8?B?NHU3MnZyQUR2eE9WQWZnZUZTc0ZlQWRRL0V4T0V3dGhnRUlwUEhDZEo0QmFB?=
 =?utf-8?B?MURYeEVWZUVMLzdDbllkL2RlUXVESTVHN1oxZnpEQklBcWwrSkVLUGNiVUVO?=
 =?utf-8?B?Sitid0FTK1UwUWgyNlVXTVB0R2hUNWM5aXBXNDJTMEc1NG9remwwY285YVUz?=
 =?utf-8?B?NDdYL2FydFdvb2wvVjVlbXBFSnpSbWNpcmRyd2tYZ0RJV0tyZmVtK3h5dHY3?=
 =?utf-8?B?M2VPS3Flem9pOVdvUExzUmtnRjJiZEQ1M1NiN3RxVURYb3dXak5tNnpmYytO?=
 =?utf-8?B?b1o2MHQxVHlZSHBxbnZLWkw5dTJWYnFjRElLanhRYTlBN3pybzV6OXg1bDVG?=
 =?utf-8?B?cThtajBBK1hDY2NsNWwwZ2VZbHlLMGJYUHNnWURZR0hNQUlITzc1ZFdGTERn?=
 =?utf-8?B?RFpjNTk1MVNsenJxSVl0cjh0R2R5L0pPSDlabktPZVBpYlF2eEY4Nm9mRGhW?=
 =?utf-8?B?b3YycVVGZjVhWU9xaWRvK3FLSCtTeS9idjhUZWlMR2NrSGFBd0ZUZmxSdmtL?=
 =?utf-8?B?V3FOanVnZ1FiK1luOXVCVDJmcjIrb0pRaklOTUdJc2tpV29YOU1JT2IyYjRQ?=
 =?utf-8?B?VEdBNzF4Vk1VWlI5Y2w0cEZRWGFXSkxYT1lKRHk4bXVQQlVKWU9rQTd5ZW1n?=
 =?utf-8?B?cHJmV3NtQjNhZWFrTERrdDBrRENiRE9pYkx5VFlBWklkWFNzS0c0YlRGcGUy?=
 =?utf-8?B?ekdmbHM2ZE9TcVhoaEZCSWhWaFd1MzlYNHNYRENaQXVIUW83MThMcXpDckwr?=
 =?utf-8?B?Z1hqMW4wRXFyY0VKZ1FYVmFPamxlbEExYXY2a1d6RFB1c3VnUVhHM2lCSXJI?=
 =?utf-8?B?ZFREMkg0QXd3UVZ3Y3p6d0dRMDBZY3dIK21hSzJsTkk5dVY0NVAvVUFIZVo5?=
 =?utf-8?B?c0J6a0QwMmRUd2ZjVW5aaTRjMzdrRnZuOTZJWlNvTkhDbWo2a1ZNK3RIeTZl?=
 =?utf-8?B?WEpxNFhIc1dlbnZEMkZIVFBhZ3YvdFhKMjZSMk9ZaW5LNnhySHU0K3NRWjhZ?=
 =?utf-8?B?WWIyOWxxc0IzczFmWUViaUtjTUxsTExYUkg5dStscG80NmJENCszV3dnM0NR?=
 =?utf-8?B?OXg1ZUdEUUdBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:47:33.3542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3f4223-d2ec-4f67-7f14-08dd404192b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

V2: (Lijo)
 - add amdgpu_jpeg_reg_dump_init() and amdgpu_jpeg_reg_dump_fini()
 - use reg_list and reg_count from init() to dump and print registers
 - memory allocation and freeing is moved to the init() and fini()

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 80 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 10 +++
 2 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index b6d2eb049f54..0f9d81e27973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -452,3 +452,83 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
 	}
 }
+
+int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
+			       const struct amdgpu_hwip_reg_entry *reg, u32 count)
+{
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * count,
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump) {
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+		return -ENOMEM;
+	}
+	adev->jpeg.reg_list = reg;
+	adev->jpeg.reg_count = count;
+
+	return 0;
+}
+
+void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev)
+{
+	kfree(adev->jpeg.ip_dump);
+	adev->jpeg.reg_list = NULL;
+	adev->jpeg.reg_count = 0;
+}
+
+void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block)
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
+		inst_off = i * adev->jpeg.reg_count;
+		/* check power status from UVD_JPEG_POWER_STATUS */
+		adev->jpeg.ip_dump[inst_off] =
+			RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[0],
+							   inst_id));
+		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
+
+		if (is_powered)
+			for (j = 1; j < adev->jpeg.reg_count; j++)
+				adev->jpeg.ip_dump[inst_off + j] =
+					RREG32(SOC15_REG_ENTRY_OFFSET_INST(adev->jpeg.reg_list[j],
+									   inst_id));
+	}
+}
+
+void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
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
+		inst_off = i * adev->jpeg.reg_count;
+		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
+
+		if (is_powered) {
+			drm_printf(p, "Active Instance:JPEG%d\n", i);
+			for (j = 0; j < adev->jpeg.reg_count; j++)
+				drm_printf(p, "%-50s \t 0x%08x\n", adev->jpeg.reg_list[j].reg_name,
+					   adev->jpeg.ip_dump[inst_off + j]);
+		} else
+			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index eb2096dcf1a6..02886ec4466e 100644
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
@@ -137,6 +139,9 @@ struct amdgpu_jpeg {
 	bool	indirect_sram;
 	uint32_t supported_reset;
 	uint32_t caps;
+	u32 *ip_dump;
+	u32 reg_count;
+	const struct amdgpu_hwip_reg_entry *reg_list;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
@@ -161,5 +166,10 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
+int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
+			       const struct amdgpu_hwip_reg_entry *reg, u32 count);
+void amdgpu_jpeg_reg_dump_fini(struct amdgpu_device *adev);
+void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
+void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 
 #endif /*__AMDGPU_JPEG_H__*/
-- 
2.25.1

