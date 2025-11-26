Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F849D111B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4E410E736;
	Wed, 26 Nov 2025 23:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CPlpS15t";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7088410E736
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHWLRA9ezsRm69d3WUh4RRC8z0GQYl4GQFB1yjICGoO6/ZrCqTjwb2XnXH3Trfs6y2HWEK3+V4XXfnM48xcMdScu4b+j1VzBMhWWFlDKLwNA2KCo90dtJ4C715vZVYJJuNQeC00QK/Ci3LgJc/QlhpzfojdN+p00e1JMoB00jHJ65aGIRWoVoJ0/+GTiTBA1Nqdv0s7zFh2ko5SWytHIc5UdAVtXHBmAH9sxtAdtafcVoVLlyBALTVHwCGZS/Zts0M+qp03d1Neh8Mv72yq7Pb8m21iAHL9so3Jvhx2fIIBqvpZn+NJk/yMtQvslBWm0/zujiEvraJDjVRCeBfMKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lseAZHmELJvJcnN0jwte+VKxPdWN4vkaXcqnTUVekRc=;
 b=AzO1r4xfbyghv8xmsrL5z/MfQOio8yAaOQB2JymC7pooEtT6uA7AdIaRn6i40Fh8dclFCxLSXyt+OiJMvyrby6U11fSpljgEwgX4fYqljI28vqgDdCwLcQmd+yGlLz9uxlQ6Y6/ma64Dd8N1qZcS+sSa3pc9whb2Y0cDJUBuyxtBGqMIa+4KqKyBA7s+RfXn96W9aNa6cw8XaC4rqDRwuailWu/WUdKkvO9/+avm8AmaE2ZY83HLJNFfGs7Mly920ofMmmjTXm2OBno2sPsdJvCUiRT0kSB2+KYDRoHOZ1h2o/HfaqPFxpRUZJ5yk4+j1zjtYEeYf8ls5x+zEVpaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lseAZHmELJvJcnN0jwte+VKxPdWN4vkaXcqnTUVekRc=;
 b=CPlpS15t5E4oKd6iMIxaGlCUeWQCTP18XeKIz3nbuQmjhBt8ogTybTIdbNceZvDfXIFht/kyN5uBAlSLpxpHmLPVhlRb7pe8HiehEn+/TTDbbCP38RcwwpAwx6ORaMe3nSiTPGozfiKBrE7j6N7eAQpCbBzEPqYCXXD1x6ksraM=
