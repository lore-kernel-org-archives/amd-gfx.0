Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3275DC5478C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 15:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68D311228E;
	Mon,  4 Mar 2024 15:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ft65RSa";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CC511228C
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 15:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpXLs6Cndmb0wyExz2UO+ZDJUJedB0hIG9n93Lu20dO6IQJHeQauWWBqPr0ebA3g4PWbGHnzItIC+5pLYVgxm201umS1vqHA2/FOIvvv28ky6i28fHeGIJlp+lSAeaXYHykCFanalpMnA5LFXwVU/uCoFsp3qflqCGvJTvCaziPW4gIJZmDGNBEnuwll54w00i4rXXkt7Zq0mBOxUkTiq/ycfzN6hlxdgHXGCQ4blX3xvRtnbcxBbYm3KD+g2fosd1N5Hqa8Qds1V3HPUgkwFfPR4kjm0pg35mp9h5d+Ety7EC1X21T/153tNdbGC5uiypl4DKC5bjISTMMp7ngYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG1t6K0Y4LcbvzFlhe7xg423QX2VY/qOrnUsh0oY52E=;
 b=QnpvckasTdEsBP4qGEdCNf4ThthtxKlzdL5m52wHRZtzwlD+V6xqNnYBzDJhmw8l06BoH44Q96nXiZsvUzuAyNoSa/dFcqIBNxdueJ4qUhTnVOwUqt+TS/bWwBMND6RznXBeDZkTjUjUQSjL/xNdGvz7TikXLG78/kYu94xZcFkFkKEr9Ayu18mcoW7pn7Vs7hn48qhtca6wiwDwBW5dxWDdVuaAyRl2kih2nnAB/PSJxxjm33D0TESUKpiD+S5Xkt5cvW6hdZkNBu9Ki8h9pHfifCU1j6n031wJQGhOLX0d67m9InMugUDGM5Q96S0jWXxB4BfnIZS1sbuBGX+/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG1t6K0Y4LcbvzFlhe7xg423QX2VY/qOrnUsh0oY52E=;
 b=1ft65RSaz0WLIxIypMGF4/DVZd6hgeFQyAUnvU+HlfkOa8gYY82yqbinX7kTBQYf3OMr7DTt/X88s3y2q9VBOZv0n/+05T/yy6sfV0ndlxL4GWTJU2I5FZ+7tqK3sBjrbed7BrNviKEJoswgqOdJvz0OmTezXv4uR9XmztR14Fc=
