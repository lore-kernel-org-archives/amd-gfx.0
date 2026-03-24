Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5693DF532C6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 02:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C915710E087;
	Tue, 24 Mar 2026 02:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j6PFhqnl";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F9410E087
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 02:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYBxZgSBnpd+inHYB/U6WzncQ6w47wHZKcBDm962Vb/METUqCPk9jJ/PS+oTWSjpuze6LWkSZEIgspcH1DBdWJgBgg95N6WoP3tGxRhUPtUYWgpiP8XnhWxQtGXwJRpQe1ySzgz4i8wZ5olGq0JcCn3H8usucO10VgSRxRSV6JsyFTQSrDE9ixjJscgAYMjbK1bSYiovF3QTq1oAys3ftzA0O228YLCSh+8geCBV+A8fOGXZn0BV440fQkh/ucjhlPU+pjp91xuIZRoM65JzvyRhJTM1Ahx6uUoWa3D+rhpX18HnyirURpkGHbVbyK1jIDMWwrmxp5XxtDJf8CJq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Vm/2WpBLkrnRXPLSg3MsQTGtgAiD6rdRPTCkDA59/g=;
 b=zSsVLlV0RCKYIkftdFDsrn6I5n7taigzfBPIlsus1HfSDxaQa2/8oNBUTGhaQ06LisTR9957YE4AxbxxRJOgqaR+aa/T6beiRQOCvQuBCBKOufZ+V5bc0/ZK0WW9HtmVJg9cgA51BC61eagW9fqbiD699s8zUZgy14mzmDpdj+I/qnMSoQ7fKPCTxHpSJclIK4eC6DcBjdz37fLouhLa0MmcxkZx6sM0RpF9C9TjUtEC1CK8PNfygfNId9ya6+bFcJtsrvliIBcI9vBhmCsuwtBdI6SB16UgeHdb7xF0bj92IlOsL4Y2uyDDO+IF4Cj11lEp8y8DYYIrndY7RM28ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vm/2WpBLkrnRXPLSg3MsQTGtgAiD6rdRPTCkDA59/g=;
 b=j6PFhqnlE1eNxZrycwpwJsliETEcyq4+4bqbjriK8LAUPI/wOU0iLTtjPwqfYPeRL4n//bz4She4AKbnC5OMYknYng4GCwBBRAcPfcMCF59okQBR+7K+qdRfXCIDkIWCKAXWrWgvi9D52JWAthAh2d9k6TGq91ghldHJlbNX3fw=
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 02:10:48 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 02:10:48 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add support to query vram info from firmware
Thread-Topic: [PATCH] drm/amdgpu: add support to query vram info from firmware
Thread-Index: AQHcupvmf2RMdoHIIkKTRCtuqonotbW8Po2AgACr0QCAAAZM1Q==
Date: Tue, 24 Mar 2026 02:10:48 +0000
Message-ID: <SA0PR12MB709106264AF3B6409DA874D79748A@SA0PR12MB7091.namprd12.prod.outlook.com>
References: <20260323080525.1877204-1-ganglxie@amd.com>
 <67393c4d-b08f-4e73-aaea-1cb129ce1515@amd.com>
 <BYAPR12MB259783B70F97FEBD17AC9CADE548A@BYAPR12MB2597.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB259783B70F97FEBD17AC9CADE548A@BYAPR12MB2597.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-24T02:07:37.4545603Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7091:EE_|BL3PR12MB6620:EE_
