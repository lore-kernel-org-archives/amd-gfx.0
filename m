Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D75C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE5E61375
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE5E61375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A3466EC4C;
	Tue,  8 Jun 2021 21:40:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1326EC49
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv0qXyqlr7vjdVBTWtFbPv+ASgN/ohtmK/zvcGrHBu6IWzU2noaliCeuxjbfyqWcCJN9HS8/2ZzvgEhxm7Eqg5Am2tvVipn3xzHcRwCSTO9M361r8FiXUOAbYfOyewZw/OKjXuDPrXUUbf9IEhmkmua98cprAG59eGd1jbja3y0okpA6B+M/ncEMbgv7MgdZ1UXBpQB1nYZgK86OzmVH9s90uENf6lOEO5YfTyaMo/pbfUZusRekHf78ca7QeVNKA3hRa6GXRuenGKTRbZSOW7s2HDcHmPh35JdD8YZPirVaSQNjnrEHGw0kWtTPSIYFmBHDG8BDVaXrhdGzYqXpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On+Z2lo+xQqOb/+FT6dbUrrb/9Vluv5DP6qZtMc7ur4=;
 b=lDSjijDtvClTamOZvmz22AZUNfQhv3DBZ3GCGN08E8UABLBzd2zeUk7MGPwi/QbqT8rvKYMykbFTD6yAoBl5q9fk0m1K4pTWzPQcMyPC/jE1YxjviX1r5gYTTdOzNlPZYhc7v8lllPgwHeLbfe4I1Wi2cDxgC/9p/Faq5oCYprl8+EG2/8QcfE8SQBFVRG3ON6psnxOweC2S2J2nbL/EiJRL1cWZtDKsFDQ9IOWsmmQ22Tb4SDUoCqPJ2RreC2vfjJvixjTfVG1Nce0fx7oA5X3+CK8VDn/suQhMz85MsZoACshhW0UW9n6zG6dnNsSJWp5CAGcuCo5didfx1auryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On+Z2lo+xQqOb/+FT6dbUrrb/9Vluv5DP6qZtMc7ur4=;
 b=Da/JdPVer3hlciZb4HalNEyP5O9JICcRuqpHzB+L9WezEifnZB2Dh6b68i/D80q5y24oTF80G7Gn9GldcE8KGX9d8C4tNIa9CvK6E2w+SDhBw+HMMlQAdtoJJnJyumzlMzmFTaD1womVWQlEJe43iouV1+2+f07/WXg2Y+/qvRE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:36 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:36 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/40] drm/amdgpu: RAS xfer to read/write
