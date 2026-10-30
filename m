Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32251606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0QVy0yt3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E7210E884;
	Fri, 30 Oct 2026 09:03:01 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE6910E884
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 09:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5EnfL+Pr6C0Q+q6Q3ZkV9F0pZDlEJJ0Sl9cfpjjP4ti2UWO7UVMD4/a0TSNO+x2AfnghR0z5DPS76OHyQvsSVn2mMEl6yF+ONRtOlEstdU2CIDqhTov7g9EJo91SnRGVF8poRFYi9bx/ANVjDKGYhwEFvmHYPnasAknVEzvtAWcj32q6QNDJMxJT17FyYe7chCFrY0Kpt+LgCLhpAqAp4sMex1lhH5h+L/KQfAVjC9hyBoTM29m5i0DEboehFXcnd7gPsRqa85YGGW3mejZAriyvWsyq8ICbJgmSpsPtdLjLq5t+pfChlXKfTPyUP6TcJisa4QkKaZJq6QXWuwZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhPorZPE+aukHMrOmdYf2JIJy+DSxXpWpQIajllLcW4=;
 b=S1B2y/BCO+/E8CA7o9Gn+MMeYOuQNSBjXR7s5JKAJZSUtLwcOWU0T6nTSusK1VY5kleezghUSpFZBI5/NsvFlO9XzvpvrZP/2x6V6ZKHs2ensDVbu/1eDRCJfwKTMRaF8NWLwuRhm0VGHCxeveu2kYZogTwtgoOLnBK1XoF1T75z47lD0STsw2vHOPo/iG40aeqzK0iPjnKxq6c+EktOeWwkEXD/JNGseKaOkvt3uTHmCjPgQstdoJ3+jy2uaWdxf1UHXk2Enlxuo9vGelX7aIT+ptV/7au1yW7Ntp2hdsfwzlfMC05Q/sCUKndeZHmPQyIQd9AUJjp2Gd/XKyHndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhPorZPE+aukHMrOmdYf2JIJy+DSxXpWpQIajllLcW4=;
 b=0QVy0yt3Poz/NTx5+Al+Okh1a3Un9yjJPdIBLougKvjh4Tk1wrNqbzwaz+uIfvtT4Bbcp7jEpctH5ZXdljEpevIs1A8DG5TTOMS1ie6UI2tFHsAu53rhdNKZaZgwE66OpVMtwTfw9xiFESR7wr0LYDgWPhWt0O0eYq+8Rxti8V4=
