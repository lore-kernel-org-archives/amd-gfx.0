Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA8BC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 18:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A488410F84B;
	Mon, 18 Mar 2024 18:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvNZUg6y";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B3E10F84B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 18:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q76F0TRG6wdL+A9PaMbD+w5jtVTrgYtrncNEabziSgz0vP56O453qz2y9IJEMjxVN7RPt3VztT1zaWvrIFPOnkf+Zq00mbSiz5eJzfl78wRglIVAI/3wDDbyg0aVk62UzBC3GVIgrJWuXUdzIbomPANQA32rSV7eYT03ayRRuVwsH8R1gTBu/1vAoaOIFx3K79xu+EDmUCKCdoKjYa9sjaZoPYiUpspaaZxWNb+4leLWTodupIo7PMIGLNnCCoDAAIM9qRkFCHJAljT7+WBs28ayU+03BoEFuA+qZrjLJqw5yax+37kl5Z7RJi+75jtwSf21UftUCev42hhV4Z8Q9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2vcTdTjgVcLP4Cz8kum8GEL3hwutGZPZL3rNn/01o4=;
 b=k7vUE7A67ezGxowJCaHCskGLbOQ0hSTEp9SJ/EWAy3tlf1GEaCvhbK9WMiluEcOsDbSn3Jj9vnPxsuiIGW3j3G9mLrrYT7HZsC+HQAGGUVaHuNFd/s13zjPkqIVl7eHy3/d0W1z8+yV5QMjHsVloXAPcYOqEE2eHyOd7RInKCCXcCVmCrW7V3FQ5Schzm5F7RFJqUAQSrFQJ075lVk0f0VVIUfW+1XMT48be9sbMneuwilxl74hRXIMgBzHB9PuNcFoDTFVxKBeenB0MxLWY88PcshDzutRm7QJ2oqaI4gWyjAmq+ldDRslNQKu0YcS2f8SC82nTf1AHuiwkOWdpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2vcTdTjgVcLP4Cz8kum8GEL3hwutGZPZL3rNn/01o4=;
 b=vvNZUg6yakqqanFUV/oG2o0gSejDy3LjC0rRcXLN7bvw6Ds+X+xDu7ND3K9Ow/gU9rUApqML48GZpobpyWapNgHWB7Om2TeP+CeyIDzHsADPoPsNXGm5i0I6y7JcJE0UOOUuTGd0HMYUgCyEiq7/vg1H14ClBRKxF8pwavUHMRg=
Received: from BN8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:408:c0::21)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 18:56:42 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::10) by BN8PR15CA0008.outlook.office365.com
 (2603:10b6:408:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 18:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Mon, 18 Mar 2024 18:56:40 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 13:56:36 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
Date: Mon, 18 Mar 2024 14:56:15 -0400
Message-ID: <20240318185615.880473-3-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318185615.880473-1-samir.dhume@amd.com>
References: <20240318185615.880473-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ef52eb-d8e1-4dd4-01af-08dc477d2554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ka+iebII6KWkNLsh2odABJ+3AQrhflVYn6x96j+1KGKKCWmLHM1VArHR2lxFBW9RwgTczoP3CRaGf3dw5smhPzOVKhYIl9/5b8qsCInFVxtP+DuTLTmng2h4cXXVi7rNci/ybmHz4lJC72/SvToUU1B8BAcWELGQCriF1txN5/aduirKyYYzinPKZEMPSvlA2DrUMNmbToo2vihxCRfuhcBPddQJudqAtEl8pJrIUJf58CRGa0/g7i4XgRIlCJbp++kl+INczAK7ekqQcpcIAh60KBHJXxyvFywpHP4u8FCU8FotCmsJ9GoUHAYdwGjvCwBRrUP1aoV5o0ll3ucIytD7QJD2BMsEj8KY9TfVNUtWlHHIDqhyeY7RUcMBn12bilLCl8O/o2vGFsQK0N5q26iDepf7YAe2HmHBwv7J88/QbaBCSJSYHeC9cpg0bkuLzH0sI8DFtv7RG6QBV1jiilMs9Fq9T8yL3pCwIO3VHf89NnKtzd0mX7LaH0HynLCfIySZ3vxokAP+pFdLd0NGH1eyUZQYf0T0hJ71O6Ic5C1GSYrqurWUdGqPeJyns9RJDkGdb+T+xA4iUBVieIjnyenI4ty0W4AR17l0bvkzTLaLxBmIBn45ZhkRq/W8IAvQGBTlsh2svvvZrncUbG7iHs2n3x5aw63I8PXXag//R4pz6kOWbPlWS2IURczUqBDbV774btoP3fKO9ew6c2RA6l7aDHmcMrXF5QyzYZ8iP9K9cnL7/tQrRHkLcLzdThni
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 18:56:40.0170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ef52eb-d8e1-4dd4-01af-08dc477d2554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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

In SRIOV CPX mode, each VF has 4 jpeg engines. The even-
numbered VFs point to JPEG0 block of the AID and the odd-
numbered VFs point to the JPEG1 block.

                    Even-numbered VFs     Odd numbered VFs

VCN doorbell 0      VCN Decode ring       VCN Decode ring
VCN doorbell 1-3	Reserved          Reserved
VCN doorbell 4		JPEG0-0 ring
VCN doorbell 5		JPEG0-1 ring
VCN doorbell 6		JPEG0-2 ring
VCN doorbell 7		JPEG0-3 ring
VCN doorbell 8                            JPEG1-0 ring
VCN doorbell 9                            JPEG1-1 ring
VCN doorbell 10                           JPEG1-2 ring
VCN doorbell 11                           JPEG1-3 ring

Changes involve
1. sriov cpx mode - 4 rings
2. sriov cpx mode for odd numbered VFs - register correct src-ids
(starting with JPEG4). Map src-id to correct instance in interrupt-
handler.

v2:
1. removed mmio access from interrupt handler
2. remove unneccessary sriov variables

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 +++++++++++++++++++++---
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 32caeb37cef9..d95ca797412c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -68,6 +68,11 @@ static int jpeg_v4_0_3_early_init(void *handle)
 
 	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
 
+	/* check for sriov cpx mode */
+	if (amdgpu_sriov_vf(adev))
+		if (adev->gfx.xcc_mask == 0x1)
+			adev->jpeg.num_jpeg_rings = 4;
+
 	jpeg_v4_0_3_set_dec_ring_funcs(adev);
 	jpeg_v4_0_3_set_irq_funcs(adev);
 	jpeg_v4_0_3_set_ras_funcs(adev);
@@ -87,11 +92,25 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
 	int i, j, r, jpeg_inst;
+	bool sriov_cpx_odd = false;
+
+	/* check for sriov cpx mode odd/even numbered vfs */
+	if (amdgpu_sriov_vf(adev)) {
+		if (adev->gfx.xcc_mask == 0x1) {
+			if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
+				sriov_cpx_odd = true;
+		}
+	}
 
 	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 		/* JPEG TRAP */
-		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		if (!sriov_cpx_odd)
+			r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
 				amdgpu_ih_srcid_jpeg[j], &adev->jpeg.inst->irq);
