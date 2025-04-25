Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D94C369D3
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4326F10E897;
	Fri, 25 Apr 2025 07:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHouptHI";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA6510E891
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 07:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGiLkmzgssCcp43UwNIHrFR8EcLXNC/iawtrwpe2hRIlC35sBqozOQ9Sni2f15bMz4CVNAa/oU9qi50ywPN5F7p1dfSxVDRhHlsgw4HI+aTtKvimDmACXLNHeyW3O4TYl78S8F1wFA7ICdwBa/HHU4CrMf5dBDwsn6/t6MTyIfF9gki7pAkSI5KARpB+s/GIlP5MJu3plf/+h0y5MByvfTMNvTLb0U5wwLawj1F/bmY4paOroCNTERaWS7cMsVFbJ87bPw4T/WLk4MuMVJUOpwyskEuDJfBly/uHsRqjjtMpoz23YW+AvPLjSi5in4F3Vd+hskiUGSwmGzaoaSbWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KgCFmUaRL5/BkQPt3HcN81Xh/obBTj0ZlGTTZtNz4Q=;
 b=TQgNYd3YmENsVzDw16e7jpKKx8V4PBKBWkK7GWn9CGjRuOUjcVytcBNLnlyzOiWahs53bFnB5/2jtR7A3s2ZRrcBg358YK29ZBl74O35xiOfKU860WD85xBnlZnohGixq0L4T0TNqKi6Nb9spTfgqBIEJIZsZiJ5lTcux7L20HqF868C8XKSOxL+1oqO/YpFXE9QDcqHuEflwl3YlgZT2UhW7RtnXsPK0lhngQ4LBTzr4f2LJ1FyXeBZQ7kX+rk0IaYdXRZ5Xrir7CNX9jEhKgSYB53OGQ888iPbzST+M+4EP5Z1J3r3U4B77/C6cqSH1Z4HuQa05i1zHRXy1P2TUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KgCFmUaRL5/BkQPt3HcN81Xh/obBTj0ZlGTTZtNz4Q=;
 b=vHouptHIk+QCmn9Jor9CX7af/h9ih/MR3KEfh+z2rOiPkNdr2KeZOi37m6dF9RRHI0suxzLUY9H24iX6N6kSgojoNvY0IyMdhCoJOpKl9C2gEmCX0VR+9ojMg67NQe91DOR6BekMqPUcO1ryRv3Y4cmp4Mks5ZBMhZDuPke8HL0=
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 07:07:47 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::59) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Fri,
 25 Apr 2025 07:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 07:07:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 02:07:43 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: validate the eviction fence attach/detach
