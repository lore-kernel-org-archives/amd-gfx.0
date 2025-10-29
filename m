Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B9DCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735F210E78F;
	Wed, 29 Oct 2025 10:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KpAjVP1B";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13DB10E788
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV7Vhwvfj/BXfoKrwSZ9pD9ecbYkEPDOZxpS44/he0QCQ0xmz0uA3vewJnviWRKhqZp07jWS87DZ4peqbtSvVFzothy3gBbzlATEyIUelmPAGRVskTaiiGad9XBEYHhxMMs3gQwK9bIZkKyZBgRmtRXghZUSoGalM6OValYpTNSYPePnnRdyA6dxdsQjjf4hZAwBnkpj82HWhpDWDnqNr68h7ymu5brKJ3jVt2P/zEl9a2EINrntSWnEl4FYNY918VOpdXh/tqQ5Ar0jSlEisbY1zYjDXA46rnOrBWpkQQGU66hJ8xoIb5+lZqcsZwEzpERRiKKQSAlL88X/Ok66Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+UrCexZ3nOP5cd2/nRG4qrY/fB2DXaakXeivanAbUk=;
 b=BS6Up4bk41PFDD7mUjbdSMOttTHYd4RIUW9TrjEokM/t50B3N9u+5Eq8AuQ+hqSUPiHgqwwLwklNjCAv6Ew21T+c/vQ0ElGOPDoRG/7uj7NBsRDKPQlHgTK8P1cyVDOULTcNjAV5U5lAt499EpN164Xjuz8+g50dXTKDiTJyIddcm5YPA0RFzY0VzIPX2466tpaIueyhy/69AVLUu+dS8tI58XLzkovgCIKS0vdbOZ8W+7n+zklU7slaJ61cy2SHVB6aEKCofB9uLg4hxdimR0nsmrDLKo4A2YgEt6l0LyTvA6MRwuU0yJVroZQLGD63k7d7YY55yhDNvefWjjPrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+UrCexZ3nOP5cd2/nRG4qrY/fB2DXaakXeivanAbUk=;
 b=KpAjVP1B52RYN1nqSMIb7ZyA2C7QsE5m2YQKD/HP80obtAVHWL3vgGMbW6yhhSUUT0HiKYQOj/Lin1u+uFNBgI7XnhJpSuEOUsvoLGWnuS8DKSslxd99MHCIK9J6bduG2V6bJmJaQnP8AyKOk551Tu5UbNM7QnaMkwFKABJJMck=