x-ms-office365-filtering-correlation-id: a5cae685-fef7-421f-6cde-08de894a90d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|7053199007|18002099003|8096899003;
x-microsoft-antispam-message-info: T2IV7ca03SdjasOrzKzHBf0iCLK1brVNsq3+k9UKsapDKcRwpHcaKrVDFzUbRYEoUK3cDZb2QNWGxMNzsFJxIfQc/vpA8EtUDG9CVZY2kGe8lVueFTV77wXibwf8hHLW+44iBeKfRyqc2w00RhkPFxtSgnEVth+otcpAnG0TACzLWGVZgMownX5niakaAEoYg7cqF+UgPhlKb2kiZF0Tt/2I/DveWZraex7knRllSP7Z+yFqfJ/vWb1IMFvevJQI1jx5xDQVtwSIL1gzxNxq7hOk/JXic7KlE84jcnVIDv4WuBkZXI0rZT4g6m4fBot08GPXIH7AJKlTcURZvMttEFNgZ03zKo23EBcoSsN9sUxWLGfEfKNAl7H+PgDY9FqpoeSshl9b8PlxObuotb/4ChRaINFe+6eq+VuQYRmLTppZPPFEyJQM1w4m6P9/SEmAGx+tiWP2j09CET9GdZwWw9zu48vNrZsRnqF4IcqT3KgY9dMwojnkFIZYvGpjm1nEvmTh8GYl4WniN3/+c0GVvds3a4ukJdYJVC8aeh2MoIaj7MBehOf97DbNH8tGuyNOpZcmcsMCWaPzib/yggJr29oqqZ0mtaBdSjPQb5+iR3GKHF2CQPalCZ4JsFraJ41zNk/jwjruuDL1WpvEKSrIAVEn1GIyULNqIcsktwMwTEDC72AJ3MDVfzWJC7Mg6PIdMiq7tzbdEBRF+11UxJmnqYxO4nkxO0cN4/HO93JC547a6F4/KvLlUTChmsGK4X43vxFFANrk2igLF7x97cS7k78zb9c0Q3rlEefaBOB8HHo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(7053199007)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6r6fNBzSkDIdVOVOYGvllybOnm/EOBkHkPI7AkU445q1utRESWk19I/yCxnU?=
 =?us-ascii?Q?yU4/i9fjqszzDOsO6/RQ+7YHzh7SFETJD1yJZ+Jd5zec8TPSeYIacjstUc2O?=
 =?us-ascii?Q?Ynkhqa7apRyg8SY/53GSjuPe+4gWyQVmi2a8QVAscaHe8U7jiD62BvuLpv34?=
 =?us-ascii?Q?Gjh5PZ2LYv+KpW21Qr+7VX8AFTErzrl784dee+5LF5Jq6Q6v5MfPC/X4ZSTo?=
 =?us-ascii?Q?XilNX3xEiANaawAAJJzX37FveF5n96U3xmnkl3C0edXmkLMYeHRjD25vywQs?=
 =?us-ascii?Q?XThfJfGQGGy4GUeJ4QeFaoreMKpyvP3PV387aoPHvrM9Sv9bcGtsiWVKSByz?=
 =?us-ascii?Q?rsOBejUaHSbrM1AyKUbairfuA3qMtF5eqs7HTfzLvh2RIeE0X5tFsVZvlNGQ?=
 =?us-ascii?Q?HyTnZx8uqtQcgA9DrLK6ZNkoTAbNTy8QlLNXuZInTJu2M2Hfu6EbiJx9xnjA?=
 =?us-ascii?Q?p4mrovLPz8+AE69oidb3AfVUCsmVNOKcRuVxVT6KZCFp+JbqGj57MuHwYF5n?=
 =?us-ascii?Q?kaQCGi3hc4h3n8AdmE9f0ykFT+Ep3FRHxYDOZuTWlJk8JHLKnYv0wwnYSXHL?=
 =?us-ascii?Q?VanZMdqWpufHYLKGNw3YkFp3Tpr52m+wLi+SZU5cO4YoVbHYbUKG0LWIIoxW?=
 =?us-ascii?Q?p3rEgzy43s2vADkGnDvBd3hq9NwdsMUnyanFFRWOG5ENfw7MegLuP/UdP0BD?=
 =?us-ascii?Q?pDcDwchDKlTl+M+1wKGAQZqXeqqEaXap1toLPGe88IzKvesVJsX9nODf3/35?=
 =?us-ascii?Q?zGHZ2HDcmTVLxepZTNIaSDkXOUB23sGLxaL+sZ2vE6zl14eWJypQMHwV4m54?=
 =?us-ascii?Q?4SN5oISfRKmQ9JEdAKax3Sqi7RfJECPOooKXATqs40rcjXrrSmSkJu/h+qHk?=
 =?us-ascii?Q?ViXQ9cJX1RT/htz1GOB3wTq2Pxfpw9Bmkp1sZB9vZuGvHcm1tq3Lev9EDxcV?=
 =?us-ascii?Q?14uaI1AgBfptDk2UeBE144BYJ/SkaNhtfhWVyP5GXC+sAIqU9Gh4W6icnXl9?=
 =?us-ascii?Q?F6+IJ9Af/X6kKxeM9UqrEoXnQqDZbVsInfRIvdQGvwNJHKcZxcZk+Km13sba?=
 =?us-ascii?Q?WW3pWXT71oMeueh68Orq28v36zbvX+DIpcrWmxzmWU2Hy8jet73m4QsbfuJk?=
 =?us-ascii?Q?VRXSy9bckI7KidvNjnEZMng+hrJ6zDTqNdxGP9nRerxUt+zk3YSRgEQKA0l2?=
 =?us-ascii?Q?eXYO1wDdppdL89iIRE7eH71186185yIisy9f/v2xKAqfnmF8gqQ73HJB2NXB?=
 =?us-ascii?Q?V1t+OEKEsp4OduymdgAb8UfcjwgtFHfyUp113w+VQfXQISE2RgYurBI16WGP?=
 =?us-ascii?Q?CuEFpfjhhUS+VcVVimJBFKZ1JRMbZkInmDvYKfg7aFX7b5CiYqZy5UNv5J6b?=
 =?us-ascii?Q?YHbDlHicVwWuZadKEfXps7Xc0EhulVuLvCKha3rJ8vUh3qyBd2FbCgAsIh8F?=
 =?us-ascii?Q?wKUapPS4wUTZiE+WdpMVyQjHa9AXCGtA6r/CGyq0QdZGg7O3NqU34K2GukTu?=
 =?us-ascii?Q?Ui6G5rGhflcjdXcWAsxJYFF00o+4tJA6fh9eKgdM/+ywnxnaHHTRr6y6DY/+?=
 =?us-ascii?Q?inSGSEz/f+iSnJmOtXyjkzHlBD1SRm844R05zx6YCI//ul3+B2Gw/WCQ++Xr?=
 =?us-ascii?Q?I0O9GkM0B7LiaoGEIrJ2u2nxn2KGLZd3VzFpxLZrUG663KKIqpkUE2nSj7De?=
 =?us-ascii?Q?taS1tjgFeX15Bl81c0Gc4BfTFkHeEIHj1BhH4JACbVbE3reelmfHuthkMykU?=
 =?us-ascii?Q?gqE0XYBr/g=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB709106264AF3B6409DA874D79748ASA0PR12MB7091namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cae685-fef7-421f-6cde-08de894a90d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 02:10:48.3187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D33fkNlP56mSvr+wVFn8BlSwJLmvLVDNh+tNSj553C9qkPTzU98so335uvoX2hZ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620
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

