Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CA4C6FA82
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Sep 2022 02:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B262C10E27C;
	Sat, 10 Sep 2022 02:26:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC6210E27C
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Sep 2022 02:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVKREw/DWy6kJYqi3lEbPKn1wTkU2uEiK78/l6hWsa3L2s4z+QbDQU/EnT5tkOZD9ZATqdCnHEt7cH86nsBFEDlR6n5iekY7n2m0n9M5I0sda6wCyH3DKen2FuKOMzIlca02kJnxULYoNO03Ok4X8pfQ04neuDwh6gowa7pDoaX8M2GbgoZG3KfYvlGC6X1l88HX9aesjtmo0p6A9GSRbQRQ/0zaTl0KGyY001y+vg34dxPRTlqylfCXCvX6WooAT/YQNwAdOR23qgsULQpeXr4bzh9nooz01/AVSeALZrR/4gpzFCZ5JqtpOtgAiZmEQlDvb7pVzHTFvEjWQUbKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+x915ghp/49zPzFKRbFAsBBIZuKIjJfS66DZjZ7fHo=;
 b=bTYt/EDfVtEaCfsmpK/LnU39TI9AdNLWSEqlZjjBLk+ESDpLUhmperylYcYibz4wxkdFnjizpIMUbkJg982bt6onjD2klk6tECIL46LHbY0gTRsSsiWjZLHvgoDrcLYThDEmwQe4+u96SCCkk4GdxfIj93nOe5nNS2UEcQbxv+hf1zWGR5rgWpiVkq23AOkNy9ww9NNyZ422YdqDdC9cRWWLcaqY6XYpI387J8wPTC00BY2l6Ios3HT8ruhFOWcuaWJsvYTC1tU743+wOO4MtcePxF9UlQO3Eyx8z+QtuN8oo/sPvOMRuVCN/gmM9Oe4mWk7pe4Cl/wWsLNDsyF/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+x915ghp/49zPzFKRbFAsBBIZuKIjJfS66DZjZ7fHo=;
 b=Ky0Gt0EwKjMNS/5vtrNa46y4g8i9EbTqoC9deGjDBU73KLofKG8Du+GCW9ZSn63FCv+g9Ow3KOkt3uRLVD1SL+tHjx2kdFhYZDWgtaDW1Snh63vsrgILdPnuOzJMOouqzQIU01hljf0bN7DaeOmaMRhBmBnuJQe7mRw5oisGpU0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.15; Sat, 10 Sep 2022 02:26:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5612.021; Sat, 10 Sep 2022
 02:26:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Skip reset error status for psp v13_0_0
