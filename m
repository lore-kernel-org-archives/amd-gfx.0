Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01395C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 10:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6457410F899;
	Thu,  5 May 2022 10:02:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D525410F804
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 10:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRqqQVLR5N9k1zP4xttEHHyU7xM+C4Bjb+e6TFJ2JVWTe2f/S/OOdFumnerm2Bowg49TYmZzBVt9JcnTgLXKls6SDLFaLTkt4MBs4j4lUbDceqZlihCn7124rQh1VW5X1QONxrf0qugAfz2V4rArVqsOlrZFjlxJKgxNBFkW1pSMfQTboBCKop5TRlgnwEUD2csBOZ7EERZzsflq89ghr8kX30ab9UMBa4Ve8w5NNVVKGTJV2Lx+CNP3F8z3lthMUvKCWC3W3wDDpz0KqHHA7l63QduPzxM5eQQnGs3SOD+NZW44QVzaJ3D+fWlJO7yr4rVGB5R/ETzvVJT34r7VVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yOFkithaxXj9gkXrmZZALDSDwB9ng/uWj4kEOCvG2o=;
 b=gwKALUERWMCk+/1Hr5kCyxu5u38OJPSn+PBU4thoIPC791iu4/CxPYQBXRo5C0Y3TPJ4EKN0fQNMvfQT6gpCDq5rfxVXgoLsgh+lG5gifOJ40su1Qm4+x2rFusqBcwYbMXx4EzvSK8kRG/6ecFzVyDIUAR1oW+HFJXiC9T5GfF13Gs9Ny+PxIylQMIodfI2OuLNf7iPJvemEn8ZG9YX6mSNoe3gg2S3KhdOs8IfW1rjNlhMpGJbz1qcDpzOVGD0qdnv+CJPcjNJ8sGWgl3xDYoJfqbZJaohyLPiumclUPH15kgvCLhnVoVJhvVA0Ji+IxqSM6JUEjRdq6/oH1f2omA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yOFkithaxXj9gkXrmZZALDSDwB9ng/uWj4kEOCvG2o=;
 b=InlGOtmmtMOyR3MZBomSdDsMsGUDxEWw32QjgNCZkWKf4YbHxrGzTiWppu+yr5ar0QioS3t4E4ai3IMUtmq9js6u19AZKzlcQ286bAXgD/SHZYdOrotrlJDw6HvRYwdd7OExS8y6s6aXXMkxFQIjaJTs18ccWgHa5K1kGOJNfik=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by BN8PR12MB3122.namprd12.prod.outlook.com (2603:10b6:408:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Thu, 5 May
 2022 10:02:16 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::1c90:f807:7b0b:a862]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::1c90:f807:7b0b:a862%8]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 10:02:16 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, Lyude Paul <lyude@redhat.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: Do we really need to increase/decrease MST VC payloads?
Thread-Topic: Do we really need to increase/decrease MST VC payloads?
Thread-Index: AQHYXnWxk9xTavhbfEObDNqlnlm3sq0PO8QAgABXcoCAAHfR3w==
Date: Thu, 5 May 2022 10:02:15 +0000
Message-ID: <CO6PR12MB54893ACC396FBC017AD2E276FCC29@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <dd5c63923636ec2ad78483899b1e4885e2235055.camel@redhat.com>
 <ad4ce2ddd2f2019f360b501c092680c799cb468c.camel@redhat.com>
 <BN8PR12MB334859526DE2D862EBBA0128E5C29@BN8PR12MB3348.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB334859526DE2D862EBBA0128E5C29@BN8PR12MB3348.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-05T10:02:28.239Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5feffe8-1a33-4894-1a24-08da2e7e5572
