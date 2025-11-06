Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5731DCCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 17:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EDA10E989;
	Thu,  6 Nov 2025 17:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVwSwMf4";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4903A10E989
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 17:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/FzdlnfR9j7GgWo1Fp92ak4A1Y5ZZ3DnAbkYGpzugk4vgXtKFS0QDyR5ibgb1mTHxMCc2d9BLtimdnOBCDJzsd+bXl6PlNu9vhErC+nMEpfjsi9gSlTnoHyW2bag9s8tyA9KHFFb23BDi7itTWIhZOJRgDBTQbqjrPpzGBcZ1XFFlfIvRc3imN8A6fTogFVkauoM0d51RkwQ+LfBog4X3yoML0km/s9CSj3XTvmB5PQLz/IaUR7vOTGnRHnPvNJetZLoRhe1zhjEvK4nBvqi0algWD3s+UIWMUltmP2GUNTsiTk1homKCDOo/+HgH2VCkdmqsM0jTXZTdzXUoNCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcnIgRHUIT1y4ok0jsXUnNCaiDvgGoHC4aqY6Qy9iDE=;
 b=Rt/Eo9hjHdGcgQ/IsLm39uKmyIy8Fzf3+gfVMWWFENz/cmsKAV+lFObe53ckC7Ely+gny+JMa4+b6TvDJPDmxqE/d5ZuJ6cvuvQvcn1IgHn0Y0xFQw4P6eQkpc641zuLYFuqjnYqn7Qx3dEVz+sWGcfFFBomStts2DPgtfiY6GCcHAxMqK/XYU2HwBFxIwGXtKtcdRg8Z6hy9XWtduYDp9aebMD8htqWlCTU+ueZ9P1g19jt7CRoHNdVeNtgeGkaslS4KBC3Ngt5vzZPNNqNaTyg09xhaH7qZ6Ipzm+WAYOEIyyj2q2bp9RrbdAwHmgGyjxKvc8Upf87HKHMMw54Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcnIgRHUIT1y4ok0jsXUnNCaiDvgGoHC4aqY6Qy9iDE=;
 b=BVwSwMf4DAkpIrV5RpGMLLFofIyHWtR9PEY0xp8bev/0ZmHBA+S75q5gYXQtXS7KLkBB312JEx3SRBXkAIXqrWEZOxD3leCHI7Bi4yFMdrRH6QJSUsh1V0q753FGy6n6D3iCko7/j9TTKFaAYtqvuXBYPwXmlNWYy3h/FtuRHAo=
