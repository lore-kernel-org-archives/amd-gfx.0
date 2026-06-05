Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A51CD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 18:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FA011AA67;
	Fri,  5 Jun 2026 18:40:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="id3/8Y6I";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013004.outbound.protection.outlook.com
 [40.93.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1FE11AA67
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 18:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7U94LjNNTcbuulGSGqD2w3/PKLiiuFF3TY/H2w1iI3zXlqziyIpBq3QZ1BYBlWbJtqtrksSv/cnvX50iPqSRJCUn2y7XkV9NLNI29FIx//YvaTxXr/7uGr41OFXRBpOyZBebLPb6DRwIa2YKyYbIBzSbblxjj4GXGEsxXv1ldgFBIOrA+I2CFX4Ckdf2B5gnYYDuYsg5oT6ESLhBqY8t4ErSkpN1y1hJOV7+8n+f+RJIr4PCJfpHSs8yDEq01EJdyhZvVMudkCZ+K9lNHhu+iPZW5jXAC9yWMqbQjHPgnX3AeMyY7Z587rDA1a3fh8bV/6zShk9nZYVcYephElr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnDKSexSkh0bPiFr60QFB0enUrqCXKT2Y9XYx3MwAkQ=;
 b=lm0Bq/mO7K8kgwmVS8tdC/ZkXuYo4eqH0mzZCLYMvDk08k7sMvYUyn0D169iwpE1/yfY72TxOmW13pw1q2sQaLc4rHv2sfBJY3wUT4w31j+riAnytDdbrkSjTE1JYPnimKzXTF+wno51zCiWRv1ABPQ891C3Ja5nRjZ35o4hfzpa3Hm5SEYgZRdDSvp0wYjYdFHDufiXkcB6NvqLhozLD7fNPlqoOy/WrPsAVQiL2lvT57Vb8Qm8qKvzst5VQFsDyL11btd511Cg7V0FO7IAy6I2k+58Miw9U25LwWwEIKpkq2FAGmY9K7SKcr7OBA3zPBd5SuvussCe+57iAh54xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnDKSexSkh0bPiFr60QFB0enUrqCXKT2Y9XYx3MwAkQ=;
 b=id3/8Y6INVRgiy8uS808H0b3wNnpEW7varpu70sNe4gjfdOq2RwQ9wY8vyNWMkgUzcauIDPqr9JQfWfj+37VPQV87XassrkGOzX+izZxZ5HNn6SyW/9W5D3ozygMRqMuNKRxOX3vBZRkGL0/xOmUtMZzF7XhX+V3UqHCrXN91zA=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:40:00 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:40:00 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V2] drm/amdkfd: Check bounds on CRIU restore event id
Thread-Topic: [PATCH V2] drm/amdkfd: Check bounds on CRIU restore event id
Thread-Index: AQHc8sA3bkKI+2Rxck68GXyFvyZgMrYwJ76AgAAnrUI=
Date: Fri, 5 Jun 2026 18:40:00 +0000
Message-ID: <SA1PR12MB814424C2E09E5F9D046FB94BEF112@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260602184652.2614456-1-David.Francis@amd.com>
 <BL1PR12MB5898702AB07A4ACB83CF919885112@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5898702AB07A4ACB83CF919885112@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T18:39:58.967Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|PH7PR12MB7116:EE_
