Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50029C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 05:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA2C10E17A;
	Thu, 20 Jun 2024 05:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xvIZaFd2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1EF110E17A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 05:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7Bi/70PJrmJEXE21aG4ci3dCcn60c/SenHpvHwT6ml1CSorHijel/4iemF5NJgVqOqtrzmgGpQlZWljgdIS3cqmg5A8yvhCT9RU0Xil4yf6iNxgpXLHsiabArmXxQuzRvweETWzQOIIg1KgSA+PbqTp3UHPsCifPmfHLB0xdRNCzBWh+EMocW9OTN8KKNssrap+9cT5NNvjGkhg+mAGr4poboNfp+ckhrXFDkFCqLVwIgWKwPHU+jfFCrzbA6GyTp9l+kxXzYarA3nw5ltalkekgHQquBnrnaGCc4qJw+74NxhL8D45wA8AlWXvygYrAM421l+W6G7+qDz+vzurVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZsJ1/Uzznac+SVoFNp62F25l7rn0HfqHwSlzKOHg1A=;
 b=Sf43X582zKo2lsbvlJha6TnDKy17qeez36eb/ZULFq1cYx8i4gADwGdW152fDt6xM+WGRBHw+L7fdLS73iVkdx3GY7VmABVIyjNv9UycSaAyczqKkjrosigZqEVAfu7Pyu4uiigiN6hMOSgUD9242L3qAIwhoAwdLZFp2C0ngcw1Q2ijNs3FTWHLXnvlg2DVYp3LSW3Q8zlDqExV/xMq6LfDzqtfcMQdrKtkkprcOhG9APBUTGYAbwkbbRoHHlTX3BPpcTlPESqtdlWma+u48CBkU3c1N9oKja1WZIb9WQvr2UhzhRKL9L5kEEQ0uk1zjbY2xZxFWQFn/hfWoKvS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZsJ1/Uzznac+SVoFNp62F25l7rn0HfqHwSlzKOHg1A=;
 b=xvIZaFd2XNKfi1W3kN3FHXisVZ1T8m9rKqLwe+X9fxg1zCoZUsarjQnYLzipZ3h3K0kzZpHWzSM0nc/fpbyVbnCxO4eaa3zWzXYy1bSUsJ8pca9Zrrq4Kg8Lum1jaC+ZhIpOkVwlVa/SK6hwt4fFj1h5EYbhj58ea47k6L/f4Dw=
Received: from CH0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:610:75::31)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 05:41:25 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:75:cafe::89) by CH0PR04CA0116.outlook.office365.com
 (2603:10b6:610:75::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 05:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 05:41:25 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:41:23 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2 3/4] drm/amdgpu: refine poison consumption interrupt handler
