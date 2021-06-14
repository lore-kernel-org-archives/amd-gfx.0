Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9623AC47094
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FBB60FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FBB60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCF86E138;
	Mon, 14 Jun 2021 17:47:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED7E6E12B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGM0hHljCpkBnqFDNOEkKYmkMKc1ANyxPCHdUgloTYVzS5oO6r0APqI5k7l07w/L7cuI8GmwS0wH22AZu9XaMLuxdH2z7uWEBERf5uS6uBr+hCbpld6Wud5S5RAxx69Mj3I5yUntJqc3HV1gUauPldhKLGHQ+Qa/rtAbGla3yNSzzGr9Bmk6megAPvqTPysJ3ldTJx4vOCI36DhL8SRSYcgtPTWFxNfBE86l91Efhc7oq0ilbRp6SZyH29ex0MQH69c8GP+JG6XsfPkCPwa7Uv/f5BzwA3QYFFt8PJFLimp8N/Qm2hr/o3CA7LGt+/3VaFo0lwwdt3uJZfbxLMOX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIqrpDa61nEoc2Vr7YHNtGEJz14KNprOfxlaNDV/xcc=;
 b=Vbpp+r9GOO+yNbqNqW/lJu51PMJ0uuFdObx1Su59NA/ypgTMd1rN3QIhBEWq5Ca/eudl5qxEM5H0N+b0lh5lUHbr853MSX07QmBV7aO4vulmiZuM0gYM0DzMv6Kx6WSkDVUl7abSJuB2aTa4UWfGyr7PPGZIadW8clJXVlo1I+KXBFYvzWadiIYqEA+zUK3tkSLdMdR5zB0cUudN/cCGQj46S20pRNkLuf9gCWlk+BSDLKwGw8T7nAOWtSrm56Kp8p0jF/4C1i8bw0O4ulSwpMSJ8sdv6BHzObTEBzIcjrF8Y2TErMBHDfMKzOul0OuhgUaqFA2VlwoMXyY5DhT0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIqrpDa61nEoc2Vr7YHNtGEJz14KNprOfxlaNDV/xcc=;
 b=N/IeXIhnmBPM1IVovoK60WMi0j6KAyAPS419jGNTXsc7Mkp0XvLtvO46FsYWrkc/7x2t4EGrhKk6nUQrykvgOEGnAaLzpmlzYucM0PUhsxxElaBMFOkN3ouRwE5BnMS9VnmgXQ80X5SKLxl6TCq0Cq88TL94YA98tfoEQ7VZNqY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:11 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:11 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/40] drm/amdgpu: RAS xfer to read/write
