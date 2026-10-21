Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7648606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WAvZSkBL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB5F10E02A;
	Wed, 21 Oct 2026 05:10:48 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A1810E2BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 05:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOe5JYxp3hRWElLkdItfMKZU542YNXISDhQetLmPY0EDd+BV01B7GuFGx53Wc8nWvv8iF1YAIbOl0pak+VXzzdS3ejdR/K05KpojX1GKLt6dPkbp+ocW+qoxQ6n4ZOgBhfWLfiQKk5M0X0/nmhAKJ1BIqbcV8V49oXvXLzuI2Qxhp7T0q0bPKm+WKTzp4tUzxzHQqONiSicKCsp+JOnCBoOoOll6xWY9Dt+WEAenyCNcr5QMq/yI1oL3syP3Pz4vxBA8+4jVYdtuDNYodUmTW4Y7I67iDCd4uNT4WMhceA9JD2IqJ+wZKk6WmWFCRGlZJRScPi/58qsEEb9GZAL9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du6adTgCRCCqg5YfNVokdgDEw29DSxfBDsODm8PjcUc=;
 b=Qg9ihCAqF6/CMsRT+HugWoTEmbfMGSmOfke6lbjZaxJ5bbXfs2ZqHaqXQc6CTvnrk9TCODTkuQ9skFXBKRSxXFoWs6Ltm5ddTrVv8rmHQcZw5TGYNgHfExp2OEgsnQUWnNzIRzRHmvcNJ8HLEn01o7KcVmgUiEuHoimumvGUXbaRXf2PdTUIYmSP1tUCW5utLtEExdpgdiRhcmMFWo7b4PNwuJkzBdt0FupeO5XWoLvrllvbVXe5+4xU0rXzKvoPRURyaw0SpN7BzdtSatca02hKuL1+lv+SzPlRhi0rRP6owe3nH8QUr1rDEDXvUa6eUNGfTuIgGxQ6E7PX6/lTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du6adTgCRCCqg5YfNVokdgDEw29DSxfBDsODm8PjcUc=;
 b=WAvZSkBL3UbyFmFlTH2sOVnAUrFa2DbMtNgYg+djkXLQYw/+eitmddWwWrvK7uVj+rKTq90mEvrOuQ7SXnEP13/zUQVy0oudz3+3uTaAtZ2g8noDdnyklQc7qABfsk7xl1ieKb/PV59jX/rAPy5sULDNp1y5CoBkx1IBJIMniWs=
Received: from CYZPR11CA0012.namprd11.prod.outlook.com (2603:10b6:930:8d::25)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:10:39 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:930:8d:cafe::66) by CYZPR11CA0012.outlook.office365.com
 (2603:10b6:930:8d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 05:10:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 05:10:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 00:10:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 00:10:37 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 00:10:36 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2 2/3] drm/amdgpu: keep the CS user fence BO in GTT
