Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29947C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 15:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C821910EAE6;
	Fri,  6 Jun 2025 15:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l3nX38Vy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA9F10EAE6
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 15:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMk2T3ouG24MAhVfdYWSv7H8xy4Oa26KFGWKCnSjOJhR9zaF/Zk+ZQYkxyL/NtkNb/2mAY36ppsdYDIgui8JI9TSGYBUC9QgO/GoANqfVH66WRr1UI8Wudv/H3ZiMmkXoMuGN5iveOZhQf7y7vEU3GITo6gQQ0QOfSFCgW8PtK3KdgEFp6tQ/0hPgGeOzWMMKwPTTE8Hizt/2rEmRSRZm0YHJeDQh3YekREnMFep93xhV+MFZRyY2z6SxVSuMxv6Po9kqVa8RRyWU8vHquE/xxU1h9cVfgMiWi1FK/YLI/7DlEuwllWriowb6ocPhn8iG6Mmgwv0ztFKBC1xrTKCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVD0pTK6Wgu/wVp9ED20K/7B8yDzbe6ea91h6rHsk6k=;
 b=rSc5LQqtZSAAeiWvJSsidfFLG/YQ03cz0RKw8lhtLVydlfN6sgKTh0MXOaQgiZ9slkJGAUIbYVayqSa3f76NGGV9rbZJQ1D9HFKDXgBTNTE8GhuJ4zHUuadETJTlyWlIukPn0xgprSAHe63iLIzVkTnHVsm32hVhvK3Dcn3742DcG8aAKulVtOozc8XqUfyYtQ7TCCnlDzS0MpNkSA9sBbdlfiNyME8XBwJ1orRRJKpkAZCCvR+Ry9l+oS/TbjjiM5xq7mDd4yhoh0Za96w8lyQZGBCedvEQCjfdgb2EwXvIibuJSUE4DV184uZbZBFbUwecMoIqy4jOzH2VZuplcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVD0pTK6Wgu/wVp9ED20K/7B8yDzbe6ea91h6rHsk6k=;
 b=l3nX38VyOkcvlTHwEGfM58ATWNCU0agQdCtMzB0IwmNVnufwUub6wc4mEmV2z6co2HQOFR3ekdhx0B14aRLQr6LBAv6trU0JhjDi0KOa1r5+7tiDDG19awL8ljvtMhG0bAz83Rc30LmTIGWBkkb3DJnCOJAw4Us2swYEH5JQFb4=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 15:46:36 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8769.031; Fri, 6 Jun 2025
 15:46:36 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix mes based process evictions
Thread-Topic: [PATCH] drm/amdkfd: fix mes based process evictions
Thread-Index: AQHb1KS4XUVnUZftPkq2YPKZ2cAy/rPx8eQAgAAHfZCABE5UgA==
Date: Fri, 6 Jun 2025 15:46:36 +0000
Message-ID: <CY8PR12MB743570E2EC5BF1977E6966A4856EA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250603162934.154349-1-jonathan.kim@amd.com>
 <CY8PR12MB7099B08A13F18F0E620123B38C6DA@CY8PR12MB7099.namprd12.prod.outlook.com>
 <CY8PR12MB743580E8BF4A0D8CA4061848856DA@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB743580E8BF4A0D8CA4061848856DA@CY8PR12MB7435.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5d511c5a-f9c5-47a9-88e5-131e2d391373;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-03T21:16:58Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CH1PR12MB9672:EE_
