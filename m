Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF0C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 16:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B73F613B9
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 16:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B73F613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F69A6E195;
	Wed, 26 May 2021 16:05:17 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EDA6E195
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 16:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A34nOp9HlMOeBSEn+YPd/4G1eHSeT1x0XWokfj3ASErzqEbESxO0XNlnwgcJhiCMbEwOWKtPO45X9ct0FIy8Iqk6M+kFwMQjwbSgtoMyoYbJ2Nkky5ywXqgahlJNeWevAtPAcAIAGAvF0WrAEJ/HJTjuzspnGwNoT4PVGrrDhXGC6UnbH7XxSj0wl6lzXAdUK7qFXQwezUVLFCnu6UXKt8GeHN8aDP4Jb9clEHtl4rXgB3G0a5aEuSziK3NEtxV+mU8t31bLnXc3Nro6UL2NEad9hEVWPr9C203zTX94QdHMw4ZDOMT+av1V/mc8GyZIYinHuc82xgsrFhEFf0fxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rYehEQj8a18zlzOblEk6vkGKyZIdoqggOlRFHRB8FM=;
 b=j0AxJ4M8hsyCmnvMMLqmbURAKcFbK1A5zS5Nb/D3IKAP4UthiLUU2mmReZ3IRGQNBiAPWp05IWfLkUUKAbdK7d0wwGzkiPlXEJerAYA+8m8PZJZZ5LdLwgfI9iuC6mrRUE1ggJ1ySgQyj8jH6aqqL1gPOWhEUxZeYzGVtlBQ7ghlsyLkk74P81MlqtLSubb9YVOKC9V9tWVwIwdjjUfFKPdLYpMsWyfOBQYqxVhgyQ5Fwu5cCJwZdSKUItIJakENbPMJC63a34G1plwfZD0n8WWdtBKt1iPaP0TMRsyreCX/NOCTYvN9wl+AkDZNXLlfg8eVbXYbNNgQUQzQ7FSfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rYehEQj8a18zlzOblEk6vkGKyZIdoqggOlRFHRB8FM=;
 b=eqPTCo7zR+5TKC195I+h5JrZuN84SaED03ptsC/0fXDQ7lWySnIuuSSpy8QZmWtPmM9Lg+U1Usyt7336fWeXLAjTFjdxMnTGpIDWMzEVAam35N825qm8RuW5P0u/8G7ZkjCvgZfJ/Zs1NmVc3/7As1sOYBh5sQKrv5utX7dmdog=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 16:05:12 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 16:05:12 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error
 counters
Thread-Topic: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error
 counters
Thread-Index: AQHXTobuj88Hu0lpuEKN0hDwuL++Nqr1ns2AgABHO4CAAAzlRw==
Date: Wed, 26 May 2021 16:05:12 +0000
Message-ID: <CH0PR12MB5348BA69879C38A49D6965F997249@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210521211836.4839-1-luben.tuikov@amd.com>
 <20210521211836.4839-3-luben.tuikov@amd.com>
 <CH0PR12MB53487EE4BD75A8B5493F742D97249@CH0PR12MB5348.namprd12.prod.outlook.com>,
 <823691d6-3301-4b56-3dc8-f82f66f04ef7@amd.com>
