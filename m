Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114E8C83F09
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 06:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75ED10E882;
	Thu, 10 Jul 2025 06:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kFo1YrMP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E7210E882
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 06:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLtEEEsmfkvU32elp12P4F9gpF0/1Ovk0QUu+7T4WQ1bUOxbVuNHn3qEYh0myZBThlYZNZWQ2qKM19KSLRdIlc0InEeiZXRjjJcQx2FyXEh1msV5TOiOlIgqo/iRMgAAvdTl/qKjaCrN7y5oCmeW8BORMPXjaGI0d+BwGotLzK+b4UVikBPPKtiyO1zRoKtPWsbAp7JqxvVI2XpifL4p/fxqD93YhniGWRzvCMlvG6pRQpQ216Pz1NTCOyIvp977yQ49izwRXPG+57v9c2A9xytFZy/GaAbITCy8/SUBOl246sreQnhw+/KgeZARU3dAjbOQdTiJS7/BWYe5JzDw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcjiE/ht8fFoRDGnWesL1MhOo3UkWo+pG9QvxRna5yE=;
 b=gF8HuvCemjthivrTFyXoMhP0OGDMnfIcg8ZYZL5CrBrlOqb8E+fYEG+Y/dFTb0caR8+6wv9igpLhpvo73wodPAlKLkX5ZUC/bjBBnfYCWWPsWXiU+AYUkUmWmqwkeZmeXXyGP/0Hol1uL0QIcyoKUNmCpKs/U5E36zw4r0lCPCyAflEJtcqnItlMYaGaijmIYyFsXFVgJHto9j9AgdsrSSV4oE/0Tq29IHg8FgZnLjYxY9puqyCs0Mh84pFvvuC4YSXw676xqqmmpjvgFAA98XZqL3kd5+wDJ9SM7DA7H4ZJS3xu6m9KeWeON1V50Vo8uQ27IIR1rNhkfdsPix4kwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcjiE/ht8fFoRDGnWesL1MhOo3UkWo+pG9QvxRna5yE=;
 b=kFo1YrMPCBvG2qxmkLtonMZ44YI34wQe4/UcxmWsb8aokcSNP+sH3Mni67WYJVTdud/vevJjK521we6/LFbtwLnyuqjFbA+hv6eU3Q/ejYUWp+BbNt40qL6WEau6CoIvgXedfOz0IvIFLEQfEkZD3gjBbwp5ZOHfP48uEcauhJg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 06:50:06 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8901.021; Thu, 10 Jul 2025
 06:50:06 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Topic: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Index: AQHb8KujKIL5roXcrkmN/Z7JddnLArQq6z7A
