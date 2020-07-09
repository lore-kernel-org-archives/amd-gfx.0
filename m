Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A26C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 05:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22140206A5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 05:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rc8LLvnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22140206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89266E3D8;
	Thu,  9 Jul 2020 05:33:26 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BA56E3D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 05:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1QQMdK9ube7cH47oR/rd68NQqoCx333RgAKdiaT5ehyADAux8CZLuzBPEmcfW9IzwvlCEpWLYByrfpwW0llXHYkxhWY2uhTDazRjqJhSTO/jzR7bMUC7F8kQW09QDilJmxvV9NOZ6QJqI/ONYzmEPFIkxiu1bZXv119H6+AMKCmjc3njx8nAbmVTKcE/SKW38WDaYBRZbDud0pt+EDP+zVzHsDrEDhfhgldRvfEX06yvdT5qYAldwCNbElsbZ0TMUZScUuaHzLiByapLEDbPXEOzCd/K8J6ZNz9+Ewttr/y2MzALt1hesYMfFs9iju3SEoNCpqOYMPJAhCqPDooDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WUVCDSW00IhLs2ZD8o6rCNR2/Gn802Vq+ragjW1AGo=;
 b=c5/iNaYTlDjTmGmqQmk2dGbCQpsTUzqLizqblEOKY7NnijTzD1qjPl0Sh04Rp7HMP4E/1RKhFoAZAHi2IHVesrgGHxVMA/H5ojQyqwsb+OrhHTDfAbA1DLIjH+7LPpXkTnLiNO27L7TeVf5E0MwoB9XtdyJjbF0bVj5EOfgpfhmvEHtGLa7oH/h1ZmlYwrS1xaxT2dVCTsf3S34qZtEw7jScAruLSeLpvUnEf/x8Y/DUoxmUiHsoEzox+Mi+JhL+Hf0csq/OP92BW6lBO2JUveZik7H1ImUkFlo7kBCIx2yWSte58OhpcUTbUM7AuSsDI2IUyZ4xIFai6gqu5olfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WUVCDSW00IhLs2ZD8o6rCNR2/Gn802Vq+ragjW1AGo=;
 b=rc8LLvnc4PpJBPXG+wqrA/iahcIAwCvkhDqToRrJCBJ6WbQ/fBIZ+RMvC+VZwdamgaNP0IdWivxEQ0CG5nRQm4l4JJnkUI3NFJdbp9QzUGuwEp1L/bCnfyKQpT5AKRmDmoL1S1pOdmKhiFUnYj3SIyJoYde33TCg6aPBvxFjZq0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 05:33:19 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::7d31:448f:70fb:bb13]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::7d31:448f:70fb:bb13%7]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 05:33:19 +0000
From: changfeng.zhu@amd.com
To: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com, Harry.Wentland@amd.com,
 Eric.Yang2@amd.com
