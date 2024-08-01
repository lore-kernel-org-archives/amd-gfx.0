Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E7C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 08:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD1110E8BA;
	Thu,  1 Aug 2024 08:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Za0okluk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E304F10E8BA
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 08:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3/JRj1Ixgfc9IIsp52wh16Ibkiz5+ZcOQTXT/dQGzzvQwXdJkDBukOigUMwmUrWDawee3DmlS9AoHS2mAd1EBjv3E2sG9SKUtf9PirFbpt7uUL53/C2nCOCujcRA4JH91JH761JQarIjWtpSWH6AeZppB9WVS0ne7U28U0+Qn9l/MiN83/Am/0r9Z3KrHwunLz/+q+kJzTLdN6mw9r4Rx/+Mu4lRjMFZcjEZ/KjOV8EgNwjP5xLo1aLaDUACX/9vvD+U0KEh8XuvGUlYBHeqWhzLa1UQPiXoXv9rquaXbuV2cJts6ApAi2LOF+PBgYeLRbNIgcSa5htWklt7k72tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLQRxLGFZ7RD6eJczbLDkLRdjwV7WnDDDy6MoAjW1yQ=;
 b=c6hxrplwZvH8yE9IJj1ioL7/jXnpNLhDVqEZiBiyd8wMV9JT8AduFGzjuFgj4BgjzfVlky7WarXL5WQk3hQCVdl8aNTEHQlpYbUDs9wosXQF9vp47JUGdVpo7YN6Cmu0ND1mULBox12W7cFcIHjJnC4C/UkZBq9zI4+JFWWZqQr2RhPqrcdHxO4SREAK06XoETDAcaj105agoK27gj5tAV9jU7eCt1iK187OCwQdU4vfJT6CJ4gHrVILc+K6XYbgZyIQRla+7KB7Ow/KrC3a1uTtVQMnfiasg3/40BWsUXDtYryQT1r+yqnhCoirI/9aaNyZ1u5oL3Mf6163h5HfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLQRxLGFZ7RD6eJczbLDkLRdjwV7WnDDDy6MoAjW1yQ=;
 b=Za0oklukZGXOJOKDYYtrE9A5t2grmxWOdMC631CUUpjBSlmTyCkMIFN1Wh3jfQL4MQIWquQdlcLB+nHz/rBzc3GOPsmY1Iife63m+2+k3en5LELBhHqy8V6tJQUirxa3EvSCzhqvWuvOs5QApFZD++ReXawhLqsR/Wv4KmzEw7w=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 08:38:16 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%3]) with mapi id 15.20.7807.025; Thu, 1 Aug 2024
 08:38:16 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: save the funcs of gfx software rings
Thread-Topic: [PATCH] drm/amdgpu: save the funcs of gfx software rings
Thread-Index: AQHa4+RRkIXsZpUe1U20liATSjaMiLISCTGAgAAEIxA=
Date: Thu, 1 Aug 2024 08:38:16 +0000
Message-ID: <SA1PR12MB7442AB13E7537652DD32E7CDFEB22@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240801072723.1193504-1-Trigger.Huang@amd.com>
 <DS7PR12MB6333C189AE205B7A6C581B58F4B22@DS7PR12MB6333.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6333C189AE205B7A6C581B58F4B22@DS7PR12MB6333.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8b55ab2e-e4a3-448b-8276-640d80fa2f4c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T07:51:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|LV8PR12MB9359:EE_
