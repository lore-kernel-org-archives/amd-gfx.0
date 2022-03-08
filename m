Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279C8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 03:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F3010E4BC;
	Tue,  8 Mar 2022 03:41:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D5210E4BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 03:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr+Tb+M9HD1Q4/4KFcx7uoCpWil4WHXgIzO4hMd4DDchk11RGGYH/X2Z60oet2rG9tXVxC3y8AaA+Mic+zGoScEwV0ng5/GH5DsPFFLGCtYbWecoWbbPYHlai9hQDVvfanFoBEtuKaQjEi4C+jqrmDojsf2klLVNg2DLXJoYuMubBagvYNQwDBE7MBopObyvWd2/7IbIKZdxqk1+wsR3tzg2hB6YyZeht0/9MRZ9qwYr/shPsoCliN8tVYsZhatcq9Glawcu59Q77wdEnBqG8f9y5hwwnydZHKbnfU5udN4cEAfR04+fR0c8rsazxn39eZy1JogX19p91XcR0OJOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHbQVdNginAGzXwlL8MwY19qz5svJj7eODJ6lXXVLiA=;
 b=h8+bUp/B6rpXXHgPB0JDW0JXMGc2aJizcsc5ud9YeUsRbSUxugdBXysbrqPE/nojPH8fSVtLm8GahNIReebBlMN4TqOKYNX9L6zJNKUTwNRtF7OgorPk8CaCXzzyuHV9QrHno9anNjYuKXTojvaemAtJh9clspKptnPpZ5YQZCeg7ZU8WSaV1hREWA5zbbfjgVWovzBaEjzHVYAADe1ab98q9IkejBPDz9I5jJyL4KDue6Nqr0uwc5JvF8zWOIPNw393S6zUKKsrlxuw/7xT+JjBGcJlY3SSdpKDixJsUbaHd+GtlmQfazPTTnJM4bEX/YrNh5cgYcIw3Lc1agH42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHbQVdNginAGzXwlL8MwY19qz5svJj7eODJ6lXXVLiA=;
 b=PMXY9xLOf0UmnXDfoUNYyDvrLiQf4yfUbaYcyqeXZZanQ/fj/pq6//eGMhGruWxWRBoMrApnx/OGDfVba6eKLjeFaIJrMrkNLMs1MUiNJY0lY/PksTV2xiJBlSK1ANmYRuPjJo8FiKb5DjcqWx13LJm0MzK1ihy3MDdc+UzBChI=
Received: from MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 03:41:21 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::b5) by MW3PR05CA0012.outlook.office365.com
 (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.17 via Frontend
 Transport; Tue, 8 Mar 2022 03:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 03:41:19 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 21:40:29 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Date: Tue, 8 Mar 2022 11:39:41 +0800
Message-ID: <20220308033941.999933-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ff1113-e815-479e-a25c-08da00b5824c
X-MS-TrafficTypeDiagnostic: PH0PR12MB5647:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5647AD4A9C80B1FBDF8C266AFB099@PH0PR12MB5647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvDpHWrMhfwRsWn3C6osZ7DeYF3cvhy+PCp/W2D9R4FI2NihfOLuKUcfBZ/iQOqMmR8bbQs66Tsp2LgEe+JIEQ4C55JV6IVvCG8ZGACMhL8Bb8MOj2w3V4ceI+uUilTcUK1iM8ldFQu/XaMunp1pt3Pz12b7SMBxdQB1j4h8651yCO5RtaYVYhs8SVqzWiY+WvCMGrFBOmrEq/EVPQ4f2dgO3rCGbkaMhnnfCvPIYDaYtmJTgL2UE7f6KO6wSMOcVKhf0CxwYN0j2kfvUwF8UIfxz3YtoIZwFMivcYXDI+l8kqtCG76E4laB73BsDx/+n4/EIPfrBtb84DJmXDz6D8B/3GkgYsGgvrMkqgCICAmUHoFGWgbuUd3k+DZqCG3NefVePTfYWi4SRQiUmh5dWgSyitnVsnYez1J3nu2CPdTr4qUvDBF7yZRnW1diWj5Ju/FoSnFJsTEeYAfFu+q3WRVJLLjvz5SWDEtlM9zFPd5T9iFeDT0mrql2GhfJwJJw8Zcfwubpeufgcm0yNK9M+qu/dKmafNE1489WnOH3sNS6CuJGKBcSW6SURtrGzdaecfNzJcSlKa60aIX0ZvNVoqJT0X1qOzM9Xd4Z9b4jQObFVEdqzmKkDwmx59/01IzuXiEa9hUKkpsXdCObTo8juSwCmNTx085MY1wIoY74q791D5dxuYIhl+1BUVZ66dAUNnBjxtwaDhCvN74LJ3YwUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(8936002)(6666004)(70206006)(7696005)(36756003)(83380400001)(2906002)(36860700001)(47076005)(86362001)(1076003)(4326008)(70586007)(5660300002)(8676002)(82310400004)(54906003)(316002)(6916009)(81166007)(2616005)(40460700003)(66574015)(508600001)(26005)(16526019)(186003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 03:41:19.9143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ff1113-e815-479e-a25c-08da00b5824c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is a hardware issue that VCN can't handle a GTT
backing stored TMZ buffer on Raven.

Move such a TMZ buffer to VRAM domain before command
submission.

v2:
 - Use patch_cs_in_place callback.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 7bbb9ba6b80b..810932abd3af 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 
 #include "amdgpu.h"
+#include "amdgpu_cs.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
@@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
 	.set_powergating_state = vcn_v1_0_set_powergating_state,
 };
 
+/**
+ * It is a hardware issue that Raven VCN can't handle a GTT TMZ buffer.
+ * Move such a GTT TMZ buffer to VRAM domain before command submission.
+ */
+static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
+				struct amdgpu_job *job,
+				uint64_t addr)
+{
+	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_bo *bo;
+	int r;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	if (addr & 0x7) {
+		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+		return -EINVAL;
+	}
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
+	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
+		return -EINVAL;
+
+	bo = mapping->bo_va->base.bo;
+	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
+		return 0;
+
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (r) {
+		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
+		return r;
+	}
+
+	return r;
+}
+
+static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
+					   struct amdgpu_job *job,
+					   struct amdgpu_ib *ib)
+{
+	uint32_t msg_lo = 0, msg_hi = 0;
+	int i, r;
+
+	for (i = 0; i < ib->length_dw; i += 2) {
+		uint32_t reg = amdgpu_ib_get_value(ib, i);
+		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
+
+		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
+			msg_lo = val;
+		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
+			msg_hi = val;
+		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
+			r = vcn_v1_0_validate_bo(p, job,
+					     ((u64)msg_hi) << 32 | msg_lo);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
+
 static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
@@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
+	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
 	.emit_frame_size =
 		6 + 6 + /* hdp invalidate / flush */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
-- 
2.25.1

