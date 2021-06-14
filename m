Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3D8C48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BE961378
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BE961378
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B946E12B;
	Mon, 14 Jun 2021 17:47:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA8A6E12B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvWwHXAZKfSUEbnIA6kS12Hy5BpWiWvXkYfnnghDrCemFYh7YQZSGV5yIDCSS163lD2A0HQtiNx1PeodI+ngM3n+PNOjGNqgjqrALs08yUcIJPVccZ77ceuRknGKI18BmfI1nP03Ux3I14hvE0Cx1/cDFEJhsF50bzsHYSCR301PpgPykRcsWCamdeVDjU+Vn0v4LPbDk1RLZvztFOuuls5GPtTEhQtKmFWr6kNw82Acrxe9k9LCY2Ol65lmYtpZt3igpQ70uHkA8h//vHgKoXLUJHLDq7VhPTofM7m/dW5Q4EBPwZoMvJ+WbSeJl83R43FPR68QoHsYgt5YOouJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI7JBIpprtbgbzTE5T5mZVETRB8FP2WhYHXvfBnF0xo=;
 b=fpGncDpHiLXE/H+LBTNMg/1fyGFYWS3AbxyGJn27tfiyCooiC0kbKj8soLk1MoFGrDxfe3sElUl6B52fN7ZdLRTcht+aZUwg9rwmEIaQ7phildsYZYD2yLkkGhTy5blAp2tv1uk4Dw6mGjjCxZBZH6njX7VLdzR3S9cM+9aF2c89crhx/jWL/X1eHbA8cwlQirbjYF/B05sixQrMZaFf3d8zYuEA5UIOOLDx8RrFV6yvFeIfL0wkBW27oeIctDEpUTJib3SMkEaHH4o44/q5PQlpiubHV2MaaxjqG5hKYEdyyf7OJDDaKMeyjIPVYZyEBHciHaPLcDUbX5np8NrL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI7JBIpprtbgbzTE5T5mZVETRB8FP2WhYHXvfBnF0xo=;
 b=rtKg4fSsjOpliTunge+DzqhrDyOSOFMmjfHue/ohWTZD0EqQ7izq+FeG4tL0bEpZWGMu/G0zO1ckM2RPaVbtAIBA2xAQeeZ9lSGkDLX8idkAJXUF6ZXOeK55PYu5TCsIIx+vXBYXC7kD/dJ4api1gw+isg6BSqOjwsI9XIFHxVI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:07 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:07 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/40] drm/amdgpu: I2C class is HWMON
