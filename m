Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24419C433E1
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 02:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EC122CAE
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 02:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XYZx19s5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EC122CAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436C26E49B;
	Wed,  5 Aug 2020 02:48:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77B76E49B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 02:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHzIFmwmwayucoyeeCBHPHK83KRzpSL1m33LHOz0TqBCrasRkV8+jtNm5vCdSAQFNqZizdnHfS66Z5Pwl2qRVEK/7pCLTf6MI7cPtiI0/e/D9VD5Q8UyxFjS9EMzzGovzUJ+xVTWsz5GCX+XuchjYz0XfPTU7tDIPcpVGAEBjyK4qkn37HDMx9v3JK1t4R+kPWQg67gF+FIDB8b90fMEQFy5N7XozlMIKUcQbNRtWR0aDyBUrkNtTUJg4RBPqg5UisHh0wYHmzUl6JhmwTomVkLZIMXurTEEznOzLZ5zJKcxdRRksGlrAo+oHnnxAt8o8MjLSPjPNgXpSHXZifn5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwzteC1W0FIno2u96H0ajVzZ5Vl4cRjUVgTDKhDCjqY=;
 b=dKTcp7CUz7I/V3uUe6/aKutKbCGfvqEgB1LwJLMIsithbFA2GqD6E8zWrcybDUGD3rf3fCud9DGZeskFT8xSj7hGDbqdeizlEWGkUOImZgDYU3thEIBQZFzDWo83hcbPsPMQJhQZgt+BoI7fdRNL4vfy5Vdthl0XSxOZKvVl4NWHaBjeIrST/es+h4K2yhYZo1374fWHZa+rkwjucqsRSJmU9Kmvm/jSnTzHULMSVWHGrLQky9jDX2lKULDN0u9lyAtm6s8IebYMOK7IYe+97Wa0msh0thkziYsi2+BpUaG6k7m1w5Vkb2LNNNQ1hDzIWWZB9F/lGC9cC+Gt170t0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwzteC1W0FIno2u96H0ajVzZ5Vl4cRjUVgTDKhDCjqY=;
 b=XYZx19s5DE1I6CVaDyQeFbOeI1GrLuejrY1OeiGkMvK6KlPKS/5qGSxXTe8ES/VCem2eE849T8BSdqiGu1MqZO5r+BRVO/jRxvjiEWKyGmU8/VF8L1d9NxJDww4HkCnJfv+28bhI8GdyOJ+wQFGKC2+SiqtEpapDXlrQwh5/cNU=
Received: from DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25)
 by DM6PR12MB2764.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.22; Wed, 5 Aug
 2020 02:48:18 +0000
Received: from DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::7dc9:5fa:cf73:2c54]) by DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::7dc9:5fa:cf73:2c54%6]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 02:48:18 +0000
From: "Bridgman, John" <John.Bridgman@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?iso-8859-1?Q?Michel_D=E4nzer?=
 <michel@daenzer.net>
Subject: Re: Enabling AMDGPU by default for SI & CIK
Thread-Topic: Enabling AMDGPU by default for SI & CIK
Thread-Index: AQHWaSdYDaw07wjl10y/DThL0FNoQ6knossAgACWRQCAAJnE/A==
Date: Wed, 5 Aug 2020 02:48:17 +0000
Message-ID: <DM6PR12MB3097E61D23857E0342398E6EE84B0@DM6PR12MB3097.namprd12.prod.outlook.com>
References: <CAP+8YyHwMPPTiPAEs0CV+K+NSWtQmKQ-1hL0CmoGvUjA=P_1+Q@mail.gmail.com>
 <6964a9dc-00dc-6e72-f3ad-b4c80c49ec68@daenzer.net>,
 <CADnq5_OzAfTyufz0qzOQYqMbkYYGx6FaFLi-nvRvvzLcYrFQcQ@mail.gmail.com>
