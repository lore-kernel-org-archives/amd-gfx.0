Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FC5CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 17:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B45B10EA5A;
	Fri, 19 Sep 2025 17:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L1jwllJN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE43510EA5A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 17:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwQuutyYbBs4HQcTYgVaLxrsDX6a0pFMaPDpcsomzYKCidLVd8oHAsWNcauw9staYCkb4TfznQ9ca1YlvbfSRoS8H0r7uwMDrVKFVHPD2bJHE6GY9Io2NtGlyiX9+LiIwFlfI5csZpvLVqfY+U8b3NYJRhU2naMVLmsVo/GtrTB1rVAtT6WS2NydoluJ97tZJga9NH68+d4scV3pXBXz06WypkhTpbSDH2v3YatwB9ex8N3xCwzadRDqC/uQDuXAvZZ8ZX4agpn0lUC9ZDNs0uQ17J426dAbrgggEkmJkns6Ae/XbDWOPIsea3Jl5Teh+amLDNK3CyXyhWIp2womYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSFW5c/0FZYB6FFCq/ij3n9DuoOIBOCVcJtyNCUmfqU=;
 b=nW4hl2U7oePc66rLkK6wfW6UMsgbCFo4xj6r5L7jziDO2VrRqfmRYyWPTRjIceoaq2NOyYAMrwyy7X7TljRMBmbTi8WDBFkN+zq5Q9E62PoZBtN5UIa+sNvKgZUMQNjV2Vj/mP7xr9aN6o3atpswP476X1nS5Di6DZcAG/WAq+zv1orjjERVekAmdbpIAabp00aCKcGt57/ziWmVHLtawfySuG3D2sOEfcfBvJXGa7xMRbU1Z3YaBLY5tpee8df0IeaN/z8CgnE/rZUXdkoBkdlYvaBrXmkbx8aIT1VAlsAoAPN0UVj72Vt/JEIR+26PeV6Pa+jNMAJogbMTHisP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSFW5c/0FZYB6FFCq/ij3n9DuoOIBOCVcJtyNCUmfqU=;
 b=L1jwllJNSimbKA1zNeMzpwjacTbvervPRjk3dhcw6Pw+re8LieJfZEleKhRtPD5s4Auw1nYc5sNa1wqeX80ObZt2eziSgC1qGgubo6g7dJxGVJtnCnwTzqUHBvl+cAbv0XvNRcfSRc7qCm25o6x8rttthbiOmemaHM5mqmEAFwE=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Fri, 19 Sep 2025 17:06:10 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%3]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 17:06:10 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update amdgpu_vcn5_fw_shared for vcn_5_0_1
