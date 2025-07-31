Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24818C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 08:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD2D10E720;
	Thu, 31 Jul 2025 08:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eqVTFuvd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53B710E720
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 08:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgzVwxRB4tIIWNntrG7VK2bBl80RSjiUvyoVw5L1yRueUe+/I9YMW2aaPFZaYxOWgv6BN1LffF2srMkRicoXobCrRA8UlzsHT/as7ddJx07Ax87lIiQqlOCzmEFvj5H+1pp/knsft8QL3Mza92lNkQVkt/ngeW3Ztg9MA7QCqxAUWJn4osV+C3oB8Q2Dw/tXq5VilN0D9JAEj6DjwLpu9X+UvXa5bK5wIaSO5/XgNC0z39HNkNd/eKoTUinnHoIJCOwazlk73qWeQcwmU5wgQYzGo6RTDjP9g3lijCX9xew3vdYFFE396KKsyeC0uNJiw9TseR/jp65pm71MdfTxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3aqlXpIu09viDaoEshhzaCgM/+aW0YlVmMnyez/TWc=;
 b=dpkKQtfHsIBCyOJ2IsyfB9qgGUKIOvfEHQxW4FThXM/N8EOTPRkxmUSXMepoDLg63aSgTDvf1i+hnqa2wGG9k0D79RIkg5LepqCM3s6VETcW+UUbmOtSITFmvch3LnKdEq3gshHPlrZVUCBjbSX491CGOH6rnj2s+WVLf2uL3BddD5TGIPob+fSjC5K5YPfFl04ofUwnltqa9sIEFtxquAl010wp45N5hrM50R8PBtZ0QNURtWzEMMWlskQCXniMeYaayEoWnHDDOQSuhe6/L/82K4Q1gVqRA641kVsX3EueHx5iIQaB8mLg48XfV7ZMR8p6teSEE5MKpRyI8C81YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3aqlXpIu09viDaoEshhzaCgM/+aW0YlVmMnyez/TWc=;
 b=eqVTFuvd6R1KmpH/VQu6jU9uoQXvMtsYXMw7hgwbrPt7g8J7++ZcsuSf1VFK7Tu0Wcv44829+kRVBdV2HIDuPIwgSmuGOtqePrrE+ooWDLG2NFDArzOJRuAO3Du5MZvqwRCVSBX8hBMnFYe7HT2pMtoIqN+ubo87CDPI1t+lkbY=