--_000_SA0PR12MB709106264AF3B6409DA874D79748ASA0PR12MB7091namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

You also need to take care of atom firmware file change. The purpose of ver=
sion specific file is to keep IP specific logic and avoid littering common =
code with IP version checks.

Thanks,
Lijo
________________________________
From: Xie, Patrick <Gangliang.Xie@amd.com>
Sent: Tuesday, March 24, 2026 7:14:46 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add support to query vram info from firmwa=
re

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks, will do two changes:
        1. change vram_type to HBM as you pointed out.
        2.will add multi-aid check.

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, March 23, 2026 11:30 PM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add support to query vram info from firmwa=
re



On 23-Mar-26 1:35 PM, Gangliang Xie wrote:
> add support to query vram info from firmware
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 13 ++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 50 +++++++++++--------
>   2 files changed, 40 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 7f4751e5caaf..504b5f0a74ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -399,6 +399,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,
>               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>               case IP_VERSION(12, 0, 0):
>               case IP_VERSION(12, 0, 1):
> +             case IP_VERSION(9, 5, 0):
> +             case IP_VERSION(9, 4, 4):
> +             case IP_VERSION(9, 4, 3):
>                       index =3D get_index_into_master_table(atom_master_l=
ist_of_data_tables_v2_1, umc_info);
>                       break;
>               default:
> @@ -475,6 +478,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,
>                       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>                       case IP_VERSION(12, 0, 0):
>                       case IP_VERSION(12, 0, 1):
> +                     case IP_VERSION(9, 5, 0):
> +                     case IP_VERSION(9, 4, 4):
> +                     case IP_VERSION(9, 4, 3):
>                               umc_info =3D (union umc_info *)(mode_info->=
atom_context->bios +
> data_offset);
>
>                               if (frev =3D=3D 4) {
> @@ -488,8 +494,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devi=
ce *adev,
>                                                       *vram_vendor =3D me=
m_vendor;
>                                               if (vram_type)
>                                                       *vram_type =3D conv=
ert_atom_mem_type_to_vram_type(adev, mem_type);
> -                                             if (vram_width)
> +                                             if (vram_width) {
>                                                       *vram_width =3D mem=
_channel_number * (1 << mem_channel_width);
> +                                                     if (amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0) ||
> +                                                         amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) ||
> +                                                         amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4,
> +3))

Suggest to move this logic inside gmc_v9_0.c after fetching vram info from =
firwmare. Then within gmc_v9, you may wrap the check with amdgpu_is_multi_a=
id(adev).

> +                                                             *vram_width=
 *=3D 4;
