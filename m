Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620DDC3ABAC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 02:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CC010E268;
	Wed, 30 Apr 2025 02:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d+EGsonL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB2C10E264
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 02:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwoNg8bPTX0iy90UpBylXv5kzyal5I6GXZyn/ReRRh8IUok8BU2cTxfj9sqXSxc1wjTzjVx3ghy0CUMv0cxaXRdbl7RSOz56ok4daJuUf35f8W03ICSMSOy0gXAK0bwmv6bi/5b/ytpR2nefncCUityXgLk4r6mNZL+gJOMwtfIx7xaDcKIpB4z2ITqMDo2FDV8m3IdpBPfwvSG3+mLlh6PxliENNhGS8knOkMEBde7SkRYDMjXaOLizMclB0pyIntgB5U4BiVpi6atXKIQ7LrAQM9mOiv94zmmZesJI/WcgT6kJsFSGoKqFWfwSGhzddC1KBTd+oD24PdGJefnWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSWSkQ2JW2iHuzSW1HPgP5LX5O7ltjAwp/GBASc3O+k=;
 b=ogpajAsZedGD4zLLUr8LRRcsErOjuDwceJQA2chLefD02LFkKkE5FSNYcj9pTMw6S/1LJHQ1dYMzrIwDetb2GQequ3lrJ33qD9LWJUqhHdV14180CeCfOKJ+z6RIizCU66FIdfcuIzmoClCQj9i8bODA6hQQDEekM9FgBWXlqQLP70OWj099SqVi4jKhFuSwahMgxzLn6earxPuiLAYWIhHmkbm4BSO/MBDMdaRksnbzcw4FlFc9HHPr8dHR/k/sQk51qwVXIysnYkooEJ3IN8OP+BZccssROm2IqCZ2OyVNwIFmqyj//nC3Vud9FMq6rQgyCegQm1lmxSTKbUcFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSWSkQ2JW2iHuzSW1HPgP5LX5O7ltjAwp/GBASc3O+k=;
 b=d+EGsonLSZHS5TaF06saXxl9DPIodhF4c12TBMd6H8auaNz0XsAno1lNLTo40yiAu/b1W18jY3L3n7BdMG2sUd6xqKXQPfxWPnmgBkTPauA9++WeK/oltiwsDbIPbEYVh6RNVZnhMYMHbeicNe5kP5NMf0DFTA9NpbijFLbzgfY=
Received: from BN0PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:e8::6)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 02:41:14 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::cd) by BN0PR04CA0031.outlook.office365.com
 (2603:10b6:408:e8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 02:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 02:41:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 21:41:11 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 5/5] drm/amdgpu: lock the eviction fence before signaling it
