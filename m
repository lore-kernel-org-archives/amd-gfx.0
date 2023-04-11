Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00C9C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 04:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984AA10E4A1;
	Tue, 11 Apr 2023 04:48:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B1610E490
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 04:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATtakqNVp3St7AHnmHqGPmhHSTCDl3f3WOw7Inj5dcIYfY5y3Qz3Sj4vqU28cZEEU9X36uJKWnsXeiE3kBJckuoNbmq0Nmkr59ktG1J+4iqHZb/FVvFy+jD4dj8YPSZa4b2papiTKNuQJDoxgL1WlcFGHcAXsufwx+eYJZNWnZA8Z2AhTP3WbALoNFuwCuvAzoFamcMVAaA9lRPDCFfDmgC47MsN8pIHO7wCMf5hys9A/6V0FPoWEtGOtYbNErr84w+yc1EHxgtpbK2c4Ty/QjK7okSR8NJtC1k51Fjn3JaU2iUpFiOBR2QEhfdDHyn2wqbFefDeb2s8qxoKqS29Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulbyPz77suII+wgMrynx3EbEUvP3YkJVVgtH9rhu6xQ=;
 b=a94PsgzS6fOvXh1Jan8ZqMj1Uonyw11CsJ4WQnUTVXeTlspAdGTnJWdT/NPiFTuu1Y7CByZ8/AnoW3r209+NXtFsK4RT5U9ar4vW5PWoPjLidoXATN6Ag3G+hXaTlPl4w78+lT/hsGCVg7bjDdMGusjDp6l46PC3uxx9v2XxiU/w/AkJlpeGoGQeTt2IPYYS6cpMBwecwV8qnNBZpviOJY0P9Bm30Dp8BFHOXtj2QtUHzRatmWcrQYPZ30WmOntWF+bSsYQkj+1Sq3k/nG5CkKGR0LUemdy2QB8FlPLsaNZElaHtLrIoOesqVCU3bbawuWtOaulnr4+qp9+hi0fjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulbyPz77suII+wgMrynx3EbEUvP3YkJVVgtH9rhu6xQ=;
 b=pvv7iZxM0VGVg7E3taMSP42DhyUzP11jKs3Sg+IRffKeDGzdH/5MgTzReqK8ubOaJTbl7cyh+dASSxhV39KYxIzjBmBYfQC+mnzqNsizSiFqlwEMF4R7+HikEh75LlD7muGzt9zMrOtlpr8YCY0/O94iGgAnIoKM0gU14traxiQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 04:48:20 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd8d:b994:aaaa:c8a1]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd8d:b994:aaaa:c8a1%7]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 04:48:20 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
