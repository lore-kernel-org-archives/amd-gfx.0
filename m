Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC57C04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2517810E577;
	Thu,  2 May 2024 16:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DFs6vMu4";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 951B5112571
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfruxzutPT1BHX52BATg2O6xUi6jS6A+D9n/DkU6jXcC0JDveV60v5zApVlc2OiWpuL738zKwgnLXf53IzBtll2EajNTxWzIFcusooh6OZ0lhd3RAtxV1iFwwwostq0kyLUMQGHz2tGafo10b0maWELCQdrbd8AKGnrNc7ocm1mkqHfdlElwXYF63Nj2JAioFcKYg15BTvvWyxbsLWUAnqMPvHUENK2JmDAFjaiGtteDmJrGqUiDFr/OVqPexRNIRNPJURgHyx80EpShUIhLHV3eYM8X69xyof9p7hUlyE92knRHmeLArx9qyrEdFN29TEicRR3BLEUP5KaBkt1ADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L84N6yN5elXrYLtfZkaIffMHmGtWHEuRHyOLc31Wb9M=;
 b=fj+FCGXPzOr9nwtxgDC1On+LQ2AyrlepygIjUK22e19OV2QwbIspw6RWk30PhgdwB3wR7lcRhx81j6UFaDNcU1FSRPOVfE38yv/YjpmEW2Y7pmghuN4OmgSixf1Bc4ozd8x9c/j5unzAqnLjKh9hjFrhgIjZW3wxYVo64+dKamjx+5EwSFFrzORAhgEgUBZiMC+Wot80Ge0AZ3zz4W8VfFiJ48BJ/CNY1OpZgj62EO7U0DDxFlUWVw2sXd8ovGZLyIky+BmfuJRl/8otl1swzh6k+nGOhNiCJanxtayLImnn94cLPnQcYFY6vaRMu0Ef258DTDBuDK8z8pRRa+YETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L84N6yN5elXrYLtfZkaIffMHmGtWHEuRHyOLc31Wb9M=;
 b=DFs6vMu4AdtYMbPckyYi5+LZ48M2n9eDhJRUXE33NaWo8KtJ/KydBqpY3gYjy2ax0XddUH+do0JaTNur47CaiEO6/gtWcYtPx+NsYHhTVwkr1xlOZQc0NS1ek8Bfrf0AaWrHdLc617L9Qz/ArLxt2/zfgUGI6b+4pinWHSK8Eck=
Received: from CH0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:32::32)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 16:32:34 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::1) by CH0PR07CA0027.outlook.office365.com
 (2603:10b6:610:32::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 16:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:33 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:26 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 04/14] drm/amdgpu: add helpers to create userqueue object
Date: Thu, 2 May 2024 18:31:41 +0200
Message-ID: <20240502163152.1382-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d74d2c8-8f4e-40c2-ae59-08dc6ac577f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U+seodASVfh0Yq6EKiexQ8Z9NrF8TzinA28H8RUCGchbL3XKudfVj/UA8bIi?=
 =?us-ascii?Q?jpAnD2FgUiZjyB/oLriiPsEjdKD0PqB4LCcLfPbjArq3sQCDaP2ZosDOU5H2?=
 =?us-ascii?Q?49S7nPIWLMf8+qXeSBBdyAgl6JlPk8FAvLmiZHc2eHqAA4JtbLBm2LHyKiTN?=
 =?us-ascii?Q?M228JlnQqlDz2sw6t0bU4/Cv4CH8NDuCD98l0qHX66Kn08nyL9h/1gslHnu/?=
 =?us-ascii?Q?pPRtiAbJzHvyYwFcusvvhuQxQhNALb6D7UBG2MosG1aEFtHKzaFKrZOc2OBw?=
 =?us-ascii?Q?DyVy0uF8n8aYzBJxHxUkdkvDxax6cZL/Mmoh3mQuvwQYJIAu5A9dInrAWseF?=
 =?us-ascii?Q?+emONRsTVqojv8YCFSqE7qEiCjznZVXSK+DqKksCRZIDcCd692cWeyXLcWO9?=
 =?us-ascii?Q?vsTvNlEvcJBcCsUn9f5VDrrKrqChfsv+a51mSXt+Qcz1+AbqIyT2VQ08vjqe?=
 =?us-ascii?Q?xuiWjyBiylIbqsgSSOgAXlLANf9PLIwy/2zJ3wJdd/0+ULaxFZ7pnVk2hMWc?=
 =?us-ascii?Q?vCP1h3hblT0S0+jx+0TW2nD0Kt493E+NcisrFKO2WgmClMA0/rYb5Ojh1/bm?=
 =?us-ascii?Q?3Eqt0/6VWdbTWs1n9jJAvVq1yElKGQQ4m7fwhwrZPX8Nif5DmpxSlQYMCIeC?=
 =?us-ascii?Q?FLcEJTmUX5WR66fk9RGISiHcm0+ZUFtYBXR9azsqHIswRxD4Bo5FSKVNnKWR?=
 =?us-ascii?Q?8nkIjLjsShLwnMXk/xuIa8oVvtlamTPlnRf6u91WuMBaAUPgzVNsb3hFHaa0?=
 =?us-ascii?Q?Ge9cDpgAHN/UkO7yXgqn/Gr5qzuyiKtSZhBNfDOQTHZk030OmXcg1K5kGBVn?=
 =?us-ascii?Q?/kC63Xy5bwNNZYbpOsU8BWwbCwOUEwvb6ExVJwalkwFOTG7JCKG6ZMAtHhtg?=
 =?us-ascii?Q?OCSAR/IDhJ0M1OoPGLNoLnScM1a21to8JXnjt01iTV+VHssSLSk3JC0lGxaM?=
 =?us-ascii?Q?GnyjmrVmiEo0epQdNBkPjNOi4N2m8Fcx1b9xNYbvvj7+hVw5Bw5re0ja+JAg?=
 =?us-ascii?Q?WBjl8eC0thWY5ahS0oCSLG8g44y7JXrgv416wibaTdyaaLP912lnTD03iEXH?=
 =?us-ascii?Q?327tjotfGZg+vEMziJIBXWyLZtNX4uQa9/2RjEw9Sy3o5hWv8P/96AuT0QdG?=
 =?us-ascii?Q?XijLxJDG117D5e5C9ypqLuCupZa2JN57fmh/BeYtJXB6Y/yNtVQjPof9Jh+2?=
 =?us-ascii?Q?Weh4hd2nwNJtFtbJpiasBEb002VHT51R+bvX1r9yfLfreaYIeFl+r75hLQwg?=
 =?us-ascii?Q?7B3hT20eJzfUTEglMHPGncIBz4BBljYJGT+PhoSXZC0iir/SfeFjqh2es9Sn?=
 =?us-ascii?Q?5V5vidhhuvTx1Y34Y0CBu/LEPSMfTDTNmNo55x4vIj90Y6tdxkPgJO4KlUo7?=
 =?us-ascii?Q?ZmJRsXU7XhaMit/4aZr/8gzLLZWl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:33.1936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d74d2c8-8f4e-40c2-ae59-08dc6ac577f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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

