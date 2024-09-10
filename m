Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F10EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 03:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD2C10E6E9;
	Tue, 10 Sep 2024 03:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yMETWCeH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C1010E6E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 03:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsxsgzbs6onqWuHsQe4I7qy3FBgVizrTIpjvTu5ndR5l+LmgJtwryJePBoqDtr/WT3F7giM5kHP85SmO6XdCzNBmk2mcr+yM7KpaTK0qItqOzcq5LJo4J2R6ycLJiPBUOBSL9rHjjEg9eQ0mcEOWyRBF0vBrt7GadiQYn3s1xMgQVGjcydCPT9GLJUbmflTMaJ0hXMc3yPcse6WKVgQ6UaTBm2TeOwyh5X2pCUO7m1IKQl95JM7QPPq0Y5WdUAn/++AF3p1kCyWeUpWr9vQXFwA0Cth+xvPJCL1tfmFYco0Z2hhwLoMSDVO4t600xEPOWGguVLQqIpUXlk2Zv05kpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a3kvZ0ineLQ+R0DkjjeiHFR1ImyWQjLmXKdQOeLr4s=;
 b=NRjQSOaXSsmGLuKKDHOualYJwtMY+m5QxVoSIUZwMA/iPdGWhPAI2fDBuqqkE0z6MUzC0n5y/WKWXbIfnc3GhspGW7B35UdLTL9UGXKkM+qyMj+PoyGTX8EH3UQ54lApSdOc0VNjQZf0PEfLW5vLbqRoHW2U4SqzPOUlwUoJ33a78bo3w09/lj4q1NFVwM5Vn4FIFRCQmqaIGTSxvKaMw3N95moLkZcqVTCOKeIHht3YoSmdtr51/n7CqEFqrNWpuf1BUckp6FiIlfiI+0LbNObnYsZGEalWInXNhK1lRtp+RUvuIxD1Tg/YhRLaDHN0PNUGMIyO0c4tJcuwtso+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a3kvZ0ineLQ+R0DkjjeiHFR1ImyWQjLmXKdQOeLr4s=;
 b=yMETWCeHoedoCSmOubkNsqNLcT0k/J81EGqYfTHMhhbPRFE0kPiKoS33gBIHToWFn09AIqa82U4Vu05fuTFNHgKFMSfdlDhvTxtNazZLJ75NIIdtT/YaqhqaXKnDMImbPjH1kb0XSjM9l5OU+lKiwlKG6G4GPa3C5qWsnFVuWbY=
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 10 Sep
 2024 03:59:37 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::51) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Tue, 10 Sep 2024 03:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 03:59:37 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 22:59:34 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific ASIC
