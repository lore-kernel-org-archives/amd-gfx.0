Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A30C433E9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11D764DA1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11D764DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4016EE7E;
	Thu, 11 Feb 2021 21:45:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33926EE7A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER7uLz+SFL/bF94NOSoRGO1GZ2IXATMPPI2wCXbhFitEQlnHAKgJ0kRLjsXX31DI35GvuSg/M9W+ZpuYZB8ZAnckQehYWwlMB80hQC9NWzgEJkAbcNYS7yV8Vr/xEPGe17c9gdI5a4tgVxMdw9n9D/8s0uSsB27kIQRxTrH0Y+FuIOgGMoUWHPigDpopizA0u+SCUIx760yTsKxDWQKUsY5Afg4ZcknqXI+ifFIcs+p5r0+yjz9IIFTZeXT8D3qNVfju8V6ajYp9QAHiRKJsdxsDyfixL7BPfmNglkHH/PyAPMWAEXKWKJ/UPhueDIuyBWpD41APmzDaZdlOMBefXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGqZAS4mZ2uJYjl/Bu64h78fm+DRE1f3qjhX4uQBEwA=;
 b=nMwDWAyWZREVDM/8fpGBrIHEJjloNWV+P55pAt/I8vZ4Aj3YxngxiJ1WFQvs89pfUnxW1h5wuixA4ZDPUKlrX6kXRn3sYSObv5wcZEuMoQbvWOWMWWeYcjCsymB1LPF1ckGFEFYlZgHRyxaTX13zvIoQXGISjynIRq2DB9qc3l5tyQSNISe0lHnQe0LXiue/VN+rPuus4B9sj+8Ze3g83YciOM8jTxYFDSZpQTu2cPa69HOW3/ZMbrcAej4enzXhdZNpGE+tVkWD/NrcBmBs4Cb8hbzWeZdLpMnaFw4onlxUX9i/o4XACqySEPUGvYrvEOXAq40SJniGEpVcR7kEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGqZAS4mZ2uJYjl/Bu64h78fm+DRE1f3qjhX4uQBEwA=;
 b=Fpcz59p4Kj80sIhGfVeequJPKKWXGEVtVDmbppflWkO/V6qJ2sUbnljkkEg1bEo1KUIxrqJA47GKs9DVuiTyTvJFD+uQQ5NxfI8hB/RYYFIhkwS483JYzEZLhToLstx0xfPY8iUSMWGFxxtlmoYxJDMYhYL8Ph2VQtuc1OprSuM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 11 Feb
 2021 21:45:11 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:11 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/14] drm/amd/display: Implement transmitter control v1.7
