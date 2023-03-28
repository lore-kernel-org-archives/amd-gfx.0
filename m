Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86623C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC45110E0E2;
	Tue, 28 Mar 2023 15:06:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31CD510E0E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYe9vLMvmXJ09BPWpRUJBJ8ZCFbrC38d0IT7OM97cjoDDQBr3X+V0e/kGvgLOZDhk9xReY1NZk6wxZafeTEEGdmr9dJASsS4yq7sgwVjd8/fTEFfUTUKZsMFlyvr7JmDuK+u4ANnuvZTZe+cuRrA+iZIplqQc0lIZeZgXb8BRhDDeruiJ8hLo+ZbgRfyOoi0y3vG8A0Kf2UJhyH4KxUS6Gg6G6EYYKJq7yWFdqgpp+q4SH4ANxOjG5UrYgtYkV/VwbPgjNukbFuph5MbGNWlnFemAGdHJwfPo4jJi1S+ziL156PrG5I2o964UejV/ZlsuK1DSYqBebgqHweHpFeFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7XtW1irHklxrKA0KkxDMuA5CM5Qh2OKvGSj2oOXykw=;
 b=OfBfaz1aElgkOgvTVC0xe6DDV4Z6nGGUqQS8lZA0VjQlWc9UKMde4cOKc6ZvU4M9P5He/h1LZ74yUljo1/IFwyJlJ3MLgYwQTz8DrmjvfuAoxdNrakhV+nOE8jnSV1kuIbFdOG1C8JehqbpcDxqiLSY/Bb5VByJP794pX+Afe7Chd+XFA8eMQBOwZ6dYiF0IIy4O9rF6/SHyoykeO1jUJ2lfkNCR3RDbA+Knx2RTHhlsWKM3OLCPxhb1mMzK+aU8HivSBpDgszUoyc+3XvI1/DbJGXHWNTQhHu8nksCz0VeGUQi3R1pU3ZY/29lc6F6BJ2QrWZZmVJgoZNXTfVMZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7XtW1irHklxrKA0KkxDMuA5CM5Qh2OKvGSj2oOXykw=;
 b=KCGQrA3SE9v+tE9nEVFiAgqyvY4MWsB5STFOrj/lDM68O5DV9bT8g8GmYD15Incw0zpROzb2Yh9MTRR8k9SArjHQqt+++tAMsnC2/Jx97JwCwXg1gFO7ehbAjDHb9570ZPW7Y92p+NuAGa8c1ANmic4S8vryr3SC57GTNICXgug=
Received: from CY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:930:1e::27)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:06:06 +0000
Received: from CY4PEPF0000C983.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::c0) by CY5PR04CA0007.outlook.office365.com
 (2603:10b6:930:1e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C983.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:06:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:06:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu/jpeg: enable jpeg doorbell for jpeg4.0.3
Date: Tue, 28 Mar 2023 11:05:49 -0400
Message-ID: <20230328150550.1933519-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328150550.1933519-1-alexander.deucher@amd.com>
References: <20230328150550.1933519-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6542ac-27d0-4853-5d9d-08db2f9df4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUKdzFrf1oMwwwHAUIuHVJwWnLOwsyJ/8NWszR/PX5yTia/8PXFe8eXxNVj0J6zBs/PhUinSnvTQsbxNynAywxXGzsmM6XTtZe5gB2WucOYdzGX8zb6oZ89OEnyWzpSgBZN7l9nYdaaoX1MNjaKb7PgO4tuqGuN386rlfcA3vnX8h48CdzHSf0tvhWoU2QhMFNE1xrWANzaaFxHY853BFJNUcn0CPqGglc5FkKOa/6BQ/LoqhsALUlIhIJBvqzMcWB2mYLF4LuuevaBj0bOGgbZZqEYOwygYCmPD0ADz8vDym3EawuE83JVmyqXILFmItbBPrWgg/2Z0TrOmD4fXAtYwusbrrBrtw9DzyJ6DrmrpK4qxF320ZtzqNeDfy9NClKxnPiDtYawgONz3KVPuu7GmbIknyGPvd4/5/NpWYbDdtI14rbmAD4t93+caNVp6wL1C+gUPYv4xH8p+YeWHrMOr7ZgpeOsUfyZ9HL0hCmyGnXD/Mj1219+JE3cuI6Am5agD2t0kwugWouXcgDZsEdncPnKxoffWWu2l0+1n76aemEwO1cdNcmPfaUJa3E1HHh9WLjgBrPL/nsJiJI4dCOJi+IvjEaplzz+unAM5YWgo8oyx/RKPXkcNReAV9SUXRJ3Sufm9059tWVXYv4ZlswCNPZQxowMhILWqyCGf1+PIe7Sd47lXogs4d9zXnmHgeyZOiXNLkHfxbFvIdmYy9iSE6V9CZ+aOQ4JrFL5tebU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(316002)(54906003)(6916009)(4326008)(8676002)(41300700001)(16526019)(186003)(70586007)(70206006)(2616005)(1076003)(26005)(478600001)(6666004)(5660300002)(83380400001)(336012)(426003)(8936002)(47076005)(2906002)(40460700003)(36756003)(81166007)(36860700001)(82310400005)(86362001)(82740400003)(356005)(7696005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:06:06.3730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6542ac-27d0-4853-5d9d-08db2f9df4b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable jpeg doorbell for jpeg4.0.3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0d3509409d3a..8914f3c6c80f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -100,8 +100,9 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst->ring_dec[i];
-		ring->use_doorbell = false;
+		ring->use_doorbell = true;
 		ring->vm_hub = AMDGPU_MMHUB0(0);
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + (i?8:1) + i;
 		sprintf(ring->name, "jpeg_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 					AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -148,11 +149,19 @@ static int jpeg_v4_0_3_sw_fini(void *handle)
 static int jpeg_v4_0_3_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int i, r;
 
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
+
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst->ring_dec[i];
+		if (ring->use_doorbell)
+			WREG32_SOC15_OFFSET(VCN, 0, regVCN_JPEG_DB_CTRL,
+				(ring->pipe?(ring->pipe - 0x15):0),
+				ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+				VCN_JPEG_DB_CTRL__EN_MASK);
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-- 
2.39.2

