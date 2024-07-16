Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45D5C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 07:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6441A10E5B9;
	Tue, 16 Jul 2024 07:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CS9+j/qF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE61C10E5A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 07:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDR2XZ4P4oRIeAUMJl0NRLXAXJ78QSXBSkavJgTSwLazCIq7riqWMr96E8Spa4FbffSY8JiJxD+R73RLP4wsPoCHULLJ0HJcMXdLWRkVNRFQwkBOyunx0mQMaPbtgF+MyAYRabMIx5pVMsUSmGVt3o0JxRZzTu+FHn2uYVUdsVD+HH48HRR2EX7EwFufFkaGogpXdMaDntVzpY6UXBYB6IutPNeXCQQ/0PI+OrS8Rcw95ny6E8VmquYsgiJQM5Ds1AC4oFjo9U9m6ZX14URSHA9Rit8B2BuO0jJG8JZlkc6/Ve5mBo7PXcpxlZyxXSN2Ry6Gizwhd2kPU2mAo7q1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEU2TZVvLoGi4D/84o3HdVjNuBoQnTbg7xTEVr4HTH0=;
 b=xsVUb3QrxJwhWBuUBnCpX8yJXxk8EjjSwFrDzsCxAsPkGeGmMhf5WaOKNiRfwcnruDom0TtDEJNaNWVQ9pErSI1nBw44V94V/o9lppLs0adFZZCwrCipSB7AGV0XpZW4Qh0g/MxuvQ+JaqJgf36g9hEs1etfYCueZvF03jp2+eBxXQavlZrh94CPV6UD4gc+y1yE7NAMa6N77dedYIjd84QwuNBJVIL/8sU67hgCeYTwNhjfsTl7UdN81dgGWHAN1IqYnEGst98EmJ8SyNExD6asq5jQN97JKstMjt7TJN9BYmXT1Xb9icg+/rk9K5wETPgu9kqFmujmfeGZ4ICiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEU2TZVvLoGi4D/84o3HdVjNuBoQnTbg7xTEVr4HTH0=;
 b=CS9+j/qFBW9gyIk80EownmWB64Heo4dUVtLWJZLCSXn3ZYeRT4dG1dMWZGWU8skKjERoTvXaPzv1j5UPZGKXLA0Ql6U7aOaGz6Ar1fxYtX7GnjGKL9LoP3Vttfe3TKN8odTeyvAo4eOkW872ebPt4KHbbx92Y2SYC3oqk1A8iTw=
