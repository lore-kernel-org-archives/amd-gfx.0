Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A6606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ViWzYGsF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C1E10E90B;
	Mon, 26 Oct 2026 03:21:34 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E4D210E813
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 03:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkMorOg6VUX3913LGurRwUaM4SqUuG/cOLqRAFGM5Eoog01aOZZWtQTTMIcw9BMa6NlVWVZVTHsKxVHlWgy7HbyInod+6WkNYcGZQQPO1K6HQLu94g48gHjg4eb4au7lWnX+ZxoLWIxljyn4QeO8+74htvLAojlGxVGckVQ498cAOEE0rzaod3JqV6sZF+u3jzTVEB+r2z3/dRhlvkQ22CrsgiPqofpOEi0Ae7q54PVS6G2hT/xiUAEgW8sUZwz5Vb9dUPuA1Cr1/o72a4m9vWq0le1QHq3ANof4hxnZJ+IsUYGqb7YvcV/1BMhDfz5OuOdZn286W7WiWSjmWTMauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmMT4gQ1eYs92lHHLT6NhRvvxeyt1LzBm+w/0slvNk4=;
 b=lUUPto1C/niAzCWXIO8WYXvuo6yg04OBFkvc7sM18jdOMJEi9mQe0MFWEpBZWI+1yjbyV64aunSPIERWfHolE25NNL7AuAbC2LPMi2MlRIoqZcu0GUTrlDnvNz0GdR0MmDSn9Xk4xCvuzNRL7ZR2tJREkoCZFkMWMQKiprJymm5OARsg/bsNpU/QlScSKeL4K0NiPNTJRXTa1iyVt92EuGvipbCohz2jNvitdCESSQhjOTqjwQbRfKWTNtd1lw0/JCog5/USgdKt/xYmwDPVGi1NXML3G0B04oc+/PJEW4LcDwTQdT9gvmFt94+OfJePJFwFZ0HiXH3bAXtRVE2VKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmMT4gQ1eYs92lHHLT6NhRvvxeyt1LzBm+w/0slvNk4=;
 b=ViWzYGsFSGA07U6oMAAfEtns3AerrkeSKeH3Yv62drLXvAdbOnvxV2z6tgNIjZbBGLWPFngG6iyDp4Z1KtpNMoUDXxnX+9l2QOhnCw2bYjaaNXNwJMdBgkea6HPh0QFbU5hyH9yxTrWBybsU4tMzrOXiD75+It+11swRVNdb9wc=
Received: from CH0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:610:74::8)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 03:21:22 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::65) by CH0PR04CA0063.outlook.office365.com
 (2603:10b6:610:74::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 03:21:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 03:21:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:21:19 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 25 Oct 2026 22:21:13 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <igocaike@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 5/7] drm/amdgpu/gfx10: flush the scratch register write in
 the ring test
Date: Mon, 26 Oct 2026 11:20:21 +0800
Message-ID: <20261026032042.2266892-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
References: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 1725c5de-c3b6-4ea4-67a6-08df331034a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|5023799004|11063799006|261021121427099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: H1uMh8Olq74NO1BKkAzvVOzFW7bvHmXyASveSUGNgLSxfmIDHS2UkiIuedP0uZcXyprmNvSds12SkvTw8rFXtooeimInslJ2pWYdt0jFVPtXc41JQk5ZWO7zwfZZ+NNz05tk7J5l5lCsVHm4rFMPn0NHzd7n0kvsV1leKHCcnMN6BOpZhAD56UG7VHhZssyVfrOLvKICYgmdP8LOtdeRuAWBM3VGv/NoGhchrPM6TrgJYZmwXmqgQN9Bg6/RY0mdVWenXQJbWQgToLZk5LbauDtbOLu+e+YueY03iv4V4kzq3LgEtCtEzFKwK/6pCw+z9SfDIOeqno8U+eGAUugMNlE7WGnGBN9mAs8sCMumfqORFPJ8Vh92AgrvaNuI80VOuXCJwASV9P+eRnr1ZmfQj0wLuxYbUgqRN1ByS33L/ED90tIpc5fTsp5KGtnCvgQ2fnQAn7D39cJUrfVfg+S/OXLgb7LyY9ChShvmj/pdAJQ0HeRfR/kmXXYKpviGc3kYi9Jpb0w9ap9y3nZTdA9cnwfmtINYZCibHHVK+BY2Qh91BrRmah+d9AgIDWFEnlDjuxXTYDOpgWVWn9iaEolgC2l4/x6n8OxzX2fQNxwZHbkAZ4e5s21jkqgPTAU69E8BdfBrBgdWzOMJAx7I/zK7ifzuahryVHaV+NAG9gCBRCWJqD8ip1MhmwAmTp7Hfqukah0XTXfXB4r5sWK9f1Aw8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pJVC2bKwbLLIpDmcyYijHAZ2ZLuAFJqZUQT9oJe2WPxaOV+udNzRdbwfeqQouTZfzJST2HqtYt2aAHDSGLOLcTKbSJZf6iOGFOu1tECqhoisquVSENXuN7EfEC9GHcqjlq7jUawLObDMG5F/8bO0W0od4ynJXnnvcwAnUxsGAQKDYTWxWrJH19NSEMP5Eglw0Jgr7BL9/Juonz42CqnWl9o4telTJAjEwhezoZsodkw0mDLoME6oKX3N8ew4GGMEBmKLY0ufRTodCyqeqiykN/hfPp0NyuR6iZhjYTXbcsVNL8y3WloOX6dJC5GNvOZpWAOT0XXLCLWucEX3JQ3KmUocE99Xuv8K6DRv5ovIBsZixoQvncTR7rULuQ2oZD40hzD5syzEv83LqGIHsMHCjv9WzkV9HikX/+Be7vhbwSDXQXrq2HhF4XCgVQulYoNl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:21:20.5207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1725c5de-c3b6-4ea4-67a6-08df331034a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, then has
the CP write 0xDEADBEEF to it and polls for the new value.

Nothing orders the posted MMIO write against the CP's write, so it can
land after it. The test then reads 0xCAFEDEAD forever and fails,
although the CP executed the packet. A false ring test failure in a
queue or pipe reset escalates the recovery to a full GPU reset.

Read the scratch register back before submitting the packet.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b6f61f4a08e5..90a23aac7487 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4039,6 +4039,8 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	int r;
 
 	WREG32(scratch, 0xCAFEDEAD);
+	/* Flush the posted write before the CP writes the test value. */
+	RREG32(scratch);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r) {
 		drm_err(adev_to_drm(adev), "cp failed to lock ring %d (%d).\n",
-- 
2.50.1

