Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26CCC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 13:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E739C10E110;
	Thu, 24 Aug 2023 13:54:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D99A10E110
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 13:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSj0duBkQfdya0MYjMELaBn4CMDZmor/IGIFT0LUd2wThH6FDfM6rIpUfSaLHJlJZp9f/2L4yiGqK8PQ7DRBLjXUXioGkJC6LmEqHsspdxooflnY0JKimORo82ElYXfMyDhEp2L70sljc+F6oY9br4qcQVfnJD56U7akSo9yZzENNVaN4Ij2c2b4bphLc2mXgV2wKIH1MZRcuH5+iQphixxQ77H6NRatQ167vaA4rwsCia4nU8uNM+ibHpROwL+Vptvo1/R62VW0fUfc1Z3l92rMyUYvwxcMcIRObt+Ih+FkY3eu5TdsDiJziT9eoObdQbDoLNwayW2EFEbXBZNhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJvQp5+bPicg1ii263ucJ6Uu339gRJNBN1Yn8fH8v0s=;
 b=gA8p7BXgtPEgJdW4Rag9rwEOQH0c1YFAlEhR3nLnPc3pjBky+i9VKBaLvdckNG9aG22VtXRDbFebVDulYpkdSf4W0IMCG3Fo43K1ni1Cz83eH347kZbynPFnYnXD6LkrWsidzdn+MSgPOIvMfqtA8FZLaTBH78kJPFUSUpDc487ZaRiu6yDVnFM8m5HARVOFl0hpGMdMflZBL4XP48lILoBeiQw2VXNMt1h5PKkAARH5ds17kqpQ2kDxb+2CKe7rFI4Q6aa+ADeuePGVlcvEWAlM/KSLRkI7F7zCfSbvaQXE1CHChvLOrrGoEvw1xffiSdm4X6kiUYN8xdTKqEpnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJvQp5+bPicg1ii263ucJ6Uu339gRJNBN1Yn8fH8v0s=;
 b=JGwYseqwMp5ctfT3JwVj1+Xyb2oDk6bcJuaERIahNWLj/NxtCym2/i41XTDMmC2Hg640VPhn5NI9lwDyU8i3J7Cn+0XD6AtMzzjDIAfsP6gHoHIrgabyREstD3BPdkEvqQDL0tEDtVBK8zdM24YJ74j3msHG7m0+bR3NJZSLN3Y=
Received: from SA0PR11CA0146.namprd11.prod.outlook.com (2603:10b6:806:131::31)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:31f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 13:54:37 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::9e) by SA0PR11CA0146.outlook.office365.com
 (2603:10b6:806:131::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 13:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 13:54:37 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 08:54:31 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: change page_table_base_addr caculation in
 mes queue property
Date: Thu, 24 Aug 2023 21:53:36 +0800
Message-ID: <20230824135337.3975006-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea3d361-cc3e-411a-be81-08dba4a9a7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbALtqEEm5bUbKG2qn03M0RQmYcuvIwmcZzeYqHATy65HGTGT9fomisyYrkp30e7bitkaXpuLO31bZj0dfArrXCheBQBpNf2/1Fb45AfnIwT5xFr84+7Tctkz7EkBovBSY7tM6FVgfpKeBVzlJzNkSRIX47+n7pLhmLiFyiZTD8yxWQjjVw4gO8/C3rTGhDiGaKmY8K59VnGP9uDob3AxMpDfz7jMtMQKeUOnMCV0d2hBrgwQ/Ivyl451883gz84Rp4bwl29SK5Ce00ZraLKwEmDWoGDeglMYeuokebT4AUCzZxVKGTbj3Xb/RuhBhPJlcpOBaA+eIgQ0yczU4jwf35hkzGTb4DQ8cB9SKwt7zUvhbCTArEOZidFTgmqYPi08/aEJLZKsbBSfg5xTPe/hwkSoYmReT4VkHdEP2mCrFWXKxu+1YalqI4Xzlz4YVs6kBonwAVSmM4Nw2BNlzYilKTjcF2zdx4vRGoq7yvVDGgpc+qFY4XjdTlnJdRVmxMcb+wmwKNSzTt0rP+DsKnFvl/HI3IIHTWH+vP8xfzXRbwDn2qvY9CGXhLGLNOd21T8dl/mNY60BSy1ZtkCIF+SEsF7fieM0DW/vAaq9Sjo8BvArWjfY2hOxzbYbXqSEZwffl0eAzludGX8o7AL8dHpZqTVnMkHaSKqGGuWnXGP61fNFnwVvrsDN/eEARZvSg9bbmTyq8igH7ow8R8sYB6/KD2koEc1dJcS74xEWP4MFEQ6V4BjtMnID1Jko6aqVEH2LGCznuHSbW9WTu/KRb4OQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(2616005)(40460700003)(83380400001)(4326008)(8676002)(8936002)(5660300002)(426003)(1076003)(336012)(36756003)(36860700001)(47076005)(40480700001)(16526019)(26005)(82740400003)(81166007)(70206006)(70586007)(54906003)(6916009)(316002)(478600001)(356005)(41300700001)(2906002)(86362001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 13:54:37.3090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea3d361-cc3e-411a-be81-08dba4a9a7bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

current method doesn't work for GTT domain page table, change
it to support both VRAM and GTT domain.

v2: rename member for pde (Christian)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 10ce5557bb11..06a178dde38c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -259,7 +259,7 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
 	process->vm = vm;
 	process->pasid = pasid;
 	process->process_quantum = adev->mes.default_process_quantum;
-	process->pd_gpu_addr = amdgpu_bo_gpu_offset(vm->root.bo);
+	process->root_pde = amdgpu_gmc_pd_addr(vm->root.bo);
 
 	amdgpu_mes_unlock(&adev->mes);
 	return 0;
@@ -621,9 +621,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	/* add hw queue to mes */
 	queue_input.process_id = gang->process->pasid;
 
-	queue_input.page_table_base_addr =
-		adev->vm_manager.vram_base_offset + gang->process->pd_gpu_addr -
-		adev->gmc.vram_start;
+	queue_input.page_table_base_addr =gang->process->root_pde;
 
 	queue_input.process_va_start = 0;
 	queue_input.process_va_end =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a27b424ffe00..01ecbfd57ba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -140,7 +140,7 @@ struct amdgpu_mes {
 struct amdgpu_mes_process {
 	int			pasid;
 	struct			amdgpu_vm *vm;
-	uint64_t		pd_gpu_addr;
+	uint64_t		root_pde;
 	struct amdgpu_bo 	*proc_ctx_bo;
 	uint64_t 		proc_ctx_gpu_addr;
 	void 			*proc_ctx_cpu_ptr;
-- 
2.37.3

