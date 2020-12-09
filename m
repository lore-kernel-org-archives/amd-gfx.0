Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB2BC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 12:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F66B238A0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 12:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F66B238A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4316E192;
	Wed,  9 Dec 2020 12:50:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473516E192
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 12:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXYSuvAKM8Nj2OHkS2FfiA8K+0qqQe4+Js2ATPSUYBWVGKP7ZY7645DDUHRvlBVYAYgt9WHiy6S3GGJWV/kS+/WkK1qJDnFMUj+gugzwxsv7G5F5TvYKSPFotchS8AO8JBLldCzyqh+6Jk+yRIUyEAoHb/hwsyxR+R5/gqcFtps5fGZP0WxETefd3HoTM3WaZA0BYAashc1hS6QAIdLNywBOx8GVkBoPci6qMw6xHR4RiI5b4NOgCD4EdbjKs2H9qLg5VmXyVgxJT2h1t+9rjRhWlB0Yf2wJy4+UT0fJ/bEK5GmNbw5VLvPHeTh1cVbaYGHXYO+4zORG3+5uqdj6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjqxyzWiXsuzmwK5LBj+6xH7OzdFK9UbYuzxm+F7IGM=;
 b=LA+vay1piHiteMjxWpFp/jdIoPp2bOdV4Ax5vgNlf0VC/vA1/nEX1M8Hv0h5P1ZJRBdAE12Z0XilXPLtVkhvWuk4JnOE45Nhfbk0MIYANi71JReqxIiSJTQH1ixdRAhdyDucnBnuDCgx+qPORJH/0SFhWs/AAi0Izt7vDKXNfW/5l3gUkGh+2SAS9LppsiHG7iO4NZAQZhQ5LwVGuAL+yk9kBdn0YGeQwYAGZ5bPDRX66jaxrcHGnCVhpj5t2CcloaHxnmf4Iuwu7SWNPUKKw1oDQOpz0wJ40ql/jyR2elt3vhSkBP2ELKYLU6rL4KJGX2WHIUurT6DG2JC/Ah1oYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjqxyzWiXsuzmwK5LBj+6xH7OzdFK9UbYuzxm+F7IGM=;
 b=bWfAoWJmuVNpjFBFRHMcmGzmpWc4QzVrDhlK5ZremI6UZDIXkeoFmCaNEF4x4AzvWlTPntI7mOS4RwaXZV+ypvdXMUub8F4Zga62jUsXURuOVGbhWENXdZLqZPMcN/JJC2IBGh4K5fZQeuYkEacdhtDKKpOI0Ccjz3CG6tctwQA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 9 Dec
 2020 12:50:14 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067%7]) with mapi id 15.20.3632.026; Wed, 9 Dec 2020
 12:50:14 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amd/pm: inform SMU RLC status thus enable/disable
 DPM feature for vangogh
