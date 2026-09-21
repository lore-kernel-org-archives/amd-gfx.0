Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD63C982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE2410E3BC;
	Mon, 21 Sep 2026 20:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oYBflD+P";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777D510E453
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4ikQJW19Adbk3m5FNCJ0H5W8BLx0QKwE2CjkbNAPVxNyRtq9QCtjkC6O7TAt+SfSdJcCKPZVzkCACzTL4exx60obbmnzArvl7+4D6vFRD0+EUlKyvMGGMipZU/J3U1jO+IiLVirIGwhqaWpq+zjATBEvjMI/TH+ZiijdrR034RPEzFBKCqxFg5DVgMuw7HM8pJWmVPHqctx0RijoWfWCHkwaurNYkRXVipCHsaWhj0/KQsBJJ6OT5JbmlnWA0Ieuuiz8+Zpr85GuCqUCcM1Vh8LJuO5dWcaZGYMf7ejZyqp4axPu9rpGV89jgCRRWLb/+90dXkV23oiz8C82CYGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6HKp58dCoXFOJsB201NNMCE1Zy9OpxTJrKDIaVGDLo=;
 b=mFDgpjwfBI4PDmIClCdkP6Hl0ku/d6G2IFHccf7CEvIOjAvbNupw72sBneeql61PUYYF8qj/zQsGJ9YzE1WcdVL6W36DjzX5yFtShGOsWxAbHTglEfJZBsZTNkD/g8qycgbM07hq9zZYcshP14//VIblbQd3/f0YWOhw9ovm7/2/WBooNmQ9Ax5Kq/v1GXiZ/0m+bFqsoQytHtNfYZ1WCwEIRkbm/dOUO/SbiXC1GU6GvE6kt3DKesNXVCrXK/w6m7LhXKg08s5Mg9jryJABbfPqmJSa/K6U+wo3vp97PcEhpw5xp0h0zkY82NPcQvB+0yRmsUntQWmMAoNzMSmEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6HKp58dCoXFOJsB201NNMCE1Zy9OpxTJrKDIaVGDLo=;
 b=oYBflD+P2jehDRazW+70vQS3tvyF9vLLkFiK/g2M6tkUoF/Wfj7K2LCYpCKwD0q1l57ccxD2219l/WRgOpaAXglCc0oqYDqSQXoE7xyxdLg9wkPKmhDyFrS3pJYnCCrrELSDE9KeZ7xqw1k8JYLXdMgA7z1mXVkWwXordvVMPJ0=
Received: from PH7P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::22)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:26:44 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:510:32a:cafe::83) by PH7P221CA0005.outlook.office365.com
 (2603:10b6:510:32a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:26:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:26:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:26:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:26:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/3] IH v8.0 Support
Date: Mon, 21 Sep 2026 16:26:25 -0400
Message-ID: <20260921202627.2038382-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 7004060a-6f22-4d6f-5683-08df181ea71f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 0ZNj4Q+EovzZf24E5zhStVKsd+LhL+jn5K0ZM38M8F4+ZlbstwCXVU0nRJIjIr6Rz2zblZ4cWAM2x1lhmfnegm30A+tVJJfD+R3h6ZRyYDzV8pzFcxRum1UAkXrRyaynqkvFdMNZ+G55FeA4EC3t6aqHOlljnkPyTD5//4c1npHwBHG8sNsldZ0pkkmDBZ85VwEBv9TQ23raOekzBWh66ayLEooEeLBdNvDuq3PVVm+/4L6kh4ANdIcdSFNbWrVFvEBTUjE80AZJissro6nC4tmh+ZETK8w9T2gM6W6OQ/j+TetEW5sfJSMH5+il6RC+LQyv+VZmxoy3puReCcsGj2Wg8mModvmXeXRtY1yC2eunNwtCMGvJy+2eLMNthm371qZ58cCkaEXxThuAgYzaNYEiWu001abMkkJsCBGJ4wE+Wb0w+TfA2IVeHzKQdKo3HInIbz1EmfLlyiToC1JKly66QXq4eBMNALkhPPl/JyqRjnKxBgP+f8nib1KzyPQ4X+ULq1+sDVw6RPw3Zc7KYi52saCL8Y3emIkS+IWi6VzcwLtoUu+sDF0zIw13YexT4yCea/Voo0ThqGjjyAPvcsdWDZtSscpmeeiYlJffpidRTkqkFQUrlQ9lmPbEsmSNTS9mEUlq+akZaeKYs9JddT71L+dfnbQ7NBr0OPy7ZJZMQIQPvjmT9zeqSEbts8A7teoVgMEY6Flza7ny9PA+hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lcU+CIc65VzKF5rnL8AUx+MRN9MWKS7p4XyWTHDnaPcYmgEEtE5bvOgi3vQXmhhMSIUDesWYhm5RlfpyNcNBYXoFRoClenVLcnAYf4zq5hMOxe/dIQzLREUlx4ckG+Ku3DkNAHnoJd3pMAdXC/oFp10ZPxS5NfiurzZd37bMFhq3qBghKQHQPZUacjiWVR8n7GUisjR4J2MzfqaZBcSznOYPy8SgJwRNnVDf4im2ORrwrt9GcVY2TdQ5Lu98lGsMYDJDTLqgXJDf3KQvdHP0haeISiQeCNk4hutv1q7cSIEtBTmm8kDiUvrw677jFwjf6EmI5VPSdxmImomoKq6Ff/xq730CATAnfbuLQF8x0bbmLBoL35dS7U4HHNzQM3C/LrWbPjFPM6MLUVZtUgZuZY+hppQcjMPq+ZEvef/HTri0oJZEaULMd66hSuukjju6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:26:44.0560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7004060a-6f22-4d6f-5683-08df181ea71f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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

This series enables IH (Interrupt Handler) v8.0 support.  Patch 1
adds new register headers.  Skip patch 1 to avoid spamming the
list.

Hawking Zhang (3):
  drm/amdgpu: Add osssys v8_0_1 ip headers v3
  drm/amdgpu: Add ih v8_0 support
  drm/amdgpu/discovery: Add ih v8_0 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/ih_v8_0.c          | 781 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v8_0.h          |  28 +
 .../asic_reg/oss/osssys_8_0_1_offset.h        | 275 +++++
 .../asic_reg/oss/osssys_8_0_1_sh_mask.h       | 984 ++++++++++++++++++
 6 files changed, 2074 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_8_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_8_0_1_sh_mask.h

-- 
2.55.0

