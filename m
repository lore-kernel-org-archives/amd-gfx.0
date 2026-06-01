Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CDCD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7313112DCF;
	Mon,  1 Jun 2026 05:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xjq0uXx4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010070.outbound.protection.outlook.com
 [40.93.198.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED1C112DCF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txeo/7daLmo4AHjd5MFNTzGvITsHE7L/zdtEAtPLyKg3GKca+Jo6CSafuuqWS4V8XrRBO7dHf2IVdLPUQa3rv7AD5c68AsE1Oe5llElJZyjUGPP54Om9ICJegj1hSkggZcOCjEY4TSG6EhWu+V/tWFdUQJbBtkgCbPiJY2jLUO4/qydYYPSONIKbkLvBJaLdxU6iUh7KJ40FKOzPuwmUQOhCrCIEVEsNrhXhW0XsJvkegENYoF27l3sIpu8QeHhwS1U6kPqhu3GeWDIdbCp9W7S+1zb8rOGDUIalcTGzsR/08uUpwbs8e0ZU1pXjm8yTMvxjcKHUJcOwCdJLA+Ys9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y/GGNNaNslOE2cpDVBUAC5vMODCTB38Of2RCVE9bXc=;
 b=EXhboFx+uDYe0y9L84FYeMyRCwTE9KnCblMXFuHY0/UzL4Rb2D1y36OFYoRdB20uekF2l82K3KUk4sv42HCERw13rylsJYM79rRYrlI7L6mpyvKPzRFsiAoLENh3jwyangcl1ateDh8LiAyDNTxIuroFxEQypn9/38ZuwyUW/6bdAGfrsa8zsBVndOZuXJcE/FDhY/8ZbtOTl+D88aGhbxwjrTnCxRUvjjNac3ZkMlhGprs1XBzw1WOnKMvKgq2okyEk4YGU9ppHme7yymT2Z766yMdrER4WUcAT47B/jBaAdwzurptPxuYiQsz8aBDyDkqSUWwKOhpbNAC/h8DCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y/GGNNaNslOE2cpDVBUAC5vMODCTB38Of2RCVE9bXc=;
 b=Xjq0uXx4y3jfPh3Sybbuqdt/2je1NtR1H6GwTmyMXeEZvkhxclONhy1yTDgLRdOktwwxEJkY6vGATU+KK2K45y/NHEHDr7jejA4vXrQ5Zq5cY2frqPgJrQ7hR7FiryKG1+yseGYxDf4MX73ActtluoIS/Li7bfsPEejOOqYNLcw=
Received: from DM6PR06CA0084.namprd06.prod.outlook.com (2603:10b6:5:336::17)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Mon, 1 Jun 2026
 05:53:47 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::21) by DM6PR06CA0084.outlook.office365.com
 (2603:10b6:5:336::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:53:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:53:46 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:53:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 25/42] drm/amdgpu: Allocate enough space for hpd info on
 gfx11
Date: Mon, 1 Jun 2026 13:49:11 +0800
Message-ID: <20260601055034.3700921-25-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 75780bc0-5285-4141-1df9-08debfa22596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2Qrq96LqolxUtMYwp4/r6TThHn/Vd2hXqWvJGK4vEag0n2VhYePbHbyIQupNiWsryk9t6VCclPaxFqZmySFLmweK3tjH4zk84TuldKAEdpJBfiz+KyWrAvtFE34HkI9tqRLuzy13a/4xe+IqowCWytGCQDIiiQ6CdkrIsgfl7wtbtiqHsIAGSXg/+LG7N/UX3DQs1pZwjKbwVYHB1fFGdTiYs6nbJBhgHcaNHjTyO2GVgfalwxYM5w52Tt9MaA1k/tFj/j0+M/lYqYfTGMikWpm7rqZ4wXCVMmuvqhLvU37P2fLK/R/xMFF8JqTKwrKfU9KRyYQ537xcKTtKCrJcb4JS1rJsm5Im7pY+pg0Qp9S2X6UWQ4o7lUSYFKyefpAbTH0yg9zf2y/lmbP5S7rP9bQMUyptz2D+a611b8+em4iqVr1bqHx10pKGvEG7pu/4irxdLm0/9sfwBprD2fSheAUagbAsC94cHAS/uoV91HoTStizK2+5BG1GmQ3JrXUUtxicUuIblDUbKVC+nhhHCPPHVJBpqECN3dCj5zMwFmZpBqO+KzByprFMMqT9mn85YrGb5rd/Z6YN1eM2VgJ5x06y3cFaAp8KJsz/pc8EkS6GT/tf9aANVMcqEzurOGCoVaGbo5jhsPK3FJdQrNTcA/D58ZqUzUMrnG0Hu1x07Ova0IAkoMd9h0M+k1mYEg/4CT4EDKWE00MQlMzK+flj/DPWNe+feiQIQuRRAtar004=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gkOv8YoKfhorIxGhD1pRWoHbca8eGPmWz8lHxI3DLuxSeoohrMjDPHEN/umHE6Qa86NW/iGa4Ussk1cE/Qu1KVy5Yop1MP8oVgS1CEG8r88YtSag2+JhVc+71QEqrddtio1fJvJ4HjsrnKc2SKUyonxHbDdNliln5U59NYIK7bP/bptqT6krBgxxYMsk6iOouNTxcRGcv11n1+miti1j3rKs1sfHYAWvkS76y3qZkBeyiRcgu91uK/iznQFN4McAumt9kMIDFwIMLSnckZRTvYJnnUNmILejq5QE1C4WkEJMI2ZxBBmGV4z1TNVDZZyTLef3wmb+WFATNj+NKgKuoGHu0ttjWWojCtji3rXUSUfb1XbZ4hGF+wUbgrlc0HOzE45hbGm4Ppmk4mdKSkFWus/mAUlCLgcDAapcGfZT5k8c0EZACIozQ6BRZJHmgbG0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:53:46.8644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75780bc0-5285-4141-1df9-08debfa22596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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

From: Amber Lin <Amber.Lin@amd.com>

MES in newer versions on gfx11 and gfx12 can support queue/pipe
reset via MES.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ad1b620230a9..370e8d159b6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -217,7 +217,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	if (r)
 		goto error_doorbell;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 1, 0)) {
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
 		/* When queue/pipe reset is done in MES instead of in the
 		 * driver, MES passes hung queues information to the driver in
 		 * hung_queue_hqd_info. Calculate required space to store this
-- 
2.49.0

