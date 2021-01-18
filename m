Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC65C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8F6224DF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8F6224DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257DD891E3;
	Mon, 18 Jan 2021 01:30:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FDB89A8C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 01:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj7yfmn9bMIE5NNuYIEf+0tatF2xKRR0lDI8hk2uzk177nf8Xapi1x0jZfKKHGxxNHJP00iDsp/4aEK6SVvVvA+yRxqROrx0glrNjHfMYlT5WNrQg4+FDQWZFz97owjOSr2cMG6TnC5wFZApoau3LecQEcV2CK6ViY4wD6ESCqydEQiMfs9VN/eiIS+bgYA1OA6HJ510c1K8YiKHr+CMM7XpDwocZbtJ3osgcdKdTs6s+HpgaKJMc5punOrW7jwJ0MgI67W33sdIDYZXwZOabdrEe+uAdW30Tik2mzJVG/rhPjH/RldDEXICDwihPFpfkcOC1D8TrlJ3cLsZFljpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3iIcNwOWUu2HcU3NUS1U8rZz3/Xq1pQOqPRDu0zWFo=;
 b=SfFn1PK5StUJHACVhy9NBf/OAm0iRBTgIu9G7wpWPeaOBh2wqS6FreStqUvK9Wq5NQr6CGXIvJVmGp5bnAe2maL4d4uDHkWERpzvr/yPTSeA3lA5jmFWrj1b68lSCUcSpbv+6lx4MaezvQ+hCzWMwtfUrUvHgWtmClat2o9BQa7Y4nMAlsXZhTCoKYkeQ1WOAr2g2aWavpYPQlVW0bVExMfZUwxlaRoSep1IBWWXZZ6rrnCoS7A1Vr56HzyajnAuwMDn7D2rKZvYkPp3KrjKGbSFDBmlv258AqaBmjLNM/xjcaur/wOe7VZUmg7aBuukr+hKgIQpNJD1nVtgj1ohJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3iIcNwOWUu2HcU3NUS1U8rZz3/Xq1pQOqPRDu0zWFo=;
 b=H74PtuagUGq8Ea0huBgCJLSgWKlgNWHtoRh42Y229RxFQHTkBR77Ql93vLbGN01KCOQm9icSrRm770FmDEQNtK9kIIDws1mBDc8ibbly8ItlBRM7OmS4XjD+7sJ8b9R6efkTvDLhy5DCW/TcfihY1zVES70+Ylnww18PnXukr9o=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Mon, 18 Jan 2021 01:29:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 01:29:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Thread-Topic: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Thread-Index: AQHW6yGcm9atOe6/vkOQ0S7pfVohraoocXsAgAQq8YA=
Date: Mon, 18 Jan 2021 01:29:56 +0000
Message-ID: <DM6PR12MB26192381D8B57E2283B14340E4A40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210115093406.389563-1-evan.quan@amd.com>
 <CY4PR12MB1287BB7FACC53E6156A9C7E4F1A70@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287BB7FACC53E6156A9C7E4F1A70@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-15T09:50:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=349d5cfe-a923-497d-903d-d771062d6fab;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13c5a0c4-6c10-4a28-3564-08d8bb509063
