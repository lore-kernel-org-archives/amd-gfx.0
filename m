Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D29C43462
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0429E61029
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0429E61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0CD6EC75;
	Sat, 10 Apr 2021 02:05:04 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAEA6EC60
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRn0trOW9CdL//ifF6+CUTzQZ+B5y3stLOCLZxo7isX0X0Ohqe8L0QEOSzsfMz8HbGqHelQgqu4UGO5HPgXXVQKyCcT5xHSm/++A1bZmylp0rOLdYzukRgISY9YbWMpreoBsdB1EAQLGYE1pqbk0oyr92NEq32CRvvie0lo2Oyx+n8iLJXj0rDGMnSBDXKf7e85XMEyu20akS2z9lCKknDK7mwzVikOPPSjbwpnS1VtzTleMihrRnXBvjLZLiF23t9nWceAhJP6yuZTxrbqfza5m/t6joRMYCJwIwl030iN8zAjo7LpmkDB4qiHxQbF1ecDUSPPbDdAEWXLoyr64NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gXRBTRCOrWQDuUck+rnbbhdYisBccu9ACLXkuFWemA=;
 b=KOajrRmmG+Qbd+xHQ3o3iBfS8hwJAvhnKxmRKk06whCFysSqpSAASJwqcgnni5Zmw/cNPUAUQcWJMb/QfxHCfJ6BURc1TkBbuwW8jRNXCz5nBrXP4b198ycE4KgP/2Qr/9oMwInuKQx3rpUTg5xG3GnpE28YOzWtep4W0fhvuB8n4kWAroM82fTI6gmn4t1ulPu4heTyeLBZuQrCZjdFeKngWmEPsiRj9qSALHacgYnqgXJPWB9Ezf1nLqQLT/Sok0rtkrjuA/08gr+GG/sYKhPQcXYyqbDNBjQGnCFQk1cFKNF5QzK1mGTXXCs6iaPaCVVxNbsMJc3IWeEokKnHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gXRBTRCOrWQDuUck+rnbbhdYisBccu9ACLXkuFWemA=;
 b=Zql9PHO+nYYItwp2ob1bCeJs4uvK2IT8ooXxxvpSh3oR+rEAvW+dcrpN4FFfmxt7A0EeTgtk6b13FtWwGXJu9yqbotSOzM5NIuR5YdTyLUZ0+y4oVql8n05LND54EuSrmH4wEn1StRcGfcBFwtxsyQW96aerx6CjQUefSRI1YtM=
Received: from MWHPR1601CA0012.namprd16.prod.outlook.com
 (2603:10b6:300:da::22) by DM6PR12MB3036.namprd12.prod.outlook.com
 (2603:10b6:5:119::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Sat, 10 Apr
 2021 02:05:01 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::45) by MWHPR1601CA0012.outlook.office365.com
 (2603:10b6:300:da::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:05:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:05:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:59 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:58 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Added support for multiple eDP BL
 control
Date: Fri, 9 Apr 2021 22:03:58 -0400
Message-ID: <20210410020401.1100228-14-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 939cab36-bc4d-4702-87b5-08d8fbc50c7c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3036:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3036637525A0EBB4A5F83F61F5729@DM6PR12MB3036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oF0b61nQRk28KWIa7FEjbhksScTzTe2OgWEQlT2bJpWDthnfwWHrX9zLZKEIK7yFVMZactLO6NO27PAeG2DKdqdxNs3EaoXwcVmWrvyQjbpiIlslPkmiBxf3HwuJ8p4xlr1f8SOHvRn41broxwa78O6yhGjSYjnFxQbWP788cpw4QEOQTcaG912GGWfACtPEdh7xHwvj6KqzryXOBlLOp3oLUGE0ol5nG9h+I3g76VjnaBdvtxUOry3uJZZgfQis2SvRiCa4G9uW+83UQl+EbJhT5UQGIKeEuddlRJWVP+ChnfrxlnsHh10CHWeZOUL7pnzFHoQMfi3I4iiOEVKwSqnPrOpX576g892L5US9VChZp5zg6MHLz6VegxvNlQRUjRdV20L7bQ9umdCn1OZmHS3Xmt+7+pKrE5Bj0ApNEW5DPFrnlDQl7XFf2LtD7MkRqhlnNQF8IZynjcwIKqM5G5ORzgX+KiHnKnyprKADpdCDvoCmBfsOrLNzH+KhNlwcnVb9pYHqp7KJOJ11dchFttK+Bwvn6I22Lj0nuGwwnjlQHZCNojodNP1IVDfer0a7Sn5zC7L1PXZaHzGUZauaIH2Mal3QyObDNTp+gg1IEejKPRH49ZrUBUF5X+Rl7KRjgKbsWJMK+KHEbw2A6d6UAyj0olN73fKLJK+523VcDEOTPrbsrKXCzZKKFQ7eSAga
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(36860700001)(4326008)(54906003)(82740400003)(2616005)(6916009)(336012)(8936002)(81166007)(7696005)(8676002)(426003)(36756003)(5660300002)(356005)(316002)(186003)(70586007)(47076005)(478600001)(26005)(70206006)(86362001)(2906002)(83380400001)(1076003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:05:00.7942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939cab36-bc4d-4702-87b5-08d8fbc50c7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3036
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[WHY & HOW]
Driver currently assumes only 1 eDP is connected. Added support for
multiple eDP BL control.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  2 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 27 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index d3b643089603..8fccee5a3036 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -218,6 +218,8 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
 	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
 	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
+	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_SET_BACKLIGHT_VERSION_1;
+	cmd.abm_set_backlight.abm_set_backlight_data.panel_mask = (0x01 << panel_cntl->inst);
 	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 9b3e31103bdd..cec1ab91274b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -120,6 +120,16 @@
 /* Trace buffer offset for entry */
 #define TRACE_BUFFER_ENTRY_OFFSET  16
 
+/**
+ * ABM backlight control version legacy
+ */
+#define DMUB_CMD_ABM_SET_BACKLIGHT_VERSION_UNKNOWN 0x0
+
+/**
+ * ABM backlight control version with multi edp support
+ */
+#define DMUB_CMD_ABM_SET_BACKLIGHT_VERSION_1 0x1
+
 /**
  * Physical framebuffer address location, 64-bit.
  */
@@ -1625,6 +1635,23 @@ struct dmub_cmd_abm_set_backlight_data {
 	 * Requested backlight level from user.
 	 */
 	uint32_t backlight_user_level;
+
+	/**
+	 * Backlight data version.
+	 */
+	uint8_t version;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
