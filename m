Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD51C48BE8
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C243360FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C243360FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F3A6E140;
	Mon, 14 Jun 2021 17:47:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE5D6E138
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGdLpm7ANGWquPCEcSybv4rnT44TcuMmgT2AsjSR6kVrUaxTC6+I6wWJ8X9PlB+lkAjZX4zG15wzxU2l2gjrjDmkdFoWwt33tCUlhLq70IyEQcYICk9FPEvXx6vLmadAfimd9m1KbR5T7InlAlPZAmcH8uvLf3HzfgtxirSA7eb8L8JvEwE6hABBZBsLiFqY1S8vlsfccFsv14g+FSk8W162G+cES55driKF4KpCG5cYNJizmv7np/LHLekcE5GHR3uvAvC3MWWgGw50n72ErzxS807GvLl2pzXwMF4GEI+xhIIlmvzZEw6/ZH0SIpWVMXMYrFBD4gKyay9EX0HPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QW60u9PWa0x2suV/q9aUg5KHUtz5yK9rhKKV9TyVfw=;
 b=IcZYRyQX4BX0Ewp5ugRckRutpDnQCxD9olecF54UUN/XAUwIBZ30VjPndbvLF1YCaFW/SL7BgagYEZ8sC2sKEbztnir2H0BitrTgL65jUU9Sa0WFu7nl5kC4jd9eXY0u8sh5wqH8+qvf5h4xScBAASGoQMrlRfMEcQqOqkcV1e4ubLD6//dfSrgkqYNr95nrBbdVnaKtzD2hNl3/m/JL0TBCRWM/J9KWYiPmAmU2RL+r/RFnejo/af0x1sDzeLBchg7Bk5vuf7dyTVb2ZudcSZz1qQx72Pk4ssGEbd8mKZx0SdCbgkm9L11UibCj7gGJpbra2tiN8eqzbQUahu25AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QW60u9PWa0x2suV/q9aUg5KHUtz5yK9rhKKV9TyVfw=;
 b=bP/ppg6sW5Ro9NSGWOeeCfnKyoYUvDG20UVKNMNn6NIe/SZj9F1fiszaCGDBkgZbCY3DCMSxQM9jHOucNy1kpaPIsfBAOLvT/9uFkNdR8PDGfv0nl36x5+3/RPu+35R+MoRGNbpvkXT7lpSHX+B85aXl52i8pD4DB+tbipQRebA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:12 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:12 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/40] drm/amd/pm: Extend the I2C quirk table
