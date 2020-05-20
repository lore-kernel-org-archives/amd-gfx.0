Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA369C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 01:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6030020756
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 01:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1YyYJYoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6030020756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2C46E3C4;
	Wed, 20 May 2020 01:20:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700069.outbound.protection.outlook.com [40.107.70.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D48D6E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 01:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMztBewJcjWzPXk8ReQCt0ixg56kYQL6EZNmYE0H7eP48yH9Njd8Q+gSE8GvI/KvB1d+diGG+y3OdzO7JJmKPPhrkQ3u/zsuummtNs8U06ASs+JWBzxnMsetaH9Owk6zzEPeGgvc6dT0ShvDToTBFJx/APmS2q3cjA0CCXAHOD19mNR+yZgiz9WIEH624xdTa2YFLNKA5zWvUXsdOw45arnfcV6irTfS4F5e1bw2bHOVVofHZTDdNw0fmPI4zyfBI7dYGhmKHEYsUtF5W8Wx3mIz1guHSFrxPpPDvCjEgemvgoQN0f8DFNbsWL5G9YxlFtFto3aoZMH0E55woncu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsTyOEFx711k7aIBGJGUx53rSq+vMa9GtMBka04j5uo=;
 b=U3I7OL34q8Bu3b4DdaB72XMuZrzexFD20ubl+Wddy9y57SSaGdlgve6p9QMu9Y9Uovu7hEV3mSCCASImZ46RgP8fyCqf9kgEkZ3ojgO48DCoa4+vOFmRY+EYIaja/0FRJS622o8NSs9gM7d31jLHyP2j1SfzTMqLqaqrVokjSsOXWTbVNUHkgpce6Nm8ur0+RXBaN8mlx+cX35zX8vewKBa9KB3jpqvX2o5IpnnTeOkiTGPRmZxbi6+zhhLNV6cXG/G4JRfnBcCbOAPaDgQHoP4Jv9MCUBSY0O399e+K769dXIQt5Ae/nCVX7Kob1hAE5G+fLTzj+4fSt4ghA0Pi/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsTyOEFx711k7aIBGJGUx53rSq+vMa9GtMBka04j5uo=;
 b=1YyYJYoLgUtZT3BduodIqIqh6dZ6wN94wFFVUxFkLYO6Vcg2Jla2D7ZEyMPYKJXXj6DFphk0EiNkm7YJZBKx1Zst8+DAuRj9wXvR5AAh945aq8NWzmGZ7TqxoGk0Rloy2lz1iE3410N13daFCjGBwJHpBXH7FoxmLdARclmZjCo=
Received: from DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25)
 by DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Wed, 20 May
 2020 01:20:39 +0000
Received: from DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::90c4:f2:4919:845]) by DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::90c4:f2:4919:845%6]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 01:20:39 +0000
From: "Bridgman, John" <John.Bridgman@amd.com>
To: Javad Karabi <karabijavad@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: slow rx 5600 xt fps
Thread-Topic: slow rx 5600 xt fps
Thread-Index: AQHWLg+pBUAl/S5MvEOP7b+V1qoxVaivxyIAgAAB5gCAAAavgIAAGOmAgAACWACAAAWygIAAO9uAgAAAiZY=
Date: Wed, 20 May 2020 01:20:39 +0000
Message-ID: <DM6PR12MB3097F4ACE6F41E4EE925BD4FE8B60@DM6PR12MB3097.namprd12.prod.outlook.com>
References: <CAEOHGOm=g_VGa5939Qi_HEXAfuUKuy3tXURx9TKg+n==dUDqPQ@mail.gmail.com>
 <CADnq5_N-vLuyqo_rqjy44nwdKPWyiO8cpAJN9pFk79wjwKi7gw@mail.gmail.com>
 <CAEOHGOkbu5jy_1_bUD4H0U89YEc_9zOxsSdyZqmtqZNsdOyDkg@mail.gmail.com>
 <CAEOHGOkRYXZWN-20VagBEFFywRT=26xphP3JQeQD4AJuxxzg+Q@mail.gmail.com>
 <CADnq5_Nc+eoCKsQrHA-u0d7trv=MM=5iKv5G1R3TMCyot40OjA@mail.gmail.com>
 <CAEOHGOk-YO_B3gS7WayrBEAO4oxrUAGtR0o9ZzW8ehOypuc1YA@mail.gmail.com>
 <CADnq5_M2R93S6aQn8XtrC_JdHhB=ajC17D780koNvdnDFbWCpA@mail.gmail.com>,
 <CAEOHGO=Tgook7i5R5Ucxn3Pg4ovZe+Fak5rntZ2P+UuwDJ+-Vg@mail.gmail.com>
