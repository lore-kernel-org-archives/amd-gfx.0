Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C353C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 14:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCE3207EA
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 14:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v6QAD3ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCE3207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998F06E14D;
	Mon, 14 Sep 2020 14:50:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40EEF6E14D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 14:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3AMBmLIUX+wuCrPA5GRneYf05J1RIVdkPm5A/S2pn/RWKZrxiaE7SZXr/UKcuwob9ois9FOoIW+k6qBFL0pZCq2F7dn4jRGZEnXwJC9jhD9hbpu+has2FHQ1DAECgF8RQW0K0OTDVhxB/eSPbRTdfyfXW2RGyLGVpTWXf1zw82U+/XoVVpyjrK+sdZb1kSp2LgE4sQttoCappJTjXQRzDAi8UQgaecxrhQViwqzttkYP57yd119qLG72XaZVHD1a9KBOhh/AmWtIOQxsYvALeZQZ8QaeHvXEoavHiRnZ4wdDUTTw2CuXjgol2OkcO8LmGcnm1ClGyQaRK88uf0Xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeAjuF/+cxKXLU5U5MmQiCEHMnljYuXoLHw7jO8L4ls=;
 b=ZmVgQBbvcagDK9ofZ409gNpSjP5OKX+fi1CEteBkMVSUFOSOPxwYE7o1uHyVpCJxKrtSqPr8DbPzQN3jESEOVgFqNXZiuUQIz1IenCLunSlQLrkY/Bvd6Z0VOvfQdW/sDQR2Ln1M6aYKyzZqYhMZ/KbDbM/hGAmg9Gxti2sUqReQyH7zOlpffFQ2UKKxkVdKP0LFtJneXwzfdCaLNtUMgR9599dR6EBN9qx10q1bnOV61uBl3PYAs/+EHRPfCAAoxxRb5u4bxcB05+8LIOozasgl79WMRPPjZQogjG9oizfWOPuFv/oxcj7VqUH2KA/DV1u55q7cfSoVBsj5eQc5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeAjuF/+cxKXLU5U5MmQiCEHMnljYuXoLHw7jO8L4ls=;
 b=v6QAD3ssQIX/+cbeKByVgvZ4Y3wc/xU51BX9lwLtPYyrvAo5at9DkFGVo3zkhSuoipxCtlwR6Llse6CQxKJVLCxxlS3lJLH6cZ49kWahIpyAuuUR8crETcFB+LBopAvFK65VVTd9s+4SlJwS+PCp3yOJtrqkBpvUy8MlpsI70ys=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 14:50:08 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:50:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Include sienna_cichlid in USBC PD FW support.
Thread-Topic: [PATCH] drm/amdgpu: Include sienna_cichlid in USBC PD FW support.
Thread-Index: AQHWh50LkN0B2JC1CU+Du7OFiEvGX6loOG+AgAAE7/Y=
Date: Mon, 14 Sep 2020 14:50:08 +0000
Message-ID: <MN2PR12MB4488C07A8A358C791223A230F7230@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1599761153-13679-1-git-send-email-andrey.grodzovsky@amd.com>,
 <a968c176-ebd4-65d5-b27e-af4881342f6a@amd.com>
