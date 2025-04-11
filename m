Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036A7C369AF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279EE10EBD4;
	Fri, 11 Apr 2025 14:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGU9a6yh";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B4210EBD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/b8YTkBsO+8kMNB731qmD1DGKq2wkjQag3VtwRi2GQZG/BRpRU2Y0kJ1f2fEqMnxz7ucr0KZrEpnU3Q+maraolkYsaNgBgQO+MUvCNNM7eKHAQfr/8NoarsKAJ6OnMdkUH/n/iF8IFsrGT+G696UqQBzVOF+rJwI2PdCvtnUgYC92QLl+vWlO4pxAew6iZSN9Y/bYrDE67ypNIql+wqErdKe4Vzu1FClZ0kjfJ/ILsj2l5L9sXOK3s9DPHGt/IVdaMLK+7sIVjI0SPCZKGJbbcz5jj/AjsJlKFk8AXkSn7fRlvSaYxabuUQlpRaQbt1K/fb6Q9OcUcQzAjLm4FJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFbIHpQSFl5Dge9TuveoCP5Sx5gP63FIo8CWpdzcJL0=;
 b=fLggL+1jcUgK42Nu31ewkfuksNfzKFBf6/FvTaQ3A0lcH+tYEawzgjkQZWUyrAnIoaOV8Q+j+poCeD+3mW+58BolMxjbzCfgQWGHdTo0V6uh414qTV440d17xnXZXoDSNH17iX/Pg8qohUOKQLVj90rN8/mg5CkQeAdh/BZqkNT+d+KuhRpxXtbUrtA1zzdtRwluWK2o/zdz2RLpKeYY51UPkojaAqWcB4XAIhOYa9s4xMJNkV39YOV+2lJf3yc3lxkTZBzKTMGmEhw2Cl5ZwQAhL0KW4my8UT2YsdfjZPFgzssrd+BWagIOlf+Hml+nX3oS355w8gVo50ZlNkiTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFbIHpQSFl5Dge9TuveoCP5Sx5gP63FIo8CWpdzcJL0=;
 b=ZGU9a6yhZ0KHb8oCkrdJzxDpAszndanRF5psTJ6BQn2S1EAnGLCpio4LQ1SKru7eTYDAQIuhlB8DqKIAlJPPHFn/TqZ8Jh/cI0FZvFkj8UVpG5IPIX0Aekpaks5h2cGgqgrLkkFxMJoH8EU5f3kHx1Jztj/R7TvdztTSPVIgDNA=
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 14:12:44 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::c0) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 14:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 14:12:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 09:12:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 4/9] drm/amdgpu/userq: properly clean up userq fence driver
 on failure
