Return-Path: <SRS0=eq4R=4Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F2DC10DCE
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2020 18:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AADA2067C
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2020 18:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u2geCp//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AADA2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0828C89F38;
	Sun,  8 Mar 2020 18:45:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4036689F38
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Mar 2020 18:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoBKnpLx1YDGkEQV+YdD3LmMOALiGX46ZKl1oele+XLbAo97s/bsZokskQ/Y7MYZzd83UPvYKGL2tILUArh/g6n+c4q4ujHnwH+2zh59DZa523DTf6brG2IAuTF/4vbDCZXO9dxZoWZzZlkb2ZkD3SHmYO1kxnMESOZOW+GojVk6yf203kmmUQGtp14uG4+J0rR57S+L7LH0kN7LuNBOmr+YBe5z9B9v4McgGf6TDdTdx6k+IlMfFo4ki7iiYSko4SZd4D0lXyYoqu6kXYFym6rL0D7Y3Mv/XX7qmLSbhtHMUwUufNqCajuwzl6iJtTvpmTqZEL21Xf3Nkk0F0UwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATJMxvlYkL9wCo9JBrJXneVAhyX2nfM4f5VS6i/jeYI=;
 b=cQeOP5VZbk1+cX2dXAcfjdrS6YupFvpRC/WIpDWk6PEHilkZlS9f0fhBop2/QzoYO6WRvgwgC2ZyceVfq2dcgy3Y2BVSrCZvs19zi6h4XWQQ/xwJYtPYp73uBdOZ2np4RNahsh9XR95oZhGQZHvBhQx/8lwLApd+y47E93imk5asrDm6laVQiWII/QmryZ8hhmDAdeIZTdPQMt9Pu/EG03WPhPJbv5PwtdkD+xl4vldCWzA27DktiUmyb5JOvqF/UZtG4rHBP4j21kCC9wTLh5+eeiv/58cxz+LYT49xw/Tj7L5truJsGX/L/TT42FikVo39rCuqQdi53AQiRlQMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATJMxvlYkL9wCo9JBrJXneVAhyX2nfM4f5VS6i/jeYI=;
 b=u2geCp//uJeHI9sHFcg2wkZT4eVD14jzz+awnpEm15ABFCm9aKUyfuiZ8GXgrqKFhNyxfr9LQSSkxg7AWbW1bEVxiwvV49r134MOAPfgLwF15MdL2FjuOeDdouZ7RBn6k1qwS8Ehz5+ncR3VQL1t+g6XduKW5r1xlT62QjeZjCo=
Received: from DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25)
 by DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Sun, 8 Mar
 2020 18:45:12 +0000
Received: from DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46]) by DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46%5]) with mapi id 15.20.2793.013; Sun, 8 Mar 2020
 18:45:11 +0000
