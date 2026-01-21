Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A43AC44500
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 08:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3712910E709;
	Wed, 21 Jan 2026 08:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0E314lfG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C46510E709
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 08:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7U6fvNSKiTB92OfqCCLullakI/hM6gY5nSFAutqoXEGLanvS3t/rTzx1O2qEPFCuLsvzQAkcXBz7w9wOkDVxwYIycWMhO/rR3X/BeKvA/0vKwyechdRBToW5UBrMK9S7W4+ANHUBpec+kc7ZN/c6wHDguH9EQNJTyQY6qLc1tfeqD/nLR9n+VUvcDT3TMEv/MLSWyuebKxydvOLOl1EqszQbC5ltVe9zKumN29LiL3QHnWBsqOvNCB362rnYROwBgjo6Iw0Pq8DkwBB6WtBq0ylm+XNa4kvOj8wcISQNL2LW6x4tgiuoXfKeMlwK/n1oT8rr8f5TO4uhcrIjvMXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qylsMhc+ve3YrgQxorkttlRVAQMQLp8A23zmCVRkVvE=;
 b=OglyIpXqd0AYJ1lLS2TGZEwlWflJIueiGHYwndgU6X4pQsKEEoZwsL9V4SRjQ+Lo2fjC/+/Osr+4mfUN0+3+gBd7A014yif/VXPocbfEvwNqlaDHLfQjB6K888++ADNw74UH/vWSSMEG+X9i62cHyTIEPtvxc4KxpJmSx4PHxN4Ftpw8QHatbp5d8M+mz0wZiRxNycMxGhE+0+gTW5tFNLfmlSC32kDTBEkZzhAYYri5BkuyluIoau9hCccvz5R+ur88cuU2Os0tNtuZh+oqLUw9uXswtmS2myToVgsGRGdUbSPrguGVFhrzuk5gFFtCj3e+na/bSfqrW+aiwhDhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qylsMhc+ve3YrgQxorkttlRVAQMQLp8A23zmCVRkVvE=;
 b=0E314lfGbffXYMJm4KSv7rDmqboQ2dZhq/JDjvNXKlnqkz0zQvRHo3EB+xlQskIM1DoSk9dmEAuEIIqG8YiNq/zwBXT1UPCHexGNenF34m2ondPO5f1sy3ra/GNIfsdPOaDuS/jlKEercneOlsz3d2IRORXb9F/tzaaCqojGsVg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 08:38:13 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 08:38:13 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 10/10] drm/amdgpu: rework ring reset backup and reemit v4
Thread-Topic: [PATCH 10/10] drm/amdgpu: rework ring reset backup and reemit v4
Thread-Index: AQHcioJJq76KTgS/JE2EWFj9cGSqzLVcTYQw
Date: Wed, 21 Jan 2026 08:38:12 +0000
Message-ID: <DM4PR12MB51523172B3D23ACFECF8E1B9E396A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
 <20260121030057.1683102-11-alexander.deucher@amd.com>