x-ms-traffictypediagnostic: BN8PR12MB3122:EE_
x-microsoft-antispam-prvs: <BN8PR12MB312219BB65CE18D0FD9ED49BFCC29@BN8PR12MB3122.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V0rXUB9Ig6FGlPd2rTXS9xIuZawqHylfaEP1Js+CoUK9lX42H65K2kMZUgKY5fEoeothP1goJU0lbZDkH777yfmXrgMbayk7tYeJaHrFXYObz1KZ1VzExwOgKSJAAEbwxd52shpY3fLqIDMvrhL+KD0vOGBc4g1OvXgSFuk4yuI0WtViOkbpmRQwCJ9gCnbsEN51TPFVH6qm5j2a0XAgF/vaPjwRUSpM4J9yG1TxNa+xYPXp9QD/WP0+PKAqkt29R8l2VVIJlpi7B3jT18PZXPgBzpHhAi4hYmiQmgotG599v/ybkzWBU866NyxXddSt37jo6gez5RFnOADrzc0qSZXn0MxJ9WuoAOyKWhLs2BI0hbK1pzTanpfENaFL+HK6V3ShAeI6u83/Ridi4fneg5A/fMzOutSm1Qyh5wSm3XQ9TqnmlnqcGXtreuCQZxOyTNeBHjh3M6EJOY5QYwt9v2xgpCQ58qDkCxTtgV6T30OlEm+ohZ55j5RpNFE8QMSEvPb/TKxb836YPb2hSwAy+2HevXiKzwg0FVaZdTv3lg3C0I/ewtVefdDvxKjEmOdc5bMFW/d0ParnYQjlTKp5jYeN9h467eosfV4Rf69yDMYqouVdL2h2eabtfPn7/nhOYvTZgRJ+yrViJXtWx0+A5yJuHYDIrWPLAXfF2gwilcwNnkRrc+lRM0opV9HXrSv8vtnCYTmlqUVAbLFR3WIOsaBrudKtWG8IEdmKvmhbtmHN//FYoZ1JTvlV+55W4f4k7ecSHfqWSziNtK+MVng1+q/LR9BfukqXESgTDeV7fP4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(86362001)(186003)(64756008)(8676002)(66946007)(76116006)(9686003)(966005)(26005)(66446008)(91956017)(508600001)(71200400001)(38070700005)(38100700002)(45080400002)(110136005)(8936002)(316002)(6506007)(53546011)(122000001)(33656002)(2906002)(5660300002)(83380400001)(52536014)(55016003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dOvZkWaXmTtHNWK0YMyu/cirRNHvaB81l1idmRw5lE97IENatj6tpRZP4d?=
 =?iso-8859-1?Q?qUqRo0EbJ+9ncFUWhDJIohmt4Pe8XiiJhh1Puy/gvSyRnM/S7T3gZ1P038?=
 =?iso-8859-1?Q?xfw8/Gg6Ol30JJ+tVISX4OPMQaJA1vXgW5DXlLYKs4AHTo8JglPqWgb0G8?=
 =?iso-8859-1?Q?M4puU5cdVXQxacvGcioG7yjiJuG3HOcLFu0jDoNVjbZD0/AS2Kt92Usk8C?=
 =?iso-8859-1?Q?VUK7QT1WE2eB2VMtESgAtZu6gSZzHlemBmX6z4ljvDwzoBhvhWzjbOQnhp?=
 =?iso-8859-1?Q?vJK3hA0HrZwGaJbrWXKZLy37ZC4oSf9x0iV8pBs2sk3uZCYWRQRrWrNLHc?=
 =?iso-8859-1?Q?xLQO173581KAv/Nm8eqpFDAw6tEyqSyaK51FlqWtcpjkwf/zbO6SeGkRVW?=
 =?iso-8859-1?Q?c2Kj73EX68HjpRyHNIc2zOhIiUTicQMM6vHs0f99PC/gLePi7J458bEWBk?=
 =?iso-8859-1?Q?fwwL+qOL00bhBdOq9Yjwtd0WRUONRbYK86Z2tcnm8I5pnun/fyyQiuvX8o?=
 =?iso-8859-1?Q?gWHSNltKCqUydotTe2ovYY1jvzijx/6u83iTIBnnv/sfAUW+ATn3hFSyyX?=
 =?iso-8859-1?Q?GOTdlMwzvITyUvtGsHjeeH6vI5bK1EGCIdzsI2Hwswp+02uKJJBmZ3y+Sm?=
 =?iso-8859-1?Q?ULlcPrZ1zrferYhU6Owq0kr3wlLhxKX0PhJT9izOqd9N1rIkv7Hm3lkzOT?=
 =?iso-8859-1?Q?NxSpDlDfB9S+gN1oOAAMwErXpF/DNsB4jlrTK9onL6Bj/VIqZx6NXS4LIG?=
 =?iso-8859-1?Q?mC73iNNn2yw0mbYMD6DYeIOH1ONYmm+z4Uu73n/LaD/dBzBXadE9B0HPsQ?=
 =?iso-8859-1?Q?cq2pKej3cSJDinxWj2/OGzbWsq8TwDUWumtx79TaAcA9g1vm3ChLcz3GRC?=
 =?iso-8859-1?Q?UMavhpum2PHEP6/U9FPAhAEYz3WAI3bCHtihPoFZ+EJsMSq6ntyjnvLyIp?=
 =?iso-8859-1?Q?bUOFiQpXiW417RugZE9V5oyiV04M/1WviRLsEdrfSYpJa/sN3gtdhhyh/I?=
 =?iso-8859-1?Q?I6Ni/e5UXH5q4ieiWgs0gYMEjh415X73tHoGe43MNSk/7UVS4oIbZPyJyR?=
 =?iso-8859-1?Q?Q+6nDzUQ4AUFJSeVH7fSZEdCzb5WV0IrjLbk+YRCj7rDYdyk6KFBBPXVvy?=
 =?iso-8859-1?Q?rFE/PXAly6x8Dn9KVwUeeWoW1f5+NTWVtBPxnMdE4nx5XjLV+OYhXGTJaP?=
 =?iso-8859-1?Q?xXpO2O7p0ffY9x4lCuNuNoAxVbC4SPfu+zuMAoOQ5G9q31GGtM2wwfP6wy?=
 =?iso-8859-1?Q?2JjGmMtbCJNdblo/hjxP6io5Rn/yQLiGUno9J2xEVNGSlbmAdfyDuqo64N?=
 =?iso-8859-1?Q?C21eltvcFW1ayfYGzUfKuDwseOwIQBt3s8mS7nTmBQU7lVjsOlOSguyQQZ?=
 =?iso-8859-1?Q?4k3UuO5ag9WxQqYceJEK9lxsMrrMNOzVEBSR8Dy+PjzITv8S3HYsSx1amH?=
 =?iso-8859-1?Q?7vSRWmrdm1rqWp+EO32E17F0cl6r9eeB8eS00JCyrpBemPM4tsxndBwh0s?=
 =?iso-8859-1?Q?99rq5KEUpaxfAcFNAKU4Yt8XJ0qwa7dwXmZx1rnI90LTdlGXYh0pr7lpNU?=
 =?iso-8859-1?Q?gnie9ra15ZAmjLYyP5HwH4uN1izTjO9f7cr/1umeN/TGS4y8lthy6+oX1K?=
 =?iso-8859-1?Q?b3R7XOGOmUFiGB2AyshaSR95ng4sBG6+Pi001D27lM1pJDmsi6zeyx6GWP?=
 =?iso-8859-1?Q?EFRc9EWYHqEzLLPeFoIByNlahHeTnQF4d9OJ6s6XRkusj64hbbCLHnAL2L?=
 =?iso-8859-1?Q?eYIhXK6M1yIKMEdDB7qeFBhRUZ6cbFREmjCmKtB6/SxXV5hWeJVgV7E8zJ?=
 =?iso-8859-1?Q?QTyssHyHLw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5feffe8-1a33-4894-1a24-08da2e7e5572
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 10:02:15.9707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cx/64UEUXsPqrGT2jz0s06XsPk4lpqvi6vwP0QnxGk5GYytTuxwrQ+Ag8hYnNeZEDhf3Y9oOvF2+4hpmHtzkWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3122
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Lyude,

