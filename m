Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E92C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B61060FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B61060FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A236E14B;
	Mon, 14 Jun 2021 17:47:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BE16E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJwLUiLl7DYxTjVFijcHXqsopHfitLJQJFLKwOtdirYNSSSERfSXQndJdLMnDQXqnEpBvz6K8Fwi+Or5Gw9G6c8T8Beglzp+eL8LDExh/ey+14CJtONLiTLPJFj1YCYVKmMMv9SpRh0d33THEgi9nDq1qVedj7Acpr8llHtru2Ar16LNHEqkahXomaefG27fdWlPa5hGUDTehgGE7VVlWg96RVdVT+tAUyU+pQAQEYrQDnFXf0my3Xte7UPnC9DRWiMprkXcOCXcgzCOJ1yiAt5XtrsrENEv7JqRIDxLowo+OTnMZ9JuiMdmS9ZYlm2DO8Ssa1kM/L23ZVmcwIUXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5u+ep41FyHCQ/odP03iXtshK3sv40KZUshjSDC6B6w=;
 b=I873v2ELjbWxGLtfnXSuXFUEo4kWKlWd5zPNAd1EAEG4SeXQ+DawqZmozgXeqK1VjGLTqAqL4liYy8XYeg7w4FIpsChtN9LlqR4o9/EheQ5wVwxUIwGhl3oZ9GFOB2s3Xlm0y5UZxshdEkr7FbZ0PC6kCLAS+D09Cu1KwB9FfYWqM6Y4Gx6at2xZWx1kZU6JP8RMbZ2Ck8zecjg67TXdy+LPOSSw0pT25aTheZbrzdsKhO5lufx+6KaK+d0HXIkXilF/7aeg1+kd/3mGwsYmEYHJnrevuyVe42gEH1y1FzBQUayoYDCvZSnMz4J4uCqlq6eS7E/W2zCk9ZPfrd9cuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5u+ep41FyHCQ/odP03iXtshK3sv40KZUshjSDC6B6w=;
 b=SN1eZYt+btT7aek+/ohSAZsoXvhV8Lp8nONPIAxyjVkj2Xm8cJuzuHqmUHXIN+R85MJB9vGsCb5rAdeO/DxsYAE2u1+JhvPwk1cIvttq4ufQoF1REyOZFmwMbjGtfqRi+pZdwmD3C4M9dfOcCdmmTUv37aXPNce3+yLIcfxP4oU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Mon, 14 Jun
 2021 17:47:47 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:47 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/40] drm/amdgpu: Use explicit cardinality for clarity
