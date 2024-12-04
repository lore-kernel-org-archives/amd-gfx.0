Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E49E7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC22910E4D0;
	Wed,  4 Dec 2024 15:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHppjEvg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2372110E4D0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLbuB9NVrqnFjSL1xVvzQPpBwu1wNzYxupUcfnbqagKBAsysf/LgGLDPKvAlzGnCFLqcRfi7FIDjH2TcZWphu6cgzdL1oHA0qpKmfbK07BdxMDi1gVlpEp+cLGosuJqDzrKK7GHpINKwdOTehJz8j3f1N9RoOrAlfE4VzuZD8DIzHBABzfhIGj6pgHGzQ1xHZZ2a7kp0AAEpXZOCN31COCmNmlYcvshbDlvLZvCXYKsKy8Fh5xmEbLV3YakI4hX7ummhmKRmFKrNCl/EjN7OYasLAgTesaexnLy5NV7ByT9rD4St1+o0WWLH3vBTmaFlViutYj4IV/ROoyY1F117JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb5WABpHwARD4v4f7CiBSeYYTXbOQtGrkSIEtcinORg=;
 b=Sz3LuZt0oe04T6hFrryNSVWDe7ajqKu3u18Bg8YywxYWiqCOC4iX/CXCjRZ0xWphrC/r8b6Az6KK9N5vjHHJIPx2w0lo5GXkaMkwXP3KQS4N4EbkeF7qgXeQygzFJIozum5LSpwZ+QayYqPPpfsFmbdQGNPh0w/ep7dxUMVSCGMuM3kzB4lnEnkqhE0nplhMuUlK2W9SuvuoVay7SEq0VoPPjfgs6pmPG6pievmPmS2H02HpU6OdyBYVoh8DLio7tUQFDOE27HM3HXB4ZKxdyXAsuunFbzifZ5ujLVxiLbalbj4AXVX+99v2xjRWzb05xy6uqx/zheNMF4KzbLAZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb5WABpHwARD4v4f7CiBSeYYTXbOQtGrkSIEtcinORg=;
 b=UHppjEvgVSRvrpxXJy00JUJ4eYJP1TgzdCaZqTSwLllaSIjwiVFu5gWko/1dHCvnh6pqK9ZrdVssI9g9rqJVASCUTLjpkngwnGjOVq/8SiVmWbCEQuMa0BG2TywUlA4wwS5XZut0LD6xGkJIvEKiVTV+dSh3bp541CG3zvPELUI=