x-ms-office365-filtering-correlation-id: 37c09f1a-e1e6-4a6a-4f4d-08dcb2054a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CYtyi23pttA4mW7OzBqogZte6a1sB3qeoWqb4jUrG53ZOHUYnLtJB/8fcwIg?=
 =?us-ascii?Q?Py0g4i41/V7ndL1akvBLNUIpBLXDf7UEC+WTnfaHv34SZy68XRGB3a7sUb5c?=
 =?us-ascii?Q?ut1YehBIs7MHKF06a6nLv1hdOOF4KpjT4qYVgY/e0oOnVLOmjZj3p7kkHuJ9?=
 =?us-ascii?Q?gQEbIYfHZYVzjPPsn4pnm+nuKGZuRvtSWwS8Cm4ZTNYkd2VlUFF5DH9FVKlm?=
 =?us-ascii?Q?iSNcud7xRGKQ97c/rX0cIFJ1yEaRnkhQo8Za8LstyRCAFb8KNM7ZJy0tvLR8?=
 =?us-ascii?Q?iBZoCM2sXNNf3MH7Lb2SMPd3qynjx+dcUPShII40+/qM49/XEqMctfNbwETO?=
 =?us-ascii?Q?/DGOqYW3ppBMDc094LXH6XpE/u3y52S3gLpqR1fYJ70EOd+j7mX8Pde0AoV8?=
 =?us-ascii?Q?8F7VmJMeoiOo8mKHTDo3ktUtp9W/2Kj5hBW8/HeGFSj3QXTisZwbVv6vQdUj?=
 =?us-ascii?Q?xQF26+fT/LE+TwiGPUkr0r7WWfND+owfKhP4L4LWWWUtVByX2Im6C2/Fy0T/?=
 =?us-ascii?Q?izL4zQWDMJTYFSVjEZ9SpDrIx++/K0lLgX9ipf/1qTfBYMi6Ben9sAvuDnAO?=
 =?us-ascii?Q?s8EqDlljAekbNRTL8jkB9bM+gESWPfDPekARZKp7pmsYVRmbw7LcEOA8/zZi?=
 =?us-ascii?Q?ReAW0+KPwW3YDvESI1UwFaf4hG6z3edEv5BuIkqJvCRwMV3djjwGFRdARham?=
 =?us-ascii?Q?LZpYuZr+AeIxr0eRlZF41rTOSyen22aE6PPT6ibN9b0n2x3styinXKJQQ6iY?=
 =?us-ascii?Q?ZueimTz55bwlu76SD859J691M3DKSCwCTGT5lk75j8eolFpNGR8GlvNWky55?=
 =?us-ascii?Q?QQdG1C7RLQP3bba3ICI3LS3kupBsYK5m6HyUsnWRjSDF+JcW7Ti0/ntY2bkW?=
 =?us-ascii?Q?ZzhKQxAHIw2IhbOnrHqzyo6tomBVBtf+JHBW9EkEvq8ogQ53eu6cLNsciSEv?=
 =?us-ascii?Q?CtatPUlTLEx1wN27ckiZJNPIZKuuVuh2RKR+yh36pYftICUHcfVI2DzuC6et?=
 =?us-ascii?Q?Xcw956jX7wv6c/nKo0u5Fc3G2Q+A5wQqGBDFoMKXCe/pR0bZ7pUaPDJnb9zt?=
 =?us-ascii?Q?BfukfONICG2g+wsUNnJvLDMY+zxtg0Doux2TabGsTd4hqjfZRpY/Gw0Fivqo?=
 =?us-ascii?Q?8aZMfgcfzPo3oQdK9DhAYvl2eYbzp9XcC0I/9jmibo+oWsZhngbavHTNXNqu?=
 =?us-ascii?Q?CDxDlnMqVXsbLniRAA66utL9lsCYN2mldG8/o89Kg0oLRyUFLoDDfCDmMEBL?=
 =?us-ascii?Q?zwRs7iF3St+txrlEihaW33HJOQHraf+uBxW5SJnqkZwzrD+7osfiYJo799GY?=
 =?us-ascii?Q?Hnub74Zy9M+UHgOE0DpNvgoKYpbRhi77TSYrTq6zUTcJh7wb2D0H2zGXYVDx?=
 =?us-ascii?Q?cfFzOcbf0/XamRQAe9eFL/DfhuAvNdFVmJCJH4WrRhgvwhYQDw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7mvY4z/nJE9CvRrllwTMjUkbpRT89MIgl97orku5WJLTc9m4PjoWsj1Ti5FL?=
 =?us-ascii?Q?MAx2BMHnRbtjjmRp+ePi5j+E8ZsAlbMkmiBnppDo9n+Qgqzel82rAY0c8zdy?=
 =?us-ascii?Q?csMJbckJ/5riAbHmvsNqXsjoeGCZ4okvcCDYaK1bSC6tySxqBz3uk5CDlndf?=
 =?us-ascii?Q?8ZBQ0S2Sh+ewM7wpKhkQTKK7yWbOSAqY4z7WovF0Ml1gI5FExM89W5Cbi30a?=
 =?us-ascii?Q?HivaeLqIJq99byBowW+BSLWpdnpspk8nO50KOLf3AVbFtqP68blW6GQzllI2?=
 =?us-ascii?Q?unQMAgcSbknD9UjhChydR6bumcV0StmueF6iFwtXxdaNtN5sEWkUCzp40GPe?=
 =?us-ascii?Q?pJ1EOEnqH5MjAmggnKhuEJkMtJ4jqoxKqR4dS0uT3hZZA/30vs+wUUcIRq/T?=
 =?us-ascii?Q?gjn28QG3qC+He6Wg6Tm+qXt+OXSTvaYDgdpn+IouY+8tyftDEHH/4Hb/jIQe?=
 =?us-ascii?Q?z4zRnmqb8wpVFZ9th5Tkigy31z0b5vK6QBByiWK8fuHhwxtWNPql/AA8kuyX?=
 =?us-ascii?Q?7FU6giAmGTuRC0rJ/3i7m6QJMBv2s9hGzYT1cqFNEC/zdqYD7FPaTSMjIP5z?=
 =?us-ascii?Q?fRggl3RghFS2j0K/BEZToFZSPRMaaKcrKgSMsZ6iuhv786y6Az3KeMb7KI5f?=
 =?us-ascii?Q?giqs0vR4vxwcPrmaZtMtconT4ZesN9og4Z4V69vWZBklML9P9Mp4hrPk7ZRJ?=
 =?us-ascii?Q?sqBDsd/C1NSmH+RLMDfsC8zE/2hczrdHNdNA6yco5FXZoXHKDurHPUwkyU/+?=
 =?us-ascii?Q?HRDS2rCzdLiAjQ10STzUfR1AovvM0Bv6J+IinHVRTb+MteG0tqG2dyZu4AGA?=
 =?us-ascii?Q?dSlXAjklYJRo2punM/Fgp/LgI5EzuOEVMcJ9HiUwdjCk8CMvzu+wKQBqIZbT?=
 =?us-ascii?Q?RE/SaC1TCxRrUDWx4ZlHCmMCd/rz8P8FhTxwDXVkL94grRDTuSkOnH/JaZEE?=
 =?us-ascii?Q?K+8pvtSzrMJ+JmDaUE8DBKgUX2mO4BohFjZEBi+dg/k/yhRm2cDOO2o6Z50x?=
 =?us-ascii?Q?wnVTnyJhanmclPXzDtBT/l64jnWwuW4csMHxOkW6koeIDhyF2UKy1J4r95xg?=
 =?us-ascii?Q?rjMH9fodya4H16lQvDQmNp93m5Z1TZQI4zmAhUJ63zRSXFT9ireK53sqHFp8?=
 =?us-ascii?Q?dwhrPuSrB8gQ5cYG7yWX0JzZ//CRD7n3DsTQwppc9I/zONNtsGus5B1tNEvs?=
 =?us-ascii?Q?SxMPopHetvTjEnH9jFLdeRpujGb2X/NFaZCJYqoNGj9pxQ9bzOAPFBweMrEi?=
 =?us-ascii?Q?A/K9m/bvGezQZNhh4m6it5OaLo20yzKS0qvcC+VP52UnDKA1ij5ItNMJIBXP?=
 =?us-ascii?Q?pMevhYXJcZqVV4Rv1H7qgGgR5tc5BGN2uqLYRNV4mgDo/nFMbaVWnwvT4d9f?=
 =?us-ascii?Q?Mw93HQDkBheaLZy4oeofBUpe5pKVPvfJcetkRABmylIYkTvYA+MKIal+RDgo?=
 =?us-ascii?Q?UHe/aPnhF6hMbkMVCJRYZ/FVCquwrEI+rbdDfUGxJSOpbdNv8yqfXRHheYtL?=
 =?us-ascii?Q?TB8QnB0RhYrVRoEImB7puF18DBl0oCdqW3mjqKrGFnZ7XuAJwl+k/VBX20Oo?=
 =?us-ascii?Q?AUSSpHoBFNYEORh+ebw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c09f1a-e1e6-4a6a-4f4d-08dcb2054a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 08:38:16.7604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gGMRbKHYYapN8YmOevxZN4dGH836VZdO69QFf0FVJPT3ah2wCntTK1B88W5PIAMhx3rdd8sOO7ov/Dm/Tk9UgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Sent: Thursday, August 1, 2024 3:58 PM
