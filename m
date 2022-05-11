Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F70C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 04:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F0610F607;
	Wed, 11 May 2022 04:14:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9715710F5EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 04:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgrL5IvVyd/rsbJK15o0mirnhxNy4IYtMwPZo1+cf6ykat19DBTQSw13hdhc7fR76heiXhF4quGYGwhHNb+beqRcINUtqVsq7LyoBaQLf8gjzXIPfUZCXtqO/SbvbrfxebuepF9oSJONgRwFbPG3avq+7M560mRuFR7JMBnDfrvFieVR9UVrO9H+asMRGnMUR4mOZfvUOcyXIRqtuBqiee++Nf7aJlpfgc43WYnPFZCJxTzsQNAUDuKG+TsZ7EjpH5UFjAxDNE6Pb2wpHYHW2niFFG/aKKKIx45it5eWTDdp0pW/2M+IPpKmBYQ5XN1pTvo4nKEx5MM7m+Xj6215mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrSaGxONSZ3xDvxQjRnJogDyb4m2A2tPvkQE9FEKr0Q=;
 b=m4hFEUDnbEad4gtF7CjTsOk6869n+OFhmQ3cA/cxq3KeuDPCG4LDg9MPlm1lAfZlKgXgHX0ucz0IDQSbZa06jhC1PNb6/HOy1PeizlVxLGZ6GMW+WfhBQe2EJZJTdO/9XG2iARwiSrvcypTo4ujJTr/rc/PtnvH5IBK2EVadMPh6XfjaGjXINc/v45hpHNgRPylMuRrgdpQ6lZxYLswAf4O2wr0obYeRfanhW8T7BLb7ANzq2uOKGR7p1UxPOLrEH2q6eLIAdiZaw2wjXASsT+USNXX+M2UOJXt2c40QsBeNfIiwAAQQHzOKIEdrMUbnB0/uw+FNO4aXkQwhF6A+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrSaGxONSZ3xDvxQjRnJogDyb4m2A2tPvkQE9FEKr0Q=;
 b=R/PiREEjzaM7up6/WV6recn4r4fVmQktbAxLZ5k5DJxLba0SfRzVZlp49P/XNyDpAjlAN2CZ+NIlK14UsQg1HC+g+HvXsEu8NOXm8U0RQRFWPiG01rjUHYxsrX7r2JB8g1+Dt8m2OhQSmVcE32EmkLggTkeEUB0SAlW+XtLU9u0=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 04:14:03 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::1c90:f807:7b0b:a862]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::1c90:f807:7b0b:a862%8]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 04:14:03 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: Lyude Paul <lyude@redhat.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: Do we really need to increase/decrease MST VC payloads?
Thread-Topic: Do we really need to increase/decrease MST VC payloads?
Thread-Index: AQHYXnWxk9xTavhbfEObDNqlnlm3sq0PO8QAgABXcoCAAHfR34AIrpsAgABY8AA=
Date: Wed, 11 May 2022 04:14:02 +0000
Message-ID: <CO6PR12MB5489D6F9BDFE8B9C891A8E12FCC89@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <dd5c63923636ec2ad78483899b1e4885e2235055.camel@redhat.com>
 <ad4ce2ddd2f2019f360b501c092680c799cb468c.camel@redhat.com>
 <BN8PR12MB334859526DE2D862EBBA0128E5C29@BN8PR12MB3348.namprd12.prod.outlook.com>
 <CO6PR12MB54893ACC396FBC017AD2E276FCC29@CO6PR12MB5489.namprd12.prod.outlook.com>
 <5697660b5ca61a4c4288eb2b641403a631d17400.camel@redhat.com>
