Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A0FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 03:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C9910ED09;
	Thu,  3 Mar 2022 03:39:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDDC10ED09
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 03:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGoVU77/cnk7YCtaC5CuYTa6K7Gw0+4eoJSmUviV2+b/aFH9AqKyHFvhsDaom7n1jCg2g64aQFkf4rgRsCOhpbwkE7aw3UUEZN6C5A5WmAII5zeSwwcwSeTtul893tFV2Oi02q77MndRFVaIT4LPDMDcB5Bo90bUmeBwAsbFBsAEVZiiBIy0z+Pz1G6vIhs6kTGWSJ/49g9MvSvg1YKwYgSRL4fgflci0iT6AIv7KZeV4DToMXgEshb/n8tPe0gdhon7zySKsQG+Dt7gyNFVksccM/LmyVjBZR9XUn9HvqQOhqTIXb4S913jh7FsnrP9MfPCxnp6cWoCiVuJZc/Ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Y8UFusUMRPyGqXFkyHopxVaCW/EVG0Di4kGktqJjE=;
 b=LsXf8xbqgUZIrgfpQhqpwvOW+8Gja9RTwF4ecdMXyuEh4h1nkpBV3PIo1c/79e632uoZf887ai9fGV+xncjFf0Jmu35dStAX4h4saT9QATvnkajmRZfTpkeRP2R1FLLpxd5zEybZ5pjAbT01/Qme/coWWFFzkuJhQoRqfW7APn4eG+BsGSWMPCPfkHsJZbKCxpcqZZwxdbClIgELn5PgtQIPMi6f0vNh8nkdzLkUYkzobOkho9SljMh64KstXgjOVblzb5dT0Q25LyvFyFsMxwA6MtoxAj9U90OiTo4oZZBy/kyU5i1faMhthAEzSIYxkQ3slsXxAxifI2LPl9NuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Y8UFusUMRPyGqXFkyHopxVaCW/EVG0Di4kGktqJjE=;
 b=CTXiIRKm3xVg+DdGhSmxmtvsVwCEzRJZTsPhU+Ge2SK+YQklKPeD/dYiTvExvr0MGq49F1tlqsToTsswtOec+SiMqM/yW94gXYYy39OtpTkgJIKzNbGBFKEv4uiOBFZT9N9M1vcGUAZVBjFJF8yuGZ6ssCZbb0qJxzcxsfjMM2Q=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 03:39:34 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::296a:42ec:a1e2:7f0]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::296a:42ec:a1e2:7f0%8]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 03:39:34 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
Thread-Topic: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
Thread-Index: AQHYLImpNng3uP8a1kS2Zon/Z2yPUqytBb2AgAABVVA=
Date: Thu, 3 Mar 2022 03:39:34 +0000
Message-ID: <PH0PR12MB5404ADB6408D87845EA1C180F6049@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20220228095723.721786-1-lijo.lazar@amd.com>
 <BYAPR12MB4614485194DEB2361556B60C97049@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614485194DEB2361556B60C97049@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-03T03:33:00Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d1fe6b42-0ecc-46d0-aecd-3d383d99d3ef;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3741f31-f7ae-4b7f-e99b-08d9fcc76f6f
