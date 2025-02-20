Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7D7C021AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 07:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9035610E8E6;
	Thu, 20 Feb 2025 07:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bSp2c41h";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A2710E8F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 07:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/YcpurMpXkW85FCPed0lIG09m9PuVjZNkGMPXuMzDWtV1H75MCyhjbLWaicnwjZ2BI2gCZ1EwkGnoSG88nytxkaZqoElEZW/b4gzRFdXvLHk2X3F8nDDb9lkkWch2IgtdeIAS1+NQjtn8uuRmMLUCNM2dXypu3HQPkG4/d2vE2gAsBzAaVP6wShZB/+DNqjZCpK4RT696QMsNqqwvFoz2h7qRcIXA4VMueMrC2M8y5m5QpmYuthflJ494el4aJQ08sZKnR2MWbygV2fy/dTVfa00Lf2XPOiyuW9kINHpXuvQQhYdq9d+oY16y1VzZDTi6mev4uTYtQw/HYgUpOVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLGvvnq/CgPRRKvr03sCeAXcPk0EpiaXM4bgWejKbSs=;
 b=Nf3PHx4QDWAbQQbH6NAqM/JzPa7fKW4LmCSSgKkjymWL2jTarhDjyRwqNdkJ/gDY7aR++lfsx4cm7Zw7zrIsBN4+UfgRgch+58xED3+k1GYiPcHkZ9KwUPRT1GwNJ1JJW48RKr9Rci67yQKfcj2gH9RG3B/XRwKkYHvkgAd+s+D9giASMsFi6Ec8rGCO2bfj+4/AXcDACngLkRCPLtWbVCEWq7CR5Z/mLJkgEWn48MezaIHoqG7kt3XiFWLJBSudZsFHVElXcPWrVyOD4wB5+B6XNj8dwkcEyXDiO9KE9kGK4k1unLn/gHlm3I41x4nViAHsBjI4J9nYBjxczYQgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLGvvnq/CgPRRKvr03sCeAXcPk0EpiaXM4bgWejKbSs=;
 b=bSp2c41h2PqH6HxZsfUVEXHz2bG49lXsh9CYVAsAuEaYRAMwd5JRZLHI2to3d/Wd2wzGqkG++BV8DWU7c2Y1BpTQ4wKfzNGVoLT0Nnd6rXqTdpOzoS+4uWuUogUgHKpsIIznhN8et4RFFHXaHqaFDGHxsMj75/8oLISc8WvkJWQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.23; Thu, 20 Feb
 2025 07:48:45 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 07:48:45 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Save nps to eeprom and refine code
