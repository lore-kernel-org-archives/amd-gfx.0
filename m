Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C705FC87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699EF10E4C5;
	Fri,  8 Aug 2025 06:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RSxe/cLe";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF2110E4C1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8T/+H1uDuzmwzyE/fD5Gw98JBs4iEZMDAPIaAmpeiWe/Wbe4phWM6b7hNm27ndAAqb8uIi+xEsvz0jFV9wIip2LuxqZ2e/LLJspv/oe60xnKD7jFuWX+dLyey4F9NFCLev/JZXUCEv/gjSMd2i/TxJ2sWhot3K4Vrn2cC6ZidPwHVZgbVEYvAsDpefQO7Zfx7DYfqOTzMXxbMO8hWMVTza1MTSpAFgpGt9q0GJCssjRGoQETSgDyafalXSbzm0gpc70henKcLJw8qfEpicQEO5mpfsly4RvevDXS1g/WntjtbT7tQo/UD6mBnW1N04H3WYoAJLeIFyt/9xGRv2/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HKMiyYb3JOsHdDDafMg4Lf7cAZ/qcnO15JNGj67GLY=;
 b=OF9xh3vX5PzJ3nhke8JA0BcmsbCA8ADdmOO6O8RjuMpU8Hm8wVhM07gC0T05W2ie4DHXlDcKRerOUI7HgPv/5nTodRNOrA1PNgj5Xixe+8sC8w+PjDD7snLRixl4ksW2XLVxM9rE0MbcqkQZ6iSJme6TXp0HoRpk47YyBgZYCS2+FgcrjtAF4wVUxGuynVCSDvIAjjL5r6OMKMDh0OQJoOLbcvahl1/1z8qLcKO+suCfapA5G4UgUrglZGZMsboc6JY85myApALrrq1z9v2rb07sMhDDa7hGWKZJb82o6EFv6DJ2RvNPFwiwxI1SHDjia8SBgzJkWSCxlhJpyuxJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HKMiyYb3JOsHdDDafMg4Lf7cAZ/qcnO15JNGj67GLY=;
 b=RSxe/cLe4xfbfhbt2MsUpLBY2HVQcVSQi51w/9hThD200f5Bt50nSbxbz65Q2ohDNlIWhc7fGJzuqDuoP2PIVDG/m5TmcDby+nv7cp/IHa/SvbKM2QEiWd3l58qFsJjFpyyNxPcaZIoTChMor6VJ0ovKC3g+0EHdZJIRBSWaNOU=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 06:29:39 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ee) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 06:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:39 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:35 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v8 06/14] drm/amdgpu/userq: extend userq state