Date: Mon, 14 Jun 2021 13:46:27 -0400
Message-Id: <20210614174632.20818-36-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b1fd305-6e32-4d23-f5be-08d92f5c737d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355BE8B54D7152F490B12D499319@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7ZG17gKa++DqDixOI/ZKPVvSPFeqAPOZ/yIcGPQGzzqVhdDfQXZ3nyM2uyzC4n4NJAIGHfEAhLe5A+dotImECieylRal1ksRr/poHuH/KtT9N4O4SW1XtxHMgjwdVOnhQd+2jaSfbYlZirLi45/XyWAQsBoVcQFyD7b07TgpjvY4XYDSAgTZXMo7CfVYdI1f4HGpA4GW8C0JKRFnzz8NWKoYoA1IxoKvoxzQpZUduFGPOFUb3yTG0UiPlKYQbgwSBZidqxqip/XjpZe5QLhiKsEAk62bfBhnn9XMa9VFTElsdofILp0T+IQNMpiruRbvgnkpk6S2Qx1fCEUms2Uu6jA0qf48/ra1y+azOnQcZu+1bslVlhJO4t4sYnMVhxKevPZB02M3xDa7ieJEv7i8GMphGMvmiEJGJL/dgsCc0k0aD8CtVcpAbLN/4xg269KsHS0JwfPBiYI8B6uE/HKtU5cNXelH+V2CunYdATYfqDsmdZcgs+d2ThByl8wDOV7BpWCu11n4LKpxBSN3eZMG+g18INDO/Ve3FEQyMnty7VbOHqv+bUPTRREzMaAK9tVSKBFi+AJrHhS7MRx3Zj1cSmqapKnal8XydxrdN7VZEsCSgADWaotI5FI4owImyj/Qs05I4gEHve9HCw3V7VLJuxcHceiaDRLpOoYwB+8k/9vI1f81/QL4PPokWL5lFV7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(36756003)(83380400001)(86362001)(38350700002)(16526019)(38100700002)(478600001)(8936002)(5660300002)(4326008)(956004)(6512007)(66556008)(66476007)(66946007)(8676002)(316002)(44832011)(54906003)(2616005)(6506007)(2906002)(55236004)(6916009)(6486002)(186003)(1076003)(52116002)(26005)(6666004)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBIhd+Kh0qsQKsd9S8fqtYQqOPvX0oXkxCRx2aWhOEAghU0a8fEKZxxUnacQ?=
 =?us-ascii?Q?iDhrrdgXP9JLRnwTk14wuNBWoQX7CTSfo4TBznnNixYNMGAJbVXkAhACwEs8?=
 =?us-ascii?Q?K1hl2+jrJiPgG1jzSW0HchiAdizLnmlDd1ojCEqxlmNrCSVTmpRtUXhvOPi0?=
 =?us-ascii?Q?wVKxV8lROs9ZbKJQ0fhk/ds9UZJwVpIWZW7iZCc6HZP+7eNqRJ9ouFmyLylZ?=
 =?us-ascii?Q?YVxbGsEUGusewtP+CVk9xfRAnm3ACLOt4NGZ00HIJPFUVl2V1poO63zzwk62?=
 =?us-ascii?Q?bjeIksdB9KszMeELN1PKb2ZrTi7lO3l2K9bHd+5Dw0paTdvipNx6dgnv+bDo?=
 =?us-ascii?Q?wmNAeN7i5EXyqjLxFKRQfirZsav/mewBgAGuaSd9Yxss52BI93qMMa7AABbs?=
 =?us-ascii?Q?2O8m6a5ahoxhOJRHhNxyeLoqD+qiBk/YSNCQ+gOwaPVRmTrEn3n9m+M/Dw4g?=
 =?us-ascii?Q?UPGyWfowWE7UR72ua2LFo1nxAcqk7TzpA9wOttB6WXvvs4iljhHxoUPlJgkQ?=
 =?us-ascii?Q?UkRdjP2CeMArNKfl33Wt6Je8X1SmqaFoQpRCRwutoo1qMXLB1Z4MNC/OJF/J?=
 =?us-ascii?Q?IPZiqdcgXr12S5zQZ5htML1WIa/CMly3j3FYQaYZTsDaOKCterxYhRdkYY/5?=
 =?us-ascii?Q?C4+m2wLs/dakCaDtlWhszgShXLul03Qy82ZkoRokFywBNkbSwXnWIuGJvae2?=
 =?us-ascii?Q?APM8bOQPvjS9kDE2oWLPyCdgzSDH3Um/Ux5qR2WECUUjnPrc4Wdz+W8jkXR4?=
 =?us-ascii?Q?fpaiBwc5e6FQaduvnPugUckC6qNi3kvt9gE7jpNmi3KCPVyBia/CIOAD/am/?=
 =?us-ascii?Q?Mf7Opa19vq3Qb/kV3gfcyra7D+Ia+o5Bt9WjNmTXD6j1Q1sfgcNWtv2W2TUj?=
 =?us-ascii?Q?zJFOnBjiuyTQNhILlISQd1sR2kQPoEoxHneSIll6WnE6QWLbOtu6kFDFS865?=
 =?us-ascii?Q?Tjcsu27KfD8nlPCzEbrSWIrSp1VQmj8+YK43o1iT7ntETq5RUSNnHjiHTBbt?=
 =?us-ascii?Q?x5Ed1m52g+4WQNlSxaWNxMyk+bKW0TECccLBBf+EHfab/2o3IK4vBIk0/z/g?=
 =?us-ascii?Q?pyZnhgwsjAUZ+WhSkagSWxwOiyPgbUho7kxmnXlyOjfFgJmuM0fRLuTKNqhg?=
 =?us-ascii?Q?zw7fOiGCmdYjynN+EY04LDANuZamRp2InIJeBw2j+Ezy0tOQc9+XafmtJ0dt?=
 =?us-ascii?Q?/VUl+XGM4SFDlMbWRlHAtJ7hXpeYIH47aQsc5wErvPWS88pzaoStu6ncN5qK?=
 =?us-ascii?Q?GMHw72f18hKkQouxY2hpnqoNGB1oDzRv2B6UpNElyk6ZWXfAE4p594XDutNK?=
 =?us-ascii?Q?LcK7MICqd6n2fBYqUpaKPfEK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1fd305-6e32-4d23-f5be-08d92f5c737d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:17.1896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/dXNkiKYgpq1uNKrKdpTf2ZS9kATqlQ03A2pujkGSbcgOirfvsYEINKOuQ08Ds6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
index 18dee704ccf4dd..ecdf2d80eee8f0 100644
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