x-ms-office365-filtering-correlation-id: ff048902-3153-432c-d3ba-08dec331d987
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: AnVEzUtTtw6eDbIJFzsybGcRtdn9IazvqQKGL+iWKVm0Us263pyljrWTf/H8NOA7sHQFJUIJ9kaUrzJbEdTZjjBVcUn/XML89OJzANglqCFUO6Od0mL+xeLZtGETPRH5Ov2ZR1sGRGIMG+OR6AOVQ4mj/fyg2phknrGD5wtZWuKvWhD+6s6//Zw3xVxeKiwn7sMIo2PgiIYrr5NlwDJPucFbegyCZ2fBQuqcA9P8WVTcigClthBHVfrZQ9RNQdgV16a9WXMydrwlxtRt7FrNbHUevAgJ0y50ANaGGtr5oDCBCVBknV8WwJJmy3fhXUSKgWrurLyJTa7lRYameygNGLuWP2U1on+LO9SBl1PXPUfoXIKFU7BjN2U4TWFoWJp+T8PRhBPxEi23tr9RwGhQCTZEKD21pKIfDC9yDTG2E7kuh1mYplkB5glgVoYvzjsCCJIw7qArdiOZ7jMlnjyAYBts8ZWQieELIy9oGNFDVu47e/N4Ga5EdUJryso9r3k4P+GV9sTnkPVcYOhDHe2GRsaaDNahCnacVQKaAw0Ry4uLD4pfdZtI5RgyivkM8qQOVJNPczIUlfo5Er4uT8K2voCBYeUCNQGGnXyhn0Ks354qU5FcITMeoAEDu5ssGO4KawvrNINnba6tayJhUuCM5AKt1LnB+WBdRLH7oTv5aJ+redEMI0/AirGo02+2J4bFv5f0Fx8IS8bUMaz4JGZFMjkP6V3alrDPkTSt5aZrZxix/Bdj4aAD75cVwCRQJLWq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WNXpiBm9w7ID5mfU8ltVvcUkDBhhyGliSXuPCxtSsyLj69wT47zIyKR4r022?=
 =?us-ascii?Q?ScZ8izYsRPdC7hWxsXdTz1WJFLVlrBEd2sDaK+PyQwebahfLmvTowJIS0pDC?=
 =?us-ascii?Q?8+UlueMwKKaKPpXnJLjc4qh0iWSFmactsLUJQikRyeeN1GH+W8mJbaV2MbMA?=
 =?us-ascii?Q?cRshvpra+ZLOKYOv5QRWIHcBLQPfyyyZ+S9XC6XTqBci1SnSg+CFP2RMFzr9?=
 =?us-ascii?Q?/RBIbIIeb6moTzqsX2SkEAR1nOyiBINSu8yLaTIAvN+3iQtVP4Ac1W5KrWPt?=
 =?us-ascii?Q?X41/eq04dDyr6D+BP0Af2BiDMRW4CcwbcdpKhW3Roy0yI68/sBCPoKm0ECOG?=
 =?us-ascii?Q?fIercsNci+1UtglMZEvP+tP8vHmhkhNG0okJP5kiDKarw1OlFXKSOIYPE4Ye?=
 =?us-ascii?Q?utiuu2mJIjeWhdN6gKP/MQuIS6jWYMFkOPlgS/rcTavtKn4V2liRLxw+lS1q?=
 =?us-ascii?Q?g9r2rpsuaPprnLkph+NmrA1c6P4EAN9VAoEp9t0SwioKiT8jCBTGitLrfJf8?=
 =?us-ascii?Q?9LidpdTfIPJlwZEXj+3l+6D4DfUBgXcxYILhnQ70ionKcHw7Icot1BooHEtk?=
 =?us-ascii?Q?XZFWrxkWt70vWGkKZinTrF3d6KTSlX9H0rsRx2sb6WIEN7lXG697TeDWs5s/?=
 =?us-ascii?Q?Yr4pfLgIx25D5L7pehfk+6u4NfY+Vh3ioTTn98xTX6zNhXy28lH4MaFKN7n5?=
 =?us-ascii?Q?vMdDVukgxH4Mpc8O33S2KiQFQ8Z0cPX36VN/NH1NBicxU8QqHpTHSuipfrE5?=
 =?us-ascii?Q?fDzKFFT9eM7oDuoR0tSrmT3Taiamm3tyFJZ7s6kQLJCsnZbNdYrVSzcETqxs?=
 =?us-ascii?Q?MUsDULViUTFp/086S9GSdVIu8D1WWzWZLFxuTQKgfJw+mW2AtayBsLCBTpi4?=
 =?us-ascii?Q?9h//8lj/6PWUP+HEqfHPS18GWIN3g3MoA18Tug9OQMQ/hTAk+4dxYp3NzG9T?=
 =?us-ascii?Q?hZcHY2iSW7Ao4rxnlAS64t9Gf+TFCz2NzUBVjmMs6Fuyi7HOC7G7mocydTpx?=
 =?us-ascii?Q?g7mt71SLd2icKSR1BYc0AGIMDrSlhlUQpT6gKCULsnR+8+N0cL96KmGFR3RF?=
 =?us-ascii?Q?T4Xj9LFqFb9XLB5Qxf0U1Tc2EuoyJntsVYQEeBaSinbOLW+sq/OEdiTH0G2z?=
 =?us-ascii?Q?Cb/sWf6DbkNOtlb7aKZotlDmr0kOQljVLP2D8IDVtNig3F3VuD9HgZIfSc7h?=
 =?us-ascii?Q?8l8Cg619UhC1P1o2siXcMvgw5NU+SZljv+Zvgoye7MvHVLuqN0VuNSVx+jnI?=
 =?us-ascii?Q?dkGiGEFSntgd6UKPPG0NkVD+p0NeObn1wwyVzEbs2vLht6DcLTWQYxPKoLhR?=
 =?us-ascii?Q?UTPBhUEX6F9d6ht1FWxXXLusEg7KV/52wP3Bi8jT8nad7uRF/hyaKhQIYfXE?=
 =?us-ascii?Q?RKBA0gijsmApSpM0zHQdQWCgRLQ48xksq0X/oNxqDO2y+dd2VASKC8xhrP8x?=
 =?us-ascii?Q?51xiW0kJ7ubEyvJ1UeCyty8u9GEjA4dmWad3GpX1sCVreTTxvm3kvXdiUJbN?=
 =?us-ascii?Q?BMXZFV0pGKlKrPfQUih9R0BizusHl7zAYwTp1mr8NGMYHsvV59Uinvx/Q2up?=
 =?us-ascii?Q?i0hkDszjdobxDmpja0Zh4kFKEqSf/8yiu75bUmc7Hiyc7hyuq20sKgnh610b?=
 =?us-ascii?Q?gCE1RnkHjLHDfDrngTPv8/YKyXkY9S1d6uEEa9w20/HtpL+WSFCrkWMV62sE?=
 =?us-ascii?Q?r6Y3Wv4u0b5jwy6q4JxiHPcfwatiQPZq8CSOBq582ar3FsrL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff048902-3153-432c-d3ba-08dec331d987
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:40:00.3404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNyZSQlXgjQkFgZfUIS57NTY3gPXyB3+NuQH3Tl0RbgXhgD2TVOs959fuqyMZame
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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