In-Reply-To: <CADnq5_OzAfTyufz0qzOQYqMbkYYGx6FaFLi-nvRvvzLcYrFQcQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-05T02:48:17.066Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.139.197.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de49a7fd-eff4-4cd1-4b65-08d838ea0204
x-ms-traffictypediagnostic: DM6PR12MB2764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2764D7EF816EE020EE18AD4CE84B0@DM6PR12MB2764.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcNYVzZiiQjw8Vi4IE2I6vlXpdu/hlUvUG1X0wtAm20uQTGalnFOJhIWPLY6wiZrWNkhOwrKOkSpuYEAuKnP2mkGsnAw1BJj5Yayt5c8y7RlERLYXWdhGhk2OKmD6Nz2LJPBjB7WhoG3l22c9WGbSHSYMdymQB8BnY/FE5oZQwkTAUjeW0wf0uQDglM2A2LRKo7hMq2k3LfebxfBQ1//6Eo3sHo8Ae1USAkjKBFtAFL1Sag4wqi39XiYeVnpRMR+W53G/m/B4jUAmvSZdHoWiYROZcENcqfRZY4vnGkqOXtpw9WRkYMCTfyGxjQ7GhEw6QGeP2YSN+d7g1Gyj5EJ/anzfEFnKrn+OI0cRCl7+kA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3097.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(26005)(8936002)(66574015)(19627405001)(5660300002)(2906002)(52536014)(7696005)(66946007)(55016002)(71200400001)(166002)(478600001)(45080400002)(66446008)(86362001)(6506007)(66556008)(66476007)(4326008)(966005)(83380400001)(76116006)(53546011)(64756008)(54906003)(9686003)(186003)(316002)(110136005)(8676002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 382zWVj5U/uxF+IqowFcXVwb0b1Cz5Tx0sKQiC600Mf8OnBTiZ7iJYfIH4LPFphAEYlMVMhmm4YIrJx7ru/o3U5WhUkXM6+wvLyGLQUtP2ljktZph02wWZTI9YQmgmb5gucbBgBYaKOnoFojYQzFbzBj9+odLoYOT+xqTKoejFAOdSJycdYZLW38KcGIdFd8erkmrbZCmJh9qD10msCUJIkn85tpoYP3rs3yQ9eLCDuhv9gKWMYmHKO8Nq9j7ZQAXK1FrsrhSfmY0kQJJOux7gJEXTmA92nBAF+J2TClJvOxrR5cc/3CeCr5AX4lAUTnm/WgSNgT/XvTEbyUKPOc0yU84V0OQTzwXep+JXtiKR47hSq8aaR+mJkGJmVuWIlRoTLCRifdZqHsE0UtMUiadrv4CtM5DUOflkVDA1f5Ptm+L7IABDj58dGUIqnyKS2owHPtjxatYUfpEvMAcJWtx1fl3o5ORYTxKxc39n46sge2zlrRllvpTS14XavKqMFL5IiI4EpJzN/o0PQ/HZzSd2W5/7zwAH1ItGvVKRshzuSFbo9vfh7X6qVTN70U5eRCKvKUrbjhywkcYViaE8zowXiZ7WJtvfYbjSB7hf9ctdDQnbmZsWgPHVy/iK2d7+c5Jp8hwuqeD/kpthSqpvb0Hw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3097.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de49a7fd-eff4-4cd1-4b65-08d838ea0204
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 02:48:17.9034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StS3JhXEPs9jjFxEd898va9/+3Iiod64/JdkAxCGP9ibFeddmDMAXykAdvUiP5v12EbomJgmOWO9SwF18GARGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2764
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/mixed; boundary="===============0508802794=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0508802794==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3097E61D23857E0342398E6EE84B0DM6PR12MB3097namp_"

--_000_DM6PR12MB3097E61D23857E0342398E6EE84B0DM6PR12MB3097namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

At the risk of asking a dumb question, does amdgpu default to using DC on S=
I and CI ?

I'm asking because a lot of people seem to be using amdgpu successfully wit=
h analog outputs today on SI/CI... suggests that they are not using DC ?

If so then would enabling HDMI/DP audio support without DC be sufficient to=
 flip the switch assuming we felt that other risks were manageable ?

Thanks,
John

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: August 4, 2020 1:35 PM
To: Michel D=E4nzer <michel@daenzer.net>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx mailing list <amd-gfx@lists.freedesktop.org>=
; Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: Re: Enabling AMDGPU by default for SI & CIK