Date: Fri, 25 Apr 2025 15:07:30 +0800
Message-ID: <20250425070730.4033803-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425070730.4033803-1-Prike.Liang@amd.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 350c6fc4-598c-4dba-ca14-08dd83c7e16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fKGfrN+l1Hx+/ernlQWxvMoo0qO1RNDXpkJG1CoMAr/0dTqFhI669agi6r6l?=
 =?us-ascii?Q?hAYBIzJyl6GncwnKprfekktcKE/EWDFXUPRqL6/GoAv3eY1fd5LQPbnkNWKN?=
 =?us-ascii?Q?CZiIm8mI5QdxmmVFmmbXI21e/jPgNaAJ05RwuDNWpwHLTJpm16XgonR1vtfy?=
 =?us-ascii?Q?dbn1ouUSmoyBG5S9WqIkE30V+o9udJdUL7RBbXycp+NyhYs4dsMNHc+r4xWW?=
 =?us-ascii?Q?ZAwl/yqrUsTM1+lUqnOzWyjEUZXU888vqA6morOXSgaYXNc/OnN3kqCyfOYI?=
 =?us-ascii?Q?21RA21HORFIk4hL01sAbsu2FBhfrOLE+PT+8TrHcyNaMgEKGFwKL+Dv5xMVG?=
 =?us-ascii?Q?l/FYwxBEcJrJpEFeb9O1eMf++oxYJQGiBUBIlZnelJUnkWiCXzyZCn3xVhob?=
 =?us-ascii?Q?+2y3kGmY2ZJa6S/CHaOD9QzGBJTNXoiwdMHWxHoSkSYiHQ8rYN/H4JvhrGZ0?=
 =?us-ascii?Q?lwQFfTNwLUOBqyUybgvj+Q2Cbn9Ol2gVIQdlVw7GucmdByQhm9V+tPjZ1rsI?=
 =?us-ascii?Q?APGp8xWH+9HF1WwD95CJ+ZPG/cPYnoNwWF3thjsu23/WNTAFLbzwZtv9sxQ1?=
 =?us-ascii?Q?Awc4svH4gfJHFucy/9oX0Ft8Zh3ySOTkEWN/DGU0uPo2700UcS3HgInhQsf9?=
 =?us-ascii?Q?3i0BJKikVEmFMGzigQQEyuaGchmb7wVcAo6/tz0F3aZMtIGoGVnoawsDjh0K?=
 =?us-ascii?Q?Z+2c4cMzxYi5ohR3Z4RTyR3WNSkFG9oCYTH++xTgXKlzwefV9GLwvSDTJSeq?=
 =?us-ascii?Q?jG8nEcxbyY28BBmSMKI5qCKE/A6GTgdZAsl5B1WFvhB2EKgrV+k1qFR6dma2?=
 =?us-ascii?Q?n5IfqTQGK5VE32s+TSESLoEJqx45GAsEZzRL4e+0epONy/9pCiYJqjUrahYe?=
 =?us-ascii?Q?UtAPmCEJrhH53FsGbmoLM1LIxEfVU8HIF7rUKGTPhpCwWlGuvk526qYTDVxP?=
 =?us-ascii?Q?U+a8VyFV0AoaC7Y6ZoTV2eJ1uaAtyqAQ6WYc+Wz8qEgybBOv0IFPUNZXOAmn?=
 =?us-ascii?Q?Qn5tqd9Qdbq8e7KsShxVdDJyAUqKXXdJjihGKjYBL1zn7ketXq0g1k8CBI94?=
 =?us-ascii?Q?341iZZGwGE3bBC2usNUjq8kEdan9VvgJybf4zre6WZd6l6nuBCN/8kwRWlIY?=
 =?us-ascii?Q?J1nbztaOLCL/4Q3wSPaZaEolj4EwG8L5fBn1Gb2sN+QXLa0qmMA/pLJoiKmG?=
 =?us-ascii?Q?bI5ATnq5hEmsG6A9No0lonf5XMB3zF54fP/i8IKaLx5420oXiZt1NndMyhe+?=
 =?us-ascii?Q?GUH7HetqtvHoRoUwRqUJLlg/6Z70c8w10gje9O5c1cmkoonAhC/QxTjaXEMN?=
 =?us-ascii?Q?mm/GvSa9aggEytw9Vx/B43YVxZyRGIBUiFvOVW4yMaWEBpoDPPmWQvvOqEm8?=
 =?us-ascii?Q?oqOA/TRjlsnu9cQ4kDIO6iWmhTMgkRxhzkEkmdccot1d4S+ysLvg+8XjrIdQ?=
 =?us-ascii?Q?Yn4ijw7maSbNz/d6EIhT19WGJDATJTRUoW3qxiMbS9wYApb7J/548TbaCwUj?=
 =?us-ascii?Q?XoFkD4n3O4kJzyMvOtUj1DfT8C1MDZetwPtf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 07:07:45.8740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 350c6fc4-598c-4dba-ca14-08dd83c7e16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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

Before the user queue BOs resume workqueue is scheduled;
there's no valid eviction fence to attach the gem obj.
For this case, it doesn't need to attach/detach the eviction
fence. Also, it needs to unlock the bo first before returning
from the eviction fence attached error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 16 ++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index d2271c10498d..375f15b6fd58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -216,6 +216,9 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 {
 	struct dma_fence *stub = dma_fence_get_stub();
 
+	if (dma_fence_is_signaled(&evf_mgr->ev_fence->base))
+		return;
+
 	dma_resv_replace_fences(bo->tbo.base.resv, evf_mgr->ev_fence_ctx,
 				stub, DMA_RESV_USAGE_BOOKKEEP);
 	dma_fence_put(stub);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index c1d8cee7894b..04256de4bee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -292,11 +292,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 
-	/* attach gfx eviction fence */
-	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
-	if (r) {
-		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
-		return r;
+	/* attach gfx the validated eviction fence */
+	if (!IS_ERR_OR_NULL(fpriv->evf_mgr.ev_fence)) {
+		r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
+		if (r) {
+			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+			amdgpu_bo_unreserve(abo);
+			return r;
+		}
 	}
 
 	amdgpu_bo_unreserve(abo);
@@ -362,7 +365,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
+			!IS_ERR_OR_NULL(fpriv->evf_mgr.ev_fence))
 		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
 
 	bo_va = amdgpu_vm_bo_find(vm, bo);
-- 
2.34.1

