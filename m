Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8648C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 07:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5815D8B940;
	Tue,  7 Dec 2021 07:18:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CCB8B93F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 07:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4Pu1QuDkfpZOCvhDp90c3bJ4YUL9tQ1yAZBFhJ6yK5+sncQwQxozg9rjg2P4d866Iz1CmEfDrQj+pOZpeUpGKBcAaQhEGcMjQw0MIOMPEtpwOxiMISqldDPi5bGd0DA9HkJbpScfIVuZEL9kdpSlBAc9/13fqwSkpQ8ituDidShj9kZ73A/F763FFqRW7AKHIshNsz4unYXEk6LIP0dSUJPIfE5TZVYpggyhcsTQo+J781TNQSmMzjwjC8mvie/hw2PFEjNZcKF2l7lGWOxcBa3ykyErlvrvcSr3h+CyuwWytyPeY+OWtBtRixtPXorMlOxmtQoRuCZlK03+qB4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMyJsvM8pbrpmSKGmTBF1ufwbdL48s/5t4uWZaI/NmE=;
 b=OB0LjBkIGmx0H+hidMNtmXGcxL9sj8GSrEPwolD4wiWAdC9+mNYA2V3FQz1U7OepswjF12voUYeJyCnLt9qpXsrdkg1MVrDeUDfRZwH9ZIH+oK8Q+G+kTpROtTfvChOfbBnZF3Ion/qd6rWT1fVOIMHa/ZEg0WepR3B7Kb6uTk+dJZrmHLoC3wI8PGhtyyOoJHy9GAxu9sSAbarV95DHwsbgTtcGa/5OhIslxwOTd8QgncsHlI5fA7CaHVuf2r4Gh5L2Jq15LsLeTjE/w6Q6MQXJiF2Vmcy+ww0XdaRcOkKBE36cTVhiBxY4Oeqezxfc0Lwg4SLO0lLuRChOJlTMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMyJsvM8pbrpmSKGmTBF1ufwbdL48s/5t4uWZaI/NmE=;
 b=VnPg8llOa5JPnNAI2LO9hXFsz62cluljRDc40JdeOzl4Xc1xUByo0pPlD/dWlYhTgAPHWFJzbR4io6JC5jV3acKnB/hs5UM2Wg8ZntI19E9VI+lMHTGm8MjUbPGtbNcdkpFtd6ACPxaWUk1gTCMzFYTpChRYyvfqloR/79PNoCE=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 07:18:52 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e5:e439:ff62:252a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e5:e439:ff62:252a%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 07:18:52 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 11/11] drm/amdgpu: Move error inject function from
 amdgpu_ras.c to each block
Thread-Topic: [PATCH V2 11/11] drm/amdgpu: Move error inject function from
 amdgpu_ras.c to each block
Thread-Index: AQHX5qG+XL5dMDu0sk2+rlpKQCJH2KwlGe4AgAGGqIA=
Date: Tue, 7 Dec 2021 07:18:52 +0000
Message-ID: <CH2PR12MB4215E383AAE2894BBF62B029FC6E9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
 <20211201105250.298525-11-YiPeng.Chai@amd.com>
 <DM6PR12MB46506836B1671033C5EFD568B06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB46506836B1671033C5EFD568B06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T07:29:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=89efef42-429b-4683-a9de-f148ff71dfbc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7cbe820-f8e0-40c5-d2bd-08d9b951d271
