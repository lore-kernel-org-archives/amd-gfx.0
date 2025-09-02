Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C676CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E842E10E043;
	Tue,  2 Sep 2025 14:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YA2k4Bh3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E7B10E043
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwV1YUYH4vtyLJ4GcnSt4bVKo9ePE7XOcK9CTnHRKR0moxQeZvUe9xEG2+3FdWP8vvuDQMda+jxSzQfiUaNq9NlKV2vvA+KwNnL8gx+MMbjQTNwSmrRSzJVcEygukD+cVbYvhip0zlr8W0ryYHuL1MJUadMaXxxuaRvATliPWnJbIMWpawYeXa+rvMTWo8Dif2xW4kT8egincKCK9WfIk/C1s/kCVeBuj6v+ZuSmRq+fX1df1V1qg1QiLQjYyr3jlMAyJLUqces8cAL0kIHesP9FZ4YUR9Zm9YqfxOPzeS3lQ8ykdbXunNBUc8BT8FMSBkLz8T7VVLGZqJW1Logclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDEWocDhICEtawWM10gBdn+yyJGBQia4XhaDbV5VhdM=;
 b=qWEZkR0Gx+X5gUPasouTbuMq1N/rxemJG9jiQhLvwmLjIyO8Z/nmSf1mYmM5q54V7572z0WJSsIuRRO03hzn+JU4SWbF5lFrWNceLDxBNIw2CBHwklkbCETrFZ6GTSwhvRhtIw/kizzP2uzQWsgcVfBPOAAoMmpwPIBYP9hzLyZAPB+ZXokLmxgWgD1x103ZW9echmdlLukn6P2yvz7ZYVvGwluwjzj1lh5QFsALJObfStapegC+AKR+0iflxnrY5oCHp1Y1uzxGBl7t8rdYjy7WdaRGQaeSirGDOKKYSVcDpmQ3cPYKlv9AvOC///rvfnS7Y0MpIapxwe/JS0J0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDEWocDhICEtawWM10gBdn+yyJGBQia4XhaDbV5VhdM=;
 b=YA2k4Bh32OWGA0swP9G2AxozX3sokPl2N8E7f7W1yGzwIBWNziLHdkpT3gh9tONw38cRAJfIoL3CJfxHS4bUvwVKYPT3ImY3r7h1v+UY4nGY/J3urx0UX7LmjLxHBz49XKJRVqa2oKRW7FHlDhg14K7n+afXZxOaeHuFFFoIJZQ=
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 14:58:24 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::2) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.28 via Frontend Transport; Tue,
 2 Sep 2025 14:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 14:58:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 09:58:21 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 07:58:19 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 5/8] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
