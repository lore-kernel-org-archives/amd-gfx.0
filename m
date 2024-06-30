Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56F2C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E8B10E092;
	Sun, 30 Jun 2024 14:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EpQKLE0h";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A02A10E152
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WunF2qzN5Cge0KQsEZ7TsYwDt6aMiiGaafKzg7RWE2lj300U1TO3XzIi5IxVGD8MsHx6oHRLPuq9H1vRw+mEueLaN45v5E0GZdG0rjkzppLRRvn+ofEoXqdIefZo5uNfcHv2e0j3EbEfLut0/0vaBhhIbGVTOOz/Vs/xSVFqf3wdgQMzxs0pnWBmxNZvDYiHIIU9TKiDlRNH09Rb/Yn9kDykjQ8HGWjLE8hlrWsHnKGv9l5+IRM9YaNFp9hfYK4MpFAgyT72QGWRUv3oOaYlsR+jQg2cbXMT5q8BBUC+rbho4GejvGrnSl+CCbLoAnvKlG+mdp4+xEPoMS4ZkiDDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LkyqiWwWalpT/bR+B9+oszZWqpO4jg0kbKe6MV/Clc=;
 b=lgJS19CUjaOG/kMYEHKxg8e6Y1e3D9qkq1nGGrDI8p2HyyGJRQT+OkBrU14DkpaTGx9eP/1T6Ro29aRArqFI3P0MpRRC19JlqKXg3ffvo2aUV8Zc6QLVSXWHN8Y6jX0idLC8vZINk2St8XAv0mVpzv/ww+LROoZpuRzoimBFq71VUIyrPPb5GJbkxbXH/PJrLoIIjlcPd4oldKBrA3Gflwwt/goi/8VjOixuYu/6y/Q7DvmQZPSy5wRpl4V7gRG+1aRjPfceYD+cC3Isoj71khVxzbHPHC5eyEHEORy+k5BUKhwqMy8zwNiL0Qw89sKyiQlYNN6NQFB0ialB+7BZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LkyqiWwWalpT/bR+B9+oszZWqpO4jg0kbKe6MV/Clc=;
 b=EpQKLE0hKUi1smnIS9kHrfTy5wzVVkIdkdspSOLga5pcWZkbIPApl4dwrO0KCb1G5mJ5YjraK3k5VsyYMtDxv5yEOypUqGxYWJOc26k8WPC1KyIOofrMgA4k/Epn0/AU8x3klWfp0VYSP0HJZhFpxiWjJcWpqv0oX1DnSw5idSE=
