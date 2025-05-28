Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7866C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 01:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2808E10E268;
	Wed, 28 May 2025 01:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="quktLhjB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E0F10E268
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 01:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLxG2w2WrBtqO4KQvwlb2xgyClefD889KvtDGgZX3Zh3LuexVO+/Xf5OVPBDUeBPU9Ocfczuj3Xuqhyqp6uijYhI2mO2RIiCQF7Hfi+k6IGkYBCh0hfR1KKMHE9HGKqXxNhjlQ1/souys/cSbAMxImCFedXoIT6UXBw3jjMDhlUhKjNR6iz9k9CpMPqMwT2xrTgu36qRBasoQ+BOxhhCfnMfKgEbz8l9NVno/qvs5IussAfSafvprN8ERxOh2lEXSb1D6sGhbhQkO/mmseDk6DJrKawZmW+jPNrRThhSG+LlOJLBkdEqK965d5EHsN0xHB3RJIIkb2PUNgQGpoD7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo8pSUNe7qPxslStFM1gZzecj10ZK3VOH7HzszjgMKM=;
 b=MOnDareihUHYB4XQxQwC2RHJlIWxJCTxVbTgCVR0+M4ZFPX5MGCOR3LrrpSCEm1W0G11ZWfDDGT0mACmd0AqHGmUfvdOpvuOhCxWo6xLeppsfV40rqgHeb3fiWxYrI1UIErOhtiJfL8jwluI7e0caBakaQ9Ujcv+1op1TeL/wUEwkVbk60zq8RvPUonCvUwRir1MLubyGfVGjJ/2zvOUjd0l0sRV3OcFJXBq/7PgX7BSYHrwDIB2SbD40VKgJTiD+72ot3/oeM60UNpCmgeAZCEwSGenCNSf0VPsT8pmP6+V5VvntCQ52yWHCwhRwo9G0YSLHdd9nXpXis/ekxHxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo8pSUNe7qPxslStFM1gZzecj10ZK3VOH7HzszjgMKM=;
 b=quktLhjB1/xCuIyrzq432J8cakPPAubGk0z6woTTEU1qJ/M4sCDbKhhzkemnI0/gJPm3h0tFvs9NRqOy1hVBC+q5xO9HqJBpqSjSUuhE498TsBbwSVxSVJ+E+YnkZlR+6CrVwo7caUjPa3U72FO6lK4zLVUty0G78LiPP3HdvYA=
Received: from DM6PR12CA0014.namprd12.prod.outlook.com (2603:10b6:5:1c0::27)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 01:55:56 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::6f) by DM6PR12CA0014.outlook.office365.com
 (2603:10b6:5:1c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 01:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 01:55:55 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 20:55:53 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Philip Yang <Philip.Yang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH v2] drm/amdkfd: Map wptr BO to GART unconditionally
