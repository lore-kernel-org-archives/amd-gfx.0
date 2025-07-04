Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8E8C8303D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED9210E9F1;
	Fri,  4 Jul 2025 10:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VkoXa+V8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9068710E9F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0x8f2DPermrWS4W18ngcNf382gGnfD0f7ZFYOiPnQk+o8VwCDy+LcuDCwRchzXDSbowTRA2sto22iJ2RuqFGY3D5bycCZvJ//71aNEFf9K3hi2SKFPsoGNSi7aDft2MX66mWPh86wmFMyqjfB8cXdPg7xGW/qhTXWxcWuDIer3efq+ncObiT1ZAiLKq3SCt5nf1yTbcWDIjeKy3anRCclrxBBBDZZ7+GP6IrgVH79AlZgmNocpsAK08F3fc3BvsDUmg0Q/kRQkY+LBZH70BK42OhTCnjtyv4JWpiD2CF494/WkybtTbMwrQE8nmmiW69ENASj7B6+PcddL445cMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONEXLVXakr5Gq5BWZhDqrDIbnSttRTLkzxL+pDzPswQ=;
 b=qwynmgYeLBRwe26Osa92sfv5XIszJOca7u/gXlgaXszUbSLpGR1peNObY5s7dM5fdq+6j7R1u9YIXmX5bt1Lh/InyXJCBcrRoYWCriBaDWV4sXXMJFGZ/CLyFnKG4RDmWI+ThVMYCEx9rumVyHa+Vgaf8ZMPdRWchLWY9sJjEQ/lXqkkrtfx5BlFEaeEsysdk99g7iLjDg5jfsL88EukEm6eMqfE9PP47CVlO9LxujDyBE9XUGKt2SFE9boACAIosC4UQrtdHcgcmhKqmeliNvZ2+ztZ4giTV1DCJtyXdEroNi5Gcyak68XFJ833tRB7Ii8EctZJ9DLcWDC9YpN7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONEXLVXakr5Gq5BWZhDqrDIbnSttRTLkzxL+pDzPswQ=;
 b=VkoXa+V8yI08RaIsilSXj0ZceVZQ86kRNAt8NdrT9l3fIMrJm8POJaclqX5/tMZJU69MNd5gC2cS44cX1gDZ+6kTODX6pcIN/dxH0hUwqBtPkkUZegXtTgV/gBs6vY4lm5uqDAls7ihxu2kwmH2+6BZg+uSgTkBV66vMHGzeLb0=
Received: from BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Fri, 4 Jul
 2025 10:33:23 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::b4) by BY3PR03CA0020.outlook.office365.com
 (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 10:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:33:23 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:21 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 3/9] drm/amdgpu: rework the userq doorbell object destroy
