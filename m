Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E24C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E2D7A304;
	Mon,  6 Dec 2021 10:21:06 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5816E9BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 07:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crulYNEcZlaKBVoZ7kCNi4ro/NJtsIi5vuqk3dXoLCzgIuPoS3oZBQlUJWfjjrx/pJy1L1+PysM9XTRs3VciWAmuQXMdcDweP0BnX+JRqJaR/wqZqTgyF2CYv6JdcvmwPiOrZWcaorRPz5Z9M+XaYbpKqYPafaSJs1OHECZoCwoIdJoPKp9U4aClHcfgvuRJHwe5DzMLSXJzacz+fhohbKfF4H9acCudLVOuCp6x6CJ425AWy+GzCchP0RIlh+B5pb3qc+6mMsA08JLbP1t14ad3MdTEZW98VxMO7UfokwoquA84iBzYeCIZN796s2LfQEDV4aZ/JQBwakquU2mieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKXV0EC+DQkERh+pzWjjBO/ZM+PZ7zN4ZSpJQlj9sqk=;
 b=EsHh08zhyc+70PWmVCLdq7YMRNmmWQ9z+8QpscEwVyN4Qi83tuCWCx9gJHMoDFgTEIODJfRMY0XXJgYPr32FE77ySmJCjMMJfzICe2U1HFWUKbtBwjSYI+ypSuteUL99Gw476EA5N+EI0qA0e+GlGYpXiXB2umsdx9Is4mhJoA08lbweBfSGoP980Ef/MDcRKfGUpHKdyR9ixZ7ruCUl67VpYHzESfftQRb5brq1deCRLilqFhB8YFD+9NcGz+axUiXTFo4tZAKp0Wkf8MWcmsw2d2hNMjX+MW+Szcj5FzVv4rPQ0qS81l1t3mv6Q2hAkmPwcYJJRAz82TqgMnPQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKXV0EC+DQkERh+pzWjjBO/ZM+PZ7zN4ZSpJQlj9sqk=;
 b=dRcUtGUGp9flnjbF8plhLGnuw7VeJQbEJxHoKIzFOi0syCoAFQ+ZxsAHTABKHXPXzsUWNd+aA9WIGLNxviKLmEESig54p3UAlSZ+GKUc+wh0Q3dF3DZ/SSQa4WCY/wa0AU+Iog/58Y5vhuhoA6Vz8V9IfEvfGqre+Y8zElJRBDY=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR12MB1289.namprd12.prod.outlook.com (2603:10b6:3:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Mon, 6 Dec
 2021 07:33:44 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 07:33:44 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 11/11] drm/amdgpu: Move error inject function from
 amdgpu_ras.c to each block
Thread-Topic: [PATCH V2 11/11] drm/amdgpu: Move error inject function from
 amdgpu_ras.c to each block
Thread-Index: AQHX5qG+NRuL41MVqU2q0Ry34xSfRawlGKAA
Date: Mon, 6 Dec 2021 07:33:44 +0000
Message-ID: <DM6PR12MB46506836B1671033C5EFD568B06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
 <20211201105250.298525-11-YiPeng.Chai@amd.com>
