Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B69E95A9C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E47A10E1D7;
	Tue, 10 Oct 2023 10:18:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115B810E1CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ak8dvINqPcrdAIuMuh0XI6mTmCxXwkHoLHcL4cTFJeBVAeey7u4l+ypNbn+JvpzfTuFujCpzbhup5ifYoLvRrc2SY3pUdPV7e4QS6yJ1HbYOrFkz78NXVt1LkvOhvE8tQzicididNDkMX9Hk22tyB2F6/L+cofZLrat9x6a2uU5C3NClae5cd/lFMCgf+ym1zMWPhjbdX6+K0sb6qqZWgTCeWXa+5+GlRDZ5B/L0bcmEKlpdI1GZYc7PKys973jHmqw5fFIKVWeMvTt7gjyjW/8xRl6jKFeTZDsZJnFWKfTncD60zQ4gHar4T/XN4ThD06XiCpXevpejZGwY7w5O0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDjWlGUWsJ5HQeIqRJR9s7wJ7RRrDeSYsvBAhAgPcIA=;
 b=DQPpTZuk4iNLmfyxglPHZQebdMVSZZ0cH9Gv5frsV/p7dyYTwBcSeiUaw7uJm6wpywrYKn/YlSeSCnaeGEQ8oXz3JVQfIYapVH7Wv+MQebYlObDEfLWOd9siorXejOph1KA9HQKCOrXph9iH1JPBLx+aZfoQhrYb7hz4oemng6SG71bep4wxgS+FbNriiijy95QBhMRgkWuGLXgpQBnOwK/vg2D0BhRzg+4WGi1A2gOi20HekPWm+OFmf9hHQcHQ5iyb+TEbJLLU41fTBOnZk9qsZhjpxS5Bizu+yM5u6ii3DZb5ToNRxc04qcIs/ETfD16KrinO0SwUEmE+JdL5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDjWlGUWsJ5HQeIqRJR9s7wJ7RRrDeSYsvBAhAgPcIA=;
 b=WHTGnFjyyCBJ+0V64g+W7B2k/Ow3gbkiglHdmQ01isal64zWVvFs3XDoPF2pQWcSOganZh4sy7C1Q9WrI4bgZn/HmvHcx12PXlFUS0V4da7WPR9ikYXI91IM4/d1nRISlHHdxsGL9Rf7ss3If6uTteHYkHBTz3qP5K2ORYraiY8=
Received: from PH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::25)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:18:38 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::cd) by PH0P220CA0005.outlook.office365.com
 (2603:10b6:510:d3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:38 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:36 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 04/12] drm/amdgpu: add helpers to create userqueue object
Date: Tue, 10 Oct 2023 12:17:44 +0200
Message-ID: <20231010101752.1843-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: db3cef31-cdb8-4ffc-e477-08dbc97a44ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBd7JkmRQKnhsMpxO+jELy8m5c0DRu4rFg7KybrAFEtCkeZ9hqmgOuCZcI4LyOrL4SrK9Vcp1fuO4KZ1f0ynmrxKx/WLnqiimzh0pFDnq4WQnbQFIhcysPatmTn9LmDb3cALtf+AzPxi9Mi+1qW7pOR+nK18sgNQZxcSlY2CtNlaSe9QHUo63xZDnSZ11oDLxb+LUBIdz3hdWlIN6wUvDX53gDEFpjvucJZZj3HKSmcrCF+oD6cH3R7OFLYdP7jDaEmkMTuky7z3/1OGsZE86P8+IlYazit8Ykgy7XTI1zdjbu8Tqw8OtIdIFqCFGX6YT0czeWYaI6NLR493XOoV07LWY8fO4q+MiVgYqY2OPI1JKdbLBHPodiGPTMgnWDOif374CaHRDUc4u7txi6n+h4xbsRyIVBFwsF3VJ0g5u+5j0NDECXkXdiEtJ7Hm2ig5H4IKVZlBzw+deU6PtooepCMIbdZeSRCidXGNInQCHRFhFMFEZXwTxYpt2fY2ywYxBdTplJ/giOwD3EEG9s0hNqFDZivIYx9wPcKpOmuq+ipsDAzKMlUfKa9iKEhfsisYm6PFADklHkcTLABBteIH0u4Q40v6d46WP6mY+g3Gg+FStaUoUq+Mm5eTaPJoEUy6Hcft0DsI6+J0ePUyBW4SGbCDTfMlTIN6MRyrxbu88BnS0KaQ6RAY2DvIyzhnJj/D/4Ci+cHSIyyjUJG3SCymsBptkYa0hLqMyJCW899zbB8JOIl8pFquEmrzqaZaQZQp3tOhCE5xtMF8Tt9sToHeQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(40480700001)(47076005)(336012)(83380400001)(1076003)(40460700003)(426003)(2616005)(16526019)(36860700001)(26005)(70206006)(54906003)(6916009)(4326008)(70586007)(8676002)(316002)(44832011)(41300700001)(8936002)(2906002)(478600001)(7696005)(5660300002)(6666004)(36756003)(86362001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:38.2066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3cef31-cdb8-4ffc-e477-08dbc97a44ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 62 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 13 ++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 88f0a85e6e17..141808e9296b 100644
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
2.42.0