Date: Thu, 11 Feb 2021 16:44:42 -0500
Message-Id: <20210211214444.8348-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 461a496c-7e06-4ec8-56df-08d8ced64e74
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB311426664BF779394ACE5A84FB8C9@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ST0m8JBvENMgpO+jgRJvpFTXQMwOjpEiWu1ZlUzKnztmN30QjgUb6FhAIl0GPPPbbQ9FgOtxuhp2hmvoVr6V++SihCjC/EYXQS0g2TUVvpASc1gdV58XZeEbJfAl0pCmTajIc4aCrltW3zfPRrRxxzGeAttA0uD3Q0imsErdx3KWK8O+oYiN1UIrJye9gAsID8JC9NEN2QWXbI/Judman1UsRl5LYDGJ0XApVk0nRkvniAfL2S0vbAI6YW5WSEsP/6OU3+rnEyN5jk1tLu1cRmSQJefYkMHSMCEqzzL98xnxikBwQ0owBVdqcci5wdxtLmbRpRxsnKf0COAvS0wcr9PE1rNGJjXP7QYaQV7gduK51BMhL+FrY138U4SLCa9r8PPCpJPXHZ/8C1l5f22Zo7mki5JD6EbUKga1XUQEbKCPy+o2MsFupquqcdynLww0cZi45vhp8V690M3kGdZ/QI+dPPO7YUuTGEU4bNmLXFcjxHNwiIdb+jNacgttb32vNwCJYJsMwRzCFNGobjMoCq6WOl2oA0zP9Nm6CvjhUBQ9KJPfocBCRusjfft1cX4gQ36D6OjDhK+8/etZiXM1/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(83380400001)(36756003)(26005)(16526019)(186003)(6506007)(6666004)(2906002)(69590400011)(66946007)(44832011)(2616005)(8936002)(6486002)(1076003)(66556008)(66476007)(316002)(4326008)(6512007)(956004)(5660300002)(86362001)(8676002)(478600001)(6916009)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E/CoxZMuB/mkzVhNTi3tjFfXKykPYXdxNUj0h7I+vQT2G67lnsnzm8Y5rQHZ?=
 =?us-ascii?Q?UP9Kqc1H3sujF0RxjJZRf8Qe3KtHYENylW40NIgxUWMF2GwdQGoWC/lD/K9N?=
 =?us-ascii?Q?nFmn47ZRX+MXBO4niA3DYNT2spbNt17DYtlUGoIFaAEJGdNLbcFCxKonD4Ca?=
 =?us-ascii?Q?CObmOwwGTDAllaxAmyTH6fr3fv8wkyzz/XwhUmaXVL7b9Qcc31oTloeg9l9T?=
 =?us-ascii?Q?BZ+Gv53dbC28EPqYUputqe5LrfOA/VOisU5Momv8kuRegeNrguh6Ek0WzHEj?=
 =?us-ascii?Q?sptB2hb6WXOYmYpF1PFGG00HztdEKDDV9Ck8oF5TRXUv5eYjFjaGSd6ya60z?=
 =?us-ascii?Q?si1rHcbyEM61BuFDGZYmoO7WIl21ZTZxhp5dIu6l35K7LJs28JTiDjzKKJ2+?=
 =?us-ascii?Q?1XeS5L65f+4I9/9c9/4ucYo0Ip+CKkmvAwM20Eo0mst3yYvhqtLTawnIp5aL?=
 =?us-ascii?Q?UXm50laK5LLn6F8+s96eg42Ts+Nvldov/FKEAJ5ihjL5idQJBMq9dYTsgJR7?=
 =?us-ascii?Q?FcGDYCQrxVPvuQHK+8M9UzFaqI0Ut9wwwrBktl4YS2mxmeXnKZhUQd/Bp4zT?=
 =?us-ascii?Q?veSjHY8jzTT2cVDGH3N6Es4ndUidYdwNmwzae9WmhYnUOvG1pt4cuP5snwgB?=
 =?us-ascii?Q?aP2wcqdylCiilQj/QVBigbI+5RywkfWB0XqMNC20wbqvSASe1+EsFzWiBoDw?=
 =?us-ascii?Q?G55NCUk1iUyYx9/dtRFdk/OeyhsK0fpwDvzMxxsgV9cIzbTc03PGC9Z/ly1R?=
 =?us-ascii?Q?fV9TF5JQi4xAup2rMQ/HjGcQkcVbroPnydMExVN7b+alpgAPQuODvNvoRd+r?=
 =?us-ascii?Q?TvTRDIooJbzuzJoVTOimbE3MhhuqqJxRlzYIYoqn4UzN6UXjWRzJvVaOgFsc?=
 =?us-ascii?Q?64/YVp4mjuQDIKY3pyW9fWI3KHnjOGGMSy5qTn8m+Zcm5k9i9NVa0jUN0Xfi?=
 =?us-ascii?Q?4D4Ct+77T1ihxaGYzAoChZfyC1yvHAdZoNH5zrK8jcEosEEla/bSUdm4wjY8?=
 =?us-ascii?Q?5wvM/4fk/k90Y3dsZBvcjs801Djh+WcQWnoE4BjJRtubXXmwbnH7q5zRlBYV?=
 =?us-ascii?Q?11TZTtQIvxTfz2JB1G7/u2Ra4pubgIw3PbpjcvwQnnuksnCrslPmrhtmS56P?=
 =?us-ascii?Q?/lSx5Oq8IFJN314s3FiUr6+f+xbgFjPCnHuebzLLpd/HjEjvDBAI48l81zKT?=
 =?us-ascii?Q?WCmplT43tWvpa53+PAxgee6/lVnIuTpb9enS7gLnhJi+WwGnwOrUMEnDvjAC?=
 =?us-ascii?Q?IxNKXot0fA8RDfKbMpQJTeEJCLKB9LWACkMY+SMgSc6lCxk1aMEwFDb4NunC?=
 =?us-ascii?Q?9a5DBegoiNu6ms1jwOijB5sX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461a496c-7e06-4ec8-56df-08d8ced64e74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:11.0693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3YPJlsLSjA+/NS6EUx1yoD+9QCV590y4iPEUPygB8N+dl929uASUp8pgnvQ0sk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Moving definition of transmitter control from atomfirmware
to internal header.

[How]
Update the command table code to call 1.7 and make it the
default fallback path.

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 .../drm/amd/display/dc/bios/command_table2.c  | 72 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 25bdf1c38e0a..fa5271a4598e 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -218,6 +218,10 @@ static enum bp_result transmitter_control_v1_6(
 	struct bios_parser *bp,
 	struct bp_transmitter_control *cntl);
 
