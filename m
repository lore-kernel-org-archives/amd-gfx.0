Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9400BC83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 07:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349F210E8AB;
	Thu, 24 Jul 2025 07:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TONDdRlK";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCB110E8AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 07:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrdzqrMw9sP6QNrqxdqcIO9URfYdsOoCa/f/ASESXiIME4bNMR+hl9goeTu7Dbd9tk2aN8tQuUVXMNGPgugZTWpWU22+Nmi2okLS97PlDc+QzvcYk16F9QKo+Dsebkcox07bz/ptKwX5+xqRODW8cqLip2KbFqUrAYiya45+csYgm75rCMKcBEhRkRpkZW3xLhYvRskOJqaah0Wk8GCrjyqQmKIp3buhStuxCVcpkcc9Ou7slmVWVbuSM3Z3wsWaDCPixGhPt8B7tyXRupmsGHflpV90B4uklSoJ4+v0E3kJ/VWwNvd2Xw6ntfTXJGngzvao2qXHdJrgo9A/4Sesuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xQt0CSsN3ty37Pi7wrwWhtEiIecR/CZeISQt1qGtnI=;
 b=KmZaQ/px7ZWY/jI5xEG/oRr4TIGRJrC4OsDydVi5SucT2zMDypMuc+RdWgrgkjMAx6oY+ifh7GNLzsaFlcOpkPq2a4Vf1iPoDzJl9tjvyMao1beVYgfZr1qNea0qDg2+jjqIJE+tvf3MiNvM+MKiapSvWCAXau7/hHCqlnVBH8pQ0JynN+wcJZoPJ02oZ0S206jmeQAt952VVvdM82Oi0EKKWe/is+pYui0BlwClf/XJlW/zc6dfZR8IvB1/uxamE0pf6Z4QMiQ3HRJfKMaDwEga4PtomfYWHUVd5T7qCy4t8rnDaWfeip71brHEKL92swng0VsrzXMmvjeeShq76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xQt0CSsN3ty37Pi7wrwWhtEiIecR/CZeISQt1qGtnI=;
 b=TONDdRlK5dq4lG37JEUfgJxnW8ySB+8N1g+ddF43vt4TTiFVcyomLDhawb3+n6YfJ2Dyc/w1zXG5Tkw6upl1azjfjx59NLwpL8V9wVtSNdsfuuvWFc2ruuqlB03OeHpJjh9eitT4C1YuL5MbEyj47xGUQnrO6pgIt+/ykX9C7RM=