Date: Tue, 10 Sep 2024 11:59:14 +0800
Message-ID: <20240910035914.20273-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cca600-b1de-47bc-e19b-08dcd14cfd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZZ4jz3JIbJt+NF7yiatKBBr6sa3zXQ1nFNXxPIgA+bcpx9tgVVGRinSbMtYx?=
 =?us-ascii?Q?l2R8WpTKTDNuS6P+vzqyhw8sK6M3fqHYqxFarAxDNyTsp9rhIQD+c/1xNAel?=
 =?us-ascii?Q?kx9/woo4y+M6g9fCfxYySaxBNRWUkD+PzTAnYDFQKxcrJBPOZgO4PacXZD+o?=
 =?us-ascii?Q?lgBoxpsg2CTY5hiLgfY95xp1YheX6c8gZoZg7kwJrHYj9axACgqcXk4DMb4M?=
 =?us-ascii?Q?uDEpODsBZFVBxD8NhE3lmusm7mbAMXoGdKbMuMjCQSVr6QQPRJcbLHB7L7h7?=
 =?us-ascii?Q?b33Ueq7a0liARZSAX8iYr1xnvuaWdOYFfjrorWDGD8JrsgJaz9XLBlGFPW7m?=
 =?us-ascii?Q?RYmOtSqHaJ363W4jBA7xB0Zbn5o7KLyEKHuKCnSInD1TMJ7sW8i/2eOVXnBa?=
 =?us-ascii?Q?WPuhHicqcyklLu/fNN27bBFEeewfX1CHwyydqWhoRQSEVizEO58H+xTTMWjH?=
 =?us-ascii?Q?6YXuvq3zttHQ3D3uwCJp04zfsDshjCwe2kzFh42bAyB0HYwLBeGXKogItKCC?=
 =?us-ascii?Q?AlHE+ZP3o4TECkRBfA0G8AJ6aMb8+5V/kinDLqnhfJqcBV9XSghCfONOqqec?=
 =?us-ascii?Q?AKkf9ZvwtgZGdw7UhGH10isvQcGMD6knalbG6LzA/Y0D7ztPLbv7HVkoXwUo?=
 =?us-ascii?Q?ch75+ymTjhQ0gCT2OXDHUi3GsiqXTqL+Z7ZGf8M0ylyOeCLAdQ7Mk9PW1V6O?=
 =?us-ascii?Q?hW6yhGw7mwswVgU6i6A5Lzf3J7otMD4nirCu+LX4jfW8K9YNNMXHeiZC1GlP?=
 =?us-ascii?Q?wlch5nPqM9+8aAMPda8xKqOfAqDE+mcipSUAk94iW0UZbnhbnQYx46jq/PGH?=
 =?us-ascii?Q?g3PSQPr7OQ8TvSpUrKjOGy7egDJdRdphKxq9TQIuDYn5e2M/ZOWEXC7IbOkK?=
 =?us-ascii?Q?TwECVYyKEA0n4ROX4QsdrW9aBfGiX3KpxSzXCO2NJ+sG8BHUcBTpal5f1yYY?=
 =?us-ascii?Q?NtfgLYVNQBgEWZFIJphKAHEBRB2fNhLMdUNbcJCsxSv15l2iBqk9FhydVqpp?=
 =?us-ascii?Q?N2WKbK16p9YmPoDKMtR5eh3G/cgoyJD9+KNDG4dWd5QRYwpKph/0YKW5olzS?=
 =?us-ascii?Q?tQd5Ix5J5LFAoBl2aMm0xpgY3d2TBkNjSYuN7g7+ug7ri0PsA8s3kgVdSf5C?=
 =?us-ascii?Q?WT9oPtrckDKLdcjqIUh+AXcj7eexGOhAUkPvFm8p7zGwWeP+QLeTwsD7z0RC?=
 =?us-ascii?Q?ndpw0t2iVbLoE0PieFORTvoy4a+GZoxv0rLuPrj2ZpOE7QTwU20wa+yTB8T0?=
 =?us-ascii?Q?H6LHuTQ8CnBNuhSdYuoOgWBfSi5UP0WY587a65ddmsR5Sky9kuZCVZC1Ee2n?=
 =?us-ascii?Q?T++snkudHR8G9GtkD1AOXEGT2hsf8bAr4eKcySRiiPW+KoZL3T+CTqRAq61R?=
 =?us-ascii?Q?keohpZidZ4AWa9K3rgz15GJiU06qp6XXczTg+lnTfu6GTuFKCOHLyCfuFc+M?=
 =?us-ascii?Q?ObP3Alf1euoYcL1cP7Sm8ffwbGBN1r5Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:59:37.2013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cca600-b1de-47bc-e19b-08dcd14cfd07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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

The feature is not applicable to specific app platform.

v2: update the disablement condition and commit description

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..08efc9121adc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2055,6 +2055,11 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 	con->event_state_attr = dev_attr_event_state;
 	sysfs_attr_init(attrs[3]);
 
+	/* bad page feature is not applicable to specific app platform */
+	if (adev->gmc.is_app_apu &&
+	    amdgpu_ip_version(adev, UMC_HWIP, 0) == IP_VERSION(12, 0, 0))
+		amdgpu_bad_page_threshold = 0;
+
 	if (amdgpu_bad_page_threshold != 0) {
 		/* add bad_page_features entry */
 		bin_attr_gpu_vram_bad_pages.private = NULL;
-- 
2.34.1

