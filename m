Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2120CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 16:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 803EA10EB06;
	Fri, 24 Oct 2025 16:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0HTNgbf";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F7110EB06
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSRlHiI/gFEGryOMrZd/J0DcdDXtEQhhvZc1XpY+CJfn9mQNlY2uaQGeiN79S8NTdedVrxvEcXnwF6R7HC6bWPPw83LFeErTSLp2LN4sniCstyoBe8L0q6OM+DufKCLiLCCuaxO73dW7eTywDHtDXIERWZcijnOxKoufyDhaL6wmlVdzLb1anNzWaSJ39rC72FAdxRtUcdBlwZ8BOLjX+W9nRuuCs4fb82smcOUOqeyOK0WAXfdymDvxWXhuP0bDEm4h6TVdjlTWMbFqhNQdO7kqUbd8Pfvn/tsaaSd8tCOefX3GmB/EULZ+9Fy64sHhhIDyNRuQD9zpLnfyDKWnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja78IzFJnZQ/6+1QGrQSwzc8goRbCJWf6FYFog8XQCc=;
 b=Fcr0SZ4Nwt2cO4RZSxkXXetMyHwVMqM0NKUDoOghIoHXP5MgeFLhVx4qpWlNtozL+AMkV5kV6DiMO3Ax/ius4TBhNW8/OhY4IVavPp3c//Wl6P+R3wz2bIwGMhqc7IZWnIfHWdyW2qqlTo7Dar6ISF4DqFlaw2Btj0SLVe/I+XAF8owzSx0rE8hFB61fEUsDVOINCRu2s6NKf2VNcJOB3ep/GYKuTQeuBLdayVUm6eepxLjQXcB/uOvICik/T19B3r6uTZA1I81de4SLsZhHpilR4iemyhRkX1Jyr49SkeD5BmNEKLDFEiPm4eOtT1CWBEXCF+xDmagEceAzkHgs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja78IzFJnZQ/6+1QGrQSwzc8goRbCJWf6FYFog8XQCc=;
 b=F0HTNgbfoDFZJs4lbRHFoygLtjX7fhoK41ACfXUUkUmTeYOnPp1l0jFKLcos/2q14s5X/w2sW347c1I3BoDuM63zIqSzDtdshuM12df/7CFkaBHwaA/3jXBKA7w8X0oC10y9S2HOzZKeLE/Sk2n7rTBBUSVCBPQi+ITjgnGO6nw=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:22:57 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:22:57 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix nullpointer dereference
Thread-Topic: [PATCH] drm/amdkfd: Fix nullpointer dereference
Thread-Index: AQHcP3L07dBhOJuIjkyCiC7rFJn1/LTGqJJwgArVdQCAAAQu8A==
Date: Fri, 24 Oct 2025 16:22:56 +0000
Message-ID: <CY8PR12MB7435119DA8A9A0D14821240985F1A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251017143239.1483587-1-Sunday.Clement@amd.com>
 <CY8PR12MB7435B8B4D3B7F5A11E80600785F6A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <SA5PPF8ECEC29A97EE8691605DB2ADAAB4A9FF1A@SA5PPF8ECEC29A9.namprd12.prod.outlook.com>