In-Reply-To: <823691d6-3301-4b56-3dc8-f82f66f04ef7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T15:58:37.7045841Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.206.44.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 857b2e0a-87b2-4f87-a482-08d920600b4c
x-ms-traffictypediagnostic: CH0PR12MB5330:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB53301B17317CDFD5F067F61497249@CH0PR12MB5330.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xPeaFBpU9JAgJQ/XhvPxtrziZj218NmjNptQZoT8KPTJ10iUpfVojRTW79zesCQX2PvO/yfRDXXzPmMQaErXCAo1K94j+rtQW6BGyNUFDYCdBZhnIe9B8TTtqTlWgcnIn6ko+3rxL4TrwqrEox+F7V9uw4cOUHqrdGYGDR6pruV5SV6HePIHv6w0JVnXDsytOVFDVePPI6gSkYpFdNWa+ZPdG7C5Ox8eWpc7jwxYxEtze0u7MxbLBg2vriHVY1Fqmp2ZqTk5E4L0aCA4Fn4j1O2dvE2gdSE8X4t78M6/pwBC2JZTHC/ZKUhmTyPgjkiNRyOZ5LWMEYwaBYpgfqLEVTvk5HKIZ5//SGjMA2U9WGPWlFSrFkprkKip+mWJB1fpbWLgMCPDqKvjojBW2dD1nqStGGxgEV8Y8PxZACk6a0jOB5C5fIOU0Jw5SJJxr+mSZ1RULIEg26jfrHbSH9YVQNqzi4fcklnGHSIgtfVXmCWLqSaLyIT45S9EgFmymbzBWAlSqOe52K/Amex9DFzjyabRPhMvgFfP52NF1KqzCe66cdALdTTzzHE09u/P0iVjItQpCedVDy7We87KApqQgM51IRQ4mSTqXKB1hhIfSe0pDCQlgA5PS3/GsZ8ZPzWa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(166002)(66556008)(64756008)(66476007)(9686003)(2906002)(66946007)(8676002)(5660300002)(76116006)(8936002)(4326008)(66574015)(66446008)(52536014)(83380400001)(478600001)(966005)(91956017)(316002)(45080400002)(6506007)(7696005)(54906003)(53546011)(26005)(38100700002)(186003)(33656002)(122000001)(110136005)(86362001)(71200400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?S94ycZqnlcOszOHQYkutvuUBG77Cqh1tXsDlfWVFafWjTiipGHf4y0cRzv?=
 =?iso-8859-1?Q?lLLJ4+ORfASpGjSR96isaoNbpiwybNM27ZpvfRb1sXBgJMJCT2cV1RtboP?=
 =?iso-8859-1?Q?2AYB9QcD78r6FPMLl2fYXoqCXiBQfPJb+tiaci4LsZbD2+rIysSN8EF79F?=
 =?iso-8859-1?Q?1TSoO+f8z6YCd7YhS6vE+V5SNrITcmy5OeJopKansqv9hANYhdjCh/+sP/?=
 =?iso-8859-1?Q?lRfco643mCwR2ar8Tsgq79bb/UszCPZ9CpF2DTCZjrp8mYu1u8jT+c4eNL?=
 =?iso-8859-1?Q?dZl36Y6ZiLtKF1azO8HC4cFgmi0qazajjg57MTsDFMX/ppNPXhz+xbhHUZ?=
 =?iso-8859-1?Q?NhGSW/0OL1bGLkpbN4MpanyyKsUzL8lL88Uhh2GT3/bWHhRf83DkfNIqcC?=
 =?iso-8859-1?Q?rlZaUFath5wsnQfPAlS1RAZM0VV6XgeZBXqzLG69vknH2N4KEvir+lfGCz?=
 =?iso-8859-1?Q?ioGjqEwz5bTvemWPGbFb3ZpXWmmfqRZe1CPY8HAqkObuqlHcbRrTwgMT0X?=
 =?iso-8859-1?Q?q1aOzBa2RaNAspXEMHhSsnee4b4XNbs+TSjxjk4JKLg3QtetEQWWqd2WkD?=
 =?iso-8859-1?Q?6IddtbjifdVPtTPHXh5NuxXvc+63/pz+oroL69STPgsZ3no1buYVe1zjGP?=
 =?iso-8859-1?Q?nF8Rt60qHGAgCRa/uo03xfbTHqrUG2j88mDKJda9yBM6f15szNi8v4AKng?=
 =?iso-8859-1?Q?xrTp9oDvdJFyREsak4LNsTnt5aOWhxSUZdhUvjNv0p6FkgF+dZQVixjJ8g?=
 =?iso-8859-1?Q?8KBys0VtMFfE5ukkVdBV9isZVuIkJuJKho/nwt7PGVnpn9bQqdU12sZspz?=
 =?iso-8859-1?Q?5vjrn7R0OtYqdijiJ+uhePXUvQuWPg+qmM+LA7CfYeIm1oGd/V3wlAcmYE?=
 =?iso-8859-1?Q?cgkyL8EEZv787Lt/Adlk87CJdrZqidpi3KICgOFUMfmVmZf7HPCNsnIYII?=
 =?iso-8859-1?Q?EWZT7PmmnDs+AUed4ub13mYhi+vNTLDUQ78V7M5Ecw5KC+r1NbFcHVqtyM?=
 =?iso-8859-1?Q?1v+D3EUsFjTQI3ETZQlZkZ3HWDFQDWQbxE0YdVERiT9xtGEnMWla/A5vL1?=
 =?iso-8859-1?Q?Ftat46JlsiayO9en5Mv9+hD9S/Iuhyy2is7HisQaBRxWESSUSYjC7qdfQh?=
 =?iso-8859-1?Q?FYxnZeQLs9gZtU3tJ+HA4wG+5aLYASGtD0qD7fyRMx1Jls2bZpMJrPqSSU?=
 =?iso-8859-1?Q?qeHsIz8eKuD5b/noVey9qBmybUPLOpzbhF4wFyiDIKULccNjMwcI92P4n2?=
 =?iso-8859-1?Q?+YFax8/6DWLtlWoblFLdqKkwYWc6L1J33kiDNKqXNRnHXuZIr0LjAWVly3?=
 =?iso-8859-1?Q?i3r7VQhnn22xJZ4boTyvUMt09Fh+ZVMz2BCTmxGftIb7dmJJ0X6tlmeZ4W?=
 =?iso-8859-1?Q?TEExEng3YINVfgzb/E1ZBdH/ZjIWTu0w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857b2e0a-87b2-4f87-a482-08d920600b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 16:05:12.6763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBvOIxJ0jsCUQyWDxS0M9WOadEkT+B8d/k7OSUtLJi4TusY1V6vrw5pacKuAU40w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1302355103=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1302355103==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5348BA69879C38A49D6965F997249CH0PR12MB5348namp_"

