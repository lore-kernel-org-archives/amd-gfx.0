Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD63D3569F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 04:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9977210E7BF;
	Thu, 29 Jan 2026 04:35:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tyLE4/UT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E0810E7BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6gyHlmd+w9hVtSwKlCbnHDMfe+oWie3v8bbLKHybKDgPoTKa5w1fn3ZZZVfEibuupxQWMoQ0knkzEHApVN2A9zluT1Wr3X3SDouziQZzeyOU+7g4pePsMGPqaG5ENGDstjvI1UDeNeElJl5ltxzMgphBmJMSnUmjUieQuIFxWNQMXD8dtu1sUQhfsIIlMn5VQ00f4BotYCbvKxd68q4ZIW0J2NVsBQQtRngoFkmZFRO3uxKXs7VK9mlvIGa5OG7kspgv2ko/YmsOakKzaw/e2K9QOyX7IcwQvJR0eKvh9kAZDNZwN2++CFwTF6vciYOjd4SeikgC5QPuAdabJ4gCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wDDuKtBrzDHEB+HfdI1FkReMqS0VYdokQURMxei1fA=;
 b=Ak/lsbjpRyPXz+7xBPA3RfxUv04vmDd5wWBJHYbk9LnnKLeH9QkRsTGXuK960wpvSRcuuwdDerG2dCFlWu3ud9jxcC5lZMalSZr5Rijv3nYSjOMdHXuEOKcElnR0oLcShukLhT5Gp0RE6Oi/p03giNwvOZ3TTUZH8A5M1Wskzt5Qq0u7OOhgp/e+HCWYQpFAQ44NNeUOpXjge3MiS07+rbMI1ATlOxUrpTyE69dh5EsaTcXvSVVQhNsUXMcWpwovWdeksi+Y/JUiAjJ86TCJDDa5kTXRFP+rs+WBhRtp1ZgqpidFCs2DatGX5HZ69KwMCB3I3lY7FSTkUTm3oMzPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wDDuKtBrzDHEB+HfdI1FkReMqS0VYdokQURMxei1fA=;
 b=tyLE4/UTN5VFzp+QI5hzNBbuEToyiY/CMrXxLQUhDgNJm0yMvWEuQfusNbVMDZtwbGENlGiPkrwL3F8n7ZRKxsZfT00lnjPagZ+NgGZN+EAoP1SpeFG5rQiiofLPvMHRJhCKF2lPUO53vme/XhGw8ljcl5TBNrdm97nR94w/B0Y=
