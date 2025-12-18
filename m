Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42528D6E2B7
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 22:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB4E10EBCC;
	Thu, 18 Dec 2025 22:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TRI7Nxzk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E32D10EBCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 22:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oC+pdwjdo/iBsAHz3hrj7IbepkLfUuUqs0JkGlBllnSrEIy1arg9lncPPNMtboThKjHHyiGQeBiOJu0i+T4kunR5mvvNKjqoOxRn6Kya91mQsC8Fmu0hONemZuYDiLSPUfxHq0Fp+V1rpf1ymo3l4Qgke8cG2wMMzTaUI4YUcrpK6Dzqe2OTOzG8BOkznPS+H9r32q/b4GpVr4x0lh4h8QqRtpNPG7WCBj/h8zdMlDCcMZS6eMIT66n+hzKI9hgLS5krxP0iAg2NAZ4ydJ7RMZd6DXNQrBdLutEbB6MsKafGfqzhi/ogMtJIPJMnnoIVVA6oT/zBvEUs9r8G1yVtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6OkdSis1W0JJhLiDDp6bgjEIr9htQWXnY5ouaqYqSc=;
 b=TFUHfkytyCZmZHGKUMkHXiJWQJGuKJE8Gd0nArkCoOpOCTr93SzA7OPtk6t+XbUEHwO5UHWItlAGFml+mUtgV08N12/1F19Lwb5mMj+Tl4nnYPdP/HcVJTIgHCZYMDb2ktCIhkYGW/cxUUwB38ZHz4C/3nO7nOCUOzAmjdCpPDiGeh2pCW1FO/xIjjCBlc31uoCSGt/6b4n/toN5090o7C+7kia2KXb4Qh0omWzrCkOZhWPwrdlHDjDAil3YSiAekzaXdd7ZwW0wGgKj+uvkS2okGpkrqQ4rXFYPji+6wWDnktA6iY4JW/7p5nKWpp1QuI5zsb7VfZaZPtwEARDtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6OkdSis1W0JJhLiDDp6bgjEIr9htQWXnY5ouaqYqSc=;
 b=TRI7NxzkTz2Z8V5+PC8RjxVNs3aaHqzQOhUuo9F5aIREGDx75IduhbPNEUfdP9RxxolVnph06po/ijnKdytE7qLxFhnLLUOyhoIsOknfArv0jmpUENipaDLf2DzH+yhh2syoAQxCP1wY+7wL6JRmYr0wTrVoGIbAog33ebuXDIc=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 22:42:00 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::74) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 22:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 22:41:58 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 16:41:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: mark fences with errors before ring reset
