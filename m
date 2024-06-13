Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FE9C27C4F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 06:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F7B10E924;
	Thu, 13 Jun 2024 06:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nCXyVWCo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D1210E924
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 06:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfGv5aQcUFmEuQTufWbgLRFP7ANTEyzItdC84a45d4vnwMgROvKowNQUm9zdTSkq3kBW9KYm55mc+Xmk8vbfEAwyV1V72qI3I4JW3/IgcWJ+JYuR0E/fQWbjegq4lhc8mkQTBwaosD0J0K4MsFzfBpEGVoTcWmXlUrhWydbpwXuvONnhGhgM8DMxjXcP70PUnGChF1AdsroJ0R8+ijVttmzhxOFu23W+RUkClxmTc7JPQ6szxYEyhylCowbBY6T3jcP61XA7fHtc35c1i32GIVp+eiSb8m4Fi8/CSZleoBIn2DeTy33zyC0SAFhobgf1q5cgWyygX+y+NpKJiVnbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVTYV+SaLfY/IOCwjZl/2vbFsucwqC+NbxLlO+Ha7V8=;
 b=EmoFKjnxrl0j3DRf7nbDtfiMYBKIXhMmOUkcXYdQeD03Ho9ImjmnSfSAIeWcLjUrTq4iilGYWEjV6c0bUTqhIg2nH0yKtSjkdS57vGMY089EFPUV8a4xBOscBP2gB3BDczdUFhYwI9tb29Eqhp5DtGltptbTDPVwPniBh8Le/WKIKNHmgm+eTVjZOShElGJM52P2g4PxWy6Xa5hLG5awOv+rTTZIc9uUIhKIi8qoidTpCaJ8/Ak+VnMAkpGfUenOZip8IZGshEBBnEKsb6eRjpSGXqpkpifLSSd7HxrVNsIzMPO7zPrFfMfHdtzggRL4O1ll0Rya6R1o+aPHT2PKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVTYV+SaLfY/IOCwjZl/2vbFsucwqC+NbxLlO+Ha7V8=;
 b=nCXyVWCoiiultH0KHs6ndFpYd/SBWdCZzjFBVS+CB5atkI32/119l5qI7SE5Gmilst2eneoJcdks8k7auccs4ch4cJzkUnd8bn+a2wV6dlOgil74hVKBdSrliayvAmn6pZ7Ku+rxjv9znX8/TXWzCoySN/4iznusW5WwSQOFNjM=
