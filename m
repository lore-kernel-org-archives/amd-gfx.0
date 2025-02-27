Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444F1C021BE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 11:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4BF10E171;
	Thu, 27 Feb 2025 11:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jy0tYjdg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6142910E171
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 11:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYtLuTJ+O5cG6t36f4zYI2AjGBnVnEfpnoa2gtIWAkOkbOja1XXJ7TyNnME+vmENm8d9ulOM2RbED/hSpADRBd8HSqKBgStvYtFdQhce87v/VadVp8D3xccQ3cjrouZU2tcsyVfy/ZDBM0eQ0QLq8yzo5UuvV7lNDEU0QF1bzDVTKYT0qlMiwzoPW6NJzdHUlGqwYdAi/pL3zddITgikzKJ6CcxMCyMqx5oxaQ/akgwhqm7cxcipcSVXImcHv9cFswFOTPJ6lcv/2g9zL7L/7m1uBMd3VeNJ/pVhrB+8MQ5V2k+XgT0XtAzpkAyrj9J/QCAcZXmeIpsEka4vbhN3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY91cJsiZje1ShTuLqgKCWSWgKs3bXPujc2kRm3Hi34=;
 b=hZ4kabllaDXRazJlOQE9MuSAW40mWDffMUeDGhedHDh+d+oTVmnZMRGI4WW6PtIR2+Dff/qTDXhDnr4AnwkvYxZBed6pqovPQOJOs0SR+29NN808jSBnGJW98oYcVC1faa0xzR/eeToksIAtSXLkWzHAIaxerQZss3SVEO19XkRId0towEXD7aQoS+SijGKQJDG+nFF1QAJp5Lrx6/xtXhuGxYR95+OzU1JBte3e60uGyDCKlVDYhgF08S6g9Kg3cmRpqiAYwkWny5bv3UjoAt6XrsCy3uzATdhRJssMBEnEqvKbBtODus2S+UbhnqSb4BUYGVzCq1UhwQg8+Ye+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY91cJsiZje1ShTuLqgKCWSWgKs3bXPujc2kRm3Hi34=;
 b=Jy0tYjdgLr1tSZ/UwHHpWucaeIx8IswiRfkacv1656i1Ocv+qM5c976On2J/KaAwyz/wlgwD3wx6NGR29NJdFIyq5r0ABGzfraVrl7wAkg1ZmVWJVlo87iHu3zD5/xCImtCRIo1LlZh4GEtYSwJ5ISBSw8kyIzAAQTvTxAjJrII=
Received: from MW2PR2101CA0036.namprd21.prod.outlook.com (2603:10b6:302:1::49)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 11:48:34 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::af) by MW2PR2101CA0036.outlook.office365.com
 (2603:10b6:302:1::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.3 via Frontend Transport; Thu,
 27 Feb 2025 11:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Thu, 27 Feb 2025 11:48:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 05:48:02 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 27 Feb 2025 05:47:55 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 1/3 v5] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Thu, 27 Feb 2025 19:47:53 +0800
