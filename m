Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6168C27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 08:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E3210E70B;
	Wed,  5 Jun 2024 08:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wqNuBI2t";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D8B10E70B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 08:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me5sY7/NHYL7iGPw7+Ec/ya7Svb91AiZLJuXdAMTW51VNxxkAKqvvRO5KvFCPv5gKJ+QDC3jztHH/MAYxfSf3JguKulin9pCIQWT+99hYvyo5k0KMaQI1AOyuHV+WnwpeLbHvh7Ifg6lBfbYTPxUcUMku85pQKhQkfqhOSwYTUyCTOEVXO9om+Nck053N/AHeiXx2wQyk0B8vd9jcHuGB1HaEjsgMpPHt7E8ljmaGCq4B9lVPfOivR1H5r1H25TVMPjBOXgWKjXVWWPevCHejWgxs1xeFgXWt9yq+7eKTiSR+GgWktKMVr+m6f9OtGo9MWrMwTV1YiQdXmB/9FuPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HtObgQ/WVRraCmHJu4yChutk8tvwKlxcpMsbKoieWc=;
 b=D1u212EMAD9UoY2y9sNkIxnGqr0kZRMtgi3ZS70bNMn9Lz11o4yrpSvdKLk1UIUiFZLI/XlD0vdUBYDF6iPsLxduAAToHcmXIDQPoq9cBuen8j9ITu91sSw0Z0l+IteL2N96iwhF8iebgcc+eBz4L0eOkld2aNdwPHOaRHiHEdZalPOZBCI82vEC6J4V/iqFvspa6Wz9GokXTey1ZVmf9ymgwI4wmcvI+BvzZeB2HLxspKZTFIQXpvKsPMIRWJWuKY+J4gI11Y/hRBBFVWSnd1pu/NwTlQ6b9wIdDlYtARUn3Ew5Wq0HM5nBTFjiil+e7qCCpiQC/DgRtcvKQyKegw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HtObgQ/WVRraCmHJu4yChutk8tvwKlxcpMsbKoieWc=;
 b=wqNuBI2tmhg+CcgViSflh323Y7grkSggIgIKrx83rQSv0WTU+ZCpBG+P+dAW6ge6WdC+wJ5Tb1hv1u2pawxrDe3RTMqN7mPf7UlzanPks/n2qa6UIM2rF9K8I3iWBm7jU9bN1zaNCDfSILT/P+K1zRjGaK6mbxhsQgEjUdq+c7Q=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 5 Jun
 2024 08:36:35 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:36:35 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 4/12 V2] drm/amdgpu: remove dead code in atom_get_src_int