Date: Mon, 14 Jun 2021 13:46:16 -0400
Message-Id: <20210614174632.20818-25-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30d1ce5b-7c3f-4ca2-4605-08d92f5c6dbb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3690044314E2DBF797E243C599319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hb0iae/pz8xap2tJI/EqxoBv9lhjYcv8ccPR0u62P+48FE3NksXpDRvDMzWejbeykBVdHfoPcHN3fnwMXfxMhA0EsmTLFXL6MpeZESauu6x2VDyAhH1ZPxL6KGNpdof8t4AJefgoAY2YVphKPbFEiA+KwUeldAuf7P58M7JVBiHCpBhJqcaTKSTysijf/DYhRM3pxVKxeFFRRMf4zPoHkb3THQ1Zvszl0r+fV1XIb1cODyzhyecGh/N/yA6QcqfQXF0B/N2adKkr73sDurvPWVO7HzesLiqOdBkrvPEykrZSpFhvMEV+SQ9/6J3qeCFgc/6v1kUsnSNr0WvpE/FIfzhvjzxZvLXer0Cag7BiKOnANoT7+dlWIwct/o70KPq3NGEyXVGCNSZei2Z2yykC2P1nMhyax5ZMKV86F/tnGTxEDDcmvE+nyurbyq9dS14Xtq+lyEDKUOkH3Mfg9vJGVybO9NYCCdLwDnZ+ZfCAfjpXEIt+InMhwmOJkgs7PHvw6PZciCI/E7f3ls6LWbZh1ALyd7E9jo7S2Gc65MvoEEhMRD1wVSr6sU6zMuzsDw8vOSvXnSvD/tRSW4PYtC/gx+E6Jh5WOVGGrjREzlsqfCyRhz2baQOBskMlSYQRBRs/5yB53a5iPOuzmAm9BWfZ90yDjBb8vs6WD0wGcDes7lf+hZO9VWlLUE60BmWzrYCY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(54906003)(6916009)(66556008)(6666004)(498600001)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iCDnupJCnt6hMMhdeGstyxyQAOYTtIrRDuBBylkGfQ92jPZykkL8N+V5eJs6?=
 =?us-ascii?Q?6jGClIuGEalfsJgef6Vrf+AkviXtExAOD0v8if63a8lA5Md9Ilm4YEVLPTUF?=
 =?us-ascii?Q?NYXKhnJgWsqUS6mf3quZeZY3hMm+gZveSW6Zx+kpeXYKJlrBKUg/6pVxyZcN?=
 =?us-ascii?Q?C8LeyRUDHLlygqZZHl8KUg/OBTwnUholHyAc4+mOUmAO1hFMuf0HQfx27z88?=
 =?us-ascii?Q?7ljo6vBBX8a/lAx9JQ2lu8pmFvAa8NChiACvw+w3COMHzIeK7xWM7vb851BQ?=
 =?us-ascii?Q?VnF309GwiwpnvsMnelM5GJjI0Qzk4oUeIrDlkCaHWbKKJH4MMQLcBLW+Hv0J?=
 =?us-ascii?Q?5R5E3AnmTUQF1ftTBMda4E5o+VuLjYmRnAQrXoHKnephAcxBUv2DmcUAmh7I?=
 =?us-ascii?Q?IiYsB7Mcupt+FMcNc8n/hJ1DraeQfJ4cOAMi4tiHVw6jNdziD38q2lO8JVWI?=
 =?us-ascii?Q?I6PXkm5aa8d25XYNxoYMj0NMuvn9TlkxdjSdEP+be4svX9e5Npn7NoWeQJ0w?=
 =?us-ascii?Q?KbCbjWssf+e4qHZxtEt8/McOWnwe1Z1YEHtmdVyNdxKC59B77mR+laZ4+3aB?=
 =?us-ascii?Q?KDOYGaXS4oyvDHNkXUPM9NqiPMwzb3kE4M3X96z/XZnoGlXHn235t8L84+05?=
 =?us-ascii?Q?j2uuwjHh89bqq4vQMpS0Nz5lWhBaE+6zyVRXpAuU7g5g3fbwxIbAOpsMClaW?=
 =?us-ascii?Q?sC/kyRl+OSq+fJGRl7uSHXMU4taDCW2iigZ77qLISCYUbGmSJeaCFVKmFALw?=
 =?us-ascii?Q?b5t6C319a1ntXMLkzr9x50NblRwgmmYuIis8XqICGfyu3qW5lXEqm2HbWb3O?=
 =?us-ascii?Q?Q9yc3dzW6gaozBSnDy1eUbM130MLMfrvIRcy8q7+Cdf0ZQyfjRnwfmqawDeG?=
 =?us-ascii?Q?3rP8H+3PAg2MrMEFIC3JZLo48AlH3OSXp9XbMdzi4ghe1B21Ur2nYhT42Us5?=
 =?us-ascii?Q?+J8XXHS4PAGaGY5BYObL+nxSZnOM3DxXtY0pguvCSDO5nuiaC5842kzU79i/?=
 =?us-ascii?Q?y0JpTOqC7UEmtfwj/GiuMiTIVdWnqgN33nuquoZgCMy72VC1ixepuL+AVzzf?=
 =?us-ascii?Q?usnX2a4bd+PlIFMzT75eQo9EIUTeoLXXKvYXt1LhF3IV5VTU6yVYcV8fGpqd?=
 =?us-ascii?Q?xn7RGMV6lKFdlODStXlQqMPzDAi6M8iiN9ry6OAXoeQzzf3fgyAJNJf8tUmj?=
 =?us-ascii?Q?QF3TnTkrCevrWNCfKQfnC2bWwMG4B5HwVyiiRbx2UQhYlA7r17a+yZt6WcqX?=
 =?us-ascii?Q?DB5PwcMTbP8W6nfA0/QQhV8Q/68ykbBqCpO8WsKHMhigiTbJwgx+I7UvPr/9?=
 =?us-ascii?Q?orRbVEnwItENdhp9HTRlhpYw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d1ce5b-7c3f-4ca2-4605-08d92f5c6dbb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:07.5651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86aE8d5+1NWZdTmabhkSTbbBnTc1hht2J+bnmQlC1ve/LrZFVH+N08meyNfZEl2J
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

Set the auto-discoverable class of I2C bus to
HWMON. Remove SPD.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c              | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index b8d6d308fb06a0..e403ba556e5590 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -667,7 +667,7 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 
 	mutex_init(&adev->pm.smu_i2c_mutex);
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &smu_v11_0_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 33210119a28ec1..9fccdd2d3e73ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2046,7 +2046,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_algo;
 	control->quirks = &arcturus_i2c_control_quirks;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 22b31055461eb3..e3cbd334a956d1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2844,7 +2844,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &navi10_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9a14103cf9729f..2444e13c4901b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3551,7 +3551,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &sienna_cichlid_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