In-Reply-To: <SA5PPF8ECEC29A97EE8691605DB2ADAAB4A9FF1A@SA5PPF8ECEC29A9.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-17T18:27:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH8PR12MB7421:EE_
x-ms-office365-filtering-correlation-id: 83fd6ba7-b99c-4218-b533-08de1319978d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uUkKpnbcTkxtg7apv6jiqHatem4NFdtuNFBb9jXuWk7U8kEqIwaNylkWqKic?=
 =?us-ascii?Q?lg+irkixBoNKvfOVfijPeT/2nPyxf39Ndpi023ELeyOSXaqri6tddrpmqv8z?=
 =?us-ascii?Q?7w3aAjJpe+a4MWfTbN4o8fNackqVZiOFhC5eTH/L+vbMZNU2vZg2d/tVoUlL?=
 =?us-ascii?Q?DXjdv5lA2owHihts+BHsq/lHGgxQ1tXtGCYIyMIbeB8u6pAMvU0/q10E96IR?=
 =?us-ascii?Q?Q4u+Pqb/jXO8uTEJ8NZ2ILhTFP1Z6llk24RecTg//tZMquRhC9doJ6ogr3UW?=
 =?us-ascii?Q?nbrYpl6xdKanFdSgFwpUkvz7XMhugfs4rLRv7w19GXxGav9LtCXVQPIZEN85?=
 =?us-ascii?Q?Of2ahUyfFutxMjqBrvnJYBAIadG8l4gDpctr9YNh/rcOEg7xkeVOjS9KYrtT?=
 =?us-ascii?Q?CpK/cEiTf8kFlKoW3P+d9Kj7t+NHXEbU1KyzP8i7C3slZIC+W1fEiJlS3/WS?=
 =?us-ascii?Q?eCmQp8AM8A10kIAKKwGbHgTf+OfWVMWKGRSIYBvXFsA6L2uwpCCxVdfPFSSl?=
 =?us-ascii?Q?rnf6FJjDhJNacQdCZFca50CxWIJux1JPMIuzeNb8MLkpAU+akqds5hfoKWRL?=
 =?us-ascii?Q?K9aVz6VlDVDVFdols5gc5FBV38C8Q6xW33CKlv9hiklOyWwdSwddM6L+Dllt?=
 =?us-ascii?Q?IUthKVWP1cYEz2frOjQmaCSszcdN1/ybZh8+J0yxNQ5WXCETPPLyaDbyX1Z5?=
 =?us-ascii?Q?km2uIP29pyJfJSlhofVlFsoVF7OceCCsxJeZeDrE5EMF5Yk9s594k+BihfYm?=
 =?us-ascii?Q?zSpeP7zR3DrRi9zsI12hQEOrCTMtmZgub9uxuiSCSEFIgLNJhxwRxRLTnMy1?=
 =?us-ascii?Q?jWEAeL/mF5jieQpjoLTuxsYfamyGCTLJr0yrapmZUyOcKyKXKesUQc/7FnEt?=
 =?us-ascii?Q?0mhDqwijNn+nxd/Rlf6q71HBa4tYnoXVK8NUK11+xtPDK2bt+xIQ00ZkY05Z?=
 =?us-ascii?Q?swLLPP6AV5qU6Rylyajrze8VJpH9cJpHUJ75CyfOVEepZYAA2zi1ogLWhsgH?=
 =?us-ascii?Q?W7Cb/oF2xVFTr4RyfN3jV3qRrw+Ii4MtOG2ToaqECuxjJp9Q/EOBaSA68BuG?=
 =?us-ascii?Q?Q5C1ZPYrMb0rwY0CqrlNVL2FoN8MAplvgxGetGVVTz3Lbfu8eNQsxdpKM/ra?=
 =?us-ascii?Q?LWvXmjo4RKB36zNcRhwJNbpEy223bmlFzJQBtmiuE1q45cCYIa93CcOr3aNq?=
 =?us-ascii?Q?GiyP3uFls5vXLhxHuR2W2NueWmysp/UAdL1RHSvPtG4WL+GplsosIr/AMrI/?=
 =?us-ascii?Q?uG9T+dSxBNsxcE3f7na/krAOezhKwX+P2jEK+Mnaotr0ugaldawNTdETbeNX?=
 =?us-ascii?Q?p/zdA/btcrqrzUbi5vNcGUfi69S+tLh3AQsMnF9QVewHY0jgNE5sUn7uFUAc?=
 =?us-ascii?Q?0izN8Idjhykkv2bWoqa5vSvidER3tEtx9LUbc9D6ADfufHeLWsyNwWHXQd7T?=
 =?us-ascii?Q?4C2bsHA4G834RVZ7T6jeaFpvf7pipaWn2LfSWFfkY2qBZbTjHa8yW17CPZC2?=
 =?us-ascii?Q?GfbLeJvOZc9qaBROd/EPVdDm4Z4JkOMzkxhB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3GdoBxXhkS18sLmmvzkY5rbUnXV7Zj3efntXVLgIppGdXo6/Xvq2LbtM2WGk?=
 =?us-ascii?Q?l436P9tmcmqH3YHYkkqiasaGpoFZGFGaDftW//0rfGxNMXM0m3+BH543DUmL?=
 =?us-ascii?Q?0upmpxmql1WV3hidyANrkx8tS1Hnb2u9VZFTC3/ugdxBiGp5KJfrA2zwVb5r?=
 =?us-ascii?Q?Cg0TtADjOLk1pWhYChWhWoEBCIlqs98IwI5qLMVndL1lb0yLK+VODjnMSi6x?=
 =?us-ascii?Q?GqlZHy3kiiZDRYqRBaP0ypkBwDmfloO9yEql9ADNjoTvpDM0sBkDJt8wUJcz?=
 =?us-ascii?Q?tBqMAqNQIdVsoNuFwoA2z5OicG4CysGncR1Xs2piU/gvudL8GjRkEx3p+eR0?=
 =?us-ascii?Q?tptgfPBmCwz+mA0AP+zMlAsfprtVdKUYVJP0hD5+UBbWx2/sZsqwkt/AUFOg?=
 =?us-ascii?Q?XlZNzs11u7elzejIGn53Cw64K1sFYblfPatrm8g5+insk2elTvN87zVFmlNd?=
 =?us-ascii?Q?E9sKWmpQEvB1Yt7smq4Q2kG00Cz0/mjazsErdkK17t7lh57XOMxZb/dE+/TH?=
 =?us-ascii?Q?3eUUt3+cc0aq2nsdfZGhFrkj597HmdFHY/Bp26SazB8nwWcwYnKjHzNfFkxh?=
 =?us-ascii?Q?s+og95d5utj+dwrUo+2qeBeJZnnqssvqOB+Bxo7F1Oi9ZRc6QcioTE4y8SSO?=
 =?us-ascii?Q?NXV7PHkukCojfyq+dPp3tfH+7/AcWxOO7VXkd8O3GLZOu0s4Icb1QMMpJxKX?=
 =?us-ascii?Q?Ieil0cdNL28sXUhyivlCX60F6UknAfvGBHRn4yMCeHYf9lzSgFeckqK6R/bN?=
 =?us-ascii?Q?BpCWb1gh+UB0YLGmrYTnK5CTALf6ouuEF4L2zF/yCWUkettaXQ7ipSGAv5qI?=
 =?us-ascii?Q?sMF9L+cYI0CpLQhZkQTA+1YCONhQczQXPLQg7XqlGZmCP8ObKk6BGXbOpx6U?=
 =?us-ascii?Q?0M26P1N4Pe9guJ/S8klv+R36+XL6CjY708wKujzv3kTTg1BA9gDwxLM1LHo9?=
 =?us-ascii?Q?kSzdj1cTGFgYEjLqIprRylSF0zCppk6KN8p875RowUTsERDeUMjuzzNyimCr?=
 =?us-ascii?Q?PgBFQdj24312tZ32e7fD3A+KoqxdWW4x5uHx1BkMXutClOzA/5kOEkLeMpKR?=
 =?us-ascii?Q?oKywAeLSnNmdrah92k8IXCoZ58uKArFPVPTnD0c1X9I7OjU47ExNiKkYcaTY?=
 =?us-ascii?Q?K5OFUcdIEPwfKjZ/8TekLRlXJ9Vy0nYgudFGtcRjUBj4QTQo0JVo3M5k4IAP?=
 =?us-ascii?Q?WJH6MPv7kHOk1wZB7amZy1FK7+bkQCtx+uVcbg1p8DclV9QNCphQdJX/Abmn?=
 =?us-ascii?Q?dX1neEI7ymLM9CYEEEm/ZuNDrreFcjZE6/Y0jKyXAZP0zDUABVIMdEycTZNb?=
 =?us-ascii?Q?mg2STVswRIXjPaK/3Rp3gLFLZXjROgHyK2DxCOq2YEsmHobdlUqL2/+rUpB0?=
 =?us-ascii?Q?/5EI/8T8+EwWHBGv1hPmukrPdkz9exVDjZFfZUT+cUHNVsZW+AHJOF9nwMTI?=
 =?us-ascii?Q?ZPoK4VdyhytV0UktYy5SAPb5SSp6esAig5yh2ovHGMuYXi4NcAp8E/rWQCIP?=
 =?us-ascii?Q?w3dBFvxuwVUaIV2Mc9SSdrDNmCJW9lp8xRcoxveNGGZMmfhldefSlZIYD4DZ?=
 =?us-ascii?Q?f3J4zyenJJoj4iHFPa8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fd6ba7-b99c-4218-b533-08de1319978d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 16:22:57.0320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cB8F7hcWeUkHwbekrOiDHBOhc5HTm5m531pkGXHG0lEuE1+qvuWPQKB1B1wcxup9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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