x-ms-office365-filtering-correlation-id: ec406b6b-0810-4ed2-c87b-08dda5115201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vkfeoUEH557FbkTavfOAusEDor6y49+NVG1usYFg4Lk0S5hrpBzwp/Ni/9C2?=
 =?us-ascii?Q?pfi6uajFjxKyvyUq/iGvDCiTAdijW4aRhrUVOJ8mIP1ardUwEtUhYiOtdBBI?=
 =?us-ascii?Q?JKTE1ykDs67hR9qF0FVmPYOEXnIw1/b8SeDaw+rVt27jzesB9rlMdpcnQCdk?=
 =?us-ascii?Q?IOVI3rsbv078O/V8855vWmlyzgJb+Ixtv2oby2isIy31G1aqKrGnvO7CK40r?=
 =?us-ascii?Q?3UluV4QT1pl4H64Ann6Tzu7QWIcxo81eWT8zbnRLjVIGxGwDBN0Jq2VpNKF5?=
 =?us-ascii?Q?8EuULQICPwbc9g7/nP2LTUET95vtkVC7922+2vpD8nVR8unMy7LfuitjAUew?=
 =?us-ascii?Q?wsfR0KOcYQKUhOAuCkBVQLn5VY3cZmVy6gp+D7b/kpSCicOtyvn7YiM5Hw/r?=
 =?us-ascii?Q?ntQB0mYjV7UCyDf9WydnU2v5MqaMqJddXEyOxMCFLEIMyq3kFOjzp0sZ7P6S?=
 =?us-ascii?Q?e6Z0EmDk1Sk2DzmFuzWSpPpVynFg87jEFe7u1gfA+BBu2f/SvCYkaNhR9cIt?=
 =?us-ascii?Q?DDhYsyo/MC//Lh9ZyhdvD7JarR2YB7D7Asvs/OildiVQE/GZi0fV6PCHyWvg?=
 =?us-ascii?Q?Ob3TYxE/PGm9Id8357ySAbhzgFRHYd7WNhtVCif1/Nrud5bOjJPPGX+jK1gu?=
 =?us-ascii?Q?E38wfd1HfdqqB746FDSGL38iodl1Sayl1snd2rPLRgllVGySisAg/QLHxsX8?=
 =?us-ascii?Q?LCwpVbfqSqU6/LHqo5aJLwy1DvXZqhJF2w6r6WEkhbfNTYlJ4ZrLZRyXF5w6?=
 =?us-ascii?Q?2C/rcSVVIAcelTXt96103hDD5ApHTxS6UKGtB985gYRArEt9xDwLf4cXyrR5?=
 =?us-ascii?Q?e5XgIDhBx25GPE6jnUlBSROn88ciKHhDJdeCMcR9FbFppovTN25z2BNFKDgj?=
 =?us-ascii?Q?nZUnmnSmeaSlnT8lT7J088X3YQTYCSk0R7y6eTHV40W8q/YcQRs8A4OFhl51?=
 =?us-ascii?Q?blfe4rKMyuCVSNzNT0tXbuWnB7V8zWsGo2OwdP8HD/OoEPkUY+LtBHT7rCIE?=
 =?us-ascii?Q?Y7BYBMI4mlfPVmHUU7hpLhiX4fum++fdvrKuGNU05qTPn8wudhycL9D2buXn?=
 =?us-ascii?Q?X8UJCglS8h994HdLdBOV2AsXQD200gAfbjaolRdK1d9oxyt/6g21s+qH31kl?=
 =?us-ascii?Q?kRDWbpzsCIZrTFgRNvZ/d0ZdoKYevdK7tRCCMKn6jJ+2zCdc0j7enQbj4NSN?=
 =?us-ascii?Q?4fPQqcnlpuZZQHBO0cFARvDil9LyjVGg2/wGBdQcMKfp4p9CsgTvzj/urskG?=
 =?us-ascii?Q?vpa5DQHBnr7/nDbBnEk+etBlDAZrIPZMctObUTxHyIM6TaFIkZZ+RfhnLLae?=
 =?us-ascii?Q?aXk6eXuMjynfnPjX+YtllOtxVQKBaj0P27aFj9isfPxzD44OMK8BE7P4qw0r?=
 =?us-ascii?Q?Fo5G6V65s1nNdcJZ1S6Jr5bdpFVDxuRoczVZNssbKWD3GGei4MWsGUlfu/fJ?=
 =?us-ascii?Q?upPzlEPWvsdaVwYL4cDqlE525InpueHCwx75wVtIF+jrU/nn3Y8GvOMNYPG7?=
 =?us-ascii?Q?vBR7SzVW6u8Prug=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XCJE/E1qJryJPGgxrrMRQw7PuoXlDQYL5aWu/qcXD2eUUPL2d7/KYKOgZfHY?=
 =?us-ascii?Q?mWskWMWu9RN+ovgwNkfhaJIYv27odwI8vHWqG0ZCQuTpK1CfyOv90y9kQYH/?=
 =?us-ascii?Q?zA4CuhVDkuKuCwlkQgMifARlq4NBCsI+7XLCYx/m7plea3lzwShbLSuUHERi?=
 =?us-ascii?Q?BtmgPRvqTib9oEzj+Qa9vZpnbIcvjq6b1v7qhCyO6H/ZewFSlbmbajP2uFzO?=
 =?us-ascii?Q?oSrEv9EfpDsug5FalyQYAJsc9NmngHfSoRtvNapBrGgZDJZa/l+igbWusnvL?=
 =?us-ascii?Q?CKehuJh/FPdyXeneWxWD6HysEDbP8hsXcRIz94M0YcFIW06D3gfDaaWhzjx7?=
 =?us-ascii?Q?Cawn/CgU+1i7x7gTj4m6xyknJZ7Gx0f/MjHWV8Jt/HMQVKQxVRLc8PleJtCl?=
 =?us-ascii?Q?Ou6g5pLdU7Qo6F3/5mCd7R/Dp527heuc2KBRhD698pxeAgNX1VV/wj/Hv6t9?=
 =?us-ascii?Q?A/2/Laoh5zouTPQN255PGulxWN6u/l8xsgdlpAeVRsY5dLjM8Tif4zhYGGVe?=
 =?us-ascii?Q?2ey+naJ/MPBRfML0/5V116/b3OGGxkciCQaWYI3G0Ma13gTymqTxuw84D/dD?=
 =?us-ascii?Q?g3Vljiu2dC6GIN7QMmAmF9MnEpQ4HlfZNWgB1npnAop5tl+FjbXOJiwZdvF1?=
 =?us-ascii?Q?w0uu5qnjPtzQefWUDyv4IoqrccimAQ0JwAs3zKQQd+j9Euj8DDoqDgsR3WcG?=
 =?us-ascii?Q?b437/bgFcv4zOP8nCWnI3bmG+arQAh9Qe7YkIs/0qONsFo7C6IWT0gltqjDB?=
 =?us-ascii?Q?ZWzY36RhhOUerDwZUReIE7ad3IG9h53+tjMOf/gUCjSQcHpcNep3argL9NAD?=
 =?us-ascii?Q?H0UsQ/3TmKCalrEKyGgnU9gOi/dxXPF6BuAwyo2ZczEGVFK/qi6AJFBUeskr?=
 =?us-ascii?Q?ppg3rCC62lOqv1nznLp/rdSfBQnnexxkWjU3aK5Xz1Lk13VrZ2Hr6EFe7GrY?=
 =?us-ascii?Q?qQKh2NRDasCAN3obn0ZZ879a1lxQsJsQzKgUeK0dEEPcRvLP4CVGtgEDFadZ?=
 =?us-ascii?Q?bTLyjk9nmDAoH3SfcHOXqAJefr7yWabhd+3mRW0qaePIVBqmZlgx1zVeqE6f?=
 =?us-ascii?Q?xM9azs69yTgyX65+Oj+7EzaQeIVOWBUtRYw21PApwDKpsx3i/i6WODxklmkO?=
 =?us-ascii?Q?LlsNG5u2AG/7q9p/gBB39QAWmp082W+AX10ZWGBypF3Fg/tqNn6/93IXcH+W?=
 =?us-ascii?Q?Q/yCNqeyBL7Z8a0v5lbd3IqKUlUxGKYDfKKr64jQmGbhHi1U1jAiGMaNrvCK?=
 =?us-ascii?Q?2fLEsn1K0ZFUaRJtuYyVrjYI3k0a7OKSV6wVV3+e5mwF/eLvVIdES4xQ4Kvp?=
 =?us-ascii?Q?iBgltEfntKHsKze+OB8c1aDRhoaQGD4cqUbRspF3E/kJa0Ze2RcuNZhbXVlq?=
 =?us-ascii?Q?YzpPUCtjG4TkbUFiSP9Nbq6lTlugunP4xdYaNhs3UTQzyvrnbnmUpfqajMdx?=
 =?us-ascii?Q?Tur2CDXMAms7C+OVU7+gK6O8I8nWb37UGsWfPn69Kb65wvuq8SqS/LdcNcvr?=
 =?us-ascii?Q?k43F+tKl31m5EzbS2162YEbLCPJygB3nLhgVCDjZJ6LksCa4U7tmWdDiQphj?=
 =?us-ascii?Q?iMfvzeTJVhAiQeESMRc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec406b6b-0810-4ed2-c87b-08dda5115201
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 15:46:36.4917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5WetllYQuZ0hh7n+WdKOLY/M1bmOHfvGwTT2Skimx32iAucpAs0M/HQBcVzD2rB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672
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

