Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF85606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e0JTjCfp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186FF1122D7;
	Thu, 22 Oct 2026 02:46:29 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EAF1122D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 02:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6J/cyTFyjuHYucNlVHtXnrv1mdiZ5t4lnjP/gWPOBvbN0jfFTlLBswho1Bp1CBHk1ieOB7L2IYpl/WngnEudl4LW0DujKFGjTv7MQmyfIouEIebSFmY1m951YbKdoNl1yLUTUigxzgSPQJk3SBU1y/s2quzyRZvDq3lQ5g/COLf2HL5PzJNV5nBJ21E7pa0kt9XW9xUOPfFvLAOasdyhN/vu3IHQETP1q0rCJ9b7BtQxyHRhxvSV7WNzdo66Fq1h2euVgfGdoyrzxBYnS38u0WoA57ZM/tQ3Z2/fhNvdiJxI07T+RwmAHgSLmFDQQIXgtHSNvgUoJlj395H88Msjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krnqfJDwl7MCh3jzkD08Rgpx7BOYI3WydbUJhZUl4Lc=;
 b=Cg3JrEzS3oYUbvpex0GCaqjQMLLc7LHsHI6MruMymVlEm6IiHZLEQomKm4JFDmOKyqxOTU5mq9bQBaK7jxtEeEq0Az/lriVVgQj0LKLVu2Rn+sc1N1BKRpnBYyDDA4spWyPI/aTt1pWpNQO+tn4Jj74nEvkb1GXeSSvo3Lt67Q51XcE8mqghcABzCo4s3s7BJuoLepPv1RND2wNgfPiIrr9uOPOhAVnf6TeMHHZTAHylKwu4p9e51Q32OJs6UI2GCleyyHh/kn54dWm2ALrTpoMycsO4zMywe0lQcpOC6HrcmvEb3BaKM6D+mzC4rXp478bkVL4QW7qD3P6S3sVU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krnqfJDwl7MCh3jzkD08Rgpx7BOYI3WydbUJhZUl4Lc=;
 b=e0JTjCfpt6ZuT+fO0lkph4EuSibU8JNtLQEcLPujxnsVSkd0jf227y5HbUal0L/zJJ/tLkWVFXwnRqAncpdm6REajajvm8Rl39JJH+R2dK65kcl9q5CnS67nfRQUrHBVZp/2JA71+I07uMzgGEbYFg+ReoAroPC96DAEALGs/is=
Received: from CH5PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:1ed::11)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 02:44:10 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7a) by CH5PR02CA0012.outlook.office365.com
 (2603:10b6:610:1ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 02:44:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 02:44:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 21:44:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 21:44:09 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 21:44:08 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: keep the CS user fence BO in GTT
Date: Thu, 22 Oct 2026 10:44:01 +0800
Message-ID: <20261022024407.4187271-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6013d3-7b2c-4dac-fa6a-08df2fe659b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261021123027099003|56012099006|11063799006|261009223027099003|10067099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: b+HAC51xzAWe0ZU4gIKkwvOBfzFbpkpC2ansDeb6gl4AhiJjx0QR6NJF1ib91hi3ul2VJeblKdt3YFMSGqW4Vz3hH/A0ae0x4IRGrJZ1b+JjY0p+upy7mcppIRHAQERSBwk1ZEEk+d0Z65MlYv1QzMki9voJpJ433vm4BsWK4EsjEFaQHaNKtL0AOg0q5z77ZJRm0RNnOU9q02vQ6D3Z3D+GGisbKq/vplx8TEok3z1+Y2sL67bFjKE3bQSFl7t3VpvH83W9UWmwK0FWGW2Bc8fbpigMnY/PajQAXtW5jQj/orTvcQCZEozhiOLVrou9yH4AyMN3uEfecB6P7zYry1l4ZAOgJpNV7L6wo5pM8G0RIGRBAPGrM87XQ3txxv9hZLcz/OP69HgbTP8QWvZcBrYz2cxL0z+sYqtdNucpgu+/lykQ5RZwEMwC9nkHAFUwL0+GXSgkrOem6DLFJrkRWYZX+z0/xZM5wJClglERj9LGR/yVNnAjsZ5wETCpWLQhEh9qYPINMjeQUYyQou5KsU4u+yXjauKY6vEmuqLU2LDbRftfJqkUFmMaj0q/lXfGVWli+kni2SWqajWJoQdpfQBLR6KhWma4Knde3uNLt8/k2tpQk25TQThis3BUKabSvBb+3cg8PTs/+1MF01JzAyCc80NZnhqAmcDK952y48kBK0bmKBHpCkknk3Rx6Qe225ehBU5c2RcDntj7EdEEfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4xgHoLBSxh7wJE9vavYZ9vuGNm/GXxogwRB3Ge2qeioFmHnB2p2WUyNyAoVMpQhPbkzDjeZ9GuCHkFwjMgvITFbjvuuRNZaWtFGiB42tj2Ww7mKT43ZJ90AmKtoPDll0jtU4UmOc3AuWQcfcZH/GRcHA5HHTblx4kGYD3x1DZhyH+FjXk8T95DqIrU8dcHn08AFbKEvpMq8Ei4836mu6dqxRxqRy/vwuKrvCG4IGUfUxNWhL8xNMsrbzYYdmUM2IpKDbnR2BaFqQAipAFccsq2nm8lZoEASP6lZ0qVX9OkOp/ZbfZ57Ykp/JaMNJbjR62fFQqQeQU02R6zAPX2zNpgSE0JT2SE9lnAdYn7Uc5J3+ToDzqxV64d3JOAHKjUeYSaUoywPgP5VHXmsB9SDfkN1p/8VNX0I0PX7ZYi2e3gkxGBcQOMny4lRMJ8qEHYvZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 02:44:10.3364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6013d3-7b2c-4dac-fa6a-08df2fe659b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Only take BOs which can't be anywhere else than in GTT as user fence,
which the CS then validates there along with its other BOs. While at it,
detect userptrs with amdgpu_ttm_tt_is_userptr(); amdgpu_ttm_tt_get_usermm()
returns NULL once the task which created the userptr is gone.

v2: only take BOs which can only be in GTT instead of special casing the
    user fence BO in the validation, use amdgpu_ttm_tt_is_userptr()
    (Christian)

Fixes: 1ea863fd736e ("drm/amdgpu: keep the prefered/allowed domains in the BO")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fa301c71b782..7db85de5de8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -150,7 +150,11 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	if (size != PAGE_SIZE || data->offset > (size - 8))
 		return -EINVAL;
 
-	if (amdgpu_ttm_tt_get_usermm(p->uf_bo->tbo.ttm))
+	if (amdgpu_ttm_tt_is_userptr(p->uf_bo->tbo.ttm))
+		return -EINVAL;
+
+	if (p->uf_bo->preferred_domains != AMDGPU_GEM_DOMAIN_GTT &&
+	    p->uf_bo->allowed_domains != AMDGPU_GEM_DOMAIN_GTT)
 		return -EINVAL;
 
 	*offset = data->offset;
-- 
2.50.1