Received: from SJ0PR13CA0148.namprd13.prod.outlook.com (2603:10b6:a03:2c6::33)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.27; Sun, 30 Jun
 2024 14:45:55 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e4) by SJ0PR13CA0148.outlook.office365.com
 (2603:10b6:a03:2c6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.8 via Frontend
 Transport; Sun, 30 Jun 2024 14:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:45:55 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:45:52 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add SDMA IP v6.1.2 discovery support
Date: Sun, 30 Jun 2024 22:45:19 +0800
Message-ID: <20240630144521.2016551-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6719dd-992b-450a-9468-08dc991358ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ggDbC2fQS/SV075ichGcP7zxQgJi1iXhz965C7oo6o9+fk+yhW3zUICcAmp?=
 =?us-ascii?Q?Jf6vyvpmEz7Coj2r01QZQrzSb9J+xvtDB/y/BjqBXH9KAO4arWED7FYYC3Pt?=
 =?us-ascii?Q?P40l8cIqRIXSBQOXJwOgKxNsqDqZ6Dz30fUIJ/ZwQBAaXKmETeHOclUOucvu?=
 =?us-ascii?Q?26zbbhC6LVnEaD6g+Y88p3t/jTYG++uHGAdKVX3vvxMHb3/XYCqmzXMJsThZ?=
 =?us-ascii?Q?0croOpeDZ3kQnKmFJONPVOG02m2TgwM6nCVrKZcguMS+3hPTnJGxMElgrcm7?=
 =?us-ascii?Q?4iVaQnK8dpED12SSPwgfUvDMVMA81pD++7ExdXiMBN0lD5mG2Yiqc3lVjfz6?=
 =?us-ascii?Q?zyp4P6yRBvN0K3CBoYTT1WasEGBjOjNGOnakPzOMlkHBvOT6soSZWX7MetTA?=
 =?us-ascii?Q?dd1plZhS8GFp7X3yYdM9kZHtm9aN46xge+EF1utw0bZft45DZelQiHhcusb3?=
 =?us-ascii?Q?AWXb0qw58GHPFpFkTk+U96lPooPZh/8PZA111Zp9w1B/d9oTWrYKOLxFO87k?=
 =?us-ascii?Q?kG9DYkIshBXGmdw6bhnz86g2jSF4z/9VAKjud5H6/9vcLMwJTDh1sC7rBgNy?=
 =?us-ascii?Q?bTfosBkZ/obkUVOUvpZ89uerBwaKz0gsAZVbFpBaMxCi7zz7BDud8oEkgLtX?=
 =?us-ascii?Q?0t47aBmcZn30fnzqpQN0dYaz39r5hRNQXVfmsjtrSVEFZjH8FrP4ZIV5dIhB?=
 =?us-ascii?Q?CnKa5TERz77zbtYqrvnCj/1hDHb94NCPhqROdu37mtSb/bh+5QWfnSUojwZb?=
 =?us-ascii?Q?5PmKptv6plzQ3HKl5qU5IQKec2gbhb2fOtjGLnlP9n/8e6Yydos5NsFkpNpT?=
 =?us-ascii?Q?XxVjXS5z7TFfaRPlLjOKpuv0iIWTImoM4ijomAgAhdU1uKSERV7+I6C8Ki/R?=
 =?us-ascii?Q?IktB7Q/5/owGzPXKpBzdUdAQVotqp6jaE3RfbV6LomSZqWbcqflpVz4TxJtt?=
 =?us-ascii?Q?g8Sp0vXdXV/saj8EFYvQ6i5uiqMtR6f335cdBWhh2sk8or7bMVGgaMSgkZaV?=
 =?us-ascii?Q?CHDdRnRYb0Bv4dFe2AwSQTDLuCbPTalDUS/pyH0pPQAOq5oFsEHFeL5Om+zo?=
 =?us-ascii?Q?nyckAVHl2RloLZtKGyiIQh1TZxVswtDFxQzzoePd64EqiOTlhLalQFdEz8jt?=
 =?us-ascii?Q?djMQBJ+TwCjqtfz7YP3xxwFhrXBfigIf7UayMyUk4n0KRRUuezRHbZCKnCIy?=
 =?us-ascii?Q?5LZ2Ov5zPZOIxvCGxpjmzUMV5hWx6IL1uxiAEAEsKYHzXX+Fqdqkhf/OZA1c?=
 =?us-ascii?Q?GrUO73zFABEO7r6lcEh0TWaShwa2UVcO/2v6EQIKP/96AfzU3NVVXpyLfS0g?=
 =?us-ascii?Q?/waibySD/lnksygflerOET7Yv4/1x3GcHUGYfKkagX7wGp4+sko3a2Y7eYVC?=
 =?us-ascii?Q?ucrkOqItTKAepvpzMj7y7sSEhOX1EEd3VbJnFTXNSkl37HzKc9tWnZwY7u57?=
 =?us-ascii?Q?kzoQ1grj8STVWmnVa1Xbf5PjDLd10rle?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:45:55.1148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6719dd-992b-450a-9468-08dc991358ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
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

This patch is to add SDMA 6.1.2 support.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 39f29de6ed36..b1ee5bafa493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2208,6 +2208,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 3):
 	case IP_VERSION(6, 1, 0):
 	case IP_VERSION(6, 1, 1):
+	case IP_VERSION(6, 1, 2):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
 	case IP_VERSION(7, 0, 0):
-- 
2.43.0

