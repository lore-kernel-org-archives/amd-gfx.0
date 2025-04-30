Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9CCC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 03:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23D210E26B;
	Wed, 30 Apr 2025 03:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HbSjCGMw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5F910E26B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 03:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrnDvQr3U1I882YGFJYTbqZxeI3wyNzlpjryTkzUtQaRx6rVHlrmjmQPsOaVynqAOrQuYcluCoplOVC7wBC6inWe9a12iwwohCEyTy8GRjvE9WaNOLg3tFtbGrGEAI/8wlNsTbMKH8BBc9dqO5tnnfgRBufEcTKPIrimhMLKhOeydoxBavss9qyRcgMP/DWDWriYBj+e7GOtejSEmYCx+W7r9dQKOI7g2Sug0N8UFZF7rkGZKXLeCHsr02RdRLzMD6iyme1LuecM0XBrPvOW/mx7EbA5JlzTx9gGghwohe2AFmbIXmdKBVCJkrJ8AorFYYK5HRfBecA6XnA/VdIqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w76IoWflulpJEtTmnBF5vLh9A5hZeELNeRnlYt9k4g=;
 b=l3tJY4m8FB/WyzybKb43C7cvvgN3QU/KogFHVt/rh5i624LO2e2bni733SLGETdV2dcYOcBFIcd2IvRebzJE0zTZsEeVRc835oXz5bGhglzj4FDGkmO6nmW2wZYbwZy8yHTaSqypYOzEM6JNNWopwwQNFBsPgd6qW6v9gQNpS3u104nDdGANqLW4Ys5YWTvOaSXzZ0dvWQRn9qPVyHR0/5q8aAUGPMTqG0HFyi3WyK3hiGRIyPwvh6CQYuNBt9KjYV0WR5+zXe9lXMHcV7/pjgHZGeYjJwfMyW7/xH7B1UzM0N0IkEauazMDb/v7idxHaTAv9pFXdleV3mdU3qky5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w76IoWflulpJEtTmnBF5vLh9A5hZeELNeRnlYt9k4g=;
 b=HbSjCGMwnIFg98/n2LCYCyJb14wpLXsNpYBkJUtoKjpAVjhow6k2FuWZ0Y3etBVICtv1OJTu8rAnurNF71M+F5D9OfBAc//BPdv6WC2u1EjD0ulgOYgm8VEVsJb++7y7ITuektaVc5qi99T/0UEqmmBQLcqn8gL05UiJhmmtIv8=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 03:37:56 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 03:37:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Topic: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Index: AQHbuNSUufXe4GuQCEK2IbT3YFaDF7O6VhMAgAADkoCAABCDMIABHTIAgAAJPrA=
Date: Wed, 30 Apr 2025 03:37:56 +0000
Message-ID: <PH7PR12MB879665119A8F973B14ECA3A7B0832@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250429070121.299873-1-ganglxie@amd.com>
 <PH7PR12MB8796DF080D6D991A7CC37ABBB0802@PH7PR12MB8796.namprd12.prod.outlook.com>
 <MW5PR12MB5684B2000B58EB14048AC397E5802@MW5PR12MB5684.namprd12.prod.outlook.com>
 <PH7PR12MB8796271082C5FDFCE2982FC5B0802@PH7PR12MB8796.namprd12.prod.outlook.com>
 <MW5PR12MB56844DEA086BDFEF16EDEF77E5832@MW5PR12MB5684.namprd12.prod.outlook.com>
