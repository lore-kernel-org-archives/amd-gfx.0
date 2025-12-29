Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB36E8FDB1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 09:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6AEC11346F;
	Mon, 29 Dec 2025 09:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hNzXL9N4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A23811346F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 09:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnKUzX6HLOwTaeOExdF64zNKiSA6pZn9YxRRjFq5+CW7aLIh7R1xmOMdAWM62oeFWcQwNIMA6EWsibNmyUyFll2Y7mg96vJTLrY2AccQMDHQ2y4W46Hkfz0hjOK2L8NXqjyiiBzAdJ6zhMBkVBKb+TU3JfalVkZ2hxt8XAil1gsELaNEr3UsP61Xs58SUNdrMK/0SaUex8179sHYbGVEYe0xx8HLYX7+hkxzdltthCQV2DBAuGVpmHwBGFx/4UqR2DPDFvFC0h2JNEuRoqe6aGX0PhQLadBzX9XO4jfoV6oJaJCgqstHIdkFzQTtff/2uJllz4U0B1irsp7M5n1iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBa+xCF2RlKm5oH1SLHEI3+YxTPG7Y3ar3gmjg3lIFY=;
 b=QLRzkXn7CU3IfoQBWQALNeCOMA9dmgEdyv2eOPwHcoS1eBfWGCxJYNM/4DwweNLnjH+sF3gz2V94EMntR2iOX/E+5fSveZiYAKIXJZ9TNsRYSY9mtHyTdxaKInK1XSgDgFcWreBlh66IjuGc+c/1mH6cs51kvV4ZiNdFBpCeazi9S6jD4YL1g31g+c2Z225jVNfTFh/pQRNpF+yLsAchNMgFQsYF8j0Ycp+ynF5A1FuPLKyMQ47F0XpEpykbMn27dQLGakN3PGdV2x+0HmCh8luowuUsI6d/FHPOFeYd+KyhVpY8aNTjQVnYWd/iIH2ekOX5SGgFZkCaqqq2clX43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBa+xCF2RlKm5oH1SLHEI3+YxTPG7Y3ar3gmjg3lIFY=;
 b=hNzXL9N4MDPIwXzeYT1rKazUhXkUpusfEjgUFhlpNfVv7GUnxNJ/ZBrLr1osG0d/DgoyCZ41kJRTr6V3tFuzCuoRBvQoRc+2y4pC9oDt1FKdBxRgkSHnHCaKXx4Yqsfs2REKxGhQo3HxnV2I6tvDMEhFLFS4zQTDAy+OPN92ox0=
Received: from SJ0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:a03:331::28)
 by LV2PR12MB999098.namprd12.prod.outlook.com (2603:10b6:408:353::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 09:21:01 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::d8) by SJ0PR03CA0083.outlook.office365.com
 (2603:10b6:a03:331::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Mon,
 29 Dec 2025 09:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 09:21:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 29 Dec
 2025 03:21:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Dec
 2025 03:20:59 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 29 Dec 2025 01:20:53 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/3] drm/amd/amdgpu: Schedule user queue reset on GPU
 privilege fault for gfx11