In-Reply-To: <20211201105250.298525-11-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T07:29:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=89efef42-429b-4683-a9de-f148ff71dfbc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-06T07:33:41Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 83947b4d-ee27-4694-b145-f7af6ed49247
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc37bb58-282b-455a-5810-08d9b88abbbf
x-ms-traffictypediagnostic: DM5PR12MB1289:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1289635E2CD1DE429E25115BB06D9@DM5PR12MB1289.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:110;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8I/T4rSvRMv8djZS0XCe7vX2+gwbA4jCwt/RAJRFu9S93npsDcHL6OlmODl/j/RahuaFeBhHjq2NMLAtxwjt+dKGdwWkY7ieNoAe2y/mH9R8JK7KrUdpZV+rN2PhKLd0rjsDyA1cbXM38W1hlYQLJx++ERACjTOklPG+T3heeeXjT2EJ/Oa88ruwF82ttAWHGP6sgfojkVNiiBkczFpbo5kqig/tf/TD7PHUBcgr4jcJi/ORIIN7NvoweKSh/0qMcYMNHGc6MCPyH9Pw6aNrNZ8AbJ+Jzzud6jKH9+a8Ra+jrQsSpDszFsTtHZ7Rxnom5/2VCYUMlfVSBFV4I6/YVZpE87xNSSRzfMeh+eixVanFfzagaIP2meGFfiJHA3bflHMvWZ/ETwWc1NNs2dcabvr7tbz+zBF6K5z0TczGA0q3CXyWCoZLsX1vH63oI7hXcdrSgPr0eY/2UQ5R6lRpXz5R60K/tnm8mGKcmvg5plK5zWRZOWZjfeC+U3szkMUYxsvI0Vd8xt6TxzLCKsOkRR7pqZpDInkJ8NnGWEERBOdMsH+/l80yXEsIWCpY0yXu4t0/icWqdw2tZJu4YxPL3NyM4ubg7cSK8LfPTmbWaWY9AEi5/GezBYuYvpre720jxTFP56/666d55gQvmNIg4+DBnEsf4Oozg1GoF/NATsybrRZKtrMpQFbhuTiY3rbzGPY8Y2EYCJ71bPDraOfh0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(66556008)(26005)(9686003)(66476007)(64756008)(83380400001)(55016003)(52536014)(316002)(8676002)(8936002)(76116006)(66946007)(66446008)(4326008)(86362001)(186003)(71200400001)(30864003)(6506007)(53546011)(122000001)(2906002)(508600001)(7696005)(38100700002)(5660300002)(33656002)(38070700005)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NsCnA2DKFomfhTd5tD8+Nn1bb8AzFOuP1eVuO/xPlOU7Jf6OvCtQiH5kY8CK?=
 =?us-ascii?Q?5NtS/UwEagWjwzJwS76ZNHxA0WVqKHULzeZhmdmmczB+NidVm5OlzrChrLPp?=
 =?us-ascii?Q?bibPtuKE7NTiWXh3J4+Bd2/X03AtZfAp5LXpQv/NdE72/Nmdk0eQ4IOffjUd?=
 =?us-ascii?Q?40dM3O/UCbFYqi2P0fXOAALKeHO0I4nWqSQLg+ELhA6Zpek8BThPrZbbIBQZ?=
 =?us-ascii?Q?HHEVUS46QacIEwYnY+zfSoy/11tsFT99LlzkmICqxfXYUe3uK1Hmr4UiD21r?=
 =?us-ascii?Q?Yw/Zti/+6i4+lE9v/h+XZulvyLHq48wko0JKKn/DL7GsBkWSdY9+KWe+hZ8z?=
 =?us-ascii?Q?9VNwBn6CnhCbBmwFZroofDDAswCVpx9caWjCutumuzLHHruLMDE4CefJJRv2?=
 =?us-ascii?Q?ZH14um6BDaZKTDUfdLZ9ucIGqToQPtCsxSiSXT6gJ4XqxMyviV1AA0c1EHir?=
 =?us-ascii?Q?3ZAYNClgaeXGdaex3bfYoZircvLdwxpoU6MShfed5V8L0CSKwtgN3VyM2j4t?=
 =?us-ascii?Q?otMBcqUVoeeX3w+VcsUYPCrO0pZK6jdT92Q4Xr6DcQwN3U8GdNKFW2LHBKMK?=
 =?us-ascii?Q?T/QLPoHkOLXPRLho4HoRaNIRgLMdPDjAD9o2H3MYBYcF9SJSIX7fbwd1MHRa?=
 =?us-ascii?Q?qQAOyCvinW0p3iamsz6dke0MLvy+HvHWnbTIUjfMW2MT/Aq2mh4rLjdiQAst?=
 =?us-ascii?Q?jqVULwk5x1yVmlmGeYhEL2zH8UDeLNI5tQMdlowZIKo7DExDrIskMJ8c8rdK?=
 =?us-ascii?Q?3gldhw94R9He7svVxdRqWABjKITq6quTeGQDH0LWL7ffEO4PCkh+7ZmXfk6b?=
 =?us-ascii?Q?Ch6WfKViwjYv4/TEbKtYGLL2zIIF+TH4q8nR6uEtYMBF5Kft0GhlFR6XFqET?=
 =?us-ascii?Q?9VdFdnEFpJpmzN8uAN4eZvWlWdRpKrQrvTLrPFsXt8uBPXzfOQfCJFnAs1+z?=
 =?us-ascii?Q?QsnOx9Ej9tMWN0ZpRwSc49uoHlb8yc0bnSQcgJQCN1NIwliCHuGJPBCD/TuK?=
 =?us-ascii?Q?jwDM0kASWFpYIDkDQTpZFiHwqNyAcBadocP+qTVPuty0isHkkJ8XfBw0m9fd?=
 =?us-ascii?Q?Li6tLKOmqFFTJX4k10iTQaZ3cFpBhnaTdAR7Mz9/87dn43wv04BhnUta6+e+?=
 =?us-ascii?Q?QCOplwqoKz6Rk3ZXMDmI4IPBZkP9ItK0/vDzY1ldIwGg4rzOKpwQAYXvTXGk?=
 =?us-ascii?Q?h+zUMmr9vltYVxs0g0Br7GISeBT0OYXpOxA5368cYObePIkEkeH3ic7SmbfL?=
 =?us-ascii?Q?mF/4Y3kCggK6qWWwSXZCJqoV0fS1sln0+QQv0dC3UtbvPKMNdyUPqKFavOfM?=
 =?us-ascii?Q?RixbojU+3vDxkN+SBx43GxW88AxUaIK7We9pZDBQWLh0UJB2dybnyYhVlz1g?=
 =?us-ascii?Q?tMc1AAKm0nt+zUbeeULCxC67Fon2R2smAaJLciNFriiMnrxxG9u9hQJv+o7U?=
 =?us-ascii?Q?3Gnw0c1ioGSv9/yO6VdaBIUTCUdnLkafcMjsfqdki8ZeulWsAp8M8sSpErkN?=
 =?us-ascii?Q?DVPXqPUUMLkb7zFXhwV9aHJOdKcOW+OPpf7/COsAhfu2SZLXCTOCXJN1vQma?=
 =?us-ascii?Q?DzYSfHCqRE8hE1u6flw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc37bb58-282b-455a-5810-08d9b88abbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 07:33:44.3113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YB24XtddZWX15cSWHPiKAmVqPxoRQX75PmMcgeT1tWfPYnbbB67kdfg1vL5d+aeU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1289
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