In-Reply-To: <20260121030057.1683102-11-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-21T08:38:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: 12aec6f1-b76d-4146-0021-08de58c86a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TwiLo0ii+j1XzpoBIWZ8QgX9Y3SPxu7wzBGUYQ52fcT1RBcPKj7uAwreM6m4?=
 =?us-ascii?Q?Yj86O6B9adoiBUsuUizuQW1KmiCfBTywa/x1idynkmsyMuuiqJ0BJ+HbOCwJ?=
 =?us-ascii?Q?0ozSN2VscLmzJSWgYYv4eOxvxy2Sktjbmt1zTi75u33lqYfKPcEoO6y2kthk?=
 =?us-ascii?Q?aIU6H/uQvbAFjNQciPdDrJIDquFvMb8IDRNFVJm0t+O4NeuehaQe12fxi0ME?=
 =?us-ascii?Q?RQuudCyTi2Yx1z61ttLqPdebeeH6C3AbfixXsDJwiOJfvaIXf4eEE+IvFVt4?=
 =?us-ascii?Q?bGBqbi8Yr1jkys91ALQ+/da8hPfHRr0jOm9nj1Vu8r3A9x1WivVCXs8Q2fqc?=
 =?us-ascii?Q?b/FwNrLtbYKfvF6nMcPO+oKij1lRlcaCktHTJdowhVDvp2yfthdOzzrjiyV8?=
 =?us-ascii?Q?49TMAENbgJmuQbYOyBAT4ZT99yU3TKmxGjIi3EEY59HV6kj1k3RuvCWJ/grw?=
 =?us-ascii?Q?oGyjANQbkssL4AJUAjMPHGNLsP6SnU+DR9tjDWO3NanqOVedZ+WyCV0zmw3E?=
 =?us-ascii?Q?dUebgnovaVJOh4ppnx1SDjcX5ccYXXzG+FBdeFO6QXsC/b3RV1Kf6fZjEL8N?=
 =?us-ascii?Q?KD0igLt8ZLfFUZkxHcoIXOAynR72ov6j4euNqF3fH78kvhL+HCtl98sjsIsx?=
 =?us-ascii?Q?raOG/GX5EYFnw2zyO2MHn3+UTDZGRT5DZK6HD0JYacd4QqOJA7DrhsvtZvvX?=
 =?us-ascii?Q?csJIZiUB3sa5OIWS3Mvh9pTmJZGgSIvAS87ztx8ee/9fv3CDa8NN6LFaaWjr?=
 =?us-ascii?Q?P1TVzAmPDyvJL7JWQCRAmDsI31zcubfVcyeh3fXEmJIh0N+D3bygURqNfMUR?=
 =?us-ascii?Q?9Ev4wUq22pHtjQ0nBC9hmL2l1ccmgbg5RRF4+rVYcxqx7DnFk+pJpbVejyMy?=
 =?us-ascii?Q?CPGO0ZhbzFFJYJmlgtvSbP0OpEP1tsRGfRTo66X+eKPaKbQPOWCT3FJgxu82?=
 =?us-ascii?Q?OpnrsctQwPrURTfB2CCek91pozBt2FRUrbBWo64gGPXiNEUK2H90D2RfZybd?=
 =?us-ascii?Q?mjZBDihFiSa6kdisgQqiH3YqERWC1h+V5hG253fZXixXkMT1DEbCnt0InGvu?=
 =?us-ascii?Q?9lvQotDVrIt/EVzVKzzOVrMFLRe905/70JHi7acGZSBz6HVpxkrw17HfjvWR?=
 =?us-ascii?Q?hAEE/YH6YQgfw7CfeRXlBwtk7V8/AEVwS6asNtgdqGRmgqsuGgT9GJ4WmUO/?=
 =?us-ascii?Q?PDe11CGWUkELVSU5Ym88VnSAXtij109SyTqOpVovkrRDp7nJzBFe0gzHiBmk?=
 =?us-ascii?Q?VROArD1S6kLpRQWcVR0+mWXGszAyk7uVfHYT/R8bQL7A/0mOcelSk4E134ov?=
 =?us-ascii?Q?5ZSESpUXc6D4UIUdq6m65Z7sVda2hybaGLKa6g9DQ6J1z21RYQ568NGHh6I/?=
 =?us-ascii?Q?MSlQsdWsQuHDbw2+b/+eyLOD3d5eaIKdRS0yHiomyGE11cfmI0cfX58WEAdE?=
 =?us-ascii?Q?3c3Y8eSw2PRgMpF9L7BXcdJSRnkBsdRAMuC5IXzImSodMjd41tI9LZLzfY8/?=
 =?us-ascii?Q?yFZAAJr+UzTDND49iR1ioguPWI1orn2L72NI2mLU/iAvvAeYEfL1EWvhIrMq?=
 =?us-ascii?Q?BXtJqJDL436HYn0agsfL6VtupCeBMUAj7ARBu/SeD5u4C4tr5toeZS1ezB3+?=
 =?us-ascii?Q?zGVBzfv5VZjQlyhXck+LL0U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v0OX1XYE+N/ermNdN2UAf96cAih+7uiWVhpR20OpoGSLBqe5X/fcPYr6Tji5?=
 =?us-ascii?Q?rj2VPvd5xSuGF26xfxCSPsuCunhAaXXfq+aIteZ9Rc8ZPkO8TwUjtyO2eFJF?=
 =?us-ascii?Q?DauCppgTrzIOPKAqxIFWNcoouB3c5DsmFZNhKZ62cILq84s8dRSXgpfy4F3P?=
 =?us-ascii?Q?f+IzJoeYAXz36D4gMD020u+xwtDIJrx9LdzdZG1+ono45lDNoQuStkNLXF5q?=
 =?us-ascii?Q?HxplCYao3hj+LTpuw+e7bgkoeXHtW/B7F9ytrJGc8fOpIpNejb5R/LEn0L66?=
 =?us-ascii?Q?/IlzCmHVWr2YVNPg7hZ0cRAUgV+KzEQBEULow9k7Liv4027Nu2omIdF1fDNk?=
 =?us-ascii?Q?tf/5N/1aw72s7RKOUDE+TaoLCa6Mpxaitr2Rx3okwn1QFCrxJ4PN7hHTAb48?=
 =?us-ascii?Q?zPVVfzgPFBEPSVc4heirFxXhi8MoO3RZok8qZoW3eURJ9qzhlg0jdTkKUjj+?=
 =?us-ascii?Q?/oOWKFZtqIsx03lCOcGauhk7oJC5LFFMbjYU44w16JbffuXjw/jCjmAnENab?=
 =?us-ascii?Q?l5qypaxVTfPhUfkjQ+oOAn92/bAff2tNBwIqAAfKLHN+FkszRtv6z2eMaQHq?=
 =?us-ascii?Q?4HfH4LwRzx3O5TABFnDhuUWAR407sHP2ueClYkvE9nrUdzpLJG5dLycvBfGf?=
 =?us-ascii?Q?E0NWkY9aS6fLfEsotpZq+d7iKUkyKt+FCPzxCyPQZDTf68M5M+cU1/Tx+odF?=
 =?us-ascii?Q?l+2EK6wT6/upPyzegIn34Ho2zU52DrtWixIwaxI1ddW+e1EH21GCaSCICLj1?=
 =?us-ascii?Q?k31RqgQs6uZ2z1LOgYcijgb8hrdp70vbBb2aIsktDDzEqa20lm4+/QbMfHOd?=
 =?us-ascii?Q?fKG4VcjQoUalQsUEk4reBKeyKnwVWyueADY+KPBMlK/GxK0TSNOswOv2d+2f?=
 =?us-ascii?Q?I6Gui65M7Sm6kboaa+4dk20EnK+3iJWS5ImMWwX/k2szb+zEEw4h4zWHOXYo?=
 =?us-ascii?Q?DXYwNsmMOAiYkfoGlSZ7QE4vAsYwimw3WlwmfgRv5daUU9+W/dPGbIwSdqe+?=
 =?us-ascii?Q?ySTBgI+/+92NXFZw9heIDwwYZfvmuIlFjcFQla/ibCrDqMz9Ko51ZOkk4ft7?=
 =?us-ascii?Q?R12GUT18AT3ckFF3aNNn0Wr9cQtlqmji9wVkR9CSFKEo7BxqM4EKmgeBJQqo?=
 =?us-ascii?Q?33EP+sX6a/OxdOu4SC3CDmtHvkz2e+Fd/sP5kekEf2JsznleeemKV4bgssx7?=
 =?us-ascii?Q?+OVwzXq4u0SMHweMwNbGYbtVdvQGJwU7jyK9LTKlKY1TpkNm/P0x7HwQwR9Z?=
 =?us-ascii?Q?3bS8L8UlM85I/jMzUI7VgyfuKKGpKORZcpekMIPDet5WKfjBrZF3HSWTXMSY?=
 =?us-ascii?Q?Ak/t/68p/4L+Rsv9KpXqpvGY0ZRNt+P0PueQaEhvVn3VGo45dcnwgQF5//Be?=
 =?us-ascii?Q?q7ZGaRrO92C8drpFXIH9iBOK9Rka9mlUhFkDgXRabWoaaKitqj/Ro/LTwotj?=
 =?us-ascii?Q?xlqIejWChB3GoXYyIZovn5g9qKwfX05qSBxes8Xn4pWy+f+h6KZAaEZTYMQs?=
 =?us-ascii?Q?7fIjDSnPblWpfbY323LwdSsmrMuo53UbVZxMIeMf3JxTUOCpKhUNP1ML+fim?=
 =?us-ascii?Q?/jIs3VxgMv3OYHgJbDeAPd3P55KKQ5LJPGY3U11AroavLG9fkAbFPUV+hDNe?=
 =?us-ascii?Q?AMfaCqm1L0rJNej/pAXcpzW9+IpjxgjNVkZBrH7IVF0FCXIMJu4trUNUITsi?=
 =?us-ascii?Q?ljBrWRLRPLQN/au6TIpmhD/XawJzzJV4zxQ2Oj6i527xtPMJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aec6f1-b76d-4146-0021-08de58c86a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 08:38:12.9895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJewr/WhoHpE1Z6k3HaDjoEbkhkRrUTktt/x0jKZlMXursaMk0aRPIz+ty5g+A/4ixawrfdcAy40r2JJC0qkdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, January 21, 2026 11:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 10/10] drm/amdgpu: rework ring reset backup and reemit v4