Subject: [PATCH] Revert "drm/amd/display: add mechanism to skip DCN init"
Date: Thu,  9 Jul 2020 13:32:53 +0800
Message-Id: <20200709053253.24653-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR04CA0015.apcprd04.prod.outlook.com (2603:1096:203:d0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 05:33:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dc679c0-505a-4a35-eebc-08d823c9968c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435B12AD2BA80856FD52A55FD640@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWtbIvHDz2s4P7MDSkS3V3pX6DxUYUreQfMmlifCi24wGLt9j36CxHe7kQf3g18vVnwoohhKNiCxlfE6yYd6vhyT3vIWD2cDk5FdR+O0iICMD6r7MGe/vVybO3Yok+nff2lnWiRqSooFJGINBkCNMa5hs7mxx5IacMFL+WLqPBSCkJ2kcQKUcgs8YvFJratc7W0JA79EOWw5Y/RlCuRBCqzTOKbJQ8X/ZCpvg0y0FRGRtPLphZgHdDo9XcXxQ1qN0f1HIsQKeIf2pW3otzvShhfVm84uc3nPwtuDMkcK6vIV3VewV0BPayWtKEt6yiOvSEEllEURX5V/X6SF73hr2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(956004)(2616005)(316002)(186003)(16526019)(8676002)(26005)(36756003)(2906002)(1076003)(9686003)(8936002)(6486002)(478600001)(6666004)(5660300002)(52116002)(4326008)(7696005)(86362001)(83380400001)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HSv6UFX0WpHcfQK9zKNH69U3YuN7OuHIlDSWVoqEdLRYJUPxddba80hV00AqizGPRm8MX5aFhJTiChDJs4nx9U9W2aSd5yXb8Cp2/q7wNW0yQlvlj/AVQjAgN2SdxcPoQa6IWoLG43Z6DoTMoT+ERbhl8Dl66pns5geU+9UTXlP++uBA9bV5uP2ZR3VpSqzlQPbXeuxNFHu18ZsIv2h+A3ZAV2gANmXi5xw6ls7mK+gbzTibYa0JBtF9yTMJdDST0Em7qS2pbs113qWS8zt3kNsmfosp+mb+xUamIwuYzD5vbgDAs57V1ypKwUMx7N8Wqxg1NcVq+f9yH94d6yFj5nKHsFmC6LZA/qkKHOxLxNIewbTkjPiLxDb9ryvTD18Tu+ydnXgnjCVUtx/t4eBvTaQ651TuUNc8qSDLyH4Gjzl/FIu5puBi0ssKf9173vQiKWDALazzZDdLFhVDWcBaXmsOrE3Lf+AtpFjSF+Ho9lvvNkq6XSwT1QRsiaqD4PJg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc679c0-505a-4a35-eebc-08d823c9968c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 05:33:19.6830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eArI7uOQ1mtbSYrTZ5fDzmbhEm14ySpRDqJXEbJzla+D2+khnNrSqF/itQjkKlzUqX++8S3//MhXyEiyfkheRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

To avoid s3 faild at the first cycle on renoir platform, it
needs to revert this patch:
drm/amd/display: add mechanism to skip DCN init

Change-Id: Idca8933d728531fb68ea2ff00c6c8d77d2a3cdca
Signed-off-by: changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 28 +++++++++----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 -
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  5 +--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 15 -------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  4 --
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c | 10 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |  6 +++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 40 ++++++++++++++-----
 10 files changed, 72 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 67402d75e67e..db5feb89d4af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2681,7 +2681,6 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 	dal_irq_service_ack(dc->res_pool->irqs, src);
 }
 
-
 void dc_set_power_state(
 	struct dc *dc,
 	enum dc_acpi_cm_power_state power_state)
@@ -2693,6 +2692,9 @@ void dc_set_power_state(
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_resource_state_construct(dc, dc->current_state);
 
+		if (dc->ctx->dmub_srv)
+			dc_dmub_srv_wait_phy_init(dc->ctx->dmub_srv);
+
 		dc->hwss.init_hw(dc);
 
 		if (dc->hwss.init_sys_ctx != NULL &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 96532f7ba480..eea2429ac67d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -106,17 +106,29 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
 }
 
-bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
+void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv)
 {
-	struct dmub_srv *dmub;
-	union dmub_fw_boot_status status;
+	struct dmub_srv *dmub = dc_dmub_srv->dmub;
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	enum dmub_status status;
 
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
-		return false;
+	for (;;) {
+		/* Wait up to a second for PHY init. */
+		status = dmub_srv_wait_for_phy_init(dmub, 1000000);
+		if (status == DMUB_STATUS_OK)
+			/* Initialization OK */
+			break;
 
-	dmub = dc_dmub_srv->dmub;
+		DC_ERROR("DMCUB PHY init failed: status=%d\n", status);
+		ASSERT(0);
 
-	status = dmub->hw_funcs.get_fw_status(dmub);
+		if (status != DMUB_STATUS_TIMEOUT)
+			/*
+			 * Server likely initialized or we don't have
+			 * DMCUB HW support - this won't end.
+			 */
+			break;
 
-	return status.bits.optimized_init_done;
+		/* Continue spinning so we don't hang the ASIC. */
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 8bd20d0d7689..a3a09ccb6d26 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,6 +56,4 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv);
 
-bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv);
-
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index cb45f05a0319..abb160b5c395 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1288,9 +1288,7 @@ void dcn10_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb))
 		hws->funcs.disable_vga(dc->hwseq);
 
-	if (!dc_dmub_srv_optimized_init_done(dc->ctx->dmub_srv))
-		hws->funcs.bios_golden_init(dc);
-
+	hws->funcs.bios_golden_init(dc);
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 3cac170312fc..c6a8d6c54621 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -264,10 +264,9 @@ struct dmub_srv_hw_funcs {
 
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
-	void (*enable_dmub_boot_options)(struct dmub_srv *dmub);
-
-	union dmub_fw_boot_status (*get_fw_status)(struct dmub_srv *dmub);
+	bool (*is_phy_init)(struct dmub_srv *dmub);
 
+	bool (*is_auto_load_done)(struct dmub_srv *dmub);
 
 	void (*set_gpint)(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 0cd78e745e7e..2c4a2fe9311d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -312,18 +312,3 @@ uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_SCRATCH7);
 }
