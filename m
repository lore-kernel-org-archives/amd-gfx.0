Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7DAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 06:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7516D10E50B;
	Fri, 25 Feb 2022 06:34:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE9210E504
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 06:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtu+MOyEzRWYCyU21QSqLJ4cLRamdLls6NcWcstABsHSTF4GDWDFpX25SopZ/9DarHcaWPVVZO0esUZcFXFnSkHrJniuZAmFTHTCjeHznOczFr1X5hjxx3lGewbQiZI3jVx2O7l28LTXFRO4JbbR//FUhXMatysOue9JhHWuiVBaFZvbrJDfKXeOBlGpz74HxoL4x8aoM3KGU6jA+jWFy0XDW3YLS1+QjmJcU9MujjDvSwJapP33TvEBee0QPnbJjKEBIXx1OgPYLQhCKvNLHZxGMGp3jaOEF6zHQ4rdvc5X36vPAf3YCkMlO4SFlZCAMJTsfW9J5w8ModbtnMMc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX4PZwaUCu0LOPs9Wwj5yoEkZ1Z/8bfzQ0764uJOwCg=;
 b=kcS3G+YeMsrM1F5AhDD5T24LFgg9fz9lTInsvvT72p8NuNAaNgRh1U9+QWTjW2iDxvgUMpjyRfiJ99K8xMVfohTMn++/zK3JhahwzsiM+L1ci6nIaysay0yD6EiCp1CifXKuC0EdcX2NyqeaQWqao83JsUq2ri+TdE2EJSQdtLiBzqRYfGevRuq444cN2hHuggv1xddHR+wT0VcwKRR16YpdHt3c2n4FeA0UEF7n8/RQ5c4igHEmZaTUfEJVgLPIubtcQQJ/StnIucVBEGcNu8op55bm8ZF9rfhej28xsaHI/coVmo25Wkd4eZM3AkvAFEF3TFdFGdgJ8+4/8Fq/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX4PZwaUCu0LOPs9Wwj5yoEkZ1Z/8bfzQ0764uJOwCg=;
 b=DL8nCR7gEUkjFBJhzfWLmzZsVOUpO0O49pb+qLpUaIaoUxfMVxwTGf2VXy5JrTsXc8SahFbJfbux2HgzC+DADrnA+u/TpLswmZW+ETuNrg/PbcuJKFk1Ye088rAPqHBuDBpMck548rIAitw8eysWKK2vtPNko/dcaAGGn29QZQE=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 06:34:38 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 06:34:38 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 02/12] drm/amdgpu: Optimize xxx_ras_fini function of each
 ras block
Thread-Topic: [PATCH 02/12] drm/amdgpu: Optimize xxx_ras_fini function of each
 ras block
Thread-Index: AQHYJwwporIA+o+sukiwCEo9bHBcfqyj1N2w
Date: Fri, 25 Feb 2022 06:34:38 +0000
Message-ID: <DM5PR12MB17708325955A75A4C70E030FB03E9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
 <20220221101620.3269611-2-YiPeng.Chai@amd.com>
