Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F43C4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71F261375
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71F261375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD486EC49;
	Tue,  8 Jun 2021 21:40:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A902A6EC4C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdV3Cn1nKnyKJm9tnSs4NBRtGV0iNISR0vnMWrkc51FFAto0N7rPmKvpEGtbKyRhgU2Y8Ed7exyIk5RKknxFZaSm6VcPQdkDpXq6SEzuzePsbAoZMljCSjsJ/UVZk/wRfcg70N+0ioCWUOrtcgjv0Bpt0Rfn9wnklztGiZSBq/paw3F+3wI6Odaxv6AWycBWB9ugtcyWX7AXX0Rnrjzf48604WuoSKN/3g69e+oMO+pjUzglwQtkFTCYaDzsJcTGg5W1EpDJ0kmPUg4ScQDUk3sSsIuVgmPF++ITOh6rdyjt8OaXSLvQnJWGRqEAUfCgBF9Ao1KSJ0ucBr11gmVM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiM8htjPRNlkblCxqEkmih44jMdAX6OR3Ybt93u+LGo=;
 b=Izdj7zC4WFKHuRKyocShszcUwyNQFginA5Jfmlu5VYLc2r/GvLECbsWTWEDVhta+Ob/5CFity2ZiZ5gQzyQWPB02dJupw9tFr5uPD+4F7Clvadg+RR1s7O7TAbJir6zTIy3kHwaRHXljQw8U1unLz4gUsGbFt5LzY76s0mzNHeBR134XQEQa9a3FIB7V+OazChcnvh6RjgdN2q7mEPMeYpF22uYRz7rsNhNJzWZA6ZVtYgXQsBqkznaoiHPBukHnyk8ovIFfh9771Ryov/3ytXZdzEqB0Eh0HuziV30D+56YRIMXwmUTBxhCuoFKdO42Aoh0s/awxgQkPHr/7OL6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiM8htjPRNlkblCxqEkmih44jMdAX6OR3Ybt93u+LGo=;
 b=dDk15IssLfA169WmQrUFOmthiSNnlDfMi7PfUgzt8LcyqYol+XgnV8yhbnQGld9B8EJOpxRDMEzGid9MnD2HBnF/JPRe2EPp/5FAJSzG3vHo//xRm2awQSRfN/bD2LnMIvDays5vNzEGNskfdoeNKMMwt2zXbuADHku63ytn6TQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:38 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:38 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/40] drm/amd/pm: Extend the I2C quirk table
