Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C5DD3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE5C10E4D8;
	Tue,  9 Dec 2025 08:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ylNjgZDV";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C10710E4D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWeKpqq9Acphgr3oc1lhPH34V7U8fVIADteQdkGT/nkH8YiuWVOTcAEjZG8uxfQo/Xt5VgFt6WIEGqqdzZS/OEajZzy6UGd9JIet0Maz2PV5Uae0CUL1+mm/VFFgj/Me+1G/GsdCqH4H2j9vmCc2cbAg0Zh7vYHjcKpv1VKPKaANzuNexmPuPPOxlh2R8D4TCYiu31EL2geHL2hEFQKuCH+O1lnwSYzfk8ROQPNeGu+dC9lVWXBqD1ILV+7fhJ2lMqXWTKpo1AzMkaZT2pAhLgWc/IW5y3Uqwyh6m/uwu8mGlHhbHz7Kr1V/Hva4Jp9N35WRjEnOmlNLj0y1ek6BTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEll8M06i3yw5ilkXwYsQznwedHALkyy69mBqhxFYck=;
 b=OjlGRaMWzMSZGhMAubDU0BPp2WdC1dhjbvqS911e/Ut/C8RNf2S5RHcuKRmd4BxJWPm+Bv2aJgsAnSFXP7DOZlcX8uJM5rkjhiBJ2HhlOke5PuhoJbmNSDsZj14xY/gM99U3O3mgewxa0KvH7OhFlmUdreMuF79YLb7n5riS+rvnD7+0/bTOOrpX/i5oeAHokMo1EBEUC1Qoj+HxCz80cEhgQb1ooe6wq//mdQNXnkgMwT3mBScGS/MuHnSmYo5skuNC75NHWONPoD1i5kIynwM2QU/r+yk4HKJT1ZTcW033wY5xMzoxswn4F1cAn5ZkVDRmcyYnzs0ZhIq0zzR2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEll8M06i3yw5ilkXwYsQznwedHALkyy69mBqhxFYck=;
 b=ylNjgZDViA3VdsmsIn3HggLGu40yYFqHmMPsa6jPoGRJ/AerhzYhUjYRZIsMkZeeSQVU+izQQiQDIETaLtnrYucdyyM+sKvSfL9Ah4+36cJRbgbDBqze2Gq4ULG4o62bwRBMFhnLPQ6ta7n0sY3w/Vb/gBtW7WxVer96Y4ZHGb4=
Received: from BYAPR02CA0019.namprd02.prod.outlook.com (2603:10b6:a02:ee::32)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 08:58:13 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::5a) by BYAPR02CA0019.outlook.office365.com
 (2603:10b6:a02:ee::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:58:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:11 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Dec
 2025 02:58:11 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:58:08 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 09/15] drm/amd/display: Don't disable DPCD mst_en if sink
 connected