Received: from BN9PR03CA0636.namprd03.prod.outlook.com (2603:10b6:408:13b::11)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Thu, 13 Jun
 2024 06:57:38 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::d9) by BN9PR03CA0636.outlook.office365.com
 (2603:10b6:408:13b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 06:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 06:57:37 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 01:57:35 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdkfd: use mode1 reset for RAS poison consumption
Date: Thu, 13 Jun 2024 14:57:26 +0800
Message-ID: <20240613065726.30129-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 846c4db1-5a59-4a63-c019-08dc8b761c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|36860700007|1800799018|82310400020|376008; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U6/Th1pkCEboApP/tOhf1CPF/Eh7ObupixMjpZA2hW3pxYrbXCZXkRc0oqgt?=
 =?us-ascii?Q?eHiSMtBF/U6ykbATxxI1wQ379AYpd2fVxhJTXuXmhWCvZrQq1Zl570c91Uq6?=
 =?us-ascii?Q?ouOS496CYcQ6ckLrzkpAnHDruGf+T1Fyru5W5XvpINBEM0py+32MTyIk610n?=
 =?us-ascii?Q?zJf+pEm78vnDj9LvGFLLLOCEM0DQMfR1nzB6mp9SzQ332/74GIvdkAOAjaHg?=
 =?us-ascii?Q?ITRSVAlLsSoQu7dUvZMccmkP9ThIc2oYEu8RM4mSmHKVkyQUA76oIszu2Wqc?=
 =?us-ascii?Q?M7CAsEF0uFg41XgkxQE76kWqEQtVJ9kZqmreDrjup812494rKZhC1w9ueTQV?=
 =?us-ascii?Q?zkMXqMqgmIfSYFuvQvW5Picdgy6TZhWN5mZSDrG5K1tf9kYj5j4BAolB19zP?=
 =?us-ascii?Q?x2tI40HYbRr1+gBYix3k8LabyIxKHGAgEDcY3tocdGRy6iomK3iFbHgb5UGG?=
 =?us-ascii?Q?NuSHMaXgou441a+hDE0ueQJ9deASBi/XJveTKpIV3IztD58ZmSSxntKlsz3x?=
 =?us-ascii?Q?4hJUmXzC0txeyaR9JJMy7zV/DrgyJle64WvYSZS1pyvk0aM880gLGxSWvJcl?=
 =?us-ascii?Q?NHxkUnmh+WU08vPrmmnuZe12VMbK49AywUeEvfbdINMKoTHkPycpAB7JT76N?=
 =?us-ascii?Q?EutGQMzhfiuzvZaOrO3yXLSVIDgM6nxHATxkGxAdeXxJRfA6s7Rf2JgDS02O?=
 =?us-ascii?Q?0MZScAzg44LuwAcLuGQxQ4rnEePsWrxcsYI6Ym2gJvf2mklSaHQH/kSDLPfe?=
 =?us-ascii?Q?hOFSF8vYgvU6Q4lpXJ0yJ0fkL4BDVHWrH8V/nbEVsXoMgd3iFXlj2/NZGIFH?=
 =?us-ascii?Q?qUhoaUaAYLYiHWZ/5gHJ6pfkb0l/z+l+kyK4Iin8TRifpqJFlLDnoG31K2bw?=
 =?us-ascii?Q?u3lCThh24KF4JvPtNJAHeJQqg0UaZeOW2WuTSgJsykY/QHolS0sxHUAM5OZO?=
 =?us-ascii?Q?sZK+61+oUbFWJyMkZ5o55vqPeJ/HR5HEIFQ4rj1/RIMuut/LRr/JoKIgh8BQ?=
 =?us-ascii?Q?glbHQxjggiVxAruIldHc+QvEXoNkaN+c87sXR4b9MtR7rdN/RrORvl+8aUWz?=
 =?us-ascii?Q?UxBekxFWnLgF+GIVl/07wXBvhzaYsk+u+FN8avfmIIVUECUB6a3snt+Hybr1?=
 =?us-ascii?Q?OVIhQKmbaC78Y1+kBom+uF7mdqZx/Ne8mHzyPdynk4Hy/6pSDP15aCuOWq22?=
 =?us-ascii?Q?zbZH14v9AcO7ofuYqvwvtZDZpstpwlzv/YCwqYr8IZwZjJoywyPRH8xewz3f?=
 =?us-ascii?Q?79D+/zaKxraI4fJ4OthSbFlIlOgp5BolX46VgBESaEAcAgo/HvSg0CoC5Jcc?=
 =?us-ascii?Q?jXPsdx6CZKDtYrLusdWjTAaEMG6DRg3K9V7VBYlj2YHrpVmrUU5Lf7nSTVjt?=
 =?us-ascii?Q?NoBvkZi+E7csY3ZBQpUmQLJdzEOHWzSfjLmcsXy6/duGfR8xOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(36860700007)(1800799018)(82310400020)(376008); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 06:57:37.5903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846c4db1-5a59-4a63-c019-08dc8b761c62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

Per FW requirement, replace mode2 with mode1.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e1c21d250611..78dde62fb04a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -164,7 +164,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
 		block = AMDGPU_RAS_BLOCK__GFX;
-		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		break;
 	case SOC15_IH_CLIENTID_VMC:
 	case SOC15_IH_CLIENTID_VMC1:
@@ -177,7 +177,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
 		block = AMDGPU_RAS_BLOCK__SDMA;
-		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		break;
 	default:
 		dev_warn(dev->adev->dev,
-- 
2.34.1