Received: from SJ0PR13CA0234.namprd13.prod.outlook.com (2603:10b6:a03:2c1::29)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 04:34:56 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::20) by SJ0PR13CA0234.outlook.office365.com
 (2603:10b6:a03:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Thu,
 29 Jan 2026 04:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 04:34:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 28 Jan
 2026 22:34:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Jan
 2026 22:34:54 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 22:34:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx10: fix wptr reset in KGQ init
Date: Wed, 28 Jan 2026 23:34:44 -0500
Message-ID: <20260129043446.33377-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b5a9b3-460e-4dae-c31d-08de5eefc121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJj6qE5X5vKRgl4SvfvZGTkv/qfwDCln9XWI+BeFW2zaaynvcGooq6SsfjEr?=
 =?us-ascii?Q?U33bMCJMd2UodlvWDJrqIbTZMfz7/HrOovms9nAkCKDaVq5fctalKkfRM6Km?=
 =?us-ascii?Q?tyUTPXEG+ka6yUFzqtcqJPihdbvaqjO+ES5rKfkmjFHeojLaMEoYx8b+2mHz?=
 =?us-ascii?Q?Gjm034i0XKGO2HmYqhnpIbYAAa1M+jdATwvzo48I/obZooZm46axpgIqBBC+?=
 =?us-ascii?Q?xaQ74qm2DmLoxYyA+um/mGjqfzYTRPSBCyRGlZX8X/akWZzI0J9bxVAanA7L?=
 =?us-ascii?Q?KsnEEc8SnPyw3ZmYxmF+90dWCrv1nMGYDF5YPi/qPinoXKxAjAG6IvaXd90J?=
 =?us-ascii?Q?FbJ3TuEPn0nGOqgX9ku0T+Pzl5wQ5CwvvbsIkrMJZe3H/RHCfSBpGQkd3KlD?=
 =?us-ascii?Q?iuHY6pBUPXUrXs2xWCLZIGthoY1oh2R/FpA30ctoCLN7l4KH+sgdtUHYZ3Hz?=
 =?us-ascii?Q?Z/1UO/3WEJpkNTnl/fLt/7WYeT91//J6gawKwOVud1mOFEWG0/iG5f4odn6C?=
 =?us-ascii?Q?ySpmRspoEcQ1svmcp2HbN68ChBuNkJjpjaE8U89HHw21/4qSw1qUbvoZf5J1?=
 =?us-ascii?Q?5aaP2Or3GLlmq+lz1x7IM+j2XOujwaCxMxr9e/XvlgskzOOQhbeofbD0gIJw?=
 =?us-ascii?Q?QHFm9jvMvccq15vStwlpzChq0mZf0YSTa8MLSklTrLsUrE9tGXVayhYRlv+E?=
 =?us-ascii?Q?LV7K3cuOJ2Np2LtKP9KwRh2VuxkE/ZIoqW/o0bZCArrGPFT4EVj0bk1suA3v?=
 =?us-ascii?Q?l0LhdL7y2+/16qUOSKKhKqRhZn6XwJLuOIwu3ZYrsR4ZbxlLSDG6fFVFcqin?=
 =?us-ascii?Q?qb4JZfUELqPpPtLTCObA78Dii/OXgh9JVePxazewzvLZtaOavI8yrUsssy4F?=
 =?us-ascii?Q?hJqg6vqm4aVTrHQkl+CTKqXgV8KsxP3ptxHSl5VD09hPf72hevtqZ/lCpu/3?=
 =?us-ascii?Q?voL5XBHCBw4qMrwJsBTyutormExoHG4wu8zI7pfZ0yJPSKdQ92m++whOaf5y?=
 =?us-ascii?Q?gaDQVPty4gulcWfTgvy+Ff27a/hCMHjZoJYeCTJ4xe0rk3e012POR0aGoRnF?=
 =?us-ascii?Q?9NRimGWV6YC8AB+Keso9qYIhgG9sYXqhO6J2VDVyWz6RLbJ1KUorSIp94chO?=
 =?us-ascii?Q?r0lQdkq4r8nAM69Bj7aeghO1AIVeuqopXCKXS8I4h3iA4xqGkGlKkne+xXnF?=
 =?us-ascii?Q?U4yeOrJNB5G5UbvyK4VDkf1hEqBsIwUGQeBvheqVidLvtDR+vKeWJ73AO6hR?=
 =?us-ascii?Q?2Yc298zPMyY87r/fT7ok/o+AMoHsBW3GZ8mv45aA89oxkaYBZXhT+sS8iUYV?=
 =?us-ascii?Q?6xU4IoiiWec0ryX5jFQWg1iTfog66jSx/wsw+a4OGgmey7z5csv3JfQ+XiXH?=
 =?us-ascii?Q?hM8V/OV2fwpZo8s5dtmANqccUeuOp6xocwElnnU5AefOCfpG0i/cQwjOReRT?=
 =?us-ascii?Q?7kiOI7plQzrCvJPPzWSLFLRCYoNkBPHc1miRkPhpFJy8+25JIa5OA1cYnq29?=
 =?us-ascii?Q?IdNQkY8MI6kIFpfBpmYBn5gxSDWhR5QEHTo4U3IlkIvV8zkdlppmWz1Utnyv?=
 =?us-ascii?Q?gpV0NoIVlF7rOnHwzj+/0NCqjth4I8VvQdg2ejwAYKVgpNknSBwJ5U03fhT5?=
 =?us-ascii?Q?sXSgHSR35xtFzTmtLcHdgVBYKUTj+3EwaYk6J+R/RNW955Qjc0gztb/6q+a/?=
 =?us-ascii?Q?9mGOvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 04:34:56.1372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b5a9b3-460e-4dae-c31d-08de5eefc121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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

wptr is a 64 bit value and we need to update the
full value, not just 32 bits. Align with what we
already do for KCQs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e9254ec3b6417..ef7d91a4437ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6883,7 +6883,7 @@ static int gfx_v10_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
-		*ring->wptr_cpu_addr = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
-- 
2.52.0

