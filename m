Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B3C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 09:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19433611BF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 09:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19433611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA376E90A;
	Mon, 17 May 2021 09:02:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7576E8FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 09:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZh/kp2tsMUAdMiKU6arNLikqrNQ0P8/UWfNB4cZ8ZTfkwpu+aqNqq/MrLxLQbZdDDup46fsL5yHaQbwmPN03mQFsY+gBl7WxC9qLYe739nY+sj4WM22MFrKFxWhRYjZVceh2U4R8irqxOPIb0Pg76zBL97Z9e/+caURo0wvXxMJ0c3xYfbsqoZHusF3MVLy6CbfCbf7QzJngAZ09N03Ls5Dd7TZ5t8VZ29by2XF1iSZRuY9SyLSSInaXiLljWxj9YdKtQ7sFqLt3GqXX3mez5YqPaHWoztmjoqx0rbTz+B5i9QmY6USmXxlMXfc+cJINcrjqcFrAShrahJM7AxAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFpBNCZudlVDbmrikUQQrWRwPFLEn/nOjFXFH++EjDI=;
 b=DzJ/ogOqpJUXZVukGurJjHtXg86P86zmuZJhnl7hh1tMl0uoP0hqmwUmi9ys0AjSYBMWu9DAv+XrsNMKFt0gPearntWiER2+Hw/DJ6BVSN4885FYpA6tVcrE+3/oG9TFQsbCKf+53YHvWsih7+REVWjfUlMh2aMHqU6/I5JO6EE0d2HfNvA8wQmhcsXUMNzpFaNqVtVgIb8Rpa5tziceyguPVxw9k6v1d+Qz40glEjlDEHoZYQX9MzI1gFJxBrOcEhUCY1aJJh+mCDx4IZiwltrVEUQRGeQoZGmyIQJPsixquXYN4iL+YbXh8ktIU8rDk/9dwKbh+sgTeYkuNkZftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFpBNCZudlVDbmrikUQQrWRwPFLEn/nOjFXFH++EjDI=;
 b=DkVqoyT5iyx8SIpu1fCz7lFNFcmplpZXxb2S0UM5wgVNvQhCu9tsFGm5/Fdi70jLXzhjOsWF0HNud2+RpE4kOvUrZ5T+poKmA2/kYVtiSTaw14JfmXcZOWmwR2dTdKyyD8VZ+mla/VgsQwu64OXD9Ewet6TcHv2abVq846tTpgg=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 09:02:15 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 09:02:15 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Topic: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencies on
 aldebaran