Date: Tue,  8 Jun 2021 17:39:41 -0400
Message-Id: <20210608213954.5517-28-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c51982f-fad1-4617-aaed-08d92ac60d1b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435210F5C77D996C5217FC799379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDZaT9EiYWaUNuHsp7uQyrYf1XENQnseTEsN2RfUiqfBWTKwRsNec/qlC1Iu73cliAWC0EJshbDXQcB5Aiz2Jo2hZObWPWOj2raxn7X0uKir0u9XPGdPTTvkizIodyEmElWNQsDVA0EEbHp+/t8MVC5Gcn7xpZeozS7HpoXiupFbIvN3HrIEp14idgOI7z0Y8fugUxv1g/YqIxkmHFlFMu4U0gL2HMfbdwT2LuTQDh8b1h2++jZoKT2fDap1ShZ5j69zoHDFmkNscjPx1YbRHF2hsbCOXGwt6KssGVm2JglOPx4aNGJOR9T0EbJKmyYqdWLA70B7bEYGFeS1O/Bt+073N/9mQpx+ahIYrwPf0OiKDhoAJdRrNQzSXGwHR5OOHVMvBHAq/Agasmx8gFXdAJEhTWmiDyoUe29nyupdwVSawE9qqJB7Wgn1dDqCgHpl9UDKs9ZwdZ+znDVMx654ec7XH7mfbPn/q1svbrJPS5SkBOOTIuQjenCQtqJXS3GQPrOK6bzAbI2jEwwrBBsDDUuf3uZxOAVy91OVXtJWXLfzS9vEO9YPRfiafU0DIbDl7q4TDHjD3xC4Eh86VV4LTLdzX9TgbhD5c3G7EJka7Kgdsy86I4+kWSbGL4Bl0goDcdnS0ppMKcCCc/FgXshsiWTW+HQYmM461UofSuj0VCwPElrS4VzrynE2849NnAHo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErQcq745rYuybIcK/t9XJ5ElAWLoU8GazSKIvz8GlkATxKcA8Mmc9QfwehKB?=
 =?us-ascii?Q?bgBOLhftawBFnssvQJu12D1ZMshNJyQj5zdEYSyRqyqL8OYWrWKZ6YHeYp6x?=
 =?us-ascii?Q?8SfPXZEspbarzs02EdwXzvEcmBBScwe2jMxWld6N1vP1v7uX+jEGR0pCXHOx?=
 =?us-ascii?Q?hR7JelJ18zL78pOY9kYvb9CHtvSwqSWPB2qz0zn9vq59hqtKOqeNxdJr6yih?=
 =?us-ascii?Q?eEygtx0mBigAYHqg2d6cxGgOpsvO+4cTyipPRXp2xyJvracb2W/cxV8OmlOg?=
 =?us-ascii?Q?jFYbLJhNDa34j0cHGUtr420RBOcyYm8yEGKCcyenBr52Tg3yENApQfrLE1Yp?=
 =?us-ascii?Q?5CifiiSUghRd4f7RGbVgKPpOoQ0uNasphCEn9OsH6OIcj7kPZ725TTPufjK/?=
 =?us-ascii?Q?Dnz8ESXcnpXczmxdsnBF+ojN9mROVaeAc95SBojVDlWdWf4eZom/Px+cHBzd?=
 =?us-ascii?Q?RR2c6lGayziUGaveOMPvv3CNnNFBVcs+h9nI6XbTkllBhW3TC7lxmS2vIETf?=
 =?us-ascii?Q?LkiQRuzaQa+f7yAznrZWDkOxFzRwQ2iAQWIE0vH7YcJwmhdky+vVYUsno5Sp?=
 =?us-ascii?Q?wc/1OAHD/lzo/NWcwAF6Zg+ojteKeDKzlQy02QVndkWWf+uPoYLAi2SX6Grd?=
 =?us-ascii?Q?MG/CEwYlTOjK2sFOrefI+NJD+vEsjfmCnFKiWy/0UKt8AvXMm212vCMVOanS?=
 =?us-ascii?Q?o8OIAdQaaVddXfT1tL3EMa6ON9egustTuzsC67SKRFbr11lqv2iZAzMiaRXc?=
 =?us-ascii?Q?sSg9OJ+xFEFhXzpuTC23ity5E1XrPjeuknRSizeDP6KVvI/zT+Fw7AJOmMAP?=
 =?us-ascii?Q?KPVcE2TPTC42GXy3vNNEPzwpOZtpG2ep7uElrZeURKynBx8qEMAg86nNyut3?=
 =?us-ascii?Q?cJ/xLbcQzC4N6HxjNAVFgB7YvkreqWlviRf0IATEXvT7KWHLOKSpE6To8OMH?=
 =?us-ascii?Q?NhVpp3ZHp1/U9NxY7Nexpo6jdcILipOZbikzA5Ez0Tqsh2GYA6Ou60x5DcH3?=
 =?us-ascii?Q?Nn/dyB2T3oIVykGtRm2yUAmiASMqaJkozoT/ML105JfBgdU5KTO6iARLasgz?=
 =?us-ascii?Q?G+9WyzEAmoKfp5LLaCS9+RHShUe1BJgKNg2vObkLLEErJ9aE/u1bgQPVLup5?=
 =?us-ascii?Q?CpQTWRVUbCG+ACRDvLz0bO67h7k9IzGcJQtV+82de4jSuv04viI6t74hmbAz?=
 =?us-ascii?Q?ij7WBfoA/Rstobn1KFWy2bD+H/2VuK/lJfEzIPW9RAw9lKmlHgiSH/nX1vs4?=
 =?us-ascii?Q?hL64b14bVUn/0rjYqUeC3cuwMqaoznUVRhFUq/s+8T2VoAyFCDjo74DSmoGs?=
 =?us-ascii?Q?Rz4dUYYZOW7P/ksGTpHaJU1g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c51982f-fad1-4617-aaed-08d92ac60d1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:36.3253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNUuqEAdGhS979oF64LHEGbOsnXLkVKCu4sFZFi0/vP520NqzpKRcF6qgO6SugHN
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  9 ++++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 24 +++++++++++++++----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  8 ++++---
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index beaa1fee7f71f3..e3ad081eddd40b 100644
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
