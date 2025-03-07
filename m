Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598A0C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 07:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7EB10E0CD;
	Fri,  7 Mar 2025 07:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S0Aq2VDn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085D010E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 07:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONNVVmbPZ5hVNR2vWkefngp9r8cBD3fQxseJNP7y3Mtd3VVpuZP6FH3kFeuatdlzyQzVlnVhENhf3uL0U6H0kNesJr8SJPmMVKJeBklcUWbIfzuHsC++QJXXgxAPTDExW7B/Y28sdB99swnWUOP1fpnFIZ5ajaa39IwSjwx7R4r5gE0Sox/LbStmzhhWOWdqpBcfUqWQFavJbHMDcdWQM8E1pAjUzkwA3ZCMibUdBb7JvEYB5EXfAHL2EhSva4Ik3skezUXAIAfxqZ9XWzubuY5zjK6dYCkT/hbKoQHpznBrjGYYHL0bHDaYjZvdKP+/FjVdjeoj76qMU12rCvMfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS9gS1mucrqV9xW4B25UOeri5wXgy0L31jjdhPEj7nk=;
 b=y1AjQYoBf/klBaDnML3SS1lghmiOQz3bGl7FlThDFlpyXpRn3Xv5OAK62qP9x6Uprf+uZhAsgcTAZz/UFkVEWv97iLp4eiXUWjDaQQZ6XUi7lkZluRW2RvsU2+km30ZTDsS0xb5zSZC0spDp+TI/pRIWrRRKuBGHVdEsQQHb1c/Xn51m2c/N4S6ScmY/k9LY5SL8eCWZw79nnvMNNpIPAAyMFlKycl9b1zCbGYLoBvh/Qg8f1gw1BDtuBNSA0KAojxgVUlGz22p8/VlghPL699nzZOXbewmyMkFBl8geosB/g/H09csn/7jilq+AirXVcq7lHuaorGZgyas1+066bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS9gS1mucrqV9xW4B25UOeri5wXgy0L31jjdhPEj7nk=;
 b=S0Aq2VDnjgspWwMHxQeIBHeZDVRPX6XmDudzOmPJxZa3eJl/TWBuPwQpmRXPzHLyL9O8AoMYBwOML9YjBhgouj4XCA6Ssd/oResEG9IEMFG9htkrMwAfzlwvT6KTdpeYAZzn6C4R4T/5vpp6UEy1BRWXuF/mCTx3+n2h4MN1gyk=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 07:36:20 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 07:36:13 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Thread-Topic: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Thread-Index: AQHbjyy7TYErPVdmpUSoneZxFZ4I6LNnR7vQ