Thread-Index: AddK9+XE91DitEyBTVy9IQVRlPxVPgAA0FOF
Date: Mon, 17 May 2021 09:02:15 +0000
Message-ID: <CO6PR12MB547376F1D510AA412933FE48A22D9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <CH0PR12MB5348E7FFE856A134DBCA8DC6972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348E7FFE856A134DBCA8DC6972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-17T09:02:14.391Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df72231c-432d-43db-73f9-08d919127789
x-ms-traffictypediagnostic: CO6PR12MB5491:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5491272DA6155735D0D2F491A22D9@CO6PR12MB5491.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqFwC4mAkPQhEQipqI4M/sjq1x5g/s5la2Yzh/PnTahRjWp7BQqPgN2NK3Cncg8rYmrwr6SyDU+SNr58F7kdtfjeiZLaJBtsBe4z4W34H2PwNQot3+BXee3dYngH02E8zdZCVIxq9Iqzwn0x6czW3WED1yNWYNbMsaYWRbBWOU3/oDZmtPLGX+2sdxBwXkKWk72VNWJGzVTMSMElLFT7YsuWS3qO+2WHPXd0izD0zkWVbUu85I81uvUmh144dWofimschJhAKCQ4m853FSl/R6JTn1ToMXaYSU43rwpAieKwojwe0LZSdcAqf9mAx/ZZttD2KYR9+/hvVHt7CG5r2xn1Bj9ffgjO/nabh3IzlPGLEa00I8wf4aE2U/TOksZnf3MLBtzNOHA5F7dCeU5bIBcIwAzkXKPV/AGyjNBVw3Y6+Wg0noM9NLyrh9NjVaekadecqxJJSI8sYlZmp24VTmHvznE7FfOu/jlmiBKDNDXMjRjirYMxo47KqL8bLjAcKCA1KFfxsbzGlEilxDunt2b0Seoppj21KNj23d/vqwXrTDHjV1c36NYigAFVySRFqS3cRhtU6O0FbfiGSmmF/nEDi0943MEfQbG09ibhMWg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(83380400001)(7696005)(71200400001)(6506007)(33656002)(53546011)(122000001)(8676002)(38100700002)(52536014)(8936002)(316002)(76116006)(66946007)(66556008)(5660300002)(66476007)(2906002)(19627405001)(26005)(478600001)(66446008)(91956017)(54906003)(55016002)(110136005)(186003)(9686003)(4326008)(86362001)(64756008)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?rNZTfHoJ9VatrkchzK6+cDxTw0RzFbKop5/HnpbKVQP38JovVfAr4ma+Is?=
 =?iso-8859-1?Q?mGoYLkc+hLOajxBqOknUkNpk/4gYHUYj6g7sP2H2GX1632zLjZboUXQsPh?=
 =?iso-8859-1?Q?HJFw8zPPcmrN0hANYBpnZIB63NybD2wBHgQ4ss+b0s6Ep3Rx3qAtJsV6XR?=
 =?iso-8859-1?Q?/RfnJJyOpn7esdlKpgZC72v3GQFpP3W1lSd1/ZehS8I8/dK/EoodrexAGt?=
 =?iso-8859-1?Q?p+wtMGxgTWsuz/ZezXnHCVeuGZfLkW3gjAC+xzi7OxxDj6DAAKYT2zfO1U?=
 =?iso-8859-1?Q?pbAtWoR83FUb9fKyWtp8sAxoP4UraIM13VTRG0cmz+mT0rEywbI/1LTLjS?=
 =?iso-8859-1?Q?MICwcu09ysc12tS2TXIhPI5QSQZNPKGaFEtwMN0LhZK/6TkCpI5Y29Ddas?=
 =?iso-8859-1?Q?WooZxizKf3uyWiCodt67PuH6sIqFk6M30M/keM9uHRNcPFzkLjXkDRreiX?=
 =?iso-8859-1?Q?0EAI/QbsmR0GY5r7krCRynw2PrsGc5jRwZKd5h77BE1PFDdh19h7onLBZ9?=
 =?iso-8859-1?Q?6VxF5NnhhRnY3z3Gw9UMWhRCJXUsuWAUjyagfcDESn+ssOb5eYJRH+G9ov?=
 =?iso-8859-1?Q?d5xcgoNkI8iIJkNySQeWUk/1wvkHWiOFnXGep4D8kJy/cIv2/CIyqD2AvH?=
 =?iso-8859-1?Q?SnheqEZGgZn/Bq2YyTzxWJwXfVaHFvVlh149ZkVQaz0tVKRjgojGNz8NWF?=
 =?iso-8859-1?Q?1LVhKubQO77ISR2+cIHllnNh1hQbZd7MNFm4h32801M3I1mDwXT4vE+3tz?=
 =?iso-8859-1?Q?xalItG2UpvJ4Hj54OhWNRuAL8jrBjDtvQXgk+/apVOhHXoYGFoA8gpY1/h?=
 =?iso-8859-1?Q?WbDYBC8bzO5Ry+n4Mm7X3yd7BeQ1rTTcSjb2nrMTJnxV13jqA40tqt6Cr2?=
 =?iso-8859-1?Q?6cLku1l6XAyxNZdS/W7nmTXPi7khq7VhXeRZUDaUCTIzPXQ7y2QE0BBpNg?=
 =?iso-8859-1?Q?7jF4E+qms09rMstF1jP+AkCj5ehfqPRgPp1X9JoE9mHct45XvtsqRFOiV+?=
 =?iso-8859-1?Q?GpexU19b7pfqXqgf6RehToVN64gvKiLECC9vK6G/3p2rQYeXanD/2jYwvZ?=
 =?iso-8859-1?Q?Y2nZCbm8m0jbteoPZ7MehxV5cv1MujUFHZc55POnQR1+5jXvzvK3Xn+LGf?=
 =?iso-8859-1?Q?mljqCKY66qg8I7VusziWV6LbhlR4HHkTRSXeo+hEoyF7QV0AxdEm79MJJM?=
 =?iso-8859-1?Q?aB9IH+8ct2gCjjtDB4ZB2gcWwTk8QvlG3PdGNMs7SQv5aPQFYmxO0XVF6U?=
 =?iso-8859-1?Q?GJZccM8tqD4l8/BAHJwfHN7AtBZ3KjN5n/WiAUxc6z3iLSSgVkYEAX5Vo6?=
 =?iso-8859-1?Q?DWQrsuic/PsorS8OOGxrSwjRnXqBkaj8yNaW3qMr0PdFlMDR5AI/zFGL3s?=
 =?iso-8859-1?Q?DfccP9nzy9?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df72231c-432d-43db-73f9-08d919127789
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 09:02:15.3416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5ske+zBI3IgDpnWsD51fkTQsGjHZHmcI0OtPsyoh60xoSt4hNrjR58hMyBkV02w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2040956955=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2040956955==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB547376F1D510AA412933FE48A22D9CO6PR12MB5473namp_"