Date: Thu, 10 Jul 2025 06:50:06 +0000
Message-ID: <PH7PR12MB87961046F1A6A6C7137B3B53B048A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250709082915.18904-1-ganglxie@amd.com>
In-Reply-To: <20250709082915.18904-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-10T06:45:58.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH3PR12MB9284:EE_
x-ms-office365-filtering-correlation-id: bfb7c0ce-1179-41cc-829a-08ddbf7e010e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YRPTSybPhLE1NfidFE3rkI2pfZbkn/9zHrUrkwCKU/Psfogy0CneiVeJOHWI?=
 =?us-ascii?Q?F18zVcNgPf0yV83Gs8KyVFPgXV+rtTcbFAqqrR8OyCUxlIaCtboha4sZpC7c?=
 =?us-ascii?Q?+Mtb+mukKThc6EEHZ9PdfABAOg3WD3herLlEfQ/Qwh1C/JxYCs65+AkJXFLC?=
 =?us-ascii?Q?OQgeCroCHxcJavGZQMoKCJWygFs/Pc4KKuSN3rW3fUOa3KBk8ChtWBAUSLnR?=
 =?us-ascii?Q?mAN9hyft249gdptqF+TWrMcOCpNg/uVk22Ck+qlnJPi6pc0t5aP/xi1QXyto?=
 =?us-ascii?Q?6mql8wuW85ipBZtmUfo77pOhjUEOwSZ+6S/AaKuXD21KSS7hE9bHVOmZrGt6?=
 =?us-ascii?Q?M0T3PfM+66gFj8i/u9MqzldY9h9vJaaQTJ1DuBLKIyaBRO4S00lVWCEjI5co?=
 =?us-ascii?Q?LOuJpj4a4UJtLIMO0e0DrsKa5Kx+S1kkFg3TgepkxUrjYl+CBk8fYbtCkeZj?=
 =?us-ascii?Q?0DyJ8lIwyW5hRjweyIN6eDtk/c5TAsC0yigD0GZ6QJjMEuYkWhEUYjM7mugf?=
 =?us-ascii?Q?ZNPC689POz+THSX/F6XLgmqn6Vykr3nX50aapSUbzcdxfLuJ1PvfemXUNAMh?=
 =?us-ascii?Q?Wx5Ug2JPIlSo8t0PtSg5TKx7CITrB2AS8xasJaMawYu2BXqKE21DXJ4eCkar?=
 =?us-ascii?Q?7P7mS6u84cMuY8PU+wVVHG7erKf8HxkpzO2LB30bffwHejUROiT+BLJ4Vp94?=
 =?us-ascii?Q?0w4aS6io2osCmdA0/kTk/EIG1coWiWun9xHSzBx7+xKmcM1EfDD8YYO4Z7ER?=
 =?us-ascii?Q?B39vp4SYNi+A8vNZG1W/Ixn+E/bWX5FeA+ytNC9hf2c6jhyEknwmDNpOAUPD?=
 =?us-ascii?Q?aWuDsDsAEjzCd6UpZFR0A4sDMJpAvmpN39gwSYvaqx5M3OUbHCN4EpzmOh96?=
 =?us-ascii?Q?qenvuA915kgbJYEhLKxckME7b0tkEZla9OARCgMTMUwA1fDmzrlxXQR8xBOQ?=
 =?us-ascii?Q?XgfwREMVf0YO9LuiNqh2TBXnkXGQx18TVQfKvnFraFWNohkp/0XAiniwfjzP?=
 =?us-ascii?Q?7I62jC47xdPITSw0amTS9XrCZzYSM40AYKUq7Nycwccfsz6EcVp3dTPcRcII?=
 =?us-ascii?Q?06rUP16dYhLevvAgbYTfVgHJCZ1oSgpxd1JBgaj+17Qsu73KrXBSecb99ZZC?=
 =?us-ascii?Q?IgvDixIWusHG+AoNnwVClubIeOjIT8mQsDEhOFNIu1317i+6fnjBXbGAynoX?=
 =?us-ascii?Q?/yuA+aEodZa3uEM/PFBOaNbn2cZiZn7ht4XI2+Q1Cu806LKmipDaWGj3mSk9?=
 =?us-ascii?Q?t3XGRzv3VutKhC6BdoguiinsGy7N0NYuGWu/tC9jgWcuSuFqmquT4W/FUWs6?=
 =?us-ascii?Q?JlluusNXssEaB/qV6YPtmjYYG7cc6+Pt1p4m430BieoKA5GZggkRhr+pWgh9?=
 =?us-ascii?Q?dkD2mSZQCl11sSKrjE7ZoLQLEAkTUCnINIj+E8qXmN2i5qD1opVc0UduH2z7?=
 =?us-ascii?Q?tQhp2rmJY4MYgb2748wyjwfaUDCtBuCN2y5jADHdxuHhyQWBtM6sIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SCRYRNsL53KOydh9ZtVr54JA8JxpI/Eepzqvx+fsIK8tPGpy0EU+gSEeYOGJ?=
 =?us-ascii?Q?iWwbLbr94S4u4dB6YMcCropdzKFtAEJwM/rrEIWcOvbmOtQZwZHnPoYRoo2A?=
 =?us-ascii?Q?4iL4/dRuGWFHt5nQRz/rb1lXbuBCvS/Sw9ZtgH1DRoUipjzS1Zugj0Kab84c?=
 =?us-ascii?Q?sXRQZ0xCKYqh2ZBIjnInk3YJn7ihxddINRU8SNJqt6gM00ekdQiIsKY/ZpUt?=
 =?us-ascii?Q?DNl/MrOiWFxj9rRJfUppSY9alsb9QqJ1Z5DkIbDTz+ZkPdw+iA8aSHUcCHiL?=
 =?us-ascii?Q?u4ACL+RiLQek6CUD/5lUO0zd3h/Ktjoadv3pF/sMqBnWRKZqPhxpfwjdPBza?=
 =?us-ascii?Q?NfC4Kxpe7FAU23+CieVx43JEJG/NhTVb8kq4Nu1NUWVdC4oEkpsELI2HNNqZ?=
 =?us-ascii?Q?FaJc8W679VvSE448ApLRR/xyrMwA7kg15mgUQRDzN92N2R7NYKcbP5d6N6Pa?=
 =?us-ascii?Q?Bbz/kvCd59LEBTiG4wSzAU4vCzA38oNrAykD67mr6FAO4d/oSXuZFhKkxENP?=
 =?us-ascii?Q?cVwh9CDUQYtU+wPcEGu5ONSfhEybtxTedy/aGU6x3BUYfRFvU/wwlJaGjmNh?=
 =?us-ascii?Q?nFy5GqyZ0LaEvM14sNIt3pbn0iVJy+m8THdVBXDyT9G3wlUb4r3avTMDOcsc?=
 =?us-ascii?Q?WH6gaPtt2VS9RGDXa8hLHqHnfOv/VBzYfpYDzihl39VJPhGswZeAzwQMZ/ry?=
 =?us-ascii?Q?wYbLmiTjkAXlSraRbrHl0pmVl8dc3oRlruxjXoOO987rXyb4aMVjQlp9P8gO?=
 =?us-ascii?Q?3Ek5+ZuSieOHcz8JpByGVeix/juKGNn3DFqagOWovvq7KbtO8LyVRuwUcZ5+?=
 =?us-ascii?Q?QfS2UVD89RLGCZqxCJ8AlMSfryIc/DHi0gYzkUIlUlrQwYdrJYfeia4Xtbey?=
 =?us-ascii?Q?p1qlOAyOj9JYldRk3KFaeS1WZKv5FKLq0CmJCX4BYKesshAIjGGbxm8cpGi6?=
 =?us-ascii?Q?tpmGN+4XeKj9sumEU5etTTURbvQ+XSc+fw2v1Jret2HTVhiH+TS7HgdLM5m+?=
 =?us-ascii?Q?PMKekO+6R17XBR6FhyzDn6zFQ/+17/04Cxh0iqwmhyJvN+QM2LcmDR/XbwS7?=
 =?us-ascii?Q?KijBYENiN2YPzxLtT7GTjOu1aUDvWUrzEOvg4Z/RdsCW+L4T5vx52TNyfLfW?=
 =?us-ascii?Q?kG5ioAgO3jj6roiOxiAgkzPo18QTqgDPJ7vnHRsCDY4/y88feV683x228ydX?=
 =?us-ascii?Q?znr3wExtILHeyE4uKTvcV5WCkNG6+WRoS7yUdcWMZKQNyB2M7j2NYbtgN09p?=
 =?us-ascii?Q?zeJ58Nk7GHLOlFdHsZAflsocfI51r/grKev32eralL21aI3baMSLZZ5HJJnt?=
 =?us-ascii?Q?ioijOZZ/KQG8nRKG6atMEg75OGzzOgSrCRhsgCvKUE1isewdPUhtJD0E5cwH?=
 =?us-ascii?Q?QyeiW8b3eaSSpMuRcewPKdV6VbxGFqc/zebNKADMKhJ+nf0oLHTtA/4foqPo?=
 =?us-ascii?Q?a5jtOzfSxfr1E+lIDv86KgJwKLGzDAi+6V5GOszyl/cPyVl6bnXDsP2ijDiX?=
 =?us-ascii?Q?RvM2qDjESYRVg7T2ZuPZPAW8+p3ZF5Gz9FsMs13pebVJghG1zJYOTDxTclB+?=
 =?us-ascii?Q?oqC7raiaDjVDmqF26/w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb7c0ce-1179-41cc-829a-08ddbf7e010e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 06:50:06.0536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5oTjlGHIwk0OcWz3j/YH+QTqHp+Eh3BOmSCE82m7sT5DSAs/jBWmSgaIyFL9w4q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
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
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Wednesday, July 9, 2025 4:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
>
> add eeprom data checksum check after data writing, after gpu reset, and b=
efore
> driver unload. reset eeprom and save correct data to eeprom when check fa=
iled
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 13 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  1 +
>  6 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 84fcaf84fead..2503f2300472 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6410,6 +6410,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       struct amdgpu_hive_info *hive =3D NULL;
>       int r =3D 0;
>       bool need_emergency_restart =3D false;
> +     enum amd_reset_method tmp_reset_method;
>
>       if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
>               return 0;
> @@ -6506,6 +6507,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       if (!r)
>               drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE);
>
> +     if (reset_context->method =3D=3D AMD_RESET_METHOD_MODE1 ||
> +         reset_context->method =3D=3D AMD_RESET_METHOD_MODE2) {
> +             amdgpu_ras_eeprom_check_and_recover(adev);
> +     } else {
> +             if (reset_context->method =3D=3D AMD_RESET_METHOD_NONE) {
> +                     tmp_reset_method =3D adev->asic_funcs->reset_method=
(adev);
> +                     if (tmp_reset_method =3D=3D AMD_RESET_METHOD_MODE1 =
||
> +                         tmp_reset_method =3D=3D AMD_RESET_METHOD_MODE2)
> +                             amdgpu_ras_eeprom_check_and_recover(adev);
> +             }
> +     }

