Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E0ACD8CA4
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 12:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C889710E13E;
	Tue,  9 Jun 2026 12:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nPg87Ut";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0311410E13E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 12:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuL6ZDQDzHWNIfQHnftSUYXTMgbGmn4pkvgdcdTO1lPExM2UQajg1BfemEXBWHgSoGCZXBTbbAaYk/HNnAliAspmcYr1cxv7NUT1+Glb1kgVBFX+sYaOgCh6GuR6jROgKgZa+MY1rVwFAcqQZC3fbQqdxIqLKYufgeKqGNw1OJNhxPvhETbILfajZSbhD/k0DxiQzdgrA4biM3wS3d2csI3mRkj9tVz5HxRK8JfSmOTLlOMR5fVkOLjPpRYutw8nyXIx4Pmh24z9laRdIst5ukcwy6WR3C2CrfYjg3MX1IDxsJH8lGbYvLmpCbERQVD3QiynIOaERP7mKok0ksE0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4bYvB6vBwKlsnYAmzahCOvppGOfFFR+26Rn9AU9SpM=;
 b=Sq6tk/79RT8Qfu1Wyk5KawEpLWQkfoD1mxOCf30udE/wZAthNPidzr31BOfaxhFnUhhhvlsnSsNB6R38F4LMZctICBZnnPGZovW0n4gH6qNF0wLPlNyJQhq1tHQoTfG8omcXMVAwZZHpG9MRAnruOSL8DptzyLux6gnlw6S6mI85B2nsl6bXE0bs15iTmBx0FVX6YYvak14HJuW6z/8TCxNb8k6Rr1EqOJbghu9UzI9jXx3Bof7zEgdGrlF1uU+AtZzzFcemaAJCQLOCAnjknp8KlZFsG8H0WHE1Wy73XeyI1xEJSnYyx1i9xWG1pEhdkEGOuLAQ6tsfARujRPBU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4bYvB6vBwKlsnYAmzahCOvppGOfFFR+26Rn9AU9SpM=;
 b=3nPg87UtjS6sEgMga/eoxpgOyBHc5kjrlr6XC1i6DOgsMMm6xfLpf/wbPnafFzIMOsEOyiHCMRMA7wMSb8846hRjNjk5QdzSUmCsMx4vtQKhs/0jSdVGbMmengypD6NkkGHh30r72ENCC3os1Z2obmPgqtSP93KSDPL1yPzQ+OM=
Received: from MN2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:208:1a0::12)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 12:19:30 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::86) by MN2PR07CA0002.outlook.office365.com
 (2603:10b6:208:1a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 12:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 12:19:30 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 07:19:28 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: set the userq xcp_id
Date: Tue, 9 Jun 2026 20:19:19 +0800
Message-ID: <20260609121919.172340-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe08a3c-d8e3-428b-1d32-08dec6215b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: o5qcuqWBwaFTyL4mFJIfTIyNYPsryWMiB0sMbEfba6u1iHH6bBA3REyO7UJeJwdfcgm6VuSKn2YRhFl99gvcd7gX+vOmbfk/uUUBPxCcrooQzEpzZrLdFI7ZariHBlBp141t9dw5ZVQ2CmvkzYfrycZTMnocpTidZmYfNLLoH+6ocwozcDCkRzF3YPLzBSAKRlo6DHsOPbsUyS90tVgdDEIwDMCRRthHWcPcmUG81kYwwadQUgl2oyU2DU/MD1Du/vwuxopWEXnawnN4PziKWfqnl6zo6yabfURaZq5o/Og259bmSFJ725bFPqzXgkouA6Vwp+u4E6LxzKlgVNsALl+Hrd6uCbv9FmB+VQpvYRYrnGXDVQMvCBeNcaZZ8yTD4YTpgsFGywkYqEJ3RfZHZ8iloo+UMAvq3xP5H3d2VW72nnq8rMiWJC19baPtDGbM5pKDq+8EVanMhPhwdMHt8Rkd556hQNTidcUYX6k9RjfuPhf6Zqzz1ZFxCP2eq9J0+88v8SPBwJhe20yiJCifb5eXNJPNYPNOx+yXsulXRUmp0CMzFYyEzo2KoIPLV1AxZw1Gix+ucgbqzYpI9VQnt7Iz20GPCth45J6GgTNrIrsopIfb9dCfIbvcPCA4enOHb0nT2bVs+MdjeUoIcdA5KyalrPbAkiwC4FgDNEQnJ0ySzh1gGYyANypr1UspedrVM0gcYR1Am0SJhtgYDdNmPtPjakoswClV/4L9U0z5dsA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ViHRAAaafqOwSrl5o7qlKf9swJD1+Ro+DejRLtQNrh81s7o5McCYYzhjcRw2NCCcT0Z6DwkRGm0ltC5zJ64/2EvPyL5viGBkqoFS2NHBGiGWnQ4hlRk6N5UMxMrc8zfJXP4QvnpSURwzXyEQX/N3E1wczsY70D6EAuPR0nsy6YBYW2YMLC26Enuzi0qu5+X74WRHUJUXSBlud2NCiqFJSlsCoAoq6q2VgGCwfftCHljnAN4i1JovUpAGGEBSa2ppn2GMSSDcvu8OgeaL9f0UZ9qlbtGb+eiUsFZt4uLSkg1tIy5gEqtfL4vZgcscNJL6n1nenYK6LLOhS/ajLCI5ipAGViFZhjWTvNjF00oBEDbBoNQZcgbS9pJzq+nkLfKhiNfELFhj0ya0Tu4fsdkgHr8PFyrx/FK46HxV2CMDeg6JYnQO4/4O39a8nL80bITy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 12:19:30.0354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe08a3c-d8e3-428b-1d32-08dec6215b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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

Initialize the userq xcp_id.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index de6848b4fd67..cd0ae8a77c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -585,6 +585,17 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
+
+static u32 amdgpu_userq_get_xcp_id(struct amdgpu_fpriv *fpriv)
+{
+	/*
+	 * The enforce-isolation userq path uses idx 0 for non-partitioned
+	 * devices, matching the gfx ring isolation handling.
+	 */
+	return fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ? 0 :
+						       fpriv->xcp_id;
+}
+
 static int
 amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -629,6 +640,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->xcp_id = amdgpu_userq_get_xcp_id(fpriv);
 	queue->userq_mgr = uq_mgr;
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
-- 
2.34.1

