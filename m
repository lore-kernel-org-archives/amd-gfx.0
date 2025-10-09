Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C09CAC5BB
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 03:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3FD10E906;
	Thu,  9 Oct 2025 03:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KjDxMKF5";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A776310E904
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 03:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyN2Dx0K7dAlr6lC8djnEatdaUhjfzLae/6PU+4eQRquSEEtbJMsEPRvSmJBcANlFywc95hVwo3otqDa8Y2vsmh4KDsMtdY9Ow9c7Hsi/ptT6kqECtkMF1VUktJQE3KWplu0vsYBu84POfEN8kbh6g3D9AKkpxxpRlQ9xfXSkeRjLiPOak7KePgJRwtqq0wmnvz61zc42lgSLm87UjLGcEJ0nMoOPhYCSUYveUC9JT3uRPRTCxJPzJRbYH+htTs1LtgmlZyks4Zx/+AD7Gg7+lYRbjLLn1DtLS8eeJpcUVoxNT8OUBQBG/wevBYMaKSlXCySKLMcvWt+dXVMCzbmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS33ma49d0PSZ6MnwLWwHWtBiH0LxiOo2REtBoazvks=;
 b=xO6Kc5Klnn2ECe+qyxq6oelaF/l1nhtuJPj11tt7f3vcC0ed6IbtKo/3w9PzOGyW74uXDd0BiPF+556s1OBmEMmFJHzD9H6c6enWIfJ6zAvJkF4Ifxl2xvWo2aDpN+wmEXpFWfuTkMTlXFbd4LRCD5gjBNHClywN6QUpfZFYowPY/xhr1BccwADMusq30vBvymuQ+dIoE7hqjjazO365nhGsjv0k39MferfZGHpZajiqiX2bsusJgIx6/T64OQ5PSkvhrBkcYI7lmtng5bkkNSm9/Cupc86awAjuGT8IQ8oYNYdruHlaSGewUhzQ8+Cn5nx2xI03O4GsNICuO0V/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS33ma49d0PSZ6MnwLWwHWtBiH0LxiOo2REtBoazvks=;
 b=KjDxMKF5GMeeKwiQ5jQ85wLdaIUEJ/L821zGAvQHYXpZzwb9xDMh+JxH4CJo4AN12Q1gsCMSvqK1h6YlpbHK6jc2i5mjw+sTvbKtUcu+kXlXpbOcoErRQubWLd8ErU9mXBrEqht5pTU8gT8qCjWFx3YIa25C+i4Erf7sN452U8g=
Received: from PH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:510:5::8) by
 CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Thu, 9 Oct 2025 03:29:46 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::8e) by PH0PR07CA0003.outlook.office365.com
 (2603:10b6:510:5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 03:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 03:29:45 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 20:29:44 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shravankumar.Gande@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: Updated naming of SRIOV critical region
 offsets/sizes with _V1 suffix
Date: Wed, 8 Oct 2025 22:29:31 -0500
Message-ID: <20251009032931.24950-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: abf90c6a-60f1-43d1-fb4c-08de06e41798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V3BI7fY7xSW+eX15O28zbZ4L1isdFkUbzUfgnWfUC80vJB8osOb6kiyViW9y?=
 =?us-ascii?Q?sa/QLbkqqz34nkzVyN2q1FtAxSpyUTngRaH9paw6QH0uCzBG0Gf6fNDmNhsP?=
 =?us-ascii?Q?LCW0sE8AZagVS7x1oMSfQs0dLIlxSKHAG9IFozD49rLT74Kb4mD9uqHE9QJU?=
 =?us-ascii?Q?Pqt+EPRSDIEt+DEccKXgzzX+ldEs+Lbmn/06IRc2pz4dkvhtNyBKv+qIgkFh?=
 =?us-ascii?Q?KoqUhcoHnd3Q8QF4CpWaYRZHWCF1EYj44Emahp0WyVlrWTImdWJrVjhy7nWb?=
 =?us-ascii?Q?DOcRFFRfq4xZ+EFHrycoY/SxGa/3HvmHtJ7tE2nCGWdBO9Q8xAL8thV/9t6m?=
 =?us-ascii?Q?d7rZ6/JRRmcfMaL4AU0S53mMWf62/RfoNunpcKNlvcDo0SWKaB2Ee/1Adhyh?=
 =?us-ascii?Q?/Ehi6Q4PtrEZbsCS/3LerM5ybfEHsFapXq1cx5xtviVwA3Cy+peAplh3W57o?=
 =?us-ascii?Q?FJDuDNH63XKcMXiSUy3LyD9AnRSoR7Yjn+3UVmp+bXNWQM+nE3q0M8Oyj9cW?=
 =?us-ascii?Q?eoGCqMzArfmfryqWUK7IWqvqKW5+yO9LqCOe0qBBdFbWhu7gwF+SZp3d4Ptt?=
 =?us-ascii?Q?ERaCrVWaP4UW+jUqY2bsW3spR6DzxZ8zyZi8pGnF6OTvn39TSrDtZzG9oD/G?=
 =?us-ascii?Q?YluEgO2tArhy/ETMwL/FPm8GimGIuYeXViV9R23egLLWw9IJ/kW+ALFPxQHd?=
 =?us-ascii?Q?fv0QTU3f5AgX4iZZC0ECvOj5sJ69KTM+Ict6a91r9ICTXcFUlp/YoxSbDdtY?=
 =?us-ascii?Q?yVMGXkiLb5Q1701+B0O9UydJYNIkpbIlOTvOY9Se7ZoceGXAbPE7LnSDeN4L?=
 =?us-ascii?Q?jjMJudVmXtUaeVLFk9JO+5aqW0/pJQ82Bu8Rrlcgq3c4coMA8gTLapjep5nF?=
 =?us-ascii?Q?8z8kzS3cs40EIB+liM+vjGWzYgI0TsCYsGRIHCGdETNh8wXdub+cRMeuTiEj?=
 =?us-ascii?Q?eTqhSKScQ+kRbYo8L9zsuEIMYbHnO40QOYFw9VuI3cAvoN+uUA0TQYyY5xVu?=
 =?us-ascii?Q?ykiaPZXuiFd0NH+B2yNwdr5MUsu+8UH5lGOqlw0c6O14r0ZAYoiNJ4ip0ZHp?=
 =?us-ascii?Q?V3YvmM6Hl3T2tR49qDW1ScnrtpT2TigCnP40BwQ1XiWIw8iWycg1BXRI8BbN?=
 =?us-ascii?Q?8A2X7Er8PDnng2Bifq6ccru1tY6edwu4rzZF24wTG0Izm8J4hl2l0tXGd84N?=
 =?us-ascii?Q?Ah8g9vpEBbZf7+t7xFUH64iMaFDviNucgjOn3Q0g7NgTw+ChEc5dNIxsOfqf?=
 =?us-ascii?Q?CJ0JkuMYz8ZBz3yVQ7IqICtnJ3REGnXoZId4zeVNDO+xT7WnGGo1N1O0HwZk?=
 =?us-ascii?Q?TorgHobFM2qLuul8NNDvwawJpu3cJZRAeUpwJVUpU6Se94omOQILsezh92od?=
 =?us-ascii?Q?NRe252k2WFNobuZuG6OxbFQYFKcV9nAU9f33vqnb30Sqv5QQUSVVyanhI48B?=
 =?us-ascii?Q?ip1PJ+u5FcYNddBIHO9vhcFQ8UbZoFit4dUzY4H9NU3OcfMGGs4zoi8pqiAQ?=
 =?us-ascii?Q?gxWObi94hVFdDnQM4ZXINYBmWDShDUy1JBHxMWMCa9LOVRFLxXpIKp6QKh0F?=
 =?us-ascii?Q?TI6AHH3BgCuQMNUdcbU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:29:45.0538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf90c6a-60f1-43d1-fb4c-08de06e41798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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

 - This change updated existing SRIOV critical offsets with suffix _V1.
 - Therefore to prepare for the later patches to intro SRIOV critical region v2.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 20 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 57 ++++++++++++++-------
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3328ab63376b..e95adf0407a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -686,7 +686,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
 		adev->virt.fw_reserve.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 
 		amdgpu_virt_read_pf2vf_data(adev);
 	}