Thanks for raising this!
Please see my comments inline : )
________________________________________
> From: Zuo, Jerry <Jerry.Zuo@amd.com>
> Sent: Thursday, May 5, 2022 10:30
> To: Lyude Paul; Lin, Wayne; Wentland, Harry; amd-gfx@lists.freedesktop.or=
g
> Subject: RE: Do we really need to increase/decrease MST VC payloads?
>
> [AMD Official Use Only - General]
>
> Hi Lyude:
>
>      Sorry for replying late.
>
>      1. The payload increase/decrease routines are not for DP2.
>      2. mst_bw_update is not used in amdgpu_dm, so those two functions ar=
e not getting used for now. I leave it there simply for future possible hoo=
k up.
>
> Regards,
> Jerry
>
> > -----Original Message-----
> > From: Lyude Paul <lyude@redhat.com>
> > Sent: Wednesday, May 4, 2022 5:17 PM
> > To: Lin, Wayne <Wayne.Lin@amd.com>; Wentland, Harry
> > <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org; Zuo, Jerry
> > <Jerry.Zuo@amd.com>
> > Subject: Re: Do we really need to increase/decrease MST VC payloads?
> >
> > Some good news: I actually came up with a way of handling this in the n=
ew
> > MST code pretty nicely, so I think we should be able to move forward
> > without having to disable this (although it would be very nice to know
> > whether or not this is necessary for amdgpu to work, since it'd still b=
e nice to
> > split this into separate changes to make reviewing my big MST patch ser=
ies
> > easier. More comments down below:
> >
> > On Mon, 2022-05-02 at 18:40 -0400, Lyude Paul wrote:
> > > Hi! So I kinda hate to ask this, but finding this in amdgpu completel=
y
> > > took me by surprise and unfortunately is (while technically correct)
> > > an enormous pain and not really necessary as far as I'm aware.
> > >
> > > So: it seems that amdgpu is currently the only driver that not only
> > > allocates/deallocates payloads, but it also increases/decreases the
> > > size of payloads as well. This was added in:
> > >
> > >    d740e0bf8ed4 ("drm/amd/display: Add DP 2.0 MST DC Support")
> > >
> > > This is fine, except that it's totally not at all a situation that th=
e
> > > current payload management code we have (which, is the first place
> > > this should have been implemented) knows how to handle, because every
> > > other driver simply allocates/releases payloads. Having to increase
> > > the size of payloads means that we no longer can count on the payload
> > > table being contiguous, and means we have to resort to coming up with
> > > a more complicated solution to actually do payload management
> > > atomically.
> > >
> > > I'm willing to try to do that (it should be doable by using bitmasks
> > > to track non-contiguous allocated slots), but considering:
> > >  * This isn't actually needed for DP 2.0 to work as far as I'm aware
> > > (if I'm
> > >    wrong please correct me! but I see no issue with just deallocating
> > > and
> > >    allocating payloads). It's nice to have, but not necessary.
> > >  * This was from the DSC MST series, which included a lot of code tha=
t
> > > I
> > >    mentioned at the time needed to not live in amdgpu and be moved
> > > into other
> > >    helpers. That hasn't really happened yet, and there are no signs o=
f
> > > it
> > >    happening from amd's side - and I just plain do not want to have t=
o
> > > be the
> > >    person to do that when I can help it. Going through amdgpu takes a
> > > serious
> > >    amount of energy because of all of the abstraction layers, enough
> > > so I
> > >    honestly didn't even notice this VC table change when I looked at
> > > the
> > >    series this was from. (Or maybe I did, but didn't fully grasp what
> > > was
> > >    changing at the time :\).
> > >  * Also on that note, are we even sure that this works with subsequen=
t
> > > VC
> > >    changes? E.g. has anyone tested this with physical hardware? I
> > > don't know
> > >    that I actually have the hardware to test this out, but
> > >    drm_dp_update_payload*() absolutely doesn't understand
> > > non-contiguous
> > >    payloads which I would think could lead to the VCPI start slots
> > > getting
> > >    miscalculated if a payload increase/decreases (happy to give
> > > further
> > >    explanation on this if needed). Note if this is the case, please
> > > hold off a
> > >    bit before trying to fix it and consider just not doing this for
> > > the time
> > >    being.
> >
> > Sorry for being a bit vague with this! I typed this email at the end of=
 the