Date: Mon, 29 Dec 2025 17:19:30 +0800
Message-ID: <20251229092045.3368038-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
References: <20251229092045.3368038-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|LV2PR12MB999098:EE_
X-MS-Office365-Filtering-Correlation-Id: 589cf0d4-ab6a-433a-6ffc-08de46bb9511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WfyndhBTNs1LAtr8z0CdJ7L5yQL0KGANfqkoV6RxIqF9xPtuOGuzhaV/x167?=
 =?us-ascii?Q?yRA2Zeu8lZfyJDcUBinFcmeSA1yQVKrtsiLdkl7xjQAQ/9YA2JWU5kX4uMCn?=
 =?us-ascii?Q?LTZfVgcX5B4gEAetbyH7mU8sd7V3xvlsgJ6HHAvsvEnNMUZNVh7CEb9S9tVu?=
 =?us-ascii?Q?mvSShGuW7Kv4p2pomsHNZP7oB/XokO5tLFXdqwryhqgKo+kbOtSeEx/e2G8V?=
 =?us-ascii?Q?3fbYD2HNh/LiwqVfQopCbfkLgft1JlSrQzN0JEBRxuI1Im6l75Krflwz40VW?=
 =?us-ascii?Q?JwgFVkOCm5TkbgJAJ6ek9SS8n+6RYmzwRnHRlx09fInzu/mjmclCdyDkhZJO?=
 =?us-ascii?Q?Pp66/fMKwqWeYi6IOJzZOnJ0jft0m6igZXZGEt9afBhLeSMbEujEYJzWoYDe?=
 =?us-ascii?Q?frqpZNvo6QBEIi71S+r6ojHw3mYwOy+50a4S3s212uNqqaPtiQmzm8gUhafd?=
 =?us-ascii?Q?S9eX4JGnjF4FOvXuZeXTqUDETtCgqraYzwBhaK7zfT4f46UHZJSz1iJoUOef?=
 =?us-ascii?Q?1yVIxv3XRyh4VBLdWqx/9hIEMzRhfTKKMMwjeaX89qfwnST5fKetdf9bg88Z?=
 =?us-ascii?Q?I4I63d4shpyyvPoThjUgVRBxAtm1eFV73j6j1lLtyeIgB5JIETttYit0SFs7?=
 =?us-ascii?Q?Yj946CVQ4m9KQJhSeQQt1x9jODohz1EbaIbwjn7R7VWfmRIaPPYPsKIucta8?=
 =?us-ascii?Q?KzeuUhYuHAJxD7Rue7FQuZ7JI6a1CXYiQALMSJzK51tPw1uurmwU/D/Mwxve?=
 =?us-ascii?Q?IEjgR7N7dX74Ck/TDat3oOXfZyQlrbV8+57O1Ozn0W9B85VtsPkzxiOhsRkg?=
 =?us-ascii?Q?DPCKg0JtB4LLlJrZUDbROBEDNrv5xTaEAKhPpixxZ7asPopNH/syBihQ3WXn?=
 =?us-ascii?Q?8kpKZph7Hqz6uKgVXOye3OO86gP9GmJVi9atuvSY3GOZRehGw5Z2P19Fftp3?=
 =?us-ascii?Q?DjWZY/oaZyrWZvlfhdwm5/v0LGgUDJtjrHw3lQjLM89V9Ql+bGlwZvgvI6GB?=
 =?us-ascii?Q?KOhUyJca51E69/A/eux+i4BWJGmIrfeOU4b1rT0+uttJlRDPrMiVzIol4ysr?=
 =?us-ascii?Q?mJdFB4Cs6kVN9KVz7XegRNiXyTQ5jphSPfMUMwsBLptMIWx3L+m0yBUgazzy?=
 =?us-ascii?Q?ZLJpbJE9/JeJfD7M9awxflRCPOjaThgbK7qN/wSv156bglc7f5g72NPr6AzF?=
 =?us-ascii?Q?BRRr186fCtqJd75/ehEE4b8szZ4fWrNPZk8zWLkfsDzFKENjZGJOh3hE3zan?=
 =?us-ascii?Q?dzL5roPGETMhNYqakJCk9UqoLYn0m6/pFJ2JlEPNhRVvd3zeSvqwr0WFdAOQ?=
 =?us-ascii?Q?NsS9Br+s1BCktar2Ar29j8tteS/ek3VfhFlvuDatl+8tWAH9CkPTERjhlzwt?=
 =?us-ascii?Q?tOSKm2v7xMJpp4NxKyaZTOOMFH0jLHADojJSIzJoy5l3465LT3TzsKTad5BK?=
 =?us-ascii?Q?1+aXHdm+8kT6DQI8v3f8/ETPrQjXyYQpQMAYOdzK+lTXI+I7+iXSfNEJC5hG?=
 =?us-ascii?Q?ebdO+cyx+XAwI77wncRbj07PILYtx9DJQdlKVVh1Rj0zmhNXksY1XCwvzmXR?=
 =?us-ascii?Q?IeIJOPh+I8f9+IdMF1c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 09:21:00.5637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589cf0d4-ab6a-433a-6ffc-08de46bb9511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999098
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

When a privilege fault occurs in a user queue context, the GPU may be left in a hang state.
To handle this gracefully and recover the GPU, schedule a user queue reset via amdgpu_reset_domain_schedule.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3a4ca104b161..a2bc4e86e619 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,6 +50,7 @@
 #include "mes_v11_0.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_reset.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -6653,6 +6654,10 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 			BUG();
 			break;
 		}
+	} else {
+		/*TODO: schedule a user queue reset work */
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+							 &adev->userq_reset_work);
 	}
 }
 
-- 
2.49.0

