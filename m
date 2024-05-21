Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E97C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF3010E44C;
	Tue, 21 May 2024 07:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dui5ND6d";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC9689BEC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpBu8zsIRBTRjwg6yDus/XImKyJxAdZhjx4yb88hL3W3zDacsQUHnp/ymsO1eHHhTGtIwsJcDAiT/0XMXxIXTV5uM25wQbACBBtzlSIT2N9pbN/aEzXkoqa+hwiRHUPJ3/EsS0nkBmCgbFtBWrcoxweC8j1ooOVidWYyZ5XAkTJtaRbWWaCH02ItnYC6S70nuXCcalx0OB43RwUl3BHFxLXt7XCWBtEJPzKLU/WJG38jEZ0sXV2Xz9YPJpRONX4DqnsBkfbB8Zfn4BBORYOV/zYvV6psjoSmKhSjFtgau2ZnQigXou1ckuvA6u/uWlUHs0I4KNsiPOKnUILoHifZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbMxpfR7II0vZYaaAJkettpyAiLJ9pvsSZBHuvAk8OE=;
 b=VGEbKNDG8WBhlZPzCyQ+N8IKaavlrwo/CkoIpRR4AG6myYfgPUzUJf7R6PuXogA7CIGDMEof+i6XRXxfIuNSyY19Qhek1llfMLX6oRSIEONKT7QQJZ7WTcIKoByhI/SrVUK6H5tp7k8OwytYrX+iPmQPS7hbqvsjj4TlIFP3c/WEK8l9c+iUtCB1oORcxRnAVYVTv3SObkEbyhBNUq2gz7fgMKpdVQxYJXHmk203b/J4gXnsbUPtaOYcLhK8aS2PJ9OHFnl/qSxsUZv9qSMTOL9q4/AAUoLQ0oBpa1277DjYOILFAELKReWQDFRpnKivyNr1NguK+Ys9uRTwZHhcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbMxpfR7II0vZYaaAJkettpyAiLJ9pvsSZBHuvAk8OE=;
 b=Dui5ND6dGL6Rxe9kKF87lPSizEPL6GGaBDrRWYUYeFW89GLXrrBecXvSap0r3OiktUzym1rEq8J1da419ErCcYXbxxkxudkQGSkRUlbNs9s/CPUa2+qKKK9638Phq1U16Jaf78n0LbN0f0OKdLqjKggcDg7ySWQgj0bl3mPE9Ps=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Tue, 21 May
 2024 07:20:23 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:20:22 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct hbm field in boot status
