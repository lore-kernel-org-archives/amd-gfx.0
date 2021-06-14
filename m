Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF27C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D305D611EE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D305D611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C456E103;
	Mon, 14 Jun 2021 17:47:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DD16E12C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZy0/ZSwqtKrmcCJDh51C1nyTmvdaAMGdAcDyFPmflmMQFETKTkG8SRL+33yXldL3zEH89QUNX4XZ5pXWdd0BxKX5wgNfd0UCCjrtlOCJcetFvY2AB/IuXHHYGG5eQAJ87dbY9jtQI2TxSU3xWkKXq2Z0WUNbvvqyi3kS1hUYFCDvGlc1qNGDph1TW9kBAs4YUMpZA64/z1OS9ByX5z2862S7UFe2U0GEBEkJF4TWozMnJGIik4PUga3KAqxVFP7nXGwnYqIyEOQmsn7ee0GyoaNhIDX7M9avPkAfX6AmuOutxhDA1PZbmfmpEi6NVS5g/yclWP2CoVPh4mDZKOdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMufHR7mZoF0+fIwKX8GAtvs2SLd2uQXzeHTWEKhtpA=;
 b=dztuwl5OR0NvdNYwJ26RBp+8DS6p56zc7O1xE0mWOKpvg0ZiR2B0cWRNIumiJARn/B/APyxYjBIqAHxw/3Ax1UQcJrQ74hYSyyQoh567k5hIHJsMZrQM8Sq6bMD6htc4WNsyBZqNFz4N6/VgoJl3dHYUs3GyAbeAsDSD7KlD4RTXYdNUTyLx2N3DHuXSJkK0lPLrFpEW6cr+GUuP4j3zwJVFjxE/LUFTHyI27oAbiuYkRRc5Ca2NA/PVC8OMok7kYF0LBtj4RhErhcK0GWFPxXM0DOxqLn9/6KTpTInPcjZnN5Wzne4TEK4bKt8HsnrKq82CePfnCzZh3Gs525LBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMufHR7mZoF0+fIwKX8GAtvs2SLd2uQXzeHTWEKhtpA=;
 b=0O3hYOaaQmzbwwtONQvbCfS7exQCh2Sk4zm7yBZlndkY2HEPjZPBySep+2XlpY+m5VY52bHCwZCtV4bXT+53dUG20WNLdXbq7ZR8k4ox/DJ6jDqaSW8lG133c/hA3s6Q/l7cUAnuTjRFIiAEdV6FXykKsKvMtLQjatK66mc5Suk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:10 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:10 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/40] drm/amdgpu: Rename misspelled function
