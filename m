Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D0BC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 15:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35C1112FC0;
	Wed,  6 Jul 2022 15:33:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5779E112FA1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 15:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsqEIV1G8C8bnp9qaWd4W5F6LqE0fYTuejf5Gp7yiFy15910fa9q3NXyt/by5HDTW2YXAM9Q4d8YQwP/RGz5E1od43nSq5xAV7rPxVhYeIqQ5L5mv3T/Grr4/qar0KhD3hqyBBnqbPsq9cj0j9/DYLk794jiI3D4kfSMdqaf89XvFJhrDdxRojnoIixkAULx0AL53VdaGeKxvgOSORaOAPn7zWOCzRDoCVajznKGqfGrsSPgSUXmnhl2W8TwzReWETtACYqhXUzsr5Y0DteCvo0e9zvlrJMknmIm3Q1dXhHhaU0qz4iF0uVG/VNmgpcAy5r8nDQenjOGiuMe2Vy5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=calejrBABgB7fBfIJl7DnzIwb4MuKkgv2eD1EU+wELU=;
 b=aM4Mf7mYPmCCOWGIvv/0WlDKFkjr30+yLaraGi75Yn1UqR4ZuA1CMgnvqA9LH5mO1HSYN/+h1WzvxPgjjarCgDzzM72xkgHqBurAdnNilW8CKb7//x8jTAydbBVo7HafrAt0RKiomS/TYgxSlepwKsImvJD0wC5KWfCHLAgdCcS/yQj3cC6E4PEDLDcjLeC98lZoKGE4lWWwx97e/7QZPPwgHBLcNVby0R2wJBiBFEuHdrhKybnWjlUj+T2dIuHurBWiguU3kzMc/x8CQUKbGb+pJZ1DGoIMN+ybHtuy+mMvVh1hi8Vq6Ki1qstzGVXzl41/RbnLH3KBjt/KgdV7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=calejrBABgB7fBfIJl7DnzIwb4MuKkgv2eD1EU+wELU=;
 b=4HUbR1YbH5t6EJyqdnoICWO/VO5IufXGH7/6hSKJNYd6oZTYxwCp/W8MzZkYaCH08SlZeuK+kutN2rgguVdk5kE3XzSSAGzR0GwVoCoi8tSCyybm9GhTpZBVTZWaE2ytphQGgWg7/zwBiQ3t96Lz6an4UBYgaKAXZAeUAy2H3wU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BYAPR12MB3334.namprd12.prod.outlook.com (2603:10b6:a03:df::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 15:33:45 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 15:33:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: remove stale debug setting
Thread-Topic: [PATCH] drm/amd/display: remove stale debug setting
Thread-Index: AQHYkUyYGWFblzuCdEiEhoq1EkbqXa1xeOHb
Date: Wed, 6 Jul 2022 15:33:45 +0000
Message-ID: <BL1PR12MB51448A9C36B520C9C17F52DEF7809@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220706152507.1075669-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220706152507.1075669-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-06T15:33:44.679Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd740d36-4cc2-4aec-e33a-08da5f64e9dc
x-ms-traffictypediagnostic: BYAPR12MB3334:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcWD2kzD/n+VUHpxX35sUQ3CDUQSmLs/XiRJgfBq8Hp3Sx1GVbaKKmErEvxWtpwOT9TobVLR4HJQuKbhTuI5KvOkPoyGq85z54vIUHqUbsf48BFtW0Gjy8/ivSzo+TPTc7I2HeeBdqStet69gI288TTWB08PyGcUJkH2VC/PXvR8d/uoFWeKxKciMIQ02QFWQ7UNspiIIdP5g7fq1MI0QxW694/YMqQPj6ymwwU+EUn0l9wznr1YZhd+nJiXpkfvRU6x0h06+ZnbvqUq3CNnjrxFPncAIEXaU44Z6bejbwq4FfzFV/us5r8bJkamhElROqGuX6OdpCbCwgYcsR8lAY/Nun+u2AkApU66Ng59R0zIEYAdoRe4KIJd8EXt6HxoIOxF4ne/7REVpduOkviHSNUyf6UzkHvtzEWXjNnTC7qKV3sIv/qZ9igCd2oQnzZgKbDFnysruJ5BsxwEoIdvWsD2G1Jon6P38wZZ6Ap4CbYbtsVxD7AUxGs2/qtl9D39L6NvKOHBqOYCcSS3CNqSQ2qgNChuPQiITzLTmcOV7KBhHlHttipT1hOPWISURs5mpw6FSYbKUnpF8aEnqNW/bRq/kDiiA+pN9YoX698KZ7f/tWbjj6lMaitmWCZU5XlHxxB3GuHtbVanvB3T3F5qOWDU9ATbiRCXmNnL1zV9Hk0spbaawRpaqtj+2M1+QEgleiIQQfBNNy5eh/2GLY7Wg0eKYiG1t/4wtKX0HSo9lNeCRaBsQs0EcIAign/8hk+Ybj6AJAVJtG9MEbLcKpyya40OqRh6RP4iw0KTnvd6d3Lh65XD4+yW1gy8JW8E3jgM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(52536014)(478600001)(53546011)(5660300002)(8936002)(33656002)(7696005)(6506007)(9686003)(86362001)(41300700001)(2906002)(26005)(38100700002)(122000001)(186003)(38070700005)(55016003)(64756008)(83380400001)(71200400001)(66946007)(76116006)(66556008)(66476007)(110136005)(66446008)(19627405001)(54906003)(316002)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MtUqxzobnWWNF8Ex1zX5mwKNdn6coDjBN4sWBv/vbzqtpPjakRHh11xu1MlR?=
 =?us-ascii?Q?UteY3YBz8u6THyF0+2n3XyOdLBZwAUNDdv1yzwWSC0rjVok/4XortANaRf8+?=
 =?us-ascii?Q?KQui/ltmJYjPwRpLuK6Phaunmv4uOreQtxteTmb3+cniCp0Td9cZngspoTRP?=
 =?us-ascii?Q?sgrmC4GJNLcL58PKXwaFF1ynrcMdRrkh3gfFhHd1mirbBhNo6BBrGl4S1rbK?=
 =?us-ascii?Q?U/1z9HcJuDRu0ICv2K1IToIxti1KcVkX1zDFpQ1hFDUP2gPhMGsZOi4M5HMq?=
 =?us-ascii?Q?WWWG7KViiohVKPjUXNu1/FUTVjnlbJ2WC046elK6p8tALd751pZVh8sowTZj?=
 =?us-ascii?Q?8FLdSYOmk9mkyHdj+D76LTJmCL1gR5Ck8j/3F1q0I0RWo72UV/oPBXixozBU?=
 =?us-ascii?Q?1WYJ5JXDYPxA29b+cRXq+Q9JwGqFBSrhCxQaYdB3fjEqSRBcaPeMMpahEl5d?=
 =?us-ascii?Q?409ZrRsbKwl0/Y88C2qfzF6w88f+TbAVRmH1YTulYar0KXMTuRt2D6JAa3z6?=
 =?us-ascii?Q?seQa+yY9vLMeJ2wZdcb6N08VH73JKhkRj8BffjBpUY8Toa+D21tzmUfCvyTI?=
 =?us-ascii?Q?UkubDHXI3oN6CjIdWYXJgAK8xzlTgEmni+ZR5FGgvNkUaY0rdf955a4iquDZ?=
 =?us-ascii?Q?uGm6MzDohQfnXHRlA6uXU3jPJrSdswjUxWwPKBx4+SrW2GBdmIWDvsI67E2+?=
 =?us-ascii?Q?T6iBsKCsTuBQrmdF4V9/H5AneHZQaw9RbakKdoJmGe208NPJGyGkt4aQ2QmT?=
 =?us-ascii?Q?uiIEnrhPAL3Jv5s/jIl0K18yhXwTWoCUDIg/3mU8y23d1PWwm7y4CrS0vVGS?=
 =?us-ascii?Q?uZzKiJoCOYkwpYAI2UGqK+OheAaS6hExvw6S6DzZVmAMxoaqGPPesrNoQPVJ?=
 =?us-ascii?Q?bm9kAVdvoandhwiSwCAEKhw4p40MzsA2TA19km1ChwVqpowJ1TfpCO3/b0Ri?=
 =?us-ascii?Q?5u6RBhiuUN+yOpfMiZUIK+DK3ZvVMyCW2eY0zOOtF17ILdWHJJ0+ahHxIa4X?=
 =?us-ascii?Q?L1bJFI6mfqzHnF+SpEVRnX4Q6bJfb2uT1vIyhwhoLenDWoBVutaEmV6MVs8W?=
 =?us-ascii?Q?Hr+VVjDu4q2WLjAIktgOIzEKuRfp0Q1MyivZE1gEM4FGUvejSI1agJJ7X8t6?=
 =?us-ascii?Q?IwIV13hkaUzZZAZBsjPLlQq+g0up5lU1zdBeqgAVwdHlz77ZOaCcBc7faXmr?=
 =?us-ascii?Q?ET0Hc/SqzwmJZA7qAW2wmb7aJLS1EV4+bC0kY5tZOPdb1VWeyVb/jl+Ov8GH?=
 =?us-ascii?Q?6J/CPuCOxXJCnNDwK+x758pFioeBBfnMur0utN1DRa9HuDS6wiZT+wuYpDxR?=
 =?us-ascii?Q?hgjXm1OjPl/MgLHUXORzQw1U0+16gQeSNM5uh8Wsz9QeE+siXjaPwdc6gFn5?=
 =?us-ascii?Q?dldDpSl6oBcfKWbXm0+SJ/LzrgR27ZwN67EDV8QUgDYqkWOX1+hMo6jbfk0F?=
 =?us-ascii?Q?hL8GXJPmr4njtvz8WKSuJUptgzNUJLXZSQY20sN6pHWev9voTrqQ/l9lTiqx?=
 =?us-ascii?Q?J48WV3mKssmbZraNWTxaPa8K1dUlDLfrYfLgAnWU3ULNktP/weksUltKLqYt?=
 =?us-ascii?Q?HJRKlbXnYtf1uGWkwfs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448A9C36B520C9C17F52DEF7809BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd740d36-4cc2-4aec-e33a-08da5f64e9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 15:33:45.0813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubdy1duRWLPbx5/RUot4SekCs5D91dQIJm1DThECzA9IYihiCv/NZLWAC9NV4E7Q2P91i2yUJEc1zbf22qTWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51448A9C36B520C9C17F52DEF7809BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aurabind=
o Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, July 6, 2022 11:25 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: remove stale debug setting

[Why&How]
The debug option to disable idle power optimization can be dropped

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/g=
pu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index baaeaaff23df..1cc1296aed9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -736,7 +736,6 @@ void dcn32_init_hw(struct dc *dc)
         int edp_num;
         uint32_t backlight =3D MAX_BACKLIGHT_LEVEL;

-       dc->debug.disable_idle_power_optimizations =3D true;
         if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
                 dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);

--
2.37.0


--_000_BL1PR12MB51448A9C36B520C9C17F52DEF7809BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aurabindo Pillai &lt;aurabind=
o.pillai@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 6, 2022 11:25 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aura=
bindo &lt;Aurabindo.Pillai@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@=
amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: remove stale debug setting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why&amp;How]<br>
The debug option to disable idle power optimization can be dropped<br>
<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/g=
pu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
index baaeaaff23df..1cc1296aed9c 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
@@ -736,7 +736,6 @@ void dcn32_init_hw(struct dc *dc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int edp_num;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t backlight =3D MAX=
_BACKLIGHT_LEVEL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;debug.disable_idle_power_optim=
izations =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;clk_mgr &amp;&a=
mp; dc-&gt;clk_mgr-&gt;funcs-&gt;init_clocks)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dc-&gt;clk_mgr-&gt;funcs-&gt;init_clocks(dc-&gt;clk_m=
gr);<br>
&nbsp;<br>
-- <br>
2.37.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448A9C36B520C9C17F52DEF7809BL1PR12MB5144namp_--
