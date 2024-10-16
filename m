Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD50CD2069A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 06:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6898410E68C;
	Wed, 16 Oct 2024 06:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qJzpXzBc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99E110E68C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 06:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKIvy1JTliO1bEJM1aKioonOUz5O4YktbJwc23zgW083v6oAvgcxOcg26pT1hm8Gz8GWnm/tt2ePvEwi+8Kcg4IQmbPaQoEyCtjEPrpfAa118EKL+b4iHmVbZtCYnTOG2I2MzNuasGYLmIouwJnjfsrxBxp1gAfTqftsGnTrxKZVCQh+HSX0sdnsYhTmTPosZ2K6oIj+WfOf7K95dNjjV34gGQeMrL9wCj2jXNUeOlAX3FocVWtoLYEtBCojUrXrfERYOavSxaxghKBO3ypcOnyBCk4SB8r2vs/nwmmNGN3m+e4DGALLYtj4JZhTKxnUsZhVx/KAVnPm6Zplu+efxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb6CQm0o4ahX9iWniILmdfqdWOFFMGsncTAmP7R/rDw=;
 b=pyECP1HAtL5RTIYXWtsVAN8Ub5LgHtKvBOyUWVGC7xT4mb+Utn1biUurh4XtSGUTqugULP4svizUFXEsiGtXrtdA7HZteYixSMVK4qVdVL7wv8BlUb5Rc8Su1t9Qi/ORcLAY5l7SHujGqiAKwGFG33TVIqhFIdpuEn6lotap47rzxCWDo18jazMRYqbnuiKCN1+nTHHXRXFmWNmPsjKdzhpsuKOHOjRGSQ2QpoAZsnRrz/REFTvnerUhTNuK7mtXuvl5apVnKes5U/EbPxmOWM5V8r8qxdg+6ycqZnoxJx8i1G1b8Lq/mUaW3xgEDpC+wuq8SNjRLnKon7FrkGP8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb6CQm0o4ahX9iWniILmdfqdWOFFMGsncTAmP7R/rDw=;
 b=qJzpXzBcW/+p6av6YhtPwmKNHvJ+wFZmZCQpI6F/vsTuxkuRJ/g6TEsrkdQUPgxSj2lywobgu/Xwsdx43Tk/Hwzxdy3ADT+fKL+uQahBV0iGk++VvxWlPIxzJmwhwtcBAXKR3fadERUhqiiHYGlyPxmpl4i/Y6sW7+gz28sKR7I=
Received: from SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 16 Oct
 2024 06:03:34 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::f2) by SJ0PR05CA0163.outlook.office365.com
 (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 06:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:03:34 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:03:31 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v4 3/3] drm/amdgpu/sdma4.4.2: implement ring reset callback
 for sdma4.4.2
Date: Wed, 16 Oct 2024 14:02:19 +0800
Message-ID: <20241016060219.1811607-3-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016060219.1811607-1-jiadong.zhu@amd.com>
References: <20241016060219.1811607-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac63bde-6a1e-4ec9-8559-08dceda844d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pglQqlTPSiwki+tu3vWQS0m776EorKsBVBpQbdoZSsq7J7EHNYJP885lxPfv?=
 =?us-ascii?Q?6GR7nGjdNISbYXbCUymLg/D6TnTYKriOLI15IjS6hMM0BQL9VXqyHji/Yi5K?=
 =?us-ascii?Q?A2m/XD/YmxyZ1sFTyrtYVaJ7XLlMc5h3H58CeBsDZuu9dNUzC2RJDumYl4FP?=
 =?us-ascii?Q?Fvq2u2Ob0wVqnsfJS5qEbItt2+0wZiXklZP+1g+nAuMVQbOw+qUUDB5UvPAq?=
 =?us-ascii?Q?OYt/Hgud5O3jGoDejD8jwB5Hu/ClUKb4CjqYQHhBMUDqJrmpm41PKMZqpXEW?=
 =?us-ascii?Q?CCwA1jy5Bol1bW39HsoEBndDoH0q6O+YJa9T3apt3XyFk4JRTyY0Xj9C/TRi?=
 =?us-ascii?Q?9vNY1G5OVmJuQ2+CZv/mBdBaIKBN6l4t2pmamRwRJZQLofBxQvw+FJmoe+F6?=
 =?us-ascii?Q?++oQSVttPUKK8HojvpRrkDHAS3xNwWFBccUqaR7V6zFwpcFR1BaKZFllPxU/?=
 =?us-ascii?Q?PjTbwXlBKqnfSaw4B9e9jQFklL4PzJO/rBT7Htawzhpz67ESKT0lB6oP+YNz?=
 =?us-ascii?Q?DMQs7pmXO0vHAkgywkKEoPijqnf3UYHL3LemkIXDbYR4nH10GQnZPVxZmfhd?=
 =?us-ascii?Q?KitSfGwrkXDDITHPfYUcfsoUfFRj0pKxdkWPsno3Eg76p2ivR6JzuWn+K/05?=
 =?us-ascii?Q?j8/E88NVrycvvErCs8MQTNBz1XNMd5qXQYfj4oAi3H7ahXf1IyrnuNv//Icn?=
 =?us-ascii?Q?Mxo9Zfh4lZ13yC98RIuxgwTiLWudkrxj9L+4w0KH5F3K361Dq8ulJuXnVwmq?=
 =?us-ascii?Q?aEGW/1/Zh5I8uS1lCvssgKOXcHhIeaXrk6OMLFYc07/SY5IWDvsVULwMQJs4?=
 =?us-ascii?Q?TdyiTfGEB+vM157azuyeUuVglkUkU4waLfLmCT84lEgYNTqLRgGOuA5plTbQ?=
 =?us-ascii?Q?KVGT5M3mImt1xYu3w9jU1Zxo63IhcDWVt6bmdMWtMc4Uh3fXwI6kni9DwsEW?=
 =?us-ascii?Q?lg4QAk9Amyhzx7CLJNROHqSH8jVPnbyg+6iwcUuh5shwrUGsHUKspE0T660D?=
 =?us-ascii?Q?WsRIye+OL7Uq5QqhRhC0Sxyb/LHbFb6+h3ZjJ7d+G+kBLPmuSyObL/jiEpI/?=
 =?us-ascii?Q?wyElCrAd1hgOFwuEGOPZM8BXEW+xj+zqxrDaJ/cBRk89IuXCkqUpMa3yqblQ?=
 =?us-ascii?Q?QwdHqP44ZOq9sI7m+1HlGHxC/Djaa6fRyY11btfD5XUmbv3p9w4YO9wjFpBs?=
 =?us-ascii?Q?LNJBE3/pb/2BnZ2KUn3u1GqAYnF0XxICUexdC/KNr+AKGhhehZe+8YCj79DP?=
 =?us-ascii?Q?ZQBZyVq4SA9VnsKQ5ZQx99JgomUooeyC0VXFW6ESU4zvEY1MJY8LVlMCAUEZ?=
 =?us-ascii?Q?p98Klj+g48RNhwJ65W8AKSjuZep5acJZebY7GPuyVq+ZFxxpZaDMrA2vKtt+?=
 =?us-ascii?Q?b+yR+sUIrSzer5MXLlsMgsYq5bZh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:03:34.3222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac63bde-6a1e-4ec9-8559-08dceda844d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma queue reset callback via SMU interface.