> -----Original Message-----
> From: Clement, Sunday <Sunday.Clement@amd.com>
> Sent: Friday, October 24, 2025 11:54 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kuehling,
> Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Fix nullpointer dereference
>
> [Public]
>
> > -----Original Message-----
> > From: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Sent: Friday, October 17, 2025 2:38 PM
> > To: Clement, Sunday <Sunday.Clement@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kuehling,
> > Felix <Felix.Kuehling@amd.com>; Clement, Sunday
> > <Sunday.Clement@amd.com>
> > Subject: RE: [PATCH] drm/amdkfd: Fix nullpointer dereference
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Sunday Clement
> > > Sent: Friday, October 17, 2025 10:33 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>;
> > > Kuehling, Felix <Felix.Kuehling@amd.com>; Clement, Sunday
> > > <Sunday.Clement@amd.com>
> > > Subject: [PATCH] drm/amdkfd: Fix nullpointer dereference
> > >
> > > In the event no device is found with the given proximity domain and
> > > kfd_topology_device_by_proximity_domain_no_lock() returns a null
> > > device immediately checking !peer_Dev->gpu will result in a null
> > > pointer dereference.
> > >
> > > Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > index 4a7180b46b71..6093d96c5892 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > @@ -2357,7 +2357,7 @@ static int kfd_create_vcrat_image_gpu(void
> > > *pcrat_image,
> > >       if (kdev->kfd->hive_id) {
> > >               for (nid =3D 0; nid < proximity_domain; ++nid) {
> > >                       peer_dev =3D
> > > kfd_topology_device_by_proximity_domain_no_lock(nid);
> > > -                     if (!peer_dev->gpu)
> > > +                     if (!peer_dev || !peer_dev->gpu)
> >
> > Is this a real failure?
> > If so, we should figure out why our assumption that proximity domain id=
s as a
> > counter for valid devices should work but actually don't.
> > Either way, probably better to throw an error (something like -ENODEV) =
rather
> > than continue since IO link data has now been assigned garbage and we
> > probably don't want to keep building the hive at this point.
> >
> > Jon
>
> I think this failure is not real or at least could only really happen in =
a contrived
> situation, like a race condition of a GPU being Hot unplugged(I don't thi=
nk this is
> even supported) so the topology dynamically changing while the vcrat for =
another
> GPU is being created and that messing up finding a device by proximity do=
main if
> the device was removed, probably not exactly a realistic scenario. But li=
ke you
> said instead of silently continuing I could do something like the followi=
ng and
> return -ENODEV,
>                 if(!peer_dev) {
>                         return -ENODEV;
>                 }

I guess the break on check wouldn't hurt but yeah ... hot plugging an xGMI =
hive node during load seems physically impossible and surely not advised.

Jon

> Thanks,
> Sunday
>
> >
> > >                               continue;
> > >                       if (peer_dev->gpu->kfd->hive_id !=3D kdev->kfd-=
>hive_id)
> > >                               continue;
> > > --
> > > 2.43.0
> >
>

