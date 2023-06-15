Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A81EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 23:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D932610E569;
	Thu, 15 Jun 2023 23:14:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2265110E569
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 23:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msaPrCWm2KYAXWl6+xHzb9VO/V9Xhd6AY+9JL0ienyN/rOETMEl+gFPF2b0lOsm22nLt/ubckZjl2K4hK0bJ1NgxuYEqFnhldEVyGWhkXvHsGMD1/7T5iHUzS2B7oY6dZ5pxmaVh8syF5jIUlsPCHf+Cri1xt+9hKpZjoehAZGg3G/OBgL0B09AJn7oWFHwzhfdmls40Lz36d0C1H0m3doLVfM92Js/nV/blh458xn1zIH7y13xFN6Gz7CTXRzKBSDbrHqQeYInCCL+Z1npd9qzc+ZNYBvfTyIFztgBZ9yRn8AuB4FTG2XO0l2g95Gr+YbBY1Sf7CJs9cfJvVMMRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BGgW9zirru/+udUvaz+gq907n9Pf3YczmyMzPV9vS0=;
 b=e5t4rMd7Y9I8EwBb1c55LE3cOABRat5aid216GY6AIoPMxbmeVbyqyeCD4DUyjSRyvwfaO9V3kAiDSmc9QP4qToApABojieBxhECxGXpu6+U43/gJ9u4YWDh10ZVmbMt/KX4EJq+rq+ujggo+oGcuTngIyh3+XWXWGiu6Tcm3xITAh6yjZb7nO8ikAM45djDn2d6C2JSIsDLocs2xFqb9SZS8njOEJAc+g8Efql12E3y7/mCvwFpZ2fL4aIMWEa3LrBGLgAgp0zIWaockUKT8yK+LRT2d7l6RYwmUMIxxsgZiAHqlkSC2y0tI0lWD/tAIvFNFuBJYIvE5yJZlVYjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BGgW9zirru/+udUvaz+gq907n9Pf3YczmyMzPV9vS0=;
 b=cWICPV1LqCVt6WvXtTAmjC6haCnw+9kPTO4YlJNirGacAbcwpH9Mg3qhXQD82j2qHuxGvKy2Y/BTvvVfVNZD5eFUzLdDrKM0+i91CejHIVybRqyChugCCbnFJlRGzy9T+NfqIDD/b2csswEueq2E7XVVFW48GupffOHYG7sCpng=
Received: from SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 15 Jun
 2023 23:14:14 +0000
