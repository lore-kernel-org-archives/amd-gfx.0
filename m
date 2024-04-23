Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66001C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA571133A4;
	Tue, 23 Apr 2024 13:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wbv2p1Tq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 262A11133A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcZaBWleEzGrooO+U/7ipoJqYIH0ZKu3QD+i7rCae4KDPRCJP3VUSh2abzIl0U5skMpbRhZBgOWg6vTpWecZM289fgxZZdLgFKcr/f9CdHGhHdmWtMU2UvES7FlE3dX2ZzPYr/RrHgx9YhDvUou+5bF2gnD5g2+Y8WO6Ksak77ExPGTXfbzk4dGFzBOTilG2X5JNZTbVwlobMH4itHPK3ley/StpE4A8yGvTQVfbK9ZiZnubqaVnE9VLKTqJm7/S/Uzne0V/RsoxU/qjcXGDkY0p24dymSf3vaQrdYBCYcdXyIRm/J0FLzK9THlzA3BugqRePoHxxhVV2y6+VzQ6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzch0u06xpcIAUG9H3pf2JPcuoFEYsk9SJ6dDRpewnQ=;
 b=oSwld/EjIWyEPE52v94FfSBwKBe3OPolbcgZa8T1/0QWDeBnXE/+JrdNkSvvhSDXoW6lRKCsudE9IZGPMR6ie/LiP3MJf//TtcubceH8cd0T3ATYPp6nt5QjQHN/2P9SEfcBORIzTXInKt57eZnMZ7+TR9cdXfCjIf1Aj0uQcBEBcKhEdXQ/4ne4DfGQx6VFAfEtAxEkijvn7bSSSsAEIHCeIm0XNP+51aDagG1uhmVxQtSsbyOZFs9k4UeO81gLxDOg4MFwCqlhbL7CWShcNWrMwi1LjaTjT6gbDjlRLB8LUOBmcB6dq5zfApQLLEo94IJgv4fxqlZneMqL33pI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzch0u06xpcIAUG9H3pf2JPcuoFEYsk9SJ6dDRpewnQ=;
 b=Wbv2p1Tq534J8ARIw7zijhQKYTstAKJViLGWvY+TQcETGs2lqM31wQ4KFw8AvzGv8wr4y9o0F087vo/5AsMIVye2lHJilsvhWk8QO2KeNkhNvQwvOK6SB+eApe+9ZApJx4qmkxEgn/e3CToMr9r/rJ+9aS+VZc7Cq1N9BonCawU=
Received: from CH2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610::34) by
 PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:05:48 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::6d) by CH2PR05CA0021.outlook.office365.com
 (2603:10b6:610::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 13:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 23 Apr 2024 13:05:48 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 08:05:40 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v4 3/7] drm/amdgpu: Evict BOs from same process for contiguous
 allocation
