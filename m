Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BB6EC1E89
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 10:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C6110E871;
	Thu,  5 Feb 2026 10:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fW3ySjxd";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DE510E871
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 10:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8bacWnI3N9YRDkkYGPLbr/u5yfdSe4JauCuez6Ncz6o3j9uyBcdDuhNCr2HIoXcuLeaFAtbSgJAzPosrDW/07UyvgKzQs7/9lsSM0I9kI7jjnGHK/OD6E74SP5jzT5kLRwpCGGsWNfZdogQsJuSBJzYEAwTqNj4patpbXGAehIMcZp+/KP578F0OxVS6YkaIxZzGx+xa1g9JMqJM6PQiUfEMNbWB9Y1cO87loQBpPrt3gG6FCavbEUDJMdI7xzVIEIbx3VZ4AtJ6Y3OtcSh1AZoD7Dk2PFv/E8HajEciY7yLkdepuI6iTo/41kea3nxStX/AfAIXpamSJZwLKyWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG0PV2IEYuMvIy6aH3fPjsDDwrNVA8zNBz1+yfdCpU4=;
 b=cX4BiDQpA7XZyzqh7rEhghP1B4Y/HoQMLIGimfAE+xHM29CTW4y3y1DhkaGAZ8EKLQjvDQLpbnwled5CspVhyql2Q1trK2hJndM+1tM9nxV/pBa94+j37Ejw3/m53ZVp2Eg094gIFIkgp2nTFbxYTmLLGdsN2yLNK/wfYo3pwW6sOjwA/t1Svmu46ZoDoC/VPnxVP0TXsAZXnd/CuQOR1l7oEOuA1YKIxZ+2MKVdUgwLYvyBcOG4eiNlM0wGDraZBOf5j9iOTpmYCYYKBMsHs6ThnxjDtSmKerc87BK8dncKCAiZjA5NCuUH5loL0KOdoKE7jgNTjfeQLJf6N99MPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ursulin.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG0PV2IEYuMvIy6aH3fPjsDDwrNVA8zNBz1+yfdCpU4=;
 b=fW3ySjxdwQEhyYr0QilwumNeEaK1bQo96b6f0ULQgk8A4cMBnkj5u8GohBLjnjuLQBYsmJQvXD2Vh68J5l1SUsQCPTIqXAV3ybFgHWRBRk1Jw2dfmeo5siyINA5yiDFl4qTDJcbV05dL3YNEJhUxC9ney+Z65gCg7QwBNz/jwdU=
Received: from MN0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:530::15)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 10:00:22 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::dc) by MN0PR02CA0007.outlook.office365.com
 (2603:10b6:208:530::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 10:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 10:00:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 04:00:20 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: Tvrtko Ursulin <tursulin@ursulin.net>, <amd-gfx@lists.freedesktop.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/2] drm/gem: Document drm_gem_objects_lookup() failure
 semantics
