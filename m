Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3812CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 09:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8641410E392;
	Mon,  3 Nov 2025 09:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QKoqIRx/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B8310E392
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 09:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xon6O8XAoZyVXwY58IPkik3gvUSIBwDmXAGvGiw6Yx4ZMbDCjaIC0N95R39PDiOqW856CITgqxBbX3d91NRRCGZ9I1szbynoyDw4kVi7Uj1z8TY2NlAEG9IWmxmPP1Cysn8XyJ/+ePgnEhb2DTziD/hSVpJs5hD2KgsEi0ZdJ4h4aAxETzgLGp5sEidzvSo6c/HjPFwapb4Z6pCJUpZ2ePUsHFziCUL04MYOMHxHwmW8UhO2Dw5oZP5DaJ7NEQWT4LfPbVGW8HmfINscYfDa03VTO8+tSc5Q30NBWmK8XQub7aXPRxXvCSMGmYMyiscL2a1VLMWOSZkPDMqZfxOL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWRVCkhfMTqx1WLwozAC1mf1QZib2Dw58hbfG0jca88=;
 b=nUymS/tmC3u1I2x4vROmdfHAMsPARLzhjiK6gO6OfmVYFwv+p7noe4ojyng4hGvEibzjFCKsK3Hb8HSLVaAQvAwvODELkrq1VHaI0KBU/u+YdZ+cLQJMniTsQxjtImE7eil/BrLNPessSCVVScoxaapIPtCVWy+gCVgHoz71Cyuy1kx73h171D/yD3mVn4/hhbvTgSRV43Rpig/s7s3Wez9VTYOooGQiQoAuc1G9gIclc8ExdE1H6rZYdf51ttvgn4GziDCWb86rFSczpmfxO/3Bc9v6xpsNjdLPRStW7YuYpici3X8q5OieEt5XUHfSvsSR304dCV+J3hrPJo8Jdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWRVCkhfMTqx1WLwozAC1mf1QZib2Dw58hbfG0jca88=;
 b=QKoqIRx/OB/CS7QPEaeFaK01jnYaRRjt4dTrMUmq1fO2MyReZxAkTQla9RVgH8702bZ93lXAEASLmr2spE8YXvspAW0qXa3TG6Gf2KuySHNxeIh1iyzrx+t1daF1PlyMCww2mUiJh5m+wqkY2FTFw8FHkqZo0lhq+Nqxym9u4KA=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA5PPFE494AA682.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 09:30:08 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 09:30:07 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe"
 <Jinzhou.Su@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
Thread-Topic: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
Thread-Index: AQHcTKERliwUCBymREuawmBm8BRFlLTgr28w
Date: Mon, 3 Nov 2025 09:30:07 +0000
Message-ID: <PH7PR12MB8796AF3604DAED28BD782129B0C7A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251103090457.3036885-1-YiPeng.Chai@amd.com>
 <20251103090457.3036885-2-YiPeng.Chai@amd.com>
