Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD405C25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 20:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E3C10F436;
	Thu,  9 May 2024 20:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JpNQXIT0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 679B310F436
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 20:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTZTev9O/o9QGKRQ86fm5AOxhKWyNnb0wnBscN0Wu79qseGOBzZKyAqV5PTBWjKzcdal8VxLXXlNcT2G6/V3c0/pDy5Il2yq/7SyDVNwRoJxYRQXmrQNumAFiRnRYPPRQ3ok39AiuMicOHmSue8O5ktl0BnutC83s1pER7sKM8OT+lwaS3OtQRU0UHpAvLSm90abch+xBcM8kP3987e+VcaPyhyFzvXjlbuYCdDSyNa8A+qXDGMnAxVFWKPQVwLMyeN5IVP5NyNKrYH5Z+yQsU+jeuAQJXIrgqN3Lrag9QTqmI5BZYx4xSp7ej4a+X4yxXbNx3dD2qHfDC4icagcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHx6W/5KH7M7k4DO38Bw1OerBwhZxQ6Bd31JZ0b/mNg=;
 b=oJya/oHtmDjXaDOugJaveNkGy2gIMEre1uYtXGrWlBHEDGqchSJsUkAuuJ3i6P+m0D+CEQzUvf5UhpO5EKaontcZ+KlVjkcGAoz9tfkvbqE4Bau2XRbnVdJ8I+YkCEimHy8F/ZZFeL0JYhj7ImbZbzNEnVgzSkMwr8EheuhwVc6Nnu7Iu/a/xF5xd3GduxVfpySu6+7soV9l7qrVoovIW+Lskcozaw9YQr2umuxKtYyB7DOQNwx3ZgGsO74rDmpgRDS0PZqCUxJQ6+6eYHXWOJqFXm4Ncztsem1mexLOwqykec4peMvsU6bETpH8U0hdnk6EwWHKp4TegHwFFZ1vug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHx6W/5KH7M7k4DO38Bw1OerBwhZxQ6Bd31JZ0b/mNg=;
 b=JpNQXIT0G8qbaOQntFY5rLYUsjiOl0siIfqLB8vjlO7yqLXhK1Ouv4LNfmmbSJE0NFNvsi4xHRQowrjI3aec9ir54Ec59yNjt0JD21YjV+5L91GZMfkBjGgxIBSPkmZpHxAQz1/nWWLCmWNauZeVU1PEMSlU8y28LBiLExx75U4=
