Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B3EE77173
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 09:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A65610E694;
	Mon,  9 Dec 2024 09:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gkHwggXU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD5910E694
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 09:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNNkfsZgrz0pDhnPi8x9AuNFKTHqChmvTE7BZa0+snur5/JNu2d/5aHYMQeeN33NBqjpxEuv5DONAzZIRXLn3BmfM3qreIHXXOE0TxIvwGPj0oEene4p8LwS5wJFox2sDa8d7H/O1Kp4wMzsXFtgMVqlgCs2G2BJjqUCosY5dEVL6/lzalDQZFRdJ9c8rGIzH3zqRcs+IFOm/+KJkiunQV3Oyh34f5UscueFmq7G88P9uu9CcQcPSuMn65TUwc4s9EHbGHq+m0nvMCaVRfQ46PCXJGLAh1d2RzzO/+DJksDL/9s360t1ETC6Aw+Uo7JluTUzIE3EAFYw4PMuIsY0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/De1ZedcWw9KhAEw4Og3CAIZERkwUpqxR9fP6UDZiU=;
 b=ihzomdZ9CLX9fnegiAFvxFDHhFlc+O6ZCxIIpuTuZvxGXsZroKnky87zpbYimvs1ytyYVzs5xg7VmoG8jO1xTZ/bCtqNWaMrGExOW7rqfLCiJVXT8zCMK+AWGOUSxhRWTCKQwoCErsR3YKpbHXF35hqDgEvH84/7TM/jILw0SQzGwq+LjKV2cKUSDBLPQTI+CyCg3AGvTEdHLeURx8k2sISt27kMfstviI2DQgbKOm00rTCw0UD96GLv1iLLp/W+DBdi5xi84kvpj+eQkf+y2cL5/WYjZUhpcfOTyasFvApfqKwhy4/sxnZWg0i32HPhPAUPwnx77jQJwVbHvywQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/De1ZedcWw9KhAEw4Og3CAIZERkwUpqxR9fP6UDZiU=;
 b=gkHwggXUjnkiWTXDJPLJnAdpZZGIjMXavkDc9fLnRgB9F+SPhA54eEKNfLBV7JWjz95qp6TeiEWdn5xNQZAt5AaYO1eXXm4lL1AdgUjk++X/MxaEHsVoOEkq95JMAooKQXPw3taSnRORbStDP0phxs054/fZiRpRNcEnaSb5OqE=
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 9 Dec
 2024 09:00:50 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::5b) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 09:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 09:00:49 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 03:00:48 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: improve RAS ACA to avoid binding unsupported RAS
 blocks
