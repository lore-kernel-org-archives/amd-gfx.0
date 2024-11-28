Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC73D69113
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE9810ECAA;
	Thu, 28 Nov 2024 14:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QeernLjC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925BD10EC97
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VezD5ZX0VuehNvylTTdTqMXq6cn1mblo8oSv0oZi62NwNfjs2lE4kFkKcprj9wNnvzvOMA16lHa65aOy6L8knFZEoIgRGDhEy6bgBuZZpiEjHQsWeERv5c0A/NGb76m1R9KWlheRiRtrj1M05LzqsQlTzmV2zx/LpMVVQJM7rCVZCjq9nR7c27YqlHZbjWEbe7qc0P+nNUzTFORwUg5fq3J83mqb6DqlFoV0bek787wY3PX3gVVx5oBx156HW933chULceQu6MV1qaR+I9ROpTo6//IBVNEj7YQ15cAOJOkbSDe/TU3050mm8lDLS1i6g/eJ8MrhDC812/7ZQFBo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVKj4nXYnPyxiHZfPXNyC3U4QRUptTV+cMDMg9O8TUI=;
 b=O3VkX/VjHTG/LQuD8NGGhCMFfdGZlbrn+p1+v3HAEAycpKIP3YKjdalWwJpt9+ViyElYm6iBS2kWiUtvw4S4Fe/k4l+mUy8ITuN+BDWjZexy2dcmzKMTiRpFPzPvaZHl1U9YYsjmcOywv7+SPfBdwz9ydBFXZW0uPXWuyDiK4SFNqjkpi2e7V/r712a1OVTCzsGs7wxNoiPUstfM0XVkXxXkYKRbjlGLNO61v7Okt7/9HygnlOGBFbwo/2XzYKDCdIr+iiqi7wNyb6iGI5UDR+N3jrNYLUuBKlD/ziZPNtEyL2HFImZF6iL04gjsgtIdKRL5+TeErVy4ZmtIg4FYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVKj4nXYnPyxiHZfPXNyC3U4QRUptTV+cMDMg9O8TUI=;
 b=QeernLjCvX2r2IGeHZqPvJsiQUWTk02hMIU9YEO9NC+z5Yk0V//X97cPDmANXYGgDntcLXijp7IhaHK+XiVusmkaOCpKMNGP50ceWYivJZiVsE1o5plOaQOU0MpLsd8t5F6AoO3ZOP0+ts1FkGUupuoG82sBrpc7QCrnZP5VXUw=
