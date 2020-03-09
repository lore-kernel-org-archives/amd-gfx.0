Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92621C10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 06:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F10206D5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 06:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IgXwELJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F10206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA57B89F49;
	Mon,  9 Mar 2020 06:58:52 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690081.outbound.protection.outlook.com [40.107.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F57E89F49
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 06:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvBxxFSMENUUqsKJvvteFPFCtAc4LdL5iPKFBtfhbU3wY5qGvo4tvUpLyafrNjXU5n00WRrpaTenCV32Wif/Ww1M5pdNAuyMP/YakzYGUnACwuaTTuYzCW6LhrcIF2Ve63Zs9iHYs8lfglzRZGKrrRSF0yfZ371tqb5nOPvo4jXQuBtHErFWG3LAI/g1sIDATddnSlsezK+D/35Rfg0zsq4N/mj4WdL8eCU9yTfHRt6XJIf4Fk0S2OezNdt0HtvYtgPiNDX2E5BYYqkozTw7HeY/0Uhcjk+C4uKCGbtaSVL71vRdJXGEm3yvrezfaahNyzMWxAQYZK6c8+u6Xd4NaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpYmja7VP1bReplQE5SkIF33AuMxPM0LboXCfaaIF5Y=;
 b=F7DeIIP3yXfzZ9jXLjIVwFMJnLhHs8GVHaJ32qNu4iDUylDFaUN6uyV/SWFDRBw7g6+NiaciTUv6dgX6JX+/o+JkiZf6xkWxtpB5mLdnXK5KmF6xGSLpxFdTyhfuM2tPs+le1fkEqXenQfEYgx0w0EW6Yuhxv9UIyCs86alEknAwc58vAxXTktQtxH7zLd/aKBJ1pmBMFBBW5xZhV5iSjMRCwIOVcPtXRSD5EoV9lJl/J2ErP5LvP35gP1Zh1rtflDOJWvjKqCygSVIoTLSwnD2lmju12Olb69cssxb1VQID+rnIHRmpjvgLreP71Gg+Lkhl+f0thnXDbMFt6Ut0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpYmja7VP1bReplQE5SkIF33AuMxPM0LboXCfaaIF5Y=;
 b=IgXwELJFxKJm9wFZZEBAoth1snwxvWvIw1K0K1goJsqPqaXdKOBXZNfoenc4sLiwIYtaofcnuo2qP8YT+6PArc4/e2TdOAOLmPS2DsKD+LS+YSbJ1z40jMu0eVMpZI5ZEbzK+XNWM5jsThSdGjLBaDdPp7lbgUimZyBM7al7Urw=
Received: from DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25)
 by DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 06:58:50 +0000
Received: from DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46]) by DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 06:58:50 +0000
From: "Bridgman, John" <John.Bridgman@amd.com>
To: Clemens Eisserer <linuxhippy@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
Thread-Topic: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
Thread-Index: AQHV9UqqZR23yGf9cUeTL0ye4URzuKg/BbcggAAGOhOAAMHzAIAAB6hG
Date: Mon, 9 Mar 2020 06:58:50 +0000
Message-ID: <DM6PR12MB3097728439238BA34015B087E8FE0@DM6PR12MB3097.namprd12.prod.outlook.com>
References: <CAFvQSYQqneGVka+uyZjs1RsFNFkXZqYmz9pTP6=8uhUP0ddHAQ@mail.gmail.com>
 <DM6PR12MB30977EA10F8FDF64778C18CAE8E10@DM6PR12MB3097.namprd12.prod.outlook.com>
 <DM6PR12MB309791830A01031827FE2DCAE8E10@DM6PR12MB3097.namprd12.prod.outlook.com>,
 <CAFvQSYTm0ivSvTrFGUQ3S81+Q_SvbhZxaAQScOX3-kySWJPYUg@mail.gmail.com>
