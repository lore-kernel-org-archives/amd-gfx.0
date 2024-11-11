Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1145CD2E9C9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 09:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B20F810E1AA;
	Mon, 11 Nov 2024 09:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LeMyZciP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6009E10E1AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 09:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dh5vYZXfOlU0iUX5+cPkii5TJUgCY4wiXXWreq7xJ4PUTJqvZH8UpdiCwKuFVJAg5D4Ve0+7UqMfEcJzrSOZ/QBCAFbYDSrATi47uhI/X5gYTuCGiUWCpVZppxObPxhWmYlOo/cUKK++37kVD8Dgk2ouRH5Vr8d+Wngb/vbDiQzPv6w9S13eOExf4X9Big5jyhcZY3PV3X0fsHmAnlVqEg3zYD5Ei7lpD7ugxO73ZG36txdCs5Sk6qdSR5AFzLNgfqeOnIsetO2GgUK8WSYofuvonBf8PZSG0Yyb5B7ADwrI/rDAlZ8OFHWLJLx+0bFqoigSNLbQnzJVsyQ8yRDunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV52d54lEilh62VQC7Mc1AFAVRAbsMhemBYYof1TZN0=;
 b=wBbENX+D8jhHrKLfJu73DTMRl+bRuxmz9pONwNvhr+L7nSWSlr42DnInJ870ToJMkAaqouFfXkva/NojHWBDI27ycGnWM1fiFw7nXAAZL+Lj3weN5rYy4aSd6bbTMOTFLOHKplqIrumAFla/7nGHTY7Ma3k9CuSnYtn5pP7n5+aBr9z6EGaW+dAs4/AS9OtsQ7rjovSWXH1TW0OpKVkBGBpcuajCI8g8/zsF+27OYiQd5yNTo+hzS8gMYWQftwlvm6GqqArlwwOQKrxazVtjNx+5TtK0jAgBs2GQYTBT1Eamg67fkssS5ttm0ZQu2NUMudM0iCiRwevXa3FTOv3rsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV52d54lEilh62VQC7Mc1AFAVRAbsMhemBYYof1TZN0=;
 b=LeMyZciPamYfdkJVCuCPkTZMQwVWwe9ch4MR9YnROrUFN4GVgWLcA1YdGzT/mb5mw0uZISx2vfOctMBKRys6YiXn1sKemCy+S7v6A2BPAkjiBC8Jx1k3xiOkQwmfqYzteI5yNki8BApnvBh+yzenhFnJjdRMBB82jPM5uZ8o9Uw=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 09:41:04 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 09:41:04 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix a mistake when removing
 mem_info_preempt_used sysfs
Thread-Topic: [PATCH] drm/amdgpu: fix a mistake when removing
 mem_info_preempt_used sysfs
