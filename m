Return-Path: <SRS0=eq4R=4Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFE3C10DCE
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2020 19:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C156206D5
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2020 19:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BFCx2WFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C156206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D921F6E05A;
	Sun,  8 Mar 2020 19:14:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5316F6E05A
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Mar 2020 19:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNoM49SgU+AsnoD5vkYyLa2/e3+jRJl8U/AIe+Ae88F0kIXmlQ9GCQhWG17ztmELlKdeO9fexnY+4WzVP8EMajkos5wf5qeuZRbPK+L9pJOmGUCcCm0PZxS8YYq7GvFZi+k/MR96IoBKG1c/RM6pCCuqToZAqGjBv+fQDSMCl9/oZ3khDUmjorxrpwxg7MLVRefq8OQOXlPYl9yOvUyC3wBQx+cMOXUkB9tVwHOyTJu2Dk6JU1JGtBoNfjmUG8tTS+UenxE+V2RwkLb9zNiKCNwfRgVAbhFK9ixP/+qU2R21Y+AVuu0pryFq6GESbcBi02duGH8jGwFiwcqQLk7lRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia42+gvtOxQ87LdQw9kTeq9ZNOznZnGiqbh2KWvR/Gg=;
 b=HRTdtszrvweODIBZapCB2Ga5NS8mdF3X9gAXZ/IuDqi9ePfPeqh6DzFnXoT/qIF6pdjzLnLWuJXKkONNbqYdcZl+0aEzkyVa4EGZpq120scAkEM8sQv5VQ2q3Rh5Y5azL41jw0epEmcRJFI3BtpX1I5EvDTLC/4Sp9xpnhPcHa/c+1fUJSpIk2bWcKPF6NrXSENaShzvq8L564Ba4K7QNWSNC14lyety2Vl2wxtC/BNsfCUIpaxCsmUg/C+3oWoLRuA1RfDml2nWqgTvC6iy/uzksE6Frn/9TRp/WZVHciFX15Fw9FIHtlmoxjj8eAjfhzDC8s3g/GpPZkl123YPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia42+gvtOxQ87LdQw9kTeq9ZNOznZnGiqbh2KWvR/Gg=;
 b=BFCx2WFBSYZkeXgJ/xXfrgtUolyXjaSSjuiUJnQ8Z9+Fm/xkc+mFDC9nTiMh1N/t4X6Y1FJp6E+RXRN96fy4MbbjvZWC1lkvDHRXpvgUykWM3pr4L4OcxiIRGVPdrhLu5V91QAL9u8JKZjSA9c3cpRqzdkys9V42MlH199qwDQw=
Received: from DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25)
 by DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Sun, 8 Mar
 2020 19:14:07 +0000
Received: from DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46]) by DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::c90d:ccf4:5717:9b46%5]) with mapi id 15.20.2793.013; Sun, 8 Mar 2020
 19:14:07 +0000
From: "Bridgman, John" <John.Bridgman@amd.com>
To: Clemens Eisserer <linuxhippy@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
Thread-Topic: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
Thread-Index: AQHV9UqqZR23yGf9cUeTL0ye4URzuKg/BbcggAAGOhOAAATAyg==
Date: Sun, 8 Mar 2020 19:14:07 +0000
Message-ID: <DM6PR12MB3097BAD868E86A35D5067A43E8E10@DM6PR12MB3097.namprd12.prod.outlook.com>
References: <CAFvQSYQqneGVka+uyZjs1RsFNFkXZqYmz9pTP6=8uhUP0ddHAQ@mail.gmail.com>, 
 <DM6PR12MB30977EA10F8FDF64778C18CAE8E10@DM6PR12MB3097.namprd12.prod.outlook.com>,
 <DM6PR12MB309791830A01031827FE2DCAE8E10@DM6PR12MB3097.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB309791830A01031827FE2DCAE8E10@DM6PR12MB3097.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-08T19:14:06.540Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Bridgman@amd.com; 
