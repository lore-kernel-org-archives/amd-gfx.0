Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF5FC61DD3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 02:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4633A10E40B;
	Wed,  2 Sep 2026 02:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAIWtGXn";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B63C10E40B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 02:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEAx+V/PZh/zmwBgEcnB0gR4l2vEnK/lqSUlcsGvvreFT81uQ6aA5iSB+2+wjs3SMu1O0IPzIkRQIThLLJwVdImba46ebQ4JalTs2x/DMb+jOjnzEga8fY/SSidQSCZCJ5XL7qs4gMRJtnMHVHnd04YQRFdPl55DfZBayYq1RG0kHnZaNtkaAEWc9M8V+DpXGp0MVn0fy22XpfxVZsjh0pXd/VKYRdissIan3z73Xr47RSbU8zPFEHbaVPJ0w7mkJUfUg8YqRvRcPhzRQUMgECTPK52uX5EzW87SZQRGy5z3gLL/+AnsPeJtYKKqx+ktLcD9hNH4aBqddM9RrDxHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPjnhvP/BF9KWqeuo30Zg/lKBY7wxGwYBUIQlWmR1FA=;
 b=nAgK7o45vxeO6duLw1gVmjmclowvWPD+xfOnaCih29J+VaSUNaTkAK1IJq5NdtJf9IC/lM/uguQgxyE1fgCjla8SFSNeXWlwH3fdYM6O66routzhTwcGOxKEssAz+nyjtQ72qpTBUSFU6y8ZesDWfXWgRhHxbjAEH2d6TUoAXQA0x4IOibaHtKxCikF0IQm3I8XKnoMoOUfRP+vigu28mIcnL7n/p2632jET5ol28qY7UVyCkw0bSzgD/Hh0Ad5Y5J6b8yEcHl886RtS7IjOJQxrICf1RB2JqsBKDBgqKZ13K/0YQRiZ4H3ZDMp11dnUGr05IQdIyYuX0yTLj7DMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPjnhvP/BF9KWqeuo30Zg/lKBY7wxGwYBUIQlWmR1FA=;
 b=DAIWtGXnhO11yp6UQsafYimwW58RQrj+Itsiq4+o8gh+WBmWZkfwfCu4th5VEN6ZFFE9uM9NXmfVfTKUuuR2bjehbUo+p7lCUUg9LffVQFqMwaO3njo+riR3xQg5MIBcZu/gYhQiPOFQsWCmu0vUF7RtlZR049vQA4Yrr5MaS44=
Received: from BN9PR03CA0453.namprd03.prod.outlook.com (2603:10b6:408:139::8)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 02:51:00 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::2f) by BN9PR03CA0453.outlook.office365.com
 (2603:10b6:408:139::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 02:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 02:50:57 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 21:50:54 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: use set_page_dirty_lock() when unpinning userptr
 pages
Date: Wed, 2 Sep 2026 10:50:47 +0800
Message-ID: <20260902025047.698595-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa0837e-5d71-4700-5fb6-08df089d03af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hNctoSUx8zEbiuxdftFqQUw5TKCKvpBAhHgZWUhffwcN+++dZPcSi5vPeu3yiLd5DMmX5M7JGuKEZhjh0BnVQoznKfpVC4gaSYuA4NF16JRLeP7h5oZZ2KCS93tBpX4mPjghd1oxDxGIw2kX+UdEP7JPwHHIzpCPjZroj7WdNjpVuOd2mDwOWkqfJYcvJmSgiEF2d3VJQYcROeVqPp4JrcsXWemZ7i09TrButiCEDkIXYhRQPZBJQbS1vmZaBoAQe/w+o7acKhDkuSwe4rSv05mE5QDkc3nVrPp0dtpTOG8a6w4uYv/+1vCI0EYxVFFOywvxNSQCEN9urpTHla8p15oFi5YKUbNVoBPUsIDDJR9mXOC9Pxbzea5TMeGIrUDmPa1pw3D2P1vdoGYsY2m2jrEFUiLKD9cTvCd15zUkPZj6sjippxnOo56MVAi1RYJX0fBvpNNIuOmLvsDd7jwAQY+yHah2H+MkpHEjxeCXELvcoLLdsnWyYgacRqtCleZ4kF5Vxig67e3WMtPuOhBykskLkOzfYl3Yrk1RQeaFGtDSqLVyUChB546ta+fkxmapa8/ZeaB99Lb3mBdP/9kXPha8buOYANi/ROXYSB8fXdhQElM6JaUYizgMJ2GKJh/gcCGKnPfhlWoiK+Ji8/0o9MAG7lwntIGvNRHazv+Bsbb0gDesPI6a87GQ/WRIBGkFIIZRZT56fG4Vz8wUC9Z3rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JF/jbuTy/25mPFfPWXF5rS/zlXA9QkA/qcP+pGnfFiB2r6pcXRDaxZ+vuEWU+HtsKd1iM6RTpS+R933daqBPtUtsup+vLVbRAl2bJJPKnWkrz8yiVeThDHS1mDdxMmxZQf/fZ4QnAXBajLMGyODhKquXgOTzzD4yra/OAoaRSpQsmyCb9zE8VVCZTjwogGxm9A/vfedTURlAHbiq0DKB065TVFGeB4ZQIBbl8sdp4mw6qWHESIGSpdKXcV0UiZDIlJ4yMX3diMuRZ+ufHZcXeMPcwK6mVlXO1TNN38SDfa9Mkf5VDsPy+6DIkM95TKaIzoRZWr6ZyLICQ8Lgyj0qcShU3/xYTd22MVMXYG9Kc8IQSO2x3HhP1Fdwi9qD2Pwsl4ZMocHzlMscJ8fVNNKhg/OODDmTwK4oG2o/nJtPgw9jPgAzy5+a0ul53mIDrscM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:50:57.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa0837e-5d71-4700-5fb6-08df089d03af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
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

amdgpu_ttm_tt_mark_user_pages() dirties pages obtained from
get_user_pages() while holding only a page reference - no page lock, no
page table lock.  set_page_dirty() requires the caller to keep the folio
from being truncated, otherwise the address_space can be freed between
the folio_mapping() load and the ->dirty_folio() call.

Use set_page_dirty_lock(), which takes the folio lock around the update.
The upstream gup helper unpin_user_pages_dirty_lock() does the same for
this reason.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 07f8854bc80c..4bc6ba074c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -971,8 +971,9 @@ void amdgpu_ttm_tt_mark_user_pages(struct ttm_tt *ttm)
 		if (!page)
 			continue;
 
+		/* The caller does not hold the page lock. */
 		if (!(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY))
-			set_page_dirty(page);
+			set_page_dirty_lock(page);
 
 		mark_page_accessed(page);
 	}
-- 
2.34.1

