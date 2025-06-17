Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8B7C7115F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3046210E4A8;
	Tue, 17 Jun 2025 03:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T4W7rfFa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 844CA10E47F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frgVR/0m2OH+lra0XbVzI0jRoVNfzFclhfYy/qaBJpBXW6AGrVDEQ2tong5vm7w71nNkH8DZxGmuov0VlzSutcvPemQ7Dxcq57PwTlX8Jwgo6cggItds4UfDzEAlpl2KhgqfjO8GRXSRcH66vEd/i5YZ7/g3yGfTFMF1j24SRB3egbkcC9Jj4vQwSVoFyAjvVy3ekMGL5mHnfoUSLlmOdUihB3occJEm2pOp0WBJ5bku1Fp8CDxfQ63qQHVo9h64QijIfiSQ8tLtkuzDMISSBXvvWGT0VtzCu/FLcL7ZYyNzxN4aLhd7BG8s/O4rJWQDVkg7e8HvPM2IeAds54BI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/kz25qrqXQvyU+lfGrdfsFAdN2olp+4E7uaq0vuVZk=;
 b=rLstmNmCvDyfUO9ASuYqgeN0qn5Zv/jW5mzt0ur05jP3j9DJ+G/iqA5+9/VabBQE17wdvYRV286FI9G98kOdueQ2gInP9R96WpigMr60dAw0XIfWcJ8VHU+4ZL/xOehqJwpfS/BBiwwGCcGIpjm/IxFJfPC/lRCERuPOMLuZcmMRdlF3HfLs3IBWQVC92ql8JWTBuAChC1FwYPGkg+um9E45QkbKkdoAxFkQ1aaHrH6CMNLHgcuCvZvHCWD3cuAVWxfaw66TJcRCRihqtylb03GKQMgGETPW5lZXfYl/xiM+7UJQ3pFuxMk/PKAT6dHwYq8nXYvu4oKSQJWbOJHdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/kz25qrqXQvyU+lfGrdfsFAdN2olp+4E7uaq0vuVZk=;
 b=T4W7rfFa+R4+cVzVhXznhDllld8Qt1NcGyTD4daYsv6hZlSpiRL0FhGEeXRG2cDBYGQnkzX/p12RihCe4MaHRjhtHd/BLcrV81PYiNVJiCGTv2tFnkepCPySCZSDUEaecYMFFzVqmwGPQcS6qBL4shINBQ3KKeSY4oH1F2Zs6g8=
Received: from MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:50 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::25) by MW4PR03CA0156.outlook.office365.com
 (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.24 via Frontend Transport; Tue,
 17 Jun 2025 03:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/36] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Mon, 16 Jun 2025 23:08:08 -0400
Message-ID: <20250617030815.5785-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 492bc0b3-91d7-4d32-1715-08ddad4c48b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1SGoH1UmVjJoZibdSOBBSeneeflwXBtI1XMCj7HyB1NlQm97qLV1KCdWJIVi?=
 =?us-ascii?Q?1TnOa2eFwG3XzgQPYKD655E388bkBot5zSX14quHvIpXeo/1GGDU97e2mvIp?=
 =?us-ascii?Q?cDW5wltxogEnWm5CDGPdlq+2Cy1Q9HO4FXAbwxP785bOs30pQ3f649favfX9?=
 =?us-ascii?Q?yr6kO3Q4raVjsZ578/+WrsN2uuj4ZkI0BVkgnqSCax0uJnt+gBXKp7ALKP0s?=
 =?us-ascii?Q?6wPRRMjGiwzdwIJ5WbXADUw/AcX4vyC2U3zyfgE/4vWi1mYVV0ztig4r+SxG?=
 =?us-ascii?Q?0GTbXjsgPK4MDxB9vV7e9XsWw2JF2RZYdhB/2yTcaZ/WpHnqmhOX1E76bqZd?=
 =?us-ascii?Q?EFKyPTxaWM4GkdWaz/D4mq56CdyOFIlFtvUOrNkeVm+25Hk0Rqly2em6qEU2?=
 =?us-ascii?Q?OQeVn/ig0WlW7gefsHdZwmdLrCe0acYBuAPTteXyacmjF2qQh9iEjNCQHu4d?=
 =?us-ascii?Q?ekJo9BAm2WnNNeRiWGVHBug+ftqsuWVnRhAMCpnQId78Q+sdjcG+ehoMK3ri?=
 =?us-ascii?Q?Ims4AYYUS+WpAwHSj6Qw2hVZksE/qEbxu2QD46RrTnV19BYLvDnBazcabeXo?=
 =?us-ascii?Q?TzKCm360gTxIupow8dRC/wLiHbsB5WA+4aT5Hq3++qXhgxJj5dVtY1qpi0Vr?=
 =?us-ascii?Q?vDfLjn1RAMJU8bdw4qdBLFeG05VFoY+gDHTzAPp+eClmH7BqUatvARPimW87?=
 =?us-ascii?Q?DMsGFtM+srWjJ0P0ijV9huojUXM1kjTp8/BB7fQ9c9NRTxG6UzZtbLCWSjUS?=
 =?us-ascii?Q?X4ujzLiCVNIMWiNGbBcwtTpNhzlC+1ZvoN1ZvZo/cZaDg0F3edXzXAEKRCf8?=
 =?us-ascii?Q?IknjLaf0IwLvUZiAftXV347rrQKXbVn+g4jXbV2Ty05DILUjnDwZMDRxU/FN?=
 =?us-ascii?Q?wrQ/IYTP4CWCWdrJz7LFgzKFU5N2OMu5552ZbBhmJ3jRoibiVvgKkeMgG4ru?=
 =?us-ascii?Q?a7gOGvICTB7B8/yjRC0UKZHxwxij3klYgM+TccW3u9UTgTpdyMbpDf5OYwz7?=
 =?us-ascii?Q?eJqhXgnub9HtqqUC2NOprXvPdvV9rlnR0yQZPzlFllIv9THJMHT+6Tojryhk?=
 =?us-ascii?Q?e7mDdpoYajTsY7au0Fxs9/KAr7LEnzk43DMA+4sreDtavW+h55/qYSbWOLqt?=
 =?us-ascii?Q?503gJi98lhNlQCDMqqpXK+MGA4gLPNAbLiBVrGYoJk3TDZUHIoQVSDz/14bR?=
 =?us-ascii?Q?Q1d7nM5viWWkyuJBP75DBcWa1OT8h5udgdqBuNIkqCiUlFpleKV3lc91BVdP?=
 =?us-ascii?Q?6PKfJ5aut98KeTY0UeypvejiAioa01W3LXymSo6/Y8o/6toQPyBo5Kj6xgD6?=
 =?us-ascii?Q?SMQAx7QJWKNxiTucXd9O42tAElGypR9DEOOJiyppzK84v5ZCsNtJ9tCtxFDu?=
 =?us-ascii?Q?DZXrHmhywLUSdnzocorcY5V9PoRdpFezF4/EHhik8IUiXS0heSbSgpjW2JLX?=
 =?us-ascii?Q?MW1LLOa6DSOzvEhgoV1ZPMCsTXLOChs4JTSZ/VfabrwdfGYHEToKfCDLmfuA?=
 =?us-ascii?Q?ckCvo6tdonlt5N4IaEDOZTZh5qXzeWqVJ9j/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:50.3769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 492bc0b3-91d7-4d32-1715-08ddad4c48b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1532e9d63e132..b29e69d034a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1973,21 +1973,14 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.49.0

