Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF43C3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6665B10E691;
	Wed, 14 May 2025 17:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kOxqVXvO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4A810E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3KTvvDHPv96USmWICFBqURtQlaD0BwCOc5iV8Y85vvQ15lSCuelwIlevOO2dOxhbJyguD8x5I0AbL/2AqStaFWwCncCnQp3rz/JYzqelQpOW/O2EB+0bD/0nathJEEQt4Rx3ySzC37yEDIUYbMuWRwCi7uqBApfRbr1N2WyTBffTRe4BwtDLfoiLYYgF8LDfmpDeOBzqWFrtEiVdrfz49YMgn8b4SKH9CGYAdqJB4BaXo2t2ZZfq9fmYJjzR5aYfIm35tQy6oKuYyvycH0S7em+j8wuZ44FMUb7pYBdi1bVJrx3dDWtQ6YNjoSmdo8e2wjvgpno4IR9Tnp958KA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHBEOt2IeAPjndY/QanN79a2G4eEREH06UBHdhWdtEg=;
 b=Q2c8mLfaHkvv63T6+tLCzclWXHaeBH06WS8Tu0qvYhyHyBFmOPHWufRgX5NR0sw00HeN71jUikMUbrCPs+9lc5HL2HB9uMMfn7IbcpMTttQ1nm376l6FeEDaf/vfoJj8eUTaKqLkBqJQU7fzXVSo3B7pted8HjWKLLDUlTbSqsbwl3cQIYRV1LrWbC7IzpXDrnygPuOK+TwjfY7FXhOPXy4DWEoKMxB8jU1vDk618MhlCxJUl0JazGkcP7VvoLrnsmG/ikArKXt9TWCoZduyl424xxLXzd99NkmD0Y51ScAhHa+GePhMj9OL4wzMql5U0UIDNzdRO+BUN/ryDSeBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHBEOt2IeAPjndY/QanN79a2G4eEREH06UBHdhWdtEg=;
 b=kOxqVXvOFFDStn/vCNYZyPYI7bPPWj+65JLHVWE5LW+fhNhE7UrfmSVfr9CJrvZHdsNcFaWLd03ylmcsONAgZZGeTxnDeZtJqzmKP9kO7lNqD805HO4Lybd32cU6gq0HESrhI4RUAiQ+SVlBoAAGZFrI58TUPuJ/Ri7B3KXCp1Q=