Date: Thu, 20 Jun 2024 13:40:19 +0800
Message-ID: <20240620054020.434523-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620054020.434523-1-YiPeng.Chai@amd.com>
References: <20240620054020.434523-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4342a2-cdfc-4089-9c6b-08dc90eba00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JphQXDWrtfZDUe6iseQVggGLMKtgHtIF6G8s7k6+6bZuEiqbLBZK1WEfZzxa?=
 =?us-ascii?Q?cQKbl4E7RGneoUtfIZfPuYDyCnVXS1seLH5maxvbRoM99JGmIqZ5olIkvl3o?=
 =?us-ascii?Q?4TDGoZFdM4CK1rK2/oi2mzuRtj2YsGLGuRmC5Lm3fwxYhTkIXueC6TAAEB3e?=
 =?us-ascii?Q?U5zcRxkrr0AOfoGa5Jg7AQKNTZ4iu7XF6C/9A8uU4Ri8+2EqYtD5YTYChBYC?=
 =?us-ascii?Q?4o8pMhLcF6u+/F7YWjI9OCpskp/wWWDphIJ/AruL3SDXs4P5Zc+ppX5s0u3j?=
 =?us-ascii?Q?sMZlxZlr9JC9yi+m8HU8gnejbCQ9TwKWamXW7U74X/avu9xfttGwzbkQgkVx?=
 =?us-ascii?Q?kWasHnuo5eIogXHl7gSMx6UOPvtEiZeoNfdSXWLKgbNlg3dNKZkLOYPHpDg1?=
 =?us-ascii?Q?mshTh3q5AXGgwgYagLXqcwbsabQ3wqf443WQTH4JT3GMs0uBr9Vv07VXy3+S?=
 =?us-ascii?Q?DYg6BnhPbgl0bLztnDgyNcpkjojhoUn4sifIKVnrvUqSzB2d3yK+Zllv7WVS?=
 =?us-ascii?Q?DoUBuKrKnSb51KKta9opnHNggAaoaJLLPk1m2mvFzFn7IeT211GCoomV/qEj?=
 =?us-ascii?Q?jJ0IE1wj2907hNrIW/zFE5nUB4tt4el4Z88INNN6S3MudbHTWW5zNd1vFK6a?=
 =?us-ascii?Q?uMtxeoD8/g8VxzvSxc8oukJwcqgHNQgvgRs/Vjc6QHAeJLjPK0krGP2XUUW4?=
 =?us-ascii?Q?qXk7Gez7SaKL4/EUdAG5WqpWTA9/ja8JT5C9rygbPUUtxeZYzaz1EQH1CsZw?=
 =?us-ascii?Q?qCsXUPjRwNNsYsSwgpIsG3rFr8/mw+JtH3sxN7PbLQjSvkFNwmdguQtJvH1A?=
 =?us-ascii?Q?ZALiWWxVudMaxlSICTz45e3c/W/n11ZkZ2OI7qv/W06H4J/VoRzFP7fKvHhv?=
 =?us-ascii?Q?XGu2TToOSHGh6E+1lk9IyT9NV9XEJbTA/FUvUXw8uIqm2fnbv1KstL/b7fmG?=
 =?us-ascii?Q?kbtFmelfvLATTySS5dkzru87D2Max+Sd2qr1kpF+ix35xJj2Ox9mMdDaTzWM?=
 =?us-ascii?Q?UB0T7p8JnwKXgjRR9L5ERJlqkBurkRT/jHSvcl2LA4Zqx8b0XnR6Bf3rgDsn?=
 =?us-ascii?Q?6ru4Xod6Bns+9e9OP+KQE7Vbzm7brvZpQAX9TtQfS0vJVd5qNoxmQ2/PSIMa?=
 =?us-ascii?Q?Eh3eUymH9Sk2jWjyC9J98YOJ9cp0XiwEkNRwbWn9o5Algjd3uPnO8oWVBpjo?=
 =?us-ascii?Q?L186ukmnsiCdDqZnSJ05xolD0J8Gma1aOf1ikHQl1l2XSC8jbwukEI83L87S?=
 =?us-ascii?Q?6ttFEwfTZLsXXnTpr4AmEqu7biYMtBmVAxufzbta8LvT+EBDVwyCQ6ms0Ek7?=
 =?us-ascii?Q?kAr2olfCcbNLf0fDMUxFsNB/QT+4WQ2CHazUEEUzL+GYQs9TX98kNunB2qEz?=
 =?us-ascii?Q?4KvAK/tvTGwe9nUB0QfEsJk//3lrXRUY+XrcH02gGrEOa1A1iQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:41:25.5816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4342a2-cdfc-4089-9c6b-08dc90eba00b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 56 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 12 +++---
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 308348b4644f..a4030dc12a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2917,23 +2917,41 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
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
 
 	/* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu reset */
-	if (reset && !con->is_rma) {
+	if (reset_flags && !con->is_rma) {
+		if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
+			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		else if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET)
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		else
+			reset = reset_flags;
+
 		flush_delayed_work(&con->page_retirement_dwork);
 
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
+
+		*gpu_reset = reset;
 	}
 
 	return 0;
@@ -2943,11 +2961,9 @@ static int amdgpu_ras_page_retirement_thread(void *param)
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
 
@@ -2958,6 +2974,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		if (kthread_should_stop())
 			break;
 
+		gpu_reset = 0;
 
 		do {
 			poison_creation_count = atomic_read(&con->poison_creation_count);
@@ -2972,16 +2989,17 @@ static int amdgpu_ras_page_retirement_thread(void *param)
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
+				    (gpu_reset != AMDGPU_RAS_GPU_RESET_MODE1_RESET))
+					atomic_sub(msg_count, &con->page_retirement_req_cnt);
+			}
+		}
 
-			amdgpu_ras_poison_consumption_handler(adev, &poison_msg);
 #else
         dev_info(adev->dev, "Start processing page retirement. request:%d\n",
                     atomic_read(&con->page_retirement_req_cnt));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 4a72ff8d8d80..38e7793137ee 100644
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

