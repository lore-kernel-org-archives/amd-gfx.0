Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67372C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 21:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA5E10F252;
	Thu,  2 May 2024 21:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q4u3Gjq9";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613D510F252
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 21:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTmZQ3Y+4JxHJZt/93vsHtZOXJ0P6LkoXGoW7iJO+kGW31pRs9p7jTRmFgGGoW874CFnZ5KP0aqAtZJ7rymBACyDbqZHumnJtd72uawEQQ+dMaEPSPEoW0snErCP83FH19w9Fkcu9/mHiySgok5RZGUhm5v2RyVzBOeNGj9A+9tWh8TMVi+YSQzfiuaTGnM+rFmdyTtqqkaskF9mbzXIEZDYn6tnihIq6M0d/pk4jNVd+dhHZR+77IkLrMnCkTWbKGMCoAkJNJ1qZW1dHBL9CjwYxzmXhUX7BMH4SLZQbPzKCmFUIhmIE8vWzUMVPrRxyuY4GcC6lDTZ+5coRO9GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5cKjUiy5DyMEDAasVah20ky+dNFgJa3Z7Pb5nRglnY=;
 b=nPxD2xQ1q+sVkAUa70p8jp1S76oFdd5qwccJYFmbvDHDkTn0YF4wF1NhE8H9tqzhdvM+pN5rXlo+9vnOSykHEQp4BNPMe6DzheCGUuhQiv1MYO+ayVgL//pbEOVWwyWve7S/+TMdqRs0NHfktcnyMTcSkK9nl54m9BLe8LtJ4WSgfFfrTryU3Mdao+d/FUvdwJLMCb1fEZAiG8Pj7DfZniNp/gSf4ji4W2h+BHQGhhtNT/0teDY1QiG7f9Or+XCfDwKfU2VVD4/LW0aNXxT2cJj8efGV7rAJpcKUZig++uvIA6ug5NhbNAarbuw9Pkl9xUanmlKTAQNNUVYRAm3Nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5cKjUiy5DyMEDAasVah20ky+dNFgJa3Z7Pb5nRglnY=;
 b=q4u3Gjq92vazpt0V3C5aZQl1scC+felBH9s0iCYjetFZ4P3ltdfceN/IvkMgpBeA7P0dhzUECem9+bvWyJsw21ot3JihPb5bfK5eni/eg+F1FnNst4r8gCk2s9Q1mDvnHgifZxhCxaqc+jwUYG8uEWZ6PM05Gj3itCbDzI24FGE=