> To: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Huang, Trigger <Trigger.Huang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: save the funcs of gfx software rings
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Trigger.Huang@amd.com
> > Sent: Thursday, August 1, 2024 3:27 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Huang, Trigger <Trigger.Huang@amd.com>
> > Subject: [PATCH] drm/amdgpu: save the funcs of gfx software rings
> >
> > From: Trigger Huang <Trigger.Huang@amd.com>
> >
> > Currently the funcs variable of a gfx software ring is not set. So if
> > it is visited somewhere, it will lead to error logic being executed.
> > For example, if we want to call some callbacks in funcs of a gfx
> > software ring, like per ring reset, it will be failed due to funcs is N=
ULL.
> >
> > Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> > index d234b7ccfaaf..4dad03a07492 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> > @@ -202,6 +202,7 @@ int amdgpu_ring_mux_add_sw_ring(struct
> > amdgpu_ring_mux *mux, struct amdgpu_ring
> >
> >       e =3D &mux->ring_entry[mux->num_ring_entries];
> >       ring->entry_index =3D mux->num_ring_entries;
> > +     ring->funcs =3D mux->real_ring->funcs;
>
> The ring functions are set in gfx_v9_0_set_ring_funcs, what is the case t=
hat
> funcs of software ring are not set while real ring's funcs are set.
> Otherwise, real_ring->funcs are not the same as software ring's.

Thanks for pointing out this. I just realized my mistake, that I am testing=
 the per ring reset on the software ring, but I only set the reset callback=
 for the real ring, while not for the sw ring, and that's why I saw NULL po=
inter of reset callback function when job timeout.

Let's drop this patch.

Thanks,
Trigger
>
> Thanks,
> Jiadong
>
> >       e->ring =3D ring;
> >
> >       INIT_LIST_HEAD(&e->list);
> > --
> > 2.34.1
>