Date: Mon, 14 Jun 2021 13:46:21 -0400
Message-Id: <20210614174632.20818-30-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6364992-b9f6-4aa2-3e83-08d92f5c709b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3690DBCDC1D81AA4F7D01B1C99319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6L1hQmOrEI0QCPNlf4vHa54ajBD8Qj6krkS8GkRUbMmfl59GtZK4To5nCSowKQVI1V0ZM/hBC8JWyKutGGShgBkQF94npMzKNGo9DSQdYJYKlpBiOU1l/Ct6OSgtfU7YkLjtKUqO0QhsCRNuE9F8Ln2hWGNWdBwzucR2z1mryVB1K7+5YBIIZs6osrfg/31bmAFautyxREqimqqjFPq/VJKHVduIu9PvDsyjuR8I+Jnmnym2W/DYbvlJvYDScjYOsISAD1CniEQHGb8twCze0Eg7V9z2Dkj0G9tjww+d3F9Y+A97GPEWZcy6SWZXXCk5z1J6iDO4ax4E/GEcy8KYHnVxUcmzvkl7nNecWIP5m74agk4y34TGbAcntSmyaB1A2y4m3HceJxjYo+uHMfHR/dd1QA80qb/Hqu0u737968Fzo9kAMajNKzbEfUBCU/Z6u8qrQ810Q8ej+RfQUCuSLAkzjbqitfv67Je2n/z49O8BN+7EyvPu9Q8bLWka/p7pObtThozVL3TAtkHmLRKZDZF7Cy+aof+NZyDbxq9YHRq1YqhojUD8r8QJd0RUkks/rCDECpyOfHcagLUTJ7iyTsTSTyMQz9YjFWqCPEv8m99crsGpfwEGcm9XI49Amp1jSA3RJRIvJs8E8nKeoCLt6Isx1pNFHPW2A2GPD5cdm9IvOFyU90FZTATymCgSMzaJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(66476007)(54906003)(6916009)(66556008)(6666004)(316002)(478600001)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6BdzlYS9R5Oj7uMFAyqvWy2a6TqDT/1//no3Ih9UFPsPbIaSOR5pYuf+hGjy?=
 =?us-ascii?Q?cvGC2SNDVL2fnzZUC1/VdZo7Y8N11ZF7/iNGenv7WmRM0de53xFKLfMfKo7h?=
 =?us-ascii?Q?loNFp8nEA8w+6R9gX4ZFHWUQzMM+VyizyQ530RTJGz7twhLyxlmbHhQMJ92f?=
 =?us-ascii?Q?1pIktDS5Rxh6m43qYC3LMB+QIkgQqe7P2D+k5WXz4BBarGMKuhVtTFHQsyng?=
 =?us-ascii?Q?vuAom9gebjLxSH1WfZQ5OdSWGNTxyALXfmhsKzM2+cFZ5Rmvis1bExc6KYtd?=
 =?us-ascii?Q?uFAumxraZ//xmqt0B3M+E7tFug/rOq2jBLa4lFjKTiBmrESlmszumjGOCrky?=
 =?us-ascii?Q?1P4/4sC1WQXQ/g09NPlaWW6NNdQmVZj4hxBg+XNwtIS3h94hLO7/Bu/JJ+PG?=
 =?us-ascii?Q?bYOlVCzcy437HvxO7it0UcSxkjpfl3cdsjCOtOJo4SXmROV5krD5SO7y3boV?=
 =?us-ascii?Q?9K2sVvRcFVC4VNlfa89+UPnsISetUljv92EgwDu9ShCsK7PwrkSnKQMSKEbl?=
 =?us-ascii?Q?yvzYY+Zgm+QBDo7Cf1QE+Y96kPrqW2IODEngGkMZyYmRh8PPfYJUZZe4ggYa?=
 =?us-ascii?Q?ZbH2l4eC61dr1dka73uQ+MTyEOwqhbKsjh3J82E3il4dfKx2U525o+8FKMMj?=
 =?us-ascii?Q?GPKSiKfh1RYN2ggABcYIFwKI44g9nKmgXu2FHSwtYha7GzUh8m8bxAiTZKWV?=
 =?us-ascii?Q?rne7Kf5vSXD7Nhq6AjLdo3YJg6jbdxr/ZwrMvunFbAY3qZb6amxS+t3RPvx3?=
 =?us-ascii?Q?E5dyQwXsMUhY1BvaTwyB3RsGLjs4Bk4Jl4DlnGVMoPRImyhf9qRnidTdEV9s?=
 =?us-ascii?Q?iocZHxPlMTT45N36B+VF24Wj4QK/H3AWagZjv0owld9OtNju+QCw6V/gjUPR?=
 =?us-ascii?Q?mHXG85rp19xX490Rc746ePtc0mESMhdzuC07mj8RS750hRLYCdD0vY3iGmES?=
 =?us-ascii?Q?DuxgLo1RTLXf9Yu8/07lQ9LAQIHhXb4iDZVzEMzPehswBFecwB3T7iIUP/1u?=
 =?us-ascii?Q?69CF/PZ0DKzMfSBKCSj3Js5HTT32GkWePGMooVE/B2IqwRKHBkcFLryADUrl?=
 =?us-ascii?Q?AUOnJKJAl2g/tnbXgWCDb1we1xqO0H/SkH2mq0DW4KiRajAIJqqugu29RVw9?=
 =?us-ascii?Q?LVKzcEzuPTnF/Xnf7YbofVMNN7QZ1VhAfy26MpNmtGF5sMwHTzcjs3ypf8fH?=
 =?us-ascii?Q?4flIehEOn8iLw5VaMGotLNBtJ9FRv5iHeljxVMG5Ot9HgpFlUnmrqdOLozSD?=
 =?us-ascii?Q?h8jWn8G5WmYxfCOLzX3BfPRG8z0ytvSot/+FTp7ag3s76pzfaZVD+fKEIhM5?=
 =?us-ascii?Q?IiBDLaLUvkFNx5yDqOG2vQhe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6364992-b9f6-4aa2-3e83-08d92f5c709b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:12.3684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCYdc0AyyJc+r8cTFE2rTuVkW0Bir22X232WTAJ4MgVjJNNd0LrCGvVgKOAf5Udm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend the I2C quirk table for SMU access
controlled I2C adapters. Let the kernel I2C layer
check that the messages all have the same address,
and that their combined size doesn't exceed the
maximum size of a SMU software I2C request.

Suggested-by: Jean Delvare <jdelvare@suse.de>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 9fccdd2d3e73ec..3286c704bd08df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2036,8 +2036,11 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
 
 
 static const struct i2c_adapter_quirks arcturus_i2c_control_quirks = {
-	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
 static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e3cbd334a956d1..e9c14ab7699502 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2834,8 +2834,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
 };
 
 static const struct i2c_adapter_quirks navi10_i2c_control_quirks = {
-	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
 static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 2444e13c4901b3..37cfe0ccd6863b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3541,8 +3541,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
 };
 
 static const struct i2c_adapter_quirks sienna_cichlid_i2c_control_quirks = {
-	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
 	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
 static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