--_000_CH0PR12MB5348BA69879C38A49D6965F997249CH0PR12MB5348namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Luben,

What I meant by event based is a thread waiting on wait queue for events, n=
ot a periodic polling as you had in the original patch. It still fetches th=
e cached data on IOCTL but also triggers an event to poll for new errors. S=
imilarly, a periodic error handler running to handle threshold errors also =
could trigger event. Basically, error data fetch is centralized to the thre=
ad.

It's just a different approach, don't know if that will make things more co=
mplex.

Thanks,
Lijo
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, May 26, 2021 8:42:29 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Cl=
ements@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawki=
ng <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error =
counters

On 2021-05-26 7:00 a.m., Lazar, Lijo wrote:
> [AMD Official Use Only]
>
> Scheduling an error status query just based on IOCTL doesn't sound like a=
 sound approach. What if driver needs to handle errors based on that - for =
ex: if the number of correctable errors exceed a certain threshold?
That's exactly the trigger which evokes the error count procedure. The diff=
erence is that on that IOCTL,
we return in O(1), the cached values and then trigger the counting procedur=
e in a delayed work item,
since it takes  O(n^3) and we cannot do it when the IOCTL is being processe=
d as that negatively
affects the user experience, and the overall agility of the system.

This is the closest implementation to what was had before when the count wa=
s trigger at the IOCTL time,
and the IOCTL blocked until the count was completed.

Acting on exceeding a certain threshold is fine, since we're not competing =
against the delta
of the excessive amount of errors, just so long as it does exceed. That is,=
 so long as it exceeds,
do something, we don't really care if it exceeds by delta or 10*delta.

But what is important, is the _time_ frequency of the delayed work, AMDGPU_=
RAS_COUNTE_DELAY_MS,
in my v2 of this patch. When set to 0, i.e. count as soon as possible, we g=
et about 22% duty cycle of
the CPU just doing that, all the time, as it seems this IOCTL is being call=
ed constantly, and thus
the counting takes place all the time, continuously. And this isn't good fo=
r the system's performance
and power management.

When set to 3 seconds, we get a normal (expected) system behaviour in Vega2=
0 sever boards.

> IMO, I'm more aligned to Luben's original approach of having something wa=
iting in the background - instead of a periodic timer based trigger, it cou=
ld be an event based trigger.  Event may be an ioctl, error handler timer t=
icks or something else.

Well, my original idea broke power management (PM), since it ran continuous=
ly
regardless of PM and whether we indeed need the count.

Now, when you say "Event may be an ioctl"--this is exactly what,

