Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6968CC28B28
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138FD10EBD3;
	Fri,  7 Mar 2025 15:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DFDzm1ug";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8B310EBCF
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq7dvDPx/gevGwsf6/tE3iyDn+HwCKuubVulwuoONDKZm+HlJ58jeeWUwU0LEjGzNlotLjb99TsOwiBYHOm6PSGwG1O8I3mRhDW+SH9uoiaN/Mn4BCwCzP91AnjyNT2v1KSMlQZh+16vNGNdkJmfrfqPpc6d/04qd6hKTt0iBWoKJTo68iRK1/15rMBOLPqMACcgOh33BLbSHFkRaRpjzHPvOD78JRyT5tlsgoom1kZcUGA2zSuMRZG6btLM/MtVH/l2jn8tx+RIN8EMbdr7ub6yedWom4c1vERjWNF3xJ54SYxN8/8T4jtyGUXzlumfoBg42W9hZS25fK8HpaY1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvr37PfbO4ml4tLBDtFb3mZZtAg2FY2VfuI3iZ9K+Ns=;
 b=P+xAJ0Jg9ZaZ7OniQ5d5icBPBDcGDZrHXVf2AbLbvQiI/5t7oUnsd4a+lF7OGHipMkAXvNVPt3MnCCmV9dmEJfZTJF6Q0hKn89x5g9ogxbAcMsU+IzI9UOgbE2W7IhRM+QA029x/H2R8R5HwKRMVcxPnhi5bEtSCd4HtOh1EphWDV4usaLxd0oaO2S+FascV48MXvTL/8qj210Et3OX2xrxcCzoEOF8xK1R8V46/d6Zo1dC5ukOHLcc9DyuAIJO94ySjlpB3laZwcTECjig1JiXjjGS2Sq233QLH9arwIteIjxiQIS2xZ1BxsgqG+AGp4GpiFFVazYDPoehCqMZe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvr37PfbO4ml4tLBDtFb3mZZtAg2FY2VfuI3iZ9K+Ns=;
 b=DFDzm1ug8/+w6COPjZNxfi3a3PxuF49NmVdJWLOya1BoifpRC+t3J0gM31ebojNCd4wDdPMadyc/5I0h57qgBG+/At5Trk7jnsoMa3exUzP9wkWiayXkl8/9GRnVxaVt5wkozn9DvRcGrTgyBuiyw9vFNdEH2vJaQ1ej7roGqis=
Received: from DS7PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:3af::16)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 15:16:25 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::44) by DS7PR07CA0006.outlook.office365.com
 (2603:10b6:5:3af::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:22 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 09/11] drm/amdgpu/sdma: add flag for tracking disable_kq
