Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3E3C35FF1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 09:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750CB10E9A1;
	Fri, 14 Mar 2025 09:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lnBe0L2h";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0A710E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 09:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7KUfzUchKOlMoL0xl1GSccpbml7DOwED9COjOdhAbNABJvSB+ijNqMF+lZFNEOHA7lyn1dfr4UB6+yqgd+NOCgPIlNBm1LgiV/W9w0jzBL5OQvzHtDbDrtx00o0ql0VwBWZTIClmfFVZOi+Xho1lEJHCVaT8hovY1dKSZsFb1BLy1cY+2ZKKbeZQv+m3kipVqM0sA/c+6vpJuvkJOXNm7oc7IXRfiTpUfZHvwYrOsE/wT5NjRfRQSFsUGWgERWv7+i66urhoyLg+7eIn01/1seh1xJ/J2Ra9lg8mv9tm2CZg1zG0982jhvvx9AG4jHF0JttOXpFWDbcVJU07oVqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgmaIxIm3Xsg1ZMKKagu+5UEbKbBR656lLt6okfA2cU=;
 b=B/7VF+qYGKOkax1BVLw780eq0sEnkaZVKJcd5bdBIkMFKWF4+fJ8i093sNBR3KZdHQgtCozYqd6brWpNBbVvb+NYDCXPuEQHWF3P+vqLRmqQBnCcM7GiGmY7Ew28uxyl9L3QSBPwzAjmFBhU2T6my4n2Os5iABkDS9rMMbhlJ8HJXmxA9GSmBwI7z/f4popEAQuyCkyOkRTOHScDs63AUrbnxN/+/2AAWSA29e1g8W3OqoMl5ss0rN1yo9/vDrtUvkvM1GHwc/Fq9vF6NQBbSnaZ9vwzEDAym9KBAe7KnRMZ14/i0VEKYPhJ+V/RuxQUkKccTJv6pZdF5zubEc+wPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgmaIxIm3Xsg1ZMKKagu+5UEbKbBR656lLt6okfA2cU=;
 b=lnBe0L2hXsXxA6l7Sb3rUxtJu9odo6exeKzxk9ZueWykMg4nj69bTxa2FKV+95qzonPpBqUGLgO5d0ZGL8UMwYAyBpyUpaHwThtNs+E52Qj9fKeuw+alur1wL4UBa4Sbnp43H6qfwJad1VhLs0bKIOVoRFt4K+cvmZAEXiPWSr4=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.28; Fri, 14 Mar 2025 09:54:49 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::8b) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 09:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 09:54:48 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 04:54:46 -0500
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Li.Meng@amd.com>
CC: Flora Cui <flora.cui@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: check ip_discovery fw file available
Date: Fri, 14 Mar 2025 17:54:26 +0800
Message-ID: <20250314095428.2914973-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c80b28-44bf-40f2-3f0b-08dd62de41f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IesnsX56mjDI9Q0eUurtSUAQk6xNPw5uXwlgcwnJZXqD1MWiQXts/et9Tsq0?=
 =?us-ascii?Q?BNF95LaVycJbdw7u20YHswGJV9z8L2AH/vICcw7oBSrsrVvhwj4Sr5YtyCfp?=
 =?us-ascii?Q?szX/aCr9fXiyaGb6A/fboiHoAuVto01I0Cw+jLNf3QayZDkUhAUZdt9hk5vl?=
 =?us-ascii?Q?V28DgkuIK8qFwwfDt1Jh3qsa60yQ/WpYSf5+ee6wltVAKtfhdbmsjqVC2Bk4?=
 =?us-ascii?Q?vUsjClqkXVSF/Wt1BCaKUmhkkQLKy9R5GJUB9aqhrGh9U87/voxuyRWe5AOn?=
 =?us-ascii?Q?k9ugZ1QrtoWt99sFcRGcqbTr1yFny01qg/K77uD9ZJ0TGS5Mg8iJeX52mfkj?=
 =?us-ascii?Q?1NxaqLid7ZX1rajXmMrrQFsEpZmQw7SrvPtXJqw8JOQKW3qlxj6krPOq7Tyq?=
 =?us-ascii?Q?uFFaq4GJ8Qog92D17P4O5tephdlmXe3CuGbBBObP6zZUk1lRFYz+mH5EVyG4?=
 =?us-ascii?Q?vGWyBvTc+QR5046ZJTO8O73fhdkJgndyZ8EdCzgRArt0Ur8zrry8Vazt3CN4?=
 =?us-ascii?Q?dbMGBYqpaf7oIQAeG4+zF5MJYwbRuxFSrmlX9dGf/XXQAVwa2YrbWZ7aEtUI?=
 =?us-ascii?Q?3vfxMKWRhWCkwU6WB8z49niQwuj+18GRZpS0OC9mItujsyT8Q0IJCNIosO1p?=
 =?us-ascii?Q?KVw3Tg5lgsXLXZnDsOgEI1VZNvolGpf9y2umoYKF07OeeWbxLQ7kvlyi4O7F?=
 =?us-ascii?Q?2Wjz86MJ38xAXKd4+HTFdc+q0GKNeu8kpDi2K8Ge8IysbRtFEbltd/tchXmx?=
 =?us-ascii?Q?xkIKd2sL/vQgh+FCWtq4fwHShwxNhhSZsIiLfZA4BHzDlzei0/CSox/2n47i?=
 =?us-ascii?Q?6KeQyFJBjv2dgb7YFPOPB4J1W3yGTJxLWigIJMAydhepNaovRwEX4d/hppz3?=
 =?us-ascii?Q?hLat7UWCDB5lMotyIYuTXGSsGrNaNzg+EZvl8kncaV2iggCxfxl3TF5+tpB8?=
 =?us-ascii?Q?hkXgT2qdqSFO+nj1k1qWwUZ2GelPew2r4G5A7ZSbqRkW24E+Kngg1gNR/Hz8?=
 =?us-ascii?Q?h9/dLNnQgmthpKDuKMSrkPxFbUnRk4a4bJ9bg7YFXCZavvWMnGb1rUhFZ0sM?=
 =?us-ascii?Q?rJxxmf83pUucnxj2gDqOyfPD+kI3BbOupXdD6ajMy8S/E7dvvhrV3HPEYQfZ?=
 =?us-ascii?Q?lXRJTstgI7mQp3EJPdrVserdgg78xbFDHJwnzbegvPYdNGjHTchVMICnHOAK?=
 =?us-ascii?Q?/dGveLE0kFgq5SVK+f5qDRySIXFK5BEPysTP12BVbOFWn4kSAabQVJFafIhH?=
 =?us-ascii?Q?9XW7peXwiH4ipyxKClc7ghkvZ5O7wU1ou4JS41dzft53RZrBJ8CsRl34uS/v?=
 =?us-ascii?Q?RvVnbHZs6+iLe+a5pSWKjgoPB2r3ZsbQS1YldoHk1W0HUDvlIsq208CPryPg?=
 =?us-ascii?Q?3RbnlVSFng9dZllIcWNnFdfZTbH+zvYdyU0GwleUtHDCa2OfEXAdkjoG8tkN?=
 =?us-ascii?Q?0e/p8cNwox3zbRtsnCv34IxHLu4izquUYxiHm9X6qXAjsUGnNUFUkcV9FMGu?=
 =?us-ascii?Q?UNcTmj8w9l5bW7s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:54:48.5125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c80b28-44bf-40f2-3f0b-08dd62de41f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 967a992829bd..2b4854e03821 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -113,8 +113,7 @@
 #include "amdgpu_isp.h"
 #endif
 
