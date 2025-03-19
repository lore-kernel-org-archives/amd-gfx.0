Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B39C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2A310E547;
	Wed, 19 Mar 2025 16:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ml/Pf5US";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9309710E54D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISljLprNSj81ir6oG8VekmRezzel7ZQVMtNDzin0f657roZlS/wXwPOW+6xGis6DfMrRpdjM31e8Maqh772QrWKVM9MPVeL0GJM/vgXYg9+pCNoCQScB8qdlxu1vTW1a1kz81NpJVIbKffmy685YYn5muS2/9hN78S9/2mmAJ+SKaqKoyc9J7XSUHxEurmEI+MuqYBa4DxQGHyEgBq27huta9wxsJi4S+WvutSMvmiX6to0B1tVG66M+ySPAHM0GJUKSqfrc61ItO4IYP7eS/EJpwjZWRwP5Ub8YLSxPpzMtRXE226HgCDEWqf5unffIAmIfqrvHolo74+xx2MBPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsQVCcBOn2gBThsvKIMeq17W1MB5LQ/46QMSKnUkHtE=;
 b=btEYRxMpX95pjasT2ezw6DmLlt62bbcHfGsFp1tk0NfpxvQvQkIr0W8ykzXQ7GiSfnt5BsCMdipX85JYGMhLxvuYzGJY2OXocwfyBWuYYS6o383QAnUGG0+SaKstEh3wGS9CmFHESbZ+evZQ6sevqPHAaE8dh1Ej2IJhf+ipPuQe3RrTXlvRddIAY5MFru1HcoS2MzXaztlpmxBZv2eQCAPOcXlk8m2/46jG8jP6Lh0rHst4Iv0jldM+Kt+uq9OdpFWTd76f/B1W/sFA2l47/zlqNNoSwwNqEnfkDfspT2UN8CTfmM/x5mAnz6lmVM7Rdg4avcnid+CFS+cLIJg4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsQVCcBOn2gBThsvKIMeq17W1MB5LQ/46QMSKnUkHtE=;
 b=Ml/Pf5USzeJr/3iJ1g+MR/PW3+P6zv9ZvOUnWFoVTq1iPZlGeJbj6fxtb4ujs5cf9wCzGhGyNEoIBqA/gjHqcG7JxeY59/F4rWbkwCcHHD43CreJrQRS4iQd8MLU/5LNQsc7PAEP2T97A6e+tgwWea4aC/tQp4/YlunEXIwqsCA=
Received: from CH2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:610:54::11)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:22:43 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::ae) by CH2PR11CA0001.outlook.office365.com
 (2603:10b6:610:54::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 16:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:22:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 11:22:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu/gfx8: fix CSIB handling
Date: Wed, 19 Mar 2025 12:22:22 -0400
Message-ID: <20250319162225.3775315-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319162225.3775315-1-alexander.deucher@amd.com>
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c85990-800e-42e2-a4fc-08dd670246c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s3JO0lwLtpBy9LZTDa6plFvHzaQpilRhEsNx/S3Qjem3I1pFMc+cFgKowRt6?=
 =?us-ascii?Q?sA3IiI7XvB/4HCBppyPkBM2N5R8LccKmlObWothB9kmm+7AR+ZWNIU0URNxs?=
 =?us-ascii?Q?8Lkxp/ZJxD08Iji0SJZoHBMvV2nfJIvZFCJmdk8Dk72pgYn5eOstL+ZP0BlN?=
 =?us-ascii?Q?Rtad4lzOiV5JxGUvfZDNCxMuI02fW2kSSOTWwCp9IJEcwTp4eaeVUxf4aZ/a?=
 =?us-ascii?Q?9U28RLh4NYqb9O/0/7uP89C/d0xfG01j1KmxFMGSqHJOBNc2lMdPC/Jkf4Da?=
 =?us-ascii?Q?U+CJ2HWDdT2VayFbe0aczlYppnWZ0uu2zWLXabcfPXVixQdhIRiOP59Gmkz3?=
 =?us-ascii?Q?b5OOpAH/78yEccPumAyt99vp8pnC6wrpOo+SGwiJWazz2UCevsUY2nneaKN1?=
 =?us-ascii?Q?xcFCb84G+m+hyrTpGDSkDOSpBBrLMVEvo5pw6zpDRX9hPShJ0fIwNrBQ0MYQ?=
 =?us-ascii?Q?7EykCJGlj2Yn0akj5eop486qKDElvr+ATcgTsC2dpNKndJWDoIp4rGc70uY6?=
 =?us-ascii?Q?eKWWfT5S7023owCOyg9dPmGD3o4y7DbAih8IY/njc6qYnUmbXlZzDEaRECrg?=
 =?us-ascii?Q?in1xchy3ehzHuZ8rvAx6TQEAbIsY40OW06HKOkpz3m1XNzIESPBsSWnezQaK?=
 =?us-ascii?Q?XUhLh9X/ZV7LJiRE9JTxdNu3gvdYbxf7Kx/WY+MXQzXuj2n/hm8Li27zhkvX?=
 =?us-ascii?Q?Hy2Of4+rL0C+mHRNbo2fW4pllY9Hd4V4449eLf8Y3hBleyGBKfui+PB3ScZg?=
 =?us-ascii?Q?RckDcEE3L2733qoFs5/2fdyF9O3bxku36kRsgnSFadcQyK6pdkYGLnnxxQm0?=
 =?us-ascii?Q?BJOyBvuY3w98sf2PyVquHcGUEm1UbgkwbPUVkcNelAhGQzSjDQM5mrqzOFQ6?=
 =?us-ascii?Q?cUJKY2vbrWNLwLTlQV5kbDgaCKIkSOVygUlXpfW3KHsQBf9k3ruxWM/YRdlL?=
 =?us-ascii?Q?wkS0nU0MInPzbQYlWQ4wjtNtly++eewcoDC9xMF9sszrXjP2GlSp75rHsvRR?=
 =?us-ascii?Q?QdtV6Lvw9QKcV73KVePknhVlZICtqB1+Wn8477jVQrK5ocFtfHsntcv0Zm2i?=
 =?us-ascii?Q?rTc94VthLf1fnsGbN/8DI/SxAx+ctvN/vkNHWHw08jis+DG26WMtwmATKYuD?=
 =?us-ascii?Q?mVE3+ookk1qaKPxI73mYCqeoUmMc58F4vflaAaHGkurTk2CVXiQ1gTkAt0y9?=
 =?us-ascii?Q?wn2aOl2IP4GLPwTpoacvhgNmrvxHmfq/VdXRNnnWhl3NfC0L9tg7MDliR7DE?=
 =?us-ascii?Q?d2BeD74YkhZrB8aE5d1AxiQUHM1nbwH/G37GwBS1dD84hHFMnU4k0SbKI3U7?=
 =?us-ascii?Q?9QTKkvm13/kwan7p84+XvLSls55q55wtuf4HKRFyYaL2BQERt/nb9Fb1IBF4?=
 =?us-ascii?Q?vq+Ee90SDsTyVnAicglnS5Ll1P2vHjjdC4wWqLFbJEENXZytjYSztUm2Lsmt?=
 =?us-ascii?Q?K7T1ys1AjHRvH6mPJKPatKismsi/qFQrJLcgV9UcjUqhlRKi8UGljA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:22:43.0937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c85990-800e-42e2-a4fc-08dd670246c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
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

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index bfedd487efc53..fc73be4ab0685 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1248,8 +1248,6 @@ static void gfx_v8_0_get_csb_buffer(struct amdgpu_device *adev,
 						PACKET3_SET_CONTEXT_REG_START);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.48.1

