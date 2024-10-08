Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91E9CF0437
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C2610E5E7;
	Tue,  8 Oct 2024 21:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ogCJCYtJ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432B010E5D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncr6DhOjfJQQnp4yfkwIPaPhhEPp4fhJmNNyaXxo68ug+0jDwfopDLykFXYi3kWLg8Ip+3JmPN3gY80P5B9JoPcGFa0JLYHzpzyqEQJoC3fzQbw9Wfcn5gY6RRavED+QgYeAiZoQtD/zJap5UUoX4bbaPPIwV669VDA8xrA3xyt3Ir8tsk3iD9I1AzIjt4qvLlTXEBg8/xkC/bZLuVleKF5jUssfI1mUX3HmEelcpNxaMx/Y9GjUfx9PfnbOHysqYdD1CicAz3v7OvTR/JfXBjKHQJliuPmw/fgWo3hy6rSog8yMIJWrW0YZySWxRxEj2a9lHq7IHf03H08jMNcxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65fjtnw2qcXAhVUpMjqD3fZxOXFdWTZXBQ/sVFlov9U=;
 b=rf8v2uyTDue3Z977z6uri+XIfNwngRUu3bV3mOOOq2/qxYXb8ck8ij2Fv/2TYKMejeeXlnCi0xubW5paS65CMCGQEdFhI986pB4Q+r88b3oo+0En0nwKo2HGi/mwo+eaoAY3XZtjmzHCfGW3n2VGo7bCVcfu+LtioeVtVnYQx11MFZoqVwVwA8205mLeShUaqgHohlMQGuZJD0iZK3k+qJVk3QQYDfn/XaNzlBEJo8tIavXFlq9qehTDVa/HRQ4Qjl48ELY9OTKs+INTEyatonggcR12sDaeQSl3QgcfHMYxE5v/a7iIofTtVSNsP9Uyqpd8qkfpKYnVuNqOt4Q3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65fjtnw2qcXAhVUpMjqD3fZxOXFdWTZXBQ/sVFlov9U=;
 b=ogCJCYtJQ9rMRHJCYBBC9g29tFIWNv5F28e+mLCclDfi7HwY5rzt+bkWmZmayu83fEMsJCbocjHglBWCZyL+oUOGkCfZ1BFfFVm5H2Oo5haxvVhpVjyUvos9z9GUcb6awkT3rfMItuIVYgtJvgqy/7GWau0BS2JkaBpb5ukUhLU=
Received: from CH2PR05CA0032.namprd05.prod.outlook.com (2603:10b6:610::45) by
 SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Tue, 8 Oct
 2024 21:16:32 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::48) by CH2PR05CA0032.outlook.office365.com
 (2603:10b6:610::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:31 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:27 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 23/32] drm/amdgpu: hw_init for each vcn instance