> > workday and didn't feel like going super into detail on this. So I gues=
s I'll do
> > that now (hopefully I didn't misread the MST spec
> > somewhere):
> >
> > For reference: the issue I was mentioning here was regarding the fact t=
hat
> > the current payload management code we have doesn't keep track of exact=
ly
> > which VC slots are in use by a payload at any given time - only the sta=
rting
> > slots and total slot counts of each payload. Which means that once we
> > increase a MST payload, since the additional VC slots will be put at th=
e end of
> > the VC table regardless of the start of the payload. As such, it's poss=
ible that
> > said payload will no longer be contiguous. An example, note for simplic=
ity
> > sake this example pretends we only have 8 VC slots instead of 64:
> >
> > Payloads: #1 =3D=3D 2 slots, #2 =3D=3D 1 slot, #3 =3D=3D 2 slots
> >
> > VC table looks like this, where each number corresponds to a VCPI and X
> > means unused:
> >
> >         |1 1 2 3 3 X X X|
> >
> > We decide we need to increase payload #1 from 2 slots to 3. The MST spe=
c
> > mandates that new slots always are added to the end, so we end up with =
this
> > surprising VC table:

I think this shouldn't happen. Please refer to the figure 2-98 of DP spec 1=
.4.
The payload id table should be changed to below I think.

        |1 1 1 2 3 3 X X|

