Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9254EC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 10:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1663623A9C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 10:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1663623A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C1316E0C1;
	Tue,  8 Dec 2020 10:17:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6146E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 10:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWJ3jpnQU9iaoshjKfczDxNRt23591r9kyyteCxvCZKFsSXpXCIsuKZPMt/iBOfa6d1xayOR5ak2OhaJpsfo5CDP501wQZ2eA5C95OaPP7as9/p/CUGkx/lGAKcu5r6CFZYLAOdz6mfr7alhlM9LbcB/B0DyVUS8SfDaRgbVAMsmuOQEWos35gwqPqjuCtivczErzUPKkn+wD64yISvIw4c5f4sb2h75aGYeIf3cIbx3hvPDJxp6S4yIJnd/jr3NHf50RFkKWktF9ZOISgUZjeOM41COS30kczNwEAaZrLo5wBRFJNDg+uIQ2HHV5+g2MHApNOEzyUEcrLT5EEiXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nm6DLqHn2frhZUX6VdZQo98lhVu4KZ6i6TJlPjEpWo=;
 b=hHGAeK6jdztc5aC8DrtJWMLzZdrzi1SJXvZfBNvwJMatQ7Y2JASPaxEfwmXCibV5/lXm//Y1SYQSRL9/CIJ+86ev91/S/9M9BIzpzwk0wLMqQqtMYD70urUa9sowILKsjgFjOAOxs6ckr8TF0pDwIn3i3n9NVEIkWeIyisz8LHnfKJItlP+xdDWZnUVKJg8sV1rJ9Z9DsxjRFBJ8NrIoAuMtXVZzK7soFI9DdzhQgnkFOx6x8O5FyNPa4TtkK+9v7vKQBH7nvLQsK9r6dpeuO8dv7M7ICrac/7o1zWX079pDsi1Z323g8/HtmgFpf6pc1yKkmcoBvzZEFdA0JORzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nm6DLqHn2frhZUX6VdZQo98lhVu4KZ6i6TJlPjEpWo=;
 b=tGo3ajrwaeOTI2gwtSRgGbAYVpvSBuIexZ18ES1qhj45eoYXuqbMYEA87MkEE4VGQfvEKYzM7moGc3ChEl5rD7gqKYhxcD2fwRcrbj+YgU7+XGvZJLHg8/xD1WT42IDluziXsNQPlo93LSjdcAdhXdSpEzW21FvKQlk32UG7y4U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 10:17:54 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 10:17:54 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: use AMDGPU_NUM_VMID when possible
