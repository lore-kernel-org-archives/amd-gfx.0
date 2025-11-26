Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9733D111A7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4303210E738;
	Wed, 26 Nov 2025 23:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZMha1cT2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03FF010E72F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dz+9QMBYlrWzIh+EIFXZBqTPdmRIJQIk8WW4R9lcQaqiIzAHgPYpFta90Ct/Z1aQKE5JBV3K2IIyK3BRoHM9dwu06EslrBMur4shRdxCk8UOgEQglNVOEV44bQbxhprPrIwbyRQzRF+Xiro2JyDjdmK4V2Xe6/Q47pDF8bIHe4NIL1mw4gRK1sLcRmlQIGJOUwfPpH2Vh03QAh3ldePOKoT1TJjeMAr7/qT5+iFZhdESNp7HE7D79w7bl+7Cl6WrzaQAPb9pV/cEPpS2s8yQ78nVc14zciEVqi9bYDMD1Lsu30FCI56NJarxgveiBQvgpfByCQFpoNPrybu6aXXD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+bluL2ggzexmJ93E78iq7fRx7Qhoh4CFimpl1zxdYY=;
 b=q4B/b65d4ul+iWecxxK/Tx01I0x8PBWvkO///K8KifI9/i2WNX15tvF/Bu2mjgXiZ2mCpdzQ/aXEG9FG42gcLo/Lm22nkNCzWYbNXZ5JH8wKxN6WYm3UHkci09z2bw4y2kP2ozErMkiAT+rX6YxPNyKe3EVqpJRA6Uf0HENjMKOsckUk5p2mU9LxaiF7103xyBfA36NL7Erp4iDtFTEXSMAOAIGhQGOySquBqNDdIrc8fC5kRou/kfEVQnPSCjP5Ps94grwuD595MwvciPhh2lFY404Ie1XMzXtyJsRj7Lx/JtH32AdRn3IKJWmO8Yd7cMlj+NbsJ4U+4NkKAcFhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+bluL2ggzexmJ93E78iq7fRx7Qhoh4CFimpl1zxdYY=;
 b=ZMha1cT2sHe0SnIEy+0qMwcjGSDqYC4I4Xt1ToZLfQsVj5VTj4CO4ONr5AKzJD0Nm8aetNJSZfnd2jtiXWl1GwX/kUPH5ns9Ylf4Yath117lDHS96W4OPGrkbvS7WPsfladabdcgkZAuIDhQLMlHIHyU6/+03/JPmiBUUOS2Nu0=
Received: from BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::20)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:37 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::cb) by BL1P222CA0015.outlook.office365.com
 (2603:10b6:208:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Wed,
 26 Nov 2025 23:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:37 +0000
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
 Transport; Wed, 26 Nov 2025 15:06:34 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 02/14] drm/amd/display: Use local variable for analog_engine
 initialization
