Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4DAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0463E10EEED;
	Fri, 18 Feb 2022 22:33:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C053910EED4
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8DErutsnlg1AXLVTBfO0XXGyW903shUUo45nuCjESJxC6B0u3n4Dc3Q81uE0qY1EH98e1KxjYQ2XXxK4ulRdvAlRjwLuA1ILDdXkvYbXAeT4QVB+1Lda78o1Sv5B/A6oHTKaK52tj2TFkWm32Xqewdr6ow2ddi3ZaxW6lNko2LWCHcHGGzN2Pf0+7MuzAYqWKklxQlyWWmFIDhcP7PYAc2D0YIQkYCymlTzO+NU0rsQckT+uHGflUGN8lIVB+buy641T4DqlYR0hvw6an0T9mo5sImB3hCqg7JfdT0y5MVMm1vPUObye8X3ycQVjclE/4QUl2R6+m1Z9T/Vbk9jkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNx51uH6AubD3MYJfuauNsBbJekC2TX7YeL+8eM2UfI=;
 b=Xuw6D+5lew5yli2lt9nDjwmZ0sqIj9xHajSMUjT8PI7W28E/3EexqTrld4ZLQ6rKue9W4gNSkquP5YrKyHzdrNGqUrjRIvQpBXaNRa4lUGuIJpxjrt7w185iX3z1s7T2g/Ud9dzoPf4Yz1cPrvFolXNf4fSSfoJkdJntwxZ74x3dqL7N+9myt41BCi7erz3ul7krFkz5vStCPFAbUJN/lw/LfodVptB+08/z1KS9BO8iHyHKkZamIwJ+VvIrgafvr1PJ82z2p0D+yRDWsZEfZaDYF/edk8clO75va9266i5fBANKFfnG25rcXMA+kQH2k95TO2WHRg63EDMnxwNHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNx51uH6AubD3MYJfuauNsBbJekC2TX7YeL+8eM2UfI=;
 b=1CFSqPdsTFWdacSQDZDA2OzXP3FpO3tELyIsAz9Mgw7h1JZxQm7g6UQZ+B0FRmeP8v7KuZD6R9fTbhyDKsvwXJb14Kb9Iiiw1iS5rZ53XAQDcEzhtgAacG2S8cGb8uQeILXOFSZfIFnZgOYCjw5TnuuuZK7CBu8Go2I3x+1HiWM=
Received: from DS7PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:3b8::30)
 by BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 18 Feb
 2022 22:33:42 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::dc) by DS7PR03CA0025.outlook.office365.com
 (2603:10b6:5:3b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 22:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:33:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:33:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: print the selected benchmark test in the log
Date: Fri, 18 Feb 2022 17:33:29 -0500
Message-ID: <20220218223329.26038-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0b607fc-d1dd-4cf5-9f1b-08d9f32eb786
X-MS-TrafficTypeDiagnostic: BYAPR12MB2631:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26316565CDBDB3CBB72601C8F7379@BYAPR12MB2631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbKtfWLqHc/em8YVpVihGLYEyuB6WV4LQGPLc4rpEGUJMLmsLIya7XDQzjrLMsQ/tDXawqPSH7Xd/CfdJyPrpySwdoMbdyaojFTAkgD9SLxEd+VWs9LWuonh2W19/zm0IEbxzhMUE/ZjEt7Fl0V5Ua2ovcrs9DMWUaPt9O2+L1mV/YguCA2F6c4VpViYpgMF9F8AfPEe7McayfJEBk9gDgey+RNoh2pVRrDXq2AtuSenjW+LtLHEe+67wE/nuuujPBCggIU5CnJBiWFJ5JKQKD9+uU3IX5n/xMh+PbAdn/PcDSK0RDExlNW/DrjCPC77XCGz/4WDopc9W7dCrWdn7xZI//XVM2nA9c0b93A9/AguOpL9/QxPVO++mZSvp8bjblci/G5JrV9zrXVGwl4s0yOz82TkdJPXE2Mqg2JCqqkXkxDFj8zjgVLLcFDPyLTk5L7DOJlj12ud34e3fspTZQfBSysirjkKmlDADIk2A0zYn6gBoWSnpm7/XnVbT7VUlF136WhDLINOwNfT1T5W1lXaHCYwjyk2HLT/mRfe0dbf0m4JotWfHaCD5wWHZnY182cIRhiBXDAXvt5Odk17uUWfesd1XV5aOeHC/5UcMEY+wMiMRi0q5ZRnKlt2xoNmBrSpfnMyVAvardff0yeZCKhe8+71GPavfe79coagRBvskQjBEcCtiFqDjyqyKqqCXYtNfsXDyBVbIvdkn7gCEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16526019)(336012)(426003)(356005)(4326008)(2616005)(26005)(8936002)(82310400004)(7696005)(8676002)(81166007)(316002)(70586007)(186003)(70206006)(6916009)(508600001)(5660300002)(83380400001)(86362001)(40460700003)(47076005)(36860700001)(1076003)(2906002)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:33:42.1640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b607fc-d1dd-4cf5-9f1b-08d9f32eb786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So you can tell which benchmark was run.

v2: print the test description as well

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 7709f48e25a1..930ba85ed15e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -185,6 +185,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 
 	switch (test_number) {
 	case 1:
+		dev_info(adev->dev,
+			 "benchmark test: %d (simple test, VRAM to GTT and GTT to VRAM)\n",
+			 test_number);
 		/* simple test, VRAM to GTT and GTT to VRAM */
 		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_GTT,
 					  AMDGPU_GEM_DOMAIN_VRAM);
@@ -196,6 +199,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 			return r;
 		break;
 	case 2:
+		dev_info(adev->dev,
+			 "benchmark test: %d (simple test, VRAM to VRAM)\n",
+			 test_number);
 		/* simple test, VRAM to VRAM */
 		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
 				      AMDGPU_GEM_DOMAIN_VRAM);
@@ -203,6 +209,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 			return r;
 		break;
 	case 3:
+		dev_info(adev->dev,
+			 "benchmark test: %d (GTT to VRAM, buffer size sweep, powers of 2)\n",
+			 test_number);
 		/* GTT to VRAM, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
@@ -213,6 +222,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 4:
+		dev_info(adev->dev,
+			 "benchmark test: %d (VRAM to GTT, buffer size sweep, powers of 2)\n",
+			 test_number);
 		/* VRAM to GTT, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
@@ -223,6 +235,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 5:
+		dev_info(adev->dev,
+			 "benchmark test: %d (VRAM to VRAM, buffer size sweep, powers of 2)\n",
+			 test_number);
 		/* VRAM to VRAM, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
@@ -233,6 +248,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 6:
+		dev_info(adev->dev,
+			 "benchmark test: %d (GTT to VRAM, buffer size sweep, common modes)\n",
+			 test_number);
 		/* GTT to VRAM, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
@@ -243,6 +261,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 7:
+		dev_info(adev->dev,
+			 "benchmark test: %d (VRAM to GTT, buffer size sweep, common modes)\n",
+			 test_number);
 		/* VRAM to GTT, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
@@ -253,6 +274,9 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 8:
+		dev_info(adev->dev,
+			 "benchmark test: %d (VRAM to VRAM, buffer size sweep, common modes)\n",
+			 test_number);
 		/* VRAM to VRAM, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
@@ -264,7 +288,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		break;
 
 	default:
-		dev_info(adev->dev, "Unknown benchmark\n");
+		dev_info(adev->dev, "Unknown benchmark %d\n", test_number);
 		r = -EINVAL;
 		break;
 	}
-- 
2.35.1

