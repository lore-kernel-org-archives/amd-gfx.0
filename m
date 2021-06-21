Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E7C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B6B6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B6B6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354A16E247;
	Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4016E24E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSWFfNak6eIdVPvGLxljbeJoDJhGoBVVhKgOSzsLeaf7Np2aps0uN5LWmSyDeQ/emGwrCqKjukhZyyOYKKvlox3GgPTH8uSM1GOQrdXhBZtbcH1lknFMvg+IyBgFfhyhZF6oejxnW7xdJEA7NTudnrZ9Fh06na/CEQpbO3zBuOwAG4EFVbEUbnXP8hW6F08GkyV8GPuQkuJa0ivB32531/+qvzQmTxCsn0We5aTh9qW/92R5VK+9klh74BkWZzrBkIQ2SVjNRN8Vujo0GmADwVJw3Gf3TKoH/iTCPuY1peU1T6bIF9gLp128TEw8Q01EVZSqq/uUIkFo4V0n055F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dc26QjsGbcB3EMfBO3aLzcvSN+X5vDQcj9Sk017xaQ=;
 b=Ze1d/SgrU3ywcDyIImwhiMR2icajDhYqUXd0xG1UOFXqu3aOYckDEbQU1dLyzhnqEqPzu8hdeq1I86ml8aNKyCdCgfnE4TUdLxMg8MtFLsg/hdm7CZte5ffObfvbLp5iqSi0PIaHicwjXmq3FXf6LP/qMmiD0/2t0yQouE9Q9yU7x3rqnj+KWqK3sIhVHxLw5yG7hxGBvnOb5J/K2Qsd6QANjnZOy7O+CSVFCEqzp3WUd3XpeRSyag1Vj2RC9moETwPQ+CTnE+T7XRC7Ir+v5YeVuWHEmKoh8bgPlrUl/ZC1fmDcYvnxgQWShf6nIm+sJcAzmuNdus0dGZfiDxbkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dc26QjsGbcB3EMfBO3aLzcvSN+X5vDQcj9Sk017xaQ=;
 b=NJk39cTmMR2/Cds/IQZxabM9MbA7yOHSYrYD0hU0q7nStbml3oxrQb2h0MIL7KPwbKd+RcXm+4czfKCZPS+2TfNTMFYepfna1pywyaakv4hWoFSmwjeoJ4poriUsy1VmUR1O3MAO/CSTpIjRKnANTq48a+Kgam4m7iRE0qq2csM=
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
Subject: [PATCH 27/43] drm/amdgpu: RAS xfer to read/write
Date: Mon, 21 Jun 2021 13:12:05 -0400
Message-Id: <20210621171221.5720-28-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 485ba016-c201-4463-bb2c-08d934d7d04f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258F42F8DED6EBAEC417B87990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfZe4V7KhASs9YjmMb3/Ay3+nZYjm0aMQAkMQeZsD1qkYvj+DVoyloD+BV99GM/C/bXxAbWsROIqW0jcyPqv9n4TdcPj30zlRUcFJp+/hjtTO8imsgsx3SFCjxPhgMg3L7KSQCD6Oho2xeJBWwfeR1n9udE1yEr/RK4AqvU4xt8dQREV4clggvR0uxtd1DR7qAfExrF2qsgWWQ3VnAtYrzx/rzV3/hsvtyQw0i+aK+ugOKt0bZI62CrF5FQ2uqencpVbBspExuO8zAqtlAtZxutg1naeaEaXDeNt6cBoinYjqKnfC7FfZGUuGeIphQm0Daxs4+3N/KTy1mDZL67QaR/wI1byQvD2HMlw3Vhyx0ttXdccRIWX0tV/45tPkAtJ+EfQcKRpleM+hhpeXxLZUIh9MaMptqoarIclBcj/urUMH0avtT6g2Ng8qPZcjk2XIlpMKcqw0JaczETo5yYUtnkOXkkysmuB1QFTOTz14TKgwvkGjO23ii0RwsheSsYiNepftouGvG+BSySq+gMSmatJR4DjhAiz8t3DztJdwjdnyi61Blhc7vGHiA5igh8he0JvazD13A7Vl7Lj+1mKJp9BSzXOyfrqhrM8dYcCzQlA/YEZw1nataU0dKxfkZPj3jM0cNHZSIxbaKK+IcLOlr8Zv3etN8IvDQu73OLt11Ek8+S+oc0/Y1nnB3HLEbXB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(6666004)(86362001)(316002)(5660300002)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qy45gPmYP5Qy0tK/RF/rkvTrUOmL62ByGeHsBzV2BF343DkL80CJyKsNBCOv?=
 =?us-ascii?Q?xqyetUOmu36o2dnMYoQpERzIs4KQenjc8U/6AAHpky354vNCsC6HngJPXeJM?=
 =?us-ascii?Q?czBqG0VrWA5vDajsvX4zCWJ8QLNRw1DgK7Dr5lrRNdWgEw65C5pN7YS2MHxT?=
 =?us-ascii?Q?Ls2O83i+h5LLnzLso88CPHN55X55Te8CIQwqFzwq3HS4LlDVvbG3AR5nznXA?=
 =?us-ascii?Q?QhOIjDqIK/Fa318hmjGE7o2VaPsgUINlG4H0vBTCKXdVQ6xrjonja6jBsxvX?=
 =?us-ascii?Q?K+f72+o2yEWVeolnSj4GVwTMGmn10g6CcO7ba9mUcNAKxauMwYuj/EY/bGgJ?=
 =?us-ascii?Q?1jrLIe3gte8fhEee9ZajKD7+/SVzCQBY9BLYBkyGHDUEuE2WWxN0VJW0IpOh?=
 =?us-ascii?Q?4VnQSvvaF8Hex86UZqlgetAe9UCavqnvQ4mOM2466R9AAnErwG4p7iqCzrdj?=
 =?us-ascii?Q?fuY3ivdjaugJJVbwRw1j4BSxwaLywVupML2bcv9qlVhGDDxzqvhk/ce0+YYC?=
 =?us-ascii?Q?G4At76EEzR7zKf7I8eE5XJdNqM7He+HA2+CeekIlL1ZAqzWWSdUg7X96aKpF?=
 =?us-ascii?Q?OjJEFpqpxyDKFPPSbY6n3AY2y4ze5/itjgT58RB2DPVNXz9lSwJR88YMDmgB?=
 =?us-ascii?Q?dbhdIxdmQOig0LFTIl7UtBp71kJB1zmIKUol4WqHZnEJe8+9/Fzpc6A7A4QN?=
 =?us-ascii?Q?uhKIr7EzC3V6zHc7P7z88kUV1geAgHimTNBUxf1+48uQ0qpKsQ2TPdkrwmc3?=
 =?us-ascii?Q?TnmaGBLPtcNy0ydG7+M7abaJicyEWq1l7oQ7pQ2PcJ4/mqT70agSJwb6qJ6E?=
 =?us-ascii?Q?y4kFdr01FFDAhSi0GhGfd/vpiRMQPG8MzgpiClWUaOdy0KorCLCLOLbdkAnP?=
 =?us-ascii?Q?rdTJwPE8oa5jJLweGc0OpTarO+Ox3CFCEaVUBwtMy+VuI8MR3j2DDwIWgNjC?=
 =?us-ascii?Q?LrhOyUE+ewOyypqaed1ZAg2U6Ybz365F78UpCjwPAyH1e2aSHay21zHCNIpx?=
 =?us-ascii?Q?mYPO6mwFVqQHDJqIV8hD3fwaPob7nGEgUZnui1z85a8mErqLwetiVCi+m2SY?=
 =?us-ascii?Q?brr/DdvPuGW3etv5tjmmHmyZ4qZNqpXsvhsX+cf4bUPCzRqnA059lPuunnwN?=
 =?us-ascii?Q?P2c+KTpQETVbCwIck9A/L+00VgUX7AxVQLnNa2H9DImRZfCSELq34TmFPLAR?=
 =?us-ascii?Q?O1L68riyzbCSPoYU013nuewHEkF5npZ+izAnRm6XaZBbVNQ82iSo62vfnf/T?=
 =?us-ascii?Q?qDJmi4IHUrvZ5jya9J6f46afE17y8NOgZzAcov35jE/Z6l7QcQw6PdHICB8Y?=
 =?us-ascii?Q?nlRWKktKRw0RTqprM5lbyJQH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485ba016-c201-4463-bb2c-08d934d7d04f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:56.8394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHyq1InPHqKZYhpAOjADZBgkbQvxuZjytpkf0OuGsKZSM9gXJRemAcYb5d7L6o2o
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
index 96a2f42d57bb2c..a9af6d0a2ed6bc 100644
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
