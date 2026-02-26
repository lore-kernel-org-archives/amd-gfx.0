Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F06DFC5908
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 08:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C487710E14F;
	Thu, 26 Feb 2026 08:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FnhNGtL8";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B497F10E14F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 08:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2WXEbEOinOuU67R7ZjmbS2ycoZ81Z4IbpspXKfDIsjU6CocwjkWzoCbiFXmmct3IzBrpL+GSEXQQXN2iwpd/ay510sC/ffjxCALH90J1NrA6AwzpmYzAHqHyZF1/YX6XbMsOcMT9xTlRWiOaG0BkWuqcyHR3vmZ/4qAwwqa3EpsmEytTjIHlWPT8SJCAgaYUsWrecYY/wruq2tIlg5G4FhA5NJt792euhXEqtRFNlcUQy/3Sa/1ucpzHirZgZp3fmb7jZiZMnB9ACyAMpxAZAM7r+toUD6acvnc1A6aLiZk+AyBKN/4yoYij93Lxf7A36KzYOE02WAT0vs2CzvMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXquKBbqVX3LxuTYjFXhMhu2MdRrbH7yhno6seAbBXk=;
 b=CwJ7PDHsp8sJ+acHnePA/DQKc9L/XKgashE/r5/fb1a6GfKNnmFCLFimQtneizmkJ1OqUlXiiuKHR7YqsaKgoPSS4qOAZ7BaxsKZ1JnSbqe4Zc2OMSnIlnWOWciXGGdOTX2rKj6Ro5Vpqf5YFt+yIrKjIrgsTBzFIUEC131J03hT9VgJTcgspICqlWco3gL5cVu6Y87vlwzt+Dtt/XqVRHsn5+EhX16QIRlkkiNtRW3n2GXuJORgIQGLMEQnpewp6gOvYZpbbpYIfXhVOPEGDmQdChv6WMvC2NMU7pZFphepLfIGmGD4BQG2SGOrugBLUSl6wecHje1J0nPuJ8esnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXquKBbqVX3LxuTYjFXhMhu2MdRrbH7yhno6seAbBXk=;
 b=FnhNGtL8nPC6lhiW07mzAgz2cD8ZwrWUzIOWE0XJiznxeo0xd7+SDpJ5FdROf3z87Ec5YgnE+Z+VO7SWfMrVO4gRB6SDpexrQwIcrkA+Fs3vTwW28Alr3ijGof3KaHMsGbKGAGT0ilagUAQCy5cKMkkVxVzHcc0iwu6u8GSw3co=
