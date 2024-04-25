Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B08C19F4E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 19:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71A411A842;
	Thu, 25 Apr 2024 19:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wufk2Zuf";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0997C11A840
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 19:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibz+ZIHRNodIrdwuZiDluxyBR7y3qrfc5k3cYYzkK2mj5Cdhg8/qE2QZw3BZifLKPcJ7SfU0E3kKOcIQ+PI7al8kAb7eMjY9qB56Vv0k4C4Z1Sf6TzpYDA1+4NkJvLuUeVZ+OTQy/J5n1n1Z1uSApriih40qSf3F1JwzWjmBqdIRg34dxA2UtQnih1Vj3nK2L/3N0uRzApBW3/hJaDYVoE8UaJIS0dP6IejjBohswOgl3WReadC6Yzw6UFHW2Jv8qMLhMYtjzRfI0n8UQ6M1MApFv5rAGcnocweO0zCaRBSG8y2Kfwxd54XmsmwkrM+2WPZ3gbwAHr5dUG5hFeqrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XzhCCrY7REHJQPBR6pZGwXSIXJZXjDBOhzN5uYWN9w=;
 b=hZqoZNvbHe0F2C9h3PXmmdntMP4Nz/JabFWqb3bhTSHzOq5Vp85aWiHGSLPtMZi4lzP2S9qEXhnf8lCqCOl7yoBgmuaDcqBvA63Bz7IDY0eC8svFr27W/rurqtMhnqyxYtnoT9gu3fAjAxQrbI8syXcVE4zeMNt/YEQaMwxFLhQosGQaAaOlpgG7DfIg41LIGb1qrifx8pBbGvFh6oGA799N/udX8mXA8aU3JLPPaX+RTa3delKEi0xWafV9cUOkM2EaR85wqHxQY/2L0K0ZtO5bwik7vHVW3PccCHyqEXNd9GXkUhnFkg+4jGG/G3jwtZNYZm39bsynlIny5e3rJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XzhCCrY7REHJQPBR6pZGwXSIXJZXjDBOhzN5uYWN9w=;
 b=wufk2Zuf0gqgRRF/tpUBrXspEp7teoWxh4XNi5KEOckDd3DWNQ+w7UvOIxhWEG1iEboJHpi/MXrqGfD9egz7s438tfHgGJyrcIkRxBEZtP1UIFrpA337/UUC6nW69ZphPikVgXm9dGxM2pCdjFPRIo6wmeMtypocXkKNxyNiqYs=
