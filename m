Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8624EC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550916054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550916054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FB86E249;
	Mon, 21 Jun 2021 17:13:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32AFC6E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzhCOIbyU96T10kOh3qSHyF5hmmTOEKMJfmvI1cpWNGpJs8iYcUjJn0/Mpdp4UxcpC9tKJOjm58gH7rx6BsVhaItE3y6JkUL9yFOBV81a3Uai4j+HXP1kRKh41I74xrj2jA+3tnPl4DvaGnUljWtjUNo9gLWsp8jA04fFCFXmdpqjmDSYPKT6znRUqFKJk+epncoK5EjxGVQsVfpiVoNC1TsdDDDq66zVte4y5YryqdNoYXIfcLdhjpCIlBYHRvABVqn+LBUkZkX5stslgcNo6aXK/9i2dGRJW2o5sAwVccImiACu2dvrMgtXme5NdgHmzHUjoWZW1fhxbT916httA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6AzTUSeL0geVeI/eXTYBVsV+f6Cafrk0q3jzVEBwWs=;
 b=ANT91NJizWIYxeckgiT0uFe2hqvzLjwPh0dbdnRHxeYp8vIWqIh6NHGNpEh3QalqQPAVxTUC9VU4d9H2q9cMed4VVIKAfqjgYE+GgoIu1feBqolMaL9F0S4vYhCNq6AXfMXTTJWoDlnA6gF0yF93E9ixhPAOMAe37m5zsPeH7kyhlz7GkRvivCQWcsX/ooMe7CrOGLRQtaJ/ZAp3QkCnPjt2IwMGaJBhoEMkwdcAdrHJ7Mo9pnbNOoa7ayTsyPISwf9dZIDi9f4rzUnymqj+3Ouzo6gOs7Ci/JcI+QVmMSE3mOLyQ/hNUvSOTKENjsC2Xg27bLEGKt3DduNZNJYMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6AzTUSeL0geVeI/eXTYBVsV+f6Cafrk0q3jzVEBwWs=;
 b=LWkOCfq7jlFGYqqAU8J+1R+5S/Kp7PpdezVIz3SwQmZ88h2sFUP/hRnT1lIQ3tLG9uAn34BfL9OdicvmHdj7x37B0kAkPhADJRLTLzQgRcpv9NL2sT7IcRSsAqFUqlYWAu/XrmAQX9QDteXMAy4qFabcmHERGIdzV2au7Tm2zk8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 17:13:32 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:13:32 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/43] drm/amdgpu: Use explicit cardinality for clarity
