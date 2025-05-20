Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C29EC3ABDD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 07:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165DC10E147;
	Tue, 20 May 2025 07:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uvk6jUQH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A571B10E0FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 07:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTqpToGuXeWxgiTmRZLZ2d5iQ8rZ7Sed/gB1vkD78muvdLBdvRTZ4Tt6gbLMSo3/9LYnz3aCb6XYqqUZlq/f9TuMJhD71bA58e2gP3VO2fjgiF5DaQDm1Ccv7HofaCdlgMvYGDd8jLYiW78wtUk859ibBuio0SUAn77oQsgp8iDBQS3rAStx03K3uLLcflqor8TjCWB6+zI4nghVJpwLR80wO8C6eVzf5bqDh/5U3JFPD9fR8NVMBneDTWUsigSMRY5Kn55W+3t5TPEnyhw+S56TOCbObUuXHuA8KCfKk+Xn12qSKujG7hVOd7/RNYmBzLuqkjMHUU1wroZwkGvwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR95szXDT54CwWzfDt9x4xPXzRjY4EDmc6/0CBRPl2I=;
 b=SI03r+KgFES+Xb53S45Bzpxs+aZBQgle265bCaqvTWdavwwGt4aRylMXZlU1U3tgKpQ9TXBU4qM3QvR2Ea6j9INJ9T1RlRPbK7PfbFAG1/qMpAoi1v6QDsXZ3EFsMT3kL5bO8RTBzEQdgmKkr3l7ZTy1a0j1I8hdx0E8N5N/OhdT4CtngR5Q2wHrNRpMIFohwjXvsiTZvaHpMFWQxJaxLHFQIzOirBqWkl9Syw6xKI5dH2aD7T9tnFHcZozDnLlR6Sq/lOCB9AHXSja4uQn6SU0eR50Gzc8fPcSaEDBTn2FPv9JTV1aO4aS0rEpTPPA3enEGUOdDlDxOn/Zj8TYemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR95szXDT54CwWzfDt9x4xPXzRjY4EDmc6/0CBRPl2I=;
 b=Uvk6jUQHyDkRGJMZ7pzVvSnwYttUIpyzPnXCVy+1d6UhRL1aoceG7ye/xgJmeQGXY/QZqJTAz5YAN9DcnlYjSNF0ui8zovEnqX6wqy1mfccqwfuoYWxauj99CwSuipoR+fj7u85pau/1MnESEQ2ujRRRtfkoEyGk+xnz4iLXTTs=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 20 May
 2025 07:04:48 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:04:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH v2 5/5] drm/amdgpu: update ras support check