Date: Thu, 18 Dec 2025 17:41:39 -0500
Message-ID: <20251218224141.5841-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218224141.5841-1-alexander.deucher@amd.com>
References: <20251218224141.5841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH1PR12MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3b43c4-af2f-46dc-9264-08de3e86a715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HgkpfqKhk0Sk8G/bBqAgm1uNQZ/ETD+DgIl7j2Xs5fj2A7NHa29knZMTRF3Q?=
 =?us-ascii?Q?K2Y8mDel37KDpPZIGQokzGQr+g7agoaXBL4w29o9v0cRhYGGJK5q9NWD8UlW?=
 =?us-ascii?Q?lA5nelgEWjp9f+jr7IMrUgPFDWKI5+C/FZwWvJwwbxCgbgHHaD9s8XDTik4h?=
 =?us-ascii?Q?9CT8my+8VG1QkcRE4Oq2ShJfWOVYD05KTCX7HdsNSfD7DarlEQtcUvtEToIz?=
 =?us-ascii?Q?Yxm9PHYXwJBLA+bQ6ilw7wMWvqHa7wn4hi5SvyN4Hqoi+FBRVthdJLnSPGYL?=
 =?us-ascii?Q?ln+xsidDjlMoKola2+duJ+YM85RGuZL3luCQjSBL9l8lbzGeLR1at1H3Qp42?=
 =?us-ascii?Q?ffNQHKZjo0ftdDnmkdQD4s/0b6NdXJ7bqXLVS5CjA3SKa/wiXtfw6WlA/9oH?=
 =?us-ascii?Q?q1sXMG2nm2cYyrZiUKtHW9kHXoWLh0g52R2Muha3Eh2O32EF5cVOw4EQNp+w?=
 =?us-ascii?Q?fXPxSJtrI1ngf+cr7zp1ZJluo0sgD7MnGwt8QFlz0fv7Y1XeEqNILUS9sh5c?=
 =?us-ascii?Q?j7o48fxcCNr5XRKBwvPI0HDKlk8qiZemwnjcBWulaS4cWYgH8RP2ZHCwFzfZ?=
 =?us-ascii?Q?DhM0usFL+STsgpKVC7zFFp2VirLHozwj3CH4sYeF2CrVfbEoplfWL/WOMZKx?=
 =?us-ascii?Q?fTq9HVVjVOGWBpKYkuDv3crtRGp0Z3UOlHYEriBO0Spl2tkofjHThmv4uuk0?=
 =?us-ascii?Q?dk0zLByikhLkhtjFTUEhvljjQDG3DbAPWF85dYQINxUTDvApqbiBHHC3k2SS?=
 =?us-ascii?Q?yQJCqGMmN85O7vjWBimI3Bsc9K7QDMxegd4s9dXppqkFrO47uL3f6IELSwQr?=
 =?us-ascii?Q?CJOmBn41ihMCeU6x0sJ+0mRZgnsDVyosFz/4SzqkRRnxOnnbQJ1lgxD3EOrT?=
 =?us-ascii?Q?NfZKA2aKAiAZcZiSZWNokwAfJVBsUbEja7zyQcqkAaWnYcGQqNVVHoMZZdeb?=
 =?us-ascii?Q?kFVCv0/aPQHFMSSnMiY8ZqGHa+c79MB2EJiC3cb6EdsDr53aMMhW80D/AOXW?=
 =?us-ascii?Q?q3hh22SROux3ePtihVp+/0krXbNv4rofHkKyWlWP8iBbnG+d2PsWwWzMprQx?=
 =?us-ascii?Q?b/Gyscj3gAP22sa4aHiu2Q9COGEFtuDKG3oy6K6DxjNfwvTeX0XMX8Ld7IeA?=
 =?us-ascii?Q?kISHcCtdwcSFsZNbzROq8bWh6X+36y//V+u33Ghx2Em1LzEgZ5lrHNKTs5s9?=
 =?us-ascii?Q?ji5sDFUUvj4BOEayOAHHtpBxWSqUetUtfDpmwnSD3eT4e33n7fGheBaX99nr?=
 =?us-ascii?Q?AdeCMzLE9Bo/J2D/hWJvNe75Q6Z7Fu/AreW0W7ZTe9THKqx7cTiSvr2NYAkz?=
 =?us-ascii?Q?nrRUo7c4fMvvwjpLdEA5yRWJhrZPI0OuTXo+Pail81BgcqV2AHWbG1pcACp1?=
 =?us-ascii?Q?kW/1sv5lLaJ7TAqRjTVIibDa90ctEavmuMkgZMmGS00H/f7TWzSH+2QvTypk?=
 =?us-ascii?Q?4xZfQu/fwREhnvBOQjg1SgneItiAycEalqeattkWHfbb3MDIfSZBcUbCqoYD?=
 =?us-ascii?Q?JoeFlLd3G5zR1pOmxqP9vGu00dzdJbBph3EUxjDaTPHT4s/n4TEZMZSHNYSU?=
 =?us-ascii?Q?eck0763q35rre9gUZB8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:41:58.1599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3b43c4-af2f-46dc-9264-08de3e86a715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672
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

Mark fences with errors before we reset the rings as
we may end up signalling fences as part of the reset
sequence.  The error needs to be set before the fence
is signalled.  On GC10 and newer, this isn't a problem
since we don't signal any fences.  On GC9, we need to
signal the fence after the reset to unblock the recovery
sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 600e6bb98af7a..5defdebd7091e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+	/* signal the guilty fence and set an error on all fences from the context */
+	if (guilty_fence)
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+
 }
 
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
@@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the guilty fence and set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-- 
2.52.0

