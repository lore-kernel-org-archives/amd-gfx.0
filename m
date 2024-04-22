Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B92DC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 08:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA1A11288F;
	Mon, 22 Apr 2024 08:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZWVjqaEa";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9918511288F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 08:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2h9/ehZ4sNCgngw1NftsymDU/kH010UYAsl3wVXhqh/Lr1x+2A6PC7RS16QXzECkeCX6xbpP0IDHSBilI0PuuZQk0jNYC5xd5dNgGFimnKhktUO6lW5nfeXAV5iCxCWY4GrDiCoDrZAlZtFWJ6gt5aZAscocJbtzcKAztCdrTIGadTJoz9KklgQ/IBUEjbuqHXDumZGprtVcH8mMwGO9k/VqbJ430VSqtciqM45LwUUw8CepmXg3HR2VhTBPZWY6mXRPa42yEIMX1dIZ6XtLVpMVar71JsTu4LrGiyCJHKKRVAmEtDVMOjroL5wkNba1ayiQh7o1a0WlwP7xG1gEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQhBOqnbodMhkNN0CEoz7/TqN5nNZvBxlKv4L3PhA2g=;
 b=cCUfZIbSfIUMlZnGm6oWG3cs4DacuMffvCjnAU7JMIv0N3cd38J2pxaWJSUM5niQSlwdo0fpFi2ZKfm+RnsxX5kd3o4TF71jvQjCfFYXnCXJtpvcfWW6gCu6TcB799JMp0qcj1/0SjSkUBteoHKVZfvZxVZ2gaWWvHEfq9hx82AR45MpGl8T5/k1Uuukz9r935J3EvebyPkqdVltgRfLvoc4QGVqGQcBEjUcsXmjCy4BMroR2SQbob8z69apxHwVup62gStZ+dkAidv0+fKhispwmfbQP5/1k2VusNW4DUXCzbDJ4Rz0ZIZ4mlTf35c8Z/uFNn1+jHo7kIHk2wfYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQhBOqnbodMhkNN0CEoz7/TqN5nNZvBxlKv4L3PhA2g=;
 b=ZWVjqaEahaVJUB2K12efBiHfrgFXMCWjnzgqSGxCgCwvVfneq7W7KsZ3xWlMXCmBpCEWmNpnCFHv63jJRyPI1vqdC99znj36TYzqpZw8GUzYBHbRdYyCgAUXqTA43RVf/s+LqIOnRvNEQrFIhHn9W4l9a3wGq/gd+Z38HkeI7VM=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 08:14:02 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 08:14:02 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