Date: Fri, 11 Apr 2025 10:12:23 -0400
Message-ID: <20250411141228.2722962-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411141228.2722962-1-alexander.deucher@amd.com>
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b8b67f-a00b-4132-b9ae-08dd7902ed61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1eeBnL7uU6nIEKn2PVqxxwmh2huVlWVftNiF/11tH7BLPmSgmbbVQiDYW1WO?=
 =?us-ascii?Q?czHqnBr1QlRjNwq+wdvhdrn2N3qCP491udrbzbBYi513TnpU/efElKMpin79?=
 =?us-ascii?Q?PL4iR9FEdeQ+G2ClSW2yrf5ox2Ouoh16HpNfVQdY2arRhRiBu9CZ9r+vpgA8?=
 =?us-ascii?Q?o590BG4xC2ufhgojNYO34fNVUyMSmtBfOkytXZv2EruZPO4M9Zj22B6qbcO2?=
 =?us-ascii?Q?iO/4hzxkHtBUT2aCw+a3Auo+PRPQJ0G4y6pVj8Irq+eEgg4KlgFqPytLVccB?=
 =?us-ascii?Q?j7mu2ez3LRlTxjPQREs8jYqNy7rpQPKNS3VnUkTlR9rCM7INfYUJ+ZHI4YPX?=
 =?us-ascii?Q?Q+cJfIoev+3893wkCaVcQv17vItC6+vMINcnC1/h8xfobVIVmVV8QneJ8Qq7?=
 =?us-ascii?Q?9bEiuq1UTJb+xsNT75yGcNpeEi0xicriC6dG/fRR6vWxsu40LNXi90fnzX+i?=
 =?us-ascii?Q?fdgBEfVDTn5SdQvJHRflU/AZuqGMXhTXzj4ZpMmNQmaik+TtTQFuvqsHWEWO?=
 =?us-ascii?Q?ut3R9NYQ4HuSjkEXx3dSTpqSCGOGBbKFBdWJlYTCZHuxjDVpsb0QHP/hQ/WN?=
 =?us-ascii?Q?lgMgdzyghYHaKIWR0CQaz43CyvSA7sJs13ISg1gOmxA0PanndAsoPiu1yqo5?=
 =?us-ascii?Q?p8iZpb8STF7UeCt9NANObq3Q5jxl8M5RM85GeFLorOkljt2uTnkBZdtSptQw?=
 =?us-ascii?Q?cyR6mAZ4ua4Tyjh2AJu7tHCfDUihzVEtGDUjKRJdM9OVBo7DelmgXpsAaGuf?=
 =?us-ascii?Q?kNNFPLb8d/G69Tj+mIGTUeeNslSblKo69RttztX6mUCoBTOmFA1ufXICYNhn?=
 =?us-ascii?Q?0zlV7tgI1D7efnfUCTr6g2H8E/dyQlkCXyV+Gc1QQDV+qZIG/ixSzLr0BVlW?=
 =?us-ascii?Q?xZ01bIY+N5hwrAsUOrWZbK4Kv66oi+ZnWXhTiJbj6bCng1n03hIPIBJv7Kp2?=
 =?us-ascii?Q?tH7Gd947EEwf+w53cdTDmZjf0aelIaFAd5JO6WbRr6lz271SgLBloaP53+oi?=
 =?us-ascii?Q?MyevC4DrChGJ62NR6hJvemWqdAuEOQ3T4A1gKgw/wXvCjmAqlZs208Hq9Cxd?=
 =?us-ascii?Q?A6FGR0N9B53MHTJObMaVWXZbPQow4jULz7cjGmBtN/FEmz2A3FSaQViIGCt2?=
 =?us-ascii?Q?Yj/ADGBuJsgsoPHtG13RsKyTEx3r7Gn5EiYEeQd8ulSdeH2qoWVX4JkQzeuj?=
 =?us-ascii?Q?FjoILKpR7iBhDwK1i2+oS6WmIFDG39znNilRPf6D8poo0TvDEZK4+uz4yGoR?=
 =?us-ascii?Q?wVfLyGVtKzdTo0XYh4OR5fKhUS2q22gbfdlsSlt+x1C9advy9mxbykF8J5ME?=
 =?us-ascii?Q?U/yfG5eFPcHRWCtThp8o+BTnb08XKYGIaIkJLoWzlaQXPuxYdQTr06LL+D7c?=
 =?us-ascii?Q?V3y+hCvzmTAvYX7knxnp36YV1Z/sTL7SZLwhw/oe0WySfcK0amCkKF1c9PHw?=
 =?us-ascii?Q?7FamxeeJ8mz+2K49qAhMVZAumGgpJV+3Az9PU+Q2f6LAMGfZQIH7HKtgOVUD?=
 =?us-ascii?Q?91ukHNIIOW5VsDxBkaVrBtQu+jvNzEzLnuji?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:12:43.5509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b8b67f-a00b-4132-b9ae-08dd7902ed61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
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

If userq creation fails, we need to properly unwind and free the
user queue fence driver.

v2: free idr as well (Sunil)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 79f4df4255c50..41a095c12f956 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -330,6 +330,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
 	if (r) {
 		DRM_ERROR("Failed to create Queue\n");
+		amdgpu_userq_fence_driver_free(queue);
 		kfree(queue);
 		goto unlock;
 	}
@@ -337,6 +338,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		DRM_ERROR("Failed to allocate a queue id\n");
+		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
 		kfree(queue);
 		r = -ENOMEM;
@@ -346,6 +348,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = uq_funcs->map(uq_mgr, queue);
 	if (r) {
 		DRM_ERROR("Failed to map Queue\n");
+		idr_remove(&uq_mgr->userq_idr, qid);
+		amdgpu_userq_fence_driver_free(queue);
 		uq_funcs->mqd_destroy(uq_mgr, queue);
 		kfree(queue);
 		goto unlock;
-- 
2.49.0

