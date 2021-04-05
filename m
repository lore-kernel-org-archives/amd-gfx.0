Return-Path: <SRS0=xdDd=JC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F4AC433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 16:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3268613A0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 16:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3268613A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 771A389EF7;
	Mon,  5 Apr 2021 16:10:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BE989EF7
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Apr 2021 16:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8rkq7BRjCfB/tiAiZseY5s5jlcniGIFVd80chwV/rQ8hUUDocYG+/F+Xdqjf1/CcNAcv8JhdzjVqSc/hNExpcTv9lC/2999sBg9QjvHtUagvs2aFfiGDxBMUG9NYsW0n4V7zvCncUUb7zP0yhcwWcMXhgNRGczrTwAcrt6VwRWS1n5QI5gXYTv+Y84GiDkndQaSn/yoau6ZLB9kWxuBMkZu/x+ieghk17JkFSiP7jm27EpKc3bH4wUPFnFOzs+gBWnJVveBrtifRw/sFwvC6WdTW7VYxSV7Y1sL/zQym4A6yetfW/6u+o2jomOY52yVmDsE74O4J5/LTZkItcRIdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=353up9gRZNlSEW0hxf08wRetJzWq68J1adzz2lNkFCE=;
 b=OjkTuPyTgKfTVKhqBk4qBZbKQkfw7M0e/4IyPRM403gcFr3FqFQ0isEKrDnuD8vYrexy8HP9Yvsa9Fm82aYrXHj6B5zgXfCddlmTyc5Idx5z+cZMorg87ui2vzuMAs300g9o9mIabiD5LH+xiJKw/7+82Tt7Tm4fH7TO9qxZpqKB9ON/kpfst9UjKI5Q29h2Yd5tCr/KJNnMv8YOUVIw+z/t4reJCzX7g6Btn76PjlLnW4v6G/tkzRboX0wG8t7BGQsBZo/iV3wTz15x9rW7UctJyP+cM6VjaJsj3a5owy/HPm1Fr3uFJosi4SoSSoToSKtUies/vTCLLcESMV9J0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=353up9gRZNlSEW0hxf08wRetJzWq68J1adzz2lNkFCE=;
 b=1K2mkHGUhOIThBIncpc/V7ook/ERZNGHDHD8TBgMHZZaa/QsedVcmK1+4w8wyIXEEVdpSuqoGCxD2ISZ8oe77B3SfM9pKOw5ZWswZVUI011acyjCu/3TuHmbUb4BRqpaXp5CYZYODh7Qr1XrzlLf5dfWWY6ITv1vASbf4onPSzk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26; Mon, 5 Apr 2021 16:10:26 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 16:10:26 +0000
Date: Mon, 5 Apr 2021 12:10:23 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Qingqing Zhuo <qingqing.zhuo@amd.com>, markyacoub@chromium.org
Subject: Re: [PATCH] Revert "drm/amdgpu: Ensure that the modifier requested
 is supported by plane."