> +                                             }
>                                               break;
>                                       default:
>                                               return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 1ca0202cfdea..e6bb04dd0830 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct amdgpu=
_device *adev)
>               adev->gmc.sdpif_register =3D RREG32_SOC15(DCE, 0, mmDCHUBBU=
B_SDPIF_MMIO_CNTRL_0);
>   }
>
> -static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
> +static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
>   {
>       static const u32 regBIF_BIOS_SCRATCH_4 =3D 0x50;
> +     int dev_var =3D adev->pdev->device & 0xF;
>       u32 vram_info;
>
> -     adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
> -     adev->gmc.vram_width =3D 128 * 64;
> -
> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))
> +     if (adev->gmc.is_app_apu) {
>               adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;

This is just AMDGPU_VRAM_TYPE_HBM.

> +             adev->gmc.vram_width =3D 128 * 64;
> +     } else if (adev->flags & AMD_IS_APU) {
> +             adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_DDR4;
> +             adev->gmc.vram_width =3D 64 * 64;
> +     } else {
> +             adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
> +             adev->gmc.vram_width =3D 128 * 64;
>
> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) =
&&
> -             adev->rev_id =3D=3D 0x3)
> -             adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
> +             if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 5, 0))
> +                     adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
> +
> +             if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 4, 4) &&
> +                 adev->rev_id =3D=3D 0x3)
> +                     adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
> +
> +             if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 4, 3) &&
> +                 (dev_var =3D=3D 0x5))
> +                     adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;

For an easier lookup, may be wrap these inside a small inline function -
        if (gmc_v9_0_is_hbm3e(adev))
                adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
        else
                adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