Received: from DS7PR03CA0152.namprd03.prod.outlook.com (2603:10b6:5:3b2::7) by
 PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 15:11:04 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::df) by DS7PR03CA0152.outlook.office365.com
 (2603:10b6:5:3b2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Wed,
 4 Dec 2024 15:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:11:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:11:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Init mmhub v1_8_1 ras func
Date: Wed, 4 Dec 2024 10:10:50 -0500
Message-ID: <20241204151050.3426018-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5892ffed-d30b-4407-8271-08dd1475deb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2l2ZhZ1IwnlxoMcr3/fBAog/KMUB68yLKsbXnux4O/wAIq7kbGOzdatujRHs?=
 =?us-ascii?Q?EQm3yzY55LRhk6KhxPYseTI+l1J8KWm6Ri/rjLxoCP0p2wCSzh9z4hO/cX7V?=
 =?us-ascii?Q?zIFxZuOmEKBN9ffiV/Msf261UD2oPXzEsSNIt0I4sCW5FLoAA8Y36NA02oCL?=
 =?us-ascii?Q?3lMa20xKDnBR0Bc2phdvFjs0ESwAFUnPh4yoglDt5rQTpPD0SC7ZHU2aCA1v?=
 =?us-ascii?Q?cPx3oGYr5GMmS3bz8OBr/oiET1djdXsDqzGDR9wmCi2FE3dWnaJwaAnt2kFy?=
 =?us-ascii?Q?GKDDosH2SxiuYmhNSl5eCjO9Vi4J5FCtfkun1l9b9KEr0od/1EzzMhnxq4Nn?=
 =?us-ascii?Q?x0j02UPvvdFXQ4rtvxMZTqAg5l1qRfqg08i1bNkSlXNW+zwR1KCrANLVP0mQ?=
 =?us-ascii?Q?AvWwx4VgY4kgWYSX7drL3uxC7tULy4ui+kCJ15MUBgbANmCVYZEtdA267dSa?=
 =?us-ascii?Q?qubAe13ZYdVElZZudZasOlpzi7cK4bmpOMBcxo3MS3JqyJ5a0JkTaMF+ZSPC?=
 =?us-ascii?Q?xrLqw189lwHpI8+SBG6LQhYcLrlhYQFt5YtP7QbtFToP1iUidf/uFiJRtWBf?=
 =?us-ascii?Q?VLIYoFzzgNREMknXWXT7AywesKqIbTXS8+OC8s/aL9h6vwbeoz29BNMujGN9?=
 =?us-ascii?Q?9PHCCxNok+rYh1XJkETR7EVkp+RbBBPFB46GxrwdIbUkkqj5efEezhOMcS3Q?=
 =?us-ascii?Q?YI1cQM8ugnAhz0mPsj7/Hqet64StC7TcrFMUOcRxiREABSzn1Qo13M+pkVOC?=
 =?us-ascii?Q?xOVOhpWHn3sAXYNbFPCMn/979QowKN/h/VztbLcoaw2dT5h3fzomwSdACa7b?=
 =?us-ascii?Q?iY5YO00M1gpWW8hEG5eTujegVLGghs1rUrwZSwdDonoBmo9Bed+Tku3HMUNd?=
 =?us-ascii?Q?K90R3ZsWGwvrp8cBQAPl5wjZob5B2WtkvROcUmWZtTVWK4ZfdT9TcXDzJ3W3?=
 =?us-ascii?Q?IpUDY0SEJEpQ1kKsWqvx5UWgszGttCdf7GRdR1Go7QzqU2eRQb0ea8CNM22z?=
 =?us-ascii?Q?psD8hI3ho+Ih5CVAtIXlSoF6X/8g60GMSLRhmoZg1U4UbTV7RHWbtOj60s2J?=
 =?us-ascii?Q?veEVbkP70OI6Plf8UWFHkcvi8AFmCF9cmpcJHAkshJdNreu9L0XHr9YJqApX?=
 =?us-ascii?Q?qsalwegM8QxqWMFdWv2buOjaON2azTRUyJW1J+n9AgT4jRA96x+HxZWBPskm?=
 =?us-ascii?Q?/a2ss2AeUgIYrXa9ziAyeJKD1aaJ1waWf5ZaLwhi/YAdmyxIQYGgiu5EYMPI?=
 =?us-ascii?Q?e39Qnfh3aPXeDoQv90bNwLkAxASx3gYiDZTytri2HIC09NBXniLWbqd9TkJn?=
 =?us-ascii?Q?UfEFgrMIyUYn1C7Y1L4OyKvIu51Gn8WlzH7Fp8TEZPsF5Qhk4cgJf10qIuXN?=
 =?us-ascii?Q?gcFVVy7aZXwfIgeMN2hn/k72Y8EmU1rWZkKHmUGiCezMn2z3BAVJ5s3DzExc?=
 =?us-ascii?Q?MDmtbxZrXhy2QYLi5oB92m0xGfkEYh8H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:11:03.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5892ffed-d30b-4407-8271-08dd1475deb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

reuse mmhub v1_8 ras functuion

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 39e008e3f0af1..48f1b9cf1f882 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1542,6 +1542,7 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 		adev->mmhub.ras = &mmhub_v1_7_ras;
 		break;
 	case IP_VERSION(1, 8, 0):
+	case IP_VERSION(1, 8, 1):
 		adev->mmhub.ras = &mmhub_v1_8_ras;
 		break;
 	default:
-- 
2.47.0

