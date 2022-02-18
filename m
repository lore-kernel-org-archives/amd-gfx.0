Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB8DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CCC10EE0A;
	Fri, 18 Feb 2022 22:26:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB55310EDDA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+Pba0riuDXTB12UbKTHeSSepi6UBfvfEDugNFPExJ60hH78F/0MohaS3R/QbPD0f2lBYWn2oh3dTpfI7oslQCBk4+Jv4WbTyW52P7mSYCjVbp0X92p3TsuJTY735jo6dx/w6OiPDjDS6zN+0rMpM71mm9L3p4aKuH4qMUaQpOSRksLAU2HK1XUILewW5J4Huitb4oDp1T77L4gcn9n/ZLj2ZJQuNHP8q9jDXQCBlRu995wNEXGy8AjhVCkK0Sbv1NEsI3nwye9obhqAOhI0taQ5mv1f6h0nUOx3vspEgM/Q/H9QKOSyKNp60uF0HyIySretwPJ7CmfqcPnE+0n5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/PDU9/K4WSKeQSVunTdopE7bPpUVa9LWpD8NxXZic4=;
 b=jcerh07NlIeeByF4UE1ZiyWmQ8mgpMAfGNbRr+akalQyWXHjEYhEjgJTVh4OicS5h+W3kC7K7RIw6RxP85HP0lcSxDIwq5BEVXd2jmpHxl4YsIahkCcK78MIOpVkD9JRgflOfJmaLrYvUsUHoJmsoO5RSeEfGrTWu8NfW5aJsm1nKqzUAG4ZoPfuOK95AgMTCdHwjla+hJRbo5eckpO1Acyx72yNVS8I4qeN/yc1UbKY0YQlMdxgPBkZ1oiyDZRyXDcYchcfZtTUDphOnGWo3h9LuZCW5ykP0vb9cC+TL8GkWqd1jG7FWl5twEAi9BapEpTRfMqHc+fH71p1YmFY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/PDU9/K4WSKeQSVunTdopE7bPpUVa9LWpD8NxXZic4=;
 b=faLLOIt9wWfdZxdIDNusyWjIw2mQT8fg9x5JjMvZxOUFwoDaSPz9Mkb3OmxoLJswXTEZpTc556jyNbt+/vOUFF5fgBk3S0oOjXtneiINREIi/dLXTBQ7tMGNxNccr0MCzFc/aZGThJVpXZyqzO2ioNzXP1P+EGYK4heQlQ6NzUo=
Received: from MWHPR20CA0020.namprd20.prod.outlook.com (2603:10b6:300:13d::30)
 by SN6PR12MB4718.namprd12.prod.outlook.com (2603:10b6:805:ee::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 18 Feb
 2022 22:26:17 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::ed) by MWHPR20CA0020.outlook.office365.com
 (2603:10b6:300:13d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Fri, 18 Feb 2022 22:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:26:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:26:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: print the selected benchmark test in the log
Date: Fri, 18 Feb 2022 17:25:59 -0500
Message-ID: <20220218222603.25470-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218222603.25470-1-alexander.deucher@amd.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 968ed7ba-35b4-4f0c-e735-08d9f32dae7e
X-MS-TrafficTypeDiagnostic: SN6PR12MB4718:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4718A06FAC6FD7348E32A5BEF7379@SN6PR12MB4718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDl64yR/FLZrr0BRv6mpcwhPeMJJKEw61aAfFT8biuHqeu+wYNWJDuZ9v2SYJiN7r6RVcvSfPgIQIHVstlU1QuyuTkUimGhahfw9LoTetzucTho47CYUhotFEkn23xrpMZAv7VvQQHHdjwu4Mg4lrTSfBBlL7x0kCGDIblUkDl3CbbSkgrDe/z7opeXuY6oJTlHtzMLe9b8L+ixfsT6Zn5NmvUwuRZG4jqJylslnJTg2vuhuMYyX4DfQhniX3JPle0vDfsxb9H0e7LzhUmU9RX6TIURKP31BUSmy/dFUYLs+pW62ePSaH8f3WnuxDAgDMu3RHmjCZuJmEzHqhIRdpZZaS+ER/dM976OqgJA4sSgCCihrM8AST+rpttn5ZRGP4lwr4JfOwvEbzTvI93DzmIuRRrwXn/1utgZ2PmF+vVYp2Qm/elnvUUZYdA76OLrILSCzss9QjzMgGEjMqhasGekpg6U3JFHJfhaayMR3cUWGftWw/MorpSRJfjXwbrdUGLzMnxDlm30VNrqEUmLLu4NMOqWok5AI91Pqn4fJ1Gk/Fds8ItYrDDTal4/mvPHB9F22gylnnqczEng/781JtA7n383pBEuY0l5rHui4gM7o+7Dq2WTWZix+q6YAEoU55C+XpO5vyhbbU14yaLcg2LdiAUm4+Ux7RD3lmuUxg6jYO6yP8hT5RwAvix+zCr5bqY2/sqMVQs843EMRQ9yHmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(47076005)(82310400004)(36756003)(336012)(36860700001)(4326008)(40460700003)(426003)(70206006)(6666004)(86362001)(508600001)(2616005)(1076003)(5660300002)(70586007)(16526019)(6916009)(186003)(81166007)(26005)(356005)(7696005)(8936002)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:26:17.4547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ed7ba-35b4-4f0c-e735-08d9f32dae7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4718
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 7709f48e25a1..62422c395789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -185,6 +185,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 
 	switch (test_number) {
 	case 1:
+		dev_info(adev->dev, "benchmark test: %d\n", test_number);
 		/* simple test, VRAM to GTT and GTT to VRAM */
 		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_GTT,
 					  AMDGPU_GEM_DOMAIN_VRAM);
@@ -196,6 +197,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 			return r;
 		break;
 	case 2:
+		dev_info(adev->dev, "benchmark test: %d\n", test_number);
 		/* simple test, VRAM to VRAM */
 		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
 				      AMDGPU_GEM_DOMAIN_VRAM);
@@ -203,6 +205,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 			return r;
 		break;
 	case 3:
+		dev_info(adev->dev, "benchmark test: %d\n", test_number);
 		/* GTT to VRAM, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
@@ -213,6 +216,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 4:
+		dev_info(adev->dev, "benchmark test: %d\n", test_number);
 		/* VRAM to GTT, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
@@ -223,6 +227,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 5:
+		dev_info(adev->dev, "benchmark test: %d\n", test_number);
 		/* VRAM to VRAM, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
@@ -233,6 +238,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 6:
+		dev_info(adev->dev, "benchmark test: %d\n", test_number);
 		/* GTT to VRAM, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
@@ -243,6 +249,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 7:
+		dev_info(adev->dev, "benchmark test: %d\n", test_number);
 		/* VRAM to GTT, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
@@ -253,6 +260,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 8:
+		dev_info(adev->dev, "benchmark test: %d\n", test_number);
 		/* VRAM to VRAM, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
-- 
2.35.1

