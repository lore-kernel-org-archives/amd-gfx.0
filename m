Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10401C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 14:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73E423D6B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 14:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J9MV05qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73E423D6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C095884E2;
	Mon,  6 Apr 2020 14:32:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1074C884E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 14:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+gZoPOSNgi5DM2SuOTdie1qW1SfG/GpaAnZBb632pLGmlKaUm4RGAY3DomkDvsm4QJLo4oWMD72yPoSEEUJr+18qK1OxaVMtm12zS4GeHkmPsDq5KPH4k2D42K8ed1T+pA75lWsrJ9P+u7X0UbmDaFyVcViA9ZsQ6Ohq3vaFLDzOQYty2h0UVDeC8Un9SFsOlPRO6H+nOSkuKfRylEHLQBb7Aqq/5JhO+aA0nrlWWgZtSkCAUPQ68o6MKyXKcMCXqbePW2hmVkr6nOeWkLQUug34fVLeIdq7XfWtbiaCLJwcwYcxqKqUzlgyOu3wIh5wu/N7jd3CRwXEIUcoy0+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx22PeEHRmlTyRe7caaYBYYuVf1yEQSAbAGvKhhgqX8=;
 b=TRPdmmM+uQsAId/BaF1zAk9DEfSAq/FyUaRYDfCJogYB9jOkEF3wS6WeBG7/f8+2dYzEoWtuuz23b2nM0Dy7JWrW+ocsTlXq2OppGx9DZZE8U4Q2yqdNtbXbBSG0yxUc4r20wa7XsBn1xnlAZMQVzsTHFwaWTXpK/66szUPyJmJ3jI2dnVPpKvfGhc3hSkl/oquTdI60SnNK+8pBXziIMArbGtPMJfaiXPw4oqgK0orHQpRb4P4sgThH2KMm6hHZXw0ii6+KdB+0MQ8qfIsXplmCNnP1wkuHHQCLNQQ7NonmnYiPRGfMao1uurG/ovzy4v7Va3S6XerzltVsXev16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx22PeEHRmlTyRe7caaYBYYuVf1yEQSAbAGvKhhgqX8=;
 b=J9MV05qHA4XBcV6xcXRkzYb7NXvvLRjCl9Uv8dfaBGLRAW9aws3vMB99vlO1CBSvEqdqZXphMKDg4f4n4iH+RZRiJr7KJ94Yjv527g/FOGWGi8S7jdST9uhERId1j61RarjZ8H61cdqAIEYjS61XLSzXX5tCNCYWuqbtSyLYfNE=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 by MN2PR12MB2991.namprd12.prod.outlook.com (2603:10b6:208:c6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Mon, 6 Apr
 2020 14:32:14 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::cc84:be2a:e761:5914]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::cc84:be2a:e761:5914%6]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 14:32:14 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add SPM golden settings for Navi10(v2)
Thread-Topic: [PATCH] drm/amdgpu: add SPM golden settings for Navi10(v2)
Thread-Index: AQHWDB9oKAb0+9pfFEWljwS+1kvnNahsJ1IAgAAAonc=
Date: Mon, 6 Apr 2020 14:32:14 +0000
Message-ID: <MN2PR12MB2957A2F1FE817F70A3273CBF95C20@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20200406142632.2685-1-tianci.yin@amd.com>,
 <CADnq5_P0EPdqkt-xLA-+EtXsp2zKsdT1-Z6Ky4kPr4MMygR47A@mail.gmail.com>
In-Reply-To: <CADnq5_P0EPdqkt-xLA-+EtXsp2zKsdT1-Z6Ky4kPr4MMygR47A@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-06T14:31:04.084Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c6aa853-da0e-4407-e759-08d7da374d2d
x-ms-traffictypediagnostic: MN2PR12MB2991:|MN2PR12MB2991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29912827FB1D2DA7AE52D1DB95C20@MN2PR12MB2991.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(6506007)(19627405001)(64756008)(8676002)(86362001)(81166006)(6916009)(316002)(8936002)(4744005)(71200400001)(52536014)(5660300002)(33656002)(2906002)(54906003)(53546011)(4326008)(66946007)(66446008)(7696005)(66556008)(66476007)(186003)(76116006)(55016002)(81156014)(478600001)(91956017)(9686003)(26005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjIu/qtpfhdtg0S/8m2/zmJDGJKJNw8zw5CCWM8MkIjThOhVmEYU3RlP+pdl6x5b4Q8NHTIK87e7a8oSRlRZ8beEd7RsVj9CgUqo0Soy9peR8Mk1o6QdzUsRgYn9gZF3sLTF0sbPG+wtsoFtXW/faViCMnVhJHh/5Sx8yhJtOoAuNaVH5vYhKY1ovtlreWIzVDVJo0lW3FTp9KRP8Z471oli1DRsImDkWu4IfjkYPJq3sZqR37t+OstVzCkWoLhLIgKMvDaWhOyADv8gg+BQQ1x2bhC9wK5pCDdgai40OGXwMzH19TvnscjB28dVv0XrzI0CGxxfVahGHG6Zh78OPZJQwg8XTYolPZ2CkKsa58Ud0n7bRQIVgC3lxQmEIZo34N9yfmzFtoUoD8nVU190Y75hXY1pWr9Xg7X7jNH+CSCpjca3dhpBdJ8UxwlvcYRu
x-ms-exchange-antispam-messagedata: AlGfr4ZyN2GhUynZ/7UTUrzY9pTnWxtvcHMEgj/Ev+atiqfmGsHEG0kFZ6LHsRUpuLPWdzg8aJzDO5/FLDmfeRBmJiwc1OdDCFaocmNInT73GDO9x6m73GKdiPru8L79EvWMQUj5lcIG+5Nxvj9NoQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6aa853-da0e-4407-e759-08d7da374d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 14:32:14.7895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1Mj8d55ncaA/pnP+IjB1xKMeZ5Ls6O2PnRhw6zk9drsCk5/4/zOzsJHo6bBxgPci1j5FNTIGDQem47zRUkcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2991
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Hesik, Christopher" <Christopher.Hesik@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1913485794=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1913485794==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957A2F1FE817F70A3273CBF95C20MN2PR12MB2957namp_"

--_000_MN2PR12MB2957A2F1FE817F70A3273CBF95C20MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks very much Alex!
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Monday, April 6, 2020 22:29
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Hawking <Hawk=
ing.Zhang@amd.com>; Hesik, Christopher <Christopher.Hesik@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add SPM golden settings for Navi10(v2)

On Mon, Apr 6, 2020 at 10:26 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> Add RLC_SPM golden settings
>
> Change-Id: I616e127171293d915cb3a05dee02f51cec8d8f6f
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

--_000_MN2PR12MB2957A2F1FE817F70A3273CBF95C20MN2PR12MB2957namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much Alex!</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Monday, April 6, 2020 22:29<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Hesik, Christopher &lt;C=
hristopher.Hesik@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add SPM golden settings for Navi10(=
v2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Apr 6, 2020 at 10:26 AM Tianci Yin &lt;tia=
nci.yin@amd.com&gt; wrote:<br>
&gt;<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; Add RLC_SPM golden settings<br>
&gt;<br>
&gt; Change-Id: I616e127171293d915cb3a05dee02f51cec8d8f6f<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB2957A2F1FE817F70A3273CBF95C20MN2PR12MB2957namp_--

--===============1913485794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1913485794==--
