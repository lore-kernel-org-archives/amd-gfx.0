Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39938C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 06:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B430F10E586;
	Tue, 18 Jun 2024 06:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l6vyO77i";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF8010E586
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 06:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+epL5TwJRAJcpywwomhyBVTBZhErgJrJlJZhe3hFbvEbLnpesLmNZSYNb0cSid3tInXh7uaHZKwLWqeWYyQRgkk0+W9hsGiNNNqy3gE/xHhGiPuLT4+B62y3LGy9gdfE5urIVIgYaaIojbvMeINJ5a/vwbqtkIirJ7PsdHXXojIDJf9ThwhKuz03TZeXo3wnTpIUDmndL4eoHoXHJHsh0Eo9XyblnJA2plV2nYlLqOWtP7fXGxDufhL6Es6yf3vCxKOjdDai3Oi8u+aUXLPOxxr2W76d9CRy+D/jFBXoAF7pqi6240vUrmexfVM51cFVt1EOwI6cPi2NI+v0KXJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH8aZietgkdm8dGcLmncxV6bIu5JXDy2aC32nB1u7CE=;
 b=fswGTvP8TBIrpSXSEP1Cv31OOtiePHVsR6RnUjEDjb598yVwVaHEw5juQ8LS+7eJhKTb08h/i12h1X2O3HFvil5H28e8ebtQLsol5gGbQDmsGfSW7ljGrXlCaC1HSBTSsTApMxbA7gWi3G96HnBZRzfxgbOvmwFG7Q7pagkK7Vv2hgcrlf/G6KNJgx15KmCx8zkCr+byrbg9EX6bsPUukpmS4Liswi+vt+rLJjgNdcXfTLNjhhvpfn8jGqIQ9105ebOxA3IuOl83icrTi0JeTEfNozYphJ/h3dBBO6AQCfxoYpRCTVF6G3phu7dkIML1Ie3OcCUVhIXSX7+BE4whHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH8aZietgkdm8dGcLmncxV6bIu5JXDy2aC32nB1u7CE=;
 b=l6vyO77iZ5Fy5Ou8WESf8lkaaEOgZvCrEGY/AC7mqlALsUOT4WVvwHjSU8WGblZ6zm14WEDrPv0Wb0rowiO5HzbAaDgJ6jnJlqYTbRAXo5pUAc1saVcAuYpJdl8fjOqF4TrWxfh02pwlGHdxzo1Gjz2yTMOvY4GpYQqJQmIKzqg=
Received: from SN6PR16CA0066.namprd16.prod.outlook.com (2603:10b6:805:ca::43)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 06:34:36 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::ed) by SN6PR16CA0066.outlook.office365.com
 (2603:10b6:805:ca::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 06:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 06:34:36 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 01:34:33 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: refine poison consumption interrupt handler
Date: Tue, 18 Jun 2024 14:33:57 +0800
Message-ID: <20240618063359.304293-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618063359.304293-1-YiPeng.Chai@amd.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acba2bc-ea66-4c61-4832-08dc8f60b90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s/R8XjOYXz2ORtDyS4vYzXFyQ8PZUEiQS+YWhC7/0vrw2jCDV0VWGBSSD+OX?=
 =?us-ascii?Q?OIYo0kCFvD0S4fYN1kIcA0i4tVk1KU95dbXRpoEOqc3hBuY0GDvH1u69LlbJ?=
 =?us-ascii?Q?Vixw1Hwrlt4142rbzar53mw8VPtZGHM29j8jgkz1Ucc2QUjYqB3qHWQJZ2qx?=
 =?us-ascii?Q?woQxUMS4Pv03t+dN/tWJe5Zz2sKUDEgcG46/z08EwgBJrcuk+r9ISgCPcZwJ?=
 =?us-ascii?Q?m7L2I14mVrzLj6dC72V/iqqYUPQGRfWZsStIpmMKnQK0enYfSsBNC/LZuK87?=
 =?us-ascii?Q?LQ7PM8iaMf5trnvPx+z+AZ/n+r8HNmHHiglECw9xzBGq+e2YUm1ugckiq1Xk?=
 =?us-ascii?Q?3Avwxha/G290o6D8H9ucbXj7MrtDBi4cW4Rf0oCtPhDPUdBx8yASTC62PZ2j?=
 =?us-ascii?Q?onJlO4K75vme7hhEzlPIGcpb0FsOwMhLQ4jdBx7Qb9RQfxU4etOhd28dPvBo?=
 =?us-ascii?Q?19PDzWUXqQmZ4ihwc3EIn1eq3ep723kEPS8a9bF1TT43CTPhMkN5hkrspoj1?=
 =?us-ascii?Q?7TwIKh3wUFSdQ/P5HTMNeAaBrLBgzgrlioqOnfCZ7lDDbuoRH629RbrmVJ3I?=
 =?us-ascii?Q?VZqR7i+QLvjygmoHLzXbDuzcGvsp/DFKBvcjI6Vnfii5xmDzx4khmIk983To?=
 =?us-ascii?Q?YrCkWQWdSQ4eF7FviuZgnZYOpI6UkcjWyawcRSGN1qxU2sNnvMWY9gu/XvKo?=
 =?us-ascii?Q?TvZyg6vpKyyzzb21TwRh2ttuITKdTh1ndueLLTOGE8eZN5dHb/YerlJfG4kv?=
 =?us-ascii?Q?Kosx8FxZ2Yk3ylJr7tefxfVJnrJLWhMOVZ5aP7Ff84ZI7NpbSpF/YlbGzIu9?=
 =?us-ascii?Q?RJ8JM/70Xjo0SA8xSaY0TO0je2OqRAaSnyWt2ksy1Ul0b98RdlsmwlsRHXCX?=
 =?us-ascii?Q?AA6Vk2paweUZBwn+QFE8C9WLxOteLftrAzQa5PT1rQwng5pXDfvK0PXialyp?=
 =?us-ascii?Q?HYqW6sDq8Ypivw/z7q4EcqFkn1LxDs4ivBM7kztZ+wikZ2YvnZ8gGZtfhF9e?=
 =?us-ascii?Q?sr3i6lQeIv01nGu+VKtizrA0Ze3SqIMVR8fXlFxEy7zFxtX215AH4UG5ZoWO?=
 =?us-ascii?Q?Om41+Am09/CTECtYi7eM5Hu21eWvqcm1U6iAt1OWi/HjGlLdbpBv4Q4GbR5p?=
 =?us-ascii?Q?+qMvrGStb8mgRXNaI/ED/+PpcTsj05sVknSyldVLlXFyTJIwN7pEKWB6xBWS?=
 =?us-ascii?Q?t5WmTqxuWjzsLAUTe+HXVgto+GgbNYVdXcspEY8UD0A4UjC7uzApLayUn/At?=
 =?us-ascii?Q?Cgu4//k06bhnkqH2PQSVzUeGBtqITtPayqZSIlwbyOv1ekEMf9ynRHzAenVf?=
 =?us-ascii?Q?ECMwwhdVfJ0l3M4+XpJDp7af31msAe3iFW1HmlvYbDa0critWG5tZ2tDRAA9?=
 =?us-ascii?Q?akJB2Ch87pnUZ4jusSBY2ym05p1M/zKDiX9z3f1HiO1LmP9laA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:34:36.3143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acba2bc-ea66-4c61-4832-08dc8f60b90b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
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

1. The poison fifo is only used for poison consumption
   requests.
2. Merge reset requests when poison fifo caches multiple
   poison consumption messages

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 12 ++---
 2 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 13cd6a9234f2..898889600771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2881,22 +2881,40 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 }
 
 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