Date: Thu, 5 Feb 2026 15:29:56 +0530
Message-ID: <20260205095957.278704-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205095957.278704-1-srinivasan.shanmugam@amd.com>
References: <20260205095957.278704-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 68086668-562b-46e1-da06-08de649d6069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUQxZzM3alo2Tm92bWtLR0djUXBwZTlzejZucS8xcksxMDdGbFhOVW1zb1pK?=
 =?utf-8?B?b2NZQkZIbmlrU3hHQTVGZzBuOVdpY1VaRE90aVRtZ2RPT09vMGpISUhmcVFO?=
 =?utf-8?B?bWUxWkRXN0VuOGV5QmNSNEdDa0ZBZzZTak5ZQ0diMXQzcnFMZTlwSFRNWDBn?=
 =?utf-8?B?Nk5MT082bk5VM1NiOTMwMFB3dEpUK3VQci82Q0hDbUd1dk1yeTdnV1RKMUh0?=
 =?utf-8?B?MHY0ZmgrZ3VuNGljcXlqaTltTmRDRkJCQTdpVG1rUXdZQVRZRzBYTkdvenRX?=
 =?utf-8?B?OGJWREVlY1RmRWlIQnZBYTF3aGhSN1RGVjZ2eVRheWZpaXJJUW9FZ3ExTW1x?=
 =?utf-8?B?ZU1OV2pSL280Rll5bU1CUFUwdWZocHlYMnhoeHh5dkg1ZXZyQ2l1L3FwVmpH?=
 =?utf-8?B?VDdNc0pKcTdtR2JNT28xYjhsUlhyRnZZeXB2a1pYbWxZRGVKOUpURXFHeGVQ?=
 =?utf-8?B?amdMeUk1alN2Q00xNGw4cDloZDVzOENSa1J2RWJxdVBCQ0JpeVVlTUVrbE5X?=
 =?utf-8?B?WkZnN256NGdlRFdvNlBVV0pUWUdmVVZMMTZ6cEx2YXV1eHFwUUVvdXB0eVZR?=
 =?utf-8?B?dDM5b0ZKaVJGR3cwUDRHSzJuLzF4dDN1NWtyUU5tY1ZGQVFNTnZWeC9pZzV4?=
 =?utf-8?B?Zzd3bHFhakZyeHcrTXFadUh4dlpYZU9RdnFQdUJaRDhkditVUVB6ODhZT1ZP?=
 =?utf-8?B?NFRBM2g5ek1vVHk4Q0w0Q1Rpc2NrSHhoQmNIWXc3d3hlaUxlQmlLOVhzZG5K?=
 =?utf-8?B?VVBXcS9tMzlHblozSGJmQUtpdUpySGRjODhnTnBIVkpmTTV5UFpzb3dxMWha?=
 =?utf-8?B?dnEvYXh1blVGeHpIZ280dVVEZFhNNy92OTRjakpWN3NFTXVyMGhGeWVRaFVi?=
 =?utf-8?B?azQ4NVhYbURlTnowZ2tsZGZNeXRLR0lpSlgyS3lKanBPenk5eGV3QklUckc3?=
 =?utf-8?B?cFJRUkNlcVZMa0prZ2crT0dKM3FHUnZnZnVrVFZsR0txNTJRb0xxMjkzNVB6?=
 =?utf-8?B?bUxHTVk2VnI1alBqdE43TnhGNDFGWkh4ME5xR0VQMHUvWDkyQmZTYmFwTlor?=
 =?utf-8?B?RVJPWmY5cjFobkgrT3N0Yi9XOEdwbkZjN3BjNGdlM0xiUDJrZ1lESVBPMHpm?=
 =?utf-8?B?Y0dEbWhFZS9FamxkSVM3VEhtMVF0R0RqRW8wYnVWS0RMMWttbGhjQU1lenZo?=
 =?utf-8?B?MEs0eUh6RVNQaUZqd1Y1S1Y2S2R6SDNhY2E1cFVrOFovV0hsN0xYNjQxMWlh?=
 =?utf-8?B?Mi93c0ozVlhMdXBKM1lTL0lsN1dvOXJ1TVJ6ejZqdjJaa0gwVEFyZHNTNVE5?=
 =?utf-8?B?UWptNTdzQk9aYXNGOFVCZ3FZZXdJci8wZmhPYnd6UXlReUhwNWJtZnR6d1pN?=
 =?utf-8?B?ZVRwSm9IekMxRnZ4OFgvT05Fcm9iL0x4LzdNSW8ydU5xZGs1TFVBRnNBY1o0?=
 =?utf-8?B?UHFHM3ZqbG1vWWxuSGR2V3BLMTVKcy9RbEIyTWNkbVlQSTZ4dkszU2YrUjVo?=
 =?utf-8?B?TExPbVBPQy9yY3AzVWJ5UVdvVUpCeEVLTExad2hSOEpheHlXQzVVVjhLL2pl?=
 =?utf-8?B?alkxSURyRzBmR2hhN1h4TWpSSzlvbUxQMDczbXZLWktVVURnODhzSEVBbmhY?=
 =?utf-8?B?SGlkZEZHRDdMdEt3c1V4M1BMWW1BRnlLenpBMFRTUTJuMm9sWXZFWDRYaFdV?=
 =?utf-8?B?TWx6MGZwc0FueWcwWElnZnRFWWVPbVBqOEdhdkdhdW1WTnpEcEt2TmxXbTdi?=
 =?utf-8?B?Slpsbnl3Sys5ekZqSEpxYlhZOEIzTEZ2VkM0S0JVZ3BucERNY1JQQWZLRnZ6?=
 =?utf-8?B?VE9LVzRFSlZhTllHaWllNGZTOFNVdWlsOVk3MHovaFM3RUJGclV6VFQvbFlU?=
 =?utf-8?B?V1o2dU93ajE0TElCTG1pdnYwR3V4ZUo1YVpwUzNOS0RHRGxnWENnQUtZUkZG?=
 =?utf-8?B?c1F5aXlKSVRrcFNkUGFUN29DK0VHdHlPeWZLZDhPdDd2anJyaFBWYTFsMitw?=
 =?utf-8?B?TElRUW05VXdOOXlENitxVytraDBpMk9NTkNLMlZZa21Wd2FHVUYzdHk5UzJm?=
 =?utf-8?B?L0ppbzZjNVdXRnRPam9DNXBOckNuSjVLU3VTK0paYzJlcGp6cVA5NUMzTkFq?=
 =?utf-8?B?RVJzSk9JTk5EL1lySGlzTjZlczAxVWRmV01OMlJGTENlbkYyVS9PVEI2WnQ0?=
 =?utf-8?B?MHZsQVI3dTBhOVJESm5RTDBDb1ltVVpIeXhISCt6SGFObXp6K3VKNkF4UFdh?=
 =?utf-8?B?UUpTenNlUUZaWGR3b085OUtHeHV3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xl4Ry5MBl5zjt46kYLbpIvsOsDtjSbpr6CQJxPrwUKzVsDO/Ib6qGFjfUPvZ43uInf7pau0lyWMSQIywXJfCNhKUx3xd73kimEcvlZhd11LbA+NEIgdDMbBz3r5Gm/FowC2Cl8bFe+qGKogJGl3++JfRKTtzeNEg8U7iI2hTwo0UgsvudUNiSMiUeawwc0Vg2y46TXUg9KkERyhlfHglvTdFtJI7yKjVSr34p0KP2VqHKP2VX2iIuaWHJKXMRxTi2mYf0p/tJTYsc444owyjZQv0IzPOMsqU/6yek+4HO2TkCIr9m42egT1wtuc1J+2qWQMGXajvTq1yyk0g6c343d9vzESQusuyyETGATESCeI0+FJr08sPnAxO6HRR00Cz93mQhCWZdfXDHmsZSK+/NPOApN0oBzZqjvhCFxyw/tMlQp6yA6DWK3cB4XsLnDky
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 10:00:22.3022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68086668-562b-46e1-da06-08de649d6069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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

