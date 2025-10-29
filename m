Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE3CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FEC710E805;
	Wed, 29 Oct 2025 17:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vhqpzGPi";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD0410E806
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCVS/kIb159EpOkqkoOLvHV8IjWamyl71/1LPc1kpXH92ggKSV6Gfo0RsDUZcQt9OJLTMBJJTt5imwOdQs5jONv1IKXUbj/BS0JLAXoqPeUOuUGhDACNWFZzKuJItXX01Wtx56gp+v/Zc3R2Tvn8l4gkygzyURoX1SqoUUrtxxoZAKQOyQyXWVpryMqxIUlHmxXWxoSYDN+G6tW9gIN0dNm7A31aHxClmvQL8ZFWvfeiY4LbS7e4NrNufQK5JoslFXD1z6luURj3TvnYF92vAMljXmbAELzfg4Qgcu+NUmvlmq3XDisn+Wpdi77+nAFS1pxj2XBPMqOAwtyYmDtMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1rbxewHttCjvgTT8X/uQtvY8KeRICvmsPw2KysuJBY=;
 b=TzRZ8h6YMWbRUj7MF73GzRYqJofHuKMqUukPhPzH0W4qXm1c/TcfyYcpEpVJu9KJteO/2RetUqwT+f2Rul+UNTv9O7rdFZUjRe16ARyqIJYQzibcWGlUaOi7fFs25a56L7cC+oa7bg6y3+h0aTjEnggbtxOm/oJETt/gg6QYkErmimq2kxEvBSVR/jauFAFqCcbSEsFrIjqw/OFX30zslV2GdVzER2a1PlabS1QGxv3A2+uO7vALzmKa3i2LDqIdHIVRgxtZX7NQSctM37c1ct33V/hztKAbMCz5rGj46s1DXqORjbzFjfoQLmXqpxljHKzUclmXMfdcImsIL2RgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1rbxewHttCjvgTT8X/uQtvY8KeRICvmsPw2KysuJBY=;
 b=vhqpzGPi+tJz97ihswqUQB1k+epeTuPK1tihZCrtzk1z9ypwGLtZGEvqfFH1ICZpwKcPDce3qQh/Ixf0ypRV/Qi+YfqEblh+GFbRScMWC4RSi0sLDHoabjz+DF5Q1MgNHDzU3VBcx1woLjcEhtzZOvGApRbf03f+Tqd+TmcTphk=