Thread-Topic: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
Thread-Index: AQHakTzIYPO8u4GCEUqoSc3aRUP457Fz9yjQ
Date: Mon, 22 Apr 2024 08:14:02 +0000
Message-ID: <PH7PR12MB8796BA85309CCBC954A8ACA8B0122@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-10-YiPeng.Chai@amd.com>
In-Reply-To: <20240418025836.170106-10-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c585f23d-7ab8-43dd-82ea-5f594246e3c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-22T08:12:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MN2PR12MB4048:EE_
x-ms-office365-filtering-correlation-id: ae717ac5-6a20-411f-c9f2-08dc62a42ba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?iHS4SL9B6zraCifCNHd2d35wC8NCwOggWYwgKuZ9+Ih/as7kQVdVpgALA1dC?=
 =?us-ascii?Q?8iYJXc+R4u3tu0bUIdSauwgFOgwzrfPFig4DlXardhL1jlle5x8W+/jp5W3v?=
 =?us-ascii?Q?LD5idBp234IxAMDnMMylAs/HhCtp0J/ipQf+bHd+d3ybUai6L6QNYaxalpcW?=
 =?us-ascii?Q?HbaEpssJB878hLrVeJeDFISt1gvTK4nQRiZyCt9TtDFj8qyMqJfQjMM0FrIl?=
 =?us-ascii?Q?1/5LmqxHSG89ErP7wWHq/G918TsePi/g0tAQtfh492SVPxjJ1pvnqcPXFzOm?=
 =?us-ascii?Q?JToYHkUFX6PP2JHRFIae9nfe8cQ2waJpcbPuV0vUP2sX+mPBAxPNOG0tsikL?=
 =?us-ascii?Q?Q12JoJ3KOymr3xxx0UA97QSv4Z95OGzDmTbFBqyVYE9Y15+0MGjRdVQleXIr?=
 =?us-ascii?Q?eVdhair/IeRZPcEbKK7rfEYzQEsTfvBwOouOo52JYqln6W0XRzPZFa8QUsHN?=
 =?us-ascii?Q?LRNs8/YEGyu4BGQUfTyapPQHHyEbBR2hLLYv98o9WIwH8TRFPMiCJefWyUQa?=
 =?us-ascii?Q?UoX9RZBxZxBr2k88VeqXt6sIAuSVgk3UPWvQfuemLqG0bNiVXR6Jc+rxHVBs?=
 =?us-ascii?Q?MOl0QRY+vp+/HCLQAE/+HYSLiiPxzUhnd/dvl/aYkMbExH9GgwihXkTwML32?=
 =?us-ascii?Q?JqF+YUix8VhvhUTThtxu189CMpYUM/gns8t2APplZqCPwYVEgztIO5l0tPKN?=
 =?us-ascii?Q?qN4rLpJWLHe9qlEdkS88/B1i0LTcP92aQevxzzp6ugtYGab0OcPW/WUWQgKP?=
 =?us-ascii?Q?dIyyn2Q/vh8tveO0jv+mGzonVhrlkg4Ve/tuoStxjpat6qXOLMIEMARuxqjS?=
 =?us-ascii?Q?xsRSNKJHV71MIYPJGVwFICF0oQAZASpwhaQgUcsvj9Ck0Ny64jJGX0yMb4aF?=
 =?us-ascii?Q?hM1huqEGKN+OQEcX+Lse+KGppLRLL/ZGbpiaV9JAy08Rebqs7eQ1jEqvMiZb?=
 =?us-ascii?Q?4A1F0VGXpk6YncMCqPQtgBIpup3lwnMONsIQnEdzs4Gh6aBpli8aDXsSSdc9?=
 =?us-ascii?Q?kOWQjOSxuf70lS4ZnoocQXho6jM6L5c0M6oMU8w6NtJbubFK+yoE96QgLo5l?=
 =?us-ascii?Q?R1m1obd3aOKuBce+cHKwMyDdQLGk6qaV7mwGOhiLdK8Nb+dFc3PZois0KmNI?=
 =?us-ascii?Q?jetLMOcpP4Jb9gug1SthlJAhKBy1Kf1NwVaqeLTIKdivUHtOypyHuQCvS++n?=
 =?us-ascii?Q?DkKdbETRZ1fZeW4p/bEEpQuEw+vINcoDDDQOijw+HqFN3I0zG8o72yDc2WuN?=
 =?us-ascii?Q?pTEeiGcyoXpFG2GhE2rtPvFOi/cfqyboDvt1o2OpURBsucqg9YbHAypCTgJM?=
 =?us-ascii?Q?xlCKe9grKGvGQxHb1c/VQGYz3SXEXj5KvsTADJ4IweOmKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KJVQYK102dDZ45ZJX+fIxV0pbrnibRLVJ+OTTsMRWcr0MWy2Fn/ogTS8E+UA?=
 =?us-ascii?Q?RzcTVg4cqjsWtPnVCvFzTQnyvqjZ97ag2PHWaJ3aSIQWXWDawp8QP1nTA1QR?=
 =?us-ascii?Q?ztEN3e0rIu/9lZgo7MzdqgFKgrADGuJ1X9of0MRG737TrK1EfSGH/SMmQar2?=
 =?us-ascii?Q?SdoOmyPrKj7FwRNuFgTLPRdMfrc+mrsVPX5Xu/qlzgbjFPuW1vXPLT9MwTIR?=
 =?us-ascii?Q?uoVX/+fGRTLl8RJSgSTBLW+Tdp2ekF5eb3wC/r2vPI3P+pLI4O7oL7end+H+?=
 =?us-ascii?Q?y8ssRv0Ha33NkzihSyoaG8Td3Kq9qG5Q9H1bJlKfrDv2e9N2855QLFsGeDH4?=
 =?us-ascii?Q?G0nkz9qGZrS6H1j3OcuZ/wcBuiNmM1Pqop0nx0tazf+0gsIssVnSXfRYbUwb?=
 =?us-ascii?Q?zY5iXZDrZmdRsVQJBchz4anyAyf5sugy8mfNUJ9RO6tLCNusTFKfDvGhzAIJ?=
 =?us-ascii?Q?ZGYNnQus5ZvfljcPpEb0GkGGJiNQ0ipy6D6VvMBIQx+Hi/3ghOLIYiqFXcI8?=
 =?us-ascii?Q?he2rQGVsLs6Dnjl+aAXpdXmVifcmh/O5weliC00Ywmp2YYX3sHWa1l2CUD6n?=
 =?us-ascii?Q?NWSKHFwWaOxCHmEfRLW21I39WD/seenOUNR/Bst47qkUZJ6dXmcGSRCxHOO9?=
 =?us-ascii?Q?NNWhrkQw07m2ObQ6u0fzAzcAqjQSYSZfebC0PZxU1Uo/4D8hx9fSDv+YPAj0?=
 =?us-ascii?Q?yI1xU2NwMoD8uI+X+kB1kVt/7txdqFnNQbimKBUEcBC5L/rnVhtkhvSdqdVj?=
 =?us-ascii?Q?ycyERPB+ysvQEtPtZJDH1pS26neZ+pAy6hNFaEergpIayvjQTHrcKahy03Jn?=
 =?us-ascii?Q?5GA8kqUcy5DlooHG3wsfhASswTW+92GjKI4kx1iGzwVVNN7kEbg/0CwEw0nf?=
 =?us-ascii?Q?nVrr7JyYROHH8oP7TndGqgo7r62FMtY2hv+2PwPAOD+RC8PkOfJpmjhmr1S1?=
 =?us-ascii?Q?V9Ii2AQKke1yi3Hk21+EXFHoy1ecc2w2oQAaSlGATxBCFCCaYdNh0kkwiaq4?=
 =?us-ascii?Q?2w3Iz2hrERLNts9rP3j7OaDELyVhmUkyjV/SCNwBTYL/Q9EGe1OAb90x3yh4?=
 =?us-ascii?Q?nP463gukUnV8k5/GYKpFwHqr3f4brAVkWd5x1r+SIkWiXja4k/s+yynXN80P?=
 =?us-ascii?Q?3gxDRSLvTjSbntJCbkgP9XBPSQ4j8Lb4DnvDuFMXCu3f3o9uxI3oUO7GmteW?=
 =?us-ascii?Q?xs9MxFH5yivZuMBeB5cnVdl2jhzxjzmGJUi6fKXimu95Nzedvq6gE/xGPlJt?=
 =?us-ascii?Q?4Y/MfWEQUjZlNpj+dPVBMR6HDxfJ828m2qS7j89l/QrpZLcpP0ffk72VCTjR?=
 =?us-ascii?Q?FsFPos9CEDEJXGAI0YefdqUdPFr9MeUYT0cN5ygv6mv+FKpU4aXVMQdu1jw6?=
 =?us-ascii?Q?SdLNbhTD14DSXft3HQWh5uNMrrA6ESjSyWxXIOd9tHMnb04XDSZEO6u1f1WF?=
 =?us-ascii?Q?hl2z+f/9kNSayyQURTtuUHcFYYmy4QrylyQlvdLKykxr9XIvItJG3n8I8YhA?=
 =?us-ascii?Q?MkzHAE9ElIWBUbUnr9AJqwurQVl5Dt2KONRT7JVT20IFeQPvL2e7SExuuOWR?=
 =?us-ascii?Q?UL98E2vIYGXDX3KlYlg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae717ac5-6a20-411f-c9f2-08dc62a42ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 08:14:02.5365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqcIaFOuCol9HDGQFQ6e/1Rx2+5vu6cvCbT6YuTR/ktUA5x2XNtmuhvwUgBQYu8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, April 18, 2024 10:59 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
