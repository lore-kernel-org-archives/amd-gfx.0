Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C92C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 10:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376E410E275;
	Fri, 11 Jul 2025 10:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KA9IZzBr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0227010E275
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 10:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkTR7XFlJDe+qDVLf0YRHORFbbh5nPlYVfljYyxPPs6lDf4QuH+Q+DHc57F8znYYmft8c3FeBy35H66CCTT7yusz90jxkYfTH8Flax+8cY1+FvOPpCH1oT04oF5DjjR4rjS3zf5d2MdTnsWet212MICVaHlc7I2RGlfM3Uz17bWTt9k+qBZfERjb5nzfiA+LWUiQOe0mcOTNHWltQNkZg66m9vkFIXMpZzlaJHZF5lYpVQ8AxIzlIusRpZ9VEE+hVaN4e2d+4M9gY/rVMbs94Gnlobp1jhwJwfD9n6r2AE4eRaGP06UR9rbo3hMrCyzNdK09OzCArmeTIvFszT7PMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2xNoBjlQlG2z8egV9l7llKuLlpYsdlRmzqEj83l6s8=;
 b=mMkEyYmLLgE+wS+j1CKCFo3u6K3M0r+DuOKnosAqVA253S7OKgyO0PMBdUzIGw6HSuzigDJouD7ZBi1MFgyp5jrZUn4PqBoOiTIed6ueH0ee4ISMACTWkXXkN8NdNu1wdxT3FUGRyw/Gc93pa0K3dPujFCyBh7BLv7F+BQwylHo36pzIb0T4Y/qgD3u4ulRP+Favrkck4lPEP+XFhd97I5F5KrywPQr3S9Di6vB2ZIjCXudgrhIAFX2YcsJP/PqAo/n4WMMpRT4FfVxKYl5TQfdm3WBbi6VTt2/9Y+HOF6TOiZv8rAEFBBl+Hh1f4/gNr6t9alqfYvD+rc71+mzNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2xNoBjlQlG2z8egV9l7llKuLlpYsdlRmzqEj83l6s8=;
 b=KA9IZzBrvsw5Zsfj2Kt3rH0XgDrW830IEAF7H7S/quFo0mCTWE6oX4erd3UsH32ecNFpL8TViF0zccMqnkUWr4VaCfSKaJ3zz8hDlSMWx4IiWgsZx6kzKdD/bsulcchV+dSgjgwRyAYiZxna39saTrhfNtft4VJh4gIwu4XFPCI=
