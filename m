Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5EEC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 20:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40A210E3A9;
	Tue, 22 Apr 2025 20:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K6+w7V/P";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6BE10E3A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 20:12:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rb0gpo1/Ak0fJqK/2jGpHDuYpCdXUJ8gQDpP3P48gS1FIsFYt68u57x5Co8Rpmo2g882fBkLz2hfWrwDj88wavpoXK2BehcSZW/X0q2e8g2OPYYYPSEDt/nqkN6YKeell8Px2HU5RfeG6+ft0LvN8ja9/H5RxO3RoFk2uB/yjAvIkCptSc4UnYykW4tDmhFEMHQg83zxH3sTFpv2U3LoLvAQdLcGNGVVHcFw5gnADN8uw4b1l1J5ncA+6h5uBvYIq0N5W3UMKzI9/OA6uX9xMkbvYtO7ewphu8pw7Cq9o7QcgX7ccFRIkgbzjtpZ6/Hq7PYN7xAGPyurn5Fa+pBD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ1cZ18Ymw1LOtoJYKrw4y+ApCQ6TruiB1JcBZ/PMfM=;
 b=IBhXfoJ/rxO4oampnAoZgktggzcspuSMO8AuOB2nVr3FTG0EjKu3Ce/hPJ9ENJPUZFJShEn4jGrETbv/dal1J4SlkFoHqZnxnCuosBBMXrJo0LDfKGCzmcd1Df2e9vmYpJb3Qyh5FxnB85yfJp3UX0v2Fjnj683kz3Mk/s+n1p7qwGm9IULHnsBVQSRmp1CGMsY0MnlERmx/3juvA6cEhoWoC+t6PLa5NLgiy7jrmFglO5z92YcjJpTHc/I4KvFi82tesgGPqSzM1SIOIgrt6P9c6eawFJDdnJSfUt/Oodr2tvTxV7dBzTWMfk7J1hvMaFapMsY7331iE6k4AxmXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ1cZ18Ymw1LOtoJYKrw4y+ApCQ6TruiB1JcBZ/PMfM=;
 b=K6+w7V/PaZw3gUOJDJcDcOjgAfIdD6wBEePK24YCLWsKX6Ave5lZqifucfqOEPD6UnfRFW63B/Vko6vD2hJpI5DSMZ2LSdra38OOK7Y4wWqYsL9hKwU+cHHuF5JAEeyB2DBslxxtwvkoy+S+fkk/9Vzr7d+1VlVM7eTUGZjFPf8=
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Tue, 22 Apr
 2025 20:12:25 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::3c) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 20:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 20:11:23 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 15:11:23 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB
