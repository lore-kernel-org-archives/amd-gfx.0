Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C36C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76A510EB53;
	Thu, 27 Jun 2024 21:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="biZM0q7e";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E4C10EB53
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lygWV7jwRGQ9ai1sDijPijTAyRfFM3osgFqvBCtK4xzFSwVf2yb/Wajoi9CCNa9rVPG1pkyssBvYLk422oHTpHQLBlDo4R2df7CaQ6IhIfheZDQqYTeJPUrsQETjL7YkIEngEogh32XVf/ASPghdR7ihhSagOoMDhBlm3NjcaX0KP+apMDBew7f4PW80EGK/O7glZJwQ2swBSUOdc5BTERaaXHpoI+Ku/KVbIHdb6wbv2EL6s5MzpQI97A7DkDb7i9+fRkffWaD0iHyNKGgb/0aiSL3NxWokPVUTsEP2OAPDsBh/F7bJmfFUcEHiNXJFZc3MrBgaEDWoawwUC1vSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CseqJgUFZacE+9pekvca6LazHdrtjd+EqH0AgXQuh0=;
 b=h46EqkzUqxoJYRwbCscxW6KTLqhtejMeau3g3suXEhBKjpDR7khxMRSPcLVJaU22PSpJPLT/Ng4kCa069TPyWl30K3dpQnnEVYaPI8v9x+qoS9rn+EP5UoFpIGfeTZ3NXOuNkVXrkBULoOtWfWz/9ercMhaUAavZy/xhoHV68ioGLQcCmnSAQyiNeY6bev7dJYO1WtyFTjg1BZEUATlGiA4EfbrvMnzXuvnUQl7wEbkE/F8WL/OJCgiKqtEg3hsNHWQt2aZpniEY3P/SWMf1PI4IvQNQHAQbHgwO9//70Nntu0U8d6ntPhsPS8HGuFqR8H7c1W31ZvnkVQ4V+B37Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CseqJgUFZacE+9pekvca6LazHdrtjd+EqH0AgXQuh0=;
 b=biZM0q7e2BcWbAQIEYRfBAcl/LAPYgYYEXyQFD5bSnUpsV6NNuTFdbNl1/ZvDDNEMhb3yDPtTXtbMKytTsku2dqfBLdwNle9CD1wyVVy7gHK6+sUNGo+9Z2XFbx2nki+4oTFPJOTNOFLwY3PGW0tVbyfOmstR62ru1hoFtIL6ds=
