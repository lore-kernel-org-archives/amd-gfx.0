Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E963D3A67A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840E310E6B9;
	Tue, 29 Oct 2024 17:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jUHeNUs0";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62AD10E3A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC/5ztahRKLA30yw1GatywaaPvGOlalCnnT1Y6NbCDXZblC9Tmhd63LgC93bzTPn23j/FykBgzve9vesZjSVPg/wGX4FOqYdpwCxqOvd4jPNo8AenvKxuCwuv/8iPx7At9fS30XAxr1XUnU+sroBvijVydxixaSa2JIXME0KgWf/Zs7B2Isvv4CyslL3PGipGFwk3SiSuLr0QZGKzD+RPa5/aBFCOaFHjxHZvFGfO9lnzBHA+RX4E8UK6RAXzbqFtZTlsVg2twdRXrBZV/2ydk/plUJiZkUaWFx1bUtK1IAI1BJKoROKDEYd/O+Mnk5L8/osWkjlFHALoyAm3a9ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r51i89kMgGL304SOXDZb/3t+nKR/Y6mLsC86xnZyx5A=;
 b=F9UwmT1wqwK68SmqkL9X+6+L06yMPFTBILQ4+WamHT1xMfJ4x6NxekL4OedsoIoXKPsBnmmhd1hWoEm0kkHG7Q7fqYBVfq1YXdYWkm6cfXsAbttGwChn7pkYig0cZW1NjN+2jIIV05VdK+hpp0Oii8R6/EVaNrD3wEWZ/D8z6sR6Hm2dJiUKS/5yso+60pSfvs5E7bbyVyQuLR+MG9rVHX4KsbG21SkAFoWMs3KPFq+2dSNpJU1t+OcWGKhYSH5RZJm2mQZzIJHnGCk9Lv23i7MjHrWjVNT0DkZXZrAlKgEy+JilWU0x0nfsK+PeG0lRHyYP+2Fg3idwQAVFdjW8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r51i89kMgGL304SOXDZb/3t+nKR/Y6mLsC86xnZyx5A=;
 b=jUHeNUs0o1MR3NPgMR9nbIDOoT/734ihrST6Hj5dtBWs7jQtdcSGo9GtphbOP3J/rKFRUZWoPSyqtHSY0eieEQhClUmTWxlVETEk9Ay/24gW8NVoA2PZzsCjhdCsZ/dFwSobnC+JyjHU3iKvo3Ra4+DLW1fGhlPleYbE8ZecEY0=
Received: from SN6PR16CA0059.namprd16.prod.outlook.com (2603:10b6:805:ca::36)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:43:09 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::81) by SN6PR16CA0059.outlook.office365.com
 (2603:10b6:805:ca::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:08 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:01 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 22/29] drm/amdgpu: sw_fini for each vcn instance
Date: Tue, 29 Oct 2024 13:42:33 -0400
Message-ID: <20241029174240.682928-23-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f86e814-1fd2-4758-c0f3-08dcf8412703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+dJ6OusCzhWshaba2+vU2mZ0xXm9FsFbZ0gKtqmCOYWyJH9vTzvjVCiaG3yG?=
 =?us-ascii?Q?rVjsZ9j7kmevH/EicW7gxn1b1OH0UIt+JUSOQFmbGRgl++xSLxIhKXhgTF83?=
 =?us-ascii?Q?yPc+HoechCHSD5vGPR2rED3goXzN0HkzMzsafDuOEtnoqhyRjxYvixYCKwHY?=
 =?us-ascii?Q?aipm+hwP1I9u2Q4w5sqK2IrU3+c6A5ABy0ii98/dDX5OHkPacLTBOucHBIOh?=
 =?us-ascii?Q?DZbSWQz68XDdSul1li/xpSjK+jAQFAIJp7YvBJHdt99FtVVD7R6/be/1ayfj?=
 =?us-ascii?Q?/d0yMfG7HptmyYHzu0t7dYxEHQFipRKdkOt+MkW36J23F1YZYqfd+4OIyGNS?=
 =?us-ascii?Q?byvHlTB4sNoRlNqIhamSL4U0btT1aJOBamh04V/sC2X4Hf/1rmzRLEhN7hPi?=
 =?us-ascii?Q?aDuezIbRYvLCxJPtq9gIHdQUdxiPD0ls09dhNP5o/MYXS4w6uEsyicBF4IUi?=
 =?us-ascii?Q?WIwnELNqWfFCKvDcYw5uZs5G8KdyzAv+wtRxsQH8aoIER30H2rRHrDsrJcP4?=
 =?us-ascii?Q?0UAtec7sBTxEytwgEuxWIPfM0tM8eKtgsg4w4zUHxWlcQseEh4KdrGvJqKIF?=
 =?us-ascii?Q?Js0J9zx+um75OSoYb02VRKYMkYEeapEtiApTabT8YWxL6c0ayTrA+mrnim+9?=
 =?us-ascii?Q?C9Gz1ClZFdMS3fso93IJEbqSMcWaTSTuwyyx7+1kLTuewCxkST2sTuJkE0tr?=
 =?us-ascii?Q?bvn65507/eOy5jU5p79JJ/cX/65sRnf/eKQ3CCZbHxGR9mImNIMWiLglj0oF?=
 =?us-ascii?Q?KBlydXPqcwNkT8ddVBmlqPzUsMUbXvdRkZyMGe2xhCaHCEsFeHB+Qckn0d3W?=
 =?us-ascii?Q?XtbQ+hiUKz9B0WlwyLx+FmQ/Na83AfdLkV9LdfxZ3UY0dslg3Qs/n95Tvqn/?=
 =?us-ascii?Q?ax4dCmp0Mg1XqnMvaj9viFOB0f94OnG7JV8pjgbiy31F1wVtQRA/+wO0PS+c?=
 =?us-ascii?Q?AZvC3T0c//qvqLzKBlCG8uZdKmpFoszcUE8JmYCY3ZLsGsuAGG3md8MucIiU?=
 =?us-ascii?Q?HK3jn+7lbU+Mm/kdoNSlTutddJwT5L/Lo0nnMxym7KuPCX1B00X6+sLL45vZ?=
 =?us-ascii?Q?NUOfOHgLrkYFzRaRoH+ecgAqM5WX8uZYEI/4UIXdrwzCxToasL5TSwnmF6cW?=
 =?us-ascii?Q?qIJJcCYJDSgIoHBjhn9RIWhpA16zQTXh7Q7L7kzdfjC3PNPG7ox2IRFav457?=
 =?us-ascii?Q?97qIgwPbKtEvRGiEcBZfZ390a+tlOxmBZDSJmVMJz83KJM7oj81NszNztWGj?=
 =?us-ascii?Q?RjwoLtGFe8YBzu2ib7yyqTysNta4cuOX0ri8RgyzJq0WyDbqjQOqS8TVzYnm?=
 =?us-ascii?Q?bWNnd4oWiRrczJAS+3RhwVBW9IfnAGlHTZX1FxgmuykKPfu/MhufH1kATrnT?=
 =?us-ascii?Q?nDdsmQ9ie/yDreWifBzWRRBWDhyPuBUR3NXFJ6imNqhIRMcm2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:08.9950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f86e814-1fd2-4758-c0f3-08dcf8412703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_sw_fini(), and perform
