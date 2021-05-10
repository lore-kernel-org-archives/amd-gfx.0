Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCBAC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5326E61482
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5326E61482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AB76E921;
	Mon, 10 May 2021 21:42:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A3D6E921
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 21:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMld5GWKi/WlrqQ/pS1ju85Ls2xfz/GciY5Alu2GOW1bTjZzck9BAKA7BHGuS50EN+PPuuks8TtkQRg2NlHa1wvSt+htvcpzWTr97xgjxd2eikxhK8u3xQEHyMfZMjfVpu5x7wZcs0+46ZRs11zwZsLCYyUTzfpKJ6la9KV+4Z87ebN8y0czIHSxazpwyceWwtgVJK4m0qgIObyyo6G4xTJ7/OFjN2FK7ZVFGT4iUksFPGNzqGHKS0w4uzXRPGppRLczjqUk4SCZK2H4pQ2mW1Rrw/1eGlr07Z4YOfG3B0q15gA/Nsv6amlhIccwFbYYm1iNvUU+E+hD3bDZWx/Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de9uNiWODRbZKMSi/D7Ju0OhBGZTo0gXLRYllPQkuq0=;
 b=KxMaUwgeFXpRVh/Qabmr+HitgUTuxAP4UNCvc6uI/GE2dsBJmhkYyqZ2sOxX5jWnwn4BG0IhCp1yMsuyzzuvfF8LUCfILlHBtRX8B4MvTo2RQAV203mncYw26TuX3BJKhBkAn9qT3yVREwUREdoyS+9INP5vYDrvBKCUbWmUO4rOhugQPn0sXKX5yA3P5lpQRiCwg7yjExdYWZjOWsbChAFe48Z29Ad4OhrdrmSp5ky0bLKkRMuJtoY6C4Dicx/1GELBrMUoIpgm4vKiB+I6C8RTWHvyiWzAy49ym6pjfHi/BhFSvr6FRjvzTyFET+GA/Gk+9E9kB6eI8u4ag8hJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de9uNiWODRbZKMSi/D7Ju0OhBGZTo0gXLRYllPQkuq0=;
 b=PFU+xu73aZ2zNfAOKLRt0or+IWl54ZbVA48P/H7jft97EdzNuKf8u/cUZxmx6G+i0H6+MKhLi5JuCD46anmOk2aFex3ddAoR1PIvzjDhKv/MwXRW91W/EzV9mrVyK2naaSphM12Z0VHXLxaCKZv6OF5f+aAsYXacNRuYLhKF5og=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.27; Mon, 10 May 2021 21:42:35 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 21:42:34 +0000