Date: Mon, 14 Jun 2021 13:46:19 -0400
Message-Id: <20210614174632.20818-28-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9feb0bdd-92c1-44e1-7f31-08d92f5c6f67
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB369081C305EB854E2F6CC9ED99319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzUO3pcsRhfU583XBGBIco9uqYQIEMgxMC0mfPWssyeSNE5Me855lOKAMm2O9koDEhGi2K8GUiI93/GN/KBdTt+8NHSdclE1aNC0t4iHI3lm2x9cIC1iFSs3B3deI3LzyoZuDf9wYlq75YoANvYtGNSppPq6N8DqG+wzu2SLQWNnQLeIPprLTkrZHwGat2/WKGK0mBtHtskBSBVHs7AfwVNQc+yaLg/kTLeHKJiMCCvXb90HD2QifhDN0hfT2QpkZhPMHVQViEpBRvf0cxZSTADxOZWie1MU2oikc1CVyZHdXw0dN82ij8UsIHnhPQi9NlM/NimhgG2682cNBU4cFU2BKnLgqHiKfDvz3/8fMiQM21LnGhJpc4EtgcZjbrFBbHGKa4HI2za1deg8ZEm3MX2n6S12UafdrgYwnAEBsnpsVevlCITUG00SYMmwoVvdm7EUMC5X8dSG47MyseA2Gu9858mLqJ9F6ZQV8TaF9Zs0eYIR/c98tNexk2NuPDGLB3FqGJlAn92Kyh8zyKTfwm4tCy7iqzLl0GMgtPuAFh7ISblgEH02v2WRXxwAlVty0MXeluLzyoXnY8JIpn2Q5GijxIujvFa9D4gCghG94cXpC9/PiYLQxka0w4A1ReaID9dGl1NBhvIw9R8Q0DgZpmWR1JHHrPeDnssHPCjvPekkpmwbGoiA0WHMluG/tqY7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(66476007)(54906003)(6916009)(66556008)(6666004)(316002)(478600001)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cLUBez1rQ5KZbzMFMTxWO4xJNfCM6OTNIuXIxndpqVswSoPzCRJGh9Bgy6Mk?=
 =?us-ascii?Q?OEhkdbShnrK/qOqv5o8tJPDOsD3XKH1L/EfzbVi5YSJ6nAkAZkmqKBX0u7T5?=
 =?us-ascii?Q?FabqUvzvRBo6DNogfePPcw8wSEqIhgzPScqAI7WBs99sJF3duOX0uo1Ty9Id?=
 =?us-ascii?Q?lNE/SP1a0Ew4Xrs0MsXyynFkcSL2fmiVsP3XRE+D6741bAGLnhMFOd/QWfbw?=
 =?us-ascii?Q?sx2csenbdSrkTgWWhMav61PJKU20k/Scj96ZfybseuxZke2VCm/DXf2Iq0aY?=
 =?us-ascii?Q?2PRdaX2EI+UgPw6cqye70huBfZPaJBoeDgxzYMyR5Uc6vrovVdd0udwqrDNz?=
 =?us-ascii?Q?LXzX9G7N8oTOYb7miuYxE5hnl8BussOAXZmcRUETbLq0TFtRRvKINCqSBU82?=
 =?us-ascii?Q?uCL8xScvQYPgvbxkDF4vKhCanPfoFNFnUhywKZAEJISNGvfvloPiM474aZtE?=
 =?us-ascii?Q?T+kq5lVudV5dzCLQNkhGlWf+vf78PdVa8yWWedMQazBuw/WzVPgCXJAoE/Kx?=
 =?us-ascii?Q?VwOYMfWqBBJy+C+pZf6sA/8xLyjolBj7GhcvKqA3Einmydi1RmRURKk7PISU?=
 =?us-ascii?Q?FqXh+UWSiXrp1p3XJtoPleFWacOUdfzHZ17QVmvaoO7+wsPZW2Aypa+j6lLm?=
 =?us-ascii?Q?AzeMms4RXvhuV+dS2xdZAm6KUmkH65zsnCalKrNbmgLzaqwY6RBsUZ7mLRaJ?=
 =?us-ascii?Q?frI6dCrI63WuDPBWsp5Yyx9U0pWebljPJSoZrnDMSAWEsEwn7p80Styb/Rh/?=
 =?us-ascii?Q?ZNo4CGSS7Xa6YqdFWBwU9i3WD5rqFMirO7qxZ8vBx1SA26H8SMnaH0n2RXTC?=
 =?us-ascii?Q?gO7B8wEzUYCGfoizg/Tqv5D0AsAJ6ckOs5jy9qB8Z/1az7gfjQU/GWwxLYJL?=
 =?us-ascii?Q?mXO1giraGZvP0MgiQPK+dbchzoF6Tkn3ACaA+zK90XhL8+OFhi7PQTB1Kx0s?=
 =?us-ascii?Q?1RAT5H2W05l/qFHz0CDkqVzsfH+VKuYQXyb2xYso2IuSt8BqhM5+9X2Meu4N?=
 =?us-ascii?Q?VGrpuBGftgQWFWIfmsOMKXLBKDcCDPYdNClaHCazzaWFHChVd6asWgzhES10?=
 =?us-ascii?Q?Ypj13W3xFOriYrNFFog8lgofRECO5mI33DaHs9OVDQyvr6IJWg8SfGyePTOP?=
 =?us-ascii?Q?vsJEwy4lAjBUZO3+kXGUN8dQfN6k4gACgPs084ZT4+fI1tJMvxB7OwbB8Ikl?=
 =?us-ascii?Q?fKwwo0JDsKcblDQXpLCRFCHWuX8FvmobajFoPNCQmACytoC7/I6bn/idsoVK?=
 =?us-ascii?Q?8ewTBfKS7x07Y7l4L7161VujLlliWPmHse6X15gHRqLmABqohECLSY/+kWSA?=
 =?us-ascii?Q?vykdOQbK8heiPvMoa6pv02lQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9feb0bdd-92c1-44e1-7f31-08d92f5c6f67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:10.3735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enEN6TsMdpiDRjE2FQQuDxti78sR7LbguRAaLm3/OsSMFvIqM3tSGSzL5sr8itr+
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