Received: from MW4PR03CA0247.namprd03.prod.outlook.com (2603:10b6:303:b4::12)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 14 May
 2025 17:11:13 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::f0) by MW4PR03CA0247.outlook.office365.com
 (2603:10b6:303:b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.26 via Frontend Transport; Wed,
 14 May 2025 17:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:11:12 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 12:11:09 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: amdgpu_vm_fini hold vm lock to access vm->va
Date: Wed, 14 May 2025 13:10:03 -0400
Message-ID: <20250514171004.4259-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514171004.4259-1-Philip.Yang@amd.com>
References: <20250514171004.4259-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2e98e5-313e-40e3-4576-08dd930a5427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nD1ZRwSLcutE0NLhQLCFVe4HASRd635IComQzDS9DOdxI2yFHyGUoxS4SWAy?=
 =?us-ascii?Q?0qgutcnqQgNwwy0aWJvU7VuK5YrWcQ8ok2Nvbdcq/kV72GcB2X41Zk+L8DjZ?=
 =?us-ascii?Q?C6qu/S9OmVtVsbT7qJccYs+iImSFP24JwBsfWezS7mR8hfC2ze+d1O4B6PQ1?=
 =?us-ascii?Q?Zsa4pqZyXz8ZxHOvD4ndPs8SCqauI3ZJXtIVmOHqHCn9V8GkLLgBY5AMeCS4?=
 =?us-ascii?Q?QM6UjS+RqwUfpvbAjecZMg5wVjI/3CyKEPvx56xI4XVKK8CyFcWQko8ziXZp?=
 =?us-ascii?Q?fSADTcps7frS56BkgUsDRB7WjWf5HGdT8Y8ofxnRseLDrfwKTmU8kDXVLBs8?=
 =?us-ascii?Q?3sqgnViEhjnBhI29M4kt05z7aPSwa/jC82DsstG5ycNDcerKObFg5PpR4oNU?=
 =?us-ascii?Q?rujigoi3nUZWuasAaDHHst4wWLf44CKq3I5S9BHgeIBU/T7NAotPBq37SE5u?=
 =?us-ascii?Q?fUdwRg3dCbweky3QWUnqdhl57g3z1FwwiJww8HEe202mskWPG3dQX4RhefLy?=
 =?us-ascii?Q?FoqSDrzaPksA7dObV0S+Obap/cup4KmLgv5pk3R748qyELbIBe5N4N4hgpAr?=
 =?us-ascii?Q?RQ1YU55y0W3lxMewWGLQHmhjndQMFvS7yuS44nonKpjGH6ZpeZ2hVcwT+a43?=
 =?us-ascii?Q?wnrcdgS8tD+NaMKLg3lI4u6bTzW4TGIcd/66f5MognA1DwOMBMV09g16QbD6?=
 =?us-ascii?Q?5vgPNiSYlEjMtxNn6T4QyyIyyxJNWv7xgnV9QNfOlMtE+/9nZ6Tjg0oFSjLb?=
 =?us-ascii?Q?DkVyb/BADHUZ/WnVMgQDjSUq+oYlmPoiBFtmS0M542zJEykuRaxep9DDJdl9?=
 =?us-ascii?Q?I1es6YS80w7o/MQELvMAjFXDcdH78gsBGJ++48tb4+3/IOleL8yPvRSPxYNM?=
 =?us-ascii?Q?OIxjVb2szEZQqZD2qWknNVUCPmXlwiPX9ImYL6O49y6FmJR4EG9tccVL0YU1?=
 =?us-ascii?Q?3SLsESVkYOjVHGgQssmpd2kHbZsn1d4+u4ZG6mkzQJnSmRgqzHqnP7ekGCST?=
 =?us-ascii?Q?X1sxaIRdsBeW/idL2lMx4fgW2svnrLRd0GCEzkUqQ4Wlg26KKcVA6/geQj30?=
 =?us-ascii?Q?HggDWuAuRyA6BLV6RWXX7LIFJlg1GExxh/auk53MBs8QmcIQDV09mqCnNEUO?=
 =?us-ascii?Q?Kr80L9CXsPsuxuLwZGI43LE2ulFARjVyEnU/xIOFnGV+144gjWAxh02V0uDO?=
 =?us-ascii?Q?aRW85VpYH6f7QBU9sc89HQgqaux2HovgopbhnuvYk4z/aGBHsokwR1oMnp2C?=
 =?us-ascii?Q?lKtfVaO2t0Cuo3tLMI2kQv4Vxz70jAfP+6WqdGcpeawR/5tzlnC7lL7GPKeX?=
 =?us-ascii?Q?2CerA5Vgs0sd2y++krSFOUtiFYt6vI8WbgU4rXsxFfEEsmF0cv22SFDhlqlj?=
 =?us-ascii?Q?Uhv4nfRhRvIm92PQonCUeRFbX6hyodoSOPhvzAHNNBLYTGl4xrnPWDidtl1B?=
 =?us-ascii?Q?meZ7ew+FIj33J5wZqwy3DOXiWLmKYXu35zzZVryP6J5h+3fPfSrXI3YneKd2?=
 =?us-ascii?Q?TMy7HEQrmhiHlDaAT6X0fA3UMOQ36+/xKsTK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:11:12.5831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2e98e5-313e-40e3-4576-08dd930a5427
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
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

Move vm root bo unreserve after vm->va mapping free because we should
hold vm lock to access vm->va.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..fb5baa6ec32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2740,10 +2740,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	}
 
 	amdgpu_vm_pt_free_root(adev, vm);
-	amdgpu_bo_unreserve(root);
-	amdgpu_bo_unref(&root);
-	WARN_ON(vm->root.bo);
-
 	amdgpu_vm_fini_entities(vm);
 
 	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
@@ -2758,6 +2754,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		kfree(mapping);
 	}
 
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
+	WARN_ON(vm->root.bo);
+
 	dma_fence_put(vm->last_update);
 
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
-- 
2.49.0

