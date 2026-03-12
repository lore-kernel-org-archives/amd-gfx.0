Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FFD1067036
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 14:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B1610EA1E;
	Thu, 12 Mar 2026 14:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tWq+Otdv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 186BC10EA1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 14:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqxOnvTLimW6AC/IHj+iAVqrWv78s2yPDzmuWG8ScmI5dP1TnU6RPIoRs3chVgJK/jNwKp5uSWV8o5vq0V8d3FpLrRD7gNq9PMO7Jy7Vgi5vWk+hIyBff3NtegftGtfj1yvKq0LEyJRvDTJcBxoQQ+zM6//g8711MAfx62f99hYBVWD6PuddTGESYldcU1wKBNXnJJHjo+uuVSR6pvVb7mQ6LJPR80mu3uEcM9HHa5XvlkniMQ0aePhelGcxKb6gdt+eh3jtbV7xDwp+Ni9RXV3I+KP4yDmS71OqHWkVVUhE3kVUKt10N16hNfuBO2sl6JZQyQSEgrFscC6Dqb7oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDyoLY1uNEPpTMhGCuyGo3fVz5XDWMI92MqSzAp8FtI=;
 b=tC4INthCCN1UXAwhYOJlzGsjTkhkX2uUbgFZG0WZwzPAKrZXihQBDPo8iXf1IgFMtrNqJf+fM10ZY7LQ5Cd9jbC/mJ+jFx8F1vYNSOy+QVl+ixySJPvW3TN7htk88tD68FH05LsuyFR4gLrrxaUsFkpsVFCpEp3lMWnsdh/3kXjXXfiV3OAjUpr0iRvnQI4JdH4C4fe1CtvqdaIWm+gdIu+rEUyI2g1JfdJfVLnPyU9F4aLwTTB+ZGlGibQuUy8nelTK4IzB5lNRQPO9JQYMysenQy0FaRu/ygBiQkBp4NhaXKOne7VEWLNCVKmphZVoI5qn3XFqQ+yavpwhsV/cLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDyoLY1uNEPpTMhGCuyGo3fVz5XDWMI92MqSzAp8FtI=;
 b=tWq+OtdvP0UarniFI/VdU1bryZjNPo0O2ctgo6EiX1l95mmpWY/pL//1ufIZbT9zTd9+0KpihSP4kGZJR2ftp23V/Rl7Ag2iuWXQUMEo0upLPxzV+l+13YDylYjpVbcaOCim2gbyLXroKYUEH2IwhzG8UbPHp7FfXj1ryi7f1N4=
Received: from CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::23)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 14:13:27 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::5) by CH0P221CA0007.outlook.office365.com
 (2603:10b6:610:11c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Thu,
 12 Mar 2026 14:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 14:13:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 12 Mar 2026 09:13:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH] drm/amdgpu: Add explicit NULL check for bo in
 amdgpu_vm_bo_update()
Date: Thu, 12 Mar 2026 19:43:15 +0530
Message-ID: <20260312141315.1851106-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: ab207352-1aa1-4a81-be70-08de8041871c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5r0aIPUB6GvIRyM6VizykbZ+kfP92+G45pya6lv0JAC+V+kKWn10KEv3GfPjTzqGrtmtJD6c9TwwdNIyaSxc0MYlTN4lB05yn9jJdpWqYEcWoqX999bWDeHpwelDz8tbTlEQkMpnVaUjl4qAKM94FkiYVYJf1lJAv2q3vNVuYsWmgdxv8fVR2vk7oiZOBq0Z8MvRXu8WsuVdaQyDdHEBYfhZmKRyMBw6a0nOfWRilERedq/NK1y9v8+UGhRvaLMgNPI7mAe9KEEB58t7AAQEVDgP4/MCrKXuXmCCZhJkKVBYe9elD45/I5oey6mVjK+FTX45wbfhvClvRdF8XmSci/CBsr8SdElci0Fq8qSSJ8YeIOzBlis9F6/U3l06b85dg3JLyifFm8PtBx6KgNwq0sTXvwAA+khXIA18GOOlWJuoLl1naXaD2laMi3+nqOdROA4kUDO4zrjd43IAXmVuDNxWRDL6oMbZbcLnEo+4r33rWqHrBYFHel+t8rCxnRhWuRNFGXIc9k34xV6ZCtkjAUT4/3+8D/l5Qc2H4oQtaprcr5st1Zpgf4mBg82Mf/i3e6vg6cxD295QjvfYfZ/HbX6zhDDJ4ZT4uoWsuN/8S0wxRvnXYvZCef17kosOdQqEuMiZwUuMx8VrnA6cdj0RjHigonW65OocihuhvhaNvQBGj3Z1W5RJ+uwHd5tswPGBSp3dh789e5e4lN+66T24drnQbGYGGslQNb/Ltzu2Z/9lq/E6Rmu8xPz9Gh6+vofq9JJ9DrQjCjw6kSwHXFA+2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N5F88FUi2vgZGatBTSJnJNdpM5pW6xKfuxvtp7h42LZjD2B/0LW/alfzoSXUqf9KSwx9YjYOT0FcMiQCTFgHVoa3T7nOethqYSMuakuO1+uB1BDGvXai98xLc9f5w2cSmX57JxlqYumYWvEyu+EPfdnkkeFX8hYREeqW1fH+uVtxp8fGGoUcqrDuF7rn3lmscIWsmulAwa7oV0na3DrAFaseDfG+V7n5qD6+jrTHePZpVFA5Z4ZQGcMTxNxDdEPGQ8x75xHIrIHelFyaPyepPkB5YECTogIvzmfDqCy0O4uRzkH+44qL6z47eDDa3idsB9fNTQDeuYlUb9QvQWvOHNsPG58WzFrzs4dF3dN1lQGVE6l+ivbQJiPI0084/wIzi1gH9LIf+EptN9lTrOeXFIkfFA0zpySogooEz3FsCGWgMHmmGaUDYTSrJXLSAEHy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:13:26.0693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab207352-1aa1-4a81-be70-08de8041871c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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

amdgpu_vm_bo_update() allows bo_va->base.bo to be NULL in some paths,
such as PRT-only updates.

Although amdgpu_vm_is_bo_always_valid() already returns false for a NULL
BO, Smatch still warns that bo may be NULL before it is dereferenced
later in the block.

Add an explicit `bo &&` check before calling
amdgpu_vm_is_bo_always_valid() to make the non-NULL condition clear and
fixes the below smatch error

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1353 amdgpu_vm_bo_update() error: we previously assumed 'bo' could be null (see line 1292)

Fixes: 26e20235ce00 ("drm/amdgpu: Add amdgpu_bo_is_vm_bo helper")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b89013a6aa0b..0d26346178d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1349,7 +1349,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	 * the evicted list so that it gets validated again on the
 	 * next command submission.
 	 */
-	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
+	if (bo && amdgpu_vm_is_bo_always_valid(vm, bo)) {
 		if (bo->tbo.resource &&
 		    !(bo->preferred_domains &
 		      amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type)))
-- 
2.34.1