Date: Mon, 10 May 2021 17:42:31 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/display: remove an old DCN3 guard
Message-ID: <20210510214231.cz4rmumcl3ueidae@outlook.office365.com>
References: <20210507203642.552770-1-alexander.deucher@amd.com>
In-Reply-To: <20210507203642.552770-1-alexander.deucher@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:e50c:fb14:3ae:933b]
X-ClientProxiedBy: BN6PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:404:13e::14) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:e50c:fb14:3ae:933b)
 by BN6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:404:13e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend
 Transport; Mon, 10 May 2021 21:42:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e11d1dc-35a9-400a-968c-08d913fc85d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4250C5CBDEBA7CF4F5A34F6998549@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDA6vxxtGesrEotxJ665YaS+M3tx4fiv2UhQ+mzPzRe4nVAqj9sBxqjSrAplpaV9RcfOiiec6CUueMZyIVwptWcPvSarPK8FX6fMeaNJTozGeP5usgLDUen7/9Z2KcAGgjXpGJQUFFwpkBI4bVEpb6QDX8NXoGsK5pDvc4R/pZEnsg2YrWtcXSsBpLZH/uHgkb6nE8AhfFcjlAbiB6F0guJ1FbyvFrpPBvfrJBUgIMauP9YlTPO56J6+U+u376rI7jNuwwcCJUozGHYYQhX6kTI3SSoSZ9li0dkNydWijytdo10VC7g8IatQ6KqD7NCU1b609V2hx52RiUkDeiK3vNsx+NHfRltjxljgTc/1iPMi0KfPw6ORsRMgNTTg0fLt3vD237PgEFPEd1713RM48wCfmVeEs/GW+CfFPXQ1+eSbZUUs70e3idpcz+tBTBRo27bD3SlRuEvt2Ex4K1+HyYsb6Zl9R0+NwovnGF5sCLLvCIxDZcQkavuTRnEbe2QxCeWI5c2yvKZ/8LSUxR0b1rUVDTC93AVWC8Q5v/VtttZIcND++kxTswfG+hqcwr1QAbXxMIFIVcvOcvJLIwYUQMrn6RIyScY4zlFSjel9sCKOqCEYEPt832jSAKdb45uTnU5YKdzS/wxhDooVss5MhCCxuk1iQ2VLmLRaw4jEJtZCix6hh2ELJheDRrSxNTVFM5gmtBfXk/XoUidYkaJe2TMlDSYmQKvb+u8wncrQej8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(7696005)(6506007)(52116002)(8676002)(6666004)(478600001)(44144004)(45080400002)(9686003)(5660300002)(55016002)(4326008)(1076003)(86362001)(6862004)(8936002)(21480400003)(316002)(38100700002)(16526019)(186003)(66556008)(66476007)(66946007)(6636002)(966005)(2906002)(83380400001)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lxn34I2rHqdJpYwZq2AXFDokvT01dAMPzW2cNij9m8sVfcGmK/B6Dbr57ygb?=
 =?us-ascii?Q?NI4AeVVkFbRPiEajRAvb4IrqlSkSkPaj04rYQN+J/u+tJbORt127THqa4Voo?=
 =?us-ascii?Q?54LTYtJ793Xmpetbi9/XHZs52YrTOR6KARJ5wYE+Ik2bwR+Gkw/hecPQslmD?=
 =?us-ascii?Q?QIx5/2k0qyeIHsqMca5XrEiNu4etGjUA2hv/upmzxJzKd+CEHgXzZrQdmxRU?=
 =?us-ascii?Q?MWxVe53f5erIiL7u8RF6dTaGKzt4n6Nd8WNFZ6bsGm/sPKfQyxJRVG4LZ3by?=
 =?us-ascii?Q?GC/JdVrQKdyZFjWcjjgbX8cjQNj9yqcyLLjpgE6I4Sq2q2DZoJyCTD15QwQd?=
 =?us-ascii?Q?+iGB0TgevBVO1Rm+/Ywutc7YagouPssS/I+Oev3usE87p/rvMNkPs0DL5k5o?=
 =?us-ascii?Q?Zc8nQ8FLzH/scB2V/H7Y7256Cr2leGoPtWo4AfID1Ddt9N0zZXB3TP097FQ1?=
 =?us-ascii?Q?fBlDxay1Sz7x/nRE75+Sr0OiJYJtqAlGCDN5oyDp7hfnByuwm0pMNC0fWeyM?=
 =?us-ascii?Q?tcAMxJqbCbg7YXyYdK0ALImQrLJABP29cR0TDqevDdQs9VbowWdvgSOp+6zf?=
 =?us-ascii?Q?JXoURYFDApsy+4z9H/zHMSEK6MAAKSCZ8QQs5ZxIWPACRuhxEun5gdqVoQmW?=
 =?us-ascii?Q?yTeu1GNirRTyPG7H83sECfPg16Q5YvO2fq53HH7+UDkpWeGAaDJ0OdHcb2d0?=
 =?us-ascii?Q?0L1ybRrHJG/erjxzOsaDyRy6PVZvvABpbfWHGxlc50n8KRUQqTwAIQc69oTF?=
 =?us-ascii?Q?hzGoCQ/uR8wpcrHsi51omnNYKWsnmAiYS7a4LEyi/NNSGg5SiEAd++mjDSAS?=
 =?us-ascii?Q?wajdGmjheKfjJSWojPVQiNL6sWYiPdQXsZdkeEvbv36cdl5ob2sdCATWzDD7?=
 =?us-ascii?Q?IeNZiaYIjNPZEa/Rxqnkho8neEOJrEVWT6kx6XhmbBGeAhGw7R57OLPJIVyY?=
 =?us-ascii?Q?OS6MxtwM+2lzc+e7mul93FujRT7gjjapsPvLeWHtjnATCH/E1FlwYIJcbu+s?=
 =?us-ascii?Q?8OJtLbVCwc0mwzrHJahXiLJY6mcibwFoj5OceJ3TMo7Fig5Ny2p97/Twv+pF?=
 =?us-ascii?Q?d9DYHibchwhy9gVCWG/E4Kx6Q2RAjFY/e9N/btxNN8Y3JP7M7i5e/6+4tEnJ?=
 =?us-ascii?Q?uehawZTfL2Kc2mKINjgqd2sGAiJTuH9VKqgNr3v04BQVmOBb7n4GTD9F8u87?=
 =?us-ascii?Q?trJHnbz23WxDGVm1YJr1/cvqTptq83Zr/CS5hvr+pzHjEq9+2HKYXFx6DJuR?=
 =?us-ascii?Q?UVKTbwgmdXSxSFRjXUiEif9jPonGAsEPdNQYRgKwwAz7kLqhHnpgenC3aPcx?=
 =?us-ascii?Q?kNTw34KFMlX2bKSp5f/0pbnlTPCzOAHThMZ1FBULrLGB7gW+5gxw5sMSFeQI?=
 =?us-ascii?Q?inarWVybdLVqwyf1x9nlT6Fg4Ymk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e11d1dc-35a9-400a-968c-08d913fc85d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 21:42:34.8671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tG02O/FHOcdWOeojhwX0Fxejzc/HMyZDlfzr83+ZNmNzLEPpgB2bAMc3JcHJkRZqnn/E+6APJIvr2HYaJQAGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0162175294=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0162175294==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nselwo4h2zitwm4h"
