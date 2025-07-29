Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F1FC83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 03:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5D910E5B8;
	Tue, 29 Jul 2025 03:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvGaZCJ4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5972D10E5B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 03:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHQGH2JjDco/K1F7K1HYQKqrY/AXh2hxGLUAPnTK0KiMH/YDydmU3mhorYF8UOPBKQYF6EggczWtenkEkTkksVU/q2X1pAQVcJWGsgKGzIt+kM+Jms6KBiIqtJdFwWx7zWP6mWYETHtGu43sAHrzDbHUMIUb26d2kIJtaW0NY1nA110Agcj8QlyQi3dHYUbJkk1Vcgzy7KfziQ7RQ5HS7g4iE4w6NBnN65LobeZvrv9XHcrsp/N3+bgbq32VI2ytIg9IEQeFdRGkvarSYJXWRQ84YBF3XEzq+qwf2o/Av/I4YNLqSxtgN4nUVmUL/LEcXmQ/UIYx92hXKZzabLlSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBTWl3XA37K04HDyegxaQOZZT0d0z0qFSbEY2D5RWbs=;
 b=bjyEK3qmXXEN3JoYo2bHdoFRBwF66L1Y1OIVCzSjnSNBLXJw93DlLEdPtwX8su946ZpvgkWlfOANWEixw9AjmEOI/eLLwNoJGkz8uPs3xrDKET/tjJOko4dZVkBPO3G4m/PDKe95Lp0CXzg0/oZ3TmxPeqlZN+JyRg1KOvLG+cALMud0CWIxyxsDJNmkBAFw4ra39vkqnASBeNhjXAes6r1vHhGe+pzP3cD1OFj790dQyK/qMTAvqL8k3FtldqZytUia0NXWM5odVBj/isp1R6mXR4hz+0S+rQ9Y4lWk6ySIK//4kUDQRtP7mWwQpBx4/3npNOe7Eg2aYQsmT8hQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBTWl3XA37K04HDyegxaQOZZT0d0z0qFSbEY2D5RWbs=;
 b=UvGaZCJ4AMiYmJt3UtnC2Sh7v827i29a+44R7UlQbIlcfBFXkOMTAwYz+t8XlpQiWJCwdfb6vq67xyW69Ld5bsctnIdNL6RqFqv8rIPQpA66hsoO7nqjZnzEMH3x72x1hbZ8Pux9Wg+s+73S1OFI2gBzCki/fTZjCLxl9oTamxo=
Received: from CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::17)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 03:32:36 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::24) by CH5P222CA0008.outlook.office365.com
 (2603:10b6:610:1ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 03:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 03:32:36 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 22:32:34 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH Review 2/2] drm/amdgpu: Add new error code for VCN/JPEG new
 chain