+static enum bp_result transmitter_control_v1_7(
+	struct bios_parser *bp,
+	struct bp_transmitter_control *cntl);
+
 static enum bp_result transmitter_control_fallback(
 	struct bios_parser *bp,
 	struct bp_transmitter_control *cntl);
@@ -233,6 +237,9 @@ static void init_transmitter_control(struct bios_parser *bp)
 	case 6:
 		bp->cmd_tbl.transmitter_control = transmitter_control_v1_6;
 		break;
+	case 7:
+		bp->cmd_tbl.transmitter_control = transmitter_control_v1_7;
+		break;
 	default:
 		dm_output_to_console("Don't have transmitter_control for v%d\n", crev);
 		bp->cmd_tbl.transmitter_control = transmitter_control_fallback;
@@ -304,13 +311,76 @@ static enum bp_result transmitter_control_v1_6(
 	return result;
 }
 
+static void transmitter_control_dmcub_v1_7(
+		struct dc_dmub_srv *dmcub,
+		struct dmub_dig_transmitter_control_data_v1_7 *dig)
+{
+	union dmub_rb_cmd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.dig1_transmitter_control.header.type = DMUB_CMD__VBIOS;
+	cmd.dig1_transmitter_control.header.sub_type =
+		DMUB_CMD__VBIOS_DIG1_TRANSMITTER_CONTROL;
+	cmd.dig1_transmitter_control.header.payload_bytes =
+		sizeof(cmd.dig1_transmitter_control) -
+		sizeof(cmd.dig1_transmitter_control.header);
+	cmd.dig1_transmitter_control.transmitter_control.dig_v1_7 = *dig;
+
+	dc_dmub_srv_cmd_queue(dmcub, &cmd);
+	dc_dmub_srv_cmd_execute(dmcub);
+	dc_dmub_srv_wait_idle(dmcub);
+}
+
+static enum bp_result transmitter_control_v1_7(
+	struct bios_parser *bp,
+	struct bp_transmitter_control *cntl)
+{
+	enum bp_result result = BP_RESULT_FAILURE;
+	const struct command_table_helper *cmd = bp->cmd_helper;
+	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7 = {0};
+
+	dig_v1_7.phyid = cmd->phy_id_to_atom(cntl->transmitter);
+	dig_v1_7.action = (uint8_t)cntl->action;
+
+	if (cntl->action == TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS)
+		dig_v1_7.mode_laneset.dplaneset = (uint8_t)cntl->lane_settings;
+	else
+		dig_v1_7.mode_laneset.digmode =
+				cmd->signal_type_to_atom_dig_mode(cntl->signal);
+
+	dig_v1_7.lanenum = (uint8_t)cntl->lanes_number;
+	dig_v1_7.hpdsel = cmd->hpd_sel_to_atom(cntl->hpd_sel);
+	dig_v1_7.digfe_sel = cmd->dig_encoder_sel_to_atom(cntl->engine_id);
+	dig_v1_7.connobj_id = (uint8_t)cntl->connector_obj_id.id;
+	dig_v1_7.symclk_units.symclk_10khz = cntl->pixel_clock/10;
+
+	if (cntl->action == TRANSMITTER_CONTROL_ENABLE ||
+		cntl->action == TRANSMITTER_CONTROL_ACTIAVATE ||
+		cntl->action == TRANSMITTER_CONTROL_DEACTIVATE) {
+			DC_LOG_BIOS("%s:dig_v1_7.symclk_units.symclk_10khz = %d\n",
+			__func__, dig_v1_7.symclk_units.symclk_10khz);
+	}
+
+	if (bp->base.ctx->dc->ctx->dmub_srv &&
+		bp->base.ctx->dc->debug.dmub_command_table) {
+		transmitter_control_dmcub_v1_7(bp->base.ctx->dmub_srv, &dig_v1_7);
+		return BP_RESULT_OK;
+	}
+
+/*color_depth not used any more, driver has deep color factor in the Phyclk*/
+	if (EXEC_BIOS_CMD_TABLE(dig1transmittercontrol, dig_v1_7))
+		result = BP_RESULT_OK;
+	return result;
+}
+
 static enum bp_result transmitter_control_fallback(
 	struct bios_parser *bp,
 	struct bp_transmitter_control *cntl)
 {
 	if (bp->base.ctx->dc->ctx->dmub_srv &&
 	    bp->base.ctx->dc->debug.dmub_command_table) {
-		return transmitter_control_v1_6(bp, cntl);
+		return transmitter_control_v1_7(bp, cntl);
 	}
 
 	return BP_RESULT_FAILURE;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