Date: Tue,  8 Jun 2021 17:39:43 -0400
Message-Id: <20210608213954.5517-30-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f70de6a6-c33c-4876-89d4-08d92ac60e41
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44359E96F6C19F969697B7BF99379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MpB/qSW5H7/P3ajsNWNkY++JP5owNprVp37ISPkIro2wHM1TCxX+J+1dMx+zNsZKvWMj2r+K3XXIpDV+ZnY8yNCekyqHkobJgeztetqfrE7EElGqq3LGYRuwQ8DI/raaJAU0BreM9qPBVaIXgHHoHojjAutMnzZlXIxY250r2oO9XZAPJSlIwOxpSvfp8Fa+IQ1A9+fKI8Yu5PFHKJ8Wj4ieyLkk3ous/kSs2zlmJkZnWWTHmF1yImQvdkcNEoqFUL6qkTFtufH5OuOJO7MPY3+V6cftqG3aj1AseXguKRRqoRqQcEEvlvSZYEHfW9x99ONu+rzzr2YTO5x54WPm7Oy5HxRp5XSL9ZM01Eo73cRkoZg8fQXCU9JSMrEXjdGmHx1J5Swa1yKtqs8igV/Hib+Es0yuBrmK1OxQqwXWdFUS9Np6YraaUdwcF7eBvYvN1CIg+rSHnW0F7s+tU2Lk1zdDaxWQ3HrdkHc27rKmLxaV3U738f9+1H/ntW8vXMKdIxPkZW8/9hsxKCfHcJw9QLV90SZQQgAkKaG9H+EKBI2d6wot/WnmTmC8wGZ0G34huYAGJBAG8e/Zf0ckRrqSaEPCd+/kxS25BepoqjdRxIODyZLkOTqNnYeBxG8lTdVbMAWgB+l8xGKb+8sZXn8d6aA18l4f6ktDneq8jx7orkIc6EAONG5kpabmbdGwB7e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWRz2n743n4X7NAGUgYgD4AJR8YY2Gla/yO44vaWMGyD+1XyW4WcZVgSh4QU?=
 =?us-ascii?Q?h18bHm9feEU0dyyQgeZ0Q91wcY1u8WviNV9KabbRHzhmkJ3eyzPEfygAuPQ1?=
 =?us-ascii?Q?GRRNa/r8bB33P7UU7ssbuZUtjuormmBj4wPMek+/zhEoOoa9tpBFaJowKmP6?=
 =?us-ascii?Q?3qJXtSXniBjWSBfsT69VO2LGySCWP5pxHryYAMFv3/Gmwg5FAeU1KazSbS7R?=
 =?us-ascii?Q?DoMjjTVkntDl8zVINXkinmyPhVD4Nh40/XZ2TFCKfAnlzQ6c9jVoesJv7N6a?=
 =?us-ascii?Q?r5Ee6cBHa/49jT3e5RQpnxy0RGrREk5/uEuZg7a+z28Ixg3NhqM9JkPCcfKJ?=
 =?us-ascii?Q?dH4ACabesYXQv4PWER21N3mseA9n9TaQnKuHweEjWv4Bx1ls5GxTT6UfV2xg?=
 =?us-ascii?Q?Pk+EovWnqUggSY3Poq+X99io+1NxvE4N1Xerj69yktAD7XePfErrXY40MXDA?=
 =?us-ascii?Q?lU4dIFk6vET7Uff2L6vWhAUQS9nnofkhx+h0UBeWU9oZxZ4SEeqIbbJhvKuG?=
 =?us-ascii?Q?IQ6JO4ZTa/f+M5UBSyKwD6rOyFkbjS3zZ/+HcmmdJa/M2OactzzxMJUOiNDq?=
 =?us-ascii?Q?+idPi5GUuZeUffZE1G6c0A/wm0cgBnVHDrGJ7KjRvw1Sp54LU842aRMXwv1x?=
 =?us-ascii?Q?nSRQ6yPaV+rTVfp3dc2mxHyiT+YUdHZHvWJaWJWr+iS+6rKGq3UJRpUX2G03?=
 =?us-ascii?Q?d7AxMDxZ9RhSK73Lqb8xQmiaawItuDkNT9knw951UpE9RTxeLE/nWyVUD9aj?=
 =?us-ascii?Q?AKl1vMWQj9VifCQu6hovdMgqh7oerDPqEYf7Prpee/3JrQIOduop9k4p8PA4?=
 =?us-ascii?Q?WfF9ySPMK4uc4yiuPfn7ZUohIQWE2RSl2reNMdP22FOkXdUb/UnCI/Ncn+ca?=
 =?us-ascii?Q?WXVoPGnVs24uwViGaHimbta6GkdifCJZwJq5uelmROKUlIYlYCDOK1PiAZR9?=
 =?us-ascii?Q?7qktgj4P+sbLb9Hx1yVGijtZlqapN+6nJSCBbD5CRMC15nLv19YZBw6/yNV5?=
 =?us-ascii?Q?ChOslrJzMmkTDOv1Kheyq/9bzidWjgbWCyKBfcLkuXW0Zec33stvng4aWQ7x?=
 =?us-ascii?Q?5kh6s4RJB2zL8CquWVaHlWgMfBxl7UWqecSlICaaW1rkSTe67JJPQY6htvXo?=
 =?us-ascii?Q?bxjpkNYDFLWT6GpVJKyutDVhfLT6udmUIVQX+JDKtI84mdxmjGRUax+xINtp?=
 =?us-ascii?Q?rcBpEDMGcgkqQ6bwMxwIUxUTuMSiNMJsgm6k6qN4saNkGD6TWVwB7in9r002?=
 =?us-ascii?Q?Sq72fEqgv8RLWJS2y7krTlJ0wOgaUWYJv9fKVkYkwqtUwl83tm21p2tN6huw?=
 =?us-ascii?Q?1UPxEX8Z96sgopZ+BqUpz3+U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70de6a6-c33c-4876-89d4-08d92ac60e41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:38.2562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy1Fu6mJo/N2uAEyx4Vxt5sxOZm8W+iTU/9UPPSUtekZZUPgEjjWi/H+hCaF4vbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 974740ac72fded..de8d7513042966 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2006,8 +2006,11 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
 
 
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
index 8ab06fa87edb04..1b8cd3746d0ebc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2800,8 +2800,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
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
index 91614ae186f7f5..b38127f8009d3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3488,8 +3488,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
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
