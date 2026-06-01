Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4ECCD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC10112DCA;
	Mon,  1 Jun 2026 05:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AMdlChHl";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE30112DCA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZCF5MrF8ndfNXkE45w4Hb3w12j5whtdBJCZxK0SCwRhWM9KRlxHEMFot4UA3vp6ySQQD/i+gb2pPnnDykbKPHeBLhdlGW575+Hu2POKkt/5e7YdyzwfwSm1zPZLn+Wi9IdVymrX/wx4zgWGIVcOxBoW9XllHIywphKPOMEWefUyHVG+HHnEMEwcL3hGJxFBWZJl4lA7fGbQ4HTJfcQ2NL3ENdsUMd3FcQ8Qgx3Hd+luVJkCBpPiqpTP4G/m09WgzpA2Lreo76Ct5BLSYa/qL0Rj7Z+3pn/QkNRwahvpdNkdKr13NLERd03nEVRhDpUv69qbeipCI8AWARjPP4qqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDQHSIezRpJsMQAB9wUdgmZMi8Q1/hqzJDlZUgA3Izk=;
 b=l6V7CkZsG2tTtgRnw6jEVxIxxQMj2DQIh7bFExC0o7UK72nAmrsRUH5g3AUqMusbmLwbXQDAnfm2gYqNTZqnFbgln82hCqPQjtitRR/2ruOwZQ76ltmxYB5G5j/mNKHrQdftKaJ57lclgWYJ42erLi6pPfaUI0yud19JEXl36IB84hS5pAcBCQMc/vyeWMxEPjcc/ZZCPNbwUhLojHXYJlWBOv+WxFgxsq1t4OJRp+1dwRlG3B16RtHrFqmY+ccgTVYRNzZjoAfKsR/B+77NfNWe4XH8zGCkkTerecNb8jtyvNxqcCNVmN7pF4ud8chfcEImc4e0s3W4WP+7x7utZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDQHSIezRpJsMQAB9wUdgmZMi8Q1/hqzJDlZUgA3Izk=;
 b=AMdlChHl07VXlm3JzIFgrRSB++oKKXb2r+F1KsFuOZ0A0HSDsWJ+gk+tRCIkgkDy0zmRn9iWdeVCMnSbXK7pKbL98Ojk1zmMH00hD+Kgef+zpg59/Q6fxwJhGAVOrZpzVzxqXKCJvDee+4+3pXDIlIAMsIHLda/22wybdt1FuOo=
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 05:53:20 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::5) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 05:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:53:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:53:12 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 21/42] drm/amdgpu/userq: add mes userq reset callback
Date: Mon, 1 Jun 2026 13:49:07 +0800
Message-ID: <20260601055034.3700921-21-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b83a841-1736-4b76-6b7b-08debfa2153d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7eiBmey0cmdJeoGCDpd0e0S0/1MOTG4o3ZGOnMtzcMYpy/GlwiwlN581zVRNnQ4bUIlqFK1oRHBQHGvd0AANUTSqsSJuZYiO158upcBIITGeNipD4mXRJI0FPD7aHI3S38btuB2lrMn6/lo4Zc0MCkwejp1M2MlEhPdmetGtIw7ACfxd/F96aXWFO6UkFpRjv7FrgA5+2xErsWTezelyYlo4pml4U/itfXyk0EskSYzdVsOF/FxHmh84s1XAxoKvWYZDvUye4E3fPoOlXItrGI0+NvUytmvTMqqXRzhZ6ShOSA6Is0NHUaDoKRk8s2DKWf1TWRilrcPA9+CAIC78sH1WRHesVnT35K70+c2dKUWeF8AQJrHi1Aoj5kkMFuyPvfgiOA4T1CoxaH5Moyc0y/oSxpzYWKm8XMu/ko0g2YvgQ3NhFuqfOrDER3SPt9aw3e1H3Ig3wo1WvqCmu0/hLL52ETTJNaOp3ZZNmjO6DYBnL6KftfsmpP61XGq3qmh0H97s2gMrZJTG+0Z1ilcbDuFU+VGmCdAm/0M/F7yxmBHK/piFBJTFIg1I4nRhrXdD+EAAOcs81M2FduUghgWZ2P4eqNg1HexwpYCGPphLLnhbBjEK1Erl+ksL9W6Urd95hmQvNbhqIixyhWlUHXBVNxc/s1niIGRutQqFXmvdUhwt8YZnS7JCp/S6l115Qw8kcv1IlXCY4SiiUQACLoveubEtg0/gjVk83+tWX/Zg9PA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 67+Y7A8Y3VzNx32Hr/dM+wpz5Rmktz+PcdWP+5KSbRMgayZN4hMWMKbpkv+2J9HJZhZ+jgKd701YpmlH5/GfdWnjtyKklCyp/3Y/9jXfE1ctP9lZB+HGHZtA/TQw2mmjZsml8XJbU6+gjjRvY9lYvm2KYKgXmZawXZApWKW7NbEbmfRcYSf31Y285hydUXY6GoOlRRDTpW40JD3vQXVNCkmia7Sb95hxY9PNlVf/l8E9Y/DM81HZ6YEtNQRczKJsKdHtkwVS3a/LLGk1BYK2ZGhCmUGkePrAJUORfnI87/akN79mU1Eil2+UWnGzKRR2bilCrgrL8204tx6Ntvd/WfnE9wFe+pGc8jEmazcdSAQM/v0O5U2Dts0G7Z6jtPnisqtTcvjcYLD6Gv96QXJZ0vQ+lf0Nyg4neOyREH3onkYlDFMWwqnYxnrJqPvxd758
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:53:19.4716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b83a841-1736-4b76-6b7b-08debfa2153d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
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

From: Alex Deucher <alexander.deucher@amd.com>

Enable per queue reset for MES managed queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 14db2124ff81..4f285a8218dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -177,6 +177,26 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
 	return r;
 }
 
+static int mes_userq_reset(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	/* XXX: add a FW version check for SDMA per queue reset */
+	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.queue_type = queue->queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		return r;
+	return mes_userq_unmap(queue);
+}
+
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 				      struct amdgpu_usermode_queue *queue,
 				      struct drm_amdgpu_userq_in *mqd_user)
@@ -528,4 +548,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.detect_and_reset = mes_userq_detect_and_reset,
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
+	.reset = mes_userq_reset,
 };
-- 
2.49.0