Date: Wed,  9 Dec 2020 20:49:38 +0800
Message-Id: <20201209124938.11680-2-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209124938.11680-1-Xiaomeng.Hou@amd.com>
References: <20201209124938.11680-1-Xiaomeng.Hou@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:c9::9) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HKAPR03CA0022.apcprd03.prod.outlook.com (2603:1096:203:c9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Wed, 9 Dec 2020 12:50:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0dc5264-96d5-4d4a-b473-08d89c40f94f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44717DC2670FFCEF2162DEDC9FCC0@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knv4la8QpkBC/EkdOWGTMr8kNFYEvHKf0IowcZqOSmymp0RUkusPnRQDmPRu8o1/ZTFSSNwnljqZoXLggqcPeC5IaYREMWU2a0F/jsIlu470mgRNzlHiW5WCOpFOzEiA+rR/ZMAlj4Ru4MVvTwDVMiNNX7WIcBmFrnOxhyzkTKU4kceBEvUWYd7F6ftlnrhhtHY/90gU2RxNaxJPw1tFjgy0q44wPRv4El7KniPrGXSSYl2Ux0cGtziFgafhDiji7CtMjzNNO/qsRn0XQDkysbouo08OHMDnjZfRhCllND5nA2S71bRnFRKiel6TXTAUMebW5CMhlDgUuSxUmDixOymThu3AEzC/RkUEXG9a4P3MxC9fh62GW+f8lfncKKLh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(8676002)(6666004)(7696005)(16526019)(1076003)(2906002)(36756003)(186003)(4326008)(52116002)(26005)(8936002)(34490700003)(5660300002)(956004)(86362001)(6486002)(2616005)(6916009)(66556008)(66946007)(66476007)(83380400001)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y5m8J64ufeVSloLMjewr125tsEYvbptFqDcpJ/Ngj1xRFbjIqeC76EzVf48o?=
 =?us-ascii?Q?oUnueu+6lz0nD76sTAH3xi2JvyDsRGCVjDLM6jXdvCTYmqfmiSlsGyUebZA0?=
 =?us-ascii?Q?2V41Nnlsu3tJ0ycGLU3Nfh4ON1gGTkZr8g5vUAyQ1CdhTSo/03EZTJoreryu?=
 =?us-ascii?Q?JNuMj8nGWV5qF49MRuYqAACNOcUEpWRi0+fk3bQ+emyCkkGS2mQUBomJzWyH?=
 =?us-ascii?Q?niSXPvgy8qAH4Bn2+KAui5vqONRMPD2p+rgI3uZHRx823In4XSi7aQpD9MSY?=
 =?us-ascii?Q?c6Dfq69tdkOitKVgg+dLB6JYKtiy6/BpbK5mhCW85XFTuubVLWJJkmYdN3i7?=
 =?us-ascii?Q?jkSPHLuNCiKeONP/sUFkPcO2hlazdzfoXw9shOmgYxwjp99GXNQWzuhGcaU3?=
 =?us-ascii?Q?zO2/zYoJzlcfrQm0wue4510WymzF/gRX6RCdKiaNWTmRbXCBhFDM08+lAcev?=
 =?us-ascii?Q?pyib2jRUouyLh88f3zYgvStclJtoQDYVdYvudJ5/9qOfizJ8tZDo5K+BvGS6?=
 =?us-ascii?Q?59ATQ+uEyNG0ZlTMAdaVH6ypFzMBXkf4oylOlBOBlb6NagDm9yTn99Rnv79a?=
 =?us-ascii?Q?bZwybyXkyZQCmYZafCg1YHctlTZtmB60q6gcb/dAQWB+G3lofORXGPXGud5O?=
 =?us-ascii?Q?eqyNyvUtU/4da2pGDoAHZe/7dvR7YKsGKdVYIUlHXLrpso5XQoHdAZzy7Nxd?=
 =?us-ascii?Q?RnYurWgNWKy7t5Mj23tIm+9pnOE+L/OHF3Xy2c+wYAW+yc+OSoWjLEIh82eK?=
 =?us-ascii?Q?fmt5rAO68YD68rk21qhkAPiCX4XZ8OgkYnbfJIELjb5ia3X1vgNESrUTFC+4?=
 =?us-ascii?Q?BEHXd5ZBzED/pMDzq3QXjZ+nttZmTtIcjEEhVSJV+39PYQ3Bx1Syvcs5VgDQ?=
 =?us-ascii?Q?go2I7NiWckLgZntdgiOvyBS5gaE8kMOlpmWsmN1t+sEWJjyO0HLY7c3FRoE6?=
 =?us-ascii?Q?m2ZQk380KO6SvkYU0hfUEnT7dxjwam1X9bNyahYNbtHuZBv4C2C5zBkxDqEE?=
 =?us-ascii?Q?UXfu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 12:50:14.6845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dc5264-96d5-4d4a-b473-08d89c40f94f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGwGk0U6RbjMOg0M6KAXxTRVEFX2dMnNzE/3+19OoP2Rngpkc5fYmRZR2iQxtevQ9mZUNvtpWVk36ImZTghOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
Cc: Lijo.Lazar@amd.com, Ray.Huang@amd.com, Xiaomeng Hou <Xiaomeng.Hou@amd.com>,
 Kevin1.Wang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RLC is halted when system suspend/shutdown. However, due to DPM enabled, PMFW is
unaware of RLC being halted and will continue sending messages, which would
eventually cause an ACPI hang. Use the system_feature_control interface to
notify SMU the status of RLC thus enable/disable DPM feature.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Change-Id: I2f1a7de23df7315a7b220ba6d0a4bcaa75c93fea
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 ++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h    |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index ddaa6a705fa6..fb16d94b4031 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -64,7 +64,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,		0),
 	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			0),
 	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			0),
-	MSG_MAP(Spare,                          PPSMC_MSG_spare,				0),
+	MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,		0),
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		0),
 	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,		0),
 	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		0),
@@ -722,6 +722,20 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	return 0;
 }
 
+static int vangogh_system_features_control(struct smu_context *smu, bool en)
+{
+	int ret = 0;
+
+	if (en)
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
+								RLC_STATUS_NORMAL, NULL);
+	else
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
+								RLC_STATUS_OFF, NULL);
+
+	return ret;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -750,6 +764,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.print_clk_levels = vangogh_print_fine_grain_clk,
 	.set_default_dpm_table = vangogh_set_default_dpm_tables,
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
+	.system_features_control = vangogh_system_features_control,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
index 8756766296cd..eab455493076 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
@@ -32,4 +32,8 @@ extern void vangogh_set_ppt_funcs(struct smu_context *smu);
 #define VANGOGH_UMD_PSTATE_SOCCLK       678
 #define VANGOGH_UMD_PSTATE_FCLK         800
 
+/* RLC Power Status */
+#define RLC_STATUS_OFF          0
+#define RLC_STATUS_NORMAL       1
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