Thread-Topic: [PATCH] drm/amdgpu: Save nps to eeprom and refine code
Thread-Index: AQHbg18cDCqwussRW0qSeI+gUu1EI7NPvt8g
Date: Thu, 20 Feb 2025 07:48:44 +0000
Message-ID: <PH7PR12MB87967C68A2640C9B92862DB4B0C42@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250220061637.1092474-1-ganglxie@amd.com>
In-Reply-To: <20250220061637.1092474-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=81b8eedc-8be1-454a-b281-d656352edbe4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T06:43:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS7PR12MB8417:EE_
x-ms-office365-filtering-correlation-id: 312221d2-c8d0-4166-3548-08dd518300a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rYTLiiuMQPwebQZZA43J5L3enND7EJl74YP4EjIH8jbg+G+ruQL2fpLwTW+f?=
 =?us-ascii?Q?oyXvIEykumVmMxYxVbJYkhh1dJh5XkWHD2GCCQ6+8ze7JfiXs4TEJVXUADcI?=
 =?us-ascii?Q?NwiGKfBDZwi2Eq5ZXjQjRDqMIcFmucmdMUqFSRDWyrQ0lE5SCWBR4gupfKFn?=
 =?us-ascii?Q?pFuC5hC3zzioYT/8Aqun3HNGoQ70o9AkMQkKSVpOsfQ7/Xl9pvqso5hf04Pm?=
 =?us-ascii?Q?tsLc3KT1RCWEoBxqVLqTOn2BXTX2TiHWyDB/vu2f7Wiis7g9SmAk2jKt8fZb?=
 =?us-ascii?Q?U29zyeNFu1AJ198D+eUyXm0Gb2R5d3mfooGo2J0b+oRJVChHdG3WhF9bHQpS?=
 =?us-ascii?Q?k1sRQoK6dkGYyD/R3nyIiYF2L4WOf/cVKCF65hfqCzI0WaAZ4XGYwrS4azg6?=
 =?us-ascii?Q?fYkp2fZ9c6i2J0ITDINAX6g8PFZQEtkvf7RfyvAkFSn7IJNaSSnqJw3AERBl?=
 =?us-ascii?Q?uQYF3+KwNY68203M2DOkuy1mT/8KV+4lOm3+d9xud2NiXfI2+08VfP0uiVbV?=
 =?us-ascii?Q?2rddziM36NXJOCwqiOnXQb5lab9Xq+nnX6c3DZZpPkJpnAl7UwmUUT+gcQiW?=
 =?us-ascii?Q?H1cUtQmmbGunl8SLATxLx/buK7tHNDcj3oRt/7IZgz7/pQMX0/HNT6Fo5xcU?=
 =?us-ascii?Q?S/sXwIXHZ+JGEX7bbO5A1p8x2JR1twR91088Y5rSfkamnfviIWTtjsE3WGKS?=
 =?us-ascii?Q?nA1qKf7j3OfhhS85pxHwNGH419o5iCaGsGThBQ2Cz/NybFFyzYvh1Q9rTwo7?=
 =?us-ascii?Q?FIZCxftMQU9C0X6RPYTJC2YE1s2xU1VeZyEbfuqcMg6wOrw5tBUhbPaBz7W8?=
 =?us-ascii?Q?gVMzpDBzfGzmi8gpbVqsDdsQW7t3N4VhvYAJgfNXfkz6kqFRmKrF3ju86bPB?=
 =?us-ascii?Q?cgDj8ufUzNZTG4IlZwZikefQKS9y6K40/eQWwdDpPGBMfd02rlLRsDoLYGPM?=
 =?us-ascii?Q?01dWJrEvh+fqq+B54i/+OjZIROwkf6AFDlc22pkkflcJhOt8YOPYIVakeLQe?=
 =?us-ascii?Q?TdEqenLJLqRSnX0Idhd8qFdcYxFKZi2W1lvWB3TMa08PPo8B1h1RaZ0g8p+e?=
 =?us-ascii?Q?3khdI2mafGsWdHQgyerMWIISUbKJy5eewGMb4LH+XeRaIrYaFXVlx6VK+jpp?=
 =?us-ascii?Q?5/Z2rvii5XsqADxCZcHcvb14379L8jhK3WfwJ9yrLzhhXCET32rr4n3e5875?=
 =?us-ascii?Q?KmWf5vVaWIdKUMWRDJkJTMlTEczNtWcRJMYKbwgkTcGF2s2bdkQXbSY7riih?=
 =?us-ascii?Q?qR9RpVtFD46SUQ0ySLSXGxCYQXRAUwZjmnN2Z7pgU0KYIcmaDjtBC2fP4eoC?=
 =?us-ascii?Q?Ib3HO42aQY7QhGNmSvXlg0JvYaygW2h4hNMzX69jU/umpibK0RvckzM5wtmA?=
 =?us-ascii?Q?XOXTgECDVfM+q8ScKrG4NkXPWeDKZZCeQSiCvAWOTGhWGCaMZM7Oqv/ZYrZh?=
 =?us-ascii?Q?+rs5VBFPiTJS1bqPIYrHmAPppwQzcNon?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eAS5uE8zSBvshfKorVI5bQ22WQ1LeLMgSlLXosiGxhbnbUikw+rd24lhFdvk?=
 =?us-ascii?Q?WcvJWyceCKzg+CQkIlTfaptkSkwK/ht/OXqhVjxZ26mwDRQ+6nsUp85UW6xe?=
 =?us-ascii?Q?/fiKt8eYUNHL4n+M/r4t5F3xIuIeNaNppha9r8gp7bRgeV/6KQvaGPGAqPGe?=
 =?us-ascii?Q?LzrLKQWXcswNpbOqZM5taI4oh5xgf5cshYzuxkHEt+v+yb0odLRkjOTHvoET?=
 =?us-ascii?Q?0kz+V5ILmQksKkyeKN15Cedp2F32ON7kSJaxX5Pn4rLx0X3qAyNvVuooRwH4?=
 =?us-ascii?Q?VRf0cQn+fo4z/+DSpIaRrXdllJi30UQf73fNhC4L1MvYqqO2ZAAEMb9qJQ2V?=
 =?us-ascii?Q?tfJnIRVa+S+AWMFMvbg4sCaqujaZsFO9d6gn2S7Bqxxoo5hMp78zdXG82SRS?=
 =?us-ascii?Q?03g32FlYPCh57tSb5gnhc7R1kEGwNDFeo6362gdAoRzmzn8EydBoBGMpqh+N?=
 =?us-ascii?Q?6HgPK1thnGHfhthX6ZREtFLxiu3hul9cxbYlstfQRA45A/vLA5vO3Yyo8Iny?=
 =?us-ascii?Q?LPGf0cJRUdpblWzVSwK/+PaSNFW8dXC8pENVQ7cIy3JxmiKZ/1etXAx6Enwd?=
 =?us-ascii?Q?2k+e818ETGwQmwtLaTADQ9ZgqPvFsJr2CZ5mjtGeNE7B7t9iTj1INDEI9GTA?=
 =?us-ascii?Q?r2JaE8AdkI/o+hf4Xm1eQvW98zr8gWaEECVlB69YVoV+fCfqkhoJUY4ZMkJQ?=
 =?us-ascii?Q?/zw54CEroupkDMhW+RDPQ8iNPp5599CucGLfd4W2ILwc3Kw+BnmfCdboy2ZW?=
 =?us-ascii?Q?/d4yrc4DStNnzGbUZdjX8QWZ7p42knLCGWLPOAOR8K0Fo8nduUWyOkfko2GQ?=
 =?us-ascii?Q?GJcXTBMqvBA7fonASiD5hs6nIuePu+rGgzc1dV2t1lrq2tWUXu/oXGGYBn/4?=
 =?us-ascii?Q?fHaMOT1cicQhNhlza+REZpr75W4seZz9MX/huCiDWPcBoZHAPtDVS7j1jeCu?=
 =?us-ascii?Q?y01v6BdzGpk1vL4CBpv6R4MCRVHhvhTgNwhuWDi4oz98n/MQBvIUCsSOc3Zb?=
 =?us-ascii?Q?ysb9rKdgbY8fOiEl/K+o/7jAh+c2y8Z+/EAFy9lO0PwDZm/LKnTqftygbEXL?=
 =?us-ascii?Q?XSXF2Ne7JCpz29T0ba/daAjO/lFYGnVNAiKehuKB3aAXUOVpke8VR5IsytCa?=
 =?us-ascii?Q?B6yW1XeFykKGk+ns8R1MlgIq6d8UHP1PBfT3U0YSs+kLlOZmQjH+xu/4G+vD?=
 =?us-ascii?Q?kUahbSEstEmo7tr0Tu2LkSjEDjAEPOyRsRq1gRAgHdvJ58kFarX9UUd1C/dm?=
 =?us-ascii?Q?u/ycG5C1TgJzprC5HLaafsAftXCkkb479H3VImgBe0eoVr6ss+x29gC1B+7X?=
 =?us-ascii?Q?DlD2Zg1zc/TKIky7idzEIAxh/AdfPy5go91SuHj1YabelMzUjk8NnNAw+miV?=
 =?us-ascii?Q?bC3bzKBKyOv0002Hr0Ft/foKqytSZQdsMKGhMv38SCtEDtjISc5gTdDqQYIU?=
 =?us-ascii?Q?hRhTFH2GThLK/Rf3/QpPqG3t4XSNFDvFLjqmGoZ93IxWscGFK8o7iQqw2lvG?=
 =?us-ascii?Q?taVYZbZVZKR4+mqiMuHO5znxBFVp2hnBovOV3w0MQe3KuVEcQPCDEj6p/soo?=
 =?us-ascii?Q?1Z2mwGbyLhlmuokMYio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312221d2-c8d0-4166-3548-08dd518300a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 07:48:44.9111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1mnOsfzZUtJh6Nj6GhD57dI1Xl6WldbtmGsglB+KX0cffxaXxOp+vqyVyI/ZW+d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
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

