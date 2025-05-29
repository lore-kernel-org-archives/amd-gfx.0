Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0585C5B559
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F41CE10E782;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RRd3jpum";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C741410E76E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4XwoehrFyyz4eHEaO2eKcarcLJf0aaZ0QcfHv4yLOOjoM8Jgv2+5dyozFwYrgSPJUARqvTWG5Ws2eNzdxKl4QnxmnEvn/v7DktEj/FhSPpcmEWKXvFzKtgH7FLC6DNNo8YOqmpOxTiAmTgdH9xIXYkbL9l5fchYISCe59+qC3umbqqeaFg1EnBbKjk5FImyxZEdvTUZ7exjeq/rRPmqnp+bffF9Ls63OtqYQIBdsQ7H8HRbQBja3XilnwnNtuTDj48DDaF6Whd2rQPrRMx8bhPAsuxf9Vcx6cCrG3NP902u/hwNeVhmwAF5qn3XzGktrUnNOjPreHhJw3CWvGdddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16VlXFSIeoQ/eIUCVASVePY6fciY3Mfbq5PTemesRDM=;
 b=RaLMCpvdQ/4uvNJ+w2VpdjnQLg82QzHQ9zCppn3PDqN6AIH8LhgrZy9AVxwjE6MFr7D1rKimL/9/ABJkKzjRsKQc7Ji3JuNMOvlAKoMqs/S/NIsQom96xErQWo20TIM5hf0JUtdVdLFA6/6MbPoU46RpPv9AvkekscVlD1yjiMnjl9gtqAwnXGMZkBvHDvjdq8VwB+jF7pQYtBdo/TzBoiGxzh/m2NaVW2Va7Kg8IvgGd0JUOp0ACMuHqWPeYzzXIVLUp+0U2gXdgJO2YV/9NGtqKDghDmBLpFwpQaf/7VgImd0cSeXJKllafJvBMKUwa7bJmyfBRwF4VZMcKP68dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16VlXFSIeoQ/eIUCVASVePY6fciY3Mfbq5PTemesRDM=;
 b=RRd3jpumGspq19ZkRWec4W8e7FL4QHCoZnb31Ppk5HloXEyKrKb2ERrXx7R7VRDz3dnNSky6oqI1bEelrHeO4uilg3IYmdnM7lhYhzND5wH9S5ruPHwANZU2llnwmCzqHs0bU2tNHDHCA7psenUGhnXMAXDiZFlO9PJZmLhHX3s=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 20:08:33 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::ad) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 20:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/28] drm/amdgpu/jpeg5: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:53 -0400
Message-ID: <20250529200758.6326-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: dcace465-837e-4dd3-3e90-08dd9eec96d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cjhug6zl/xbRHCQEyiLdfcFJFi7rIGlD1CQUpXVgozcwVsuJqsVhsB4CSfDk?=
 =?us-ascii?Q?8R/8LXQesGFoVCo9rnrvDEPwK6cyGHk7JBmEl/EjqQpZI9qZEM0sE1tzoSVD?=
 =?us-ascii?Q?+AkUQ6PkuRu3iyDq3yJggMG1HEl8TySt+WnoIL5vzEJY6DSPL0bfuES4EygE?=
 =?us-ascii?Q?o7CgI3C4za4Tc2eSLgo8Uojxg4OMlDg3S/1CUocsV+GqquRTJ8Cr/gExISMw?=
 =?us-ascii?Q?tENpZxnqQzH5ycH8ex/n9GueBA8NlCuafnUsMw3H3kUPpQfYor5764R9m5op?=
 =?us-ascii?Q?WcZKZuEta494dDIKGK0g2NjhjN4CwIYascxGUVXmJGFp62N+zANAqtV5EM2M?=
 =?us-ascii?Q?2Zs8iiUtwZY07GnR5tS0UNKDgsvtx79QU4fR5wQriCCF3zZKZpe4HiX53MnV?=
 =?us-ascii?Q?XjYZi6plCuQqoXEltEMgaJN7Q2M45naeFbs7lcWAcoFhl0PCBJUk7rN0kLvS?=
 =?us-ascii?Q?onFTv5vmUdaXBXBr+oJZFjXrI1CVq0UPeMvceFFO28D/tVJsGJMuwWPhrlFJ?=
 =?us-ascii?Q?N1h41+MVcdiZtE7jvAd/m53e6/uOGgA+4qXfMoI07ASjA1qBMnUfvuW6v0lV?=
 =?us-ascii?Q?c5Fp42DzrFzLeGyaTzJUtrlYp5dW5RHK90rdgIo0P9MCxRHHs/3RC92uR+ma?=
 =?us-ascii?Q?28jOOSQmCMAq7yfjNwORGuTAiKP6mWdN0P+lTzZDnVpHgLeemwyfup+aKQ1H?=
 =?us-ascii?Q?K0Pd//LDbhtOSwTu5uYbLhvZgPOpJ20nviuMOYsXAU1gSHIzqR+ZW/AecBWA?=
 =?us-ascii?Q?iRbMh6W8Vl5eQGNKDXfJsclVZCvqbYMrMYY9HuxocHIMPE8G2q14MBVQkFIx?=
 =?us-ascii?Q?CMb1jFN7k0STR19mumP8itz1Vka80FctaHyhRObLgG+P9PH6apC75MMN1zjS?=
 =?us-ascii?Q?URiikst3kk1AOBK6nboaaR+ilmlCPfgdTGqWRnUOCSbbwDvwMBXS9wH7YE6y?=
 =?us-ascii?Q?BYam9nZWCbg01M8HSD0kQss4LJm78X+ULWFW8hW31CVd7S8aokpMrB690K4o?=
 =?us-ascii?Q?k/WYMSyK8qDphzpSpCTPQdhKBbtlY3Xl9O8OJLsJNu68rCJJ1Z6R3OjeKlop?=
 =?us-ascii?Q?Dm8AwBvIJJ8jEVQ37y0QKL9hpv+mUXrbp6lQNS6qJcJEh7bcBkq/0+YsXM8e?=
 =?us-ascii?Q?vqHd2pW6HuqWJLOT1gC9XdWVXbcwa6ioq5xeXRc+AhBTQpkBch0GIMbtpBKD?=
 =?us-ascii?Q?HrpXWkCOD4MFxgPfDEazRbs6k5/G+Vl7MAl8WaLC+QrEZFFTq8TiMVZMDL2K?=
 =?us-ascii?Q?/rFAli4qai4OV4KsPDyYMZE604UwbinaErMFsBFoVZuDfAOlEL1uXCu/OPHR?=
 =?us-ascii?Q?xgY+kCnE65IRSf/rKGF2eZbz3tosHMGRQoLADLAnGNC5NbCdOyy40MwSceIx?=
 =?us-ascii?Q?JywekUyFQLZy+4Z6yPBr12aj3JXj4FoRFAKP8Du/Dm9UjkiK+5SdyKS4jvPz?=
 =?us-ascii?Q?BRs6AdQkXYnsy7pnqkcZUe0GWxs/47E5LGyXyGJ2bCFQ6u9U7TN57HiGxCrz?=
 =?us-ascii?Q?vLrAenFudgjtRuyBaoVKqc7Rf8KqsaM+GXFQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:33.4905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcace465-837e-4dd3-3e90-08dd9eec96d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 231639f2ef0d1..89f3cdb8616f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -651,8 +651,8 @@ static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v5_0_0_stop(ring->adev);
 	jpeg_v5_0_0_start(ring->adev);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
-- 
2.49.0