Date: Mon, 21 Jun 2021 13:12:13 -0400
Message-Id: <20210621171221.5720-36-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:13:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4191ccf-f01d-49d5-2a0e-08d934d7d458
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29854CE124CA05027082384B990A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOSduU4E7ztrPHd9s3E0fRqu9LfEWX5wMoJ+WNiNP3rM6jvUYC1yCEeOzwUQdcDUXpHpc/8AuU7NfvjFwgcF0OmfH7tIOlBlhvm3wCJ4O8Hd/47E3q1YxQ9BrCLrEKsaEYqddwQRhy77Hne+6Eb/B2DNAvBeAoSRAXC1kAKbi0CA23D5JtctbJSJSfpgWiB7TFq6Gflz8XLdqDL0udgZ6Fx07negm8m5YRQBVYOMOnNvlNYPKT5H9iUENvqm/4t4/F996h6Kvp9k2efkvuCpMb5OWNaHRv6UEgo6iNu8YxvOzgpi2gwnMJHSfBH6kPAqpJe21wh6WVsDbl913yNhibMD2Eri3xRdXP4VCiCyiKIQbjmNxa3iiSS8Ssd726ckvIQEcEBU6UnVNvb6hMXhxywdguNP7XGQCp0P0JWSTXv8Qnyv5VnKiBylJpjJIr7itjfd0ezbgoVOSyE7EGLhtecWt4cwOhdINWpjCG+t4UuKzMbxRs3cAdmnpE6PeHvaxZhX/U/Ny39IAkmDOelV0vhalUR/pI/2oSjSLrb2kNAUynxgQFuLo/jr5CCIK730xQZvt5MIxMYxWz8gg3ZmlCMbHyJ8A/U9gu0DutGgkkbBj0XdH8iAciwLo26HPZGDghk2oOhkTyFQb0GwWJ3Z8qbG9W2BqYDPj82SMIAtV9/F1gvTiD3T4E82cnLWKTu9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(6666004)(55236004)(8676002)(316002)(6506007)(6486002)(54906003)(44832011)(8936002)(478600001)(66476007)(66946007)(956004)(2616005)(6512007)(66556008)(2906002)(52116002)(36756003)(38100700002)(38350700002)(86362001)(5660300002)(186003)(4326008)(1076003)(83380400001)(26005)(16526019)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3TNJAnTdlFiohrhxG8JyfWPSgIAX68Gg524kAcOShTt4fNQuAJBO1aSQmHId?=
 =?us-ascii?Q?CmWZfLTgkCvaFF5sTXSODDbX0p5EKFlocujY3c14gqmB0ZEEyITygn0jqXnD?=
 =?us-ascii?Q?M4gX3GD2iEu3CNOA4oqy4fZgUSmfXzWLSATJ8bIVoTwWwEQfsZN6cq3ic9xL?=
 =?us-ascii?Q?PrFR/4j+Q317K88kI2XFh+IMARpUYEAMZcPZISvMM1X1vkN7/DnR+694sRaJ?=
 =?us-ascii?Q?12a0DU1601tTmamh9TV9SLf6I724zTrD+6O8nqMDH1R8pdOP0Vj/N2mK+2uW?=
 =?us-ascii?Q?IAW/6+9NIU5djbyF5mMwFAMgwznNFIIYMt4TFDCWF6JaCiotukWoxuYfPxOB?=
 =?us-ascii?Q?sMeRS02SBpU///V5ponLDAvWKJomPY8Y1y9eUtc5tM+VsVEWTWVMnReFUvUq?=
 =?us-ascii?Q?2BSMq5yXVtaGvW1Ku6pQ8ki0iXnZSJDDGQAgb/u2Gdwm2ESshQZQi0do0cy+?=
 =?us-ascii?Q?P20jTbcQTnqq/BkSJq74VLOuKZhCnAX2qnssetyOMufMc977it/469i+PCRq?=
 =?us-ascii?Q?DyxdRORRiCaEqNUM0zb8cL3U+owZOf5Z11xKsMZo2erHXJPzQEaI5YDmlHnU?=
 =?us-ascii?Q?eE8hYbMwgxZr2QovVhzQKzHAIziqH+lFfWVVNUPHLzcmqOdeDXcKbXlV61wD?=
 =?us-ascii?Q?bMtqwTZqh4S8fYzv3wtEUutV+GGZWWjFBaAmg27zHwUDgfy6tmlC8+TY046/?=
 =?us-ascii?Q?SOj2bkTYPK2KSb0TikUKdpMK9xjbk0J+TbT0yFfqu4P1Ezb+8x39kuS6FSVd?=
 =?us-ascii?Q?hhdmxefxccwO+x+0LeR/BO79DNjfgvP0PLEhxb9epWH8GOTPVMQ8JKM705iM?=
 =?us-ascii?Q?onEeDAvTwR1rNngErMRC8dMuBfifZDvNLByrXsbs62xo9cXF3xSZ1qcuiM1P?=
 =?us-ascii?Q?oiquPR/m4iMg3lGQl+Xw1nFxU5ciZc3s+VvyEeXgkEwHgex/YJRN7lHnUyCa?=
 =?us-ascii?Q?OnGNJDEEIwmQE9AC9/eqp4iEwkw1JVkWv3bueqjkBsYnii7ez5vnyutr35HB?=
 =?us-ascii?Q?5L5z5RjRFaYyaw0VnwcLYdMZyhmwnBShXg9rmzXnkJ7t2jc0dPmnBt3arTa2?=
 =?us-ascii?Q?f31JF1VmEJwixWBKhjrI573x6VFlWoadnZmBqw4VYwiLcA9i3Qt2NT8sVv0C?=
 =?us-ascii?Q?QM8g7MIzgx3ha4GXUpRKtf5J1MT99WvSMHUT7CvfISV/9XSZ9OWjHuxjLzS3?=
 =?us-ascii?Q?8ZyCynMsboJcnPr4bQ4cJLBMw0rFw26XZ9naTXHfIEDkadzq9N6Yy1YPCHHL?=
 =?us-ascii?Q?w6y9cyQcDE5WQMllahvZlZejH24KMfZNQPZC0Erera1FxLneqEIV+tFV5WEK?=
 =?us-ascii?Q?T7vHv5xVYSLmobKqyABc9il7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4191ccf-f01d-49d5-2a0e-08d934d7d458
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:13:03.6345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSXOKKIQ8Nl7tC0ncB/7uO6waMJSWnOw71hE/E1tar7mfzSAhVJhjEIF4saOet+z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS_MAX_RECORD_NUM may mean the maximum record
number, as in the maximum house number on your
street, or it may mean the maximum number of
records, as in the count of records, which is also
a number. To make this distinction whether the
number is ordinal (index) or cardinal (count),
rename this macro to RAS_MAX_RECORD_COUNT.

