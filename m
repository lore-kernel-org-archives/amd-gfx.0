Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7157DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 08:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B24A10F98C;
	Thu, 10 Mar 2022 08:23:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC5A10F98C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 08:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn76CL11IwlzFgtY6vbV1mGg8bdw1y3YNhkQ7egHBx5+AlT5UzpQvYcjrrFaFuePyWpOQ2Bqj9G3ylyjMNpjqzWbw5aq8fafgXcLte7O5QE6h0vQuDZRinVzu9oEamWfHl7Bv+BazI/ryem09SLWDUdV9c5bRUX5UQxy3uERpzLwF3hgmkbygDscH/16aHFKb7VTBFm9MoyHXx5lPgnzaa0PC9xxWy+WTp4GvTmvuf+nF5NEMmvh1/P2sv668lE0Chf2f7rwz5pRi8eS9rVsd78jNTwICtF7dHfT0URb/6WTVMYD90Xs0xKQ8zPAuwn3hn2QGHSSZXqebrkOBJeygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfwXXX9CKHQTAp8qS7wQ3DTqOWJtZw6Uf61apH24Y3Y=;
 b=g70+s1qtgKQETFcqjLltpEtFiqAcTNxtLqdPhpa1hJ7D7REAs5eQLR/ob7ALxGWteQHtursWJCZTP/FX5c7MWE0P6SNj2MUVKZa6PRgYoBkl99FDc1TZfi/97jwQbrGpJme4ZABlVmQx0vFLtnns8dEW9L9okE8B930LCTk3nzxw1wTc2RJG+Y75eHFej/U22AkzB8KybmQHfUMSDu8hsC80M4OJK34U2QaADUARFLO7Y18gRT8RUeU0SoldbWkJk4H1WeTOO4baOz/sVYC/w1pcqWWN23GjIxPwj0CZdiAiKrvr1d9hEXx/Y4Pw8RSW6KimCLobUm1PJC3f65x0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfwXXX9CKHQTAp8qS7wQ3DTqOWJtZw6Uf61apH24Y3Y=;
 b=ZnQiabdnNMWerRuREXROB4lgujFtRRu3xzteDa7NtAAnUd12rjNmgGAWYpZsx6okm+N5IiZOOW93OGk8Nv1SIXagkA6DEFK08AphLCXy/iExkR9nSo/O9v/THGExfA1zkgGYbvrrHFQz7GPuSOHuyHJ8tYrj1RCzdIJNsqDSRN4=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BN6PR12MB1906.namprd12.prod.outlook.com (2603:10b6:404:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.25; Thu, 10 Mar
 2022 08:23:08 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:23:07 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop xmgi23 error query/reset support
Thread-Topic: [PATCH] drm/amdgpu: drop xmgi23 error query/reset support
Thread-Index: AQHYNFbfuHDVQXfM+0iirozlXAvjFqy4R2ww
Date: Thu, 10 Mar 2022 08:23:07 +0000
Message-ID: <DM5PR12MB1770026D7CF015D8E69C8944B00B9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220310081417.21705-1-Hawking.Zhang@amd.com>
In-Reply-To: <20220310081417.21705-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80ec6097-bff4-42df-d741-08da026f34f7
x-ms-traffictypediagnostic: BN6PR12MB1906:EE_
x-microsoft-antispam-prvs: <BN6PR12MB190671A42AD9011D9FB51F7BB00B9@BN6PR12MB1906.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6val+5V8EiM5lSG7K457828hbewk9XVJOWzU/T6FWCphpJjDUvdtU4AHZcsu9UHgCmpQ1lTsA5+iziWCgUJh0O5Hd8ReSEcj8ae6BHB0jTisIDwvV+ijwa+R69HkZ09Bd9AgaLNv5Z8oDycI59A5Hyug4X4JG+d8TH5teDgDQFozYjIx2yyZn4e7AmCfdC3miD5utqQ5Mem2geV4xgIEsV1gB3Eimv8HlyZIxx+bfkDvuCCNsQpJIPHI8IeGfYubZn35lLzBICjbo5qXLI8riCxrOm2fBO7+Q5aPfw5LuCLZjenzebGVOdElow+zHl2EgJMrq0XqC7vlzaQLL0G5jIfw+yQ5F4o2BWZMj48GUIbxgKgf0g6KMZ+HdT+xnAf9sP8FvX6QcPK9YzP+KpxMar5UzgM1Cf6HMns3pF9VMirKEQAFsMDt4GAuhjH3fs2MJB52j7Gy/p15gd0k3pjlOef+Ja78NAJXnax3udJoGg0jeqUjGaPh4Pv1nGbGvl15wDu//AWlSOGaQy5iwlV8oYvEeesNFClE9G9WTH05hSy4eNL1o0XiEDDg2WI+OYiiZydOeNBsRsr+lmg0oTvhsevxy8AXMsu35fvliRSz352s9afxyG2i8yPV4WF9MdqVA0xzoySXw5m0hjd4GR152dQv+AnZ4G9e+hLfYjf353wLBHoUU7uZIggj6X9S59yDasns4FasJdJSTSPjpwntw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66446008)(76116006)(38100700002)(66556008)(86362001)(8936002)(66946007)(64756008)(5660300002)(52536014)(71200400001)(316002)(122000001)(38070700005)(2906002)(8676002)(55016003)(110136005)(33656002)(508600001)(53546011)(6506007)(186003)(26005)(7696005)(83380400001)(66476007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pys+7kYkounx11E+sulyQf+1dh5Bcg85J4RCO3PFjg7dhOsOlwYZTFhFeRKU?=
 =?us-ascii?Q?T5gEL4fdnNSZzc7zwQaKZ0odip7RKs48F2y22F8ysF4jE09yNDhhknC1MDjR?=
 =?us-ascii?Q?L+YXLGpA8HWLEBlC/9SPnIoMKqxm/o0vtZ7wy38ShUz6bzmkiI3bSlyV+CAw?=
 =?us-ascii?Q?3CWqWIVb101pnA70rsbcuXH0k+zNfOtuki8FqjQU+QzhBrus97w4ie3GMmYO?=
 =?us-ascii?Q?EzrpROX4ZBSTcHfh3/msxYeoHtCSwymbj9ROnxDxXdeF/9RkwEyQpAAUlOfc?=
 =?us-ascii?Q?Dk+SvvaZKOCuhgNvpHQAVUvJoYUvq89a1o+DcViZX6UgXaTQcAznSAvMcIEs?=
 =?us-ascii?Q?+Y4w68U5s+ArYSykBSe+pFr9itSE82fxq0Jvp9rdkMlL6RuMqXQXXdRl/59x?=
 =?us-ascii?Q?uVGLf86fj0f/PdXBPvtuAAyMW1yypukG2OUrdJi3+zGqvIVPCM2qgJ5O+SkU?=
 =?us-ascii?Q?mg26/dcvZ1WTwRtPq6WOMfIVj+9nc4cHilTssga+TrJavb6W7siHGt5u65Ml?=
 =?us-ascii?Q?g9rXjx5OLppZdsOBCG/iBvfTk/MD4TwC4W+QoEhLp5hHJPqyzzrC0GH1PNjI?=
 =?us-ascii?Q?s5cMe7Ikw4aSjLvxTm32AlU671+vuJzLVFih2zdGugBIjXAyNvuc2Qa4yzun?=
 =?us-ascii?Q?AOBo9SV9/3z0rU/bdZrxIgf+Ss+/jFteXzpfvoVwBQAUsokPtsgTHUlNIFV3?=
 =?us-ascii?Q?63WG3wOEyR5Tx0Z2lBXPYYZ/K+a7qdb6jgwOR6mtheeypBI5x6XqXKtD465g?=
 =?us-ascii?Q?O91y4JMD0ZtIbh3IV3IxYV6zJ73mNkIFmIdR4FHrfC8HqUWsKqB1Azm7/eWZ?=
 =?us-ascii?Q?0w81QOsQ/h32iyb+0dugR56UI8fTYoWbyGSvX9Bd9ifkCL8pf6eOu/jX9Vmx?=
 =?us-ascii?Q?R+ZemYiZQ6JWVXJZ3rbGvJKjAa2S4S4YtrFvS+v4fAxf6R20bgs0pgtBtryf?=
 =?us-ascii?Q?CY9R/Qu6m1Fawcx94yfVjUL4kKmLLmD6AQVpvHTvYr4F+juDrdKWib/5PPyB?=
 =?us-ascii?Q?6Wil8feZd2yXdCXhYZeME369d7HeuougPwt0e2xq1LdFx+ypq270mud2FB3h?=
 =?us-ascii?Q?00mzf9etwj+Xd07BrNp+UYrwn3Wefp+MDZpd+BVa7D2aSdyen93CNL7kjrmP?=
 =?us-ascii?Q?BdmjqLzKV6Wn+lYo3N+FYut0pkaIIfW+BcR0gZ1EZFlndNzNhx+MC6J0Z8WE?=
 =?us-ascii?Q?EEL8p9GNNIxLknFx/BFp5/G10qmnY8N4t6vR0ak2/tt011BNRGPAB3GZNkj6?=
 =?us-ascii?Q?jEBKMU6UfpIDq4x9TYcN7Rx+mpJWNVXxYYnVCxu2WFzTG/llxkFhypiB3/A+?=
 =?us-ascii?Q?yFbAjw8MspU+OLVAR08FA3rtYkmDkRi79YMkZgqbb4bVo35vKbquGATBkvgz?=
 =?us-ascii?Q?+ktJ7qxZTjxz92wkIO3JLT1hTOSAPP2RYEvg1HoQv2UMvnBCm/RQyj0MdNZU?=
 =?us-ascii?Q?XYNw+fs5qygWZAG4Hq5cq7xxwuAaW4VvzMwGCFq8PtT+y74dBRk9N/lIchiP?=
 =?us-ascii?Q?D0xDgzPkAuFl12KDjj0vUHZCqgDjBxKD+Olw9xK+/HC3UmJfaFjVI3DUuMCd?=
 =?us-ascii?Q?1fhJ+kLTmwOFdDwckgc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ec6097-bff4-42df-d741-08da026f34f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:23:07.8535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElReIKEwLaEWxjy2c5aNW8p48J5+9zrjPzHtw8gnvBXx84ayw5Es0n3xgWDNSWpL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Thursday, March 10, 2022 4:14 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: drop xmgi23 error query/reset support
>=20
> xgmi_ras is only initialized when host to GPU interface is PCIE. in such =
case,
> xgmi23 is disabled and protected by security firmware. Host access will r=
esults to
> security violation
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 4a789c789c6c..c6e52be7e8ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -32,7 +32,6 @@
>  #include "wafl/wafl2_4_0_0_smn.h"
>  #include "wafl/wafl2_4_0_0_sh_mask.h"
>=20
> -#define smnPCS_XGMI23_PCS_ERROR_STATUS   0x11a01210
>  #define smnPCS_XGMI3X16_PCS_ERROR_STATUS 0x11a0020c
>  #define smnPCS_GOPX1_PCS_ERROR_STATUS    0x12200210
>=20
> @@ -67,17 +66,6 @@ static const int wafl_pcs_err_status_reg_arct[] =3D {
>  	smnPCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS + 0x100000,  };
>=20
> -static const int xgmi23_pcs_err_status_reg_aldebaran[] =3D {
> -	smnPCS_XGMI23_PCS_ERROR_STATUS,
> -	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x100000,
> -	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x200000,
> -	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x300000,
> -	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x400000,
> -	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x500000,
> -	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x600000,
> -	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x700000
> -};
> -
>  static const int xgmi3x16_pcs_err_status_reg_aldebaran[] =3D {
>  	smnPCS_XGMI3X16_PCS_ERROR_STATUS,
>  	smnPCS_XGMI3X16_PCS_ERROR_STATUS + 0x100000, @@ -778,9
> +766,6 @@ static void amdgpu_xgmi_reset_ras_error_count(struct
> amdgpu_device *adev)
>  					 xgmi_pcs_err_status_reg_vg20[i]);
>  		break;
>  	case CHIP_ALDEBARAN:
> -		for (i =3D 0; i <
> ARRAY_SIZE(xgmi23_pcs_err_status_reg_aldebaran); i++)
> -			pcs_clear_status(adev,
> -
> xgmi23_pcs_err_status_reg_aldebaran[i]);
>  		for (i =3D 0; i <
> ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_aldebaran); i++)
>  			pcs_clear_status(adev,
>=20
> xgmi3x16_pcs_err_status_reg_aldebaran[i]);
> @@ -881,13 +866,6 @@ static void
> amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
>  		}
>  		break;
>  	case CHIP_ALDEBARAN:
> -		/* check xgmi23 pcs error */
> -		for (i =3D 0; i <
> ARRAY_SIZE(xgmi23_pcs_err_status_reg_aldebaran); i++) {
> -			data =3D
> RREG32_PCIE(xgmi23_pcs_err_status_reg_aldebaran[i]);
> -			if (data)
> -				amdgpu_xgmi_query_pcs_error_status(adev,
> -						data, &ue_cnt, &ce_cnt, true);
> -		}
>  		/* check xgmi3x16 pcs error */
>  		for (i =3D 0; i <
> ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_aldebaran); i++) {
>  			data =3D
> RREG32_PCIE(xgmi3x16_pcs_err_status_reg_aldebaran[i]);
> --
> 2.17.1

