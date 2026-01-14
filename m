Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ECBD31A3C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 10:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C686B10E5EE;
	Wed, 14 Jan 2026 10:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Y03+za4";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96F910E5ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jk04FWSIPpWsPy8UAwROQBbVJ2ihZPznR5+kIeIcXkVEPJQeSe0KKSeAuILU0VI3Q0YBYmC0ZFfb2Ay/HZA1gZg1y4kkj94gqZEKYc9eHirCvxL68GOTqI3cOZKW61ViC/nZVR9L8giqIRBv0zIcjlfv+nU2A+ty+NvIGRThIAznuBgOVJa9wUbNJsDplifc4FYilwZftXaN2WI0T9Ob1tADOM6WlDs535BrDpHVgpTthaOlWbcntU+7w7SgkfbOPX6BpBp7S4hKsRwO+k2z2u0TKvrH8+4+098hfqBMPx+uVj3q0UOqT+2/RabvPPYMblIJqIYHkVu/qVLdscRkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkcXwIqH6mdXS/EQXRgIcvoFIa+fVd+2SAdhbQ0E2Z4=;
 b=hAxG3szaZ2geC+Tpp7cR6SrNiFdo3/fJ1/uE7kYdNQ+zU46CxX5BWwTZzkEL2BE0G1EcblnmOJeASpxJK1qLmP3iC8mfnl6yuB5yLb/aDKActx27gSs+z4N8MxZCmvOxCJxFM85pfmhwY8QW6OcVowuTKEHrC0LdpyDwK5hXrq5eoWVoRRUoRu+FR6eQt0VABpUHKVqmb3mcJlgyFTnKk+4csCVLzTS0JMY+jlDr61bl2/dqVyjnHDhUxZG/jaC+3/GZLp48ffUg6OWeEQZgepke9FlbJu89/knyB6W+rBa9C9fqVPGCKCVRMF4MkKkl6zXoq4deWSPmzsCaMiboEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkcXwIqH6mdXS/EQXRgIcvoFIa+fVd+2SAdhbQ0E2Z4=;
 b=1Y03+za4YUkvJXA/1tmgVyl57+tVVvSOL3pOK/QCnpcIrW4LCkPI7Er0v2imaA/mz9UyhQjb6tiBB18r21WeTrxTyxAq1VVai3iIk3K4JS23unFdxS2e7/CeTQdIXwGwIgPCP74fR5O5ptHkkCSvK4WRF4ZVom8fsUFklf6/r44=