x-ms-traffictypediagnostic: DS7PR12MB5744:EE_
x-microsoft-antispam-prvs: <DS7PR12MB574443BAA8DB157AC94B8C4CF6049@DS7PR12MB5744.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0FZEF4InZkbvGRifPnN1u7Lj2XXdRo+kZSMoo054wOsiBWd+8tRZPCOjxw2RQ7CsA4AYCtKXPjO6dhdi1PRKJhRkvpVFLe8xx8IIxyNOm4b860D1KNrZq5iXUsZwDvhJSllKYkEushyRu0PnXVj1FUTow47CjcFf4Zo+NxEatGvib0vLvlSpMULxMZMcDgF4icx+5a0xlLp2bMzHbMIGS5WrvfcY4MrwRZoC5MRJHZvE8bbHIoHff85SkZzZ7Ze9bpERRnVKLsuYXMa7WtyevCxRkIFwsd7A2ZpY/aeHfj+K+Qm8At+sVVW/a/bMuC/rzNlynyuL1NqvpplGzrBzbwyN0xmod+RKmSzD+ySJyfViJkaJoRJ2Vvb/Ya/88f9vOQWKJSP35JqCJ4XoJ/NRHaYWKOQq7HadomzVxm+Eys6arRCaG81jpcOB8xsrm3jQvb/nk3pRzWQl6HAHEWlmmRwBWuf6goFzJq+lH3a5mqfSn5VNszq/JxdzjHmqJ5Gwc7Nv9fJ6qsXjb4eEHVoEiovU1kTCjtoz1r+dzeRQBS31h3dbJ/KiDf6Z+qwREyc9y1R3b1OeqwgtFLS6b/4k1iOVO3LCGTAI/bs31JAXiRjae6pNpnTj6WBnLejHRs7T/UohJdvy2+tTo7rkJ8N2Z+/YJTzhE1q34Zfs94gwWJ/wuU6N6Z0u9M3V3MJOEn0W/tw+JylpXiuTPWEtGocLDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(66476007)(33656002)(8676002)(76116006)(38070700005)(4326008)(66946007)(66446008)(64756008)(110136005)(508600001)(54906003)(316002)(8936002)(52536014)(83380400001)(66556008)(5660300002)(86362001)(186003)(26005)(9686003)(2906002)(55016003)(122000001)(7696005)(38100700002)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MQTERaE4JGWtfqlcOVNsQCK8XgnMmU6yhHMkrp+ibm5XXCFCW2OaRwsVY25s?=
 =?us-ascii?Q?Y32lQweUF9lablMmEJrFx9Ae2xiB3yk2iW+kjPJrVnkQ2GFuFtq68m1tw9T5?=
 =?us-ascii?Q?sxWR+KN0PpsgvmExPwCRl6bP5VbQQiLkWsJg/sKFx9f68iBs/35jQfWgzqoG?=
 =?us-ascii?Q?U6auuu5e3TZqleg1UMvkglXlCF04IapU5j/3RcMVQOJnMs3SV6MHpElYS+/M?=
 =?us-ascii?Q?lCerusuCBdPS+68jPOzg0X27xr8/gpZ6OLgvJIXXQ/Iv2jHpkgKRHAAa5SLy?=
 =?us-ascii?Q?wNgAwARnhcuc0Ck4LPCr6bnqyZtQvhFUD7QNDuRDaSqeHsxZ8SZ3V+atjeAd?=
 =?us-ascii?Q?Ak6s6M+6mt2GA8S0Vt6PEv7xnJ+nxepNkmXxDMSW2YDMpgnHcQcx2ngyRfk6?=
 =?us-ascii?Q?06Oqu1M5DVPpZBWiu29325zYQ8+iX5P3CihCiqtPlALzO9zrXrGymkykyon0?=
 =?us-ascii?Q?wf07GVK0oKdYlqzV7XQ5/1IWSowsh/XGqpZAVTWxxwbAVO11m7pk7FSAkEtl?=
 =?us-ascii?Q?l5JxafOO03RnXYeUz2GcjLJ/g17UojUEKaYwalz6xLQYsCzpYdUfRZMOo9kt?=
 =?us-ascii?Q?BKe5mSW79W9OaKDUHfy3+0KlWicRq0Vwc4z621lMYAkCXoiY5ckn2q4eTOQx?=
 =?us-ascii?Q?sgcURucaVIrZZ+kVMnDZFBbv5RTCD7pAthDMHjdBrx+FGxS2GM8IzX8nxB20?=
 =?us-ascii?Q?qQZluDiXYjYQ7tGH/+rGhIvdeoIbpn16kcVPB8YaAx9Fdq6AGkK9XORbDdjA?=
 =?us-ascii?Q?cCkmcdMhTVbqvO8RTnIE489NXtf57OnTDk/arbw/XuWZetNOZBc9lbo3jeOS?=
 =?us-ascii?Q?eOKo4lWe9gLRNn9LmK8QqpzMwhA4KU+9pgvLGxNLpBlb4detRYWkRurgeLu6?=
 =?us-ascii?Q?hMEVa7/SgQVkCgAt3GPXOD0GG9ZfJ0a3n9WUNyCHPbmfJ3oFVreikXOPCy/I?=
 =?us-ascii?Q?9I9U0gN7SaJxJVRfpvHq3qpl2/XtBYQ94awcKM3/aP4vwy7iZMImRIXBmXH3?=
 =?us-ascii?Q?qGwjQvg00eMk+6FP5CItmp1VOL3k/Bd8d8KyveLGHJXxhrzrxt2+dbuKJCpJ?=
 =?us-ascii?Q?GPd2njXNq11U4lHjFt8uAhgmLHiPPtG1nCmeqjDQ6jT4CKvLYBYs624XA519?=
 =?us-ascii?Q?qfbZhKFzp11jcIuMPeGCSE7wXwvU+wQ3Ly/MSCkUCGuLhGux3UebIyAmS+f7?=
 =?us-ascii?Q?39YKf4sWO5eBxBjFMlLeTfIMuQ3va3tbwWEDk7gbGQ2UmQZLY8+6vtgCmCmM?=
 =?us-ascii?Q?CYsz/S5ck767JftCG3tCj1MDTCrUsoUQe/E/AQZTkg9X0/HnrQ8H6Z1YyGhw?=
 =?us-ascii?Q?Y6Xb8ioKPcDHAoNlcOks4buEMXZkvOk5CYQaqpGR75FgQbyAD+gsL/rLnVij?=
 =?us-ascii?Q?o5OAEjQlGIvFQgpAlItCkqw8xL0wjBWXbVJkRsFQb/NZPdmk+RGevJvDIYRj?=
 =?us-ascii?Q?V4OAVmwHj1JANzzDAFrrezLMB0a45Tz1g7gSaB6wb4xjFzwWO+83MvpybSnB?=
 =?us-ascii?Q?ZvBsnKzf4iIwNYY/p9U71rOW6EWdCMrWYTvdLBnnzWBb/GQWxIB2uOasFBGa?=
 =?us-ascii?Q?vqDrXxkOk7n3XWGQVTU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3741f31-f7ae-4b7f-e99b-08d9fcc76f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 03:39:34.6983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+48sO2a/JMiKJsllm+W9NYWHFYsLpqbWmSrkP+aapLBhc7+8PpIOI/6xNksmHo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Le Ma <Le.Ma@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar,
