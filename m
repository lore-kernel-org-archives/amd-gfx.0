Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C216DC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 10:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7227110E67E;
	Thu, 21 Dec 2023 10:29:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D717C10E659
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 10:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T17Iv8CfBk/s9dqqjqwVw7DzG3OBBO8Dm5IB0AqUbUUcRMZucvC1QhCpEn2zthvDCgtdzdotqJY+YtZ752kOYCJHK5+j/gRYLMFJXYKP/+ZqeexCGfWV75Z64M/XeFhW2ALrjAaA/2l1hcFU9xfX0SHAVzLyUF0l3mkUJLYGM3BetpSaoWCMyuz7kj5wqrhuwuyCZwc/8hnujh/fNDtu6sMLc4AbIhrIan3/X9rHIOtwHIff8I9wpCVc7YAmbNJM9k0VmxczJ9l2UBFTQ6HtcccujxO78hOGcyH99Y1osY+3mOJSJhKXgknvAOOqG0O+mTf2MDd/z+SEEGP26SoJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/apktbSIW28O/nW5LU9zANCjfxfbff84sKywY6Pzyjk=;
 b=KXWjzZb0sDYsx5D7GcnvwvPRfZLipV3uQPCFLVrIphTNxeo3aqF5fWCfKyDFJap9ZewTZQWCk/stXOCAtuOGlLBTMNym8IeEJ6H7Z+qIwafvPL9zqIKYxdsy9z7iSKxaHCGWuNLgu95fVbo5XmirewXnHgzQt87mG4eCQgX/0v7uGM7v63pHxDXMlVDm9bAUrx2NMDsgPmgtJ8ABI/osNRxzpluqOghGVznWzCTUfeEuVOMl+FOTgywOf8kIs3OsMJWRYZdK8+eHnEh9igsrA+e9IQucDyAsEfgqkOaYj8J9ywF6cPsdAKqCcbJE0Cf1eAKZn8cd0oX2oZvElnf8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/apktbSIW28O/nW5LU9zANCjfxfbff84sKywY6Pzyjk=;
 b=fRAxG6v4olHIHYgUKTFr68g0pkLNsg6TWJEQJLYnljK7fFOB0g8q0kJL1Otnp36KgLNPEidfVe3KUbWEtCqFBUxQd2fNrDtzAJxCiWLWH8Lb9HO3wX3fKH7ta6ebgWAMmxevhoqL4C70ZrVoz+Igf9ttMeSYYMMxVTAnYzLAq2k=
Received: from MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 10:29:52 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::a9) by MN2PR08CA0017.outlook.office365.com
 (2603:10b6:208:239::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 10:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 10:29:51 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 04:29:50 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET v2
Date: Thu, 21 Dec 2023 18:29:17 +0800
Message-ID: <20231221102917.1900120-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 10442648-0551-48a1-4303-08dc020fc427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfM6o0DoFV8w+jVqarRgQFCtifDPDngre1gBgJyk5ZLv8vm82lXnB8iNFMBA7j0ZDL9k1utqYJtXetPnQ9cRxqTnT6c0DEhpmg3K3IgwIVcEGyPf7fHZyRk8p0C8/kTIryYF8RGks0FHFyy2/U2qhl9Rog5+J8JtksUYnJawKor0Xk/dyLlKK93kwZDzV7LKx+e1AY2bVDR9+VPoIr1SIHTKy4t+IOzyRcEfV6c5Q/D0VVb1zjmyJsZZWlpOjJRCT3iNRH57yj0wu1YqsKnoc+3mOyCZZZafO82Hy46PUzGKsL5UrqTTAUPxzoljnxXyYRaQbRdQmOAUINmafw1SwT2k5VB+/OV6W2b6bvXm+c8pSYcPriIjDPgcPHPJW0+8Gt+ORzwYoK1gcducv1ZVqrJNvzcGY2YKxhuRtAx0f4L1E+nXEM4SP/WDY2VODQ5ZfV5+FWa/Yj4Tj/xu1pnha1lSJbsWvVjD/ep2exRkv1s2qAcGMENyen+5iOgnku6Y7hVMlRyjE7qk/izkEAFRLzrmI8IAAEBKyf5Dljs8h2W54xAXc7AYLMTfokLzC6uhiDH4iwAmBso9/8+Xz7vBGxrB2mHHSkzsjhKqlSGe1b2HYFKJL2dbgBIAQ5ztDFOR3d1LIR5PFVRScuFLZ6bibBdJa659gVqbQr9rCgfLuOTpusMQ/3vQmA9IDofyV3AEvMN14JIIuv0K+PXFPctf2cIGxHfM85VEpfuLyZQXPfBfI7zAuXzOw0BvnAhg5oaq2mMKMLp8wtkt2YrvAnvdoFvrn+x1YLNAb9gJgveFLx0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(86362001)(40480700001)(82740400003)(40460700003)(81166007)(356005)(36756003)(36860700001)(47076005)(83380400001)(1076003)(2616005)(426003)(336012)(26005)(16526019)(7696005)(110136005)(478600001)(6636002)(8676002)(316002)(6666004)(70586007)(70206006)(8936002)(2906002)(5660300002)(4326008)(41300700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 10:29:51.8127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10442648-0551-48a1-4303-08dc020fc427
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's required to take the gfx mutex before access to CP_VMID_RESET,
for there is a race condition with CP firmware to write the register.

v2: add extra code to ensure the mutex releasing is successful.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 48 +++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index bdcf96df69e6..44f5b3135931 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4474,11 +4474,43 @@ static int gfx_v11_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
+static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+					     int req)
+{
+	u32 i, tmp, val;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* Request with MeId=2, PipeId=0 */
+		tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, req);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4);
+		WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+
+		val = RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX);
+		if (req) {
+			if (val == tmp)
+				break;
+		} else {
+			tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX,
+					    REQUEST, 1);
+
+			/* unlocked or locked by firmware */
+			if (val != tmp)
+				break;
+		}
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int gfx_v11_0_soft_reset(void *handle)
 {
 	u32 grbm_soft_reset = 0;
 	u32 tmp;
-	int i, j, k;
+	int r, i, j, k;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
@@ -4518,6 +4550,13 @@ static int gfx_v11_0_soft_reset(void *handle)
 		}
 	}
 
+	/* Try to acquire the gfx mutex before access to CP_VMID_RESET */
+	r = gfx_v11_0_request_gfx_index_mutex(adev, 1);
+	if (r) {
+		printk("Failed to acquire the gfx mutex during soft reset\n");
+		return r;
+	}
+
 	WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0xfffffffe);
 
 	// Read CP_VMID_RESET register three times.
@@ -4526,6 +4565,13 @@ static int gfx_v11_0_soft_reset(void *handle)
 	RREG32_SOC15(GC, 0, regCP_VMID_RESET);
 	RREG32_SOC15(GC, 0, regCP_VMID_RESET);
 
+	/* release the gfx mutex */
+	r = gfx_v11_0_request_gfx_index_mutex(adev, 0);
+	if (r) {
+		printk("Failed to release the gfx mutex during soft reset\n");
+		return r;
+	}
+
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (!RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) &&
 		    !RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE))
-- 
2.41.0

