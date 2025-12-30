Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249C1E95A69
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Dec 2025 09:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BDD10E896;
	Tue, 30 Dec 2025 09:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pvi0KWqR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F1110E896
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Dec 2025 09:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM71FWi6Gkx2LC7Jv61iTgO7icUHT97ggiUedgRY/Da72nTkaPntUtv7AoqO3KcYmuioYgd4GJjRoMxcb/i1nnsu7rKRaBfZwbOCVkyac7+/FwSc6PWeDL3VlCYCC6zW0Ge2INcLVjGlnKOA93VfzErrcE5XANEB68aOiLf5IP2PsxDi2DFvgfXWb1feGW7GKPCeCs+2ci6jN1K1F7fjfhRDNdF0BQNgb8wZOk/4i/S8GinyzAKEkrQD2s9ly8yXazZZ8rGEPoZXiVWgRsvwuXvrhbMPZ4GlKFwDu1WynveOTB5wIw6mPZaErJ6fPnLBBVK2zR4KSW2FmLDOGam0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWg39Gwv+avR44XgdJYJcHPeN0EC+JR/MSyEGhl5qLY=;
 b=BXFbhjZ1Dft8Zi9tt9POcxrw/kci7QxyBSmygopfR3ynz6y0DVwNYgyNLjH4bdcfpWpsVL/HpRrXKk0lLWBMVhye+ttZQLcB/AL+Y7D/216A7JvyYGXA10Vrnf36YO56NHghRllM+tCzEtELTXharbSQ4hHo57ZGkJLlGgctviQ/6lkzjk+XdZRyEB0YmeUZJmkaEYhz39QYqNsR7fFhxcVh1HNL2IAsZQslhV8JW5NaWWIuHf0nwngZFi/TQGshfPftNzqfO7rief8rJ9V1vk8WoT4YG2TlRzyCcVbc0vg/SyQEHtY0GZ7A9OvP6TA5QxzUGZgVNZfbVOfJ2h+k3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWg39Gwv+avR44XgdJYJcHPeN0EC+JR/MSyEGhl5qLY=;
 b=pvi0KWqRBmGok9Iq4cQPc+CITIlj8ehDJkR/1LL9Jq6kOsMx4S7f1bz340i6eCk3nf69DW8YtwqZcGGMW9Nvbr4bwbuXV1TIpJhdVr+z/dggQg/InYykQp/Td8wSu3k+CrFtgzPnZspecABa9jtR98wFLjfZQjPZataH+0K0fGQ=
