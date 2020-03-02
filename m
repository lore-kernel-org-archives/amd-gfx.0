Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91BEC3F2D8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE2D21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1XAuXoQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE2D21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F6F6E5D5;
	Mon,  2 Mar 2020 16:48:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C991D6E7D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnaCWGCOjyEYQX1NT1w9h+Gw66mtueIMa3gs+6R6Dmnm+klqsBGEURCN0h9g6bfvNFYJJS69tsKpO28InebncAyGERN4+rFHYvrqzpnrL6XOeBNwDPmfvXrDIQW9WbxTvWqYNN2rND0Ikoz/9iUII/TBF0sysu1q0ypU86ROOjj+ARQJ81yohJ5z5OX2EHVdgLY56xxwhmnTRAjG3JPsareNnKAEnZD24ECq9H6RLnfEGkadC3O8uGoViobGQo4ZjZ60FTk8MOVQ1ikpcyINZYacVJeX3Ehhw9cBIUyYmrY5GQuu5mm0rYEZqYHuWzvo8gIgELyxtrfb6WHOVIA1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx/loU62fCoJWo7AoXzWP3a01C0pxGmeEloTym0p+sg=;
 b=HgZ5psYzPOTXxT2mImTFntGJe7xUjpSOF71b2fIyCqXctGRMQiqTK3VJ3dlhelFLQtQp8KlKScIrVupNblwKItp7MVmo0HiyTADHSq2141cZ07+80xZle1BbiQp7wvEdKF0kOXqzpMYjIrH42H50u8up48mSN1VchShq35C6qDrK1EBvlZY6LXmwf/qtTH8SvDDqHnug1J3yMNycdqwDLZ8H+YFoxawRze7opEc2H4thlNMR9wvGSaFJJA6VBdjPjxzUB57S7p5Z4kYcfHGxPvDBDzXFeaV6FQH1cqTp0nV/Bv9lGskc9fl1QKXj14avbkOcLYXJ+26IHmqCGENS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx/loU62fCoJWo7AoXzWP3a01C0pxGmeEloTym0p+sg=;
 b=1XAuXoQA9JUl/bYvVfKZc5lK8+EzmoMRXB2nkxbBDiuczEtepGxhY2YZ73HL1lq65GU0TRWVpI+PJHbpvjJhb29j+ryexY3tvAwzr9oi2ySKbdztpg9dTF0PxS+kgR4OZDi+dFADmbZLbT6zVEiZDUDNAMk45c+qxy3NhXzqpvU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:48:11 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:11 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/22] drm/amd/display: Add ABM command structs to DMCUB
Date: Mon,  2 Mar 2020 11:47:34 -0500
Message-Id: <20200302164736.89429-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:08 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a3fce2e-ca18-4d0d-fdba-08d7bec97d18
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2411CD4AB259E35967E220B398E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hInzx7jTFjYxQ8xnxfpIFrLRlcMsTPuHRx4UiH5fN+avBgImOZAejUrxR9mCKzpRhI35MXLi3kFD6osDDF5yZ+QMsxrY8PIOV9EtwErCVzYo+Y/bfff+wqbqZnudGwW+lp2DksEYycrxkhMg3baFLWtUERv1L90C3+HXqfgde81QN5ZltPIoPwzI6yIn9pixE+wr0amcrf/XVOMSCUB0lTD0FhZak8DyW8mdfvTDpVwxS4oeq33Bge1w6VwDhFjActLSU+wyo8M09KbkLWZwChwLyxLKdTiOPjYY+LDLH1YAkCo1yZ5R7DcunR6CLxptpKsss1r6GI5EADO/X3KEYu7pSSiNZq1W5EL6aWZnySsVdy13LDxNzfdIeJc4oFeFI8QqOWzc316X6R6mRnC/OoF6+oh7sKfJJjZZjgL4n5axr3uwB0AZ4xwJNP9O1c6
X-MS-Exchange-AntiSpam-MessageData: /iYiU3cHjuOIbAb1J4kcSUB2XJZY6Ar98gqfww96mnQOyOuoAbEiqxyKEhxF/AosGxhJSDZkh/xv0B4QQtovnI9+LWHFFoQjZbELRk5mwQ5UZd1iN7uaWGpXW9XOrNTHNFFO1B2hxUSAdB4QeLBABg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3fce2e-ca18-4d0d-fdba-08d7bec97d18
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:09.5896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY9RZm+u0l/ps/DQ/+GYYE0ehjWfLU6fnzjnnbtKIPPRQ88GYPYnUqtCsJfsGb8GERz+ET5OuK7S1Ogbvf2fZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Moving ABM from DMCU to DMCUB.