Thread-Topic: [PATCH] drm/amdgpu: Update amdgpu_vcn5_fw_shared for vcn_5_0_1
Thread-Index: AQHcKL+LeaJO16B1fkyzPv6ALcdDo7Savc9g
Date: Fri, 19 Sep 2025 17:06:10 +0000
Message-ID: <DM8PR12MB539977194A4D6B6E8914B14FE511A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250918171252.2490673-1-sonny.jiang@amd.com>
In-Reply-To: <20250918171252.2490673-1-sonny.jiang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-19T17:05:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DS7PR12MB8345:EE_
x-ms-office365-filtering-correlation-id: 22f503fb-d9b0-4689-ec6b-08ddf79ed4b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lgypOjj5ED8rd+DPiMygXFZ/XBujCPDQDwprOhx/7Ole/U5gYXf0HtjUMwLK?=
 =?us-ascii?Q?ei7TE8nnWwtdKI7bakCqhYfn2n4GZDA0DYxvsmxHZFtQsB75rnMNLp9Cgj6l?=
 =?us-ascii?Q?DKx/WbQsFSBP4KYKUUO8I9mlQqs/Xfx8hndhiNOfLO0lP7Hi7j78yFouqUaU?=
 =?us-ascii?Q?yPV/E5kWdYBwZ94G0XIm9tRlwahEWKgDYVvnhaI7DsFVXpPyxLCgdNZ80+K0?=
 =?us-ascii?Q?bffCzFIfxPHPBNnhjKbWWpnJMeb7dUBiEZ0kIGlJmJB5m4xBkUvFSmEh/x2F?=
 =?us-ascii?Q?OIOzb3MdCLg4J0D8xqwqP+LAxbUNncNi3IQU6r76tc++D25eo2kFhLXpmxZ1?=
 =?us-ascii?Q?a3qGVwrLHVMpPuf8B3hxlGeWb2EZxKdG8DONmJEU2JyEENDH0Jb2f32l4ZOn?=
 =?us-ascii?Q?ZYzZNip26OjE2/G7YtHr1WY7cKzl78rqgk+TipP8tLHFplEJXrAXmHbf3pZA?=
 =?us-ascii?Q?flVtnrzeJKUKnr4mnREZ8jFHNLGCexmyXfqOtPSwkRj9YNjXElYAobZp02/s?=
 =?us-ascii?Q?dkNxAcB4oHFlvmBRBweIFbLqEvo4ef2EuATlJgh4Q/B0IjWLpmXL1WJgugkK?=
 =?us-ascii?Q?CMlsyCHu6Cs+kw2kJKgt66hBYX/d4znA1yYJ1h5qMPuiustC+Zy7u4QjhOzk?=
 =?us-ascii?Q?ghOXd4quT6vrnz7wtNsTwgIoaZL78qQbqPgC9xs5LK/AQF0YCLelfl1wUhDV?=
 =?us-ascii?Q?rbm/E7ayloBrsYlHLxjJufoaPsBujIVB2ZGuAaGmV6kNczN2iENptYp+Im/d?=
 =?us-ascii?Q?Zzv9MhBk/g21sluUPLOZkBRmJru3noNHUFeQl90Rm8iWJGaCoUliIqw67i5F?=
 =?us-ascii?Q?y2imEHtXWNjGRdnQtNWYOUsmE3GWnSvumZUr4ZXFhXYCRoHtBxGDihLOKU0u?=
 =?us-ascii?Q?Y+eQ5zIUvhCez2LejqnAQark+lhRHJywvL13dOcEpFYuuMyDMdj7LfUVNrPk?=
 =?us-ascii?Q?fJha1qpOD8RsArYptCGomy04dRF/83Na8njix1SOiqKEaSzzMRz23NPnrdaJ?=
 =?us-ascii?Q?IxlnjMCJLENOg8xpnshkn9LkJgMWM0mEVx84sDIfS9anrsc//RpYBmNGRwrD?=
 =?us-ascii?Q?tY+Wv5xQrWI60oPtELVkQXqTOBkbtU/aWj/Po5JjA8xHZ+vIL6NB6rxR49iC?=
 =?us-ascii?Q?7wHuqdkcx/JXYpVJnkmIqlffxE8krZJeCS+a5J1dvLbcarc7PHJyc1Y3e34A?=
 =?us-ascii?Q?jYkqW1jJ0VAriEc1Fbm/7gOPwesjjcuYN1adrKTHl3j+UN4XLJr2MaARI9mx?=
 =?us-ascii?Q?NJJK8OvzCmi5OtOuvJS2NTkTidb1ZhymbfuZGlD0FeaP66XAAAdRC5rkfgGC?=
 =?us-ascii?Q?Lm96JmSCALxrJ951kntdFMMEfWhCF3Fl87f6XSx06u1Nu+9jkNV06NXJE9mg?=
 =?us-ascii?Q?byw2JGWj89SY+hvsmzAs43sIxzCDhBzoRO5zBO7qAT/dpP15gPncKAJoTKI7?=
 =?us-ascii?Q?qaHT4lyJfIxpA8mQarvIoIh2aabQI1xKfAvJAg7Jd0ZetLYn3R7QPw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7+3XIB7U7UmMXsFYkB5KvQwdLa2eALx3IpX5VDYroedIn7olIE9eKEfZNCwf?=
 =?us-ascii?Q?32v+WdrBFx5559DZ0d2+1UvJEfBmj6i7XrjnBpSIvUTz+tHCK63PgqyMa7mt?=
 =?us-ascii?Q?MHPB8n84xYaVZ3v9V6zHp7KREK8A2WHYtaugt9c1uHONNqMZlkB5cd44C+4j?=
 =?us-ascii?Q?CCdd23eoIdzzDJoUCNKxsN/QIq6+q/3NIL8+V34EHsuw0mGKdaYANQ+WiXaM?=
 =?us-ascii?Q?gtBeEdkUAW5GZ+tF/0u8NMWYwbaofbeJCr4D7QC4pLvHsaDyXF5fYTZPIZ19?=
 =?us-ascii?Q?i5eBKRFLa5bktm+9DaJj6zkQ56ZDTWKQ0nmz2bW7X4hmcngRce1IEZ9oP7u2?=
 =?us-ascii?Q?RNluiaUuJpQIDEYoT7TnTykFRieIElpCnqIIPVWCDjdmrMaz4aDYnDrcyXWd?=
 =?us-ascii?Q?9XFPB/GZuFCSRd+V3hmKAVuRJUnFJjr91B5OxXR/qLXchu0FHQ70zPXgIOSE?=
 =?us-ascii?Q?9oxPhp3ayo2OQsCnEhDFOMlXw3JpJqzcJkIB3O2ZPYDgMmF+3fbVBOyxi/Hu?=
 =?us-ascii?Q?q0Q891+zOG7cgY/6e/esES2vBSHOG3mFRw9q4GXpMLLenSk4Jxwsl2pFofz+?=
 =?us-ascii?Q?TySdLVfu8Xud7fAr5KunLGcwAeQBb8t4Ljst4aOskjwfCi1XDVXHmWvEEI9v?=
 =?us-ascii?Q?IGktJ1731muEg8Gi+miFm8B1HobxCfslqJoZ8YGppu6ldqdG0eu/KEH/ms7H?=
 =?us-ascii?Q?nO1t+m35CJ0+ccTn+Da3oxACO4xImVNyiuZ0UsUeLDJ04w+09vAYlvmYbd/G?=
 =?us-ascii?Q?SKbp4BExBM/mdDcRpHEVbF43V5MuRryPvRtrN5UP9tkRhIRrSkk1jm9iNLtj?=
 =?us-ascii?Q?Pmdu80LMIfJMb37CoKLKm68IsZejT7H0ccIq2ugAfeqZTeYcOez2I9Y7W9r7?=
 =?us-ascii?Q?KRjielNV1zSsKMjI9kwOVk0JHJtHW/c4+t7KYSU9xHSah+YGx5qn6nVvCxeN?=
 =?us-ascii?Q?Ujkxwxn4NksbojjuUt2sBEoE6mTtl7gevYapg+4y2T5SMhAeok98p1wCkDO2?=
 =?us-ascii?Q?Mmk5yepJRfQNqcxul3lI3rOeBpDJtVE1YxPBKQiueMm+x+7J5RNRiggpvZM/?=
 =?us-ascii?Q?Q0q/T6H/yDUct8i4KmgJfaHivBIj5IhnF7OiC7yAsyzNtfET2wXf4r00dgjG?=
 =?us-ascii?Q?3QiT9cuetO83lX0Y/NFoKylgPY16FRnhu0gvg3V4f133YehD9s0Z10D50C1D?=
 =?us-ascii?Q?43IzH6vt/SJyQuieDDYNOfjfb/ZJKyV5rk2lLn6gvhW90UxAvvzI6ZHWLdzs?=
 =?us-ascii?Q?eTAicYT7+Kh0CcWUnapj6SykIjy9WZgqfFat6wCZc4x0MvrfyFNCg/73Y+Nb?=
 =?us-ascii?Q?gG0QsRO142O3FTL2GtBwLJs3qYvPEquQbYxdelbV2DRFXWjNVYoAgXQLeRp2?=
 =?us-ascii?Q?3g8F51as2LlCSPzyk3Zt2sUBAEAh/Mp9N2QQvsF5lxAq/QdICpGQIX8ZKan6?=
 =?us-ascii?Q?nRLoAGRc1cekW5Op/4sWHRG8qCW4ueYf7j+ABEGytB/SuFz/mR6KPhxs2LM1?=
 =?us-ascii?Q?7X9oc/YCMdxMnPaLzuAil5CYY9O4LikMmRldsADxhHpsGlN6ugYJMRwFIw7s?=
 =?us-ascii?Q?NsLVeH2nKbMgP6SYwD8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f503fb-d9b0-4689-ec6b-08ddf79ed4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 17:06:10.1965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZPabJPGEpW9pnIEerPGSlgbWkzKaLgrgQFujiU13qumew8dVLDCogWD9e18FAVr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Sonny Jiang
> Sent: September 18, 2025 1:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
> Subject: [PATCH] drm/amdgpu: Update amdgpu_vcn5_fw_shared for
> vcn_5_0_1
>
> Align vcn5_fw_shared structure with FW
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bebfc2b34afe..dc8a17bcc3c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -501,7 +501,7 @@ struct amdgpu_vcn5_fw_shared {
>       struct amdgpu_fw_shared_rb_setup rb_setup;
>       struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
>       struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
> -     uint8_t pad3[9];
> +     uint8_t pad3[404];
>  };
>
>  #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
> --
> 2.51.0