Date: Tue, 8 Oct 2024 17:15:44 -0400
Message-ID: <20241008211553.36264-24-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: d71e5b46-0d48-4eff-e095-08dce7de7b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aAFMvGAtQOOC0hOmioKRW1uFBkuXlyx2xd5gcKEzNr8Eebs69JePd2+qnkM6?=
 =?us-ascii?Q?QAJcloKtoonlScHVhEsr0rgOKhdrKr7gzjETO3SepCytK29/5bbS2q/m6XQF?=
 =?us-ascii?Q?6RRHGc9eDvWrpmar5vGANHRwDTi8iG6CWD86EV3btxTVxloe55kKpGvhhKfA?=
 =?us-ascii?Q?X3gZF8VcA9Q9ClbH9dnjoyBxC/bKZ4XJQ/WUi33V4p/NKeE9dXo7itOC29h4?=
 =?us-ascii?Q?yN3mhcqi4lhj4ATOchRNkvz+yadEDScJzqrU3U0OHG5PN/2lNucnmeco04Ha?=
 =?us-ascii?Q?DBCoL/4gw1LapbHQV7UmSYlhuc0e5TWqQ02QmvG5QbcfqUiH065cuddUVzif?=
 =?us-ascii?Q?Dw93yH+/31T8xoHcYCKjRdRTstJujyZCg4DGfAa8zDf2IFUAcf1F2lQQof/t?=
 =?us-ascii?Q?txZOd3GALR3JTQLgeCwtVklr8JADN7iMu0PnlGPP/cK+3nIyrWxXZjbyzTpo?=
 =?us-ascii?Q?nrRwa1GyZv5K/hQwS8Q1ER/eosDsF5YSz3KQXlr7HqcdGZjA9tbSaihGCMld?=
 =?us-ascii?Q?ZbJd7JaabYs8dX1iTe62yNnoqg8wSY2L2e/o4KqmqNOt4gevcsekl94tRXRq?=
 =?us-ascii?Q?F1KAyOBlzSw3O9aUjcLr8DmWZ/eTbv1B7dl+dxU6LYdMPF1xpmg/YIQI/bsy?=
 =?us-ascii?Q?Ra0mwqlTZo7xCxXMInD2JJc4rpRwbczaUo5My5LI96hup045Tn/bBVYUGVcv?=
 =?us-ascii?Q?XJEGdGc8x0jOKGzm1Er9cXyoGaKjXWZozewmNONvcjIYlMErhzh0dGUbzqA0?=
 =?us-ascii?Q?h2E4lNjdo+Wm/CNENmOQkJ1QM8EJKdZwKvCs+eByb8g+Yz9mYSnEpiRTRJ23?=
 =?us-ascii?Q?+W+/ShWKW0jcxC4xtxpgVbayyaKlUJVpMr5tR3AExgOubKFoU9oY5slIo42G?=
 =?us-ascii?Q?nM3STo48cqmPpp1lAXnRBlcKf+C25lNu+nrHPHkdl0SKtTXYVv8psZl76oT+?=
 =?us-ascii?Q?oSBlkn6pLogeAInClGgfJvuf2FGGOxdsFJLMpPCr/U8CTcF6adpVjNA/a9kc?=
 =?us-ascii?Q?n3JxmXBelaKw9LptEnokyibiwxaoGrb86jXJa+Wg3xganpGfSfiHLQhQ3eP6?=
 =?us-ascii?Q?1dUdD9QYQA7xbQ+9IfP828HAMnvypME6kSQv37wwiAtKV+fOIWjv9X1QApS0?=
 =?us-ascii?Q?1aHuHhfamLj2eMRhcNm55yxiracOg4HyzFzGumW3FcOkMVFLGzsKAt2mRogk?=
 =?us-ascii?Q?PA0j3EhWG86tCm0wYfPUkUt/aj48vUmdrMpJRK7Wfmpx0cHWjoSWnbYeXq6s?=
 =?us-ascii?Q?iZQtoXlJvzDlYQ3yvBHMlLfZP62gcFSiJI+IljVJOsvsmstr1PslbAqaRDR4?=
 =?us-ascii?Q?HrxH6FX4kbsOnK+b1sdUaIE85I/lLn+RsrfycvxWvaZ1Blf2Yd80Ztn7Vopi?=
 =?us-ascii?Q?rro0Lsk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:31.6701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71e5b46-0d48-4eff-e095-08dce7de7b64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_hw_init(), and perform
hw init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 39 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 73 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 37 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 67 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 ++++---
 6 files changed, 123 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index ed972d843f93..f225a0b214d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -338,37 +338,36 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, j, r = 0;
+	int inst = ip_block->instance;
+	int i, r = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		r = vcn_v2_5_sriov_start(adev);
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return r;
 
-		if (amdgpu_sriov_vf(adev)) {
-			adev->vcn.inst[j].ring_enc[0].sched.ready = true;
-			adev->vcn.inst[j].ring_enc[1].sched.ready = false;
-			adev->vcn.inst[j].ring_enc[2].sched.ready = false;
-			adev->vcn.inst[j].ring_dec.sched.ready = true;
-		} else {
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.inst[inst].ring_enc[0].sched.ready = true;
+		adev->vcn.inst[inst].ring_enc[1].sched.ready = false;
+		adev->vcn.inst[inst].ring_enc[2].sched.ready = false;
+		adev->vcn.inst[inst].ring_dec.sched.ready = true;
+	} else {
+
+		ring = &adev->vcn.inst[inst].ring_dec;
 
-			ring = &adev->vcn.inst[j].ring_dec;
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+						 ring->doorbell_index, inst);
 
-			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-						     ring->doorbell_index, j);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 
+		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
+			ring = &adev->vcn.inst[inst].ring_enc[i];
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
 				return r;
-
-			for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-				ring = &adev->vcn.inst[j].ring_enc[i];
-				r = amdgpu_ring_test_helper(ring);
-				if (r)
-					return r;
-			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c45bebeb0aaa..2d1835d06ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -345,8 +345,9 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int j, r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v3_0_start_sriov(adev);
@@ -354,57 +355,53 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 
 		/* initialize VCN dec and enc ring buffers */
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return 0;
+
+		ring = &adev->vcn.inst[inst].ring_dec;
+		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, inst)) {
+			ring->sched.ready = false;
+			ring->no_scheduler = true;
+			dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+		} else {
+			ring->wptr = 0;
+			ring->wptr_old = 0;
+			vcn_v3_0_dec_ring_set_wptr(ring);
+			ring->sched.ready = true;
+		}
 
-			ring = &adev->vcn.inst[i].ring_dec;
-			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
+		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			ring = &adev->vcn.inst[inst].ring_enc[j];
+			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
 				ring->sched.ready = false;
 				ring->no_scheduler = true;
 				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
 			} else {
 				ring->wptr = 0;
 				ring->wptr_old = 0;
-				vcn_v3_0_dec_ring_set_wptr(ring);
+				vcn_v3_0_enc_ring_set_wptr(ring);
 				ring->sched.ready = true;
 			}
