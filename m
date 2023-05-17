Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F52C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 14:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C26010E426;
	Wed, 17 May 2023 14:31:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8EAE10E426
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 14:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQkw2q8/n9tATJkJs09sh0H22xKk1WL5/N1ti4nM84QtBDQW8Ppw98LF0o4AVl4aVOTnb+xdraIdRfFo9VjYGLlOYr2vFTq5ffF/eWa6/Z46CZsECKXf5dr8NZfm0nhn0kcjxowrW/ygy1POVrkax7MQh702Gw7FG84OMmGaYSDfAvumSLlPUuI49JL4UpNy9W5CidJGWXFbv94JG5p7M2VdDsc5pYkH49kZze72pPez6LvWiKi+m6mT057B6iaqaGMsp2fp4Uuo1D636sWvRXWBnKvroDFyGyGvWszbr2sYnzMgV+Dy4rGez32htr7xhkA1jmL3E6TeisD05zDXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMwUZuIPW4ZVr0T6i1KGS1oR5/jlLd0Bh7zzMxk1ETs=;
 b=EzWHb+xRKMqNDmGIPmwXOx2/mK5VhxeI7OeGWskQKXB10EXOEqSnaKlZmw7plILPV00I7SnfIaRmKpgoQ8oVLxWtETHmVP1JzdEzio6zXuOTZiCXm+XLpqTc3QPrMfDEf4677klQ+YxYq9eaEItPDJAqybk6QD8t5NpcOoguAezqhilUqGq68OJOpQ8OfxRbnnHVuhjgEtcorANdtRJz2CBdDiFmI3gMGH1G35Al59CKWgebYV5M0RSzggzIQgoGUtvC5drrv71WE65TAM8vDrAZzyyI3ROxVYnlU2FI1+4cKA/nIOgW5wii+Ot7iIjAuRUgUvZNeS3rPrkJL1JQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMwUZuIPW4ZVr0T6i1KGS1oR5/jlLd0Bh7zzMxk1ETs=;
 b=CnsBhtOn5+qlgwnQoqXu/YKGXNeolAFxkHFsL6qbxmE4syaGWR+CYqnGSsQUn9B86J3fTpukSWS2rkQLyTaBi/38E2iF7ixhG1WbsV5xtNLIu+Tfs5tDzX+iJRJmdu5c0tKk+YjIjYFdo5wdSSihyFLfkg8KZId7mlKApNL6oj0=