Received: from SJ0PR13CA0084.namprd13.prod.outlook.com (2603:10b6:a03:2c4::29)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 20:46:46 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a8) by SJ0PR13CA0084.outlook.office365.com
 (2603:10b6:a03:2c4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Thu, 9 May 2024 20:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 20:46:46 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 15:46:44 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg: keep drm kernel message consistent
Date: Thu, 9 May 2024 16:46:31 -0400
Message-ID: <20240509204631.1489565-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: ce642bce-6085-45a6-e88c-08dc7069243e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bUoadnfenUJXeDxDSb0zuizNro8w6VJUIA/xp6CiSKUd+Q/avKe3qlvaDuNN?=
 =?us-ascii?Q?j80vZR2M0ydR6eDJvpOlLlBSWW6k4MMsAGH6g1q13bY8n9UQxdz0VIP0hUB7?=
 =?us-ascii?Q?t0I6gLcFUgJPJ9mwv7Hvdysb5tR0YzSE7CxxtSYRO0KMXyu3y9UH0RpJFksW?=
 =?us-ascii?Q?KMua36OU83FYc0RappOlLHLZyz2oJ6GiIcWnG12Z4nQHWy8T3gzB0NY1Yjpz?=
 =?us-ascii?Q?mepT9SET6UKbR9iSWVG/HPDB19airS19/4dUTIc0KkxSHM4lSRJq3nFAS5Zu?=
 =?us-ascii?Q?MsOo2ergb7t6u1zDDUGlZVIPHYKF4Rkuk0d07biogDCZi2WeUMTgnMbv5wC7?=
 =?us-ascii?Q?9OWWQMAipqS7WXzHOGl6WPGtl3ouieu/RAzMxfsUs5gRsncCbSjE/8jef40U?=
 =?us-ascii?Q?H9uelKU6Zd+x+uVo44ODE0hiqVkO4eLBE9Lx5gibPRWJAEZCdUbgeYCI/lOz?=
 =?us-ascii?Q?WCLALJNcDTcFi986Hd+VqPh1HiFjdmlSUhYM/Hmgn7RUPQo2OWiXgcXt/w7G?=
 =?us-ascii?Q?/NmQoz67MTJCAuO8Pxt6qFirGRhLkNfWYzpNVLK3GX0KVFYZUOauucj9xo34?=
 =?us-ascii?Q?4HKvsjiyKTtLsAGh+gHl00T7WTUfrS3EFLAroPn+d9SNpmD2uuNwhW21Gzxm?=
 =?us-ascii?Q?3REZZzn6BqwQyYv8J/2DdqMmh5hVzzwuE7/y1pcnNApEziqfIXPQFUCcTV9k?=
 =?us-ascii?Q?duLpzyXC/piqX3wx0Hv2iN2UKMXajxJhwZB+ObYjfDXiBwwNT8QwKJwtacYn?=
 =?us-ascii?Q?tneVnsO1b5I2MzSXc7Q4TmrmNyHmzLLPkitCGvpyOtNnirDhLbjzYa7+TYqT?=
 =?us-ascii?Q?44/Hv7tyhqlDS75+tcxGhX7dFANZc4wDAUyBwbyllbq/MUQo+smJLg1sVSdl?=
 =?us-ascii?Q?uq1amztoNpAcSK9AK2LHTDSIIpAoVF3nQ4vHtnpg1YwLkk7j7h/RaX8rq3g6?=
 =?us-ascii?Q?ARFTZwBEA+cCzxZIXpc/peUWxRJH/PShHXv5RypeoBbocuUr+41j4WBx4iqJ?=
 =?us-ascii?Q?K9i+IyYv0dclABdB5BWZ10vNqQTz0a3wPD5iwJwerR50hK0IOVyhF7eeAyql?=
 =?us-ascii?Q?bpyZ/KVBv7XBRRByEwbr8xrKeNIFFFL4h83tK2iHp/aenTxq177GlSbnY4jn?=
 =?us-ascii?Q?XUFcMv5vw5FniRd8jFuBXrvMLMJA2/nRu3mMqIgztU24AWGJAWcA0mHbg6Fp?=
 =?us-ascii?Q?ybaFSzOuBIG9AQbP1St/z/sGI6AalvydxdzsJxeaRpLN6b5fn0BB+7JnWubd?=
 =?us-ascii?Q?NR8kG5/LdwNKeb4Dh26S0k5+zQlznLYyaNZ8osw34FAPSqdbIkC2xD0UpVis?=
 =?us-ascii?Q?EfAh4UnSTABLOmuN56TjiGXTafyzIzSsdMRALIcaxHONYJanL/GIJ3VE8tdQ?=
 =?us-ascii?Q?4YvQhgM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 20:46:46.0497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce642bce-6085-45a6-e88c-08dc7069243e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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

amdgpu jpeg kernel message is different than others such as vcn:
  [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully.

This patch is to make them consistent.

The message after the change is:
  [drm] JPEG decode initialized successfully.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 64c856bfe0cb..4be0668ab97d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -145,7 +145,7 @@ static int jpeg_v5_0_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
+	DRM_INFO("JPEG decode initialized successfully.\n");
 
 	return 0;
 }
@@ -549,7 +549,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_0_0_dec_ring_vm_funcs;
-	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
+	DRM_INFO("JPEG decode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = {
-- 
2.34.1

