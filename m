Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C4CC83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 07:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFC610E039;
	Fri, 18 Jul 2025 07:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jAG84/gD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC1310E039
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 07:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xpt1rAY9IKD4/+E0z8CLpFytzr+HYSdW1AEyg4LW2fYBm6euJ5hIGWzKYAqDtRqpVQ6wH5iOA9yfL2EIhFdYtLzrnhQMrVj+nUEzaw7zJU/VZlgz9lam3RaCvyVWCmI1mK3FU71QMfXKXg8MJgNNSc0+GQmlRbELzVFeVyB+b1wDBuHBK57b3gLkaU7qUWRXJda/2ZO7rOJVjx2UTtaFlv74RXRZ6FJaMAdl+Duju6q5/tQbpl+Cn4s+URuKUi5E10PkpRuKWLlwYJcBXjPZnev8b0QYl34/eJqfgFN5GBYuUeny1ZLvUhycO7VGI7+eKzWV9Y5ER1kzfeaRHhxe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GieYf7Bs9nHwdZa+BSu6+1gZ4wgqfj8RjHZLy2vGys=;
 b=V31RVC180IiHuTmaB8fs5mzpwhOEABShV9NmWNiezPvaxg3HOTmir4LylkQB+mXXLIgjuQVvEo2Uw0MTS+Zx3PNbO/7N/ECMneny9qllqav3ntGrsPoiSXETStP85FnUBodRiCd2SvSblWdMykpnoITRYePCc0p+XGZRtOp+RLgiJOVomiS2Fl3E7389zSMck4X9zg4EJt2MdnCgq3xOKBFWZywTRMyS4h2FedUOSQ9TF8/hEV8fJZkEzuHcVSxGIcXpNPDZPKZ1jHCohl9BxkpbIpNjMc5DOOUwLNVN4PdxhLePygWPDi4ZhIi4ePqKugzl4CgFTT9XUsaG+0RyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GieYf7Bs9nHwdZa+BSu6+1gZ4wgqfj8RjHZLy2vGys=;
 b=jAG84/gDb1vY8/BKpsRibfVkwFknaiGYHUm3sHVHgJ0cU8w0MErZdCa+VfC6HxU0JjI3svnvhQH+Wf6UbZ1yPj7bD0nrGbQdaJlQGtQbuTm1OlYzGPer3K515o2KhMfle2M8cPhu3CPDHUcNW/t3ILInGvvnn9VgP/t3yp1ehMs=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 18 Jul
 2025 07:38:58 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 07:38:58 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: add command to check address validity