1) was had before, interlocked, and it made the system unusable to a GUI us=
er, and
2) is what we have in this patch, but we process the count asynchronously, =
while
    we return the O(1) count instantly.

The advantage of 2) over my original approach, is that the count is trigger=
ed only
on IOCTL call, albeit delayed so that we can return in O(1) the cached valu=
e. Thus,
if no QUERY2 IOCTL is received, then we don't count the errors, as we don't=
 schedule
the delayed work.

Regards,
Luben

> Thanks,
> Lijo
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben =
Tuikov
> Sent: Saturday, May 22, 2021 2:49 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben <Luben.=
Tuikov@amd.com>; Clements, John <John.Clements@amd.com>; Koenig, Christian =
<Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error co=
unters
>
> On Context Query2 IOCTL return the correctable and uncorrectable errors i=
n O(1) fashion, from cached values, and schedule a delayed work function to=
 calculate and cache them for the next such IOCTL.
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++++++++++++++--  driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++++++++++++++  drivers=
/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 ++++
>  3 files changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index bb0cfe871aba..4e95d255960b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -331,10 +331,13 @@ static int amdgpu_ctx_query(struct amdgpu_device *a=
dev,
>        return 0;
>  }
>
> +#define AMDGPU_RAS_COUNTE_DELAY_MS 3000
> +
>  static int amdgpu_ctx_query2(struct amdgpu_device *adev,
> -     struct amdgpu_fpriv *fpriv, uint32_t id,
> -     union drm_amdgpu_ctx_out *out)
> +                          struct amdgpu_fpriv *fpriv, uint32_t id,
> +                          union drm_amdgpu_ctx_out *out)
>  {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>        struct amdgpu_ctx *ctx;
>        struct amdgpu_ctx_mgr *mgr;
>
> @@ -361,6 +364,31 @@ static int amdgpu_ctx_query2(struct amdgpu_device *a=
dev,
>        if (atomic_read(&ctx->guilty))
>                out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
>
> +     if (adev->ras_enabled && con) {
> +             /* Return the cached values in O(1),
> +              * and schedule delayed work to cache
> +              * new vaues.
> +              */
> +             int ce_count, ue_count;
> +
> +             ce_count =3D atomic_read(&con->ras_ce_count);
> +             ue_count =3D atomic_read(&con->ras_ue_count);
> +
> +             if (ce_count !=3D ctx->ras_counter_ce) {
> +                     ctx->ras_counter_ce =3D ce_count;
> +                     out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_C=
E;
> +             }
> +
> +             if (ue_count !=3D ctx->ras_counter_ue) {
> +                     ctx->ras_counter_ue =3D ue_count;
> +                     out->state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_U=
E;
> +             }
> +
> +             if (!delayed_work_pending(&con->ras_counte_delay_work))
> +                     schedule_delayed_work(&con->ras_counte_delay_work,
> +                               msecs_to_jiffies(AMDGPU_RAS_COUNTE_DELAY_=
MS));
> +     }
> +
>        mutex_unlock(&mgr->lock);
>        return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index ed3c43e8b0b5..80f576098318 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -27,6 +27,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/reboot.h>
>  #include <linux/syscalls.h>
> +#include <linux/pm_runtime.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
> @@ -2116,6 +2117,30 @@ static void amdgpu_ras_check_supported(struct amdg=
pu_device *adev)
>                adev->ras_hw_enabled & amdgpu_ras_mask;  }
>
> +static void amdgpu_ras_counte_dw(struct work_struct *work) {
> +     struct amdgpu_ras *con =3D container_of(work, struct amdgpu_ras,
> +                                           ras_counte_delay_work.work);
> +     struct amdgpu_device *adev =3D con->adev;
> +     struct drm_device *dev =3D &adev->ddev;
> +     unsigned long ce_count, ue_count;
> +     int res;
> +
> +     res =3D pm_runtime_get_sync(dev->dev);
> +     if (res < 0)
> +             goto Out;
> +
> +     /* Cache new values.
> +      */
> +     amdgpu_ras_query_error_count(adev, &ce_count, &ue_count);
> +     atomic_set(&con->ras_ce_count, ce_count);
> +     atomic_set(&con->ras_ue_count, ue_count);
> +
> +     pm_runtime_mark_last_busy(dev->dev);
> +Out:
> +     pm_runtime_put_autosuspend(dev->dev);
> +}
> +
>  int amdgpu_ras_init(struct amdgpu_device *adev)  {
>        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@ -2130,=
6 +2155,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>        if (!con)
>                return -ENOMEM;
>
> +     con->adev =3D adev;
> +     INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw=
);
> +     atomic_set(&con->ras_ce_count, 0);
> +     atomic_set(&con->ras_ue_count, 0);
> +
>        con->objs =3D (struct ras_manager *)(con + 1);
>
>        amdgpu_ras_set_context(adev, con);
> @@ -2233,6 +2263,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev=
,
>                         struct ras_fs_if *fs_info,
>                         struct ras_ih_if *ih_info)
>  {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     unsigned long ue_count, ce_count;
>        int r;
>
>        /* disable RAS feature per IP block if it is not supported */ @@ -=
2273,6 +2305,12 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
>        if (r)
>                goto sysfs;
>
> +     /* Those are the cached values at init.
> +      */
> +     amdgpu_ras_query_error_count(adev, &ce_count, &ue_count);
> +     atomic_set(&con->ras_ce_count, ce_count);
> +     atomic_set(&con->ras_ue_count, ue_count);
> +
>        return 0;
>  cleanup:
>        amdgpu_ras_sysfs_remove(adev, ras_block); diff --git a/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 10fca0393106..256cea5d34f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -340,6 +340,11 @@ struct amdgpu_ras {
>
>        /* disable ras error count harvest in recovery */
>        bool disable_ras_err_cnt_harvest;
> +
> +     /* RAS count errors delayed work */
> +     struct delayed_work ras_counte_delay_work;
> +     atomic_t ras_ue_count;
> +     atomic_t ras_ce_count;
>  };
>
>  struct ras_fs_data {
> --
> 2.31.1.527.g2d677e5b15
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.l=
azar%40amd.com%7C3686015f68f84c9088ab08d91c9e0fcf%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637572287465788021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DH=
bdtryTNLwzF862vg6E%2BwKBHmrw8NFz3gKQsU9ggdOk%3D&amp;reserved=3D0


--_000_CH0PR12MB5348BA69879C38A49D6965F997249CH0PR12MB5348namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<div dir=3D"auto" style=3D"background-color: rgb(255, 255, 255)">Hi Luben,<=
/div>
<div dir=3D"auto" style=3D"background-color: rgb(255, 255, 255)"><br>
</div>
<div dir=3D"auto" style=3D"background-color: rgb(255, 255, 255)">What I mea=
nt by event based is a thread waiting on wait queue for events, not a perio=
dic polling as you had in the original patch. It still fetches the cached d=
ata on IOCTL but also triggers an event
 to poll for new errors. Similarly, a<span style=3D"font-size: 12pt;">&nbsp=
;periodic error handler running to handle threshold errors also could trigg=
er event. Basically, error data fetch is centralized to the thread.</span><=
/div>
<div dir=3D"auto" style=3D"background-color: rgb(255, 255, 255)"><span styl=
e=3D"font-size: 12pt;"><br>
</span></div>
<div dir=3D"auto" style=3D"background-color: rgb(255, 255, 255)"><span styl=
e=3D"font-size: 12pt;">It's just a different approach, don't know if that w=
ill make things more complex.</span></div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 26, 2021 8:42:29 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Clements, =
John &lt;John.Clements@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@=
amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS=
 error counters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2021-05-26 7:00 a.m., Lazar, Lijo wrote:<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt; Scheduling an error status query just based on IOCTL doesn't sound lik=
e a sound approach. What if driver needs to handle errors based on that - f=
or ex: if the number of correctable errors exceed a certain threshold?<br>
That's exactly the trigger which evokes the error count procedure. The diff=
erence is that on that IOCTL,<br>
we return in O(1), the cached values and then trigger the counting procedur=
e in a delayed work item,<br>
since it takes&nbsp; O(n^3) and we cannot do it when the IOCTL is being pro=
cessed as that negatively<br>
affects the user experience, and the overall agility of the system.<br>
<br>
This is the closest implementation to what was had before when the count wa=
s trigger at the IOCTL time,<br>
and the IOCTL blocked until the count was completed.<br>
<br>
Acting on exceeding a certain threshold is fine, since we're not competing =
against the delta<br>
of the excessive amount of errors, just so long as it does exceed. That is,=
 so long as it exceeds,<br>
do something, we don't really care if it exceeds by delta or 10*delta.<br>
<br>
But what is important, is the _time_ frequency of the delayed work, AMDGPU_=
RAS_COUNTE_DELAY_MS,<br>
in my v2 of this patch. When set to 0, i.e. count as soon as possible, we g=
et about 22% duty cycle of<br>
the CPU just doing that, all the time, as it seems this IOCTL is being call=
ed constantly, and thus<br>
the counting takes place all the time, continuously. And this isn't good fo=
r the system's performance<br>
and power management.<br>
<br>
When set to 3 seconds, we get a normal (expected) system behaviour in Vega2=
0 sever boards.<br>
<br>
&gt; IMO, I'm more aligned to Luben's original approach of having something=
 waiting in the background - instead of a periodic timer based trigger, it =
could be an event based trigger.&nbsp; Event may be an ioctl, error handler=
 timer ticks or something else.<br>
<br>
Well, my original idea broke power management (PM), since it ran continuous=
ly<br>
regardless of PM and whether we indeed need the count.<br>
<br>
Now, when you say &quot;Event may be an ioctl&quot;--this is exactly what,<=
br>
<br>
1) was had before, interlocked, and it made the system unusable to a GUI us=
er, and<br>
2) is what we have in this patch, but we process the count asynchronously, =
while<br>
&nbsp;&nbsp;&nbsp; we return the O(1) count instantly.<br>
<br>
The advantage of 2) over my original approach, is that the count is trigger=
ed only<br>
on IOCTL call, albeit delayed so that we can return in O(1) the cached valu=
e. Thus,<br>
if no QUERY2 IOCTL is received, then we don't count the errors, as we don't=
 schedule<br>
