Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F06FC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC16C610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC16C610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08E96EC5A;
	Tue,  8 Jun 2021 21:41:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055976EC5C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmPs7zrfpvXapZimdTj2VmECi5IDE2yfn6QPcIJ8MohOvNH4eSfrvPacxZF0yDkVDrd9VwATqA3d/Y3jGwdVCD+SUO+0UsbB4e1vIDbgKMFG6jma1w0gvWxbg0vYMF5jubh0Rp0N0Fipb1kJMZm5UaxQ83Iyuj9zj/rO7r+sg6ICS9k8tdIuhYQoMy77X7gd5mTIu2A5YHBqG9WG8zplXjBvcG9qScCmm8er5mBAoev4+bxD4+DrNU70OL3aC1YQx5Fm4IXw+ROlkGpGjJKSnK3FRC3TpVRfBZvkHzUppAksSWgr418U3AcilIuuTB8IhNvWo/KI899ie8Zn26KHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3V0XKwX2pe4JLvhl6vzuSFBn7RIGjOYpeBKQGiZ6gE=;
 b=NreumDUu6+sm8A9OUv0OHBpPvWd21amrUuDbAWF5SSyK8pbUDHx9fcR9frTpWMSLawllBbXNgrFoAHiiXo85wT9aeVnuydEQ+0mTn69tNQBfZM1DzX3B9aFsor0ac7niuT5Til+f/EQ0PidYX/cFp5IVDaHk4kYWdAvRaq0+sQU/0G8afEs7IWFIwqIEE+9/gIXvSwVOkhN+tj5eXPHTQaberYcyftcOK1QHaB1uHAl+aPTePilpOk8smUsZ/EWP6Ms+evnYm1vecsljly1dXX42xAtVW5rAE+/zGaeFe7ap3bjSZzz25vZRX3RgIexqvMT4yPPTqGvhYimQcbE+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3V0XKwX2pe4JLvhl6vzuSFBn7RIGjOYpeBKQGiZ6gE=;
 b=ueNxMaI1yRyfa/tLE7+25KtwLFileeFkAj1WSisgCvohsJ6dfqIqK1+rh4Mxzc6PU/8RLQfjh8c5ec31QCYv/F6n9rBgWNu57E6Pv8uynTAxKU6+vruCZ6YyZXinMzKDrdbFvWJlXuIA63HwAk4TEdvoxUWDadAlai78w+nwJgU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Tue, 8 Jun
 2021 21:41:13 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:11 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/40] drm/amdgpu: Use explicit cardinality for clarity
