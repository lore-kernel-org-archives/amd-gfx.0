Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42128C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16967610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16967610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3C86EC48;
	Tue,  8 Jun 2021 21:40:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22116EC42
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvAXLnu8VyipMMAR6Q/1L9EkNOdzGo2jZ5wzSJVRgRiuk1212uYv1zE9unvBu59t5jYEyeFkc7OXq492Qx0CJs3MvtWMBpE+OQW9m235Vw74cYipZSR8pTlUnlcu3dLYOzMKMCDPeXJgE8BpHOEg7sSCC3BE0acNkLYj+qR4kr/VkZlXHSsBp2g+b0tHE/maMN3sui52MAjq29GVLzk+uG0Ebp8m9qrSu3oB9cy5gLGuMRumuUh2pOFt8BOASW7N+HdTbqKUivU2kuNKD9Hck83hFj2wWz0TjhdMfPdi11zoUbohNxtH2J/spJicdtEpgTA3RjPoEeyMqeFXmwc/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbRPA2VuZ81oofoQi5m9O4Fiqdsm45fhogk2iOksRIo=;
 b=LIDleKIK8p8SIvVmYVKQVZLSQDG7IVjLT+YMpYU7as1GbmgBLknkXc+74v2YEZ0ExSdyZeJxSWmeGmE5Ei9ejZIz8f2GL2Xald/pQB1TxoyQ0m99xLmBwg/eGL3DhxES1bTNAukxGP2GnH+ztfJo+xvltfK5Gg1XAtIrE38yxEdqsPD1T+Plo7EjHUDPVBfE+xo/1kSIz4QTopOS47A2jEU5xCcke3iBM8PIm/wH4Srk7MWli8qUbgc6WaSb4hGplUmLErisq/1jVJpoOZdIjiaAD1El/lgk1FXqz4jnskqbETf5l5BVWixHsWv0vv5CwXmu0MIaEUr+9LcAa58sWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbRPA2VuZ81oofoQi5m9O4Fiqdsm45fhogk2iOksRIo=;
 b=5QddpHIKUcJ7yjSvXMonbfnXmbcXVabwa0ZkW291PDjbjLZZu6HGeOXXt4epWyuBBzguDGOpQbYK5ReGwuA7kYZFd5z44z3w8tA9eg1ul9NuLv68LP8TO3A3OcdQ0N3wsWbYjSurI8AkuQMd8LXT9pXmeMNlGxhq5GeSGqnSK84=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:26 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:26 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/40] drm/amdgpu/pm: ADD I2C quirk adapter table