Received: from MN2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:208:234::23)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 09:51:43 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::ee) by MN2PR16CA0054.outlook.office365.com
 (2603:10b6:208:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 09:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 09:51:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 30 Dec
 2025 03:51:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Dec
 2025 03:51:41 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 30 Dec 2025 03:51:35 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [v2 2/3] drm/amd/amdgpu: Schedule user queue reset on GPU privilege
 fault for gfx11
Date: Tue, 30 Dec 2025 17:50:41 +0800
Message-ID: <20251230095122.3587835-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251230095122.3587835-1-Jesse.Zhang@amd.com>
References: <20251230095122.3587835-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec023b2-a420-4155-98a0-08de47890944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iYASeU0WKPMKfzd66I+sB8IXVEBIwsqpvXECfPfEMCrR/RH5Xg7bK6xAfnxx?=
 =?us-ascii?Q?axrDlrVySQL4Rpf4kUKn1ye6ogIcmBSBcFJfKjreP3aCtUxzsiJICoK0J/7x?=
 =?us-ascii?Q?KwuO0TziZhlpIMZ0G2hgoa2fW18QzUoC8bBG1Mt529N+l27pOxidL1YO4vqL?=
 =?us-ascii?Q?SqJZ9FrJB+2a3BSm2/jFWZMSLnSvXTLeNjXbDE9YajnCxyOczFFAKcPzseew?=
 =?us-ascii?Q?U4H3jqQzW4VW2nfUkkZ6+uP4iOCN9veJbyUxyl8Pqo0ysi4FP8zgo8SARhBF?=
 =?us-ascii?Q?tNJNTWpLmaPiS6/M1QxGt4htkUjEODrnCUT7nldwNNaUXpl+kJ22WaIREF95?=
 =?us-ascii?Q?ZPjoOUuaHyjpXwdPRVC8noQ2Z6QvVT01vkf+mdhXbJbRrtuQox9I4kW3FwXn?=
 =?us-ascii?Q?FZzzsmEvNs5iMOIp+nZtBWlziq60zQsEZXCDk3qP4fmQjgPQ9qdaINSUZVJ3?=
 =?us-ascii?Q?qU4blnTflj+TJ4KSZ1WI8sJwu/n9TJNFXz2Do/PGNYxyqSEEglaAx392YzH1?=
 =?us-ascii?Q?YnP6/jbTBRXaGquIyHVCNoOiW8xvNaQ4OEGFmEHHx/ScfPh4GEL0Cjz0CSEO?=
 =?us-ascii?Q?ymohoYqtbHVAXpmukiR+KVWteEwWI4hodADcr4FVBP3HDjlht2s+dVsBq1km?=
 =?us-ascii?Q?D3udHgDp4MZc4V7HaRTrBH10qwbzzWosSsaD01mvcczuk5pVNs481MdtQHx/?=
 =?us-ascii?Q?EwHkEycrx/xO3n64CuyagxxjYpxbsxAVlwgdDzK0Z1ggzIqIxHMJCrVj9NnL?=
 =?us-ascii?Q?7TC/YjQPfLyu29yn5vCetaOEJasrGsEVNiLlLVe5bwdBPArVrN3QwDMWfgNb?=
 =?us-ascii?Q?dhtrSIURRqcFx7k1MZeyHaYw8ScwOMqeUchuy2RLapB1Bkcs5XvV6jsOEBZN?=
 =?us-ascii?Q?tGJvnT5nykrjqkPTgEwoY21CbvLrWv6L40IW7r/DaX27ALGawrJAQg92wO/2?=
 =?us-ascii?Q?LEBBmJHt5yw1ZVHJ+MLhuGZ5JNhY3kwKFjUJIxIaDVlLv7jmyyLVddR0jvAI?=
 =?us-ascii?Q?3BgoL/I/JUrcCULwpJ3xyjcFmQPxT3ZK+MXilb/6m8HcIK0UKz3JA7yumpUp?=
 =?us-ascii?Q?lh0BDydwKqWwyYwoaPW5JfraZq36kKytuEUp88uMpvJd1hdFVWOfU2GSotuo?=
 =?us-ascii?Q?wV+CXOvpWS76ja4dyEmNOHOilUcVvs8Gtx0jH2P1zHRbkR877NXKsTZOJFml?=
 =?us-ascii?Q?B5rm6jZjN00AHi2sw3mefHOSyAtZM7nglcD8untnO5LHI/jORViqhjizSf/s?=
 =?us-ascii?Q?wIooFpS9j5+TTp4keXBdu9NVvdlI7PEKLC2McHpGzbLQpuz8WggX4WvTWFG4?=
 =?us-ascii?Q?7xE9qYs7JvR61UQMulYiiqiJ/nxwg7KnRqcTdemubny4qCQg/9t2XlC3e6iZ?=
 =?us-ascii?Q?hPPvpYEfILkPwwzWiuqEx2dwaE6n0yZsD17xUrjKxwfmD2GXTeHjvYNeRqyG?=
 =?us-ascii?Q?eHlxupddizr7Sz4DZ78W2TrgFlkH7ggWrRyjzOvIF2ews5YBufNlyeIZqHTT?=
 =?us-ascii?Q?gtZ9cRHsKJXnTsVT6mNhRiqYmyoymEnACPMmpA0Se8Y5dErRuWxvCDAwUWzQ?=
 =?us-ascii?Q?ID6+cddUYGBtdX3aIJY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 09:51:42.4350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec023b2-a420-4155-98a0-08de47890944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
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

When a privilege fault occurs in a user queue context, the GPU may be left in an inconsistent state.
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