--_000_CO6PR12MB547376F1D510AA412933FE48A22D9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


Hi Lijo,


+                                                             pstate_table-=
>gfxclk_pstate.curr.min =3D min_clk;

+                                                             pstate_table-=
>gfxclk_pstate.curr.max =3D max;


min_clk and max,

it seems it is coding error, is right?


Best Regards,

Kevin

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, May 17, 2021 4:39 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@=
amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Feng, Kenneth <Kenneth.Feng@a=
md.com>
Subject: [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencies on al=
debaran


[AMD Public Use]


v1: Use the current and custom pstate frequencies to track the current and

user-set min/max values in manual and determinism mode. Previously, only

actual_* value was used to track the currrent and user requested value.

The value will get reassigned whenever user requests a new value with

pp_od_clk_voltage node. Hence it will show incorrect values when user

requests an invalid value or tries a partial request without committing

the values. Separating out to custom and current variable fixes such

issues.



v2: Remove redundant if-else check



Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>

---

.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 65 ++++++++++++-------

.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  6 ++

2 files changed, 46 insertions(+), 25 deletions(-)



diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

index 5d04a1dfdfd8..d27ed2954705 100644

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c

@@ -78,8 +78,6 @@

 #define smnPCIE_ESM_CTRL                                     0x111003D0

-#define CLOCK_VALID (1 << 31)

-

static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_=
COUNT] =3D {

               MSG_MAP(TestMessage,                                        =
          PPSMC_MSG_TestMessage,                                  0),

               MSG_MAP(GetSmuVersion,                                      =
       PPSMC_MSG_GetSmuVersion,                                            =
 1),

@@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct sm=
u_context *smu)

                pstate_table->gfxclk_pstate.min =3D gfx_table->min;

               pstate_table->gfxclk_pstate.peak =3D gfx_table->max;

+             pstate_table->gfxclk_pstate.curr.min =3D gfx_table->min;

+             pstate_table->gfxclk_pstate.curr.max =3D gfx_table->max;

                pstate_table->uclk_pstate.min =3D mem_table->min;

               pstate_table->uclk_pstate.peak =3D mem_table->max;

+             pstate_table->uclk_pstate.curr.min =3D mem_table->min;

+             pstate_table->uclk_pstate.curr.max =3D mem_table->max;

                pstate_table->socclk_pstate.min =3D soc_table->min;

               pstate_table->socclk_pstate.peak =3D soc_table->max;

+             pstate_table->socclk_pstate.curr.min =3D soc_table->min;

+             pstate_table->socclk_pstate.curr.max =3D soc_table->max;

                if (gfx_table->count > ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &&

                   mem_table->count > ALDEBARAN_UMD_PSTATE_MCLK_LEVEL &&

@@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct smu_contex=
t *smu,

{

               int i, now, size =3D 0;

               int ret =3D 0;

+             struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_ta=
ble;

               struct pp_clock_levels_with_latency clocks;

               struct smu_13_0_dpm_table *single_dpm_table;

               struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;

@@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct smu_conte=
xt *smu,

                                display_levels =3D clocks.num_levels;

-                              min_clk =3D smu->gfx_actual_hard_min_freq & =
CLOCK_VALID ?

-                                                                smu->gfx_a=
ctual_hard_min_freq & ~CLOCK_VALID :

-                                                                single_dpm=
_table->dpm_levels[0].value;

-                              max_clk =3D smu->gfx_actual_soft_max_freq & =
CLOCK_VALID ?

-                                                                smu->gfx_a=
ctual_soft_max_freq & ~CLOCK_VALID :

-                                                                single_dpm=
_table->dpm_levels[1].value;

+                             min_clk =3D pstate_table->gfxclk_pstate.curr.=
min;

+                             max_clk =3D pstate_table->gfxclk_pstate.curr.=
max;

                                freq_values[0] =3D min_clk;

                               freq_values[1] =3D max_clk;

@@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct smu=
_context *smu,

                                               && (level !=3D AMD_DPM_FORCE=
D_LEVEL_PERF_DETERMINISM))

                               smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDet=
erminism, NULL);

