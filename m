Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EFFC61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 23:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F6710E191;
	Wed, 22 Feb 2023 23:11:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8FC10E191
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 23:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccHYV9MwpAjnmp5QSxb/qO+qDm8lJ6Z/W/yfosMn70W/PgN5nYnlXgJWJzGecSFwedfvYyizOd0xzePsH97UgQWoJZ+bm5X4irfB2WlNgRtlA5HV/rxc79D5qObZDi4mFliaE/rqMq+5QSKu4j8Qu1OXzTyubudPvqvvKUL6ou3ioG0Kspz0ZijwkV0LBgamySl2s0pHxGhPa5EIDCAPLoovdtIAcxc0mq6RvJRpQLqjRO/VqANPVDExArb3onHceR+o1Tw9BmzhZhblBy28W7nv1OWQI6cvhY1M/r7fQTdOvBjyz2AHPKqN0osjoP0/u7iXVNoTmk7OOUqStfsFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0PGjUJOM1SYaaPRP7j89QqRtOhMCqXc7PrFecBfqw8=;
 b=JW95S6pSPsMCVOtlZRdWDFlL6xYx1gxhGxwFk/+i7+NeJe6B9qvkWShxvtO86x97vMzYfg4S6tKJj+nzlCcqQPe/exO21lKACvK40iy0Xx+ku+eboPwMxsS2xcuh7quljy6l3rLaUDjghzmwSOmZth5jz8J783e+SI9VUp53okEZ6PfedcyWg9fPZpZHPDucFWg/MlW3Ybeig8Jd1cQBRTmGXFHv+atR5pLd9VaDzI5c6XQR4JUNVGzWVwecxkavPfEdyj3Irv5MLjSAUX6xTZ2grkVEVZTCwGWFW/nZvro4456YDMqQJpBVXrgTE/Et6bUecGiS0PCcgW+zQXqPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0PGjUJOM1SYaaPRP7j89QqRtOhMCqXc7PrFecBfqw8=;
 b=2WF7TVVYkTEu1ccPYHe+Bs26uiEcawVW7UEk6LZF+SBh6XbntWHkCl4AL76i3p7FimOk1WH63E6lS/+YTc7EAx9O9EEETn3O8IZ3h87PydfcrkUolnGtR26myrfpOhE/md3PTWDZqADokk6N8slq+xr07QsbPNA2AHbznfkbLcs=