x-ms-traffictypediagnostic: CH2PR12MB4167:EE_
x-microsoft-antispam-prvs: <CH2PR12MB41677441057EA847265F088EFC6E9@CH2PR12MB4167.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: veBndmWt+eDsQR44sGb56O1X3CINMdIDCGdbXoegKrk6JJM/RBMfRWHE4fI/VgrVCJQ1Wzi1mVxQQT8KI2ew4iRvYfMvTRwShQhMfz3i4e7/PQ/6ew/x77tXzDwU3wXiRHhECYCfg6s7qL2SinGdQac9rSYRUdcP+T+xm4BS0TcAQLBVr0QuB0E7RjFLA1k3BnAaBiSuShpgbS8mS+/h/O/s4ne0As/z0jLAHLicFlSs4NiHHkXz/Pxz2gdlpdK4nvLSX4NE/qfJqjmBsJ9UH0WleRMrtPJmTy7wGPP8deMy7qsZ8zJqKatSrlP5PldcDbS+yPCWVptGooL9jn1+HWh9zozTtTxw9eOIs4f15xfsFzdRwykBq+j5YGeZZ9J2NC/zojT/JKhrhT6XKMraB4wclV4z9GojHqCSSsvUUYZh088/y4djTwNrNLY5H9cue5HKJD7YEnHhHga0K30ZGRmeFPnXXspdkDqOWwsvuHX0BHjacL8B6swq2qPjlRnDWT7xi2z9YTRKHheHPqTS29KH1MSRrXdqUpNhuMLTGOSTO+LBdIRXF0mHdopKHJ8evYKuOZYG9tnttN17hYPeD69a2Xw982KvlnIZh5eWuk9vKvFrqND+RE2r68zuwYTfsKZNZj5FrVf+xCv7V9gsGJghBDhIfitdHUmKiolK3j9MXrUmbVulvs8THWXJSZW1VTskjsRBuiMts76RFXS8NA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(186003)(316002)(38070700005)(122000001)(38100700002)(9686003)(110136005)(26005)(66556008)(76116006)(5660300002)(7696005)(64756008)(66476007)(66446008)(33656002)(8936002)(508600001)(8676002)(66946007)(6506007)(86362001)(4326008)(30864003)(2906002)(55016003)(83380400001)(52536014)(53546011)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ufonFiLgRZIYdAaHIuhDnEFrT8jLlFoc+5/YZf0A47nqdyMr/EEC6+lsgoTl?=
 =?us-ascii?Q?feO20ZNJVibmxaO0Crz4GfFoEJkh62kdKUhiwpFg+K3igiodwdAKVB4HKR8E?=
 =?us-ascii?Q?/Vj3b2feghCrWK6iOfMSGPPAsrDtDUD0n61rl2M8ZVUb0E0tNKO3S8Q9jgbU?=
 =?us-ascii?Q?01PGzbuXCI31PkvcOsVeYoQHGz1qzE0ZZUZJA0lBghrWI3H03lzIM3EtjfQx?=
 =?us-ascii?Q?1cU3OUxEQy7+mmf7N6tmuY6IT3q9iqnHXB0K/ketT3X9/yu1sech77Jj6Z/a?=
 =?us-ascii?Q?HIE+aT6sUuWy5KDrln0DLeRq/1ssIqo44qVpEwD8c+ECxdc1ghtITbs1Jmud?=
 =?us-ascii?Q?IfH1aoGHaqjkJdCROMsCG6jimXTGjF7F3wZLJ2F2uvrrcWs5o/1SN/B/un+R?=
 =?us-ascii?Q?TPzLXckfknNcqba+f8MrzYq2Mx38kItQ9x4Pvwt6j5zodWQxP5rM9rX/A72I?=
 =?us-ascii?Q?2wJWRjHwn2VKEL8ybggTAue4015YfOZLHbnajzJdW5TBJqgAue+f0qc+1I+3?=
 =?us-ascii?Q?GBts98S4pcSAG7F57bDejxnLfeitc0IUQWNDhDj43afo3q4cHqMJpGQOpmWP?=
 =?us-ascii?Q?861zZXp31o7KKkx660RCaa/IoQFi2ta8G8/Uk22Wqp4x7iMjiCg7bum9XPsp?=
 =?us-ascii?Q?YXuBBQQ5HDxjSYrOgr/1fyUSBxFdw1J/zLCAHLpR6PURPR/FAl+Zaw5wvLas?=
 =?us-ascii?Q?z7Jwv6jd6PEbTdNV9rfu3HSPIdTdyIrCrOX9eHR5L+uIgH5bCqI1bQV/TMkT?=
 =?us-ascii?Q?jx6wSjd2nqUJHx+/C1V1nO5zF5TZIkO+XUDw93ZIGtwl2bKcC5m9FtDxzDom?=
 =?us-ascii?Q?gDKuTmjIq8t7bA4GWqCmrK9Is+5HW3MA62ZVUAoasQ+xCh2AYgwjJFM8w16K?=
 =?us-ascii?Q?NB14To3sVzQ+8QEoynAGKO48SotSROJgquGN6RmH/VFAZURe2T+xC2UxPtcB?=
 =?us-ascii?Q?gobUxYm52ClDTLNB+CeP70FEx95Es2mWWm/M/dzZOqw1lQQe+smegLQF3KDq?=
 =?us-ascii?Q?oSRhJ+Ae/zpiALiRGeB70A34V3VLUqmC2FHnT0zSwlUySh/HUYxUgl/OZ87/?=
 =?us-ascii?Q?FwZL8HC0BqGoai/rySpNMPaPn4OV4pE5C9rYgAR75WXcYAnVgRbs6ufQJaLu?=
 =?us-ascii?Q?Qu+2+7vORD/TqKh628fOrWpbkI5pqPwED2qLYgQmy6CrZruUZqFrFcc9bcBT?=
 =?us-ascii?Q?U5ybPnb16Qakf4A7Hr8MY7QnAg2kRizUDBBX84d1B+xXkc71lEXj2tkFQ+oL?=
 =?us-ascii?Q?lU2Coewz5DqCtjBPmDEz/uFuBjdRuHmS4N0Jw6j60lI+ot9b4v/j8kz3Fgim?=
 =?us-ascii?Q?Z6CFHEbnF9HuEUeDRhIR2P3ftgz3bpUv2eAhKsSq/bsLBsLG+nAaVgHtzC3H?=
 =?us-ascii?Q?WHtbX4qZyFlrCxkrvmV6TtyHWcY3rN0cR06fBpUAhcSjXu6aJe223L6cg6Nt?=
 =?us-ascii?Q?JzhaJUovtrg6iAGeYPgjy8+kWdb+fODJSo3Bn6b0jcT5+Sl0dr/E98ieSm+L?=
 =?us-ascii?Q?fjSLNpw0hFbWCeZoO7yLAEm73ShS5lpN90+xYs8tsdTI7m7XRoCRln7qmn0H?=
 =?us-ascii?Q?iausB92h3tMrD6fi58g4gTAvABr8S256M9BCL0WSIyHigt2QT6cSEZmRwZSj?=
 =?us-ascii?Q?3rNIrfSiIaNPJMN8VYil274=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cbe820-f8e0-40c5-d2bd-08d9b951d271
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 07:18:52.1769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1KrZ+8GlRTaa2UHiDgCXR6Nfuush3F+Wf/zCGmuCJSyny520CeG7A6fzyQXsqMn4lb5/MYv1mHZK+PQaiO4DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I can add a default error injection function in amdgpuras_c,  if some block=
 don't define special  . ras_error_inject function, it will use default err=