Received: from BN9PR03CA0388.namprd03.prod.outlook.com (2603:10b6:408:f7::33)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 21:42:41 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::ef) by BN9PR03CA0388.outlook.office365.com
 (2603:10b6:408:f7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Thu, 2 May 2024 21:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 21:42:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 16:42:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx11: enable gfx pipe1 hardware support
Date: Thu, 2 May 2024 17:42:25 -0400
Message-ID: <20240502214225.8101-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502214225.8101-1-alexander.deucher@amd.com>
References: <20240502214225.8101-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 9672f84f-10c8-4769-7426-08dc6af0cac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EYRLyjy5wtMnOkLcFuDoz0K0MizfyLNmYHQdqJzeXRcYOvf38iFSi0p5xXlJ?=
 =?us-ascii?Q?aminN/WRD2jKz8G36xBveZGlRy+FydV3f8UsP5BZ9fBz9EGiQa2PDVMYpRTe?=
 =?us-ascii?Q?xuXSjlCuIuGxyM+Nl1P9PAyQlE0r2T6G9ola3LLssE9slIGMDY+AaJyZ0f9+?=
 =?us-ascii?Q?qM5BtfNgYGkrXEehoY8ziaYvqXO0NMLMiDo5WsmDiQmtGSz9diGaginv2B8y?=
 =?us-ascii?Q?f7Vy8sm8QJWZ18hXq5XnD3689U1yC+8N4jM9sXm8tO5PH52U9AlZT+F1ULx9?=
 =?us-ascii?Q?WACbMcTwa2jLF1RqEDCno9Ou8LHuLyTIPPUbWIDUUCGqBTDoHcFjENBP2jnr?=
 =?us-ascii?Q?4iPsP02XP/EBb1zRjh5yfCc4I4RkB1AxVcWXwtg+gwGjooUyrWk+KEmFwEjD?=
 =?us-ascii?Q?GWz1Nv+JG6KjjT7A3guu3oLt80V+JW5F20OjHsjP92kso9mk/+1oCuGhRh5B?=
 =?us-ascii?Q?4fsHh8cdwzG2HhMN88B9CzaqDi/auSye+Q0/8PwtmlR0wyDAb6F728Zf41DD?=
 =?us-ascii?Q?2Q+v45cVA/CHCUG/Qag7VEL87hQgIZqGJKOkaKDa8C/0LUv4I0WYmKF8h1rw?=
 =?us-ascii?Q?Lxf4hk6TTi8NVeCnnU3hOv4MnIxJVfI8Dp3SdoEF58ye/UaKVNSncbsZ3mcj?=
 =?us-ascii?Q?KgZrRku74HY07jzA/oSz5HmdIRBiHjmX4uZaHpzeq8tt2iviTrebBT6+AS20?=
 =?us-ascii?Q?RU0lKlnSZG66WMpzTmUXVWSs3XvBIJbghSP8x3nlZ7HVkkZbSHmAAg6D1VjG?=
 =?us-ascii?Q?0b7/PcphoXPE25mGWf/4gZPVAt3Dafya/HJJqVkYrdq9Wfn5e+JHnZOH0fie?=
 =?us-ascii?Q?b33JonPJpjw99Rq4vQjeoeU0em3MDVIouSfG2phYGHKhGp0j0zWQ2/K/A31m?=
 =?us-ascii?Q?t73xHgzcCR30bXNMGQmSMz2sE6eFJjnfjVrfUg6PzGvmd1r8Tv4dIlTUoA+z?=
 =?us-ascii?Q?YGE0qd8ErxwTSc0jsjLY1b90l3Uy3hnBvBD0qMViVs+Xqms67fUT5lPuVv+w?=
 =?us-ascii?Q?uRMvCFO35NYT37wawKq9pSduUUoo34nDuHhiGfObmpfUOyKxfrXFlzf+PCra?=
 =?us-ascii?Q?EwYep8SGGI0hVtwj7F43AfkHdex6T0doDgtfqwnmERw8uMPvjUwBkCrf9z6z?=
 =?us-ascii?Q?zQvcBNmGUoO8fwtTbWSlaZMlwRbqq5oKW1x0M0k0vLn0soKbfJE8j0ZHDORd?=
 =?us-ascii?Q?U67vB3h1EAt3UWfvtvfeKKdSohNwxnShd219ilMwUKUC81IXV/BeYVzARHaC?=
 =?us-ascii?Q?fu3NSKeGSmAcVNPy6SyIPbuS4+wXYozfJNw389mwdscHtzArpNQFenYs9hlI?=
 =?us-ascii?Q?Ryj0M/FgqRfbHBcoaNM6IByuc3lj+B1GjLeVxnS/nvTLkjMUABNG6xQbpBkM?=
 =?us-ascii?Q?w/igBnxvWIQ5Arcu0aHBytb4p5wh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 21:42:40.6063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9672f84f-10c8-4769-7426-08dc6af0cac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890
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

Enable gfx pipe1 hardware support.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 75157e0196d22..de15abc6a0351 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,7 +50,7 @@
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 
-#define GFX11_NUM_GFX_RINGS		1
+#define GFX11_NUM_GFX_RINGS		2
 #define GFX11_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
@@ -1341,7 +1341,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -1352,7 +1352,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.44.0

