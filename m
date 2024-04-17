Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66302C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 09:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2C0910F504;
	Wed, 17 Apr 2024 09:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fLBDAN5g";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E8110F504
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 09:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdckI68QqBC58rjBaCTcvPTAHYze16mWbp2O3TddqbhG8R7wAabV633f9aIgesLWYUUZ3JJ1jRTnn/DDpkCz6f+PzdQZ5rG4lrzAN2bmvbz6t/WQX+i+j5I6sG2eq1OuwqOVQtxCFvJpe4VyVnp4qKHTAbA6DA4o9ZpHX2gPmjB2+RzEyWLYQ3+HJzdc6+2CH0JJnjP8Y/ZS5JLrq3HPKJdmBZj0/PHF0wVCRAI9AFEXLtZFFGcJMPatPPuoOPMi9c9HJDPXMoSX3h1kTuI+tB12732Kmnx2hm+UBl7v8MeVEWbFIqCvNwC9g4t/0rCjB5ucATaJXAQb5SNtWUQVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtpjlLnFgfQ1MZnt43VJ2NYevtU4wyv1gko4eTc+ttE=;
 b=jLz0BPHDfAyHbjMHB39iGKGbeWpSk011tn1E/Nv3o8CfOO5wTMSCo0hED1h1n3GDvW+XDZgfWJ3IcoCXXPLMWiBysqRCoZKFj4siVQ/JvVyf3n3oqekRRAC0t+FjnnbdOsMzDY+Gq8/MxczsK4yp6mnRM4jywIEX/IFHttFbLf1vMnIKwa8PNpww9fGPdzTEAXrDB6zYkatQw/uoxxRbdfO7x0UpmNMUCkeukxDHv8BOqq0Atb6LnkkPY2iRH75Kb1nE5VTJ+TozdNWV2jjXSaisNWCvn/SAQG4q6aV7QUM7JwkdeyoLInXuny4n5lrVgZgA6SxXZVM14DFAB297EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtpjlLnFgfQ1MZnt43VJ2NYevtU4wyv1gko4eTc+ttE=;
 b=fLBDAN5g2Ud5FlDQfMwEc4EbFuzJrFeuK3JgyBM53GR+DkOyjKqcf3fEjK7MuwY2p88iWsm55rmBvRDHNNcFHAnHEIdm/ZD05FOX3+CBn/U1oIHmocZgTbcdzR8JiTd2xHcaoLEQDhB+RpQWvL7mkdS5vf5iIEFYJYSUTG7UcLw=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 09:31:16 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:31:16 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Support setting reset_method at
 runtime
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Support setting reset_method at
 runtime