Date: Tue, 22 Apr 2025 16:11:04 -0400
Message-ID: <20250422201104.639320-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8fc8b6-0bc7-4a1e-902f-08dd81d9db23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h4OwNPH1Almhl38eE20FOvfUX8NmxMc7DS8nKMWib5cpcWAZ3tjaqxqtr5KG?=
 =?us-ascii?Q?L17ZDvolQ2EEFcwa0/UdkHTLDUTrAVsAf+dzESLXwkbISkVAyCeUxoA+DQjK?=
 =?us-ascii?Q?XPEQE+fC23Q+mL4VdQUOlFPBqBwo7dhuk/STH0rqxgYj+BJ1Tns2lL+TjOTg?=
 =?us-ascii?Q?u6RP67m+E/siUt76ambqB99gPBDM+LL8DAhM13SLDlYYbrywLrI5YG7Rtnic?=
 =?us-ascii?Q?hhRXw5kNoKydVi0tmlGTVtdWdsRRaUWeu4iU6FxDshXE30LsyigTd9dgWw86?=
 =?us-ascii?Q?Q3wsfoxH/Nd0OJfPTgPuAlU8h3ChT4cua9Nbjfcd3TPQNOy39sESzDb804MF?=
 =?us-ascii?Q?r8XxVx2X1HFcp5lDFD4xdSQyfklxnwNkNbuNreITjPQorQaKiPa3Qg93ksW8?=
 =?us-ascii?Q?7UbmVYSEN8Xq9JwrtV8svf5dWqfVoVWTv98zH+tv27bCAtPfX7lCxYrmsaIE?=
 =?us-ascii?Q?/cHYZBu4wUjykWVQ+/dsuFit8Vw/zbvvhDfKqwqx/ZnU6cUhm/k7HbTcm/aR?=
 =?us-ascii?Q?HtJpDbVgJo+raZ4EpIeEZ5AdV/hwa4OcejeSj9GvKROA78DUmUuVWtzKaMuk?=
 =?us-ascii?Q?bo+8MM2THTDiwTvOWVJaROVp+NT4XQy/JjRvE3VdwhDkmXA1IclSOFBFPwdT?=
 =?us-ascii?Q?7lskPAk+7R0pMBESCt50rTfpJqG6ow/vr1X1++BUtZoMKU274tdfJJSMZ47q?=
 =?us-ascii?Q?KvfyRfVg2wLiigEn9Tbzzq5ivRz1avjcmfB2KwegTgBIXSv3Ms9WCJAZSDJ8?=
 =?us-ascii?Q?ydmIbK4yspMMqQLjMUrvSKhZYfFs8sD/UKs71BKKs6FB+UqAwJbtoHf+NUll?=
 =?us-ascii?Q?SwHj9E7oVo2QhN+MoB2fJ+XfHQXl0iBKdZBN0+D/qCJJxe/X8U3AlqIEEuFX?=
 =?us-ascii?Q?BK53OY+Kk/J51KKJKH5LEwjqH1KHW/XdX1MAGyQyooACnZ89bBaHo1NZDNQg?=
 =?us-ascii?Q?ef6Q8xZjbwPxVwOwluH29sQDg8N7idH9aK/4qN3gd1mGP+pDQ+2NtgNTjjOc?=
 =?us-ascii?Q?rSWJDvB/GsFHJzLA1A5Kus8xNKNAfXIQ5HATCPg3KGLgwTCybgE4VEMb6EFp?=
 =?us-ascii?Q?FZJ9bwynMy4w12HvLgT0GVvBURD2zXMMNVuyv+eIhVNpqqVTBr5JoKpkKtVG?=
 =?us-ascii?Q?Zrl/uhZ5iqZIOZuv8W0ynnMYoa0tSwVGRV1zjoyzpP6WPUvwXp+x7GtNbhLK?=
 =?us-ascii?Q?IrG4SlzP9ELBpayH98Der9Ox6ZatPRhIpqJLABKGEfX1bj+f51xvNa1Br4uJ?=
 =?us-ascii?Q?g414RssYavjFhIjBPKIUtD7WvmxfrnQSBC6nmEPFqJDc47nctQMnir+b65Fx?=
 =?us-ascii?Q?o3ggGrXwk8m8MJbwRonAucgU/tS+YPbp9yVFOGNXLmb7OXq+iF3nJBB69cHB?=
 =?us-ascii?Q?CGWn56elupnxebv9o2Z8F7SNTyHL8I3Ruj53Ofppki1jMNQRoHWGCkvO24pD?=
 =?us-ascii?Q?Rwo2NR6B1oWqQQ36gXYxpmxfRYKFPxoLejsLyfat4tlp5WZzRLhp80uI/kAt?=
 =?us-ascii?Q?iSPpYhrr1D8uDR6HfGcss/ya5FI3HwVdaQRN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 20:11:23.9342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8fc8b6-0bc7-4a1e-902f-08dd81d9db23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
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

When submitting MQD to CP, set SDMA_RLCx_IB_CNTL/SWITCH_INSIDE_IB bit so
it'll allow SDMA preemption if there is a massive command buffer of
long-running SDMA commands.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 80320a6c8854..116932a20b3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -495,6 +495,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 	m->sdma_engine_id = q->sdma_engine_id;
 	m->sdma_queue_id = q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
+	/* Allow context switch so we don't cross-process starve with a massive
+	 * command buffer of long-running SDMA commands
+	 */
+	m->sdmax_rlcx_ib_cntl |= SDMA0_GFX_IB_CNTL__SWITCH_INSIDE_IB_MASK; 
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
-- 
2.34.1