Thread-Topic: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
Thread-Index: AQHZa6Jlsx77RDN7U0ibrn4voQUGFK8liflQ
Date: Tue, 11 Apr 2023 04:48:19 +0000
Message-ID: <DM5PR12MB2469412275D1DA66DD4BC186F19A9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230410114822.750-1-Stanley.Yang@amd.com>
In-Reply-To: <20230410114822.750-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SJ0PR12MB5439:EE_
x-ms-office365-filtering-correlation-id: eb4434f5-da9f-4b63-2e9d-08db3a47f8e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zPxO1Ia07UpanCIaRhTdj2I8s4y3FVgr7m6PxizzCZ0S17HX/yfg2n/Eg3ACdloFJ/GJWCwGsfVvM3nrQ7AdiF+nCrIiuB5DT87z2zGHbQoV+BswbkQNZMcLLlT+cTE3JN90+k64l4Sa+hgSjW/9NfMc/x/+LjWKtrGkLlpHuW4UBCL5tmHCpmXcL8qrUeaMGFNQ073foCbirabwAgPwy7ibRcLKsofz6nGTKTsMjYFbcWHyHw6gylzKjPofEzgVvF4ZwmRZyo7pTz3onJ3OxKaz/ICllvPkV5LYtW/6a00d+T19ypz44JL8I4tY8iyMAZ2bB178GzhSpxVSjA4RhC+qoi3o1Vnuge34V2gMrUgfyXdCsAafz5i2DP2mVjWf01IiyosZTdtmOVv4L8HfjyTC7XmqM0nfFlN5gNxKoR5ag0CXSmNYOiURB3O2glLn1GA9EWPaTkrLBPw52MYj/9kdQKYhd3xco3F3rVLZULYjewLmawfZ6bmzlQDj0wZghU4e8awRJkZmXjpgGwuahmmeL6wT6KhGQDnqpeI6GokFwTmoE5/xbtv8Cg46Qp6HMXE0RFdOb1WyChv1HX9o0sLJQ/Q+VGoBDVOrKKIQ4jv9L3r8IFsQtIuQt0tCshg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(8676002)(86362001)(33656002)(83380400001)(6636002)(6506007)(316002)(478600001)(26005)(7696005)(186003)(71200400001)(9686003)(53546011)(110136005)(2906002)(5660300002)(52536014)(122000001)(38100700002)(64756008)(66946007)(41300700001)(76116006)(66556008)(55016003)(66446008)(66476007)(8936002)(38070700005)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bboEeVNw5apLqGX6JNxouzVSfDBZ81QtRP+gc8sAS3Yw76N+2EWag3yqOtK/?=
 =?us-ascii?Q?MvXGvESSGq3nIy1rwbcVfEZg9o/PY9VD6yAFo2kwcojdtPzSehOpe2pwi7RL?=
 =?us-ascii?Q?IG1WHxkBT+pRxKXHGfSYpGBK13caC7qhxD5SrkkxMJj1TeqpqCgKn/tlrsL6?=
 =?us-ascii?Q?Kh35c4ksL8Z9RSbmQbwgnZJ+x+DfMXzWUQ7C9TVC6bEfkWSMiEy6Zs+g5+dk?=
 =?us-ascii?Q?pY3l6pr5YZHjNkCsdfkQPvhb6ZnuzpQLUWRYsItH0WnF1I4PNB8I4OfJoi1D?=
 =?us-ascii?Q?l7GxclfWzmG5E828p67wndXH1sIgBbrjZptLd2OkWfjUekzsXcfjlE+4LQZc?=
 =?us-ascii?Q?P0hTqYPR5wilV69UYoUc2Y9xoR4eTEaNvII9mlDLaA7RuNhxL2lcVOxahjIi?=
 =?us-ascii?Q?NpCvHFHpic9TZuTvr4ddjW1zY+mawCzUiG0uRYpV/fQG8faeMEPBOHRIGF7A?=
 =?us-ascii?Q?5nveayo05/8l/3ySameOO6k3CvlrKVRYaao7o2r+gXtIxGqnSCDd0YwtZpxq?=
 =?us-ascii?Q?xrHMrVEXNq1kkzEZjCwNBmVfAk5S6kfUpbs0nfzF4271oAA0I1WFAlvAdH4Z?=
 =?us-ascii?Q?sVkq/fwtW9FWDKGfp6M7yxHIDoaimaX+UEGIvczFMDmgdOciJF4m++7Ti8sc?=
 =?us-ascii?Q?NK1gL9rloZ9Y/bcWx4VHtNn1GHhtKZLlOLwbleeTiASioI6Xrok1/hBOKZgg?=
 =?us-ascii?Q?Ht/WtZ4cDumcpzNzk6bUQYbtGItFkssHs2QZVQEX8XoR+zvTihOByKSWa0pZ?=
 =?us-ascii?Q?cAPFGGZ0Z2QpIHwzE9Kxp/gDS0lo+vWBVf8JQlfsM2H7QhGUDsYgP+yV6s1n?=
 =?us-ascii?Q?gxTwM70sCyRHPe8/FhuYiL8nWMgskgFrTd2prqDDq53HaPKqur/OWLKCtcbu?=
 =?us-ascii?Q?cZqHizxCUu3hl+6SLyMHm9/mc7qYf6X0Tcub3vRWyLZBkF/zLLM0WSHA5kE/?=
 =?us-ascii?Q?dTJwG593yQYTEJltMj+IXEbBHvYfQYD4m2hiE58iQUrva7pfJq6epvPqMxeb?=
 =?us-ascii?Q?gOVthicSqpqNdMYHqkEsJcB80SaUJFm5ZwpSKv1KQvQAiR7cCK/V84qzQjxB?=
 =?us-ascii?Q?QXHXDUb/Ryj5lH2P9TRjxnSRbDxTrJ4Sfarm9zrLjrPYjiPWpMYmqyXnv7Pf?=
 =?us-ascii?Q?B8PmG1hRtpjMjxWgDLu8yQpVN+0aBXCl+Ua6FZMCCwlVK1ccpkGt18Ypgzln?=
 =?us-ascii?Q?QGmgxFGuJKGV/GOVBM5KNu8DTq/nDtMc7XlNc2slQNEvN6g6k4J89INpD8ar?=
 =?us-ascii?Q?sn+9t9WzbgFG+NwLcn4pB06tUFydhMi8pxxP9R0UBdwuhcQz7jUXPh7O/k+r?=
 =?us-ascii?Q?0DYNQUxCSCi1oKRLL+IaAFigo6BJdBNSgm1bY/I4KgHjaOeqZYU+DM+xIXuT?=
 =?us-ascii?Q?8O5FrBUHcqG//CTvt9u4WXmTvA140tnJfr0JklwutI4DneR74zZ+K8pMojfv?=
 =?us-ascii?Q?45rkAd3IpHVEgBP2cKW6Ys5gTo7SOVsuvs8QufqTa7E1lJ0cNzZoRFpgQtZf?=
 =?us-ascii?Q?vt+4PlHyF7TF7bW5YzxlxKGpaQTJ5DsMtIZSLm/TLvH6uIKFEWM9cVYMET1R?=
 =?us-ascii?Q?FnVLdiTEZikBTujRNI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4434f5-da9f-4b63-2e9d-08db3a47f8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 04:48:19.6065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFeC/bUT9A7XIFVUEglTbPg+5LjlNKeR6VCminggpUurcSOr0x7WfqWxi6Mauaq/5eiZo+fva/WHSWClYJ6Qjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A spelling typo in subject, s/admgpu/amdgpu :)