Received: from BN9PR03CA0279.namprd03.prod.outlook.com (2603:10b6:408:f5::14)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 21:14:08 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::5e) by BN9PR03CA0279.outlook.office365.com
 (2603:10b6:408:f5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:06 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:06 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sherry Wang <yao.wang1@amd.com>, Anthony Koo
 <anthony.koo@amd.com>
Subject: [PATCH 09/26] drm/amd/display: Skip unnecessary abm disable
Date: Thu, 27 Jun 2024 17:13:12 -0400
Message-ID: <20240627211329.26386-10-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: f8682ec4-4dee-4ef1-a555-08dc96ee1545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?As9Nj9nXBv6RR1Wd2EBDdb/TLtKqYo+VZ4a65eIXndzaTyZqhTUq0or4A0pd?=
 =?us-ascii?Q?qas4Z8Ngoj5JhuwPljKTuR/N6LVGX4WMw+JzWObrOLRWK+VcS9sylnr4WooT?=
 =?us-ascii?Q?fWp5aq46nYfFNdhg7BX4yy5g5BgmrZzW1eWwB7js7caqufvh2rsCIRXzy8ch?=
 =?us-ascii?Q?wRVemcH1o6bjuLQrStjVoeZK7u9IXAaAMG/79vaWEFMfVwE0feWPN8YdY44Z?=
 =?us-ascii?Q?vth7i1IN4olLfRlO0G5bc6bAdwVLzHsDjpmHK8uboo1tpA7BlguHY0lVdKO8?=
 =?us-ascii?Q?JUd+NkbgjYtQ2dKkdJbKwJPu8uWv/oSwhiN7jDBYQZMuUkyzn1olGDmj+D6b?=
 =?us-ascii?Q?75zKxGkGueHQ84pD9I+zyvMuyfBiHYWFBilq31BAQCt+KzhJdNpxskbUXrBx?=
 =?us-ascii?Q?gjb8tZ7+NFm9yySqELVxlXueDPcEjYxL57kfWx21tvtGVpJZTdwIg0yodxkt?=
 =?us-ascii?Q?IV3R0+mr+dzL5+19/STonY9AXC8zU9idIzrBI6CVLh6+HNdnjhZKO8FSiTIm?=
 =?us-ascii?Q?v4JYmr3juR1BrZXviqVYTCT7PsnjtwVitaEFhO88tF8bsKoTQXdtA/mnONIv?=
 =?us-ascii?Q?yt+ahGj8b4V8vLWTAxJIRZMuRfFuZt/plz1P1u63BUQacLUxdY/u8Ii79Z84?=
 =?us-ascii?Q?FOq/RzhwaOzIwJYcOxgL/PANE6n2xt4XUpRP1ddWAgTPiOvOpKm1ZAEYiWvi?=
 =?us-ascii?Q?jHxSi/zQiLXThP9aIwEAMSMVYyYR1iOzyoUh9m+KDMz/7aDe69OgUhEe0J2s?=
 =?us-ascii?Q?9bWLKGhdr66VAHa73TUbCyzQSI1goufiTiHXI6hFhFKBZwDUHKhlCFUI4ZV2?=
 =?us-ascii?Q?JwVnE5Dhq/hbgGq8OHC10tE6oiRCa+kku0nz54lmE8uwN72wyp8iie19jyrP?=
 =?us-ascii?Q?shFVzF0mFp8FpLw4m5/kc/d2IazzChucQxbAoEHaCIs8IWK6p6N96vb0Q1x6?=
 =?us-ascii?Q?Vhv2i7hnEBmPdb1ry4bOtxra4g+XwhqIlqp5DLoUAUuHmqe9FrQe/3V9qGkF?=
 =?us-ascii?Q?an3CkzEy3W7fC9jB5gJYmACB/tR3skNa/Cv4ToaPgsLhZc+jSpBJjni9JXg3?=
 =?us-ascii?Q?5bknPfyo8wJKjHAtr/nTy/umEIgUl46Xjb9xAM/N9d6SxBIQ8lnsqPOhlTph?=
 =?us-ascii?Q?Jtjxgr7+CEjF3SMp1dkVaTm7EcUwWgg9/qBPuWmc7L+XarMBfuIxrEzoWm50?=
 =?us-ascii?Q?8TcawkpmA7QSY7hfxezTiNe7AWVjIs5uoHoGp+zuQkK3pe2TtgsAJ3I61+e3?=
 =?us-ascii?Q?Y/cc9uBD04AdTKVBrUw60GF0P77PFxBZyGXKUchYkktaRCuzkG08ldDbgDxG?=
 =?us-ascii?Q?lfDmEYpYVS7W9MaBLTyfJHZ8j+bBbj4lA+Lr44LlaKCttGwu4nBh+xkehgme?=
 =?us-ascii?Q?60dCiqNkEo2+FcLtrcd8r1qgGJs6VJvnTBf1RRoUu3BkiuSGNkmKIESDlvY6?=
 =?us-ascii?Q?wQr61GK1iMQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:07.6317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8682ec4-4dee-4ef1-a555-08dc96ee1545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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

From: Sherry Wang <yao.wang1@amd.com>

[Why]
We try to disable abm immediately when it's being gradually
disabled, which causes backlight ramping being paused in the
middle

[How]
Don't disable abm immediately if abm has been or is being
disabled through set_abm_level path

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Sherry Wang <yao.wang1@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 3de65a9f0e6f..1ea95f8d4cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -183,6 +183,12 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
 
+	// make a short term w/a for an issue that backlight ramping unexpectedly paused in the middle,
+	// will decouple backlight from ABM and redefine DMUB interface, then this w/a could be removed
+	if (pipe_ctx->stream->abm_level == 0 || pipe_ctx->stream->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) {
+		return;
+	}
+
 	if (dmcu) {
 		dce110_set_abm_immediate_disable(pipe_ctx);
 		return;
-- 
2.34.1