v2: Leverage inst_stop/start functions in reset sequence.
    Use GET_INST for physical SDMA instance.
    Disable apu for sdma reset.
v3: Rephrase error prints.
v4: Remove redundant prints. Remove setting PREEMPT registers as
    soft reset handles it.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 90 +++++++++++++++++++-----
 1 file changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c77889040760..29e2066a59ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
  *
  * @adev: amdgpu_device pointer
  * @i: instance to resume
+ * @restore: used to restore wptr when restart
  *
  * Set up the gfx DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
+static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -698,16 +699,24 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
 	WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
 
-	ring->wptr = 0;
+	if (!restore)
+		ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
 
 	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
+	if (restore) {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+	} else {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
+	}
 
 	doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
 	doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
@@ -759,7 +768,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
+static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -775,10 +784,17 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
 
 	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
+	if (restore) {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+	} else {
+		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
+	}
 
 	/* set the wb address whether it's enabled or not */
 	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI,
@@ -792,7 +808,8 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
 	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >> 40);
 
-	ring->wptr = 0;
+	if (!restore)
+		ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1);
@@ -916,7 +933,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
  * Returns 0 for success, error for failure.
  */
 static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
-				  uint32_t inst_mask)
+				  uint32_t inst_mask, bool restore)
 {
 	struct amdgpu_ring *ring;
 	uint32_t tmp_mask;
@@ -927,7 +944,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		sdma_v4_4_2_inst_enable(adev, false, inst_mask);
 	} else {
 		/* bypass sdma microcode loading on Gopher */
-		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
+		if (!restore && adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
 		    adev->sdma.instance[0].fw) {
 			r = sdma_v4_4_2_inst_load_microcode(adev, inst_mask);
 			if (r)
@@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i);
+		sdma_v4_4_2_gfx_resume(adev, i, restore);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i);
+			sdma_v4_4_2_page_resume(adev, i, restore);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1477,7 +1494,7 @@ static int sdma_v4_4_2_hw_init(void *handle)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
-	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
 
 	return r;
 }
@@ -1566,6 +1583,42 @@ static int sdma_v4_4_2_soft_reset(void *handle)
 	return 0;
 }
 
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, r;
+	u32 inst_mask;
+
+	if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	/* stop queue */
+	inst_mask = 1 << ring->me;
+	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
+	if (adev->sdma.has_page_queue)
+		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
+
+	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
+	if (r)
+		return r;
+
+	udelay(50);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!REG_GET_FIELD(RREG32_SDMA(ring->me, regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
+			break;
+		udelay(1);
+	}
+
+	if (i == adev->usec_timeout) {
+		dev_err(adev->dev, "timed out waiting for SDMA%d unhalt after reset\n",
+			ring->me);
+		return -ETIMEDOUT;
+	}
+
+	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -1948,6 +2001,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = sdma_v4_4_2_reset_queue,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2160,7 +2214,7 @@ static int sdma_v4_4_2_xcp_resume(void *handle, uint32_t inst_mask)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
-	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
 
 	return r;
 }
-- 
2.25.1