On Tue, Aug 4, 2020 at 4:38 AM Michel D=E4nzer <michel@daenzer.net> wrote:
>
> On 2020-08-03 1:45 a.m., Bas Nieuwenhuizen wrote:
> > Hi all,
> >
> > Now that we have recently made some progress on getting feature parity
> > with the Radeon driver for SI, I'm wondering what it would take to
> > make AMDGPU the default driver for these generations.
> >
> > As far as I understand AMDGPU has had these features for CIK for a
> > while already but it is still not the default driver. What would it
> > take to make it the default? What is missing and/or broken?
>
> The main blockers I'm aware of for CIK are:
>
> 1) Lack of analogue connector support with DC
> 2) Lack of HDMI/DP audio support without DC
>
>
> 1) may apply to SI as well.

Also, IIRC, there are suspend and resume problems with some CIK parts
using amdgpu.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cjohn.bri=
dgman%40amd.com%7C26df81f9a6df4e2f9fbb08d8389cda79%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637321593620378481&amp;sdata=3DEp%2BYRRT1dAcE8zSDIaZiX=
uVMb9gBVUnLnbtP1%2Be7Pkc%3D&amp;reserved=3D0

--_000_DM6PR12MB3097E61D23857E0342398E6EE84B0DM6PR12MB3097namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
At the risk of asking a dumb question, does amdgpu default to using DC on S=
I and CI ?
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I'm asking because a lot of people seem to be using amdgpu successfully wit=
h analog outputs today on SI/CI... suggests that they are not using DC ?</d=
iv>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If so then would enabling HDMI/DP audio support without DC be sufficient to=
 flip the switch assuming we felt that other risks were manageable ?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,<br>
John<br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> August 4, 2020 1:35 PM<br>
<b>To:</b> Michel D=E4nzer &lt;michel@daenzer.net&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; amd-gfx mailing list &lt;amd-gfx@=
lists.freedesktop.org&gt;; Bas Nieuwenhuizen &lt;bas@basnieuwenhuizen.nl&gt=
;<br>
<b>Subject:</b> Re: Enabling AMDGPU by default for SI &amp; CIK</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Tue, Aug 4, 2020 at 4:38 AM Michel D=E4nzer &lt=
;michel@daenzer.net&gt; wrote:<br>
&gt;<br>
&gt; On 2020-08-03 1:45 a.m., Bas Nieuwenhuizen wrote:<br>
&gt; &gt; Hi all,<br>
&gt; &gt;<br>
&gt; &gt; Now that we have recently made some progress on getting feature p=
arity<br>
&gt; &gt; with the Radeon driver for SI, I'm wondering what it would take t=
o<br>
&gt; &gt; make AMDGPU the default driver for these generations.<br>
&gt; &gt;<br>
&gt; &gt; As far as I understand AMDGPU has had these features for CIK for =
a<br>
&gt; &gt; while already but it is still not the default driver. What would =
it<br>
&gt; &gt; take to make it the default? What is missing and/or broken?<br>
&gt;<br>
&gt; The main blockers I'm aware of for CIK are:<br>
&gt;<br>
&gt; 1) Lack of analogue connector support with DC<br>
&gt; 2) Lack of HDMI/DP audio support without DC<br>
&gt;<br>
&gt;<br>
&gt; 1) may apply to SI as well.<br>
<br>
Also, IIRC, there are suspend and resume problems with some CIK parts<br>
using amdgpu.<br>
<br>
Alex<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cjohn.bridgman%40amd.com%7C26df81f9a6df4e2f9fbb08d8389cda79%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637321593620378481&amp;amp;sdata=3DEp%2=
BYRRT1dAcE8zSDIaZiXuVMb9gBVUnLnbtP1%2Be7Pkc%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cjohn.bridg=
man%40amd.com%7C26df81f9a6df4e2f9fbb08d8389cda79%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637321593620378481&amp;amp;sdata=3DEp%2BYRRT1dAcE8zSDIaZ=
iXuVMb9gBVUnLnbtP1%2Be7Pkc%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3097E61D23857E0342398E6EE84B0DM6PR12MB3097namp_--

--===============0508802794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0508802794==--
