Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E897C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 17:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D74D10E52F;
	Fri, 31 May 2024 17:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wIn6QzsG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB95910E513
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 17:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5r9pasp36OsH9bSoHBHOb1iyEuAiASCntGHJi+fPtJmfUjKjJ5q+kjMqTplLKrT/F6U/SWuJeTayMbukU+mOyRlJcXunonI6OI8qOl6GOxL4gnc3ptnQojkkoxXdmXq4oK8Ue2Cq7bfYGCgrfWaf9V7dcnu6hKFf/knmYZbSm/Dc5rpvIvVxakve51OvV79odlb4KuZxk2ovSX5SCszXrijsx8ud4Y6z7JjwMtNPLMpyOic2PYCPV6f2inFXsfyhNAsUUYIhbKs9mTn2WIRI85xWobsIoUmyFtgfrNPsSJ0shd+P8SZM0N2FOLmmrar56MQXcmkYoUgQXLM2M+adQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNvHJf7GDwNVczGhMJBKNiKEJkSdtSyJWvX2SuqJE3M=;
 b=gIf7iCi6sHRc4h/Jeq+z9rMwEL35ZCmaHKhxbcTCOcadohd8PTt8wpUqiNHr1he7Xl5qO5C8uKGrNC5dxzR11bMTfvixqOZLE0/Mj/xQNSZiR5jjX95sMkUWFscTYY1txQwZ097doDGs6968yAqlrNak+COS3eJ4UeKtRFMJIB934gfMnK/nD1R3Hl4z8xHDsTdiFolKNG4TWB4EoIx2T/5SbUVMwJW+WDc+iC0jIREgjlSvC88EesKT+ihSyBPSIzOm1UDLNeOFau9jpmKZCKamvsGdjjRH/AO1quzIZvGK9skSIbfeGHpOVXAXdHWG0jpLwjCUdc3WvbAz/Q/cxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNvHJf7GDwNVczGhMJBKNiKEJkSdtSyJWvX2SuqJE3M=;
 b=wIn6QzsGxU+uGPhOzWlD+kIripgUfvSmEXvlKycp1gYH6b4JUdLJ5HH4Hyx6W5COpXWRJlJeFAHxziOrKl1L3qcy8WavYhHHIw7OCXMJQSIyrrCVftz5fr6H896VnJIOv/wiPzQ7ypxysUHoE8GlrsMZGdqg1/eT5/3jHxG2CHk=
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 17:42:30 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:610:59:cafe::9d) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24 via Frontend
 Transport; Fri, 31 May 2024 17:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 17:42:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 12:42:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: [PATCH] Revert "drm/amdgpu/gfx11: enable gfx pipe1 hardware support"
Date: Fri, 31 May 2024 13:42:08 -0400
Message-ID: <20240531174208.3650007-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: b5be7f52-bd6e-4a3d-94f4-08dc81990b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1U1qb3/Fk78lyk5XQWCeRYIQ6IeVuOiWlulHNWOiC5uRb/xBz+5Z7qIzTCaS?=
 =?us-ascii?Q?YNydtNa7R7C8dRZMA/VUBdzA9zR/45S5SD4ZfPw85pCATGkW4Hx/Ryo7tsSV?=
 =?us-ascii?Q?G6lMMxFgT4gZ/8xACbQUCS0abG8V8kP+VdmXtavZKotHAgrYEedQOfwO+9wn?=
 =?us-ascii?Q?I5Bmq0K/pFr+bmy+/PFLvDsrjPdZdwukRWoeYj4PUqueyG46N5d7uSNRyj+Y?=
 =?us-ascii?Q?xKpJe2tOCP2jrsyVS+EbUmkpTCBl7LvWM3SdLs0mHftlp+TU61l2O8ph9iY3?=
 =?us-ascii?Q?PCFOr3njoRzJFlFo8ZRYqPzGCgb9jvdkErneY/ZWpMbu/yb0k5q8EcM1S8qG?=
 =?us-ascii?Q?rhci1un4+6Z3KHxa5C/6DwF3ZUDjgOS6Pd8/ntu9YdyOtWDx+wKWCFx7ckf4?=
 =?us-ascii?Q?EXU1ZwOSVlaFbWEZS22Yb/Q2rIBasmrhj2wIDuBzcIwVEU4IhtvO1PSIgCO4?=
 =?us-ascii?Q?HjaRv/DCBmJFBFgjG7elFf9v6NeKVxq0prf84PGQpr9NtyQsp8TGaivjdt3R?=
 =?us-ascii?Q?t+YKOlykKPHXQM4AcDSG/HGqN8JQhkXs8vz7dxuhi+LwE9qtBGqyLYf78YM8?=
 =?us-ascii?Q?61qa+y1SicJmM973zEKHX6GunhBsyYRU77IhCrhLBie68QkK0OPFW4eNevLJ?=
 =?us-ascii?Q?RTkFOQGAQ5U6D8TRQo+/aK8tCgt71gBgE5z0JcjGusa7cHZ05sGjpb2v7N82?=
 =?us-ascii?Q?fzMMyTSAjAfpm9Pwys0hlAB/TXMWZLUbeXyW2SKKpzxx0PuD+4FLldyceYjQ?=
 =?us-ascii?Q?HoU5MuEjjdVqoyOMaFUpV3omzBAKkIW/daMvKd4+hdSMKP4F9Gj0kEKvtR2a?=
 =?us-ascii?Q?bJIFy6gL5rAfH+7sAlCn4xfIBZfCFfitrhzJHp0g0oJj316NHhpvFgEG53VA?=
 =?us-ascii?Q?IlrWiE/EaI9ibRsCb08qNYVemdlsz3mzsHJ8F6WO5MP+RcloLwzamyd/W1K2?=
 =?us-ascii?Q?qHm4FNPz+LgfZlY8LBxNdHTqxhrqte7sS+x1pnbThle0ImAXIIf0BHbQ2kKg?=
 =?us-ascii?Q?rxfAiF6ZETEnhSyMjCkHtwShVPZBYRVUkGkKssz9Ejl8RvjNzTyRFEvHnsMr?=
 =?us-ascii?Q?Q3t20r5PRMJmgyHusjsLfqt3nmLCMLT0wrs2i17vsRyXjQdubhsAEhXKIq6Z?=
 =?us-ascii?Q?o7vpyc/DnJG2WtlyL8nIckbG0wRRMAocOtCK+M8+PE9WuS948Yu0wW443SNa?=
 =?us-ascii?Q?nJriZi7u/QmzBsLif6lyo6StpZfF+vr+bHbNHAHG6t+0fOw770xEmEntUpqv?=
 =?us-ascii?Q?91HOTrySSRP1DhPElMj5hqM4R/yEfY8fhXWJXl7N3Qjikh3uJrHs6InxMLY9?=
 =?us-ascii?Q?OhsrJV9/FFeu9IeeAuMCNm4PhEByezJ+iSp/5x2/CRoa3fWJOS/So7DLYPSG?=
 =?us-ascii?Q?LNWLP/em9P67sbatDt0zqJxi6LZY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 17:42:29.4314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5be7f52-bd6e-4a3d-94f4-08dc81990b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

This reverts commit 269226a8fdf2cac0e03920f9ba0d670a056af3d6.

Pierre-Eric reported problems with this on his navi33.  Revert
for now until we understand what is going wrong.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Pierre-eric.Pelloux-prayer@amd.com
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 72676bfbac8c..bf05ff77feb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,7 +50,7 @@
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 
-#define GFX11_NUM_GFX_RINGS		2
+#define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
@@ -1526,7 +1526,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -1537,7 +1537,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.45.1