-
-			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-				ring = &adev->vcn.inst[i].ring_enc[j];
-				if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
-					ring->sched.ready = false;
-					ring->no_scheduler = true;
-					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
-				} else {
-					ring->wptr = 0;
-					ring->wptr_old = 0;
-					vcn_v3_0_enc_ring_set_wptr(ring);
-					ring->sched.ready = true;
-				}
-			}
 		}
-	} else {
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+	}
 
-			ring = &adev->vcn.inst[i].ring_dec;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-						     ring->doorbell_index, i);
+	ring = &adev->vcn.inst[inst].ring_dec;
 
-			r = amdgpu_ring_test_helper(ring);
-			if (r)
-				return r;
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+					 ring->doorbell_index, inst);
 
-			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-				ring = &adev->vcn.inst[i].ring_enc[j];
-				r = amdgpu_ring_test_helper(ring);
-				if (r)
-					return r;
-			}
-		}
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+
+	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		ring = &adev->vcn.inst[inst].ring_enc[j];
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c87b4e46f2b0..afe2eba9aac4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -299,37 +299,34 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int inst = ip_block->instance;
+	int r;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v4_0_start_sriov(adev);
 		if (r)
 			return r;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return 0;
 
-			ring = &adev->vcn.inst[i].ring_enc[0];
-			ring->wptr = 0;
-			ring->wptr_old = 0;
-			vcn_v4_0_unified_ring_set_wptr(ring);
-			ring->sched.ready = true;
-		}
+		ring = &adev->vcn.inst[inst].ring_enc[0];
+		ring->wptr = 0;
+		ring->wptr_old = 0;
+		vcn_v4_0_unified_ring_set_wptr(ring);
+		ring->sched.ready = true;
 	} else {
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		if (adev->vcn.harvest_config & (1 << inst))
+			return 0;
 
-			ring = &adev->vcn.inst[i].ring_enc[0];
+		ring = &adev->vcn.inst[inst].ring_enc[0];
 
-			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
 
-			r = amdgpu_ring_test_helper(ring);
-			if (r)
-				return r;
-		}
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0b55d801ae88..0dc26dc173cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -257,49 +257,46 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r, vcn_inst;
+	int inst = ip_block->instance;
+	int r = 0, vcn_inst;
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v4_0_3_start_sriov(adev);
 		if (r)
 			return r;
 
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			ring = &adev->vcn.inst[i].ring_enc[0];
-			ring->wptr = 0;
-			ring->wptr_old = 0;
-			vcn_v4_0_3_unified_ring_set_wptr(ring);
-			ring->sched.ready = true;
-		}
+		ring = &adev->vcn.inst[inst].ring_enc[0];
+		ring->wptr = 0;
+		ring->wptr_old = 0;
+		vcn_v4_0_3_unified_ring_set_wptr(ring);
+		ring->sched.ready = true;
 	} else {
-		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			vcn_inst = GET_INST(VCN, i);
-			ring = &adev->vcn.inst[i].ring_enc[0];
-
-			if (ring->use_doorbell) {
-				adev->nbio.funcs->vcn_doorbell_range(
-					adev, ring->use_doorbell,
-					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-						9 * vcn_inst,
-					adev->vcn.inst[i].aid_id);
-
-				WREG32_SOC15(
-					VCN, GET_INST(VCN, ring->me),
-					regVCN_RB1_DB_CTRL,
-					ring->doorbell_index
-							<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-						VCN_RB1_DB_CTRL__EN_MASK);
-
-				/* Read DB_CTRL to flush the write DB_CTRL command. */
-				RREG32_SOC15(
-					VCN, GET_INST(VCN, ring->me),
-					regVCN_RB1_DB_CTRL);
-			}
-
-			r = amdgpu_ring_test_helper(ring);
-			if (r)
-				return r;
+		vcn_inst = GET_INST(VCN, inst);
+		ring = &adev->vcn.inst[inst].ring_enc[0];
+
+		if (ring->use_doorbell) {
+			adev->nbio.funcs->vcn_doorbell_range(
+				adev, ring->use_doorbell,
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					9 * vcn_inst,
+				adev->vcn.inst[inst].aid_id);
+
+			WREG32_SOC15(
+				VCN, GET_INST(VCN, ring->me),
+				regVCN_RB1_DB_CTRL,
+				ring->doorbell_index
+						<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+					VCN_RB1_DB_CTRL__EN_MASK);
+
+			/* Read DB_CTRL to flush the write DB_CTRL command. */
+			RREG32_SOC15(
+				VCN, GET_INST(VCN, ring->me),
+				regVCN_RB1_DB_CTRL);
 		}
+
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b88fdb00cc5e..36e4477c99f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -268,21 +268,20 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int inst = ip_block->instance;
+	int r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
+	ring = &adev->vcn.inst[inst].ring_enc[0];
 
-		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 15cdc7be9062..687d413a50b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -232,21 +232,20 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int inst = ip_block->instance;
+	int r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
+	ring = &adev->vcn.inst[inst].ring_enc[0];
 
-		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+		((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst), inst);
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
 
 	return 0;
 }
-- 
2.34.1

