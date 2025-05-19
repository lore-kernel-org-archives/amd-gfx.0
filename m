Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE0AC3ABDD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 19:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E270710E22B;
	Mon, 19 May 2025 19:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZlBt9fZt";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B1110E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 19:53:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQU5gKuLwT53KyN20qsWS4odml2ZtTrV6RElvPo118hoGLO386EV6Lbv8wDbWEywrs2XTwIWfdloZ+h5FVNaW6NhObOYCnkQS9mjZObM4zJ7M9ZeNAY4b3j8a2fKFlpj/uvHgxbjRz+0NvKlspN0ypiqncnJq7XabceAUBsvg4HbESI0fM6C6q45FJaaEcOGcgO33YiAXXLWXVtcnlZBvC7vqjymZ8KUKWXKQ6Mo0tMnJtyMaJX4JqCfNF9itDhy/jlp9v53nnD4hQTuTvbbmPZT9QZMNnZmvykX1pmvsfxgM/g/L7wT4NiaLxixqU71L7IT5YZfkU/RpuNF5qKUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t02HtXRSFRRNAVVac7Qk5LbjR7wL1kqU/YUAtOQueY=;
 b=mZyEdDHdNTESE9z148ZA64YbaaGHRBJOYc3X3delX0RTmPm3drWoY0m1wjmrOoC4bjV4ntaCnlopxyVcZGo+omHbOqH7ZH2um5NAg/UhXZjDQKc9r6WlG4bOZPJP/ugnDD+iZE/J7RFEZeWN8Qx1JLGHIw8tmyveqe34M90V6zgqIKh8sNxMjH9kJqUFE7H3jlyTi54BUZk1JiLre+qqdNFv4Cr7EiUNfRHecCIQTYxrDxHtEgwxLAJfjz1ir11vnNyI1KxjDdy0SeFUqGeYIIV2O90BDaDGM7dg8Y/MULw5ojylML6j0mN3ezmGNTOvi0HBw16KR0qL3TAS5NZY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t02HtXRSFRRNAVVac7Qk5LbjR7wL1kqU/YUAtOQueY=;
 b=ZlBt9fZt2HmN6n1pJuJZBOA7y9pLaLS57pXJxe5IvdSlZQ8/Cr7+j9icpxNKHt5X0Ayt4rKCTRkzmtrzhZ2vOYffO5LQDYXoSH39sF3XRJNPeV8v+2FzZkfDt7Ef7Jfi2Yt/bTt6U3XupeP4e9x4zo/bYU59bV+ADbWNib3thTs=
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 19:53:49 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::a6) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 19:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 19:53:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 14:53:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes: add missing locking in helper functions
Date: Mon, 19 May 2025 15:53:27 -0400
Message-ID: <20250519195328.82276-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1a43d2-7036-46d4-d463-08dd970edf58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4KBnXEm8b9TNQRaBpmlZzR7k2I6f6nRe4BuZ0QPjQQfCNCN6VzG4CLBti60A?=
 =?us-ascii?Q?YOjoJDTU/NngZUZhw8omyBBqQ10IQRUoRqWcsdWIqMamh22xfZsy511YlLXj?=
 =?us-ascii?Q?VX/TYANdV+VZyS50SPQtIWfEYG7KT5cOIffAYIifhRX2DAhZyFdwTivLVtlj?=
 =?us-ascii?Q?Tkp0YDRi9KrGICSF+/pBY82iuFK681hEoC/Qb+wpJmJOYjxPvwRVP4EaLVFE?=
 =?us-ascii?Q?WxIfsxB4oCl7CBm0N4pX8eqigST74rvTqW4QduLgz8q6LsmPdXuAj9vtTsOg?=
 =?us-ascii?Q?6yuqJx/BVlgAro/5g98D3B79sq0Upuek/2ydym1Dl8SMYm7HI5QS8nk/F5+q?=
 =?us-ascii?Q?GXNO4+20X9zb3hXlJsNlYbHRkqAbOdS9GPh9D6xrZNApoBqCIuh40w34dnjD?=
 =?us-ascii?Q?LVsaBG5/zLKRu+iDb9em44cOr9mZ3ICuV7kxdLmZ/KXCdRvMH5Vk4ezl0RtA?=
 =?us-ascii?Q?Hpzw50cEZvvxyWlDG21o3C2LnuZPr/xm/4nj9/Dd6IPRGNZXYbmZgqLvq8bB?=
 =?us-ascii?Q?ETPiSfm0fPOEH1kWX0NGuE9p0oZ9+t6ezgvL0psnLKAY2n1XHtMqr4MEV7mK?=
 =?us-ascii?Q?sWkKkQximperDb1GCqYfIRkMy5XiKbyXc47s198GigXKgcCh84gFAi07g6fd?=
 =?us-ascii?Q?VxqOAwhyt7hYkVsDDtxIoZnSNd8Xb7MKWrnflYt121fL+Qt91VQl6qALHdJK?=
 =?us-ascii?Q?EaumCR5XCr1U/QRfUSdaaOP50SlQQYpbeZ8sEVxDyXnUjHMWSQMMh7Rs3MCG?=
 =?us-ascii?Q?eqCR7J/hS5G5kpyAIQAHqGSF/EuVS366/3f7Nf3qLypi1MqUTvWKZ24ZOT8J?=
 =?us-ascii?Q?41ysB2ROVErtdStzmqLqUTeKiL6f/uAgaYa1khfjnIgpHKYgMFvNgmJL9Jum?=
 =?us-ascii?Q?dgS56s05AbvPt5tTQAgqbEf2h3LCdPr+ATSgJFErTjNNz4SWTG/6HJrEAZx2?=
 =?us-ascii?Q?QdDEFrOom6admkSbMFZ8gdlOwyFJJi58Ojr76x60uSFiwuP1f1jWTKOJFRJx?=
 =?us-ascii?Q?iUEY1f7IJM13QnCdLExnSFiUzQToYfUD7Bx7Mkey1TxWqd9kROtbiPoZhSf0?=
 =?us-ascii?Q?LUkdDZ/JjnP1vtn5Rt4dB3Y1tVK+Pu1FTTUxB24cOnA0VrC7+qfvgm22G2Ad?=
 =?us-ascii?Q?LK+UiP1s9qhVP8O4tet3QkUwekM506x9w2r2ELaM7UlLQV+kZoxRDqfZtyOB?=
 =?us-ascii?Q?Jb6mlCFDcRmre0DLCt7Ve9b7cM8TRfQjCdkgfw3B3wBODZYWVt4gNAwuSXz1?=
 =?us-ascii?Q?UKKdLAfVjUNzMvE4RPXCIQD5skgGMIXUaVQZ4YiBcHctOqVBvBAHinE9m2qk?=
 =?us-ascii?Q?5PH22R4cfUJgNEHwa+aRfqVGB8A7xk5gBjGaQLQKZPfIw0B8d6nNXnxgZ4CC?=
 =?us-ascii?Q?iFjZZtTWvXUJoae4+1g/nDH6ZSMoprtqsijQ7jqCGIEJYZ1/ZYy6MCv+iGm3?=
 =?us-ascii?Q?NWcs/mP2on4iEfgynNE4COgGwv/H+YOpO6wE0xeylOmzYgfA3rYo2Y0VMuCX?=
 =?us-ascii?Q?AkcsQHGeAW7mu7byTDEv+1FI3pKmD/Y5o9x1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 19:53:48.8523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1a43d2-7036-46d4-d463-08dd970edf58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
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

We need to take the MES lock.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index a4f2be39c237f..bf375687613a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -303,7 +303,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 	if (ring == &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
 		queue_input.use_kiq = true;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to map legacy queue\n");
 
@@ -330,7 +332,9 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	if (ring == &adev->mes.ring[AMDGPU_MES_SCHED_PIPE])
 		queue_input.use_kiq = true;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to unmap legacy queue\n");
 
@@ -359,7 +363,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX)
 		queue_input.legacy_gfx = true;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reset legacy queue\n");
 
@@ -389,7 +395,9 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
 	else
@@ -417,7 +425,9 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to write reg (0x%x)\n", reg);
 
@@ -444,7 +454,9 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to reg_write_reg_wait\n");
 
@@ -469,7 +481,9 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to reg_write_reg_wait\n");
 
@@ -700,7 +714,9 @@ static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to change_config.\n");
 
-- 
2.49.0

