Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C97CCFA18
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 05:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3D810E03C;
	Tue, 11 Nov 2025 05:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ng50r9Bj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E0710E03C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 05:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyQ5AkmZs7UCtkjYG9fso4FDguPu6qpFYRxRPAjDkcRXlgZrGa5qmgMAmeDsdlM7Kwq+LMLnkT54ChjQXp/UvQqOuLK2bNE4p0+Ntq32FAyznAIcHFekjzrFXWW/VXJRY+/+32kf6U5La3lWpuluS1QlRRhE3Bb8gLve3AwAEMscfho462d99mbclkx9bN2fjkAmnTlR6iCGzebMKs5Xe3iDEPvy26s4Gt5HR7vkyeB7hVdkuXn02GsKj6Ebqj2iDb+9/pFafVPPWn6bOJB+87I59P1L5bD0DuKy0GU5l3AGr8gw5iAh8+iEuB4k05LFDesNfgMgnZ4iNKsuzFfIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzp5OFe8a5pn20nIt8Gqn0dnnKpkLoH50hz1ow5bUIg=;
 b=hWu1YmxOfODxjzuHEwr9lL7Dl4tlOZWR41qBVAXTbQdrKaJCuyEBzfDySLRZ6dpJhsrfiRc9PxTlxlZIv+IulQs/5N1VcPJH2yYv7C2fDhKOKNMeRCseTwtjxi2xN18Y0yIce0RmBqkfL0fLtzrYWmGuD/v6qodlE/3bLZLIWGCmN2SyWurWnPAJfxZDc0kPJH7Lkgm+Z+tyqWmGdj/33QTJEBQntWWMKcfxqBuGen6iSLT4QLzM7PlK7vRp1BtHVSfiuwrtIcGEd4f2TmtDzTaiMMP4Oik41WDH0zTa9dH84JICFprhkmBo/ERf/D8OteihuyD3113Z4W551GmA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzp5OFe8a5pn20nIt8Gqn0dnnKpkLoH50hz1ow5bUIg=;
 b=ng50r9Bjpy2IyaMjFyDO2Z2mxGd/VR+Az35RNpaBtJuvGJwGrH8vQ9B9K02W53at2DbvCfmgb8WD4+77WE3XdwhHnX89EGBOntPDvP1/LvYvJIq8M6KBK7q3OUTXWGyQqkR/KALPsF4ePJYHRbX3GZpuCAf7YnTUtySQ4h9/vjA=