-
-union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
-{
-	union dmub_fw_boot_status status;
-
-	status.all = REG_READ(DMCUB_SCRATCH0);
-	return status;
-}
-
-void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub)
-{
-	union dmub_fw_boot_options boot_options = {0};
-
-	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
-}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index a27b509cd6fd..a316f260f6ac 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -192,8 +192,4 @@ bool dmub_dcn20_is_gpint_acked(struct dmub_srv *dmub,
 
 uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub);
 
-void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub);
-
-union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub);
-
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
index a6047673c3f5..e8f488232e34 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
@@ -51,4 +51,14 @@ const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
 #undef DMUB_SF
 };
 
+/* Shared functions. */
 
+bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub)
+{
+	return (REG_READ(DMCUB_SCRATCH0) == 3);
+}
+
+bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_SCRATCH10) == 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
index 8c4033ae4007..2bbea237137b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
@@ -32,4 +32,10 @@
 
 extern const struct dmub_srv_common_regs dmub_srv_dcn21_regs;
 
+/* Hardware functions. */
+
+bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub);
+
+bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN21_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index aa41dfa23020..08da423b24a1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -153,16 +153,18 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->set_gpint = dmub_dcn20_set_gpint;
 		funcs->is_gpint_acked = dmub_dcn20_is_gpint_acked;
 		funcs->get_gpint_response = dmub_dcn20_get_gpint_response;
-		funcs->get_fw_status = dmub_dcn20_get_fw_boot_status;
-		funcs->enable_dmub_boot_options = dmub_dcn20_enable_dmub_boot_options;
 
-		if (asic == DMUB_ASIC_DCN21)
+		if (asic == DMUB_ASIC_DCN21) {
 			dmub->regs = &dmub_srv_dcn21_regs;
 
+			funcs->is_auto_load_done = dmub_dcn21_is_auto_load_done;
+			funcs->is_phy_init = dmub_dcn21_is_phy_init;
+		}
 #ifdef CONFIG_DRM_AMD_DC_DCN3_0
 		if (asic == DMUB_ASIC_DCN30) {
 			dmub->regs = &dmub_srv_dcn30_regs;
 
+			funcs->is_auto_load_done = dmub_dcn30_is_auto_load_done;
 			funcs->backdoor_load = dmub_dcn30_backdoor_load;
 			funcs->setup_windows = dmub_dcn30_setup_windows;
 		}
@@ -462,10 +464,6 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		dmub_rb_init(&dmub->inbox1_rb, &rb_params);
 	}
 
-	/* Report to DMUB what features are supported by current driver */
-	if (dmub->hw_funcs.enable_dmub_boot_options)
-		dmub->hw_funcs.enable_dmub_boot_options(dmub);
-
 	if (dmub->hw_funcs.reset_release)
 		dmub->hw_funcs.reset_release(dmub);
 
@@ -526,10 +524,11 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
-	for (i = 0; i <= timeout_us; i += 100) {
-		union dmub_fw_boot_status status = dmub->hw_funcs.get_fw_status(dmub);
+	if (!dmub->hw_funcs.is_auto_load_done)
+		return DMUB_STATUS_OK;
 
-		if (status.bits.dal_fw && status.bits.mailbox_rdy)
+	for (i = 0; i <= timeout_us; i += 100) {
+		if (dmub->hw_funcs.is_auto_load_done(dmub))
 			return DMUB_STATUS_OK;
 
 		udelay(100);
@@ -538,6 +537,27 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 	return DMUB_STATUS_TIMEOUT;
 }
 
+enum dmub_status dmub_srv_wait_for_phy_init(struct dmub_srv *dmub,
+					    uint32_t timeout_us)
+{
+	uint32_t i = 0;
+
+	if (!dmub->hw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (!dmub->hw_funcs.is_phy_init)
+		return DMUB_STATUS_OK;
+
+	for (i = 0; i <= timeout_us; i += 10) {
+		if (dmub->hw_funcs.is_phy_init(dmub))
+			return DMUB_STATUS_OK;
+
+		udelay(10);
+	}
+
+	return DMUB_STATUS_TIMEOUT;
+}
+
 enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 					uint32_t timeout_us)
 {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
