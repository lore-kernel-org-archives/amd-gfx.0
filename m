Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1229C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4150810EA00;
	Fri, 11 Jul 2025 09:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="asdWBOd5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5373510E9FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5aRLFICXDY5xFPcPuni76BMuRgRm+/lyllxkiuP6X1XHD8U2uybvNe5COMk4ThPchJuCBtmZodPyvf9eaJfYG9xawWy/GD5hPnjODRx3k0RfWJdYCbxIuK25ZK7KbP669HFwMdHoQZiu9VvH9I+xejDFX3FRbJLN3vKOfyQJdyfRse22fwUQqwyKoidNJNAZ6PB2zL6J4CNOszihGGurPKY3dNZe3hlZpx2jHwOnkz2QaWaNZzd9Mq0UjIAj7/weucE57dj27IRwk0OdzYBAM8LlhhgTO0cIDSgfShpwRjj2YRUyzAcX/xrIZkloauMQWkASb1PfZMmUzh1CGSgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGeKES0XZZbAtTwSi6mIie4eO3exS9Yg6osEmVkjx7w=;
 b=ZzRiRAOpRDylUsTP4mG+k9eh/2UGNL+ckciioXUT3blnyoFGtnOObyh1qpyKevvfj2RT5gLWu7EFT0fWmN3AnNMZg2QrqwzpDAk/qBApYRZgi1kBNWj0HxpHt8mf04i+4j/IxVitrN6uhHk9ieC9k/y7gMuFP/SxDi4jBQGqDuCU5dDIcMrv2BAZ+AvyR/svHocK5F57mweiwHJsspNDHQLmseQ2Ih0yZeJbcmMfLdU+CtPy1lJGmEO4g5GGhLW5Z+eUpQtL068O3epl0C9ldBXHJa6zueIFVeZqoARjFIljhYMwjLTFZ42fY2pVRkIkjHYFME2SqdeM8C8fXCZfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGeKES0XZZbAtTwSi6mIie4eO3exS9Yg6osEmVkjx7w=;
 b=asdWBOd5T2dHr4jnVpV3IZDPufr4yCOAG74CP2U7qLN/eI5IlfmHNX3H5tl0hjjWXVZ8w8t/KM5NMjpYTCRZ8AL0j1lfugkJxLKNjAY1YRHAYRt8/V4MSsU/xONZUJx+T65Zq2Gxrh+2h8WEWKh6i7Wkcx/mtNZZmyk6V5CniVM=
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 09:39:56 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::be) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 09:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:55 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:53 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v6 09/11] drm/amdgpu: validate the shared bo for tracking
 usage size