Message-ID: <20210405161023.b4bygttkpq2ttfnq@outlook.office365.com>
References: <20210405150834.3942-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210405150834.3942-1-qingqing.zhuo@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:ef1c:ae21:a77:fbfc]
X-ClientProxiedBy: BN6PR2001CA0046.namprd20.prod.outlook.com
 (2603:10b6:405:16::32) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:ef1c:ae21:a77:fbfc)
 by BN6PR2001CA0046.namprd20.prod.outlook.com (2603:10b6:405:16::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Mon, 5 Apr 2021 16:10:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e17111-4b34-47f3-38ea-08d8f84d52e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45462358061D6E90D4F4A2DA98779@DM6PR12MB4546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4Kdn32R71fr6YNeey3HQeyJjX50aumORjhPk+YZbHLfLiM6ShdsUdjklo07MYJgui5se0weN9Yz7nhyLKtT4zlDUbg+X5de+ChOyzBU5FyIjPbvlMZRbBqxl09xZYoK+Ys8J5C4EroKeso8Xkv3TTSQChcQKRJz7XRPeavfHfNNRiAowEfJCwPcfpvc5m6G7kHTfr8TwObawpK9PgNA7nM2Mequr7i8rSc0ismREAHNBV/h1C6cPHJ/SyraIUW7ZUhYy/mcCmOyOD/RJSdbcKNr8vmFxw6RdnhYbe4oQHVtdfemgfB2oi+jhNRM8Jhzs8JansIQmcv66ClhtCn/WmDS1HcjDVzF4NFkmPXJany7TlmGRBSWSThiRjzia3ZniItGVN3lLzEx02Z1EBGmSHfrDeobtbUfCCyo7IGJWaHb2NqJyB5KCC7x/LVtk4trBy1TKSlSOHhrWBevcfU0akljdZDIw02thNmr3Ft2jnFGDZOzmKG6fuk7xJ/JJhXjMl5AQ4gbs/KWfpmkTfoWjZBWnG4QzFCUqHlk8x0cfqaYQzs+Qx9To08ArDTvcBis7UXpKlaXY/NDFk9Yq44mfbgAglyZw9zdRycHz3Yc0STqAQsobsaRAJ93oY8Pr1hrUmVhXCtBKwoysV6C0TTgkdztXl/qwDL/0QYyw1lz4p1CjwgVtpdPyqQK85vwreceZOXZMhklWKny1s4e24sHFLQI6hvPreY+JeX7+LYt6jzL9tHrz0SfhqmOCE5icHEn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(8936002)(9686003)(2906002)(21480400003)(6506007)(52116002)(7696005)(86362001)(966005)(66556008)(8676002)(186003)(44144004)(4326008)(5660300002)(66946007)(55016002)(38100700001)(1076003)(83380400001)(478600001)(316002)(66476007)(16526019)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?duSopDBOCouTP036liuRc/e/2cUU40UvZjZuSFQJIMffM8/roFmQAYIY6RhY?=
 =?us-ascii?Q?Eoz1YIrJJvJldzU8ALuIgvEY8elcH+7VXv7dEZGifHpzdTM4Zez0oFpmoKPP?=
 =?us-ascii?Q?ij8CQdFJwUa/SHEinPpHLEph2XKpU5FhtawPsHls5Se2C2lWP5YAcnNfVFEp?=
 =?us-ascii?Q?3JsOABl/I1XEnUMnx3+Oc7HZ0d5Xl1QERRFz1TR58OFZDPhQgq93+kGG6pbo?=
 =?us-ascii?Q?oBKXYnMaaCrOvjIQyBbgMS5wTswTn0jd7SernU1yWNYxQRDn6wELIWdE8AIb?=
 =?us-ascii?Q?5vLblKcPsVmgZ4hE2eke4rgeSNVIMpKW0VgaFtqthNGnU5itENDEOvFdUjMA?=
 =?us-ascii?Q?zgaUZLTHZwIMO1cyE7VO6+sHHwTx1HufP5RjsjNcyvVQ2nES8DXrzA/J/1Q6?=
 =?us-ascii?Q?fOSpuztPGVsBKsdoC4/A5QhKfY06LKb5SAmmufmsSoT5gTyeGkXtaaVYF7yu?=
 =?us-ascii?Q?P+q00juo0FOtAfI9CWaPKygT4oEVQ074hEYBg91JjBaFIxRNPHM0LzkWLPFb?=
 =?us-ascii?Q?ZdHu3VGHQ9TzbnKa2z0AeZc73Liv7FVHuwP7ilTxLS5KTgi1fwtqe0ntWrmK?=
 =?us-ascii?Q?dpwt2nOT7z3l4YhxzsrkaNt+jDKo5b67nOJHG2gUzcJ065p0Y8YSqHHxUeSE?=
 =?us-ascii?Q?8/CR1Yr/mebwGvyT0u4SP2hRLaDTQvZvc4mOqedBkHKA0zrj7AwX76pnJHrp?=
 =?us-ascii?Q?ImvnW8ya2e+nlT6Sg2N3hcImW5JBa0PptukHUojfU65Z0weNWWxeTvedc5qI?=
 =?us-ascii?Q?wSLiD0pNppvKffyDQoATrtCzY70gl+KdohEsuYT42r8r7Emq/4wFhbOp565u?=
 =?us-ascii?Q?JW/6xL2QFl21KQM1CGIN8Jsrmm1q6O/WksnyRr1TQv5XlboU9QKj14ECF/Mu?=
 =?us-ascii?Q?CVLVM+4aNlEAn0LRry+K2bMU0xhQj2h8RfpEfE6TX5OHgTV7YbyqvGg96i0f?=
 =?us-ascii?Q?1fqON5Qb+YiwimNQhECI9WYCVgR839mCt9y9UmZLPBKHMz2HpXXwQhALruca?=
 =?us-ascii?Q?lYccyU8iSaAOVwZPvLqpYZnnf/4u6dqngTf3nlqsABUzimyp8qWkxgN3drnO?=
 =?us-ascii?Q?yeEZKie0H5wSoh9keqzXsRF+0MhrC+v/I/WmuuiZO+9bI9nMW6Bb2Dp47Dg5?=
 =?us-ascii?Q?mn26KySFwGKGB6iR/Eprd4NKTX53g/z3On+2BVccc/eptLWs8e7uWI6eQx78?=
 =?us-ascii?Q?EQCs2vA3fJddVhNKoj5/SedX7bxL+VGTAOyaUZ+EqtQltAstdQRd2hE+tSwZ?=
 =?us-ascii?Q?XPFxs2//kWMo31HMM+RDh156a/qIImcbVGspJnIkTq9QvUm/f5uPhUnFRuI8?=
 =?us-ascii?Q?+c2S5petsiCub7LiY38a7488TyXO7JlZef9yFUF53IuKQxMJ+PrZ0FQr+iPY?=
 =?us-ascii?Q?1dJ47v1k9BGT8qeLujIXtzbEahND?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e17111-4b34-47f3-38ea-08d8f84d52e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 16:10:26.2490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnctGxxmFZKRzZ5gILqZbK5/NThLSPhBTNoweV6gUN4+mxnVXVVNlOQeh0iOjz8QW+phJUxX5MFLLLR8vI9MPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
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
Cc: alexander.deucher@amd.com, daniel.wheeler@amd.com,
 nicholas.kazlauskas@amd.com, amd-gfx@lists.freedesktop.org,
 bas@basnieuwenhuizen.nl
Content-Type: multipart/mixed; boundary="===============1740557851=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1740557851==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6zscwldsosactuvj"
Content-Disposition: inline

--6zscwldsosactuvj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In general lgtm.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Mark Yacoub, do you have any comment?

On 04/05, Qingqing Zhuo wrote:
> This reverts commit 9f81b5d40ca2c689334ad8288a4ddca4722a6e10.
>=20
> The original commit was found to cause the following two issues
> on sienna cichlid:
> 1. Refresh rate locked during vrrdemo
> 2. Display sticks on flipped landscape mode after changing
>    orientation, and cannot be changed back to regular landscape
>=20
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 13 -------------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
>  2 files changed, 3 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 0f17984fdea4..6304a49b02fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -908,19 +908,6 @@ int amdgpu_display_gem_fb_verify_and_init(
>  					 &amdgpu_fb_funcs);
>  	if (ret)
>  		goto err;
> -	/* Verify that the modifier is supported. */
> -	if (!drm_any_plane_has_format(dev, mode_cmd->pixel_format,
> -				      mode_cmd->modifier[0])) {
> -		struct drm_format_name_buf format_name;
> -		drm_dbg_kms(dev,
> -			    "unsupported pixel format %s / modifier 0x%llx\n",
> -			    drm_get_format_name(mode_cmd->pixel_format,
> -						&format_name),
> -			    mode_cmd->modifier[0]);
> -
> -		ret =3D -EINVAL;
> -		goto err;
> -	}
> =20
>  	ret =3D amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
>  	if (ret)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 54ef0f3f37b7..ac6ab35f89b2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4299,7 +4299,6 @@ static bool dm_plane_format_mod_supported(struct dr=
m_plane *plane,
>  {
>  	struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
>  	const struct drm_format_info *info =3D drm_format_info(format);
> -	int i;
> =20
>  	enum dm_micro_swizzle microtile =3D modifier_gfx9_swizzle_mode(modifier=
) & 3;
> =20
> @@ -4307,22 +4306,11 @@ static bool dm_plane_format_mod_supported(struct =
drm_plane *plane,
>  		return false;
> =20
>  	/*
> -	 * We always have to allow these modifiers:
> -	 * 1. Core DRM checks for LINEAR support if userspace does not provide =
modifiers.
> -	 * 2. Not passing any modifiers is the same as explicitly passing INVAL=
ID.
> +	 * We always have to allow this modifier, because core DRM still
> +	 * checks LINEAR support if userspace does not provide modifers.
>  	 */
> -	if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR ||
> -	    modifier =3D=3D DRM_FORMAT_MOD_INVALID) {
> +	if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR)
>  		return true;
> -	}
> -
> -	/* Check that the modifier is on the list of the plane's supported modi=
fiers. */
> -	for (i =3D 0; i < plane->modifier_count; i++) {
> -		if (modifier =3D=3D plane->modifiers[i])
> -			break;
> -	}
> -	if (i =3D=3D plane->modifier_count)
> -		return false;
> =20
>  	/*
>  	 * The arbitrary tiling support for multiplane formats has not been hoo=
ked
> --=20
> 2.17.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--6zscwldsosactuvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmBrNmoACgkQWJzP/com
vP9XQxAAx4PLy6cq7c5V+Yn2R3h2TccOavdPLaeq03ADkaycG2wDG3vv1JSIw1EB
qVeSkCTcPLR/JZTVesh9+4HzodAKz7U2mi/JTdIm5zvifv/xkjtkLylcFroMPJC5
SDQrY7AHtJ5AhT/plB8/JKAlgJb3RbUPRxEY4DB2SavWB4vthAaTIKtzQeXFK52Y
En/Joq4pcrv1D9RjlBDkQ++LZj8Z9RkLU9pNK/n37PBhtYsHvWYLT99/zdudESqs
dL8RR4oIyiwT08PEAC5poEy2JH1sFBqxt0cme7W8ZAZD9kk2dmxveUyH0xqS3mwY
qHKSRpj/+RdhaJ6iuAi1NECPTt6+IhCBMbY4OeRpm7kq2nIX+Pv0geEdANGa0vwZ
aoXcgUh7SUzBbvc7VQyzeUIDrVcsYQXCMdPJt+eR6CqjzT+oSv/Y766R0HQNIbrM
sjBOvjfQtHJnV8GAiyKWrJUO8yHWuM5dqF4Dr0Y0mSbmgY0N/ippqIdHFPnUbNWA
sVYA4l9rB5ZsytDsZO2Cnt1EjLwDb57P50qyaEkKpinpOWi2Ks+Rke9hzCdiJrbe
9D9WZVT86jXCV3NAQGTbtgqPetAHgIrDi8DNJJOIcpII9OrVqjuo/A++zXvIO53U
BLQTsCzg4Ua0JcuMJiHMyrerJxbvHlEoxoZetYQ8sHnV1MuM6PM=
=zzYc
-----END PGP SIGNATURE-----

--6zscwldsosactuvj--

--===============1740557851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1740557851==--