Received: from BYAPR07CA0060.namprd07.prod.outlook.com (2603:10b6:a03:60::37)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 08:36:47 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::b6) by BYAPR07CA0060.outlook.office365.com
 (2603:10b6:a03:60::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Thu,
 31 Jul 2025 08:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 08:36:46 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Jul 2025 03:36:37 -0500
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dl.SRDC_SW_CloudGPU@amd.com>, Heng Zhou <Heng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
Date: Thu, 31 Jul 2025 16:36:04 +0800
Message-ID: <20250731083604.26416-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: a5072543-45ec-41ae-b553-08ddd00d62fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZRS0DnuDGIH5Uo3HaYVhWz8qZJZiV/RggmrBn00+XOI6m7V/PxPSEetrC5oM?=
 =?us-ascii?Q?kTnCY6Pkkrnk+Y8ANaqmEN2bwLaHqO0e3iyX08SxN4FTS7anAR8+1hNzR7ry?=
 =?us-ascii?Q?tjVpq86f0IWCe3G0ZHT8KDCnj9Bq1wVrKn6iE06WQ9Y1q9xZK4LMJojolzuw?=
 =?us-ascii?Q?Cbs2V4D8ZTKZtu8Riu0IWpkHPzjzE/vUlXuYDiOJtHoTpL/5LeLn8ILF143+?=
 =?us-ascii?Q?tBbruUAM0oWxp7UZ+8q19VTPusrqiabE9qk2r7lrJaFbN7b7Nj36riRAxOhC?=
 =?us-ascii?Q?jfChpt9KhE2hD4vYdm3yaRn/ApYgDoG5wYAXg2c3YicMldSmuSy7lrPJ/Ckr?=
 =?us-ascii?Q?ewCc56qZ7V0msM1USsGp3xQeE9dFANQezGgGxwmxSFGgQqUIHmtAi4DDA2yf?=
 =?us-ascii?Q?K2UCOXT493jVzvmSo9i6vsZIqjFLZRcpOjzRudYvnwI3SiQ2y7ZSDqWLnIpN?=
 =?us-ascii?Q?BeNZ5nhB5oCO1qi+Vh2Xc2nKj42VW4nM9g26672iELif3n8iLBbVw+e+Bs4T?=
 =?us-ascii?Q?oK5DFGVjV/o7Xj+v99U887L0XjxOwPFxj447at+ttEJtKgSd+yEYdMrb0AS5?=
 =?us-ascii?Q?cLSALtVtH8aqS7zlSCHKyooO9CSrRjtDbAM3MR8aG82z53i3Dzysza69skqb?=
 =?us-ascii?Q?x9PM2I6c2WtFuy+rhHKqnaimZZYBfoJLiEDmf+IDhZ2Vo6X/WXpVEHzkbwgt?=
 =?us-ascii?Q?e3/6DltVDTzU29QctKZYwQ3XmAKGX9cIkVeRkWSLZGclxtX2n2myrRjciEpr?=
 =?us-ascii?Q?K6tsNkF3nJ28s11jjtjTXnVSo4P8vae9i33kZamp5LMAZjpRl2weOx8xUxwT?=
 =?us-ascii?Q?ZznZHQN6tDXwMlwqIWkGaqdVGfxc9dWMdQx2S36vEIC1GL5HZuA6aisWyjfe?=
 =?us-ascii?Q?+zeG6cAGSm18Lmy5eYOpHHkOvjSt9l1jzQCDXlsqW3Z1R2PM81CcdXQWQU4J?=
 =?us-ascii?Q?C56CCYsqgr706imJO5F78WWmZd8plqv9UoVV8ZsdZWxja1Llk+a5u7CAQlj/?=
 =?us-ascii?Q?P+4FSaDOzTSosdDQ9Qh61rDDZCPwN996hldgatNfHyPM+//UciF/Af0pMpax?=
 =?us-ascii?Q?XoJjfVUZBjvjwv6jWJYt5gaZ/H1rRGVVQ6W9Ag94qVEOLwRZwteWcPNggynj?=
 =?us-ascii?Q?NHr1ghaGTyQCiP0hFla6bnRd/xdjeLw4x9O5JlgK469Lavt7Y6Du3kmFKMkG?=
 =?us-ascii?Q?EXpw/iyApUhqmBfdMDFzWvUs6WwOwbo0d5aB/hQfDBh/b4afsKUntTUIQgcT?=
 =?us-ascii?Q?Ya1PDxokEvI1KYAQ0PJDLOLoy/9W4wBZp8+kbfBk+9ZuOw6d+etzsExL7hdK?=
 =?us-ascii?Q?Cjovt2I7sFnL/QdZ2Xd4ya1va2r7kLtco7LSL4jWH0JEVhZHXonu6dnFvFSB?=
 =?us-ascii?Q?lP4QLSwz2WpNLdeN2exBDxBMVhzt5nMMEFMx/EHq3zGqyk/tXNooi8qAB/yQ?=
 =?us-ascii?Q?8jThx8M8lmj/MCXADJ1jtZIm4/Cm9SnBRyrL9xoAawbdCbcaAZUe4761hx9H?=
 =?us-ascii?Q?MlBR8Aa4lmi+3hvHx+kNpuwqbkDLEaMQAqIw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 08:36:46.9157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5072543-45ec-41ae-b553-08ddd00d62fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
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

If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
So, such kind of amdgpu_bo_va should be updated separately within
amdgpu_vm_handle_moved.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 283dd44f04b0..f88b3e3448f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -578,7 +578,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *bo;
 	int r;
-
+	
 	if (vm->generation != new_vm_generation) {
 		vm->generation = new_vm_generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
@@ -1608,6 +1608,17 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
+
+		/* bo_va->base.bo is NULL only when bo_va is a prt_va */
+		if (!bo_va->base.bo) {
+			spin_unlock(&vm->status_lock);
+			r = amdgpu_vm_bo_update(adev, bo_va, false);
+			if (r)
+				return r;
+			spin_lock(&vm->status_lock);
+			continue;
+		}
+
 		resv = bo_va->base.bo->tbo.base.resv;
 		spin_unlock(&vm->status_lock);
 
-- 
2.43.0