the delayed work.<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Luben Tuikov<br>
&gt; Sent: Saturday, May 22, 2021 2:49 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Tuikov, Lube=
n &lt;Luben.Tuikov@amd.com&gt;; Clements, John &lt;John.Clements@amd.com&gt=
;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Zhang, Hawking &lt;H=
awking.Zhang@amd.com&gt;<br>
&gt; Subject: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error=
 counters<br>
&gt;<br>
&gt; On Context Query2 IOCTL return the correctable and uncorrectable error=
s in O(1) fashion, from cached values, and schedule a delayed work function=
 to calculate and cache them for the next such IOCTL.<br>
&gt;<br>
&gt; Cc: Alexander Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; Cc: John Clements &lt;john.clements@amd.com&gt;<br>
&gt; Cc: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
&gt; Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++++++++++++++=
--&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++++++++++=
++++&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 5 ++++<br>
&gt;&nbsp; 3 files changed, 73 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ctx.c<br>
&gt; index bb0cfe871aba..4e95d255960b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; @@ -331,10 +331,13 @@ static int amdgpu_ctx_query(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +#define AMDGPU_RAS_COUNTE_DELAY_MS 3000<br>
&gt; +<br>
&gt;&nbsp; static int amdgpu_ctx_query2(struct amdgpu_device *adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv, uint32_t id,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; union drm_amdgpu_ctx_out *out)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amdgpu_fpriv *fpriv, uint32_t id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; union drm_amdgpu_ctx_out *out)<br>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras_get_co=
ntext(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ctx *ctx;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ctx_mgr *mgr;<=
br>
&gt;&nbsp; <br>
&gt; @@ -361,6 +364,31 @@ static int amdgpu_ctx_query2(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_read(&amp;ctx-&gt=
;guilty))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; out-&gt;state.flags |=3D AMDGPU_CTX_QUERY2_FLAGS_GUILTY=
;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ras_enabled &amp;&amp; con) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Return the cached values in O(1),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * and schedule delayed work to cache<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * new vaues.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int ce_count, ue_count;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ce_count =3D atomic_read(&amp;con-&gt;ras_ce_count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ue_count =3D atomic_read(&amp;con-&gt;ras_ue_count);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ce_count !=3D ctx-&gt;ras_counter_ce) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;ras_counter_ce =
=3D ce_count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out-&gt;state.flags |=
=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ue_count !=3D ctx-&gt;ras_counter_ue) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;ras_counter_ue =
=3D ue_count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out-&gt;state.flags |=
=3D AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!delayed_work_pending(&amp;con-&gt;ras_counte_delay_work))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&=
amp;con-&gt;ras_counte_delay_work,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffies(AMDGPU_RAS_COUNTE_DEL=
AY_MS));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mgr-&gt;lo=
ck);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ras.c<br>
&gt; index ed3c43e8b0b5..80f576098318 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; @@ -27,6 +27,7 @@<br>
&gt;&nbsp; #include &lt;linux/uaccess.h&gt;<br>
&gt;&nbsp; #include &lt;linux/reboot.h&gt;<br>
&gt;&nbsp; #include &lt;linux/syscalls.h&gt;<br>
&gt; +#include &lt;linux/pm_runtime.h&gt;<br>
&gt;&nbsp; <br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_ras.h&quot;<br>
&gt; @@ -2116,6 +2117,30 @@ static void amdgpu_ras_check_supported(struct a=
mdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled &amp; amdgpu_ras_mask;&nbsp; }<=
br>
&gt;&nbsp; <br>
&gt; +static void amdgpu_ras_counte_dw(struct work_struct *work) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D container_of(work=
, struct amdgpu_ras,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_counte_delay_work.work);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D con-&gt;adev;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D &amp;adev-&gt;dde=
v;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ce_count, ue_count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int res;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; res =3D pm_runtime_get_sync(dev-&gt;dev);<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (res &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; goto Out;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Cache new values.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_query_error_count(adev, &amp;ce_c=
ount, &amp;ue_count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ce_count, ce_cou=
nt);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ue_count, ue_cou=
nt);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(dev-&gt;dev);<br>
&gt; +Out:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dev-&gt;dev);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; int amdgpu_ras_init(struct amdgpu_device *adev)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D a=
mdgpu_ras_get_context(adev); @@ -2130,6 +2155,11 @@ int amdgpu_ras_init(str=
uct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!con)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;adev =3D adev;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;con-&gt;ras_counte_de=
lay_work, amdgpu_ras_counte_dw);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ce_count, 0);<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ue_count, 0);<br=
>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;objs =3D (struct ras=
_manager *)(con + 1);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_set_context(adev,=
 con);<br>
