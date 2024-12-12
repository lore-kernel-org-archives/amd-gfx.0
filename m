Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B87E7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 21:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B93910E233;
	Thu, 12 Dec 2024 21:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHMXLlHd";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2B010E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 21:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls9BAlSuJWgEfljJ/7Pa8ZX/SnteHPfwug9doBSTVasTGB5FJur97isuaCsfkhUvcNVMMx20pYMrSpOdEjqnrbbNpyF84g33kQqx20hUN7828KR7mIeGxCFFvImMpxnYN7rZoE26gokSdh3iRkcUEcDi8DoOIcA9Mu+ovcp+X9xuFDAk0gBcn0mvxGe2B3SmC4RS0QsphvFShj4s5huGj2dbwoRLFVDyYzPy4jA8bqUNaOQC3T1xYT1HEF4DJmDHVhUhAEWQjEvHlpOh2f30B/8UzbHAANT0f/fCAZQ56f4gxiPa1TVEKZBLrYu2WVyVW6ly18TpEWrXfhP9WhLlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eChDwTj/XTU+H0JMlp45TSg5aWHJDI7qPgYwTjW1+08=;
 b=i/6DmelrJniaoUt6EwckOtJ0InI8PVyPLwI0fPGaYjvsyRcfTsbnamcWjnjm/TY12EyNccJWIUDjkMFCoHBQ1PLpIQKPZLzZPzCpspaNTsMj7BeIrUBbWhfH2VD12LsX1PYN6XG2F5Xz7e15KhwURZ11cKoQrrIuURFFyXWojPJMY8SqfA0X8E2E1YE74P3VZnCvIpUUiq5AVUKY0bTAt+/Pb+X5xQXDunXeqI2FNVIlG7pEUiQ1H4y8UJh9FO1rvgr0WEzboOe18s+3ZcqJsa2tKaTk7Ld+xbQe7/Na0ck3cEwJHg/KJ5+1B5iZOQiSUkNGf/Hp8P1Pp6znLYCxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eChDwTj/XTU+H0JMlp45TSg5aWHJDI7qPgYwTjW1+08=;
 b=UHMXLlHdsQo+YT+SWmDx63qcP4mUGR1XMXp/TmuKdohQ/Lo+6wRxFekMQSDNM2tjyFjqJKwxIN4iXPbgvIkVbOgLO/L1IQ3aha3dm+fJxVfERP+cJIxWaKPNsmIJA/Y39gJ1X3zSoQP/01+dUs/J+Q7hMBWY+kSt3pzU6K1Bfbw=
