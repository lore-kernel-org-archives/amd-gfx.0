Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDE0CA9EBD
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 02:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7737F10E213;
	Sat, 10 Oct 2026 02:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dH7u1+2+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A0510E213
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7LWRaeb/m/1y2thtZtcTHeIjddR29ti5ZdjR4QRFcWIeIYdIl3yBg1UAreGb9pZ2jzyvUhgAJU6s6UXWeT9nUQtXfvwVAfeHmA8wSww9Q1ON3YnOpxYB4D574DhXE9XzIRpWXh+cuJFY7NrVQKQTkSRE+ylB8Kpl7PY+/QN1TVyD9KAEVJw79rEbBJoCk5RO0TWRWV3yN5QNau9krquAcZVuMIQIRfoyF08ZsZFXVqsWxA8SBZknM78/DrtFlQWhfW7YTkhf5bI/rNxQSuJHaRRlqMzycn8rNUD+vG2h89j6MwKS1R07fdrlk+8LAi0VqFAYac5gcnA0mPHxwAvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYlHB+9w/Xvit/vvJTuowc22uwzItU04boAPlfMmyoA=;
 b=VaG/qnQKmzch5FPiFrA1UeqEeP9Enk3ynEUwxNJ+gN2bPPFnpIBjeMqTOS024wP969LC4JbFHUHA4yyJ9YZ4HLzrGu6L7CJ6U0Kn15QxMvBT7aWwqYCarIk80aq9wBzdhJgW2H/4YiACxYC6GPo0EiDMZSPCgqVys95yNUiGKFzr3THyR83raE6m4r8erRiDrZ80zBfKxPLjUrhGEcue9qf5l1xopk6UWi60dp28PwmxhNd+mh6vs1be1lu5NIHEvADLQ8VisV5aq09WGnxhWB+lU1J5i1bHtp7U8QmyBM/98WFckidSW/K3WtGTTNyI/uoDH6bcQgFx13mDLvOStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYlHB+9w/Xvit/vvJTuowc22uwzItU04boAPlfMmyoA=;
 b=dH7u1+2+ct8v6SoFB4AzaJCcA+jSlvginORvytN4cCzOr4HqmXauyUx7Xd1pDKW0kqTzP+r33OcUYp81mVANGOTUTootXubEKw8Sdx6Dm5N3r9UAZab6VeHZYpAIyl9PtokHi/H6hhjLNY5U2M21NeujbCbYwhfJEqimXKi5OZQ=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:14:22 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0451.026; Sat, 10 Oct 2026
 02:14:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: Use fw-managed EEPROM for MP1
 IP_VERSION(13,0,12)
Thread-Topic: [PATCH] drm/amdgpu/ras: Use fw-managed EEPROM for MP1
 IP_VERSION(13,0,12)