x-originating-ip: [72.136.100.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3edfb4a2-3a7b-4f27-3792-08d7c394dfc0
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-microsoft-antispam-prvs: <DM6PR12MB289108E45E55D8B438563410E8E10@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03361FCC43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(6506007)(53546011)(33656002)(2940100002)(86362001)(71200400001)(8936002)(8676002)(5660300002)(81166006)(81156014)(9686003)(55016002)(7696005)(2906002)(186003)(66946007)(76116006)(45080400002)(478600001)(966005)(26005)(110136005)(316002)(64756008)(66556008)(52536014)(66446008)(66476007)(19627405001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2891;
 H:DM6PR12MB3097.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDxfdaVNeSRc/0+CT2DKVl2j4SVmMJoYADrkuSzQs+0T6+KD9EC4LBPPrcrNmgFjmOOTPy8s8uLJLeU38/nz9/9gd55N5wsHVvokuI5ceuVy7VuMVscMBl7Au2O06b0As2yADiZ575Ijs5RTsB9XVzVAcALXWUguWyucXKXCkJC72jirpYY/VbSBGvm4Digu/xPjY6CXeBszqRhaOB9fxyg15Vp8l0yg1Vck8RePBBMbj4J1qu+eKD4veVC5g0VZ+WdCfb8DFQ2blM7ZkOjgdQtSt830Ec85XXfr/mPLqEpLYBVROumTk7aQ1q/khf1psNMqriWYnNtCeBSokzI0zuBVCs8BTfRsKEgNpjfpMdG9C2wDN0+E+aXYhm0Vm8isONxTj5Cjxz7GQ+EqS59ixLWaWIH1ZzerwpFk/ndx+7duuCXvsgswwVvMTxgY0IGYthU+wyoP+yfOSq5Zmbb5PROk+6dR/lYAjcRbgnYNfTfeyI6LntPmPHGeDS38GqPUyy7O811bDTcxY0GRL6rAPQ==
x-ms-exchange-antispam-messagedata: Q59ym2RHccdi+8Nx//gsAAzIx0RmejvTmAS7q0UQ84QOLRp7EilTLSPweI1g1g9kjBO18jMF2njZ2e/jgTrkIqi9JWt9ZfFWlMiYQFmXadEn4eAi4qRX5pDOoR0K8iXw0gu2noUrsRLbVn/U/CRxEQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edfb4a2-3a7b-4f27-3792-08d7c394dfc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2020 19:14:07.1447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfYHv5fifFwS7af5lzX1fS605RKqPY3/P3CNhGJB5WxGbMku0AMx4tlaB5BHecqayyhvgLBddLe4j5YvQkgNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Content-Type: multipart/mixed; boundary="===============0920314802=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0920314802==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3097BAD868E86A35D5067A43E8E10DM6PR12MB3097namp_"

--_000_DM6PR12MB3097BAD868E86A35D5067A43E8E10DM6PR12MB3097namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Fixing the security tag...

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Bridgman=
, John <John.Bridgman@amd.com>
Sent: March 8, 2020 3:10 PM
To: Clemens Eisserer <linuxhippy@gmail.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)=
 with Ryzen 3700x?

OK, that's a bit strange... I found mce log and MCE-Ryzen-Decoder as option=
s for decoding.

In MCE-Ryzen-Decoder docco the example is exactly the error you are seeing,=
 with the same output, so guessing that is what you are using:

https://github.com/DimitriFourny/MCE-Ryzen-Decoder<https://nam11.safelinks.=
protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2FDimitriFourny%2FMC=
E-Ryzen-Decoder&data=3D02%7C01%7Cjohn.bridgman%40amd.com%7Ca630e03b50564f7f=
2d3508d7c3946055%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371929150785=
81327&sdata=3DN8FCig9TNL8tppMXnn9RJ2K%2BIsuYFaBJ7cHvsfhgris%3D&reserved=3D0=
>

On the other hand I found a report on AMD forums where the same error is de=
coded by mce log as a generic error in a memory transaction, which seems to=
 make more sense.

https://community.amd.com/thread/216084<https://nam11.safelinks.protection.=
outlook.com/?url=3Dhttps%3A%2F%2Fcommunity.amd.com%2Fthread%2F216084&data=
=3D02%7C01%7Cjohn.bridgman%40amd.com%7Ca630e03b50564f7f2d3508d7c3946055%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637192915078581327&sdata=3DG8MPgL=
KheVdcuA626wFpZwSgqektnTpKkEPnBqlk1QM%3D&reserved=3D0>

For something as simple as the GPU bus interface not responding to an acces=
s by the CPU I think you would get a different error (bus error) but not 10=
0% sure about that.

My first thought would be to see if your mobo BIOS has an option to force P=
CIE gen3 instead of 4 and see if that makes a difference. There are some am=
dgpu module parms related to PCIE as well but I'm not sure which ones to re=
commend.

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Bridgman=
, John <John.Bridgman@amd.com>
Sent: March 8, 2020 2:45 PM
To: Clemens Eisserer <linuxhippy@gmail.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)=
 with Ryzen 3700x?


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
=3D0<https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww=
w.reddit.com%2Fr%2Farchlinux%2Fcomments%2Fe33nyg%2Fhard_reboots_with_ryzen_=
3600x%2F&data=3D02%7C01%7Cjohn.bridgman%40amd.com%7Ca630e03b50564f7f2d3508d=
7c3946055%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637192915078591321&s=
data=3DQAbr3IkabyLUlYrR4K%2B%2BOpVbkf5BPEgNjrnDSltoQNg%3D&reserved=3D0>
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
K4U1DF0t1GtaxaUy9qHY%3D&amp;reserved=3D0<https://nam11.safelinks.protection=
.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinf=
o%2Famd-gfx&data=3D02%7C01%7Cjohn.bridgman%40amd.com%7Ca630e03b50564f7f2d35=
08d7c3946055%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63719291507860131=
6&sdata=3D2Gkq6rDmH3ZDMpYEoC27%2FL3FrHbzPWlcZ493oFEpJIk%3D&reserved=3D0>

