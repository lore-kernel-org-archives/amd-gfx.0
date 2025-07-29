Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C542C87FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 06:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152D910E0DC;
	Tue, 29 Jul 2025 06:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1LtotbB3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B56B10E0DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 06:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkl7xbQmpQIRhenF0BSCE96XcKKzuO5FLtDGl9PK0iqZ5mReum8ZM6BJPQDbyVTSEeB1fWP45N3v9J6IkrGHkiOY/g44WNbR+HqUh/KK6BlF+u0q4jI8UwPK25G2oftLSCx2D9NuX5iPENF0PlchOcQkMKHbX4M77RtTt3ZlcL31TUIKohTUEt6Z9h21LyUZtbqI397f+XVhZFBT0L71aWYdpHlbggY/EeFdVNTVLFJDP5vgVL3y3dpLAe56Eltq3o6f7k8tA5Z8l6bGIdvFWq2ydhY3PQrGKjMiciOFARzDSMplLIiYI+WrQ2MJhFDuCX8GacguoObzG1ONhdtH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKsUme75mxmPO2P+TSfI9uiFojo3OUvGoV/mgfybVuQ=;
 b=PEEv4cGWMTogAVww62HehYUZO7whf+2CIgYaFr3HTfNEeg81EI5XXbi57IKDZRa2U/k0kzllza4Oqqt8GSlmXxXlNVHXKwNg2HC4en5MqtieKHbftt7KL3PXbLFHK4cVeYNwO/kVqMWmEceOjtWXggscZPTBHKs3E18a90Ac+lr+57GkWRsU/o0/zkMI/SnomGVJQ8Qe3geourOrnMWT1NO1g+sm3Zu8/ZFzrP7wt4Eqol4zQ0gLO2QtmHTgYHcmIcAPFupYvTIQfosY5BSO3dX84VHDDO+clA3PDh1zLe5S14cXUwVv6w0W5Svs9wLGt8wrVnXAnrh3jOYNOJx5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKsUme75mxmPO2P+TSfI9uiFojo3OUvGoV/mgfybVuQ=;
 b=1LtotbB3NLn52Y9UTFXhHtD5hvQVB6p7cZwfDYaCpu1bNCyi9bkoMCZl950nvxJv1GOg5RoCh+IMIH50EwS3gjpKXjULQcLCEGp1YK/Ktj9Zc2NqaAn+MLjh1gzBTcl0zAUzZRf6Q52dshsq7nS28qfSP0goGOhPawfL+C+gGuI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 06:20:22 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 06:20:22 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Effective health check before reset