In-Reply-To: <5697660b5ca61a4c4288eb2b641403a631d17400.camel@redhat.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-11T04:13:58Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3bbbb7b7-8772-4575-8cf7-4afe3ae5f69e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfebbdac-f257-4794-ebf5-08da3304aebe
x-ms-traffictypediagnostic: BL1PR12MB5705:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5705544A6FB4B26E85CAEBF2FCC89@BL1PR12MB5705.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPKqVF0f2hX7apY7IqyZ9DmtVb72y0u8AZ87CGuwExueLs36ZLsXy06RAGhFg/PIuXPEcfm5XoaQXJyqHuLC1vUMtUIbx5tRvrpkinCb8Eb9gBBYH7BRnaFP1Td9orXDNUgawLkHtyHR4rc0uNprHqR2/omn8q0ZmjcWWVfRLWWKcsgZgOizYxj22YsKDDb7sDoD8Ynp7Y3jhtEhkPRRQuO//V/PVRmbW2tASqxv5qWNQgDUxIXnerwxuASiuvWmR/VKuw/beWsdg61R1bxXaP9q/IVrZ+iwrqizwrpPXCTAwfvyQ8eDdHdLHno6TlXOTeJMuiizDTRFk0k+qGFjYoP7R8UzQOxevDJDL+hFSrXNZITHt6nL/ctR+gurBVuhjhEcFcksRXcHVRlkSknfWCNrdQOlbLMEfG5Kw5v10xD+zifFFxEPO5UzEoe9x4vRjSJOJ3XSqsVcA1UCT/t19rCAAEs0qH6EU88xKBsEe2kFw0QTroytMBDEnEoFWSeUdFo0n7p6W5o+FJqPzGfRI6LnDOwV4CeuBAumwH3h0pVWTBPuiKDqxWInmgiu4Km9DgOZYnckdkPhkwrq7tciArdNUf86I0F9KlvW/uihKk6Bz3TD1zHvY0tTW9coVjSBjH9NJe4EIJk3QEDEAwHJXAGrXasMxWeEhXuRnfVgKCGAu9Aa2Jgsm6FHoIlSeSPfozv8An9EaWFJSrr22nGiPPwvPpaQPCHXHhmQBchXznAc+poSYFVadoH+R+XMrafDyUtPXURo2eivxyS2W1zcT5rETGxE/6nFcUweTUDoEEA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(2906002)(52536014)(122000001)(55016003)(38070700005)(38100700002)(5660300002)(83380400001)(186003)(33656002)(508600001)(8676002)(66476007)(64756008)(76116006)(45080400002)(66556008)(66446008)(66946007)(316002)(53546011)(110136005)(6506007)(7696005)(26005)(9686003)(71200400001)(86362001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3ONxoloXt3mKJ3dcyeMrF6nwuzu7lm23nMP1RM/J3jvsQvJ74j29z587SU?=
 =?iso-8859-1?Q?B9XTY0pYPrDDbcJwCRsNwunGbBPi3A+WoJFtCiIM2ihXH8NC9di9OPROXx?=
 =?iso-8859-1?Q?h5svC7jQeGpNy8qj2wah7S5Sj1zhCZNJq484aJBZ94bfM+5H17aKtBZP3l?=
 =?iso-8859-1?Q?yP6kOC6ZQMx719CTxMzl2KGuhqi9a7pTuWFtwhxT7Gu7ihL8q3Aiglxcy+?=
 =?iso-8859-1?Q?z/4XjYybvSnRuPPOYdlrfjoSa5sx4vPxYVyQHEVGgqNKJHrh/ZJJK7r2+V?=
 =?iso-8859-1?Q?vXePEMeu9ICUmZTwMkifFdAZTdtokmwHaBrN+m0++j2x3dEMHLp/Jz2vbe?=
 =?iso-8859-1?Q?hbyUBbnr5TfXIju89DB1t35N7LPeqqfEzqPhvp6PvB+sYKwgKQg+szZjVP?=
 =?iso-8859-1?Q?nq+9Cg+vRtuAHBk+4GGkFAus2A4fEZMJ5ISGpMkc9VComQcteREgl3Tbfl?=
 =?iso-8859-1?Q?9wppyJJsjHA9eaPfRUrwcKelYwshPc4FKZBYI5pb5gpo/lgGb1kIgF0HUG?=
 =?iso-8859-1?Q?a8bTLw/RHO3VWPd+8Vy24fi/iqUd3gi1P5Cq0TorEOPwpa7d5ieboUbRtM?=
 =?iso-8859-1?Q?quyBTbT+9b1eG3333yFh3CY1aNYRgG91nMlBxfW3Vs2OYwjMGbIHWQA+H/?=
 =?iso-8859-1?Q?zr8aW0bISc8Y/sDEfxEiAi8Uqua2SB0ZMVtd+oNlcl9lW23nqGKLjH1VIA?=
 =?iso-8859-1?Q?edxhouctXvkaXqZro3VjM25KMVE4Qo7Qtkgs0lo/BBoQTmvePqePklIVqe?=
 =?iso-8859-1?Q?5JuHJUqVOQgkgBiAAFe0tS9n6Ggw3b54/qMonBFJgpdR26nOg6l+eApRJU?=
 =?iso-8859-1?Q?QQ5XMx022pKSE3Gm8jqW55d4mQLG3+2QcQuEQLp60SO3+9f1zcOs+gQEiK?=
 =?iso-8859-1?Q?CvA0BjxCUEn9RvQD9AH6hIPZFMQUONdq+8ds3HGop7+JSd30DkcmDa9GlN?=
 =?iso-8859-1?Q?PtjVSCFnMnJs7vEY2XMnL6VxZa5lri3+LXvVeV3HhiFlPHRT3Nl3lWXubH?=
 =?iso-8859-1?Q?NUO2mb1z1aAiOn3rL+dEv5VmXzS97gVLhjp1zMCQcy7mdVXdNYqC4FmBAR?=
 =?iso-8859-1?Q?UUvrqrFQ3Rh5hdi3htEuaF6U1QDQyWKTvYYdN+dTLexxyr6DbuqgU99ZPo?=
 =?iso-8859-1?Q?Yxh5A4VIWMy0hArl+uIBpXMN86i1PH5W1eudTon7rtfRaSJbraLsXFWTXB?=
 =?iso-8859-1?Q?AtfgD3vcfeiiKn15OTlDfwPmAod9RWBuZycLoX1xjY6towLRXEUeZvrjjP?=
 =?iso-8859-1?Q?SEtnJQmfsY7xDGxSm4QM+aQXbOghSobEeaMs1N6JLdRKQtjINpv0exn503?=
 =?iso-8859-1?Q?/612O6YlMMviOdV92y274lbHp41a8y4KR6zIP6iQXzT3tA9d8/Oopb8nik?=
 =?iso-8859-1?Q?PbjsM27dlKwr/egTKcA+ntl3sJ40s1VLzOPfRfSjHlLqd/vhuHDfsfzFM4?=
 =?iso-8859-1?Q?uXVksoXr4BiTl8YOa2llOBMKpBON0BjNxYVDYB34TSwzpJH4FdKevFLz+U?=
 =?iso-8859-1?Q?gvghTT8t67GhdcM1INqrZEWvEHkyJc/H1Jqat+U0HFr2J3EfV+hfk3VCIA?=
 =?iso-8859-1?Q?4OhYXwWfCtZsbDO4B5vk5cr9+IV07uG5YYCIqE73qBWQtQlKXRQO46r3ZU?=
 =?iso-8859-1?Q?x/aObOoUALqePoX0sXO46XI7qQFzNLz+ovwCvFVDWbbcVA4JVCoQlBW+6H?=
 =?iso-8859-1?Q?RTWW7ZTaJKtCxiSxD+5+yUByeOhAYzHrPi6pO6jGDya5XWvfLugWi4KDxH?=
 =?iso-8859-1?Q?Vbt4rPpSIL/UKnt8S9UoBO6XtLZTn1WtnG48p3VE2JvmvX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfebbdac-f257-4794-ebf5-08da3304aebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 04:14:03.0355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCq0nUNxeRA/ybp92mnTMyXB/QMsmpjUfAQYPufSjY9T4Kyq+frux+8M4zCv+VZevXLzGGAHapJC34jv/z4MCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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

