Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0075C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 03:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8228264F65
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 03:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8228264F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D78A06ECB9;
	Sat,  6 Mar 2021 03:55:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1066ECB9
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 03:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAGuBRmgPCStrsQ6s5OImp2DNxzD096O9ChdKtqSR/U32L6TtmO/x9Onjp9p0WI3aV/AQ7Aku70wtKCF8YdBW5KqN8VznFtVBJVp4WpV4ydez/0kQVQaPgP2leo50FZjfFYK7gJhB19gZsOqZ4U5eDvArcIHaLobhflChmzZVr1muwKIwt3uSal6doL9gE7YpDZ/nSP4VPYQCRm2Zq4GIRnyZRGyix5szNeRoKOYl/A1+HB6jc/12me2sXEOiM/ifaK5Xlwq4i3Z5eloCqlp+hBuDPGLV3KS9HOfY5+YzAOjpkPQLtceqx0tMeg84p+d20FFl8APwZSmIQm0FR8ZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1acnO0z4gM8dn8zXKPWVfudXDx6I6YT9g0HVjBYNA8=;
 b=M4JZHmB2wzlSCYJ9n0N2HU/471LvzQ3au4UPQH2YE4kG4sDW2P0HeloDB5QyTs1dXRGH2lzN3jwOwAUrJeIgkGpjissm0rxgMo6oW50zPpbxsD4xkAhYxF3uxfwImYOPYktQVL2Ie2p3bwSBDn7zPMnK1fwFO+R4c0S9NxJ9QxDi9I3UiApaWk8VZ1td2Prgo0g2lp9lVRw+zqX5lP24n2YRI19EQueQmrgJDao2VXi9K8Q8OVaCiWjrDSaeAMr9vVvGG3+TsaaFPrnPQmLdDlp8/UkF93J9iMisaY5JJKRzxtc4vHW5PrDhDvFNNaysS4pBv4l2M9l5lpFczJfDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1acnO0z4gM8dn8zXKPWVfudXDx6I6YT9g0HVjBYNA8=;
 b=whvNL38uG8kms/sTIBEo63cKYSUuahFV4Jm3KHuD0qABJRDEJ7DpQAVuJy8LC/kcFUXwhAI7E0q9P8NF16xz0abGpNHf/H6NMXLz+GqpzYhGYoYBq/VGDy4wE2ZwzQ5/TIeXe6UhwP1H+mMAVTiobiUHAtpikZWEXKV9Itbuukw=