Received: from PR0P264CA0200.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::20)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 19:49:39 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10a6:100:1f:cafe::f3) by PR0P264CA0200.outlook.office365.com
 (2603:10a6:100:1f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 19:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 19:49:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 14:49:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/discovery: Add common soc24 ip block
Date: Thu, 25 Apr 2024 15:49:10 -0400
Message-ID: <20240425194910.2783289-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425194910.2783289-1-alexander.deucher@amd.com>
References: <20240425194910.2783289-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 340414f5-2c06-4097-63df-08dc6560d6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TMXbAQJiQU7j4b6+gfIvtJXL0XJlOuCzoOgsXAnDZyyBzZ+fKhnCdt559q2W?=
 =?us-ascii?Q?I5kBgdVHRBwr+vHkyedMIXuEU2BTJAQH5WbPLr+f4nIdoIIy9LNE5nAm68la?=
 =?us-ascii?Q?rIFxHXStl0ZBqBNzBC8aUiOeZbubThKVj169+22G2oTr9BQxetRHmFLBeJFX?=
 =?us-ascii?Q?F8YOFkP24d5noiTG1YXM6BA17qMUw8GPts34+Ypmg0GsjRkuzmbzUgOel+ma?=
 =?us-ascii?Q?YTD5aUpfhNhPvT25vtJY9UdO5NnNXpwmqYKBG8VYH5VDI30Ut4aiWgU4FxAq?=
 =?us-ascii?Q?QEnyOyCOC7lO5KIuniz7QgZAZTSZY7tCTTZ7eFXPKHsvEp81WVmlqR9F1u9z?=
 =?us-ascii?Q?4hQzdnDp7/uTiFn5yedvygveQGhPVupqWBBMQQ5XmelWhqnq6QhGxAK+7+Z3?=
 =?us-ascii?Q?fJ/pOOp1nBWXHhtQHkNzVoSypSefHGz7rN/NZ3oisEn+MclEbvVs9DlPWSrw?=
 =?us-ascii?Q?BLGGAkJxBkdkKk7JsNHzW86hb21VVPEHtxWN70MPWhGmYBCWJP27Gn+j69PW?=
 =?us-ascii?Q?curcG0bR8CXkTjiVB6SuGUB2t5AA4Z2z5s8dBMJgtNUFUYJ8y+eeBxz/EuFK?=
 =?us-ascii?Q?texEA+MnQGuAzM3Y3tLshLZ+ItRTtl7VEqtLExMdI+L+8QZq1EtP9JJef4Eo?=
 =?us-ascii?Q?ZfyoqJjRbjPrEzf+RxuHg/WbR3DWWBl5Py9pV5s/pUVFRWj/IreuNYuxkQCZ?=
 =?us-ascii?Q?CUly0o/OJO+0IkkaKFrVl1lXuGhLgMC+JdYj0Nri6uAotY2Ho2GlXHfDabJS?=
 =?us-ascii?Q?/+fXTek8SRO8QLpcLCPSY4yQYbV+dFGZ+7qMLWuJu8Nr7VhJduXgV3yly6jd?=
 =?us-ascii?Q?rYXudIAqRmqgBJxnLT4rqWpnbPZ3xEebh45DBppEiz/DYtnvYg49PpTaKIae?=
 =?us-ascii?Q?Yhn/UqsIqydWybKcbDb8V8dZ+oz/cqY3c05CSCbmf50+t3gQGkrsbuOwEt/b?=
 =?us-ascii?Q?cyq8WJx9MdMjfCwG/+nx+eozo45vZQnDTFvzXkzwK+jwYv8orTvmL11jrZAD?=
 =?us-ascii?Q?vPAFJ7mjMu11h7IjRRxMSokIaL9vaBTGO9vddEbml6rQ5ypQAXKa+4bhJYfB?=
 =?us-ascii?Q?tzbC4k6bG1uVLxTBqVrGaXSiPeL7s8SnYW9TEukYqcFPySge3YBUtsAZJsio?=
 =?us-ascii?Q?3aTQz0LaMPmkLKO8brPms5epmK3tiZm6n0OPN/q1n1Knl7065qkwnJwjk4TT?=
 =?us-ascii?Q?1X4ZBOHjEkjTGNnd/e3jMzJvCEqhY8dHaWHLp7eytuxNYhB1XnlmhymdnC6l?=
 =?us-ascii?Q?7wRyAC6np3G2UYDii2MAXqT7Jz6JNswH5swepvR+btwluF0COp4HMBy87gyL?=
 =?us-ascii?Q?yW1rtcdfe4qiPBkVaExk+MNoOUebmyxu+tJ2RM4DxFDpdmbxZOD5+QCIvn02?=
 =?us-ascii?Q?lJdkV28=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:49:37.6159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340414f5-2c06-4097-63df-08dc6560d6eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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

From: Likun Gao <Likun.Gao@amd.com>

Add common soc24 ip block.

v2: squash in updates (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0e31bdb4b7cb..79b43e4bf7c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -68,6 +68,7 @@
 #include "hdp_v7_0.h"
 #include "nv.h"
 #include "soc21.h"
+#include "soc24.h"
 #include "navi10_ih.h"
 #include "ih_v6_0.h"
 #include "ih_v6_1.h"
@@ -1700,6 +1701,10 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 1):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		amdgpu_device_ip_block_add(adev, &soc24_common_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add common ip block(GC_HWIP:0x%x)\n",
-- 
2.44.0