&gt; @@ -2233,6 +2263,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *a=
dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct ras_fs_if *fs_info,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct ras_ih_if *ih_info)<br>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras_get_co=
ntext(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ue_count, ce_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable RAS feature per I=
P block if it is not supported */ @@ -2273,6 +2305,12 @@ int amdgpu_ras_lat=
e_init(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto sysfs;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Those are the cached values at init.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_query_error_count(adev, &amp;ce_c=
ount, &amp;ue_count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ce_count, ce_cou=
nt);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;con-&gt;ras_ue_count, ue_cou=
nt);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; cleanup:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_sysfs_remove(adev=
, ras_block); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&gt; index 10fca0393106..256cea5d34f2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&gt; @@ -340,6 +340,11 @@ struct amdgpu_ras {<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable ras error count h=
arvest in recovery */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_ras_err_cnt_har=
vest;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* RAS count errors delayed work */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work ras_counte_delay_work;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ras_ue_count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ras_ce_count;<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; struct ras_fs_data {<br>
&gt; --<br>
&gt; 2.31.1.527.g2d677e5b15<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Clijo.lazar%40amd.com%7C3686015f68f84c9088ab08d91c9e0fcf%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637572287465788021%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;amp;sdata=3DHbdtryTNLwzF862vg6E%2BwKBHmrw8NFz3gKQsU9ggdOk%3D&amp;=
amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Clijo=
.lazar%40amd.com%7C3686015f68f84c9088ab08d91c9e0fcf%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637572287465788021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sda=
ta=3DHbdtryTNLwzF862vg6E%2BwKBHmrw8NFz3gKQsU9ggdOk%3D&amp;amp;reserved=3D0<=
/a><br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5348BA69879C38A49D6965F997249CH0PR12MB5348namp_--

--===============1302355103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1302355103==--
