Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D7C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB59561C49
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB59561C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AADF6EDD3;
	Wed,  2 Jun 2021 16:51:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FE56EDDA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1O9tb7iYe0GhB2y0WaBbLlz989oL3Qlis32mtPR10gN9n098UpipTFghfa0gByj+dYHz+Ie4a/ovq2VUK4ibxnI+oTNPyHORWCvBR3bcYJT6+EfQ/jHz2d+YeqBn5eoY4qp9wA+vXEdlxtzmVc/OQSddpzoTbk7uxJy4DhuGzVq26bnaXPowsbNKh6bq9tqbQF1jrgvYzuhLasVvMrGUy9KSyn0MqZJvCa2ERg+jaGaAdy7GV4mFqlrwBF4769DCvOJNxqcbzbb/1QxC7SqJf2WbUvJX77L71JKf3Cie2cUxmvWKZrCpTOIBkc9EcugrDtcWpvr6u9DoYLsOR/gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wURAdOh5DoEzC2+UIIWZCwrGInZuk0V2eTIheBFUFzY=;
 b=WYIpmnMITaHLeA8/Kg5kx1fipmOe36fmHYByIn3rnIgKVPapa/6LObTmoGFl+r2mgzuhf/3smS0lAU6zLb5JDbx4T0a7E7x/wwrec9BJzjaHp/rabo4HRIqeWu5vN024dF7BCnP4U0UOosUo3iWrNHpjPtOL3LeOapDtpkaKxf5/hMK63aq2NByeILpLT7hY2EDWhOan3Dq7+TEvcC3CXza2KmzspvqYSuSpwqvE1iZrvpGOk2cE2NMW16Ipo5KNoYRosKIRf5pLPjOaddocfzcCcYQ6ZC4C8Z9/sRHaXf8g4yEtmP9YClI3BkL5nX5FEm+l2R+E1Cn3LlII51JfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wURAdOh5DoEzC2+UIIWZCwrGInZuk0V2eTIheBFUFzY=;
 b=U0Hb1P0zOMZocAogQsIWWVHcZafZ/M+8eMb9y6idba/W07B4nw8nFdJZPccAaAvjU/3S2V+P5ihIWCGag1U+ho43p9sEKLANxbRCmHCTKM/C7n0IxqpNXaFpJZTdcAmv0/f2+FybWXugpzJfyNsHa0Ts9RnafZJUY9llQ46xnwA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 80/89] drm/amd/display: Add DCN3.1 PANEL
