Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820EEC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD2A611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD2A611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF896E10B;
	Mon, 14 Jun 2021 17:47:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42866E118
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCHTfAP/HyCcf0EBhCK4cTM4+W0u3K6As6uG+vxOoB2IOv5J2+mXxJvqNuBHlQlwhhIC2cuvjuXbInurIuZICLWNdSDLwcMVp/H7vhlbL/nTAsqOFL66IEv1+RGG5aFxLe/7ZErx8ukxB8qswzAnqv0RBbnbWJ9TbDc1VleSnBLpDkOsy1+2PmBVIg7aeQi503jRLXAloQP+3fPIUjwaqFwoGG1iQLTbvqinqtVSszW38OQgil7LAI55cojWV+iqzBkaOkmUpo5ZsuPoTtxxDs4Uuz06zAjszo2eg7cXwgvnRdByVDQTOJOAU9lrGIZMxkkiVOoIf33v+m5ApA6/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOmOqVDueP7ek8sQhlfyAStM+XylWH2HF0tLRR1FJT8=;
 b=VDgIj62quw9iy9OTFwdUwSqrPx013hUURAst20HQowwtwEp29QsiPXHu4KI0Aqg9a7jjfMPGhBh7Hh0eA3nYpPnZWjuJQshOrWGyQWFylq8uINK2WxIMy5QLRIF/ZJEUkgWZTmwM0e4J8TIJBuZcL+dPHbR5yAunOKKholNfdwFlx7Jv9UO+BoYcg1i4xk9pyGYOjxqm0oscMZvn1ohGi6NX89oEWBMwV23v4cFFpiUEV3/OkmR8WnrDN6jQd6XPuaGB+c+iYbv2uq3JlqF6nfNKSCWdQwkNowAAmZ1tMqR8ehWDR7cv6tqxXqEFnz8l6dP1ZVcF91mRznmbLf+FzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOmOqVDueP7ek8sQhlfyAStM+XylWH2HF0tLRR1FJT8=;
 b=GkIAWNuBWtUFJ276MNvNqt9HJkXCSonD6Lm/+8F6RXu/NrXgRoWVSOwYdGKad6+mas8tFm5oFFv/7qX/dV5XYWzxuGSogPF0g8ryVsyrHjpQ5r87aB5wpVCxq1lLL2Rmz8hSNV1TPoQxo+fCIextG9biXKLzEWrM4HC5Rteg4hE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:47:02 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:02 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/40] drm/amdgpu/pm: ADD I2C quirk adapter table
