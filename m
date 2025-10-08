Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C53CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2AA10E8BA;
	Wed,  8 Oct 2025 18:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="doAhVBV2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2469510E8B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC7BTB1y4wKVCx9Owe3IMHJjajEC7k9eu0xyWQLwc/sAyO1LV72YdeS6LT70RJwR/TzKOioBMwvm9+rO8aPR5IUeurzaU4/axSbp+bNK5+U5aHNLqugdT0xfsC0e1BPVOCaLuytw7Rz0JVNplkIXKvL0dV7/yVJDIdh9enwl+ANi3Qd7Of7vbmAxayzQkYW1jigYQ6OmgDbNzAGfuBjQ3ufxwqbV1mCmoEmY7aM4HalUkmXUg46XF3Z30Oqa4JpJTXO7PMgiGcJVI5szB32HaNuoeLqrKsM7CladQu/80YXXODKwkz1k/nIuqgzMwSQbemu++Deks0UPOfgcTtc7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbRAt9y6GBPf1ZUEGJTNo9dmbXOvq1lwzYkAgChpgPY=;
 b=D2BzrzeyOzct/P6sSC5PVSJqst9EiGnPPXj24U8v6pUCg5sirtVlc2ZQzR+WJllmzlOGFpDv4xoE+Hrzceyn2BDajwOsqZnA26rUQz8Pl7/OEOO5Gc8YJ0Y68Ocib6KfwApZlkXos+AVdgRyUT72Bsi9EAZjJ0MKp6hnmPq8OtY3uTJ2iqbg5U2ZgiDsk+FTOef2qJlj85PwsUhGtjIYE2kOQ7Cz7QJtBA7u+pUAKvRNBOFN4EyDguPSBc1ftE4AEOdR64cQlJfa9NcqQ3CVIRPu4Mtfah3a6LWnvqV43bmMf4M/WOU+luKDsnzcqZIOfI+8mVUM7EPumcCAWe9RzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbRAt9y6GBPf1ZUEGJTNo9dmbXOvq1lwzYkAgChpgPY=;
 b=doAhVBV2S5CBOLNIdzCSlbg0ityc51tEE7e/tXG0m8wVgOpOQkBKsDZBPfsxVrH0+k4Zqp3yI40SnpS//AA0GMdR23l2qTb6b7URirQ2sNOt/f3OsnFv162v3qh/XxEs63LVxyK2PjJe+o5PcakQH19vV3R7Hflv0taEf5L6qoA=
Received: from BYAPR07CA0076.namprd07.prod.outlook.com (2603:10b6:a03:12b::17)
 by CH8PR12MB9792.namprd12.prod.outlook.com (2603:10b6:610:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:49:06 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::87) by BYAPR07CA0076.outlook.office365.com
 (2603:10b6:a03:12b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 8 Oct 2025 18:49:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:46 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:45 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:45 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Relja Vojvodic <rvojvodi@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 08/22] drm/amd/display: Rework HDMI data channel reads
