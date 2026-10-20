Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B660A2601
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DDMvFuW9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69DB10EB91;
	Tue, 20 Oct 2026 08:38:29 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B9D10EB7C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 08:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0ePpjF0T6D0N/AwBsY3U+g29Z1rbK5pLjoqz2MCJJ2Yp5SiWAcZrg9xpA4HJ3VRUMiIdaujeFZQmT12rZJBWmsM6EfSMx2Hxy7d/KqA12OT4eIo0B4pU9/FbMwg0KOXXR19AGLO05YbBeNxevmsw+2rj8rh9fRDzS0DI1uv9Uh0tdIkF6IGbvovsD8DVQC8V/9cesE1X5woWRoGxxciB1iNytpRKaSrxE3wvqYbEMPFA0NopJm/whilIcwz9f2yI9/JZ3MAvUy+HfC1BaHDJ9bvEVtC9dOGyhusmZ/4l0LrtBRUPrJqMy+iz2r0gumFRXpgFa67f2YF6w4XClTjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du6adTgCRCCqg5YfNVokdgDEw29DSxfBDsODm8PjcUc=;
 b=hZ6LlGZnkrcp3Z/rRvSqKegRBNnTadqI+imDSCpn0ueBvzw601EJ8/HkYQGdkdk4Vfo1yzxCnx26uw1BM/yP6WhFnu2JN5e5PhboK3H8GFqCBZokWZ34Lg8geUvVq1kNibEuK3K92MKXdXklxq8pgnG5/A7c0khVQzfTpAPZtOv6x3mmSmTmF6wvTq2gMKZFcbBtQMTyB4H1Q+B/tP1hq+IIwASGHVJJFBk5FHHNelNDwc5spm5DMQihfQKZnkLo/xsEA9HahDNd9T09wlfwmZDwy5Jv+oQ2LUke36AriH95DgHmX2GR8hbG50fgD6+wvK7bn9dh9DWsAICOJG8PfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du6adTgCRCCqg5YfNVokdgDEw29DSxfBDsODm8PjcUc=;
 b=DDMvFuW9+m3yNsNel/NLrr0Sx4vgIXHNVfVeA0Int+alDlMv1nqVUD21nF6FRwVc/m6SXwGiOaSepGCtliqq6mG0HQkKuiB8bqHqryAbTTB/7glybIoQZ94WBeoavPD9+7e4E9ZwCnH0RccfgLJuSRqHoWXkHg/nmyaTjLPk/zo=
Received: from SJ0PR05CA0141.namprd05.prod.outlook.com (2603:10b6:a03:33d::26)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 08:38:17 +0000
Received: from MWH0EPF000D894C.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::6) by SJ0PR05CA0141.outlook.office365.com
 (2603:10b6:a03:33d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 08:38:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894C.mail.protection.outlook.com (10.167.249.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 08:38:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 03:38:13 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 03:38:12 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: keep the CS user fence BO in GTT
Date: Tue, 20 Oct 2026 16:37:09 +0800
Message-ID: <20261020083804.2777099-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020083804.2777099-1-Jesse.Zhang@amd.com>
References: <20261020083804.2777099-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894C:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 9143cb8c-be0a-4f3a-92b2-08df2e857bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GdI5Zj7FYIsWxFfjKztghTIWM4syGGKusK9iqo8l9hbe7A4Z7Ex9flT+VEJKfDe7QPrKZUHhr0f5bsTZdGWilX9j5gRQhsWooQi3g/0GSJn/uKZP5Uabp7CRYN4oAr5D86eO1DeXPfIM/tgcE1QwDdHMlanTuM9HN+BIYqcy70h7tEWk2uqOjMviCCYnpe8I2AWsui9kps3vX0DpT+dz5DbEddbfdY8BP+XRgkEx2flEOSiWjblvN4Km1205Gj2iaeTaUpFaq5elXI4JWg71gJTCbLDcGemMN+tk2xjsayzZuRDW5EeQUN1kfCPCrwDuYJ5DQlK8vl045CG1ptcshXquBHFmYJTxwHBKaowZRfkwg/zRiGZIwWiCHwYLhXfkphvAhll2Vw8p2By4VzhwJuRsdhwGQXUO2tVUllMEhM2ODp6pHbapUi/ZILyezVPTNZ1sicmqkeq/ZYpADVU2iWJWIplIwXhRv0CKwyq4bd1dRq2UkPHY+cr+cnYXtPGCYfuIYCqse4j6qjyVge67TdcBwD/YiCh8EAwYr766BfVO38pDM3EWWgL2PeLDcb1PUoN3hxVj1tMjRKkuNtKzN6WEjHMrFBYGftWatkHeRwLE6UsvJthlWX5qCCLjfO2bAfRKdLdECazmdpBASwY3CggtEGRI+ceMntMBdkyVi0BoXZm+gADpXNzCvjyIPcdICPK4QHx8U1BHEhjvImGDIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vE/SVLW+XSOoQxtuCXZDK2lEsX8soTs3jp51GWL79Qc7vEqOH0yPLyVOn8Exk46oQd93jg1nOToQxfvp4ll/B8GlkVzI+pvdPM9Wma5QGXXaGTFX0j6lPerMEJ3nIeb2xsRu0Bh/rzU4UR/ldi892W9fzVimxqUAO9sgZphdRxJr+tjKgNkIg50pYOJ9kJJyt4T0aDbl9UrB6y17ELZ0uNgUoR+TuNTMZZI+ZZiEvODpKBrxNfNtFLEj047PZ3om3AaUXyIVKtW1cJPl5q+Ln/MakYkrOvzFJs3REDMfSjXfRiL8hiNrc1JzD+5W3OkuJxEt9glYRkSILhuz7GQhkHNn81Lo/0EMjyihQyB593It0oTWrKyChg4A/0Q4tyFkV2DmS6z8jLXJ0f3puybXfdjmZVeysY/T7BJ8vbkdwcpRkCqDpuIroERxbgh2MZ/V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:38:15.1228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9143cb8c-be0a-4f3a-92b2-08df2e857bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
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