Date: Fri, 7 Mar 2025 07:36:13 +0000
Message-ID: <PH7PR12MB7988E52CFA8019C506A46AA59AD52@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20250307064639.273141-1-tao.zhou1@amd.com>
In-Reply-To: <20250307064639.273141-1-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bb6828aa-0ca0-4f27-be9e-8b942e310789;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-07T07:32:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|LV2PR12MB5919:EE_
x-ms-office365-filtering-correlation-id: 64d68f83-9563-481a-5fbd-08dd5d4abcca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UBWspSTrnzoL5c4jVvDqEmKIhMoFDvXHfDZ5cxH/Ewg2XCvXqZQXYGFiubXq?=
 =?us-ascii?Q?873GnIdKS7IBiD0g5uJ1QjPn7iYzj+adnDwV0KPVmgoCW69VjfsqGHCct5DP?=
 =?us-ascii?Q?/Nt9ypponlw/NVktog5oPVBMP/qqloMZv4pD+e+XEj5AiMlC64+JysrF/wu1?=
 =?us-ascii?Q?RmdZOaLgXTlnSDgCTFj6g5++HkYjcH7ftktfWdXZByHT0p+mRqyhghmDqZYP?=
 =?us-ascii?Q?sgCuR4HekJwEl9w0q0IhSFVB7uhN7Yu8rpq4S97g2uGhifsyTw1E+0EUY7Iq?=
 =?us-ascii?Q?igTSTp3jcQ5blv24CzsXIhfhNdJlkJaNIbYmt4vkiluminBisZwe+EAEvBkJ?=
 =?us-ascii?Q?IipeRLJcDavgvgFPeTgAjKZadr377homqLkXLuj8ni84YBpx9Yf60HO+6A+T?=
 =?us-ascii?Q?8LEoh3W4eUiaOSEcC/HZtI0tFFp9RNfXtmmNG7wx7YEJg+PfAsT7LWw6/0EO?=
 =?us-ascii?Q?i91Eo5nrE6rgtTaiCZOonoXDICZ8dvEqIr8eK4YAqaGB/ZogugGhyu3aIB2L?=
 =?us-ascii?Q?OsWxNpn2KWjBZ2FOHN6lsi77ou5FghP/fETg+baTDbKhLylKcfyONWybYscl?=
 =?us-ascii?Q?bFJnGnq0e++xi0uFGT0i1tDyy27P083itDdeGPLdftpspIk/7xLstnPnGtXn?=
 =?us-ascii?Q?IZFlAn5Wqv6rYuuBvw7MXOQC4CJ0N3EyNOHv0ilAp0PaQrALRIYRFyXbxhk5?=
 =?us-ascii?Q?w/nLFrtvfLmzG1Q99Wk+MAau4TYjwXJHHOM+fb+BJ0kjl4SIelMVoq4hY9kO?=
 =?us-ascii?Q?BztcOswc4o7hUvHJALnBrCOxP83s0470Ndff6T0GOe52Y8Uajw5vBUraf/7G?=
 =?us-ascii?Q?ytWSSRA9tpLXjnXfnpoFqOoBMV7wvlyBw1evCBhIJvB+CkPR/N3NlpHxhv1D?=
 =?us-ascii?Q?Y7e8vpxQ8DrHKfDaP0pH8FEBfpGYrHMnr+dMNEFRaOct1PL4nu9yNlr5m1tR?=
 =?us-ascii?Q?i8LX/pejTnuhAgUOIRhFxqBMOc3cjIyyJ/bphihwgX7UH1XKvHd5w0sN6ySU?=
 =?us-ascii?Q?YbNRpD+PqoBUpSMza8lAGMsxHV/+rJRdlAC0/5GR0RQKSer+wKGznH6sGfUK?=
 =?us-ascii?Q?Zbut8dsksesrPtuw9qhQg5fIeKqwJzdZ9c24Is1Zw9dNVeqD0ld3eJAhra8H?=
 =?us-ascii?Q?xmr4rIqhCFAMo5fbUWGvoRvzdsYcY/kMkwHOIkQAxQYjIOVmiYl3dIBtv5cN?=
 =?us-ascii?Q?5zpaFV8OIcP3FiMmXphOM/xrVjvwyxT08gTkIyL5ZjiNgQMlXDw/jEMRKZl6?=
 =?us-ascii?Q?rVQcjPJ+BUh2U4OQKqSe5sGGrYqvXDpbg4297AMAPJm2EyhQEGvdIEcUfTnx?=
 =?us-ascii?Q?anzfYyZifr8SEqyM1uulxzOFUoUgWz/mC0WzELr+xXu6mE6LACCOMhNaK5AP?=
 =?us-ascii?Q?B4Qvd3pA1KXLxFcyrHaeHLNEbA+n9vtVdPocWxwGf74tJz3Q23v1ShNSSokU?=
 =?us-ascii?Q?ZDxog3TWMB0Y+Wgf/laoZPPu5YWM/4+p?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J2A/wbA+2wxFrM9jnrYF55daO/cu2d/mzZNt3spv/s1Yvxd01KKACvAyjYqA?=
 =?us-ascii?Q?dlBLWOMJ5Jrl1EXOFfTkRu6OFYl+TrX0MgFF3PmSlyt1kgW8LNzhamEGfzvg?=
 =?us-ascii?Q?vXiJ6eBYL7uhOa5CSNLGHr/pSlDarfDzEQXvWpU8HXia8UjFpziPs5l5h/K4?=
 =?us-ascii?Q?9V/hKwj7i9FQwMAJE5oQQvOO/vNJgIefurAmzkd8iZKKCvC5NQKxVfE7O3i5?=
 =?us-ascii?Q?IQngiLJ5vsraCel5SDgO+Ofx57iM6L2zT1gKowXtKxHrA9wV0ImdAuBjzLRB?=
 =?us-ascii?Q?gP8LjQ9fzhAx8uCPHPVQwjunH1jsMcAcoL6V2+reEB6Myfel4jv8rl8apVzl?=
 =?us-ascii?Q?oOGG93NJ4Hnyx+I6oZdnDOokxCjns7ogsS2HgqD/iMOQaNgqoGP5yeBgnWpT?=
 =?us-ascii?Q?sHcBXBxYvoi0ZyZyFTLEiAHhVhEyIzF4l79QwZwAOacrpXaMDd+2mmxmTugH?=
 =?us-ascii?Q?uJvh1WrZXZPPa8RV9RRZQJoOpfCGHc82sBAhyVmbe+di6CArZ7DHYPEzMu7C?=
 =?us-ascii?Q?EU0u2zRInYuNiUJ7dEaWUB9PqiIDpxnQ9GX4fKl676tOPWOos3dkXdvgcyzp?=
 =?us-ascii?Q?LKlIje49wsolzft1iBJaZBSkT1bHf2wyvr4dmQ9cNSam/B4+pI0YCUxQm81x?=
 =?us-ascii?Q?xHzXLv+0OyleeAHkrqHUkEgsTszBbp5o0dG/nIsJedH3tqVqo7BFmGLpRE/G?=
 =?us-ascii?Q?YSqAxm4LKWdTzpGUP9U/wjGiNv8N8a5CPuJ69s4UrWVcJ+W1wAaQaOKK9w1n?=
 =?us-ascii?Q?jcq3pli2C1iOkVnaqDgKkGXk3RRb0UV8oOS2JbfbvzlJa49p1q6kA0Y2rPq3?=
 =?us-ascii?Q?BXnaKvHZ7ufivLM14jTHxdI7URg7FLfv0gRM3ZPoAhP9iNaDyDgnit5PR2Oa?=
 =?us-ascii?Q?QnZ3qjwcSTkY3GIf5acZrBtxDSM23Vys4VsVqtrugYAwz24PmUrEzG3h1CYn?=
 =?us-ascii?Q?2SR+NZoazRZhfJBwAY7PhEB0aHHQnVdM519XcLZmH+OKqrVrDk2oeP4j7ipe?=
 =?us-ascii?Q?jHODdUAVHoYoUvrcWZgdmvDFKx66ITtdLgsM8QYHobG5AC15+v17OQPYzVI5?=
 =?us-ascii?Q?nHtHU1tdaK8qk85UkM2J8KynSxqCYI9DB5mOxs9Pjgtthknoch/7caNf/37j?=
 =?us-ascii?Q?CCJgoiPPGnfin+T2vQM1HFXobhsl3eOtg3o5n5/yLSMqSTeD6J3FGJRlWydR?=
 =?us-ascii?Q?9oG92SgVx+a0QPQMl1amxbwBD7k/LFNFJdVy23ZV6jV/gAkOjll1EXOBut50?=
 =?us-ascii?Q?7mS3ovT1YQu5bI0w2EtkQdk+sbkjXQLkuLA+biptggjpkKC2BEO8JQamLX6s?=
 =?us-ascii?Q?9WCnBt4XgvS3UWNQEptFlD0Kl90MYXXa0W+0csQufj1wmxWMe2cX9HZzbsv5?=
 =?us-ascii?Q?nTJ3CRM4+CBYZSmEDYfb1Or3uytJgvxHuMO3afWgQE6aKRdh/wOF18aPOUE5?=
 =?us-ascii?Q?Itb6z3qQMnMRrXAvnO/mA+947RxZfzxep8LkKvnORR+wB/4k+2zFAIAYgpFe?=
 =?us-ascii?Q?sqrMz57G8LsNYWsJZHhXeaXs+xSc0wdnvCMitLT/xGGGQ2JKk1+Ey4bs6NRZ?=
 =?us-ascii?Q?rFSM8IKzY9M4VW/15lA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d68f83-9563-481a-5fbd-08dd5d4abcca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 07:36:13.2458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9jqYvRDd4sSADoya7BFVNPGnUj7vQ0APR8N6NVjV5p7kez17y185pVnV7vp/mKgqOaCVbW0fX7mqjqRIrwQ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zh=
