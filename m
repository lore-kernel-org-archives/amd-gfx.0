Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8924CC369A9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D1B10EA15;
	Thu, 10 Apr 2025 18:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bjK3IS1i";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0F910EA07
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggvTiky5Nvg7DMUO5DcJ7phls92/kFZQvwPtlS88Iom37bR4+Q89yk3dH2dtUv6j101Nkq5ArrhyRoU2ScMqhg/XKkVLVpnhIgLY1ZJburj1R8Yzs45Wd9445CBxZrMp2STFDl+MHWzrQDX0neLOKsBWxel2HhaBhzmkpobNIy27WAtA/GfsH87AGuhp9QJTZq4hSEN4rTpQfAWSUYK62Eyt4GOm6skQQ3KDxhJDxOlN7TysZ/UEYVe3C165xsWXXHTfnH1n3f1hEllrnjWZLaIoc7HPXa8IkWG1ZoMlP5jDJxR77dvozCdFNSNPBcakih507SUev0j1ck7MMp7sLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es9Ibwh73VFHU1CmJTqrNAVLy5faUIk8BOuIUyG9V3Q=;
 b=uCu4QZgipWObNjxgQPxqn3dvD61oYkXh9AMtzQFJX/fTFLInMyku8SY1S9CpvvsCLu1RI1cB1RHrqORIKcKB7GZdKddK+BSPaFz/t5e808qIMBiR9nsAnlQCmoVLNA3MkV0e03iL4WbnjZPB8+7d0m7ytyFACMgJqk+N0y1/YDrrh1Qb8BHOm0riOBin3FxLp5tK3AV73+uV8Z+4OGPIeJaRfT4cHJriEJbwXFud+g31yAnIl3HbR0bWAF7kLSYolNJRS35c745bGm/bcmpjU8JMD9Nru24q0RZ/hravU72CanQ5ItStV74MwxFbBmqLR5GhmRVes/9Fjp+8dcGeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es9Ibwh73VFHU1CmJTqrNAVLy5faUIk8BOuIUyG9V3Q=;
 b=bjK3IS1ifXg6btcXr1BT2QUtr1BoRQbun4GEO9bN2OjksSBcBgl5ITo+F33WW3qWxkecyzlcpAowzI/flckysg35NRLTI1NGlJSbbPWYChC1EIHewINX5v+JZ0p9lw8ihCDDYqh1vRbhtoLwZAx14gq2bpwUKCSm1+tAhHmzpjQ=
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 18:54:23 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::89) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 18:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/13] drm/amdgpu/userq: enable support for secure queues
Date: Thu, 10 Apr 2025 14:54:02 -0400
Message-ID: <20250410185402.2352109-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb607f8-fd1d-495e-db81-08dd78611bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AEtcrQlwQ7kryaERZkKZddw2YEcrxvFaHo/Fd+W5RRtZVWLtSps0vOIgXJb0?=
 =?us-ascii?Q?d+L79aCl60lgXW0+xUF+mKpVOz62oP0d7klwvpPOxcB8mOiDtyim8K7zECsI?=
 =?us-ascii?Q?tRRhq/m1jXkjzacpVAfLaxTYBm1RGW4rfv4MLUzP70wgemqO52e4518WCqeF?=
 =?us-ascii?Q?iKfTs1MUg8qWB80wHqRA1xGm7/IWBbTxtRtMY4YLTbHuhqLHdgimCheUCrLk?=
 =?us-ascii?Q?jCZ5ZKjpQZl6IzQEhZ5g3wUToZ0kJgUCoJCgKa8B6nVpICUQDSdKyGhgcPtj?=
 =?us-ascii?Q?NZXb0qbltbexGk4EyhseMFv7EP129W95Hc7e7zdV2j2vnnIJXovE4Rm8T2/A?=
 =?us-ascii?Q?B+6AhaaNGBT4ufnp7HbyKOLMJt4ceLyBTpXJqYqakfzP0Hd0mH36FYvL3/35?=
 =?us-ascii?Q?2bNhZAI4O9FwM0GbzbWBZeqJGY3ygvsvHAdMKtISNcsJdhCsWPbpusBGlRbG?=
 =?us-ascii?Q?P6BQfW/CHQUwgFDiWltBbgVk93cczsfk7DSe0tVWubeRZKPOvCy7smsO1Qnj?=
 =?us-ascii?Q?dioKGXfa5NDxwAn8h6hZYJTOXY0pchQGtMPq0lloOMBsY/AbPDIuQ8kdJBsd?=
 =?us-ascii?Q?aS4tYTgPE42DjM1pX+mcQ8Y9ffciMX94USinDeHvo9CvdAGGXu5qhvC9MIXg?=
 =?us-ascii?Q?8J5Az+fGRmkw73oNzUPXUwGBMU5wqjRmdA6rGAq9G0XloWevkYpzEhV7e2/K?=
 =?us-ascii?Q?4O96LuuJNl4hD+tfQHb+JJ58mIV+UpKpwklWOJn4qP+ZjgeOIEuR+bp99g9X?=
 =?us-ascii?Q?EdD98CNLqX/hXotBZqobNKI9B9eC/moPgmDrpm13oeGQhGIG4nBMj3842pUi?=
 =?us-ascii?Q?RYB4E4NPqcRfdGRYAX6IHsvtrxJjIpe0qP6WMp6rXQLNvGT5681EStskwUoj?=
 =?us-ascii?Q?Ak8RdZcSVzEFxyXlNzPbeBevzBYNGJAXEqx4USZhZYo+dnqO6ezHFumv3Xs8?=
 =?us-ascii?Q?Yc+zhnPoZolc21MOEdvZuZfK9tgQ4G18Lv00jYNH9vD4ALBzs+0Rtc0nJmr6?=
 =?us-ascii?Q?mb13F9dUOT5V1/gBbnm9ZxSyIzKYw6aVYlhx3El1NUwzzw43fawBV3+k96m+?=
 =?us-ascii?Q?PUGlHZ7/cS/v1k4z9100wcDHd3VnWStnQgGWD61/Aq2Ds3wqoltUnQhgCWFQ?=
 =?us-ascii?Q?qnekKrhVRB0ULQvGsVe+l2ZtFJZpTelUF/E5SeA0u5J5EdDt0o60t9vH7N4p?=
 =?us-ascii?Q?6YR9Zc2Xaf8WPPYE7WTae+wkNpPfB8s/ZhLnl67IJH4+xUmgnXLtqvbJwX/W?=
 =?us-ascii?Q?McrIbf2ufVLJ3Q3bBwaDsFKJMlYbmFK7DAxOcvCU1Dofau5FqtrqFdfTE6E7?=
 =?us-ascii?Q?kCzJObW/Xcg9nLBX5oJ8WuXNuycBQLnN558haAqgocVz7MfMnVCoTDOAJprB?=
 =?us-ascii?Q?8eLYCtbxysMKZD2IssE7ITM0KZpKE75cZDIiIsAbrg/Lx+SSQCKwcfSioTlB?=
 =?us-ascii?Q?VLNU0/HQFQ3IaF57yHd5FTqumw+hTB2i/2DicT8axWNPa7W8g7eNlT1Op/WL?=
 =?us-ascii?Q?XHXxbF+li3D0VTMm3PrbYPkhf8gxsqpT73NH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:23.0124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb607f8-fd1d-495e-db81-08dd78611bd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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

Enable users to create secure GFX/compute queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index b8b13b6ab4631..cd279f8164158 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -303,6 +303,14 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		return r;
 
+	if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
+	    (args->in.ip_type != AMDGPU_HW_IP_GFX) &&
+	    (args->in.ip_type != AMDGPU_HW_IP_COMPUTE) &&
+	    !amdgpu_is_tmz(adev)) {
+		drm_err(adev_to_drm(adev), "Secure only supported on GFX/Compute queues\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * There could be a situation that we are creating a new queue while
 	 * the other queues under this UQ_mgr are suspended. So if there is any
@@ -401,7 +409,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
-		if (args->in.flags & ~AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK)
+		if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
+				       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
 			return -EINVAL;
 		r = amdgpu_userqueue_create(filp, args);
 		if (r)
-- 
2.49.0