> Lijo
> Sent: Thursday, March 3, 2022 11:33 AM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
>=20
> [Public]
>=20
> <Ping>
>=20
> Thanks,
> Lijo
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Monday, February 28, 2022 3:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
>=20
> Use IP version and refactor reset logic to apply to a list of devices.
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c    | 66 +++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  8 +--
>  2 files changed, 54 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index a545df4efce1..c6cc493a5486 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -31,6 +31,17 @@
>  #include "amdgpu_psp.h"
>  #include "amdgpu_xgmi.h"
>=20
> +static bool aldebaran_is_mode2_default(struct amdgpu_reset_control
> +*reset_ctl) {
> +	struct amdgpu_device *adev =3D (struct amdgpu_device
> +*)reset_ctl->handle;
> +
> +	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
> +	     adev->gmc.xgmi.connected_to_cpu))
> +		return true;
> +
> +	return false;
> +}
> +
>  static struct amdgpu_reset_handler *
>  aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
>  			    struct amdgpu_reset_context *reset_context) @@ -
> 48,7 +59,7 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control
> *reset_ctl,
>  		}
>  	}
>=20
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (aldebaran_is_mode2_default(reset_ctl)) {
>  		list_for_each_entry(handler, &reset_ctl->reset_handlers,
>  				     handler_list) {
>  			if (handler->reset_method =3D=3D
> AMD_RESET_METHOD_MODE2) { @@ -136,18 +147,31 @@ static int
> aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
>  			      struct amdgpu_reset_context *reset_context)  {
> -	struct amdgpu_device *tmp_adev =3D NULL;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl-
> >handle;
> +	struct amdgpu_device *tmp_adev =3D NULL;
> +	struct list_head reset_device_list;
>  	int r =3D 0;
>=20
>  	dev_dbg(adev->dev, "aldebaran perform hw reset\n");
> -	if (reset_context->hive =3D=3D NULL) {
> +	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
> +	    reset_context->hive =3D=3D NULL) {
>  		/* Wrong context, return error */
>  		return -EINVAL;
>  	}
>=20
> -	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
> -			     gmc.xgmi.head) {
> +	INIT_LIST_HEAD(&reset_device_list);
> +	if (reset_context->hive) {
> +		list_for_each_entry (tmp_adev,
> +				     &reset_context->hive->device_list,
> +				     gmc.xgmi.head)
> +			list_add_tail(&tmp_adev->reset_list,
> +				      &reset_device_list);
> +	} else {
> +		list_add_tail(&reset_context->reset_req_dev->reset_list,
> +			      &reset_device_list);
> +	}
> +
> +	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
>  		mutex_lock(&tmp_adev->reset_cntl->reset_lock);
>  		tmp_adev->reset_cntl->active_reset =3D
> AMD_RESET_METHOD_MODE2;
>  	}
> @@ -155,8 +179,7 @@ aldebaran_mode2_perform_reset(struct
> amdgpu_reset_control *reset_ctl,
>  	 * Mode2 reset doesn't need any sync between nodes in XGMI hive,
> instead launch
>  	 * them together so that they can be completed asynchronously on
> multiple nodes
>  	 */
> -	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
> -			     gmc.xgmi.head) {
> +	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
>  		/* For XGMI run all resets in parallel to speed up the process */
>  		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>  			if (!queue_work(system_unbound_wq,
> @@ -174,9 +197,7 @@ aldebaran_mode2_perform_reset(struct
> amdgpu_reset_control *reset_ctl,
>=20
>  	/* For XGMI wait for all resets to complete before proceed */
>  	if (!r) {
> -		list_for_each_entry(tmp_adev,
> -				     &reset_context->hive->device_list,
> -				     gmc.xgmi.head) {
> +		list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
>  			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>  				flush_work(&tmp_adev->reset_cntl-
> >reset_work);
>  				r =3D tmp_adev->asic_reset_res;
> @@ -186,8 +207,7 @@ aldebaran_mode2_perform_reset(struct
> amdgpu_reset_control *reset_ctl,
>  		}
>  	}
>=20
> -	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
> -			     gmc.xgmi.head) {
> +	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
>  		mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
>  		tmp_adev->reset_cntl->active_reset =3D
> AMD_RESET_METHOD_NONE;
>  	}
> @@ -319,16 +339,30 @@ static int
>  aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl=
,
>  				  struct amdgpu_reset_context *reset_context)
> {
> -	int r;
>  	struct amdgpu_device *tmp_adev =3D NULL;
> +	struct list_head reset_device_list;
> +	int r;
>=20
> -	if (reset_context->hive =3D=3D NULL) {
> +	if (reset_context->reset_req_dev->ip_versions[MP1_HWIP][0] =3D=3D
> +		    IP_VERSION(13, 0, 2) &&
> +	    reset_context->hive =3D=3D NULL) {
>  		/* Wrong context, return error */
>  		return -EINVAL;
>  	}
>=20
> -	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
> -			     gmc.xgmi.head) {
> +	INIT_LIST_HEAD(&reset_device_list);
> +	if (reset_context->hive) {
> +		list_for_each_entry (tmp_adev,
> +				     &reset_context->hive->device_list,
> +				     gmc.xgmi.head)
> +			list_add_tail(&tmp_adev->reset_list,
> +				      &reset_device_list);
> +	} else {
> +		list_add_tail(&reset_context->reset_req_dev->reset_list,
> +			      &reset_device_list);
> +	}
> +
> +	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
>  		dev_info(tmp_adev->dev,
>  			 "GPU reset succeeded, trying to resume\n");
>  		r =3D aldebaran_mode2_restore_ip(tmp_adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 02afd4115675..e9b9ce80f7d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -36,8 +36,8 @@ int amdgpu_reset_init(struct amdgpu_device *adev)  {
>  	int ret =3D 0;
>=20
> -	switch (adev->asic_type) {
> -	case CHIP_ALDEBARAN:
> +	switch (adev->ip_versions[MP1_HWIP][0]) {
> +	case IP_VERSION(13, 0, 2):
>  		ret =3D aldebaran_reset_init(adev);
>  		break;
>  	default:
> @@ -51,8 +51,8 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)  {
>  	int ret =3D 0;
>=20
> -	switch (adev->asic_type) {
> -	case CHIP_ALDEBARAN:
> +	switch (adev->ip_versions[MP1_HWIP][0]) {
> +	case IP_VERSION(13, 0, 2):
>  		ret =3D aldebaran_reset_fini(adev);
>  		break;
>  	default:
> --
> 2.25.1