>
> -     if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
> -             vram_info =3D RREG32(regBIF_BIOS_SCRATCH_4);
> -             adev->gmc.vram_vendor =3D vram_info & 0xF;
> +             if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) =
{
> +                     vram_info =3D RREG32(regBIF_BIOS_SCRATCH_4);
> +                     adev->gmc.vram_vendor =3D vram_info & 0xF;

This is specific to multi-aid SOCs. You may add that check here.

Thanks,
Lijo

> +             }
>       }
>   }
>
> @@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>
>       spin_lock_init(&adev->gmc.invalidate_lock);
>
> -     if (amdgpu_is_multi_aid(adev)) {
> -             gmc_v9_4_3_init_vram_info(adev);
> -     } else if (!adev->bios) {
> -             if (adev->flags & AMD_IS_APU) {
> -                     adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_DDR4;
> -                     adev->gmc.vram_width =3D 64 * 64;
> -             } else {
> -                     adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;
> -                     adev->gmc.vram_width =3D 128 * 64;
> -             }
> +     if (!adev->bios) {
> +             gmc_v9_0_init_vram_info(adev);
>       } else {
>               r =3D amdgpu_atomfirmware_get_vram_info(adev,
> -                     &vram_width, &vram_type, &vram_vendor);
> +                             &vram_width, &vram_type, &vram_vendor);
>               if (amdgpu_sriov_vf(adev))
>                       /* For Vega10 SR-IOV, vram_width can't be read from=
 ATOM as RAVEN,
>                        * and DF related registers is not readable, seems =
hardcord is
> the @@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_bl=
ock *ip_block)
>               adev->gmc.vram_type =3D vram_type;
>               adev->gmc.vram_vendor =3D vram_vendor;
>       }
> +
>       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>       case IP_VERSION(9, 1, 0):
>       case IP_VERSION(9, 2, 2):


--_000_SA0PR12MB709106264AF3B6409DA874D79748ASA0PR12MB7091namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
You also need to take care of atom firmware file change. The purpose of ver=
sion specific file is to keep IP specific logic and avoid littering common =
code with IP version checks.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" id=3D"ms-outlook-mobile-=
signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xie, Patrick &lt;Gang=
liang.Xie@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 24, 2026 7:14:46 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: add support to query vram info from=
 firmware</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
Thanks, will do two changes:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. change vram_type to HBM as yo=
u pointed out.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.will add multi-aid check.<br>
<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
Sent: Monday, March 23, 2026 11:30 PM<br>
To: Xie, Patrick &lt;Gangliang.Xie@amd.com&gt;; amd-gfx@lists.freedesktop.o=
rg<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: add support to query vram info from firmwa=
re<br>
<br>
<br>
<br>
On 23-Mar-26 1:35 PM, Gangliang Xie wrote:<br>
&gt; add support to query vram info from firmware<br>
&gt;<br>
&gt; Signed-off-by: Gangliang Xie &lt;ganglxie@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c&nbsp; | 13 ++=
++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; | 50 +++++++++++--------<br>
&gt;&nbsp;&nbsp; 2 files changed, 40 insertions(+), 23 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt; index 7f4751e5caaf..504b5f0a74ab 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt; @@ -399,6 +399,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; case IP_VERSION(12, 0, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; case IP_VERSION(12, 0, 1):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(9, 5, 0):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(9, 4, 4):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(9, 4, 3):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D get=
_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; default:<br>
&gt; @@ -475,6 +478,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgp=
u_ip_version(adev, GC_HWIP, 0)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSI=
ON(12, 0, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSI=
ON(12, 0, 1):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 5, 0=
):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 4=
):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 3=
):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_info =3D (union umc_info *)(mode_inf=
o-&gt;atom_context-&gt;bios +<br>
&gt; data_offset);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frev =3D=3D 4) {<br>
&gt; @@ -488,8 +494,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_d=
evice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_vendor =3D mem_vendor;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vram_type)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_type =3D convert_atom_mem_type_to_vram_t=
ype(adev, mem_type);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vram_width)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vram_width) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_width =3D mem_channel_number * (1 &lt;&l=
t; mem_channel_width);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSIO=
N(9, 5, 0) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP,=
 0) =3D=3D IP_VERSION(9, 4, 4) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP,=
 0) =3D=3D IP_VERSION(9, 4,<br>
&gt; +3))<br>
<br>
Suggest to move this logic inside gmc_v9_0.c after fetching vram info from =
firwmare. Then within gmc_v9, you may wrap the check with amdgpu_is_multi_a=
id(adev).<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_wi=
dth *=3D 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; index 1ca0202cfdea..e6bb04dd0830 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct amd=
gpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.sdpif_register =3D RREG32_SOC15(DCE, 0, mmDCHUBB=
UB_SDPIF_MMIO_CNTRL_0);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)<br>
&gt; +static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const u32 regBIF_BIOS_SCRAT=
CH_4 =3D 0x50;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int dev_var =3D adev-&gt;pdev-&gt;device &am=
p; 0xF;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 vram_info;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =3D AMDGPU_VRAM_TYPE_=
HBM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_width =3D 128 * 64;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D IP_VERSION(9, 5, 0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.is_app_apu) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;<br>
<br>
This is just AMDGPU_VRAM_TYPE_HBM.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vram_width =3D 128 * 64;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;flags &amp; AMD_IS_APU) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vram_type =3D AMDGPU_VRAM_TYPE_DDR4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vram_width =3D 64 * 64;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vram_width =3D 128 * 64;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D IP_VERSION(9, 4, 4) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;rev_id =3D=3D 0x3)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =
=3D AMDGPU_VRAM_TYPE_HBM3E;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) &amp=
;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rev_id =3D=3D 0x3)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =
=3D AMDGPU_VRAM_TYPE_HBM3E;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) &amp=
;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (dev_var =3D=3D 0x5))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =
=3D AMDGPU_VRAM_TYPE_HBM3E;<br>
<br>
For an easier lookup, may be wrap these inside a small inline function -<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gmc_v9_0_is_hbm3e(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU) &amp;=
&amp; !amdgpu_sriov_vf(adev)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vram_info =3D RREG32(regBIF_BIOS_SCRATCH_4);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vram_vendor =3D vram_info &amp; 0xF;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!(adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp; !amdgpu_sriov_vf(adev=
)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_info =3D RREG32(re=
gBIF_BIOS_SCRATCH_4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_vendo=
r =3D vram_info &amp; 0xF;<br>
<br>
This is specific to multi-aid SOCs. You may add that check here.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; @@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct<br>
&gt; amdgpu_ip_block *ip_block)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;adev-&gt;gmc.i=
nvalidate_lock);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_is_multi_aid(adev)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gmc_v9_4_3_init_vram_info(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (!adev-&gt;bios) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;flags &amp; AMD_IS_APU) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =
=3D AMDGPU_VRAM_TYPE_DDR4;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_width=
 =3D 64 * 64;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =
=3D AMDGPU_VRAM_TYPE_HBM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_width=
 =3D 128 * 64;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;bios) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gmc_v9_0_init_vram_info(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; r =3D amdgpu_atomfirmware_get_vram_info(adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vram_width, &amp;v=
ram_type, &amp;vram_vendor);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;vram_width, &amp;vram_type, &amp;vram_vendor)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For Vega10=
 SR-IOV, vram_width can't be read from ATOM as RAVEN,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and D=
F related registers is not readable, seems hardcord is<br>
&gt; the @@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip=
_block *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_type =3D vram_type;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_vendor =3D vram_vendor;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC=
_HWIP, 0)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 2):<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_SA0PR12MB709106264AF3B6409DA874D79748ASA0PR12MB7091namp_--