Date: Fri, 4 Jul 2025 18:33:02 +0800
Message-ID: <20250704103308.1325059-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704103308.1325059-1-Prike.Liang@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd1fcb1-a60a-4fe4-3724-08ddbae6340a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?73V/8HtzMmY68jXrGjjDLdclsjUObGKre9Wz9LSSu8k0CuxpJ+ZOuicrGBUi?=
 =?us-ascii?Q?yA6T+yJKpgI/rFe8PYczYnOrNDpw/onCmRp4yLhR8MuB9hy3xYkq+OHOeFzB?=
 =?us-ascii?Q?VVnr4B0cr0achwJg7ZYPSs6/RniFtWT9cLkmObGGncg4eoRVL2Vabn0PGywU?=
 =?us-ascii?Q?jm/HBRSjyXC6CuWrRYz/plZTj0G+QTe18bG+5u9y5vcByKbrlF9zGaN5fooj?=
 =?us-ascii?Q?Lor0gHTnE9Vzk1jWZ2rNLJgrePoAHTlAGfnTk1RpcLON045iwb0ojKcsJwj4?=
 =?us-ascii?Q?ST75xhSzfotCaMGR4sS6Zj9zQsWlLrTT1kNdOvr0jwxXysjPXmxhwr9QhUiX?=
 =?us-ascii?Q?LzW++saN1qK6+LmjmuPg4qfGVls9YiIH3ko8LUg4VavaDCTf80S/TDzkH6ud?=
 =?us-ascii?Q?unBHEQ2HQlr1Glj23v/8S6W2P/6LZmbC7FrXLEyvFOdPd/pGzcBDyYLaZ7zw?=
 =?us-ascii?Q?ebdJJZmT9S5U7b8OGWUyO6COQFCfIdBSgIUm3Cq3FaFOddrO4kIlsoeeMZvG?=
 =?us-ascii?Q?qjNe5EADFVmR5Fv+muw0kaSBbT6A7rO5yaf7xKsITWFBGxpeChpZ4WrLW1b6?=
 =?us-ascii?Q?s5R/9j9gy9E8wSdy/qg+4z3NH+uIvt+mDTEnmhYS2ilBCKL/n2viKbrqC42p?=
 =?us-ascii?Q?YtV/zvhBsMST4dGKAC2Cz/bFQ/1MEEojW6fGsgqBG/HxNue3R8FpP1Hf/HBF?=
 =?us-ascii?Q?N4p40hqYMOr+lR+ZIIM8BxMjnkrWI1/mkpG9841wTeDcQB9QDOkruca1ysum?=
 =?us-ascii?Q?eLpKFMPIIAZeIDgg1OL/JLpu859bAXbvXXut2yd+fylfJKZ6tRh2SmX6DotP?=
 =?us-ascii?Q?i+aQYKIh6Zt3qGhsz3l0apJVvWswKpil+Ml9EtK+Ee0OXaKzA6+foLL4qhwo?=
 =?us-ascii?Q?5YjWw2sTYLddws9DimrYBlJ2SfK604wguaAliQ1ANmUC3CLPCiYyUNsk9Wy6?=
 =?us-ascii?Q?gUeZQHcImNJ88G7/umwWFfCpXG8upvLc10+2i5t5ICsr+gUI3W2efWPoDmvT?=
 =?us-ascii?Q?HCqdPs3UXSZsDoGAlC/U0fOKBzBXPShFHkbyz09VsE1Mk5WsUvTpYImgxj0H?=
 =?us-ascii?Q?gDcyDKO5HRuxQymMTqe3YBKjc9o+h+yXa3kziORVU3P0phB/l+qHlxuNv1og?=
 =?us-ascii?Q?zTuL33aianNA9HW1SN//bG0V5acz7LkLgVT3cQrrg7sVr29W4ZiiAytS9HZa?=
 =?us-ascii?Q?LuQSzsqN34cadhu1/MzFjN3LeMlZskQI/tJ5WDuceZYYrNKDBtd7OoyV2aCo?=
 =?us-ascii?Q?nwJrnTXZc2HQpXTcJ3F3ahaW4z+ACq51jyAK9Esna3qJOA4IyjpTwXs/VWJF?=
 =?us-ascii?Q?OPiIQHRaNhKDhaVxmaIVDzvnJx+G9yj6yEYhDrJws9miJXTY9ADeVpW+T6L8?=
 =?us-ascii?Q?pvDlX9pizKV7oGU8IMvGmgvC+1d0vzI8/T5paCtcRGtSfOkAus1nYEm45nLp?=
 =?us-ascii?Q?Gp6dncRapCP6KtrnEfg5jG9KvtxWDvRKp3ucQyvS+a6hcA6FW6wwBk8y+t/4?=
 =?us-ascii?Q?dLW3CglAqMuOqydOxvCL3GNZfiXBIsI7VDUJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:23.3454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd1fcb1-a60a-4fe4-3724-08ddbae6340a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
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

This patch aims to unify and destroy the userq doorbell objects at
mes_userq_mqd_destroy(), and this change will also help with unpinning
and destroying the userq doorbell objects for amdgpu_userq_mgr_fini()
during releasing the drm files.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3d2a7f8946cf..f1c41b1114d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -317,7 +317,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
-	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1457fb49a794..dbacdfcb6f7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -336,6 +336,10 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
 	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	/*Validate the doorbell obj whether has unpinned by amdgpu_userq_destroy()*/
+	if (queue->db_obj.obj->tbo.pin_count)
+		amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
-- 
2.34.1