Thread-Topic: [PATCH 4/12 V2] drm/amdgpu: remove dead code in atom_get_src_int
Thread-Index: AQHatyMyu/p8W0NPCEOxL7qnuHFILrG42JPA
Date: Wed, 5 Jun 2024 08:36:34 +0000
Message-ID: <CH3PR12MB8074CA27968424C5F5EBF36EF6F92@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240605083419.3216905-1-jesse.zhang@amd.com>
In-Reply-To: <20240605083419.3216905-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d211c9db-9e5b-4180-be11-3a53ebf1a4dd;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-05T08:36:28Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH8PR12MB6987:EE_
x-ms-office365-filtering-correlation-id: 076ae167-73d7-40c4-1407-08dc853a9bea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Nsqghby6tYMOqdpWlM4PYPrz15cCpwrWRudUW1dw9LXHeJ3Lv0wb7K2InX?=
 =?iso-8859-1?Q?fGtkvDmVp2fZe//5NbdR8OTVZEaKg4YVdBKdpoyxNvNIL2EcaD9HxZm7Bd?=
 =?iso-8859-1?Q?SEM1SBMFeo1LWmzCeXjQWzPTQdSPvfbOwdznV51h2hbW53Df66dggcl5db?=
 =?iso-8859-1?Q?JE4nP6ldURR5DTzFNIjnXhjQuSNS+XIXtIjvVxrm4+29bkwqgu0vVBkCIf?=
 =?iso-8859-1?Q?Ubw2fr/Lnhu/3Gj0g1Wr/M7V15kKyzg9ejfJljGI735fo0lY//A86hZQ8D?=
 =?iso-8859-1?Q?GgdQYyZGZOefHWe0v8k0pPeHxwEwU/g4JYo5Tx4LLdu09Hu+nWaVmMC4SE?=
 =?iso-8859-1?Q?jJerpYRuhW9H8Ng0LSXeufFiNrMfy7bB8ZUTcRw96Q69YyW2tLt72MAmcQ?=
 =?iso-8859-1?Q?4p/TT9YoNQKvxhXaTooSwi/1OnjpHDny16hl7SEcWWxA3U66fG2g7AWE5o?=
 =?iso-8859-1?Q?lQmxf/KcfjQUcJVOo2+x2p34oFMYLa7Ui+TKircjngungC7L7iIPUhAlPV?=
 =?iso-8859-1?Q?VoiVihAiS9T38c973FmAGgdy2VHSZL4pIxUpKAp+BcuWbSm4q9SpXw0Dfv?=
 =?iso-8859-1?Q?dbkudkr9Jt49bE2s/tNpH5DBjEB8etqJVa2KlCF1y5b+ZvYqDxiwZITkVw?=
 =?iso-8859-1?Q?DIM34OW1LkFBAhxWG9SbFo2At/RENOwcR1xo+w9kJjAY9TvtJ89UR8O9Kl?=
 =?iso-8859-1?Q?jFq9pslK6dLifbaVsF80BdFjRvYho98SHNZ2v2MiYlobz4fT2k06J6jGZs?=
 =?iso-8859-1?Q?bgV7wWwV9qVmQXF+jkfXzyS7f4b1QRFn+qIPf+6hYeYYe0WVDzYk4ZQtZl?=
 =?iso-8859-1?Q?Mjr62xLroqLDKkvRVpiAngJhd6j3QeLpv3jHs/yt50kSJuycpuwI1IDcAP?=
 =?iso-8859-1?Q?CwMkgEloO+Hp3ksn/QRYv2qCWtv1z9B//kKN2wt/n/CFmbk97A65VQQqit?=
 =?iso-8859-1?Q?WbWxRG76voeRVYrJR7lAou3b3Z+QuNrKIoQUGgQhP3vBLDQuj0CxWtx1QU?=
 =?iso-8859-1?Q?YHmbpOcG2wixIfpFznercsXNU6l+eUkYVnRz4Cj5vbLqI3PyrSHPN4/gbo?=
 =?iso-8859-1?Q?BKEdLAJfv6wa5FJVj1knDYDT6w4qro3Mq2P3qMX4puz0/a38uC2ieHLl7G?=
 =?iso-8859-1?Q?K/UN1Izu8p85ZdwJyxAawiehhpso6d02xoGZiQrqAtOxB1hsHEAPcGv97/?=
 =?iso-8859-1?Q?5m8K/FSY1z4i2NVa2PD4wGebVZRzWF6mFrE/PHtkjR61xm2C1F7XTKtV6F?=
 =?iso-8859-1?Q?FymQEk06yMJrm+dT6Y7LiR2XX245JoyutLdXKcM8OL/gmQFYz7KAoCo4gl?=
 =?iso-8859-1?Q?zYLBz+6zTCHF4RglacaggCobkTQiqyIFsOg+UGBQkDBNMoGF/kRzG94sCB?=
 =?iso-8859-1?Q?neoiZTh47c/IHR15RVKgHicG/GqQLLSudgb78BS0JSoW+NQzN/WCc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ylKffbtBjfNEQ4irBUVAV0vQRkbyLsjKZmbh/p8rVtDmCKiclXLCCfcwh7?=
 =?iso-8859-1?Q?xvJHgeC7wptyloM/g/r+oO5sIfXQe99EAP8djL2ZAQZyCXmQP0Ye1UuRxk?=
 =?iso-8859-1?Q?LkxlmPT+OfSIdFqsAuhfg27o56KivCS+cPu81HVZPwCmaCNjN3i9n4mnGl?=
 =?iso-8859-1?Q?3eSVES4PMQPM/z8Fu1vHZ2uLWC73JnajKHogkTZV9r5nmTYniyd2kgoNGT?=
 =?iso-8859-1?Q?QYDyAjBci8qV1CLytwjpl2B4PVC37gJHqBW3dupNMjgkYL5lfToJPUJ0vT?=
 =?iso-8859-1?Q?R1GXDX8ynW8TsOBv+19VBdS96asoTQHPuJO2R1ZJ40cBq7mL9zXK4zqj+0?=
 =?iso-8859-1?Q?iBRj5j3fbl48VbALV6NTVuksAZJTn33dVLJwsLWl0u7JJ3B40mAQHrJt9O?=
 =?iso-8859-1?Q?q+WdNC98UNeETzKoqvt8zeOWoq/WxVeSbIsf0zlCWoAB8eWfNLJqWI3lmi?=
 =?iso-8859-1?Q?ifWubAOntcvaMQiTUDQYJ56eVHiffZFhYlKm0bWddDyJYEytO4H3ya5i6W?=
 =?iso-8859-1?Q?K3ByUKEBQgrMGskosLRxnksGoc4lKK1IUaSyLfvDZY+UGy0lHVycL6mHF9?=
 =?iso-8859-1?Q?ocPZrlZ5EgChVU2cvWJlZsnsJSBjD86i5QTKN1ce74slzHUwvsGbKvpuMP?=
 =?iso-8859-1?Q?tp+xG/Kn9nJ4gvHzz102JDWvMP3x5xCXYQ3NZAvxCBx/sPPTSxXtpgVM1T?=
 =?iso-8859-1?Q?p9E47kcQ+5dkR/X3wcNEbbZFzGv8zpTCVimSjQYlyKEEWIjza941J7uMZM?=
 =?iso-8859-1?Q?f5RX/Uw9AYr57C49LamuEFfNLubW1TgH46+6Y8Uljjx24tKixHj0DuMDwe?=
 =?iso-8859-1?Q?ekeNHQGUE3pzBhYpGfBnqK68ET51mAAq25A/lNPDB+mM2ysTJNdzuXXKIU?=
 =?iso-8859-1?Q?fbWeX0+ejHJ4DQuPHrG1o4jNT1KYJrRdPT/CkJjilSAjHtwukSCrt7JNV0?=
 =?iso-8859-1?Q?BMbUjx21t9Al2vYol6vCv1muZl7d8QnALSx2d93pj0nzcAgd3h59zx/8Sj?=
 =?iso-8859-1?Q?MBlNP+OrUbXpOsgbO0pI7mSUOcD3HW8heFnTWETD8YczRThJPI8DI3jyyd?=
 =?iso-8859-1?Q?ZPLomH/9cTnZm53rQOmkMYGy0orkvUHP3ksySwWCVqI9C80i6CNM1U8dL8?=
 =?iso-8859-1?Q?STgx1EQljK0GWkvqI144uQ77MUSVKYZ/W+n3Mphkpd4wk3U0sK6lHtSVbs?=
 =?iso-8859-1?Q?D8s20aiQaKP8eOgke78ZSj6ytlvv9buIUr+pZ+752gm9r7cTGquHcm/Hyh?=
 =?iso-8859-1?Q?1UrxcYcYE89FdCly1FX3eRUi3bS1bP1/YFyvHuUwv8nCghUzqOymf+wIlr?=
 =?iso-8859-1?Q?Pa4VknU3koO+nYuxtn7/a7l8NxiYEMx6R3mejc0bM03UwD77PDyaIf+puY?=
 =?iso-8859-1?Q?vu3jxhIvBvfbeMpTYQWEbtU6gUjci2bc96kyLDXm3uA7iOSvPqzXg0i9Yw?=
 =?iso-8859-1?Q?rCwCloHxROB2UV80WRXfpmPNRSsvEMUTeVKv/YcT53quTs93hDY0k8TZqC?=
 =?iso-8859-1?Q?YgWKj5ayokj02ugKt5kYY7pIYlN6X0xnrNfYDwNIV38OcF5YsY1kBBq107?=
 =?iso-8859-1?Q?YFTU9n21a0reVsmEqxHOklWk2sJYMe8OOjF/lZEtACIt9hRAFkLpSr5GYJ?=
 =?iso-8859-1?Q?hTmobojBp05Uc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076ae167-73d7-40c4-1407-08dc853a9bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 08:36:34.9773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCq+5E2biM683Mg8/k3d7xmrvcrsreg56W30/YHBj60DceoJOLADEf7C7kt9QilWOA28hIM5cHbaX5GxmHdXFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Wednesday, June 5, 2024 4:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 4/12 V2] drm/amdgpu: remove dead code in