In-Reply-To: <MW5PR12MB56844DEA086BDFEF16EDEF77E5832@MW5PR12MB5684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=277a55aa-6944-400b-8930-8ac0888aa38b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T08:51:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB9492:EE_
x-ms-office365-filtering-correlation-id: 83ffcec3-d0ff-414e-5760-08dd879865b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pJuvPcaG2velDP+Zh+nobhq5IXODArN50qumj75V/3vcvafFdRQMpt0/EXnC?=
 =?us-ascii?Q?o7XxtKbisxI56PpAv5Qe2tPJCRqqdMz0/QAWpIghTFlpl//3IF2iximt8Yuy?=
 =?us-ascii?Q?PFwKuzQFbpiLPr22EjELla9fkq+0J/vBEBQPuTf9V6D2Ooh6wADrbDrSYKSX?=
 =?us-ascii?Q?+XUAysDw47CPGShw3AOdUSymjRaXXXZ5MMbq401Iya/1WZj2bEasxVv8XCfb?=
 =?us-ascii?Q?MDzLpLWgwYcgvFE0S0IqwMAmWNTCmncWfiuW/458HFKlk+I3VwfexQu1FY4m?=
 =?us-ascii?Q?CJOGu38olCb8Yg8hG4XTO+YFOf2xqIDwKraHqTmcSOgsUxBQhImnTHnq+gHC?=
 =?us-ascii?Q?2vESIZzlmVizRFRMcxcvU/GACc8YBjXLOfeCgWhjsLQfRbKkt6SwyZ3MfK8X?=
 =?us-ascii?Q?Lre9r9SAUJw1IFKbBJ1njg3nREl2rQAu7r5lj8l03e/ws7trvh2EQ+gLJ74U?=
 =?us-ascii?Q?eQArniaf6D5t46sbARR79+Nz5GyRW7HoGezRRreatfi+69r+w+DrNiKZOU7R?=
 =?us-ascii?Q?46Ukkx5kwEOA21GdsFpbtsU4aFSqshdF8kcKfQNGqUD1Kjg7spi8oyIOeL22?=
 =?us-ascii?Q?CATioH+wfGFZ6v8BwpI8wiRHq0azVvgBKnQMQr6gpo6n1A0eCCovSpfAFRE2?=
 =?us-ascii?Q?mCdVrlsz7tEdsrisYdUIeswBsgajVRqByu1pNHc4isH7KiQu7DBSsDyCbqBG?=
 =?us-ascii?Q?vK9sm/DME0M0BnX/mM4yb/zLijV/2q9wYuluB4pC8RdnBfmXgNOFJVnz9clp?=
 =?us-ascii?Q?ihNGJqfWXD3XREzOkmD547i4Ejo0pz18kONHHXHy2G0F5R5Yvzvss4b6/cbi?=
 =?us-ascii?Q?sAf3Hx3JLpA2vgVPKfsUa1pewydfUaI/y4Q6AUwSxbP3KZVcVc5CzOmdUDh+?=
 =?us-ascii?Q?y0FmeP2mMX4VpIAet9sFCvo/W/ZdZzbTAw8qwjvg3Ef0I/AOJKtJ/Y1s0y+z?=
 =?us-ascii?Q?8rZJO5+oTvCgSQa7OQm8N9z5zGvaqRhbweKOPXZKSKMRZyuDjWV1em3NEKWb?=
 =?us-ascii?Q?SP8jGbdXFhPesaD2SC86mfgHyewBfnlN0wjfzE/G3upWYVm20fIhmFp0aDe2?=
 =?us-ascii?Q?HlqASE7ontAcjqG997sdW2Pzlwy7tNWmCAqKm3MDI3ImhQPvkVTEIlfN9BN1?=
 =?us-ascii?Q?V09pj1y70xTIV54F9d8fuM7IVQ0oNXZDJFAqOX8Yx5tviniWZLs641pGrSXH?=
 =?us-ascii?Q?MXkKrEdzxD20WXJuv2wx/r+GSasuDTsASGdgVw70pzAtkR/1q9mP7/s+9btg?=
 =?us-ascii?Q?ejpPCaobGxDgJinGz6k5CifYpeictWRfOBqxnWm+OR67AOGiL5DXfN70GAjM?=
 =?us-ascii?Q?IjhGF+eenqHm4tXZng7618p+I1HARwgYLHeeLBJvOTXaJja8/kzsUc5MUfBs?=
 =?us-ascii?Q?q1ATQ7kDUpFQRBwLcq0gIeuBQcpZMeQmUSV8W3Y0TmEeHGS3gy9Gpez/4jTd?=
 =?us-ascii?Q?8Jem/KiS3bIs7SkK5agfHXhZOriB0HVb5ZExUDSAS8KDyU4uaXzBIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9QHTl6C8wOb6QQOyhHFxxeKB05PhgSGEwaLJ4TZE4S4SHrpiEJ5dm2TdJaI1?=
 =?us-ascii?Q?CkoYLiTn87VJfZx0EICs6GJvO3hkv1S9xnZ1FBvVz2IstNUisWsKYX9RXWOf?=
 =?us-ascii?Q?F2LdIDotf12iWsM47biPVERzCERl4hiovTv65NrOvCIiaBrlhSK55B3MCgmL?=
 =?us-ascii?Q?7wNYCYDEQdc1eEF7r5xXINln+ZGUvVuKEhlW11NtYkQj5Zf1/HqHH3zjh4OY?=
 =?us-ascii?Q?22TySvLa2EbL2Imt4/G0qHttj4zxA2Y6Ww2eMSnN829dqMBeTyYru6IHEm2F?=
 =?us-ascii?Q?cnvYu8QoelU9JWANhqVDYHQBPJYzX8B7VCuV0oOTSRS2SFNWKIxBsNYprRq+?=
 =?us-ascii?Q?TTsQoyzGavopuaP3fMc4n8ERinMU3Gd+IwrGYlAmEmN3Y2huVF7HeCnOOMzK?=
 =?us-ascii?Q?ANCeJAlfzTRfP9NNQ8pjPmWBrczBsy6IwHX8dQG9YxaXRQh7jT5omQNYKVSx?=
 =?us-ascii?Q?nLUfTLlQrSzOm9At5denjuy86dg+/Nl/adONjM047fqAnUhqyup5voxR2azg?=
 =?us-ascii?Q?oWiQoLME9HZmmFKX7paR8AusJ1LXVdgRef13/61xcJMxuYuzIENHBgu0CO6o?=
 =?us-ascii?Q?CaHvVcDFiYgVtTjr/DzWvT3J0bgkd+wM6s32W+F54JGbRchXwG5iS7UVG8Hj?=
 =?us-ascii?Q?f5FzXRxE56k6WjZtCBg6OiqYGloTaBXkxD00+OfvTjMmzxr9kEUZbhRQ8F2J?=
 =?us-ascii?Q?hdDsPGC9ZFCvU01yep2II/aM7a1H+xxdTvaWemLHig8FOfMvTwijgQJ8Obql?=
 =?us-ascii?Q?Chta1s1lvRZEDEZ4nVp/DAoSD6whv/YcS0Y+0k45p3jlxUrTzPared0W8egl?=
 =?us-ascii?Q?ChC3VPuBrlZDey5Z9vWdD+2smOnSQDXq7MEbCmIpZMZYMOsLgEsV8ovZrj1K?=
 =?us-ascii?Q?cE4yqdXncmVWmBUb/2OetZVH2zXFpf0oAIAD9EeXzN/BXUO8N/4H+Gg8TqoQ?=
 =?us-ascii?Q?jX6pJRrMc4xGkkuBOkccobNdpCv/0Rx4AYpdkmGSiinr0OZInQxO0Vdqu2gj?=
 =?us-ascii?Q?mgBM+WPvaZV19VPvHB9tSUGAIdx9CaTjxW9tVy+2Tuk2ugPZ7AwkgU1Bc81M?=
 =?us-ascii?Q?OTAeTlS1QkfwAzS0nnifnHJC+IeQ+jUzgUo+6LVkrctzogb1ZvuPXMo5WpCW?=
 =?us-ascii?Q?fOzsX5xlGN2WxdFowRFwg0sv1ujZNtdhE2U2rUtXfO2hz8o0MUJ0uBG7pJCR?=
 =?us-ascii?Q?Sw6TLJZUra/yb9H1edyWGruyhihsExDH9Y8U1gocT4u4/iEMoW3VnGxssGnv?=
 =?us-ascii?Q?8yR5MJ9gngW5vR3sfLI1KF0hj03aSYGKMlJT9l/rKJiIq9/2OEHcUu9ONthw?=
 =?us-ascii?Q?A8+aFMpTD5Qt5NqY2E16PjoUx8M+mNph8CQIG+TyqQMzHeG8eH0aoGBSvsGs?=
 =?us-ascii?Q?RczBLNXqqrBlAOP/g0cKUUPK6m2yQbn2s32BX+jgt0FHlIwJMw/9Dmj4Rl3G?=
 =?us-ascii?Q?630y9nHc7O3NZsphwCzeOo6yvjr+crjUlziFQSC9QCtCbhTtJEdvZAlLsVaj?=
 =?us-ascii?Q?lHccCxVjZ+I9X5cJSC+ThMbvTkeD6+hD0WfTmC5Slt0a+LwS54YuwgjHNm8r?=
 =?us-ascii?Q?mpSMIWayWtoyk58Bqe4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ffcec3-d0ff-414e-5760-08dd879865b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 03:37:56.7265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4hggUymNpPKAXnovdmZTQJeDbHR8fbEECadDrWC2W5Y06FHKmoG8duY1ilu42+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492
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
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Wednesday, April 30, 2025 11:04 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, April 29, 2025 6:08 PM
> To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Xie, Patrick <Gangliang.Xie@amd.com>
> > Sent: Tuesday, April 29, 2025 5:04 PM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> > Subject: RE: [PATCH] Add support for leagcy records in eeprom format
> > V3
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > -----Original Message-----
> > From: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Sent: Tuesday, April 29, 2025 4:53 PM
> > To: Xie, Patrick <Gangliang.Xie@amd.com>;
> > amd-gfx@lists.freedesktop.org
> > Subject: RE: [PATCH] Add support for leagcy records in eeprom format
> > V3
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Xie, Patrick <Gangliang.Xie@amd.com>
> > > Sent: Tuesday, April 29, 2025 3:01 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick
> > > <Gangliang.Xie@amd.com>
> > > Subject: [PATCH] Add support for leagcy records in eeprom format V3
> > >
> > > After eeprom records format upgrades to V3, records that have
> > > 'address =3D=3D 0' should be supported in NPS1
> > >
> > > Signed-off-by: ganglxie <ganglxie@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 73
> > > ++++++++++++++++---------
> > >  1 file changed, 48 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > index e85143acf3a2..4f4e12452ecc 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > > @@ -2881,6 +2881,17 @@ static int
> > > __amdgpu_ras_convert_rec_from_rom(struct
> > > amdgpu_device *adev,
> > >       save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MAS=
K;
> > >       bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
> > >
> > > +     /* if address=3D=3D 0, the rec must be a PA rec under NPS1 */
> > > +     if (bps->address =3D=3D 0) {
> > > +             if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE) {
> > > +                     if (amdgpu_umc_pages_in_a_row(adev, err_data,
> > > +                             bps->retired_page <<
> > > AMDGPU_GPU_PAGE_SHIFT))
> > > +                             return -EINVAL;
> > > +                     goto out;
> > > +             } else {
> > > +                     return -EOPNOTSUPP;
> > > +             }
> > > +     }
> >
> > [Tao] better to add an empty line here.
> > [Patrick] will add this empty line
> >
> > >       if (save_nps =3D=3D nps) {
> >
> > [Tao] is possible that both "bps->address =3D=3D 0" and "(save_nps =3D=
=3D nps " are true?
> > [Patrick]Yes, all of the "address=3D=3D0" records have save_nps=3DNPS1,=
 so
> > when loading the records in NPS1, save_nps=3D=3Dnps. But it does not ma=
tter, I check
> "address=3D=3D0"
> > ahead of "save_nps=3D=3Dnps" , the code won't go to "save_nps=3D=3Dnps"=
's
> > checking at any case.
>
> [Tao] so how about this if structure:
>
> If (save_nps =3D=3D nps) {
>     ...
> } else {
>     if (bps->address) {
>         ...
>     } else {
>        ...
>     }
> }
> [Patrick] Yes, it a better logic. Based on this logic, I think we can eve=
n abort checking
> "address=3D=3D0",   keep this function as before. "address=3D=3D0" record=
s can be already
> parsed correctly in "if (save_nps=3D=3Dnps)" branch, and we do not have t=
o avoid "failed
> to query address 0x0" warning, it does no harm to code logic. After this,=
 can I change
> the commit message to "Refine records counting and parsing in eeprom V3"?

[Tao] sure, you can say "Refine RAS bad page records counting and parsing i=
n eeprom V3"

> > >               if (amdgpu_umc_pages_in_a_row(adev, err_data,
> > >                               bps->retired_page <<
> > > AMDGPU_GPU_PAGE_SHIFT)) @@ -2889,6 +2900,8 @@ static int
> > > __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
> > >               if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
> > >                       return -EINVAL;
> > >       }
> > > +
> > > +out:
> > >       return __amdgpu_ras_restore_bad_pages(adev,
> > > err_data->err_addr,
> > >
> > > adev-
> > > >umc.retire_unit);
> > >  }
> > > @@ -2903,7 +2916,7 @@ int amdgpu_ras_add_bad_pages(struct
> > > amdgpu_device *adev,
> > >                       &adev->psp.ras_context.ras->eeprom_control;
> > >       enum amdgpu_memory_partition nps =3D
> AMDGPU_NPS1_PARTITION_MODE;
> > >       int ret =3D 0;
> > > -     uint32_t i;
> > > +     uint32_t i =3D 0;
> > >
> > >       if (!con || !con->eh_data || !bps || pages <=3D 0)
> > >               return 0;
> > > @@ -2924,28 +2937,31 @@ int amdgpu_ras_add_bad_pages(struct
> > > amdgpu_device *adev,
> > >       mutex_lock(&con->recovery_lock);
> > >
> > >       if (from_rom) {
> > > -             for (i =3D 0; i < pages; i++) {
> > > -                     if (control->ras_num_recs - i >=3D adev->umc.re=
tire_unit) {
> > > -                             if ((bps[i].address =3D=3D bps[i + 1].a=
ddress) &&
> > > -                                 (bps[i].mem_channel =3D=3D bps[i + =
1].mem_channel)) {
> > > -                                     //deal with retire_unit records=
 a time
> > > -                                     ret =3D
> > > __amdgpu_ras_convert_rec_array_from_rom(adev,
> > > -                                                                    =
 &bps[i],
> > > &err_data, nps);
> > > -                                     if (ret)
> > > -                                             goto free;
> > > -                                     i +=3D (adev->umc.retire_unit -=
 1);
> > > +             /* there is no pa recs in V3, so skip pa recs processin=
g */
> > > +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> > > +                     for (i =3D 0; i < pages; i++) {
> > > +                             if (control->ras_num_recs - i >=3D
> > > + adev->umc.retire_unit)
> > > {
> > > +                                     if ((bps[i].address =3D=3D bps[=
i + 1].address) &&
> > > +                                             (bps[i].mem_channel =3D=
=3D
> > > + bps[i +
> > > 1].mem_channel)) {
> > > +                                             /* deal with retire_uni=
t records a time */
> > > +                                             ret =3D
> > > __amdgpu_ras_convert_rec_array_from_rom(adev,
> > > +
> > > + &bps[i],
> > > &err_data, nps);
> > > +                                             if (ret)
> > > +
> > > + control->ras_num_bad_pages -
> > > =3D adev->umc.retire_unit;
> > > +                                             i +=3D (adev->umc.retir=
e_unit - 1);
> > > +                                     } else {
> > > +                                             break;
> > > +                                     }
> > >                               } else {
> > >                                       break;
> > >                               }
> > > -                     } else {
> > > -                             break;
> > >                       }
> > >               }
> > >               for (; i < pages; i++) {
> > >                       ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
> > >                               &bps[i], &err_data, nps);
> > >                       if (ret)
> > > -                             goto free;
> > > +                             control->ras_num_bad_pages -=3D adev-
> > > >umc.retire_unit;
> > >               }
> > >       } else {
> > >               ret =3D __amdgpu_ras_restore_bad_pages(adev, bps,
> > > pages); @@ -
> > > 3040,21 +3056,28 @@ static int amdgpu_ras_load_bad_pages(struct
> > > amdgpu_device *adev)
> > >               dev_err(adev->dev, "Failed to load EEPROM table records=
!");
> > >       } else {
> > >               if (adev->umc.ras && adev->umc.ras->convert_ras_err_add=
r) {
> > > -                     for (i =3D 0; i < control->ras_num_recs; i++) {
> > > -                             if ((control->ras_num_recs - i) >=3D ad=
ev-
> > > >umc.retire_unit) {
> > > -                                     if ((bps[i].address =3D=3D bps[=
i + 1].address) &&
> > > -                                             (bps[i].mem_channel =3D=
=3D bps[i +
> > > 1].mem_channel)) {
> > > -                                             control->ras_num_pa_rec=
s +=3D adev-
> > > >umc.retire_unit;
> > > -                                             i +=3D (adev->umc.retir=
e_unit - 1);
> > > +                     /*In V3, there is no pa recs, and some
> > > + cases(when
> > > address=3D=3D0) may be parsed
> > > +                     as pa recs, so add verion check to avoid it.
> > > +                     */
> > > +                     if (control->tbl_hdr.version < RAS_TABLE_VER_V3=
) {
> > > +                             for (i =3D 0; i < control->ras_num_recs=
; i++) {
> > > +                                     if ((control->ras_num_recs -
> > > + i)
> > > + >=3D adev-
> > > >umc.retire_unit) {
> > > +                                             if ((bps[i].address =3D=
=3D
> > > + bps[i +
> > > 1].address) &&
> > > +
> > > + (bps[i].mem_channel =3D=3D bps[i +
> > > 1].mem_channel)) {
> > > +
> > > + control->ras_num_pa_recs +=3D
> > > adev->umc.retire_unit;
> > > +                                                     i +=3D (adev->u=
mc.retire_unit - 1);
> > > +                                             } else {
> > > +
> > > + control->ras_num_mca_recs +=3D
> > > +
> > > + (control-
> > > >ras_num_recs - i);
> > > +                                                     break;
> > > +                                             }
> > >                                       } else {
> > > -                                             control->ras_num_mca_re=
cs +=3D
> > > -                                                                    =
 (control-
> > > >ras_num_recs - i);
> > > +
> > > + control->ras_num_mca_recs +=3D
> > > (control->ras_num_recs - i);
> > >                                               break;
> > >                                       }
> > > -                             } else {
> > > -                                     control->ras_num_mca_recs +=3D =
(control-
> > > >ras_num_recs - i);
> > > -                                     break;
> > >                               }
> > > +                     } else {
> > > +                             control->ras_num_mca_recs =3D control-
> > > >ras_num_recs;
> > >                       }
> > >               }
> > >
> > > --
> > > 2.34.1
> >
> >
>
>