Date: Wed, 26 Nov 2025 18:06:02 -0500
Message-ID: <20251126230614.13409-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 952ce844-a115-4fc8-bc12-08de2d4073a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Y+icLJivVmL7mRXXAoQTfcLnHhn26a1zDZwFdjygRN9ahhUG5yTR+BF4GZu?=
 =?us-ascii?Q?wPci53eIPeZ+oc5BbMBrFTgXhji05Yl9aIj4HFa6S4rX1+rgLr0aEXgbOIQo?=
 =?us-ascii?Q?qR06My/h2vcVvdGrauT5cYJXGLmJlHxSra4so7P8aR9QHB9VxqaH8WTmU/dC?=
 =?us-ascii?Q?pxyzqWH+0gBKwCisdtx8QlET3o++GELXrJw/xd6kG211XWjg9AWzZOLD/mnk?=
 =?us-ascii?Q?AFlViLbrknwds2jkEr1ktV/jb2ag/i8UJ7vq+yaVeZRRKLQ3j7SAK4KIJ3gu?=
 =?us-ascii?Q?6kdsv5TD3HTycDIDbBEBLDsWFe6fbhRf/+QTShCQLg4zJqlh3jKoD/g9DaOU?=
 =?us-ascii?Q?b3emNvFrk/EwL8FpYkwT38ElR9UiWmGgt53yK0dNska72sD+BN5Kx3d5BVIw?=
 =?us-ascii?Q?9Ai5ddll0k+5jM7MO64nH8ywt1MO0+PC6omURu+jtjOwd3e4ArHYmBEeBVBe?=
 =?us-ascii?Q?q+HGQT4llG2w12TP984pH6TYofQ2/mR3YN5eph/XXBCQcKy/IPpGZ5xDOcgP?=
 =?us-ascii?Q?dPjk23aKjGK1++RgWD5Za/xdLB4CExao6DejPv9TS+t5Pb4JObqffj2E8EdK?=
 =?us-ascii?Q?m+T6UUjrHl7Xl+SBAEiyeHBpGaBUAjPpSi9jNUyY5nJtb/UtBC5aQbk7bHR7?=
 =?us-ascii?Q?Jo9MQmBM5m257aD2Z2J5t2odTI0c36YrNvG7HKdDxiXX0ZXBsBpmL7ce9IsW?=
 =?us-ascii?Q?HJRCC6p33XpTmhuHQeQZ1tzm1Bfo9qvAeN535k6+XHKc83rA3IL2FKksh3vu?=
 =?us-ascii?Q?cYgmLmGESXTC0ukBJB8O2+qU/hqeNhoY7ojn7VxlLxHEqzPuRkLs4prrNDT1?=
 =?us-ascii?Q?epXOLKAmYUFxk9qb2lEd3A5EN0FjgpB3XtcsUXGb4GWE3iu83YlIYEvinNTY?=
 =?us-ascii?Q?KXKSRXIwPrKIyoKCNCl3ojgTuQmGZloerV6hBwwI5gvmCmiF+B5HLQV0v8ro?=
 =?us-ascii?Q?0fspErMtRsdXWOEeQFNyX19LK32iDZgdrZNMz2vvIAIQ/20HBGw5w7Kec20l?=
 =?us-ascii?Q?wWq4N9nQ84dyuLaYOBJ5/kRJao4FF+PK6WWsYyMmua4DlN1vlerpXQjkgRU5?=
 =?us-ascii?Q?a59ruDQKqqyx7DAH4s4kSmrrRlo9Ar6lfPdV7n8n1kcvCkzpkIKcdJt2buQY?=
 =?us-ascii?Q?TnpgNddqw4HknIileXG3B1HXxaYzAbzbdpWBLjKFTyevKRAO3OZE7YgX/XW7?=
 =?us-ascii?Q?+lh+ZqAxeONxtDyIuIQPDVmX5Zwh3XGneziRswvCa3vuZMf09IoP6qA3vVJ8?=
 =?us-ascii?Q?XPkNZTOrkcaoZiUyNy2Io9h1xHMPo2WbweUDH49xPi5f2IdwpLMPbHbhDO/Y?=
 =?us-ascii?Q?ydb2Aj4b0+9GW5iIkrOv5Vw43EUBE+wRdhAuReHAg7xssM4lhVxAVYwGSxNn?=
 =?us-ascii?Q?CD+JXPGPNO6p4RItTF1NnM4llloUxlcAPrJvxy3jkRk5k7hy9ZdiAisxo/0q?=
 =?us-ascii?Q?rE+IPokE0FXeZeqe/cvLn24UFoxp0N05/Q0zwhf040LJx1VIZWup64lGLI53?=
 =?us-ascii?Q?vnLtlvy90qTBRBJB2Z5IZwfHiosrROkStMSrSN1ccUMKUfbRIFFx4J2vWk8n?=
 =?us-ascii?Q?h71359MfxCL0LftIrkw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:37.4282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 952ce844-a115-4fc8-bc12-08de2d4073a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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
Use local variable for analog_engine retrieval and check if it is supported
instead of the struct parameter.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index e9f966b5be65..90a4f37a5da3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -482,6 +482,7 @@ static bool construct_phy(struct dc_link *link,
 	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
 	struct graphics_object_id link_encoder = { 0 };
 	enum transmitter transmitter_from_encoder;
+	enum engine_id link_analog_engine;
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
@@ -511,10 +512,10 @@ static bool construct_phy(struct dc_link *link,
 	 */
 	bp_funcs->get_src_obj(bios, link->link_id, 0, &link_encoder);
 	transmitter_from_encoder = translate_encoder_to_transmitter(link_encoder);
-	enc_init_data.analog_engine = find_analog_engine(link);
+	link_analog_engine = find_analog_engine(link);
 
 	if (transmitter_from_encoder == TRANSMITTER_UNKNOWN &&
-	    !analog_engine_supported(enc_init_data.analog_engine)) {
+	    !analog_engine_supported(link_analog_engine)) {
 		DC_LOG_WARNING("link_id %d has unsupported encoder\n", link->link_id.id);
 		goto create_fail;
 	}
@@ -652,6 +653,7 @@ static bool construct_phy(struct dc_link *link,
 	enc_init_data.hpd_source = get_hpd_line(link);
 	enc_init_data.transmitter = transmitter_from_encoder;
 	enc_init_data.encoder = link_encoder;
+	enc_init_data.analog_engine = link_analog_engine;
 
 	link->hpd_src = enc_init_data.hpd_source;
 
-- 
2.34.1