Date: Wed,  2 Jun 2021 12:48:59 -0400
Message-Id: <20210602164908.2848791-80-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 420ab589-199c-44a4-2bec-08d925e6839e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45340DFA42E91908609C5F54F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPN7i8TxP7dNRdeUlLpKwQROjn0yKY39rLQnwZh53ASXUoJbsyAmYIdJTnuXaEcOO1mSZc8pjoauXPIJDoR8Gl98afUYC3TUHwv9r9oPG4jyOyMmxx97TWYY1ZUVY5fQE/DSpbNMlxdb7m5Pv+YDS69IiY1OtlDkPvV1wN2EEjbFob014shK5za7x7vtib5mJPyxfr5/MNw9BflfrOqyQ+Sme3cmU6Hc/u9G+8CCYIsVPRDxUXq5PMWdoHUu4rQLyCY5XAWRychoZ2K5iAmQ1JUJBycckPeTOuu2sFc/KA+7UvIts/Q6TYgDxeGhGKTYz1yEi5rzE1A9AtgEY7j116UvhWvoaovUL2Ci7wmpccnWM8uM4eROl1+oZW4EkLgDN6ADd6zYHxIxGGAnEf4EE8hTtSTiOuDZA75e+DN6u0xFh5a566gKLTZgyaimMn1Jg32p5ux7ZUwIGqw7ZVRcV+XXtK225uMh2vvatlXnnzBlV83uHtO4Y0p9pm7D6vDv1AdyaOehH23rEwyUwmE1NvuZP8NRw79ZcXBaiTsOzXauxaZIg9XKBeCRFoU9DPMQ1NsJhO/8G5CzjP1C1GAc0eXkfwvkmd+KXSC2ybY9r9B/AUY0y8AF62fZp8I2ICDL9wkK7QaV0xf28PVYx5oRYF6i12XktCbJhbuYYPgaUIV+pKDJC4WxvdU7aGQkcNY4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bDmz4tP3j39zXpChklyRf+8x17Um5aE2u6OBA4sIY7N4oSnM8gumvFDU81OB?=
 =?us-ascii?Q?GfNRx13SCZV6X24DhhtPY4W/FzRkkPZr4Wj4k0gAhwyeeqIQGiI1kL8nVW5O?=
 =?us-ascii?Q?CrllQN8kQdaIbAaSbmICSXA5Pl+vv9aa6xPVwRbAVXgQ/JI6w+haYzzUtLoF?=
 =?us-ascii?Q?R4sYFF/HMb0cKuP5iFL2UX5TXGhXCuAJLvNeYdvJW/83/D3XVVOWzISOh61H?=
 =?us-ascii?Q?RP/8oOyyVGQBoznrpW/OX6Ex0I4exkUDym5BQwIUnJySPaAZ9F2AvfNPYq/q?=
 =?us-ascii?Q?4wCWDjpAzeZIOvkI4DdFgPEWRkvXREnbdq8swTkH5P3rUs8x8wdoh01imEJ0?=
 =?us-ascii?Q?SMtPQcxFELqEMiOdvPku3TdYOo9ziBixbe8b2qBj0LYWIoVjkl/KWW0+zgKT?=
 =?us-ascii?Q?Fmn5AoMB4I9mqA/lT746CFx2pNlnA1WIKosddC6DjY5fNtJAE1kUvISFELX/?=
 =?us-ascii?Q?6schC5SHXeAI4Jz8H99tdO3qa73rQRPL2x8afPZ3uxGsc8Pa9avlk0BJqwM5?=
 =?us-ascii?Q?vBCw2wVLKLd45hCCM9X+L47LY7axZj71OyxexQ3PkPJDf9UuynjFuCJCqAJe?=
 =?us-ascii?Q?af1xrk7ZIwkoe5I6G/hx58+eedbX5A8dFbRxrzG3jkL66k9/3Vw5KAB/1FJU?=
 =?us-ascii?Q?ovEa8I0L7sunTMkO4OtN9UdTxpmvuvnDnwRaRe8MZhsERDkXSsQ1tEaEfdoT?=
 =?us-ascii?Q?2WU/9oJwJ39wtgM5KFZXRvdabPxSX/mBjq0Fc2MRR+Kd9/OAogpS5nAMJ2QW?=
 =?us-ascii?Q?HQ5mLv6CKxkchhGDEl7xnesGAH1Gu7x3fwEBB07I7DovMs3xUH3dS4LpV5Vw?=
 =?us-ascii?Q?bsaZKvQy/DhzjkCIaHUS3Al0fP+67GH2J6QTZJFHnqI6QXwoAC0I/E+641Yf?=
 =?us-ascii?Q?UJfhFfKeF8PqD6/EfT+hlYdNSxjjQm6Kohn9JJppGU0eivCKeYhOEWfUhMQG?=
 =?us-ascii?Q?+LKUHIRgPX5ukzDBOErIatEEzmHjgwATSceO6hVMZF3a1cKsjSh0ZkIlNbTn?=
 =?us-ascii?Q?B6H3knWXZwMlwRUcTvcO14KFWLZW6Yg7uSLQ4h7ZmdWamuAJh9Gmsz6Br9LI?=
 =?us-ascii?Q?YZB9whxV352EAOkJv6obrwAH1UiXN1RFuX37BLN2HjdlAgj/ACDxtBHXZsfP?=
 =?us-ascii?Q?YuIONhjlKXOl9ZMtfstps4Mm8x8HdHCvELaasHK61V4qpBBo8hsi/7zzYlDS?=
 =?us-ascii?Q?xtp+9fWr7jYIDbvRscaC+yPmlRNMybDAUX+cAfglcKGQNLb4P8IlKR+zbOXB?=
 =?us-ascii?Q?N9xc4vdYNJL9eMLqClPET38WJbg6Yle/bSzHJU7edJUE8qjyWpq9mAGw684a?=
 =?us-ascii?Q?jV3LIWvm6ATRqLu1k3weXfHv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420ab589-199c-44a4-2bec-08d925e6839e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:23.2205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF5T8j2MlLehVqeYj5LZt0YJ9zMnJ1zCACsrdmj3t+3RhHAS0TWniYmcU07b+d7Jfx+3I9odFWUpQpCLJPXGmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