Date: Fri, 11 Jul 2025 17:39:28 +0800
Message-ID: <20250711093930.1411470-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711093930.1411470-1-Prike.Liang@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2d0963-7064-4340-fa14-08ddc05ee4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+3eLVEvNPRce4IqGCJgL/SCLWxh7cg0VD38sIytZWk9nlL33EPs4oOEaeILj?=
 =?us-ascii?Q?fkm9+iWB7PFD/JxtsyavBS+jngI2mT7kNwY/mzy1ZOazAj4uQMEoL1O1UHTd?=
 =?us-ascii?Q?JR9HJrR6r0tcCH+4S2UoiieXBoZYac+3dnKLdVQeFno+YEZApj/t0ekrsYFg?=
 =?us-ascii?Q?H0tDIVZD5lrxZ5YhDcnYakmUCwnESPXgkQEPymhZcPpsjTD6tMDKZ5c3z29O?=
 =?us-ascii?Q?enF87H8CxYKRrCe8ro5+yvBQPKsNZJVk3IjIbYUQAQgAGB0y20qWZiPFTf9x?=
 =?us-ascii?Q?A2dAxY5Q8zkUBNYNWDJ8pk7gSA4geG46MtGaGOnpUalHFuCcyrlavAurDh+d?=
 =?us-ascii?Q?FWSw7hlCbspubSTfcCA3mZpsyS8PcEpf26qqZQJY4Zg70bKRkyCuPQG5XcNS?=
 =?us-ascii?Q?uN4b+DAaWEK9wP3W2Mx2TXIx9R/BoCpqdsdhiFnHDLBbZxKJPPld2we2PcvR?=
 =?us-ascii?Q?02gwc1y5MgmeuAYJEuq4K7poBA31OybekvLw/RoJHKhYS292ZDss6ya/hkfX?=
 =?us-ascii?Q?P2N+HQQdTPQBTFEt+CE7hruL2aVugdNeHaYQNqILnYFnsBXzLj+o94UJS/9p?=
 =?us-ascii?Q?V/9cpdVvJXCLQAX+yQEPTSE5pMg/g6c/qAZiD5VmzIgTXlibGGmbUc4bJcTh?=
 =?us-ascii?Q?r6juv5c4AmG8LgnaHlBq60PX8PYGsDCSuzK0oJkJScqUIcI6D6y/alvofVi9?=
 =?us-ascii?Q?ev6KZMAyINsmsPnebbZRsE7Exvz+TTCRSZksOidB9YAmhLpt+UHa0ylqRtGV?=
 =?us-ascii?Q?MFSRp+CV46/bTP6E/pLywYBud5ZgxHmSHPXBpLSvXy5H2WDL3aE4YosX+ZwT?=
 =?us-ascii?Q?JnLPCStXMYjihO/73/ojOs9HYmbu/XmVf0hVG2IEJ+lbNDGkqmn4S/wPgdw6?=
 =?us-ascii?Q?aSUSEkixuL01VS6lJEatviz4XIGwUFkXSBy2TVre2Ns2te+bMfYxxxFE/nVP?=
 =?us-ascii?Q?ZO2KfzWILCKyRSk4MOBim6/VzFZAj+ItmW7lKCjjOdB4fZ3yeXE867Pht8/1?=
 =?us-ascii?Q?z90SpmT+MsCWYWjyovcMIlg45dHwNi/1XwrpWn2tnwCqloPRnj35+p0uKanO?=
 =?us-ascii?Q?w1QsBeQlKjqpJvN4tYAHinOqcgNytL1uQGyZT+dSDKiNTaNnHNGsnQHjg+jO?=
 =?us-ascii?Q?3WZZj1sHsuXCEzZBScYjBKVLHaMWJzq4l4TpKgp+B1cQk3Fi71wo0HI2ESXQ?=
 =?us-ascii?Q?cCYfmlxiXeHJnTwEnfLa31Gs1V9CWphjXBPRcf8/vApniS+Ll3EOSFv7WAt4?=
 =?us-ascii?Q?q+VZ+jGbCifxH6Ymn7U8XyZIZICXQftF+Fbx4AF6HRde1xfaVYXHrCIPVxoz?=
 =?us-ascii?Q?xStCASEPJ30eDDA8/rJmMA5nZCZeus3LBZAq5v4mycHlMmRHuoqbRNvp1Ave?=
 =?us-ascii?Q?aajPKRGYNnD9ARy1uN1YzvmgKTBkjCD4wZ6J/c9ElurX9CvdwnpA0ood/PuK?=
 =?us-ascii?Q?KnPVw8F+WmxzF8Ftqve8WHgLyVxV8A2eVdmO4OVhY4w8twb93H6J9Ee9DbC4?=
 =?us-ascii?Q?qt8DweZGr+bGZqTJc2v2JVO4FUllIQZsq2la?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:55.5273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2d0963-7064-4340-fa14-08ddc05ee4ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

It requires validating the shared BO before updating its usage
size; otherwise, there is a potential NULL pointer error when the
BO released improperly.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e..a574effdd3ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -321,12 +321,26 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
  */
 static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 {
-	struct amdgpu_vm *vm = base->vm;
-	struct amdgpu_bo *bo = base->bo;
-	uint64_t size = amdgpu_bo_size(bo);
-	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+	struct amdgpu_vm *vm;
+	struct amdgpu_bo *bo;
+	uint64_t size = 0;
+	uint32_t bo_memtype = TTM_PL_SYSTEM;
 	bool shared;
 
+	if (likely(base)) {
+		vm = base->vm;
+		bo = base->bo;
+	} else {
+		return;
+	}
+
+	if (likely(bo)) {
+		size = amdgpu_bo_size(bo);
+		bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+	} else {
+		return;
+	}
+
 	spin_lock(&vm->status_lock);
 	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	if (base->shared != shared) {
@@ -353,6 +367,9 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
 {
 	struct amdgpu_vm_bo_base *base;
 
+	if (unlikely(!bo))
+		return;
+
 	for (base = bo->vm_bo; base; base = base->next)
 		amdgpu_vm_update_shared(base);
 }
-- 
2.34.1