Received: from MN2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:208:23c::33)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Wed, 29 Oct
 2025 17:53:12 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::f7) by MN2PR18CA0028.outlook.office365.com
 (2603:10b6:208:23c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 17:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:53:10 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:53:06 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: GPU vm support 5-level page table
Date: Wed, 29 Oct 2025 13:52:40 -0400
Message-ID: <20251029175242.2861740-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9a0972-9dd1-4f77-e3ce-08de17140689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rP8N1Nb4kirfgN2Rsplgx0datr99ca01sL+c2KT8GpICk94UN5x/VgJcqHw9?=
 =?us-ascii?Q?F7Um4gTchUos5uBjFWDspe58XPqeU5z+8bO0Gv16ojCfFFF1iyqFtT2ZVGm4?=
 =?us-ascii?Q?txTIq1AcuCSmBoz2NhwIVXXg2OJSvJbNCVDzoIwuGxZtIXHb9Bvhf2dMGUD+?=
 =?us-ascii?Q?/CoOJOMqQJHw6PyfM9p/d6jeFX3+G6kVa2e5xqHjJK0wALa3pmKhLXuGcz/C?=
 =?us-ascii?Q?EfP7LaIPmFBODsDNFO0GPT1IcTjwS6Ol5769Z/ec1lm53ubn8fbpVS4u01f+?=
 =?us-ascii?Q?ahFM8WQ6x1tWGQVDHH9aiPHlzBkDCKUcp7NhSXwq7PJ5NJm31lSVtDTBF8aI?=
 =?us-ascii?Q?rljnrhfXcao4eEMKBjaUSJRWpxQQve+fNM1+vM0PmsuD8+GfGQ+k3+1j9Ont?=
 =?us-ascii?Q?Dy5SbL5JOkYt3X5r62uBQc2CAhsDAeu8aS3yXPRtnT87YtdXo9GVIBzUDfnK?=
 =?us-ascii?Q?yWJM9XOviYvnOdO+ARxHbmbSVqa7zaPrFIp4kYb2hQY7qIacZRYR5GS1qJSU?=
 =?us-ascii?Q?zrMSeopGeYw3RnuZjgMIv7ejMk15gZL0xcQ1DGLaZepy3cwu1oAyfIIYL97c?=
 =?us-ascii?Q?pJb7gg5zjQk1NmZ7BHr1xUUq7H75wa+5W6z/LhZcKE999B0M4lNlv+klgWrk?=
 =?us-ascii?Q?VGNqpdFOQKVHX8zoD7cXxSnCdNhzdu5IrD1TJYn+olIBLLiM/ENuyy8IicfN?=
 =?us-ascii?Q?VsEj9izW/MzY5yhCnHWvAje/gz/fUp51XiAazMUWcPViNCGdveaPQdfKW8HR?=
 =?us-ascii?Q?SbaZYKqq6ZBTTxYBrYI9QiXi2Im3L+WkyRwer0y6dK+h6xEZfjdCzoGwZatT?=
 =?us-ascii?Q?9k/9p1WqV22ZmUV8ev4YPqS8rcIIZR7Nw9oeKw9aayPuck68S4DApmijpPl4?=
 =?us-ascii?Q?Rfe687F+R9R/PVSJ2Mub+VtYshbDwF3rJHUpWuxMfjoTQiCW8KwdwTHXmQhV?=
 =?us-ascii?Q?sLFdW88nWTgOr9+h07E4eJB50WnXRUl+FWavrbVLvCc1aly+QMge+la2sTsY?=
 =?us-ascii?Q?Fm9JQ05YCboF2dXdIYXQ6DjNt6gfz2+fNTt0uokGf58G3lY9swZ6kLb+rn58?=
 =?us-ascii?Q?u0xYPVx9aTGxbvzVX1jGAYrXmVJgdlMJWJu8Ypm87oYDeOeCusCH4t4/VfVT?=
 =?us-ascii?Q?ok6+B8Q3yiPg6NzrfjXmCdJN1pLw/2amfKmiJjoYy+QuxCaI3LWznHlV2OGO?=
 =?us-ascii?Q?5vHYaNoryQYqkX3qukHOBkqnlZEpmoy7NjAL7sBWfR0Gw3SAYpbjvq+Xg7s6?=
 =?us-ascii?Q?MQIigQVKSDh8VOX55fqRFRFhECagDGV7c727eG8p0tUY1zvKpmZLyZAZM6Ek?=
 =?us-ascii?Q?FV287tW8xzg7VFtCPZB20tCCdgKB0r5LELXUVtlyr3+0ZzRA8hUVXv1cL2Ii?=
 =?us-ascii?Q?qiSisSREjEhZfu8aGm+I5CpdnnNQbO4RhzMmhooQRDFQif5owSdJ6NBZiZqJ?=
 =?us-ascii?Q?QqInZOxmkVIkjweSqXwUS8ZCzuyIHDqCxwqtNenyJqPgI7fHIzrDOMP+/ok3?=
 =?us-ascii?Q?2xvby4y/FfJJSTjiaMPLkMpqa3O4vZo2v4e1pIp1iwLYY82gD+o26pRXwRfi?=
 =?us-ascii?Q?G7MP090D/EpSPu4PUzo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:53:10.9252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9a0972-9dd1-4f77-e3ce-08de17140689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
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

From: Philip Yang <Philip.Yang@amd.com>

If GPU supports 5-level page table, but CPU disable 5-level page table
by using boot option no5lvl or CPU feature not available, the virtual
address will be 48bit, not needed to enable 5-level page table on GPU
vm.

If adev->vm_manager.num_level, number of pde levels, set to 4, then
gfxhub and mmhub register VM_CONTEXTx_CNTL/PAGE_TABLE_DEPTH will set
to 4 to enable 5-level page table in page table walker.

Set vm_manager.root_level to AMDGPU_VM_PDE3, then update GPU mapping
will allocate and update PDE3/PDE2/PDE1/PDE0/PTB 5-level page tables.

If max_level is not 4, no change for the logic to support features
needed by old ASICs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1fab953e9a030..df67a9752a390 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2352,9 +2352,26 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 			   unsigned max_bits)
 {
 	unsigned int max_size = 1 << (max_bits - 30);
+	bool sys_5level_pgtable = false;
 	unsigned int vm_size;
 	uint64_t tmp;
 
+#ifdef CONFIG_X86_5LEVEL
+	/*
+	 * Refer to function configure_5level_paging() for details.
+	 */
+	sys_5level_pgtable = (native_read_cr4() & X86_CR4_LA57);
+#endif
+
+	/*
+	 * If GPU supports 5-level page table, but system uses 4-level page table,
+	 * then use 4-level page table on GPU
+	 */
+	if (max_level == 4 && !sys_5level_pgtable) {
+		min_vm_size = 256 * 1024;
+		max_level = 3;
+	}
+
 	/* adjust vm size first */
 	if (amdgpu_vm_size != -1) {
 		vm_size = amdgpu_vm_size;
@@ -2397,6 +2414,9 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	tmp = DIV_ROUND_UP(fls64(tmp) - 1, 9) - 1;
 	adev->vm_manager.num_level = min_t(unsigned int, max_level, tmp);
 	switch (adev->vm_manager.num_level) {
+	case 4:
+		adev->vm_manager.root_level = AMDGPU_VM_PDB3;
+		break;
 	case 3:
 		adev->vm_manager.root_level = AMDGPU_VM_PDB2;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 78129cea7cee3..bea9485db3197 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -186,9 +186,10 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
 
 /* VMPT level enumerate, and the hiberachy is:
- * PDB2->PDB1->PDB0->PTB
+ * PDB3->PDB2->PDB1->PDB0->PTB
  */
 enum amdgpu_vm_level {
+	AMDGPU_VM_PDB3,
 	AMDGPU_VM_PDB2,
 	AMDGPU_VM_PDB1,
 	AMDGPU_VM_PDB0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 30022123b0bf6..f6ffc207ec2a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -50,6 +50,7 @@ static unsigned int amdgpu_vm_pt_level_shift(struct amdgpu_device *adev,
 					     unsigned int level)
 {
 	switch (level) {
+	case AMDGPU_VM_PDB3:
 	case AMDGPU_VM_PDB2:
 	case AMDGPU_VM_PDB1:
 	case AMDGPU_VM_PDB0:
-- 
2.51.0