Thread-Topic: [PATCH] drm/amdgpu: Effective health check before reset
Thread-Index: AQHcAD99r8fLowZesU2l2R025uesqrRIoNXQ
Date: Tue, 29 Jul 2025 06:20:21 +0000
Message-ID: <PH7PR12MB879634A5CF0F9E1C9AEF7CB7B025A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250729041545.75232-1-cesun102@amd.com>
In-Reply-To: <20250729041545.75232-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-29T06:18:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH3PR12MB7499:EE_
x-ms-office365-filtering-correlation-id: e98c2ef4-7afb-4487-dc24-08ddce67ff90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CfNRhTZY8rRB5LSia/NAj2diD/vdz6n6ZGe88Fy3RBvbkSDtaClGU9zbTaqQ?=
 =?us-ascii?Q?t7TNRNFHXTsIHIPprJytdfxKuL3C1jcClYv60cPsE8/HGJxtji5kjAKn9ViP?=
 =?us-ascii?Q?BzrmJjfNMkfZrxw7x4C9BiTCbUQ+lMb9y4hir+J7EaKrB2Jzq4GfGRlK7Qbm?=
 =?us-ascii?Q?uW2LD07HAVuQNR4Ptq3K70e7pjlTcT821dRx09EfUz2DsGD7/o+hImtri4Ry?=
 =?us-ascii?Q?HUYdvtRu5X+FgTuQdllXMPJznwBUQ9KrrcTIr7Dg/vJNjv9hISNRvLAeMaEB?=
 =?us-ascii?Q?vHLMvZ+8ECS0PGmIjIh96i1LI7K4HiwUrA4SYFk0hRnNJOegKX/eY5Uzj8Z+?=
 =?us-ascii?Q?aIq5d2tNemDvK7YQKg3cnTcAxYxqE7cMOcFkKIONfSmsN0VoJ1lDRzUwg1MM?=
 =?us-ascii?Q?5H1oSdpEHggBHdnGOSuo2quWfXIRrLh0tPLH5b/JERmns9+WymWcJlHjt3iE?=
 =?us-ascii?Q?X24HOo9RVdmHbadaKyzwvPc7tZ+W00GaB3l2NC1LzhdxajdZ/KPmm/SoTtuT?=
 =?us-ascii?Q?qu9hjTblhoTGJ+vvhzZ6UPl5Jgh1XePCd4DY/7gmJ3pLc060uW0Vpgbbvvcw?=
 =?us-ascii?Q?/Ouq/CnnSdGUVMnkdjmQvQn8lqsffVn86LmOeL5CEZwZ255eebtKQH1DUD+n?=
 =?us-ascii?Q?FV3M54MHQHogDYo7eIa6C301PazQV2NFtiN09yrcTWcltZQ32Evlz6kgUJhD?=
 =?us-ascii?Q?A4rE4+JpkTENASb17XeVJf4wpUUTQCZWkwu3RkxlDplOGmAVsoyBm1zsn7kt?=
 =?us-ascii?Q?pATRVnn8gd6qULZVtkezlwnk5KW4wsjfcbOxipTEi08C3dHLG9nJAQcN1GoY?=
 =?us-ascii?Q?yQ5QNlVk/QQNAB7feMPTeD4HKmNT3G797OQaSU6lZVOywXVbYMi18gtbTUkQ?=
 =?us-ascii?Q?JbveJR49017821jc2QKGPrk7dAph7sIeL0chNQytHdHBwXQg0rxendcb3nBB?=
 =?us-ascii?Q?oJvjz3kIjvGEUik2IZeXs6UDIsxILOE66l9/vJqS3bAjIU6HKcicr7OXjpvs?=
 =?us-ascii?Q?fto0IXNPPHhPMGeSxvhEHjKVOQPs03dzKXorsDiQFjUJdZjZxSALw0ydcNsj?=
 =?us-ascii?Q?KKtO1tF01/ujLKsdaHTUXSuy0xXRHZzrmgo1snYgfti2cttxpkHuAH4k4DUa?=
 =?us-ascii?Q?rf8G6BZif+kXiXLFehi0dyzzYp2evSsks2Ld8X67gRhc0182xcePSOURvmRL?=
 =?us-ascii?Q?qOkmR/QiJpdx6yQZ8wa8yM6hTpdRUakJj5DMXNhRKNQpwV6uuy6sp1zffp34?=
 =?us-ascii?Q?0EsV74PlPUtF3W/+pLFMQf4Fv4vevPxwVJbjEoeraByk4thwpJsau0Xc2I1X?=
 =?us-ascii?Q?gl9HDzHG4CbThSYkC0Uh60vH/9VWSwBY9AyApmjx/zqX0IXRFbie+o5oCPVL?=
 =?us-ascii?Q?zHeGd46I6QXtTZfFPH+goRHxTH5HqeOd1hx+oLOhAQamyCvoL4Po8N+4wndh?=
 =?us-ascii?Q?nfhdi7PoAP9ua3OEZo1xtZAe0LI8BX4Hl2uzGoLl7W48UHYE6QEilQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ThHE/qOBF5SiR/ppPEjtnCRVyyqh+IcakffidqQaHP5IWWFFEds4Z5urUdne?=
 =?us-ascii?Q?RV10afZNNdtAILyTHf4SiOancTnnf/WVVGECYygscmfQGKFtHBSoEaC7yO82?=
 =?us-ascii?Q?6cgaytsPh/5p5o0L24NRB2r0YhBxWXwOU3q6+ufEKFgKZT234aLJdvKMqnMj?=
 =?us-ascii?Q?g4l6xF1Tr8yV7HVcyCts70yTs+94v0YthuhrFZ0BN5AUy+qbz5h985fr7gVX?=
 =?us-ascii?Q?JA8tY9kZew7GMQ+CFLhOvlXCFG2fl00TDIJ1EhD3hLj8EDtq3a8Dh/LI1WJe?=
 =?us-ascii?Q?ClDTT53nfdPEqgDTlXDGKE72RTNSiR3OKxOEl/Z/L3eToSQqpOmDhUvupgR8?=
 =?us-ascii?Q?yTVc8MM/29eGKymh8WxMm0zzTU0XQYYWanshTyivkdvCVjdY3tOGKTU0Eg+V?=
 =?us-ascii?Q?A0VODeI23Hp4bbofRQjYWWHhVcBayGCXBIQQEUf138V8G/W/qxjWQW7EdXAQ?=
 =?us-ascii?Q?ZSAuxmRuKgn5o6iVSkzrr+oEMk48e87Z0UDaThOnB2QPHwEidp1YKE/IT88f?=
 =?us-ascii?Q?4Sh2yZgU8HnZaIh96qdomar6BMkb+sSkXcijLiKZPWQxBEdEqMA/34duLUBZ?=
 =?us-ascii?Q?wjsUulS2r/Q0qbXtKJMiag/ODBQ/k/6sBAH+yMf11e5K2z6rrl0Db+r5YWQp?=
 =?us-ascii?Q?o7qGS4ytcN95NnngAu48hmvNh9fLhIzKByJmFd4q3At7jzC6BoswbG+K5/oa?=
 =?us-ascii?Q?U1sMnPscbEagajV271D07eBF8G2yTIXg3DzwFoeXVWvyLK2PlIrQo04Juz5h?=
 =?us-ascii?Q?FtwO98shskwynXxIRrX7WUMqF6HJWq+pOnXujXlfavK5XM5AAB8qixKAi/mz?=
 =?us-ascii?Q?4jQEX4q/WfwbFOcq6XQgEiN1aAeEeZ+W9yXvCG7E6UjvkjRBEf1JRMGOSdf0?=
 =?us-ascii?Q?nrWW0ZRNHga0QV5qSSbYZR19nOE2/nOQ/UZkr8Lbn4VFl64fIZ3bWVMMzJev?=
 =?us-ascii?Q?Uq00dmp6njHnevGbV/sDLOWutGOD540UbWFNpqBXm8fxD5RWSHJFnbQ6rD2A?=
 =?us-ascii?Q?oR4yN1+la9JjMCnBEG4dENPBKP4Hq+/rhpMa0HsQ3V1bpGZkqqn8OcVkNoNu?=
 =?us-ascii?Q?jtBD7r8TmRneapP3PLwIplvh0Fwj5hbTzQzs+QtIR89PRLn9puEo4JqF9cW2?=
 =?us-ascii?Q?Z58E8dglApzDAGbBTRrPRqGHD08Hxvwi8q75skngtm3JJfO6yLSrDrfbCE1p?=
 =?us-ascii?Q?pDsxCqpD0uVuu+t6zsUQEqXVZEjWjoPr1Q+2gKk/P8LKb+JgljRzft5y0o9P?=
 =?us-ascii?Q?KS9oESNf5XhbUWryptZ5M9zDEHlChuwiG8ru7ESGtNOnU6FjS80MwU0EcO7O?=
 =?us-ascii?Q?T188bnKLZgMKP3JdOxKhEyjJJek5P2Q4XmhvGdqAOQA6Yjv/Sw5UUTqT7ebf?=
 =?us-ascii?Q?ENIkKPSf+CgmN7p+LTqVy0oNKroc1PRWEtriT7BtBbskZaw7TTPqRt/aZyR1?=
 =?us-ascii?Q?CowaNHvRkgUanMhNwFITxNuC+c3Egk7Emym2TT2dx/rHS1Z4BT4vqOzBqAqN?=
 =?us-ascii?Q?+2pWI++Z8ZXMX4D9meESpIbjeV5W93CoAiwqBtqe9BrBOM6KAr16R8BbrTxv?=
 =?us-ascii?Q?Z/yU14I1tTpk14LhpuA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98c2ef4-7afb-4487-dc24-08ddce67ff90
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 06:20:22.0577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBIFxox5lFJPyt3zDf3vtTvPaySJ6KHBDD+HBjkXc2VUAKvcX1fIhKaZBe9q7CoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
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
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Tuesday, July 29, 2025 12:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Effective health check before reset
>
> Move amdgpu_device_health_check into amdgpu_device_gpu_recover to ensure
> that if the device is present can be checked before reset
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++---------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2659e3ebbe49..176712225037 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6129,12 +6129,11 @@ static int amdgpu_device_health_check(struct
> list_head *device_list_handle)
>       return ret;
>  }
>
> -static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
> +static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>                                         struct list_head *device_list,
>                                         struct amdgpu_hive_info *hive)
>  {
>       struct amdgpu_device *tmp_adev =3D NULL;
> -     int r;
>
>       /*
>        * Build list of devices to reset.
> @@ -6155,13 +6154,6 @@ static int amdgpu_device_recovery_prepare(struct
> amdgpu_device *adev,
>               list_add_tail(&adev->reset_list, device_list);
>       }
>
> -     if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) {
> -             r =3D amdgpu_device_health_check(device_list);
> -             if (r)
> -                     return r;
> -     }
> -
> -     return 0;
>  }
>
>  static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *=
adev,
> @@ -6449,8 +6441,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       reset_context->hive =3D hive;
>       INIT_LIST_HEAD(&device_list);
>
> -     if (amdgpu_device_recovery_prepare(adev, &device_list, hive))
> -             goto end_reset;
> +     amdgpu_device_recovery_prepare(adev, &device_list, hive);
> +
> +     if (!amdgpu_sriov_vf(adev)) {

[Tao] so the condition is also changed.
Please describe the issue you'd like to fix in more detail.

> +             r =3D amdgpu_device_health_check(&device_list);
> +             if (r)
> +                     goto end_reset;
> +     }
>
>       /* We need to lock reset domain only once both for XGMI and single =
device */
>       amdgpu_device_recovery_get_reset_lock(adev, &device_list); @@ -6956=
,12
> +6953,6 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>       int r =3D 0, i;
>       u32 memsize;
>
> -     /* PCI error slot reset should be skipped During RAS recovery */
> -     if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3)=
 ||
> -         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))=
 &&
> -         amdgpu_ras_in_recovery(adev))
> -             return PCI_ERS_RESULT_RECOVERED;
> -
>       dev_info(adev->dev, "PCI error: slot reset callback!!\n");
>
>       memset(&reset_context, 0, sizeof(reset_context));
> --
> 2.34.1