>
> Retire bad pages for umc v12_0.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57
> +++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 6c2b61ef5b57..bd917eb6ea24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -28,6 +28,8 @@
>  #include "umc/umc_12_0_0_sh_mask.h"
>  #include "mp/mp_13_0_6_sh_mask.h"
>
> +#define MAX_ECC_NUM_PER_RETIREMENT  16

[Tao] we already have UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL for the purposes

> +
>  static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *ad=
ev,
>                                           uint32_t node_inst,
>                                           uint32_t umc_inst,
> @@ -633,6 +635,58 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> +static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
> +                             struct ras_ecc_err *ecc_err, void
> *ras_error_status) {
> +     struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
> +     uint32_t i =3D 0;
> +     int ret =3D 0;
> +
> +     if (!err_data || !ecc_err)
> +             return -EINVAL;
> +
> +     for (i =3D 0; i < ecc_err->err_pages.count; i++) {
> +             ret =3D amdgpu_umc_fill_error_record(err_data,
> +                             ecc_err->addr,
> +                             ecc_err->err_pages.pfn[i] <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             MCA_IPID_2_UMC_CH(ecc_err->ipid),
> +                             MCA_IPID_2_UMC_INST(ecc_err->ipid));
> +             if (ret)
> +                     break;
> +     }
> +
> +     err_data->de_count++;
> +
> +     return ret;
> +}
> +
> +static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
> +                                     void *ras_error_status)
> +{
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     struct ras_ecc_err *entries[MAX_ECC_NUM_PER_RETIREMENT];
> +     struct radix_tree_root *ecc_tree;
> +     int new_detected, ret, i;
> +
> +     ecc_tree =3D &con->umc_ecc_log.de_page_tree;
> +
> +     mutex_lock(&con->umc_ecc_log.lock);
> +     new_detected =3D radix_tree_gang_lookup_tag(ecc_tree, (void **)entr=
ies,
> +                     0, ARRAY_SIZE(entries),
> UMC_ECC_NEW_DETECTED_TAG);
> +     for (i =3D 0; i < new_detected; i++) {
> +             if (!entries[i])
> +                     continue;
> +
> +             ret =3D umc_v12_0_fill_error_record(adev, entries[i],
> ras_error_status);
> +             if (ret) {
> +                     dev_err(adev->dev, "Fail to fill umc error record,
> ret:%d\n", ret);
> +                     break;
> +             }
> +             radix_tree_tag_clear(ecc_tree, entries[i]->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> +     }
> +     mutex_unlock(&con->umc_ecc_log.lock);
> +}
> +
>  struct amdgpu_umc_ras umc_v12_0_ras =3D {
>       .ras_block =3D {
>               .hw_ops =3D &umc_v12_0_ras_hw_ops,
> @@ -640,8 +694,7 @@ struct amdgpu_umc_ras umc_v12_0_ras =3D {
>       },
>       .err_cnt_init =3D umc_v12_0_err_cnt_init,
>       .query_ras_poison_mode =3D umc_v12_0_query_ras_poison_mode,
> -     .ecc_info_query_ras_error_count =3D
> umc_v12_0_ecc_info_query_ras_error_count,
> -     .ecc_info_query_ras_error_address =3D
> umc_v12_0_ecc_info_query_ras_error_address,
> +     .ecc_info_query_ras_error_address =3D
> umc_v12_0_query_ras_ecc_err_addr,
>       .check_ecc_err_status =3D umc_v12_0_check_ecc_err_status,
>       .update_ecc_status =3D umc_v12_0_update_ecc_status,  };
> --
> 2.34.1