The PANEL block handles embedded panel power and backlight programming.

This programming and sequencing is now owned by DMCUB and driver will
call into the interface for backlight status and programming.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   | 157 ++++++++++++++++++
 .../amd/display/dc/dcn31/dcn31_panel_cntl.h   |  40 +++++
 2 files changed, 197 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
new file mode 100644
index 000000000000..7db268da6976
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c
@@ -0,0 +1,157 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "reg_helper.h"
+#include "core_types.h"
+#include "dc_dmub_srv.h"
+#include "dcn31_panel_cntl.h"
+#include "atom.h"
+
+#define TO_DCN31_PANEL_CNTL(panel_cntl)\
+	container_of(panel_cntl, struct dcn31_panel_cntl, base)
+
+#define CTX \
+	dcn31_panel_cntl->base.ctx
+
+#define DC_LOGGER \
+	dcn31_panel_cntl->base.ctx->logger
+
+static bool dcn31_query_backlight_info(struct panel_cntl *panel_cntl, union dmub_rb_cmd *cmd)
+{
+	struct dcn31_panel_cntl *dcn31_panel_cntl = TO_DCN31_PANEL_CNTL(panel_cntl);
+	struct dc_dmub_srv *dc_dmub_srv = panel_cntl->ctx->dmub_srv;
+
+	if (!dc_dmub_srv)
+		return false;
+
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
+	cmd->panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO;
+	cmd->panel_cntl.header.payload_bytes = sizeof(cmd->panel_cntl.data);
+	cmd->panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+
+	return dc_dmub_srv_cmd_with_reply_data(dc_dmub_srv, cmd);
+}
+
+static uint32_t dcn31_get_16_bit_backlight_from_pwm(struct panel_cntl *panel_cntl)
+{
+	union dmub_rb_cmd cmd;
+
+	if (!dcn31_query_backlight_info(panel_cntl, &cmd))
+		return 0;
+
+	return cmd.panel_cntl.data.current_backlight;
+}
+
+uint32_t dcn31_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
+{
+	struct dcn31_panel_cntl *dcn31_panel_cntl = TO_DCN31_PANEL_CNTL(panel_cntl);
+	struct dc_dmub_srv *dc_dmub_srv = panel_cntl->ctx->dmub_srv;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_dmub_srv)
+		return 0;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.panel_cntl.header.type = DMUB_CMD__PANEL_CNTL;
+	cmd.panel_cntl.header.sub_type = DMUB_CMD__PANEL_CNTL_HW_INIT;
+	cmd.panel_cntl.header.payload_bytes = sizeof(cmd.panel_cntl.data);
+	cmd.panel_cntl.data.inst = dcn31_panel_cntl->base.inst;
+	cmd.panel_cntl.data.bl_pwm_cntl = panel_cntl->stored_backlight_registers.BL_PWM_CNTL;
+	cmd.panel_cntl.data.bl_pwm_period_cntl = panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL;
+	cmd.panel_cntl.data.bl_pwm_ref_div1 =
+		panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV;
+
+	if (!dc_dmub_srv_cmd_with_reply_data(dc_dmub_srv, &cmd))
+		return 0;
+
+	panel_cntl->stored_backlight_registers.BL_PWM_CNTL = cmd.panel_cntl.data.bl_pwm_cntl;
+	panel_cntl->stored_backlight_registers.BL_PWM_CNTL2 = 0; /* unused */
+	panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL = cmd.panel_cntl.data.bl_pwm_period_cntl;
+	panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV =
+		cmd.panel_cntl.data.bl_pwm_ref_div1;
+
+	return cmd.panel_cntl.data.current_backlight;
+}
+
+void dcn31_panel_cntl_destroy(struct panel_cntl **panel_cntl)
+{
+	struct dcn31_panel_cntl *dcn31_panel_cntl = TO_DCN31_PANEL_CNTL(*panel_cntl);
+
+	kfree(dcn31_panel_cntl);
+	*panel_cntl = NULL;
+}
+
+bool dcn31_is_panel_backlight_on(struct panel_cntl *panel_cntl)
+{
+	union dmub_rb_cmd cmd;
+
+	if (!dcn31_query_backlight_info(panel_cntl, &cmd))
+		return 0;
+
+	return cmd.panel_cntl.data.is_backlight_on;
+}
+
+bool dcn31_is_panel_powered_on(struct panel_cntl *panel_cntl)
+{
+	union dmub_rb_cmd cmd;
+
+	if (!dcn31_query_backlight_info(panel_cntl, &cmd))
+		return 0;
+
+	return cmd.panel_cntl.data.is_powered_on;
+}
+
+void dcn31_store_backlight_level(struct panel_cntl *panel_cntl)
+{
+	union dmub_rb_cmd cmd;
+
+	if (!dcn31_query_backlight_info(panel_cntl, &cmd))
+		return;
+
+	panel_cntl->stored_backlight_registers.BL_PWM_CNTL = cmd.panel_cntl.data.bl_pwm_cntl;
+	panel_cntl->stored_backlight_registers.BL_PWM_CNTL2 = 0; /* unused */
+	panel_cntl->stored_backlight_registers.BL_PWM_PERIOD_CNTL = cmd.panel_cntl.data.bl_pwm_period_cntl;
+	panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV =
+		cmd.panel_cntl.data.bl_pwm_ref_div1;
+}
+
+static const struct panel_cntl_funcs dcn31_link_panel_cntl_funcs = {
+	.destroy = dcn31_panel_cntl_destroy,
+	.hw_init = dcn31_panel_cntl_hw_init,
+	.is_panel_backlight_on = dcn31_is_panel_backlight_on,
+	.is_panel_powered_on = dcn31_is_panel_powered_on,
+	.store_backlight_level = dcn31_store_backlight_level,
+	.get_current_backlight = dcn31_get_16_bit_backlight_from_pwm,
+};
+
+void dcn31_panel_cntl_construct(
+	struct dcn31_panel_cntl *dcn31_panel_cntl,
+	const struct panel_cntl_init_data *init_data)
+{
+	dcn31_panel_cntl->base.funcs = &dcn31_link_panel_cntl_funcs;
+	dcn31_panel_cntl->base.ctx = init_data->ctx;
+	dcn31_panel_cntl->base.inst = init_data->inst;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h
new file mode 100644
index 000000000000..d33ccd6ef8c3
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright 2012-15 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ *  and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_PANEL_CNTL__DCN31_H__
+#define __DC_PANEL_CNTL__DCN31_H__
+
+#include "panel_cntl.h"
+#include "dce/dce_panel_cntl.h"
+
+struct dcn31_panel_cntl {
+	struct panel_cntl base;
+};
+
+void dcn31_panel_cntl_construct(
+	struct dcn31_panel_cntl *dcn31_panel_cntl,
+	const struct panel_cntl_init_data *init_data);
+
+#endif /* __DC_PANEL_CNTL__DCN31_H__ */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