@@ -703,21 +703,21 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 		if (adev->mman.fw_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
+				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 		} else if (adev->mman.drv_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
 			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
+				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 		}
 
 		amdgpu_virt_read_pf2vf_data(adev);
@@ -1304,7 +1304,7 @@ static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *adev,
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return 0;
 
 	tmp = kmemdup(&host_telemetry->body.error_count, used_size, GFP_KERNEL);
@@ -1383,7 +1383,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return -EINVAL;
 
 	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
@@ -1515,7 +1515,7 @@ static int amdgpu_virt_cache_chk_criti_hit(struct amdgpu_device *adev,
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
+	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return 0;
 
 	tmp = kmemdup(&host_telemetry->body.chk_criti, used_size, GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 3a79ed7d8031..3b35154e2df6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -23,26 +23,47 @@
 #ifndef AMDGV_SRIOV_MSG__H_
 #define AMDGV_SRIOV_MSG__H_
 
-/* unit in kilobytes */
-#define AMD_SRIOV_MSG_VBIOS_OFFSET	     0
-#define AMD_SRIOV_MSG_VBIOS_SIZE_KB	     64
-#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
-#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
-#define AMD_SRIOV_MSG_TMR_OFFSET_KB	     2048
-#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB	     2
-#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB	     64
 /*
- * layout
+ * layout v1
  * 0           64KB        65KB        66KB           68KB                   132KB
  * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
  * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
  */
 
-#define AMD_SRIOV_MSG_SIZE_KB                   1
-#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB
-#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
-#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
-#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
+/*
+ * layout v2 (offsets are dynamically allocated and the offsets below are examples)
+ * 0           1KB         64KB        65KB        66KB           68KB                   132KB
+ * |  INITD_H  |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
+ * |   1KB     |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
+ *
+ * Note: PF2VF + VF2PF + Bad Page = DataExchange region (allocated contiguously)
+ */
+
+/* v1 layout sizes */
+#define AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1			64
+#define AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1		2
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1		64
+#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1		\
+	(AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1 + AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1 + \
+	 AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
+
+/* v1 offsets */
+#define AMD_SRIOV_MSG_VBIOS_OFFSET_V1			0
+#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1		AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1
+#define AMD_SRIOV_MSG_TMR_OFFSET_KB			2048
+#define AMD_SRIOV_MSG_SIZE_KB_V1			1
+#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1		AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1
+#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1		\
+	(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1		\
+	(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1	\
+	(AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
+#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1		\
+	(AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
+	 AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
 
 /*
  * PF2VF history log:
@@ -436,12 +457,12 @@ unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned
 #define _stringification(s) #s
 
 _Static_assert(
-	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
-	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
+	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
+	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
 
 _Static_assert(
-	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
-	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
+	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
+	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
 
 _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
 	       "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
-- 
2.34.1