Wrap amdgpu_ras_eeprom_xfer(..., bool write),
into amdgpu_ras_eeprom_read() and
amdgpu_ras_eeprom_write(), as that makes reading
and understanding the code clearer.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  9 ++++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 24 +++++++++++++++----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  8 ++++---
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index edd4d83e1e392f..9a878b5a7665fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1817,10 +1817,9 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 	save_count = data->count - control->num_recs;
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (amdgpu_ras_eeprom_xfer(control,
-					   &data->bps[control->num_recs],
-					   save_count,
-					   true)) {
+		if (amdgpu_ras_eeprom_write(control,
+					    &data->bps[control->num_recs],
+					    save_count)) {
 			dev_err(adev->dev, "Failed to save EEPROM table data!");
 			return -EIO;
 		}
@@ -1850,7 +1849,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	if (!bps)
 		return -ENOMEM;
 
-	if (amdgpu_ras_eeprom_xfer(control, bps, control->num_recs, false)) {
+	if (amdgpu_ras_eeprom_read(control, bps, control->num_recs)) {
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 		ret = -EIO;
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9e3fbc44b4bc4a..550a31953d2da1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -432,9 +432,9 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 	return false;
 }
 
-int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
-			   struct eeprom_table_record *records,
-			   const u32 num, bool write)
+static int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
+				  struct eeprom_table_record *records,
+				  const u32 num, bool write)
 {
 	int i, ret = 0;
 	unsigned char *buffs, *buff;
@@ -554,6 +554,20 @@ int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
 	return ret == num ? 0 : -EIO;
 }
 
+int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
+			   struct eeprom_table_record *records,
+			   const u32 num)
+{
+	return amdgpu_ras_eeprom_xfer(control, records, num, false);
+}
+
+int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
+			    struct eeprom_table_record *records,
+			    const u32 num)
+{
+	return amdgpu_ras_eeprom_xfer(control, records, num, true);
+}
+
 inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void)
 {
 	return RAS_MAX_RECORD_NUM;
@@ -574,13 +588,13 @@ void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control)
 		recs[i].retired_page = i;
 	}
 
-	if (!amdgpu_ras_eeprom_xfer(control, recs, 1, true)) {
+	if (!amdgpu_ras_eeprom_write(control, recs, 1)) {
 
 		memset(recs, 0, sizeof(*recs) * 1);
 
 		control->next_addr = RAS_RECORD_START;
 
-		if (!amdgpu_ras_eeprom_xfer(control, recs, 1, false)) {
+		if (!amdgpu_ras_eeprom_read(control, recs)) {
 			for (i = 0; i < 1; i++)
 				DRM_INFO("rec.address :0x%llx, rec.retired_page :%llu",
 					 recs[i].address, recs[i].retired_page);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 6a1bd527bce57a..fa9c509a8e2f2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -82,9 +82,11 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev);
 
-int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
-			   struct eeprom_table_record *records,
-			   const u32 num, bool write);
+int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
+			   struct eeprom_table_record *records, const u32 num);
+
+int amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
+			    struct eeprom_table_record *records, const u32 num);
 
 inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void);
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