-#define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
-MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
+MODULE_FIRMWARE("amdgpu/ip_discovery.bin");
 
 #define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
@@ -297,21 +296,13 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	return ret;
 }
 
-static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev, uint8_t *binary)
+static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
+							uint8_t *binary,
+							const char *fw_name)
 {
 	const struct firmware *fw;
-	const char *fw_name;
 	int r;
 
-	switch (amdgpu_discovery) {
-	case 2:
-		fw_name = FIRMWARE_IP_DISCOVERY;
-		break;
-	default:
-		dev_warn(adev->dev, "amdgpu_discovery is not set properly\n");
-		return -EINVAL;
-	}
-
 	r = request_firmware(&fw, fw_name, adev->dev);
 	if (r) {
 		dev_err(adev->dev, "can't load firmware \"%s\"\n",
@@ -404,10 +395,19 @@ static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
 	return 0;
 }
 
+static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
+{
+	if (amdgpu_discovery == 2)
+		return "amdgpu/ip_discovery.bin";
+
+	return NULL;
+}
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
 	struct binary_header *bhdr;
+	const char *fw_name;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
@@ -419,9 +419,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		return -ENOMEM;
 
 	/* Read from file if it is the preferred option */
-	if (amdgpu_discovery == 2) {
+	fw_name = amdgpu_discovery_get_fw_name(adev);
+	if (fw_name != NULL) {
 		dev_info(adev->dev, "use ip discovery information from file");
-		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin);
+		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
 
 		if (r) {
 			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
-- 
2.43.0