Date: Mon, 14 Jun 2021 13:46:18 -0400
Message-Id: <20210614174632.20818-27-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a24a059-0aac-4d65-7b1b-08d92f5c6ee6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3690F9530B3E986187CB0FFA99319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOzfSeWBY02kjAyUGLlLwzTeIYtAQrEFbz+XsNNfOXSVf1XKYiGRlJ5TfyqdUQUqn/SddvL3WDA2LWICKaSc0P0+Hmy+QizcxO9Qp5ggYCewk531nyFe/6yDYpz2MC8wbn7AO+2UQKHjilwMkvkLIqDVP8oUucoi2Sh6OkzgTTAgmISjw1Fi81G9FeA3mu5008vGS3Nj6ulbKlK3GlCo5IkOJs5WApwkxqtiaiNYuBepHF7+nnHTnTzWdQ/cSsClXjyqcQ6LQNpedGk63WonjI24LuohyaBMnerLW+uNcyOzTirgW/34gXZE6P/aiXtX0iIo+hddMphRckz4TvV03p8xQ7PlEUO/XvpWZOBnNbgItREDFxI4wHZNxx+cZ+UhAA6Ed+E+n1OhVn5M8KjbdjvX6Al50la6DmZg6+7eFIUxXq+5m+Fod9GGhG9kuzj5Glj911NlTtI6yAAfHsGoT8B/f1xZcusm8U2rZhO0K9jlhvZv/DSMpxKrN5dfefmzilZ+Oi5lNwoUz23Pof6elPdqF1nXoLDGyKAcVaqHp1tW1VZ76tcuom1mesgHB2ibAbgu1xJ/Cx68gsI6e74n2pLllFVyVOQPWJG4+887mJLkcsaXtUz7WevQlZceWKtPp9DplgEqLrBdS8hkKatDIXh7/6uhKfzOqJPprfiuLI4a7WIAgmwqXm3bHZdwdZNy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(54906003)(6916009)(66556008)(6666004)(498600001)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eaO3GR9F+hejeIJ3EJ2zriCxaehBLS8p1EJBiLuf2wt0MTvI6dtD8Uf7hl9a?=
 =?us-ascii?Q?76BaFwXzvOt3OL9/BL6tFm3yhnqaa39Xp3KulXaKmrf6xqyjnf3G8RVrRsHL?=
 =?us-ascii?Q?8uZdkRvpiuO8maEWzyZ8s+PSuDJ2xtFTpCYA1EM3UKo06fcnkR5NSMQQ+HUf?=
 =?us-ascii?Q?MaV2ulXqQj4Q6zkyLa4NedNW3bAoTAOBg/TbLIpCjpCaXX6Sh4t2v3yOF16B?=
 =?us-ascii?Q?0WT6LbW2HlTuowksjKl/NFpFL0Zq8TVREaJAvsFkLICBtTv5tnVnhhc8SZSJ?=
 =?us-ascii?Q?0lC0E3oq2B2RG630G8DYrkkY6TDVruKwZcNs3IhtrBCTEE91OSt0pmS27x/N?=
 =?us-ascii?Q?PIcPBadPbtvLROon4eN8czFMHRYrwVutkl/jyKxMrM/TDoEXyGrPmn07Yyvb?=
 =?us-ascii?Q?t0iS/+fbKnaXBSNNVaKjlwkX45rUIE7PeckVtI+xppCbSD99DzlNemRaXXf4?=
 =?us-ascii?Q?ba150Jeibfk8hu/k8fn1kCu8d17ooG0qRBdksH8HG09YXiO7MuW8wdTlyo9f?=
 =?us-ascii?Q?zct3P0fRfwFqpnMT7/mR/MXYLD2xh85l4RcpIX0yAt8HxZ1bwq1j9EJJ/BYt?=
 =?us-ascii?Q?spfGDkBHcJxyposkjPp/7BLVAQ57xOjXdkg7NLarWjOrnnktDONv5LCdP8+8?=
 =?us-ascii?Q?7+RSAPe5e3W152yj70Ed7k2O5JqqcFRAQvKHgx6LNohCZtJY2bQ7L6rApLfg?=
 =?us-ascii?Q?uSXWN+AlAXGadjAfImAuJN2lfq8LjvNJcwMbssmsYsp/3pYyQpNelGO+IFxl?=
 =?us-ascii?Q?U5W/HzcFuzGmgS4IfcyoowETRvhYTNz8k0ap1iJ0LeoI2Z90Hs90aTIcxkRn?=
 =?us-ascii?Q?vNN+gx0bkVjZy1PfzUvXJHxQP83YeuczBhvQWR3YN6nDOqKX86v/4UlTkhVd?=
 =?us-ascii?Q?mfKbkpINfdpzs5A83g5CTPb0GH6Rm7EG3Ngo6Db++zHumb4HGYYyrpiePfOC?=
 =?us-ascii?Q?xhICy6H5uUxWfWkTahimlGZ+FV48O4jHhVUl3HVd/+QBK4DnvSOvcbhS+UGt?=
 =?us-ascii?Q?TB3IpooIjF8ZaK0R18fUikrTE1SVItz7E68G7VQ1vKPSAV/dsM0d7szsLMI/?=
 =?us-ascii?Q?K5EJHhTirC7YNrehzzJn3baFE24eJ+SJWLcLJj0Z84L874RatkIrzQqf9+tG?=
 =?us-ascii?Q?Fcz2Dt4ADcyS4uoSxMmAliKb2xweZfveN4vkcDgYzHDzQi0bIOEiaasNuxDG?=
 =?us-ascii?Q?IcF/GojKsIgQAprXhPOuIwAigdSuu96hqcZApcqF3Fge6jvB0upjHl/1PLuA?=
 =?us-ascii?Q?yJGt8/SQaePgXR1s4ezYt2sG06LG7ls7ih8rYC70xmIyRBr91lLZPpv+Zs92?=
 =?us-ascii?Q?mmAWxzWxXo93Cif86GZOlwTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a24a059-0aac-4d65-7b1b-08d92f5c6ee6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:09.4790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYCN7WumhJ2MM+8psSMs4ljQxw1j+ktE2iDm9pVrQ3KGLI9SALjaHRfNRI7nKrHW
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