From: "Bridgman, John" <John.Bridgman@amd.com>
To: Clemens Eisserer <linuxhippy@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
Thread-Topic: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
Thread-Index: AQHV9UqqZR23yGf9cUeTL0ye4URzuKg/Bbcg
Date: Sun, 8 Mar 2020 18:45:11 +0000
Message-ID: <DM6PR12MB30977EA10F8FDF64778C18CAE8E10@DM6PR12MB3097.namprd12.prod.outlook.com>
References: <CAFvQSYQqneGVka+uyZjs1RsFNFkXZqYmz9pTP6=8uhUP0ddHAQ@mail.gmail.com>
In-Reply-To: <CAFvQSYQqneGVka+uyZjs1RsFNFkXZqYmz9pTP6=8uhUP0ddHAQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-08T18:45:11.000Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Bridgman@amd.com; 
x-originating-ip: [72.136.100.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b7a38d7-0a5b-421a-8c14-08d7c390d55d
x-ms-traffictypediagnostic: DM6PR12MB4529:
x-microsoft-antispam-prvs: <DM6PR12MB4529D4D1D48F88A13A8D0089E8E10@DM6PR12MB4529.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03361FCC43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(966005)(9686003)(5660300002)(55016002)(52536014)(110136005)(2906002)(478600001)(45080400002)(316002)(71200400001)(19627405001)(81166006)(81156014)(8676002)(7696005)(66476007)(66556008)(66946007)(66446008)(76116006)(64756008)(6506007)(53546011)(8936002)(86362001)(186003)(26005)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4529;
 H:DM6PR12MB3097.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJyxy9hhuYvjzGYIv/yMgitKZMNX/VRYNLx/fJUL1rJi+EkkDWc0foqS2ElSn39jG3L12C49FtNKqyUo4SAWz1SL9YYPi7tEF11FkfT6TBepWGuu4kPV4hHykrTMA3wOvmZ+UnGv7T9lh+xddGOYvgT6loEjUwEilMjbMImo76IfzlSHZNdQHwKFNZ3qJ2xTEvDzfBMSLOUSExMAfpFOvX1sZq6ox02YhGeXP/hZHkCz01rRs9vhXDRQZZOv5P/s+DOq9NSQ380PcrVI5yFPAZoyiQhNhPu2ysy1ZrWz3XrQv/aElKmUUoO3pHTpxNNfR2U5ayT/XzAItP0B//D2xValy+IZ3yi97/336tj1jyrALlE6y9Skjpxq4qIcLl+jLg+a3XoWiLZaCNKSKG+YDN4ihWGGnV5vD1YiOuPVFuIqLJ/1epLZBPDdEj6CIbFTm/kLaoZfxlmrAnKBtu7N1kzbjfcruZmtJqEzhprlqMu/dNiTXszAnsHF1AI2H64L76T3cZDwEMaRBgILX4tqRg==
x-ms-exchange-antispam-messagedata: CQqu47/R2Gl8Rsmjpg7KYVBYLKh0fuDS8XGjuNayeitmhbDBW0GXuj0+FRJ6ogob3+lzo0MMc8uOsrs3oca26GCL6DeIxBv9yM9FD8+Pe6J+QBUrlioceBXomw8Gbl9LFfumuGePxQeOkdF88jZD7g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7a38d7-0a5b-421a-8c14-08d7c390d55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2020 18:45:11.8079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcCLmrzSP7J2VZ6nqOOltOviUhFTfQ+rWI5JhHYfuXV8CeoqZdnwgh7rNdrKx37GIpCnHg6NO4IC96er4/eHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529
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
Content-Type: multipart/mixed; boundary="===============1194394811=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1194394811==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB30977EA10F8FDF64778C18CAE8E10DM6PR12MB3097namp_"

--_000_DM6PR12MB30977EA10F8FDF64778C18CAE8E10DM6PR12MB3097namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

The decoded MCE info doesn't look right... if the last bit is a zero I beli=
eve that means the watchdog timer is not enabled.

That said, I'm not sure how the decoder you found works, but it seems like =
a bit more information would be required than what you passed in. Can you p=
oint me to the program you used ?

Thanks,
John

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Clemens =
Eisserer <linuxhippy@gmail.com>
Sent: March 8, 2020 9:06 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Possibility of RX570 responsible for spontaneous reboots (MCE) wit=
h Ryzen 3700x?

Hi there,

Right after Ryzen3xxx was available I built a new system consisting of:
- Asrock Phantom Gaming 4 X570 (latest BIOS 2.3)
- Ryzen 3700x (not overclocked)
- MSI RX570 4GB
- Larger CPU cooler, high quality PSU, etc...

The system runs stable with Windows-10 (no reboot BSOD in months) and
runs memtest86 (single/multicore) as well as various load-tests for
hours without errors. However running Linux I get a spontaneous reboot
every now and then (2-3x a week), with always the same machine check
exception logged:

[    0.105003] .... node  #0, CPUs:        #1  #2
[    0.107022] mce: [Hardware Error]: Machine check events logged
[    0.107023] mce: [Hardware Error]: CPU 2: Machine Check: 0 Bank 5:
bea0000000000108
[    0.107092] mce: [Hardware Error]: TSC 0 ADDR 7f80a0c0181a MISC
d012000100000000 SYND 4d000000 IPID 500b000000000
[    0.107167] mce: [Hardware Error]: PROCESSOR 2:870f10 TIME
1580717835 SOCKET 0 APIC 4 microcode 8701013

I've tried a lot of different CPU-related things, like disabling C6,
disabling MWAIT use for task switching, etc without success.
I tried two times to contact AMD support only asking them to please
decode the MCE hex value - but as soon as they read over the term
"linux" the basically abort any communication. And to be honest, I had
the impression that they did not actually know what an MCE is in the
first place.

Luckily I found a decoder on github which prints:
Bank: Execution Unit (EX)
Error: Watchdog Timeout error (WDT 0x0)

I was rather hopeless until I found the following reddit thread:
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.red=
dit.com%2Fr%2Farchlinux%2Fcomments%2Fe33nyg%2Fhard_reboots_with_ryzen_3600x=
%2F&amp;data=3D02%7C01%7Cjohn.bridgman%40amd.com%7C683b51328ba1471c113c08d7=
c3619d90%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637192697111254592&am=
p;sdata=3D4TuB0a0VHxTqd8R0xLwxg%2BOv1vu8C7L%2FLW4O0EOiq1I%3D&amp;reserved=
=3D0
what the decoder logic is
The users there claim to experience exactly the same problem (even
with the same MCE-Code logged) but where using R600 based graphics
cards - he is even using the same mainboard. When he swapped his
R600-card with a new RX5700 the problems vanished.

I don't have the luxury to simply try another GPU (my RX5700 is the
only one properly driving my 4k@60Hz panel), however the whole
observation makes me wonder. How can a GPU be responsible for
low-level errors such as the machine check exception in the execution
units like the one mentioned above.
Could DMA transfers gone bad be the cluprit?
Are there any "safe mode" options available I could try regarding
amdgpu (I tried disabling low-power states but this didn't help and
only made my GPU fans spin up)?

