Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B7BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE0561207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0AE0561207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B3B73871;
	Thu,  4 Nov 2021 20:53:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4380073873
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3MbxFyVosF57MBSBaBGsXwFuo2iVuF/V9vaV5PlC49mBZoGh5bRDlyGCKoEfIemH53ucJsc3fGSQBSU9EqJ+s+K47iGPZT5y0F+SugIBTyA+guJXn41rDU2uwX9pGmTx2rSthWc0WrGoSUqUkd1rfUqlxSnL8SYxeyNkhZ7mX2v0M3EvE9alMeOdTmBnhUeLJ+dRBLy4fqfYYaP49nL+4X7ceYqXR9GQI6IULs+LUTbILzWJXZGARqGExFBrKKKWVSGqSutfPUQjlyBCjVt7JA/E06n6Loaqtx8CSjRw3nemks1Y4qfBnVlY0nFANe7mLfWX9S21rNWxjDNQbH6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqLWlwVp1Gxo6vdifw4wvKFqFUe3xypwSSILxCdKJ/4=;
 b=D3LRYhMhl0xNssWjUHYm93CnxN5VgMoVZYScanTACPS8WmTigHKomfJhGuW7Ovo32342OvNKxtsrbkYiMzbVFGrZt0G1Q+xQnjm6U6BwEzsVXnQClzCBHtTclZrVc6RgQMAN+ZhBk5KtgkH4fa3GoMSTYTQoLe61qkDjdtHgbPaqH2yDR6W76xUJSrOoqj59gxf/NHOWJJUxjRXV5QoUl8UQSReK2OJ9KgRTV2e1VSd0oN+VezfJgEuzLRhLiajAPylbp1pckBHRrEqtI9YHgotp07u9IGTqH6Gx+A/6AZtcCSEA2up7biTlN0pH/QgUge1u3kQbdwQ7xloXpXyT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqLWlwVp1Gxo6vdifw4wvKFqFUe3xypwSSILxCdKJ/4=;
 b=0Maal74zJgNI3Z+7hzZkVUotljMctLVbowMPuHf5Vf3VIRQ9pENYATiYDkH77l10ft/u1Mth1yuqUWBLr3zfAvwB8LTVtv0allZt3aLP+xCfP0SvyZGIWHLh/5wsnBoYWN+JWQAAAqHVeB4tcQz/CTeEqOtjlDtC5M6LO+To+nU=
Received: from DM6PR12CA0010.namprd12.prod.outlook.com (2603:10b6:5:1c0::23)
 by BN6PR12MB1473.namprd12.prod.outlook.com (2603:10b6:405:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 20:52:59 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::37) by DM6PR12CA0010.outlook.office365.com
 (2603:10b6:5:1c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:48 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:47 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/22] drm/amd/display: Add hpd pending flag to indicate
 detection of new hpd.
Date: Thu, 4 Nov 2021 16:52:09 -0400
Message-ID: <20211104205215.1125899-17-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8e6be57-2891-42d1-442c-08d99fd515f9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1473:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1473675E3C08BB8449E06980EB8D9@BN6PR12MB1473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4gLf/KiHjBbd3rQHt0pR9LtLBtEC0ZkXZva5IBWhalI+9maljUW31TpZc8vGTIJsc7pdj0P/4mYwpjAZo2vZVfcxEEb/SOB9fxjTsUHlaMasEqmMw6d0SLefm11ErLjR2H6jwzbLrZKjGW7I08abl7UI3J1DvNMb0S88WIm5Wy4890LqZSAYlHiMLqtaJ+DNmWYrqi6la8nCl+wrtYbOUNUrO3temEFVWS0iVD+j/4thniLNQiYFy3LMIxcSYcT93eYRtNLMSBDB/Oyay4FQGgkg2n3EQzTFJT4dw9mse05rob5nHDXNGBtS7DHqOOsPXijDDpNI/hX/o71p786t+oFniya10lyhEsk6QEC6FLXxU9WYQDD5WBLkn0XvQ768FAmXfZiMNPZOsd3KEyIShfkDQJl/Wv2ipzdzdNLunxekhbdEi4MxGegCo5RpMtwMcYveqAOLJ6XtwPEmhjWKK5KS/ultEmWGEV9/jfIBpwzg2HEaZ6lyRpcE9LHJFWcgupapcTjadO3uiSyi7+f35zRfjGrTa+g94wtjm4Dor6PuOhxT6aEcdaCPf0sRYBuEKoJh//pgm6595lm+qunX1qhjNE5gPLdSDoC87DovOpkqqXZvFb5P9kU/PNjoRSYUoqrkGoSgFC+7ZAfGVLr5LL+a88ty2Lp6UCBTNvG/cQ8AKm7RlNWUKLs7vKsirRDqFEEJy/BnU/fJg8eOD3+IOuLmGuyjpe5lSa6FgCRrmE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(26005)(36756003)(186003)(83380400001)(4326008)(70586007)(70206006)(7696005)(82310400003)(86362001)(8936002)(426003)(2616005)(6666004)(81166007)(356005)(336012)(54906003)(8676002)(47076005)(36860700001)(508600001)(1076003)(316002)(5660300002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:59.4354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e6be57-2891-42d1-442c-08d99fd515f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1473
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
For dpia link, link->hpd_status indicates current state, but driver
fails to capture hpd transitions in certain scenarios such as during
link training.