Date: Fri, 7 Mar 2025 10:16:03 -0500
Message-ID: <20250307151605.946109-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: cff3647e-8254-438a-0907-08dd5d8b069a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l5AN3O7LpIpZ8BwkUX9Vffq//GvBfiaYpaF2H9740j/6GWl8ugZCiimeS774?=
 =?us-ascii?Q?ds8v39Auu0gj3VZuhMgxhMyb4vBykpX/Bu1NgmDvJuWjG7r3ufkX4LG7HCoQ?=
 =?us-ascii?Q?3E6h21oiA8jM/X71qATOen0VQ7fCmSJHb9i5qbyv3JWsyjqI6ItyXsO7mMa0?=
 =?us-ascii?Q?v2N/E03qLCpqbsefcEzgyP54LPFwscUi1bzKbq2Mi/9oNCqgr8NJyfi9PBCQ?=
 =?us-ascii?Q?5E/Cg8fBJ+Ci3LR/lWgwVAilqUpRZL+7ulD6pZP7S2Vgc9awXtXDOSHTxXHE?=
 =?us-ascii?Q?/1D3j+zvbn8jithO4mWMuvPe568D/RLGD0oRVTZ6AavEDH9j/iSVZWUWPerJ?=
 =?us-ascii?Q?WvZ2lbXr/zHRTmmKUnPrUgESFBKvOxG0aWHQx5lnk2U0D5M5uIcwRFtxl6q6?=
 =?us-ascii?Q?1xIyPTafbk9NWDRXj9AGI5+rTdoaAH8f/uQyZ6qir6gtjPSJfUkQ/OEKJ4LP?=
 =?us-ascii?Q?9j8ccLY4D7BclPw48o26YjEQ7HgKkwwyFW3Yp51CUaWdSgeDPMr1n7XJVe3A?=
 =?us-ascii?Q?ayPIR3x0UGh/rb0cwSYFcG3TPlH6VcRzfWFDvnmX3NSOyARWimHBtiyy8nxQ?=
 =?us-ascii?Q?8HzaSCQsqqnPrM5wpSe+po8Y/+J0RNhfvWgTiGl+6YBrsPBP8azsG57ZVoVE?=
 =?us-ascii?Q?2tFLoIfOtipyoBM3l7Y+I7lg4vjDxG/0RO+26+Zu/yk8Rom/ur8puVyrK30K?=
 =?us-ascii?Q?QDji6/pMfigHOpsSWgp0i/H1NVLEMZL+ZgtlN8Aj+uTamVdkigryI/nad5iV?=
 =?us-ascii?Q?37f6qzrfzbn5mB5Mh/c+I9nN8Qbwor8FiYhi7HfE35vUAStCd6FWQg0x3tK4?=
 =?us-ascii?Q?RkrX4wrsZFkRgF+T1pdB9PLSqjpa5PZZ6Mq77Z143IBomf2Gw08u74o0AaIB?=
 =?us-ascii?Q?Z3NadC8YwXH729gLS5uCg164dJ1N5WB2i1clvfrecqBmdNWWHi16G8DzfDDj?=
 =?us-ascii?Q?dJRBSBTxBh05Yoi5Y8TvrKnKbRKG6AwdzhurnJQ2VlpQ/+tL8Bvt6wGysrmc?=
 =?us-ascii?Q?GNaLCMcPKZWPKQpiKhNMEGaK6VQfQj0+lMJ1J/7IRtJZWsM1kIxUenM6cLQv?=
 =?us-ascii?Q?GgXZcdnaMLB0bG6TzM3GVVbzvdRc2N4VeEDFUXcgHyXABWw/yVq++CAa2kUk?=
 =?us-ascii?Q?p0S2S0Q4NKWyajpDcHjoQ50od+sXDnKTJz7o6IpXx+CS30HBDvXT0SraU9UG?=
 =?us-ascii?Q?FTAjpmzuXkipkprutdIJBwPMVMz6Zj6SDgPT5E6TPLDsx9tsZ0bxsOPaJR3B?=
 =?us-ascii?Q?g8wGLf3wMUPzoYxBqI11Z+ei+yQlxJlfspkrmDdb9/kENX1SOyxAXsRkluoh?=
 =?us-ascii?Q?bWC4U+sHKgWjEWHcJIPNYViAGIq4HU9lDiHX+9xlD/rD184UZX3YytClkMGB?=
 =?us-ascii?Q?PN1IQptuk/8fEXJdoEhsMQs8yNcrTFFjKd9Eh5g/3yQBZNw9uQz0ZumwgGhn?=
 =?us-ascii?Q?uLRBubEvIBUj3HYE2juRfj5ODEcylP4oAb/9smH+9iuZueCV5RJ5lgf4bF/W?=
 =?us-ascii?Q?e4yjU46y+AMHQEk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:24.8136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff3647e-8254-438a-0907-08dd5d8b069a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
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

For SDMA, we still need kernel queues for paging so
they need to be initialized, but we no not want to
accept submissions from userspace when disable_kq
is set.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 9651693200655..edc856e10337a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -129,6 +129,7 @@ struct amdgpu_sdma {
 	/* track guilty state of GFX and PAGE queues */
 	bool gfx_guilty;
 	bool page_guilty;
+	bool			no_user_submission;
 };
 
 /*
-- 
2.48.1