> atom_get_src_int
>
> Since the range of align is 0~7, the expression is: align =3D (attr >> 3)=
 & 7.
> In the case of ATOM_ARG_IMM, the code cannot reach the default case.
> So there is no need for "break".
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
> b/drivers/gpu/drm/amd/amdgpu/atom.c
> index d552e013354c..09715b506468 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -301,7 +301,7 @@ static uint32_t atom_get_src_int(atom_exec_context
> *ctx, uint8_t attr,
>                       (*ptr) +=3D 4;
>                       if (print)
>                               DEBUG("IMM 0x%08X\n", val);
> -                     return val;
> +                     break;
>               case ATOM_SRC_WORD0:
>               case ATOM_SRC_WORD8:
>               case ATOM_SRC_WORD16:
> @@ -309,7 +309,7 @@ static uint32_t atom_get_src_int(atom_exec_context
> *ctx, uint8_t attr,
>                       (*ptr) +=3D 2;
>                       if (print)
>                               DEBUG("IMM 0x%04X\n", val);
> -                     return val;
> +                     break;
>               case ATOM_SRC_BYTE0:
>               case ATOM_SRC_BYTE8:
>               case ATOM_SRC_BYTE16:
> @@ -318,9 +318,9 @@ static uint32_t atom_get_src_int(atom_exec_context
> *ctx, uint8_t attr,
>                       (*ptr)++;
>                       if (print)
>                               DEBUG("IMM 0x%02X\n", val);
> -                     return val;
> +                     break;
>               }
> -             break;
> +             return val;
>       case ATOM_ARG_PLL:
>               idx =3D U8(*ptr);
>               (*ptr)++;
> --
> 2.25.1