This makes it easy to understand what it refers
to, especially when we compute quantities such as,
how many records do we have left in the table,
especially when there are so many other numbers,
quantities and numerical macros around.

Also rename the long,
amdgpu_ras_eeprom_get_record_max_length() to the
more succinct and clear,
amdgpu_ras_eeprom_max_record_count().

When computing the threshold, which also deals
with counts, i.e. "how many", use cardinal
"max_eeprom_records_count", than the quantitative
"max_eeprom_records_len".

Simplify the logic here and there, as well.

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  9 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 50 ++++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  8 +--
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +-
 4 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80dab0c6e19ebb..406043c9906425 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -868,11 +868,10 @@ MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legac
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
 /**
- * DOC: bad_page_threshold (int)
- * Bad page threshold is to specify the threshold value of faulty pages
- * detected by RAS ECC, that may result in GPU entering bad status if total
- * faulty pages by ECC exceed threshold value and leave it for user's further
- * check.
+ * DOC: bad_page_threshold (int) Bad page threshold is specifies the
+ * threshold value of faulty pages detected by RAS ECC, which may
+ * result in the GPU entering bad status when the number of total
+ * faulty pages by ECC exceeds the threshold value.
  */
 MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 64054a825b7421..c7ad90483f21d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -71,8 +71,8 @@ const char *ras_block_string[] = {
 /* inject address is 52 bits */
 #define	RAS_UMC_INJECT_ADDR_LIMIT	(0x1ULL << 52)
 
-/* typical ECC bad page rate(1 bad page per 100MB VRAM) */
-#define RAS_BAD_PAGE_RATE		(100 * 1024 * 1024ULL)
+/* typical ECC bad page rate is 1 bad page per 100MB VRAM */
+#define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
@@ -1841,27 +1841,24 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_eeprom_control *control =
-					&adev->psp.ras.ras->eeprom_control;
-	struct eeprom_table_record *bps = NULL;
-	int ret = 0;
+		&adev->psp.ras.ras->eeprom_control;
+	struct eeprom_table_record *bps;
+	int ret;
 
 	/* no bad page record, skip eeprom access */
-	if (!control->num_recs || (amdgpu_bad_page_threshold == 0))
-		return ret;
+	if (control->num_recs == 0 || amdgpu_bad_page_threshold == 0)
+		return 0;
 
 	bps = kcalloc(control->num_recs, sizeof(*bps), GFP_KERNEL);
 	if (!bps)
 		return -ENOMEM;
 
-	if (amdgpu_ras_eeprom_read(control, bps, control->num_recs)) {
+	ret = amdgpu_ras_eeprom_read(control, bps, control->num_recs);
+	if (ret)
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
-		ret = -EIO;
-		goto out;
-	}
-
-	ret = amdgpu_ras_add_bad_pages(adev, bps, control->num_recs);
+	else
+		ret = amdgpu_ras_add_bad_pages(adev, bps, control->num_recs);
 
-out:
 	kfree(bps);
 	return ret;
 }
