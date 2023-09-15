Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71008EE6455
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 11:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5ED210E61C;
	Fri, 15 Sep 2023 11:01:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A0910E61C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 11:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9w+dma7jLeGWXf8HY5Yf3DzldPovvW5zVxVhnlBWqKdyZb6dQ9VPVSIlFUbEAP31TintczRX/X6gNnbWMfFywCIkDQ06JixDLapYcxCRyIhuURrU2W+1c/oBIFjpzdMLdToHYk8ivQ0klRwdPjviJwgHttnSZfSz4ARqpMp2VAKan4TAaPe087DGPHErO+4699tXKI3VEQH2tSO4tIGCuW0zqvZipgZqRbdcBJh4OL4JQ7RnordWO9wL9f1IIyB4OnJYcoRnTUGeO8HF8OszXf/0jXV+xKwF7xhkcfWg5gMy9qmI5C10rFdyUxyrkbtylszG3IpoQP9sLtFR59cOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkPmeCd+Is0b7Sn00iSR38i3CrdU+Gpr38voaScTdI0=;
 b=TJNLYjX1AOn78P5bIIl7jHRhphYFx3DvpMjEdOYX9xAFontM4wNfhmBdcKI8A7kfWFplXgiq//h/K5FNsU+sFThWkgg+cFmZQPDqrW3ngF97B1su19ZnT7ukEYG+cnnUGYubUy06jqQc2ZMWMBXmRZco1BJGnWW2ewUO/++KJB14WGN4atvWHtKJgHsEfKMVUixxvhycO27lD/rJ5p/t4x2xHOXUcmzu6NuHvYebVt1LplKXXGWjbJgJSkyJ6rrEKKMw02X4iggZEBtJpmXtCR1c6P1fvQy1Qhik/Y0eJ+I2YbUWuCbCPEBBwnheJl2aZE3LTxpkGCjrfGEeAquh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkPmeCd+Is0b7Sn00iSR38i3CrdU+Gpr38voaScTdI0=;
 b=cpAFfnxBUdDIcNavjy30O9Im+0vRmXAABUQ+86/4uMIggrhaNbBlaK5g/Ap1zcEbxj53MHDy7edYnyIKbL60NfAY+1C8kr9qp37D1Z+L4+skelpCCBcpKj7Ahg+mCeLdsqhyq84SVkH8bs5XBgn6DZk58alE64jCcV9YV2r+MRQ=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 11:01:23 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::d59b:2efd:b690:583f%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 11:01:22 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix false positive error log
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix false positive error log
Thread-Index: AQHZ58NwqQWZ/vUCd0CloA5wIfp+h7AbuDsQ
Date: Fri, 15 Sep 2023 11:01:22 +0000
Message-ID: <PH7PR12MB7988BA30EC69052B94A7F2D59AF6A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20230915105729.1849284-1-Stanley.Yang@amd.com>
In-Reply-To: <20230915105729.1849284-1-Stanley.Yang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=63940c7b-eb2a-4fed-b86c-1e5bf08581b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-15T11:00:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|CY8PR12MB7610:EE_
x-ms-office365-filtering-correlation-id: 2b8d4cec-4a60-4ae9-35a9-08dbb5db1924
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77MmZox5gs12hXnVra06MAhtlJ9wS7Dc0RZtHeboSf/3Gpk+pALaAjvKVAPKUKNFrMgG6BFynbhavGr+3Mp98vxqEu3DIoRppV8oaVSFiu3KG1Cd4ObBGiqv1HEv//7CwZh02AZPGg7Kzjh3d7QAi9Uc/f7dw3NEDMTBoTI7kQFxswkMdhG+Um7SEX4lHfmvRYHxLzTqcr9HfrR50pzdAabmFlCda0l5noOqeMHMCdHHCL4FTfqJZyG0UwBtxCz7mrSzUBeTdzUGc4y8bx5RNFe0lsyffdzHi4AxVm/aRqlcsu7w+VON/jY986VasrS/TJ/3eKUtmT2d3kBMU3A+J0p8Mcs7t9MwndhuxZrrD8L3NJXRMJ3Re7VSl6leQX0Iiq7HacoBTH5MoPYJoHt8ixOdIf5ALMBE7jDtrY1sWK2n5c6iC0vDF+BaS31gJgnL+sx8d+BRHBcYh2YEWli/uEH/+QJpC0PR2MU54xFnalsLYo45Q73HXg6RJSEZWO95r7vIhCQbvSv9CLgTt75KtdFVb0ITHqzo0+9ZATTSsgTI8RPhPTjqy7WGtXzy0XM6VPxC/4ITrIpl8SD5UTIma8zxVJLCnMJeoFXMZn0t3cSuzBQ935xU6RQYUJ/g/7Pj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(53546011)(7696005)(6506007)(71200400001)(9686003)(478600001)(26005)(2906002)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(316002)(110136005)(5660300002)(52536014)(41300700001)(8676002)(8936002)(86362001)(33656002)(55016003)(38070700005)(38100700002)(122000001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?54AiK5K+l3Ta2j3tQx4Bc+Xb+XOoe7hG/w8QdrftXlvNcRLUlDvTLqp6EhmZ?=
 =?us-ascii?Q?yFH+QS4GklFQcLZkrbEIVgi/zGI6h7RS1bzSkhlsZ4au5eqWrIOHbKWv74ja?=
 =?us-ascii?Q?6wJb7zkZx+l7yWjjzArUBRgmQNcl19scGbH0IRw99z5qJnblDiIRnnha9+X3?=
 =?us-ascii?Q?uOmAYbWcVkX5jiS2Xh2r8J7eD+t45dvw18xw87yjWF8RuF9jMVI00/bh2tNP?=
 =?us-ascii?Q?QnOPLVvAEDbzNTCTNw52IbgQ48dU1tTjODYtXsfOM8/t5DQeV1YQOsg63i8P?=
 =?us-ascii?Q?wDmMMxiBFLzcW89QMrfdoc4WC7++D7f/wCMls0y+h9Z2xPX8WhuFOpVG6hf6?=
 =?us-ascii?Q?LsrhrfA6CSRvkuAL7UzkokNMkIUnnuV+Yh9ZFAOLfY9vB9G08fQivvP9/Ao0?=
 =?us-ascii?Q?U6bm2ZZBjZFjmd1+hPsZxS/UY5+8dL0/NFKrDaF7sfy2j/vqChPprb8hy6R7?=
 =?us-ascii?Q?I+NGAf74MVss5i3sN1Xi986w+gDcd9hXGCMkTxkCFxyZdlsJxZjL/DGzGi/c?=
 =?us-ascii?Q?/MXDbBoBeCEaquewwd0Jqv1FYEZ7uncgZ4fX+FzPFvajRKWCH23VoMWa2kPj?=
 =?us-ascii?Q?jlionx+Ao8oZRL9X/mcfvysHnC7bKYFKIKc+zFkDbqRQK9a/w1OvZYHfoPsx?=
 =?us-ascii?Q?6VHbrjoBDCwcestA7ZsQQxxz+Sv/8GIl6cqxej+KxNBEhGRqGr8+cOWqYgVS?=
 =?us-ascii?Q?M5M1HYMkdFzIG1ouBu3428X8eFSLmnXdR6hOJ4COJZRIfKiNbJivTlkoqf34?=
 =?us-ascii?Q?iEh04favH++msJkWSoa3/hP0fxymiyhGT+UyTlaRvE6yjROYDti0nd85O/A5?=
 =?us-ascii?Q?7CKnKQXHo8c1KHxNzUvBQPHQ8vXhY8OJNBxbcoZgswToEJb7Qb21ni1JFZOq?=
 =?us-ascii?Q?Ixt5SoM0zplQ8KxJkUnYvLE3rMBvsY44gvA7yhuII+Xv5dQ/MLpv9YpdQOo7?=
 =?us-ascii?Q?Sc3imAc1b2G/WIHeIfYOxXqEqSLBSHVxIfF/9wv7eX/Dr88hpJ4VH2dMU5pC?=
 =?us-ascii?Q?olutG3h6PZVWqhG/ioAYzSUrxMdNxB99gFLP4AT+myl/1wxc+5wJfLaT2MwA?=
 =?us-ascii?Q?+d6P2dH3SbTZvV2RFggq/b3LCbVRldYNHeuo0CV3lkCJ+oU5igFI5zF0iOXV?=
 =?us-ascii?Q?yNUIle9nOLFJOJUE0Moq1kRp6JLQ50KmBA84sttxHvP3jQ54wGVUrYXtyq1U?=
 =?us-ascii?Q?S0kMwK+5KOA8EBb0W9aPc59YUcFn/0pQPQZTK/yw20cAgjWq252gbkph77r7?=
 =?us-ascii?Q?TTBUB9FNwwfSAzq/K8UqN7YOgHRrnkgy5qInYHhoOAaFNoqoHRXSIzfcZlFR?=
 =?us-ascii?Q?sw6ZpSNaKyXtTqSvRQm/4wZnV3cI3kDuDccY3hq8yF8KkdJiqd5eiDTuWk1W?=
 =?us-ascii?Q?4IP7qfP9+wc5SeJOotKfSZAxJwOBEFOEMpxMv96aIPkApH56uXxbnBoAYtjz?=
 =?us-ascii?Q?LqM8Dk8JsLz3gJJE/fOq0jPuxZ/lVxI4Mlb3K/aJaIIDR+e1arhXh22bD5dB?=
 =?us-ascii?Q?bO6mjZIfgJCdNswKtCcrD0zw9ZkYvUKI0NAOn3tR+CpZqBbxVUfwqZi1lNHK?=
 =?us-ascii?Q?c8WmAGfoWZzfwprvui0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8d4cec-4a60-4ae9-35a9-08dbb5db1924
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 11:01:22.6988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yo2jx+02Eox/Q4Vfc14+U8CqDj6St38bVuqq2bZ2nIeSGmmru2GVQmjE0jmLYHgA4y0vq/JhVa3VYgaZZgOaNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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

[AMD Official Use Only - General]

Please ignore this patch, will send V2.

> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, September 15, 2023 6:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Fix false positive error log
>
> It should first check block ras obj whether be set, it should return dire=
ctly if
> block ras obj is not set.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4a6df4e24243..ee62f5fa4456 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1105,10 +1105,13 @@ int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,  {
>       struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev, block, 0);
>
> +     if (!block_obj)
> +             return 0;
> +
>       if (!amdgpu_ras_is_supported(adev, block))
>               return -EINVAL;
>
> -     if (!block_obj || !block_obj->hw_ops)   {
> +     if (!block_obj->hw_ops)   {
>               dev_dbg_once(adev->dev, "%s doesn't config RAS
> function\n",
>                            ras_block_str(block));
>               return -EINVAL;
> --
> 2.25.1