--_000_DM6PR12MB3097BAD868E86A35D5067A43E8E10DM6PR12MB3097namp_
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
Fixing the security tag...<br>
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
-bounces@lists.freedesktop.org&gt; on behalf of Bridgman, John &lt;John.Bri=
dgman@amd.com&gt;<br>
<b>Sent:</b> March 8, 2020 3:10 PM<br>
<b>To:</b> Clemens Eisserer &lt;linuxhippy@gmail.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: Possibility of RX570 responsible for spontaneous reboot=
s (MCE) with Ryzen 3700x?</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
OK, that's a bit strange... I found mce log and MCE-Ryzen-Decoder as option=
s for decoding.
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
In MCE-Ryzen-Decoder docco the example is exactly the error you are seeing,=
 with the same output, so guessing that is what you are using:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fgithub.com%2FDimitriFourny%2FMCE-Ryzen-Decoder&amp;data=3D02%7C01%7Cjoh=
n.bridgman%40amd.com%7Ca630e03b50564f7f2d3508d7c3946055%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637192915078581327&amp;sdata=3DN8FCig9TNL8tppMXnn=
9RJ2K%2BIsuYFaBJ7cHvsfhgris%3D&amp;reserved=3D0" originalsrc=3D"https://git=
hub.com/DimitriFourny/MCE-Ryzen-Decoder" shash=3D"ImqtFdAH5rIgPu42Z4YN89S3x=
0pS460zY6YLJhKtBtrZsZW5MJgaK9dCVMlGb3UMAzV535&#43;lKWm&#43;KzNY1VIF9NSxovFE=
SLJXgPgY9Y7fFVvJWnGKzosEChF6lKb426OWbIbJgdihUFGm88wJxDX3KDaP9sK/tA9wTdw3VRY=
2wfM=3D">https://github.com/DimitriFourny/MCE-Ryzen-Decoder</a><br>
</div>
<div>
<div id=3D"x_appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
On the other hand I found a report on AMD forums where the same error is de=
coded by mce log as a generic error in a memory transaction, which seems to=
 make more sense.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fcommunity.amd.com%2Fthread%2F216084&amp;data=3D02%7C01%7Cjohn.bridgman%=