Thread-Topic: [PATCH V2] drm/amdgpu: add command to check address validity
Thread-Index: AQHb95PH3o8oq8iZ40SBKZ+YFAzmyLQ3ft0A
Date: Fri, 18 Jul 2025 07:38:57 +0000
Message-ID: <PH7PR12MB879679332C398554AB3CAC5AB050A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250718032609.1363340-1-YiPeng.Chai@amd.com>
In-Reply-To: <20250718032609.1363340-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-18T07:38:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB7849:EE_
x-ms-office365-filtering-correlation-id: 0ad4f436-815a-4001-90a4-08ddc5ce27f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GnyKrp+9TVjAaxOWqDv/glsmtMhvy3tzK2J+HNAZ7Cvv7QETyWzrCcvogMdX?=
 =?us-ascii?Q?Fp8frByn/tNT1WIpYSkIv6FS/wywidtO4Yxs45cB6ckQWmibY+6b5AsJRC6h?=
 =?us-ascii?Q?rJ33TirMutacVp/R+vIQR7rqe5F/+9+iX3b+0R6v+D4SLfu7BX9smZ2egN7x?=
 =?us-ascii?Q?EMaXMhKtZZUTodg3H82ae/Z82v1VM1NxEoFzLqa81hJgmbC9bfT/dEODQQq6?=
 =?us-ascii?Q?8YUb4MUWIJ7RjWNBrlPU7CDLvMw5vKtlAH5hbszVTAYhnFvTRRL9l77oWDWz?=
 =?us-ascii?Q?VrRpsmvBlIWB50/gJWvBbGVJHD6elEel8El6URdTzneblEgCeQJs4t7kFgB6?=
 =?us-ascii?Q?RBeIugMyH/rfojakNDlCaQnvkcdGqp6suLfJKpFIpM33Eb7n0rR2N2cWU+7e?=
 =?us-ascii?Q?NfleJMOltz3Jj2SCnK/4kt5cgXxsPGyZMvFIli+X3hhQqJAR+yPUeBvKJfzO?=
 =?us-ascii?Q?ER5FUaNfn5/6KxfZkuIc9V/gPugwOWAfMqvji3aIjDJN3HZcah/JybsduecJ?=
 =?us-ascii?Q?6fQu6+9KmzA6rujkrR19pW62mBzYeBkx2nYTFv5oxqmRlKQXKIrQbhJJWRTd?=
 =?us-ascii?Q?8uRscz8zK5h9S8vlNwb4clr1FnJ5ftmNoNDq3WBcT2mWUw4XM/t5mew9jbT0?=
 =?us-ascii?Q?ciBYZnJyL6zPnfXtIp0vJBrFjNdfnn6uIiiPk2S3MesGzr0P0v/zS2e1yab9?=
 =?us-ascii?Q?FFeXtUHwWl2qfCSbGNRFj+pgLTofhJR3U8i/u+g3NJTptVSl30rFi528okgR?=
 =?us-ascii?Q?rCuEE54IPIhb0IH6dQVg6gDUakPaG6TemBvyf32TmWyn6J5L9rm9NHhChtZx?=
 =?us-ascii?Q?SBJojMJX1JfnnPC3TlIuMvVnUByTBmAAS5Uofm5LIZHf2jxB0ckx9IJF+htr?=
 =?us-ascii?Q?S7aN7qCwZAYkuakWeikU2PxqLh7hRvVLH85JCgDkrDpYJxrRnRuGbOClVwCA?=
 =?us-ascii?Q?y5NXOWS9kFJlYpuphMX9qRDYXuYnZgviRkNIG4kqPJAYMqzei8bFttehOQaZ?=
 =?us-ascii?Q?8WiGZvL15jmlgGZem2xWqylH9nfX8wwtk3Si85dZQCNmC7KwcRr1MIOBX+cG?=
 =?us-ascii?Q?6UykreaOGZ8lujDuZY4ZWhXHAu+PubqehFl2uZm3OdFGjU9wdlfQ5mPA7yA4?=
 =?us-ascii?Q?ZaNkRAF8x3x6h8Y6HaCtQA17OZoSlvKcG63f45+mcDU1jpWvs8XnY9KglvrE?=
 =?us-ascii?Q?wT6TjZ8FZCDCSHyWkSIv69oAxWLJRWUbObuOXZ+UdM6Ac+KKTDkklsb6J7cW?=
 =?us-ascii?Q?JGZGQ7yiw6ZZLd1YZI/UMCtOXjf7Lw7dkNSjVlzlqsUcpU4Br7E45jfP1PNo?=
 =?us-ascii?Q?GfRKNe0ZxnYd+owWLfVaI6l/C5aYJfBOvzcnOSI20hcbXDvX9bOL41bveQpr?=
 =?us-ascii?Q?T3FGTK8RIZ/28J+w9R8PPi/wkQbnxhTjc+GX6mYoqzMIxV2LhceDlMVHxRSW?=
 =?us-ascii?Q?D4QZn6f/Mgocc4LJAP8EwdwuykFA99jh4PuWe66ROj/Aph+6ihzdkg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rSG4MildmXZ4Onvor7TCoohp7drSRIsopSIZ837Q3+IrgBfGd+BA262a9IoM?=
 =?us-ascii?Q?JM3Ks6J4s9AOvjSY/8to9U6aK/lRAsksI+PiYiPYCXTRSMBkWln+ilFjgbhw?=
 =?us-ascii?Q?bggLnF6B2RcJLTBTpZX9WtcYb9Zo9yC5+uU0tgKLcabcqmszUcxv3xp4bpgr?=
 =?us-ascii?Q?wHHKJGL1IFBMDFJIPrJP64nuPYDEtedJRLr/d3qGagJ1e+5XG6vIMEpTi6TW?=
 =?us-ascii?Q?+JPVlmSkjAu4qfuAobLnjxUChUzm16pQy7GEb5gmT7lFXeC9LLP3+n/CNc5H?=
 =?us-ascii?Q?lvKZWGTYPHjKnssgLIFzydH6hsy/s6mKjYRX8TkAYObU12FFA0fxx2KyGVLX?=
 =?us-ascii?Q?f9PloAuWnXhRdGsWCT+HPQkdkNyZvpH8492mIPkwj89VPKFq8BDC85/jjXhc?=
 =?us-ascii?Q?u2p3Ebw0aZuqQALSNIV4NuNPgoxYoKMIky6fckDG76CP/VMy6mjJmho6zTvl?=
 =?us-ascii?Q?kzhAUmIKagsdfzsK5ibcgVoBPkJ1O2/LR95ayBez05XISXBcpRmz7toWw3C3?=
 =?us-ascii?Q?Zsyup8Md2ZViOlGKceATIdQGueY7ahRMvuhdGUzqV2VBZMX/QfxaNLAUWMvz?=
 =?us-ascii?Q?7RljTnuVNXI5Sg3WexcBg+huPqnckDjcKe3lEXHFmWh/tZBb263vaWkHJgyu?=
 =?us-ascii?Q?dU4UwxmLIhoCvvQd4/jkh2kbhd0VuNhWva9T9sCWghRdsliFucf6Ahk9a4m0?=
 =?us-ascii?Q?goiaP10jANNdOjpN7YLgXD0wW4CqfnvTeOLOEXGCN1jJy4IUDpFEOGX/+A2W?=
 =?us-ascii?Q?MKTINnbbQ8o2SEaMMfyusoEV6BCe+riKyfNRduUVu6D0PtmvYNKz4zmSodoV?=
 =?us-ascii?Q?nkb+c7WTNzmhs9wL0HBy9eUnOtDvNBOTiHEjABguE7svGP9a/y0RfD72aWyG?=
 =?us-ascii?Q?bLIQxJcc8epave8NVLEv7YToXbZn6J9CzkJNfkT8NNp8ugcQebkId+CfAupn?=
 =?us-ascii?Q?n1N/WhzEy9ueBnYIDCKfGWmDMr3t4w5GUVaqcDAEu6TRscda93ts+QmExy7t?=
 =?us-ascii?Q?GhgeKiWx5bcupMXvRqHYN2y7OYyCR+IHkGN8Q62JqRQyyatgInG8TdI/2WbP?=
 =?us-ascii?Q?JTYA4D1NLqeuGmOIalPoCPbI7cvUg4KEpRxQ44MF/1q9xGyBtHa4qAUz9E+8?=
 =?us-ascii?Q?u0EuZdF2Bp7YLKc/aKYtbMe/HnlIpN9dbVXs4O/CBH9Li9/15RSo9OnA602Q?=
 =?us-ascii?Q?2oCP6AY9MgPCRGS9aNNarv4pTdb/NsjIY+9/UWecd3HTzyRxLJO9WLhuL+z6?=
 =?us-ascii?Q?jQzP2U9HCmHsJoiUglO0ZZyETXQcxo57MaUVqwAHL7u37UaJnd7S/LYugcvu?=
 =?us-ascii?Q?UNT2l+ji7s4g1ZmZxPNbd+wJVK0/MCy47fpRyKMBH1ROmN9lrhC9YlMxc+o+?=
 =?us-ascii?Q?FlKIbQ4pW/59DE7Ys9qc/ciI6o4/62npflOjHTfv4i+Ob5jz3ikG24pXIziZ?=
 =?us-ascii?Q?BUKF2PdmNBUkvPje4f0BF2fLUDAm6x9tarcQ4wN9tYq6Y0iI1+duchQF9JfR?=
 =?us-ascii?Q?2d4rt1AoTr62FiS/BsH/fwxR4XGH8rN3Hw4L1H8BiTawou8LtP8KLJqVCd/F?=
 =?us-ascii?Q?7YQdN9Q/5wUv/UxjAEE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad4f436-815a-4001-90a4-08ddc5ce27f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 07:38:58.0589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7vqb9DO4Od8Q0xL78pDrJklg9xOYoH1s97ZZz552M0AdI9gD08EsUBcPu5OdSFG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Friday, July 18, 2025 11:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH V2] drm/amdgpu: add command to check address validity