Date: Mon, 9 Dec 2024 17:00:38 +0800
Message-ID: <20241209090038.3255608-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: af07f135-7d5e-4d74-d4c3-08dd182ffa5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GK6X1d+rO+Vf1tjBJNH3bEQpBQ3AQjMdBLRb2Zvd9nE+qVU+3OCjKS4ItM7C?=
 =?us-ascii?Q?9ibgv5/nTdoDe1OzuG7H4oT6oqjZXhn5D67Sl5KDg/vI/DG5JI1IQWOGTk00?=
 =?us-ascii?Q?t90ilEUZV0/v9XDQ14Pr5invyi29nxbtAOD4jO1w9Yxw/8FWuSZTBa+9KdLu?=
 =?us-ascii?Q?uVH9h2IibGkTW1IruWWg3JVEi6Cvawpbhm8S+RMKWy0pT8mlxrRAHFWAsE4Q?=
 =?us-ascii?Q?OljujDUqrywi1LOfB/Lehmg0F3PfGXGdDz45lAFctXUb/c32cbBH6HTfqHS+?=
 =?us-ascii?Q?TTMoSZ0EewSYQt4sxkt8fY0zedECtiC3EZWOYXESYnkqdWeNW1KPrhinJP+f?=
 =?us-ascii?Q?YGkB9gzH1HXgupdyZP/t6nNP/xJZxzXa1hf854zihX9YR6DZUwaWkHl6iGZU?=
 =?us-ascii?Q?QMIMcJiqbJSbroYLg445z1QXKYGW1ytHAOsevU9SO+rQrDqJMks2CAADYdWn?=
 =?us-ascii?Q?z6J8217ntKBSR5eFVCNF1+6PH0magFGJYqCmV5y/kPQEncHf8Cfl3JTbxUbt?=
 =?us-ascii?Q?6f26ceYMTUfcizMPb8f6HE1omhIXSeZJRnoL0mbozpCWYYd04RgJgQbPA1gU?=
 =?us-ascii?Q?3G4fyqYdzqToefRJ4h+MzqbADgVow6FMQAHZbz83AGRwropND408u7KdFOSS?=
 =?us-ascii?Q?mvw/a+LliYmNThHMLIoJGJfTP9V72Z7LXEwrN/06io2WM0Mj8t9MVV6NuzUK?=
 =?us-ascii?Q?35DO+X2kyGkkeg7jR62l7L+9rWJqP7DHU4vXP7rnBJkCUh9VU6Z01PIYEtdL?=
 =?us-ascii?Q?5ZsseiB8HsIumQtSF4czDfp9cN71g43BvnVw3RWDwO6YM59PaHi57iRT4oKI?=
 =?us-ascii?Q?Y7u50IH3xhxLTur50P0jiyf0lPWRQfQxWttHSZRPb4tvozNXhIewCYIiW624?=
 =?us-ascii?Q?uCso8aVsSkLG2xZFgLLR4uYh5L9pWZohrGX7tCumwnOIEtYG2uvKHbePTWad?=
 =?us-ascii?Q?9CRdb2VJjTTJPOVomhHfuns7f3kpS9xPaKq22uzYspI0CR9KdlRUUnGvS9t4?=
 =?us-ascii?Q?ml/QTKrgWBRLlgSWfhKmBJC+aKdTdzsaaapqd62OmjC6F8FC+V6+3rTRylp9?=
 =?us-ascii?Q?3bF4Ak3FnrkS+ZppFq7l0hs0Z7apQTwXVEt1HFO7jt3l2iU39pG4JFDe+/oD?=
 =?us-ascii?Q?8Km6GoOfcOGf41hKktGouPAmYxCR8ZOkOG4AwEGBenKUqCzgqJASmTdXjMYY?=
 =?us-ascii?Q?Ghf9sXWKLlO4qqR7KOgjuJngvSRa6BhHVQ6pH9yilG/0SJGOKOkP3yH4cmXp?=
 =?us-ascii?Q?0umoarnVclkIveiovpt4GXcpJGQBsm9JDsfElgTxt2o6BsJ4MASNU2aGxuyB?=
 =?us-ascii?Q?vzUKZ+6KiDLXxJKSonD4jU+im9/3iZOUys/88hoWHpOYDN5A+EczEKcnvFPa?=
 =?us-ascii?Q?Rnq1oiWj837Vyb6TYLruTekSrZKjaQHgZ1JTjTN1p1WZCHBq6fIOXgUxKAvi?=
 =?us-ascii?Q?2yALtWqNWQJn0QrJJFPg25UqimX+GvIL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:00:49.8014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af07f135-7d5e-4d74-d4c3-08dd182ffa5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

Improve RAS ACA code to avoid binding unsupported RAS blocks,
thus avoiding invalid ACA Bank to ACA Bank cache,
and also reduce system memory consumption.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index db081618e85c..54426e04c7bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1302,6 +1302,9 @@ int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
 	if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
 		return 0;
 
+	if (!amdgpu_ras_is_supported(adev, blk))
+		return 0;
+
 	obj = get_ras_manager(adev, blk);
 	if (!obj)
 		return -EINVAL;
@@ -1313,6 +1316,9 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 {
 	struct ras_manager *obj;
 
+	if (!amdgpu_ras_is_supported(adev, blk))
+		return 0;
+
 	obj = get_ras_manager(adev, blk);
 	if (!obj)
 		return -EINVAL;
-- 
2.34.1