Also maybe it's necessary to add a body text in commit message.

Regards,
Guchun

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Monday, April 10, 2023 7:48 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
>=20
> Change-Id: Icceb43556eec802f11c2077c1c58a1e92c9df599
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++
> drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 2 ++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index ef38f4c93df0..17b3d1992e80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -583,6 +583,10 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block
> block) {
>  		return TA_RAS_BLOCK__FUSE;
>  	case AMDGPU_RAS_BLOCK__MCA:
>  		return TA_RAS_BLOCK__MCA;
> +	case AMDGPU_RAS_BLOCK__VCN:
> +		return TA_RAS_BLOCK__VCN;
> +	case AMDGPU_RAS_BLOCK__JPEG:
> +		return TA_RAS_BLOCK__JPEG;
>  	default:
>  		WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n",
> block);
>  		return TA_RAS_BLOCK__UMC;
> diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> index 509d8a1945eb..30d0482ac466 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> @@ -84,6 +84,8 @@ enum ta_ras_block {
>  	TA_RAS_BLOCK__MP1,
>  	TA_RAS_BLOCK__FUSE,
>  	TA_RAS_BLOCK__MCA,
> +	TA_RAS_BLOCK__VCN,
> +	TA_RAS_BLOCK__JPEG,
>  	TA_NUM_BLOCK_MAX
>  };
>=20
> --
> 2.17.1