Message-ID: <20250227114755.444535-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe4531d-c395-4851-4595-08dd5724aa3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OWW9BF9dILarQYBkJaClZX8Mw5sJ4uQdS9f9ft/k6ZWJkAHlV57oJ05Z1G5G?=
 =?us-ascii?Q?zqEG5GunyDwZz3DTU94sLUlbqdlMV2YCpYPuAUad13lptSrKCr4RtE47Tun5?=
 =?us-ascii?Q?tjp6sIaxTq+2Eg/yVIdNVnF6/imaIOwkhQp4iDwnQQ9OXzbRIiJBLCa8FoB7?=
 =?us-ascii?Q?sYIBrvFLwFXmuXbyE26Y9QXaYlC5rUrvv+4HPv+hLFBrCKiEtgvozqyPTsSx?=
 =?us-ascii?Q?UADuVmtC6u9xCj0FyJBsaS8b62bEuSr6KKgpVAv6A2Wn28SgKyLTdh27ZW5k?=
 =?us-ascii?Q?eEi9YlmCyIA3xJsuVrprcoEWwLflkI+XvMvIhqtHSywGaMKfZzfRfAVSoa2D?=
 =?us-ascii?Q?EoOiB3G5oBL8NhBFOhBWzzVEAtWi9IPfq9WSvTGYQmwBB/9DYwKHJk3lGiFt?=
 =?us-ascii?Q?H8jEdrjVEQ7A5o5S+24GrQDIbwH6VorozOX3h7bndhPBUtn4wjf7zRpMag8b?=
 =?us-ascii?Q?ugl+eTTetnipu8qRlZlK95gVEkxPYmr5cMw2m7p/A+/ki8z/iyGUpb4zRGj9?=
 =?us-ascii?Q?3RJPeF2858DIkUE8L6smSDR7eWD1d9ZjaUE/S1CB2cgeAkO3R4W//njViqkO?=
 =?us-ascii?Q?9Yf3Rf/QKzxm1rAYgzi80m+KpixC0Nsm3X5bWz5nDAFLhQ1eDYmONv2WzmEh?=
 =?us-ascii?Q?eMTcO1KXUmoc0tIKlI2LI7urSJ8lKxJkKEpaVYgslEYCf09eJDjSAH3PFK1b?=
 =?us-ascii?Q?tWbfwUbo/fhGEPfZzWlrqsVvABxJ/x5Z/U+ibmQXKJGfBjqjuf9pdQuX8Lxw?=
 =?us-ascii?Q?4cci2IuFP5J3Sp3D49jptmgnhhq2YRJCcg521wvpU3Y8YRI9+a+shA3pNJrp?=
 =?us-ascii?Q?9LXtPIzw4n7zdgEfNokZvyr+k3Nqphv+YDQ9cOEwruHZRDk0KtXT6f/0sfWY?=
 =?us-ascii?Q?2KqC8ugY7v9rLKvx1bTtRtDfC9GaBQmm14kZ6wQCl99GX95uNybQizsZJN36?=
 =?us-ascii?Q?a8lunSU6rCOzJeF65mBFCTiWFdi843IWj/QzGmvSWC5Io3258CHvvB95+8j4?=
 =?us-ascii?Q?tYiKxTHBhEjLNy7h0eIljZkvxPv5bexOZsuAnCpKJveabiXPPg4Hj02whPH+?=
 =?us-ascii?Q?pUxSCIWGXxqUSDS7dnlchWDm/3KwaU6xNrcDvPll1DRp5ufq+0OYMHA0xzcQ?=
 =?us-ascii?Q?2ELqkSN06qrlHp5WPjWGMnuL1YW8OaLmekcolKVwBPfzJEdoSdCeugml3N4n?=
 =?us-ascii?Q?Cu9xXrPA7sp+dB3v+rAjIsV7mTfFAOIq66g9/eGCsDMTqLFO5hrefinkqvjB?=
 =?us-ascii?Q?ddo/zGeEAUcyFPkt3iiVqd4q1ZhSXjAJGzrLm4wMjObINeZtRJKP3QnTA9Wk?=
 =?us-ascii?Q?by+6qnBbm7uQVlPhTFlLzbnC5/o7ZQfUP3ha+mZSxHg9/9u8n3k+5ECSV9ie?=
 =?us-ascii?Q?6+Hz43Mb/YHzKi59RSg5u2RoCiVaBwFvRXIl1KN2rvEI3g2ppPMqh5ODdEIe?=
 =?us-ascii?Q?w0Rgv0lXNo9ySO8J1duhHT8K764y0XPDwJDPag0M6o/ctnkqa8OCMfvri+LX?=
 =?us-ascii?Q?WNlblG3TMCUoCBo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:48:34.1366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe4531d-c395-4851-4595-08dd5724aa3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Increase the maximum number of rings supported by the AMDGPU driver from 132 to 148.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 52f7a9a79e7b..4224f8fa1614 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		132
+#define AMDGPU_MAX_RINGS		148
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

