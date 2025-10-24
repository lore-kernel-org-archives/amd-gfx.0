Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7E1CCF9E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 16:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED4A10E214;
	Fri, 24 Oct 2025 16:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X1RoJJf/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D354410E214
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE4GydwBFQ0ji8XneuSQxhHv+SfIivm8MBj+0Fr/5ULu2cLbMYhQZTRfisrztVP5w3rigMIYDI5DCXJsaInJI5PlLsUPyVgjG6I5qSyxI9oH82GryL5KG/JVZuZrRVrlKTI+gqYA0Ote6qM2GXlBT+lKaOUsW7z7yaJ/WIlOPwbkJny/RbUpbc789gplxYYqc74l5VBSPNV4MlGrb+uemSg9EO5afJM5O0l5gpEq3UuxJVjcsVNgIHfWIar6wSqy3YfgCZ71jZTyhjneeBkpeOhS2FR4Kv1e84BvBlILma00/SipICLxr6bdPQdzuq+P8iXKaxyhi1thMvR5XIjToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQayYCE9ZLM6cLdB/tcgp7LpYevIGWp0eK8a+5oBIWI=;
 b=BvALUjTau2cqqm3WPVqWpeJ7nBHwhYpLTAJKkIvEU7DUYha3DCSHk9TKCPm7iMU1AGpjRU1nmvfFSRwjsGrFvu+72slIBoSslAlTs13kUt9f215lThFwiMlng4KqDLlVg1cp6tMQW4OdXsTlq5RCDfV3kKj8sp3ujIqIlaCLXtArVnty4nJkkQlG4UhVA/q9XJe04aJJ1pEmSsLsWT6qw0knegwGVCZAJuAwBK3NUQPp8Atq69cY6mXB/8XWNrhnteysd15RydOiJIRuQL+1nWfj2GjHsAk56hFoNExu8HYkljuXs9TMuc+PuUm3uWRb30ZBf2u159r1yf80wltoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQayYCE9ZLM6cLdB/tcgp7LpYevIGWp0eK8a+5oBIWI=;
 b=X1RoJJf/iFBU7fKxsLNwhX/+GIPA3KeggFcYMjAHs14GlLvxeIv+YUTZBmxuy1kNe11Y7nChYLGm2hk+36k9KKtOCrgl+bCHLnMDB8Ezbr4lfkXBtF+m0ig5CU7n0hnr2RYkbQjDYKgfkMgolHUHJMsPAJFtacYghbuYoP6csDk=