Received: from MN0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:52c::17)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 21:54:10 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::2f) by MN0PR05CA0011.outlook.office365.com
 (2603:10b6:208:52c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 21:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:54:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 15:54:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/nbio7.0: fix IP version check
Date: Thu, 12 Dec 2024 16:53:52 -0500
Message-ID: <20241212215352.770069-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212215352.770069-1-alexander.deucher@amd.com>
References: <20241212215352.770069-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 901dfbb8-ccfb-4985-67cd-08dd1af7829b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?imjSsQ1oIe+VLxE0W6PFQL5EeiAbCSHKd5ahMnObzIA/XVp72oy89ciG6aDW?=
 =?us-ascii?Q?6kyHQlR3Dl3RFpqz/xofaoEsi0Oc0/1Ua6S5W55es0Gw9bfiXvNK01YUDztq?=
 =?us-ascii?Q?FUlTTY75SKkxT8nAhPrB9wKpNmALbBuzCh3ZSMSOhfcICCUhIBp/My/27IFj?=
 =?us-ascii?Q?ovaSzsO1L8aBH5Ob/2R0GCrhgdtGbNrazllHDRyH3+EWU7CyRjzJxrab0blG?=
 =?us-ascii?Q?b+gB6y37F99CSAndpYq1YAVecI1/gaXM7yJI3ta4CtWLxNIMaebkNZDe63gx?=
 =?us-ascii?Q?UWcQRXuS0cS0WhfMSbQfVTEcHa51WlA58JWR9Rc74PQuEKt4x0G8CGB9DD2I?=
 =?us-ascii?Q?ULz1X+kH4ZvsoNx3YyOfUtPBG2xY5palLZsv+hRU0wt4yA1LuEsSOZZDOjdX?=
 =?us-ascii?Q?fqEOimAUqkzLxBD9kmihokY+vLFwhue2d+085G5Oi5O7DAGDE5xHKPk6Ryz8?=
 =?us-ascii?Q?XZLUQ5NSRXAZcYauo89wtesmeTf+zG56XFrN3FDTwMSfA0JrDxHVpaHp4AOk?=
 =?us-ascii?Q?Z5suAxQ5c2we8qBTOf7RLEttJAiYrk6Zq/zLOgjY7qXlEbggMrAHV9h0Nwz7?=
 =?us-ascii?Q?EK2Tez30tZQ2AdS9aIjrBf/L5i1gItAA4u1QFNJQfhrO7Vgd3s/YlXAhXlsU?=
 =?us-ascii?Q?fPXOPSXEUvdNa6qbCRntGbk6FObhneUvSpHdACvMR+qrOT9LITYbmW+W1qoG?=
 =?us-ascii?Q?ycDzPSBnZOAjxlQytck9OT8JqdLjp0ZLCx0/kp4GgkStI2n0pTIAvhG+mggA?=
 =?us-ascii?Q?gCZrGe8tgAe3FFu2Q/oYSsz2uSVKAH7asS7J5JRESH/4iveJTDC2Yp83LyES?=
 =?us-ascii?Q?LYp5hkkkrW4S/kd4nKKVTHKGYiRWZ6BZNtn9U2yJzKc4OeiuAVhG7UvT1WE4?=
 =?us-ascii?Q?afJLoc9zeUBC3qGjBIsfkj5eEsNaMWyobQS+lzzL72v8KmYhAu3hsDwJtoF2?=
 =?us-ascii?Q?Vf1w797tCphCGtHmFrOqWZpWWb9lRmQl40+PKUY4vIiMhmazRtCojwrX3ofe?=
 =?us-ascii?Q?1lo8EhYysKwtHggsVAWvyC0Ynwdl4NFK2ZAufgfOJKKs4YIy11hwyWmmXXQD?=
 =?us-ascii?Q?60MINpXhNRchyQOgI1oBiZW9OLtO3Z8AVQKerlcUbPdnhLNJxd/3Xn4rYT5x?=
 =?us-ascii?Q?slu0v19i/Odf1XWEdchgnTUPj0Zt5JYc/HZfowo0z39AxrP75qiWJXRHkHBj?=
 =?us-ascii?Q?+gP2kzJkr0QkHiURuAldmZbxFhjVUJ/aDijMYMyF4jxFl0tJt6aZpA91Bwqi?=
 =?us-ascii?Q?L36AnxFSFAYrsOzA8KeFOWL2BGmco63hruMsTtojY4u/EJiYhsqdpZ2Q/C9P?=
 =?us-ascii?Q?gZmD4vjLT55m48+5YNmq/mQlZsmXSdGdk2vEoUribVcfOv7zUyilmErPpZ98?=
 =?us-ascii?Q?Lth1vEpjjwQ+VP/3mU5NJTQJZiAsPfk5n6IZg/xEFoqEPCqiq+qGf7kU9Uw9?=
 =?us-ascii?Q?y3e0jU6H+sQLHHTjKp+y2HbSOhLJZRwl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:54:10.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901dfbb8-ccfb-4985-67cd-08dd1af7829b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index 49e953f86ced4..d1032e9992b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -278,7 +278,7 @@ static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
-	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(2, 5, 0):
 		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF6_STRAP4) & ~BIT(23);
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF6_STRAP4, data);
-- 
2.47.1