Date: Wed, 28 May 2025 09:55:44 +0800
Message-ID: <20250528015544.831374-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9823b9-1549-4516-a270-08dd9d8ac8de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OeAXXZNON0wrAw1YrADWmLWW6KJTX2qOMpj8HX9rZP7vDeBz4bMjXQMIimTs?=
 =?us-ascii?Q?FsR+nYfxGD6v1MvfSwnY6MdcXUr2LOw6q5gZzK+NEGqsf/gT+TODCfEinqfU?=
 =?us-ascii?Q?DEBKo/EK5H4hpGp5Tc9DWFfScHaPU5OpDPDekHtg086WUoBys0FSAlbrLPd2?=
 =?us-ascii?Q?FbtIeovv8/pMM8S7UQHzgcfg9ZSG44b9Pynv+7d2/uF0pzLWXpw69ia36vxY?=
 =?us-ascii?Q?HQabvW6WmeV4e6gMOi5ZQj2mbAj4Cvsu04ZnkI5WqnKEEalnnEFI9uN4oMYm?=
 =?us-ascii?Q?jY0Mwo609HylwZwRQpOe8bslKzczZu4IRhzstGQsGRJTzkt+DReDXkSLf6DT?=
 =?us-ascii?Q?qLICzD3UsEy/bTzVulBsNyrbeLShDpnOTfn9bJ6DNOnUWO+1wU2zLi5I+M9Y?=
 =?us-ascii?Q?xkNK5NIdp1pq8UDVihG8TuyvjaEo7IYnIcZLBeuwss/evD40wVn1xA3M+lH0?=
 =?us-ascii?Q?CyZBy8DNdWR//K2oG9r3pZtKA6yBM7tNks0q9E3rGWg4QOqTgwtqCRNfIy37?=
 =?us-ascii?Q?YpYsW9sdLuaOsJQsbx7vV31EK6+BR/vzUfwuAKz9kIEn+XJil9fVwPM7htl3?=
 =?us-ascii?Q?cWYM3fGctvRO8w+N++5Bl9mUZyC26bA/+SMNzV+6SEqiyPB0gY7RpBbkbsbX?=
 =?us-ascii?Q?0YNbmsVd8kpvcHmRep0f0fnu6waLvyFrW6YZeD/yxjI+W5RRVtZ7E20D/k6V?=
 =?us-ascii?Q?LWeGmvAzGg/MSJNcfKUHPBLb5uoVbXMwEoiOM39fqWqQW/kn4sPv+Rpb5alE?=
 =?us-ascii?Q?bWbp/8zm/HqAUA3I65ktoO0z0/KN4iIB+5El3dt2D1stnD/gl5KO2ZnHAVqP?=
 =?us-ascii?Q?a68LLgk9tnC23Edb5CptGl+ljzrMIYwvUS5xjipdcJLijDauaz/UQc9ZRJ49?=
 =?us-ascii?Q?RzBDDFHWox42KW2En4kFjTk6BMCS+8rglmCuDcpVAu+cIWOhTb7ezBcdLPRp?=
 =?us-ascii?Q?LUMJy3Gjlu8c5rCYpKKCFunWwlSZjxaBXEIbK5Icu79RYr/zM4PTXzUoRs+q?=
 =?us-ascii?Q?We4HsHy8sHC5Y2GwisNizpK1kT5orY1sxPOUCFvIpb9x1sBDZoqGwLAOtUD7?=
 =?us-ascii?Q?kNf4AvqdoTAAxA91BPs2taIz8WMpty8OM0Vg7xkm2bJgcv4+OvSuOFKBEVSZ?=
 =?us-ascii?Q?hRT3x2ge4WXK1wqfIZ1da8EOcorja7nP3e4WjV+76Mn4NaHxrUi0cP6nc8zv?=
 =?us-ascii?Q?jkYHTavxSkw4aIBo/10CTHnihQ6C4nRq3SUIPjsYgoUg11719shS18SQpYag?=
 =?us-ascii?Q?g39Cwhk7aql09uzuIxrZu9GSWwjHbQpU+Ztldkb9iAn7TL620WHXbq1Vtyt/?=
 =?us-ascii?Q?96ErVH2aEb9x61A+womSGfSBjgqbXet739X6GBtXoYptu8V/Xd3VEL1xh6IU?=
 =?us-ascii?Q?+Z2zPR32hW3HCfXuE4jkt/DsndarA+BPCIAT4PgAD/iiFpX8UwrdXwwl7i5R?=
 =?us-ascii?Q?2QNO/3aE4ynFNITc9IWtaVNH110bs8xVZxEipnK/AsxXsP2YiZ01A3eIOu1U?=
 =?us-ascii?Q?xAoID3/RiYYqN+sbwrHop5++EdvCZSeXC160?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 01:55:55.6762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9823b9-1549-4516-a270-08dd9d8ac8de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
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

For simulation C models that don't run CP FW where adev->mes.sched_version
is not populated correctly. This causes NULL dereference in
amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo_gart)
and warning on unpinned BO in amdgpu_bo_gpu_offset(q->properties.wptr_bo).

Compared with adding version check here and there,
always map wptr BO to GART simplifies things.

v2: Add NULL check in amdgpu_amdkfd_free_gtt_mem.(Philip)

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  3 +++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 23 ++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4cec3a873995..d8ac4b1051a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -368,6 +368,9 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
 	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
+	if (!bo || !*bo)
+		return;
+
 	(void)amdgpu_bo_reserve(*bo, true);
 	amdgpu_bo_kunmap(*bo);
 	amdgpu_bo_unpin(*bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6d5fa57d4a23..c643e0ccec52 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -279,20 +279,17 @@ static int init_user_queue(struct process_queue_manager *pqm,
 		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
 		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
 		 */
-		if (((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
-		    >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
-			if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
-				pr_err("Queue memory allocated to wrong device\n");
-				retval = -EINVAL;
-				goto free_gang_ctx_bo;
-			}
+		if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
+			pr_err("Queue memory allocated to wrong device\n");
+			retval = -EINVAL;
+			goto free_gang_ctx_bo;
+		}
 
-			retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
-								  &(*q)->wptr_bo_gart);
-			if (retval) {
-				pr_err("Failed to map wptr bo to GART\n");
-				goto free_gang_ctx_bo;
-			}
+		retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
+							  &(*q)->wptr_bo_gart);
+		if (retval) {
+			pr_err("Failed to map wptr bo to GART\n");
+			goto free_gang_ctx_bo;
 		}
 	}
 
-- 
2.34.1