Received: from BY5PR16CA0011.namprd16.prod.outlook.com (2603:10b6:a03:1a0::24)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 14:30:26 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::db) by BY5PR16CA0011.outlook.office365.com
 (2603:10b6:a03:1a0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Thu,
 28 Nov 2024 14:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.0 via Frontend Transport; Thu, 28 Nov 2024 14:30:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:24 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:23 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: rework resume handling for display
Date: Thu, 28 Nov 2024 09:26:30 -0500
Message-ID: <20241128142958.28370-9-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbb4aa4-5a77-4cec-15e4-08dd0fb93337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gjnrT1rm5Hq4L+2AErfw8MDuMxUhjQY6jOxUyk72NqXRPEJFriKkpp8BV7Uv?=
 =?us-ascii?Q?qD5LTla1rvAvhNXwoI/KltcEYJdVzWfNFbGixoULoYsxly1w0UYKvChctlRa?=
 =?us-ascii?Q?lUEawoMAdyXsn40Bnb/F4G9yKj9u/ssG7mvWeG98oGTNe/s3JMjn3yk5+J7S?=
 =?us-ascii?Q?oSLpN3+qxMrPU9GrZxjY50uKPPXppfdP8TiJXe7Zm6eGJRUU2lgwePV90G88?=
 =?us-ascii?Q?hmReVX/ofgZAGv2lF/FXi8XvQm0gumxRnH2anSjzyCy9IMY94xJ83kbdrYOZ?=
 =?us-ascii?Q?4+3RfjBq+n5ulrtkzMBcyueWC1fuaz9X8M+mjaoZUGymXlaBxgaCdHhF49vv?=
 =?us-ascii?Q?DMH1I4I1ZehPHkmMJ5oyKxZGVa1Hi6QIyAqSxjmpLfCoyomyp/1xeK31rvfK?=
 =?us-ascii?Q?b11hszZIDzul7m0dsp8z4IhUvMvMo9m7TVwLe/0fv/QXsXd5wRfabLhf91VT?=
 =?us-ascii?Q?djd07O1+8REbzM7ScXEWW9ShS2GNMMVyK31rf04ikHeZ4UEPNkZMTUTd/rG2?=
 =?us-ascii?Q?yxtKLkCZFH0Bvmm2QsTHTifENvB4pkL8TL56m/mDGVQgwz4qH2M3OcKij6lX?=
 =?us-ascii?Q?s/aFuIluytvI+D3K3ep3uYz8Dwu23sK6e5hY6dIGIOAfbw2SIJUGbl72S1a1?=
 =?us-ascii?Q?Ys7m0Me98Vaz1pdj8I5azfkCK8sUcZsJUK6iv+9IvESJfLZKAtZlniSeh3vX?=
 =?us-ascii?Q?lgPh+F5QcRaCLuZNP2CodRVs3wulGyyhS3nF5IgSw4JPfHPExlpzmUmadaWz?=
 =?us-ascii?Q?s+HBi921yj60Lnn5q5IXJul972rYxxsDaTgEvpj5mhBOyk5W6F6moQJYU0P8?=
 =?us-ascii?Q?36FDJyjeOINwQkZhQzf6tKWJEVjBlkDzFsQcskAGEosFQq454ayVSDb5s7kH?=
 =?us-ascii?Q?+GMrutaJQKpZRb/lABV0kpI71h1GGH3HXZXO4ChpSj8dS0SgNVs+paJgPXos?=
 =?us-ascii?Q?UIE6RSVjIUOMz/xDNgfE3MghJkaV721bT7bcMKVVt7tk7Mnz9vVlV67ZV5HG?=
 =?us-ascii?Q?ewWL8BYpT6C5yH4n1PNLmeRQvG0MWyKFLai8kiINuk+8ocjSy4/SazTWQ+rn?=
 =?us-ascii?Q?29Te56PM8gX1Dbl0h+k+vGt6FO856ppvRWzGWoRuQ47oxOiF3+RAPvWPyXMm?=
 =?us-ascii?Q?j9Ply/Iu/5h9gUY+ExpHKqsLhLSRw5Dh1itlEfQrQ58cVYolMIy5vHWhrdgc?=
 =?us-ascii?Q?RSllY4Llm5oeqoOce8O7VP+XrmAC/v+oFs2Z9vAcOkejHfSbrezj3BpXfYUK?=
 =?us-ascii?Q?C3l6iIn/4dwJZ8qOhk7y2ettT/sHJBwzn0z85cM6wxyTjk1hgWppaxQhrS1e?=
 =?us-ascii?Q?yCAEDFzqxfdHa2OhH/uB8q3okKG6AToXwXaet+ZJel0v4kPcMp4ZhNwj3Dkm?=
 =?us-ascii?Q?FdAGu4/r24vTqlldw/612Lw0gWyZ7mPjBwd7XCU2DuTYjxsCaJgi7hXVo+os?=
 =?us-ascii?Q?5O/WVgWail07NKrdNoazmDf9Fco6pNGw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:25.7530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbb4aa4-5a77-4cec-15e4-08dd0fb93337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

From: Alex Deucher <alexander.deucher@amd.com>

Split resume into a 3rd step to handle displays when DCC is
enabled on DCN 4.0.1.  Move display after the buffer funcs
have been re-enabled so that the GPU will do the move and
properly set the DCC metadata for DCN.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Ack-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79c573de1f2d..f8023f343c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3764,7 +3764,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
- * First resume function for hardware IPs.  The list of all the hardware
+ * Second resume function for hardware IPs.  The list of all the hardware
  * IPs that make up the asic is walked and the resume callbacks are run for
  * all blocks except COMMON, GMC, and IH.  resume puts the hardware into a
  * functional state after a suspend and updates the software state as
@@ -3782,6 +3782,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
 		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
@@ -3792,6 +3793,36 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Third resume function for hardware IPs.  The list of all the hardware
+ * IPs that make up the asic is walked and the resume callbacks are run for
+ * all DCE.  resume puts the hardware into a functional state after a suspend
+ * and updates the software state as necessary.  This function is also used
+ * for restoring the GPU after a GPU reset.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
+			continue;
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
+			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_ip_resume - run resume for hardware IPs
  *
@@ -3821,6 +3852,11 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 	if (adev->mman.buffer_funcs_ring->sched.ready)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
+	if (r)
+		return r;
+
+	r = amdgpu_device_ip_resume_phase3(adev);
+
 	return r;
 }
 
@@ -5483,6 +5519,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
 					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 
+				r = amdgpu_device_ip_resume_phase3(tmp_adev);
+				if (r)
+					goto out;
+
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 
-- 
2.43.0