In-Reply-To: <20220221101620.3269611-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T06:34:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=229a6edf-a6b5-4387-8650-3b069283ff52;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T06:34:35Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 788cc448-55d2-43a1-95f9-146749e2affe
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 234e3c47-4d8b-4646-e338-08d9f828e5e2
x-ms-traffictypediagnostic: LV2PR12MB5823:EE_
x-microsoft-antispam-prvs: <LV2PR12MB5823C062267DB58754F6F7CBB03E9@LV2PR12MB5823.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5TuNv/DWyfGD+382vEprju6jKwdG/eqgdG++IpaGLZoziWmg7XnCz2AgCiXbAIiOTEMkZnd5mtoLIwrGOO0zXp7XDAviqNkc7mHSm/Y0jZw6tCGZ94lcyFuplRbwUYdPeY6bmMP9Pu2Z7iA54vduTn5Hq7i8bVWDgx0U+zL3YeaI4XAzXlopJg75dHjkR7RcaJjKdgAwmwER92cA+rPduFr78ulR1/ky1Yjas+zlF/4PV1xZF6EYEjsRJMgQWV0U+c2Ryy48+SUZn1E72iUfRdhS62TMU3U4GleEHFXCqxm5xEgzVAfDJo+L3Zj9VVJP8M+FvWlKmbeZsVpwpclReif2i1VDT0XzWaBCqIRRcoQqYupt9EEB8PvoXytdGIh31nwkGVUawnvsy799MrLxEp+nTn8o1qxZxFprjycS2w+TdJVQ5ayjwe8Q+rB/kCq3DVgTui2DBcnGlBFE8Lnj2obevc0+aGkLIOEMXqe0YEK9XzdWuJXYIDC1t1ImSGldRMh3wV7TpCL1iCROGnT0srkeLUC83MRjlc6YINz6Hd4kaps1l1vFxyJWfCoP3bNN/kRphrHZD44HauQMqHJ/78Xk1iKBKDYMJC6l0r6N0cxHGr6o7H37QiSlpP6d6jXqkPlLgX6PJ7uABd/VKgkfRkFE2z29GpA9BILBlYGWnWVMOzd/44r5DwOC8rHJ4Fx1vtq/oA24WOxNjT4iSIduOBtXAHmsCTdXYQk+qz9mog=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(122000001)(4326008)(38100700002)(66476007)(66446008)(66556008)(186003)(26005)(76116006)(2906002)(83380400001)(8676002)(66946007)(64756008)(52536014)(5660300002)(55016003)(33656002)(9686003)(6506007)(7696005)(86362001)(316002)(110136005)(54906003)(71200400001)(508600001)(53546011)(38070700005)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4pVbaDZZac5vAo7BDx1YIs4Lwq76C6+QZ6qSPmE7AhO27limnKkT5kgQx+wn?=
 =?us-ascii?Q?gtbMiUb7vn0ogB9ZgZ01JhUh41mocTDBRwpmSmrLHKjiminHck+fKyBA0XiQ?=
 =?us-ascii?Q?5tKXkH9nkhyeGoFGTkWypiKFkUzUnkv5IRTxpt1eeRh1UdtaebbJQVrR0UxG?=
 =?us-ascii?Q?BjccjdNXp6ScJp/OM6wKJjNmZO5FwnGVC7IKE1fbyZGx9SQeZnKAbZEWjOid?=
 =?us-ascii?Q?3YsCITNMfJ6M3SPDVl1L9th510lDtRDjNdnhtDieyagc84AAt08X4j/O6LJ9?=
 =?us-ascii?Q?OvrUwzpYTpDoqprQoMROYZKf8OQiNWWNbHx63F+xYljQYv0xUHHh05Y7QiMk?=
 =?us-ascii?Q?73NfprfuhzBgrq2RxsevePWL/wjGGmlFeS71PQ2SpuMScLvxKtOD5lHujB20?=
 =?us-ascii?Q?Sun42Hjmu1GY3YpmTJ01OZr7DIrQPcexFt1JwU4jx3bO3zZ3OmCcAcEdTgpM?=
 =?us-ascii?Q?hIjAlYqnJv5mNShCpwztmy4K37TJMbmLyblWOag47tUxiTHwviUJH/H6l+ZJ?=
 =?us-ascii?Q?MXYogn885/Sqaavjdhvc8li5vEUNfTsMPO3dJ/9u91PLQ6tGYyY2TQjP2nmW?=
 =?us-ascii?Q?gjLq+ZCcoFBqdpL7DrBmEM8cj/Nks+vkV9EVKUj/3KnybXUzzjEn6Vxv4TAB?=
 =?us-ascii?Q?61Yx6YatHgjLedPzW1IqevwhC7n1RQbkw+LICPS71B3Q6pzKxA7X0cZwzkZ1?=
 =?us-ascii?Q?GHzNR6P/DTYpo59TPaUbBtOVB6t/K59rTnWihvfD1oxwXp+vVYpxIlfqq5Pw?=
 =?us-ascii?Q?9tcYrq5APSbJpIngKJ/s4e7r0pOAZAlhKo4NgWeeM2eE12QSXT0HgU7QibV0?=
 =?us-ascii?Q?pE8lR+9tsp/WJtmhx6pNvCPqIJz6RKNW3MOpNJv89ZtW5YGr/nYCVvwKb0EI?=
 =?us-ascii?Q?pXa4Ba7nYxR+m4r6Rq2uGHwBWNAQK2Yu6/A9guUc11yz84n6t7mqHn0/2xwR?=
 =?us-ascii?Q?c2/jkQ8K5KLYiKq0CERLu1/7M+J5Tv63zOXnqUGsQ6E9GkRMa+OUWDNfZbrP?=
 =?us-ascii?Q?4LfdnIcDGD3Qgo8IJTpyxV8mETVJ3fOgChAZWNn1ASUZEfQJg2+6/DYQvQT5?=
 =?us-ascii?Q?BEI7y2ehjj6QlOhpEvqn/mtY+gST6AZv8BtEX1SY1mwm2BxGoCOajsvN1HMb?=
 =?us-ascii?Q?Lr5Xe8exnfyW6zATXX3a4OattMeVKn5St2dV0zXbOaQf+nL7lKAGj+5ZZaC6?=
 =?us-ascii?Q?hB9d+NxU+MMMcJ8ATCSTR8ncrz03GmUFlupvUizHlvTY+6IO5fW563vsUWwl?=
 =?us-ascii?Q?3veT95S75Y+3/KCoIKTg9kUmCz/Yv/tHeiXsIN90DcGZxVA7q5QNmUX1TyfU?=
 =?us-ascii?Q?uWf5sIVr1d904W0nV7jU5jcENfyuObErCN7K/JsIZVOYj79c5FUSW6bVXXSp?=
 =?us-ascii?Q?2hfrni4gPDjI3XmSKEOsFL7tiEvZpgq0wr2690IdqBW6Zak4m3AbkVmYyIvz?=
 =?us-ascii?Q?QtyTn77L6tOLwfcofsmTLE1/h/dtYWFbij2Ag2PNjRLlIcSg8+H0ssC5Kicr?=
 =?us-ascii?Q?5AEoecppPUHIGQJKyI0zEBCbMckJtb43emF84x3oETItT57XOA0+XhFEjkEI?=
 =?us-ascii?Q?iMdC18w1Y350FgAatww=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e3c47-4d8b-4646-e338-08d9f828e5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 06:34:38.7305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zvaj4iS3w74/bq1vFg6NINlS1pVTAjBWxXmvcMCE+Tcja1/5QvQ+0ddXNAPFS8Mb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, February 21, 2022 6:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 02/12] drm/amdgpu: Optimize xxx_ras_fini function of each=
 ras
