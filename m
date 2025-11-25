Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19549D0E6F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB5F810E42B;
	Tue, 25 Nov 2025 15:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L91qO9f1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73B110E441
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+7jJ8yoSPmGEZKVKcou1L2njE5Z72KE5T1L7YylBJu4/nlp2ktJ+NHzxTcKihAZvXB1Ud7MtzaXxEGAqW4KNSBiSR5FySDP2TYFJ+fozLyGEZNr2uzQJDmFIHqKvUTpSZvRw2OkR5zTYArEetnOGNp3WLw/AVrm+ydsnZA4gFdW/Rk7MQrAIVGt3M4dT6y9Xkj0a8t/MUeDIuI3mP05INbTqN4ajJD+LHTaLBUI44ev43KY9N58aNhVkcrrwzsACVk8Gc26rFgoUGKvcpagi8+11OBsOLiBlhPMD4ytfTKHlWNwYRQCa/LbXvrxxLd80K4gNbr2WJvHL3BGz8/sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqx4IXKl46nyFi9N4v67mPZYsnFWtSMTsr+xsToxyWQ=;
 b=T4m12XsQMS0cksIm5PYTmCEKdSE3jgO6n5PEZOgHPLjxzqrYrWykkXuv55BD1ddMt5NKjxuwbKAF8EMqxJw/47qh0RjuKZoksZhuetAZouewNqxPknQJ61tavAEyhG/NzMmAwsC9pD7SAlLUkty4w9GoGBPR5Yuz0RSWX74TKwFso/iiz3SLfbhfJRP3h6NDfS+M9/sUw9ltqBguwqlungRS41uu7+zr+B3CyOqFA8o9Ly36P/uxZ8U2RUkphPQ7qDL5x7bwRAEvn32vHAzkGZUpWoiXBxqNUu6gKmW6KfXzwIwrD2s8FLvaHwCIgcLoEPohaNlYEoMKME+xeGWwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqx4IXKl46nyFi9N4v67mPZYsnFWtSMTsr+xsToxyWQ=;
 b=L91qO9f1XOrJVvKwRWGzvkDD4vBhDtaybsDs1aP+nsHqrQZ6kg6cvaiZHgNsV9LPHmg2u1zGA1dSlgjP0EVJ8YWvmEbF69w9Cd/nom5c6/WpG4ZRsiXOplRhpGWPvS7V9WoQIgYdQrNrVaEOat5GciK9Xk9I4vyIv405ZhHYKtk=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:53:49 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::7f) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 15:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 15:53:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 25 Nov 2025 09:53:44 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/sdma6: Update gfx11.0.3 SDMA FW version to include
 UMQ protected-fence fix