Received: from PH0PR07CA0080.namprd07.prod.outlook.com (2603:10b6:510:f::25)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 08:13:01 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:f:cafe::e4) by PH0PR07CA0080.outlook.office365.com
 (2603:10b6:510:f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 08:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 08:13:00 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 02:12:55 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: compatible with specific RAS old eeprom format
Date: Thu, 26 Feb 2026 16:12:45 +0800
Message-ID: <20260226081246.465526-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e56cbd-b153-4b85-e36b-08de750edb63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: qtkwuO3i9kR++8hwzTLarCs0HSawU6t+fHGSY5CH7EEiDX9avs0+qwavBBgrpzli0RUrAZQPNqzQnzyhfkXYaIZMLdimn7o5OwadTl/QsBauY4GjbSFUxK6S3/jP9HcA8iQDp9Jui2t8frkW1myJSANMC+K2eLUP0jj5/vIV4D1zx3n8nO2aVZKymPI+BAYwjCmbawFOJTZ6lgdebQ8tJ+5NLkv7kFPDit7ih8Mq3CWKiEwD+S+O3hFzEmkNEwJlb82T+poSuvnhSEWR3YnP4Pb2nARU/742f388tRWLuaKez7kmm2iZaNTjKyVnXXxkXnxB62PAtsPAqJ0kigeH+a17b5U1QnDUtZ6eI3pY+E0Jj8I5DrXsthQV5FiHMpZJ8SVXq0EG7kSPbg5HLWIvQIxu6rq+1/vh1jXlsQ4e9QU2BKrpNlQXm7t1X9ORwO7x39xjFlewFWpceKqVGXBTRsIBoXu1IckCeuyuDWH5PCEGnDQ0p0LvmpFJXrl0tDT71Xxs/UNuSeRA0MkKXSDi62iGjNxeHYBid/Q/D/MgTpDz0I4fBF1r7iHa/AzPOBOi/dk1JIQYy/6oTvstiWvgcXXczvdHN3n6i5P9Tmj058Xj86UXKvrPF/Ck+pAvhvOG6BD9qhQ8WMxnpx1wa0BwwtIkya/LzlhEwKoVEmkjTOzce993Ecc1Fwcu1hdbWwHBvmJpmhgPzihdf7G9j2yS3HoMp1nJgBWimcQkL92BQIU4gw5B0CMVahtQ+W7WdsWDFhHsioRXEe0OfTaBfnNf+AeK2+TpNX6yWeZuZHw2s3MN8V0RMYGfyxLY24gmdhmcx2lp7Q4DiVzm7pluFGZR+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vQqow0I3Y8Vp6sKwgiQRF8W5z+2aD8QmFqg1tkOf0NrMyE21gyGu5aIws97lSgLVNEbm3mXacpaSZDzVq4YJlEzecYNyapU8/VadWFs+UPp+Zb58yziF3Ccu3ZPsiKNM/nqzpbfY5fSuo/l+ag9uwoLb9KAW6DZ007HM0RnZgyq1/R5N5E8Fs2Jnv73h8ze8tANYFs7k4enGHMKBP8Gxjrk3PrgL2szhFQfNb01bWg26cRzaTIL8CSJcJBTnEilT/WSNXr3hUGDWXi98Ea7VCbIv9Ykf64v8E4quelxA+gbtui6bbNotX7YfHh8kKiPe6ZzLRG8UKGmID2L1AdwoRnfyAbr75e2wnLK2AVoMcmMNht+SJfhH7zafAUM7jG6g2G6eF3Hr42nOMe6o1U1kqVbXlOsUsRSsv5fI7eLxrPho7PGWlcJjnbsblsg273gR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:13:00.3146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e56cbd-b153-4b85-e36b-08de750edb63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095
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

Handle RAS eeprom record when UMC_CHANNEL_IDX_V2 is set.

v2: get UMC_CHANNEL_IDX_V2 flag before the clear of it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 856b1bf83533..921e9bafb556 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3118,9 +3118,11 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 				enum amdgpu_memory_partition nps)
 {
 	int i = 0;
+	uint32_t chan_idx_v2;
 	enum amdgpu_memory_partition save_nps;
 
 	save_nps = (bps[0].retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
+	chan_idx_v2 = bps[0].retired_page & UMC_CHANNEL_IDX_V2;
 
 	/*old asics just have pa in eeprom*/
 	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
@@ -3132,7 +3134,7 @@ static int __amdgpu_ras_convert_rec_array_from_rom(struct amdgpu_device *adev,
 	for (i = 0; i < adev->umc.retire_unit; i++)
 		bps[i].retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
 
-	if (save_nps) {
+	if (save_nps || chan_idx_v2) {
 		if (save_nps == nps) {
 			if (amdgpu_umc_pages_in_a_row(adev, err_data,
 					bps[0].retired_page << AMDGPU_GPU_PAGE_SHIFT))
@@ -3176,10 +3178,12 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 				enum amdgpu_memory_partition nps)
 {
 	int i = 0;
+	uint32_t chan_idx_v2;
 	enum amdgpu_memory_partition save_nps;
 
 	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
 		save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
+		chan_idx_v2 = bps->retired_page & UMC_CHANNEL_IDX_V2;
 		bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
 	} else {
 		/* if pmfw manages eeprom, save_nps is not stored on eeprom,
@@ -3201,16 +3205,19 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 			err_data->err_addr[i].mcumc_id = bps->mcumc_id;
 		}
 	} else {
-		if (bps->address) {
+		if (save_nps || chan_idx_v2) {
 			if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
 				return -EINVAL;
 		} else {
 			/* for specific old eeprom data, mca address is not stored,
 			 * calc it from pa
 			 */
-			if (amdgpu_umc_pa2mca(adev, bps->retired_page << AMDGPU_GPU_PAGE_SHIFT,
-				&(bps->address), AMDGPU_NPS1_PARTITION_MODE))
-				return -EINVAL;
+			if (bps->address == 0)
+				if (amdgpu_umc_pa2mca(adev,
+					bps->retired_page << AMDGPU_GPU_PAGE_SHIFT,
+					&(bps->address),
+					AMDGPU_NPS1_PARTITION_MODE))
+					return -EINVAL;
 
 			if (amdgpu_ras_mca2pa(adev, bps, err_data))
 				return -EOPNOTSUPP;
-- 
2.34.1