Thread-Topic: [PATCH] drm/amdgpu: Skip reset error status for psp v13_0_0
Thread-Index: AQHYxJ35GIZOIOrmFEaGQQqJyCVSyq3X8DJ+
Date: Sat, 10 Sep 2022 02:26:38 +0000
Message-ID: <BN9PR12MB52578E8A694C68D8770ED4F9FC429@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220909224551.5790-1-candice.li@amd.com>
In-Reply-To: <20220909224551.5790-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-10T02:26:21.3255799Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5820:EE_
x-ms-office365-filtering-correlation-id: cc2337b2-15d5-434e-f67d-08da92d3e3df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fC5wibDmgPLNWTWSgBPKWtTeajLZKimRW4le7GrlSehKXXPM/Wy4wk2FW/dF5Ti4ARnVU6gXJXu1azmwBsF/hN+KKVrrJTLK+fQyMQxkKSVQFYUhS+qfFgAfXYHQpJBtugGfcSC6Rs8kwoc/WMK2JXQB4x+QimH+XW0iqdQK7Oz8MmuvG68U5i8ysheHEUxBhylgZa5mEPndMceUCDgIrjdjrvlRhpq26JXtTeuZaNkkwKTaoIvDDxROkzOjA1a0DpLELe0U0yv4lcMcdf6IMERZ4w95DHwcHCLWcyfEmELnbKoVinFe2oKUzJP6YwPNJurRbvqERPtW9GRfXFRG9jbRLzPr0mzbzcy+CE3DOK+cxppFgZ0JaP1iAAc3wjfc1wAbLkvj6so4/cPMR9Hipm+GXTQTRQCOaCpZighhhWq/BRbv0/+HRXpPQxA7Eg0evfaeN0UoFQTBkIyqOz36A+CbweFRrNNMedkAfrt7ui+BLIVr3wFo85Rxka3IdyGkHxBsOIpXALqACa0jOAqjHKvkBVxUbHKD120e+jtgbGSva14H5k6EqkCYJqUtw7nUan7XG+ThuV0V604oAdus/dSI37rP5LH3JXdHtnGzQE4eTxOLSP+z+7XCe50UMyiqMM9JTK+42b7PHUYFEAPZKaLpvdQtxVh+vkeNSvTvR3WcB/vbqmpL/c3UlcVanYk6c/ilYdrNM8wiMVOdHcgzy3kEDECL+VSFM4fIsDHF7rofMZFrLJdwK2iHz/uk6W4/pYC/KkYFZVJyOKtng7kKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(316002)(122000001)(110136005)(38100700002)(83380400001)(33656002)(53546011)(26005)(6506007)(7696005)(9686003)(4326008)(66446008)(186003)(8676002)(38070700005)(64756008)(66556008)(5660300002)(55016003)(8936002)(478600001)(2906002)(41300700001)(71200400001)(52536014)(76116006)(91956017)(86362001)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M83oi9rt0rpKHSiBpKmx8bhEfo4sTkP3V01MD3Juh2epWvJfthzUBuzpuWc0?=
 =?us-ascii?Q?kNfQxvvTOmn/Gd5Rr2n4rYagIY9smk8fMD+zLtt3xD7GNL4wKCL5dDySGKdh?=
 =?us-ascii?Q?YhIqksJ1G883H6QSYLYE0b8Ai7grAeEFi/F7T88jsYMpUYRixZaBYBPZ8l4T?=
 =?us-ascii?Q?qVFsigv3MoV4IcYxKEafis3KBXeSJj5reQOBtMxxMfF8LoFPOkMtbAZU4U3k?=
 =?us-ascii?Q?hZZDBGZrQMgh+oGtCJg6dVMv2iGMz48Ux4BfjYPFYLHgGkA2GPeyAaVrKeDR?=
 =?us-ascii?Q?FZ3Xxc9vMxlKJZ7uzUTq2T4zwxpRvyyOIokNA4l2YoNSm4t87giHaMf4TT5w?=
 =?us-ascii?Q?eidPcw2vBGkHKDb25WbbuVC5tVRuYv+LLtm0L50sERSJDWGFu58MHuQjmyan?=
 =?us-ascii?Q?IgWz4h1GuliBAPTBXfNuKt6VhFE+kmrEa5lcQ+E0GX/L9RxXvA65aQyW3HK3?=
 =?us-ascii?Q?6ltWW/rNfU7VBboO1oj83mGMOtWRdhUifF1Tq5CF6DoH8KfhswRb64wWJQ3S?=
 =?us-ascii?Q?x5Riuze8NM6wf+YZZezTbC9ZEHf4VHi22jBrfO+V6sSw7dZGyC1oEa5ntUhO?=
 =?us-ascii?Q?HEZcTWo/v1n+oduzxgYI9RLzluqvr34073UiATYir7Xom5IO1PxNoFf4keaL?=
 =?us-ascii?Q?lAXL8XE/JwNbF4UkTlXO8DGbwPQ4IJStFWPQv7mvuyM+sgddMhOEF08n57rH?=
 =?us-ascii?Q?fYeNxyZTA4UO6hyKd0BRHzMiOI77AYxIHOHKUPhNRv/fm6e+Gl6dccVNSkiF?=
 =?us-ascii?Q?Hgq2mnKrdfPhbde3NzPIK9Exnd++WKOrYkOCram/t+hy1qRTmxbjjLyDdzFL?=
 =?us-ascii?Q?kLgZbawMzctJy6XuEDsiaql1qRg11S2xh8mBesj7yyew09sqIbt9nb1NrAPG?=
 =?us-ascii?Q?aCA+uTa/RJGJLsFO56b1SBtY7isT6wB/OwQOJ60WF9sAtN7QLrjIXdg7uqYb?=
 =?us-ascii?Q?OOEFhMyf02HKVpelhySznL+EiT4aqTZKtd2j/s+CGFaI0ciyRQQeFhJPOx3H?=
 =?us-ascii?Q?Yc7bF1gXAfRZkrhUqCBze+AqpUujcqbpFhyx3ci6Y6vcYCaA5Yf6WpS3pNKx?=
 =?us-ascii?Q?qmn0vltppX8tA6iRj2sXmWGj3vj+eSeGOf+teIdI2TZo8PC2ml1SetSZnPo5?=
 =?us-ascii?Q?RW/7M45P8IIU1afszVEGA1XpJHyt3wl5bCzvHZ/KU/Xy/uBhyvTaPyLyXFXQ?=
 =?us-ascii?Q?sjFsn4pUGsa6zgQAFNXb4hpguJ/5wj7sFp91deqDV2AglD/3IIzfCAlQcIdD?=
 =?us-ascii?Q?zJ2auOSjpt2KfAc3GcIHAGZT4HQXtd0qd/0+SImx0z95zRADOFnTI+kzsryU?=
 =?us-ascii?Q?NWl4GeCdbwZPPELJcmdg7KRjXAGnR+bRriy0GgzVw0KaBGlA8TUYb1kkpysD?=
 =?us-ascii?Q?i+2YswOcp6jaVv2araV8qgWCw87W+XLdJV8364LKyHzeK30ggRmokjw0ioZy?=
 =?us-ascii?Q?27Z0atEeJr/SWDd1Qj8gYrP4q1vya9yHtA318m6ZPJkKsqdmuQ3FGvDuPENk?=
 =?us-ascii?Q?xhIcRr86gIxh/z7H/A57888XB2mqTCz7W9ijdvLx/1/NgekIwEKhqfi7SBv2?=
 =?us-ascii?Q?0YxQegUik98sRaQwvOwVU9OlmUMmZyiFBMz4NbRI3emCxunOki5qa8pj28R5?=
 =?us-ascii?Q?Ag=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52578E8A694C68D8770ED4F9FC429BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2337b2-15d5-434e-f67d-08da92d3e3df
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2022 02:26:38.4581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRIascDTssdgX7Wi77jv0C4FJuPTeQHMMUbU21FFaws+ObPDxRr24Wuo8w8oScHsCIthM8O5zNaecWVNS91Fcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52578E8A694C68D8770ED4F9FC429BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <Candice.Li@amd.com>
Date: Saturday, September 10, 2022 at 06:46
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Skip reset error status for psp v13_0_0
No need to reset error status since only umc ras supported on psp v13_0_0.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ab9ba5a9c33dbe..e55f106621effd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1811,7 +1811,8 @@ static void amdgpu_ras_log_on_err_counter(struct amdg=
pu_device *adev)
                 amdgpu_ras_query_error_status(adev, &info);

                 if (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, =
2) &&
-                   adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4=
)) {
+                   adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4=
) &&
+                   adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(13, 0, 0=
)) {
                         if (amdgpu_ras_reset_error_status(adev, info.head.=
block))
                                 dev_warn(adev->dev, "Failed to reset error=
 counter and error status");
                 }
--
2.17.1

--_000_BN9PR12MB52578E8A694C68D8770ED4F9FC429BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;Candice.Li@a=
md.com&gt;<br>
<b>Date: </b>Saturday, September 10, 2022 at 06:46<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: Skip reset error status for psp v13_0_0=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">No need to reset error status since only umc ras supported on p=
sp v13_0_0.<br>
<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index ab9ba5a9c33dbe..e55f106621effd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -1811,7 +1811,8 @@ static void amdgpu_ras_log_on_err_counter(struct amdg=
pu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_query_error_status(adev, &amp;info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0] !=3D IP_VERSION=
(11, 0, 2) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[MP0_HWIP][0] !=3D I=
P_VERSION(11, 0, 4)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[MP0_HWIP][0] !=3D I=
P_VERSION(11, 0, 4) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[MP0_HWIP][0] !=3D I=
P_VERSION(13, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
mdgpu_ras_reset_error_status(adev, info.head.block))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Fai=
led to reset error counter and error status&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52578E8A694C68D8770ED4F9FC429BN9PR12MB5257namp_--