Date: Tue, 2 Sep 2025 20:22:10 +0530
Message-ID: <20250902145213.486199-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3aaf47-fb7b-45ff-7b9d-08ddea312ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEpoc2ttVG53T2szb2ViMlB3L0RIQVo4R1RvbW1VbGs1eUlqTWRqSE9IZ3FN?=
 =?utf-8?B?SllXbmx6R00rd29ReWdjeHBSTHVwWHZSVW90djFWZUNRQ3pKT0NOQ09mT2pV?=
 =?utf-8?B?NnVQTHFYb2lzSCsrRE5QS3FaWTNFWlhISWJwdnovNGVUWWhWcEdoaURLWkJa?=
 =?utf-8?B?OEkvTU85TDBKM1BVcWZJcnMxTTdiWWtmY0dxNkZvS2t2b2t3ZkdFVHRPb3Z2?=
 =?utf-8?B?UkF0V09Dc1lBcFdQWWxHd012QVREWkFqM3RXRmlaaXZkcGxySmFiYUMvZUlC?=
 =?utf-8?B?dklCcUxTd28yY2xEaElrU2Yxb0dCZTZtTi9CeDJpNG1pa3M3dUxnaVBTcGFO?=
 =?utf-8?B?dU9lQll5MU1mK21zRVkyd29hWkFHYXJhamhzVTJEV3dQSTR1RVR2R0trRVZX?=
 =?utf-8?B?Q3lyblhIbHNsaXZuWVdoczA0TllqQm16L24vUmxTSUd0VWlBOU8xckNlM3FT?=
 =?utf-8?B?cGQzVFdPdXRzNFJkSkNEMXJVWjV5N0dlOFErMlJuMFliTUh6akR3K3B4SmVN?=
 =?utf-8?B?a2JkdzdzU2hoSGVaZ3BEYlg3czlkQzRpbUQrYm1vTEpWRjZndUJEL1hqbG1N?=
 =?utf-8?B?MXczMVE0Y1dVRHg3UHVFUE1zK2tOcmx6SDFabXFmWlFZOGR4ZVIvM0FaQXJo?=
 =?utf-8?B?RWltQ2xxWVpsbWdidndlT1ZWOXloOTJ5Rlcyd3ZwSVdwTU9rTU5nazBoNkJG?=
 =?utf-8?B?OXVmQXpOVVZFeW51YmZKRDhvOWRQL0trcjJHei8yaTlPcW42S0dsVjVBVWM5?=
 =?utf-8?B?Mkk3L21zMzk0VlAzclNDMkxiTnhYUVlOcVZocVFwdHZnb1RiTk50RVhUZUFR?=
 =?utf-8?B?NWRWQ0cyY2hGQ3dULzZvYmNXaDhlYzNTS3RiU3NoZTA5UktQUFk4V3dxSjRk?=
 =?utf-8?B?VFQ0eFhOcHBpWXA4ZHBrRmN0YThYSENYZ2ltVTV4cmQ5N1VuWnpjMkhsQSt6?=
 =?utf-8?B?czRDd0J2dnVoUjFnNXVldU5RYkU4UGtEMndtVm9zbjJjMU1uZkpmQkhkM21R?=
 =?utf-8?B?OWQ4bm5va2ZWbjBlbk9nVHVlbWhFelhxRzZpNUdBdWNBbGxuUWZDMUpvb0ht?=
 =?utf-8?B?VXRQNFg4eUFHWUEvOHdSNHFkb2szR3pPelg5YUMwZ2FRbjRiQWp1RnFGRnI5?=
 =?utf-8?B?WlJsM2c5MHVrTDhocDZyYTU5UEpGMkgya3BBb3V0dHRPU1pjdmhmK1dNWEhK?=
 =?utf-8?B?RjFmaVNYT0xMVThPTWhIWWdBeE9uWUtkSTRzSVFZNytiQnY1MUoxUGQ3ZUFa?=
 =?utf-8?B?a1h6WThFSldjZ2hjejJTMHdTVlVkUkYrb0pSVDl0SkZFbEVncjJGTUt3bEpj?=
 =?utf-8?B?TjJDWWdFRTdZQi9sTlhHeENmT0NxYlUyOCtGMWJNSlMvcHBCRmRhU3E1eHVp?=
 =?utf-8?B?NkRpMmhCSnVVRVVGT1J4OUd1c2piNkdZRXdEd09jK050SW1DR1FyUCtOMXY2?=
 =?utf-8?B?WHVjdFFNSFM0Mnd6T1Q1NHdsdW9wWlJjTEVIR0ZXSFd1WlIwajJZdml4QnJF?=
 =?utf-8?B?RFViYzEzRFFjc1pYay95ekN5dEZvYUJlWm1qYVNPK2VRbFljemM4ZzhxRk1o?=
 =?utf-8?B?WkJ3MUI5WllXSmg3UUFCKzg4bXpvOGZRai9tQjNBN1p6bE9OVHErbGxCY3pG?=
 =?utf-8?B?Y0lJTUZKOWFGTjB5UDFDa0xKcE5RYVBwWEZkdG1tSytGSk9HTDJLdFA2b0wy?=
 =?utf-8?B?cExMODUzUS9LRXgrcWlyWThUOVBPOWV4ZUlSZWV2WXdiRUovSkJscFZiMk1B?=
 =?utf-8?B?WUJPVjQ1TGJRUlFnZWxFRU5RR3NvUkdMRHBadEtxTFQ1cFo1U0NiM1FraEo1?=
 =?utf-8?B?R2g3ZFp2SWJweFFMNThGMjBUM1VteWt5cmI4Q0JoUTJ2Ui8rTmMzakk3YTdG?=
 =?utf-8?B?eVYzQ2tBNUJFbjBIdmRKdnJvZU9xTGRraFVuMC9uZFJXOFJWYVhkMzVybmgx?=
 =?utf-8?B?R0p3S0NnQkJJbmRXUEkrdld1WS8wTFZvbmplYW9BeFV5c2hiREh2L3M5dm5l?=
 =?utf-8?B?K1cyczYxamFKeHhnL3B6LzlzOVl2eTE0L1ZOVHh0QVVSd1hTdzFoZDBWZWp0?=
 =?utf-8?Q?0uxMdI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:58:24.5889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3aaf47-fb7b-45ff-7b9d-08ddea312ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
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

Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves as a
CPU-visible IO page:

* amdgpu_evict_flags(): mark as unmovable
* amdgpu_res_cpu_visible(): consider CPU-visible
* amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
* amdgpu_ttm_io_mem_reserve(): program base/is_iomem/caching using
  the device's mmio_remap_* metadata
* amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
* amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type

v2:
- Drop HDP-specific comment; keep generic remap (Alex).

v3:
- Fix indentation in amdgpu_res_cpu_visible (Christian).
- Use adev->rmmio_remap.bus_addr for MMIO_REMAP bus/PFN calculations
  (Alex).

v4:
- Drop unnecessary (resource_size_t) casts in MMIO_REMAP io-mem paths
  (Alex)

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27ab4e754b2a..42f97d568059 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -123,6 +123,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_OA:
 	case AMDGPU_PL_DOORBELL:
+	case AMDGPU_PL_MMIO_REMAP:
 		placement->num_placement = 0;
 		return;
 
@@ -447,7 +448,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 		return false;
 
 	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
-	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL)
+	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL ||
+	    res->mem_type == AMDGPU_PL_MMIO_REMAP)
 		return true;
 
 	if (res->mem_type != TTM_PL_VRAM)
@@ -538,10 +540,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
 	    old_mem->mem_type == AMDGPU_PL_OA ||
 	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
+	    old_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
 	    new_mem->mem_type == AMDGPU_PL_OA ||
-	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
+	    new_mem->mem_type == AMDGPU_PL_DOORBELL ||
+	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
 		/* Nothing to save here */
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
@@ -629,6 +633,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		mem->bus.is_iomem = true;
 		mem->bus.caching = ttm_uncached;
 		break;
+	case AMDGPU_PL_MMIO_REMAP:
+		mem->bus.offset = mem->start << PAGE_SHIFT;
+		mem->bus.offset += adev->rmmio_remap.bus_addr;
+		mem->bus.is_iomem = true;
+		mem->bus.caching = ttm_uncached;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -646,6 +656,8 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 
 	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
 		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
+	else if (bo->resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return ((uint64_t)(adev->rmmio_remap.bus_addr + cursor.start)) >> PAGE_SHIFT;
 
 	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
 }
@@ -1355,7 +1367,8 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
 		    mem->mem_type == AMDGPU_PL_DOORBELL ||
-		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		    mem->mem_type == AMDGPU_PL_PREEMPT ||
+		    mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
 		if (ttm->caching == ttm_cached)
-- 
2.34.1