Received: from PH8PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:2d0::17)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:08:30 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::48) by PH8PR02CA0008.outlook.office365.com
 (2603:10b6:510:2d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 05:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 05:08:28 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 21:08:26 -0800
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: improve VRAM usage reporting safety in KFD
 interface
Date: Tue, 11 Nov 2025 13:08:10 +0800
Message-ID: <20251111050810.2694854-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: c868b0f7-bcb1-4eda-b5dd-08de20e05a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THhwYVdRNXY0c2FXNWowZXhNRXNMaHZxZzFWWmxQSTczc2ZHNmtNRCs3Q2xE?=
 =?utf-8?B?NlFGa1FodTFJM2FzVlVWZ2E4cEJTcUdPaEd0MFIyYkM1dTlSaHY4SitQZmJE?=
 =?utf-8?B?eE91bUo2dEpBaGo0cmVlZVlMZ3JrajdzMThPcW42OXdsVFJWVzZQZFpCYXV3?=
 =?utf-8?B?OUliS0taeEhkRCsvQnFlTXpDNlJYd0V1d0tndWVmUUpKcUFuUVF2NUdzY01w?=
 =?utf-8?B?ZFA0NW16eWtPUTIwVnBTVGxTbGxQeXk3YldHbk9MRkdhR01PYWhtWGdqZjd4?=
 =?utf-8?B?NmpNV1RScmVFYlgvamZ1RWFlWmNzcDFaeTBwM3R3RjZCZXQ0WEg4b0FTSFhS?=
 =?utf-8?B?Y3V5VmhFY2x5d3E0aTFKSFJDKzA2cjQ4Nm4xSG55clJpYUlPYVJtZmlDeDFx?=
 =?utf-8?B?Um9Id3JwVVhaUi9NK3JvbytNUWYxc1ozUU5pS0lhbDZBTk0wVkp1dk5MbXJh?=
 =?utf-8?B?bzRwS0VqdzNFSmFyajQ0NDg4VjRrTXljUWFoNWJvb21ORTgxeThYUmhEYmtp?=
 =?utf-8?B?TWIzakxLMWl5Y3BKaTVNcGdQeURBWmt2clByMzJBR3FHRWk5bFBabVZRTmtr?=
 =?utf-8?B?a0VOallVUUpaRjZaTlFXT1BGdUw1NjdleHo3eTFLRkRUdWJXK2xmcEFuTWNi?=
 =?utf-8?B?WlBhNWFaRk51eUVhR3pvUWhMYjB2ZHd4S3pka1B6YWdIT2c4bjFKcUx3SmY1?=
 =?utf-8?B?WkVNTndzNHAwT1d0WkhTVkJ1YkhBL1BTY2lKS1pSbjlWeTI5QTRHSjJMc2tU?=
 =?utf-8?B?a3RmUzhBUkg1U0ErK0R6elZkZXdCUmVtNDM5Q3RGejhKSmFsV3dLekxzYkxv?=
 =?utf-8?B?U08yU2YvVFo0YTZZcmFLWExVV3p4K01uSnRKRSswSmw1Q2ZObWdFYzlqRVZY?=
 =?utf-8?B?TU9pNENVdUduK2NwWFNTOTBvd0hTSjdNQWc5NUtsdlg4NlJmQUpEMzZyQWFO?=
 =?utf-8?B?ZHdJOG9UNC90V3VDeHY2MHEvaGVwcXQwTVNHditLQWozQzQvMmtDWVIwK044?=
 =?utf-8?B?VHArTFF6MDJmaWpmTlI3RXVwWDdmeFcvcFRLYmlCMDJvUHpTRGlFajFDelkv?=
 =?utf-8?B?eWdSTVRBV09KWFNvVHArOWJkYkdiYSs0QnRhOGxKRmxJcWZINVFoOUYveFp1?=
 =?utf-8?B?dnpjOTA5NjFEWkxTeDlpc0VERFhCWmhkVThhcnlBaXZGK092UnBiTVBxaE5u?=
 =?utf-8?B?VDJzQW04Q09rTzF3bFNEeGhiL3VoUWxiTndtZFY1eHppcjRXOFFxN3kvbUE4?=
 =?utf-8?B?NlFHaC9hME5TcDVFd3FncHJPYTZjbFBOV3IxSEZWVkpkMkRYVGo1ODdjdUFZ?=
 =?utf-8?B?cHc5UEthSEQ3U2xYcXNueTFhZ1lhek5xN2xIWHR0QnR6endIbmRDclhKWHND?=
 =?utf-8?B?c3FXQ005RDFZdW9WdnRnbFg1ZXN3YnJhUXN1cDBuL09QR0Z3d0dsRm8rd2Fi?=
 =?utf-8?B?WnQrMndLZFEvdjJuQlJxd2tvRWl1b29CdUszQkw0Vml1VXlKMnQ4ZjBwcFFE?=
 =?utf-8?B?TUpQSENrOWh3RVIwS2JlTTNNMVNXZWRKTVBLK29WYWVseFJCL0VUd2dPMW1H?=
 =?utf-8?B?OWxPeDJwNHlOSzd4aW00WkFWSCtub2E2b25WRnZuNk54WVBnakRqVXNubE85?=
 =?utf-8?B?R1hDVWpVeDYxb3BKSFZ2TVpyaVhJL2FNeTA3VXdvS1hFNytEeUppNVVjUVJq?=
 =?utf-8?B?SFBzanBPQlBVS2diWVVOY1dqYmlER2hxMmNXdFJKUzZpaDV2VGsyREp3TEtp?=
 =?utf-8?B?THdvZXMzQTdmOXJqcWQ2M1B0cjhtYlRhUm42MXVoZzRpSGFFZW1xWGRGU3Bs?=
 =?utf-8?B?eTNRWjR1c0NZZm5MVGR3cnNhOFYzdFl5QVU4OVlaUVJ5UU9LeldsRFRoQlgz?=
 =?utf-8?B?cFgxSkQzQXhlT2ZSNXpnVUZlMHMxNUxTVnB6UXVQUUwrVTJPZjJvb1NUSitG?=
 =?utf-8?B?OW5sVEtENnNpZWd3NndBQkpWVDdrcS9UNXlldFJsM1BqelFmVHEreWN0MEcr?=
 =?utf-8?B?MVU4ZXJscG5sRm9ma2syeVJQWmZpaEl1VEYwZVQzU0U0aHRqenQ3NmM2ZGNv?=
 =?utf-8?B?eFlGYks0SnE1YytVWmt2SWhEYzd6b1Y1Sy84Y2NyZkFLNGRORHpLMFpRYzVW?=
 =?utf-8?Q?9220=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:08:28.8834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c868b0f7-bcb1-4eda-b5dd-08de20e05a1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
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

Check if TTM resource manager is initialized and active before
attempting to read VRAM usge

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 39d712e3e692..495cba975f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -590,7 +590,8 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev)
 {
 
-	return ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
+	return ttm_resource_manager_used(&adev->mman.vram_mgr.manager) ?
+			ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) : 0;
 }
 
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
-- 
2.34.1