Received: from SA0PR11CA0031.namprd11.prod.outlook.com (2603:10b6:806:d0::6)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Thu, 24 Jul
 2025 07:38:58 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::95) by SA0PR11CA0031.outlook.office365.com
 (2603:10b6:806:d0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 07:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 07:38:58 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 02:38:56 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix missing lock for cper.ring->rptr/wptr
 access
Date: Thu, 24 Jul 2025 15:38:46 +0800
Message-ID: <20250724073846.3991348-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c58e10-d779-4eb5-0e99-08ddca85269c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tGh41ldufyGRLP7IB1XcpC16CszBPr9+A1ZNbA59et2EKyoWqH/q5EP10yyq?=
 =?us-ascii?Q?TxLO6OqsvoC6+KPZ8Xd6G2Lau5nvLvMa4yLk671qp7DeiVnXM0a4h33YX9Yj?=
 =?us-ascii?Q?Cn3W8JCQh3q1bAnmYv9R+h6QKG5TL/OXDTfSOKLPHX91/VCgpMG9n0NRkziI?=
 =?us-ascii?Q?4YBVBbiJk2D5opofCzfx1tRODkY/Xe7OUyyS/PmRhKWvo7KE5Nzs6bIHBMMh?=
 =?us-ascii?Q?De4goWT/4VFhNibwL1UgHCpEK2r8bdjvkrhXUk9NLC6xfc2wUZbC65RV9ojV?=
 =?us-ascii?Q?C6++d1JSy3Nw7JpG+pBO0u9XBhYtWyLjJdkkXLUXmAZSMBhy1prdwkCv1qqo?=
 =?us-ascii?Q?ktKA8W1zT1s6mwwaaeUndHKnt1ergaMw3EZJkn/woQmXVyXqx7s6fX+WW75v?=
 =?us-ascii?Q?2wMcpMbYWwlVNLS+Jbh+YUUNWdYdrHVgkxkksnPvWMM6mwBRwxxGfuzgJn3X?=
 =?us-ascii?Q?Ls8wXquZVbJ8Tyjd7+fuv1XXsMm84tzeEum8nZThsmnlLtXPstpE7Ua7bkGU?=
 =?us-ascii?Q?iIp5nEBjHf2x+sCUi11hWaNQvjWA4b5hZM+O4l3+cNCGz1+sUSHHRwC6T31a?=
 =?us-ascii?Q?zYGXmzD1OhX9VY9jLE53Yt2MhbOUjbvE1cjhB+l1cdH9CyLJ7x1qOyip7jri?=
 =?us-ascii?Q?bzwMKJZsrYf2W8n1Cj+2/A6I4GFMRXhS4EcgEbW7Iuq4ibURLlY59BIMCCFm?=
 =?us-ascii?Q?186gngQTchGdQxrD8xd7RpjRO8WhVE+baPRzSssDVcKfTlfR7eKQ2Kfnzpen?=
 =?us-ascii?Q?PWUGrDlhHAu9JvKG3N8G7CZhcJ63UaBI9ScV7wEzcWSwBGxGV7vI33m3OXCQ?=
 =?us-ascii?Q?2gTQlZovobOoyPnRuJa7/Xu9VuSmi5MRDr7UjnC9ecokSoC5eH7ujQZcyx7U?=
 =?us-ascii?Q?RbNaEdFQPg2XA3x876OE5VEsyCqhlSSyZGzpYtBm6+5b3wJl8C1TKuXVdH4G?=
 =?us-ascii?Q?54VnFosXHeZP9NzKDVIvRauRH3nhUWE8f6dxssigwVAMXhwaVFsvyo25D6Go?=
 =?us-ascii?Q?C1yezBr3ogCGicb1YebuRQ61JUOlyxiVQgMv48q3UsoxnmIxnd0cQZcOliR/?=
 =?us-ascii?Q?BGhh4V5tC1gLDApAUvgVqeapAfku3g7UxD4qTGvRRqO28GS6vuKpuGvosZtI?=
 =?us-ascii?Q?Pme3nAeRtEJNw3Kcws1oNG8h55nbzHPHZHbHSiDE3uco5/G/FI7dnKa4gXv8?=
 =?us-ascii?Q?QU/FZ4bKMLLgNfCbkPP03x+/VABOM/j8ngmmVzgnD9JdqBI0KZBhRLJ/kuao?=
 =?us-ascii?Q?cmEJIAgQfEqKERWirB+RVt0ekyUdgWXot0dgJa8LHzot/EkYIA/7I/0W7rJu?=
 =?us-ascii?Q?J0+2azJRrs/A1newKw4fdNe+lOoD/jfsW5GeFE/vlgTGAyp65VtxUuvkUSDp?=
 =?us-ascii?Q?BhJP2nmjB90eg1YihCFSCvvI+j7kXw3WGRzYWuz5mHdM0GRZDUQYKZe9q8O+?=
 =?us-ascii?Q?fo56zxvafkhfsXvbv0wLdu66eckb6+HR0Im+71/pGalOUXmT1awET1UTM9Xx?=
 =?us-ascii?Q?FbF59AKXX5EhkcztikEvnaQNHycuikcoj5Hk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:38:58.3049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c58e10-d779-4eb5-0e99-08ddca85269c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
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

Add lock protection for 'ring->wptr'/'ring->rptr' to ensure the correct execution.

Fixes: 8652920d2c00 ("drm/amdgpu: add mutex lock for cper ring")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 15dde1f50328..25252231a68a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -459,7 +459,7 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring, u64 pos)
 
 void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 {
-	u64 pos, wptr_old, rptr = *ring->rptr_cpu_addr & ring->ptr_mask;
+	u64 pos, wptr_old, rptr;
 	int rec_cnt_dw = count >> 2;
 	u32 chunk, ent_sz;
 	u8 *s = (u8 *)src;
@@ -472,9 +472,11 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int count)
 		return;
 	}
 
+	mutex_lock(&ring->adev->cper.ring_lock);
+
 	wptr_old = ring->wptr;
+	rptr = *ring->rptr_cpu_addr & ring->ptr_mask;
 
-	mutex_lock(&ring->adev->cper.ring_lock);
 	while (count) {
 		ent_sz = amdgpu_cper_ring_get_ent_sz(ring, ring->wptr);
 		chunk = umin(ent_sz, count);
-- 
2.34.1