Thread-Index: AQHajKH8jzIAFWg8wUSKRpOvgm25FLFqNg6A
Date: Wed, 17 Apr 2024 09:31:16 +0000
Message-ID: <PH7PR12MB79883E13BAFDCA56EC86A34D9A0F2@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20240412062114.3581242-1-Stanley.Yang@amd.com>
In-Reply-To: <20240412062114.3581242-1-Stanley.Yang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=865bb330-4fc3-4a04-9b1d-b740a8c8ea7a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-16T02:42:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DM6PR12MB4298:EE_
x-ms-office365-filtering-correlation-id: 91692f66-2dde-4561-f124-08dc5ec12157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: diA++E1vUt1IvhHgIgDjv9Sd2MJNPkRa7UCTM8OQWBGDbnqlVHRJmjuAK8g+kOlEEBcPOY3joStX1rh+cxYB9B8T5lniHIlD42oWISE8VQ+/jUBF9i1WGYY+EAqY6T1C+h4uCN00cpz59htDSV+/INCcfXfe3UHCwylq4h9IQJJwFIG0PRUXc8Kou0Bvj4DHcTElbWcOq1WuXwNpK9eqFvPvz3LeWD3YGi/HRNTgVfSJb6Q+UkyNuX6NrOkOJItC0JVQGB+31oqfFC5xeB+PnAaFPMFRp8NslRE3W7Qe+ytRfA7tBTp4HmXpoIwFUtWJh7CVOK6zOVG1nvaAZ+SUMq2Td6AvMG6qRXn1v41BD5FsfKUBofgl4u0H/lOetjadqtFeTD/3GIJgnN/v3pjDigwyqC45J+Ka3EqOY0TvKDWX2UNrExdxZxRVYL6ze7YVcEJyMLa/8GODBDyclDQyICSol+TreDk4obkxnhyWvOlXLSA/uRJwjSNPRe3pl6eeqBSxWPjbxxI2bxwCZ09rZMNESq5Vw7/GJtM9mt0NDyZ5wXDkj05aEZ3U9qgvXPPGO659nFAmzC+/7idP6PGzK5yjQw7MftaCf8RzkzMttvj3uLpE8/0QZQYO/kX8N8p5wqXonpmgro3LEOtQckME1KMRpv7Q+svrbNm9i3wonoDd47gjWysMqNj2wSPgVeIodDHkRzySlQQ0boGMSvVcRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?03BR946NpkfSx7htZiYYmTCbokULU233pcGzTC6Q3+W4/HEbDPAku/m0Kfn2?=
 =?us-ascii?Q?tw3h+5mLixGdm+fACZ05nHV+aYyOFBvtb83aO4AUMDH18bDTgsDrGrp+cCDu?=
 =?us-ascii?Q?Cm/34pYc2ClVm61ueUdNZ4RRFDLVs04TO5A07mQRijs93SVOHBUv1eXA4K2h?=
 =?us-ascii?Q?4JMHVwabV2V/bJiDtVVBoUxzIVv1beD67R8SAk7AWJsYpCOppa5YXk4Y0GbG?=
 =?us-ascii?Q?uACx32SHdxPc0E83bDY2SwE4EExIcss+XpzhXLYUJqvIjHQ/4TsRrrz3ouq+?=
 =?us-ascii?Q?FOwp6eZiG5LcMCXW/g6VdQ9x3xWZxS/94wrw31FDgxF6bZ7ZgM9lJyuCnGbe?=
 =?us-ascii?Q?OJfCfG3CY08swcZsDvW73/Xkj7v3OK3lhpT4yCDOPzMlYWqn6AyU3tMd6rX8?=
 =?us-ascii?Q?WVQmpTRMqQ7e9ap0KN6vjI2F4uiH0L2uYDAVy+WKlmEJdAz30QP3LWZH8Ihu?=
 =?us-ascii?Q?SW4Pjbyyu+PTlxMgUIt7ehWFKuoBb+Qeo/JON3svUFozVJHo0kQbdMgul6wG?=
 =?us-ascii?Q?Gkkq4efXKJofJvTzQfSxke2jU2Svd6GmPPBeSiXBRDLdMM/DAgpUZeUKxmSt?=
 =?us-ascii?Q?62TDkJeZPISCvQ1aEVX/GBkNsmoph5iQ++VrK9JjxhvulZXSxHNDMz7QmYee?=
 =?us-ascii?Q?r3UoDbM/5MzJvUW+RjXw8ZkZE94V2bu+Fg2Yu5hQJEcvXIJwUwYQvhiqJDqY?=
 =?us-ascii?Q?SIlqsiLqoeYuGrdT/hN+cYaVSEOIhsVeMy3OR7E4sYwvm0gGoZSd5GAjDR5y?=
 =?us-ascii?Q?cbG9+NndTGAcfA/1SldD5IrE1x28X/YTbSqr2I+Kr7Lw8MPWswae+tS2b0nD?=
 =?us-ascii?Q?SJJJxAjpO3DOlAqW4FOEEHgpQU0hNanaoSgckq+0PkTKj/B2jfZ889dkwcdQ?=
 =?us-ascii?Q?OVuQQF8La+AfRL/abM+dV6Knu4pxC3xO9SFkdcJfk/GZGdEUc9y/yFE0TT0U?=
 =?us-ascii?Q?gkuHcdYhNqE47oZjMTPS2p9VPoGi1drAFxYX+t7pID1xiVnVfw3Doz+3ZiHM?=
 =?us-ascii?Q?XHpInLI3AmtlovhG8ecQj4nUmRxcXDO7jOLZ4i0BobUYtIfTNmsOArrTivcV?=
 =?us-ascii?Q?Dmcx1DEr+33fJYr+R6xZYNzS6iisvDME8+3uhNhhc7i9v0847/OuX0wgIGR2?=
 =?us-ascii?Q?6rxjz4EHlMB5/08sKHI6CkMDycdKNwIzwAB+o1r8SXNaA9rpgIeNSm4mNt1a?=
 =?us-ascii?Q?lneB6yJqFtcfw/5Wj05a2xc50PWGjv/n6toRtw0+D/dZUTC65SXFedlZ8VjX?=
 =?us-ascii?Q?VYqn8kzmDlqMJSOEQ00nmHFJYFcL72UnBo43hVw4th0hwi/Svpzt34lpu9dz?=
 =?us-ascii?Q?tl/bij4SUrJaUGszBAHq12ZgvbFHE1dK8c1t9DChlc5/Ls+22j2zdJ7Ti+qU?=
 =?us-ascii?Q?CgGzhkwsHYibqem3AbgdpO70Hq4EzSkVBUnw0MIFId60XOWUUwEObO7mCd4R?=
 =?us-ascii?Q?BZGuF++apZndOeliEM+QQ5v8MhUd+7zzaTtNl2/VK4PqnwtnlBQnfBNnpt3A?=
 =?us-ascii?Q?Z1fAcNhuoSYJKQPMTisv3avmjsjt8p8gLk2I4t6WWIfax4niLx0Nkf0Eyy+3?=
 =?us-ascii?Q?XIFtQvIblKdEB5WwnjU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91692f66-2dde-4561-f124-08dc5ec12157
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 09:31:16.0679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4nRpijRY53lsrzAwgH5GtFnO2l8s8kVoiOBbvNtXX25oM2fo7GHATCZTLz/K7l4SZFLkYZuz3GRO2SlihEqKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

[AMD Official Use Only - General]

Ping...

Regards,
Stanley
> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Friday, April 12, 2024 2:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Support setting reset_method at
> runtime
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 80b9642f2bc4..5f5bf0c26b1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -915,7 +915,7 @@ module_param_named(freesync_video,
> amdgpu_freesync_vid_mode, uint, 0444);
>   * GPU reset method (-1 =3D auto (default), 0 =3D legacy, 1 =3D mode0, 2=
 =3D mode1, 3 =3D
> mode2, 4 =3D baco)
>   */
>  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 =3D auto (default),=
 0
> =3D legacy, 1 =3D mode0, 2 =3D mode1, 3 =3D mode2, 4 =3D baco/bamaco)"); =
-
> module_param_named(reset_method, amdgpu_reset_method, int, 0444);
> +module_param_named(reset_method, amdgpu_reset_method, int, 0644);
>
>  /**
>   * DOC: bad_page_threshold (int) Bad page threshold is specifies the
> --
> 2.25.1

