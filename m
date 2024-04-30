Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C91FC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0BF112E55;
	Tue, 30 Apr 2024 18:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qoqkQgi4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45AD112E55
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0RL2vAk4F4dHjinyoglGHZeSQAxY2clDzHnHqhyGKjyIWNosVL2zBzXkIutbwVpVYVOYsm9YWaqOeOr1/aKNqNTaeYcmxSoW9Lb8Dpv5t4nRfe5sliuNqPI11vrU0JdOWuxMLO1OrTCHVpFpTBxHeT4OQEnDOICdm3vToajm6MHGjXT6LxIN2rnVmrgcPwwXYUVJRt9dcjVJr1MotvpjqJWePErIrHBj1ZwmWEA9ntv2P8yy+Xo1WK2UeWEphKktxUMLXf2KdCs5DxIsWejDesH5cbpbJMXrHiszwx8BtlVK4TSYvtpNPVe0Avai9QfVOl21+l5Xb41ZCX40ZCc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piSkQaRo/iIqsweu+dH73QqQw8HRwxznrUnuJjQkAqU=;
 b=NbJ+G22elapI+crwC/bcnkGjpK9Z7LrCEOtUFBcHrusba4Cw7Ln4sHBDH7Z/9DqdUk8SBcctfS51bWLc4P69eCETd/cOdC+nJ2sDIH6wfD4zJySw6t5jt54zSIxlm87RkhiDGSpQ/KOrfb8lPn7c5gmpwdF6ohvtUHttSlbKaPtTAAaZgmefCXF4pwBIZubtOMLgxckJbsccJG7WqGv4tLLIb6FygjpluLhJmmbKZaQqF7vMmtp/zP2Cp8Z2MKlzMfFgwxEVnkHy5OkQkw9QMtV/AzEte73/TUzZY5rnqaJQ6episqydwkiRUXmULhT/0V0jFUUvvxsouIPfs5JNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piSkQaRo/iIqsweu+dH73QqQw8HRwxznrUnuJjQkAqU=;
 b=qoqkQgi4dR1O2RF0kDy3U7r/19V20rmUyvwsxVN2NtinkX+TNZguDMUbcvPRWhHKSCWTo3nlHPQjT6dbLR/1rC3gvgf+S+XwC3Jft9ysXQ3UnXMf4UHKdinH6WXi0njYD1Q5OsfmU7ZIpjtvEfSn5MCDDacDQ0J7cJFPyL0kMsc=
Received: from PH8PR20CA0023.namprd20.prod.outlook.com (2603:10b6:510:23c::29)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 18:52:17 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::f6) by PH8PR20CA0023.outlook.office365.com
 (2603:10b6:510:23c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 18:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 18:52:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 13:52:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix physical address mask
Date: Tue, 30 Apr 2024 14:51:59 -0400
Message-ID: <20240430185159.747531-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f580dcd-46ab-48d9-a0ea-08dc6946a75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eb14TFtvhZkmXZwFXwJPOd2KfNHVUZGb/pZV7Ifet0FM7UgL1TvVZjXKCaYl?=
 =?us-ascii?Q?fI++KyHwNt9UQTkLS/DYOj3zYlsUqW5InVXdT2/sIl5iYfMJ/WT+yg3GZOwF?=
 =?us-ascii?Q?TRegu3CFaP17igJcCEnWOmiCi1VgO1I6y0u0ZWdThYuXPyUf2DJBKTWTOEJw?=
 =?us-ascii?Q?VvI9uz7kd539NUVUaBJMJmyBw5oqQ2wrzdUVQjq5XFwiIjz2okLU9/9MVMsh?=
 =?us-ascii?Q?bRp0p680q9rLl97rCzmWkQRlwfCO0P+uGwhXW18vJdd2uU/ukGYclEH+2QtL?=
 =?us-ascii?Q?rLXEGQ50a6Rqw2REOMuOX42llSpgxAg7fp9oIUtu59DGLfIDDXmEW1B2Yf4Q?=
 =?us-ascii?Q?uf9HbfJmh4FTr4AxSrqUiKCKIF+LBCy4Mr+lnwF9opS8bkxVUKJe41GwIw0O?=
 =?us-ascii?Q?Mhzt8QDQloDHIeUkuPKiF6/2tMl/QeZJm9FCDrmLT+OR1Vdxms0EZQPuVCC0?=
 =?us-ascii?Q?vQw0VMBUdol0Me8ZdbS9F9N7Gytp94gCgNn3vtsxVT/p+DPdZfvInajuFlVu?=
 =?us-ascii?Q?QMOMCw/lAishHGRZk+SjlM4GIiQz+eQhvz53fgIJqz74WU+xQTyoXdR8dj1P?=
 =?us-ascii?Q?u+pISTYi1a5Auqo4BTkmY5a4CR/Rr9KIdWQ20nIKi/Xy/UkNEMlXY6EXNVlb?=
 =?us-ascii?Q?yZl3V1Wx3kP2+LoojWNDnAhD6chno1xCr4StokDnshSEilrk4oDzHB1imWQC?=
 =?us-ascii?Q?bdnrXuI3o+WdGGPyIKSVe/GY1Lpyn0yvqvxGbxEP/d2bmvWenWrkDM9AfrOT?=
 =?us-ascii?Q?AlgQCQMjyAxm/0Bbv05hNWXbi5m5u7cucJlHNTLLHvq3JFRxTdrwT0GM4XBt?=
 =?us-ascii?Q?bvzk2ONTir5fkvY1pNaFZeKPu0j1eYy0yf9L4xieecRlUCAEcbsDV8QENFuM?=
 =?us-ascii?Q?DyNzvA3yeAe5j4pfkM5/I7JuaaoCC0MFh1b4dJRNPidJHkl3FOmoBRjAqIr+?=
 =?us-ascii?Q?PjSdVB5rEQKxC+LuVsusA+ydXqpJxDZvaBziAO9HoaIBk+8TvjtO0qoR9OMX?=
 =?us-ascii?Q?Ee8POFXMTtXklsd7f0qgHk12X0oeoah6iqR/aVOIQ6LUPlPUsS3+6LQK7RY4?=
 =?us-ascii?Q?A3g+vFO2nWXK3cpbxLjPRA2xpHSkRE24zwJiCrE4LY/iGExAGRwwvR+fBi83?=
 =?us-ascii?Q?5QKnffwBTDZM0l510VfDQAFEEAaE6tYdoawL57gwArBX15pxtUuhW8Sa0cw7?=
 =?us-ascii?Q?IVGOEGPGFVgCbEZNGI+lfBqF89Obt6SOSGLAiHOTEQTAylqozsY1UhPpkiWa?=
 =?us-ascii?Q?ojoUPe4Aglc1uDN3YQ5C/32aQwdRWmUnPDyJSXKNAtewS1ScGFDwG27z/btp?=
 =?us-ascii?Q?tYcvKMzuyC08XDwpyjCzMTo8yMFRB8MjkZ8DlQSScJ3tK2XrqfYZ+pudjInX?=
 =?us-ascii?Q?hxuVzCI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:52:15.5232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f580dcd-46ab-48d9-a0ea-08dc6946a75d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
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

From: David Belanger <david.belanger@amd.com>

Mask should be 44-bit.

Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3e6676fdc1875..2b7b67916c1dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -763,7 +763,7 @@ static int gmc_v12_0_sw_init(void *handle)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(48));
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
 		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
 		return r;
-- 
2.44.0