Received: from SN6PR16CA0048.namprd16.prod.outlook.com (2603:10b6:805:ca::25)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 10:16:21 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::40) by SN6PR16CA0048.outlook.office365.com
 (2603:10b6:805:ca::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 10:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 10:16:21 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 05:16:19 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: The interrupt source was not released
Date: Fri, 11 Jul 2025 18:16:05 +0800
Message-ID: <20250711101605.16301-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7482d365-8218-4b9f-3c5f-08ddc063fbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3pPcvyPR4/0FLKwtLl88g9Tqju9vh7qwt0+SC2O6c0PrxJO46PgRXwKXvAVB?=
 =?us-ascii?Q?T01gw8VeysbI1rDX1ZSoDYf1hN8YGaOjcevO3sI1GAR6BSu2TLgfCLRp/8pk?=
 =?us-ascii?Q?cRaG+Xkg6hM0/NxO661o63oDVzBqPFJxQAZhQwf6ropXe4pQNiwKSNEEOTN0?=
 =?us-ascii?Q?8WC9V8pexOquaWuE2i6EeeCC1QVlVtFAZYkslmAzC/rjGAR/O8FriJw2AXd2?=
 =?us-ascii?Q?sHlixR98JpgESS2yXk6/GuB+k22I/T8xmnqtjctZU6IddpKRz5km3vmuegsX?=
 =?us-ascii?Q?G5ip7zjpF2Zl26TvKY+fG1my4qu906/xNhoOlIr7LdTiW5N4XteewPLQYu+E?=
 =?us-ascii?Q?dpD1E7eXXYr8A7NOUmVJIkpYlHB9f/Uv0uB/Gvh+T9UBlJQRnrofCb+K2rKC?=
 =?us-ascii?Q?a0XZFQkQgjp/zNI03KBLc3tGfGoqqLboCtPG5mIsvxRCQvwloSZ87tAjzNsY?=
 =?us-ascii?Q?/xQ1RslnYS2GGHOIpEkHVQTx8ruiaq3Mey3wFgDOS8fr8zVVVLi0tAUojdrI?=
 =?us-ascii?Q?mcIqikiSeaZu7BGhG3E6VBlTU0MuSsQW3Qq2Y0d+7Fg/XJncySjiHaGBs0S5?=
 =?us-ascii?Q?afwvjBnkgTDs5SHTREHVhiIKtq5KcZmmgBa2nhp9Zezn8wY1D61MjCjW4rVf?=
 =?us-ascii?Q?AjfPVnQAsP8J8p35no5jEtOTAkdZE1Q9JRFSRT7iONzWyK7Q0vH1uCOzFJbH?=
 =?us-ascii?Q?WDSgvejO4snCNVZUTYgxr6w+2cBVu+s8nd4bwLi/z+jRIzbQPfBKyrZvKeRv?=
 =?us-ascii?Q?s3MglSFqGQKoNMY5UJNFQIw+uMEQ1Xuwpo58/En+xn/dT/KSWpYrsI6qQrn2?=
 =?us-ascii?Q?Z2pW/LjhKVOCRElDzrac+kqM4jmRRPpLMWu5LJTU8ZZWn6hJYj58wYHFF6Mk?=
 =?us-ascii?Q?mBwMLOW1duNi4EE3j3Ix9QMSOjgzvHPWkkNvmR6684vPiumZppi9swqxuJEv?=
 =?us-ascii?Q?ECtGqo4Hdsf4KvRZxTrh1OcKqjxcxkAysfvKnZCaCA1owwWls2yKgYOHtWIR?=
 =?us-ascii?Q?B8dKb89LfBCc4u5rrO/zPLagmJL3Sx5Kgv/pQHOqyB9A//GYs5wGMjezULp0?=
 =?us-ascii?Q?iLAHyCRfqvZ0knCC30Dcd0JGfzY4OXjtJku3ItELsu1wwNrSS4S0t3RMClMq?=
 =?us-ascii?Q?bjZ6CkDjxIZrDhc0ZzgQK1ZckulCVSybhNcA049/+TCb76Zbg/AWCXiahAZH?=
 =?us-ascii?Q?fK9fYIgX/cvTpo9dvz6UOsIo4luOGzw3zj8HMI3sK/zsCKeMxcDYWZ+Sbhf/?=
 =?us-ascii?Q?Vl2R3HApzWuvEglGjwEAM4qNFiODaqBbVs926dEZcnTIL5yZqm8MuVfWAWyE?=
 =?us-ascii?Q?CWD+Jjv2VPyF9xJQ7437HeyR9fQg8IMBAD6attAEZKDPPdvKWJGvbyXd+vxM?=
 =?us-ascii?Q?zjolERU+u3BPQL01QCo6Tf+0dJWiKYv5CBJB6v/dSrCBkex9MN/p2K3/oa/I?=
 =?us-ascii?Q?2IyojvnONZhCGiulu8sSB74/QsyDF+GNLJfD45kX/oBWjKpWImmuDdxkYO8a?=
 =?us-ascii?Q?Rcp4I+cIU7GKG4OqBDpc21UOXP0V9q9THnlY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 10:16:21.2614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7482d365-8218-4b9f-3c5f-08ddc063fbae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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

When the driver is unloaded, the interrupt source of
the rma device is not released, resulting in the failure
of hw_init when loading again using bad_page_threshold.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index cdffe4a1559f..80cb8865c02d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -622,7 +622,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
 		   unsigned int type)
 {
 	/* When the threshold is reached,the interrupt source may not be enabled.return -EINVAL */
-	if (amdgpu_ras_is_rma(adev))
+	if (amdgpu_ras_is_rma(adev) && !amdgpu_irq_enabled(adev, src, type))
 		return -EINVAL;
 
 	if (!adev->irq.installed)
-- 
2.34.1

