Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288B7CAC5B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 14:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D2E10E35B;
	Mon,  6 Oct 2025 14:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VyVNriVW";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010028.outbound.protection.outlook.com
 [52.101.193.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA1C10E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 14:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lREE2PeMv/7Krnwv/eCC7JORoZs540e6w+PNg04iP+I2TDJl9CeGI/kgHpY+lxinD2AoKsmNfqv3HwOno422qUl6wSclk9PCa/vsIPeu7BGqjnsAb5WecYNyAOpwvCZ2Nz/zxpOgWSBAIirZxgqZygY/KledOtBrl13GehvfCs9aUkgxCbhJiR9fhUrE3VCBd/uyb01vOCpbw8HN4M2W3dD80A/parEAAHJA0IG/PzIeS1sBl6gq59bUGuuEGTNyDUIz44dVCuyCMXtldv4yRGRZB4qWMyt5TFF9MSLYex7L/xim4BbEAA1MvLp78Won56iNx51nc4G69+lcffZ/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+RE4TxANa6XJGl9YtYeAjxkqPDJi/X/9S4x+W5PRrQ=;
 b=hCMd+ZEZYNi3TYhmTBGuZBBs2Ex6JPxVUpRlJ5Rtuaua8zoSK9Y1erQySIA6Gty9x1Masfm4iyQS4F7m9bY0qTdgH1oQsTLSX8X65VICyh05yAZQq+/pEz2q4NYrImoaNAz+V7kz6KXexmS1PxxIEooyeWTJkbF0wKK0w91ONhMKZAuvcQ2Jaab6+L0PVfPe3t97KBst5NMh50rHoFYhqAylGXNl1osGDDSNTOqzGNSIjC6DaHIUH777b3HHXNxLoCJQfiJAp3RYujNZOZtFj2T5+LS5IugYf6bRbSNagsDQYAJ58DsSwx2Y12rI4qCdiDnW8iX2vCby9IzlhKRBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+RE4TxANa6XJGl9YtYeAjxkqPDJi/X/9S4x+W5PRrQ=;
 b=VyVNriVWy2Vapt2Hl3rlC/Z+Wwv8eisjjOCJAAXGY/tv86YwwTXoShDlXChWBGfwSQuqNVtIhoQRwXxhfvJwmVP0NqOmUrw7R51RCElOmNs7V2WmGjCpGFQ6A8vpbOHoaeDx/WoncT5oBTXHIKsFhsrKHY1ZdebUXCZKvoyVEvw=
Received: from SA1P222CA0077.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::24)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:17:12 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::15) by SA1P222CA0077.outlook.office365.com
 (2603:10b6:806:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 14:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 14:17:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 07:17:09 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/2] drm/amdgpu: Handle MMIO_REMAP as fixed I/O via dma-buf
 v3