-			struct ras_poison_msg *poison_msg)
+			uint32_t msg_count, uint32_t *gpu_reset)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	uint32_t reset = poison_msg->reset;
-	uint16_t pasid = poison_msg->pasid;
+	uint32_t reset_flags = 0, reset = 0;
+	struct ras_poison_msg msg;
+	int ret, i;
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 
-	if (poison_msg->pasid_fn)
-		poison_msg->pasid_fn(adev, pasid, poison_msg->data);
+	for (i = 0; i < msg_count; i++) {
+		ret = amdgpu_ras_get_poison_req(adev, &msg);
+		if (!ret)
+			continue;
+
+		if (msg.pasid_fn)
+			msg.pasid_fn(adev, msg.pasid, msg.data);
+
+		reset_flags |= msg.reset;
+	}
+
+	if (reset_flags) {
+		if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
+			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		else if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET)
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		else
+			reset = reset_flags;
 
-	if (reset) {
 		flush_delayed_work(&con->page_retirement_dwork);
 
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
+
+		*gpu_reset = reset;
 	}
 
 	return 0;
@@ -2906,11 +2924,9 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)param;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	uint32_t poison_creation_count;
+	uint32_t poison_creation_count, msg_count;
+	uint32_t gpu_reset;
 	int ret;
-	struct ras_poison_msg poison_msg;
-	enum amdgpu_ras_block ras_block;
-	bool poison_creation_is_handled = false;
 
 	while (!kthread_should_stop()) {
 
@@ -2921,6 +2937,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		if (kthread_should_stop())
 			break;
 
+		gpu_reset = 0;
 
 		do {
 			poison_creation_count = atomic_read(&con->poison_creation_count);
@@ -2937,16 +2954,19 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		} while (atomic_read(&con->poison_creation_count));
 
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
-		if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
-			continue;
-
-		ras_block = poison_msg.block;
-
-		dev_dbg(adev->dev, "Start processing ras block %s(%d)\n",
-				ras_block_str(ras_block), ras_block);
-
+		if (ret != -EIO) {
+			msg_count = kfifo_len(&con->poison_fifo);
+			if (msg_count) {
+				ret = amdgpu_ras_poison_consumption_handler(adev,
+						msg_count, &gpu_reset);
+				if ((ret != -EIO) &&
+				    (gpu_reset != AMDGPU_RAS_GPU_RESET_MODE1_RESET)) {
+					while (msg_count--)
+						atomic_dec(&con->page_retirement_req_cnt);
+				}
+			}
+		}
 
-			amdgpu_ras_poison_consumption_handler(adev, &poison_msg);
 #else
         dev_info(adev->dev, "Start processing page retirement. request:%d\n",
                     atomic_read(&con->page_retirement_req_cnt));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1dbe69eabb9a..47a46bf49a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -296,13 +296,15 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 				struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 #ifdef HAVE_KFIFO_PUT_NON_POINTER
-				amdgpu_ras_put_poison_req(adev,
+				int ret;
+
+				ret = amdgpu_ras_put_poison_req(adev,
 					block, pasid, pasid_fn, data, reset);
+				if (!ret) {
+					atomic_inc(&con->page_retirement_req_cnt);
+					wake_up(&con->page_retirement_wq);
+				}
 #endif
-
-				atomic_inc(&con->page_retirement_req_cnt);
-
-				wake_up(&con->page_retirement_wq);
 		}
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
-- 
2.34.1