Received: from BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::14)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:36 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a) by BL1P222CA0009.outlook.office365.com
 (2603:10b6:208:2c7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Wed,
 26 Nov 2025 23:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:34 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:06:34 -0800
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:33 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 01/14] drm/amd/display: Remove unused encoder types
Date: Wed, 26 Nov 2025 18:06:01 -0500
Message-ID: <20251126230614.13409-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e842a5-8802-4b84-b4a3-08de2d4072a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HuiXPq5tNCIrtpFA9BphiVzUh7UL33iKnT1rq/Mkc8FtBgyZZdVK37zuRNA5?=
 =?us-ascii?Q?GVABsYP+5SFG/s80OewfQ51eJmVouu6ohF3DC5lCC6BNpAYT3E1KInuiq58G?=
 =?us-ascii?Q?qsYiqbWd12OCHGXbnxtOmdTtNC7nQgZmwi5EO4rQl8bPmdGR7QYEVCceoPNB?=
 =?us-ascii?Q?vgzl6fruBs27VVWiNOdrvaw0V5KCnPrsRCbtdmn02413IFbNGhY9GNRZ9Ykt?=
 =?us-ascii?Q?F3bqUHb7kHmrIZ3LXwzHSBRcJIdYFrBNNyyIv7OXeQ7jLdgJft2nR3AlJOW8?=
 =?us-ascii?Q?fCunOhvZXPSvS27zGu7Xh4SPn/pwzYYaR2bqtkdD4e9/f4Wy1sq5zOk14y95?=
 =?us-ascii?Q?cbs9xaFnw6icDrKplTXFIlBL/P/DK/p/Yanz4j7wWenAN75V3uOesgUByof3?=
 =?us-ascii?Q?sdTfkUVZy7qFsc6LlWIf+ynrHYdH2FPfFdNSL0QiQtqezYdq7nt19HcM8BgC?=
 =?us-ascii?Q?lTNl03AvYfzq9k3XG3rnfzMb+aF6mD4cyJIpUy8wlbWtqSfWmzpx5SqHtgn9?=
 =?us-ascii?Q?wtKQYJCyhc1a8pgbEJ4Kb4afQ49k1PFq4JKOKB1FmgxCya5MqY4AHgJzEQfS?=
 =?us-ascii?Q?B3yd0PQHi123d7Qh1ZIgsbLz1QWp3TZS2evcoNApqprQOvyCMVH2mL4ujtxP?=
 =?us-ascii?Q?6Y8yy/Ev+mjlUPsLkuu2E/kstNIYC4BTpOuEB9h+M6C0+R7hgGNS84CZ2g/R?=
 =?us-ascii?Q?ocxSKjYnWsohNNKseisjDZ1QXNXUkAQ8mdG9rv9e0QjNc0kzkUkXDcSO01MQ?=
 =?us-ascii?Q?CNBHjQQhf56vJ11uQeL+JcsEVWT+wZuKSJINwhV554I5r/9A+Nr5IJGv4yl4?=
 =?us-ascii?Q?vj6aFaXyPHlw6L9QO14IVxYjhr9WiHCZfyaWsVX+AbH+3X0w8dalI2N0hjJy?=
 =?us-ascii?Q?jhV2EV/2zdStb3jQ0eVNoeVhtOsEvsGl/txHDFBEfdN+TilRbdXA0aDgjtLf?=
 =?us-ascii?Q?obQXygdpNcI3THySeRR9FjxoQs3eHrhNOj8dWe7FPKVa4Bohb3jhfMDsckli?=
 =?us-ascii?Q?0qdTIPpPeHhn5D4U9RNyVDxaGRM4i4dJxG/PmxBAD5lhBTb5R+hYnLwnT7uj?=
 =?us-ascii?Q?He1EkooAkd7C1Tda2hlsN0pJWTLxUFPe3HFIABDjtUGEzbU4q13PMChEdOWP?=
 =?us-ascii?Q?VoAnf6pQ4e01lPF9bXwkX380tu3QvyCLDUz32XBORn0VV1CnuhItW4WVPysD?=
 =?us-ascii?Q?rAJ7z+GmNzVfQW/ZBRG1wPU5awGYRyUwbWDX4+fcC8mIrm75746euWBA6lXI?=
 =?us-ascii?Q?k16rhwMSuiP8YhDaR9mmtjT6qetq8uQhBvSQZvkuDQX4NrwzZ+9Yv4OCA3jI?=
 =?us-ascii?Q?/KndzJCFd2xhoHTsb/Zuhu74WZNMIcEYxaXS9kfbVsVfyMdY10rzSa/OPd6+?=
 =?us-ascii?Q?iDLSuw0DbH6BsHpwVJsb9OTe7Lr87f9TvMsf407RtiEGAitm5MsOM+JU+LJx?=
 =?us-ascii?Q?ooavZwc0STBUDRWf+1EdF3PDFcRTl59ILw1iZrppBRVZuDdUo4PMNSCHhB0V?=
 =?us-ascii?Q?EJr4N6SbVY006Bs5WUgBvTHAUTJRYAtdHsjOwoNUvcntTQXNSQukalMBzsDx?=
 =?us-ascii?Q?OUp2yvbIOdGh9xGB1hU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:35.7172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e842a5-8802-4b84-b4a3-08de2d4072a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
We only support ENCODER_ID_INTERNAL_UNIPHY encoders now, so NUTMEG & TRAVIS
can be removed from translate_encoder_to_transmitter.

Also refactor to use local variables of transmitter to exit early.