[AMD Official Use Only - General]



> -----Original Message-----
> From: Lyude Paul <lyude@redhat.com>
> Sent: Wednesday, May 11, 2022 6:14 AM
> To: Lin, Wayne <Wayne.Lin@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>;
> Wentland, Harry <Harry.Wentland@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: Do we really need to increase/decrease MST VC payloads?
>=20
> On Thu, 2022-05-05 at 10:02 +0000, Lin, Wayne wrote:
> >
> > I think this shouldn't happen. Please refer to the figure 2-98 of DP
> > spec 1.4.
> > The payload id table should be changed to below I think.
> >
> > =A0=A0=A0=A0=A0=A0=A0 |1 1 1 2 3 3 X X|
> >
> > I skimmed over a bit of the implementation in drm. I think it should
> > work fine except that we have to revise function drm_dp_init_vcpi() a
> > bit.
> > Since increasing/decreasing time slots should still use the same
> > payload id, we should add logic to skip trying to assign a new payload
> > id under this case.
>=20
> I'm not sure about that tbh, since the example you gave also still mentio=
ns
> VC
> #1 which is supposed to be disabled here.
>=20
> FWIW, I was alerted to this pecularity when I noticed Figure 2-93 from
> chapter
> 2.6.5 of the DP 2.0 spec. Notice that on the diagram it mentions time slo=
ts 1-
> 20 allocated to VC1, time slots 21-32 being allocated to VC2, and then
> (confusingly in a different color) mentions that time slots 33-47 are all=
ocated
> to VC1 again.
>=20
Thank you Lyude.

I think that should be just a typo since remaining 2 payload portions of th=
e
"De-allocation" case at the bottom of that figure are represented in differ=
ent
colors. Besides, I think we should just take the idea that it illustrates i=
n the figure
for increasing/decreasing time lots. Which only increase extra slots contin=
uously. =20