Date: Wed, 8 Oct 2025 14:47:02 -0400
Message-ID: <20251008184839.78916-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CH8PR12MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fb057b-479a-428a-a0c0-08de069b5b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?roxhSk8xHwV0qz2pbeyO6HCRMuxyKAd8FiJfUmmoPV0tvi1Znf9dStbeTZxF?=
 =?us-ascii?Q?DJhfmigciXJIQx75IujlNXBR2yAJ6cjXEEz0tVsQsFXxGo+sHMrDqt7+yzPp?=
 =?us-ascii?Q?aSXUM7wBkeSCJVmWMm7EIuRp/rCnXVeNORXgU0udBPDD8KeniTvoHuiFfDfI?=
 =?us-ascii?Q?wwKXAzj2TxcAlpYYJh6i7J4P3Mxhy/J2GBYhruzVuir7ik5IyQYJnbp9p2xJ?=
 =?us-ascii?Q?qmEu5LlcJXH8IkOvp2jnHgq904NIx39ZEdQ6y8oFsa+ZqbmNmWY5XF6ImJ1Y?=
 =?us-ascii?Q?M/RCRrF8RsC3DhwRCo1bmASrasht9EDT306pQPlGrpsyBCQuD/wWr7lERzAV?=
 =?us-ascii?Q?wFbs8t3/eb85s6gT3d+T+Xh3iYrClwVCPK5LNYRvBNiRHGdYLF4O2VzR9S+H?=
 =?us-ascii?Q?xSZGcLNeXEJ6OuVm57THRfIJ9xAQG7UnV7GpKDlqhj3AthcI7koF0M1QP+Au?=
 =?us-ascii?Q?9NDI+eh1COQJcOJf46UfgUaOj3gCSjqsr+w5atT0dj6e3lT+msE42x7DHNKc?=
 =?us-ascii?Q?zMgOckgo4R84E9tbUF0YfdLmUKPcXDJCIaaxeCOhCy331k7MHmfmye1cCSf6?=
 =?us-ascii?Q?OiuxpwQepEqo8dmnBzAS22mjmQX8162HzbHp2f5NfAUdqdw1KYRcYgkjQ4Vc?=
 =?us-ascii?Q?XJcS1FXU4eVP/Teywt/z7dMm/+/Q4MbzKuGE/HMA2M2RrN6xizSJ3CceuhGS?=
 =?us-ascii?Q?8F3VLVe15H+Bi3IWq9NHCpD1EHJyqb2r2LzS3oZVQRQ5h0f6ez5CuBHtMBUU?=
 =?us-ascii?Q?Mjbprpgfh6UPRRff/KzGTE3Ex1jwhj6FN0mV+SC9iQxQ6pV9prK1Zaf3eHHl?=
 =?us-ascii?Q?VgLE/d0xASJBN8474oKzvj+XdG3n4HYbM13YOMSO5nXrj9SYPibUtGuxLDal?=
 =?us-ascii?Q?0QFfDRZxFR3IclNHaN0w/BAWazbtRLcnQ+47k50FVFDXm1iLGJqyB5QxJbwm?=
 =?us-ascii?Q?Hq/K6T5kqXWgl/lhc8+ghWvtXzEv5vXB4MD8ltyY6U7UDgMaZ9xvMqeyritF?=
 =?us-ascii?Q?jUCD8KAPKg8yunlzTOcC/S6ZNqQjvtCcDt0xJTogJH6rUHQS3OrFbwhGmMxK?=
 =?us-ascii?Q?9Ly0p0mkH/E6dzhI/hfbGG48tgdpXhUscKKlBWBW2icCgxBgTEtXXidEt8Jp?=
 =?us-ascii?Q?Qj4q6OLNHNsH8zMPmLb8OCB6PbRuxaFmZXQvrt3HIgb/CQjExs3dUMiskwuq?=
 =?us-ascii?Q?L54O9GxyIT32bSP8TlqbZL6SeMxRIeevimwnNRfKatKLDTM8BkIZrl4PuDun?=
 =?us-ascii?Q?svucKdev1Eg90Zt0L7Wn6fjO29g7DotsCzF03A4zhe+oqkcGgDtGB7TxUeBT?=
 =?us-ascii?Q?0IEUXsaRJnPQXAvSnfqxmdNInNFK5mmA0NXb7YI/4naWzo9U6oORI3J+/U++?=
 =?us-ascii?Q?hD3cY3r50K6YBQbMlk5UDNt86e2I3Bqx92sEaVfwkNo7WvTaDC/HFlkqEUcm?=
 =?us-ascii?Q?YE9hQ9Fb2ucDrSQC/rePTifRjiY3T/7JNcpO+i+lnoyM9TPvAP4ty1jV2ijC?=
 =?us-ascii?Q?lm+A/e5QF39bDT/0BNh4PS1nwzAZpyXQed4Q+YH0G3Yvx3zXuN5pl7O+6uzN?=
 =?us-ascii?Q?O+vy5iYwm5mhpXWpby8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:05.1517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fb057b-479a-428a-a0c0-08de069b5b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9792
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

From: Relja Vojvodic <rvojvodi@amd.com>

Fix the HDMI data channel reads to respect scdc_present field
to pass compliance test.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                | 1 +
 drivers/gpu/drm/amd/display/dc/link/link_detection.c     | 4 ++++
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b5aa03a3e39c..8f8ccde7ad94 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -212,6 +212,7 @@ struct dc_edid_caps {
 	bool edid_hdmi;
 	bool hdr_supported;
 	bool rr_capable;
+	bool scdc_present;
 
 	struct dc_panel_patch panel_patch;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 85303167a553..82a9e52d5ae5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -270,6 +270,10 @@ static void read_scdc_caps(struct ddc_service *ddc_service,
 	uint8_t slave_address = HDMI_SCDC_ADDRESS;
 	uint8_t offset = HDMI_SCDC_MANUFACTURER_OUI;
 
+	if (ddc_service->link->local_sink &&
+		!ddc_service->link->local_sink->edid_caps.scdc_present)
+		return;
+
 	link_query_ddc_data(ddc_service, slave_address, &offset,
 			sizeof(offset), sink->scdc_caps.manufacturer_OUI.byte,
 			sizeof(sink->scdc_caps.manufacturer_OUI.byte));
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 267180e7bc48..5d2bcce2f669 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -549,7 +549,8 @@ void write_scdc_data(struct ddc_service *ddc_service,
 	/*Lower than 340 Scramble bit from SCDC caps*/
 
 	if (ddc_service->link->local_sink &&
-		ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite)
+		(ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite ||
+		!ddc_service->link->local_sink->edid_caps.scdc_present))
 		return;
 
 	link_query_ddc_data(ddc_service, slave_address, &offset,
-- 
2.51.0

