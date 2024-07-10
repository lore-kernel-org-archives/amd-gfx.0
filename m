Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11371C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 21:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A7610E903;
	Wed, 10 Jul 2024 20:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SG8xbSwu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F4910E8FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 20:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ+saTy3jeFJ+avZvMddfrpFKb30HTDvdyIKU4l0FvdenVRJuo4HDF7A8vsXLZ8YtSQYGghDH/AKkbLT/55+zyRUcdpKH9Whn2qPTd3aRIAlUOcnMQtd4Midip9fbJ1YyFtyNoOVL7WI0PSESeU8LoI733by/S+ecIwjJ7Kp/KR/1AwnvU2xe/qVr3Q0kyw5h4aiPZ18OshtrnMutbh378gcq4qrJBQSiVSU1UeDmgEz4UgrfIt8cZvs9wZIN0K4j29xeydWCoHIWSeIc3FmahjkjeEAqM5J6mVLbjGBbr2jUUbM3vqISSlKYOXsUl16KMz5WFOjx2MF5COXr7N1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNVunpo3o+sqnYgxK8FFVGBMckvMCdQuCcbgXDS5cn4=;
 b=FlXoBb3kTqQHKGMKo0R8cVCLJxsx3S911GzxV+DqWEfl6RZ0k46FCY9wHBpYnQNNEo2YP+z3K4OMQERaHJEQNs8U5jSeZtBV1FvRYjOj7P5XSdPxpTvgxDLU6tJFKRvxBNY6RfAlXPwQY35yDcX95fvGIMtIICwFjHL/LqmQxN5ysa68jx7qJ/07aJRPvYQNCwL7BbIdoxfMjMRMP4SMSZIoNs5dmkjRfSSdzfqZHoHYSgR5yhx3hwr9lyb+DpqiLj6XS4BI7fxLP5aBD5QVBu5fQWVC+h9PIDislLfa0sRoMKXWLmzH9xnlsbB1uwcMCwYS+zhFLH1N0xL0UgDhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNVunpo3o+sqnYgxK8FFVGBMckvMCdQuCcbgXDS5cn4=;
 b=SG8xbSwuHzz3enGVmhetaKRnhG/Em3I047kwvApBL1WyCgT5myRTgufkg/n4dFBFOxkItYAjDBXV4trh262GZ+6x7lzCYkg5ehqiZ9nJvk/DwrSX1QmrwiNJ1rVwuItyEw4Y/621Aaj6cJ/fqUTO9TdrQwdsDaXblzQnHw6cNtg=