@@ -1901,11 +1898,9 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 }
 
 static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
-					uint32_t max_length)
+					  uint32_t max_count)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	int tmp_threshold = amdgpu_bad_page_threshold;
-	u64 val;
 
 	/*
 	 * Justification of value bad_page_cnt_threshold in ras structure
@@ -1926,18 +1921,15 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	 *      take no effect.
 	 */
 
-	if (tmp_threshold < -1)
-		tmp_threshold = -1;
-	else if (tmp_threshold > max_length)
-		tmp_threshold = max_length;
+	if (amdgpu_bad_page_threshold < 0) {
+		u64 val = adev->gmc.mc_vram_size;
 
-	if (tmp_threshold == -1) {
-		val = adev->gmc.mc_vram_size;
-		do_div(val, RAS_BAD_PAGE_RATE);
+		do_div(val, RAS_BAD_PAGE_COVER);
 		con->bad_page_cnt_threshold = min(lower_32_bits(val),
-						max_length);
+						  max_count);
 	} else {
-		con->bad_page_cnt_threshold = tmp_threshold;
+		con->bad_page_cnt_threshold = min_t(int, max_count,
+						    amdgpu_bad_page_threshold);
 	}
 }
 
@@ -1945,7 +1937,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
-	uint32_t max_eeprom_records_len = 0;
+	u32  max_eeprom_records_count = 0;
 	bool exc_err_limit = false;
 	int ret;
 
@@ -1965,8 +1957,8 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	atomic_set(&con->in_recovery, 0);
 	con->adev = adev;
 
-	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
-	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
+	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count();
+	amdgpu_ras_validate_threshold(adev, max_eeprom_records_count);
 
 	/* Todo: During test the SMU might fail to read the eeprom through I2C
 	 * when the GPU is pending on XGMI reset during probe time
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 54ef31594accd9..21e1e59e4857ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -54,7 +54,7 @@
 #define RAS_TBL_SIZE_BYTES      (256 * 1024)
 #define RAS_HDR_START           0
 #define RAS_RECORD_START        (RAS_HDR_START + RAS_TABLE_HEADER_SIZE)
-#define RAS_MAX_RECORD_NUM      ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
+#define RAS_MAX_RECORD_COUNT    ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
 				 / RAS_TABLE_RECORD_SIZE)
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
@@ -532,7 +532,7 @@ static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 		 * TODO - Check the assumption is correct
 		 */
 		control->num_recs += num;
-		control->num_recs %= RAS_MAX_RECORD_NUM;
+		control->num_recs %= RAS_MAX_RECORD_COUNT;
 		control->tbl_hdr.tbl_size += RAS_TABLE_RECORD_SIZE * num;
 		if (control->tbl_hdr.tbl_size > RAS_TBL_SIZE_BYTES)
 			control->tbl_hdr.tbl_size = RAS_TABLE_HEADER_SIZE +
@@ -568,9 +568,9 @@ int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
 	return amdgpu_ras_eeprom_xfer(control, records, num, true);
 }
 
-inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void)
+inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
 {
-	return RAS_MAX_RECORD_NUM;
+	return RAS_MAX_RECORD_COUNT;
 }
 
 /* Used for testing if bugs encountered */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 4906ed9fb8cdd3..504729b8053759 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -88,7 +88,7 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
 			    struct eeprom_table_record *records, const u32 num);
 
-inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void);
+inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
 
 void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control);
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