or injection in amdgpuras_c.

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, December 6, 2021 3:34 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH V2 11/11] drm/amdgpu: Move error inject function from a=
mdgpu_ras.c to each block

[AMD Official Use Only]

The error injection has no difference among RAS blocks except GFX and XGMI.
I agree to move the xgmi error injection to amdgpu_xgmi.c, but I don't thin=
k it's necessary to implement specific error injection functions for all ot=
her RAS blocks.

Regards,
Tao

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, December 1, 2021 6:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas=20
> <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 11/11] drm/amdgpu: Move error inject function from=20
> amdgpu_ras.c to each block
>=20
> Move each block error inject function from amdgpu_ras.c to each block.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 62=20
> +++++------------------- drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 ++=
+++++++++
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 18 +++++++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 16 ++++++=20
> drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 16 ++++++=20
> drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c   | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/umc_v6_1.c    | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c    | 16 ++++++
>  drivers/gpu/drm/amd/amdgpu/umc_v8_7.c    | 16 ++++++
>  12 files changed, 201 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2e38bd3d3d45..87b625d305c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1032,31 +1032,7 @@ int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> -/* Trigger XGMI/WAFL error */
> -static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
> -				 struct ta_ras_trigger_error_input *block_info)
> -{
> -	int ret;
> -
> -	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> -		dev_warn(adev->dev, "Failed to disallow df cstate");
>=20
> -	if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
> -		dev_warn(adev->dev, "Failed to disallow XGMI power down");
> -
> -	ret =3D psp_ras_trigger_error(&adev->psp, block_info);
> -
> -	if (amdgpu_ras_intr_triggered())
> -		return ret;
> -
> -	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
> -		dev_warn(adev->dev, "Failed to allow XGMI power down");
> -
> -	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
> -		dev_warn(adev->dev, "Failed to allow df cstate");
> -
> -	return ret;
> -}
>=20
>  /* wrapper of psp_ras_trigger_error */  int=20
> amdgpu_ras_error_inject(struct amdgpu_device *adev, @@ -1076,41
> +1052,25 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
>  	if (!obj)
>  		return -EINVAL;
>=20
> +	if (!block_obj || !block_obj->ops)	{
> +		dev_info(adev->dev, "%s don't config ras function \n",
> get_ras_block_str(&info->head));
> +		return -EINVAL;
> +	}
> +
>  	/* Calculate XGMI relative offset */
>  	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> -		block_info.address =3D
> -			amdgpu_xgmi_get_relative_phy_addr(adev,
> -							  block_info.address);
> +		block_info.address =3D
> amdgpu_xgmi_get_relative_phy_addr(adev,
> +block_info.address);
>  	}
>=20
> -	switch (info->head.block) {
> -	case AMDGPU_RAS_BLOCK__GFX:
> -		if (!block_obj || !block_obj->ops)	{
> -			dev_info(adev->dev, "%s don't config ras function \n",
> get_ras_block_str(&info->head));
> -			return -EINVAL;
> -		}
> -		if (block_obj->ops->ras_error_inject)
> +	if (block_obj->ops->ras_error_inject) {
> +		if(info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX)
>  			ret =3D block_obj->ops->ras_error_inject(adev, info);
> -		break;
> -	case AMDGPU_RAS_BLOCK__UMC:
> -	case AMDGPU_RAS_BLOCK__SDMA:
> -	case AMDGPU_RAS_BLOCK__MMHUB:
> -	case AMDGPU_RAS_BLOCK__PCIE_BIF:
> -	case AMDGPU_RAS_BLOCK__MCA:
> -		ret =3D psp_ras_trigger_error(&adev->psp, &block_info);
> -		break;
> -	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
> -		ret =3D amdgpu_ras_error_inject_xgmi(adev, &block_info);
> -		break;
> -	default:
> -		dev_info(adev->dev, "%s error injection is not supported yet\n",
> -			 get_ras_block_str(&info->head));
> -		ret =3D -EINVAL;
> +		else
> +			ret =3D block_obj->ops->ras_error_inject(adev,
> &block_info);
>  	}
>=20
>  	if (ret)
> -		dev_err(adev->dev, "ras inject %s failed %d\n",
> -			get_ras_block_str(&info->head), ret);
> +		dev_err(adev->dev, "ras inject %s failed %d\n",=20
> +get_ras_block_str(&info->head), ret);
>=20
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index da541c7b1ec2..298742afba99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -940,6 +940,33 @@ static void
> amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
>  	err_data->ce_count +=3D ce_cnt;
>  }
>=20
> +/* Trigger XGMI/WAFL error */
> +static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
> +                                void *inject_if) {
> +       int ret =3D 0;;
> +       struct ta_ras_trigger_error_input *block_info =3D  (struct=20
> +ta_ras_trigger_error_input *)inject_if;
> +
> +       if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> +               dev_warn(adev->dev, "Failed to disallow df cstate");
> +
> +       if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
> +               dev_warn(adev->dev, "Failed to disallow XGMI power=20
> + down");
> +
> +       ret =3D psp_ras_trigger_error(&adev->psp, block_info);
> +
> +       if (amdgpu_ras_intr_triggered())
> +               return ret;
> +
> +       if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
> +               dev_warn(adev->dev, "Failed to allow XGMI power=20
> + down");
> +
> +       if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
> +               dev_warn(adev->dev, "Failed to allow df cstate");
> +
> +       return ret;
> +}
> +
>  static int amdgpu_xgmi_ras_block_match(struct=20
> amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t=
 sub_block_index)  {
>  	if(!block_obj)
> @@ -958,6 +985,7 @@ struct amdgpu_ras_block_ops  xgmi_ras_ops =3D {
>  	.ras_fini =3D amdgpu_xgmi_ras_fini,
>  	.query_ras_error_count =3D amdgpu_xgmi_query_ras_error_count,
>  	.reset_ras_error_count =3D amdgpu_xgmi_reset_ras_error_count,
> +	.ras_error_inject =3D amdgpu_ras_error_inject_xgmi,
>  };
>=20
>  struct amdgpu_xgmi_ras xgmi_ras =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index 99edc75ed4ec..ce6841967b05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -60,12 +60,28 @@ static int mca_v3_0_ras_block_match(struct
> amdgpu_ras_block_object* block_obj, e
>  	return -EINVAL;
>  }
>=20
> +static int mca_v3_0_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops mca_v3_0_mp0_ops =3D {
>  	.ras_block_match =3D mca_v3_0_ras_block_match,
>  	.ras_late_init =3D mca_v3_0_mp0_ras_late_init,
>  	.ras_fini =3D mca_v3_0_mp0_ras_fini,
>  	.query_ras_error_count =3D mca_v3_0_mp0_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
> +	.ras_error_inject =3D mca_v3_0_ras_error_inject,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mp0_ras =3D { @@ -101,6 +117,7 @@=20
> const struct amdgpu_ras_block_ops mca_v3_0_mp1_ops =3D {
>  	.ras_fini =3D mca_v3_0_mp1_ras_fini,
>  	.query_ras_error_count =3D mca_v3_0_mp1_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
> +	.ras_error_inject =3D mca_v3_0_ras_error_inject,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mp1_ras =3D { @@ -136,6 +153,7 @@=20
> const struct amdgpu_ras_block_ops mca_v3_0_mpio_ops =3D {
>  	.ras_fini =3D mca_v3_0_mpio_ras_fini,
>  	.query_ras_error_count =3D mca_v3_0_mpio_query_ras_error_count,
>  	.query_ras_error_address =3D NULL,
> +	.ras_error_inject =3D mca_v3_0_ras_error_inject,
>  };
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mpio_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index da505314802a..7cca86c504e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -786,12 +786,28 @@ static int mmhub_v1_0_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int mmhub_v1_0_ras_error_inject(struct amdgpu_device *adev,=20
> +void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  struct amdgpu_ras_block_ops mmhub_v1_0_ras_ops =3D {
>  	.ras_block_match =3D mmhub_v1_0_ras_block_match,
>  	.ras_late_init =3D amdgpu_mmhub_ras_late_init,
>  	.ras_fini =3D amdgpu_mmhub_ras_fini,
>  	.query_ras_error_count =3D mmhub_v1_0_query_ras_error_count,
>  	.reset_ras_error_count =3D mmhub_v1_0_reset_ras_error_count,
> +	.ras_error_inject =3D mmhub_v1_0_ras_error_inject,
>  };
>=20
>  struct amdgpu_mmhub_ras mmhub_v1_0_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index 829d14ee87d3..79a9995caef1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -1333,6 +1333,21 @@ static int mmhub_v1_7_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int mmhub_v1_7_ras_error_inject(struct amdgpu_device *adev,=20
> +void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  struct amdgpu_ras_block_ops mmhub_v1_7_ras_ops =3D {
>  	.ras_block_match =3D mmhub_v1_7_ras_block_match,
>  	.ras_late_init =3D amdgpu_mmhub_ras_late_init, @@ -1341,6 +1356,7 @@=20
> struct amdgpu_ras_block_ops mmhub_v1_7_ras_ops =3D {
>  	.reset_ras_error_count =3D mmhub_v1_7_reset_ras_error_count,
>  	.query_ras_error_status =3D mmhub_v1_7_query_ras_error_status,
>  	.reset_ras_error_status =3D mmhub_v1_7_reset_ras_error_status,
> +	.ras_error_inject =3D mmhub_v1_7_ras_error_inject,
>  };
>=20
>  struct amdgpu_mmhub_ras mmhub_v1_7_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 1edc98e5bcbb..eaed556b9551 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -1667,6 +1667,21 @@ static int mmhub_v9_4_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int mmhub_v9_4_ras_error_inject(struct amdgpu_device *adev,=20
> +void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops mmhub_v9_4_ras_ops =3D {
>  	.ras_block_match =3D mmhub_v9_4_ras_block_match,
>  	.ras_late_init =3D amdgpu_mmhub_ras_late_init, @@ -1674,6 +1689,7 @@=20
> const struct amdgpu_ras_block_ops mmhub_v9_4_ras_ops =3D {
>  	.query_ras_error_count =3D mmhub_v9_4_query_ras_error_count,
>  	.reset_ras_error_count =3D mmhub_v9_4_reset_ras_error_count,
>  	.query_ras_error_status =3D mmhub_v9_4_query_ras_error_status,
> +	.ras_error_inject =3D mmhub_v9_4_ras_error_inject,
>  };
>=20
>  struct amdgpu_mmhub_ras mmhub_v9_4_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 14f7265d954e..8e62e2ffabe5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -650,11 +650,27 @@ static int nbio_v7_4_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int nbio_v7_4_ras_error_inject(struct amdgpu_device *adev,=20
> +void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops nbio_v7_4_ras_ops =3D {
>  	.ras_block_match =3D nbio_v7_4_ras_block_match,
>  	.query_ras_error_count =3D nbio_v7_4_query_ras_error_count,
>  	.ras_late_init =3D amdgpu_nbio_ras_late_init,
>  	.ras_fini =3D amdgpu_nbio_ras_fini,
> +	.ras_error_inject =3D nbio_v7_4_ras_error_inject,
>  };
>=20
>  struct amdgpu_nbio_ras nbio_v7_4_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 30a651613776..578ee40cc0d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2803,11 +2803,27 @@ static int sdma_v4_0_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int sdma_v4_0_ras_error_inject(struct amdgpu_device *adev,=20
> +void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops sdma_v4_0_ras_ops =3D {
>  	.ras_block_match =3D sdma_v4_0_ras_block_match,
>  	.ras_fini =3D amdgpu_sdma_ras_fini,
>  	.query_ras_error_count =3D sdma_v4_0_query_ras_error_count,
>  	.reset_ras_error_count =3D sdma_v4_0_reset_ras_error_count,
> +	.ras_error_inject =3D sdma_v4_0_ras_error_inject,
>  };
>=20
>  static struct amdgpu_sdma_ras sdma_v4_0_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
> index 8c165bcb0ffa..0656c6a7a2c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
> @@ -270,11 +270,27 @@ static int sdma_v4_4_ras_block_match(struct
> amdgpu_ras_block_object* block_obj,
>  	return -EINVAL;
>  }
>=20
> +static int sdma_v4_4_ras_error_inject(struct amdgpu_device *adev,=20
> +void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops sdma_v4_4_ras_ops =3D {
>  	.ras_block_match =3D sdma_v4_4_ras_block_match,
>  	.ras_fini =3D amdgpu_sdma_ras_fini,
>  	.query_ras_error_count =3D sdma_v4_4_query_ras_error_count,
>  	.reset_ras_error_count =3D sdma_v4_4_reset_ras_error_count,
> +	.ras_error_inject =3D sdma_v4_4_ras_error_inject,
>  };
>=20
>  struct amdgpu_sdma_ras sdma_v4_4_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> index ed480c2081a6..2058439b02cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
> @@ -477,12 +477,28 @@ static int umc_v6_1_ras_block_match(struct
> amdgpu_ras_block_object* block_obj, e
>  	return -EINVAL;
>  }
>=20
> +static int umc_v6_1_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops umc_v6_1_ras_ops =3D {
>  	.ras_block_match =3D umc_v6_1_ras_block_match,
>  	.ras_late_init =3D amdgpu_umc_ras_late_init,
>  	.ras_fini =3D amdgpu_umc_ras_fini,
>  	.query_ras_error_count =3D umc_v6_1_query_ras_error_count,
>  	.query_ras_error_address =3D umc_v6_1_query_ras_error_address,
> +	.ras_error_inject =3D umc_v6_1_ras_error_inject,
>  };
>=20
>  struct amdgpu_umc_ras umc_v6_1_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index e26728dbc6e9..2e87e7de4a55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -333,6 +333,21 @@ static int umc_v6_7_ras_block_match(struct
> amdgpu_ras_block_object* block_obj, e
>  	return -EINVAL;
>  }
>=20
> +static int umc_v6_7_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops umc_v6_7_ras_pos =3D {
>  	.ras_block_match =3D umc_v6_7_ras_block_match,
>  	.ras_late_init =3D amdgpu_umc_ras_late_init, @@ -340,6 +355,7 @@ const=
=20
> struct amdgpu_ras_block_ops umc_v6_7_ras_pos =3D {
>  	.query_ras_error_count =3D umc_v6_7_query_ras_error_count,
>  	.query_ras_error_address =3D umc_v6_7_query_ras_error_address,
>  	.query_ras_poison_mode =3D umc_v6_7_query_ras_poison_mode,
> +	.ras_error_inject =3D umc_v6_7_ras_error_inject,
>  };
>=20
>  struct amdgpu_umc_ras umc_v6_7_ras =3D { diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> index 037791e90c24..f7fb653434b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> @@ -336,12 +336,28 @@ static int umc_v8_7_ras_block_match(struct
> amdgpu_ras_block_object* block_obj, e
>  	return -EINVAL;
>  }
>=20
> +static int umc_v8_7_ras_error_inject(struct amdgpu_device *adev, void
> +*inject_if) {
> +	int ret =3D 0;
> +	if (!adev || !inject_if) {
> +		dev_err(adev->dev, "%s invaild parameters \n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	ret =3D psp_ras_trigger_error(&adev->psp, (struct
> ta_ras_trigger_error_input *)inject_if);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +
> +	return ret;
> +}
> +
>  const struct amdgpu_ras_block_ops umc_v8_7_ras_ops =3D {
>  	.ras_block_match =3D umc_v8_7_ras_block_match,
>  	.ras_late_init =3D amdgpu_umc_ras_late_init,
>  	.ras_fini =3D amdgpu_umc_ras_fini,
>  	.query_ras_error_count =3D umc_v8_7_query_ras_error_count,
>  	.query_ras_error_address =3D umc_v8_7_query_ras_error_address,
> +	.ras_error_inject =3D umc_v8_7_ras_error_inject,
>  };
>=20
>  struct amdgpu_umc_ras umc_v8_7_ras =3D {
> --
> 2.25.1