40amd.com%7Ca630e03b50564f7f2d3508d7c3946055%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637192915078581327&amp;sdata=3DG8MPgLKheVdcuA626wFpZwSgqektn=
TpKkEPnBqlk1QM%3D&amp;reserved=3D0" originalsrc=3D"https://community.amd.co=
m/thread/216084" shash=3D"urXVTGsiUt2jjinZtqR2cXabObkNovYbveyRs1XZPLvGq5LVr=
ayUInduW0fEAcvRyWr/BPwPruJAGSm3ObsshOLUYzP&#43;qJxuwREEwtVyBeOLCkVsI&#43;N5=
8YOvi6InVyqb2y/JaDsJlA30y3YnxDhckBaUi/j6E3yZa13u4n5lT0A=3D">https://communi=
ty.amd.com/thread/216084</a><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
For something as simple as the GPU bus interface not responding to an acces=
s by the CPU I think you would get a different error (bus error) but not 10=
0% sure about that.
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
My first thought would be to see if your mobo BIOS has an option to force P=
CIE gen3 instead of 4 and see if that makes a difference. There are some am=
dgpu module parms related to PCIE as well but I'm not sure which ones to re=
commend.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Bridgman, John &lt;John.Bri=
dgman@amd.com&gt;<br>
<b>Sent:</b> March 8, 2020 2:45 PM<br>
<b>To:</b> Clemens Eisserer &lt;linuxhippy@gmail.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: Possibility of RX570 responsible for spontaneous reboot=
s (MCE) with Ryzen 3700x?</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top:0px; margin-bott=
om:0px; font-family:Arial; font-size:10pt; color:#0078D7; margin:15pt" alig=
n=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
The decoded MCE info doesn't look right... if the last bit is a zero I beli=
eve that means the watchdog timer is not enabled.&nbsp;
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
That said, I'm not sure how the decoder you found works, but it seems like =
a bit more information would be required than what you passed in. Can you p=
oint me to the program you used ?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thanks,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
John<br>
</div>
<div>
<div id=3D"x_x_appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" fa=
ce=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-g=
fx-bounces@lists.freedesktop.org&gt; on behalf of Clemens Eisserer &lt;linu=
xhippy@gmail.com&gt;<br>
<b>Sent:</b> March 8, 2020 9:06 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Possibility of RX570 responsible for spontaneous reboots (M=
CE) with Ryzen 3700x?</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">Hi there,<br>
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
ryzen_3600x%2F&amp;data=3D02%7C01%7Cjohn.bridgman%40amd.com%7Ca630e03b50564=
f7f2d3508d7c3946055%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371929150=
78591321&amp;sdata=3DQAbr3IkabyLUlYrR4K%2B%2BOpVbkf5BPEgNjrnDSltoQNg%3D&amp=
;reserved=3D0" originalsrc=3D"https://www.reddit.com/r/archlinux/comments/e=
33nyg/hard_reboots_with_ryzen_3600x/" shash=3D"clreb6ZaMOO6LjVlNgWQDudUY8B&=
#43;G13uKGWSVEWn57YSHXpHlMVT90EEZvockX1SLXq5iTg7Bk5HfF3bzh6RvRhb3yqWB1DSfEi=
kiN/pfxxFYpzkZq3SVMIjVIoez1pB9Mcut3Jp2yhKuZY1XTqaUTqHYHZXRyK1W3OTaNCSGQQ=3D=
">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.r=
eddit.com%2Fr%2Farchlinux%2Fcomments%2Fe33nyg%2Fhard_reboots_with_ryzen_360=
0x%2F&amp;amp;data=3D02%7C01%7Cjohn.bridgman%40amd.com%7C683b51328ba1471c11=
3c08d7c3619d90%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637192697111254=
592&amp;amp;sdata=3D4TuB0a0VHxTqd8R0xLwxg%2BOv1vu8C7L%2FLW4O0EOiq1I%3D&amp;=
amp;reserved=3D0</a><br>
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
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Cjohn.bridgman%40amd.com%7Ca630e03b50564f7f2d3508d7c3946055%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637192915078601316&amp;sdata=3D2Gkq6rDmH3ZD=
MpYEoC27%2FL3FrHbzPWlcZ493oFEpJIk%3D&amp;reserved=3D0" originalsrc=3D"https=
://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash=3D"NxJ5nqv&#43;8rF=
woMyJ6NUDTFejf2gXKg/PDfaASkGAAtuLCH3ShXb7EKdNzuFKG5MZYWgibbY&#43;gbFUUgdbRZ=
tr3dsCyuUuDAm&#43;CiX9qqSlje8SOUo4yXqS4nN&#43;9Bur&#43;PjEGDHwVojZ92vB2thdw=
eE3whjCzuJeyyP6ktCRGcekrgE=3D">https://nam11.safelinks.protection.outlook.c=
om/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gf=
x&amp;amp;data=3D02%7C01%7Cjohn.bridgman%40amd.com%7C683b51328ba1471c113c08=
d7c3619d90%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637192697111264585&=
amp;amp;sdata=3DL52zHeIm8GzEr5eYjUDm5bPK4U1DF0t1GtaxaUy9qHY%3D&amp;amp;rese=
rved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3097BAD868E86A35D5067A43E8E10DM6PR12MB3097namp_--

--===============0920314802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0920314802==--