>
> Store the start wptr and ib size in the IB fence. On queue reset, save th=
e ring
> contents of all IBs. Since the VM fence is a sub-fence of the the IB fenc=
e, the IB
> fence stores the state for both fences as the IB state encapsulates the V=
M fence
> state.
>
> For reemit, reemit the entire IB state for non-guilty contexts.
> For guilty contexts, replace the IB submission with nops, but reemit the =
rest.
> Special handling is required for the vm fence as that likely signalled be=
fore the job
> fence even if the job ultimately hung.  Skip the vm state if the vm fence=
 signalled.
> Split the reemit per fence and when we reemit, update the wptr with the n=
ew values
> from reemit.  This allows us to reemit jobs repeatedly as the wptrs get p=
roperly
> updated each time.
>
> v2: further simplify the logic
> v3: reemit vm state, not just vm fence
> v4: just nop the IB and possibly the VM portion of the submission
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 108 +++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  20 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  46 ++-------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  24 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |   2 +
>  5 files changed, 83 insertions(+), 117 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d48f61076c06a..68642aab43177 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -89,16 +89,6 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>       return seq;
>  }
>
> -static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af) =
-{
> -     af->fence_wptr_start =3D af->ring->wptr;
> -}
> -
> -static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af) -{
> -     af->fence_wptr_end =3D af->ring->wptr;
> -}
> -
>  /**
>   * amdgpu_fence_emit - emit a fence on the requested ring
>   *
> @@ -126,11 +116,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, stru=
ct
> amdgpu_fence *af,
>                      &ring->fence_drv.lock,
>                      adev->fence_context + ring->idx, seq);
>
> -     amdgpu_fence_save_fence_wptr_start(af);
>       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>                              seq, flags | AMDGPU_FENCE_FLAG_INT);
> -     amdgpu_fence_save_fence_wptr_end(af);
> -     amdgpu_fence_save_wptr(af);
> +
>       pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>       ptr =3D &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_ma=
sk];
>       if (unlikely(rcu_dereference_protected(*ptr, 1))) { @@ -241,7 +229,=
6 @@
> bool amdgpu_fence_process(struct amdgpu_ring *ring)
>
>       do {
>               struct dma_fence *fence, **ptr;
> -             struct amdgpu_fence *am_fence;
>
>               ++last_seq;
>               last_seq &=3D drv->num_fences_mask;
> @@ -254,12 +241,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>               if (!fence)
>                       continue;
>
> -             /* Save the wptr in the fence driver so we know what the la=
st
> processed
> -              * wptr was.  This is required for re-emitting the ring sta=
te for
> -              * queues that are reset but are not guilty and thus have n=
o guilty
> fence.
> -              */
> -             am_fence =3D container_of(fence, struct amdgpu_fence, base)=
;
> -             drv->signalled_wptr =3D am_fence->wptr;
>               dma_fence_signal(fence);
>               dma_fence_put(fence);
>               pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -727,25 +708,28 @@ void amdgpu_fence_driver_force_completion(struct
> amdgpu_ring *ring,
>   */
>
>  /**
> - * amdgpu_fence_driver_update_timedout_fence_state - Update fence state =
and
> set errors
> + * amdgpu_ring_set_fence_errors_and_reemit - Set dma_fence errors and
> + reemit
>   *
> - * @af: fence of the ring to update
> + * @guilty_fence: fence of the ring to update
>   *
>   */
> -void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence
> *af)
> +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
> +                                          struct amdgpu_fence *guilty_fe=
nce)
>  {
>       struct dma_fence *unprocessed;
>       struct dma_fence __rcu **ptr;
>       struct amdgpu_fence *fence;
> -     struct amdgpu_ring *ring =3D af->ring;
>       unsigned long flags;
>       u32 seq, last_seq;
> -     bool reemitted =3D false;
> +     unsigned int i;
> +     bool is_guilty_fence;
> +     bool is_guilty_context;
>
>       last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fences_m=
ask;
>       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
>
> -     /* mark all fences from the guilty context with an error */
> +     ring->reemit =3D true;
> +     amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
>       spin_lock_irqsave(&ring->fence_drv.lock, flags);
>       do {
>               last_seq++;
> @@ -757,39 +741,53 @@ void
> amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
>
>               if (unprocessed && !dma_fence_is_signaled_locked(unprocesse=
d)) {
>                       fence =3D container_of(unprocessed, struct amdgpu_f=
ence,
> base);
> +                     is_guilty_fence =3D fence =3D=3D guilty_fence;
> +                     is_guilty_context =3D fence->context =3D=3D guilty_=
fence->context;
>
> -                     if (fence->reemitted > 1)
> -                             reemitted =3D true;
> -                     else if (fence =3D=3D af)
> +                     /* mark all fences from the guilty context with an =
error */
> +                     if (is_guilty_fence)
>                               dma_fence_set_error(&fence->base, -ETIME);
> -                     else if (fence->context =3D=3D af->context)
> +                     else if (is_guilty_context)
>                               dma_fence_set_error(&fence->base, -ECANCELE=
D);
> +
> +                     /* Non-vm fence has all the state. */
> +                     if (!fence->is_vm_fence) {
> +                             /* reemit the packet stream and update wptr=
s */
> +                             fence->ib_wptr =3D ring->wptr;
> +                             for (i =3D 0; i < fence->ib_dw_size; i++) {
> +                                     /* Skip the IB(s) for the guilty co=
ntext. */
> +                                     if (is_guilty_fence && fence->vm_fe=
nce &&
> +                                         dma_fence_is_signaled_locked(&f=
ence-
> >vm_fence->base) &&
> +                                         i >=3D fence->skip_vm_dw_start_=
offset &&
> +                                         i < fence->skip_vm_dw_end_offse=
t)
> +                                             amdgpu_ring_write(ring, rin=
g->funcs-
> >nop);
> +                                     else if (is_guilty_context &&
> +                                              i >=3D fence->skip_ib_dw_s=
tart_offset
> &&
> +                                              i < fence->skip_ib_dw_end_=
offset)
> +                                             amdgpu_ring_write(ring, rin=
g->funcs-
> >nop);
> +                                     else
> +                                             amdgpu_ring_write(ring,
> +                                                               ring-
> >ring_backup[fence->backup_idx + i]);
> +                             }
> +                     }
>               }
>               rcu_read_unlock();
>       } while (last_seq !=3D seq);
>       spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> -
> -     if (reemitted) {
> -             /* if we've already reemitted once then just cancel everyth=
ing */
> -             amdgpu_fence_driver_force_completion(af->ring, &af->base);
> -             af->ring->ring_backup_entries_to_copy =3D 0;
> -     }
> -}
> -
> -void amdgpu_fence_save_wptr(struct amdgpu_fence *af) -{
> -     af->wptr =3D af->ring->wptr;
> +     amdgpu_ring_commit(ring);
> +     ring->reemit =3D false;
>  }
>
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring
> *ring,
> -                                                u64 start_wptr, u64 end_=
wptr)
> +                                                struct amdgpu_fence *af)
>  {
> -     unsigned int first_idx =3D start_wptr & ring->buf_mask;
> -     unsigned int last_idx =3D end_wptr & ring->buf_mask;
> +     unsigned int first_idx =3D af->ib_wptr & ring->buf_mask;
> +     unsigned int dw_size =3D af->ib_dw_size;
>       unsigned int i;
>
> +     af->backup_idx =3D ring->ring_backup_entries_to_copy;
>       /* Backup the contents of the ring buffer. */
> -     for (i =3D first_idx; i !=3D last_idx; ++i, i &=3D ring->buf_mask)
> +     for (i =3D first_idx; dw_size > 0; ++i, i &=3D ring->buf_mask, --dw=
_size)
>               ring->ring_backup[ring->ring_backup_entries_to_copy++] =3D =
ring-
> >ring[i];  }
>
> @@ -799,12 +797,10 @@ void
> amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
>       struct dma_fence *unprocessed;
>       struct dma_fence __rcu **ptr;
>       struct amdgpu_fence *fence;
> -     u64 wptr;
>       u32 seq, last_seq;
>
>       last_seq =3D amdgpu_fence_read(ring) & ring->fence_drv.num_fences_m=
ask;
>       seq =3D ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
> -     wptr =3D ring->fence_drv.signalled_wptr;
>       ring->ring_backup_entries_to_copy =3D 0;
>
>       do {
> @@ -818,21 +814,9 @@ void
> amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
>               if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
>                       fence =3D container_of(unprocessed, struct amdgpu_f=
ence,
> base);
>
> -                     /* save everything if the ring is not guilty, other=
wise
> -                      * just save the content from other contexts.
> -                      */
> -                     if (!fence->reemitted &&
> -                         (!guilty_fence || (fence->context !=3D guilty_f=
ence->context)))
> {
> -                             amdgpu_ring_backup_unprocessed_command(ring=
,
> wptr,
> -                                                                    fenc=
e->wptr);
> -                     } else if (!fence->reemitted) {
> -                             /* always save the fence */
> -                             amdgpu_ring_backup_unprocessed_command(ring=
,
> -                                                                    fenc=
e-
> >fence_wptr_start,
> -                                                                    fenc=
e-
> >fence_wptr_end);
> -                     }
> -                     wptr =3D fence->wptr;
> -                     fence->reemitted++;
> +                     /* Non-vm fence has all the state. */
> +                     if (!fence->is_vm_fence)
> +                             amdgpu_ring_backup_unprocessed_command(ring=
,
> fence);
>               }
>               rcu_read_unlock();
>       } while (last_seq !=3D seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 78987ecdfe03a..3e031e9e73e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -135,7 +135,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct
> amdgpu_job *job,
>       bool need_pipe_sync =3D false;
>       unsigned int cond_exec;
>       unsigned int i;
> -     int r =3D 0;
> +     int r =3D 0, count_dw;
>
>       if (!job)
>               return -EINVAL;
> @@ -178,6 +178,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct
> amdgpu_job *job,
>               dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
>               return r;
>       }
> +     af->ib_wptr =3D ring->wptr;
> +     count_dw =3D ring->count_dw;
>
>       need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
>       if (ring->funcs->emit_pipeline_sync && job && @@ -202,11 +204,15 @@=
 int
> amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>       if (ring->funcs->insert_start)
>               ring->funcs->insert_start(ring);
>
> +     /* Skip the VM for guilty contexts */
> +     af->skip_vm_dw_start_offset =3D count_dw - ring->count_dw;
>       r =3D amdgpu_vm_flush(ring, job, need_pipe_sync);
>       if (r) {
>               amdgpu_ring_undo(ring);
>               return r;
>       }
> +     /* Skip the IB for guilty contexts */
> +     af->skip_vm_dw_end_offset =3D count_dw - ring->count_dw;
>
>       amdgpu_ring_ib_begin(ring);
>
> @@ -218,6 +224,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct
> amdgpu_job *job,
>               cond_exec =3D amdgpu_ring_init_cond_exec(ring,
>                                                      ring->cond_exe_gpu_a=
ddr);
>
> +     /* Skip the IB for guilty contexts */
> +     af->skip_ib_dw_start_offset =3D count_dw - ring->count_dw;
>       amdgpu_device_flush_hdp(adev, ring);
>
>       if (need_ctx_switch)
> @@ -256,6 +264,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct
> amdgpu_job *job,
>               amdgpu_ring_emit_frame_cntl(ring, false, secure);
>
>       amdgpu_device_invalidate_hdp(adev, ring);
> +     /* Skip the IB for guilty contexts */
> +     af->skip_ib_dw_end_offset =3D count_dw - ring->count_dw;
>
>       if (ib->flags & AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE)
>               fence_flags |=3D AMDGPU_FENCE_FLAG_TC_WB_ONLY; @@ -
> 296,13 +306,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct
> amdgpu_job *job,
>           ring->hw_prio =3D=3D AMDGPU_GFX_PIPE_PRIO_HIGH)
>               ring->funcs->emit_wave_limit(ring, false);
>
> -     /* Save the wptr associated with this fence.
> -      * This must be last for resets to work properly
> -      * as we need to save the wptr associated with this
> -      * fence so we know what rings contents to backup
> -      * after we reset the queue.
> -      */
> -     amdgpu_fence_save_wptr(af);
> +     af->ib_dw_size =3D count_dw - ring->count_dw;
>
>       amdgpu_ring_ib_end(ring);
>       amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 129ad51386535..83750ab4e81b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -90,10 +90,13 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsig=
ned
> int ndw)
>       ndw =3D (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
>
>       /* Make sure we aren't trying to allocate more space
> -      * than the maximum for one submission
> +      * than the maximum for one submission.  Skip for reemit
> +      * since we may be reemitting several submissions.
>        */
> -     if (WARN_ON_ONCE(ndw > ring->max_dw))
> -             return -ENOMEM;
> +     if (!ring->reemit) {
> +             if (WARN_ON_ONCE(ndw > ring->max_dw))
> +                     return -ENOMEM;
> +     }
>
>       ring->count_dw =3D ndw;
>       ring->wptr_old =3D ring->wptr;
> @@ -104,29 +107,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsi=
gned
> int ndw)
>       return 0;
>  }
>
> -/**
> - * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for reem=
it
> - *
> - * @ring: amdgpu_ring structure holding ring information
> - * @ndw: number of dwords to allocate in the ring buffer
> - *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * doesn't check the max_dw limit as we may be reemitting
> - * several submissions.
> - */
> -static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned =
int ndw) -
> {
> -     /* Align requested size with padding so unlock_commit can
> -      * pad safely */
> -     ndw =3D (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
> -
> -     ring->count_dw =3D ndw;
> -     ring->wptr_old =3D ring->wptr;
> -
> -     if (ring->funcs->begin_use)
> -             ring->funcs->begin_use(ring);
> -}
> -
>  /**
>   * amdgpu_ring_insert_nop - insert NOP packets
>   *
> @@ -875,7 +855,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_rin=
g
> *ring,  int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>                                struct amdgpu_fence *guilty_fence)  {
> -     unsigned int i;
>       int r;
>
>       /* verify that the ring is functional */ @@ -883,16 +862,9 @@ int
> amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>       if (r)
>               return r;
>
> -     /* set an error on all fences from the context */
> -     if (guilty_fence)
> -             amdgpu_fence_driver_update_timedout_fence_state(guilty_fenc=
e);
> -     /* Re-emit the non-guilty commands */
> -     if (ring->ring_backup_entries_to_copy) {
> -             amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to=
_copy);
> -             for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> -                     amdgpu_ring_write(ring, ring->ring_backup[i]);
> -             amdgpu_ring_commit(ring);
> -     }
> +     /* set an error on all fences from the context and reemit */
> +     amdgpu_ring_set_fence_errors_and_reemit(ring, guilty_fence);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ce095427611fb..c6f674c457620 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -121,7 +121,6 @@ struct amdgpu_fence_driver {
>       /* sync_seq is protected by ring emission lock */
>       uint32_t                        sync_seq;
>       atomic_t                        last_seq;
> -     u64                             signalled_wptr;
>       bool                            initialized;
>       struct amdgpu_irq_src           *irq_src;
>       unsigned                        irq_type;
> @@ -146,15 +145,19 @@ struct amdgpu_fence {
>       struct amdgpu_ring              *ring;
>       ktime_t                         start_timestamp;
>
> -     /* wptr for the total submission for resets */
> -     u64                             wptr;
> +     bool                            is_vm_fence;
> +     /* location and size of the IB */
> +     u64                             ib_wptr;
> +     unsigned int                    ib_dw_size;
> +     unsigned int                    skip_vm_dw_start_offset;
> +     unsigned int                    skip_vm_dw_end_offset;
> +     unsigned int                    skip_ib_dw_start_offset;
> +     unsigned int                    skip_ib_dw_end_offset;
>       /* fence context for resets */
>       u64                             context;
> -     /* has this fence been reemitted */
> -     unsigned int                    reemitted;
> -     /* wptr for the fence for the submission */
> -     u64                             fence_wptr_start;
> -     u64                             fence_wptr_end;
> +     /* idx for ring backups */
> +     unsigned int                    backup_idx;
> +     struct amdgpu_fence             *vm_fence;
>  };
>
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops; @@ -162,8
> +165,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error); =
 void
> amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
>                                         struct dma_fence *timedout_fence)=
; -void
> amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);=
 -
> void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
> +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
> +                                          struct amdgpu_fence *guilty_fe=
nce);
>
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);  int
> amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring, @@ -314,6 +317,7=
 @@
> struct amdgpu_ring {
>       /* backups for resets */
>       uint32_t                *ring_backup;
>       unsigned int            ring_backup_entries_to_copy;
> +     bool                    reemit;
>       unsigned                rptr_offs;
>       u64                     rptr_gpu_addr;
>       u32                     *rptr_cpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6a2ea200d90c8..b7518eb4f05c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -848,6 +848,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct
> amdgpu_job *job,
>               r =3D amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>               if (r)
>                       return r;
> +             job->hw_vm_fence->is_vm_fence =3D true;
> +             job->hw_fence->vm_fence =3D job->hw_vm_fence;
>               fence =3D &job->hw_vm_fence->base;
>               /* get a ref for the job */
>               dma_fence_get(fence);
> --
> 2.52.0

