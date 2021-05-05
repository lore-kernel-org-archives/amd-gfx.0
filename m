Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB3AC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 22:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F71613C0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 22:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F71613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD606EC76;
	Wed,  5 May 2021 22:36:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D33D6EC76
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 22:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+RVnphvqnaOGRJgfZle3+zm+OdaAO8x7PYDYnpQzwY/lXUvDgtF2bTOQ6Mvb8VKn2EXgWdYRQow98E7NBaP0sX1hyYVz2IRkoCCc8juamaMfHwMz3L3hdk+KrD+2AduxJh0WvRn+FbxYXVZoU7O9+3UHX1oIAshX/1aKjVCMZIo1u+oWjhlqtDnwzjCJIuVTisSQ4fbKq5SrlDmVjJE/HNjASDHXY0JurQ0kpBu+aVMn11iWRVd21H7EP0cND1Gbzd6YnpK8YGp/VU5gvFOz90P79JzqJareBkEFVpvjV5yxf32qEpBrP1QIYXtqqEz/bZvmae3Z9OfiW3lLiWL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri1aA3dhzIhkOpkStySPgWHM/HpYnkUOKW8u8NO4ka4=;
 b=k7QJgL6ZPWPxJ28dNbado7tpglde2QlG9DbSf3w7Mt+ExLA8w0+C+mvP/Ye2Z3i3eC/+clBKx3S4VdtAdLSO20yj5hh/43+ygE5NH2i1Kr3Ri3x6RD0QBEtlZRZdDnmqtsI8aC+WnHoAqSWHQJSPhHH38Gh8uKGnfYDPrSDXVmft4uIRJ2kr4WA7t4h4HsyIrGmr/taIDZPGZo/gPhBy0vIGkCoXHFmFoqqYgMgpJYwz3t/ScuIOksrm9pXUB838z2dCogLeLZ8rBEFmpuExe3Y55rZUrffx7mfDRG7Ws3dgXZmOVQ6lvmK45udh4YI0D3dHRUGMrwxKU2DaNgkJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri1aA3dhzIhkOpkStySPgWHM/HpYnkUOKW8u8NO4ka4=;
 b=GkWC9+x/IlDQvM+PAj7xwF7khyLX7Nd04UKCZGk+QHEKGZmzWhXV/TotOdZMYQMRtsSLEwXfiU890LrAAgKHM2yrTXosjdes+KizzL3TotwsPOL3zwguc5C/lhKQ6hybLgFYT6ngXzsA/UofxfHJKmQPD1D7wH1m3z2/Rdl3kSY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.40; Wed, 5 May 2021 22:36:13 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 22:36:13 +0000
