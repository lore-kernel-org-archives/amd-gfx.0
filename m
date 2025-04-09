Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E99DC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 16:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD2310E14C;
	Wed,  9 Apr 2025 16:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bC6MH4XL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DEB10E14C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 16:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZzAJVjSDP+ypX2AM4MhN7FaJ6uFl3KSx+5wTl2dN2lHKhbs215zSHIPdQbDrSfWVFo3zZvRlOiWhl3JyQykCZ6pZoyIcmORI4wEoazRgcncFXArF2ICe9TjYw/naiUFbr2N3cpW7HdISsn/uz/7viSVnK7GHjKGYTvMAWK9NlAwBrexI+j0RjAGbu2nWNKutmGtn4UNcdXqhmkGGhDHF/tA+6qV/fQ/CBOb0oCQ9asvZ5F4Jos8P62U41JZvboommCPJNK//6SLKi/oMPLkoPpuycKlI4wgiEwFeLDTMBgdHELAetCR5tZrnIaXKdIm7aAf1Yq1PkS4NjXKL82W/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj2YdaxRE9r7X7LVTLSDTwM7nJXafy4WOUkhOYsaC1c=;
 b=heOv3XaE6tZHEuJVsxRbyHdS6Rt5QTBWul4qllYg4Ya9x6oR1OxJbpjn1B3DbEPQJ5/F/9O6kvUSMtDraziwKRtR6ZkEMirn/pavUJ93S2ircZ3MkqCONLICQh2O2oJAwOkUiaaJLnhFxgzYOY8ACUz+le5jd3t9jLwFEB0Z/6IEnEEMWf7q02QTJdxbBu8EPNV+168NcKp1XkZscQGJy7ys9cVqcGYq3niBV6RKoji5KlhtvUb6+9B4CRlvLKmIkK9RVqyIDPDHcGKOeBMbhhkBASN1ActZKfYFDCBJ4z2RAXuEBWhNiZW+j8MVN/4CvCuds72RwTXK5Fr7wHb0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj2YdaxRE9r7X7LVTLSDTwM7nJXafy4WOUkhOYsaC1c=;
 b=bC6MH4XL6PFECShN7e2kohKRci+Obd7m4y5YVdNts4PDNB6PdFxTbRcPiU4mmD2Y1hIC5F0LL5Iym04cK7APDxto2mXTVfWgG9Xbmn82TOrL6UsfHZnHWOtZbwuvxmXiXghD0PKFDzl8tz70OS4EphnoowuZPE0dBuyphD7wnLc=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 16:47:48 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 16:47:48 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Yao, Chengjun" <Chengjun.Yao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kaszewski, Dominik"
 <Dominik.Kaszewski@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>, "Yao, Chengjun"
 <Chengjun.Yao@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix drm_err argument type error