> Not sure if I'm being nit-picky, but if restore_id is negative, then idr_=
alloc will return -EINVAL. That -EINVAL will go back up to the create_signa=
l_event call, which gives > a pr_warn of "Signal event wasn't created becau=
se out of kernel memory" , even though the issue was bad input. Mostly, I'm=
 wondering if we need to add something > in dmesg if idr_alloc fails for th=
at reason, since someone could end up spending time debugging OOM when the =
issue is an invalid param.
> Or is a negative restore_id indicative of OOM?

Not a nit pick; nice catch.

I think "Signal event wasn't created because out of kernel memory" is just =
straight wrong - idr_alloc can fail with -ENOSPC if there isn't an availabl=
e ID,,
which is different from being out of memory.

David Francis

________________________________________
From: Russell, Kent <Kent.Russell@amd.com>
Sent: Friday, June 5, 2026 12:16 PM
To: Francis, David; amd-gfx@lists.freedesktop.org
Cc: Francis, David
Subject: RE: [PATCH V2] drm/amdkfd: Check bounds on CRIU restore event id

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: June 2, 2026 2:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Francis, David <David.Francis@amd.com>
> Subject: [PATCH V2] drm/amdkfd: Check bounds on CRIU restore event id
>
> The valid amdkfd event ids go from 0 to KFD_SIGNAL_EVENT_LIMIT - 1.
>
> During CRIU restore, ensure that the provided event ids are
> in that range.
>
> v2: No need for lower bound check since idr_alloc rejects negative
> inputs
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index e9be798c0a2b..850d6befeb6d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -107,6 +107,9 @@ static int allocate_event_notification_slot(struct
> kfd_process *p,
>       }
>
>       if (restore_id) {
> +             if (*restore_id >=3D KFD_SIGNAL_EVENT_LIMIT)
> +                     return -EINVAL;
> +
>               id =3D idr_alloc(&p->event_idr, ev, *restore_id, *restore_i=
d + 1,
>                               GFP_KERNEL);
Not sure if I'm being nit-picky, but if restore_id is negative, then idr_al=
loc will return -EINVAL. That -EINVAL will go back up to the create_signal_=
event call, which gives a pr_warn of "Signal event wasn't created because o=
ut of kernel memory" , even though the issue was bad input. Mostly, I'm won=
dering if we need to add something in dmesg if idr_alloc fails for that rea=
son, since someone could end up spending time debugging OOM when the issue =
is an invalid param.
Or is a negative restore_id indicative of OOM?

 Kent


>       } else {
> --
> 2.34.1