Date: Mon, 6 Oct 2025 19:46:52 +0530
Message-ID: <20251006141654.32291-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac2c298-d05f-4596-00ab-08de04e30ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkcyZjJmL1d4NlFDOTZ4bUNOd2dFbDBJaDMvSUhRekVrVWR3dGtQWk1ScCs3?=
 =?utf-8?B?Tk1WQWsySitUUkpBWS9PTWtzMXdnaVhRQ2MvU3IyUFVBcXgvUHZHTUR3K1cy?=
 =?utf-8?B?ZmhOOUhiYnM2KzRBTDIzZ1cwRHFRd2F0S0tMaUtoRmY3eWFSNVg0anZtT21K?=
 =?utf-8?B?L3ZMbUpoSUhyTTdURnkrK0QwR0d5bWdMSHdzY0pDTW5nL1VxU3FlOHo3cTIy?=
 =?utf-8?B?bmJ4MkdNb0VNNXJRM0lySEgvdm9SdWdzb0x3YzFLNFFoNjB0eVdGQThhQlk2?=
 =?utf-8?B?NC9YMDVEUjFZTWV0M2pSUmk0UWN2SkdDRXlwYmNQMXBMQmczWVdyelBWd0kr?=
 =?utf-8?B?M3k3dVpjQXBoV3NMTmJVRmFaWlZ5d0RQOVFCbnVCRkp5d0tuVXFEK3JWTVpS?=
 =?utf-8?B?VUdteDJrRms5UnZCWGg4NTQzcDNHOHBuamlGNk9DMFFxMTJVRlRoaEJOa0VQ?=
 =?utf-8?B?RE95b1oycW1nWTlxK01vM08yWUZONU5lTHVVa3Uwd0NSNFAyNTZpbUNuaDZP?=
 =?utf-8?B?eWhhS1d1U3F2RVBiMzZjUFZYZDN4Wmg2eWZQcUt0K3JaSnVrcmhKUWQ0Z0Vu?=
 =?utf-8?B?T3ZEVTFabkRVK1I5bDI2Nk9XYWVaOE52Q0xtR0RibUFGa1c0ZTFxWGcySDRR?=
 =?utf-8?B?UU9NYzlHN1pPYjg3aW05WFJ0QVZIb0JrWmZqU2EzN3F3NXBhV3g0VzAzcFJp?=
 =?utf-8?B?eTJhMFF4YWRGeU53NkhWL0RtKzR2MUxLeGgzOWVZUDI5V0dSZ25Bd0kxWXpk?=
 =?utf-8?B?N08yOVlRSjBTVnJTcW5pb1g3K1NpVjYyUlk1UWg1eG9PU2pxcXltK25PS1Vr?=
 =?utf-8?B?aXVyRUlWczVKaHdnQmJRdjZxMUZpT2trZ0FWQ1FGTlUzQkg5Vjd6YXAwWnVo?=
 =?utf-8?B?dFVXZVBjb0puNXg4S3ZUUXYyTHM4U2FGY2t5ek80WEpvVzhOSnR4THFEZlVz?=
 =?utf-8?B?ejlrenVqcXlzMzRFTDg0enNUNzBMSGdyaHRoWWY3Y3ZIRlB3dXBhUEdmZ2Fx?=
 =?utf-8?B?Q0tqMnB5amZBNjBXRjVldWF0bmRIa0gxMlBMQlhTenVwVVVDL3Q2Z1RFSzYr?=
 =?utf-8?B?bVB4eFJnNVJmNGt3NEp0S21xMUxPSU1XTDhycThma21GWG1GUVcwWW03QUVk?=
 =?utf-8?B?OUxSV2VIOGJqbVU3VUJURmI3NEVPVDRKR09BcklZTnA1N2xZMWdtRkdQQ1FF?=
 =?utf-8?B?UnFsQWlPTktNN1NMUElQaUxIOUNYV2hUTTBkUEM2Ry9sOE10QVNyZEpkVHRP?=
 =?utf-8?B?OVBnQzNHc2dDWVc2WVNPaURmeUF1RTg5dXJ2YzBqbUhHTnY2V1AwV1Z0NzZM?=
 =?utf-8?B?b3IzQzN0RGlBMVNnd2RXMEVJNmhCcGwwWVp5SUxhRCtMcU5KaENBYzl4UHJ0?=
 =?utf-8?B?L2l5ajBBVWdsSUNvUkNJV2E0bVlSNjNnRjFOVnViMk5jN0p2SW1KSmhobk9a?=
 =?utf-8?B?cy9vVGQyYW1TemE2V2NCNzhpOUtDYlBSRys5NjBwNE13Sk9reHJ1NTVTeENq?=
 =?utf-8?B?MnhHd3BZT1I1RFZmRi9BYTh6TVhob25heEh1dE1jQjhmNFgvZnkrSGtmQVRY?=
 =?utf-8?B?MU5kZDVOZzBseGV4K2dCU04yR0VxMStsSGRhQnFCTUREMDNuV2o3SDg3ZmRJ?=
 =?utf-8?B?elc5c1dSNHY3YWE0RW5YbDJ1ZDdqMzlHekoxeWgwRm1pTDdLaVhhcThybktI?=
 =?utf-8?B?S2VOWWtvWDhTcEZMSnhqYW9BcVUyaWpST2ZCb0t5Tk5kQmRvbzgzaGtBdCtW?=
 =?utf-8?B?TFNJQXRSeFdKMG5SV3pJcFJscmxGSnJLd3RqeFFzQUhCUSt4b3RsbG11WW13?=
 =?utf-8?B?RWk0ZndXQnhsdEVBOEhZcHRUaTdHV0svSUhCNDJBdi9aY1p6bGVtVDVwQjNl?=
 =?utf-8?B?NWZxRDk2LzV6SHBKVEpRL0lqS3YvVjNML3hvZjdnQk1GS3o4aHFhN3lleko5?=
 =?utf-8?B?WWJ5UTRyYkpiOG9KQnlIRytqTWxsSDBBTnl0eENFVS9nd2Ezb2lXd3hlNkVt?=
 =?utf-8?B?V1BsamxuSDdHZC81eXB1WjFaWGFZZUFxT2NLbVlraG9aQm9XbUtkTVJKa2VK?=
 =?utf-8?B?b2FmN2c2T1NSdVIxOHREdEdmQ0lmQ3NsbW9rNkFFamZyWk1ja0laT2ZBTXdQ?=
 =?utf-8?Q?+Q5w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:17:11.6550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac2c298-d05f-4596-00ab-08de04e30ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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

v3: Addressed Christian’s feedbacks from v2

Move BAR I/O mapping into TTM:

New helpers in amdgpu_ttm.c: amdgpu_ttm_mmio_remap_alloc_sgt() /
amdgpu_ttm_mmio_remap_free_sgt().  Export prototypes in amdgpu_ttm.h and
include it from amdgpu_dma_buf.c.

Stop doing offset calculations in dma-buf: Use amdgpu_res_cursor
(amdgpu_res_first/next) in the TTM helper to get start/size.  Compute
BAR phys as adev->rmmio_remap.bus_addr + start inside the helper.

Simplify dma-buf MMIO_REMAP path: amdgpu_dma_buf_map()/unmap() now just
call the TTM helpers.  Drop ad-hoc checks (e.g., resource->start,
size/page checks) from dma-buf per review; policy checks remain at
callers when needed.

Keep the mapping: Build a minimal 1-entry sg_table (sg_alloc_table(...,
1, ...)) with sg_set_page(NULL, ...) since this is BAR I/O (no struct
pages).  Map with dma_map_resource(..., DMA_ATTR_SKIP_CPU_SYNC); unmap
with dma_unmap_resource().

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (2):
  drm/amdgpu/ttm: Pin 4K MMIO_REMAP Singleton BO at Init
  drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register window; add TTM sg
    helpers; wire dma-buf

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  18 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 106 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   9 ++
 3 files changed, 133 insertions(+)


base-commit: 40f4510b661af74cd4b32b368747867c00ad7490
-- 
2.34.1