Received: from DS7PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:3bb::31)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 15:20:06 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::31) by DS7PR03CA0086.outlook.office365.com
 (2603:10b6:5:3bb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 15:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 15:20:06 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 09:20:04 -0600
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
Date: Mon, 4 Mar 2024 10:19:31 -0500
Message-ID: <20240304151931.802397-3-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304151931.802397-1-samir.dhume@amd.com>
References: <20240304151931.802397-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8ac84d-cd4c-4422-b5bb-08dc3c5e9290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfxGIx9kMCI3A3hE2dogM6laCEFAd3ExvfnnctJINwVfAgH315lQX+f9TBjIiDYf5ZGuCaGdUMh6ehxHHIKdPVxoeDXGIwbc5g6qwQr3gx6+QE3j0mofGoY89FlD/cEBSPTnxRnzpUUokb+DhNu1NDcwqD6497kpKE/l9HB29XtuDn4ozXvZmxMVNZaGMzL1RW4TJ7xBqrc6IbwMIwCqGarwU3DrG1HIbc4db0WAFw8R+Vf/am3c9tBhcR6EWlt7kmHvUGKVEih2vVkuTPo13JsV9wjWgw8if4XfpH8l/Qie3OpX9hXn2ridgoCMzoOuPhFDVlRQn3IEFFHUGTscRmIFzE2xxZF3ZuOahF7zr/T9Xsax/C5DEuI49752ltUDNI3vOvUwUXeVrgonDMzmjdM0Aiaa1yVnetLW7XgBwowBMlrwBL7xVkr53NhzzR4QFtHkM0VZOgjIR4ZLd9u8+bhcd1EgKEwqQe1qPIq+vkyrT6SeppPMqKmsKONW9TryFR7GbkCXiLL84uaC3hpSNczY+dnnu89lkRUatbpZ+lztIwGT6EBHVM6V/ig8sTI49RVMH/wmopGg/RX8dXipdnNr8df1P0LWj+y9rvMdqWDO9VnAG6SQWnVPw/Y9Anardk1cV3lCIRyM8tyAGvoqN3/Dzxx/gNqUZBVV9OnMgNCAVsYc4+ryaZfB+T/lV7SORHmsBrZmE3Tz69O1m1HKORpKi2UKVvAxG6wU6vQnHTC9YSpYuldG6VzZkkbNHfpt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:20:06.2379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8ac84d-cd4c-4422-b5bb-08dc3c5e9290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 80 +++++++++++++++++++++---
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 32caeb37cef9..4bf087f8ca2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -65,9 +65,15 @@ static int amdgpu_ih_srcid_jpeg[] = {
 static int jpeg_v4_0_3_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
 
 	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
 
+	if (amdgpu_sriov_vf(adev))
+		if (adev->xcp_mgr->funcs->query_partition_mode(xcp_mgr) ==
+				AMDGPU_CPX_PARTITION_MODE)
+			adev->jpeg.num_jpeg_rings = 4;
+
 	jpeg_v4_0_3_set_dec_ring_funcs(adev);
 	jpeg_v4_0_3_set_irq_funcs(adev);
 	jpeg_v4_0_3_set_ras_funcs(adev);
@@ -88,10 +94,28 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int i, j, r, jpeg_inst;
 
+	bool sriov_cpx_odd = false;
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	int mode;
+
+	if (amdgpu_sriov_vf(adev)) {
+		mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
+
+		if (mode == AMDGPU_CPX_PARTITION_MODE) {
+			if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
+				sriov_cpx_odd = true;
+		}
+	}
+
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
@@ -116,10 +140,15 @@ static int jpeg_v4_0_3_sw_init(void *handle)
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
+
 				else
 					ring->doorbell_index =
 						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
@@ -186,6 +215,9 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 	uint32_t size, size_dw, item_offset;
 	uint32_t init_status;
 	int i, j, jpeg_inst;
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	int mode;
+	bool cpx_odd = false;
 
 	struct mmsch_v4_0_cmd_direct_write
 		direct_wt = { {0} };
@@ -197,6 +229,13 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 	end.cmd_header.command_type =
 		MMSCH_COMMAND__END;
 
+	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
+
+	if (mode == AMDGPU_CPX_PARTITION_MODE) {
+		if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
+			cpx_odd = true;
+	}
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
 		jpeg_inst = GET_INST(JPEG, i);
 
@@ -220,10 +259,14 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
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
@@ -986,6 +1029,16 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_iv_entry *entry)
 {
 	uint32_t i, inst;
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	int mode;
+	bool sriov_cpx_odd = false;
+
+	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
+
+	if (mode == AMDGPU_CPX_PARTITION_MODE) {
+		if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
+			sriov_cpx_odd = true;
+	}
 
 	i = node_id_to_phys_map[entry->node_id];
 	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
@@ -1015,16 +1068,29 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
 		break;
 	case VCN_4_0__SRCID__JPEG4_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
+		if (!sriov_cpx_odd)
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
+		else
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
+
 		break;
 	case VCN_4_0__SRCID__JPEG5_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
+		if (!sriov_cpx_odd)
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
+		else
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
 		break;
 	case VCN_4_0__SRCID__JPEG6_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
+		if (!sriov_cpx_odd)
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
+		else
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
 		break;
 	case VCN_4_0__SRCID__JPEG7_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
+		if (!sriov_cpx_odd)
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
+		else
+			amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
 		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
-- 
2.34.1

