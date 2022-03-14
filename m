Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E34CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 02:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 031B110E17D;
	Mon, 14 Mar 2022 02:45:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0CCD10E17D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 02:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDTx7kEOSzCkEBMQSSgjwTQFMzFpLo734OS1moUa5bcViHHamEIVa870ziX16FRsw/g02XBHf9Qz+gBmyPwXmjzFJYtgpix7R/vGuoUWankNFPN7HVgwNTws3yPRjrGDL84Zx9ofRb9SJDbAeueufeOxA8QrSw/88/uFbLHAHyN2pdLQVocv3xiQ4M7YFRbNem7uEezPJshYvB5TrxLz+P7aN9hwWrt6CLooD35uznzmSv6eI150/Y6XzsaQ44yHZlL24Ctmnsmg0O3r2XHqCdxEAwCOoXF+BJ7k18rzHMFnV94qbS6g2ES3MRbNpzZj4LEyeOFK/WFsRkIb0VXtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFlDFMze4SahWf2yFIbQcibswvstQbeoglUp2xx5K90=;
 b=eMuNj7DaXtx2x/gh3xiv7zBuVyd0KK764y0zI4W4WfAw1tdmg3z4dmo6GHzVXvxNGEO4rz3S/hgpgljjGGSIozO8B0yvwYGBCKsjVJW/BBP6hCovCy8q210XVgcb88ar8IvfERcUfhjBued1Xqy/ooV09Rpj/ZEcqiX82fSd5InvnpgVz4JRrXLyw53jKjOSlX8MgtBkOrAJHoAWC/+dNEyRF00d+jRkktiQtd2N7NQOwdu8XiiHU+OdKugjjnF7sYgQ+4l8CAfTYPTxUuuwIKAEC5/X6pslBmN0PBgPenW5Xv0gyh0kch4TnOkaf/t8RvnBi7vOPNASscHR7Xq8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFlDFMze4SahWf2yFIbQcibswvstQbeoglUp2xx5K90=;
 b=ngxUxrnol5s6RGRIq5EO3kyDwfk5qrgPOFzVUkhX3umsiXSGPiFqegqteCTFvgpAkhkV/1XaMRQ789L4wVO/BkUQ55xkxJZpK9SNKhO2uQyqduJMqzFXcy9nSf1z036+Zd1CQ6hus1gqUEA77h8sLGNo2nqtCsJA21DcCZ/zRiU=
Received: from BN6PR11CA0056.namprd11.prod.outlook.com (2603:10b6:404:f7::18)
 by BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 02:45:41 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::7a) by BN6PR11CA0056.outlook.office365.com
 (2603:10b6:404:f7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Mon, 14 Mar 2022 02:45:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 02:45:40 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 13 Mar
 2022 21:45:38 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on CHIP_RAVEN
Date: Mon, 14 Mar 2022 10:45:19 +0800
Message-ID: <20220314024519.2201231-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc15485-9187-4b50-53a3-08da0564ba34
X-MS-TrafficTypeDiagnostic: BY5PR12MB3762:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3762DB7A8935AFF04B7A057FFB0F9@BY5PR12MB3762.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZF7en/OlxSnNiW8ni0VW/UvOSvl14wqSPb7VgIo2n5WoDqzge4qF+6OHBEZlIhL94LSGZyDh4F/yfSFq/rTAcfd1RfHs6U3aLFr+/uqhkzuXWsWXeKPuASfUc9q0dXLwu+SaRKuBumGJH/z8zXPg1CS9Ff0LGiwjv8gOzHpZx8sMjyzfn3mA1SXhJXvn4Tx7WbLBOb+lAulL0/am1ZJ/u+2ysB4Z22wcT525vA2mBpRW4Jo1yfBqZT8Z2r+5hSjGOfFZirfqJkPuL9qLXIhrgzG8gXfdJQF+oF3wwTN6kdrZVfNd+i5jHBDgtDMFFOKduPJJ76dEMaqidgqyeZ2RtoqViVj97cAw2KsjJxXOY8/fCaFdCGaEW4DZgFiO4vnAaJcDr6QuZSHbIAzEo0hDyRVu3v5rA4In5Qj5QMGimy3W/r/3Ck3agvDa3M/RnjHvk7RN6bayIy+aOgTemPB3LNuGrZbppO2Dc7gSaG+IdGkgWHmIpogCn7MOvpR12dlLCfffzH+PDnXekbes5mJ/pv0P/zNdvEcjZd8iTlMIiX/rpSCDX9BhYdQTvrdbRyfh7FePLZxCtmbJtXkO+45hlKbe4nL3UGQmpixs2MqpIuko6oCOqo2eENdnCQY4X1B+D+zdS9nT0mWCNU8JxwtcxofJ3Z3PN3k9QsRK/G/jhJy6HdeD4mVuzX9GnfuHaqsPWH24qsYENn46TJoKC+ILg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(66574015)(7696005)(6666004)(26005)(86362001)(1076003)(2616005)(426003)(16526019)(186003)(81166007)(356005)(336012)(83380400001)(47076005)(6916009)(316002)(5660300002)(36860700001)(4326008)(8676002)(54906003)(82310400004)(70206006)(8936002)(70586007)(508600001)(36756003)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 02:45:40.4425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc15485-9187-4b50-53a3-08da0564ba34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3762
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
backing stored TMZ buffer on CHIP_RAVEN series ASIC.

Move such a TMZ buffer to VRAM domain before command
submission as a wrokaround.

v2:
 - Use patch_cs_in_place callback.

v3:
 - Bail out early if unsecure IBs.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 7bbb9ba6b80b..1ac9e06d3a4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 
 #include "amdgpu.h"
+#include "amdgpu_cs.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
@@ -1905,6 +1906,75 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
 	.set_powergating_state = vcn_v1_0_set_powergating_state,
 };
 
+/*
+ * It is a hardware issue that VCN can't handle a GTT TMZ buffer on
+ * CHIP_RAVEN series ASIC. Move such a GTT TMZ buffer to VRAM domain
+ * before command submission as a workaround.
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
+	if (!(ib->flags & AMDGPU_IB_FLAGS_SECURE))
+		return 0;
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
+						 ((u64)msg_hi) << 32 | msg_lo);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
 static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
@@ -1914,6 +1984,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
+	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
 	.emit_frame_size =
 		6 + 6 + /* hdp invalidate / flush */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
-- 
2.25.1