-              /* Reset user min/max gfx clock */

-              smu->gfx_actual_hard_min_freq =3D 0;

-              smu->gfx_actual_soft_max_freq =3D 0;

                switch (level) {

@@ -1163,6 +1161,7 @@ static int aldebaran_set_soft_freq_limited_range(stru=
ct smu_context *smu,

{

               struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);

               struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_co=
ntext;

+             struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_ta=
ble;

               struct amdgpu_device *adev =3D smu->adev;

               uint32_t min_clk;

               uint32_t max_clk;

@@ -1176,14 +1175,20 @@ static int aldebaran_set_soft_freq_limited_range(st=
ruct smu_context *smu,

                               return -EINVAL;

                if (smu_dpm->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) =
{

-                              min_clk =3D max(min, dpm_context->dpm_tables=
.gfx_table.min);

-                              max_clk =3D min(max, dpm_context->dpm_tables=
.gfx_table.max);

-                              ret =3D smu_v13_0_set_soft_freq_limited_rang=
e(smu, SMU_GFXCLK,

-                                                                          =
                                        min_clk, max_clk);

+                             if (min >=3D max) {

+                                             dev_err(smu->adev->dev,

+                                                             "Minimum GFX =
clk should be less than the maximum allowed clock\n");

+                                             return -EINVAL;

+                             }

+                             if ((min =3D=3D pstate_table->gfxclk_pstate.c=
urr.min) &&

+                                 (max =3D=3D pstate_table->gfxclk_pstate.c=
urr.max))

+                                             return 0;

+                             ret =3D smu_v13_0_set_soft_freq_limited_range=
(smu, SMU_GFXCLK,

+                                                                          =
                                       min, max);

                               if (!ret) {

-                                              smu->gfx_actual_hard_min_fre=
q =3D min_clk | CLOCK_VALID;

-                                              smu->gfx_actual_soft_max_fre=
q =3D max_clk | CLOCK_VALID;

+                                             pstate_table->gfxclk_pstate.c=
urr.min =3D min;

+                                             pstate_table->gfxclk_pstate.c=
urr.max =3D max;

                               }

                               return ret;

               }

@@ -1209,10 +1214,8 @@ static int aldebaran_set_soft_freq_limited_range(str=
uct smu_context *smu,

                                                               dev_err(adev=
->dev,

                                                                           =
                    "Failed to enable determinism at GFX clock %d MHz\n", m=
ax);

                                               } else {

-                                                              smu->gfx_act=
ual_hard_min_freq =3D

-                                                                          =
    min_clk | CLOCK_VALID;

-                                                              smu->gfx_act=
ual_soft_max_freq =3D

-                                                                          =
    max | CLOCK_VALID;

+                                                             pstate_table-=
>gfxclk_pstate.curr.min =3D min_clk;

+                                                             pstate_table-=
>gfxclk_pstate.curr.max =3D max;

                                               }

                               }

               }

@@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_

{

               struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);

               struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_co=
ntext;

+             struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_ta=
ble;

               uint32_t min_clk;

               uint32_t max_clk;

               int ret =3D 0;

@@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct smu_=
context *smu, enum PP_OD_DPM_

                                               if (input[1] < dpm_context->=
dpm_tables.gfx_table.min) {

                                                               dev_warn(smu=
->adev->dev, "Minimum GFX clk (%ld) MHz specified is less than the minimum =
allowed (%d) MHz\n",

                                                                           =
    input[1], dpm_context->dpm_tables.gfx_table.min);

+                                                             pstate_table-=
>gfxclk_pstate.custom.min =3D

+                                                                          =
   pstate_table->gfxclk_pstate.curr.min;

                                                               return -EINV=
AL;

                                               }

-                                              smu->gfx_actual_hard_min_fre=
q =3D input[1];

+                                             pstate_table->gfxclk_pstate.c=
ustom.min =3D input[1];

                               } else if (input[0] =3D=3D 1) {

                                               if (input[1] > dpm_context->=
dpm_tables.gfx_table.max) {

                                                               dev_warn(smu=
->adev->dev, "Maximum GFX clk (%ld) MHz specified is greater than the maxim=
um allowed (%d) MHz\n",

                                                                           =
    input[1], dpm_context->dpm_tables.gfx_table.max);

+                                                             pstate_table-=
>gfxclk_pstate.custom.max =3D

+                                                                          =
   pstate_table->gfxclk_pstate.curr.max;

                                                               return -EINV=
AL;

                                               }

-                                              smu->gfx_actual_soft_max_fre=
q =3D input[1];

+                                             pstate_table->gfxclk_pstate.c=
ustom.max =3D input[1];

                               } else {

                                               return -EINVAL;

                               }

@@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct smu_c=
ontext *smu, enum PP_OD_DPM_

                                               dev_err(smu->adev->dev, "Inp=
ut parameter number not correct\n");

                                               return -EINVAL;

                               } else {

-                                              min_clk =3D smu->gfx_actual_=
hard_min_freq;

-                                              max_clk =3D smu->gfx_actual_=
soft_max_freq;

+                                             if (!pstate_table->gfxclk_pst=
ate.custom.min)

+                                                             pstate_table-=
>gfxclk_pstate.custom.min =3D

+                                                                          =
   pstate_table->gfxclk_pstate.curr.min;

+                                             if (!pstate_table->gfxclk_pst=
ate.custom.max)

+                                                             pstate_table-=
>gfxclk_pstate.custom.max =3D

+                                                                          =
   pstate_table->gfxclk_pstate.curr.max;

+                                             min_clk =3D pstate_table->gfx=
clk_pstate.custom.min;

+                                             max_clk =3D pstate_table->gfx=
clk_pstate.custom.max;

+

                                               return aldebaran_set_soft_fr=
eq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);

                               }

                               break;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c