Date: Tue, 29 Jul 2025 11:32:05 +0800
Message-ID: <20250729033205.826312-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729033205.826312-1-Stanley.Yang@amd.com>
References: <20250729033205.826312-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5c7be9-35f4-4bdf-d180-08ddce508fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ggbgn3gqAV8eZBV0lZFh/+y9cWvwhkCkmdVrA/seMYRCvIGCGb8fVQEmPCvA?=
 =?us-ascii?Q?O4lUEKMWhu1lK6ahTVguttsmlDqNjOZoLrgx/VUougDXmT+BiRDeWYdHS70m?=
 =?us-ascii?Q?c6fSTdb3H4oo6u9VOXoFRvuq553lPWv/StU0NLZreVVG42IL/B7399DH61Nz?=
 =?us-ascii?Q?KS5XHDyQhrBhBt7OZH+amZcqVH27eiAVDxObCOB7ytHB9Ydq/QtVXtlI5yyA?=
 =?us-ascii?Q?TZ4KpQ8//UjnQzU0stRlMkYZ1qCHrOEjKrPT6KR4muCm8PhslRFgV9psJYjk?=
 =?us-ascii?Q?MKcR5GCfBHJzkkeKf2YDWseW9ovpL7D8VnsxEIlDQNN5P4jv/hz9OKDO6Gzq?=
 =?us-ascii?Q?e6EtcZo3Cck0IfdG/olBSRl23XkabfHJiejwmQx+ORGPfvCu2giNpTMMxmlk?=
 =?us-ascii?Q?UwhWXgDt03MH8t83x8HUPBM22T5BQcVkSHPVjnFDRK52rMh3QZpUaR0RKsW/?=
 =?us-ascii?Q?T9MF5ciu+77z202obbvIpvqyUtMG86izMDbvOg45cxTZwsCIPgYfh9D7BNBG?=
 =?us-ascii?Q?UftHc6YKLxFdH/Udi0AQhVCmzKqCI3vOIQIu/kgHT+0Cjt/KbAkHiDTT8ikx?=
 =?us-ascii?Q?1HGs0e7mpVCbyztik0GDQbaLvabHiW675NSUui/LcmQjzVoGvjDOPkIMM54k?=
 =?us-ascii?Q?jCVgBZikSKJbfMdpoeSU0ETL9ZHCzJskTV2dsaUkkfvQ1DVIwFXWhm5PVKjv?=
 =?us-ascii?Q?IXWLTNPKkWZkOsUmAms/kQhBOacRTyeJ+eQ/mGJ1OvDWeAiZIC8WEwFwP/fk?=
 =?us-ascii?Q?EJ/CxAr3HnSsGNnbbO/uGx6odpwGt3AtAg9ZAexCcaKm1wbNSvaKsYGOZ4nY?=
 =?us-ascii?Q?fqiCTqXnkdHxGO98z5hzaJ70Hcdv9bVObBbABe06SITCKEdIemmpKSpSZYh4?=
 =?us-ascii?Q?OJxmb5uVQ3/2AMcAJp9jAyuSfdNZfcjmhDKSiKe68OguLQo4Bc1AMgpIDpuQ?=
 =?us-ascii?Q?Cg7F0ITishtm36IVW0dFwBJdWVLlhF6/alacdfKwqIB4KTYzbKqAWkHAJzl0?=
 =?us-ascii?Q?sI0fYkwyz8APJy5/eyp10nSjxbZnr+XhA1XoWufcZHJZ7PvCJTb4XW9exQF7?=
 =?us-ascii?Q?AqNtB145lFGWQFMzm/5CiIFMRMBYLKa3RWd6+GmGXUK/Rbx56GqOZEeUNn8B?=
 =?us-ascii?Q?BsCGdoHRNXjzLDmpvpGHCfisYBtMokDgVRiAT70xnBSROt2InU7W3oRlKmha?=
 =?us-ascii?Q?y8vhlmoaLpYZwGN2wrMnipBqLYHUyQ9uEowLdBpo8LPtliK5wKOOWF0XG1Cq?=
 =?us-ascii?Q?2Th1JGWcPZCn3R4fjvG7jkIlZU89MzHBsaH7YSTE9O9+MZxRSsQ3/sW65QD7?=
 =?us-ascii?Q?d7y318GUtVXXSFTBugEbaGKvD+39QYZW9C5nMg2DqVCKGbtCLjClZK3mjXwX?=
 =?us-ascii?Q?joO/jdqiRmeAsRw5erIhZd+owAMfV3l6cYnuywCuXii56yRmumzGICSvgvOS?=
 =?us-ascii?Q?YceH2Sq2vjfOGDGQJiGTrHSrptVfr54+C0fcY7hHZQP1zmcswGnwdd7YO28R?=
 =?us-ascii?Q?QZbD3NGq+kXBjPdyCIgTAPW2cHr7Er3aOMnc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 03:32:36.1857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5c7be9-35f4-4bdf-d180-08ddce508fd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
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

Add VIDS and JPEG8/9 S|D chain error code for VCN/JPEG v5.0.1.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 51b9148626fc..961ab557fed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -1028,7 +1028,8 @@ static int jpeg_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 /* reference to smu driver if header file */
 static int jpeg_v5_0_1_err_codes[] = {
 	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */
-	24, 25, 26, 27, 28, 29, 30, 31
+	24, 25, 26, 27, 28, 29, 30, 31,
+	48, 49, 50, 51,
 };
 
 static bool jpeg_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 0333a2833b2e..120414fb024d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1565,7 +1565,7 @@ static int vcn_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank
 
 /* reference to smu driver if header file */
 static int vcn_v5_0_1_err_codes[] = {
-	14, 15, /* VCN */
+	14, 15, 47, /* VCN [D|V|S] */
 };
 
 static bool vcn_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-- 
2.25.1