Date: Tue, 25 Nov 2025 21:23:31 +0530
Message-ID: <20251125155331.222776-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d064de-fced-48fa-828b-08de2c3ad149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE80WldOSmZCc01HSjJXZ04rQndMckU1eDZUUlQ2dGtaUGIzVWp3Q2RZa3kx?=
 =?utf-8?B?ZCt3NWhMbERTU3pBWngybEU1MDVLQUxpTHh2NVdnaGhmVzcra3c2cHErdmVw?=
 =?utf-8?B?VHRQb25Mcmo4bS92K0EzSHZRVllZS0tzYko4anlDamhZUnJCYnZnVTBuNzVV?=
 =?utf-8?B?RzN1OFdiUTJ5dSs0eHVZOUc3L05NYWE2R3Vqak84VEcvNm8rNFJaZDJaeVpO?=
 =?utf-8?B?WmlNa1FnKzlWMjR3Z1pLSnhqWW1reFBoenRKMDlCNzFsMWh6SFBIc1RHUzNB?=
 =?utf-8?B?UnpCeW5PMWJtRWVvZGlnV2RycmpJVUtPSEo2LzZsTmpLaWVieDFOMjRTaC9n?=
 =?utf-8?B?aTh1VlVucTlKVzVVNmhDM1c5elpaY0pZRitQSmhkK1VRYVRTWEF6ejJDb2lQ?=
 =?utf-8?B?eEhvNk1mZmtxN25zMzBjcDFMZXFjMFhSWUt1SDEvMm1WaDFEUk1oRU1iVlRQ?=
 =?utf-8?B?Mm96aC9uR1F6UlZVVHhQQThMYU5qMkNXQnVxSzhLQXZvSkkwT3Z0eGNEMFBK?=
 =?utf-8?B?dGZNd3JFRDdzVCswMWhvM3hVZElFWDEwQ1dBaVcrSysrYm1Lb1lVcnBMK3lQ?=
 =?utf-8?B?RFJjMEdlOVVOTzIwelJ6b1d4K3FBY3dwdy9lbmdEUnBDYzd3Nnc2cDBLRnhF?=
 =?utf-8?B?b2QwemtlQnkrajhqQXNxcXJvTXZoWFhYZTc0SlViVDUxUTd2VzB4ZG4wcXJB?=
 =?utf-8?B?aVE0S3ZwV1pzeHdPMDluREZzY0VjdjBGT1ZLVE4wNkdBYW5BOUtEcGlOTHl4?=
 =?utf-8?B?TWtGQkVXV28ycVkwWXJwTjl5aE9jd1ROUThPZWU0MkZXa0locU1zbm9SY3pN?=
 =?utf-8?B?N3B3NEVmRlVBeGV0NDFaYXB3SlpQU3UyTmxGWW1BNVpRRldIV2xHVnM4Ni9G?=
 =?utf-8?B?QlNrWEphTG9nditmekVLNEppTk5LelRTYU9YbThJY21UdGNZZW9XZlkvL3BE?=
 =?utf-8?B?dkN2aE5ETlhYSWNwUGRObUxack1mbzdmUXV0ZXdlK0J2TDB2TTN1eUhxaDJX?=
 =?utf-8?B?VWtIc08yaFlxY1dabWowZHlNWno4dGxmeUZ2dUkrdnB5ZDc2Vkw3bDlLZmpO?=
 =?utf-8?B?NVpxSzNvR0NhNUdodzNodjZRSTcyRWNXZ01xMTFON28waW5ZbG5ibmVMdjNK?=
 =?utf-8?B?WlArTm9ZM3NsOG1nTm5WazJuQmlpQnNXMk9aVmJaSUNpYThlOEVnOUJwR2Nz?=
 =?utf-8?B?dytYVy9uYU9NcmZQNXBkN04zY1djbGNSL0dUY0RaaGhCeVprMnZEY2V5Y0VB?=
 =?utf-8?B?bDhPMytISWY4RkZQSklRb3NNcTdZekhvS041QzAxOGZzcHhjcndxOGltNW1v?=
 =?utf-8?B?VFNRVG5kMEJKbUMxT0g2QktwUy9EcEQxSXpESzJieEJNNDN5QUgzSnJ6Z25U?=
 =?utf-8?B?cGUzRjVCekt5bHZtS253NTJXQ0NKckpsWDJCM0dibEcrK0tZYjhEelhKSUl0?=
 =?utf-8?B?UGFWUEZ3aVJvL1YvVmN5dnlzQkgwYjhqVDZWbmMzVzJETmVqWENRL3Y2UEtQ?=
 =?utf-8?B?NEZtbk1xWHplVGF3WVdJQkRQNkZSS0lid2N3ZUE3RCtaOENkMkZpWCthOHQv?=
 =?utf-8?B?OVc1dFRCeXVyK2E1MmdqQS9TamI1WENjZWNYZ0pWRFNYTVBoOUZKWlB0NStI?=
 =?utf-8?B?TU41dnRNbWZhc0FFaFNOUm0xVzNGa3dZVE1BZXlBdVBpQy9UQm5KdkRFOXlV?=
 =?utf-8?B?aGVTRXhVbXhuV0ZoNW82ZjZJZEdraXdhblhZV29RYXYwTXR1QUhqZ00zQXpn?=
 =?utf-8?B?cnZLeHFZSmJlc3NaMWlIOWp6U2pjUlhYL3VOWTN3eGE3bDVpL05UblVuaDY5?=
 =?utf-8?B?TDliNkJjTkM3N2lnSnhQUm5VY00rZ1ovc3J4OXkrV3JKTFNZU2NvOXhWQjlZ?=
 =?utf-8?B?eG5FVDUxVUtQNnZ3SG1TLzZGNVROVGgxalhSUnlud2ZsSjU1Smw3VkZHVTI3?=
 =?utf-8?B?Q29EOWtHWVRTZ2luTVlyTy9SbExDWUtLMUVNOUpZMlZleXF3M1lyc1dBUC8w?=
 =?utf-8?B?MjVLWGhLS0hBd1krWmx0VExDb2x2Nkl0SzRyTDdoTGtLY0lYUnkvNVdwQVpm?=
 =?utf-8?B?cHlaNW93RHpIbkdQM2RiQ1IrNmw0Zm1GRXhHMVUvRW5aRmZCd3ovNXc1MmVL?=
 =?utf-8?Q?i4bA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:53:46.3729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d064de-fced-48fa-828b-08de2c3ad149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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

On GFX11.0.3, earlier SDMA firmware versions issue the
PROTECTED_FENCE write from the user VMID (e.g. VMID 8) instead of
VMID 0. This causes a GPU VM protection fault when SDMA tries to
write the secure fence location, as seen in the UMQ SDMA test
(cs-sdma-with-IP-DMA-UMQ)

Fixes the below GPU page fault:
[ 1826.488596] amdgpu 0000:0b:00.0: amdgpu: [mmhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
[ 1826.488609] amdgpu 0000:0b:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 18
[ 1826.488617] amdgpu 0000:0b:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00002732
[ 1826.488623] amdgpu 0000:0b:00.0: amdgpu:      Faulty UTCL2 client ID: VCNU0 (0x13)
[ 1826.488629] amdgpu 0000:0b:00.0: amdgpu:      MORE_FAULTS: 0x0
[ 1826.488633] amdgpu 0000:0b:00.0: amdgpu:      WALKER_ERROR: 0x1
[ 1826.488638] amdgpu 0000:0b:00.0: amdgpu:      PERMISSION_FAULTS: 0x3
[ 1826.488642] amdgpu 0000:0b:00.0: amdgpu:      MAPPING_ERROR: 0x1
[ 1826.488647] amdgpu 0000:0b:00.0: amdgpu:      RW: 0x0

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index e3f725bc2f29..4996d60751ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1390,7 +1390,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 0, 3):
-		if ((adev->sdma.instance[0].fw_version >= 27) && !adev->sdma.disable_uq)
+		if (adev->sdma.instance[0].fw_version >= 29 && !adev->sdma.disable_uq)
 			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 		break;
 	case IP_VERSION(6, 1, 0):
-- 
2.34.1