Thread-Topic: [PATCH] drm/amdgpu: correct hbm field in boot status
Thread-Index: AQHaq04sxpHoMvKTpE2g/zJl6BktIbGhSArA
Date: Tue, 21 May 2024 07:20:22 +0000
Message-ID: <PH7PR12MB8796343807272CA5CB32B44EB0EA2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240521071130.12167-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240521071130.12167-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d0d9c407-999f-403e-a255-9ea6c38bbc13;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T07:20:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM6PR12MB4418:EE_
x-ms-office365-filtering-correlation-id: 730ec771-f849-4447-da89-08dc79667a44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?7Y+XylNLSyd+MvSodhdiVy3P75szxwm5s9r+5+RTo8ZTk0jJ4uKEZsY7CWEE?=
 =?us-ascii?Q?qOTTNgPcDIz/HGLJf98DvzMHV7DtOa4X0mVuGT5o5AHe4nm5hbxQQJkWU2/P?=
 =?us-ascii?Q?PsCf16S+NpUeC2xR9f1DoEkDxSFZq4ysWNm1Bee24Zb+QG6N7oLGonm1GrRP?=
 =?us-ascii?Q?9PG5YU7dRkDNTfT5DU2CJwJppo7N4wiZSWpJG2vWHi3rF2KwwbJndyBN/ivr?=
 =?us-ascii?Q?5VoSMbBLG3mZ0pYz7W0N+cPWr6KWnwq2hHe7urQksQhY/+gUlC/xu/Xz+DWf?=
 =?us-ascii?Q?SNixTTOy9gnwOGovqhucYytebEioy7jN/LA5NshVyNtLHhH4gVx9Snze5zCS?=
 =?us-ascii?Q?QBDbEE7HENDEHXZTOofbw2vx+U+1sFGFummSkLS/r8T+ilG4fSzOovF/Fmnp?=
 =?us-ascii?Q?QT8GmM5csRywCIkHnniFZFDzPgP9pRBkq6DCO9Qlsq9cDkZu/CXx1woAbym0?=
 =?us-ascii?Q?ldrFRrFMg01YxE2SOkXC2nvw3wJfGYD3FbmCElGbjbhMdDDHh9/X7bOan6ys?=
 =?us-ascii?Q?9AVoYL3oMpT4nxAYjzHjsu2+uG/l5eQXgIDMbOCEbP4GIRRr1Lu3r7AUJ4SO?=
 =?us-ascii?Q?HYVivmhaICtLbtY5Wk1VcEfJqDrWw5FQEScI8oEdIAIBhwrKLFOvm142QwLn?=
 =?us-ascii?Q?3xSneWj6jzQe3dm0pHcXl2pI3xNLo0cgs01uGR2ZgqzTbg23k/wpbvoY3Cak?=
 =?us-ascii?Q?b2ZxiFUsWN8WTJc8eEPNxZKlcHgywGdLL6u8o3lujc3Kgo0rESZD6O2hj8sH?=
 =?us-ascii?Q?PzlfvqtM6WBxjtlZoYWxLwV/QaB13G11tYSm+Ag68W8RJ/gI29iKMFq9GDcH?=
 =?us-ascii?Q?GxSxcyynaKGhAnn0gxKco5ssmNHPVEB7mGV9PMEFp3ZdNT0JffXh9vkyrWLs?=
 =?us-ascii?Q?jcGdcMQ5BaJtMRMpqFpOF/3YvVllYslkkrTH7yp4QHZsD9cgqhQ30H6imSe5?=
 =?us-ascii?Q?kfEfJfNY/y0oDKHTspYrTkILTtxHCbN/REdvoy9KKaAPVoZO/rzSI+NSpV3C?=
 =?us-ascii?Q?Bmc88DC9JfyaBx9XE413oJ+lilAmhnnpYQm+AB2fLfWjYyB0mZwfEjYgtYiI?=
 =?us-ascii?Q?V4PO1ddXksIm3am95z1KdO/S7RsrQaios6D3F1qn0kbDlzDSslfK29gz5Gwo?=
 =?us-ascii?Q?qZvSTPN8/Tv41/Jv7Z3JTy1hQzEbnKqV7nPq0vwpSXvGY4u+ScZJDuu6w7oi?=
 =?us-ascii?Q?/iWk39ztphLEmRzPW0V/bexbd2rwlaemdvZuQxMWjCcNhnhciHCRMHydKZ97?=
 =?us-ascii?Q?4h7C5ZhtX94bWgLjz1dQCDMUZPVRud0sdsvZvzm9VmHZFtAW4ov4g1nEh6Lg?=
 =?us-ascii?Q?RaZNZFXNSRDpQL2et/MvJNR+wOVgyIKUt/kRHWb3I4PIrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qgg+evRf1LfWHPAbGlR+CknllwwjuC/DjNszbvUfydiIuAc5nU0mfXFB7FIY?=
 =?us-ascii?Q?4O3KlpfNEgMLrOuz8owIfc0EaBO/cn4ZEVJ1ofh9J9oHpJBHsHoH4kgvZ/XX?=
 =?us-ascii?Q?6TtO88eZaDeAtTENkhKylmS7UXt0VdQJb1HQ07XOiOEEE7DOXwiTr3XPtqP9?=
 =?us-ascii?Q?DOzn/GCvzUmcnp/mKpKCHwQIXizn5tAQxkBuElLuO2vo4NeRb+mtSjMjDf/4?=
 =?us-ascii?Q?Xsx5wLV1/7p11Yd+SFu076Gzl8z7eyXOIFBiMt/aTqSpTnusO++IJ6nCp5Y9?=
 =?us-ascii?Q?UuINBCOyvN5G0/RzUCQ/SDYzOGw7AXSry3WU3/qolhrMpA8ZHYEhPJ4+AmIp?=
 =?us-ascii?Q?lMBNQ0EU79WvrI1yXfZp2lIJ+gWIMXx1bLQ7RSsHgSBwfiN+bxmivgEc8l52?=
 =?us-ascii?Q?SbFTDmJjSpe3s0ZrwYXvvX1O5SyXkbfgF6DQePuds9uZq6wSKJUKwkZ6FlRj?=
 =?us-ascii?Q?Ep7tepq/WmaDe9Ws4FEkEj0njH5zBf5L4KKmrUzp5Ex4rDiuakorXOawKcvl?=
 =?us-ascii?Q?cwHIYWTgz4NQPX0o96dZhjuXOjtqr+qjZFenVZAcuJucdwzurlxOlG8J+2Ym?=
 =?us-ascii?Q?/Oe200+XkdhatwteRIAWuo7EP8phY9vF1biPPC3zWF94VM4bJMBg9NE0U24U?=
 =?us-ascii?Q?Vc487SBlDt0ScmGc2C5ULSaRiWOw7H+hcBY0nHU2u+CxzUqd11CilR44BfN9?=
 =?us-ascii?Q?6eNKwQtOUjjL/y+TAMahqbV3xGI13a+Si+TDlvdMsVbuDepo1ym6asDUJE0L?=
 =?us-ascii?Q?bepoiz0JUUGK1c+fqSW3lC3OTBwyjXv42O3VMWWWpag2kDNy9rikIvVJiwi1?=
 =?us-ascii?Q?MdI2xRgzPcU6OqCsBZMimKhWAgC1H2GpeoJdfxGKK0ykZsPRQiGTq79UbZXm?=
 =?us-ascii?Q?43Ht4bOMktK+3GuXCOn1WDwwJakv9My7Q7JN5affnQQKLseESedxu3mUmW5h?=
 =?us-ascii?Q?TykMs/rmfFIrvpIM7FOGzEhIFHch47HLdbFzXVWH2C2T8iHjMNomE79/fw8X?=
 =?us-ascii?Q?2DKbHnhyw/nXXKOpkJsFKcJz0Gzzu5Wl68oQjM234FU8YzPuIS/55T+XmUwN?=
 =?us-ascii?Q?4QzyFIg0pbYdxxlAK0MV827+VoPIfWrEKEtiL1P+S1//uB1ZsTjdwX3RKHlm?=
 =?us-ascii?Q?pyaQKx44YkbC/5V6nGrSfdZiuj1HtlNOgrNg//dMyURBGUUsKvFFZIDPlHAP?=
 =?us-ascii?Q?w/OV+TfJCjiGIvH4FMl4FVr5AqJqGAqeMgLrRURUwkf2AkaIkcinitVM+W6e?=
 =?us-ascii?Q?55fiyQKdeaxucJ6t7L1dwySA7zlXNdQtCrGf60/FDJkXKtdup3ggNxVvxpDj?=
 =?us-ascii?Q?HogC3639LIhWG6AnlpYPHaF74MozdF8MzvXfoQqhEcgK/TC7ma4Oy16ufdVI?=
 =?us-ascii?Q?PaDlzBJ3SnrpQR8rJcD60xURIE5f10lsqNBTHGhMX5tH52E+u7/YXyWHoUcZ?=
 =?us-ascii?Q?K6qvgXlvsnpPO3aqXnw4hWUGbr9uLz/WVAvmIstiSdEN59hZYqVVWmZKKmsq?=
 =?us-ascii?Q?/uogse4t+ETMvoQFYLl2Qbyw8EoraSqTUFIYb7TEJvYr/oYDq46lLbiXlGJQ?=
 =?us-ascii?Q?AlmB8UFhvbuQQsjW4bs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730ec771-f849-4447-da89-08dc79667a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:20:22.4185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9dtWT0qxsSVFbq7j15/TNe4YxuU8ohxICWryxdFDHN/rAVWkiVZ3UifGauFWSEW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, May 21, 2024 3:12 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: correct hbm field in boot status
>
> hbm filed takes bit 13 and bit 14 in boot status.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index c8980d5f6540..7021c4a66fb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -46,7 +46,7 @@ struct amdgpu_iv_entry;
>  #define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 7, 7)
>  #define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 10, 8)
>  #define AMDGPU_RAS_GPU_ERR_AID_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 12, 11)
> -#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 13, 13)
> +#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 14, 13)
>  #define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)
>       AMDGPU_GET_REG_FIELD(x, 31, 31)
>
>  #define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT 1000
> --
> 2.17.1