Content-Disposition: inline

--nselwo4h2zitwm4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 05/07, Alex Deucher wrote:
> The DCN3 guards were dropped a while ago, this one must have
> snuck in in a merge or something.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bdbc577be65c..73d41cdd98ba 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3720,10 +3720,8 @@ static int amdgpu_dm_initialize_drm_device(struct =
amdgpu_device *adev)
> =20
>  	/* Use Outbox interrupt */
>  	switch (adev->asic_type) {
> -#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>  	case CHIP_SIENNA_CICHLID:
>  	case CHIP_NAVY_FLOUNDER:
> -#endif
>  	case CHIP_RENOIR:
>  		if (register_outbox_irq_handlers(dm->adev)) {
>  			DRM_ERROR("DM: Failed to initialize IRQ\n");
> --=20
> 2.30.2
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7C25680479109e4017707308d91197df29%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637560166252532452%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DnDdFg7%2FPczkIeaw9vNoD4%2BctBPiyfYNIGsbKKZQCpEs%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--nselwo4h2zitwm4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmCZqMcACgkQWJzP/com
vP8fshAAph1izJR63t1APB8IJi+ZiSyOqnft+t+Nl10KJg1BEnEDVVBIDPLyLkZp
hg/Hen06CdpU01EYPOcLepR40DcFowR4KFtYs8uAEfs1UbiYBs7Gc2refRK3F9Os
EDbC2ySzQlmGGgnJJdT3fFA3JdPsH+s8mag06/Gwd7hB0la7UyJ97obZPjufY86c
Vukz+rTXpXA4/1fwG6LZ2B462tDC/l3kh1xnxbW1dQTGcYMp23zVP8oDFbjTXU8F
AvkJpvrQwhvFkUmsoQWw+9L0mX2WlW/mU1jFHxY5m418bfq9eq83hl1xIPM6ozsH
o1Al2FRvsLrYv4MnpOwCXaI/CA7+fAnb2CLOuVwzxSwCI9MHcFQPcrdGp8X2qUgs
RQMBeP1o4nXoUvTjaQGph1mqN2IJcTHKVqVXTuDQ6Bo366Hn6qw/Pvxdh/xS/xCT
4n7OG8qEA4GwLiZknT7xjY2iKy2mbImiGjtI1vM09F6HegAv8MMT7mlsjw6WXBqt
1KeNks20epzAGjTd31NWJClsum/8qtgJQTuUAo8cO3l+k6vsPOKgQjXvi6CrWxXg
Tiq1KRiveR0a58yViSav6sY3IzDMyA4pOpDMimYY9FRxe/j+YFeSejoM06HXmGPa
tkR35BcVTC5HDwYuWNOy1gDVZku2am719Zxsm9cfD63dZ1E6S1A=
=7CdP
-----END PGP SIGNATURE-----

--nselwo4h2zitwm4h--

--===============0162175294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0162175294==--