drm_gem_objects_lookup() allocates the output array and may acquire
references on GEM objects before returning an error. In such cases the
array can be partially populated and relies on zero-initialization to
indicate which entries are valid.

This behavior is relied upon by existing callers, but is not documented
and can be easily misunderstood as automatic cleanup on failure.

Clarify the lifetime and error-handling semantics in the kerneldoc:
callers must drop any non-NULL object references and free the array even
when the function returns an error.

This is a documentation-only change and does not alter existing
behavior.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I2d1bdf3f319d841cb548cedc7b699bab9efeeed9
---
 drivers/gpu/drm/drm_gem.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index a1a9c828938b..0f8013b9377e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -775,10 +775,22 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
  * For a single handle lookup, use drm_gem_object_lookup().
  *
  * Returns:
- * @objs filled in with GEM object pointers. Returned GEM objects need to be
- * released with drm_gem_object_put(). -ENOENT is returned on a lookup
- * failure. 0 is returned on success.
- *
+ * On success, *@objs_out is set to an allocated array of @count pointers
+ * containing GEM objects. The caller must drop the references with
+ * drm_gem_object_put() and free the array with kvfree().
+ *
+ * Error handling and lifetime:
+ * drm_gem_objects_lookup() may allocate *@objs_out and acquire references on
+ * some objects before returning an error (e.g. copy_from_user() failure or
+ * a missing handle part-way through the lookup).
+ *
+ * In that case *@objs_out may be non-NULL and partially populated. The array
+ * is allocated zeroed, so unfilled entries are NULL. The caller must:
+ *   - drm_gem_object_put() any non-NULL entries in *@objs_out, and
+ *   - kvfree() the array itself.
+ *
+ * Callers that want automatic cleanup on failure should use
+ * drm_gem_objects_lookup_safe().
  */
 int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 			   int count, struct drm_gem_object ***objs_out)
-- 
2.34.1

