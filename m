Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439CC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C67D64EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C67D64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4B06EBA2;
	Wed, 24 Feb 2021 22:22:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AE16EBA2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbd4j9yatTjN4E4CrMj40psLOzFTneqmx/06QQsbZdcYDVzsxkg6jZCpZmnFo0AZsMRZ2iTFGe6tpSV7vinRvqGk8kA+CXQoKudowzIVfKXRWv2E5djKCa+Y4Kob69aoHh9ulfF1rKlrNzegt7z0UkJTSgR3PeXhN8cdC0gjA8LrJn06E1gXIFGYnoY9O6nFca1mv5d+1xjd15uf6iiRqHmp/IWEHCDp2IDW2tnnT1Rvl/bqBk8Ead2dTL+CEH9g9PctbeODttzXZRsEn6Ftmq1v7mlDmCAEoCHYgVKjE3h1qBqF2SQOUu8F5tuIDfwK2GLL+JyIp3mEofjtRXEoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eARVWH9TQtGt9kUK6WRrBPC8/T8jiE+uJcYFVmzcR6A=;
 b=d1olDAkNguZvPDQDQ1wDIeuMcuQc5jDEB22JsbLSmcXYD3B55Nj3m3J3WcmuEak4pfBYHjA/pmJv9mHgxcZF7WlhcNbZn6m5VlR4F5PoA90zNiNe+vL/ED6H7VUPvhCN7+f4saswueNpJA+xNCLnh6RfKqhxibrKOIQeD328Rbc68Dc+Nk/rvA/ZpOsdwGNioakJe1DHkdfb3kB1w2qZj4UPAWHkqMtLx/SSx9Qt+s012wYbdfSe4fU9YO7SEftf3NzK2KFOyFMm3JHd9iUrpXvAd4NMbQfDXA+ESgfuCVyHfyxMsBXg3m+NGg2aeBBjAuZPJarlZG2vcyC5FgHSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eARVWH9TQtGt9kUK6WRrBPC8/T8jiE+uJcYFVmzcR6A=;
 b=n7YaUL1nuv981fVDkLrvAjRBFj+NVweyFYhJhdaUa1ctzMUkKBNbgG16b0/zQrHuijjTrMWP1d3H/uwu1NPoxVAqkUKmxFWPyqTqVvgADOuj2d8wmnMSz09Jrzr44A8gZGQnHWAOBw8ybBSizMsHhBgkT6LXgCSCihMQo4ZQYh0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 141/159] drm/amd/pm: remove aldebaran serial number support
