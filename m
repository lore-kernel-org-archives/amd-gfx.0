Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894CDC2BBCA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 09:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0471F10EBF3;
	Fri, 28 Jun 2024 09:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DcPM9gpt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C94010EBF3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 09:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs5CsdO3gFhk12j0F1lnFwu4Nm49tjlkKg77UQX0OdwjL8zJClXLizpAyExqXTNw2AmT6fucIxIFFUm/NYNKgo/bWZFJ6syRN2mJg2v7Oe/NC6H261RNDURAfCzCXEjEiDheskFRnW9tNI7ojWVTJZ5oQCh/l84+3BmsN/WxiG3hvWEtF8YdWnt2Sj3pjjjVTdFPMESP0gHaOh1bFroD5FT2aqm08weqrxpU2UbEl1956JzF4MQzWGgvO0GrSeKpZ7vrHp9/Cb+hH/Su0Os5jQpkHhErMH369X1PmAqTgudeObM7QjGeloLPSaqfYrW/Oa2+PVA0tfZBcMrj+jvftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilR/eRrB8vQv2ACbgkD9kTzlWLp5NDrlgUa3gVRC99Y=;
 b=GBx0+H2dLUF/qR/ZWhnM9DAUf7AX1U6X4FjwrZaON1oBXRfwdIbjCeJ76kzTV6XSpZUmHxzS2jrYTffZMJfK/4+wKF+Q+NE+L3tMGW971id3qOtg7oliMN0sUpQWuL5ikaJDb4MsDj/L1QmimiNAhr/q8CV0xIQQy+lPLXyDnOC+mIDyPhBeKiCmE6fNSbnQYxsoA8ycOz6ybIqZt22ww73tM0QgjP5OmbjZ6qjfQLvKU7/NWxB9ujPCXW7fATiOXIBBfSwNmM1X33TsDwGaccZDFYeUpak1PLqKZfj/WZOswZhIsUDsowdiJ1Ajk9GQ5RULQgp/Sd5EFBSNWqbnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilR/eRrB8vQv2ACbgkD9kTzlWLp5NDrlgUa3gVRC99Y=;
 b=DcPM9gpt6cwIi7SJqNVTZ7SH26kLzNzHbTfOYR9QtIHDGDS51RLs3Sfjuv68i6HNQUJfKfcKF6jci6C+WdGAOzzYX4zQ/4j+zRSHPVDsbIF+nmDxrBQQyNsDFJD+T5Ga8QQJXXJHrGuiWYLE4ujmbolhktW2tSYXdTNE0djChiI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 09:22:16 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 09:22:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix hbm stack id in boot error report