Any help is highly appreciated.

Thanks, Clemens
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cjohn.bri=
dgman%40amd.com%7C683b51328ba1471c113c08d7c3619d90%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637192697111264585&amp;sdata=3DL52zHeIm8GzEr5eYjUDm5bP=
K4U1DF0t1GtaxaUy9qHY%3D&amp;reserved=3D0

--_000_DM6PR12MB30977EA10F8FDF64778C18CAE8E10DM6PR12MB3097namp_
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
The decoded MCE info doesn't look right... if the last bit is a zero I beli=
eve that means the watchdog timer is not enabled.&nbsp;
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
That said, I'm not sure how the decoder you found works, but it seems like =
a bit more information would be required than what you passed in. Can you p=
oint me to the program you used ?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
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
-bounces@lists.freedesktop.org&gt; on behalf of Clemens Eisserer &lt;linuxh=
ippy@gmail.com&gt;<br>
<b>Sent:</b> March 8, 2020 9:06 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Possibility of RX570 responsible for spontaneous reboots (M=
CE) with Ryzen 3700x?</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hi there,<br>
<br>
Right after Ryzen3xxx was available I built a new system consisting of:<br>
- Asrock Phantom Gaming 4 X570 (latest BIOS 2.3)<br>
- Ryzen 3700x (not overclocked)<br>
- MSI RX570 4GB<br>
- Larger CPU cooler, high quality PSU, etc...<br>
<br>
The system runs stable with Windows-10 (no reboot BSOD in months) and<br>
runs memtest86 (single/multicore) as well as various load-tests for<br>
hours without errors. However running Linux I get a spontaneous reboot<br>
every now and then (2-3x a week), with always the same machine check<br>
exception logged:<br>
<br>
[&nbsp;&nbsp;&nbsp; 0.105003] .... node&nbsp; #0, CPUs:&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; #1&nbsp; #2<br>
[&nbsp;&nbsp;&nbsp; 0.107022] mce: [Hardware Error]: Machine check events l=
ogged<br>
[&nbsp;&nbsp;&nbsp; 0.107023] mce: [Hardware Error]: CPU 2: Machine Check: =
0 Bank 5:<br>
bea0000000000108<br>
[&nbsp;&nbsp;&nbsp; 0.107092] mce: [Hardware Error]: TSC 0 ADDR 7f80a0c0181=
a MISC<br>
d012000100000000 SYND 4d000000 IPID 500b000000000<br>
[&nbsp;&nbsp;&nbsp; 0.107167] mce: [Hardware Error]: PROCESSOR 2:870f10 TIM=
E<br>
1580717835 SOCKET 0 APIC 4 microcode 8701013<br>
<br>
I've tried a lot of different CPU-related things, like disabling C6,<br>
disabling MWAIT use for task switching, etc without success.<br>
I tried two times to contact AMD support only asking them to please<br>
decode the MCE hex value - but as soon as they read over the term<br>
&quot;linux&quot; the basically abort any communication. And to be honest, =
I had<br>
the impression that they did not actually know what an MCE is in the<br>
first place.<br>
<br>
Luckily I found a decoder on github which prints:<br>
Bank: Execution Unit (EX)<br>
Error: Watchdog Timeout error (WDT 0x0)<br>
<br>
I was rather hopeless until I found the following reddit thread:<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fwww.reddit.com%2Fr%2Farchlinux%2Fcomments%2Fe33nyg%2Fhard_reboots_with_=
ryzen_3600x%2F&amp;amp;data=3D02%7C01%7Cjohn.bridgman%40amd.com%7C683b51328=
ba1471c113c08d7c3619d90%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637192=
697111254592&amp;amp;sdata=3D4TuB0a0VHxTqd8R0xLwxg%2BOv1vu8C7L%2FLW4O0EOiq1=
I%3D&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?=
url=3Dhttps%3A%2F%2Fwww.reddit.com%2Fr%2Farchlinux%2Fcomments%2Fe33nyg%2Fha=
rd_reboots_with_ryzen_3600x%2F&amp;amp;data=3D02%7C01%7Cjohn.bridgman%40amd=
.com%7C683b51328ba1471c113c08d7c3619d90%7C3dd8961fe4884e608e11a82d994e183d%=
7C0%7C0%7C637192697111254592&amp;amp;sdata=3D4TuB0a0VHxTqd8R0xLwxg%2BOv1vu8=
C7L%2FLW4O0EOiq1I%3D&amp;amp;reserved=3D0</a><br>
what the decoder logic is <br>
The users there claim to experience exactly the same problem (even<br>
with the same MCE-Code logged) but where using R600 based graphics<br>
cards - he is even using the same mainboard. When he swapped his<br>
R600-card with a new RX5700 the problems vanished.<br>
<br>
I don't have the luxury to simply try another GPU (my RX5700 is the<br>
only one properly driving my 4k@60Hz panel), however the whole<br>
observation makes me wonder. How can a GPU be responsible for<br>
low-level errors such as the machine check exception in the execution<br>
units like the one mentioned above.<br>
Could DMA transfers gone bad be the cluprit?<br>
Are there any &quot;safe mode&quot; options available I could try regarding=
<br>
amdgpu (I tried disabling low-power states but this didn't help and<br>
only made my GPU fans spin up)?<br>
<br>
Any help is highly appreciated.<br>
<br>
Thanks, Clemens<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cjohn.bridgman%40amd.com%7C683b51328ba1471c113c08d7c3619d90%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637192697111264585&amp;amp;sdata=3DL52z=
HeIm8GzEr5eYjUDm5bPK4U1DF0t1GtaxaUy9qHY%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cjohn.bridgman%=
40amd.com%7C683b51328ba1471c113c08d7c3619d90%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637192697111264585&amp;amp;sdata=3DL52zHeIm8GzEr5eYjUDm5bPK4=
U1DF0t1GtaxaUy9qHY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB30977EA10F8FDF64778C18CAE8E10DM6PR12MB3097namp_--

--===============1194394811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1194394811==--