Received: from BYAPR12MB3528.namprd12.prod.outlook.com (2603:10b6:a03:138::28)
 by BYAPR12MB3637.namprd12.prod.outlook.com (2603:10b6:a03:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Sat, 6 Mar
 2021 03:55:29 +0000
Received: from BYAPR12MB3528.namprd12.prod.outlook.com
 ([fe80::f577:7272:3619:bff9]) by BYAPR12MB3528.namprd12.prod.outlook.com
 ([fe80::f577:7272:3619:bff9%7]) with mapi id 15.20.3890.032; Sat, 6 Mar 2021
 03:55:29 +0000
From: "Jacob, Anson" <Anson.Jacob@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "lyude@redhat.com" <lyude@redhat.com>
Subject: Re: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Topic: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Index: AQHXETJFpencweKVpkuRJgG28XhCnap2BqKAgABPjw8=
Date: Sat, 6 Mar 2021 03:55:29 +0000
Message-ID: <BYAPR12MB35286D39AED12CE30E1C2253EB959@BYAPR12MB3528.namprd12.prod.outlook.com>
References: <20210304200851.4937-1-Anson.Jacob@amd.com>,
 <644d4643c1be3714ae9e7a643a528586d793dbe1.camel@redhat.com>
In-Reply-To: <644d4643c1be3714ae9e7a643a528586d793dbe1.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-06T03:55:28.800Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:4068:10:321f:c24c:644f:5aa2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c049024-b7a3-4234-49e3-08d8e053aeda
x-ms-traffictypediagnostic: BYAPR12MB3637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB363795C6C69567AC1D4DAAA5EB959@BYAPR12MB3637.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VnGsBpW2vkt3HwwX09K7/f/9SELgVUBkI79rU6A7D+f36qCnSwBneQXNPJI+kpsZ9bn8/miku6t/NAQmChGDpzvV8k8Ydh6KFdf7bN4gc+u1drHDOMdZ1gahcFOakXa8rzfshJgtscna13zqSDBeb2xuvmzvaWnIHFCc56y88SRIcxITRZLvwsMWJB+g+QCHyXz4pH0f2TL9M3Orj1wTnD8OYzzA+46s6mOEK23pm7/hOxAbHSFUZ4c6MosvDpShWFuMfuXf4V/le1G52Y/uzknte5Bq0uC7IVvmYNBhIkWWDD836upVGDpWx2bqfwSH7x//k0mN1G25sYHV7fyCMidMjx8+x0DevgUPMoWwEksit0FL9Cx5Rmg5vpbUmz5KDzJeBx2H7Iw+LpnRgJoWmJVdsiWiStuQKC2lBolblNF/+VqocWZkm2oQt8GyX9dCks7AIqLhbvPeywV8OH8gDGlnGLhhQ/XJ2lq0jOE++GpfMk+PxFHuyVtKNHg4nIMfbgVvoEkp0lbgH4gBQujfkvJxaldTzdmo1DFgwkxWw67gmMk/J/jHwaJTOi4XuHhV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3528.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(54906003)(316002)(110136005)(6506007)(45080400002)(7696005)(86362001)(8676002)(52536014)(478600001)(186003)(966005)(83380400001)(53546011)(5660300002)(66556008)(66476007)(66446008)(19627405001)(71200400001)(4326008)(64756008)(166002)(33656002)(76116006)(9686003)(55016002)(2906002)(8936002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TwbT420i6GjkEiBw3nFeZgabZ7akGfYBve44npPerrcaU9F+PByWB6vl/I4n?=
 =?us-ascii?Q?+tyZ7ek5zr4U03UovlIKwBX+ZMgh2fdXIIZsrVsQc8ZpUEpyB49+6jK2LikK?=
 =?us-ascii?Q?cYnh/fZ3IVHEvJxNS5JavWXTYeyUBg80LLumP3xZ5w/Oxb8PQd91gvEmSNAg?=
 =?us-ascii?Q?ucsd/aY3VCHpkpclz+jxNG1I9aSIcmmU5Tfuxmqwot+1JbMfnaPxo7zljDC1?=
 =?us-ascii?Q?09rIi9iH5QcA59Zs6l5wWChnjNXao3dpOtY7Pzci2esHg+wGLxicBhco3Fxj?=
 =?us-ascii?Q?+UFR/dqxlDeZZHF03V/LPDhYpvlmopMnG3eWoHh2MGum+w/f8MYOM5piww/b?=
 =?us-ascii?Q?0jUe7o8SBvrsVNE7UH3bQeDcjCC4RV81WSEZn40hABrxHTLLTCE6eopxZPqa?=
 =?us-ascii?Q?99f+eECfEwzN8l3o6YQu/GizZNwlFffhc+H+TJ7SgeEWh0DtrQOXQT7FRr04?=
 =?us-ascii?Q?NIejQRe+u2P4+76y5xnDO/1FkRr82EdiX1FDb8ogpM/xxh/jUMGpRLV5gYWh?=
 =?us-ascii?Q?yVM/Sc/My+7QKkwkA5MlTKcIf6+F9I4Ys2WdGdIJD68pQb8rccz8f5I11ArY?=
 =?us-ascii?Q?hpMBplENAH9rAcTg2/2DphN6lzkRxUjn99cf0O3yK1OQZplZTaNXhmHKzPw4?=
 =?us-ascii?Q?3UI6tB0H13/30kEb8cj9Q6bN9fvyixX6PbyZmaOyjVI5vDUiGdBh9EiemVHs?=
 =?us-ascii?Q?QviVyu012H/qPaXeU7ma9rQq2hBsPKZnrhq6qze/4MkZoZGk98JNGR0xsYrk?=
 =?us-ascii?Q?quVm3JxDLmPBcF+9XSrKADH/9asJ0WbXuz+nWzdYhiH96H+nMmgw/TJ8mV6n?=
 =?us-ascii?Q?nD+fW95yx1nQn7iJYqZjY7jCOsPpr/tz+qCEZJDsC7DtXPmvZ3hFbYJM+mlQ?=
 =?us-ascii?Q?Wj8ztcXxD2e+bcvWHoSzClF/7dbq2Sjye+7FIlFCB/GbCN3hcZDD9FyL35AN?=
 =?us-ascii?Q?F22AIzJ//4+LqzknuQ8rW6YdGSb5rVMCEwAknExvoaxdSdnp4dWTIbO8+Uab?=
 =?us-ascii?Q?3hsh+PYOtHVIxjrC3wrRUeXzJ8n4Z8FSEKhyTdrd3H1d57dJIvG/6N4pIOlP?=
 =?us-ascii?Q?56pS0xNTP+8YbLrQaXH5ly2xf9SIaAdaVmdLe03czTD36a3JQaQD6fW6JokF?=
 =?us-ascii?Q?TOBDRWdyv+2wX9O37sWToMhS2heRF0CqOyMIMdH7LpQgKRuD/oVXPoIgsLtW?=
 =?us-ascii?Q?vcniGZ63+iOuO5u6RX13UHHfcBMZ2NemaNyhAztgsv3i2dC4B2sladC0Z/sk?=
 =?us-ascii?Q?0ifDMWCYBqn9xG/N2cbNzCjzRy4bdXOh5AFi6KCKB80RkGtqdsvzJSm3iZ/b?=
 =?us-ascii?Q?F+9dKfYMUpzKGF59HCbtUDNSwV4CuzGAWAZdmCUtIoBPicOAYmIEsctBHV1v?=
 =?us-ascii?Q?nYYdwuM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c049024-b7a3-4234-49e3-08d8e053aeda
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 03:55:29.3114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyKu88UbeQVUhpbrf6wgxup1NzjcZ2vX7QlmtCa6G5aUfRhii7fY0ld0oQc1sJfxESsez7kmWPGVeqeOXCRcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Type: multipart/mixed; boundary="===============2054144420=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2054144420==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB35286D39AED12CE30E1C2253EB959BYAPR12MB3528namp_"

--_000_BYAPR12MB35286D39AED12CE30E1C2253EB959BYAPR12MB3528namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thanks Lyude for testing the patch.

Are you referring to this issue [1] ?

Is it reproducible after applying this patch as well ?

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/1473

-- Anson
________________________________
From: Lyude Paul <lyude@redhat.com>
Sent: Friday, March 5, 2021 6:08 PM
To: Jacob, Anson <Anson.Jacob@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning

Tested-by: Lyude Paul <lyude@redhat.com>

That just leaves the KASAN error from read_indirect_azalia_reg, thanks for =
the
fix!

On Thu, 2021-03-04 at 15:08 -0500, Anson Jacob wrote:
> If get_num_sdma_queues or get_num_xgmi_sdma_queues is 0, we end up
> doing a shift operation where the number of bits shifted equals
> number of bits in the operand. This behaviour is undefined.
>
> Set num_sdma_queues or num_xgmi_sdma_queues to ULLONG_MAX, if the
> count is >=3D number of bits in the operand.
>
> Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
gitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1472&amp;data=3D04%7C01%7=
Canson.jacob%40amd.com%7Ce9ea7130bcd945a194aa08d8e02ba9f8%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637505826204096667%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;s=
data=3DGEyObPt%2FnEeU9Y7K2I30RS1TBMGbbUneQ6hWkR7pJLM%3D&amp;reserved=3D0
> Reported-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c37e9c4b1fb4..e7a3c496237f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1128,6 +1128,9 @@ static int set_sched_resources(struct
> device_queue_manager *dqm)
>
>  static int initialize_cpsch(struct device_queue_manager *dqm)
>  {
> +       uint64_t num_sdma_queues;
> +       uint64_t num_xgmi_sdma_queues;
> +
>         pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
>
>         mutex_init(&dqm->lock_hidden);
> @@ -1136,8 +1139,18 @@ static int initialize_cpsch(struct device_queue_ma=
nager
> *dqm)
>         dqm->active_cp_queue_count =3D 0;
>         dqm->gws_queue_count =3D 0;
>         dqm->active_runlist =3D false;
> -       dqm->sdma_bitmap =3D ~0ULL >> (64 - get_num_sdma_queues(dqm));
> -       dqm->xgmi_sdma_bitmap =3D ~0ULL >> (64 - get_num_xgmi_sdma_queues=
(dqm));
> +
> +       num_sdma_queues =3D get_num_sdma_queues(dqm);
> +       if (num_sdma_queues >=3D BITS_PER_TYPE(dqm->sdma_bitmap))
> +               dqm->sdma_bitmap =3D ULLONG_MAX;
> +       else
> +               dqm->sdma_bitmap =3D (BIT_ULL(num_sdma_queues) - 1);
> +
> +       num_xgmi_sdma_queues =3D get_num_xgmi_sdma_queues(dqm);
> +       if (num_xgmi_sdma_queues >=3D BITS_PER_TYPE(dqm->xgmi_sdma_bitmap=
))
> +               dqm->xgmi_sdma_bitmap =3D ULLONG_MAX;
> +       else
> +               dqm->xgmi_sdma_bitmap =3D (BIT_ULL(num_xgmi_sdma_queues) =
- 1);
>
>         INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
>

--
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat

Note: I deal with a lot of emails and have a lot of bugs on my plate. If yo=
u've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to =
check
on my status. I don't bite!


--_000_BYAPR12MB35286D39AED12CE30E1C2253EB959BYAPR12MB3528namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Lyude for testing the patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Are you referring to this issue [1] ?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Is it reproducible after applying this patch as well ?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
[1]&nbsp;<a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1473" i=
d=3D"LPlnk">https://gitlab.freedesktop.org/drm/amd/-/issues/1473</a></div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
-- Anson</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lyude Paul &lt;lyude@=
redhat.com&gt;<br>
<b>Sent:</b> Friday, March 5, 2021 6:08 PM<br>
<b>To:</b> Jacob, Anson &lt;Anson.Jacob@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warni=
ng</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Tested-by: Lyude Paul &lt;lyude@redhat.com&gt;<br>
<br>
That just leaves the KASAN error from read_indirect_azalia_reg, thanks for =
the<br>
fix!<br>
<br>
On Thu, 2021-03-04 at 15:08 -0500, Anson Jacob wrote:<br>
&gt; If get_num_sdma_queues or get_num_xgmi_sdma_queues is 0, we end up<br>
&gt; doing a shift operation where the number of bits shifted equals<br>
&gt; number of bits in the operand. This behaviour is undefined.<br>
&gt; <br>
&gt; Set num_sdma_queues or num_xgmi_sdma_queues to ULLONG_MAX, if the<br>
&gt; count is &gt;=3D number of bits in the operand.<br>
&gt; <br>
&gt; Bug: <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1472&amp;am=
p;data=3D04%7C01%7Canson.jacob%40amd.com%7Ce9ea7130bcd945a194aa08d8e02ba9f8=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637505826204096667%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C3000&amp;amp;sdata=3DGEyObPt%2FnEeU9Y7K2I30RS1TBMGbbUneQ6hWkR7pJLM%=
3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.=
freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1472&amp;amp;data=3D04%7C01%7Can=
son.jacob%40amd.com%7Ce9ea7130bcd945a194aa08d8e02ba9f8%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637505826204096667%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;=
sdata=3DGEyObPt%2FnEeU9Y7K2I30RS1TBMGbbUneQ6hWkR7pJLM%3D&amp;amp;reserved=
=3D0</a><br>
&gt; Reported-by: Lyude Paul &lt;lyude@redhat.com&gt;<br>
&gt; Signed-off-by: Anson Jacob &lt;Anson.Jacob@amd.com&gt;<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;.../drm/amd/amdkfd/kfd_device_queue_manager.c&nbsp;&nbsp; | 17 +=
++++++++++++++--<br>
&gt; &nbsp;1 file changed, 15 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index c37e9c4b1fb4..e7a3c496237f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; @@ -1128,6 +1128,9 @@ static int set_sched_resources(struct<br>
&gt; device_queue_manager *dqm)<br>
&gt; &nbsp;<br>
&gt; &nbsp;static int initialize_cpsch(struct device_queue_manager *dqm)<br=
>
&gt; &nbsp;{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t num_sdma_queues;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uint64_t num_xgmi_sdma_queu=
es;<br>
&gt; +<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pr_debug(&quot;num of =
pipes: %d\n&quot;, get_pipes_per_mec(dqm));<br>
&gt; &nbsp;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mutex_init(&amp;dqm-&g=
t;lock_hidden);<br>
&gt; @@ -1136,8 +1139,18 @@ static int initialize_cpsch(struct device_queue=
_manager<br>
&gt; *dqm)<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;active_cp_queu=
e_count =3D 0;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;gws_queue_coun=
t =3D 0;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;active_runlist=
 =3D false;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;sdma_bitmap =3D ~0U=
LL &gt;&gt; (64 - get_num_sdma_queues(dqm));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dqm-&gt;xgmi_sdma_bitmap =
=3D ~0ULL &gt;&gt; (64 - get_num_xgmi_sdma_queues(dqm));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;num_sdma_queues =3D get_num=
_sdma_queues(dqm);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (num_sdma_queues &gt;=3D=
 BITS_PER_TYPE(dqm-&gt;sdma_bitmap))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;dqm-&gt;sdma_bitmap =3D ULLONG_MAX;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;dqm-&gt;sdma_bitmap =3D (BIT_ULL(num_sdma_queues) - 1)=
;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;num_xgmi_sdma_queues =3D ge=
t_num_xgmi_sdma_queues(dqm);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (num_xgmi_sdma_queues &g=
t;=3D BITS_PER_TYPE(dqm-&gt;xgmi_sdma_bitmap))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;dqm-&gt;xgmi_sdma_bitmap =3D ULLONG_MAX;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;dqm-&gt;xgmi_sdma_bitmap =3D (BIT_ULL(num_xgmi_sdma_qu=
eues) - 1);<br>
&gt; &nbsp;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;INIT_WORK(&amp;dqm-&gt=
;hw_exception_work, kfd_process_hw_exception);<br>
&gt; &nbsp;<br>
<br>
-- <br>
Sincerely,<br>
&nbsp;&nbsp; Lyude Paul (she/her)<br>
&nbsp;&nbsp; Software Engineer at Red Hat<br>
&nbsp;&nbsp; <br>
Note: I deal with a lot of emails and have a lot of bugs on my plate. If yo=
u've<br>
asked me a question, are waiting for a review/merge on a patch, etc. and I<=
br>
haven't responded in a while, please feel free to send me another email to =
check<br>
on my status. I don't bite!<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB35286D39AED12CE30E1C2253EB959BYAPR12MB3528namp_--

--===============2054144420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2054144420==--
