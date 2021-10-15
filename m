Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53153C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 02:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF0A610E8
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 02:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDF0A610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684076E218;
	Fri, 15 Oct 2021 02:18:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D821E6E218
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 02:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJdBHeZ7Qar852yIGGsgSA1eVwj6i/lRB8zMiye0XfVFkh79oqbLlHqko2XXJOEcLb6bBIH+W0BOdxA/pxKJve4tPvKx+59xiGlZ4B9sN0hclsJ61N3FqygOQLOs6mcZdLkpn3ctl7PPXAtACZStNGVXkOe+w9x5OysnjGeNjgl1+9foB8f9t8K120Q2p6wgpcgCBEcySocg6+JYo8ftodW2QELpdAXOF2J5h9z4ikmBue49b9IYe3iQmb1OJU32Kjzsftn8AvWWmflra6NBayBVYIAnq2Kn/UjfkAR553Ve+xNMtLYEpaKWm0aGkVPgrApkSKTXWbLDEGCbwTyMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YilWr5LjIvEOjKsegkQ/ZurqAkokeJvvM0h4eScDdbA=;
 b=LVG+UUV3jqf8KY4Aw6oOtXL/YFaAqw9TtcJucWd/Te2i8WVeZPJLLnUNSKiGToditIZNDx1ZRx8btCPQ8sN1V7Pusu06kVHikoRWuno3IOn5UcYqQ1TQD3cPGsb+eRupmuOCvJwsCSWGLN+T1Iq5Kleg4ah2Xu2YMdUwqeW/wrWy3X2qoJ5M+vT2qdbbbnwNWgaiSAVpvcOOSHl4frtAPG0HAbtPiAh8oGjTMvER6zzxGzfT92Sq8K9bwoyVstCT1d77xCW/KWdcj8NjZW3aE9uoH3V42Ucl9JqfNRk2U4nhkA1DtFtzGsjGEoerV7NXv5vO3Gkha+Jod5S9A32w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YilWr5LjIvEOjKsegkQ/ZurqAkokeJvvM0h4eScDdbA=;
 b=b8Cvlky75Z+eAX+0Fqe1zcF1EGlfgQaZ+I0Rd0BYQDRUohvWirkFcjhJYqmJmRUOdWUP6zm4sDUZI16Z4hKwFSNIOzwypoUDilSJNZRExkL5wfZoRYNeAUeHkIIO8dUGGpybEbhM6MhVvGImYdrEqmDT5YLmmgkGQHwPskevZRA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3578.namprd12.prod.outlook.com (2603:10b6:5:3c::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 02:18:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 02:18:35 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx10: fix typo in
 gfx_v10_0_update_gfx_clock_gating()
Thread-Topic: [PATCH] drm/amdgpu/gfx10: fix typo in
 gfx_v10_0_update_gfx_clock_gating()
Thread-Index: AQHXv4fhbzRzdVJiJUifec3+qDgbuKvTVsWA
Date: Fri, 15 Oct 2021 02:18:34 +0000
Message-ID: <DM6PR12MB261904FD4ABD4F4C194A93C9E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211012164003.1073534-1-alexander.deucher@amd.com>
In-Reply-To: <20211012164003.1073534-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-15T02:18:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=835e88f0-2662-43bc-804a-4e66e9550840;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 980e5d6f-9f0e-499a-e69a-08d98f821773
x-ms-traffictypediagnostic: DM6PR12MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB357862D4BF167F2F46B5774FE4B99@DM6PR12MB3578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kBgczx1fso4uHkXn71z1KITbzwM1nHwNIoQhpH+IfePmmy8SHwZ51ozh/65qQs/w2Geo5RjGktiGIlcwdNjB0+NL/+lovfl/cDJeaTP42Y2Ou08lNo1jE4GNnKwbJmW6B7w0hMGi9KpmMo5bVNjZc0ULs1ECB8Q7Q7/oBjCJqoEsKF+9CI/4kV+vKvRg8sJnfiajiobNNMow8+bG3Ng9lMzi/0ogNusVeSHzIlrsrrNylXRg4e4RXR/56oNhVNp32MeduwymzETFNXEYQYT/KkWGVJql8qSRUC8gjGuc1pg0KzK/tl9kXZukIGVH2KH7kl5kBrmUGRjNNoxxIGPoRVxz1fqXy7THkjy4ZLzZJ1pQo1dQH1mlbxY9jFnh6NtfVg8+tjS6fxB1ompKvV+x8EXe0xW3G1zWEoMsd2T8DuynPohYQkrveozb+RzYSSOrG7XiskxKNdNtxNIlzv6yuxW096T1gnPCFOWcvUWfky9K9DT0oNdVaeN9hCVVJpoeA4hCFJZ7MXyXDVrfRRtlXFQgOHGf5/qlmHbtncaNcvZy6a2VXJ5ON2ZcuKvo6PgfPFPL79Ot6HFBtOgzzTcYMUWEdf5OqFEV+2ha8XeJiVYiuNVrYgZEve8YzCiotV5kcgmTJT7eMtogrYx8bnH9s6IK3WT/8fyTz7eNH6JpfRScbk/hBXW5N5PcDqH/ahG3KIhCKIfMCCkajqcTEdXd7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(86362001)(33656002)(53546011)(508600001)(26005)(6506007)(8936002)(4326008)(55016002)(2906002)(66946007)(316002)(66446008)(76116006)(186003)(8676002)(52536014)(66476007)(66556008)(64756008)(7696005)(71200400001)(38070700005)(110136005)(5660300002)(122000001)(83380400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X84wihW68Qvd6gQmhGgQYFNTiTxg342OLU0Tnq66xzmiV+/AYrEBBUVLCab4?=
 =?us-ascii?Q?oR1QIbQZhMUxCg399gMiYBZFTStuKpnIofyNwQjnBh22KZ14SoqqtBB8vf20?=
 =?us-ascii?Q?+Ch/fSgfmjd+IFz6Cx5idJNSsnvwozn3J07qfrwR4p59Wmpcu4eeWR3+eQih?=
 =?us-ascii?Q?uDqth3I37eNUValoYbxlLMDbG/kOE8NH5wAQTOLpVrBiNPxYCm6M2WXIsWql?=
 =?us-ascii?Q?3yI6TuiNtRnKKNKRRwnEjROFe+aVSgr/g4oaxo96E6tUu331Y9YTL0u/sDLC?=
 =?us-ascii?Q?1KkrtEjRWGo7zh/NoIkEvoNmyccjYPgh8EGwqGpFr0Yxzj3MXdIl1M3CYTyP?=
 =?us-ascii?Q?BaSAhzJ6D1Mtu4fyj1bDn07DcuzQzmfp0P2skN/o4E464lNsXt4aiWHF2wTW?=
 =?us-ascii?Q?e4pvtf0D2IBDG2pQkRwkjPgBkcc9BSZ1wFfaj51hmgl/lOKmHtozP4GtdEL5?=
 =?us-ascii?Q?E0c5vmMA0mNblC3LpS3xwu7Wr2yBDshLO+3mgUjNrUC6OjuASJ7Eb23NeqJ2?=
 =?us-ascii?Q?1vnRVulFaZxtYkQs3PkgvWj2SJbYN7mU7/MJc1JEKT9ThswUdRehgYC/lfpf?=
 =?us-ascii?Q?LrFdkT/NBuvPmPee+XqCFVVF9ihnYlRkhN+AwHOUb+euwYoeByLlwyn7JNR/?=
 =?us-ascii?Q?T/DlY2W/7GvSH3i9eqxaHqMlNgasHvJrA/z5/rtLwYV9sV1vi+IaHrbgdO7U?=
 =?us-ascii?Q?t1e9+VnTvugoESroNtiKbuYilNnbJyWobTierPYOEV+4ylPiI021c9cKklb1?=
 =?us-ascii?Q?sYrlrNgvyFzCNQUTqFOcjOV9QlKuvNLAlQUfDPEwCfP+4iTk0Tsa2C9SCdHZ?=
 =?us-ascii?Q?j5SjHLuM4K217tv6BsCVEvCSdeqd7juZqetaGA+X8iNh2LqT0tlmZYv3bdrK?=
 =?us-ascii?Q?oEa1OAihId7rpiDsWOI3V/UfVfVQkPRfApBTBq2iCy8qYen+x1E5oSRyud8l?=
 =?us-ascii?Q?WdmMHmgNRBa4Yp+WltLaIdPMY3/LUfyvtnZz7GhC2fKJ6To1F3AVUTbcWLcK?=
 =?us-ascii?Q?npKj4//gLLypboe3bCnVz7xuwVuUDBJirr01rcucuPpOOQlhf2JvKdKuCaZ/?=
 =?us-ascii?Q?rYCdMuS0HvZCe+zwDjNTuyzAqB2hO+ys8s03NyK0WHRkSnGN9N+kkvmOdOJN?=
 =?us-ascii?Q?nrSPaMbHOfgmcTDlRtti/wUuwHuHBIr/E+NFm1PwX2kwqf1TlQJ1C+MVfHkO?=
 =?us-ascii?Q?g/hZMNd/TB7UeIhJwOW2J037TrBynVF0fWnBfIP/oFMakie1w9HxzLLy4mab?=
 =?us-ascii?Q?jPoPDmvINWT5co/nODpWN/rJZwgy2g/5kPyKsQbsYFPGr/4zb/L5wm2qaDIU?=
 =?us-ascii?Q?mi5zbwes5VHJ+yjb2EbV83Uw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980e5d6f-9f0e-499a-e69a-08d98f821773
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 02:18:35.0128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eD6dqvwBUtax1YnWdmU9UPmK67hZX+VLfkNaWzV40A7hwofTyTyPAuvprZknmZr+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
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

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, October 13, 2021 12:40 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/gfx10: fix typo in
> gfx_v10_0_update_gfx_clock_gating()
>=20
> Check was incorrectly converted to IP version checking.
>=20
> Fixes: 4b0ad8425498ba ("drm/amdgpu/gfx10: convert to IP version checking"=
)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 71bb3c0dc1da..8cec03949835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8238,8 +8238,9 @@ static int
> gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  		/* =3D=3D=3D  CGCG + CGLS =3D=3D=3D */
>  		gfx_v10_0_update_coarse_grain_clock_gating(adev, enable);
>=20
> -		if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 1,
> 10)) &&
> -		     (adev->ip_versions[GC_HWIP][0] <=3D IP_VERSION(10, 1, 2)))
> +		if ((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1,
> 10)) ||
> +		    (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 1))
> ||
> +		    (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 2)))
>=20
> 	gfx_v10_0_apply_medium_grain_clock_gating_workaround(adev);
>  	} else {
>  		/* CGCG/CGLS should be disabled before MGCG/MGLS
> --
> 2.31.1