Date: Mon, 14 Jun 2021 13:46:09 -0400
Message-Id: <20210614174632.20818-18-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3213e98-7f38-4d59-9bc4-08d92f5c69de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748C3E8D7E2F6882BF6B0AA99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hr+PFxpHzqjbsaEzmilzHl4SGs8/XBW38BEG4u2BEHnrBcIvINixjuychfA3fCYMbM2RpsgYBkq539a64P8T38hIHO4ueGfJ4xxos+svBt7sE1Rqp6AzXTDeurl9QcSbGsAQLZNEiPCSxDy5M+RFLKGPNrZ7umNNyKfLHk9KeVPVDaLhbdV0S4ZP5Knc1Z6nUhep15zOVxhFftK2TM3W6kwCJjofdfZiIAZy7i4UMa5LKsNEWbYH1jrS8UckHfFXjjAWDSmBR9nzSp30o9Io3JqXOJomKVUERSWwTsi3xzM2dUMHGO1fe9zT3rS3/EK2y1xm+kucHEpzoFN83sKV1PmXPLsXls3CxPdNlqkJ4zPt7zrMmoBANGkMzOjlI8/C5saAx7dex4euM0e+hViiwwQNVRkM2JAEsojOZ5iocJtycWwTOh1JfZ773Z3n5JGYJfIUQ9Z/cf/fxlRhZNSCQ4T5o8645fdMcnvEYs7Ye5xKROzeBTNq42VdL7nZEPIb/OjgGl3qSQVh/hAEejFsus5P1hs+qfhC9Ei8hUYjDLxyLVknrBGaY7+HXGF8NY8xCH1pPgBLDnjlpHX1eyooQp6dgOqwF1jBG9yTKGqIzEjKl6GU2ZVYHxgm4UNKas2Ryozk02F5oW1O9sbIToL8A0goLWXHVyRP8PauXo1IF47cJl1JiHjdTU9iZwfv8dBM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(498600001)(6916009)(38350700002)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8rMTU3UhOuazyue8YwVyrH8S0Jt6X09+M4pVlUPOophEzcpoUV5WHrYNAK7l?=
 =?us-ascii?Q?G05fZsB8UxjGmuwrAEDrdKKUpjiyMf9o0KXah0fEXoVNcFCrOLEZm0uid8gf?=
 =?us-ascii?Q?wfaEzV9cA7Guu43r5keDxEv7/gmGi52lReV0rMs+kpOXIYW5dpFGRIypoEsC?=
 =?us-ascii?Q?1iykiU4l17dYgUjO4B9tOJrMuFz+lDNWOjRkB/+E/8TYpXMvxJnWLbkiVDNB?=
 =?us-ascii?Q?MVQQmcDdzgxhrXuAWSak4W1qCn5Tp3DRlr0O4Cp50KC/yoDucaVu+HfGnE04?=
 =?us-ascii?Q?jO1k/BAnwlyg1MNBmMyA8ZHHvWRbZiYKBjJI1TB+Q9/mFY0C68YDXg2rg3ZQ?=
 =?us-ascii?Q?6fBe/LLfRlm+PNlap1Qe9VrUiJPKyGw5PFzY/FoPHi6XnyMK423TBYlrWie+?=
 =?us-ascii?Q?u7lKVEj+zkY6I1Gl3uwtp8Lmy85fyUcJonmDO/hVCM27Thy0riDOjzIr7r6U?=
 =?us-ascii?Q?yK8aLK6JGzfX7ExfltDjzMYeFNpXpRdxtY6thMtxJyIeFBy0KosaWe+Idbcp?=
 =?us-ascii?Q?Lb74ak8dw6FdMbCV9NjY4XdKLjVVcohveoZ1HEoJSPfWR2rEs/qKFcw/Zlkv?=
 =?us-ascii?Q?KZWiXlI0NznnneqZAC3hFTY2tCnj3rz/U3Y9fYsgp/bU/y9S1QmpARrQig+I?=
 =?us-ascii?Q?OK/8i3sSm1wnjcc8/IzVgASxa2RuckzT2Y6sjkOamF66fdvt94tGcxP0s87Q?=
 =?us-ascii?Q?Woh6UklVnlTG992Tul9Qz1O89fiiLFF8DMhYn+5NhNI8bZWHQJZG0MFLUQs2?=
 =?us-ascii?Q?SnE8TQl0kAQ3xSDne18buYLo/XI/XRkwiOCk6ZyCRoQVm1twtIAdy/KeYRub?=
 =?us-ascii?Q?0Lh84eo1kA2UpuEs/3kYllN5AfvFMACoAnEp2KstD48a+Y6R5hg++83gQjCs?=
 =?us-ascii?Q?UFtwdSQxsVRvihc2jvytlUFkm7R+yDXrHqHh8KIObSwznSAxViq6USdF+k7y?=
 =?us-ascii?Q?qLvAg3VNNLnkWGmWku4ob7VqyL1V1YoaquFqySMHnbYWs1teLvFZEjAuraok?=
 =?us-ascii?Q?umYjsWKSm4YooJt93Vh0U/CxNii3ZIG/m0EfdFagmTxQfkBAGWrorbiufPsb?=
 =?us-ascii?Q?ExQySSOik0kIoOzi2oSb6kMKbBlzuLXWEDkXjt76e7ASIe/NCc65lLyGUfIq?=
 =?us-ascii?Q?5Yha2MsaqRvVvCsgPgERQ3lx/Mw6j1RKy4RDedFubfEvaCzwDrMmHlEroBgm?=
 =?us-ascii?Q?8JfqMYuJP4u6nPR+bxNv/kdzfpAhSrJJNM0I0Vy/5eDo7tHDqB+8Bgz6v2rE?=
 =?us-ascii?Q?S92oLNCzucbyC5hudAm0DYV0iwhG4iRC+Td7sYNsnsZAsOtBfT0GBtGU+N1M?=
 =?us-ascii?Q?dTol6PsVkX2Ijc+P8cNgJXq4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3213e98-7f38-4d59-9bc4-08d92f5c69de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:01.0688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QePvdn3ql9myhBR1QC1THwkX8EeO9CdVKg/LNX3ownlvp8vOGWff5AYBEiHVa9Ce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index c916ccc48bf67f..33210119a28ec1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2034,6 +2034,12 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
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
@@ -2043,6 +2049,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_algo;
+	control->quirks = &arcturus_i2c_control_quirks;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
 
 	res = i2c_add_adapter(control);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d734f51b1cfaa4..22b31055461eb3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2833,6 +2833,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
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
@@ -2843,6 +2848,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &navi10_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	control->quirks = &navi10_i2c_control_quirks;
 
 	res = i2c_add_adapter(control);
 	if (res)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 8f8e5c7df44a12..9a14103cf9729f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3540,6 +3540,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
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
@@ -3550,6 +3555,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
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