Date: Wed, 24 Feb 2021 17:18:41 -0500
Message-Id: <20210224221859.3068810-134-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3d56317-def2-403f-fdff-08d8d91275ad
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38070EEA3F9B541E3AE3CCF0F79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUeErPqs1zXTSNh9XbWrBnL+285lo84xmfghkNDlsulZrBSFZH88k5dOgiUjBANHrcf8xXHo6UhIx5LXm58C+i3myaplBlZUuZM95DkoqhfLoWP0u/IMHtredjcv3qaOSpXfGHBzYbAISIxl5XwizYMHYIZsjTtiJLmxvNctAcUPBMa0txH8cxnOuHUgnqaXS7iLUNIHTaGmHidofapQb6XjWWhq6E10fcvJyJuhHYQzafXZtM8SK3+27qhpjq/lOy+fQHt2jUAcrtw2WIUPSMFAXEoxqLHpMQpjGwgH1HM/FuvPHkJUck2P0Kgua2pOfwGGYKstYGRNLGGaEubKhXq31Jhub1y/fsxE/G6wtgkXBtfhMwXcad+SJEwa+JQLRnbipFJhRBJQrNKkIcI53FqrdD1OKDSt3305Yyy67hA+ILBXK0W8EG0ZZ8pcQpWk60qA/9FKHTChFUtUNHIs0vNIcP2ghK3KF6cRwoSpxkh7KO24jxDeyRZBHSTToxP1Dlp25yM2iqD0kR5RhKImZVfjfwDOgeyzu3bBZ70hUKNBgfT3MzztfMYsxwuUReqVg+HdefOVLK+StFmNHBAR4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(19627235002)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z+osdqcKYOklbe3618aT+o6gBFuVbP1ycrivRWvo6mkEUyvZ7U8f4dwGz9jI?=
 =?us-ascii?Q?JJgpk3dCnBSbWln5Fr/J5ZX83HqUrKu01g02eYmrox3n8QyZzWa1bEtFjT3k?=
 =?us-ascii?Q?Gqy2fY/UgYiIwYYyLvFDW2zx8lQ8e1hsYdnEBzX/9h/mWMriwySYP2KNTeZ6?=
 =?us-ascii?Q?guyuPlCUXNzjDY7XtWLq5kq/kwytyUzbNpM/oHBgCSrXNY01gEfyWbLBIWGx?=
 =?us-ascii?Q?b/hG6qcA5FAycdsVMbGrd1DPj2qii47E0fWWR4nebwhKpOR+QxQbBRbfw87u?=
 =?us-ascii?Q?ltV4p/YR/r2xWvXNiMWc5fBFQYsVC0mIMFUqXWIiPUO5wy5gexFvZ1QU77/x?=
 =?us-ascii?Q?Hx98OphK59ffOe+GWsOBml+bKe8UrBuP386Gtw24lL9DQoQD3it/iwKT3DgD?=
 =?us-ascii?Q?4yaO4zQqwn3GCqQreUjqkCQ1GPIAHZSC1+OmhUwcN79u/kqW6YmPCWNA2mew?=
 =?us-ascii?Q?kvW3gGDLLH5ibmbvvA9RTsaZLhG+yoWPKPEZt8HELypyacN5xYSf/mLOmtEK?=
 =?us-ascii?Q?xuY4D9s/3zVtc1x+92Odhv+fnp+6dO9cU5URTvsgYMKLG3tvYPSZ6N7vM1/W?=
 =?us-ascii?Q?b0BEA/S0wT1jbvbeo+ioa1ZeOROg1kh3yi9x4/2rXAoE9S55W5YMNOrzuVBr?=
 =?us-ascii?Q?qG0oRneQ7TBkznfNwI7OkrALVVZPtgVg7juuB7wt0yis5j9e1RtiA/eVdZiP?=
 =?us-ascii?Q?jIgKwrknhelWkDI1FI8JAK94pgG2iyVLpjogkZii24Go7s5AMr3Fl6nvZsZf?=
 =?us-ascii?Q?VXEnOEFa9fuRrFVTagSbAeHNWk+L/GmXgYjvR6+7JoTJ5V4IDSQyE3nFOyQF?=
 =?us-ascii?Q?bHj+3w+DVJrkLTDeGadjnL0d8RNx1NYUaKnRyqBUEkvX4XABIupNUoetgZeU?=
 =?us-ascii?Q?VeGOl9ht/hlq1jX49ljcDSyQ17w3ZeMBc+9TyTQgDfa1Z6PeAsgJo6zHanmK?=
 =?us-ascii?Q?dZK0H4JIFv4qoDlKIlzQzhf2CM2jMVXNRmEmKY70DzQRs8TxRfmzJjsC7I76?=
 =?us-ascii?Q?y0S1ZhmmEg3GuRI+WY2RGvqGH2Yb5P3ZkAqxuqXDTksSq8sxiXR1Iig9f1Dy?=
 =?us-ascii?Q?COCiHetd5Tr1n83g3HXrqo/rrTdfR34NOijkJGU7GLKuvGef5RY4TOrsKqjn?=
 =?us-ascii?Q?HAcyKisS+HyNfLCUigad1xChLnqsVmyLgEoSpbXNZPzNVW8swM8uIZcOD9tH?=
 =?us-ascii?Q?1gd7iS75JaWJLeLJVpPpmNYzWiZtNe3h6S60ajzyAE2w+wuohEVbgcbBss1T?=
 =?us-ascii?Q?+2qdJpvzPYEI4mI2PLLlM1b+yt7U9r4uHu58aAF1xlPacGFwBGcbAWUBxkq9?=
 =?us-ascii?Q?T9ytKwDxmSXi4I46Cafov1dd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d56317-def2-403f-fdff-08d8d91275ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:58.1693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRklto0oXpIs3iW7FarOoWMx+wwUNji3JoUv4i3yMupxSI/jzh0W66JWMUi8i7VSQzBpF4HMtqFWyc8mDWs4jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

the following message is not supported.

PPSMC_MSG_ReadSerialNumTop32
PPSMC_MSG_ReadSerialNumBottom32

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index df94604edd97..7bf8316b9816 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1183,24 +1183,6 @@ static bool aldebaran_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static void aldebaran_get_unique_id(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t top32 = 0, bottom32 = 0;
-	uint64_t id;
-
-	/* Get the SN to turn into a Unique ID */
-	smu_cmn_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32);
-	smu_cmn_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32);
-
-	id = ((uint64_t)bottom32 << 32) | top32;
-	adev->unique_id = id;
-	/* For aldebaran-and-later, unique_id == serial_number, so convert it to a
-	 * 16-digit HEX string for convenience and backwards-compatibility
-	 */
-	sprintf(adev->serial, "%llx", id);
-}
-
 static bool aldebaran_is_baco_supported(struct smu_context *smu)
 {
 	/* aldebaran is not support baco */
@@ -1373,7 +1355,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_performance_level = aldebaran_set_performance_level,
 	.get_power_limit = aldebaran_get_power_limit,
 	.is_dpm_running = aldebaran_is_dpm_running,
-	.get_unique_id = aldebaran_get_unique_id,
 	.init_microcode = smu_v13_0_init_microcode,
 	.load_microcode = smu_v13_0_load_microcode,
 	.fini_microcode = smu_v13_0_fini_microcode,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
