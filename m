Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F9DC3601B
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 09:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21C310E211;
	Thu,  3 Apr 2025 09:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M3Rdux3C";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C04D110E211
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 09:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcLfHzj30RErXLUmSDTEMSVJH6aJ7aqCmUxmYK1wmh4chbfuvLKs7ldkvXmRoW/O9BTc9fHpDyNySi7tH416QkNLa3mwVVTDgHCGV7tbuI7O85bi7cDs4dso/wS4RKzwMa8vWqfwtA1jzmSrq8jNdW0TIweG7zuZlPbqJ0nEYjieaZOkVBQ6+2FsQ4XANxzcn4MzlslR3oqI432p+8LKjLXI5Ul37kquIUhIIzOgx7UxBZ7Ah+ReM+7K8j6atUwjemx9nfSnNe4uot2baD6ToT/3yxr0hPY2f4tExXNSQzhWnn+VQGFGMCJqk83p4+4VA6yLePd4kJziR3CcxeT2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQeyaNucq5o7EWdUQdTWs7JSqjffNwjViXqsAsSRwW0=;
 b=eOvG87KjzgBNvhUJrs46w9oO/MR2GmhEZixeaGh8ooOp5MSD/csHXoqfUmOX2qFMzgao3MiLAvTeWyZp7rDP6PXsJFkKc96at6MYUWWS3HGmY7JrKM05ZRXFePGy2xJCD2EbvOAlYqTCDzY/yu+ywbtndUbEfsXPEDe2JGD5zZy78D3Ife/qg+KuCXU9zXTuAzWIh8SSUhdtrQs0xPnCHwzKJxBSY5QCgPdBwCg6z3ov8dT/F6rGcodgvfovgN2cE+639A6YMvZO29eAgEU4/e2UCtNO02RyjLyQaEH+EOGu8IgNrYU9K2Oj5XnVbIXerc9/sNCrE+khtoQffZJ12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQeyaNucq5o7EWdUQdTWs7JSqjffNwjViXqsAsSRwW0=;
 b=M3Rdux3C0d0btykYOLwUYtUwyikAG7ZC3Zhe6Q92O4xcHVs1BGSdvoy9dw51awFKpOAoyJiTtp1C+E5JPg2vUNOdzJ+mlDdSkv+fZG6V/tb5i7i3ITbS5pRtaCzdCdOZ05MSYPeu1s2bhavMlsPUc0Eih9ZK4ZfTrkW3VtoPk5U=
