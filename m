Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94060C48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6641C6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6641C6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CFE6E28A;
	Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26F96E250
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfic8fX6Bg+rA1wtKW/u7Uro41FM279DSIo9zDdLkWkeqlM5n9TVXhtKKs9AkiNEDN3k7ykJALYG+tZpedBs5VCygk2VBxdKE7idwrr3aUOrGnzb2qb+ryNgroWafqKAxLCnHLoJwYu2ULp1rUGaW4qxCVQHmEbHdfEN2XB9U4sG/qmK0nPc8e03uH1mGGX+wf68WK7PFimyNwke+6uUPQtrl1nVV42zylFao7IJSIuNjl5iwoDCeMEEwEfeGBudZPqadqY3E6G89vxQoyRM/OizgTfWiqaYuyIT8kzqE9PzrwgCT4Gr7D33pK61WvwCtbfyzSrC54PpBvyWDZhjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kS0szflsMcehqfznYOYiU9hk9W86CeaKiRTM3jbUro=;
 b=AubYMzwMNmWGdZCi9ehmpaKvZdbX0Pt2qp0nIdUyN8iRd/tU0rUlDM0Ux179zzyP/YceuJ4Ee6BsVMu6Ea45FRqM42Nzejks1ip8nKOnCf/R3MCJ23Rxk0C2H2tVntFftKbOA1B5geEgbv0MAnu3Bp27VPmXATfSf7n5GqxZ6SIcsEPJDwHQzr6Z8sM1HlQBhaWiNemFp9omhj6Fs83u4sh5Em5yorodX62fCLf3V3ZDCN8ea9Rz7cmm9h5RndgejThA6NHR66YRb7nG3jI1NgAv06fH6ULIx5OWkxtddQUy1Uxr4vQl02iPcpTOgxLNvfNIBte9oBbswrfkOGnh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kS0szflsMcehqfznYOYiU9hk9W86CeaKiRTM3jbUro=;
 b=1YpwQXfMdo+ds7ViOEkgY/wz9t/f1a9zFGOcRqq827v+LN261khQ3183cWvJEecWQXr/vZkbIFCAb44KDa6HwF6KFsUw8aKJv1vatLzVpeWR4EC88wxTfTeETwUJcd4BfsmYysqar9Y+tXIlLuc6qJ5aM3ghIpVt0Wj/SiCY5/g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 17:12:56 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:56 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/43] drm/amdgpu: Rename misspelled function