Received: from BYAPR21CA0024.namprd21.prod.outlook.com (2603:10b6:a03:114::34)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:12:36 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::15) by BYAPR21CA0024.outlook.office365.com
 (2603:10b6:a03:114::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.5 via Frontend Transport; Fri,
 24 Oct 2025 16:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 16:12:35 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Oct 2025 09:12:34 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>, Antheas Kapenekakis
 <lkml@antheas.dev>
Subject: [PATCH 0/2] Rework Van Gogh RLC handling
Date: Fri, 24 Oct 2025 11:12:14 -0500
Message-ID: <20251024161216.345691-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2eca5b-4a34-4ec8-4240-08de1318255f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jKueI9epdSEfIevgqDTFlvzFOvGJ3+Jm8HITgaOTC3W/Xy5yQXfMoYG9ZCrX?=
 =?us-ascii?Q?H1GyHFvy4xwvm6Y7FBNQoRgtTL/01DvXSwL7DBdZH//NbzF6sMhh33iJevCy?=
 =?us-ascii?Q?b0AMPjirw8YNI+XK+7wE5YLF4y1caBHGHFhlsRr6vWkriRDvw7gZ6YgsGb9y?=
 =?us-ascii?Q?KOAFPWFSIeMaIvN/mJfh+ZdUav4CCcMLophNQ8zwm0us6CmRTC2SwWBsQivM?=
 =?us-ascii?Q?eDGT0RkEY3NqhgJENldAsmjxYbSUXv2o5t7PAoCNbBzbbb9N/06/3AZ3/LPo?=
 =?us-ascii?Q?hkUF2PaKf/TH/q5zp8jNftPuZk3Banp5pKAW1C22PmsWllh2rVtgyP1ktpBq?=
 =?us-ascii?Q?KJ//nwqAXLx8wEP75KBukfUNMprWT0vR2Mz6tPOxYzJdEQCMUCJuJ+97s+za?=
 =?us-ascii?Q?IGcsNB9yTbO/OpN6z5sEZ8VA3Bp4Zl5dpaVYOPH/3DVh4UPZ+oXervw6Uamj?=
 =?us-ascii?Q?u8dexJlrUVH9GseTR+HIscdozSSwH6IsCtqWusYjG34U96iM4hqP6xszCZMI?=
 =?us-ascii?Q?NJnGSWdXlzttLCs55dEc6+m1qBM/MFpPxH1jU26c1evgXG7PbUdbiHNhQ92v?=
 =?us-ascii?Q?2ta5etl66Nl6tSV402l/Q0FtyaQeFUyWuOyLjugkuoUg6b2PR8A/GoVd0QsQ?=
 =?us-ascii?Q?gJfcZb0AEcSMtFw0gcpzkQM4GzBxXyT50dw92u5+a20SRoVF33sINLQVCN/L?=
 =?us-ascii?Q?GkLLj6kSO6imnyeDQMwEjX7bA7hcn88q36qyNrub68XkkxS1C3GKP7nT3oEL?=
 =?us-ascii?Q?3SrKqhmbY/njHIQDvmHKlOj04DlJUBkfROyYeRDRv49fLcVi7d0Ch7udxfbC?=
 =?us-ascii?Q?hhja4bRUWBquxjSdkzG2HmmtFKey758nkkureS+VJcyYbYLOXtunbKmazQVq?=
 =?us-ascii?Q?xn1pFgb3IPCgZ1Rw8FJjbA0E0WCQ7nNxWeEE+4FFdJvhuMn5peuzCuLF3n/3?=
 =?us-ascii?Q?fJYB9y/rclGytvSTim8qMBkBvh/GKXPwx77PkFz0uV9vDvUg2+kftdfSHUNI?=
 =?us-ascii?Q?kpIj2wnStq3a25xl6MP0xMaiGHcsfX8+h4L7gUkdzSLbTbm6GQa13kATZ6zB?=
 =?us-ascii?Q?mI5xymhajaq+T3P5jZhS8YqCN6c2chwP5Joeokp8XSAVzvY77HkQETcoGpVc?=
 =?us-ascii?Q?NMgmgOsO/56kUFdYrVsoldNEDILb1Qc4KVCmBNH8fWbmlsCIXsHdPYf0casX?=
 =?us-ascii?Q?WHotlxZx9+6kuuB25G0Yd8ppwgiVF0XbVObgTDygjIAQ1keShg/sr/PiOB8n?=
 =?us-ascii?Q?5WvK33d5zF8RjKKw+zrlP4BidOQa6/9vBSQ/habUwD1OY+GbR4n3fcPJEKn3?=
 =?us-ascii?Q?O6mMVWJwViqeJm0xEyAxVN3jRUxNYEqx1SaUe/fJ8L1fd8ebkoRz2spJlEMC?=
 =?us-ascii?Q?V/jVmSBFyJ59M7++LLZjzHWcGUy5zseVIa7mDB4LmaI9T/7MSZ93Pa6ShclC?=
 =?us-ascii?Q?J3vk+fxgHIoq/sQ85IGw0h4ke+a96sEd6/jHy4U39vvt2KUV1wL7txY5PbJy?=
 =?us-ascii?Q?8cj5AEloKlbXjvgy4HaFMZVL3sqhHizAubf5ozng5B9EKr+Am6xeWR1my71i?=
 =?us-ascii?Q?wYBQQqcV/Pwwh/WuYZc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:12:35.8980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2eca5b-4a34-4ec8-4240-08de1318255f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
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

Alex introduced a patch [1] for s0ix support for Van Gogh which
Antheas tested works on an Xbox Ally X, but when I was reviewing it
I noticed that the RLC callback is very similar to an set_mp1_state
callback.

This series reworks Alex's patch to put the RLC callback into a
set_mp1_state instead.

This series should be tested both on a Steam Deck, Steam Deck OLED
and Xbox Ally X.

Link: https://lore.kernel.org/platform-driver-x86/20251024152152.3981721-1-lkml@antheas.dev/ [1]
Cc: Robert Beckett <bob.beckett@collabora.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>
Alex Deucher (1):
  drm/amd: only send the SMU RLC notification on S3

Mario Limonciello (1):
  drm/amd: Move Van Gogh specific suspend code into common
    `set_mp1_state`

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 -
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 18 -------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 +++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ----
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 25 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 -
 8 files changed, 30 insertions(+), 42 deletions(-)

-- 
2.49.0