I also consult with a branch device vendor, their DP Rx HW design only supp=
orts
1 start/end per stream. We have consistent consensus for this. However, the
most confident way is having VESA to clarify this.

> At first I honestly thought this was a typo in the spec, but it's done mu=
ltiple
> times and it _does_ actually make sense when you think about it for a lit=
tle
> while. Consider that the advantage of having VC allocations work this way
> would be that you're able to increase the time slots allocated to a VC wi=
thout
> having to even change their start slots - meaning those other payloads do=
n't
> need to be disrupted in any way. This is only as far as I can tell if you=
 have
> non-contiguous payloads.

Ideally, other payloads shouldn't get disrupted. Source will send out ACT s=
ymbols
to synchronize DP Rx with the new updated payload ID table. Operations on
DPCD 0x1C1 & 0x1C2 won't have physical signal take effect immediately.=20

I think increasing time slots non-contiguously will have DP Rx to have more=
 HW
registers and have more complicated design which will increase their cost.
>=20
> >
> > > >
> > > > =A0=A0=A0=A0=A0=A0=A0 |1 1 2 3 3 1 X X|
> > > >
> > > > Now, let's say we increase payload #2 to 2 slots:
> > > >
> > > > =A0=A0=A0=A0=A0=A0=A0 |1 1 2 3 3 1 2 X|
> > > >
> > > > Surprise - the monitor for payload #1 was unplugged, so we need to
> > > > remove it's payload. Note the MST spec doesn't allow holes between
> > > > allocations, and makes branches repsonsible for automatically
> > > > moving payloads to fill in the gaps which we have to keep track of
> > > > locally.
> > > > Normally the handling of holes would be fine, as our current
> > > > payload management code loops through each payload to fill in any
> > > > holes. But these payloads aren't contiguous and we only kept track
> > > > of their start slots and total slot counts. So we would end up
> > > > thinking we now have a VC table like
> > > > this:
> > > >
> > > > =A0=A0=A0=A0=A0=A0=A0 |2 2 3 3 X X X X|
> > > >
> > > > But that's wrong, in reality the table will look like this on the
> > > > MST
> > > > hub:
> > > >
> > > > =A0=A0=A0=A0=A0=A0=A0 |2 3 3 2 X X X X|
> > > >
> > > > Now things are broken, because we now have the wrong start slot
> > > > for payload #3.
> > > >
> > > > Just figured I'd clarify :). if anyone is curious, I ended up
> > > > fixing this by adding a bitmask of assigned VC slots to our atomic
> > > > payload struct - and using that to keep track of the current start
> > > > slots for each payload. Since we have a max of 64 VC slots which
> > > > fits into a u64, this works rather elegantly!
> > > >
> > > > >
> > > > > I'd /very/ much like to just disable this behavior for the time
> > > > > being (not the whole commit for DP 2.0 support since that'd be
> > > > > unreasonable, just the increase/decrease payload changes), and
> > > > > eventually have someone just implement this the proper way by
> > > > > adding support for this into the MST helpers and teaching them
> > > > > how to handle non-contiguous payloads. I'm happy to leave as
> > > > > much of the code intact as possible (maybe with #if 0 or
> > > > > whatever), and ideally just add some code somewhere to avoid
> > > > > increasing/decreasing payloads without a full modeset.
> > > > >
> > > > > FWIW, the WIP of my atomic MST work is here:
> > > > >
> > > > >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> > > > > 2Fgitl
> > > > > ab.freedesktop.org%2Flyudess%2Flinux%2F-
> %2Fcommits%2Fwip%2Fmst-
> > > > atomic-
> > > > > only-
> > > >
> v1&amp;data=3D05%7C01%7Cjerry.zuo%40amd.com%7Cf669121b53414c0dbc9
> > > > 40
> > > > >
> > > >
> 8da2e137e85%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378
> > > > 729585141
> > > > >
> > > >
> 60092%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> u
> > > > MzIiLCJB
> > > > >
> > > >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DIBn%2BF5
> > > > 0r9WIeUfG
> > > > > 9MUGStbACr5Kolu3PB5K0dyiiYwg%3D&amp;reserved=3D0
> > > > >
> > > > > I already have i915 and nouveau working with these changes JFYI.
> > > >
> > > > --
> > > > Cheers,
> > > > =A0Lyude Paul (she/her)
> > > > =A0Software Engineer at Red Hat
> >
> > --
> > Regards,
> > Wayne Lin
> >
>=20
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
--
Regards,
Wayne Lin
