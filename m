Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20DDC4829D
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 20:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5EC10E12A;
	Mon, 12 Feb 2024 20:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FSnD10cH";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F8B210E12A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 20:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozsjqh+xdb2gT+8PCWqCgHkB8RyeDeF8KBa+zEzqaAZFyoDkOBQqCwDylR+K7tdd1qXrFeO22rPJ97ih5P27pB9u5ImcUuw5y0nGdh0InsUILd6MC9p/eEPqGBZ4AJR2748qB3y0fbUFAPWgaLryocN5M7+cppdYe7Hq9ij/MOWuKzuo1xKuNpdt+QsYgTCkslXllYdCN7JdmxJIKKw98xZ4Xmkd04PFtJ2B6qqqy4POI+IrThbsIFh8Gai/KThD2Tcz9ZpXxlyZxlcPPdtL9RUw6jU+J6Zh4osNCB6J+AXxFHS1vNIzZuJULzZoBp9F3y48ruy+ftJjhtq3cLIlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akEtdo+bJsiTwgwlVtbqxch7sLvE2asZewrokIIz69E=;
 b=GDtH5ZJ39Yi1OhU2WqdpdhR6nVIfACC8zYuUDw7DEpGOTMH9HS4oQf5vw9NlbKvAdMbHqCyyhrZDElF+rjCiLhKBwTYdx24NbVuuKY/PPhVlgMIHYdBAKchqc/rtD5FR5GVMZhrSBbMRVoOIHxRSuAJJYr+TLelNmxUBLD/VpQYpv+p+KTWokmrX6or6v/ykdlmiXd2l4jtGFSBAuBpmA2Vt+1ULGZwIXVrVLOZtklUSlcfME4KIiKUk1bbqKkRgrwIerhx5wIQ8e9pBcIPs2NZQeygNm+A8UPJBUH8e4FH7vJ26Joe/XrsAlD/OTi4FW9WjfH9w7frSM05SKu+qjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akEtdo+bJsiTwgwlVtbqxch7sLvE2asZewrokIIz69E=;
 b=FSnD10cHYlz67zPueyPaRfWvPp0i5SRu2dZWMQbxMj97TWUnVRtlNLgidP889Te03qE5g/zjsVKpxemH+HKq8lzLZuKVpUosegNMP4OBN9Y5UHYXw1rgM1VBjQmi53J6SWPW2yQTTlHrrWlr3ht9KQpwfi2wxmISS+9GMJCu9eI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 20:56:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::e1ab:29b9:e3b4:dfdb]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::e1ab:29b9:e3b4:dfdb%6]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 20:56:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