I skimmed over a bit of the implementation in drm. I think it should work f=
ine
except that we have to revise function drm_dp_init_vcpi() a bit.
Since increasing/decreasing time slots should still use the same payload id=
,
we should add logic to skip trying to assign a new payload id under this ca=
se.

> >
> >         |1 1 2 3 3 1 X X|
> >
> > Now, let's say we increase payload #2 to 2 slots:
> >
> >         |1 1 2 3 3 1 2 X|
> >
> > Surprise - the monitor for payload #1 was unplugged, so we need to remo=
ve
> > it's payload. Note the MST spec doesn't allow holes between allocations=
, and
> > makes branches repsonsible for automatically moving payloads to fill in=
 the
> > gaps which we have to keep track of locally.
> > Normally the handling of holes would be fine, as our current payload
> > management code loops through each payload to fill in any holes. But th=
ese
> > payloads aren't contiguous and we only kept track of their start slots =
and
> > total slot counts. So we would end up thinking we now have a VC table l=
ike
> > this:
> >
> >         |2 2 3 3 X X X X|
> >
> > But that's wrong, in reality the table will look like this on the MST
> > hub:
> >
> >         |2 3 3 2 X X X X|
> >
> > Now things are broken, because we now have the wrong start slot for
> > payload #3.
> >
> > Just figured I'd clarify :). if anyone is curious, I ended up fixing th=
is by adding
> > a bitmask of assigned VC slots to our atomic payload struct - and using=
 that
> > to keep track of the current start slots for each payload. Since we hav=
e a max
> > of 64 VC slots which fits into a u64, this works rather elegantly!
> >
> > >
> > > I'd /very/ much like to just disable this behavior for the time being
> > > (not the whole commit for DP 2.0 support since that'd be unreasonable=
,
> > > just the increase/decrease payload changes), and eventually have
> > > someone just implement this the proper way by adding support for this
> > > into the MST helpers and teaching them how to handle non-contiguous
> > > payloads. I'm happy to leave as much of the code intact as possible
> > > (maybe with #if 0 or whatever), and ideally just add some code
> > > somewhere to avoid increasing/decreasing payloads without a full
> > > modeset.
> > >
> > > FWIW, the WIP of my atomic MST work is here:
> > >
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
itl
> > > ab.freedesktop.org%2Flyudess%2Flinux%2F-%2Fcommits%2Fwip%2Fmst-
> > atomic-
> > > only-
> > v1&amp;data=3D05%7C01%7Cjerry.zuo%40amd.com%7Cf669121b53414c0dbc9
> > 40
> > >
> > 8da2e137e85%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378
> > 729585141
> > >
> > 60092%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> > MzIiLCJB
> > >
> > TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DIBn%2BF5
> > 0r9WIeUfG
> > > 9MUGStbACr5Kolu3PB5K0dyiiYwg%3D&amp;reserved=3D0
> > >
> > > I already have i915 and nouveau working with these changes JFYI.
> >
> > --
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat

--
Regards,
Wayne Lin