[How]
Add ABM command structs.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 52 +++++++++++++++++++
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  9 ++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 0cb8967f0c45..10b5fa9d2588 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -50,6 +50,7 @@ enum dmub_cmd_type {
 	DMUB_CMD__REG_REG_WAIT = 4,
 	DMUB_CMD__PLAT_54186_WA = 5,
 	DMUB_CMD__PSR = 64,
+	DMUB_CMD__ABM = 66,
 	DMUB_CMD__VBIOS = 128,
 };
 
@@ -256,6 +257,52 @@ struct dmub_rb_cmd_psr_set_version {
 	struct dmub_cmd_psr_set_version_data psr_set_version_data;
 };
 
+struct dmub_cmd_abm_set_pipe_data {
+	uint32_t ramping_boundary;
+	uint32_t otg_inst;
+};
+
+struct dmub_rb_cmd_abm_set_pipe {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_abm_set_pipe_data abm_set_pipe_data;
+};
+
+struct dmub_cmd_abm_set_backlight_data {
+	uint32_t frame_ramp;
+};
+
+struct dmub_rb_cmd_abm_set_backlight {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_abm_set_backlight_data abm_set_backlight_data;
+};
+
+struct dmub_cmd_abm_set_level_data {
+	uint32_t level;
+};
+
+struct dmub_rb_cmd_abm_set_level {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_abm_set_level_data abm_set_level_data;
+};
+
+struct dmub_cmd_abm_set_ambient_level_data {
+	uint32_t ambient_lux;
+};
+
+struct dmub_rb_cmd_abm_set_ambient_level {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_abm_set_ambient_level_data abm_set_ambient_level_data;
+};
+
+struct dmub_cmd_abm_set_pwm_frac_data {
+	uint32_t fractional_pwm;
+};
+
+struct dmub_rb_cmd_abm_set_pwm_frac {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_abm_set_pwm_frac_data abm_set_pwm_frac_data;
+};
+
 union dmub_rb_cmd {
 	struct dmub_rb_cmd_read_modify_write read_modify_write;
 	struct dmub_rb_cmd_reg_field_update_sequence reg_field_update_seq;
@@ -272,6 +319,11 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_psr_enable psr_enable;
 	struct dmub_rb_cmd_psr_set_level psr_set_level;
 	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa;
+	struct dmub_rb_cmd_abm_set_pipe abm_set_pipe;
+	struct dmub_rb_cmd_abm_set_backlight abm_set_backlight;
+	struct dmub_rb_cmd_abm_set_level abm_set_level;
+	struct dmub_rb_cmd_abm_set_ambient_level abm_set_ambient_level;
+	struct dmub_rb_cmd_abm_set_pwm_frac abm_set_pwm_frac;
 };
 
 #pragma pack(pop)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
index ce793f47f234..d37535d21928 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
@@ -45,4 +45,13 @@ enum psr_version {
 	PSR_VERSION_2_1			= 0x21, // PSR Version 2, includes Y-coordinate support for SU
 };
 
+enum dmub_cmd_abm_type {
+	DMUB_CMD__ABM_INIT_CONFIG	= 0,
+	DMUB_CMD__ABM_SET_PIPE		= 1,
+	DMUB_CMD__ABM_SET_BACKLIGHT	= 2,
+	DMUB_CMD__ABM_SET_LEVEL		= 3,
+	DMUB_CMD__ABM_SET_AMBIENT_LEVEL	= 4,
+	DMUB_CMD__ABM_SET_PWM_FRAC	= 5,
+};
+
 #endif /* _DMUB_CMD_DAL_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