[AMD Official Use Only]

The error injection has no difference among RAS blocks except GFX and XGMI.
I agree to move the xgmi error injection to amdgpu_xgmi.c, but I don't thin=
k it's necessary to implement specific error injection functions for all ot=
her RAS blocks.

Regards,
Tao

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, December 1, 2021 6:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 11/11] drm/amdgpu: Move error inject function from
> amdgpu_ras.c to each block
>=20
> Move each block error inject function from amdgpu_ras.c to each block.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 62 +++++-------------------
> drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 18 +++++++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 16 ++++++
> drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 16 ++++++
> drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c   | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/umc_v6_1.c    | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c    | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/umc_v8_7.c    | 16 ++++++
>  12 files changed, 201 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2e38bd3d3d45..87b625d305c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1032,31 +1032,7 @@ int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> -/* Trigger XGMI/WAFL error */
> -static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
> -				 struct ta_ras_trigger_error_input *block_info)
> -{
> -	int ret;
> -
> -	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> -		dev_warn(adev->dev, "Failed to disallow df cstate");
>=20
> -	if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
> -		dev_warn(adev->dev, "Failed to disallow XGMI power down");
> -
> -	ret =3D psp_ras_trigger_error(&adev->psp, block_info);
> -
> -	if (amdgpu_ras_intr_triggered())
> -		return ret;
> -
> -	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
> -		dev_warn(adev->dev, "Failed to allow XGMI power down");
> -
> -	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
> -		dev_warn(adev->dev, "Failed to allow df cstate");
> -
> -	return ret;
> -}
>=20
>  /* wrapper of psp_ras_trigger_error */
>  int amdgpu_ras_error_inject(struct amdgpu_device *adev, @@ -1076,41
> +1052,25 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
>  	if (!obj)
>  		return -EINVAL;
>=20
> +	if (!block_obj || !block_obj->ops)	{
> +		dev_info(adev->dev, "%s don't config ras function \n",
> get_ras_block_str(&info->head));
> +		return -EINVAL;
> +	}
> +
>  	/* Calculate XGMI relative offset */
>  	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> -		block_info.address =3D
> -			amdgpu_xgmi_get_relative_phy_addr(adev,
> -							  block_info.address);
> +		block_info.address =3D
> amdgpu_xgmi_get_relative_phy_addr(adev,
> +block_info.address);
>  	}
>=20
> -	switch (info->head.block) {
> -	case AMDGPU_RAS_BLOCK__GFX:
> -		if (!block_obj || !block_obj->ops)	{
> -			dev_info(adev->dev, "%s don't config ras function \n",
> get_ras_block_str(&info->head));
> -			return -EINVAL;
> -		}
> -		if (block_obj->ops->ras_error_inject)
> +	if (block_obj->ops->ras_error_inject) {
> +		if(info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX)
>  			ret =3D block_obj->ops->ras_error_inject(adev, info);
> -		break;
> -	case AMDGPU_RAS_BLOCK__UMC:
> -	case AMDGPU_RAS_BLOCK__SDMA:
> -	case AMDGPU_RAS_BLOCK__MMHUB:
> -	case AMDGPU_RAS_BLOCK__PCIE_BIF:
> -	case AMDGPU_RAS_BLOCK__MCA:
> -		ret =3D psp_ras_trigger_error(&adev->psp, &block_info);
> -		break;
> -	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
> -		ret =3D amdgpu_ras_error_inject_xgmi(adev, &block_info);
> -		break;
> -	default:
> -		dev_info(adev->dev, "%s error injection is not supported yet\n",
> -			 get_ras_block_str(&info->head));
> -		ret =3D -EINVAL;
> +		else
> +			ret =3D block_obj->ops->ras_error_inject(adev,
> &block_info);
>  	}
>=20
>  	if (ret)
> -		dev_err(adev->dev, "ras inject %s failed %d\n",
> -			get_ras_block_str(&info->head), ret);
> +		dev_err(adev->dev, "ras inject %s failed %d\n",
> +get_ras_block_str(&info->head), ret);
>=20
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index da541c7b1ec2..298742afba99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -940,6 +940,33 @@ static void
> amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
>  	err_data->ce_count +=3D ce_cnt;
>  }
>=20
> +/* Trigger XGMI/WAFL error */
> +static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
> +                                void *inject_if) {
> +       int ret =3D 0;;
> +       struct ta_ras_trigger_error_input *block_info =3D  (struct
> +ta_ras_trigger_error_input *)inject_if;
> +
> +       if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> +               dev_warn(adev->dev, "Failed to disallow df cstate");
> +
> +       if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
> +               dev_warn(adev->dev, "Failed to disallow XGMI power
> + down");
> +
> +       ret =3D psp_ras_trigger_error(&adev->psp, block_info);
> +
> +       if (amdgpu_ras_intr_triggered())
> +               return ret;
> +
> +       if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
> +               dev_warn(adev->dev, "Failed to allow XGMI power down");
> +
> +       if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
> +               dev_warn(adev->dev, "Failed to allow df cstate");
> +
> +       return ret;
> +}
> +
>  static int amdgpu_xgmi_ras_block_match(struct amdgpu_ras_block_object*
> block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)  {
>  	if(!block_obj)
> @@ -958,6 +985,7 @@ struct amdgpu_ras_block_ops  xgmi_ras_ops =3D {
>  	.ras_fini =3D amdgpu_xgmi_ras_fini,
>  	.query_ras_error_count =3D amdgpu_xgmi_query_ras_error_count,
>  	.reset_ras_error_count =3D amdgpu_xgmi_reset_ras_error_count,
> +	.ras_error_inject =3D amdgpu_ras_error_inject_xgmi,
>  };
>=20
>  struct amdgpu_xgmi_ras xgmi_ras =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index 99edc75ed4ec..ce6841967b05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -60,12 +60,28 @@ static int mca_v3_0_ras_block_match(struct
> amdgpu_ras_block_object* block_obj, e
>  	return -EINVAL;
>  }
>=20
> +static int mca_v3_0_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops mca_v3_0_mp0_ops =3D {
>  	.ras_block_match =3D mca_v3_0_ras_block_match,
>  	.ras_late_init =3D mca_v3_0_mp0_ras_late_init,
>  	.ras_fini =3D mca_v3_0_mp0_ras_fini,
>  	.query_ras_error_count =3D mca_v3_0_mp0_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
> +	.ras_error_inject =3D mca_v3_0_ras_error_inject,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mp0_ras =3D { @@ -101,6 +117,7 @@
> const struct amdgpu_ras_block_ops mca_v3_0_mp1_ops =3D {
>  	.ras_fini =3D mca_v3_0_mp1_ras_fini,
>  	.query_ras_error_count =3D mca_v3_0_mp1_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
> +	.ras_error_inject =3D mca_v3_0_ras_error_inject,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mp1_ras =3D { @@ -136,6 +153,7 @@
> const struct amdgpu_ras_block_ops mca_v3_0_mpio_ops =3D {
>  	.ras_fini =3D mca_v3_0_mpio_ras_fini,
>  	.query_ras_error_count =3D mca_v3_0_mpio_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
> +	.ras_error_inject =3D mca_v3_0_ras_error_inject,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mpio_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index da505314802a..7cca86c504e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -786,12 +786,28 @@ static int mmhub_v1_0_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int mmhub_v1_0_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  struct amdgpu_ras_block_ops mmhub_v1_0_ras_ops =3D {
>  	.ras_block_match =3D mmhub_v1_0_ras_block_match,
>  	.ras_late_init =3D amdgpu_mmhub_ras_late_init,
>  	.ras_fini =3D amdgpu_mmhub_ras_fini,
>  	.query_ras_error_count =3D mmhub_v1_0_query_ras_error_count,
>  	.reset_ras_error_count =3D mmhub_v1_0_reset_ras_error_count,
> +	.ras_error_inject =3D mmhub_v1_0_ras_error_inject,
>  };
>=20
>  struct amdgpu_mmhub_ras mmhub_v1_0_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index 829d14ee87d3..79a9995caef1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -1333,6 +1333,21 @@ static int mmhub_v1_7_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int mmhub_v1_7_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  struct amdgpu_ras_block_ops mmhub_v1_7_ras_ops =3D {
>  	.ras_block_match =3D mmhub_v1_7_ras_block_match,
>  	.ras_late_init =3D amdgpu_mmhub_ras_late_init, @@ -1341,6 +1356,7
> @@ struct amdgpu_ras_block_ops mmhub_v1_7_ras_ops =3D {
>  	.reset_ras_error_count =3D mmhub_v1_7_reset_ras_error_count,
>  	.query_ras_error_status =3D mmhub_v1_7_query_ras_error_status,
>  	.reset_ras_error_status =3D mmhub_v1_7_reset_ras_error_status,
> +	.ras_error_inject =3D mmhub_v1_7_ras_error_inject,
>  };
>=20
>  struct amdgpu_mmhub_ras mmhub_v1_7_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 1edc98e5bcbb..eaed556b9551 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -1667,6 +1667,21 @@ static int mmhub_v9_4_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int mmhub_v9_4_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops mmhub_v9_4_ras_ops =3D {
>  	.ras_block_match =3D mmhub_v9_4_ras_block_match,
>  	.ras_late_init =3D amdgpu_mmhub_ras_late_init, @@ -1674,6 +1689,7
> @@ const struct amdgpu_ras_block_ops mmhub_v9_4_ras_ops =3D {
>  	.query_ras_error_count =3D mmhub_v9_4_query_ras_error_count,
>  	.reset_ras_error_count =3D mmhub_v9_4_reset_ras_error_count,
>  	.query_ras_error_status =3D mmhub_v9_4_query_ras_error_status,
> +	.ras_error_inject =3D mmhub_v9_4_ras_error_inject,
>  };
>=20
>  struct amdgpu_mmhub_ras mmhub_v9_4_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 14f7265d954e..8e62e2ffabe5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -650,11 +650,27 @@ static int nbio_v7_4_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int nbio_v7_4_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops nbio_v7_4_ras_ops =3D {
>  	.ras_block_match =3D nbio_v7_4_ras_block_match,
>  	.query_ras_error_count =3D nbio_v7_4_query_ras_error_count,
>  	.ras_late_init =3D amdgpu_nbio_ras_late_init,
>  	.ras_fini =3D amdgpu_nbio_ras_fini,
> +	.ras_error_inject =3D nbio_v7_4_ras_error_inject,
>  };
>=20
>  struct amdgpu_nbio_ras nbio_v7_4_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 30a651613776..578ee40cc0d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2803,11 +2803,27 @@ static int sdma_v4_0_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int sdma_v4_0_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops sdma_v4_0_ras_ops =3D {
>  	.ras_block_match =3D sdma_v4_0_ras_block_match,
>  	.ras_fini =3D amdgpu_sdma_ras_fini,
>  	.query_ras_error_count =3D sdma_v4_0_query_ras_error_count,
>  	.reset_ras_error_count =3D sdma_v4_0_reset_ras_error_count,
> +	.ras_error_inject =3D sdma_v4_0_ras_error_inject,
>  };
>=20
>  static struct amdgpu_sdma_ras sdma_v4_0_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
> index 8c165bcb0ffa..0656c6a7a2c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
> @@ -270,11 +270,27 @@ static int sdma_v4_4_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int sdma_v4_4_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops sdma_v4_4_ras_ops =3D {
>  	.ras_block_match =3D sdma_v4_4_ras_block_match,
>  	.ras_fini =3D amdgpu_sdma_ras_fini,
>  	.query_ras_error_count =3D sdma_v4_4_query_ras_error_count,
>  	.reset_ras_error_count =3D sdma_v4_4_reset_ras_error_count,
> +	.ras_error_inject =3D sdma_v4_4_ras_error_inject,
>  };
>=20
>  struct amdgpu_sdma_ras sdma_v4_4_ras =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> index ed480c2081a6..2058439b02cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> @@ -477,12 +477,28 @@ static int umc_v6_1_ras_block_match(struct
> amdgpu_ras_block_object* block_obj, e
>  	return -EINVAL;
>  }
>=20
> +static int umc_v6_1_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops umc_v6_1_ras_ops =3D {
>  	.ras_block_match =3D umc_v6_1_ras_block_match,
>  	.ras_late_init =3D amdgpu_umc_ras_late_init,
>  	.ras_fini =3D amdgpu_umc_ras_fini,
>  	.query_ras_error_count =3D umc_v6_1_query_ras_error_count,
>  	.query_ras_error_address =3D umc_v6_1_query_ras_error_address,
> +	.ras_error_inject =3D umc_v6_1_ras_error_inject,
>  };
>=20
>  struct amdgpu_umc_ras umc_v6_1_ras =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index e26728dbc6e9..2e87e7de4a55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -333,6 +333,21 @@ static int umc_v6_7_ras_block_match(struct
> amdgpu_ras_block_object* block_obj, e
>  	return -EINVAL;
>  }
>=20
> +static int umc_v6_7_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops umc_v6_7_ras_pos =3D {
>  	.ras_block_match =3D umc_v6_7_ras_block_match,
>  	.ras_late_init =3D amdgpu_umc_ras_late_init, @@ -340,6 +355,7 @@
> const struct amdgpu_ras_block_ops umc_v6_7_ras_pos =3D {
>  	.query_ras_error_count =3D umc_v6_7_query_ras_error_count,
>  	.query_ras_error_address =3D umc_v6_7_query_ras_error_address,
>  	.query_ras_poison_mode =3D umc_v6_7_query_ras_poison_mode,
> +	.ras_error_inject =3D umc_v6_7_ras_error_inject,
>  };
>=20
>  struct amdgpu_umc_ras umc_v6_7_ras =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> index 037791e90c24..f7fb653434b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> @@ -336,12 +336,28 @@ static int umc_v8_7_ras_block_match(struct
> amdgpu_ras_block_object* block_obj, e
>  	return -EINVAL;
>  }
>=20
> +static int umc_v8_7_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops umc_v8_7_ras_ops =3D {
>  	.ras_block_match =3D umc_v8_7_ras_block_match,
>  	.ras_late_init =3D amdgpu_umc_ras_late_init,
>  	.ras_fini =3D amdgpu_umc_ras_fini,
>  	.query_ras_error_count =3D umc_v8_7_query_ras_error_count,
>  	.query_ras_error_address =3D umc_v8_7_query_ras_error_address,
> +	.ras_error_inject =3D umc_v8_7_ras_error_inject,
>  };
>=20
>  struct amdgpu_umc_ras umc_v8_7_ras =3D {
> --
> 2.25.1