Thread-Topic: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
Thread-Index: AQHaUsu9xld8pb8mEUe2SDr6YkSForEHRjEA
Date: Mon, 12 Feb 2024 20:56:18 +0000
Message-ID: <BL1PR12MB514476B2675A7FEA612D6473F7482@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240129155621.824237-1-alexander.deucher@amd.com>
In-Reply-To: <20240129155621.824237-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7e27905c-7ead-462d-87fd-baea59d3685c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-12T20:56:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB7792:EE_
x-ms-office365-filtering-correlation-id: 1d6d6502-2121-40d0-3957-08dc2c0d0fc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3lvyoNYDE1wlFXaM4a3gDCn9vta4iCWkDyt5iTubnF+C+scStuLLHraEpHvDt0c2nvy7p/cmfWEFeNcM9ze5SMmv1GaF6bdRW13mJoczdOdUHMZCTc25kc/yVdiqNLeSKm0u745/n5TmdOibPxCGWUll50wI3teN2zwwVn8vCUzU39kVZRKHjqP1/z+Yo1NjEYhOXpM/Xw3uLf2bm46JkDdGXp0KzoeHi5LFUPsNY2o8csPoJwmd3dg/+siuFEmQE/UC8MKh0f5vPyssr3t0+JfQWaPnOEfMrVuy/FmPZD3XHei5V6LZ+9WtOJJfJmBhK9m+7/WgLRYR+v4HcU1S1JR/U0a24XBzs5SwDrlcRxSLGNPVCdcyCa2OFqs/fohWgM8orE9r8N3EBHUAkCZhgZnkKTqErvaVOU9++0Ea8kGN6DINV4Ewd7KTEV7/2WF278dy32iCQhXVaes0doRAKKM6nkK260Ez9aIBiwsOW0a10370RlzyPobu9jHkIlAuqoPjSbJpCmYVJlEwmaDfG3WZS+DEDu2CzV3xKgAz3Z2vn2pqShrmp4THgXFpIfZPKat/T+D9rSxTjCLnQXzwsFAbHKB+djtVedLMU39JFk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(8936002)(5660300002)(52536014)(2906002)(83380400001)(26005)(33656002)(122000001)(38100700002)(86362001)(38070700009)(6916009)(66946007)(66476007)(76116006)(66446008)(66556008)(64756008)(316002)(7696005)(6506007)(71200400001)(9686003)(53546011)(478600001)(55016003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+cSMPSoGafQzU22ChK7JzcL677c5mG6J9wod4kjxp6drxkdgA5Et+BDpxHSC?=
 =?us-ascii?Q?9a/9HsFvBFninApTxZhfcEnemT4Xf+lBSAb7IxpSaPTT+l+SYxARVDNcG4wb?=
 =?us-ascii?Q?mnOewskQ6U1rIsYQ02Oa8K1TxUYgHoo/8vPUwB0Mi2L/Bc9CsQKVcdxabjPf?=
 =?us-ascii?Q?FAotVi/mKuoC1JPqIOjR5cAXrOA5xBQbETi5liiVYWKDglWCJ5Nhu8A6DyvF?=
 =?us-ascii?Q?+Z6B1I19wIkEmr1xcITFfWzMeCabN+VyyT01dIk0ZsZeVxzVWgTRQiXoN3oi?=
 =?us-ascii?Q?5h65ubWo06uqAjhEWimncXathXq5c+fqkw01tg026iTaePJKIt4Hh+nz/X86?=
 =?us-ascii?Q?KqVSfdQzsY2WZ4SaBrK6guqoD4FcQkbpbzS9QB47Lo8lRnRusgJjFH1+uWcG?=
 =?us-ascii?Q?1SJXe8a8JPU7hHjZC7DZAmTRMFSeaTw/+ljZlGnFaei9VJ5dRcrGS0D+PmNK?=
 =?us-ascii?Q?ALle5GcXfyBZp/XS/yn1y2VVafVuuyWdfqt5agyWzNft+Zf3ZAuyfWJ9BibQ?=
 =?us-ascii?Q?38aDo1z0cgrhIAQN3kSLwCMtAA1eZkt5xBiShgiiMuEUDjZ+lnvEBvQa1OzC?=
 =?us-ascii?Q?MMVTcwKwPgGAihxSGiP3rl18z5cP7xasopQY77xP1KEnCwv7cY05pGhroNRj?=
 =?us-ascii?Q?NxSA4uUQppuTSHlVKY/+Vmsk2Q49rGGSqH5afTCfB9ryppUG2Msgn9byz0fj?=
 =?us-ascii?Q?q7rAoYjd3//k570Kcg4zwmFD5P6VOLQwsg/4UJ6XqO2FgSId3GZF+E2fAAwU?=
 =?us-ascii?Q?Tsj157Ri8Ay/CkcEgdLgF6gvje8PQCWe6T9fX7Y9Fgl7k2xDuIw0dKCQzh3R?=
 =?us-ascii?Q?OS1LJ3lah8Af+aIwkY6iHdpxwjnjWiyVGv0g5W5HTnR3upAfZNeFgo2p3DuO?=
 =?us-ascii?Q?VCx9+YN38Ymfh1WroJ/7JeQofMjVkhtTobingfPOzboeFe6xpyMaZwjljooF?=
 =?us-ascii?Q?pxQ3vKLa4SwIosAAmrJlnUMI6OPjSROnZx0r9XG+VCvjkh8kdjFg73pNVFSY?=
 =?us-ascii?Q?4Zk5kdOUIIgop1SOiV2/sRvdfn8YESVl/ZF6fh0vboN3UzYO2lpKSqRfQonP?=
 =?us-ascii?Q?b2XOXpryCY0GH8chQvTeygXLafCK8sK/oEu7TwfMjLcUaOcSlta1Iq77Jv0o?=
 =?us-ascii?Q?giJtT8YBdyEv3iTK2nvWDvHQVmbnvFgnSpaMWb8r1fSBHra13cMfFt60J1vG?=
 =?us-ascii?Q?S+gziClfa/KU92Dljt/zlUBdmNIKNo6eLiNKgisH/cs55EO5fynhfjc5h/O2?=
 =?us-ascii?Q?i9omeRWQAHMhWE+jJeq7DxC67cZg//1kUPhhTMQXF3DPgmcl6f8IMlYQN+ny?=
 =?us-ascii?Q?9HQ2usI8Pt4dE1UmfZMp4AALOFYRYZqU4X00KXkfLdbJj4pZETyFUWkiQpol?=
 =?us-ascii?Q?l4/sZ/BDaL8uH9wbp2OPuNhe4qyuZt2p+Zud5MJhVuBZXcOsuHGOm/6hN+JO?=
 =?us-ascii?Q?+RXRgwpBucqbbkoMQpSq7QCq8yYWeFp8WHF9J1/xGnWHBKTFH9Am0Z70+TdK?=
 =?us-ascii?Q?3n0a+axWSO3IpMcGRYwwfrKOQqNRc0IAASuAYxPyfyft2Vc3/3cnS1diX2Pm?=
 =?us-ascii?Q?n+6+ekHcs5bPagTohRg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6d6502-2121-40d0-3957-08dc2c0d0fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 20:56:18.9947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Or+9KpHZygG/1PLvHZnPgy3k+IO8GF+GlCkEpf3H3MsZUJ1hV9o2LhHNDQQyZhV8iIcCKANoz0LkYedFGRwirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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

Ping?

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Monday, January 29, 2024 10:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
>
> This avoids queries to read registers or query the SMU for telemetry data=
 while
> the GPU is in reset. This mirrors what we already do for sysfs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a2df3025a754..d522e99c6f81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -607,6 +607,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>       int i, found, ret;
>       int ui32_size =3D sizeof(ui32);
>
> +     if (amdgpu_in_reset(adev))
> +             return -EPERM;
> +
>       if (!info->return_size || !info->return_pointer)
>               return -EINVAL;
>
> --
> 2.42.0