[Tao] the logic can be simplified like this:

tmp_reset_method =3D reset_context->method;
if (tmp_reset_method =3D=3D AMD_RESET_METHOD_NONE)
    tmp_reset_method =3D adev->asic_funcs->reset_method(adev);

if (tmp_reset_method =3D=3D AMD_RESET_METHOD_MODE1 ||
    tmp_reset_method =3D=3D AMD_RESET_METHOD_MODE2)
    amdgpu_ras_eeprom_check_and_recover(adev);

> +
>       return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 571b70da4562..1009b60f6ae4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>       struct drm_device *dev =3D pci_get_drvdata(pdev);
>       struct amdgpu_device *adev =3D drm_to_adev(dev);
>
> +     amdgpu_ras_eeprom_check_and_recover(adev);
>       amdgpu_xcp_dev_unplug(adev);
>       amdgpu_gmc_prepare_nps_mode_change(adev);
>       drm_dev_unplug(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index f8a8c8502013..e03550be45b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -196,6 +196,7 @@ static int amdgpu_reserve_page_direct(struct
> amdgpu_device *adev, uint64_t addre
>               amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>                                        err_data.err_addr_cnt, false);
>               amdgpu_ras_save_bad_pages(adev, NULL);
> +             amdgpu_ras_eeprom_check_and_recover(adev);
>       }
>
>       amdgpu_ras_error_data_fini(&err_data);
> @@ -3539,9 +3540,13 @@ int amdgpu_ras_init_badpage_info(struct
> amdgpu_device *adev)
>               /* The format action is only applied to new ASICs */
>               if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >=
=3D
> 12 &&
>                   control->tbl_hdr.version < RAS_TABLE_VER_V3)
> -                     if (!amdgpu_ras_eeprom_reset_table(control))
> +                     if (!amdgpu_ras_eeprom_reset_table(control)) {
>                               if (amdgpu_ras_save_bad_pages(adev, NULL))
>                                       dev_warn(adev->dev, "Failed to form=
at RAS
> EEPROM data in V3 version!\n");
> +                             else
> +
>       amdgpu_ras_eeprom_check_and_recover(adev);
> +                     }
> +
>       }
>
>       return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2af14c369bb9..2458c67526c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>
>       return res < 0 ? res : 0;
>  }
> +
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev) {
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +     struct amdgpu_ras_eeprom_control *control =3D &ras->eeprom_control;
> +     int res =3D 0;
> +
> +     if (!control->is_eeprom_valid)
> +             return;
> +     res =3D __verify_ras_table_checksum(control);
> +     if (res) {
> +             dev_warn(adev->dev,
> +                     "RAS table incorrect checksum or error:%d, try to r=
ecover\n",
> +                     res);
> +             if (!amdgpu_ras_eeprom_reset_table(control))
> +                     if (!amdgpu_ras_save_bad_pages(adev, NULL))
> +                             if (!__verify_ras_table_checksum(control)) =
{
> +                                     dev_info(adev->dev, "RAS table reco=
very
> succeed\n");
> +                                     return;
> +                             }
> +             dev_err(adev->dev, "RAS table recovery failed\n");
> +             control->is_eeprom_valid =3D false;
> +     }
> +     return;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 35c69ac3dbeb..ebfca4cb5688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct
> amdgpu_ras_eeprom_control *control);
>
>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
>
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
> +
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index bfc86f1e84e5..081f7fd29394 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -80,6 +80,7 @@ int amdgpu_umc_page_retirement_mca(struct
> amdgpu_device *adev,
>               amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>                                               err_data.err_addr_cnt, fals=
e);
>               amdgpu_ras_save_bad_pages(adev, NULL);
> +             amdgpu_ras_eeprom_check_and_recover(adev);
>       }
>
>  out_free_err_addr:
> --
> 2.34.1