Received: from MN2PR15CA0047.namprd15.prod.outlook.com (2603:10b6:208:237::16)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 10:38:18 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::b7) by MN2PR15CA0047.outlook.office365.com
 (2603:10b6:208:237::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 10:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:38:18 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:38:16 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: get RAS bad page address from MCA address
Date: Wed, 29 Oct 2025 18:38:00 +0800
Message-ID: <20251029103802.1402199-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029103802.1402199-1-tao.zhou1@amd.com>
References: <20251029103802.1402199-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 5188206c-1f22-4986-0c2d-08de16d74623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wmu44hQmNvz572fG312PdSzU8chYI8n4u+i763c8sY8Y+VUXWEKDZu9RdnbV?=
 =?us-ascii?Q?SsTZteFqsSRg6Fz00zqDD+Nvo71Dnua+FJAB49CmOJJGFj/LzfuEtC8MPHM5?=
 =?us-ascii?Q?q83Sc6C1DkncRYbjND57I4Mj2DWg0Xpa5s0vSnlXTbvK3jFfnWVnquKKcts4?=
 =?us-ascii?Q?vu84mA2AJd9lOFg1uMdphvQCQ6SUJSpGEYfW3pEokpFkgb+/NExe7pCW2Kn0?=
 =?us-ascii?Q?vrZ69aaNCUvv+8G/NmlTtgT32h4cdWWKQqtkw1TifBESihOj58DH2u5tanEB?=
 =?us-ascii?Q?FR4u9nulS1AWaVwNqCBp6eKYAVy2+8FfmTmCiSEzCUyL0kS9C6NUnqGo7r+m?=
 =?us-ascii?Q?ipCLZ5FyC9K9iQfNtK0mVMuPeuJ2Aj262RZSbflgWzTTJ/EXsl2ivb9SFV5w?=
 =?us-ascii?Q?vIltcGTyiO96TNa7psXEiUYnxG93+bXcfPYJ9/eI8dXdae5H/h34+MXQK5mV?=
 =?us-ascii?Q?BBz5lAA5dzxV2B25/aTcpc1hqXIfb1dgpQT7Kw04805SZof8sM0g8puPbqq2?=
 =?us-ascii?Q?VVge8jl/FfCy5EEMfMccBeUUEreXCnXdkdHnGNTiY34qbc4LAc5BXQZoSuqX?=
 =?us-ascii?Q?IksVkM3Lt+1K9UUjXjljDVHrmfk4zK+ov17Lc8aTzFpGbFh06dMx9vXbSp5d?=
 =?us-ascii?Q?1g2Gy2y8pvSm177442yWeEmFFNw3yUWeR3eNODhICjnA1nUJKIrdwV+/F1W0?=
 =?us-ascii?Q?9cuFL3GL0j8ExGtNAz4tqcK6Zu0kv8J9CXAVkQDaAoT4S+tKkvmKYtNxzWn0?=
 =?us-ascii?Q?d69LiKBTz6agHMlV3dQhlCRFsCE3nVRzhPwcqSUmttTTatuJLMzcBiV9imGm?=
 =?us-ascii?Q?SflRBKftl40+xrmt8xALlbrO4Qe0Se34FIkd+c7GFNBaOEjFnigOPCYifzED?=
 =?us-ascii?Q?K87FQ2bRQHUzwECkP7Yce3iHCMoRGKaW1iVPEfZLFFpFyU4gqVLJW7zw2Nvr?=
 =?us-ascii?Q?ajsEIh88GaPmKLAfN9wollUjC0J4lSTemeFRtXm42easX5UvEVSZ4dU+ww9S?=
 =?us-ascii?Q?webO+hc3vr+0fa534HX1opZEXz51fNMT3Hipi2tZ4kEaSeqeYgQlIyijMLmX?=
 =?us-ascii?Q?C3MYomsmmdjrqDNiLrS+AXhBlmZ95VwMTfmhaNtluEyToD/WET7UyAW/looV?=
 =?us-ascii?Q?TH5dV3jcAkf05UtLyNv+OWNGWMJmPKnM33tCrT6oH17z2x7JMYovloQTvwn2?=
 =?us-ascii?Q?3IYDkjrz9o0ez9cXQ2ARjT7p+IP4myp7uB6p6L3UNVQuMTpO4A+BO9tYBPS+?=
 =?us-ascii?Q?QTdgBnFTG2/RFk+r0b6/e8iN/lcFDCZw94Ue2jmnGqR8d5Lpne4l4+0Y2s1/?=
 =?us-ascii?Q?/b4dlrC+zNhHWPKhAabFloe5PCN7qOIFkZiNp7vew/nNGk3p9ynkO5woZomJ?=
 =?us-ascii?Q?8hqC7tT6Rgv2OuMfmi7enfKudqH7huykgCgWx/M4j5Hf4euZ7ROafnkNL1PQ?=
 =?us-ascii?Q?/7H4BCL/cmGJh44EXTXRZu6yGFRPH97nDYNHUSsSdh0wUFBV+WbRmjeHZGpL?=
 =?us-ascii?Q?6IQ9POjoQmshiIl9oF/MmSydWRQsY8UTOfBFI+JxcYw46m7hEMoEpH0fYOz+?=
 =?us-ascii?Q?D/9r6QOkjgZ/Ag6pnXU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:38:18.3239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5188206c-1f22-4986-0c2d-08de16d74623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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

Instead of from physical address.

v2: add comment to make the code more readable

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 23d421b8ba54..ad197486d9e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3010,8 +3010,13 @@ static int amdgpu_ras_mca2pa_by_idx(struct amdgpu_device *adev,
 	addr_in.ma.err_addr = bps->address;
 	addr_in.ma.socket_id = socket;
 	addr_in.ma.ch_inst = bps->mem_channel;
-	/* tell RAS TA the node instance is not used */
-	addr_in.ma.node_inst = TA_RAS_INV_NODE;
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		/* tell RAS TA the node instance is not used */
+		addr_in.ma.node_inst = TA_RAS_INV_NODE;
+	} else {
+		addr_in.ma.umc_inst = bps->mcumc_id;
+		addr_in.ma.node_inst = bps->cu;
+	}
 
 	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
 		ret = adev->umc.ras->convert_ras_err_addr(adev, err_data,
@@ -3158,7 +3163,11 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 		save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
 		bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
 	} else {
-		save_nps = nps;
+		/* if pmfw manages eeprom, save_nps is not stored on eeprom,
+		 * we should always convert mca address into physical address,
+		 * make save_nps different from nps
+		 */
+		save_nps = nps + 1;
 	}
 
 	if (save_nps == nps) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3bf633158fa2..511c5882b37e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1012,10 +1012,10 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 		record[i - rec_idx].retired_page = 0x1ULL;
 		record[i - rec_idx].ts = ts;
 		record[i - rec_idx].err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-		record[i - rec_idx].cu = 0;
 
 		if (adev->umc.ras->mca_ipid_parse)
-			adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+			adev->umc.ras->mca_ipid_parse(adev, ipid,
+				(uint32_t *)&(record[i - rec_idx].cu),
 				(uint32_t *)&(record[i - rec_idx].mem_channel),
 				(uint32_t *)&(record[i - rec_idx].mcumc_id), NULL);
 		else
-- 
2.34.1