V2: Fix construct_phy check for  TRANSMITTER_UKNOWN

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/dc/link/link_factory.c    | 47 +++++--------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index e9af184dbe5d..e9f966b5be65 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -354,24 +354,6 @@ static enum transmitter translate_encoder_to_transmitter(
 			return TRANSMITTER_UNKNOWN;
 		}
 	break;
-	case ENCODER_ID_EXTERNAL_NUTMEG:
-		switch (encoder.enum_id) {
-		case ENUM_ID_1:
-			return TRANSMITTER_NUTMEG_CRT;
-		default:
-			return TRANSMITTER_UNKNOWN;
-		}
-	break;
-	case ENCODER_ID_EXTERNAL_TRAVIS:
-		switch (encoder.enum_id) {
-		case ENUM_ID_1:
-			return TRANSMITTER_TRAVIS_CRT;
-		case ENUM_ID_2:
-			return TRANSMITTER_TRAVIS_LCD;
-		default:
-			return TRANSMITTER_UNKNOWN;
-		}
-	break;
 	default:
 		return TRANSMITTER_UNKNOWN;
 	}
@@ -481,14 +463,6 @@ static enum engine_id find_analog_engine(struct dc_link *link)
 	return ENGINE_ID_UNKNOWN;
 }
 
-static bool transmitter_supported(const enum transmitter transmitter)
-{
-	return transmitter != TRANSMITTER_UNKNOWN &&
-		transmitter != TRANSMITTER_NUTMEG_CRT &&
-		transmitter != TRANSMITTER_TRAVIS_CRT &&
-		transmitter != TRANSMITTER_TRAVIS_LCD;
-}
-
 static bool analog_engine_supported(const enum engine_id engine_id)
 {
 	return engine_id == ENGINE_ID_DACA ||
@@ -506,6 +480,8 @@ static bool construct_phy(struct dc_link *link,
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
 	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
+	struct graphics_object_id link_encoder = { 0 };
+	enum transmitter transmitter_from_encoder;
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
@@ -526,21 +502,21 @@ static bool construct_phy(struct dc_link *link,
 	link->link_id =
 		bios->funcs->get_connector_id(bios, init_params->connector_index);
 
+	link->ep_type = DISPLAY_ENDPOINT_PHY;
+
+	DC_LOG_DC("BIOS object table - link_id: %d", link->link_id.id);
+
 	/* Determine early if the link has any supported encoders,
 	 * so that we avoid initializing DDC and HPD, etc.
 	 */
-	bp_funcs->get_src_obj(bios, link->link_id, 0, &enc_init_data.encoder);
-	enc_init_data.transmitter = translate_encoder_to_transmitter(enc_init_data.encoder);
+	bp_funcs->get_src_obj(bios, link->link_id, 0, &link_encoder);
+	transmitter_from_encoder = translate_encoder_to_transmitter(link_encoder);
 	enc_init_data.analog_engine = find_analog_engine(link);
 
-	link->ep_type = DISPLAY_ENDPOINT_PHY;
-
-	DC_LOG_DC("BIOS object table - link_id: %d", link->link_id.id);
-
-	if (!transmitter_supported(enc_init_data.transmitter) &&
+	if (transmitter_from_encoder == TRANSMITTER_UNKNOWN &&
 	    !analog_engine_supported(enc_init_data.analog_engine)) {
 		DC_LOG_WARNING("link_id %d has unsupported encoder\n", link->link_id.id);
-		goto unsupported_fail;
+		goto create_fail;
 	}
 
 	if (bios->funcs->get_disp_connector_caps_info) {
@@ -674,6 +650,8 @@ static bool construct_phy(struct dc_link *link,
 	enc_init_data.connector = link->link_id;
 	enc_init_data.channel = get_ddc_line(link);
 	enc_init_data.hpd_source = get_hpd_line(link);
+	enc_init_data.transmitter = transmitter_from_encoder;
+	enc_init_data.encoder = link_encoder;
 
 	link->hpd_src = enc_init_data.hpd_source;
 
@@ -810,7 +788,6 @@ static bool construct_phy(struct dc_link *link,
 		link->hpd_gpio = NULL;
 	}
 
-unsupported_fail:
 	DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
 	return false;
 }
-- 
2.34.1