Date: Tue, 23 Apr 2024 09:04:46 -0400
Message-ID: <20240423130450.25200-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423130450.25200-1-Philip.Yang@amd.com>
References: <20240423130450.25200-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 1124f2ba-850d-4bdd-d7d0-08dc63961829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zxD9hD3cNlq1yQnk36BcV3sADgHxlempJ40/hu3ZaPwhy8H/7r8dERpGzG+5?=
 =?us-ascii?Q?5f1uo8l9oDTDUbX/P3X6W2AUbFIcdSRnc81MIMcpNh6aMBtyVwF6XQKuxXE+?=
 =?us-ascii?Q?DanzDZQNDvBd9ssxL2XlMg4EL6fbx+zHT67hYAWxWaQb55OFYKZM4jbJuzla?=
 =?us-ascii?Q?nqKzlPlWZaOj76zCezZTa1TvFG3y3PRDqHBBDgDF7O2trTPTnmWXuAKzK/pI?=
 =?us-ascii?Q?hlC5fVF/w1XJWEyyyxGkiXm5B+FT3OrUJeqE5jRGMjtBsVhCGTtCWMkJYRUP?=
 =?us-ascii?Q?/a8EI0w1IfuqDyKE4VEOAkbCJpLLWWTE4uymoO0UgYEwJfMtBWd4l1idW0Gt?=
 =?us-ascii?Q?nNBIE2KAQrqB1bcZHMTBBfHjoumxHFjpjSonsQr+SHMawiMFHHP9oTjBizs1?=
 =?us-ascii?Q?RnRxOyIllVG9/jJ5AcbLGjpGQmcrWfmGgn7kbJo82zlQRv5n0h3a0R0h2ure?=
 =?us-ascii?Q?PJk9s3DvZrxe34yADN/6v8mKNnp7H4tcQ6ouB2ho6TX/Tes2POpweCYGzEq4?=
 =?us-ascii?Q?ZVYk6OZuFTdHUXTgBEaSPwju4N1nVajdgEmXr8Sis/sVg+ke5iTwjBOHFmLp?=
 =?us-ascii?Q?BhSMGKe6p182tD5nK8DNt9uJF4fwDCIrybmKRk5zQos8SclNxpQrYEehzqAn?=
 =?us-ascii?Q?R+r258c01yAewX03SryO2QBdnzz2okxiOI7oACRXPSF6nAPay3iqFoEuBuPo?=
 =?us-ascii?Q?WnH3d0bb32bhaQkfYENJT+SRvZWQQmZx46p8E53o6lGuysDST5vwkB6W65Og?=
 =?us-ascii?Q?dOqDmjrDsgsipXKXnnDJ6mcKXlk7h7HHhwa3b9lKIbN8LtSz/toWcpNXWYAZ?=
 =?us-ascii?Q?2J1tcKcTiMdGJOea5DTkbLjEb8M6MO1Cb0QYxqiWZUS1WIauEBxjtfIg2Ylp?=
 =?us-ascii?Q?s41USrB1hqXrswtmWRrdUqj/hhFVJRse6EBa9keXJFWtRyMSSypNRGoa5KvN?=
 =?us-ascii?Q?T4dO3ptE2vQq5bD36TkUECiKxMPYNFVvfd/XMQ7zuxUrx0VwJwAEEnM4L90k?=
 =?us-ascii?Q?KxhZ4evW2hw853zrCBUt21sgXIIvWIV4LWKmXoGCt3RntenQT8pM4ANfMnP0?=
 =?us-ascii?Q?G4E4FANtBZvkzn9iKNKf33rdEtdrVgkKviHSDnsjq+mNTeWSBjcbjBiG5F9h?=
 =?us-ascii?Q?fstwe7gD9cB+5Gk+DYKHvIl07nolwcqjB/vj2oF5SkHU8kBb4QuBt0NLgUH6?=
 =?us-ascii?Q?F/+LZmSx2KlWIjY66R9zzDa4N2EZGXC/FgGPeXw3y4cDl8WmQQTyslEGT8NE?=
 =?us-ascii?Q?thj/4+TlmZnkT4NHuE2rKeg6j3u+cIx3Tnqt4Rl/ABvmaoNGDPsx97b1lvUK?=
 =?us-ascii?Q?xBWZCwVAfN8DUUZTAozZhtyhxfDep6tN+Qs5PyJ50P/gM4TIduKC5ZB3R9GO?=
 =?us-ascii?Q?nM7SH3AqGzhTTXh+d3ZgrRsIxOfV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:05:48.0782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1124f2ba-850d-4bdd-d7d0-08dc63961829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
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

When TTM failed to alloc VRAM, TTM try evict BOs from VRAM to system
memory then retry the allocation, this skips the KFD BOs from the same
process because KFD require all BOs are resident for user queues.

If TTM with TTM_PL_FLAG_CONTIGUOUS flag to alloc contiguous VRAM, allow
TTM evict KFD BOs from the same process, this will evict the user queues
first, and restore the queues later after contiguous VRAM allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 851509c6e90e..c907d6005641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1398,7 +1398,8 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	 */
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
-		if (amdkfd_fence_check_mm(f, current->mm))
+		if (amdkfd_fence_check_mm(f, current->mm) &&
+		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
 			return false;
 	}
 
-- 
2.43.2