> block
>=20
> 1. Move the variables of ras block instance members to
>    the top of the call to xxx_ras_fini.
[Tao] to the top of the call to xxx_ras_fini -> from specific xxx_ras_fini =
to general ras_fini call.

> 2. Function calls inside the modules only use parameters
>    passed from xxx_ras_fini instead of ras block instance
>    members.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 4 ++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 4 ++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c        | 2 +-
>  11 files changed, 21 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d020c4599433..40f7e29aa9ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -647,8 +647,8 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device
> *adev, struct ras_common_if *r  void amdgpu_gfx_ras_fini(struct
> amdgpu_device *adev, struct ras_common_if *ras_block)  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX) &&
> -			adev->gfx.ras_if)
> -		amdgpu_ras_block_late_fini(adev, adev->gfx.ras_if);
> +			ras_block)
> +		amdgpu_ras_block_late_fini(adev, ras_block);
>  }
>=20
>  int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev, diff --gi=
t
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 5dcb341cae19..4823c42e0e02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -455,16 +455,16 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device
> *adev)  void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)  {
>  	if (adev->umc.ras && adev->umc.ras->ras_block.ras_fini)
> -		adev->umc.ras->ras_block.ras_fini(adev, NULL);
> +		adev->umc.ras->ras_block.ras_fini(adev, adev->umc.ras_if);
>=20
>  	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_fini)
> -		adev->mmhub.ras->ras_block.ras_fini(adev, NULL);
> +		adev->mmhub.ras->ras_block.ras_fini(adev, adev-
> >mmhub.ras_if);
>=20
>  	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
> -		adev->gmc.xgmi.ras->ras_block.ras_fini(adev, NULL);
> +		adev->gmc.xgmi.ras->ras_block.ras_fini(adev, adev-
> >gmc.xgmi.ras_if);
>=20
>  	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_fini)
> -		adev->hdp.ras->ras_block.ras_fini(adev, NULL);
> +		adev->hdp.ras->ras_block.ras_fini(adev, adev->hdp.ras_if);
>  }
>=20
>  	/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> index 0f224e21cd55..5595f903c17a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> @@ -27,6 +27,6 @@
>  void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_i=
f
> *ras_block)  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
> -	    adev->hdp.ras_if)
> -		amdgpu_ras_block_late_fini(adev, adev->hdp.ras_if);
> +	    ras_block)
> +		amdgpu_ras_block_late_fini(adev, ras_block);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> index 6dfcedcc37fd..e7c3b8fff868 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> @@ -27,6 +27,6 @@
>  void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct
> ras_common_if *ras_block)  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)
> &&
> -			adev->mmhub.ras_if)
> -		amdgpu_ras_block_late_fini(adev, adev->mmhub.ras_if);
> +			ras_block)
> +		amdgpu_ras_block_late_fini(adev, ras_block);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index 0de2fdf31eed..54a5a15272c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -47,6 +47,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device
> *adev, struct ras_common_if *  void amdgpu_nbio_ras_fini(struct
> amdgpu_device *adev, struct ras_common_if *ras_block)  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF)
> &&
> -			adev->nbio.ras_if)
> -		amdgpu_ras_block_late_fini(adev, adev->nbio.ras_if);
> +			ras_block)
> +		amdgpu_ras_block_late_fini(adev, ras_block);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 863035a94bd8..1df8de84386d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -114,8 +114,8 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device
> *adev,  void amdgpu_sdma_ras_fini(struct amdgpu_device *adev, struct
> ras_common_if *ras_block)  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA) &&
> -			adev->sdma.ras_if)
> -		amdgpu_ras_block_late_fini(adev, adev->sdma.ras_if);
> +			ras_block)
> +		amdgpu_ras_block_late_fini(adev, ras_block);
>  }
>=20
>  int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev, diff --g=
it
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 41e976733c57..2623a2d30703 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -165,8 +165,8 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device
> *adev, struct ras_common_if *r  void amdgpu_umc_ras_fini(struct
> amdgpu_device *adev, struct ras_common_if *ras_block)  {
>  	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
> -			adev->umc.ras_if)
> -		amdgpu_ras_block_late_fini(adev, adev->umc.ras_if);
> +			ras_block)
> +		amdgpu_ras_block_late_fini(adev, ras_block);
>  }
>=20
>  int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev, diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 27421811f2f0..7d18c5d22e10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -746,8 +746,8 @@ static int amdgpu_xgmi_ras_late_init(struct
> amdgpu_device *adev, struct ras_comm  static void
> amdgpu_xgmi_ras_fini(struct amdgpu_device *adev, struct ras_common_if
> *ras_block)  {
>  	if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__XGMI_WAFL) &&
> -			adev->gmc.xgmi.ras_if)
> -		amdgpu_ras_block_late_fini(adev, adev->gmc.xgmi.ras_if);
> +			ras_block)
> +		amdgpu_ras_block_late_fini(adev, ras_block);
>  }
>=20
>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 3ecb238c6483..e8446967a4d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2433,7 +2433,7 @@ static int gfx_v9_0_sw_fini(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
>  	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_fini)
> -		adev->gfx.ras->ras_block.ras_fini(adev, NULL);
> +		adev->gfx.ras->ras_block.ras_fini(adev, adev->gfx.ras_if);
>=20
>  	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index d0a9012e53d7..222d25a0413a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1997,7 +1997,7 @@ static int sdma_v4_0_sw_fini(void *handle)
>=20
>  	if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
>  		adev->sdma.ras->ras_block.ras_fini)
> -		adev->sdma.ras->ras_block.ras_fini(adev, NULL);
> +		adev->sdma.ras->ras_block.ras_fini(adev, adev->sdma.ras_if);
>=20
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 34cd5cad7da5..0631ebd39db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1215,7 +1215,7 @@ static int soc15_common_sw_fini(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
>  	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_fini)
> -		adev->nbio.ras->ras_block.ras_fini(adev, NULL);
> +		adev->nbio.ras->ras_block.ras_fini(adev, adev->nbio.ras_if);
>=20
>  	if (adev->df.funcs &&
>  	    adev->df.funcs->sw_fini)
> --
> 2.25.1