Date: Tue, 9 Dec 2025 16:55:12 +0800
Message-ID: <20251209085702.293682-10-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c80c53-664f-41cc-18eb-08de37011540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LLY9aRCNk/Efp3gLRHHhHz1Js3nRB814mBizJQEHe75nMy9Ne6tvA3HSHVSN?=
 =?us-ascii?Q?UaeprpMrAJ+vMVGwOgjv9dJyrRhlrqP17JPGNupxKaCdTMzw+mA3iMV+YtxZ?=
 =?us-ascii?Q?WWz2lveKLG9hTvIQz5oZk8t46/Ig7o/Tg13iSaY7vJ4t9FYCg+zLuB7tkWhP?=
 =?us-ascii?Q?qpvyT+xDQeBSID80CoE6SpdW2FpvB568W0cB/FrxkeGsrjCcT6AZsKt+TRIS?=
 =?us-ascii?Q?CVarWpctoQ40Z0JWti/qzvzgRHn4EFFfgxKSlB/oogoYZ/0AY7FZfsuFgic2?=
 =?us-ascii?Q?Tju2P3kqVFp6IUeoN+8BdQ8MNXChvxOw7qz8UooQ80EHLFGXoaQYr8C15vpE?=
 =?us-ascii?Q?rThr8UoiMdGZZ0L2SsR+ksiKlvZgSWOmLypkj3Tblur2JAZVSq2O74ASMM93?=
 =?us-ascii?Q?y0uxO2kPHZwOyLxGZ1ImZ6kZ2kSBJ7Bmw8D2NHrnyaYpIE5K1P8wILEp6oBw?=
 =?us-ascii?Q?CnvoCjtMtfySYVtaWMvOEzvY6JapRJXekMVTJpOuRAooaeNALStgK6q4mA3o?=
 =?us-ascii?Q?ItUGJby+s0Ehzd5YBBPTDKPzr5xuz5jwa5n5kijiSi+H0BR+05KIOQmQQPLi?=
 =?us-ascii?Q?5JFlpDUGGMoYrm0Y7937AFl11gbBHvMGCz5pIrr78R68eTykS6HUM4NJ2mys?=
 =?us-ascii?Q?hxE4WIsSq2mqNNd0shEASdatbNVcc49kSvtDPknYmua+cOnoSadvLK1+P1jM?=
 =?us-ascii?Q?Q2CsKDc+Bkih7jjvLgO9rTX6kGLR87kvvI6KtOt+LIploGdAZzjeB19tWDAl?=
 =?us-ascii?Q?FEJQQ5KGIJZkt2YtV1Cms1wNCqHXdcJVDyylyElcjvafnsLRLDE4RvxMMxF7?=
 =?us-ascii?Q?rkXB/j3iFuUMhgN8fyYl0m4MmuT8RAwcyhuk6jR/qQR842HYy+uT3act5Ceg?=
 =?us-ascii?Q?lK6AZ16zL4KTYdvU7IpEM1mvZU9iQ+xzCX1vDNssqbnBVcEy6LkPA4o01rt3?=
 =?us-ascii?Q?Eq/+PhtMeyFfkkw5ZPYXtLVrS+d6DAaL7Ysz3yZB4stMq35SLhELxoP+IjL8?=
 =?us-ascii?Q?Cyjle52Dvgsa9oTLUI00uPPO4pL+4AdEPnuJgZ5szmy/FrvS2q2dH3hsgnTu?=
 =?us-ascii?Q?xGfkjuhyLSQNVP86f/Z7Ba90w+PmyCSur1BWWuAQqYjZGEpkQ08WLaz11uK/?=
 =?us-ascii?Q?DumH5phwiYtNvMgYs3mbnA8YoYDZeVsGHHs5rn3TM5noXEx1c454/mAwG+U3?=
 =?us-ascii?Q?ua57WzGV8oI2X0xvW19OVMOLh60uyraucFGTFy1sHHwH+/w7Dgu2dHUc62Ga?=
 =?us-ascii?Q?+AwDmH9mp59Q9gk9OjGvIdx1eAgDywN03gwGeDNsBkDS5HFW4aKNO6fWtD+N?=
 =?us-ascii?Q?iaorRECf/tX9oR5ds3F8iFaNmwBY21VZjhHG2UV/VA60+32VNSrbAVrQAfsl?=
 =?us-ascii?Q?3KLBki+/SLZSYRyMEy4030cQiMgbPKLIMEqXsH9+aObcqylZiB679ozJowjN?=
 =?us-ascii?Q?4xO9khQTxD3j3Rc9KXNKByX52qJOQe59w4ao4RF4ji0KQWA8AAjMSndfyecA?=
 =?us-ascii?Q?zGzDCUBwZHObRQtzDQFJWspLNEjYiRk7t1ifSd8OXlTIYYDODdnHq0O3EQAS?=
 =?us-ascii?Q?EglcPVVWG8xRvw89aC0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:12.3232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c80c53-664f-41cc-18eb-08de37011540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
User may connect mst dock with multi monitors and do quick unplug
and plug in one of the monitor. This operatioin may create CSN from
dock to display driver. Then display driver would disable and then enable
mst link and also disable/enable DPCD mst_en bit in dock RX. However,
when mst_en bit being disabled, if dock has another CSN message to
transmit then the message would be removed because of the disabling of
mst_en. In this case, the message is missing and it ends up no display in
the replugged monitor.

[HOW]
Don't disable mst_en bit when link still has sink connected.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 87f9ceebe26a..7384676e646d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1931,7 +1931,7 @@ static void disable_link_dp(struct dc_link *link,
 			link->dc->hwss.edp_power_control(link, false);
 	}
 
-	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST && link->sink_count == 0)
 		/* set the sink to SST mode after disabling the link */
 		enable_mst_on_sink(link, false);
 
@@ -2082,7 +2082,12 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			link->dc->debug.set_mst_en_for_sst) {
 		enable_mst_on_sink(link, true);
+	} else if (link->dpcd_caps.is_mst_capable &&
+		pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+		/* disable mst on sink */
+		enable_mst_on_sink(link, false);
 	}
+
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
 		/*in case it is not on*/
 		if (!link->dc->config.edp_no_power_sequencing)
@@ -2368,9 +2373,9 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream->sink) {
 		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
-			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d\n", __func__,
+			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d sink_count=%d\n", __func__,
 			pipe_ctx->stream->sink->edid_caps.display_name,
-			pipe_ctx->stream->signal, link->link_index);
+			pipe_ctx->stream->signal, link->link_index, link->sink_count);
 		}
 	}
 
@@ -2484,10 +2489,11 @@ void link_set_dpms_on(
 	if (pipe_ctx->stream->sink) {
 		if (pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 			pipe_ctx->stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
-			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d\n", __func__,
+			DC_LOG_DC("%s pipe_ctx dispname=%s signal=%x link=%d sink_count=%d\n", __func__,
 			pipe_ctx->stream->sink->edid_caps.display_name,
 			pipe_ctx->stream->signal,
-			link->link_index);
+			link->link_index,
+			link->sink_count);
 		}
 	}
 
-- 
2.43.0