Received: from BL1PR13CA0264.namprd13.prod.outlook.com (2603:10b6:208:2ba::29)
 by DS5PPF6BCF148B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::652)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 09:44:11 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::34) by BL1PR13CA0264.outlook.office365.com
 (2603:10b6:208:2ba::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22 via Frontend Transport; Thu,
 3 Apr 2025 09:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 09:44:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 04:44:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 04:44:10 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 3 Apr 2025 04:44:03 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable TMZ support for GC 11.0.0
Date: Thu, 3 Apr 2025 17:43:55 +0800
Message-ID: <20250403094355.1866897-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250403094355.1866897-1-jesse.zhang@amd.com>
References: <20250403094355.1866897-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS5PPF6BCF148B6:EE_
X-MS-Office365-Filtering-Correlation-Id: cd893f50-a4b3-4281-a372-08dd72941625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mPHUH7wGu/hm60Jes/H4Q6jkrVpjRY3NuRfBxsDJnR1Ysr+jWvJuyg5zZg7f?=
 =?us-ascii?Q?CLFsB3ro71IW6HQpmPd26BWvPKPOduHLOjMMGciH5kypLz6MM5U08W828Hso?=
 =?us-ascii?Q?Tr9iX0XJzwMhspPJ9fdHnFrbWwvfGJMwVk0bzJyh7/iTIvgf0kfmp2fjrp8q?=
 =?us-ascii?Q?QkIQ65EMXoElDqX1N+4Et2jjTHXKXlQ1Ip8ywwmirx29/4+y8Cu6JimBf3LN?=
 =?us-ascii?Q?w3BSIIEI1rCNr8xzjCPc+gCtxb6c6SPQTQ23hJ9B8gkVGHzDDwjbwRHZew0z?=
 =?us-ascii?Q?elS6jX9LsbLI6zbUIyZDc+ZMqHVSmqWRxqNQkhz0n99NH2DaciZjHxBrRPlO?=
 =?us-ascii?Q?puG8iAzUd9Bk3gtItowqP15kvmixZURwzFBXbg5NM0LPFQ5kCuwGMzMCcSl6?=
 =?us-ascii?Q?/jzbB6G5LrNNMl295v+mjb/vqlsxJqlmX+Hs7SdXof/Yk04wYB5rh8+e7ava?=
 =?us-ascii?Q?RUHeyJ3TO/kaXegn/+R1U40fjSiZUJkgiB6fvJdOBSmB4IXOIFcJOqkctoW1?=
 =?us-ascii?Q?QuDEFBZcv7JUnaYQMLPlQGvMwBwzt6c92Ly2PJI4O2DteHtKNyOp0Cpxbb1m?=
 =?us-ascii?Q?4M03pK5diQfgv2hYA4cK580dtPABlTuif5IFKCU7kkFamjaDotp9+00RdA54?=
 =?us-ascii?Q?an/TuTw5vk8ai1pF3IFf/tnP/lKENFb9vPdhR4ud/6A6Y8LvIg8clfi90m2/?=
 =?us-ascii?Q?VMxTnx0H8COl/TKtyuSzcyMtdX6Yz4qq5UIdwHpD6oaqrW3aY+XAuxC4GJXx?=
 =?us-ascii?Q?33XkzN5zYopnMW7cUZArvk24AgKn9jWDvzmamS3+1Koh1EgIPan1hR62E24V?=
 =?us-ascii?Q?sE3imZ2OVKuROLaU5zOV2PVmnQgokM856NHP1XsMhW1Cktsd11XA2ILcKZAi?=
 =?us-ascii?Q?pntt6XtZs8n8jRecJX9njrnD7Itz0pquFF8SEa1Tvv13nQc3REaAlblDa6sB?=
 =?us-ascii?Q?MxACTq+U2l5Bf6Nuvq9xzrddVGmQyUH3eIH9+WRfodZ6mzOZt2MIA2FyAefU?=
 =?us-ascii?Q?ZqnhR6B529qQ472NxWFBeSBu0KDiIUB2/30BsfMcb3aHwRWpgg6LljcG4omN?=
 =?us-ascii?Q?A3JmmbcMbIXfdhvDwRWjPLMKNx+jyMSoRaZ8C44qVODnpLrjJq7obrnAShte?=
 =?us-ascii?Q?jE3S+XVghmVoDGzZHhCw3a5Ib3grx4ELdp4hKhgi1SjpBL5CM+F+oICHyrF2?=
 =?us-ascii?Q?Y9lswzuNsIO8eieG01R/nGpw3+oHTW6UgmCMXzkupghTgD8+L9U8wDeSfa3F?=
 =?us-ascii?Q?5I5F+3WNHOHx155DQmY0NH3wus3uLS0QIrNpZOSaob2U0v0P6Xb+vqraiODH?=
 =?us-ascii?Q?zaK3+vvIdX1oFHfLlBl3KuAbYxC210m1d3FPt2wO1GtCs3tEfWyxJA/CFjLK?=
 =?us-ascii?Q?Uob0yHyG2J+uJgUlqRgbJYe6OaUlpQGdiII+iV3WCqYIsPLCCINcYwY09w48?=
 =?us-ascii?Q?9k52xIMz646i0oSlY1QLTfSFM52YZJKatc3hpGJhaGFOwGBjrf3Cqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 09:44:10.8456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd893f50-a4b3-4281-a372-08dd72941625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF6BCF148B6
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

Add IP_VERSION(11, 0, 0) to the list of GPU generations that support TMZ.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 464625282872..1eb9242436ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -843,6 +843,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(9, 3, 0):
 	/* GC 10.3.7 */
 	case IP_VERSION(10, 3, 7):
+	case IP_VERSION(11, 0, 0):
 	/* GC 11.0.1 */
 	case IP_VERSION(11, 0, 1):
 		if (amdgpu_tmz == 0) {
-- 
2.25.1