Date: Wed, 21 Oct 2026 13:09:58 +0800
Message-ID: <20261021051033.3287259-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261021051033.3287259-1-Jesse.Zhang@amd.com>
References: <20261021051033.3287259-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: f88b077a-9ead-4726-3bce-08df2f31a581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: HzdEkB/BVWe4TMwnMXVtxkMFS07V4kvnQHjYJeOU68zism2pW43ajmIYkagS74sSYIfYoaS0aY8ky8HWaebOiO9euRtWxzlOuLM5lkJH8qLy4DJkqr6QAwc3OhcTDQ0pi1Eep/alvBV/5E2KxzNMyyakVl3geLAYXv7sDlmydTSehD8CLmI0vK2+nmPzWCPwx8a7whNordr7P5ZU3XTV01kNrOgYn1Gno134Nr1w0lLRbeG8JInwGv8S/gZBpvj05HQKx/2aHAx2gDzZAJh8zrQ4kJbSK8WypTb2sm6Ps7e+0DUSOp6E8T5wW8KB2HLVCNHBpVAWFGUYZdyDGFvUwJtVKk10OjoXDGD8W8/Al6TrZAgjjsyrqB6HYdKQJg0SzjS7NyLkBx49dskFf3xbWaLb4iGwE9AE1NjgOawu60PCwTnhdgZcznpq61AGnIwcx+sn8dcrZ1Cwk4DzO2iwQB62T/FNGRHhMpGOLe1yyPxzOhYcH0eB53QnQ0hE7XVehgWKuMv9oooYqprp5xi/ayfKcPLCw0jAv9Z2cHhUrRbcP1t8Tbl5oeXaSESRzkRbouDa67fDKLxDuIvtZWkZ/NvQsUboxcRLewgs34504pTGlrLmivXcpbNOUmAiAmqYHmG+skO74VmWz8tqnWiN9T4zo4X3O5z0H6bKfrofFRKfVp9uP3eEfdxc3oR7NjHZKTS/MpwZnDIBf2F8nd6YsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A6DztWqEmqYCgD+tYcanWbVWpiB7Dh620HRgXlym0rM84FlpK9hKe6TD6xJvGFrFhMxooL7j2TKQblCr6Hth7LboxI3teJPX/1gFj1QShN/mgjHotrzJ9Eofs6sl6Gbr5Pf7AoGrSBNR+ARTGiSKoVEhPF2Qfgy2HALmxBNo4C459E+UrAzOVfjWofFAL8ukRC7tZ8lAJ4+jxCZKErwCu2ikivZOO4LraVK++2raETvn6QR7c/WGoO0wHW8pFhGS89guWR1yaFYLfUXMS/XG2U6EWN7PfOuQ68IZmTgk0lDmXnQVLPQhWrIDOsQYVCdTeXssgkH29k9PV9SrUgcDp5S7HIqkEpabVh0A98+vgIeE2YBzgbFixEZ6mtnHdNUpQRtxfFh7jkkcqhmCqQfKj/5x4ITKvahyaQ3CAI8QMXvzocW1jS73m3L9wfJLU6uy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:10:38.5895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88b077a-9ead-4726-3bce-08df2f31a581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CS ioctl hands the GPU the GART address of the user fence BO, but
since the BO keeps its own preferred and allowed domains, it no longer
makes sure the BO is in GTT. A user fence in a VRAM BO, which only needs
to be a page in size, gets its address from amdgpu_bo_gpu_offset(), which
warns about non-contiguous VRAM. On navi31, a CS with a user fence in a
4K VRAM BO, or in one created with AMDGPU_GEM_CREATE_VM_ALWAYS_VALID:

  WARNING: amdgpu_object.c:1531 at amdgpu_bo_gpu_offset+0x86/0xb0 [amdgpu], CPU#11: cs_gem_checks/18393
  RIP: 0010:amdgpu_bo_gpu_offset+0x86/0xb0 [amdgpu]
  Call Trace:
   <TASK>
   amdgpu_cs_parser_bos.isra.0+0x4eb/0x850 [amdgpu]
   amdgpu_cs_ioctl+0x97e/0x2510 [amdgpu]
   drm_ioctl_kernel+0xac/0x110 [drm]
   drm_ioctl+0x2c6/0x5b0 [drm]
   __x64_sys_ioctl+0xa0/0xf0
   do_syscall_64+0xa3/0x4d0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

and BOs which can't be in GTT at all, like GWS or OA ones of a page in
size, pass the checks as well.

Only take BOs which can be in GTT as user fence and validate them only
there, like before, along with the other BOs of the CS. Validate the
user fence BO explicitly as well, a per VM BO shares the reservation of
the root PD and so isn't one of the locked objects of the CS.

Fixes: 1ea863fd736e ("drm/amdgpu: keep the prefered/allowed domains in the BO")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index abd8a756779e..62758866378e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -153,6 +153,9 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	if (amdgpu_ttm_tt_get_usermm(p->uf_bo->tbo.ttm))
 		return -EINVAL;
 
+	if (!(p->uf_bo->allowed_domains & AMDGPU_GEM_DOMAIN_GTT))
+		return -EINVAL;
+
 	*offset = data->offset;
 	return 0;
 }
@@ -823,6 +826,14 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 	uint32_t domain;
 	int r;
 
+	/* The GPU writes the user fence through the GART */
+	if (bo == p->uf_bo) {
+		if (bo->tbo.pin_count)
+			return bo->tbo.resource->mem_type == TTM_PL_TT ? 0 : -EINVAL;
+		domain = AMDGPU_GEM_DOMAIN_GTT;
+		goto retry;
+	}
+
 	if (bo->tbo.pin_count)
 		return 0;
 
@@ -858,7 +869,8 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 	    amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 		p->bytes_moved_vis += ctx.bytes_moved;
 
-	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
+	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains &&
+	    bo != p->uf_bo) {
 		domain = bo->allowed_domains;
 		goto retry;
 	}
@@ -992,6 +1004,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	}
 
 	if (p->uf_bo) {
+		r = amdgpu_cs_bo_validate(p, p->uf_bo);
+		if (unlikely(r))
+			goto out_free_user_pages;
+
 		r = amdgpu_ttm_alloc_gart(&p->uf_bo->tbo);
 		if (unlikely(r))
 			goto out_free_user_pages;
-- 
2.50.1