Date: Tue,  8 Jun 2021 17:39:50 -0400
Message-Id: <20210608213954.5517-37-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e896599-a96e-4296-ecce-08d92ac61186
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4678A1DF7C92CE13EA3ADC7199379@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qLlkFey5S4smxhSTS2QHS/t/TmeuVJGtstqacqF7cPGgnHyN9ofzxrkT5C82o/+ZBL+gA44tVVKTOiZ9cEMLetgjqUI7hHDXvqNepHFTqtAdwIjJO+i7b0l9KlTzr/hEIrg68yRxhOIiGppU0L8za/DAjkTcHI+B8Dj5UmpTk0GKRXgIXn/e6yVX7eHQ2+vbhanFwwLDZj1yX3TRqZjmICjZkFHHTMuY4wUZu836IhaGvqm6VFvNcQUXDrvlm4DSBXoWp7lcxdBeZjb+xOyeYoA21Y9HnzpsWH+HRXcK5C40XTLP+cOcExhv9HSWgtfgal2zz59fQorE3PbqIyQifzLYvtOyc4DPD5/J6zcEL3lB7WRIieXTNHTWS9RrtvKnCRTLImuSyHdi/dG7lsRrRvFR8S2U9yQ8p470P4NnmWFhEUWAIP4zKm7hnxYl9kVOubhuo6h08+MG51xsXx4FYvJGqCPeRBnkcWdYEp/41Q06jAmX3mO+hA+SVFHKd7AGZIz1Yjaiarf2RzZX4rkXT2mgwohAljj/0/SAwl+ei0qAxUX3ikzaM7u1No/4jX/N1UsuFhZWsgqNB/s+dm9uZqR3iAbjKRCD5ITCpGgSlKWdZ85+8BG7VGVOL23+hMe67uaYrmI64vsHrTOiFQfCkvUf51phIN6+GuJUHWyoZCSv/MgkvNbYXPfoy0UED51
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(26005)(6916009)(55236004)(6666004)(16526019)(8676002)(316002)(66556008)(6486002)(52116002)(66946007)(66476007)(86362001)(83380400001)(1076003)(38100700002)(8936002)(2616005)(478600001)(956004)(36756003)(54906003)(4326008)(186003)(5660300002)(44832011)(6506007)(6512007)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRmADqEVVvdqoU5s8jqjNo6Yj/Vt3cYH4vU6Mjs3g4J+jI2S+fsjvNj+UkoK?=
 =?us-ascii?Q?PXbFNQIGdXt8xWN9b4v8RpB9TMpwpeeOTzlNS32ud3fcM73n7Mswiq9ml/HM?=
 =?us-ascii?Q?cuUZaInZ9JGHEbrKlSPinv9LoZFPM/6RUxjsU0r0NztBjjk+G3eBAMmUNqQ+?=
 =?us-ascii?Q?PS83QU2K82J6UVXBNUcS2bTTGizE8nY/tf3dDzVWVURKiEy2N/xo4xRRTUur?=
 =?us-ascii?Q?eJvfJspNKFm7gjiNXN5cEDiobllMjcqqA1Ab3hWRwkC0EXzUjydvvTmubkVg?=
 =?us-ascii?Q?fZRaEqCrEk6ClJvaAH58ofTWLneIEJp4Mn45DUGyj/1DiXinoUEJfoes7Wr/?=
 =?us-ascii?Q?aP/RJ+NiK58XBXjEIogNmzTIhJpYrbsA9P4t/NFR8vjA67A6e+54TqRk07Eg?=
 =?us-ascii?Q?mcLRdJoqsgGzbsHHSDLSOFmOd+N5pOiLPf4HddD35xe1rXS/rPOl9xtYUHxn?=
 =?us-ascii?Q?/FQYVB7ucjwoJgkwvRarKEtZF+HOvCoeRZdPbarER52OU4fh4/EOGle7ne/4?=
 =?us-ascii?Q?56UXtz7nTPqpRglcGMjdKgK01S0ya5DzObl5ag9Zc39A+bAhOFyIgwfOwp2p?=
 =?us-ascii?Q?dlQR2q675spTGlwgYzqqvJLCt6qfEWcISv8X2yI/H4NUMQZNF2ItfyxFaFAg?=
 =?us-ascii?Q?I00xD4jfMom+QFVGw9sAUITDRjWJN3R0xot8LA/PT8LajXNeDVKytjfrUwyL?=
 =?us-ascii?Q?vyKZR/baskuno9AnEDgalPZs+qtNRil7C+CfpWEqWMctWRfhyvsKb6EZYXIn?=
 =?us-ascii?Q?oj6K2rC0NAnfmJBTs7QmXeE+beAl9ui93QofgMlyBqNn9WvbwQaxHwJpPCJh?=
 =?us-ascii?Q?CLNsFLjcSpVqB1QDr3NZ7a0b5lV4OnSLcAGESnketbBSpjtTCB5m2ke8Q5Zg?=
 =?us-ascii?Q?ioXeXmG6ATp/FPV9Ycdpbvlj2hMUVKnbRTrTjaNFrjONXVoiQQWCwet4ne/3?=
 =?us-ascii?Q?E8gMvrpbaju7hnnLsQ/ot3w6UjBrQtHmsh20eBXNZ8ea8A8yHXRdaPhUBmsV?=
 =?us-ascii?Q?NDVyg35iB+iIBnTR1EzXZ6O/4WUnXU2Ph39bMR4tgqUz3EHSO0JS5+/kHHTY?=
 =?us-ascii?Q?hqtm128hcgRMKggDUF5NaAvkyukxLuF4MiBzHtjDsSkcaXpTDUN4xPXTV5zI?=
 =?us-ascii?Q?LD0YUH8pjmO6nqCwJVCNk6lTSa2HmTz+c7IYCiLROtWvpbFttusfR+yQnP5i?=
 =?us-ascii?Q?vzXvcfIjUfJcJ0PKWKyd7Uy8w7XSp2mQAggnkl96kNODt9/Jp6eKZkO8ywxR?=
 =?us-ascii?Q?kqNWJ5KpvLr22hS7Rq0TP/aaNUvSPDffi4Ga0zV7Measz5fXPebmUm4LyEj3?=
 =?us-ascii?Q?/Kx9ljyqfELWpL9n7Y/OyAre?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e896599-a96e-4296-ecce-08d92ac61186
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:43.6981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txSM5xFklqvmoTHRQy8jquLePjQkDIN27MfSYIcnf3Zh3p6fgXeHVOoQ6kFoC6CZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  9 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 50 ++++++++-----------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  8 +--
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +-
 4 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3de1accb060e37..0203f654576bcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -853,11 +853,10 @@ MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legac
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
index 66c96c65e7eeb9..95ab400b641af0 100644
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