Date: Tue,  8 Dec 2020 11:17:36 +0100
Message-Id: <20201208101736.22352-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [217.86.115.138]
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.115.138) by
 AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 10:17:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2dfe83d-fc99-4d0b-8bfe-08d89b6286f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4843FC4ADBA90C34171CEBBC8BCD0@DM6PR12MB4843.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/GyiYzy42Dgxl9cFZ4KZvFm4FIa70Ati+yrhLyLbbva8dMuQtSzr+tVjuHX8gWOrfadPW5f6ueOwfX11MfBq+LvF1RaCshWS+KCljNPjOGgYV8tX5q+maBF+1MvzTHyAVbFrnVwfOZf9Pm8G5xhqFSKnCisesvOeOATn9/VDOBzDefvQsdx7Gy7GW/orN/YWscVr3iOb7KVxJ7GFMw8LoGWdBPOuboUlzwfv7AjqkNm1fLwYMLSGVJEKBQfk835wyaqVsq7pSdTEpOZEra9B33HRg6uUDnQv27QANjDATX4A/t4ggn5TNwP1dnmYOQk0xtT6/xb1f2TKVG3anJCfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(6916009)(8936002)(2616005)(6512007)(44832011)(956004)(36756003)(5660300002)(6666004)(478600001)(86362001)(2906002)(8676002)(1076003)(316002)(83380400001)(66946007)(4326008)(66476007)(6486002)(66556008)(6506007)(26005)(52116002)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dKzjFiZQ8rvQ9l1UFCVFZfhR20T1SDIv34DPED8XExPtY3JwCJig0buJueTN?=
 =?us-ascii?Q?SG9M3/P9n73QtonyzMA11144FQG7//5OK8J35e7HrtCSjDLfiVKh/Wmvav/I?=
 =?us-ascii?Q?414+nZ5Y6Iz24CG7vj1z/1523EyOdQlCYAvrmYphVO1yJ8NMpmIaH7Y53xID?=
 =?us-ascii?Q?nv14Mt26WSAh+4xmY0k4GFvhP2OmsyKgI3qXHWbvIYgW3eC1TEMBKKY72xuH?=
 =?us-ascii?Q?tzVbuzaz7UR7EwlAKgnPi1+nTCXaIU8AMK75F29QAsVnbUwrcG9yCiA7zev6?=
 =?us-ascii?Q?1DJz5MF7HHjB43FmoAY7oMaIrLukrMxiif0U/oR8QhN71XUGcQilDeZ1pZJU?=
 =?us-ascii?Q?/agCSrLjS/6iHPgQdZG8uGAs61Y3v1DV11NRnszzqjRElPUnoaEYHeW+pYEk?=
 =?us-ascii?Q?ob7sa7fxDzHRLmfuwK/KHdgi8rSTspacwiayzOrgJIsFfGoThC2oR8Q+dFhn?=
 =?us-ascii?Q?s0WN8E7RPINwM1C43bveDRTkl0j3i2j6fCchk0qa3caRFFCBqKwl3B83eHnz?=
 =?us-ascii?Q?n1BczNZQ5MYjKy8lQBAzFHj0O/soWF1G5vkgQdHpkxbTHaA8OIx/uBN71ddd?=
 =?us-ascii?Q?1eEb7zKr8+W1Us6w41EuTPjs2J1W9pxT+QBwbPhCYUQKqMWZI7OFrQgE9mnr?=
 =?us-ascii?Q?rJIXCcChurvC0G5uAcGKLRHm6lmcEgy+rm/Wjm2BqTzKTQ/xPqK2YoEqp26J?=
 =?us-ascii?Q?EkR+rbYc+n2pspuE8/Q8QlMqpvtk6I5yKrVH3ABeCj2i9wU0Zy+GnkxXLkFB?=
 =?us-ascii?Q?V+ULwUmEmANgXQVmhNH4FJYbXkVItW5HsMu6pfvi7BRsIwwEBpbjna7eXYDA?=
 =?us-ascii?Q?2IS513to5LRFvJ9JpagcY31m6mnDia3Dgl8X8qNKyrbU4VjD9F9JnfehbuTa?=
 =?us-ascii?Q?OJM4XpRw0rpCdeB6HXWvPK8TLCCncq0pViB324XFknZPz7o98YVyETsg3LLS?=
 =?us-ascii?Q?DVuOTmJdfDofMjMhbnBV6uoS+AqsLXVabML1H3augkCcUGanKoIPS4wpj6Nz?=
 =?us-ascii?Q?6rRp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 10:17:54.5181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dfe83d-fc99-4d0b-8bfe-08d89b6286f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQui3xa4umrnf2YR1VCGiMNHLJPCeivhf9iYxKjKeZ/SpVO5iz4VP9BfADDB3A/uoM6Diq4U0dvxQjzoEp870w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4843
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace hardcoded vmid number with AMDGPU_NUM_VMID macro.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 157ae3004cc2..ba1086784525 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4844,7 +4844,7 @@ static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
 	 * the driver can enable them for graphics. VMID0 should maintain
 	 * access so that HWS firmware can save/restore entries.
 	 */