Thread-Index: AQHbNBix7lmf2B0byEu7Gs5zLGAy9LKx0nqQ
Date: Mon, 11 Nov 2024 09:41:03 +0000
Message-ID: <CH3PR12MB807450928EEDBBBE448E2FE9F6582@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241111090400.229503-1-Jesse.Zhang@amd.com>
In-Reply-To: <20241111090400.229503-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e742cd61-83ba-4676-859a-067c3a7084d0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-11T09:39:15Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SJ2PR12MB8159:EE_
x-ms-office365-filtering-correlation-id: 92b4acb5-b9f6-49d1-dd22-08dd0234f5a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?c2ktmiAZ4YWS2sQuIOPX0k7frFSC3lQs38Xd6m5JlXwtBX2Tqh8CEBZOW7?=
 =?iso-8859-1?Q?XSk8mlHBJhni14i8TxdzKVffZd3kywNTkG+fY9eKf1F0VlpJtM87/savC9?=
 =?iso-8859-1?Q?n/1MfLIaRi8ogl5rr8m7T5ZqM2OAFPwcqv4npUHKSaf0EVPln7Ou1wloQk?=
 =?iso-8859-1?Q?Q+ivopYLxcuWWT8L8umnL5oB65DsEnLTFYZ8a84puFHnVEdZmQ7xC51VYk?=
 =?iso-8859-1?Q?DP/HhCM5q5yyhf6AtE2ZPsFFwpMoJGMFuzbsl1LrV83SlV5pf54t1xVnvX?=
 =?iso-8859-1?Q?7OLUWWWbVtqANGM61Hp3N/mZOkLsUv1MCZeiwn74qCT6InwLcnhMaOnRCq?=
 =?iso-8859-1?Q?X+O1VF2Mlg3WHpQ4h9xIC53ZcScg2Nzo8D6BVzlfsbL3043BNEo0xvVO4G?=
 =?iso-8859-1?Q?XHl21t0ZXca7tIwuToCdsGZJza0IoHL7EFl9q/r5xzEbI97+5vXae7231d?=
 =?iso-8859-1?Q?kMI7LcBWdPod+8x3igPss+CDDyyeMO2azfNDKKbytFQJPKDaoKBXZZTGrs?=
 =?iso-8859-1?Q?ES7vo0AExfQsN/NqXPbTbqsa4Qt/X+k769ZT9Bij3fHJL641LijaNpRHDN?=
 =?iso-8859-1?Q?zraBk957vkv4YEq4UaMvgapepO1k5nF1s8QFpNrchVHn7tIQmxHz/tWMJH?=
 =?iso-8859-1?Q?XEp8Ubd0hWbLH0Xn2gOsxLKVtwsPVObXU2e0e7cBOnfmM7eu40BCQRJEzx?=
 =?iso-8859-1?Q?CxxULvQcgAPp2AXR9HlwVwSMnSwEfNWEMQTBRckqIS3IOZeSvhYNibtDxV?=
 =?iso-8859-1?Q?i47idgc88O5KgIbxZLs7SpluxP7ydHzRyw4TA66TBpBHGT38KCLXzbX7o1?=
 =?iso-8859-1?Q?IbDZDJEzxbciSyu9e2ZDM0/7guZ9jai3HVvQ//pTcriAXKxvHChIRBmhqr?=
 =?iso-8859-1?Q?fBWRHmsn1UN53MAHL9l1pOyH1SY4FUr9VYh1+f3XYaDDovD3REgBf1WMXR?=
 =?iso-8859-1?Q?iCOMJ5gGZgan3vIMPiXXCaaiErM4bvVgm9l+1fm7LKcouqGYBn9uTLKuMg?=
 =?iso-8859-1?Q?U6u1sxH3zXmIf4INnLKSIkpy/nfCZvZ2RHLolk2zJ8XmYouAMmRTqihd6+?=
 =?iso-8859-1?Q?IxHfmCd75UcEaaOkTFrPOIqGpu9tLiPxaTGPAZY0kNsOOEJy9zwp5wOo4J?=
 =?iso-8859-1?Q?t5UJPBWCXlb1Sl/1UtKWOBv0rnPUe78c85/XUt37s0zIwUOZ15cg0q3HxT?=
 =?iso-8859-1?Q?V3QJZCiclodxa2SYXHn9UKvxT9eYnP8VHXQLqFlYplfzmTIG5c0Q9yQdid?=
 =?iso-8859-1?Q?/D9sTaMwhB8hGiphIl+DtXbUcakkAAQe44i4wYEGiamcwL2GHD+XqRzNOY?=
 =?iso-8859-1?Q?yZY8Ov8QmPoe+Y0Yr4RSsk7q58hW7fqTa89eT5rCmRyg3mQfZr32ZGd71q?=
 =?iso-8859-1?Q?fNno5AeYBg2w9kGWRX9NWyLpSIMfAtBl5fiLcVKrAMC/Wd/Gx/GgI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Qj2ySWxjzvihqRSZIe/QLttuwUamyKzYdiDLuimkrRDf6xW99vlF8ZxlsP?=
 =?iso-8859-1?Q?+6xlqdz4dUbwuVT6+ZsOcR6B0yaPQq+KXRCQEvHDYBKaqUqk3A72xQn9m/?=
 =?iso-8859-1?Q?B4KfzF64y10wVCeW0/cmUPYziL2RP8HOa09qS+VEnUxdcPu2YAteDEqPQS?=
 =?iso-8859-1?Q?V/tDE+NRNsW3UJFNYtTmexklr0KvaRgjGrJHHUYAp4pWhHefR9mXd77CYo?=
 =?iso-8859-1?Q?crFT6iM7GL1pmKDMXXta/eLwkh4ECqygqMuZHDZqhdPlvwnZT4BaYomz0b?=
 =?iso-8859-1?Q?nwQZ5+9FJxKJ3A0Bh0WWgCC10aa78lXzWb/Cz8+whsVBzOKz+tSutx7Pnd?=
 =?iso-8859-1?Q?omDdvkGjvaKIBjiHO31yq+Af8v6WPVY5mbQtbcdbh85I/JS44XkWNK1Lxh?=
 =?iso-8859-1?Q?Gw5xPSGUSQcItHYBQk/ZOO/4ccT+Lne8zznf3AThsXlyx0uKZmFRBROwyH?=
 =?iso-8859-1?Q?dNZzWj9CuWiWlB6qU9U/ACzvheB7u271jTjn4fkOny0XoSsWRQUEJR1L+C?=
 =?iso-8859-1?Q?w4SiGB69doRtWi3Wfa1UDL79PzWNeOebxmPW+QsbK5R4rUl9dUxYxfbivf?=
 =?iso-8859-1?Q?HSye1+mNDGnwgo47mG38xdBCAcMkQU6MPEH7USToS06wFfW08IbFJGRsIL?=
 =?iso-8859-1?Q?G1fa17Fztf729VcD/Ruh1+nWmwCov9vtMLNiTPxRXXrpFZMr8V2T7iawg4?=
 =?iso-8859-1?Q?xs4agBJ+0glWxbNIwcZyioQ7fpOgRwPPYKhsFtG4vdCw22+B8kLJIYGJcM?=
 =?iso-8859-1?Q?E2yAegL5t+ROSKhppzN2dIAHfv6yKIQZMuIKZMMRWWhJMdaQy/7FBgRGhv?=
 =?iso-8859-1?Q?k6XXOtTUr7EVH12YjWN2mbpxHOTsgfq7w4YDd+hTsvYRXO1Y6kGml9sjUX?=
 =?iso-8859-1?Q?0EJatchBkSqbcgR/TculbVU0KMr7i6LLhOHwspQONgK8PWnPEzFublz/w/?=
 =?iso-8859-1?Q?YY1eOLWxtRp+grqOYDiIZ+x1O80xs2+85RfJI146asFkKNnfOMo9acgJkx?=
 =?iso-8859-1?Q?PFDUeMZSOm/6O6VEcLzmBv61HKMBVVqHpvjSYcChiZMJUCyAThdmSv6S5z?=
 =?iso-8859-1?Q?eck9/yjaIUVBVk+XxyFt+KnRmU7J0Q58ubdw4iGvlt8Sa6d5GdoxF7wyje?=
 =?iso-8859-1?Q?UcDzmYddRGmdwXVZDsKn1rc+pqo4HR3uh2V10hTw9Ii0ic6ZFq5zLZyfGs?=
 =?iso-8859-1?Q?nr8h1RxLAIrz2QvSB7DoM2XGlR8uOlNBjfthPzk3i+7qJ84u+mwM7s2tyB?=
 =?iso-8859-1?Q?X2d5twcsGhwMO+SfQKGaPgysF3BCSb+OZIDYLu7FgXppM5tI5UcPRJSRgj?=
 =?iso-8859-1?Q?vjQtVFt0Tyf0y3IkFgm+L8GPwDekybJUEaleIQDWh+7zQPkWocQRzuqjj0?=
 =?iso-8859-1?Q?dEWQB/F9l47WCqjnKoK0979GyN1BDBkrC9/7J4URFwlIqpcFPFWWXbZoUh?=
 =?iso-8859-1?Q?udh/slqKpkg1Q9EU9ExRyn1+dU8g8Sw2V0Ddu6/3skmCtV45448YrDhUUH?=
 =?iso-8859-1?Q?alqLUDlLIDDnKZutaomkPGGVAzGNH9QzDLnNSvgSNSQgqE1T8YCnX7h5lr?=
 =?iso-8859-1?Q?rZV45L77I5Q6nuSS20nuKO3KFsEqEIPmbar7evTHLNW1fnfvn90vdxSaP/?=
 =?iso-8859-1?Q?Vq9nv54zJ7a9M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b4acb5-b9f6-49d1-dd22-08dd0234f5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 09:41:03.9122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JyBrjYg+OSxAuSpPeqn3On8M2C3oFDfrMh+HslDRxpZkjbDQXGveDYF9TwLw4Vi/fwuoIcF22jq2lnEK5qBA2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
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

[Public]

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com>



> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, November 11, 2024 5:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix a mistake when removing
> mem_info_preempt_used sysfs
>
> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
>
> Skip removing mem_info_preempt_used sysfs when unplugging the device.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index 33a714ddfbbc..9a0346ed6ea4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -138,7 +138,7 @@ void amdgpu_preempt_mgr_fini(struct
> amdgpu_device *adev)
>       if (ret)
>               return;
>
> -     if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> +     if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>               device_remove_file(adev->dev,
> &dev_attr_mem_info_preempt_used);
>               drm_dev_exit(idx);
>       }
> --
> 2.25.1