Thread-Topic: [PATCH] drm/amd/display: Fix drm_err argument type error
Thread-Index: AQHbqTAhNrRNCukcpkeJND8VLA/kNbObgu3A
Date: Wed, 9 Apr 2025 16:47:47 +0000
Message-ID: <CY8PR12MB819318695A93B8E948AC89B689B42@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20250409091640.122655-1-chengjya@amd.com>
In-Reply-To: <20250409091640.122655-1-chengjya@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4e761554-83fb-4d94-a34d-4f24346eadd5;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-09T16:15:57Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|SJ5PPF1C7838BF6:EE_
x-ms-office365-filtering-correlation-id: d2686990-20b7-4ce7-1470-08dd77864297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IrjV8OLMZ8tnWGQPVL4A7t0/z7P9xSx5ZRtre54llGsyNvtrVZNHMhwxqtod?=
 =?us-ascii?Q?7NDT7jePWfkwIqTLW7/zkEZgcDyR2mxHd5CiKbU/Upmhpp/jH4BKYTjdZhOM?=
 =?us-ascii?Q?tFNiMf2Di9GotJKofsKkQ0OSFZ9om2Y3uvbtzcrw5YlVo7lUd4QsoXJWt1cz?=
 =?us-ascii?Q?ZqvsO9ewHh6T+cEy67bXgA1hBiInUAC7WZqYkeU7QWjGvi5UDDpkCKBZ5nC+?=
 =?us-ascii?Q?w/01nkxUbX+lRG2GKxj2gsC+8PnyHryjLbUdT75vBx+tD94mMig1DOE/AkvU?=
 =?us-ascii?Q?M1Z/SKAziev2EGnJROlJKDm2/FSp3TBmqME1G8Zw3ZyULVcYUFjFE81hHe1m?=
 =?us-ascii?Q?F0e8nnO7JpE3qA7Xjr6USqyAhrfBHbvWw7t8D6mVj5XqYii5I2hJ+WJlYrq5?=
 =?us-ascii?Q?OMljiHDv5g1Oh9Sk6d6dlDtjWuHvnIAfd+wyQnoZ7NDkYaK2I0uRk9oYaAEr?=
 =?us-ascii?Q?Ly7Glz0mE4lUVDUBbqH2PL0uCzOIDX0G1EAuGt983VEpVssj4ptX8FnCeO4T?=
 =?us-ascii?Q?Zw4yPL1/NnHWnFtmMOJa0Lf8CXVADqvMJ7y+yHPyvBmqbmQG/NkNoJj2GDiC?=
 =?us-ascii?Q?QsMHh0dsR5MpZdGay7wQ5/A1P/CxCTIGGj+ZBZtN7w7RJZ1HbbDXVCUcziCU?=
 =?us-ascii?Q?4sMORMKxSq3eG4C2p37PajKnqdVYO+QukDG0tmrOuGMSgL+bnVOx77ElvHTt?=
 =?us-ascii?Q?j0IGsy/MD9zEOTtNaU/HWPT6jj9w/SgROBjNAaX34qvSoxXgpQBniY/JPDgO?=
 =?us-ascii?Q?2i8SNVH3pgwEOM/SylQuXoLmcpLrAbgKQpKFzcTc+ebym5NPVgBTcJmjXvCu?=
 =?us-ascii?Q?ZoZQV+xojVW9h8FD7V+1t+YaNqUnnRYnQ0P7fAvfTYolgTeYERRUNQ4aBc9b?=
 =?us-ascii?Q?+nqAop5Uzf+4Y//twOQv5EY4qchLWex1w6uvRCA+uh/scpM9AiBgBQQOX7ht?=
 =?us-ascii?Q?H/G4049TFCqEFzcBPZ74Ik8yZnWqm6ELdi2SnYO7SIXGnuaTJFSfZ074yZMd?=
 =?us-ascii?Q?kQNoVPsVOmE//xd4fndYZgn/bxsVVhBIixpY+HQjiRQiZCLALt8y/KUR1uRR?=
 =?us-ascii?Q?eqwLocEwfE2sBsEjCbUiQSWk/guDYOaefBe31phyjgJJMerbeATwKtoFDj8q?=
 =?us-ascii?Q?Qwhq5kAwrrBZufed5xvGmthRRLPxU3o7YdMJCCs2npLrNI4amq1sg93dfMXM?=
 =?us-ascii?Q?KLbeIz6smhfRvmiTcQIaqdPPSRysAE/1EmOqftUf28/ZRYPnW+Mk+357St+H?=
 =?us-ascii?Q?dyhhuFbDz4Rl2FuVZ2usx2k/bttdL2L4UeElWyK941EEHKb/y8l6OuMxbsGZ?=
 =?us-ascii?Q?9DPjyYF1MBBorx/xZH/B3dlMMXbef8P7VAqJfYohUJHVQNj35wNXS0dMBvkJ?=
 =?us-ascii?Q?Ad5/PE/LN5qLuPkuotciYN61weVd3+5bdF3gVPNJfU4QztcQjNCi4PGOM/pv?=
 =?us-ascii?Q?2lMw3wpJsddCszIJAJ5fEKPqysfA5aqKf8o3CUfFFU25tlpuBYK/DSDeanxv?=
 =?us-ascii?Q?ZhkrZi1zMmN0u9Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z1CVjzxmC6QRq8iRWvQJbBC+KpIoX2BydKJEOpqXP+2QLgnYuW2TgMdYDLKG?=
 =?us-ascii?Q?oT6jP60owkrTm4x4ET+mAUKp3uq8eUK6mkDCBysrvRt7mvP3VDEGTOYA9Vvu?=
 =?us-ascii?Q?+iDAoWjyEfCOnqcooBwHPjCQUa17prFM6kiiGRpmLoBfEX1Edshq0P4LbbWk?=
 =?us-ascii?Q?BdxG2O6NAQRX5LWGDi8uAp6yjP2ISnjXgJZNoxAEGWaVDetZQk0JrwMZzmFe?=
 =?us-ascii?Q?zaqvWb2wfTVUHXvInYFJ9TIwZaVnb7FOlEyMRJQStLppnnobFDAHsHvBBCiV?=
 =?us-ascii?Q?sn97NjwfrfJvSg9R92i1jxMVDbqDXwvBT+5LWl83wmxNaZlOitG1a/61Ui5S?=
 =?us-ascii?Q?/5+rpC7mLQ+Ks1HmoDjTgAxxHZwyW8IQWJzNIHBK7DwCoPuVHDFQ/bDA9Fow?=
 =?us-ascii?Q?BtxXkyZi7PD99+QwGkt/3dKFvz+Lg0wm6/NaevYN8RpvS+dV9r/j9G5iagMX?=
 =?us-ascii?Q?u9iOkfFtGNVLEsd8O4A/tLxrvebN7qw/zYWnCizUFgoMd+2AuulzQorOxIys?=
 =?us-ascii?Q?HFRjZjpayHcys3k4vqGmPgiGJ2qL7kw9L0mLyZaHZbveQ/sjX6JaPmeW7Z3e?=
 =?us-ascii?Q?sZ+GbnedPZd5mbL4j9Kb0PbHq9hg1pbI/ETAjZbckdUobd25nUXKw3XvrsKs?=
 =?us-ascii?Q?Sb4dDDwiAxKkeZe7lVC+6pJv5Q9cDOgr8E9LuIZ/JAl4i9pUvaKWZKhQQn4N?=
 =?us-ascii?Q?RUTsHoZnxPJUoGfi15LeEsqAlWgWp6ZOvsd8BsyxHe11Cxv++bnsk9XYBeE5?=
 =?us-ascii?Q?ZwLHRxkzphOYnmCywM1N/8Lvwt2I5lJ3j7jsi/FDHM0pDWKlg51QtHGNVtW8?=
 =?us-ascii?Q?rY6aeLQgUahPNKjdK1H/7UbgJlkux1G2GkOEr/1qt//Qs3DZIITuDAcnAnUN?=
 =?us-ascii?Q?bh7ky40JHQthISbY29GefoCO5lGSi4D2AWwvhLoOAigR7JOdxgl/4byCnnMl?=
 =?us-ascii?Q?qju1AzjnCzOF4yKMk4+4vAn+gpw7dni3SP9Or2g39TSuzmBV7NVF2oca48fa?=
 =?us-ascii?Q?klfHj8MRzs0GCu8hAhayg4j5KrPoqqGYqQ3uLM9LzZD6MNmaiIYUF+9IB/8P?=
 =?us-ascii?Q?Uon79pIuQj3OimA/6Lir4zTaUwnH5TdlkRyFGFWn3rcaIxsx5wIlJbhG60mS?=
 =?us-ascii?Q?/SrpE5qRPq+QJ8kL1XXpxItdQ9oh7PXYPypWQYby8XnbUIG6Awj0N6iNUjmt?=
 =?us-ascii?Q?I3nfFTyjw+MeD8lf/snaccuIV04SxqzrT+Jx1B+Lio5KRrzCmrtp+UlsXRrq?=
 =?us-ascii?Q?+OEVXtmB3OdYVKp0bS2FiyqpCcLZbatfaydo+Bz55CzArS9C2uIo1oHf3Y6s?=
 =?us-ascii?Q?0P5QD6R2rSG9dGyQfomhouXxopGUUETda0HKJiGIsse0Nlv5rBSPoiWMG029?=
 =?us-ascii?Q?fo9qTe1jdCsq2D7PkaNun7nhqDp7o59a+dbGUSiPJKGpzMGO/oxlgFL8T0jr?=
 =?us-ascii?Q?h0uwnzitdJgDe3Znxpg/4WvaimTmgyl5ZynqUwroyNUviCqev6eX+l+v9dbD?=
 =?us-ascii?Q?2ZIhMI8AzzZTAffC7nDn8hd3zNIAJSJTMVeXsHTqxAOD76J6cCVcDdqf9Dfu?=
 =?us-ascii?Q?0oiZXW6EgBPZzcFUx8c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2686990-20b7-4ce7-1470-08dd77864297
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 16:47:47.3870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohUv3qT7p8lUsOGYwSKWBwvTTfCg9kn51HL6uPkNPBUcGte+BKFExLHniDeYSyYV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
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