Date: Wed, 30 Apr 2025 10:40:54 +0800
Message-ID: <20250430024054.4093239-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430024054.4093239-1-Prike.Liang@amd.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: c654a6fa-67ca-4b54-c450-08dd87907970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmuu/x+s74iMEagpk7gSfacDjYt3AWdlhfSzTd3l/F0aqBYTOxpGzKJFo0c3?=
 =?us-ascii?Q?Gh/9gitb0VFT9Jiu5l1dxUm6A42mR7PJm26A+/8xrALJSDWc1qyX8W+OZDrj?=
 =?us-ascii?Q?57RNe0UVjdiAkAzIxVjfR8cE74Up5xGZVoyx1UgcNzSwUcuZ1ynLxs7FF5mW?=
 =?us-ascii?Q?R0EanJ/i9aTKwLYNdUWxSOEy0gpGV/IOsFSPPQdXaIiuV1aZPlx+M9ejwM1F?=
 =?us-ascii?Q?pxNQkH8d9x+mmk6fG8BxRFn53KqDSV57IgTzzFmvHFAZuqcp9byYwpA65+1C?=
 =?us-ascii?Q?cjTm4grStnGGzkdIBV7oUj4PIRhWSvY+CDAUHkCKL7DPB+4IEzRTj2RuP9yi?=
 =?us-ascii?Q?G6w5z6B2ABA4ZNO4zD7l+MMo1QTUU+yQYf2CK0jaU1VVhzLFuutkcyDnMAVu?=
 =?us-ascii?Q?l4mUjW1Wn0L7xj+kW51m2At7zaaV9wEomH2CbgAneiYctECyj7QKLBQmqRIR?=
 =?us-ascii?Q?8pP1rXmvEbZ6YtUmTXHR/Gm1pwdXn8CRZjsxigmHhI2xlYhSIiZ0KUXo1eGJ?=
 =?us-ascii?Q?+LgssyiPjncQ6Fnvx2VHwvR8T4ERMTGXCtAgx9bPw+OSCgYFe4r+hCuwurYH?=
 =?us-ascii?Q?wK8jXeYL940VnHxEP8hesJ2z6JXD4xxcvZfIFBeERDVsVmr2sd2HEr+Ofzx9?=
 =?us-ascii?Q?FV8AOgOvQ9/IH5l9qxVjPv6Hod+mqlhE/5HeeBzG4hz04m1TnZMVcnh6sOrz?=
 =?us-ascii?Q?VLOYImbjkOcaUfUzZkyISpm6KQDJs2fXfeSjjZASZFNNuAEntLlOUnFu792Y?=
 =?us-ascii?Q?ep8CVJUlc97zpAcJgkKfO1Es+uHEq5z0gU386WeZZF7CIl2BC+rrq3JA2FSq?=
 =?us-ascii?Q?ymWB18mvWZklJnFM2C05mep85yMfipg5WIKdCFCGCTS0Zlh7mAJQZwd1YH+e?=
 =?us-ascii?Q?o32wYsWrG/E7R9zlBNs7UK45JrS+1Qd9Dl353ZeN/yZfEv99ksrQkUfJP/a6?=
 =?us-ascii?Q?xNB1/up9gTe/Og6e14fsFBi6PqBvBZcyA9tSCSNHdgTMWHxm2f5tttX+FicY?=
 =?us-ascii?Q?c/+M29HMRzU4gUkghKXkaDi/u5VaCgBMFZl+NxvTfOwMCdnXGxjWrNNt2IvT?=
 =?us-ascii?Q?bu4sVTFD3AmEkgfoZ8HdFjmBWowkMxTE/dTdHVp8AfIjySzgr7coGUSgNLZf?=
 =?us-ascii?Q?0YApWBXnKAsHcKZqmT0+/4muEJu5Wl9Iw/ARaqAAeqSS+zw/x7jkmPik/zW0?=
 =?us-ascii?Q?ruU5Voq+IPGQdNWkpDvGLSnm1pRQSCP8nxp5U1XJA4Pxb6BmcslsNB+95dMO?=
 =?us-ascii?Q?ngNBP2kxQpD50CD44DCRQVGfDRfyDcqO+Bh0+coHXBfdRFpl4Y8Pj93cbJEX?=
 =?us-ascii?Q?RwzDjE3MJGNa1lueaKevK1F0BVHSaed/djMckCCcrpYWJjtSr6xVmXYtx45x?=
 =?us-ascii?Q?qTfbxAg3tN8pjLoogifI4Jwv0ylrSgBSaoSBJOt/jx+vKrPXV5Jq1ABdd2aH?=
 =?us-ascii?Q?2SVbweDQbSHeExe044JZlbmjUR9N1N2jJwQfWc55Uzq3I/b2OVSNe/QPX1gM?=
 =?us-ascii?Q?L5nFiHDVCe84n3XAzI/C8fAS0jO8ECJBz07y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:41:13.8518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c654a6fa-67ca-4b54-c450-08dd87907970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
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

Lock the eviction fence before trying to signal it.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 242bfb91c4f7..fed065892568 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -108,7 +108,9 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_eviction_fence *ev_fence;
 
 	mutex_lock(&uq_mgr->userq_mutex);
+	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
+	spin_unlock(&evf_mgr->ev_fence_lock);
 	if (!ev_fence)
 		goto unlock;
 
-- 
2.34.1