Received: from SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::bfec:5fd8:f8ba:1afb]) by SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::bfec:5fd8:f8ba:1afb%3]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 23:14:14 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: set coherent host access capability flag
Thread-Topic: [PATCH] drm/amdkfd: set coherent host access capability flag
Thread-Index: AQHZn9xoijIDjFF87EOxze4pV2hveq+MfjqA
Date: Thu, 15 Jun 2023 23:14:13 +0000
Message-ID: <SN6PR12MB2717BC76E23D5A0B99DB6203FD5BA@SN6PR12MB2717.namprd12.prod.outlook.com>
References: <20230615225442.11083-1-alex.sierra@amd.com>
In-Reply-To: <20230615225442.11083-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2541f72d-82dc-4aac-b0c7-234da3195ddf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-15T23:13:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2717:EE_|DM4PR12MB6398:EE_
x-ms-office365-filtering-correlation-id: 9b79f4d0-498b-4042-6efb-08db6df63c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNNSx7mvtipAGk5lIdxaQEee89RX8RZZmYqzE+YCk2k07HtLq7u1BcUnVrZUBN1ZdnvhQRjzbl7rg+9afgRMHUsiJJjIcLFoiCqGwSvT7OiYD9DAxNmsY5jNCuMudzMT9z57PZhAZyLnj+hWnB9ENx1kN+q+Fd+vxhB1bDoGxf5+ijcrV7+ofDQzgJsapdZ56chty+ZSPUcLVjTa2l1Y/ohNGXaYo8ZI2enEmPK/0o+b0nAJOTZRpwg6WmgI9eLauJOFCrM9yzixDqkcXmw5/m0gcwWBVQol3cmgDqxeRdQhQ/UWH6YuEQFscpt+ygRtmpwHOFM8WCvNUSEfvnXtdrmELqQ5xArs0pmeuiJBwU4jAyr4Dr1YHWF5I0fLIm7pFNymbgRd+PMrUQbFXh6afVgV+W3M4J5Eqy0XzwISJr3Y+8REdEA2HnYpxDRRkU4ufuGi+VGz5mLHbvlD4xPIqCjGpPm087yNq08fTxE+mN39nXyOX2qPa+KOyiRLlIj8vi+ytPGyRVinnFWuEakHOg/+MaNXarGcaNw6cazgXvcEUwB+0uXWCnvO6RLkIBigO6cnil67o904xe19L3+U01cGKUI3Rdu1WKskU7E20b/4Mh6TYqKt4muvT4bpiG8s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2717.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(26005)(8936002)(478600001)(86362001)(6506007)(53546011)(9686003)(71200400001)(2906002)(8676002)(186003)(41300700001)(7696005)(316002)(64756008)(52536014)(110136005)(76116006)(5660300002)(83380400001)(33656002)(38070700005)(66476007)(55016003)(54906003)(66446008)(66946007)(4326008)(66556008)(6636002)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BvcxFLMIc8hdNMeHoN1rwdHYmUcEnm/jFkJyZwgOqrOU55Z8HqrSL3XnYjnI?=
 =?us-ascii?Q?zWlAVpJRJofCkeJkVJ4+qOSBmYHLQfd/nwcDaa5wiIIWbmm/2draB9cwlLar?=
 =?us-ascii?Q?OQkGvNwhbXMkKZEsu8mf7TwfY646lEFN7oGjkRIH5HTfRWvfb7+bN1qci3zM?=
 =?us-ascii?Q?5VsxSr6rs5HlBG6bdZA4q9/THjgUkC0DpFW2cxAAj0Ijnd2aCTjyXEZEQipx?=
 =?us-ascii?Q?1cwaWSRNnIqoJ1Eb/fH3hE17egAq7Rqz2f20UWnnVs/ibHtdSQLg9/V4NV8N?=
 =?us-ascii?Q?NJnvqyqwCfIE8EKM4Hrq2bcuZ0VzALdEx1h8t2XxcOjPqMz1kSmwDCsKomwI?=
 =?us-ascii?Q?iBvz+8SYCDFFr4KKn3uQg9Y07VCkvzdwV2467Ghp4y+BhvSjv79Dmj15Z2Yn?=
 =?us-ascii?Q?Szhl7wazPku0tkbPMRemj2PpYcoVKTG8C5zGLznuPNO42HthaHN+dAdUvvVi?=
 =?us-ascii?Q?S44h9FHH/hDuaJsHVJ7OdnbjIYw/+g+uM501edyJEXkTje9o24cpmtsHADFH?=
 =?us-ascii?Q?ojiLaLTWUXDPV0NDfYFA8WBmsE7MAsiaVPl5QUrtob+rwSzn4SNdqMwJTsul?=
 =?us-ascii?Q?xk2IyVcdFFPRTBB7rL+/KCkiybsbPosDK0puPiZfb1b2LGGTtlYIH+TPeSbr?=
 =?us-ascii?Q?g4Sy3tsPtQuBAaYsUHW5zPXlxARAD2rObXB+qVgGIZ01/RJxx78D51egzoRM?=
 =?us-ascii?Q?niwyjkgCdBjR56WFJcrf1p5kVMzBfEW3aTBns5eGTxcX+YVvrvQWTL40HuzZ?=
 =?us-ascii?Q?Cd3YbvNet9d9Alzaj9nMfo2Wx3IlPTgp2wZcerb4O8KunFOD/mnRZrJ0y+4g?=
 =?us-ascii?Q?0he+ClBDNfUv/+okrNAE2shNGzQaSz+eBnj18TeXGM0616jkzBQLcj5godrL?=
 =?us-ascii?Q?pAkzxmyaNjp/yJZ2u38HlBQLL2DiTaTqgeW9ooCOr7c7QH2biUuTDBViDoxb?=
 =?us-ascii?Q?ElaFkoeg83Gfur+9NpcykQy65fO55WCtfpvROkOWlcxZrLbOK4s9/VC9nCjI?=
 =?us-ascii?Q?ZqpiwJEuEEwyXxefEV+fi3/NvxgwEBz7Jqmmn7wGRg/Z/eBewyw4Jto/agT7?=
 =?us-ascii?Q?iK+SQiP680dML+TBwCAKKk08F7Gu3vLFPGIsrgNU5QI6nnb7cOMgnujQve+Q?=
 =?us-ascii?Q?SX/0tHX0KaobhtzFPZEQmbgxbB54lUMP8U+omptYAk/k+gi9oN0WBOT0OKPj?=
 =?us-ascii?Q?b0LasM8lxWGveecZpq4eLdBxk7y2tjfG83RD9by6PqzfVVmK0M41TJKtwYT6?=
 =?us-ascii?Q?fvSRT5dOXK4la5hfBaRBxqNfHn0uWGoMEqdg96KB3onZF8sesSgxRLYynlDN?=
 =?us-ascii?Q?co+Wz8jbtWFa3HxYw92/p7uWAo9nASoK9QlbSsmQJWW+2C1yfr/6RCSStNMB?=
 =?us-ascii?Q?Uvg/7Uh9to+h+3/ONT2GFRBrGF1FMPUFdn2TL5CW1MANTdResYDnKdBDpBun?=
 =?us-ascii?Q?cNimppEcvScKUL9uUiAlUIvbCVwdRKkqCKu2wIXc3fqRuSph9ySAhnPEewMM?=
 =?us-ascii?Q?w1eZAixJZxes/j5ffNToRBcc4w1ouuDeKbRON55tFcCtCBAtJZoQvWVDfNUT?=
 =?us-ascii?Q?GfuN5WVOJtqtkJCChDM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2717.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b79f4d0-498b-4042-6efb-08db6df63c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 23:14:13.9187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6TMYK0U1xxCzsNs/GsoU7BDq/GtETJfvZffxGl4oNOlSNAUJ7B7PIcgLWYuPICkVxmy4cmp8EzeicazmQF1WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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
Cc: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

CC: Rajneesh

> -----Original Message-----
> From: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
> Sent: Thursday, June 15, 2023 5:55 PM
> To: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.co=
m>
> Cc: Yat Sin, David <David.YatSin@amd.com>; Sierra Guiza, Alejandro (Alex)
> <Alex.Sierra@amd.com>
> Subject: [PATCH] drm/amdkfd: set coherent host access capability flag
>
> This flag determines whether the host possesses coherent access to the
> memory of the device.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 90b86a6ac7bd..7ede3de4f7fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2107,6 +2107,10 @@ int kfd_topology_add_device(struct kfd_node
> *gpu)
>       if (KFD_IS_SVM_API_SUPPORTED(dev->gpu->adev))
>               dev->node_props.capability |=3D
> HSA_CAP_SVMAPI_SUPPORTED;
>
> +     if (dev->gpu->adev->gmc.is_app_apu |
> +             dev->gpu->adev->gmc.xgmi.connected_to_cpu)
> +             dev->node_props.capability |=3D
> HSA_CAP_FLAGS_COHERENTHOSTACCESS;
> +
>       kfd_debug_print_topology();
>
>       kfd_notify_gpu_change(gpu_id, 1);
> --
> 2.32.0