Date: Wed, 5 May 2021 18:36:09 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH 1/3] drm/amdkfd: device pgmap owner at the svm migrate init
Message-ID: <20210505223609.fi3zscuiit2smwx5@outlook.office365.com>
References: <20210505215001.3418-1-alex.sierra@amd.com>
In-Reply-To: <20210505215001.3418-1-alex.sierra@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:ec84:3f03:15cb:a86c]
X-ClientProxiedBy: BN9PR03CA0366.namprd03.prod.outlook.com
 (2603:10b6:408:f7::11) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:ec84:3f03:15cb:a86c)
 by BN9PR03CA0366.namprd03.prod.outlook.com (2603:10b6:408:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 5 May 2021 22:36:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48b464fd-ec87-4a58-64d9-08d910163017
X-MS-TrafficTypeDiagnostic: DM6PR12MB4010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB401066A00CC63440689A4E1F98599@DM6PR12MB4010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzWRs3ekBiUDzACUmMCaHBrfyYRrBP6rz1CYJ1fSKOOFAgggxXYtiAbde9Sx11l57r5KoD1uZoxwzTkpTNi+lsolUIvZos6u1xHAgfwA5ZR1T7xw1eH4ixBDUPrvdhaXQZKpUY9uUv0yuaAU9NK/lOPO97CvkiFXnYYorFBG2SoeaYm/+7sMux/H4c19zE9dCw22idALrsk4hiY+Nf+Hzyk33k5ZOkU4LplcmhxVNiYC6aSIzerlzZsVlszeRSAu4ibYe08LhuSTmKDfc32Q18BlXdysx1vqgj3jbaggd7srcCxkhrPNCN+mst+xdq5oWZXfoMkg8lf/zX1l7z9R4dU3jOsO4HTuRqYq7Tol/tTqLOVTDkydji+MQvM65liFVzfwCptUjg1SJkmlPH2qIA2PRQA792JqSF1tnMD7dqjyA7/2y4v/YryVI1MyjXuMq4VxJbYcKcxN+BFZQ2zbQMIugRaln2QLwRcWig1WSAuYeQyEfrKtIzlfY0jgtZCOY9YjrE5dtMDBRxhPdGG9WcszsqP1NH6xsnm40Bi4nRUIUZt3Yha0WgIaFBvy324lQNehMPkfLEamrxIG/rAmiVJI60n6XNyQhdd8IeixjI1setgXlbIEn+ojB4pASyRUQ4TO1Gy2YTo5YurAvYZjcViT1ChwI1Cd6kgtbxmGL086hsgCxLoO9Nk5JeQG9slnNAzc6kP5A77z78MWbb2EuRFXyJmMjIc2lD1TzR5N4YA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(478600001)(1076003)(7696005)(6666004)(52116002)(966005)(45080400002)(8676002)(44144004)(55016002)(38100700002)(21480400003)(6506007)(66946007)(2906002)(316002)(186003)(4326008)(86362001)(16526019)(5660300002)(6636002)(66476007)(8936002)(83380400001)(9686003)(6862004)(66556008)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b5IlsTZqYj16PNpdFR6dVEivsH4zmmFdbxuZIQZNO03NrpUokbM5m4M4YT/P?=
 =?us-ascii?Q?osLqs4xF+bUMRPLgQwv7sTzdkUA6kEzcL9F6o7JGbzGLM4eIubDN4UcC8RVC?=
 =?us-ascii?Q?YXNbml7TVhSHMi86EJjU12cLGWef78tEmJQtwF3o/9pdQ0nk0+aGQtoOyDH8?=
 =?us-ascii?Q?oxEUjihVmMV9f+rZqFfiaOoIcbxUR0ooNWQuIGTsdR92BHnD8ntyDkDBzho1?=
 =?us-ascii?Q?J0ZZAFwmmQ0e5zHgBqJ50W2ghQinRn39KFQ8uh9GhzFfVR+VHWuoUw2CXKFq?=
 =?us-ascii?Q?x7x202J1v0640J5/F6SYZZiR6+FU7WcvwH+80yZYLXVJhDwEbcJOpzR25pyk?=
 =?us-ascii?Q?ad+gxCnHdSOEJHketEJxlvp5EePlZQjTdbLDb0F83eBy2Vj52WNNYkN4cOlI?=
 =?us-ascii?Q?8FpN3+rpo7+iVAbXZahGY2v/eZArIP88O84RsN/y1CkNjK2rogRHJjPTgVji?=
 =?us-ascii?Q?m8xvW98ZP75efNP9KUeXMcOOtGFEAWYOQOxa33VpgIAiTHLCikCLpQF1buSI?=
 =?us-ascii?Q?VCAegt1nkQfG4YFRY3PRjL8TR7LSaAjUKdw31CtKu/z/QOcp+wiXjXF5o3h0?=
 =?us-ascii?Q?xdHRB6Uo8sLzcsypDhQ45mg7sZWumQ9vJvg0I3pJo4BSDTj4rr9d8dMMvXl9?=
 =?us-ascii?Q?Lus5TJJYSKytIb16lDUSuHIyvXXQ4v7g07BEhk94Gpng6vY3XXCrUjNRk+Ps?=
 =?us-ascii?Q?smwjYA3tpFdgPqf4WlZD32RgRwOZYDVtuF4bolyzMDmzRLHGeB3NTeb5Vp/8?=
 =?us-ascii?Q?gfiM79RfEqn/UTI6UuLEtFCW3SCd8/UmDgfmH4Q9+M8xv9YM8qNKqQiRFwoQ?=
 =?us-ascii?Q?26H/Y8RNIxFwBhcVPtGt47Ck7V1v74gfCWVswvojWePDJCFIBeIuZLL5w6gw?=
 =?us-ascii?Q?BA4RyufRq1/qyGZ+m0CPIpmd3Oiaw/fjuYHhGT/bUNU5oDGy0tWmjo2qqXhH?=
 =?us-ascii?Q?x36HYP/4seNlOkjSBKGIF+XhNWPAGGvVJUxHDfhT0R2m83QptdtefRV1Wy23?=
 =?us-ascii?Q?3Q+2sJALkuTQUVFdQpJk+SOcjJtRSGvymqv/ArcHMul8upTJRIiwcQ0Dw9iw?=
 =?us-ascii?Q?iysU3BbQsKcs5Yfvm7sLJrGkBD2tOkDScD8o6dX2IWBCkDhM7qCgoCM1vF4L?=
 =?us-ascii?Q?5gI5jkI6k/ZWiyWz5RSqwpID2o/Se3Vau0Mmbj+SR37cOifoh5W0bjr42l+u?=
 =?us-ascii?Q?9ceOVA0r6/IEmR94pyV6rK/9ItPAo1pk6HCEebL4V+mgKZo5+jVB86TuQrQM?=
 =?us-ascii?Q?5UTfzeASCFVlM45Aj0DrvvoQGvMjDPNChqs4btSCnLE2zkogV4JCnTnx6sCd?=
 =?us-ascii?Q?APVR462Wu0L/s07e8RMsnUTESL77Q8/XyErhkKolTGiIOpwGwM80kMhpweJ1?=
 =?us-ascii?Q?Yx+dasORwX6yw716tM/TH2H66K/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b464fd-ec87-4a58-64d9-08d910163017
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 22:36:13.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuVjmDMrveWB5dB9dGDHRB8tTv1QR8Tpa9G4pBi62OH0QsnwVaO+RF2VVCcg+SFD9ElaoFVYJVTHFgqZ8TovMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============2107795775=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2107795775==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tg7yxr7qpa3ahrnz"
Content-Disposition: inline

--tg7yxr7qpa3ahrnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/05, Alex Sierra wrote:
> pgmap owner member at the svm migrate init could be referenced
> to either adev or hive, depending on device topology.
>=20
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 6b810863f6ba..21d92de235be 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -426,7 +426,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, s=
truct svm_range *prange,
>  	migrate.start =3D start;
>  	migrate.end =3D end;
>  	migrate.flags =3D MIGRATE_VMA_SELECT_SYSTEM;
> -	migrate.pgmap_owner =3D adev;
> +	migrate.pgmap_owner =3D (adev->hive)?(void *)adev->hive:(void *)adev;

I think you missed the spaces around "?" and ":" in this patch.

Thanks

> =20
>  	size =3D 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_=
t);
>  	size *=3D npages;
> @@ -641,7 +641,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, st=
ruct svm_range *prange,
>  	migrate.start =3D start;
>  	migrate.end =3D end;
>  	migrate.flags =3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
> -	migrate.pgmap_owner =3D adev;
> +	migrate.pgmap_owner =3D (adev->hive)?(void *)adev->hive:(void *)adev;
> =20
>  	size =3D 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_=
t);
>  	size *=3D npages;
> @@ -907,7 +907,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
>  	pgmap->range.start =3D res->start;
>  	pgmap->range.end =3D res->end;
>  	pgmap->ops =3D &svm_migrate_pgmap_ops;
> -	pgmap->owner =3D adev;
> +	pgmap->owner =3D (adev->hive)?adev->hive:adev;
>  	pgmap->flags =3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>  	r =3D devm_memremap_pages(adev->dev, pgmap);
>  	if (IS_ERR(r)) {
> --=20
> 2.17.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7Ccd057517621142c86d6d08d9100fd033%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637558482375385783%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3Dj2z4VJ8ZGKim3R5BxIOLNRwjj%2B6yanIKNd5JQp738P8%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--tg7yxr7qpa3ahrnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmCTHdQACgkQWJzP/com
vP/f9Q/8D1dO0ZScTiS+KfTS6n7RIre/H8vmpqq/Ned9Q0ek8Yu4qG9QaREaHXCv
P9wS1Yssg1tyE9+UvHrJTOPZndt9Hs9vZ1SdC2qT3QY0wLPTFQQsdW4Gx9JPzwuA
fK4b/yXzITmejnbRf0xmOiTgdNzMRrQIaPTY/FOuPxZjVPyqVftKdByy181f1TNP
YLPOkiOcSWYeDBZRqOylK5DIgJazvvLBrfEOyNM9WxwXoAY4XQOXdxiRQnLyIX5m
C3W7W30NrFvmnelkElezv7k4soCIau4Wm4osG8S+z3iXt8QWpzX/NxD3amPgyb75
6gk+MGjVs21pXJaG8UryI1YNqeRMyzBMijtyzF4njR3ICFg+PE8mZX4IhH5YYWqT
euDHz5LwO1AlWs43mshOm8ZYpoA8YmjOejPTWsq1gEDLoEIY156YFuQxTlMX1HyO
wDWuGLYdGzGb2B0psIas1zxp25ZMJvbFJHgyKbeIIS3WQNRsG6z9UWzDHQu17ROc
0LhUkLehVvYeCpsvHFYhXtx3sgNBG21jPhvWX/drsnL9OaUI5eACQ0NWjx3jh22m
mwbXZKT1gDtfUWFcbtKNcl5ROod6qOEof1NDZuIhJk0YLQa+e/7lXoXaqEwZw/sn
u18MoNp2K6ZT0Or379ifK8mGF4c4sMFiSZHSP2xJ0txdilJXGkw=
=5p++
-----END PGP SIGNATURE-----

--tg7yxr7qpa3ahrnz--

--===============2107795775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2107795775==--