Received: from BY5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:a03:1f4::15)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 10:18:05 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::a2) by BY5PR20CA0002.outlook.office365.com
 (2603:10b6:a03:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 10:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 10:18:04 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 04:18:02 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, "Jiqian
 Chen" <Jiqian.Chen@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: free hw_vm_fence when fail in amdgpu_job_alloc
Date: Wed, 14 Jan 2026 18:17:41 +0800
Message-ID: <20260114101741.445524-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: c09b1cbb-a349-4482-9800-08de53563459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGte5Uabnk4wzx+zFfePfYoh68xIKHhu+iDETPMQ9m1MgN9cKNKYJjp/JgR3?=
 =?us-ascii?Q?NsJ8mAefI6+nYTbcVwoo0cmqbxU0XzfZApR+bA6HZSme5ctVrzQIPbjbcKOU?=
 =?us-ascii?Q?7y6NXTk5iREJjd+l+WfqJwReQf5VaHk9KjMU6MmmfXA+2BJP6w+Vl2yUpJwv?=
 =?us-ascii?Q?aURK6xL1e8cdMJzuS/xk/WjPaYUBws1PnsDmLB07XJCSM8p+VywgF1LHUJuX?=
 =?us-ascii?Q?OMUt0yTMv7nm5+c/pMy+9YgRoaUMdREx+dfxGQzUgMU2RtktKilmHaKeLVCX?=
 =?us-ascii?Q?UTZlXWP2lFKt75HhY7DmncuyfsMhC7qporL0N9cIFYwPVwYqMKTpzLSeWaU8?=
 =?us-ascii?Q?+eg69nV+ssgnOqQ/7bv62GzzVU2r9ZF2fZyIa/uwTxljLKp8ogAc40J+u/Ga?=
 =?us-ascii?Q?CkIlQi6yJSomyrCW+TT/m4QO7bwaQWN9DrE5++Gi+/zjnwfDt3FSAQhgDTHR?=
 =?us-ascii?Q?inaeGxADXeXGG71alL7JQ6xjlAjHJAtI8kF4baxwTJAZco3pRCZIxYF7zA5R?=
 =?us-ascii?Q?mnRqukX2uQgxHcjof8wyzQZFjBcfLmXX6nvVZOk04OK4uCHgFYCmdNzNigE9?=
 =?us-ascii?Q?gAvA/rvBbwZJTgao18g2ipxmhliJksYJyA1ztINuPVRgPVcqcbkWdk+L7XrP?=
 =?us-ascii?Q?XBTC10V1WSJbKuC53Fhtt2N4qRpIHOUheqHEL8g3oz7+xt42dBbidaFjQvdn?=
 =?us-ascii?Q?mvDd9yW7Wo4f81pN5uhuHC7KzzHnaa2VfF7H+PSqrnbGRph+CrAx2DYANfLq?=
 =?us-ascii?Q?sgN/AM4WOx41jwM2+QHsqgnSygBL/dslKhEZlVytlFM+qgWuf1NGQJtHK4kx?=
 =?us-ascii?Q?YozdQOK4pv8g6jYVvOF1XBNjM2ZNAecAUpY6/TK6yi6ZOCu1EpYUs6ExhvfS?=
 =?us-ascii?Q?n0OvYkTvOc1vei2MQ8hIIqsbqsvbOnyDPuN6/xJM56nYAyH4fAA9gZDoauqx?=
 =?us-ascii?Q?PspEh6prDoafbJAiqy4MxOtkeM05jR7ElkQ2441fF+2mXn7aEZCmiNkln6Ru?=
 =?us-ascii?Q?XLfMRmzjnmGABRBiYam/47Wk2/15zAunUx0lcVT6SsfaC237YULwwaFvuKo+?=
 =?us-ascii?Q?OicUjYdcLqsvvguyFVQFyNV6vxBNJ/o82tAtHsbAzc+Yq1/2GtMTjYj7xsU7?=
 =?us-ascii?Q?ABwGEWQ62HkTWnB1d3PyWPzAPSecsx10KFwiI9djfi5cZ5QgVz3sR0JBzOR9?=
 =?us-ascii?Q?HCjgHryAwjtOMCXUnyadoWq0pgWBBNlfXg+2ulPUlvDa7jBWcUS9YGhmisWt?=
 =?us-ascii?Q?qH6QDy73djY45F+Bi5al3azi0d97tmyCj1hl0dKmOIGDOaqr89UNIU4QvsQI?=
 =?us-ascii?Q?RpTN7N90G0ifNCbSS74YMza9CdytJG9qhVcEIMqsKL6cC4+l8G51YA6QZgkj?=
 =?us-ascii?Q?PnyC5jw+Ab+VlvzrPzPFGyhnIXknyZygph60x5I9ySN79blZJOngIxVKLNEf?=
 =?us-ascii?Q?VoJJTYpAptGPCZdlMCG9nr2akSkyje+WzPh+3zvL0dUU8mgmtEyvIEE4gs14?=
 =?us-ascii?Q?0el2JP+GpDcknViPwfILNSpjC8cd2a4oo8XwIIO3ueRAS6w5H7xi8DXkIETD?=
 =?us-ascii?Q?aYQra0cOlI7ocRV5ufA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:18:04.3055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c09b1cbb-a349-4482-9800-08de53563459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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

If drm_sched_job_init fails, hw_vm_fence is not freed currently,
then cause memory leak.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7f5d01164897..a5d3b35353da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -216,11 +216,11 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	(*job)->generation = amdgpu_vm_generation(adev, vm);
 	(*job)->vm_pd_addr = AMDGPU_BO_INVALID_OFFSET;
 
-	if (!entity)
+	if (!entity ||
+		!drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_client_id))
 		return 0;
 
-	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
-				  drm_client_id);
+	kfree((*job)->hw_vm_fence);
 
 err_fence:
 	kfree((*job)->hw_fence);
-- 
2.34.1

