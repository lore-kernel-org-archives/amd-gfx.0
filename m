Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05248C54E6A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 19:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4594C1124AB;
	Fri, 15 Mar 2024 19:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tu/+lYej";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097EF1124AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 19:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPwy79jfiDFRC5JdyfMH/mImZbRLvS9cldZsCn1ZC4usiVyUTSbHON1mq2y3iXj5VhYRErtz0fbuGj5wNKIbYXjMtHmKgliKzWtxs91J7pAKjLZQaq+EDSPA6O+50Vf5mRAhKK0Qh0Apq73irfKI2S2DVLuDzuRAxMWnHa6+sZkewoxdhkuRhQJ3/z7B5YQJmgJMMSFeYGF6o9/3rUolP8iuccC5To0aKC5E1xXcS7gaIbO9ZeQLplj1611pclpmRM7L3zM6Xgq/c1m+36DeCEd2JnQEdYYxW2ZI19NWWrjwWiVmPaCUkWfv8oQYGoACzDqneERp0Pa8SOfc3KJjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0QH7p82eIx9lIYFZTGfV/qXV2mDcsHZhdDT5A5xZoA=;
 b=ck9mCvgfygQNHRVDzlce7jQKHGmtMRAfw62dT3lWaYgDxkg2cvAU58jcftJYv59vZWMsKJOn3h026v0G3R2XZX1vEFltEXzD8VYClzM5JlIDrx/Bfv67nTGgNFxNFYBM5mEZzTg1tcbe5VthRqpabjxYGuwx5hpnys8Z6MEaFkJ4JQuJmCVKtsqocLaCyqPledx1CxGxZhBT8EPwAQbP9oKFcnqB3phOLrAl3Q7c6jDYOur6kxcUWq2CaQrYAgTZR+3cuTTefhTFCkZHA7RWdqb6RS2dLJMIFOG9F3uo6ucblH/nac4i49jtitQ8EDhFQ2CP/3wTHJbu3+csCw4UWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0QH7p82eIx9lIYFZTGfV/qXV2mDcsHZhdDT5A5xZoA=;
 b=Tu/+lYej6Dgrp1CyVSULgQf+joS7JtEX8JzGaqhB72GLxG4V+GHJQrMGB7XWjgm2fMkHod8u7BLf0MHuXngHfR0qSDSSKglTUFB0OuutQW/3N+9Iy9UZmSONbxJvNElnum1jZ9jTIxYPg043606u9BvBc26SFceHW+Gy3K7on0o=
Received: from BY5PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:180::33)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 19:51:37 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::4) by BY5PR13CA0020.outlook.office365.com
 (2603:10b6:a03:180::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8 via Frontend
 Transport; Fri, 15 Mar 2024 19:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 19:51:37 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 14:51:34 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
Date: Fri, 15 Mar 2024 15:50:59 -0400
Message-ID: <20240315195059.862846-3-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315195059.862846-1-samir.dhume@amd.com>
References: <20240315195059.862846-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca589db-958a-41ed-8671-08dc45295339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZ8m9Jji7AOoxvCQp0ZaZROLIKhLl9AEWWOGg2a7f3oeUkGrv8gh6I4wfi18aOQHn8D3pWURxO2do0nRHSOqyjVRz2Es6TG6k7OQy9TuYyDW8I2HaJ7DxJMEbzfaPyusYlcDelS6DXqx+Mot/OAkfV5HXAQFdePw3fSl+oJuEqCN2xsstkhnKESdZwFDyn2UwUrKqw7Q0EJwJJlvj+quFD4QRz6n9BfkhDrwSF5o//HbTQFcQCQFJ1dm2HytlVSTDGbOCLSpBfLGSexijfmp2CQM954WFxZub2ZRciUu+WqH1hX7d8LVRmZJcNcak33LQ8zBszsuO4hH0oEt6NhoUWmo7na8sMPWA5/bEYz0MNhs1/fdFdnpbNrXmiSCmDtcvuoaY/WDngBjdIgUxLV+yCHm8MRNtfYUJSN7fsMscVCEDJ595raMa28wDRLTD3zDYMaPjj9pKa2SlfygB2SqBAZPwclne5x8aqsIhldpgZB0dENElyWaWsMEQ3tWZFIV7FIXe1NEiChCX97681ipTbt6eWk+Y2Q+G1X1EQ7hLkwVhQ0wKIOJWTFRLsITffI4Z6VwTU8W7DxYmkzss40A8NT7ZbGpe+6Qn6na5eMK+vVIjuIHnA/ZjlyojJx9Hp/PAYKdZDzP40ufci+U8fgjAgc89NO1eOPUKJyikcjbH+kYoDqt20QwtRqD4QMOjig3O0qJ3G6mBf0DALqmb2x+WJL9ooiRv2GhNaSXnRobEF0lxV2GfMWkWrBe9n+jA5yb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 19:51:37.0772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca589db-958a-41ed-8671-08dc45295339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806
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
1. removed mmio access from interrupt handler. Use xcc_mask to detect
cpx mode.
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