Please split the patch into at least three parts, one for bad page/record n=
umber calculation based on nps, one for nps saving and the third one for co=
de refine of bad page add.
Please check my inline comments for other suggestions.

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Thursday, February 20, 2025 2:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: Save nps to eeprom and refine code
>
> add nps info into eeprom records, and refine adding bad page logic based =
on nps
> info.
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 244 +++++++++---------
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  25 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  20 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |   7 +
>  4 files changed, 153 insertions(+), 143 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5420e2d6d244..3945dda54b3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2801,20 +2801,101 @@ static int amdgpu_ras_mca2pa(struct amdgpu_devic=
e
> *adev,
>               return  -EINVAL;
>  }
>
> +static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
> +                                     struct eeprom_table_record *bps, in=
t count) {
> +     int j;
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     struct ras_err_handler_data *data =3D con->eh_data;
> +
> +     for (j =3D 0; j < count; j++) {
> +             if (amdgpu_ras_check_bad_page_unlock(con,
> +                     bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT))
> +                     continue;
> +
> +             if (!data->space_left &&
> +                     amdgpu_ras_realloc_eh_data_space(adev, data, 256)) =
{
> +                     return -ENOMEM;
> +             }
> +
> +             amdgpu_ras_reserve_page(adev, bps[j].retired_page);
> +
> +             memcpy(&data->bps[data->count], &(bps[j]),
> +                             sizeof(struct eeprom_table_record));
> +             data->count++;
> +             data->space_left--;
> +     }
> +
> +     return 0;
> +}
> +
> +static int __amdgpu_ras_convert_unit_rec_from_rom(struct amdgpu_device *=
adev,

[Tao] for the name of unit_rec, how about rec_array?

> +                             struct eeprom_table_record *bps, struct ras=
_err_data
> *err_data,
> +                             enum amdgpu_memory_partition nps)
> +{
> +     int i =3D 0;
> +     int ret =3D 0;
> +     enum amdgpu_memory_partition save_nps;
> +
> +     save_nps =3D (bps[0].retired_page >> UMC_NPS_SHIFT) &
> UMC_NPS_MASK;
> +
> +     for (i =3D 0; i < adev->umc.retire_unit; i++)
> +             bps[i].retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
> +
> +     if (save_nps) {
> +             if (save_nps =3D=3D nps) {
> +                     if (amdgpu_umc_pages_in_a_row(adev, err_data,
> +                                     bps[0].retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> +                             return -EINVAL;
> +             } else {
> +                     if (amdgpu_ras_mca2pa_by_idx(adev, &bps[0], err_dat=
a))
> +                             return -EINVAL;
> +             }
> +     } else {
> +             if (amdgpu_ras_mca2pa(adev, &bps[0], err_data)) {
> +                     if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE)
> +                             memcpy(err_data->err_addr, bps,
> +                                     sizeof(struct eeprom_table_record) =
* adev-
> >umc.retire_unit);
> +                     else
> +                             return -EOPNOTSUPP;
> +             }
> +     }
> +
> +     return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
> +adev->umc.retire_unit); }
> +
> +static int __amdgpu_ras_convert_single_rec_from_rom(struct amdgpu_device

[Tao] we can name it as __amdgpu_ras_convert _rec_from_rom for short

> *adev,
> +                             struct eeprom_table_record *bps, struct ras=
_err_data
> *err_data,
> +                             enum amdgpu_memory_partition nps)
> +{
> +     enum amdgpu_memory_partition save_nps;
> +
> +     save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
> +     bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
> +
> +     if (save_nps =3D=3D nps) {
> +             if (amdgpu_umc_pages_in_a_row(adev, err_data,
> +                             bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> +                     return -EINVAL;
> +     } else {
> +             if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
> +                     return -EINVAL;
> +     }
> +     return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
> +                                                                     ade=
v-
> >umc.retire_unit);
> +}
> +
>  /* it deal with vram only. */
>  int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>               struct eeprom_table_record *bps, int pages, bool from_rom) =
 {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> -     struct ras_err_handler_data *data;
>       struct ras_err_data err_data;
> -     struct eeprom_table_record *err_rec;
>       struct amdgpu_ras_eeprom_control *control =3D
>                       &adev->psp.ras_context.ras->eeprom_control;
>       enum amdgpu_memory_partition nps =3D
> AMDGPU_NPS1_PARTITION_MODE;
>       int ret =3D 0;
> -     uint32_t i, j, loop_cnt =3D 1;
> -     bool find_pages_per_pa =3D false;
> +     uint32_t i;
>
>       if (!con || !con->eh_data || !bps || pages <=3D 0)
>               return 0;
> @@ -2825,108 +2906,41 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>                               sizeof(struct eeprom_table_record), GFP_KER=
NEL);
>               if (!err_data.err_addr) {
>                       dev_warn(adev->dev, "Failed to alloc UMC error addr=
ess
> record in mca2pa conversion!\n");
> -                     ret =3D -ENOMEM;
> -                     goto out;
> +                     return -ENOMEM;
>               }
>
> -             err_rec =3D err_data.err_addr;
> -             loop_cnt =3D adev->umc.retire_unit;
>               if (adev->gmc.gmc_funcs->query_mem_partition_mode)
>                       nps =3D adev->gmc.gmc_funcs-
> >query_mem_partition_mode(adev);
>       }
>
>       mutex_lock(&con->recovery_lock);
> -     data =3D con->eh_data;
> -     if (!data) {
> -             /* Returning 0 as the absence of eh_data is acceptable */
> -             goto free;
> -     }
> -
> -     for (i =3D 0; i < pages; i++) {
> -             if (from_rom &&
> -                 control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_MCA) {
> -                     if (!find_pages_per_pa) {
> -                             if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i],
> &err_data)) {
> -                                     if (!i && nps =3D=3D
> AMDGPU_NPS1_PARTITION_MODE) {
> -                                             /* may use old RAS TA, use =
PA to find
> pages in
> -                                              * one row
> -                                              */
> -                                             if
> (amdgpu_umc_pages_in_a_row(adev, &err_data,
> -
> bps[i].retired_page <<
> -
> AMDGPU_GPU_PAGE_SHIFT)) {
> -                                                     ret =3D -EINVAL;
> -                                                     goto free;
> -                                             } else {
> -                                                     find_pages_per_pa =
=3D true;
> -                                             }
> -                                     } else {
> -                                             /* unsupported cases */
> -                                             ret =3D -EOPNOTSUPP;
> -                                             goto free;
> -                                     }
> -                             }
> -                     } else {
> -                             if (amdgpu_umc_pages_in_a_row(adev, &err_da=
ta,
> -                                             bps[i].retired_page <<
> AMDGPU_GPU_PAGE_SHIFT)) {
> -                                     ret =3D -EINVAL;
> -                                     goto free;
> -                             }
> -                     }
> -             } else {
> -                     if (from_rom && !find_pages_per_pa) {
> -                             if (bps[i].retired_page & UMC_CHANNEL_IDX_V=
2) {
> -                                     /* bad page in any NPS mode in eepr=
om */
> -                                     if (amdgpu_ras_mca2pa_by_idx(adev, =
&bps[i],
> &err_data)) {
> -                                             ret =3D -EINVAL;
> +
> +     if (from_rom) {
> +             for (i =3D 0; i < pages; i++) {
> +                     if (control->ras_num_recs - i >=3D adev->umc.retire=
_unit) {
> +                             if ((bps[i].address =3D=3D bps[i + 1].addre=
ss) &&
> +                                     (bps[i].mem_channel =3D=3D bps[i +

[Tao] here should use space instead of tab

> 1].mem_channel)) {
> +                                     //deal retire_unit records a time

[Tao] deal with

> +                                     ret =3D
> __amdgpu_ras_convert_unit_rec_from_rom(adev,
> +                                                                     &bp=
s[i],
> &err_data, nps);
> +                                     if (ret)
>                                               goto free;
> -                                     }
> +                                     i +=3D (adev->umc.retire_unit - 1);
>                               } else {
> -                                     /* legacy bad page in eeprom, gener=
ated only
> in
> -                                      * NPS1 mode
> -                                      */
> -                                     if (amdgpu_ras_mca2pa(adev, &bps[i]=
,
> &err_data)) {
> -                                             /* old RAS TA or ASICs whic=
h don't
> support to
> -                                              * convert addrss via mca a=
ddress
> -                                              */
> -                                             if (!i && nps =3D=3D
> AMDGPU_NPS1_PARTITION_MODE) {
> -                                                     find_pages_per_pa =
=3D true;
> -                                                     err_rec =3D &bps[i]=
;
> -                                                     loop_cnt =3D 1;
> -                                             } else {
> -                                                     /* non-nps1 mode, o=
ld RAS TA
> -                                                      * can't support it
> -                                                      */
> -                                                     ret =3D -EOPNOTSUPP=
;
> -                                                     goto free;
> -                                             }
> -                                     }
> +                                     break;
>                               }
> -
> -                             if (!find_pages_per_pa)
> -                                     i +=3D (adev->umc.retire_unit - 1);
>                       } else {
> -                             err_rec =3D &bps[i];
> +                             break;
>                       }
>               }
> -
> -             for (j =3D 0; j < loop_cnt; j++) {
> -                     if (amdgpu_ras_check_bad_page_unlock(con,
> -                             err_rec[j].retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> -                             continue;
> -
> -                     if (!data->space_left &&
> -                         amdgpu_ras_realloc_eh_data_space(adev, data, 25=
6)) {
> -                             ret =3D -ENOMEM;
> +             for (; i < pages; i++) {
> +                     ret =3D __amdgpu_ras_convert_single_rec_from_rom(ad=
ev,
> +                             &bps[i], &err_data, nps);
> +                     if (ret)
>                               goto free;
> -                     }
> -
> -                     amdgpu_ras_reserve_page(adev, err_rec[j].retired_pa=
ge);
> -
> -                     memcpy(&data->bps[data->count], &(err_rec[j]),
> -                                     sizeof(struct eeprom_table_record))=
;
> -                     data->count++;
> -                     data->space_left--;
>               }
> +     } else {
> +             ret =3D __amdgpu_ras_restore_bad_pages(adev, bps, pages);
>       }
>
>  free:
> @@ -2971,24 +2985,14 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev,
>
>       /* only new entries are saved */
>       if (save_count > 0) {
> -             if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_PA) {
> +             for (i =3D 0; i < unit_num; i++) {
>                       if (amdgpu_ras_eeprom_append(control,
> -                                                  &data->bps[control->ra=
s_num_recs],
> -                                                  save_count)) {
> +                                     &data->bps[bad_page_num + i * adev-
> >umc.retire_unit],
> +                                     1)) {
>                               dev_err(adev->dev, "Failed to save EEPROM t=
able
> data!");
>                               return -EIO;
>                       }
> -             } else {
> -                     for (i =3D 0; i < unit_num; i++) {
> -                             if (amdgpu_ras_eeprom_append(control,
> -                                             &data->bps[bad_page_num + i=
 * adev-
> >umc.retire_unit],
> -                                             1)) {
> -                                     dev_err(adev->dev, "Failed to save =
EEPROM
> table data!");
> -                                     return -EIO;
> -                             }
> -                     }
>               }
> -
>               dev_info(adev->dev, "Saved %d pages to EEPROM table.\n",
> save_count);
>       }
>
> @@ -3005,6 +3009,7 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>               &adev->psp.ras_context.ras->eeprom_control;
>       struct eeprom_table_record *bps;
>       int ret;
> +     int i =3D 0;

[Tao] I prefer to "int ret, i =3D 0;"

>
>       /* no bad page record, skip eeprom access */
>       if (control->ras_num_recs =3D=3D 0 || amdgpu_bad_page_threshold =3D=
=3D 0) @@ -
> 3018,13 +3023,23 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>       if (ret) {
>               dev_err(adev->dev, "Failed to load EEPROM table records!");
>       } else {
> -             if (control->ras_num_recs > 1 &&
> -                 adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
> -                     if ((bps[0].address =3D=3D bps[1].address) &&
> -                         (bps[0].mem_channel =3D=3D bps[1].mem_channel))
> -                             control->rec_type =3D
> AMDGPU_RAS_EEPROM_REC_PA;
> -                     else
> -                             control->rec_type =3D
> AMDGPU_RAS_EEPROM_REC_MCA;
> +             if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
> +                     for (i =3D 0; i < control->ras_num_recs; i++) {
> +                             if ((control->ras_num_recs - i) >=3D adev-
> >umc.retire_unit) {
> +                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> +                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> +                                             control->ras_num_pa_recs +=
=3D adev-
> >umc.retire_unit;
> +                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                                     } else {
> +                                             control->ras_num_mca_recs +=
=3D
> +                                                                     (co=
ntrol-
> >ras_num_recs - i);
> +                                             break;
> +                                     }
> +                             } else {
> +                                     control->ras_num_mca_recs +=3D (con=
trol-
> >ras_num_recs - i);
> +                                     break;
> +                             }
> +                     }
>               }
>
>               ret =3D amdgpu_ras_eeprom_check(control); @@ -3438,12 +3453=
,7
> @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
>               return ret;
>
>       if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
> -             control->rec_type =3D AMDGPU_RAS_EEPROM_REC_PA;
> -
> -     /* default status is MCA storage */
> -     if (control->ras_num_recs <=3D 1 &&
> -         adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
> -             control->rec_type =3D AMDGPU_RAS_EEPROM_REC_MCA;
> +             control->ras_num_pa_recs =3D control->ras_num_recs;
>
>       if (control->ras_num_recs) {
>               ret =3D amdgpu_ras_load_bad_pages(adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 83b54efcaa87..ab27cecb5519 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -727,11 +727,9 @@ amdgpu_ras_eeprom_append_table(struct
> amdgpu_ras_eeprom_control *control,
>                                    - control->ras_fri)
>               % control->ras_max_record_count;
>
> -     if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_PA)
> -             control->ras_num_bad_pages =3D control->ras_num_recs;
> -     else
> -             control->ras_num_bad_pages =3D
> -                     control->ras_num_recs * adev->umc.retire_unit;
> +     control->ras_num_mca_recs +=3D num;
> +     control->ras_num_bad_pages +=3D num * adev->umc.retire_unit;
> +
>  Out:
>       kfree(buf);
>       return res;
> @@ -852,6 +850,7 @@ int amdgpu_ras_eeprom_append(struct
> amdgpu_ras_eeprom_control *control,  {
>       struct amdgpu_device *adev =3D to_amdgpu_device(control);
>       int res, i;
> +     uint64_t nps =3D AMDGPU_NPS1_PARTITION_MODE;
>
>       if (!__is_ras_eeprom_supported(adev))
>               return 0;
> @@ -865,9 +864,12 @@ int amdgpu_ras_eeprom_append(struct
> amdgpu_ras_eeprom_control *control,
>               return -EINVAL;
>       }
>
> +     if (adev->gmc.gmc_funcs->query_mem_partition_mode)
> +             nps =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev)=
;
> +
>       /* set the new channel index flag */
>       for (i =3D 0; i < num; i++)
> -             record[i].retired_page |=3D UMC_CHANNEL_IDX_V2;
> +             record[i].retired_page |=3D (nps << UMC_NPS_SHIFT);
>
>       mutex_lock(&control->ras_tbl_mutex);
>
> @@ -881,7 +883,7 @@ int amdgpu_ras_eeprom_append(struct
> amdgpu_ras_eeprom_control *control,
>
>       /* clear channel index flag, the flag is only saved on eeprom */
>       for (i =3D 0; i < num; i++)
> -             record[i].retired_page &=3D ~UMC_CHANNEL_IDX_V2;
> +             record[i].retired_page &=3D ~(nps << UMC_NPS_SHIFT);
>
>       return res;
>  }
> @@ -1392,6 +1394,8 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control)
>       }
>       control->ras_fri =3D RAS_OFFSET_TO_INDEX(control, hdr->first_rec_of=
fset);
>
> +     control->ras_num_mca_recs =3D 0;
> +     control->ras_num_pa_recs =3D 0;
>       return 0;
>  }
>
> @@ -1412,11 +1416,8 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>       if (!__get_eeprom_i2c_addr(adev, control))
>               return -EINVAL;
>
> -     if (control->rec_type =3D=3D AMDGPU_RAS_EEPROM_REC_PA)
> -             control->ras_num_bad_pages =3D control->ras_num_recs;
> -     else
> -             control->ras_num_bad_pages =3D
> -                     control->ras_num_recs * adev->umc.retire_unit;
> +     control->ras_num_bad_pages =3D control->ras_num_pa_recs +
> +                     control->ras_num_mca_recs * adev->umc.retire_unit;
>
>       if (hdr->header =3D=3D RAS_TABLE_HDR_VAL) {
>               DRM_DEBUG_DRIVER("Found existing EEPROM table with %d
> records", diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 81d55cb7b397..13f7eda9a696 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -43,19 +43,6 @@ enum amdgpu_ras_eeprom_err_type {
>       AMDGPU_RAS_EEPROM_ERR_COUNT,
>  };
>
> -/*
> - * one UMC MCA address could map to multiply physical address (PA),
> - * such as 1:16, we use eeprom_table_record.address to store MCA
> - * address and use eeprom_table_record.retired_page to save PA.
> - *
> - * AMDGPU_RAS_EEPROM_REC_PA: one record store one PA
> - * AMDGPU_RAS_EEPROM_REC_MCA: one record store one MCA address
> - */
> -enum amdgpu_ras_eeprom_rec_type {
> -     AMDGPU_RAS_EEPROM_REC_PA,
> -     AMDGPU_RAS_EEPROM_REC_MCA,
> -};
> -
>  struct amdgpu_ras_eeprom_table_header {
>       uint32_t header;
>       uint32_t version;
> @@ -100,6 +87,12 @@ struct amdgpu_ras_eeprom_control {
>        */
>       u32 ras_num_bad_pages;
>
> +     /* Number of records store mca address */
> +     u32 ras_num_mca_recs;
> +
> +     /* Number of records store physical address */
> +     u32 ras_num_pa_recs;
> +
>       /* First record index to read, 0-based.
>        * Range is [0, num_recs-1]. This is
>        * an absolute index, starting right after @@ -120,7 +113,6 @@ stru=
ct
> amdgpu_ras_eeprom_control {
>       /* Record channel info which occurred bad pages
>        */
>       u32 bad_channel_bitmap;
> -     enum amdgpu_ras_eeprom_rec_type rec_type;
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index a4a7e61817aa..857693bcd8d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -71,6 +71,13 @@
>   */
>  #define UMC_CHANNEL_IDX_V2   BIT_ULL(47)
>
> +/*
> + * save nps value to eeprom_table_record.retired_page[47:40],
> + * the channel index flag above will be retired.
> + */
> +#define UMC_NPS_SHIFT 40
> +#define UMC_NPS_MASK 0xffULL
> +
>  typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
>                       uint32_t umc_inst, uint32_t ch_inst, void *data);
>
> --
> 2.34.1