Received: from PH7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::9)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Tue, 16 Jul
 2024 07:59:30 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::b0) by PH7P222CA0010.outlook.office365.com
 (2603:10b6:510:33a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 07:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 07:59:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 02:59:28 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 02:59:27 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/vcn: Use offsets local to VCN/JPEG in VF
Date: Tue, 16 Jul 2024 15:59:12 +0800
Message-ID: <20240716075912.193722-3-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716075912.193722-1-Jane.Jian@amd.com>
References: <20240716075912.193722-1-Jane.Jian@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jane.Jian@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f47742-1be5-422a-3fb1-08dca56d3873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mjis8jZsC99gZy3MrbgVo6qKu+CIhw08eml7AFo4yHknVJ7FvAxoLl10dc88?=
 =?us-ascii?Q?KrNm+NyaMp09WLVtcA59XfsrCbNlsDuWViNz6n7VPleTxlwxNv3AY7DbtcB+?=
 =?us-ascii?Q?34iaMgIAIsw7EN6ZZ+kHu/jh4Y63vhhoqJsYVPF30RSdzY9G91baTPwSSuGT?=
 =?us-ascii?Q?FfIEFkUMlI3ouQZmtSajJG94UZGn9x5YKFi9i0BzDELtGqkrwiX+8gLybxJe?=
 =?us-ascii?Q?ONYHKS/E7IiLcF2TOcwYfiUFT5QwyDRZmkuFbKTA8Y/2ROs/NJmRq2uUaFQF?=
 =?us-ascii?Q?Dq9CmdFZt5KZk2/cIJuCFvnDxLYHy66tvR0cEUI5IVXIJZdWE+Go5nwBr9Hy?=
 =?us-ascii?Q?qPn/pPHF7vW9XdeM5GZt5jSlHemVZoezcEwiyPGruXHnKoPEzBzTQJvmHNCl?=
 =?us-ascii?Q?zZiFVwsywQ8ReMaq4ZWhP69rduRGxtf35SC3L4VdbACrdxDMJh7TKOi6TbK7?=
 =?us-ascii?Q?g0z5q4XY2xxbqcX5cepZLXwrAiMdfu8ouowcJiw6Kp6G91YkOSSRS1h7eulq?=
 =?us-ascii?Q?I4+59TGvDcmkr01bZ1Glk087mU+BsrUT31CqUCr6SPWPZIAGQcZi0bulxZTG?=
 =?us-ascii?Q?GNVOVmjtOCFPL9y4/c/zqT+f24hZoWVwwr7TqdUmq61/AEItzhvRGPiX/Oaw?=
 =?us-ascii?Q?6uXD4nLt0tgrtKsenf1tLqYgrGRx9xtkd/g/9zSe4M8sVBoT4Upl2653rDN+?=
 =?us-ascii?Q?7CUw/p+aRqrTEZtd57W33yFMzNxu7ZRrn9OfNajZ4VPjdWTrKz+2eOKzG2OO?=
 =?us-ascii?Q?JZkpw8MiCNlQ9Pix35hkbixH/wt8yguwrgpOHfAlLMHk5ybtrfA1zvDPPt+h?=
 =?us-ascii?Q?J4w0O5bvvTNgVoVjUFQMlv+otMn699mIIs+AgWWVfMkMfx4v/OJgQnKn6tBX?=
 =?us-ascii?Q?XIIcBZzAaaf+yoIX/Bk3Iqz30VYOr9/HkTf6bd46oRzlzpBvo6uEsPzKvXfp?=
 =?us-ascii?Q?KM0G2Gl43fGdmmOMF9SJZBchsafr4oI/CKmjnfNNHN0tWw3023tVXzQVlvDJ?=
 =?us-ascii?Q?8fhQClPTE8CYSOSJX6poGsoQST3F0LHzeWnIfextqgrnkVEkzBfuRw4nFv8r?=
 =?us-ascii?Q?3yduwFPorU4zryMj7bFwNWBLywcou9YdSsHmtAbxm8VB4zPNcNydiQZcsCz5?=
 =?us-ascii?Q?p25BXurdv9Z7kSYQHN+YPjSXM4Gvbf41SFRDTI7ZFDgMoaHalP8b0jtP7r3G?=
 =?us-ascii?Q?k5/TUesn2wVeQDCo7Q9FidB/aTLj1E/mBFx5Mat1WCn1IVqtG7xuH3IicBN6?=
 =?us-ascii?Q?nIDdCxDDH7PKVKwXz+EIuVCvZhs5uF6jiyPYWd1WBaUYO/I5EAUE9lQuHzG4?=
 =?us-ascii?Q?ZC4CRddlQ+8oCJxerGIl3d6bZNR3S+P3jXdwmIQxMVNqaYacNK9wFwalkGHi?=
 =?us-ascii?Q?UULdxvI+hYiIGq98LQU60Dr4h2w+zQR2tPuixLV1snIRfa5hllOsLZtp9Gpz?=
 =?us-ascii?Q?Ci1B2YFcvFnjEbhW998etQL1y/4WYNhK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:59:29.6081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f47742-1be5-422a-3fb1-08dca56d3873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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

For VCN/JPEG 4.0.3, use only the local addressing scheme.

- Mask bit higher than AID0 range
- Remove gmc v9 mmhub vmid replacement, since the bit will be masked later in register write/wait

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  5 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 19 ++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 46 ++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b73136d390cc..2c7b4002ed72 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -844,11 +844,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
-	if (vmhub >= AMDGPU_MMHUB0(0))
-		inst = 0;
-	else
-		inst = vmhub;
-
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 30a143ab592d..ad524ddc9760 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -32,6 +32,9 @@
 #include "vcn/vcn_4_0_3_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
 
+#define NORMALIZE_JPEG_REG_OFFSET(offset) \
+		(offset & 0x1FFFF)
+
 enum jpeg_engin_status {
 	UVD_PGFSM_STATUS__UVDJ_PWR_ON  = 0,
 	UVD_PGFSM_STATUS__UVDJ_PWR_OFF = 2,
@@ -824,7 +827,13 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 				uint32_t val, uint32_t mask)
 {
-	uint32_t reg_offset = (reg << 2);
+	uint32_t reg_offset;
+
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
+
+	reg_offset = (reg << 2);
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
@@ -865,7 +874,13 @@ void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 
 void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
 {
-	uint32_t reg_offset = (reg << 2);
+	uint32_t reg_offset;
+
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
+
+	reg_offset = (reg << 2);
 
 	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 101b120f6fbd..9bae95538b62 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -45,6 +45,9 @@
 #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
 
+#define NORMALIZE_VCN_REG_OFFSET(offset) \
+		(offset & 0x1FFFF)
+
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
@@ -1375,6 +1378,43 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 				    regUVD_RB_WPTR);
 }
 
+static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				uint32_t val, uint32_t mask)
+{
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		reg = NORMALIZE_VCN_REG_OFFSET(reg);
+
+	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WAIT);
+	amdgpu_ring_write(ring, reg << 2);
+	amdgpu_ring_write(ring, mask);
+	amdgpu_ring_write(ring, val);
+}
+
+static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+{
+	/* For VF, only local offsets should be used */
+	if (amdgpu_sriov_vf(ring->adev))
+		reg = NORMALIZE_VCN_REG_OFFSET(reg);
+
+	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WRITE);
+	amdgpu_ring_write(ring,	reg << 2);
+	amdgpu_ring_write(ring, val);
+}
+
+static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				unsigned int vmid, uint64_t pd_addr)
+{
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+
+	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+
+	/* wait for reg writes */
+	vcn_v4_0_3_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
+					vmid * hub->ctx_addr_distance,
+					lower_32_bits(pd_addr), 0xffffffff);
+}
+
 static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
@@ -1421,7 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
 	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
-	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
 	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
 	.test_ib = amdgpu_vcn_unified_ring_test_ib,
@@ -1430,8 +1470,8 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
-	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
+	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-- 
2.34.1