Date: Fri, 8 Aug 2025 14:29:02 +0800
Message-ID: <20250808062910.1613453-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a3ab9c-42be-467b-289c-08ddd644f3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W7ZepKRMXlPKG96hG2qqcDHpFiNnUeMhzNarEaX6dtAYPExjFVJvj//xgfwZ?=
 =?us-ascii?Q?mspPEbT99x7GQkAGZHGIMFwEhcEYTqZlXDJSdycIiApb/y3JPHpTFhlPpXsB?=
 =?us-ascii?Q?mFac/NAjxtBkDfGX2WnhJSSUzfIGj5lxo/C0gvx+WVUe1S8pq2SLAO+UT0x3?=
 =?us-ascii?Q?kAamfBmXwWTte1NlxtQvBAZTeuiQZlrluirBrYiPzmVwwL+7pqThqVo0pkbK?=
 =?us-ascii?Q?vJ2MCRMfaRY8bPv5xrNv3HqTD7GIhanOJVfNZ2LBoZ/UTROaeCx0q/Pxldnu?=
 =?us-ascii?Q?nE5+OrlD7chNw7C+1mIno9AhXZL3dy6KgcjElBQxm1b5sTQn9w9Ab/vU7wYP?=
 =?us-ascii?Q?Q48ZGSdcVQSahzpXt1WfwMzCthAkgN8P+Yz+77QCEyazS3te7Me0mcqVEO7j?=
 =?us-ascii?Q?3kTxdmm/oWrHX8RT2XcX80WrnLHkHLd6ogCxJNEYRo1YQKCsQHbvdYfh2mLN?=
 =?us-ascii?Q?fevTpTJyGQMgUQIOaBuA18LNOMotN/JPgvZWYissuFLds1tekjB+3HQztJ0d?=
 =?us-ascii?Q?X3zG5mueL/MVov2gS3qhezlCXqqezxaLVnGXVaRyx72olJmS5zYylS44RRnP?=
 =?us-ascii?Q?6pY9LRo88FlqhDxCA+/WEKIyuTc5j6v+sPQH8Ve0hevf5as4niv8llJadix+?=
 =?us-ascii?Q?esZB7JPV5lutK4iQXdiZbciAj0INYPgdTkNq6Bt/Bmo+QRcVYs+iYt+dDadd?=
 =?us-ascii?Q?o8z9LR/ikt4BUx8n0kV0ON/3rOC6gzolAtXQtBolrXWCEjXaRnR2s1i+xEwr?=
 =?us-ascii?Q?w2wN4jwkx6JtuAf0cTWchbBe2sZnu5as+BwSeoWuhb7AporoUzFWURQ5H4LC?=
 =?us-ascii?Q?bDa3qLbV6T4rd2DrK8pD7M+a9OzYBF3U6wxt0ruoh7UW3cNIxIrxIcU7RvoJ?=
 =?us-ascii?Q?X5rUERwfZNLy3FYGyhiCnH0HkT4KzuCXJBIrMLOp9Re3QWDovry+3aQ5hj38?=
 =?us-ascii?Q?A6YarlBY8Rs9ifAn7EwV8gOExKngz4o+F4UdVCWJB29pDFQFnHD/dXtYF7Xj?=
 =?us-ascii?Q?7tfcpwVx/c2ZoiFmRS9FlhIkoif9ItPkHL8iq90DoVB3HL8s9VJ+AMeU4uEY?=
 =?us-ascii?Q?hKdHMaOq2YLHc29BpKXidn9f85kc3QLvwmmBeiAAM3t9lRtj1ARAuT4z/AZ9?=
 =?us-ascii?Q?wrV922p/1Gr0TPLifyPkJr3Zsos12rue/8sfKgg5UFAnxdPw1vX4qKjHq6/u?=
 =?us-ascii?Q?uUQNXnkzJogz3vRcV/3S2NtVg82+dKe20fnHDKe0ubyXAXJFkoUqK39xVKOy?=
 =?us-ascii?Q?PTrEWb3nayXGAulsrp2EgyMIsGBOdL56XsSbeGHVF/AJZBld6Ct6uUWNepCj?=
 =?us-ascii?Q?QScSHb1k/2koOmaa85xLjzztd9aEZUEcliFeDRhE9rlI0bR+E9TV89c7VvcF?=
 =?us-ascii?Q?ZxOOAxP3qXiEqbBIIubofTLUJGV4YqiTiIUgZzL3fz+j8JdGs8xBnx4GLjlG?=
 =?us-ascii?Q?NZag8Sa/lJaI6WefTgw1T9oxGkrJezgo2/OIP3nxdXy4hlrFeJfCvo/rAlHo?=
 =?us-ascii?Q?Ql0Wrvfx6jYZZ5VPFOrOuHtHPtH4hk9acF5y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:39.3016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a3ab9c-42be-467b-289c-08ddd644f3e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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

Extend the userq state for identifying the
userq invalid cases, such as the IOCTL invalid
input parameter, and unmap the VA before destroying
userq.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75b7e39ee576..b670ca8111f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -496,6 +496,10 @@ amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
 	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
 		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_ARG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_ARG;
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 48722936ff70..694f850d102e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -37,6 +37,8 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_MAPPED,
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
+	AMDGPU_USERQ_STATE_INVALID_ARG,
+	AMDGPU_USERQ_STATE_INVALID_VA,
 };
 
 struct amdgpu_mqd_prop;
-- 
2.34.1