In-Reply-To: <20251103090457.3036885-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-03T09:29:26.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA5PPFE494AA682:EE_
x-ms-office365-filtering-correlation-id: 76cbf0cf-865a-4d24-3a35-08de1abb940a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9amThzkdajxU+GsvioeqajQwQSWwREMVJGklhJ+/Ydk+Wycg79BXYxj2UPqp?=
 =?us-ascii?Q?Lnw2RHPvRnZ189XNFMpwvtsETKIfkNvpyPDIXQTAHFOIS46xMpHAhOrVpBbK?=
 =?us-ascii?Q?b75IjHGD0DwO48VMrUzQimqRDa7k+v09gtF18z0KzJmENwTFqRMAtfkypKpz?=
 =?us-ascii?Q?8hGcJU3cdR70wElI26KlH9YfvY8cWHnV2l6HpBWv3UkyFqPAOHmdWSMb2Enr?=
 =?us-ascii?Q?dTWMeWfOvGJG1EIP5PWi9coFPtUE2L90FVc/4pc4sDOe/VubBMqSj5/Hv3nB?=
 =?us-ascii?Q?y5DNzUp9TZ5SFLYlJLyvvYNi3XPwa7UVgx/Xj6xZZMb7N5TieXxyJWpHfBFK?=
 =?us-ascii?Q?hQOhlhJ5xW0B622DJphhLM/H0X3sVd0dKRAtS0dBhbEPm2mye6NZPEtmrHzW?=
 =?us-ascii?Q?lPE4B/g/soIOX5H2sLAu5KrraIopBRgz4ojgr0rMsXBc02GwJw7weTHMrMSq?=
 =?us-ascii?Q?yJ9vk+BfMsoS0KwWzOZ4mEQC6kZsrMYOlvnjNsGM+bTALZVhaNb8ztovgX0P?=
 =?us-ascii?Q?sbBqw/A9TlnhVpQfbNNSMTvldjN4YPJlSeEWN1+8KPqw69GwyyuAmtOU7Mx/?=
 =?us-ascii?Q?IkNPbyle8JVfUnuG4+MTeF0OzYX8AnoVnxEQtReaKFFugckfSZ4GvrlfF9fI?=
 =?us-ascii?Q?dgd9/gCIEbyhjEr5PL9iLkE0r7LTIW48nktm1g6eLKgeOckLRfceFPXAsbRS?=
 =?us-ascii?Q?X5v8VF/cywY/RfQ/0dSUr+rYstVY9lWSuRD9hVlxPB+da/ITaKlaWvEKaDId?=
 =?us-ascii?Q?4DYDfG22o9D9M9yYnZTjyhIqCM2w277dEZnsYGcsmh7KTMxxY4n4wIhAQ+QF?=
 =?us-ascii?Q?yF3hYc7L6DM3LyDujeEGYC+m/cleViTkS6KRp8NTnAZti123jb0qDCMYdGh6?=
 =?us-ascii?Q?Dp1x70ZsLhZeydRqHVJ5aYpHIAa5d6wzbLu9CkihCU5MbnMPi0YTHR3iKETp?=
 =?us-ascii?Q?coW7keYbNxooe2m39locQAu59o/jQWKmZxS+FOR8nFUBYkhRv8qaVipozLig?=
 =?us-ascii?Q?Wq3SavopI8AZbs/FKsndqN5kVuuBDk75wskw9w4CKOt83V9lnGxnGtkk9A/H?=
 =?us-ascii?Q?OX3W+SN8Ol1yfMFCkxsXjYnGt2aRLqiRX8BVMPGr70rf7Xi9psfbjydSw6+C?=
 =?us-ascii?Q?yxHAIj8wMF6rcOiZKghFVY8sJEzCI8lLfocg2hPm81AR2JydhAX/L+9KxBc2?=
 =?us-ascii?Q?wjO4vJRBUndUYPZQgybGYA3MWiEm+WuPUybAYdJt6L6lmBQ5T/lfsxoDiKii?=
 =?us-ascii?Q?jV7P8IOXrnnxkj1wIDXrgQXgqFqUvq9UkUuHlrEReLBzWZR4w6++CwRO8l1Q?=
 =?us-ascii?Q?nOXdrYjy/Mr6ufaAD5dRJXee0PXDK0UzMwlK+jfa3PQ9xZCj50nQeMuL9JIz?=
 =?us-ascii?Q?RDN7wVRumN8ckhtudoZ8Tb2JeVGbLpLB5IIbwU9wWXLp34rVPsagWdQdf8yb?=
 =?us-ascii?Q?jhmiEXc5OeIPUTAoenbPmoNNob3vEVdsJ1/7l0jg56Da6ORYHBojuPP1V0bB?=
 =?us-ascii?Q?qRCVYKy/6wbqnxgEliHjnUYtQMX5Awxl3LRV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PuNPA0lKKaeccz8FvazewzAgJpdludSxaAPOGfZn9sXKDw1QrkzcJHJ/JaaD?=
 =?us-ascii?Q?+YXIk7k7tDcEUwluzOrP0gC9bihG2v6fvM2BSDppx8l2j6PXkbM2yRmMwDzV?=
 =?us-ascii?Q?5n8Ga2urmOzTisPdmltZXNO+zV5LvPo7chFDWRI3QFVlxBEnhnLQ7lnz/OTC?=
 =?us-ascii?Q?h5nuDJFrXFg1a5ybpK0WHR2Rs+gjrSw1Af2pzDWLLIRhcN/gJqII7EAPSW4r?=
 =?us-ascii?Q?kYaKE74CfJ3/+yFkJ1Iopk3kRbyyVeiXICZmDGDLaJRBash+otRl8bVQxUG1?=
 =?us-ascii?Q?sLLIUcK+OsHygy6cjU1Uxdi5XrCJt9vIDI8eoEV47ZiugRMpxMTq+3t5pmse?=
 =?us-ascii?Q?Z9QT02jVgZs8mAoeRKFKoLpVvQtMLHnTHxJre57Td9Qr2Vu8e43RDhYsbvDJ?=
 =?us-ascii?Q?auPIpJxLRvPugx7PNryNjBZxR8MgaNtGOLowWfalOfZI+p3M2tg9Pge1eUXx?=
 =?us-ascii?Q?bZaGbqnUrd346ae5grsBg527TbZp4yJuxalSpy3gn0UNF6u7Pe7+0ppEj6Kr?=
 =?us-ascii?Q?22aOcmaeRhR17NNaK8Td5Vq+XTWwBwhHv/v4grAi+vI9infzweu59SBtVMVO?=
 =?us-ascii?Q?/NuyWPlpzTQlTzFvVDn2X2XjWHJXESqbStsBDc4YGA+ez3NmZucwpHl5elbI?=
 =?us-ascii?Q?EaRVAAwxAlnZtTjA4K5wL2HXm/Lx/UJsgJbRBCU4Wc3orekehQjgh0PGQ8qO?=
 =?us-ascii?Q?nODejpGuP0weC27IUgAK1r0UN14FJFGoS2a0laAjZ2BJJk2LQrUJNeu24CFX?=
 =?us-ascii?Q?qufVzQ57H9znyp92VZ2jsc+tzZxsSJ9LTJtcgrpATvvlYV8+ksMtE/Dg22sT?=
 =?us-ascii?Q?PqdwIbpFIuvP75D9aaGtPlX98HaZ3MFAFyet4ccWUOBNq+f+bWWpeuhYBETl?=
 =?us-ascii?Q?01BbQjh4GSxH6RivXaUmCA1xdmpGjcPKP5AzruSVpSQVdd9lQQj1xBaEkKVx?=
 =?us-ascii?Q?rOKBmNVMYPxKjYW6vAlBArA8o5IX9MiWdCWXnD+2z9TUtjMWStOlHJf2Qaz2?=
 =?us-ascii?Q?w0XNxs/FJRv88PMseJJ1Ee8/ZMLb2Nl2l8sol1jIg7GLDg42SxpJo88QmyMB?=
 =?us-ascii?Q?TtuC7yHejBidWXKTYl4F8B39k97HayjvBN9tc3PfK3YSOPtvzQ6h4U3qcs/Z?=
 =?us-ascii?Q?vvQjqXBeT2M1Ajdgs1XK+xCuP/9lnmOLtHbZX1K8Pwb7lAGB7lpg69CM0yFh?=
 =?us-ascii?Q?rsN2OxFpyQqS8Q+Jb4aEDDYBjlOdBx0eRA5jhV47VlwBR6koNUpNPYa3k80h?=
 =?us-ascii?Q?M/83LW2dPSIHZGjOn6/ligo9eAe4zcfJXqSH6mrKO201pOPKGDZI3mqXYdlp?=
 =?us-ascii?Q?sk5+Zah0Yt8LBGD26zllOTNYVv8xbK5E6sYVM5rXqvI5LX13tmkMviMZF6or?=
 =?us-ascii?Q?eLnKxMHtW9L+6VD9Js9q4Md0OP13aiCkfEF8mzG6iNQ61uf4r3dqFngtYZtZ?=
 =?us-ascii?Q?YPUgEIP+Cg9GuU5JI1bobiJ73nbtL2ZQiBqmm6GKy9WmFrcX10fBXCW5G2x4?=
 =?us-ascii?Q?krIbDUOlOvPA8Z6tCO8Ufs8l0GqQjThVRR+skCZ8zB99D0mqhQWLgjI8MqvS?=
 =?us-ascii?Q?/YxCnLpoksANScUHwY8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cbf0cf-865a-4d24-3a35-08de1abb940a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 09:30:07.7993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geET0a3mbxt91lzmaYxrq8+RJWMyE98IzrQSmckOaUd1v/ug/Rt6PvIB0Imhj0jS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682
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
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, November 3, 2025 5:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
>
> Add ras support for umc v12_5_0.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 ++-
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c        | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index b06aab25d4cc..40b458a922d5 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -259,7 +259,8 @@ static struct ras_core_context
> *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
>       init_config.nbio_ip_version =3D amdgpu_ip_version(adev, NBIO_HWIP, =
0);
>       init_config.psp_ip_version =3D amdgpu_ip_version(adev, MP1_HWIP, 0)=
;
>
> -     if (init_config.umc_ip_version =3D=3D IP_VERSION(12, 0, 0))
> +     if (init_config.umc_ip_version =3D=3D IP_VERSION(12, 0, 0) ||
> +         init_config.umc_ip_version =3D=3D IP_VERSION(12, 5, 0))

[Tao] can we use " init_config.umc_ip_version >=3D IP_VERSION(12, 0, 0) " h=
ere?

>               init_config.aca_ip_version =3D IP_VERSION(1, 0, 0);
>
>       init_config.sys_fn =3D &amdgpu_ras_sys_fn; diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index 4067359bb299..4dae64c424a2 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -71,6 +71,7 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_fun=
c(  {
>       switch (ip_version) {
>       case IP_VERSION(12, 0, 0):
> +     case IP_VERSION(12, 5, 0):
>               return &ras_umc_func_v12_0;
>       default:
>               RAS_DEV_ERR(ras_core->dev,
> --
> 2.34.1