Received: from MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32) by
 BL0PR12MB5009.namprd12.prod.outlook.com (2603:10b6:208:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 14:31:46 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ca) by MW2PR16CA0019.outlook.office365.com
 (2603:10b6:907::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 14:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 14:31:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 09:31:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc9: fix 64 bit division in partition code
Date: Wed, 17 May 2023 10:31:30 -0400
Message-ID: <20230517143130.3016720-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|BL0PR12MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe15d63-ef2f-4b0f-99f8-08db56e37131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwnMwEk9A31Uuj/MmoWbVSrgQ3vc2Tlr1kofmGqjn82xX3DrAOhLZdYiH0KT2WixLxW90RhujYLqyZ9YBW92rofbYSNeuLxqQ/MlVbCx5zqxmIZNvboSyLxwgBRcD41+pve9ifSia3+g1gE5XfXChRJAFHFyNVRVUBBEsoldfV/MAUJtoBgSSdVRO2t4UUnEkEsi9/U7FK97s5SM2kDOHnC+4zKTodwWRjsw6jIeMClDWFqviL24aBaLspsBmTX773juWOj2E5x+otLi/XCBT3k4b6LKHoBsB2AArpTKDc4YN8aPKTbX54otfUIHVZ4mKsd2dWadHuRtNGRh89n87VwuNLTRa4bBebOH9j0DSdqjopm2JFplC1mZZAdyMPOMq6MNmurf99jSqShFlORgoe6T/aBR8Pdancr8AWxGuJcPX5sy6sHdlcAnSwFZJmAzuOq1YSgFEme5hSiOR4bv7mE8y+/JsFWrSpAOoIKaNG7MaKesx5lWud97Vbg/+ba0A9DVpCDoIA4BD6YA7bjvsJG9F6W2BF7H6CdMaHzYnw/gu8O73LXtUJj1AjWdzjQkty8zRF1Me6xSFDxHl/QG8edaTKybkYgc7qK90o2L/GofvxwSq32o56UiGbrzcPM2rK3tA8vA5SnsUa5lVBtJEIy3DqvKdyWqJExgU6n6egoj5LGXKsxymyqeQORVnL7Mfxn09KSFEMqb259jCIVxFBQ6eUPsis0b4UetGf2YXiOyC5w8QYPlA05st1TmqALZ+RW2IlxlEBI/SXLKbFq1hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(316002)(70586007)(70206006)(6916009)(4326008)(478600001)(54906003)(86362001)(36756003)(7696005)(47076005)(83380400001)(1076003)(26005)(426003)(2616005)(16526019)(336012)(36860700001)(186003)(41300700001)(8936002)(8676002)(5660300002)(2906002)(40480700001)(6666004)(82310400005)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:31:45.8292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe15d63-ef2f-4b0f-99f8-08db56e37131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5009
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rework logic or use do_div() to avoid problems on 32 bit.

v2: add a missing case for XCP macro

Acked-by: Guchun Chen <guchun.chen@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 11 ++++++-----
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 739eb7c0d133..fed545cdd1de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -794,3 +794,17 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
 {
 	kgd2kfd_unlock_kfd();
 }
+
+
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
+{
+	u64 tmp;
+
+	if (adev->gmc.num_mem_partitions && xcp_id >= 0) {
+		tmp = adev->gmc.mem_partitions[KFD_XCP_MEM_ID(adev, xcp_id)].size;
+		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
+		return tmp;
+	} else {
+		return adev->gmc.real_vram_size;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index be43d71ba7ef..94cc456761e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -333,15 +333,14 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 
+u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
+
 #define KFD_XCP_MEM_ID(adev, xcp_id) \
 		((adev)->xcp_mgr && (xcp_id) >= 0 ?\
 		(adev)->xcp_mgr->xcp[(xcp_id)].mem_id : -1)
 
-#define KFD_XCP_MEMORY_SIZE(adev, xcp_id)\
-		((adev)->gmc.num_mem_partitions && (xcp_id) >= 0 ?\
-		(adev)->gmc.mem_partitions[KFD_XCP_MEM_ID((adev), (xcp_id))].size /\
-		(adev)->xcp_mgr->num_xcp_per_mem_partition :\
-		(adev)->gmc.real_vram_size)
+#define KFD_XCP_MEMORY_SIZE(adev, xcp_id) amdgpu_amdkfd_xcp_memory_size((adev), (xcp_id))
+
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ad664ef640ff..34724b771ace 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -818,11 +818,14 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	uint64_t total_pages = ttm->num_pages;
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
-	uint64_t page_idx, pages_per_xcc = total_pages / num_xcc;
+	uint64_t page_idx, pages_per_xcc;
 	int i;
 	uint64_t ctrl_flags = (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 			AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
 
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
 	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
 		/* MQD page: use default flags */
 		amdgpu_gart_bind(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 938c8dba9057..d559e7bc0f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1919,9 +1919,10 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 	adev->gmc.num_mem_partitions = num_ranges;
 
 	/* If there is only partition, don't use entire size */
-	if (adev->gmc.num_mem_partitions == 1)
-		mem_ranges[0].size =
-			(mem_ranges[0].size * (mem_groups - 1) / mem_groups);
+	if (adev->gmc.num_mem_partitions == 1) {
+		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
+		do_div(mem_ranges[0].size, mem_groups);
+	}
 }
 
 static void
@@ -1953,8 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 		break;
 	}
 
-	size = (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) /
-	       adev->gmc.num_mem_partitions;
+	size = adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT;
+	size /= adev->gmc.num_mem_partitions;
 
 	for (i = 0; i < adev->gmc.num_mem_partitions; ++i) {
 		mem_ranges[i].range.fpfn = start_addr;
-- 
2.40.1