In-Reply-To: <a968c176-ebd4-65d5-b27e-af4881342f6a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-14T14:50:07.421Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ecf2e69-964f-4381-bff3-08d858bd7960
x-ms-traffictypediagnostic: BL0PR12MB2500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB25000994C87A6C93EB9B7D5BF7230@BL0PR12MB2500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DX1N1/tvqp/MUpiPBmEDT5M77qhhZP7xqdahQ6HJb6JsYDB47MaCUFzEswGC5gFgPG7T6YpoN5r+SYcz8sVcnyFoWCbnk3QUPxbHLtnhC1h37x6EL8xdMgkTOzFXNGrJ2pN1g6WhS3qU7gwgrIj1MHgm0LSiChZtxGrd5nvA0QQgAbjYwXF0RQgYiCQ7JO9BUDit9dwOqAmsUloxCQB9eSfNZlVYmPfVEG4Azt6GDp5LPq+gY8x3bgUz16n/2jidUutr8dMiREEnP14rlS97mcjmKJShYGBPAxMTat5GRjLGIuwrWrELiGWx/d8h0urLoPeUKPMP6Y9TkIQVqHoi7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(8936002)(52536014)(71200400001)(55016002)(76116006)(2906002)(110136005)(9686003)(33656002)(26005)(186003)(86362001)(6506007)(478600001)(83380400001)(53546011)(66476007)(316002)(19627405001)(7696005)(66446008)(64756008)(8676002)(66556008)(66946007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HZXpw4Mk2Rze96YzJpMpsddnTHnGpL3++cYUKo3KEipKrhwWwLAn357kqOJkiWEvS+QhY18dRDHspfY67sXivyfNIdToz8BwNX0LWcNcP1e3N4AAlGumR8g85sf4832W/SXFXFysEYOmlxZxK6Q4XOy6Wr0y5+dunr3OXt2ostQIiuZFx7xTY+pdvaiYUZMq6X0de1bY5ZIyTDrbix47hvE/Xw+XwadcBFmqzOP+REYjznIZL3+L/w+Q5mMkCZuksaEvyM5RLtV+4gklCW+RtpZ7fGYoHy3KbFLmwh01nnLI3YfZjLudweIkPhMyXSK4ElnEiCAmILvTnVbI/InfbpFDwLrGwF7s7n1IQAQxPYLeI5p1KLY6b8RF+qWxG193MzTpCNO9jLnWVcVTyLYAQrJUZdlnHXM5bY84876RuHOEkJL6MAWd+Wonl8jZcfjKYknk07WMmDKgUpjntiYRMU5P9dCXgBTyHnMpmd6gDmVCD19lPPkyqbIGz0JYrFBJ5JmR5/jlZ2xwUyHE9nofVtpfDCCSB8//CCyqdzsgD/qqcyQNjcdOgDYssAvOspMIFfP/ePzJ8Mx6zvOi6BtHI88dYAJ/XJwVjma/jlPKTuGbLIPLl2f8wwfzp6oS/XI5hLeUuMHcnHTMx5pBYUJ60g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecf2e69-964f-4381-bff3-08d858bd7960
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 14:50:08.0774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFEGs4BNaPfiiKg/72ozIcuPAPej+vbf8s7hQf+JeZ5yLN/8JHpiU1xR74VeVyJXVsawr14D2kt6uGW0lsmDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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
Content-Type: multipart/mixed; boundary="===============1732418673=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1732418673==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488C07A8A358C791223A230F7230MN2PR12MB4488namp_"

--_000_MN2PR12MB4488C07A8A358C791223A230F7230MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Sent: Monday, September 14, 2020 10:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Include sienna_cichlid in USBC PD FW suppo=
rt.

Ping

Andrey

On 9/10/20 2:05 PM, Andrey Grodzovsky wrote:
> Create sysfs interface also for sienna_cichlid.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index a7771aa..600015e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -178,7 +178,7 @@ static int psp_sw_init(void *handle)
>                return ret;
>        }
>
> -     if (adev->asic_type =3D=3D CHIP_NAVI10) {
> +     if (adev->asic_type =3D=3D CHIP_NAVI10 || adev->asic_type =3D=3D CH=
IP_SIENNA_CICHLID) {
>                ret=3D psp_sysfs_init(adev);
>                if (ret) {
>                        return ret;

--_000_MN2PR12MB4488C07A8A358C791223A230F7230MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Grodzovsky, Andrey &l=
t;Andrey.Grodzovsky@amd.com&gt;<br>
<b>Sent:</b> Monday, September 14, 2020 10:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Include sienna_cichlid in USBC PD F=
W support.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping<br>
<br>
Andrey<br>
<br>
On 9/10/20 2:05 PM, Andrey Grodzovsky wrote:<br>
&gt; Create sysfs interface also for sienna_cichlid.<br>
&gt;<br>
&gt; Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.c<br>
&gt; index a7771aa..600015e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; @@ -178,7 +178,7 @@ static int psp_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NAVI10) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NAVI10 ||=
 adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret=3D psp_sysfs_init(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488C07A8A358C791223A230F7230MN2PR12MB4488namp_--

--===============1732418673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1732418673==--
