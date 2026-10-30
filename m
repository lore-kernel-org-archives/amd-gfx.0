Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB26606A31F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fEtYurHE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875D81126A3;
	Fri, 30 Oct 2026 09:01:00 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFF71126A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 09:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGsG/Bvl33qqAOtH0QYj+rp4UjuQll4ZxrvM+r02bToMC3GwAnw8gqUzFkQnlrbIjqElD8kxUOh5dSkJ677KbnUaz89DIlJTIEuRtHHbmmMnRPuyeTKfkcYfhcKYOPcDIQF0hjrOoXzlQdkyEgwQfyZUUgfUnD2qg/H93ME27NviomtHGKjxqASCTYhfQnLWureDx6crEmLlAhLXEIIVSAcSTXRo3qYSt3cbBgOgAJF4UGS8e7QeHWmshASLxk3zZ8Q/x0imDeTEfd7tNd+pFIDE7h9u8CNUtYDh73rc2FmFkQ8evHdw3AfeJ4Mrow+YYIuABsR4ejS35ZspM83EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1dzHm810uiJsqQlaXcLNECc3DrFKHZzp2z4gjvvKp0=;
 b=TOzdxI10Xv+UMCIphwurbgZvW3WI4hSk9MTnvAkw9XLveurpo/fJsZfz7q3cm0pJ8lEdNRtk2HOqriNK7hkUwQVbX1fN8fYd4vLspGoymf0TPI0y8vZelID2yZzP200qKS0+QO0oomD2n97si4bZhdQAuknPCCigRH7zegQHnT7WOAF/y2/a0OgrO/5FmNEJrHQ62eZLTGZIKJtcUM7ruVz78I19BG81qhdG4aMY+Ep1hCxVN1Yhm2vbULkHHDGmiflSkKYs0a/mpHL5FurZ+yeFJXuzZ/DGxhGMD4YkfrzcuAEYp+yvZn3XdqO4sW8YEU6LKmjrcqgp8qGinucw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1dzHm810uiJsqQlaXcLNECc3DrFKHZzp2z4gjvvKp0=;
 b=fEtYurHEek7cOL+pqMm8fhck/gb9EJOVTP+HTPY6/sVSwC0zNkL3q0hmDxqpgj5RJu4L+vKbC+douYfwROfHOALidOjLasVBmaS5qb9QD4zVO5o9h4RwqOXlgkKCFLZmpnVGh7RZC4ejLl8du18MS3eINThvYw4paisCLb8EyKQ=
Received: from SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.10; Fri, 30 Oct 2026 09:00:49 +0000
Received: from MW2PEPF00014676.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::49) by SJ0PR03CA0053.outlook.office365.com
 (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 09:00:48 +0000
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
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 09:00:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 04:00:46 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 04:00:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Prike Liang <prike.liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/gfx11: program the SPM VMID once the RLC
 runs
Date: Fri, 30 Oct 2026 16:59:24 +0800
Message-ID: <20261030090043.652799-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014676:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c67170-0839-4c64-b480-08df36644a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|56012099006|11063799006|5023799004|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ryBGhO2Pmv1s4FA5obpF8kjcwUutSUVoy5dkfQLPFLRTIIqFogozN+3lxwYykiRmv14B80ayO9oy6Gcz3yoANahrk0lmdKfWxAKG5eYduxXg+vF0zb71UAPtdaqu4MUE8E2sWnUejTlvoVGnVJaaWtnQBQVsiiVczEdGfzVrhCMKmQeB84BIEWu/R13aNtO4u60+KS4O+ymz0ant9h+xJRu+HSHJJzs38OzN6i/huCewx4VgpaVnnXy5/H6uFqFaoIT/HwB1F4t/gEH8EE+q5UUVBhkIR3nJhfWKHxYEJB/p4pFp48Dkk9yyi4XtOxIRLaHGY7xGqBWRbHW0PNDc6WWDcCqWpdsJpB85uQYEc/5LciZ71TnA16MjTXVWjKB21FJcQH/qdClo0NkwKYXfIS1FcUAc+oN01Y59+mDBV8jPo+xTIAEvzzaGDkAeq+5iFKi4TuuPCJs9yEoaxPbBkvn7LXee9Mkefph3dcO8Ax4UA/b1a6CdYTXMnWja8Gk76G8Xbfv7fqEtXsBUxlIX1uokd/8dfROYw1TYuwlfDAKIAQWEvg71FW0pWhtcUPJFCsguhZcZr3arodb58ufOJRzgndt3bNXj7JfUI+fMsOfBA/F6gNJ6DxMH5CZVFs6C+OSRaXGMhSW7I7i4QS88fSx4r+NZPsKwMrFtc2E2FEWXllcAxKPhgYfzxsu1yrEMawhzjrRk+4lUDJOf66QTBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(56012099006)(11063799006)(5023799004)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ozh69I6gTegrgcrUN4VugvJZPFRwPDDqUTFeEHDpjeegkln4jAr4ipg5O7K7pIfskFTlyCxnJdnv01DI03bPkuojRmx7Dn4GWVsaLQDqyYufhoaQeGRus+j/AJuDo6HaKyeKM+ta45F35JdhOS9c81NWa/8RxAobumlS5uMV2JNnuf59b3P3KpgCgkcNsGqCY0w0lVYjgIaiT726ICPkc3VbKX6vTxNxv8T8VkTX8/etdMf3nIKfveM8t3T+NjWUcfVC74cNSBZ55UmCdBYpEWaoDs2drbPLp9umYfqs8tty7JTTi758lz1Cx8jhbz/ni+QZRyGg2Z5gRIe+aK18AxEAJn5Y+zhDkIQMvqWgfodbQxL6lBBhV6DGJacnA8QWX7NNfjqR9nOU1oYTKFU9ENPWUsR4vM1Sd2T0OAqHBuehj72G8+0KVL0mGD+QrOSM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:00:47.9583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c67170-0839-4c64-b480-08df36644a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014676.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

GFX11 programs the SPM VMID into RLC_SPM_MC_CNTL only in
gfx_v11_0_rlc_init(), which runs during sw_init, before hw_init starts the
RLC. The RLC comes up with the register cleared, and nothing programs it
again after a GPU reset or a resume either. Until commit 38e07c072833
("drm/amdgpu: remove the now-redundant runtime SPM VMID update") the
update on submission covered that up; since then a process which reserved
the VMID for SPM never gets it. GFX9 and GFX10 program it in the RLC
resume instead.

Program it at the end of the RLC resume, which runs on hw_init, GPU reset
and resume, like GFX9 and GFX10 do, and call the gfx function directly
instead of going through the update_spm_vmid() callback.

This doesn't cover GFXOFF, the RLC doesn't save and restore
RLC_SPM_MC_CNTL over it.

v2: new patch, split the init ordering out of the GFXOFF issue

Fixes: 38e07c072833 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index cdf543f1cd9a..cb2c4d0dab87 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -362,6 +362,8 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 					   bool all_hub, uint8_t dst_sel);
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+				      unsigned int vmid);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
@@ -942,10 +944,6 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	/* init spm vmid with 0xf */
-	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
-
 	return 0;
 }
 
@@ -2582,6 +2580,13 @@ static int gfx_v11_0_rlc_resume(struct amdgpu_device *adev)
 
 		adev->gfx.rlc.funcs->start(adev);
 	}
+
+	/*
+	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
+	 * once it runs, also after a GPU reset or a resume.
+	 */
+	gfx_v11_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+
 	return 0;
 }
 
-- 
2.50.1

