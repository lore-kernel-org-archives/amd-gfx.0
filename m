Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF1ECA0EEB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 08:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C804310E089;
	Thu, 21 Aug 2025 08:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pMlztxqW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C45D10E089
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 08:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZzGmqfY107u0+1fmMFmAaMN8dg5t5oW5bic4reZGu1VpurH3YZVDLLFZmB0czO1zpp2xNhK1S9uFyRW2tj5kLIRpJuNp8VSBKrZ+nM4Y0AbvSss1cAt9FoW9lTgALvUuXOvcnVzBw7VPJtOWGaROGTiKJ3JFoig5m5gcD7aqDeZ9e5CMDiD6NUo2SCrj5NegiuuENrcqwxzW6je4ScS2C/vX/i5oSbABPCnZbBIP0sXMYtwySIBSBtfFb+LLI9v+MLbkxah8RAq+pOqo6ylvNsFBBeFowTbiLR/d6tVShjTsdYckFA/eKol5vxAL8fLgOxLBvmgBGvKBnT62WXaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEfpUblrGYW0nYSzmgRXd880EedyxATUQxW3mM+J8L8=;
 b=PxTKqsLbmTmidr5/XXN6BBsJ0ItIkl3rNvhjI0f0rG28Z9ClJrsvJ2nFnaehpC9sM0m8Wq27Y8oN1GHelbweVyog8bblbOa3qvf0Y2yTcC+QJTqfYgp14i8fI26gc4coOAr+sPOqwEPWwG/vw1DVQxTS7eRwh85vCeJPXO9cCTs9LOJnQ2sJpDXnnALgIkL+GWX0bkdxJdvIIl6xgsfwI26NySgQr7yX5ggA2p415QmGPjjD9BhXKOpz+N0oE9bOxnL5qYpZsESJZ7R5g21hn2r9jgZJTEZvUDkjY9XIk0m/Eyol0wkjBXrfwKcAQVH+wHipde1AN1bXBtCUMvpNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEfpUblrGYW0nYSzmgRXd880EedyxATUQxW3mM+J8L8=;
 b=pMlztxqWtMdgIfGnmE6g/t1tp3zHRTdgHKR6DvcYtXPlUyNN32InBJX4Kwy/KXRBS824vPT8m2doWhtTDEepGq0u8hSu0hGzG/8Lk6K52PHL0znig6/ajrQsXpqOAK2C8EimlpgkTj0wlP1YzP4tRRPJzBXL8mLs2G176SK09/8=