index 0864083e7435..6b3374432e1d 100644

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c

+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c

@@ -1626,6 +1626,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,

                                                                           =
                                        sclk_max);

                               if (ret)

                                               return ret;

+                             pstate_table->gfxclk_pstate.curr.min =3D sclk=
_min;

+                             pstate_table->gfxclk_pstate.curr.max =3D sclk=
_max;

               }

                if (mclk_min && mclk_max) {

@@ -1635,6 +1637,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,

                                                                           =
                                        mclk_max);

                               if (ret)

                                               return ret;

+                             pstate_table->uclk_pstate.curr.min =3D mclk_m=
in;

+                             pstate_table->uclk_pstate.curr.max =3D mclk_m=
ax;

               }

                if (socclk_min && socclk_max) {

@@ -1644,6 +1648,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,

                                                                           =
                                        socclk_max);

                               if (ret)

                                               return ret;

+                             pstate_table->socclk_pstate.curr.min =3D socc=
lk_min;

+                             pstate_table->socclk_pstate.curr.max =3D socc=
lk_max;

               }

                return ret;

--

2.17.1



--_000_CO6PR12MB547376F1D510AA412933FE48A22D9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
Hi Lijo,</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
<br>
</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.curr.min =3D min_clk;</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.curr.max =3D max;</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
<br>
</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
min_clk and max,</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
it seems it is coding error, is right?</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
<br>
</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
Best Regards,</p>
<p class=3D"x_MsoNormal" style=3D"background-color:rgb(255, 255, 255);margi=
n:0in;font-size:11pt;font-family:Calibri, sans-serif">
Kevin</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, May 17, 2021 4:39 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Kevin(Yang) =
&lt;Kevin1.Wang@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Feng=
, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 2/3] drm/amd/pm: Fix showing incorrect frequencie=
s on aldebaran</font>
<div>&nbsp;</div>
</div>
<div lang=3D"EN-US" style=3D"word-wrap:break-word">
<p class=3D"x_msipheader251902e5" align=3D"Left" style=3D"margin:0"><span s=
tyle=3D"font-size:10.0pt; font-family:Arial; color:#317100">[AMD Public Use=
]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
v1: Use the current and custom pstate frequencies to track the current and<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
user-set min/max values in manual and determinism mode. Previously, only</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
actual_* value was used to track the currrent and user requested value.</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
The value will get reassigned whenever user requests a new value with</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
pp_od_clk_voltage node. Hence it will show incorrect values when user</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
requests an invalid value or tries a partial request without committing</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
the values. Separating out to custom and current variable fixes such</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
issues.</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
v2: Remove redundant if-else check</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@=
amd.com</a></p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
---</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; | 65 +++++++++=
+++-------</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
2 files changed, 46 insertions(+), 25 deletions(-)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
index 5d04a1dfdfd8..d27ed2954705 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -78,8 +78,6 @@</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;#define smnPCIE_ESM_CTRL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x111003D0</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-#define CLOCK_VALID (1 &lt;&lt; 31)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
static const struct cmn2asic_msg_mapping aldebaran_message_map[SMU_MSG_MAX_=
COUNT] =3D {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; MSG_MAP(TestMessage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp;&nbsp; PPSMC_MSG_TestMessage,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0),</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; MSG_MAP(GetSmuVersion,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MS=
G_GetSmuVersion,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1),</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct sm=
u_context *smu)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.min =3D gfx_table-&gt;min;</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pstate_table-&gt;gfxclk_pstate.peak =3D gfx_table-&gt;max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;gfxclk_pstate.curr.min =3D gfx_table-&gt;min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;gfxclk_pstate.curr.max =3D gfx_table-&gt;max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.min =3D mem_table-&gt;min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pstate_table-&gt;uclk_pstate.peak =3D mem_table-&gt;max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;uclk_pstate.curr.min =3D mem_table-&gt;min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;uclk_pstate.curr.max =3D mem_table-&gt;max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.min =3D soc_table-&gt;min;</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; pstate_table-&gt;socclk_pstate.peak =3D soc_table-&gt;max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;socclk_pstate.curr.min =3D soc_table-&gt;min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
state_table-&gt;socclk_pstate.curr.max =3D soc_table-&gt;max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gfx_table-&gt;count &gt; ALDEBARAN_UMD_PSTATE_GFXCLK_LE=
VEL &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;mem_table-&gt;count &gt; ALDEBARAN_UMD_PS=
TATE_MCLK_LEVEL &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct smu_contex=
t *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
{</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; int i, now, size =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; int ret =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu_umd_pstate_table *pstate_table =3D &amp;smu-&gt;pstate_table;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct pp_clock_levels_with_latency clocks;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_13_0_dpm_table *single_dpm_table;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;smu-&gt;smu_dpm;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct smu_conte=
xt *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; display_levels =3D clocks.num_levels;<=
/p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D smu-&gt;gfx_actual_hard_min_freq &amp=
; CLOCK_VALID ?</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
smu-&gt;gfx_actual_hard_min_freq &amp; ~CLOCK_VALID :</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
single_dpm_table-&gt;dpm_levels[0].value;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D smu-&gt;gfx_actual_soft_max_freq &amp=
; CLOCK_VALID ?</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
smu-&gt;gfx_actual_soft_max_freq &amp; ~CLOCK_VALID :</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; =
single_dpm_table-&gt;dpm_levels[1].value;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; min_clk =3D pstate_table-&gt;gfxclk_pstate.curr.min;</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; max_clk =3D pstate_table-&gt;gfxclk_pstate.curr.max;</p=
>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[0] =3D min_clk;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D max_clk;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct smu=
_context *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; (level !=3D =
AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDet=
erminism, NULL);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* Reset user min/max gfx clock */</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu-&gt;gfx_actual_hard_min_freq =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu-&gt;gfx_actual_soft_max_freq =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; switch (level) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1163,6 +1161,7 @@ static int aldebaran_set_soft_freq_limited_range(stru=
ct smu_context *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
{</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;(smu-&gt;smu_dpm);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_13_0_dpm_context *dpm_context =3D smu_dpm-&gt;dpm_cont=
ext;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu_umd_pstate_table *pstate_table =3D &amp;smu-&gt;pstate_table;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t min_clk;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t max_clk;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1176,14 +1175,20 @@ static int aldebaran_set_soft_freq_limited_range(st=
ruct smu_context *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (smu_dpm-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUA=
L) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D max(min, dpm_context-&gt;dpm_tables.g=
fx_table.min);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D min(max, dpm_context-&gt;dpm_tables.g=
fx_table.max);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_set_soft_freq_limited_range(smu=
, SMU_GFXCLK,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
min_clk, max_clk);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (min &gt;=3D max) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Minimum=
 GFX clk should be less than the maximum allowed clock\n&quot;);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if ((min =3D=3D pstate_table-&gt;gfxclk_pstate.curr.min=
) &amp;&amp;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (max =3D=3D pstate_table-&gt;gfxclk_=
pstate.curr.max))</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_=
GFXCLK,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; min, m=
ax);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_=
freq =3D min_clk | CLOCK_VALID;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_=
freq =3D max_clk | CLOCK_VALID;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.cur=
r.min =3D min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.cur=
r.max =3D max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1209,10 +1214,8 @@ static int aldebaran_set_soft_freq_limited_range(str=
uct smu_context *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_err(adev-&gt;dev,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to enable determinism =
at GFX clock %d MHz\n&quot;, max);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt=
;gfx_actual_hard_min_freq =3D</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; min_clk | CLOCK_VALID;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt=
;gfx_actual_soft_max_freq =3D</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; max | CLOCK_VALID;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.curr.min =3D min_clk;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.curr.max =3D max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
{</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_dpm_context *smu_dpm =3D &amp;(smu-&gt;smu_dpm);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct smu_13_0_dpm_context *dpm_context =3D smu_dpm-&gt;dpm_cont=
ext;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu_umd_pstate_table *pstate_table =3D &amp;smu-&gt;pstate_table;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t min_clk;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t max_clk;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; int ret =3D 0;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct smu_=
context *smu, enum PP_OD_DPM_</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input[1] &lt; dpm_c=
ontext-&gt;dpm_tables.gfx_table.min) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_warn(smu-&gt;adev-&gt;dev, &quot;Minimum GFX clk (%ld) MHz specified is l=
ess than the minimum allowed (%d) MHz\n&quot;,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; input[1], dpm_context-&gt;dpm_tables.gfx_table.min);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.custom.min =3D</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EINVAL;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_hard_min_=
freq =3D input[1];</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.cus=
tom.min =3D input[1];</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (input[0] =3D=3D 1) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input[1] &gt; dpm_c=
ontext-&gt;dpm_tables.gfx_table.max) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; de=
v_warn(smu-&gt;adev-&gt;dev, &quot;Maximum GFX clk (%ld) MHz specified is g=
reater than the maximum allowed (%d) MHz\n&quot;,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; input[1], dpm_context-&gt;dpm_tables.gfx_table.max);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.custom.max =3D</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EINVAL;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;gfx_actual_soft_max_=
freq =3D input[1];</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.cus=
tom.max =3D input[1];</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct smu_c=
ontext *smu, enum PP_OD_DPM_</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&g=
t;dev, &quot;Input parameter number not correct\n&quot;);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D smu-&gt;gfx_actu=
al_hard_min_freq;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D smu-&gt;gfx_actu=
al_soft_max_freq;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate_table-&gt;gfxclk_pstat=
e.custom.min)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.custom.min =3D</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate_table-&gt;gfxclk_pstat=
e.custom.max)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-=
&gt;gfxclk_pstate.custom.max =3D</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_clk =3D pstate_table-&gt;gfxcl=
k_pstate.custom.min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_clk =3D pstate_table-&gt;gfxcl=
k_pstate.custom.max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aldebaran_set_so=
ft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
index 0864083e7435..6b3374432e1d 100644</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1626,6 +1626,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;sclk_max);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.min =3D sclk_min;</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.curr.max =3D sclk_max;</=
p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (mclk_min &amp;&amp; mclk_max) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1635,6 +1637,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;mclk_max);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.curr.min =3D mclk_min;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;uclk_pstate.curr.max =3D mclk_max;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (socclk_min &amp;&amp; socclk_max) {</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
@@ -1644,6 +1648,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp;&nbsp;socclk_max);</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.curr.min =3D socclk_min;=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_pstate.curr.max =3D socclk_max;=
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
-- </p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
2.17.1</p>
<p class=3D"x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-family=
: Calibri, sans-serif;">
&nbsp;</p>
</div>
</div>
</div>
</body>
</html>

--_000_CO6PR12MB547376F1D510AA412933FE48A22D9CO6PR12MB5473namp_--

--===============2040956955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2040956955==--