x-ms-traffictypediagnostic: DM6PR12MB4436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44364C2976067A45DDC6C87EE4A40@DM6PR12MB4436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ujbzEqFiAHOsQc/3Zt9pI+oDQ+5clShIyrxx6mNXBLEdZyE4n2TFmu6YqIzH7mSkTD7Pvjj7AsRRgG6OBibujAS1V1HNskktbIzqYa+LZlOuyB0eSS823Lzt8T5U2OfSW+quJO+7PrQHSS9Rp4drMxD4eLne7g4qyZyqxpLLMSRCQl1uYbNTFBxCISB+5L5zzf9x0wZYXETAkFTT26ZvROPve16ZEgMYZeo8rtY/os7Us329osAgAe5UY6ABeW8briift8vFSnMfwuwKa+BL7kjj7jtaTTTFY5CumibJw/UXElL4ph5h+gb59HdupdOTPgaHMoIEOzFQDdCdmNmCeks0B5YW22+JwtHfMBJHNvW2nKRduF1wfqA/FeLop/AUhnMGphH/DZ1X1twWoHRvYQHchN9+c88T2dIluOtph2S1Feu1bpGZGWYUCfzaZzlcLoOGaONb5Nc0c/kLq7a5oaduzJxlDX9czs5We+9IlD4P6Iol6Qe5Woua4wh1s/DE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(53546011)(6506007)(52536014)(8676002)(45080400002)(8936002)(76116006)(66476007)(26005)(66556008)(7696005)(66446008)(64756008)(4326008)(478600001)(33656002)(55016002)(110136005)(186003)(316002)(66946007)(2906002)(71200400001)(966005)(9686003)(83380400001)(86362001)(5660300002)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gPxvItz9IW1x409l2CMAXAHnj+dJpSEUOAzGO1lIeeK+azimG/WfEYnCTzxt?=
 =?us-ascii?Q?rCMMDBZ+REKErm3ppvW/AgePhEpb1u3d8MXqdZhdUhLt1/nOn/svASU9DTEt?=
 =?us-ascii?Q?5d0lbTVfRMJ5Gagucie0A4FkJFLJ7nnk13YgRwm0sHBYNQIJJYsVdJHsLb6y?=
 =?us-ascii?Q?38LGIawlufKpO5STg9lBxDBVDjpzs9hLNuV2BY/hmW+9jKOmYoc5eimYaShh?=
 =?us-ascii?Q?HhBET3xkJXrpTKcDM6NrARHuriVgYRU8yAmE/Yx7peyltg9Qy6ykH+f7SaBq?=
 =?us-ascii?Q?aWTZxBfRxHei9eS2v/s9x0IU5SSH24ly5SQB6QyJqRHGMr/7nlbdt+iGtq9/?=
 =?us-ascii?Q?PsSRoMVSds7oQzlopi7Nc5eFoB+euakdHvBZPrRmmynv8g3rD10rwrHzwtLl?=
 =?us-ascii?Q?x0jvQeeSsBHz931MTR/WWaCjNFSuLS/BQ+HCmVnCc5l9B0d0xbhInFWZbVZU?=
 =?us-ascii?Q?w/iIhVG7T3LPxkSoGLjrHcCnS52sYXybJsqGCfsoxV3T3vCZsu+SlRhOADGG?=
 =?us-ascii?Q?q1uCGRCEH5VJUrjvw/dG5LE2ldDg+LVSvJkPCwe+/JfzN6cWAVQSgp+UHEK7?=
 =?us-ascii?Q?GoX66aLLhKYE7D+Y9cN2FCnvmHxNYAzQNWXF61T1BKHJ1gEQbJGYZjMf5Gbd?=
 =?us-ascii?Q?UAmcVwiwIx2xLWjXpUvJCDzhuzSmJ5yactqdoCBpw8rmhUJP5qYg3SKWjLJe?=
 =?us-ascii?Q?xRG11squkO/JWUH9aRRs6Wvw9fMQP2UDYzTgMKgmo+V+kF6kgxcCCQ4U31yV?=
 =?us-ascii?Q?H0k/z9tWES9Mpn2YFrQEzsy+6uEI1oA/7d4CgYjrtm8u9fuz+JqWiolAslJX?=
 =?us-ascii?Q?FqwCl98t0MwIrAd1eNq7KRh+nigTgIzwPLSKI7tQvrrVh1U6o71fpkLnMOr9?=
 =?us-ascii?Q?wKA87sHsnlTLDhZHY+h3R7TwBLoCKGcWlnpt423r5IcQr9PVCrc2Az1Jo4c3?=
 =?us-ascii?Q?mXsrW0JQGwLi2XvXb6oyGJJ1g4A+qevKmRiVgCstj9k=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c5a0c4-6c10-4a28-3564-08d8bb509063
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 01:29:56.6104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgZVTdqqIaXyC/qtOqc7wnKq4J6q2NjU31RCmPQ45clUv77FWdpATNdu+Xfd6oV1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks, I will correct them.

BR
Evan
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Friday, January 15, 2021 5:51 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving

[AMD Public Use]

A few nit-picks, please check.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, January 15, 2021 5:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving

Support Navi1x gfxoff state retrieving.

Change-Id: I57aa506b82dc122bbead708c580a4720e536cfce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 13de692a4213..2857f1bf4e9a 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -287,5 +287,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..93a3b6b60c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2482,6 +2482,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..50566c613971 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2127,3 +2127,27 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+/**
+ * smu_v11_0_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: amdgpu_device pointer
[Guchun]should be smu pointer?

+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu) {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t gfxOff_Status = 0;
[Guchun] Any cause to use capital O and S in this variable?

+	uint32_t reg;
+
+	reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+	gfxOff_Status = reg & 0x3;
+
+	return gfxOff_Status;
[Guchun] return reg&0x3 is more simple?

+}
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6736a835d7b34d71079f08d8b938c8a7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637463000831854828%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=CUVBdQmZcOsqKxzoB4ut89g1UFmCW5PNDR6vvPIwk%2FQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
