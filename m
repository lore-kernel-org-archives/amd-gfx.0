Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FFCC982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432B510E86E;
	Wed, 16 Sep 2026 17:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q8XDaFCA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A780C10E73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9HNklIcta4Iwv/paTmnJx2C1cJPOUZ7XFMhQ0jJGDx9s6J+B0D3PTpvyV+qSlB7ouZrVvNVxCEcGr9BxLUTEjIDIK1snd3XFArwk5pNyw5AYyBS5D43aNkVgVU950fnB6n4uiGWOVLtgD4mAWwCgYGY9yzZ8aBMkG42CBheU7W99vYeFUL0oIzUl8M1jIgB3mZdmRqBvdrFXX3wS6B7ngOt+Qm51obG6X8bOf+SjbbkVeknso5OlcdSV9R7auHTl+BNte2SSo9z1Re2BGgS+XymkL1AGCoDtvW1m94lFPTMvps5CAAKWt8aCM8x/ksziroK2ar4nYGM0tXnJH/kLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y22zljKzXB5n+adA+l0t7RHwES4cuUxbJ1AbC946T+0=;
 b=HObZqIPhKUvtuk39a/1NqF2YlsGxCQpF+F27d2E30Giura/cq/cjoLtNDxY8nVKIUf0+deYfkQz8rPD/ZjfrQz2BHQQ0uJXToQcx95pS3W9EeJ2UwvzOhj4LxE974z7AGVPNhELHNnICNqPj41wf2DwoCSeHm+kbjOAaGBHPaj6aPcl31eb5yRj+toJxoYrmUlNcpcgECJvwbmn2ckVHHsZ5fMWMt4zd9R0QiIC+3L5In+reoc9sUTZLsPWB8SPzOkUVmAoMHKkeq72APEn0CWsO8oX34WMabTqxhxUXv7d4eqlbhi8mlYdW194ua5cT6ilAtGc5x/m9nI48GpYrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y22zljKzXB5n+adA+l0t7RHwES4cuUxbJ1AbC946T+0=;
 b=Q8XDaFCA1nVg0+vrxT/Bhwm59ypoi/Y1r5VpaplCKBpMKLOFBegwidaqdvW/tySI9DOgiDQsNUeT9UBurcF/hiFYjFJmrCMiD9BaXaDzr4+3SM+anrCpc8WT2NMHy3gslyuiju5PJ9ySr02CsArNDp80ATeecH3O6T41B8ZXj+w=
Received: from CH0PR03CA0209.namprd03.prod.outlook.com (2603:10b6:610:e4::34)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 17:52:18 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::2e) by CH0PR03CA0209.outlook.office365.com
 (2603:10b6:610:e4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:18 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:13 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 03/64] drm/amd/display: add SPDX-License-Identifier
Date: Wed, 16 Sep 2026 13:51:18 -0400
Message-ID: <20260916175301.368306-4-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 781369ad-6ec1-4030-629c-08df141b402a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mqXn1PStVFFd85oPdhKFLINHchw2GVAXxww9J7eZmtHrRZMF31AX39PALI4bCyhwKAFzgC6dpdzX3B65tLZA55xEZEPIVXac8aj16ndMvbww9pSB5HQHBYIblLAX7HZLFFzc0WLJO9QaSJuq5Zcyyprx++x2LyCQR0wUdYCzy0/PFLLVbhAZWP2+JHcuNL++J0iL84LiXZa6MUEZOl2N0d0zoNaJo07lqGUQbNzSyovGy23nTH1AQXzUjxXrlO5w6kXc79CC103HWizP6LTwk1ipfLEmUy0XQriOA8MoFeEKuJZS8A5v2jxYNKW149IB5kWreuteGs6M4Jfv8Nq6usUFGPE/9wldRHhkFWty6sgDYB/i2QV3w/VjJkkX9tuyDn1YkqrN0zwENPsoeDnJPAxd7FtEHPyytXugxVfL5nwdYppFPxhWAheDRSyhYAh7enkEyDP0Zr3v63xSapLO5aOrR+H+VEGpNqpyOHxtghlvkI5wzsjnFEiLjfdmCNfNgP4eQzvVCSfuMRODT2VNJwakNZIbE1VvZNM/xOMr1ltPuO7IrFVrYp8Mh6gQS+fBy5KdF56sWAkXA/wnoNWs1VdtXzcceed/8QnoMIgBCVnULtaUH76aEDnVrnvfv/ezP83iWBld+YX9fraFlthuD+hZXOR+NpmJRrZaIHoGpML8Az8GIRXLcCBHILCUmbHYW2BLiuf8TETf6LbNUpwfUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x8I+M+QnKSSTrSFiaJUUReQc+803k6nMSAuQro7VdRJRmypd9NFBZ+JP5hncIjoNjySoRtL/Pb/WY6G6+tV6Tdk/M6ZzoHeiEumHVWf+8elWHrR1+iMFB6lOv1Wd/pZHIwyrndNFYI5fozBzBASZ78uIkZ7I2KHWMzFRcJ/34B+DI56LsQVF/+cVX+RlEfKErmzFI1sNj6Ron60reUk1JU3bTo9jbCMxCRN/Yu1LHX9mlKGdZl6woJbXdcCOIbpAUmmbMDxhOJzjfpiSbLH0wXQKALa+C5HR6O8P7cxjd4qRO7HTWSVEYs8+pT4qavWPDmQxovX9zYEtGAFiWrsPsTbjUpzZHDBsfgx8F7R7OGPObDibEpSQz2uyxo/twLbN6VzMF3sTxWWqz6edCVqXRNbFsIGW4C2+2Z7TC00Bt9WzbE7QAyZTRVRIZvYJpG3e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:18.2547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781369ad-6ec1-4030-629c-08df141b402a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add the AMD Open-Source SPDX line to dc files.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c   | 1 +
 drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c    | 1 +
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index f88404a37dea..54ef1808ca35 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2012-15 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
index 9e96a3ace207..1e11328050e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2020 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
index f9961a6446f3..d7c3f26777e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2021 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index 189045f85039..9cc5766235f0 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2012-20 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
index 6bbbb8ea7dad..dad429298d77 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2012-15 Advanced Micro Devices, Inc.
  *
-- 
2.55.0