This patch introduces amdgpu_userqueue_object and its helper
functions to creates and destroy this object. The helper
functions creates/destroys a base amdgpu_bo, kmap/unmap it and
save the respective GPU and CPU addresses in the encapsulating
userqueue object.

These helpers will be used to create/destroy userqueue MQD, WPTR
and FW areas.

V7:
- Forked out this new patch from V11-gfx-userqueue patch to prevent
  that patch from growing very big.
- Using amdgpu_bo_create instead of amdgpu_bo_create_kernel in prep
  for eviction fences (Christian)

V9:
 - Rebase
V10:
 - Added Alex's R-B

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 62 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 13 ++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index ce9b25b82e94..edbcb0f4c898 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -32,6 +32,68 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 	return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
+				   struct amdgpu_userq_obj *userq_obj,
+				   int size)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_bo_param bp;
+	int r;
+
+	memset(&bp, 0, sizeof(bp));
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	bp.type = ttm_bo_type_kernel;
+	bp.size = size;
+	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+	r = amdgpu_bo_create(adev, &bp, &userq_obj->obj);
+	if (r) {
+		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
+		return r;
+	}
+
+	r = amdgpu_bo_reserve(userq_obj->obj, true);
+	if (r) {
+		DRM_ERROR("Failed to reserve BO to map (%d)", r);
+		goto free_obj;
+	}
+
+	r = amdgpu_ttm_alloc_gart(&(userq_obj->obj)->tbo);
+	if (r) {
+		DRM_ERROR("Failed to alloc GART for userqueue object (%d)", r);
+		goto unresv;
+	}
+
+	r = amdgpu_bo_kmap(userq_obj->obj, &userq_obj->cpu_ptr);
+	if (r) {
+		DRM_ERROR("Failed to map BO for userqueue (%d)", r);
+		goto unresv;
+	}
+
+	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
+	amdgpu_bo_unreserve(userq_obj->obj);
+	memset(userq_obj->cpu_ptr, 0, size);
+	return 0;
+
+unresv:
+	amdgpu_bo_unreserve(userq_obj->obj);
+
+free_obj:
+	amdgpu_bo_unref(&userq_obj->obj);
+	return r;
+}
+
+void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
+				   struct amdgpu_userq_obj *userq_obj)
+{
+	amdgpu_bo_kunmap(userq_obj->obj);
+	amdgpu_bo_unref(&userq_obj->obj);
+}
+
 static int
 amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index b739274c72e1..bbd29f68b8d4 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -29,6 +29,12 @@
 
 struct amdgpu_mqd_prop;
 
+struct amdgpu_userq_obj {
+	void		 *cpu_ptr;
+	uint64_t	 gpu_addr;
+	struct amdgpu_bo *obj;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	uint64_t		doorbell_handle;
@@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
+	struct amdgpu_userq_obj mqd;
 };
 
 struct amdgpu_userq_funcs {
@@ -60,4 +67,10 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
+int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
+				   struct amdgpu_userq_obj *userq_obj,
+				   int size);
+
+void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
+				     struct amdgpu_userq_obj *userq_obj);
 #endif
-- 
2.43.2