Received: from MN2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:208:d4::40)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 08:32:30 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::7a) by MN2PR04CA0027.outlook.office365.com
 (2603:10b6:208:d4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 08:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 08:32:30 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 03:32:27 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Add support for dpc to the product
Date: Thu, 21 Aug 2025 16:32:19 +0800
Message-ID: <20250821083219.337900-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 49230fdc-469d-41ea-71cc-08dde08d44a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VlzMZIuMubm40k3JxPtwBOr715g29VJ9gJxG4g+OT/IbBmYCTxk1Z14QK8ng?=
 =?us-ascii?Q?7VsTEApD5A6I2+xU2VBqOoV5Lpm9VeQQelU9aELzeLSkkIOn7cCw2SYaI1Tr?=
 =?us-ascii?Q?J5jRIAM3NAoUwh+sXqv4MDrdFrJyl9SHccVLydkh5cOGD8cwZHlDkkBEfPSq?=
 =?us-ascii?Q?lh3JKRmlGZ9fncLZG6Ei7CT8d0WWOWlUzUEkQmH9GGOcFNk+jxb3P6U5MTAD?=
 =?us-ascii?Q?m2GKWiQKom2HwyDhLcHU4G/u6npSWPGC77PlhXmZmhnZ6a4JmWzuS4mpfybV?=
 =?us-ascii?Q?d0QPXltjLoWO5qYW2FIiDREorZ5BuxXcfeZ287WGZxtJsHr9Tp3awJd6K+BD?=
 =?us-ascii?Q?8HwDVuk8zlUWM9C+dAIqosNa77hYZyO49zBB2QkeU3GknM6T4i5Vk/hslL59?=
 =?us-ascii?Q?/fsnyMHvcIiSuXqJtQFsxS2LumVcEdN5exZwgiGipC8/sgXQCFbaLqoG20ts?=
 =?us-ascii?Q?S7etveKtDqpvD6P20zbHYg6Hk+efIPxkhjgUHHE+oBZx8NadwoNNr2/qgprG?=
 =?us-ascii?Q?WBbuPhR5jQkNXNGo+Bn0ZkRrmUUD2GB2g5NUcmV6BppTGW/JTrf3ZLRJ5ap1?=
 =?us-ascii?Q?i+YLEOAD6tSeQuU9pc3kiCJOu7X5wy3Fqshn5z399V8zY0Jp0NvSGIW1lkIq?=
 =?us-ascii?Q?ceS/CU4SzEoZHAFTP/Ad/sb5yePJfIpyb1dAVE6hXXNW9Ir+sfkyMVI3qOtc?=
 =?us-ascii?Q?kZ89PnYd9kl8z6uuqpVNE9zqeCJIo8/ErAYwTz8Vll2wB4paZ5tLQ4av2+HC?=
 =?us-ascii?Q?UhxDxejWxaRfRyRzRJXDYsSD/wgEAQswMEsOM9FzcxiSNzuh7Hz07bLHdYmd?=
 =?us-ascii?Q?YIPU3eauHInmEdp2xNPoC/QDxBG6VjbvGLUh7VcFaXE7+V8yUiY1TfQ8lDtr?=
 =?us-ascii?Q?MrKgN+VRUFiTXpey8ElVJorPhyaDYLPvmVuhbNLj/xYJiZUtZ5nNOm/Ule0v?=
 =?us-ascii?Q?Hbk3W7rpbrPz4dT7/yUSX9ggk01/LCB30Ev/zJ+if7kfEEJi95Tv+pYVxvoc?=
 =?us-ascii?Q?qdcKr/lOtFKtDdJTFQ/X4nwVfWwd7sfFdCW9o62i3qgtsktNhchLvwfxkVP/?=
 =?us-ascii?Q?hH+hn2+Z/Y3vbfZdMoD3cTwSIWP7wZaBseUDnfHUbhdH1wLcVBhvHIsc/YV8?=
 =?us-ascii?Q?CKETFaKNIF2pewZn8uqM6cKVbVLEX4mo+LHX5ksw+4IZfjIwazileKKwZ1IG?=
 =?us-ascii?Q?IdT56M5KUfpNCgMtulGWJDEBdFq4gN3w+RnuZgmLBYENAtZhzCsQGKrDkqwe?=
 =?us-ascii?Q?WWrRJVUslwvAgFyzxWMriijg/SQP4pHLXZvHkEZZCnKYDkCvugg4RmpamBbR?=
 =?us-ascii?Q?gFCj6kbJpIcKUy040NVOVsxvAO7Y+7KorswtSk63Rr+LR3vgRv+LJtIFqZdt?=
 =?us-ascii?Q?FFH0nP/qOa8hwnw10rM+T6PHGxw8euJJg7BqdrRb+We1IG5K367NVsxYddkO?=
 =?us-ascii?Q?RzV/6No4modAJ3/YQzvg/kjqF3tT0nmjulPmDSjXdQqM8RgNjTnZlrC2pudV?=
 =?us-ascii?Q?3xQrI+WN6cczBF35Vq/b1I5IJWgiF4ekgPRh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:32:30.2548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49230fdc-469d-41ea-71cc-08dde08d44a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
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

Add support for dpc to the product

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a4be035fff30..d65c912d2408 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3135,7 +3135,7 @@ static inline bool smu_v13_0_6_is_link_reset_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int var = (adev->pdev->device & 0xF);
 
-	if (var == 0x1 || var == 0x0)
+	if (var == 0x0 || var == 0x1 || var == 0x3)
 		return true;
 
 	return false;
-- 
2.34.1