In-Reply-To: <CAFvQSYTm0ivSvTrFGUQ3S81+Q_SvbhZxaAQScOX3-kySWJPYUg@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-09T06:58:49.512Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Bridgman@amd.com; 
x-originating-ip: [72.136.100.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f5e4867-594a-40e8-a4df-08d7c3f75264
x-ms-traffictypediagnostic: DM6PR12MB4011:
x-microsoft-antispam-prvs: <DM6PR12MB4011661E6B28A40CD5C8DE8BE8FE0@DM6PR12MB4011.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(5660300002)(71200400001)(33656002)(26005)(66446008)(55016002)(76116006)(316002)(2906002)(64756008)(66476007)(9686003)(66946007)(66556008)(81156014)(81166006)(7696005)(8936002)(53546011)(6506007)(478600001)(8676002)(86362001)(52536014)(19627405001)(186003)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4011;
 H:DM6PR12MB3097.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ltWbO/kIRcw1mRHzawmTqcABP38icxCoF9/PJPluWNcBPsB1U5arkZP3UHx+sQTU3RS10idhFaxk84oC3nsOSt63Frv+dm4hfmbyFanqyxi6c553GNlNFzP0UCdCsCIKXhG2T/JD6FYCOcD9kX16Ib9ewFOXEfSq716L49ggN9p/vA1v+TnesThn7MlqvGols6EwOl2VT181s/2PKszXUgEtd7Dz9IyL6y805Qi4AUFy35Zga8MV4or1h//IEYhiFsoKASSuOtQ0wk6MbBhQ+oBo0xDWRGJFs7PcCS+2wSuYo/jMRUuq6fLN1j8zvSPbzdjpc4lEt7K9tY01oPvAxSGGPKxOX0Kr8+UfZK4Xra7BfT6uzECAHZwln/4wIyz6Juu8uorKGbBO6inVxJAw4R+SM/kpxQw4E30RPM4BXH9HcdPloSFTY3n0+nQTnP2x
x-ms-exchange-antispam-messagedata: rW7a0KAWSYZKzqNSnxxteECAyl5mlpZxzftarLt7owEJc+uWeXtaUa6hlWKhBd2iHedewNttwi4KOujrlaXhFYDp/vEk5RgJHTp7XcACgYOMA9wrQM2qjp2SFvEL+yKWhU3YKkAgC656gyOr8nS7sw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5e4867-594a-40e8-a4df-08d7c3f75264
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 06:58:50.2170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTg89ERlRjpz51InrsANJynRVv7oDhFlb2yH+mWZoQc1DFpGU3hojJXpLYrlgTt+TqAkUuvoPQN5frPUatJlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Content-Type: multipart/mixed; boundary="===============0694977467=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0694977467==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3097728439238BA34015B087E8FE0DM6PR12MB3097namp_"

--_000_DM6PR12MB3097728439238BA34015B087E8FE0DM6PR12MB3097namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

>I know RX570 (polaris) should stay at PCI3 as far as I know.

Yep... thought I remembered you mentioning having a 5700XT though... is tha=
t in a different system ?

________________________________
From: Clemens Eisserer <linuxhippy@gmail.com>
Sent: March 9, 2020 2:30 AM
To: Bridgman, John <John.Bridgman@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)=
 with Ryzen 3700x?

Hi John,

Thanks a lot for taking the time to look at this, even if it doesn't
seem to be GPU related at first.

> OK, that's a bit strange... I found mce log and MCE-Ryzen-Decoder as opti=
ons for decoding.
Sorry for omitting that information - indeed I was using
MCE-Ryzen-Decoder, thanks for pointing to mcelog.
The mce log output definitivly makes more sense, I'll try to
experiment a bit with RAM.

Thanks also for the link to the forum, seems of all the affected users,
no one reported success in that thread.

> For something as simple as the GPU bus interface not responding to an acc=
ess
> by the CPU I think you would get a different error (bus error) but not 10=
0% sure about that.
>
> My first thought would be to see if your mobo BIOS has an option to force=
 PCIE
> gen3 instead of 4 and see if that makes a difference. There are some amdg=
pu module parms
> related to PCIE as well but I'm not sure which ones to recommend.

I'll give it a try and have a look at the pcie options - but as far as
I know RX570 (polaris) should stay at PCI3 as far as I know.
Disabling IOMMU didn't help as far as I recall.

Thanks & best regards, Clemens

--_000_DM6PR12MB3097728439238BA34015B087E8FE0DM6PR12MB3097namp_
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
&gt;<font size=3D"2"><span style=3D"font-size:11pt">I know RX570 (polaris) =
should stay at PCI3 as far as I know.</span></font><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yep... thought I remembered you mentioning having a 5700XT though... is tha=
t in a different system ?<br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Clemens Eisserer &l=
t;linuxhippy@gmail.com&gt;<br>
<b>Sent:</b> March 9, 2020 2:30 AM<br>
<b>To:</b> Bridgman, John &lt;John.Bridgman@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: Possibility of RX570 responsible for spontaneous reboot=
s (MCE) with Ryzen 3700x?</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hi John,<br>
<br>
Thanks a lot for taking the time to look at this, even if it doesn't<br>
seem to be GPU related at first.<br>
<br>
&gt; OK, that's a bit strange... I found mce log and MCE-Ryzen-Decoder as o=
ptions for decoding.<br>
Sorry for omitting that information - indeed I was using<br>
MCE-Ryzen-Decoder, thanks for pointing to mcelog.<br>
The mce log output definitivly makes more sense, I'll try to<br>
experiment a bit with RAM.<br>
<br>
Thanks also for the link to the forum, seems of all the affected users,<br>
no one reported success in that thread.<br>
<br>
&gt; For something as simple as the GPU bus interface not responding to an =
access<br>
&gt; by the CPU I think you would get a different error (bus error) but not=
 100% sure about that.<br>
&gt;<br>
&gt; My first thought would be to see if your mobo BIOS has an option to fo=
rce PCIE<br>
&gt; gen3 instead of 4 and see if that makes a difference. There are some a=
mdgpu module parms<br>
&gt; related to PCIE as well but I'm not sure which ones to recommend.<br>
<br>
I'll give it a try and have a look at the pcie options - but as far as<br>
I know RX570 (polaris) should stay at PCI3 as far as I know.<br>
Disabling IOMMU didn't help as far as I recall.<br>
<br>
Thanks &amp; best regards, Clemens<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3097728439238BA34015B087E8FE0DM6PR12MB3097namp_--

--===============0694977467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0694977467==--
