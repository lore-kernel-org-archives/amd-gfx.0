Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A6EC3F2D2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 15:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849F82072D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 15:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IaxF/9uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849F82072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9DA6EBD5;
	Thu,  5 Mar 2020 15:59:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17716EBD5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 15:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iot61jJu1bnS+u0GcMfiy5ePKKVPVBvboQKY6iqYtxlru3st/m65ydcrs2fFdRvUHtp2C08qZxOrRJMpB6Fa45zqOU7QE1QoJXMyPwurhPJt11XG9X5tpRR7tAbIpnSYy7DTUaUWzg5a4ZEn7ICCTXfV6Pa8SuWczeFcx0RjjcTH73Qme5rVFkMhOOOmEK2aTCnc37aLLLvS2kzalyYSvozwAeVhocri0Nrnh/HUtnC+dFxoJIz7+BqCOsuMRK1hQMvnf7XN3sysEsCoje6rZFWTo1YpQRRsofXqdtMXOrYADyjEgwYpEcG7EpikTtLOjySdvrWyo3bDZ6uux8N/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba3fHoOMr8ID+xpab3ui+7xrNyE/cVZEwx/uTReR4OU=;
 b=DS0s6Hc24vW1ZKumvCyR9U7kH0MBHgTvXKV/7Or4p/UrEm7gI3HlAYgDY3cU+iR3K8f66kv7WMxPcJfsVPam/HnnReDGNKela3ni2u66mjrBwcZQF8GR1SyAc7CwI1II9aZkA1e9kT6vo+gGzaemKDLabjxAaQEqOZRstARU65dA0bl66UHltQcgKDbPLDaIxKkt/ymYylGNXLM2VqRoRy9q5nefS4/CrhFcnDi/phomcHGpIOG0Kcx2JOE6hKGH/a4h8euXSAcGeY9hVDO7oFC01ecwqU1AsmYij0wxT4SCNN1mTUjAj/kHvG9vNmgGYoatHuDTkThKMQtRcVi+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba3fHoOMr8ID+xpab3ui+7xrNyE/cVZEwx/uTReR4OU=;
 b=IaxF/9uOcF42idMzbDzzEHLPFyHW/hZdWeXjCyznvJdHA/sSpHOvjcemZEetferB6PnlTaW7J0ZLfr4WLpvuQx+RIiFVIeU8fVQFQ0Ziot/X7qNhewyv+nol2EypCi/iCUSEE9Nh+PHqI0wSrDJQnMxbazph3F6OC9cUvV1jUtQ=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB3686.namprd12.prod.outlook.com (2603:10b6:610:23::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 15:59:55 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 15:59:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Thread-Index: AQHV7Bq120pU6wWbDkek+BJvZfNOZKg5hAkAgAAAY4CAALGFBA==
Date: Thu, 5 Mar 2020 15:59:55 +0000
Message-ID: <CH2PR12MB39124A0D056AFD1C8534C92EF7E20@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200225203224.1129396-1-alexander.deucher@amd.com>
 <CADnq5_MGixxj8tdOhb7Tg1hNEGGd7Ue0bgCEtKOYaD7n-u0K8A@mail.gmail.com>,
 <CH2PR12MB3767A6BF43D694CD494E0B58FEE20@CH2PR12MB3767.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3767A6BF43D694CD494E0B58FEE20@CH2PR12MB3767.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-05T15:59:54.607Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0556b292-bcf1-479a-fc50-08d7c11e3f6c
x-ms-traffictypediagnostic: CH2PR12MB3686:|CH2PR12MB3686:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3686918D5662CFDC43AB7B9EF7E20@CH2PR12MB3686.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(71200400001)(26005)(316002)(33656002)(186003)(52536014)(5660300002)(86362001)(55016002)(64756008)(81156014)(4326008)(66446008)(19627405001)(2906002)(81166006)(66946007)(8676002)(7696005)(110136005)(9686003)(6506007)(45080400002)(76116006)(478600001)(966005)(66556008)(8936002)(53546011)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3686;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YUgeuFi922uGwRIyRXTlpNbuGoAproadJxsRfgcOFR8cItTycWDuUZX/z822kxvVuv4sJh7+elFNhNRxygLpaiFJOcSo1XNV4jUbrlbgY4KaWoH9CdXfmlybGK41KSO11EQf9M8c1/5M+1zjoC/21keAm7q8d7TOE+Zms8pDNOtji88+HsMWWWn20l9X/hki6LOUB1/xVQmNTcOboBQ3RKcEztOjqqbP3pBWILoaZ59+Jk4qPw0IFF+MC1KvUAHtzf5PZECsB8/sh77qH7t94Kty69cbkiyYxmOLFN8Hpmrb5VwY5+LvhREvE2cahX1R9AzyYbMo4Sp4xXsKkWK8KMPToFl8BBx81kIpbVWBiz+II4ugx1VnBbWJwkNa1MfrtSiaJq4aM9v6OM0ozggyXfrStcqmVgSkwr79axgYTF6Ey+pYDzh7BB/UgcajTpaAnUVQ2tmgg6yqdZDpNUnyhgrp6T6t6pru5BeKfOYCdeU=
x-ms-exchange-antispam-messagedata: ue5Y/UcrKLg43XigEQHy/7yaEU183lSQTVIROdvS+WKFO5vcRwntPgqBVNyzND7E5yyoI5x+OfE+d4yllpR7Vj2YLP65m2a/KadVP40Xx/q6KjviR7mTQJgIZz07B3lpOG17BGdoUhxLE570PjOPrA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0556b292-bcf1-479a-fc50-08d7c11e3f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 15:59:55.2661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwYfdNtIVc5g3qs4pH0V8ByucNAYfPuv51Xr4s+9vqw6Lk/FlpVZhKYQuby3VqDGRXjY3RLtfFwCC1ObeMrSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3686
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
Cc: "Tawfik, Aly" <Aly.Tawfik@amd.com>
Content-Type: multipart/mixed; boundary="===============1947289388=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1947289388==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB39124A0D056AFD1C8534C92EF7E20CH2PR12MB3912namp_"

--_000_CH2PR12MB39124A0D056AFD1C8534C92EF7E20CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Is this for the series, or just this patch?  Thanks!

Alex
________________________________
From: Xu, Feifei <Feifei.Xu@amd.com>
Sent: Thursday, March 5, 2020 12:24 AM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-gfx@lists.freed=
esktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tawfik, Aly <Aly.Tawfik=
@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching

[AMD Official Use Only - Internal Distribution Only]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: 2020=1B$BG/=1B(B3=1B$B7n=1B(B5=1B$BF|=1B(B 13:23
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tawfik, Aly <Aly.Tawfik=
@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching

Ping?

On Tue, Feb 25, 2020 at 3:32 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> From: Aly-Tawfik <altawfik@amd.com>
>
> Use the pci revision id rather than the asic silicon revision id.
>
> Signed-off-by: Aly-Tawfik <altawfik@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0c55d44c9d5b..92166150bf9f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -902,7 +902,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>
>         init_data.asic_id.chip_family =3D adev->family;
>
> -       init_data.asic_id.pci_revision_id =3D adev->rev_id;
> +       init_data.asic_id.pci_revision_id =3D adev->pdev->revision;
>         init_data.asic_id.hw_internal_rev =3D adev->external_rev_id;
>
>         init_data.asic_id.vram_width =3D adev->gmc.vram_width;
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CFeifei.X=
u%40amd.com%7Cdd49232261ac4267a33f08d7c0c54ad8%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637189825908683804&amp;sdata=3DsN%2BGSvrmnz5Qdrf4JR0sFUDWM=
Wyu7tsOh6ZG9lb9I5Y%3D&amp;reserved=3D0

--_000_CH2PR12MB39124A0D056AFD1C8534C92EF7E20CH2PR12MB3912namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
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
Is this for the series, or just this patch?&nbsp; Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xu, Feifei &lt;Feifei=
.Xu@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 5, 2020 12:24 AM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx list &lt;amd=
-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Tawfik, Al=
y &lt;Aly.Tawfik@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fet=
ching</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
<br>
<br>
Reviewed-by: Feifei Xu &lt;Feifei.Xu@amd.com&gt;<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: 2020=1B$BG/=1B(B3=1B$B7n=1B(B5=1B$BF|=1B(B 13:23<br>
To: amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Tawfik, Aly &lt;A=
ly.Tawfik@amd.com&gt;<br>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching<b=
r>
<br>
Ping?<br>
<br>
On Tue, Feb 25, 2020 at 3:32 PM Alex Deucher &lt;alexdeucher@gmail.com&gt; =
wrote:<br>
&gt;<br>
&gt; From: Aly-Tawfik &lt;altawfik@amd.com&gt;<br>
&gt;<br>
&gt; Use the pci revision id rather than the asic silicon revision id.<br>
&gt;<br>
&gt; Signed-off-by: Aly-Tawfik &lt;altawfik@amd.com&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 &#43;-<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 0c55d44c9d5b..92166150bf9f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br=
>
&gt; @@ -902,7 &#43;902,7 @@ static int amdgpu_dm_init(struct amdgpu_device=
 *adev)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.chip=
_family =3D adev-&gt;family;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.pci_revision_i=
d =3D adev-&gt;rev_id;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.pci_revisi=
on_id =3D adev-&gt;pdev-&gt;revision;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.hw_i=
nternal_rev =3D adev-&gt;external_rev_id;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.asic_id.vram=
_width =3D adev-&gt;gmc.vram_width;<br>
&gt; --<br>
&gt; 2.24.1<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CFeifei.Xu%40amd.com%7Cdd49232261ac4267a33f08d7c0c54ad8%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637189825908683804&amp;amp;sdata=3DsN%2BGSv=
rmnz5Qdrf4JR0sFUDWMWyu7tsOh6ZG9lb9I5Y%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CFeifei.Xu%40amd.=
com%7Cdd49232261ac4267a33f08d7c0c54ad8%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637189825908683804&amp;amp;sdata=3DsN%2BGSvrmnz5Qdrf4JR0sFUDWMWyu7=
tsOh6ZG9lb9I5Y%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB39124A0D056AFD1C8534C92EF7E20CH2PR12MB3912namp_--

--===============1947289388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1947289388==--