Received: from SJ0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:a03:33e::11)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:00:50 +0000
Received: from MW2PEPF00014676.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::42) by SJ0PR03CA0036.outlook.office365.com
 (2603:10b6:a03:33e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 09:00:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW2PEPF00014676.mail.protection.outlook.com (10.167.249.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 09:00:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 04:00:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 04:00:48 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 04:00:46 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Prike Liang <prike.liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/gfx12: program the SPM VMID once the RLC
 runs
Date: Fri, 30 Oct 2026 16:59:25 +0800
Message-ID: <20261030090043.652799-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030090043.652799-1-Jesse.Zhang@amd.com>
References: <20261030090043.652799-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014676:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: f06f5e8d-6ad6-49b2-092c-08df36644b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|5023799004|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5kbxE3CmD4ELpowGwFcYB/GMiOhpQ1axqPvM8vDfVEb72b94MvYSA22xXvG/JpZuY0j2lcgp+cdlyonPul/lC0TBvjx+lELrLL3A65ZY0TbGje7EJ4EVj2AZwWmj1dKUspDFkCCYMvpd22F8NaTVTqylNku/pADTPnhhfezW0uwYwTMlcOEUb96+vZtnQZfuraeSoYl3o6lGcNm6KXFMvo4UbFQRWwDRHQr3RlgIYDM6sY+g8nI+5SmH5XtRAb7eNRDHA++sqZk+e+E69RTbOLKmnhiesfJspRJXeTym9AMfouQsUtq6Sz2KJ58bO3DSeRFB6SNeSpFp4AYuiuPK4i2Ctobx++K41fGsnyXzd7dLXiwL23nrtNrVr0lWXyne01bgGDkLIL19DuwpSYHclPMft9PQnv41fyO+OFCq+ajejpCRzC4qcV9oHUXEWguXTW/8yBTkg3WEg67OPi3OOD3neO7Cd62ySflac/JffxqNwABCxmZOstPG7znUOJzBe5QmPd0hwugY3Dt3KYlT2fQtmygr1s0Y0UBA1KmYblXWG0o//kNIhNvVDTMCvyLM4Z6g4gEf2S+tbjt9tsQaPfhS8dTwlloehnUm6c5hVYkaehvAwUNiskLGlm915BGBVz9AjqPoXOxDUb1yzNy0PlHzA4k6AmNgBtoaN9yrVLfR06fouQqD1eTAVibtvwL9fKxrsJD6cviX1HyxGMJmug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(5023799004)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NrFfhHLzgxaMnYZd+7H0y2pJfhdR43o13r6tkclQTxDWT9bF127oIQKwlQXou83l4/eEcRfPw2dLnftMA95WWdzSykvJ+ncqLNq+aS6i29a8A5DcLZwS24vo1jP3+nUMDULDoGkaPMeRSiiCsC0j3GxSHE1IziRQQnp/xAbkGZyyofVHw0pkhRHCKwd+xD0/RG+QkXZcdQGSLgxNO9jkdQ42KVJxsLO+DuB7xfOSpHJ3pd/7w1nHtkzCuP/EvNobMXiHlnujR96bWBJplq2OOUk1fAADADVw2+6WjfFlRj+a0cRBvy4k6T6g9vn7oyCITGJFMBPvhH5Ru2xJnB465FP+oG9wLx5zzhyFXQ9481DBZET5uQk++J3O3AfSS6ydzmREaTrNkx7BXvj9vqwUJORFs0i76gt/ZdUmBili+hmAAq4+MfCwThGJhtkuxvnF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:00:49.5457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06f5e8d-6ad6-49b2-092c-08df36644b3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014676.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
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

GFX12 programs the SPM VMID into RLC_SPM_MC_CNTL only in
gfx_v12_0_rlc_init(), which runs during sw_init, before hw_init starts the
RLC. The RLC comes up with the register cleared, and nothing programs it
again after a GPU reset or a resume either. Until commit 38e07c072833
("drm/amdgpu: remove the now-redundant runtime SPM VMID update") the
update on submission covered that up; since then a process which reserved
the VMID for SPM never gets it. GFX9 and GFX10 program it in the RLC
resume instead.

On navi48 with GFXOFF disabled, reading the register and a COPY_DATA of it
from a job of a process with a reserved VMID:

                   before       after
  load:            0x00000000   0x0000000f
  after GPU reset: 0x00000000   0x0000000f
  after S3:        0x00000000   0x0000000f

  $ amd_pmc --run-subtest reserved-vmid-spm-vmid
  RLC_SPM_MC_CNTL in the job: 0x00000000
  Subtest reserved-vmid-spm-vmid: FAIL

Program it at the end of the RLC resume, which runs on hw_init, GPU reset
and resume, like GFX9 and GFX10 do, and call the gfx function directly
instead of going through the update_spm_vmid() callback.

This doesn't cover GFXOFF, the RLC doesn't save and restore
RLC_SPM_MC_CNTL over it.

v2: new patch, split the init ordering out of the GFXOFF issue

Fixes: 38e07c072833 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 336eee54d63a..8ce56b1b7b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -286,6 +286,8 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   bool all_hub, uint8_t dst_sel);
 static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+				      unsigned int vmid);
 static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
@@ -771,10 +773,6 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
-
 	return 0;
 }
 
@@ -2143,6 +2141,12 @@ static int gfx_v12_0_rlc_resume(struct amdgpu_device *adev)
 		adev->gfx.rlc.funcs->start(adev);
 	}
 
+	/*
+	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
+	 * once it runs, also after a GPU reset or a resume.
+	 */
+	gfx_v12_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+
 	return 0;
 }
 
-- 
2.50.1