Thread-Index: AQHdWA4lzL9iaJo57UKRbr0uJBFuCrb2Cbjg
Date: Sat, 10 Oct 2026 02:14:21 +0000
Message-ID: <CYYPR12MB8729678CA60FD006F6E21E80B0912@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20261009164906.206393-1-cesun102@amd.com>
In-Reply-To: <20261009164906.206393-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-10T02:13:18.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|LVUPR12MB999135:EE_
x-ms-office365-filtering-correlation-id: 18cfb7a5-1d78-4ae5-6adb-08df2674325a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261009223027099003|10067099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: NMcNLM5pOj9TP6ZocSOaWdfBO1jqLj/ym7B9oBAr7uUXSQ1bbC3cSIWDOX2sJCBGJ4Fm2bkR+jt0Cy4U5HzUouTat2hHNGkGAkTKU8k2jT1A1soSf+cvfXmWYUSEDn++dUweraRX8bNSNAZDIYJCIpnCHXComRBGEzInfO4vuYKUmAoX78pOgBJsvrnDkOsR8hep9SpUfoVbBO4AHwqINgOVo/WZfdNdI1ka+lbtLTsVco1oO6jPLsfATTeZQRUJL0zinD7x0RiU7vzFkGnHsMhqM89KgXmsX/wHJiCpqe+z3Iu+67IjNk8ngMuPPilNILqgDHPWlIv+unDx9Xf2j0X1nC05fbzCypvtLqEdbMpiLytkhYIYpSKSmTjWCIlTytMInpPM624E9umKEa2hI5nVK3rIbHxyaQG4Zx8wQr8NlGchspgLsm//rqAenz2M0EFWfskU7jlcInh9ZNbbBsnxh9liEwOM/m0KrRkmX7Ib8hAKH12+2RXNKKPKAdJFE+o4OkTAqWfNAQ30z7mo45IJfpQr4bet/0zXQqaClWIVUbYqUACSBuax4FQ1vS9LcLyjxuj5bnaaz1mmqqMHyOpiSSWKpChGQli9qdY1KOuYPj3SWQsSltgy8dGNgALxxyLSXPW5OUst9BakFG68zV9WGLUg0sL9bJuHsB0CjArnkG/l+Cdvb+73tIGM0V3YmgJ+7Z37PyXP4wgzKRw9O5sWxrE+CHS3NkR6kRALUJg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(10067099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NhCVpKqlwOsWy8idMXwQFcA3UD03ZxJDbtM+YGKAr1WtuchRY2Au8tus/XvA?=
 =?us-ascii?Q?Gu7btj6KwD6ChZNO/QYnVQCCtYoYx2zuKx/viwKiLD2lRdZ5mqAkmN0lra70?=
 =?us-ascii?Q?wxUGRLWovTphmOqN1s3ed8LQsKFj/e7XucDMVagdNcQYqF470eeiAc6mF4L0?=
 =?us-ascii?Q?CDE2xzTU1ecwpORJewXRID5gGXLhMY2MapKV3oi9OjjfM/CXeYqA7N3bCKaV?=
 =?us-ascii?Q?vqMzzyimGgrKASPbuTU21eUD1VvXosUCKR9bWpzTQ+2kOrhh5ByF2vHzMUhV?=
 =?us-ascii?Q?uaoSwIm/6iJVcqExYCqGx0uNOqZxp4qnMYm4TgMWCLYZlYU44xQ7Erk/NGmu?=
 =?us-ascii?Q?iRz/vpKgjxKlQdvE6fTq3TD1qDXIs4QjInbgmrPme0wl1kKzsOAWcP2Lewa2?=
 =?us-ascii?Q?f+/tb9ufbu4p2PmPo+OUoScambqG7cWb1S9+pYXxPkoOFJk/wfrgxnppfU7W?=
 =?us-ascii?Q?p1nLomLVUOD6JJde2z35huf9+9GI+aiJx7REDUq55Y8hxLM5R9hv8caKQ1rX?=
 =?us-ascii?Q?TIS3nBleFrAoYAimcmRGPbD8ZKbRSiqXpYQpSLvv+4QVbZ7akbkd4F1zZf7T?=
 =?us-ascii?Q?mSPBqH7FpfezItenbXmnf6gvRfI4TGc02AeXcZ78+kXhP1YDewZu0OWUg9Eb?=
 =?us-ascii?Q?RzpFaWOjsb+SBj5gFs+O6XfdiZgJuUq65I0gmKRjgUMosw7MW0E3WStWhhIT?=
 =?us-ascii?Q?HoDFniO2h+OFcJwYHQK3dDe9yC1TgMb25kco9C/D9wHwmJVLuHiYN68XQLi7?=
 =?us-ascii?Q?g3fYKTjCRnEWoOWRobJqVnJBXq59iOmwFkksopZqG4mUF9c5s0OkP46Wj+lU?=
 =?us-ascii?Q?25Sg5XfykO91G/E55a4QS61uzQkEv/1zlEuE+rROeD4Vq8lo/syaEpcOHEqO?=
 =?us-ascii?Q?7wpA9IaSXeOKIeRXiFLUFc1q3lWoMkP1WIm9mJpmK64WeCfix4a8hcK/Tezy?=
 =?us-ascii?Q?up2EVyVLKFgcZF1pcqjNSUuptabBWzcvgOtxrh9RHmWULZjeWxwaFFqc3haZ?=
 =?us-ascii?Q?HjK/YHzIgaReXHBEuuXCgT914erBPwCb6MHLdwqGHuJPEeuF4+sIilpHaVr8?=
 =?us-ascii?Q?BKOG0fkX3+L3OWpaOr3AGKZBWeogXCwW9ZutS2LcAegPRhR4GO8NtlcrN64Y?=
 =?us-ascii?Q?ztA6HryMoM+t0qPnoBKyfTsn4hKyqd3a3aVhELxOVy/rKtGUaYZJD5eXgpDx?=
 =?us-ascii?Q?2A6b9MJU7Nrreq94mv/E9cvWgwfqMF33K0RSXqCcpNYRILRa5SWV7zlhlj8G?=
 =?us-ascii?Q?0rpGOc5oXBBYh4ir7vfpnh4PDafZOnse8mx4g9vfzD7hM7X8QdjOZ36Uh3ti?=
 =?us-ascii?Q?Dkm/3e1583cxzuVqQ1NI1TbLc9+9H9VcoOLNi8dFrVSH4XL4B+h8WzIiILgU?=
 =?us-ascii?Q?iY2gfuQz58+0JvXYqZU2SNnHvRru2PDr7eZ/ANyv+cKGbNdigfWMFT5DUHYD?=
 =?us-ascii?Q?batrLjUvMzgNnBazP8i8khSOeMJosPxKlikrbUr59Cw2GvYD9PRhV4BqoTBX?=
 =?us-ascii?Q?a8lkq6uNYOpC3XLiRT4F8GLZsSCiVc65tjY67bPSA0DaYCRfWRJwTQ9pVSMS?=
 =?us-ascii?Q?y0i8RT29pudrG3e5zN0bsAc101RQAVzsFj7lvtLJiMMwCLD1kcPAtOw6mQP9?=
 =?us-ascii?Q?iye9BCqbCW1o0ZlcpME8L0we5lwrC6FEdBAYUz15XAIxM6547W0uM72KkBss?=
 =?us-ascii?Q?gQuyQZMxqNqSDRSqj5wW01jOvCKUMNaADo/+Yy5Bbfj7vi3w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cfb7a5-1d78-4ae5-6adb-08df2674325a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 02:14:21.2053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLxzTg2GXnztNyH1CqMErhEkGw/8Rvz/Eq+fYTnhJq6C4qmOLP7X/79SllYUopG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135
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

AMD General

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Saturday, October 10, 2026 12:49 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu/ras: Use fw-managed EEPROM for MP1
> IP_VERSION(13,0,12)
>
> For ASIC with MP1_HWIP IP_VERSION(13, 0, 12), enable firmware managed
> EEPROM
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> index fe0e35357af1..cd332fc267be 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> @@ -40,11 +40,10 @@ static const struct ras_eeprom_ops
> *ras_eeprom_mgr_get_ip_func(
>       switch (ip_version) {
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 14):
> -     case IP_VERSION(13, 0, 12):
> -     case IP_VERSION(13, 0, 15):

[Tao] Why is IP_VERSION(13, 0, 15) affected as well?

>               mgr->eeprom_early_init_service_supported =3D false;
>               return &ras_drv_eeprom_ops;
>       case IP_VERSION(15, 0, 8):
> +     case IP_VERSION(13, 0, 12):
>               mgr->eeprom_early_init_service_supported =3D true;
>               mgr->fw_record_enabled =3D true;
>               return &ras_fw_eeprom_ops;
> --
> 2.34.1