>
> Add command to check address validity and remove unused command codes.
>
> v2:
>  The command interface adds new parameters to support  multiple check add=
ress
> strategies.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 63 +++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++
>  2 files changed, 66 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 15bde4904996..185b9e538f98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -128,6 +128,9 @@ const char *get_ras_block_str(struct ras_common_if
> *ras_block)
>
>  #define MAX_FLUSH_RETIRE_DWORK_TIMES  100
>
> +#define BYPASS_ALLOCATED_ADDRESS        0x0
> +#define BYPASS_INITIALIZATION_ADDRESS   0x1
> +
>  enum amdgpu_ras_retire_page_reservation {
>       AMDGPU_RAS_RETIRE_PAGE_RESERVED,
>       AMDGPU_RAS_RETIRE_PAGE_PENDING,
> @@ -207,6 +210,49 @@ static int amdgpu_reserve_page_direct(struct
> amdgpu_device *adev, uint64_t addre
>       return 0;
>  }
>
> +static int amdgpu_check_address_validity(struct amdgpu_device *adev,
> +                     uint64_t address, uint64_t flags)
> +{
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     struct amdgpu_vram_block_info blk_info;
> +     uint64_t page_pfns[32] =3D {0};
> +     int i, ret, count;
> +
> +     if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
> +             return 0;
> +
> +     if ((address >=3D adev->gmc.mc_vram_size) ||
> +         (address >=3D RAS_UMC_INJECT_ADDR_LIMIT))
> +             return -EFAULT;
> +
> +     count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
> +                             address, page_pfns, ARRAY_SIZE(page_pfns));
> +     if (count <=3D 0)
> +             return -EPERM;
> +
> +     for (i =3D 0; i < count; i++) {
> +             memset(&blk_info, 0, sizeof(blk_info));
> +             ret =3D amdgpu_vram_mgr_query_address_block_info(&adev-
> >mman.vram_mgr,
> +                                     page_pfns[i] <<
> AMDGPU_GPU_PAGE_SHIFT, &blk_info);
> +             if (!ret) {
> +                     /* The input address that needs to be checked is al=
located by
> +                      * current calling process, so it is necessary to e=
xclude
> +                      * the calling process.
> +                      */
> +                     if ((flags =3D=3D BYPASS_ALLOCATED_ADDRESS) &&
> +                         ((blk_info.task.pid !=3D task_pid_nr(current)) =
||
> +                             strncmp(blk_info.task.comm, current->comm,
> TASK_COMM_LEN)))
> +                             return -EACCES;
> +                     else if ((flags =3D=3D BYPASS_INITIALIZATION_ADDRES=
S) &&
> +                             (blk_info.task.pid =3D=3D con->init_task_pi=
d) &&
> +                             !strncmp(blk_info.task.comm, con->init_task=
_comm,
> TASK_COMM_LEN))
> +                             return -EACCES;
> +             }
> +     }
> +
> +     return 0;
> +}
> +
>  static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *buf,
>                                       size_t size, loff_t *pos)
>  {
> @@ -297,6 +343,8 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct =
file *f,
>               op =3D 2;
>       else if (strstr(str, "retire_page") !=3D NULL)
>               op =3D 3;
> +     else if (strstr(str, "check_address") !=3D NULL)
> +             op =3D 4;
>       else if (str[0] && str[1] && str[2] && str[3])
>               /* ascii string, but commands are not matched. */
>               return -EINVAL;
> @@ -310,6 +358,15 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct=
 file
> *f,
>                       data->op =3D op;
>                       data->inject.address =3D address;
>
> +                     return 0;
> +             } else if (op =3D=3D 4) {
> +                     if (sscanf(str, "%*s 0x%llx 0x%llx", &address, &val=
ue) !=3D 2 &&
> +                         sscanf(str, "%*s %llu %llu", &address, &value) =
!=3D 2)
> +                             return -EINVAL;
> +
> +                     data->op =3D op;
> +                     data->inject.address =3D address;
> +                     data->inject.value =3D value;
>                       return 0;
>               }
>
> @@ -500,6 +557,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct f=
ile *f,
>                       return size;
>               else
>                       return ret;
> +     } else if (data.op =3D=3D 4) {
> +             ret =3D amdgpu_check_address_validity(adev, data.inject.add=
ress,
> data.inject.value);
> +             return ret ? ret : size;
>       }
>
>       if (!amdgpu_ras_is_supported(adev, data.head.block)) @@ -4103,6 +41=
63,9
> @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>                       goto release_con;
>       }
>
> +     con->init_task_pid =3D task_pid_nr(current);
> +     get_task_comm(con->init_task_comm, current);
> +
>       dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
>                "hardware ability[%x] ras_mask[%x]\n",
>                adev->ras_hw_enabled, adev->ras_enabled); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 927d6bff734a..7f10a7402160 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -570,6 +570,9 @@ struct amdgpu_ras {
>       struct ras_event_manager *event_mgr;
>
>       uint64_t reserved_pages_in_bytes;
> +
> +     pid_t init_task_pid;
> +     char init_task_comm[TASK_COMM_LEN];
>  };
>
>  struct ras_fs_data {
> --
> 2.34.1