Received: from BN9PR03CA0182.namprd03.prod.outlook.com (2603:10b6:408:f9::7)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 23:11:54 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::c) by BN9PR03CA0182.outlook.office365.com
 (2603:10b6:408:f9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 23:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.20 via Frontend Transport; Wed, 22 Feb 2023 23:11:54 +0000
Received: from david-X399-DESIGNARE-EX.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Feb 2023 17:11:53 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: support more AV1 encoding requests
Date: Wed, 22 Feb 2023 18:11:31 -0500
Message-ID: <20230222231131.191619-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa7cc68-e988-4882-46a7-08db152a3028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZv574dRIy1QGCPi3oadN1V+QEwtGV16sfvAhuJI1ab791y2HE0/t2AIfPpyKX4srnw4ZM0u9QN7gOxg2dzXZ+D9ArR3Xk+w5Q/YjoM/e5Ot1aPxvUi4yzMyrNhDXnscDf/dccuLK2t7v5dEc2M9MgV7cUa/Hr7hKg5v070pf869Axz3cyG54M6QtdbgwPNTMC2RQvuvUpd97Km88nTbdhNRUWXtBd4fExpebAQiw9SbqSRDwyQuC0ynNL9PIpuPAc9KAWAQy4nvlW5tRi6k7i5FVCcS1jUWCPHURMI4Lf6ms4iug39mgBixdXdqtKUeN84XzCtxdMrQTsnPNCLGrnvBVxQYLnjSM82VkiI4rBb7Qm3a5h39ZikJ+6n4/8PDf07yTyhuLlyFnLUoI7oGGvvzilgQEZ+cFgPeh9b3TycJRi1m+O89mJJsqG9qHfszAJXktn02slvYY1omp6ITypv58wvjh0B/rToA9nxf2v8p7h9wyns1N1ZFN27/yXmsyaSxD7eEzg8nT6FWtlDOzHUcV0Tgx1i4LU8r82T+qKMVRGaiHzKQZMWmIgVmp44IQa/lApJ/WRBuxG7DLr5PQW84OQzpN8sbEcvyHzom+Db5hXS2FgPtqI5Hn91S1YRjkTGm4QuYSs2aQHkMpIe44LqJFkcIGUC1VVmbi2g7zK7vKTO3XmEeo1xwCBpRq7tC5yygTE6hXDMbk8jVeG6XSAeu0IC6/M4tKKVlhWWBICc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(26005)(5660300002)(186003)(16526019)(81166007)(82740400003)(8936002)(36860700001)(2616005)(40460700003)(1076003)(356005)(41300700001)(6666004)(70586007)(70206006)(4326008)(8676002)(7696005)(36756003)(110136005)(316002)(86362001)(83380400001)(54906003)(82310400005)(336012)(6636002)(40480700001)(478600001)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 23:11:54.2719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa7cc68-e988-4882-46a7-08db152a3028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ensuring accurate IB package searching and covers
more corners for AV1 encoding requests.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 81 +++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 22a41766a8c7..8235ff3820ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1726,6 +1726,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 #define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
 #define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
+#define RADEON_VCN_ENGINE_TYPE_ENCODE_QUEUE		(0x00000004)
 
 #define RADEON_VCN_ENGINE_INFO				(0x30000001)
 #define RADEON_VCN_ENGINE_INFO_MAX_OFFSET		16
@@ -1733,21 +1734,86 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 #define RENCODE_ENCODE_STANDARD_AV1			2
 #define RENCODE_IB_PARAM_SESSION_INIT			0x00000003
 #define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET	64
+#define RENCODE_IB_ENC_QUE_INSTRUCTION			(0x32000001)
+#define RENCODE_IB_ENC_QUE_INSTRUCTION_MAX_OFFSET	64
 
 /* return the offset in ib if id is found, -1 otherwise
  * to speed up the searching we only search upto max_offset
  */
-static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int max_offset)
+static int vcn_v4_0_enc_find_ib_param(uint32_t *ptr, int size, uint32_t id, int max_offset)
 {
 	int i;
 
-	for (i = 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
-		if (ib->ptr[i + 1] == id)
+	for (i = 0; i < size && i < max_offset && ptr[i] >= 8; i += ptr[i] / 4) {
+		if (ptr[i + 1] == id)
 			return i;
 	}
 	return -1;
 }
 
+static int vcn_v4_0_enc_queue_msg(struct amdgpu_cs_parser *p,
+				  struct amdgpu_job *job,
+				  struct amdgpu_ib *ib)
+{
+	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_bo_va_mapping *map;
+	struct amdgpu_bo *bo;
+	uint64_t start, end;
+	int i;
+	void *ptr;
+	int r;
+	int data_size = 0;
+	uint64_t addr;
+	uint32_t *msg;
+
+	i = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw, RENCODE_IB_ENC_QUE_INSTRUCTION,
+		RENCODE_IB_ENC_QUE_INSTRUCTION_MAX_OFFSET);
+	if (i >= 0) {
+		addr = ((uint64_t)ib->ptr[i + 3]) << 32 | ib->ptr[i + 2];
+		data_size = ib->ptr[i + 4];
+	}
+
+	if (!data_size) /* did not find */
+		return 0;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
+	if (r) {
+		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
+		return r;
+	}
+
+	start = map->start * AMDGPU_GPU_PAGE_SIZE;
+	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
+	if (addr & 0x7) {
+		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+		return -EINVAL;
+	}
+
+	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (r) {
+		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
+		return r;
+	}
+
+	r = amdgpu_bo_kmap(bo, &ptr);
+	if (r) {
+		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
+		return r;
+	}
+
+	msg = ptr + addr - start; /* IB with SESSION_INIT */
+	i = vcn_v4_0_enc_find_ib_param(msg, data_size, RENCODE_IB_PARAM_SESSION_INIT,
+		RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
+	if (i >= 0 && msg[i + 2] == RENCODE_ENCODE_STANDARD_AV1)
+		r = vcn_v4_0_limit_sched(p, job);
+
+	amdgpu_bo_kunmap(bo);
+	return r;
+}
+
 static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
@@ -1763,12 +1829,13 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 		return 0;
 
 	/* RADEON_VCN_ENGINE_INFO is at the top of ib block */
-	idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO,
+	idx = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw, RADEON_VCN_ENGINE_INFO,
 			RADEON_VCN_ENGINE_INFO_MAX_OFFSET);
 	if (idx < 0) /* engine info is missing */
 		return 0;
 
 	val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
+
 	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
 		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
 
@@ -1779,10 +1846,12 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 			decode_buffer->msg_buffer_address_lo;
 		return vcn_v4_0_dec_msg(p, job, addr);
 	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
-		idx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT,
-			RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
+		idx = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw,
+			RENCODE_IB_PARAM_SESSION_INIT, RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
 		if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
 			return vcn_v4_0_limit_sched(p, job);
+	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE_QUEUE) {
+		return vcn_v4_0_enc_queue_msg(p, job, ib);
 	}
 	return 0;
 }
-- 
2.34.1