Thread-Topic: [PATCH] drm/amdgpu: Fix hbm stack id in boot error report
Thread-Index: AQHayToxghwi0cIJ20q6415wlIb8a7Hc5mJg
Date: Fri, 28 Jun 2024 09:22:16 +0000
Message-ID: <PH7PR12MB879610B30567B4EE64B854ABB0D02@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240628090425.9536-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240628090425.9536-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f51244b3-f80e-4416-ab7c-7428dfce6d58;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-28T09:20:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ0PR12MB7067:EE_
x-ms-office365-filtering-correlation-id: d3e6ba06-4ddf-430f-4337-08dc9753cdba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uedbwfdkTeCk3amgI/0+WSHSZIvkgb5Zjbs0vcd4FjKyAhrbWrSNwpUGENCj?=
 =?us-ascii?Q?QRoB60mVYOZTaqP2S+DAZ+WASPNtSwjtucIrKRfyRE6IVi2WpdSaB9z1X/RR?=
 =?us-ascii?Q?8eRSqNiYj/Dl2EpByjQX3j1Q/t6jGFGmpoq3KQQmbETqXUXgWbb4/WeXMfXN?=
 =?us-ascii?Q?ik8lAx3E03fyCJRwpOGuaBscWPUFFmqd9w8x3NiP1RJtkDcjiLLGeigRe9Wq?=
 =?us-ascii?Q?lv2+rO6ELRHCT6N4V/F2pHXinsbtSuJDBdPdTGN8ICYNAPKYLSLOjTiqOKJV?=
 =?us-ascii?Q?/BF3aVWzr49lKQRvYqhAkJ1eUFEU9E2TeLUkpgeMa0ne4g2r/MqsKX+EMWCf?=
 =?us-ascii?Q?HMsm/3nC+8AXq7IWaU71K50P5fRC8v+8lxfJOBFPNZvmYTynBRh0H52TmZ6O?=
 =?us-ascii?Q?4VqckfjM0TwlOf0EUC3ItyUA9eCPW20xWuaSEaNNtUhApULIvWgRmReH/rD1?=
 =?us-ascii?Q?L9oOsH5/XRV89aPPOKc1UdHtMUMKlI7/Xyl+PXvBJVoL/1QEpCVHW8ISrP3S?=
 =?us-ascii?Q?Se0c4sJ87du/r0BoWT9ifLM7sI69cVFrTBN744aMbd4OT8bCF0V3TTejPh14?=
 =?us-ascii?Q?nGaAtQeILMLj9L1XcGv2vOq+46T+iePdWoXwjIl+81Ru9sApMZkWE0/OK56h?=
 =?us-ascii?Q?HrGqq4nJBYp31vjjvpUbMaFaEFgVhIfa7r8Y4mEPuuP+pr5b8+hw9ODvgnL9?=
 =?us-ascii?Q?26tr2sASHev0OeLcyCDlvntHNeffXixcQRKEEA1ZTgzmuQzdwUKfBJLD10SL?=
 =?us-ascii?Q?C3aHuDZJqE7TnfKdTqS3PKMFtwGhKYyrOI/rY5ON1AQMPikJ9/DiEOb0Ao4q?=
 =?us-ascii?Q?omrSq9uOGDbxhQ2+wIlSeBGlfDF9j0RlKRxz2dES2adKkrIxd6auQIdKSdGI?=
 =?us-ascii?Q?fvu5P0VFsZCg7cfgwXRGjTY5MQbGfap/9wthA1Nv8jW7IMBY7BdNrfjBeI2O?=
 =?us-ascii?Q?HcLUyapAWcZXb5wLeccYqEY8qpzfhCs3u73Vw1A8rSNYwTFfxYOL30iTTTjg?=
 =?us-ascii?Q?4LCtdQAk5mjK2YmyaVKZXSQ1Tcdu5rISnqwBD0YNRGQo986Pmn16kOEiEGEJ?=
 =?us-ascii?Q?it7wJ2zDFafVxc6MFkHVECNzb4CsEA5tp45Kr48G1nAXNn0Kps9HlXlMRDSh?=
 =?us-ascii?Q?j1ENASOu2Nzx92ERfcXAugFWvaokPaBG4P9wkFP8p4JRX2NtyxHPBOrl6MwD?=
 =?us-ascii?Q?ccjn7s0i1B3sLBIkoeiKyuWh3Z4fUQhA9rZTbM45XXU4p8tKkCrdhcgGvN9Z?=
 =?us-ascii?Q?+Hw1HYxvg0/ximl3WbrW/HJqDrnJg0fSoYfO7B4MET77UKLqETTaw1FBESHy?=
 =?us-ascii?Q?Dnt6bvog86TDrls7yiZ6cGUkrPibwFzdRNshhcMTJKAnNZTSFOSZT/9lGFPq?=
 =?us-ascii?Q?V1eE5IL2KghItemKPGPxWrazD6A036coAovKE0WThxNB/XRFYA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QgftA84j7iVyMW+N9BJodchrZtSGrqIMTTrH3G00+l1/JDJBrLSVIqXldGFg?=
 =?us-ascii?Q?XMC62p1vnLFkm09PYyrifZ7ty+Sa25q4YmSh0VIxAzJVf3zTfk2JwKPwGTkt?=
 =?us-ascii?Q?+DkKynmBweQrqCC6aQ1aJRjZjBSsgsX4dPVZatremKxYZN/f9gZJexShUwii?=
 =?us-ascii?Q?EK8lH0GZilEnMlsLCIY0WAAj6v9Mbgp+xyvA28kDHcJDkrE47N9CIFxC8GNF?=
 =?us-ascii?Q?IRx6bqujS6RBsByHGI+cUHdvOv1jvEUK9Egnim6kRxedunKu9t3jn/nDMllC?=
 =?us-ascii?Q?ePLZGetksKdjiPsy7rdKu0m5QOQMk5zUBGDtq6tyfjuUw7AlYKDgU0gwVs/p?=
 =?us-ascii?Q?Pr5LymvQBVbze6azC65BmuGH1WP+Y6Sl8nAVrddkbKRpvuMvDF44YM/T3GiJ?=
 =?us-ascii?Q?fi0+txI2vqgFKs0bxzbnhwyoyTMq9ZzQWYpBwcsHMIpEWMrSl++Kz5hjNiok?=
 =?us-ascii?Q?hFMgyBD+/5xG3CSO+DxglLZzQhOhv5NSZhtZ8XXGVkmd3bYPmPoickPNsolw?=
 =?us-ascii?Q?WLn1CQoe5bc1wEr/jioDDgF2aqflYNb7ufme5CFzx/VWqIkoSDouGERgw2P8?=
 =?us-ascii?Q?D6wpOm5KWl+L5uqqvNMAg7bS37ec/WxK4V8ysRc1q+IoXn9WS8JbsEGGhhj3?=
 =?us-ascii?Q?+R+gob4U6GXPHBroSggTkH3/kqxDWDeeGLeyf/wk9oSBuZIoNOA4wSwMwePh?=
 =?us-ascii?Q?RxHcNuHLE6Ays9bGhsKjx0GW77KKZlPvj6auToc4s/DQDvgN9Voxzj7xFQOF?=
 =?us-ascii?Q?Ndx839/eWxfQFcvESiQ+aFQUhLt+UziLL2BiMukgxc1VXX23f6WMCW+QIshR?=
 =?us-ascii?Q?y0Ih6lvoUzCYIElt1iyush0++i6wSiDlEcCIDDyP+el2MYLtjy9oPKI178BZ?=
 =?us-ascii?Q?Kl+gb1PaIG0Ib9T2POuBcbTKKW6KlrAA/kyuPoIKVVY8SvWREDCqbj0kwWsi?=
 =?us-ascii?Q?EPFshSzMN1371fualDwMmHW9P8nbug6vT0vChJTO0JZBTDSiLrxMA0Erg6ev?=
 =?us-ascii?Q?fDi8+kH7TftBy7RZM0z0EhvCilDccz/YFmIfixRu1FlzTJabNwE3XRJNGG+1?=
 =?us-ascii?Q?2rihFyb+Z+ODxataiDC3NdNgRAMcP8OQS7Ig13ZaAYyxYFRIAPmYaH8D3G2a?=
 =?us-ascii?Q?vtGxnBpLQnW1t2W3f3c2oxajgLKize91CIqcn3ssiFUDEXUwR+0bFjHXKyIP?=
 =?us-ascii?Q?BI6+HIMgGikvQwNm2YHQ1/8swjZxW0slE8IcCEpposCJt2DLM+EGvAV6jTQg?=
 =?us-ascii?Q?sQ/GF0LvT8Nkz6yazRsS/vpGd8dCp1ut1/6buY8gbZ+9BCpjwnc0ssMYda6+?=
 =?us-ascii?Q?fExhNSrWbt/zXTda+Ku2AXOki6DckqufiDr2sKQ69sK8LQnekEi3NRwb8oLs?=
 =?us-ascii?Q?4Y9XWGXMM02rtDxveoSpMxP95Su5Zpp4nzN0h6ZOtYx4MIAiYshpJt2xd56G?=
 =?us-ascii?Q?1jnywOBFk7mUm4DLmMPUuNRgU/JUCoVX6mwJ6bwdXUVH59+Ibgy7POqzceZy?=
 =?us-ascii?Q?FnvQoBQC9j3KVucPWdDL9QnMF8hDQXIXphQ1SJSgkD5WoD6sxgKWPNNhd4eU?=
 =?us-ascii?Q?G/8F9fHqPz/DW1CERNo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e6ba06-4ddf-430f-4337-08dc9753cdba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 09:22:16.8917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yqCh69widd5Lq403HThny9GVy4Rcz9mjUWHer6AH4I5yZrx1lmrZd8OVfZU0L7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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

How about:

hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error) - 1;

Anyway, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Friday, June 28, 2024 5:04 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix hbm stack id in boot error report
>
> To align with firmware, hbm id field 0x1 refers to hbm stack 0, 0x2 refer=
s to hbm
> statck 1.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4edd8e333d36..6d1f974e2987 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4565,7 +4565,7 @@ static void
> amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
>
>       socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
>       aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
> -     hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
> +     hbm_id =3D ((1 =3D=3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error)) ? 0 : =
1);
>
>       if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
>               dev_info(adev->dev,
> --
> 2.17.1