ou
> Sent: Friday, March 7, 2025 2:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
>
> Clear old data and save it in V3 format.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 ++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++++---------
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  1 +
>  3 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 837f33698b38..266f24002e07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3465,6 +3465,11 @@ int amdgpu_ras_init_badpage_info(struct
> amdgpu_device *adev)
>                               adev, control->bad_channel_bitmap);
>                       con->update_channel_flag =3D false;
>               }
> +
> +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3)

[Stanley]: should check ip_version here, this affect all asics that epprom =
table version is low  then V3.

Regards
Stanley
> +                     if (!amdgpu_ras_eeprom_reset_table(control))
> +                             if (amdgpu_ras_save_bad_pages(adev, NULL))
> +                                     dev_warn(adev->dev, "Failed to save
> EEPROM data in V3 format!\n");
>       }
>
>       return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 09a6f8bc1a5a..71dddb8983ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -413,9 +413,11 @@ static void amdgpu_ras_set_eeprom_table_version(stru=
ct
> amdgpu_ras_eeprom_control
>
>       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
>       case IP_VERSION(8, 10, 0):
> -     case IP_VERSION(12, 0, 0):
>               hdr->version =3D RAS_TABLE_VER_V2_1;
>               return;
> +     case IP_VERSION(12, 0, 0):
> +             hdr->version =3D RAS_TABLE_VER_V3;
> +             return;
>       default:
>               hdr->version =3D RAS_TABLE_VER_V1;
>               return;
> @@ -443,7 +445,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>       hdr->header =3D RAS_TABLE_HDR_VAL;
>       amdgpu_ras_set_eeprom_table_version(control);
>
> -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +     if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
>               hdr->first_rec_offset =3D RAS_RECORD_START_V2_1;
>               hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE +
>                               RAS_TABLE_V2_1_INFO_SIZE;
> @@ -461,7 +463,7 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>       }
>
>       csum =3D __calc_hdr_byte_sum(control);
> -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1)
> +     if (hdr->version >=3D RAS_TABLE_VER_V2_1)
>               csum +=3D __calc_ras_info_byte_sum(control);
>       csum =3D -csum;
>       hdr->checksum =3D csum;
> @@ -752,7 +754,7 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>                       "Saved bad pages %d reaches threshold value %d\n",
>                       control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
>               control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
> -             if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1) {
> +             if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
>                       control->tbl_rai.rma_status =3D
> GPU_RETIRED__ECC_REACH_THRESHOLD;
>                       control->tbl_rai.health_percent =3D 0;
>               }
> @@ -765,7 +767,7 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>               amdgpu_dpm_send_rma_reason(adev);
>       }
>
> -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
>               control->tbl_hdr.tbl_size =3D RAS_TABLE_HEADER_SIZE +
>                                           RAS_TABLE_V2_1_INFO_SIZE +
>                                           control->ras_num_recs *
> RAS_TABLE_RECORD_SIZE; @@ -805,7 +807,7 @@
> amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control=
)
>        * now calculate gpu health percent
>        */
>       if (amdgpu_bad_page_threshold !=3D 0 &&
> -         control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
> +         control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1 &&
>           control->ras_num_bad_pages <=3D ras->bad_page_cnt_threshold)
>               control->tbl_rai.health_percent =3D ((ras->bad_page_cnt_thr=
eshold -
>                                                  control->ras_num_bad_pag=
es) * 100)
> / @@ -818,7 +820,7 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>               csum +=3D *pp;
>
>       csum +=3D __calc_hdr_byte_sum(control);
> -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
>               csum +=3D __calc_ras_info_byte_sum(control);
>       /* avoid sign extension when assigning to "checksum" */
>       csum =3D -csum;
> @@ -1035,7 +1037,7 @@ uint32_t amdgpu_ras_eeprom_max_record_count(struct
> amdgpu_ras_eeprom_control *co
>       /* get available eeprom table version first before eeprom table ini=
t */
>       amdgpu_ras_set_eeprom_table_version(control);
>
> -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
>               return RAS_MAX_RECORD_COUNT_V2_1;
>       else
>               return RAS_MAX_RECORD_COUNT;
> @@ -1280,7 +1282,7 @@ static int __verify_ras_table_checksum(struct
> amdgpu_ras_eeprom_control *control
>       int buf_size, res;
>       u8  csum, *buf, *pp;
>
> -     if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
> +     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
>               buf_size =3D RAS_TABLE_HEADER_SIZE +
>                          RAS_TABLE_V2_1_INFO_SIZE +
>                          control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
> @@ -1383,7 +1385,7 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control)
>
>       __decode_table_header_from_buf(hdr, buf);
>
> -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +     if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
>               control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
>               control->ras_record_offset =3D RAS_RECORD_START_V2_1;
>               control->ras_max_record_count =3D
> RAS_MAX_RECORD_COUNT_V2_1; @@ -1423,7 +1425,7 @@ int
> amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
>               DRM_DEBUG_DRIVER("Found existing EEPROM table with %d
> records",
>                                control->ras_num_bad_pages);
>
> -             if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +             if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
>                       res =3D __read_table_ras_info(control);
>                       if (res)
>                               return res;
> @@ -1443,7 +1445,7 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>                                       ras->bad_page_cnt_threshold);
>       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
>                  amdgpu_bad_page_threshold !=3D 0) {
> -             if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +             if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
>                       res =3D __read_table_ras_info(control);
>                       if (res)
>                               return res;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 13f7eda9a696..ec6d7ea37ad0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -28,6 +28,7 @@
>
>  #define RAS_TABLE_VER_V1           0x00010000
>  #define RAS_TABLE_VER_V2_1         0x00021000
> +#define RAS_TABLE_VER_V3           0x00030000
>
>  struct amdgpu_device;
>
> --
> 2.34.1