Received: from SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::12)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 20:59:52 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::ed) by SA1P222CA0092.outlook.office365.com
 (2603:10b6:806:35e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 20:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 20:59:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 15:59:50 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Ruijing Dong <ruijing.dong@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: not pause dpg for unified queue
Date: Wed, 10 Jul 2024 16:59:07 -0400
Message-ID: <20240710205907.190580-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710205907.190580-1-boyuan.zhang@amd.com>
References: <20240710205907.190580-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e57a990-5987-4ea6-a736-08dca1233e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TbzifuShLbhuONL/mT/mptgUgv368o87IEZ/EjfWwOjus02pr8bqZHdXaESa?=
 =?us-ascii?Q?ybwgRsuPiNSmiJau639nwOLzWPosJ2IvqXSAOcD9yid9GTSAgef/1qBZGZP8?=
 =?us-ascii?Q?F2o4gEzWWYjBymep0xR0ZDGB3ZJewLQddRQYnxRfCb7UE/gA0EyyEjtf2PuE?=
 =?us-ascii?Q?IwtUfkSnKAA0Y/yQWY7nRkP6OBsbu5tRm9zXBfiMRq/KEB5W1hQt8gHWhITg?=
 =?us-ascii?Q?kJLSmKqhipmwdBriWTYASYV5Z7Z0/VE0G10yuzU8cn+dene45MbZ3MX0fUB/?=
 =?us-ascii?Q?iGKrNglXbibQnlW2yJ+zWPUUcxw5HhdmpKmpB47teVlIWfRcvoGhHPQwGvJ9?=
 =?us-ascii?Q?eGGT++6OPtDoWhm92aaMbMkkVWeAj6k9ZeorGgdrV7eTIN4hzvT92hbPBX+5?=
 =?us-ascii?Q?9xoV94L4lozEosvjvwQlXstCs1+VISwd5LVwJBEvW/9ynGWUla4wEAng0rEx?=
 =?us-ascii?Q?kOs73WsEQc5CsKqgNEdThNhuKXVTmjdy50mqxGlfXbEvRX2/NXJpZNlgdYJb?=
 =?us-ascii?Q?Ib2RftXQM3SDjSMSetopW+9/8RpEh/ae02pc3SL8rLba7RPtwpEyHiskTfRB?=
 =?us-ascii?Q?H7c4riIRxDUJi0hP5af/6v6y6cXYBBHjmgW8cpOvH9gX9yx2uxNXYvoKGa3B?=
 =?us-ascii?Q?4OnGFok0NpR8fOIKM7g/SbTTEMEdHjygjQc/BhnPmbGOVimzzQLRUDz1Tzhw?=
 =?us-ascii?Q?QWPmJR+zSeiMk6kSyAHsQmZ2MNP6n3l43nv4cgfq6a7jc+38MrO33D93G3L6?=
 =?us-ascii?Q?Hs/kKlhoaVLDLTfahjxw8kemjPTOdx8xt9i0Mk0onii9ey14xwPrmlMwLebw?=
 =?us-ascii?Q?kbY2OezjWlwFdQJlbRps26KrNxmiLSnFQBCNTvkQP+oQRztR9nba+zH5fNcV?=
 =?us-ascii?Q?6/icSkdkLfDRn6axdfVPZrZEmHD3l1v+8MqpsrqxTk6MUT/Q2qm4YsV9qrpi?=
 =?us-ascii?Q?+p1svesa9ffu4ijEUDxa3njBEe4BEiQ8EyOL+AigsauGZgJ31lSp6xDaeHU6?=
 =?us-ascii?Q?bV70u9aGUv3QITE+z9G+QAaQjQO8IDIBlCo06UGicGXVDNjihw57bdX19hNp?=
 =?us-ascii?Q?RfoXnDeJGRrH+t+YWHpSGOZn1HKQtCOqvhnvlapKMg69AJE3GR8tnJD0MTCu?=
 =?us-ascii?Q?BOjqGL3kWLq7riAx6TirJOk6g2p5XpWcVUCP8rzkVu7OfZHrjcvsd3mUbbT2?=
 =?us-ascii?Q?zEYPOQl7sod8ACa4x1zggwEP5nOoK68x83MK6s/9dMVtgLiqoN8W1Gw+7dr6?=
 =?us-ascii?Q?Gq1gknRDncSziSZwy/tZSxBkaWB3WTqXaJp7vIu4rL4QNvn4zh4fubs6mI/d?=
 =?us-ascii?Q?/YhD4p4TkjaJfWLRt3b2H57KXdc7oNM6S6cxL9huLRKCmtkPJqiQ4liLaUGs?=
 =?us-ascii?Q?vcWxA5lrvy3AKMmv4GU4LKnYA18jqJ55avFvgQY1KvPcHnoxLZhoXBF7LgDG?=
 =?us-ascii?Q?ayWqs/iu5VEjbzrq9O5CEh0oWC9/MnWl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:59:51.9449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e57a990-5987-4ea6-a736-08dca1233e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

For unified queue, DPG pause for encoding is done inside VCN firmware,
so there is no need to pause dpg based on ring type in kernel.

For VCN3 and below, pausing DPG for encoding in kernel is still needed.

v2: add more comments
v3: update commit message

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f59e81be885d..00f3ac5f4572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -412,7 +412,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		    !adev->vcn.using_unified_queue) {
 			struct dpg_pause_state new_state;
 
 			if (fence[j] ||
@@ -458,7 +460,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 	       AMD_PG_STATE_UNGATE);
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    !adev->vcn.using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
@@ -484,8 +488,12 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+	    !adev->vcn.using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
-- 
2.34.1