-	for (vmid = 1; vmid < 16; vmid++) {
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * vmid, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * vmid, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index f2490f915a8b..a368724c3dfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1896,7 +1896,7 @@ static void gfx_v7_0_init_gds_vmid(struct amdgpu_device *adev)
 	 * the driver can enable them for graphics. VMID0 should maintain
 	 * access so that HWS firmware can save/restore entries.
 	 */
-	for (vmid = 1; vmid < 16; vmid++) {
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		WREG32(amdgpu_gds_reg_offset[vmid].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[vmid].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[vmid].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9a905531f837..37639214cbbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3749,7 +3749,7 @@ static void gfx_v8_0_init_gds_vmid(struct amdgpu_device *adev)
 	 * the driver can enable them for graphics. VMID0 should maintain
 	 * access so that HWS firmware can save/restore entries.
 	 */
-	for (vmid = 1; vmid < 16; vmid++) {
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		WREG32(amdgpu_gds_reg_offset[vmid].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[vmid].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[vmid].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 60519431ed91..fc9bb94eaaf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2520,7 +2520,7 @@ static void gfx_v9_0_init_gds_vmid(struct amdgpu_device *adev)
 	 * the driver can enable them for graphics. VMID0 should maintain
 	 * access so that HWS firmware can save/restore entries.
 	 */
-	for (vmid = 1; vmid < 16; vmid++) {
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * vmid, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * vmid, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5317efc942a4..11fedcf86fae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -432,7 +432,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		return 0;
 	}
 
-	for (vmid = 1; vmid < 16; vmid++) {
+	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 
 		ret = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
 				&queried_pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 95a9117e9564..998d6c8fde79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -530,7 +530,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
 	 * the VMs are determined by the application and setup and assigned
 	 * on the fly in the vm part of radeon_gart.c
 	 */
-	for (i = 1; i < 16; i++) {
+	for (i = 1; i < AMDGPU_NUM_VMID; i++) {
 		if (i < 8)
 			WREG32(mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR + i,
 			       table_addr >> 12);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index d9cb887b3a91..d06e3f5e38ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -677,7 +677,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
 	/* set vm size, must be a multiple of 4 */
 	WREG32(mmVM_CONTEXT1_PAGE_TABLE_START_ADDR, 0);
 	WREG32(mmVM_CONTEXT1_PAGE_TABLE_END_ADDR, adev->vm_manager.max_pfn - 1);
-	for (i = 1; i < 16; i++) {
+	for (i = 1; i < AMDGPU_NUM_VMID; i++) {
 		if (i < 8)
 			WREG32(mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR + i,
 			       table_addr >> 12);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 65d7bc108151..e8d07109c628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -903,7 +903,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 	/* set vm size, must be a multiple of 4 */
 	WREG32(mmVM_CONTEXT1_PAGE_TABLE_START_ADDR, 0);
 	WREG32(mmVM_CONTEXT1_PAGE_TABLE_END_ADDR, adev->vm_manager.max_pfn - 1);
-	for (i = 1; i < 16; i++) {
+	for (i = 1; i < AMDGPU_NUM_VMID; i++) {
 		if (i < 8)
 			WREG32(mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR + i,
 			       table_addr >> 12);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 0309d84c887d..d7b39c07de20 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -344,7 +344,7 @@ static void mmhub_v1_0_gart_disable(struct amdgpu_device *adev)
 	u32 i;
 
 	/* Disable all tables */
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < AMDGPU_NUM_VMID; i++)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 57d5f8ffb764..092ff2c43658 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -421,7 +421,7 @@ static void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
 	u32 i;
 
 	/* Disable all tables */
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < AMDGPU_NUM_VMID; i++)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index fa77eae6cf47..b72c8e4ca36b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -376,7 +376,7 @@ static void mmhub_v2_3_gart_disable(struct amdgpu_device *adev)
 	u32 i;
 
 	/* Disable all tables */
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < AMDGPU_NUM_VMID; i++)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
 				    i * hub->ctx_distance, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 66748bb01b52..4a31737b6bb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -405,7 +405,7 @@ static void mmhub_v9_4_gart_disable(struct amdgpu_device *adev)
 
 	for (j = 0; j < MMHUB_NUM_INSTANCES; j++) {
 		/* Disable all tables */
-		for (i = 0; i < 16; i++)
+		for (i = 0; i < AMDGPU_NUM_VMID; i++)
 			WREG32_SOC15_OFFSET(MMHUB, 0,
 					    mmVML2VC0_VM_CONTEXT0_CNTL,
 					    j * MMHUB_INSTANCE_REGISTER_OFFSET +
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