Reviewed-by: Roman Li <roman.li@amd.com>

Please fix your authorship format as "First_name Last_name <your_email@amd.=
com>" before merge.

Thanks,
Roman

> -----Original Message-----
> From: chengjya <chengjya@amd.com>
> Sent: Wednesday, April 9, 2025 5:17 AM
> To: Li, Roman <Roman.Li@amd.com>; amd-gfx@lists.freedesktop.org; Kaszewsk=
i,
> Dominik <Dominik.Kaszewski@amd.com>; Wheeler, Daniel
> <Daniel.Wheeler@amd.com>; Lee, Alvin <Alvin.Lee2@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>; Yao, Chengjun
> <Chengjun.Yao@amd.com>
> Subject: [PATCH] drm/amd/display: Fix drm_err argument type error
>
> The drm_err function expects a struct drm_device * pointer, so fix it.
>
> Fixes: af632d3f59e6 ("drm/amd/display: HDCP Locality check using DMUB Fus=
ed
> IO")
> Signed-off-by: chengjya <chengjya@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5e6fdb0066b0..60d10d8cdf59 100755
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2300,7 +2300,7 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>
>               if (!register_dmub_notify_callback(adev,
> DMUB_NOTIFICATION_FUSED_IO,
>                       dmub_aux_fused_io_callback, false)) {
> -                     drm_err(adev, "amdgpu: fail to register dmub fused =
io
> callback");
> +                     drm_err(adev_to_drm(adev), "amdgpu: fail to registe=
r dmub
> fused io callback");
>                       goto error;
>               }
>               /* Enable outbox notification only after IRQ handlers are r=
egistered
> and DMUB is alive.
> --
> 2.43.0