Thread-Topic: [PATCH v2 5/5] drm/amdgpu: update ras support check
Thread-Index: AQHbyT+QlB8+3rx4YECpcLlJoZqjWrPbGGBQ
Date: Tue, 20 May 2025 07:04:48 +0000
Message-ID: <PH7PR12MB87966CC37477B848D8513D5EB09FA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250520042730.1606737-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20250520042730.1606737-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=875937fa-aced-406d-b6db-1ed9513d2223;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-20T07:04:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BL1PR12MB5755:EE_
x-ms-office365-filtering-correlation-id: e600ba01-cb7e-4c54-32c4-08dd976c9be9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ufbUl8YO5JZA0WTMXoBYl2L3kMWZy2pGXV3RkMMYTNOxeBdvaXOYfIugGnqL?=
 =?us-ascii?Q?oYwM9mq89rcyOmHcKC+nggJCQX6WnLFGc3/iwIeDPbtjv4SxnGZwO3CyjkyR?=
 =?us-ascii?Q?s14uZtp9tO1Wl6/9oQB3xMXIJadVXPGop3CH3Ce7D5J6f1ivDaYnzXSzUoO8?=
 =?us-ascii?Q?ZaKO+0agkFv39oGsQk8wGTJhb6lXXxvS5eSxw/Pt7wpBIguJb3BuGkuqNrRv?=
 =?us-ascii?Q?m4OmhkK2uLCiJTskNXBUt6AshfvxZgGXQKxdP1piAG5MfhwVns/EkvUwYcAI?=
 =?us-ascii?Q?mhcy3lypFkJX191sj5JTlgCwM44J2CTUHPwfkFATBABzVoXLA8OMqSk883JQ?=
 =?us-ascii?Q?9LnADcK/xmCiIEnVdcnh2JHW36imhiabd8vIM0o3KQ/KQ54p+hkP21fkcIn9?=
 =?us-ascii?Q?ngyfbXuI6rCz3mvusX3kuWAAfLkUSHs+SEL/0/B0pz/hPJuprgv1+Ls0zF+A?=
 =?us-ascii?Q?g7C6nO6s3oGy7JbxrO8ezjzaO4HYmVyN6IdByTQyEKxkAHdH0HnYlMmWRY2j?=
 =?us-ascii?Q?/Z98Ob9b9i7RZHbiWvrlEb3EiI06fqp6WLKKnYy1GVjbyuX29yAVMvUvSn6b?=
 =?us-ascii?Q?LWb4QfuxpH8wMeK77YKKwTY0s5s7pVOE5/Q8z11dTSn+dhGtKHkRSth3WNa6?=
 =?us-ascii?Q?ciVtfoeZJojhZR9BN4PtyCxt5QIaaPuNsC2u8x3ClVy0DRDXm9n3s3Tm6Wip?=
 =?us-ascii?Q?v0y9xk62cNxc6oVO+aD3YHCvjNsYCBfDofKWm8bxj6e+sZA7t9qRWa+PI9A+?=
 =?us-ascii?Q?j6G79uWExXwrri9NZ28B90Iui5bIN9HnL+WPahB4KHoAToqn7P2Rv1B51mWJ?=
 =?us-ascii?Q?GsOef5SljsavY1bhWV3Ufyl4ckW1cslItTrr7k5+zMiLGBiF3R29iqekuBEa?=
 =?us-ascii?Q?i6DmHR4VhKTd+qb3cxZUc+m2JvWGDMP3xFCHjbg8Xzyw0qF/qDUwIBKzvVSN?=
 =?us-ascii?Q?q8jDstnjm+cr6OLWrxOhNfCbFcX+h0lS3BWcrJKZGPtg2P7Shq/VhklkMmTY?=
 =?us-ascii?Q?r2GGbo6U4qQrgZg90yiO3moP3+p5mIMvXZ+AmS2gLyS9yu+eV6B9aY2InJps?=
 =?us-ascii?Q?8eUhK0O8q02CHzNkBqbe9A6FhY2lUOR50qYrahTWGhM6zMrZ/DyRfxZdkylW?=
 =?us-ascii?Q?tIf2VmIeh6l8nbIkqTHaZ6Gk72A+0vhGptFfsJeQU3I8eI9jGG4jq/cb0vRx?=
 =?us-ascii?Q?5K8k0Fp1PbdZ0CNh/YuJi39KR6uXsf4xLsnW2AeK33mNEUu2ueM6m+AttvtF?=
 =?us-ascii?Q?V5z34kTttDZYHqyIVFXKMElTO+lSAMJLmKstwsRV54WlQPFNMWT9ucAIeepJ?=
 =?us-ascii?Q?/r0aYHBqmD+8qtcb0bY6kwtzeNuFtilecNotBMuyfvp4m/9ETx08AJPcLy3o?=
 =?us-ascii?Q?0xGY10eXS573MGtJnQmV8APxYEDsD1oX9IAXyGVBFMrrcuZyTCHJQ+r25TWV?=
 =?us-ascii?Q?kBL9pE1QCB2iOSagvQeU/M4QuZST8Q9Tr5uq2xJUnXgZa0cXz5rB94wB4khe?=
 =?us-ascii?Q?4ulgTm/OK4F2mqk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EL1OZbRqILnO4lTU8gIVo6/mvTkLQWhZNwz2pSy4H7b2fZTe9b/UPNtJbN5y?=
 =?us-ascii?Q?dNfDYcR5gg8wavKS1iEs259j2P1oD2w2ZE/HrFu99OnMlLme9GD1CScK0sju?=
 =?us-ascii?Q?8F4Oi/kCSJuqHSu3DRC4tYSRkeIbDnX9QwMminvjgBVezyZ5uTuIksLW6wBF?=
 =?us-ascii?Q?BaeaMSNOM9k1+DWEsqtx2XWwqwd5kPfWCUvNzY0eib2GQnwEmOYzl4wAOjXs?=
 =?us-ascii?Q?8ywJwSBpz0k9Kz3yCsMs6yHA2KyVGr1mAozGPv1S10UtUeULqmO13AqQsqKY?=
 =?us-ascii?Q?53KjVhUEVYQIMSF0HtgHo7KBqkGs/oeGpalc+jI0jQhRdGYvR4MFurpSlfQZ?=
 =?us-ascii?Q?29okDOoewrFvhRBqmjsaTemfDscFNM21YBWOzUIb1/ovv1ycqC0ExR2GkZ28?=
 =?us-ascii?Q?ujkvZ3xkPOvMXBdg0erYA/jRgSEd2ZDOSngtxLY4KW045uUvBcHBBSiNkS64?=
 =?us-ascii?Q?8XswoEWudSmxRMbZocz1owIR6hB1xvQMTtcvarXnSVYCqqCAEc7RvI7esYKB?=
 =?us-ascii?Q?7kaWI/UvnpKr7+2PEjiRMskcHQ/NV1sjCZ1va/sK0Gb3ELSx6zrpOm7LWK16?=
 =?us-ascii?Q?zSLwp/yg31yHFMkLPsO70ywtvHFRP03VyzmhPI/QIh00VO47RRMHVM6xgcbF?=
 =?us-ascii?Q?lOsZ8ez4o470lxl5TLLFjSpsLjRKLh2AnIVsnI8E6FFypbTYVBKGanIjsVI3?=
 =?us-ascii?Q?uUcHEH7R7pEp7ihlDIWSlATdLTlwlU+5ivZ0Pi+Z0HAByr+E2oPly/L+Gapw?=
 =?us-ascii?Q?vVKBb5/9aoiDi6jk3KwRc/LlLxKM0espQJ/uTIZxChwDXcHEYnzx6ASLwkll?=
 =?us-ascii?Q?TJ6mmdjhx2r/9yXO3/4nDPor8duX9txqYrZbOSaddhCfCIzKM6UUjJpRqIAi?=
 =?us-ascii?Q?zg3/eAb8Q4NjCLxqv07kVCCo7TmURUUzTlaJn6tMMHa3An0uYpPUalNGu8vd?=
 =?us-ascii?Q?vZOz4ANtQ/JFV8+DHzz3sGFBSufnNVgZCL6yU6URdOcy6mIA2DK+tNMfI9T3?=
 =?us-ascii?Q?gEhhMYce0w5WzoUzZxf9Pa4YNSTxhuff2yrJZMcCe8SvJBt+oFRNYXG83+/+?=
 =?us-ascii?Q?KlBl7mv3Vtbsp3X50JxSZR8/tOmzltTbUucnABSQhdS9gn5LeAMCn+wWgFCv?=
 =?us-ascii?Q?fPdH0cNQ/yWxuNIsY78qS77sYI272F70fVZDJanwOecgeTNLlDxW5Vzp5WhA?=
 =?us-ascii?Q?kW81smiaoEsJu56f6UZLaE1YpoPXnLz4emAarURhVt+QSHEzFADwV7bSxfnw?=
 =?us-ascii?Q?1m+M7MKRFZh3KVD2MaMRby2nGrq65nageaiDnebtbP6O7wm9o5MX9Vmc0XmU?=
 =?us-ascii?Q?YgiifU5C3Duj+fSIwYWNFXNUtQnLWYQO3AH6TJYS1nYn+9dfXGtgqdVLUYy6?=
 =?us-ascii?Q?4FmSbhb9rXcW0g0GwRoZLjmwQABgFmA5w2zrMWCQ96j+qdQtzoqCCqV5b0Fs?=
 =?us-ascii?Q?umrKRMlSu3vBBus2Bk9PGfV/jTHgby8N8ZT4Owi6k06lmqcaM4rhRBKWnMqL?=
 =?us-ascii?Q?e1vD7QwE1p1mnrzqMDBxAaQE3BoUmDF7regAg37nPkxZxzUi5ocrcx6wuY28?=
 =?us-ascii?Q?RU8Usc+J+K0qr8LdCfA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e600ba01-cb7e-4c54-32c4-08dd976c9be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:04:48.4385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXuPt1wNsc9n+GSXnXiWbEQr9ixlBO8ePWysPFJ8EeW4mrUv5PvJF+sNu4ku/Fye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Gadre, Mangesh <Mangesh.Gadre@amd.com>
> Sent: Tuesday, May 20, 2025 12:28 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>
> Subject: [PATCH v2 5/5] drm/amdgpu: update ras support check
>
> update ras support check for vcn 5.0.1
>
> Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
> Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e641bd57bb6d..071412b8bd55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3709,7 +3709,8 @@ static void
> amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev
>                */
>               if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
2, 6, 0)
> ||
>                   amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
4, 0, 0)
> ||
> -                 amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
4, 0, 3))
> +                 amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
4, 0, 3)
> ||
> +                 amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
5, 0, 1))
>                       adev->ras_hw_enabled |=3D (1 <<
> AMDGPU_RAS_BLOCK__VCN |
>                                                1 <<
> AMDGPU_RAS_BLOCK__JPEG);
>               else
> --
> 2.34.1