+		else
+			r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+				amdgpu_ih_srcid_jpeg[j+4], &adev->jpeg.inst->irq);
+
 		if (r)
 			return r;
 	}
@@ -116,10 +135,14 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 					1 + j + 9 * jpeg_inst;
 			} else {
-				if (j < 4)
+				if ((j < 4) && (!sriov_cpx_odd))
 					ring->doorbell_index =
 						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 						4 + j + 32 * jpeg_inst;
+				else if (sriov_cpx_odd)
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						12 + j + 32 * jpeg_inst;
 				else
 					ring->doorbell_index =
 						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
@@ -186,6 +209,7 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 	uint32_t size, size_dw, item_offset;
 	uint32_t init_status;
 	int i, j, jpeg_inst;
+	bool cpx_odd = false;
 
 	struct mmsch_v4_0_cmd_direct_write
 		direct_wt = { {0} };
@@ -197,6 +221,12 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 	end.cmd_header.command_type =
 		MMSCH_COMMAND__END;
 
+	/* check for cpx mode odd/even numbered vf */
+	if (adev->gfx.xcc_mask == 0x1) {
+		if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
+			cpx_odd = true;
+	}
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
 		jpeg_inst = GET_INST(JPEG, i);
 
@@ -220,10 +250,14 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 			tmp = SOC15_REG_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE);
 			MMSCH_V4_0_INSERT_DIRECT_WT(tmp, ring->ring_size / 4);
 
-			if (j <= 3) {
+			if ((j <= 3) && (!cpx_odd)) {
 				header.mjpegdec0[j].table_offset = item_offset;
 				header.mjpegdec0[j].init_status = 0;
 				header.mjpegdec0[j].table_size = table_size;
+			} else if (cpx_odd) {
+				header.mjpegdec1[j].table_offset = item_offset;
+				header.mjpegdec1[j].init_status = 0;
+				header.mjpegdec1[j].table_size = table_size;
 			} else {
 				header.mjpegdec1[j - 4].table_offset = item_offset;
 				header.mjpegdec1[j - 4].init_status = 0;
@@ -1015,16 +1049,28 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
 		break;
 	case VCN_4_0__SRCID__JPEG4_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
+		else
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
 		break;
 	case VCN_4_0__SRCID__JPEG5_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
+		else
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
 		break;
 	case VCN_4_0__SRCID__JPEG6_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
+		else
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
 		break;
 	case VCN_4_0__SRCID__JPEG7_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
+		else
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
 		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
-- 
2.34.1