Received: from BL1PR13CA0219.namprd13.prod.outlook.com (2603:10b6:208:2bf::14)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:04:06 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::eb) by BL1PR13CA0219.outlook.office365.com
 (2603:10b6:208:2bf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 17:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 17:04:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 6 Nov
 2025 09:04:05 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Nov
 2025 11:04:04 -0600
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 6 Nov 2025 09:04:04 -0800
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: disable peer-to-peer access for DCC-enabled GC12
 VRAM surfaces
Date: Thu, 6 Nov 2025 12:03:42 -0500
Message-ID: <20251106170356.47238-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: b48e702d-d0c3-45da-773f-08de1d567e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elpJSy9pckRyb21RODlyNnBsUncvYXl3NTZ6dDRZeVp2Ymx5bDI5WUNXVzJk?=
 =?utf-8?B?aXVockNkTmM2cS8rM0drWXlldWltQ085QmhoTjk0MlVKaVRvUzVzZ2FDN0Nz?=
 =?utf-8?B?aEIxWHhpM3NnTlZGYlhKMGNOdWFWZC9JdVVVTXFkbk9abU1UZnhLRDlvTUlI?=
 =?utf-8?B?cld1YW9qemRXZkFTN3lmd3kyT3BQQWJLblpjMnN5SDM1QW9FM2o5YWNhbUQ3?=
 =?utf-8?B?ZnFIZEFiV3dybHQ4VDJrYzRRRkdYYkl1OUowM05hL2lBSXlKYVBVSFI1YVJV?=
 =?utf-8?B?ZkxDMHNEYUcvdE96enNYYU0yLzBQbWFGUEIrMVUyQVk4Zy91aGN4alJyMjVq?=
 =?utf-8?B?RlRoSUU1RHc1UktoNGM1MWh5SlpySmJMKzlrUkgyL3dJREh6STVqUjBhM1lI?=
 =?utf-8?B?Y1ZNYjJJQVp6QnJFNXdPRjAxaTA3b2VRZEVwQVVjbXFzSjdNTGxpRmZONm40?=
 =?utf-8?B?RzcyL0V5Q3ZtbG1LOENEem00Snk1VlhZcnNCUTdkM00rbHpQRDdreFNpYmor?=
 =?utf-8?B?Y1F4MXloZmJrN2pxK0VoR2owemZVSTJKOHEwQVRqVlR0M3ByeUM1UFE2cUFO?=
 =?utf-8?B?TU03WmdZMVdkWDVxZU85bWl2QW85WW5hL0ZZeWNZcGhyWTNFSTNYY1NCbnRj?=
 =?utf-8?B?dnMwU1RwREdVL200WkVldFVLWTN4eVNoRmpxNW5iTHZpbHE2V1NvNk9ad2VW?=
 =?utf-8?B?b1o4NVExK3ZWS1RHa3pFSm5wYmdPWGN4Q0RQQkoxS2E3RGgreHZVWDRlMlhG?=
 =?utf-8?B?cmhyblJSdGdVWDBmZ0RTTzhrb0JkZ2Z5ZWxKVVhIVHVoRXdubWFKZURoRFg2?=
 =?utf-8?B?Qkc3ZFlrSVIwVXNaa0RUYWpnMEZGb0ExUHJJUnRNUTJWbHl4bmNDVWRVSCtG?=
 =?utf-8?B?MnRUek0zdHBsOTc2NmZUNkNrQU1FUU5McGlEWnJmVzRNWi9TT0pFWE9oQ1ZS?=
 =?utf-8?B?aGdkZHpIQlhyK28rQnpKTngxRzRCeUxmbngzazlYdG1WMklHeU10alR3Z0d2?=
 =?utf-8?B?OXVRamdLRTdGTTY2MW5jU1FjRHIvSDNnamRoNUJ0dml1SkV0N3V2MTVJZFRm?=
 =?utf-8?B?SjJHcENKSFpsT2Y0VkZnY0FBUTdpRzlaUVBwR1ZGZGdkTGlsZ3pENnNFVW1M?=
 =?utf-8?B?elFnaTEwdC9rU1UvWjBoLzFXVHlVbjhkenlFeFJSWU1pNjhHQjY4TVJKSzM4?=
 =?utf-8?B?OGcwcTFNY3pjYUNFU25UenBMcEJxem5EM01mUkJFN3BzZGhNYmJTdWlzMGNX?=
 =?utf-8?B?eVFvemVGd1M4Mk05RkpQQWlYTytnNnUwdC9OTUZhZ1B1aG5wZlNMSHMxYkZu?=
 =?utf-8?B?SVA2UjBxQlVQdFgxN1dqYnNJMVJHTFRvUGZwS3hVb0E2TDY2cnVwYldrVEZV?=
 =?utf-8?B?RzRWTWdOdXplMFFlR3JDcGlwOFRKZWRCZDcrUjJKdDlralV6ajhVc3ZWSDFS?=
 =?utf-8?B?enVEZmE3RXc0aHFtZUlkb2F0QjBzQkN2QXg1KytiNmlZaW5kL0YyUTR5SEMx?=
 =?utf-8?B?by95cEVRSmlCRHBDaHZ2WUFQWGc5dWZ3TmlVMHRzSURhSGx3Yi8vWGRmaDg0?=
 =?utf-8?B?SW93RURjT01POFRYS3hhTUxDWmROMnByS1doak11TmNLMmdWUWx6NVJtSHZZ?=
 =?utf-8?B?bmlva0svZGJ4VXlNZWR5L0RYRG8yWEZUZWZBSUNzVVYreEpTcmpWek5lMmZ4?=
 =?utf-8?B?TEoyMDdQMlJNUy9ERjhnUm5EWEwzQnlyOW93MW83WHBocWlJd3NsL2FTZ1hH?=
 =?utf-8?B?TGlCOEJaekVPZk5SaWZFQ3V5NTJFcGduMUo0c0NsMEgyL1ZHWHNwUm1UelRt?=
 =?utf-8?B?c21xRXUrTStMaWt2WW5zUGVEdzVZY3MrWmc2UEdNeUxmR2EwYk8xZzY0M2ln?=
 =?utf-8?B?OUh6K0hrRjdYUDdUMDMxTGFSVXN0STlaQkJWME5FOEhDWkw0Wi81K3RIZE9i?=
 =?utf-8?B?VTVJMUs4VUhTTVRnNk5oS3pOT1F5eVJteU1ROU1MZFdYT1ErOXV2VysxbnlU?=
 =?utf-8?B?SHlJUUNUMGt3QUViREN4TGt6bk5LT1dOM0dGc0xOQlhjYS9ma3Q0UVBNZExU?=
 =?utf-8?B?amVIT0hqOGJWekFhYXlUd0Mya1MvV0hleGJZNUdIWDZyWjBkcHAvU3oyeDNt?=
 =?utf-8?Q?abVI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:04:05.5891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48e702d-d0c3-45da-773f-08de1d567e49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Certain multi-GPU configurations (especially GFX12) may hit
data corruption when a DCC-compressed VRAM surface is shared across GPUs
using peer-to-peer (P2P) DMA transfers.

Such surfaces rely on device-local metadata and cannot be safely accessed
through a remote GPU’s page tables. Attempting to import a DCC-enabled
surface through P2P leads to incorrect rendering or GPU faults.

This change disables P2P for DCC-enabled VRAM buffers that are contiguous
and allocated on GFX12+ hardware.  In these cases, the importer falls back
to the standard system-memory path, avoiding invalid access to compressed
surfaces.

Future work could consider optional migration (VRAM→System→VRAM) if a
performance regression is observed when `attach->peer2peer = false`.

Tested on:
 - Dual RX 9700 XT (Navi4x) setup
 - GNOME and Wayland compositor scenarios
 - Confirmed no corruption after disabling P2P under these conditions

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 9a0bce3ba24c..d2d31031f672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -260,11 +260,24 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
 #ifdef HAVE_STRUCT_DMA_BUF_ATTACH_OPS_ALLOW_PEER2PEER
+	/*
+	 * Disable peer-to-peer access for DCC-enabled VRAM surfaces on GFX12+.
+	 * Such buffers cannot be safely accessed over P2P due to device-local
+	 * compression metadata. Fallback to system-memory path instead.
+	 * Device supports GFX12 (GC 12.x or newer)
+	 * BO was created with the AMDGPU_GEM_CREATE_GFX12_DCC flag
+	 *
+	 */
+	if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(12, 0, 0)) &&
+		bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC) {
+		attach->peer2peer = false;
+		goto update_vm;
+	}
 	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
 	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 #endif
-
+update_vm:
 	amdgpu_vm_bo_update_shared(bo);
 
 	return 0;
-- 
2.51.2