[How]
Added link->hpd_pending flag that captures arrival of new hpd.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  6 +++---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 20 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c4944ba59ec6..2e2dcd5518da 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -270,10 +270,10 @@ bool dc_link_detect_sink(struct dc_link *link, enum dc_connection_type *type)
 
 	/* Link may not have physical HPD pin. */
 	if (link->ep_type != DISPLAY_ENDPOINT_PHY) {
-		if (link->hpd_status)
-			*type = dc_connection_single;
-		else
+		if (link->is_hpd_pending || !link->hpd_status)
 			*type = dc_connection_none;
+		else
+			*type = dc_connection_single;
 
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index b1c9f77d6bf4..d72122593959 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -94,17 +94,17 @@ static enum link_training_result dpia_configure_link(struct dc_link *link,
 		lt_settings);
 
 	status = dpcd_configure_channel_coding(link, lt_settings);
-	if (status != DC_OK && !link->hpd_status)
+	if (status != DC_OK && link->is_hpd_pending)
 		return LINK_TRAINING_ABORT;
 
 	/* Configure lttpr mode */
 	status = dpcd_configure_lttpr_mode(link, lt_settings);
-	if (status != DC_OK && !link->hpd_status)
+	if (status != DC_OK && link->is_hpd_pending)
 		return LINK_TRAINING_ABORT;
 
 	/* Set link rate, lane count and spread. */
 	status = dpcd_set_link_settings(link, lt_settings);
-	if (status != DC_OK && !link->hpd_status)
+	if (status != DC_OK && link->is_hpd_pending)
 		return LINK_TRAINING_ABORT;
 
 	if (link->preferred_training_settings.fec_enable)
@@ -112,7 +112,7 @@ static enum link_training_result dpia_configure_link(struct dc_link *link,
 	else
 		fec_enable = true;
 	status = dp_set_fec_ready(link, fec_enable);
-	if (status != DC_OK && !link->hpd_status)
+	if (status != DC_OK && link->is_hpd_pending)
 		return LINK_TRAINING_ABORT;
 
 	return LINK_TRAINING_SUCCESS;
@@ -388,7 +388,7 @@ static enum link_training_result dpia_training_cr_non_transparent(struct dc_link
 	}
 
 	/* Abort link training if clock recovery failed due to HPD unplug. */
-	if (!link->hpd_status)
+	if (link->is_hpd_pending)
 		result = LINK_TRAINING_ABORT;
 
 	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) clock recovery\n"
@@ -490,7 +490,7 @@ static enum link_training_result dpia_training_cr_transparent(struct dc_link *li
 	}
 
 	/* Abort link training if clock recovery failed due to HPD unplug. */
-	if (!link->hpd_status)
+	if (link->is_hpd_pending)
 		result = LINK_TRAINING_ABORT;
 
 	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) clock recovery\n"
@@ -675,7 +675,7 @@ static enum link_training_result dpia_training_eq_non_transparent(struct dc_link
 	}
 
 	/* Abort link training if equalization failed due to HPD unplug. */
-	if (!link->hpd_status)
+	if (link->is_hpd_pending)
 		result = LINK_TRAINING_ABORT;
 
 	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) equalization\n"
@@ -758,7 +758,7 @@ static enum link_training_result dpia_training_eq_transparent(struct dc_link *li
 	}
 
 	/* Abort link training if equalization failed due to HPD unplug. */
-	if (!link->hpd_status)
+	if (link->is_hpd_pending)
 		result = LINK_TRAINING_ABORT;
 
 	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) equalization\n"
@@ -892,10 +892,10 @@ static void dpia_training_abort(struct dc_link *link, uint32_t hop)
 				__func__,
 				link->link_id.enum_id - ENUM_ID_1,
 				link->lttpr_mode,
-				link->hpd_status);
+				link->is_hpd_pending);
 
 	/* Abandon clean-up if sink unplugged. */
-	if (!link->hpd_status)
+	if (link->is_hpd_pending)
 		return;
 
 	if (hop != DPRX)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index b732398dac89..d449e72a4e2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -113,6 +113,7 @@ struct dc_link {
 	 * DIG encoder. */
 	bool is_dig_mapping_flexible;
 	bool hpd_status; /* HPD status of link without physical HPD pin. */
+	bool is_hpd_pending; /* Indicates a new received hpd */
 
 	bool edp_sink_present;
 
-- 
2.25.1