In-Reply-To: <CAEOHGO=Tgook7i5R5Ucxn3Pg4ovZe+Fak5rntZ2P+UuwDJ+-Vg@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-20T01:20:38.299Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.139.197.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e32e27d2-b9bf-472b-ddd1-08d7fc5c01d6
x-ms-traffictypediagnostic: DM6PR12MB2794:
x-microsoft-antispam-prvs: <DM6PR12MB27947BAABB540FEFDB15DD67E8B60@DM6PR12MB2794.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bh91RXP1Eoj7wWkF02aIhnRQ4pTEptPYZDuSF3DMGTcRy1xdCRIkDPjyNrs4YVlCyn0LcUpjohky/hs3dDtQSu2HCL+qRqDcubggQHfTyKybhHaQ96dXyNCPVPxRBIKHlX0mdFgHcVPLGuQlspdJhbZgnmE3kic7XyyLZKjr1M3kBo8Ga69NcULXTZ8XvikyTT7xgJGm4eKnbzs0uC1QVN7phhmJXi1nZ8qb539HZ/NOUraDWNAjVvOa4kHD5SODLEdLmnzvjR642P+AR9fWZX3PMW0SY8vcchJILQP9gUFU8zgm5VRuKqP7bHYnX4sVMUOrUiugDdxJDkw+T54cflVtFfkIv7Gg5107BX2bCfl189wHGU7fdoELmvvwsqcdJp8jyFhEqVYnzekMBkCr+H5/H36Vh/Dx9KmvDrY53Ufi8ZDQHRNBHkhqEDNlzorFaxEuepZSyrE+bQ8WVS7OwiJrPkN/c0BLMGUGbD2sDKo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3097.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(64756008)(76116006)(66556008)(66476007)(66946007)(52536014)(110136005)(316002)(19627405001)(33656002)(71200400001)(186003)(45080400002)(478600001)(86362001)(9686003)(55016002)(5660300002)(66574014)(26005)(66446008)(7696005)(8676002)(166002)(2906002)(966005)(6506007)(8936002)(4326008)(30864003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4QY5KCKkjiqlwwpFk0ffeiaWjiSn3uLYIFgr9+lrsdlO6/KJ0/+7w6VsM5v/cVw9tRuk9O7uYIRhw63G5Sk61NCBoIK1IW8hYs5PqhdZ8b7UQLWzc7naYkF9fBe/P1ZTkq0560MpRE7/KfoLLNVHPDI9Oktq/xil6Dz8ftrI6uTh5Ogyq8xL1Y8ZJH59MNna8iT4AoZSFiJ6mcqi9WBzqdcaZhf9fxvZK7DFCy6Y3MTj1ea48Oom/3yIEnl9KKB2BNjOxjBEB4ebqMknNdy49yo3GkedYYjdxBPHFTTapFSdYGyMiiKinQgtuNfA7pz/4011rIIzukRMyQkjVNPC2sbMoELsmcnCGle9saET0onrixkzzw2/93BteX8qzzKCVZu9eASKflWw73urifUHAcEkdJMdFhFh7MkmFpcq/+9+5FT2D+PdxBxeS8xgcLtz1PqzULzvxseAXFnMAV+ufjk1aXdirwvVXz49bWdBIn8jRr/ABtKlkoQceguYdoyS
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32e27d2-b9bf-472b-ddd1-08d7fc5c01d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 01:20:39.3694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quiFBYH8yZz7S7xvBlxkOp2gEmcw/W3ml6NdBiNBvjHdmVXc7X9yAEroJO8Mc7wKULH7YAPmQ7fLFZ0j97qh0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0733974091=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0733974091==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3097F4ACE6F41E4EE925BD4FE8B60DM6PR12MB3097namp_"

--_000_DM6PR12MB3097F4ACE6F41E4EE925BD4FE8B60DM6PR12MB3097namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Suggest you use something more demanding that glxgears as a test - part of =
the problem is that glxgears runs so fast normally (30x faster than your di=
splay) that even a small amount of overhead copying a frame from one place =
to another makes a huge difference in FPS.

If you use a test program that normally runs at 90 FPS you'll probably find=
 that the "slow" speed is something like 85 FPS, rather than the 6:1 differ=
ence you see with glxgears.

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Javad Ka=
rabi <karabijavad@gmail.com>
Sent: May 19, 2020 9:16 PM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: slow rx 5600 xt fps

thanks for the answers alex.

so, i went ahead and got a displayport cable to see if that changes
anything. and now, when i run monitor only, and the monitor connected
to the card, it has no issues like before! so i am thinking that
somethings up with either the hdmi cable, or some hdmi related setting
in my system? who knows, but im just gonna roll with only using
displayport cables now.
the previous hdmi cable was actually pretty long, because i was
extending it with an hdmi extension cable, so maybe the signal was
really bad or something :/

but yea, i guess the only real issue now is maybe something simple
related to some sysfs entry about enabling some powermode, voltage,
clock frequency, or something, so that glxgears will give me more than
300 fps. but atleast now i can use a single monitor configuration with
the monitor displayported up to the card.

also, one other thing i think you might be interested in, that was
happening before.

so, previously, with laptop -tb3-> egpu-hdmi> monitor, there was a
funny thing happening which i never could figure out.
when i would look at the X logs, i would see that "modesetting" (for
the intel integrated graphics) was reporting that MonitorA was used
with "eDP-1",  which is correct and what i expected.
when i scrolled further down, i then saw that "HDMI-A-1-2" was being
used for another MonitorB, which also is what i expected (albeit i
have no idea why its saying A-1-2)
but amdgpu was _also_ saying that DisplayPort-1-2 (a port on the
radeon card) was being used for MonitorA, which is the same Monitor
that the modesetting driver had claimed to be using with eDP-1!

so the point is that amdgpu was "using" Monitor0 with DisplayPort-1-2,
although that is what modesetting was using for eDP-1.

anyway, thats a little aside, i doubt it was related to the terrible
hdmi experience i was getting, since its about display port and stuff,
but i thought id let you know about that.

if you think that is a possible issue, im more than happy to plug the
hdmi setup back in and create an issue on gitlab with the logs and
everything

On Tue, May 19, 2020 at 4:42 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, May 19, 2020 at 5:22 PM Javad Karabi <karabijavad@gmail.com> wrot=
e:
> >
> > lol youre quick!
> >
> > "Windows has supported peer to peer DMA for years so it already has a
> > numbers of optimizations that are only now becoming possible on Linux"
> >
> > whoa, i figured linux would be ahead of windows when it comes to
> > things like that. but peer-to-peer dma is something that is only
> > recently possible on linux, but has been possible on windows? what
> > changed recently that allows for peer to peer dma in linux?
> >
>
> A few things that made this more complicated on Linux:
> 1. Linux uses IOMMUs more extensively than windows so you can't just
> pass around physical bus addresses.
> 2. Linux supports lots of strange architectures that have a lot of
> limitations with respect to peer to peer transactions
>
> It just took years to get all the necessary bits in place in Linux and
> make everyone happy.
>
> > also, in the context of a game running opengl on some gpu, is the
> > "peer-to-peer" dma transfer something like: the game draw's to some
> > memory it has allocated, then a DMA transfer gets that and moves it
> > into the graphics card output?
>
> Peer to peer DMA just lets devices access another devices local memory
> directly.  So if you have a buffer in vram on one device, you can
> share that directly with another device rather than having to copy it
> to system memory first.  For example, if you have two GPUs, you can
> have one of them copy it's content directly to a buffer in the other
> GPU's vram rather than having to go through system memory first.
>
> >
> > also, i know it can be super annoying trying to debug an issue like
> > this, with someone like me who has all types of differences from a
> > normal setup (e.g. using it via egpu, using a kernel with custom
> > configs and stuff) so as a token of my appreciation i donated 50$ to
> > the red cross' corona virus outbreak charity thing, on behalf of
> > amd-gfx.
>
> Thanks,
>
> Alex
>
> >
> > On Tue, May 19, 2020 at 4:13 PM Alex Deucher <alexdeucher@gmail.com> wr=
ote:
> > >
> > > On Tue, May 19, 2020 at 3:44 PM Javad Karabi <karabijavad@gmail.com> =
wrote:
> > > >
> > > > just a couple more questions:
> > > >
> > > > - based on what you are aware of, the technical details such as
> > > > "shared buffers go through system memory", and all that, do you see
> > > > any issues that might exist that i might be missing in my setup? i
> > > > cant imagine this being the case because the card works great in
> > > > windows, unless the windows driver does something different?
> > > >
> > >
> > > Windows has supported peer to peer DMA for years so it already has a
> > > numbers of optimizations that are only now becoming possible on Linux=
.
> > >
> > > > - as far as kernel config, is there anything in particular which
> > > > _should_ or _should not_ be enabled/disabled?
> > >
> > > You'll need the GPU drivers for your devices and dma-buf support.
> > >
> > > >
> > > > - does the vendor matter? for instance, this is an xfx card. when i=
t
> > > > comes to different vendors, are there interface changes that might
> > > > make one vendor work better for linux than another? i dont really
> > > > understand the differences in vendors, but i imagine that the vbios
> > > > differs between vendors, and as such, the linux compatibility would
> > > > maybe change?
> > >
> > > board vendor shouldn't matter.
> > >
> > > >
> > > > - is the pcie bandwidth possible an issue? the pcie_bw file changes
> > > > between values like this:
> > > > 18446683600662707640 18446744071581623085 128
> > > > and sometimes i see this:
> > > > 4096 0 128
> > > > as you can see, the second value seems significantly lower. is that
> > > > possibly an issue? possibly due to aspm?
> > >
> > > pcie_bw is not implemented for navi yet so you are just seeing
> > > uninitialized data.  This patch set should clear that up.
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
atchwork.freedesktop.org%2Fpatch%2F366262%2F&amp;data=3D02%7C01%7Cjohn.brid=
gman%40amd.com%7C07bde460768d4af97a0a08d7fc5b7e3f%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637255342498350409&amp;sdata=3DLnoK84DCjYelteqMR7w2UZ2V=
H6lM0vojz9eeTH7odXI%3D&amp;reserved=3D0
> > >
> > > Alex
> > >
> > > >
> > > > On Tue, May 19, 2020 at 2:20 PM Javad Karabi <karabijavad@gmail.com=
> wrote:
> > > > >
> > > > > im using Driver "amdgpu" in my xorg conf
> > > > >
> > > > > how does one verify which gpu is the primary? im assuming my inte=
l
> > > > > card is the primary, since i have not done anything to change tha=
t.
> > > > >
> > > > > also, if all shared buffers have to go through system memory, the=
n
> > > > > that means an eGPU amdgpu wont work very well in general right?
> > > > > because going through system memory for the egpu means going over=
 the
> > > > > thunderbolt connection
> > > > >
> > > > > and what are the shared buffers youre referring to? for example, =
if an
> > > > > application is drawing to a buffer, is that an example of a share=
d
> > > > > buffer that has to go through system memory? if so, thats fine, r=
ight?
> > > > > because the application's memory is in system memory, so that cop=
y
> > > > > wouldnt be an issue.
> > > > >
> > > > > in general, do you think the "copy buffer across system memory mi=
ght
> > > > > be a hindrance for thunderbolt? im trying to figure out which
> > > > > directions to go to debug and im totally lost, so maybe i can do =
some
> > > > > testing that direction?
> > > > >
> > > > > and for what its worth, when i turn the display "off" via the gno=
me
> > > > > display settings, its the same issue as when the laptop lid is cl=
osed,
> > > > > so unless the motherboard reads the "closed lid" the same as "dis=
play
> > > > > off", then im not sure if its thermal issues.
> > > > >
> > > > > On Tue, May 19, 2020 at 2:14 PM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> > > > > >
> > > > > > On Tue, May 19, 2020 at 2:59 PM Javad Karabi <karabijavad@gmail=
.com> wrote:
> > > > > > >
> > > > > > > given this setup:
> > > > > > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2 -h=
dmi-> monitor
> > > > > > > DRI_PRIME=3D1 glxgears gears gives me ~300fps
> > > > > > >
> > > > > > > given this setup:
> > > > > > > laptop -thunderbolt-> razer core x -> xfx rx 5600 xt raw 2
> > > > > > > laptop -hdmi-> monitor
> > > > > > >
> > > > > > > glx gears gives me ~1800fps
> > > > > > >
> > > > > > > this doesnt make sense to me because i thought that having th=
e monitor
> > > > > > > plugged directly into the card should give best performance.
> > > > > > >
> > > > > >
> > > > > > Do you have displays connected to both GPUs?  If you are using =
X which
> > > > > > ddx are you using?  xf86-video-modesetting or xf86-video-amdgpu=
?
> > > > > > IIRC, xf86-video-amdgpu has some optimizations for prime which =
are not
> > > > > > yet in xf86-video-modesetting.  Which GPU is set up as the prim=
ary?
> > > > > > Note that the GPU which does the rendering is not necessarily t=
he one
> > > > > > that the displays are attached to.  The render GPU renders to i=
t's
> > > > > > render buffer and then that data may end up being copied other =
GPUs
> > > > > > for display.  Also, at this point, all shared buffers have to g=
o
> > > > > > through system memory (this will be changing eventually now tha=
t we
> > > > > > support device memory via dma-buf), so there is often an extra =
copy
> > > > > > involved.
> > > > > >
> > > > > > > theres another really weird issue...
> > > > > > >
> > > > > > > given setup 1, where the monitor is plugged in to the card:
> > > > > > > when i close the laptop lid, my monitor is "active" and whatn=
ot, and i
> > > > > > > can "use it" in a sense
> > > > > > >
> > > > > > > however, heres the weirdness:
> > > > > > > the mouse cursor will move along the monitor perfectly smooth=
 and
> > > > > > > fine, but all the other updates to the screen are delayed by =
about 2
> > > > > > > or 3 seconds.
> > > > > > > that is to say, its as if the laptop is doing everything (e.g=
. if i
> > > > > > > open a terminal, the terminal will open, but it will take 2 s=
econds
> > > > > > > for me to see it)
> > > > > > >
> > > > > > > its almost as if all the frames and everything are being draw=
n, and
> > > > > > > the laptop is running fine and everything, but i simply just =
dont get
> > > > > > > to see it on the monitor, except for one time every 2 seconds=
.
> > > > > > >
> > > > > > > its hard to articulate, because its so bizarre. its not like,=
 a "low
> > > > > > > fps" per se, because the cursor is totally smooth. but its th=
at
> > > > > > > _everything else_ is only updated once every couple seconds.
> > > > > >
> > > > > > This might also be related to which GPU is the primary.  It sti=
ll may
> > > > > > be the integrated GPU since that is what is attached to the lap=
top
> > > > > > panel.  Also the platform and some drivers may do certain thing=
s when
> > > > > > the lid is closed.  E.g., for thermal reasons, the integrated G=
PU or
> > > > > > CPU may have a more limited TDP because the laptop cannot cool =
as
> > > > > > efficiently.
> > > > > >
> > > > > > Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cjohn.bri=
dgman%40amd.com%7C07bde460768d4af97a0a08d7fc5b7e3f%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637255342498350409&amp;sdata=3Dh%2BvYNKSx6vPQ5PNDKW2dB=
O3I4oEr3wV%2FkyLHJv08e6A%3D&amp;reserved=3D0

--_000_DM6PR12MB3097F4ACE6F41E4EE925BD4FE8B60DM6PR12MB3097namp_
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
Suggest you use something more demanding that glxgears as a test - part of =
the problem is that glxgears runs so fast normally (30x faster than your di=
splay) that even a small amount of overhead copying a frame from one place =
to another makes a huge difference
 in FPS. <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If you use a test program that normally runs at 90 FPS you'll probably find=
 that the &quot;slow&quot; speed is something like 85 FPS, rather than the =
6:1 difference you see with glxgears.
<br>
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
-bounces@lists.freedesktop.org&gt; on behalf of Javad Karabi &lt;karabijava=
d@gmail.com&gt;<br>
<b>Sent:</b> May 19, 2020 9:16 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: slow rx 5600 xt fps</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">thanks for the answers alex.<br>
<br>
so, i went ahead and got a displayport cable to see if that changes<br>
anything. and now, when i run monitor only, and the monitor connected<br>
to the card, it has no issues like before! so i am thinking that<br>
somethings up with either the hdmi cable, or some hdmi related setting<br>
in my system? who knows, but im just gonna roll with only using<br>
displayport cables now.<br>
the previous hdmi cable was actually pretty long, because i was<br>
extending it with an hdmi extension cable, so maybe the signal was<br>
really bad or something :/<br>
<br>
but yea, i guess the only real issue now is maybe something simple<br>
related to some sysfs entry about enabling some powermode, voltage,<br>
clock frequency, or something, so that glxgears will give me more than<br>
300 fps. but atleast now i can use a single monitor configuration with<br>
the monitor displayported up to the card.<br>
<br>
also, one other thing i think you might be interested in, that was<br>
happening before.<br>
<br>
so, previously, with laptop -tb3-&gt; egpu-hdmi&gt; monitor, there was a<br=
>
funny thing happening which i never could figure out.<br>
when i would look at the X logs, i would see that &quot;modesetting&quot; (=
for<br>
the intel integrated graphics) was reporting that MonitorA was used<br>
with &quot;eDP-1&quot;,&nbsp; which is correct and what i expected.<br>
when i scrolled further down, i then saw that &quot;HDMI-A-1-2&quot; was be=
ing<br>
used for another MonitorB, which also is what i expected (albeit i<br>
have no idea why its saying A-1-2)<br>
but amdgpu was _also_ saying that DisplayPort-1-2 (a port on the<br>
radeon card) was being used for MonitorA, which is the same Monitor<br>
that the modesetting driver had claimed to be using with eDP-1!<br>
<br>
so the point is that amdgpu was &quot;using&quot; Monitor0 with DisplayPort=
-1-2,<br>
although that is what modesetting was using for eDP-1.<br>
<br>
anyway, thats a little aside, i doubt it was related to the terrible<br>
hdmi experience i was getting, since its about display port and stuff,<br>
but i thought id let you know about that.<br>
<br>
if you think that is a possible issue, im more than happy to plug the<br>
hdmi setup back in and create an issue on gitlab with the logs and<br>
everything<br>
<br>
On Tue, May 19, 2020 at 4:42 PM Alex Deucher &lt;alexdeucher@gmail.com&gt; =
wrote:<br>
&gt;<br>
&gt; On Tue, May 19, 2020 at 5:22 PM Javad Karabi &lt;karabijavad@gmail.com=
&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; lol youre quick!<br>
&gt; &gt;<br>
&gt; &gt; &quot;Windows has supported peer to peer DMA for years so it alre=
ady has a<br>
&gt; &gt; numbers of optimizations that are only now becoming possible on L=
inux&quot;<br>
&gt; &gt;<br>
&gt; &gt; whoa, i figured linux would be ahead of windows when it comes to<=
br>
&gt; &gt; things like that. but peer-to-peer dma is something that is only<=
br>
&gt; &gt; recently possible on linux, but has been possible on windows? wha=
t<br>
&gt; &gt; changed recently that allows for peer to peer dma in linux?<br>
&gt; &gt;<br>
&gt;<br>
&gt; A few things that made this more complicated on Linux:<br>
&gt; 1. Linux uses IOMMUs more extensively than windows so you can't just<b=
r>
&gt; pass around physical bus addresses.<br>
&gt; 2. Linux supports lots of strange architectures that have a lot of<br>
&gt; limitations with respect to peer to peer transactions<br>
&gt;<br>
&gt; It just took years to get all the necessary bits in place in Linux and=
<br>
&gt; make everyone happy.<br>
&gt;<br>
&gt; &gt; also, in the context of a game running opengl on some gpu, is the=
<br>
&gt; &gt; &quot;peer-to-peer&quot; dma transfer something like: the game dr=
aw's to some<br>
&gt; &gt; memory it has allocated, then a DMA transfer gets that and moves =
it<br>
&gt; &gt; into the graphics card output?<br>
&gt;<br>
&gt; Peer to peer DMA just lets devices access another devices local memory=
<br>
&gt; directly.&nbsp; So if you have a buffer in vram on one device, you can=
<br>
&gt; share that directly with another device rather than having to copy it<=
br>
&gt; to system memory first.&nbsp; For example, if you have two GPUs, you c=
an<br>
&gt; have one of them copy it's content directly to a buffer in the other<b=
r>
&gt; GPU's vram rather than having to go through system memory first.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; also, i know it can be super annoying trying to debug an issue li=
ke<br>
&gt; &gt; this, with someone like me who has all types of differences from =
a<br>
&gt; &gt; normal setup (e.g. using it via egpu, using a kernel with custom<=
br>
&gt; &gt; configs and stuff) so as a token of my appreciation i donated 50$=
 to<br>
&gt; &gt; the red cross' corona virus outbreak charity thing, on behalf of<=
br>
&gt; &gt; amd-gfx.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; On Tue, May 19, 2020 at 4:13 PM Alex Deucher &lt;alexdeucher@gmai=
l.com&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Tue, May 19, 2020 at 3:44 PM Javad Karabi &lt;karabijavad=
@gmail.com&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; just a couple more questions:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - based on what you are aware of, the technical details=
 such as<br>
&gt; &gt; &gt; &gt; &quot;shared buffers go through system memory&quot;, an=
d all that, do you see<br>
&gt; &gt; &gt; &gt; any issues that might exist that i might be missing in =
my setup? i<br>
&gt; &gt; &gt; &gt; cant imagine this being the case because the card works=
 great in<br>
&gt; &gt; &gt; &gt; windows, unless the windows driver does something diffe=
rent?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Windows has supported peer to peer DMA for years so it alrea=
dy has a<br>
&gt; &gt; &gt; numbers of optimizations that are only now becoming possible=
 on Linux.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - as far as kernel config, is there anything in particu=
lar which<br>
&gt; &gt; &gt; &gt; _should_ or _should not_ be enabled/disabled?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; You'll need the GPU drivers for your devices and dma-buf sup=
port.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - does the vendor matter? for instance, this is an xfx =
card. when it<br>
&gt; &gt; &gt; &gt; comes to different vendors, are there interface changes=
 that might<br>
&gt; &gt; &gt; &gt; make one vendor work better for linux than another? i d=
ont really<br>
&gt; &gt; &gt; &gt; understand the differences in vendors, but i imagine th=
at the vbios<br>
&gt; &gt; &gt; &gt; differs between vendors, and as such, the linux compati=
bility would<br>
&gt; &gt; &gt; &gt; maybe change?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; board vendor shouldn't matter.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - is the pcie bandwidth possible an issue? the pcie_bw =
file changes<br>
&gt; &gt; &gt; &gt; between values like this:<br>
&gt; &gt; &gt; &gt; 18446683600662707640 18446744071581623085 128<br>
&gt; &gt; &gt; &gt; and sometimes i see this:<br>
&gt; &gt; &gt; &gt; 4096 0 128<br>
&gt; &gt; &gt; &gt; as you can see, the second value seems significantly lo=
wer. is that<br>
&gt; &gt; &gt; &gt; possibly an issue? possibly due to aspm?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; pcie_bw is not implemented for navi yet so you are just seei=
ng<br>
&gt; &gt; &gt; uninitialized data.&nbsp; This patch set should clear that u=
p.<br>
&gt; &gt; &gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?u=
rl=3Dhttps%3A%2F%2Fpatchwork.freedesktop.org%2Fpatch%2F366262%2F&amp;amp;da=
ta=3D02%7C01%7Cjohn.bridgman%40amd.com%7C07bde460768d4af97a0a08d7fc5b7e3f%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637255342498350409&amp;amp;sdat=
a=3DLnoK84DCjYelteqMR7w2UZ2VH6lM0vojz9eeTH7odXI%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fpatch%2F366262%2F&amp;amp;data=3D02%7C01%7Cjohn.bridgm=
an%40amd.com%7C07bde460768d4af97a0a08d7fc5b7e3f%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637255342498350409&amp;amp;sdata=3DLnoK84DCjYelteqMR7w2UZ=
2VH6lM0vojz9eeTH7odXI%3D&amp;amp;reserved=3D0</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Alex<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Tue, May 19, 2020 at 2:20 PM Javad Karabi &lt;karabi=
javad@gmail.com&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; im using Driver &quot;amdgpu&quot; in my xorg conf=
<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; how does one verify which gpu is the primary? im a=
ssuming my intel<br>
&gt; &gt; &gt; &gt; &gt; card is the primary, since i have not done anythin=
g to change that.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; also, if all shared buffers have to go through sys=
tem memory, then<br>
&gt; &gt; &gt; &gt; &gt; that means an eGPU amdgpu wont work very well in g=
eneral right?<br>
&gt; &gt; &gt; &gt; &gt; because going through system memory for the egpu m=
eans going over the<br>
&gt; &gt; &gt; &gt; &gt; thunderbolt connection<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; and what are the shared buffers youre referring to=
? for example, if an<br>
&gt; &gt; &gt; &gt; &gt; application is drawing to a buffer, is that an exa=
mple of a shared<br>
&gt; &gt; &gt; &gt; &gt; buffer that has to go through system memory? if so=
, thats fine, right?<br>
&gt; &gt; &gt; &gt; &gt; because the application's memory is in system memo=
ry, so that copy<br>
&gt; &gt; &gt; &gt; &gt; wouldnt be an issue.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; in general, do you think the &quot;copy buffer acr=
oss system memory might<br>
&gt; &gt; &gt; &gt; &gt; be a hindrance for thunderbolt? im trying to figur=
e out which<br>
&gt; &gt; &gt; &gt; &gt; directions to go to debug and im totally lost, so =
maybe i can do some<br>
&gt; &gt; &gt; &gt; &gt; testing that direction?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; and for what its worth, when i turn the display &q=
uot;off&quot; via the gnome<br>
&gt; &gt; &gt; &gt; &gt; display settings, its the same issue as when the l=
aptop lid is closed,<br>
&gt; &gt; &gt; &gt; &gt; so unless the motherboard reads the &quot;closed l=
id&quot; the same as &quot;display<br>
&gt; &gt; &gt; &gt; &gt; off&quot;, then im not sure if its thermal issues.=
<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Tue, May 19, 2020 at 2:14 PM Alex Deucher &lt;a=
lexdeucher@gmail.com&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Tue, May 19, 2020 at 2:59 PM Javad Karabi =
&lt;karabijavad@gmail.com&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; given this setup:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; laptop -thunderbolt-&gt; razer core x -&=
gt; xfx rx 5600 xt raw 2 -hdmi-&gt; monitor<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; DRI_PRIME=3D1 glxgears gears gives me ~3=
00fps<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; given this setup:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; laptop -thunderbolt-&gt; razer core x -&=
gt; xfx rx 5600 xt raw 2<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; laptop -hdmi-&gt; monitor<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; glx gears gives me ~1800fps<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; this doesnt make sense to me because i t=
hought that having the monitor<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; plugged directly into the card should gi=
ve best performance.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Do you have displays connected to both GPUs?&=
nbsp; If you are using X which<br>
&gt; &gt; &gt; &gt; &gt; &gt; ddx are you using?&nbsp; xf86-video-modesetti=
ng or xf86-video-amdgpu?<br>
&gt; &gt; &gt; &gt; &gt; &gt; IIRC, xf86-video-amdgpu has some optimization=
s for prime which are not<br>
&gt; &gt; &gt; &gt; &gt; &gt; yet in xf86-video-modesetting.&nbsp; Which GP=
U is set up as the primary?<br>
&gt; &gt; &gt; &gt; &gt; &gt; Note that the GPU which does the rendering is=
 not necessarily the one<br>
&gt; &gt; &gt; &gt; &gt; &gt; that the displays are attached to.&nbsp; The =
render GPU renders to it's<br>
&gt; &gt; &gt; &gt; &gt; &gt; render buffer and then that data may end up b=
eing copied other GPUs<br>
&gt; &gt; &gt; &gt; &gt; &gt; for display.&nbsp; Also, at this point, all s=
hared buffers have to go<br>
&gt; &gt; &gt; &gt; &gt; &gt; through system memory (this will be changing =
eventually now that we<br>
&gt; &gt; &gt; &gt; &gt; &gt; support device memory via dma-buf), so there =
is often an extra copy<br>
&gt; &gt; &gt; &gt; &gt; &gt; involved.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; theres another really weird issue...<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; given setup 1, where the monitor is plug=
ged in to the card:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; when i close the laptop lid, my monitor =
is &quot;active&quot; and whatnot, and i<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; can &quot;use it&quot; in a sense<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; however, heres the weirdness:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; the mouse cursor will move along the mon=
itor perfectly smooth and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; fine, but all the other updates to the s=
creen are delayed by about 2<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; or 3 seconds.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; that is to say, its as if the laptop is =
doing everything (e.g. if i<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; open a terminal, the terminal will open,=
 but it will take 2 seconds<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; for me to see it)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; its almost as if all the frames and ever=
ything are being drawn, and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; the laptop is running fine and everythin=
g, but i simply just dont get<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; to see it on the monitor, except for one=
 time every 2 seconds.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; its hard to articulate, because its so b=
izarre. its not like, a &quot;low<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; fps&quot; per se, because the cursor is =
totally smooth. but its that<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; _everything else_ is only updated once e=
very couple seconds.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; This might also be related to which GPU is th=
e primary.&nbsp; It still may<br>
&gt; &gt; &gt; &gt; &gt; &gt; be the integrated GPU since that is what is a=
ttached to the laptop<br>
&gt; &gt; &gt; &gt; &gt; &gt; panel.&nbsp; Also the platform and some drive=
rs may do certain things when<br>
&gt; &gt; &gt; &gt; &gt; &gt; the lid is closed.&nbsp; E.g., for thermal re=
asons, the integrated GPU or<br>
&gt; &gt; &gt; &gt; &gt; &gt; CPU may have a more limited TDP because the l=
aptop cannot cool as<br>
&gt; &gt; &gt; &gt; &gt; &gt; efficiently.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Alex<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cjohn.bridgman%40amd.com%7C07bde460768d4af97a0a08d7fc5b7e3f%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637255342498350409&amp;amp;sdata=3Dh%2B=
vYNKSx6vPQ5PNDKW2dBO3I4oEr3wV%2FkyLHJv08e6A%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cjohn.bridg=
man%40amd.com%7C07bde460768d4af97a0a08d7fc5b7e3f%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637255342498350409&amp;amp;sdata=3Dh%2BvYNKSx6vPQ5PNDKW2=
dBO3I4oEr3wV%2FkyLHJv08e6A%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3097F4ACE6F41E4EE925BD4FE8B60DM6PR12MB3097namp_--

--===============0733974091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0733974091==--