Date: Tue,  8 Jun 2021 17:39:31 -0400
Message-Id: <20210608213954.5517-18-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb37d0f-dc6c-4618-b304-08d92ac60732
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44351E9EDB11F8EDB2A2560499379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTuLNlw38waE6sNM51hI0KRvfQhTo6TTGNgRqj+sQUgMOuzT76wN7lEXkNSfcGWicd0I5KmER65zINd0KelQDSs1XtQEE7tpjhe0wl8xP0ZkXo6oJT5y1wTyCTjAoGcjiiMEqCqico3spn37rFi5d049jsQc0bThJ4Z+G1+dlnY0miW10b1jniaxs1unwvjab/AQcjIKRKFCtCPck3k2ZSCxIScJv2MgIbpqLy91GOcy098m5WQwNSS/zPwb4tWEadWvqr5CJKpmx2D2exr6aoZPohAvhax2K2u6f68W/VoLbb4VA1nI3Bq6ihUOmtbR2qwCvWiSWiKlcbez+FFXH6MzDufsiAKkxrM1ObzAhli9dS0AXDBwsNAVIHw2gxAz3FTpGWcx0kEgVKfmBGKyESY90+vysljzz9u6E3DDUZ2gTYrv9PXpT0FKwMaNMgbSnT8Eblw9QCNsQmfUovfF3+u8TVd8WFW7Nav/zx1kyxSJbUEL+QJHZ8qQRRwGAA9q3yMzuZRopPCjcpi0ca1OEYZX/6IxPxIROh8oPiWQ1rPD34eCaFoaCV5/Tz/4oiAh9irvjhRO73gOZ0i4GDTTfCPvduHVx8uGOO2nUNcUqIJNgWup8D6pI/l/SAmL5p/T91fnlOwhdJDqpFbTbvgfwAN5KQwNDtlyZ3jyPLhHqd2M1u47zJyYIWLetwtOKIZL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39850400004)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3nB/ZQmKgpO09MuhuXoxMaRNn+twhhruvzToYv+vIZzJNm9ykKHJ+46OmyE?=
 =?us-ascii?Q?rta9z+os3ZiGeI6H1QeS4fRrcgg/Gh+v3Fw/3hF74Bu8UqfMZPwhsG9dLroY?=
 =?us-ascii?Q?DqFM3P+YxPUAzOVpb9uBEhNm9dqwA+jFLPD++8HGCpqrjmz4JxIRnl3rapND?=
 =?us-ascii?Q?zy7ZItIQ5MLqqtqv1Tk8dsc0X0wzfZ5SEoYkg1ZpgmsDcRhNyyRHGV8Ebu8k?=
 =?us-ascii?Q?Fxj9ZoXe+Iwm1QJzWpco/OD5nVObKo9ToJNUVxO1NG7cE/YEoL6lh6kcdFNm?=
 =?us-ascii?Q?9FFS6oMdQoTyiv8ISBNsIYj47wvitGmuxqXzjjmZa4R1alc0JrsxHVappTRL?=
 =?us-ascii?Q?M1J4hGaO3Z1rJccr7fsN8FMVNmKOoh8RMNEg0wYc3QQLjf9vd+/I4rRQ0CxF?=
 =?us-ascii?Q?nD3z7xrKSEV01t/jd7XUoxiPSXb5OLSP4xluQ8GMg1++g443eviIW/Jjp8/R?=
 =?us-ascii?Q?qd1wxS3skrhoWSKTGGIyXVvgWi1h9T1oT9AWcwOjRIPM1WGLtqrvWOYbm/0W?=
 =?us-ascii?Q?fQF6AEjfFJjsvUmT5yEKqoeIR8ZO16notGPXaPJWj6l9W7uBpQRQJgGUSO0l?=
 =?us-ascii?Q?gjV1QKNpD6JFrCe9dw1Hi7y5/XCd/7+F9XXaBtDm6Afi92Gh7iDugQi8B7//?=
 =?us-ascii?Q?BFKF95IIcTGXVKdD9FJlYUScRyMIQH72X+zTX58TNVrUuVhTqhCyTI1nMkxZ?=
 =?us-ascii?Q?2djaqzCnKP4oqojbm6sleFp+LxyjarqWMel9GEJ6audVfnfkoqsNuU/tv1ZC?=
 =?us-ascii?Q?qEaYZ6lyRYOeDVs3Q7zcWeG3S7qMDQ3RC92VXIePSYTM0o6/Gx3tg+Mn5q1a?=
 =?us-ascii?Q?OdUABzv8eHjqI20/eHD1yAJUkLAIAkRXJcqEIBY59CgeF96za5IRcoiVjbFY?=
 =?us-ascii?Q?p0MYY7ez5HvLn9JghyS3f8QVoZyt+3zjCzNY2vnbsDbRz8JXoS4GyuPRlRMH?=
 =?us-ascii?Q?aS0ZUmRsrFQphBMAmA85IZPQMUMNWXKN5g4f3xe0l7G1iwWyiCRfcKVpTNoE?=
 =?us-ascii?Q?41Vp3SToGDN121/W4XQcNPDjTfQngD3pNvXrdSbyhuTgfHNU6MJXHc6CQXU7?=
 =?us-ascii?Q?l+989y/+dUy7sQ8Eb38w1KZLKk2uVGs4O2i2fOwmqHMVaK1UDFz/R37jTRRS?=
 =?us-ascii?Q?2ze7VYUYUbYfeN4wv71eB3px41e1pQ1PDf9FfpuBz+KTwnB+yGrr0dT8kYER?=
 =?us-ascii?Q?Ve9Xfbidb/UccHDYUMU6zx4b36v2NtZs/veb8AsG/QKk4YcqSuNISdRGJ3wu?=
 =?us-ascii?Q?zzgB5Cpa34nMBnRjqy5HFgGyFSwREwX/tmidnD/b7ukwmRvI1dmgrUADqAQ2?=
 =?us-ascii?Q?d/ypZ5E44ZhObHo5zv7Qb1n9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb37d0f-dc6c-4618-b304-08d92ac60732
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:26.4119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlAPyps0Sat09IBNlvMzy7EtAGs/mFYznD5R1XaeuGfAkj7WnMuDlan5U5lCRUWA
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

To be used by kernel clients of the adapter.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 409299a608e1b3..c2d6d7c8129593 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2004,6 +2004,12 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
 	.functionality = arcturus_i2c_func,
 };
 
+
+static const struct i2c_adapter_quirks arcturus_i2c_control_quirks = {
+	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+};
+
 static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -2013,6 +2019,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_algo;
+	control->quirks = &arcturus_i2c_control_quirks;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
 
 	res = i2c_add_adapter(control);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 4010b891f25678..56000463f64e45 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2799,6 +2799,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
 	.functionality = navi10_i2c_func,
 };
 
+static const struct i2c_adapter_quirks navi10_i2c_control_quirks = {
+	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+};
+
 static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -2809,6 +2814,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &navi10_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	control->quirks = &navi10_i2c_control_quirks;
 
 	res = i2c_add_adapter(control);
 	if (res)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d5b750d84112fa..86804f3b0a951b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3487,6 +3487,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
 	.functionality = sienna_cichlid_i2c_func,
 };
 
+static const struct i2c_adapter_quirks sienna_cichlid_i2c_control_quirks = {
+	.max_read_len = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+};
+
 static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -3497,6 +3502,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &sienna_cichlid_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	control->quirks = &sienna_cichlid_i2c_control_quirks;
 
 	res = i2c_add_adapter(control);
 	if (res)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