Date: Mon, 21 Jun 2021 13:12:04 -0400
Message-Id: <20210621171221.5720-27-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ab5795-2afa-4e94-ec28-08d934d7cfbf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB125892A5A07A43219FBF378B990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxzb5o6ceDIt8E3eDr9Pp4U4/7zWfjjhO00fSrl2b5md7oU/mgAauBSYyqCCKKlWBKV4J36sZe+qoVKk3lMEuLfIgCZD6npdQ97xy7hQ1vPREFxtQNDznNFeFcAIdtUOTCfEo/96bW6yFj7sVOzhM9B3VHb8ovptTvowaAzAHai4hfov1+kWhgH88H/s/Mqa/Tr+93BD6zIchZj/qI/vKC9/h4lcsqRbIdfwTUF2n8CI8J9dtOj7Gvq6E31Vf+WA98r1+mojckEAn1knpqnlrr90uzSs48y+uWbN0LQTqxU7j/btvhcH06xEGOt2N711AWheL3srHRx7f4kWb+2zsuusFTv0QOhdZdtBWQW2nCZ8z9OKVvaxgWT67Tg1c8s+2JMkEXEclOJVA58WEK5ljRlqJ3ulrkAnzOovfIaBgT6f7tURmMYUdnuAKZvzGXQmj2NmTLE36DoU/nM8g5++8xvgqncbpsn+1iuDiQLm8jYZfxSlbNecvdGQGxdH4t2xjrf0Vn/CtAVrow9nMiHgymZK1+ASJOZB85Um2EAZyaVvikbU8MvGNC5xVbawSFMb7v04M6QuFO8VGTzkeDdPdQXEKVV8hoT1MXDCB81GbTpWsvXsOle5DnMc8hD8fEseYH4eNz9c4EpsptBgV32RW9Ps/rQthtwddmf+J6BCQrK33eIpW3dt0qqJZad0QmSP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(6666004)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tRbJ3DZH9WokVlTxJSG+Zmibm/QqTba7iGYBv2/rZwaJchH+py7sSq0LGec+?=
 =?us-ascii?Q?v0lOud8se9PYbHh9JaDNqGEkTxKQngfo3EFvt86LWuhxjwMcJP/WMzIs2Zyj?=
 =?us-ascii?Q?AkaPHqwU8HfpxTzI3qN/C1RjV0Tzu89s+Pte69qKLVPdz+/to4OrAJun6SI8?=
 =?us-ascii?Q?bWkndc80VmbtQKBopa3ibsV0nL0XxpUh+b+jYb9tap3B2w+jIevDReojeXmR?=
 =?us-ascii?Q?hJ/1ZAIa5s0wG4IQ1MXqmFbOwQOGDG/mxyN/p9UXrKtHpu1kaMne8ACG3ogS?=
 =?us-ascii?Q?aIyT34d4T2R5hVSXElSCjEcMN0a+k6qQPthWN7LEDwy71OzheDl7GlMfCD7d?=
 =?us-ascii?Q?k9mKalzB1tntM4235XfGqM2ZqhHd0PQyMf8m4xax1jsQCg/CWHGSgcl+Abcv?=
 =?us-ascii?Q?L5SgZrQhyPF9Ia5rZWeonWlHFgsxyTQX1OJWUIT8M01IDlnNoEp/wnXJIZtf?=
 =?us-ascii?Q?o5u07KxyLuFvob92puyGpdPYqiilTDlaw1JP/PHh7HqtPZJrNgmY8lvE9vEb?=
 =?us-ascii?Q?Wj2geumP/1tCDeyeSpqJ7slifMdLegOXkRO39fg0/gYf7bi/F6p9Oyx3RKhf?=
 =?us-ascii?Q?uy+/6MwHjEJNV4jepEAz2Ukc9L/jgW8k46+N4s1FkYPnClsKRlGfJLWThaHA?=
 =?us-ascii?Q?HyD8RfWQFTP9XH+1+QNuaS91kA9Y9/o+vXoJ8TGZ8WkZkTzFfgYzajaVvjk1?=
 =?us-ascii?Q?iniy00if4PjdR1T3BkbuuWXIVGh/b5aRaRa/TLnN8zdenifpM8rHtSoJyJM1?=
 =?us-ascii?Q?poNzAwSIavQ8JABeELiUUiifFG3BMsFkB34mZh2OeO8iadOm21l3kUIMsRhK?=
 =?us-ascii?Q?5uUtR+9WdUlH8a2k5MEGmQ8gUmDCjuSOJMTEHQnl74sffM5iAt89NciZ90Rd?=
 =?us-ascii?Q?NWXIauk5RUAlElrSYy54MN5xzRj35wwx7IHliW7tAaVCeaIXv9s4bCMKMEsB?=
 =?us-ascii?Q?HlXpuq3f32QCrd33wsuyga6E3XGW7Ebaa0QA+Pl7V9YZBDhVRH/QkTAXiGT9?=
 =?us-ascii?Q?78Uf63r9uuYKGh/HBVMt+MjwB9eUOr84ykAwEpcTyAF+T2U4Mm0EcSvZt2s4?=
 =?us-ascii?Q?TbaaQ1bhQmEolIMqb0p5MjiZZTiiwnCncVt4nF6tY8vwDBG7OvdQfNW9kcXk?=
 =?us-ascii?Q?Tpao/nMO1ook1xd2LEdZwvXMpjFITQFRSkiQMEuLF0On3tFGszeU5LV1C+Zk?=
 =?us-ascii?Q?1FbflG05d6bzxKajhGXGy2fGV8ozwmVlYqI3a1etlfNm3Osl2wU+EcL+A8Dz?=
 =?us-ascii?Q?YWsADFORXUz4+vmXXtYuZMuu/3rWCjdV0n2Yaq2pxZVQa1ruPdFTJgNfqlKw?=
 =?us-ascii?Q?gJMZ3av5816k0FGQ1RPvgM5A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ab5795-2afa-4e94-ec28-08d934d7cfbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:55.9509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0ab84jOn6eviEVVk3sHQwj7xjo/waWRhX6LD/RnVAwydPADeEx7BWFbg3/M0o8J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
index 44a4363cace737..96a2f42d57bb2c 100644
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