sw fini ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 36 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 21 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 +++++++--------
 10 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2c55166e27d9..d515cfd2da79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -248,33 +248,31 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
 	return 0;
 }
 
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
-
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
+	int i;
 
-		amdgpu_bo_free_kernel(
-			&adev->vcn.inst[j].dpg_sram_bo,
-			&adev->vcn.inst[j].dpg_sram_gpu_addr,
-			(void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		kvfree(adev->vcn.inst[j].saved_bo);
+	amdgpu_bo_free_kernel(
+		&adev->vcn.inst[inst].dpg_sram_bo,
+		&adev->vcn.inst[inst].dpg_sram_gpu_addr,
+		(void **)&adev->vcn.inst[inst].dpg_sram_cpu_addr);
 
-		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
-					  &adev->vcn.inst[j].gpu_addr,
-					  (void **)&adev->vcn.inst[j].cpu_addr);
+	kvfree(adev->vcn.inst[inst].saved_bo);
 
-		amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
+	amdgpu_bo_free_kernel(&adev->vcn.inst[inst].vcpu_bo,
+				  &adev->vcn.inst[inst].gpu_addr,
+				  (void **)&adev->vcn.inst[inst].cpu_addr);
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
-			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
+	amdgpu_ring_fini(&adev->vcn.inst[inst].ring_dec);
 
-		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
-	}
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+		amdgpu_ring_fini(&adev->vcn.inst[inst].ring_enc[i]);
 
+	amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
+done:
 	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
 	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 4809da69bd1b..ce8000ca11ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -485,7 +485,7 @@ enum vcn_ring_type {
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 808d69ab0904..44370949fa57 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -222,8 +222,9 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
+	int r;
 
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
@@ -231,7 +232,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_sw_fini(ip_block);
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index a86cff00d761..7b5f2696e60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -245,9 +245,10 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int r, idx;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		fw_shared->present_flag_0 = 0;
@@ -260,7 +261,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 9967ac3fc51b..d135e63e7301 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -297,17 +297,18 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int i, r, idx;
 	struct amdgpu_device *adev = ip_block->adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
+
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -319,7 +320,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index e89088e3cd1d..d00b7a7cbdce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -306,19 +306,19 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_fw_shared *fw_shared;
+		volatile struct amdgpu_fw_shared *fw_shared;
 
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sw_ring.is_enabled = false;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sw_ring.is_enabled = false;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -329,7 +329,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1b492197c2b7..7c3a62f84707 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -258,20 +258,19 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -282,7 +281,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5b61000f3004..5a3de3dbc3c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -219,16 +219,16 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(&adev->ddev, &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = cpu_to_le32(false);
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = cpu_to_le32(false);
-		}
 		drm_dev_exit(idx);
 	}
 
@@ -239,7 +239,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 4d944636d02b..2c9f863c40b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -227,20 +227,19 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -251,7 +250,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 8efedf943581..9d67e884952a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -194,20 +194,19 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
-
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -215,7 +214,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
-- 
2.34.1