Instead of fixing the spelling in
  amdgpu_ras_eeprom_process_recods(),
rename it to,
  amdgpu_ras_eeprom_xfer(),
to look similar to other I2C and protocol
transfer (read/write) functions.

Also to keep the column span to within reason by
using a shorter name.

Change the "num" function parameter from "int" to
"const u32" since it is the number of items
(records) to xfer, i.e. their count, which cannot
be a negative number.

Also swap the order of parameters, keeping the
pointer to records and their number next to each
other, while the direction now becomes the last
parameter.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  7 +++----
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index beb174f79fa0bd..edd4d83e1e392f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1817,10 +1817,10 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 	save_count = data->count - control->num_recs;
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (amdgpu_ras_eeprom_process_recods(control,
-							&data->bps[control->num_recs],
-							true,
-							save_count)) {
+		if (amdgpu_ras_eeprom_xfer(control,
+					   &data->bps[control->num_recs],
+					   save_count,
+					   true)) {
 			dev_err(adev->dev, "Failed to save EEPROM table data!");
 			return -EIO;
 		}
@@ -1850,8 +1850,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	if (!bps)
 		return -ENOMEM;
 
-	if (amdgpu_ras_eeprom_process_recods(control, bps, false,
-		control->num_recs)) {
+	if (amdgpu_ras_eeprom_xfer(control, bps, control->num_recs, false)) {
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 		ret = -EIO;
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index d3678706bb736d..9e3fbc44b4bc4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -432,9 +432,9 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 	return false;
 }
 
-int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-				     struct eeprom_table_record *records,
-				     bool write, int num)
+int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
+			   struct eeprom_table_record *records,
+			   const u32 num, bool write)
 {
 	int i, ret = 0;
 	unsigned char *buffs, *buff;
@@ -574,13 +574,13 @@ void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control)
 		recs[i].retired_page = i;
 	}
 
-	if (!amdgpu_ras_eeprom_process_recods(control, recs, true, 1)) {
+	if (!amdgpu_ras_eeprom_xfer(control, recs, 1, true)) {
 
 		memset(recs, 0, sizeof(*recs) * 1);
 
 		control->next_addr = RAS_RECORD_START;
 
-		if (!amdgpu_ras_eeprom_process_recods(control, recs, false, 1)) {
+		if (!amdgpu_ras_eeprom_xfer(control, recs, 1, false)) {
 			for (i = 0; i < 1; i++)
 				DRM_INFO("rec.address :0x%llx, rec.retired_page :%llu",
 					 recs[i].address, recs[i].retired_page);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 4c4c3d840a35c5..6a1bd527bce57a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -82,10 +82,9 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev);
 
-int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-					    struct eeprom_table_record *records,
-					    bool write,
-					    int num);
+int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
+			   struct eeprom_table_record *records,
+			   const u32 num, bool write);
 
 inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void);
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