Actually, on a second look, transient suspend/resume all seems kind of poin=
tless for MES process eviction if we're scanning and removing all active qu=
eues one-by-one anyway.
From the looks of it, MES has some trouble removing queues that have alread=
y been suspended.
Not sure why this got called in the eviction path in the first place.
We should probably should just remove this transient suspend/resume call to=
gether from eviction all together.

Jon

> -----Original Message-----
> From: Kim, Jonathan
> Sent: Tuesday, June 3, 2025 5:53 PM
> To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul
> <Mukul.Joshi@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: fix mes based process evictions
>
>
>
> > -----Original Message-----
> > From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> > Sent: Tuesday, June 3, 2025 5:22 PM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul
> > <Mukul.Joshi@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> > Subject: RE: [PATCH] drm/amdkfd: fix mes based process evictions
> >
> > [Public]
> >
> > So, the code now loops two times over the list of queues. Couple of que=
stions.
> >
> > (1) Isn't it possible to call suspend_all_queues_mes(dqm) before the fi=
rst
> > list_for_each_entry()? The first loop only does some housekeeping. That=
 way you
> > can still do get away with single loop.
>
> Yeah I guess there's no harm in grabbing the last eviction time stamp pri=
or to house
> keeping + queue removal instead of just raw queue removal.
>
> > (2) Also remove_queue_mes() is called for inactive queues (q-
> >properties.is_active).
> > Is that intentional?
>
> No. That was a lazy copy and paste mistake.  Good catch.
>
> Jon
>
> >
> > Best Regards,
> > Harish
> >
> >
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jona=
than
> > Kim
> > Sent: Tuesday, June 3, 2025 12:30 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul
> > <Mukul.Joshi@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> > Subject: [PATCH] drm/amdkfd: fix mes based process evictions
> >
> > First, MES suspend/resume calls should be consistently held under the
> > KFD device lock (similar to queue invalidation) so consolidate
> > MES based eviction logic with F32 HWS based eviction logic.
> >
> > Second, save the last eviction timestamp prior to current eviction to
> > align with F32 HWS timestamp logging behaviour.
> >
> > Finally, bail early on failure to remove a single queue as something
> > has gone really wrong post-suspend and a GPU reset is going to occur
> > anyway so it's more efficient to just release the device lock.
> >
> > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > ---
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 73 +++++--------------
> >  1 file changed, 20 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index 76359c6a3f3a..c1f0207eeb9e 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -1219,25 +1219,36 @@ static int evict_process_queues_cpsch(struct
> > device_queue_manager *dqm,
> >
> >                 q->properties.is_active =3D false;
> >                 decrement_queue_count(dqm, qpd, q);
> > +       }
> >
> > -               if (dqm->dev->kfd->shared_resources.enable_mes) {
> > -                       int err;
> > +       pdd->last_evict_timestamp =3D get_jiffies_64();
> > +
> > +       if (dqm->dev->kfd->shared_resources.enable_mes) {
> > +               retval =3D suspend_all_queues_mes(dqm);
> > +               if (retval) {
> > +                       dev_err(dev, "Suspending all queues failed");
> > +                       goto out;
> > +               }
> >
> > -                       err =3D remove_queue_mes(dqm, q, qpd);
> > -                       if (err) {
> > +               list_for_each_entry(q, &qpd->queues_list, list) {
> > +                       retval =3D remove_queue_mes(dqm, q, qpd);
> > +                       if (retval) {
> >                                 dev_err(dev, "Failed to evict queue %d\=
n",
> >                                         q->properties.queue_id);
> > -                               retval =3D err;
> > +                               goto out;
> >                         }
> >                 }
> > -       }
> > -       pdd->last_evict_timestamp =3D get_jiffies_64();
> > -       if (!dqm->dev->kfd->shared_resources.enable_mes)
> > +
> > +               retval =3D resume_all_queues_mes(dqm);
> > +               if (retval)
> > +                       dev_err(dev, "Resuming all queues failed");
> > +       } else {
> >                 retval =3D execute_queues_cpsch(dqm,
> >                                               qpd->is_debug ?
> >                                               KFD_UNMAP_QUEUES_FILTER_A=
LL_QUEUES :
> >
> > KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> >                                               USE_DEFAULT_GRACE_PERIOD)=
;
> > +       }
> >
> >  out:
> >         dqm_unlock(dqm);
> > @@ -3089,61 +3100,17 @@ int kfd_dqm_suspend_bad_queue_mes(struct
> > kfd_node *knode, u32 pasid, u32 doorbel
> >         return ret;
> >  }
> >
> > -static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
> > -                                  struct qcm_process_device *qpd)
> > -{
> > -       struct device *dev =3D dqm->dev->adev->dev;
> > -       int ret =3D 0;
> > -
> > -       /* Check if process is already evicted */
> > -       dqm_lock(dqm);
> > -       if (qpd->evicted) {
> > -               /* Increment the evicted count to make sure the
> > -                * process stays evicted before its terminated.
> > -                */
> > -               qpd->evicted++;
> > -               dqm_unlock(dqm);
> > -               goto out;
> > -       }
> > -       dqm_unlock(dqm);
> > -
> > -       ret =3D suspend_all_queues_mes(dqm);
> > -       if (ret) {
> > -               dev_err(dev, "Suspending all queues failed");
> > -               goto out;
> > -       }
> > -
> > -       ret =3D dqm->ops.evict_process_queues(dqm, qpd);
> > -       if (ret) {
> > -               dev_err(dev, "Evicting process queues failed");
> > -               goto out;
> > -       }
> > -
> > -       ret =3D resume_all_queues_mes(dqm);
> > -       if (ret)
> > -               dev_err(dev, "Resuming all queues failed");
> > -
> > -out:
> > -       return ret;
> > -}
> > -
> >  int kfd_evict_process_device(struct kfd_process_device *pdd)
> >  {
> >         struct device_queue_manager *dqm;
> >         struct kfd_process *p;
> > -       int ret =3D 0;
> >
> >         p =3D pdd->process;
> >         dqm =3D pdd->dev->dqm;
> >
> >         WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
> >
> > -       if (dqm->dev->kfd->shared_resources.enable_mes)
> > -               ret =3D kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
> > -       else
> > -               ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> > -
> > -       return ret;
> > +       return dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> >  }
> >
> >  int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
> > --
> > 2.34.1
> >

