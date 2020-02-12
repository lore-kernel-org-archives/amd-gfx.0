Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68ACC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 17:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F2820658
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 17:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CdzXYhOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F2820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467376EAF7;
	Wed, 12 Feb 2020 17:09:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02BA6EAF7
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 17:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+y/lFHp2bcZDlYUG92Bq0I0WwSICz/BD4EC+RxSomGJm/puGArhFdXq5HGwh9c4HSOwrSuLo+NsUrdljyDnGUcFho0DcruO63Kuybaj9u6xWYikTV7fYPAHWownEVB9xfpIsw2Sl3A3TO4eK85nkpu6cd3jf+q4XmRo0t/Q6xEbNYMGU2KIesWgtMAwUCRC0HnvTd9lvVocElorUrTXIAwWXtijySD9u6e8iI+Prfm3XBikt2VS/aWXCMXII6MZ0IT/mRhUbRSrh3xnILUqpmeak7cyQcXrGcdb6Ayfsv7ukXfGDxEdYHWBAspYiqB/gl/OOUTKXk0+ZqoX6/s9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTVJiwD9WWMjWmNZlOtoKHimsjUjy+vO2tRwPcgzwlM=;
 b=cNlcEPyIhUC5/YeiX2ChLYk4z5RgZLkCgcO+y4bDzJh4FuSuB7UpzFIfK3V0rDeiyMV87dLxAgO4g9Jreu8LQfK6/piQdHMvBlr7q6XWgh49vTNmWuqStzIf2ZW+iMUV0+iRuH+EEvETKjM+oW98+H/Urwc4JbiN+Vp6DGK3+Eb5KEQFRNtpyVRQHRD7ut3FRi6vj/Bo5eZD+HpLd1NnPopHgS9MiOorX6WKpXCRseTs3QjVU7MKv3PL1lKS7/cmJ0PhP3Les5OjWy1QiEN46/P2NCfmMBK2lQQHD09v4flg6Ws3AMaH5MYeI773fgbVgCYa/u6APvOOrT/alXFXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTVJiwD9WWMjWmNZlOtoKHimsjUjy+vO2tRwPcgzwlM=;
 b=CdzXYhOsJjOkrKkSIOjBWg8l9Alk7p2kg/qU2SWTRtzWyfcdQhMNjajDl1QNoc/voDP7PJHMw7oFB+j/5xDitDzj7PTuegVivWuq7rQtug26N7ZZc6C8Wnq9G1rQOQVRbX+e1wLxlXBTX2sefgTl7XbkyiyVZBXWHKtri1ca/IU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2393.namprd12.prod.outlook.com (52.132.184.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Wed, 12 Feb 2020 17:09:33 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::c15:4b9f:526:4736]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::c15:4b9f:526:4736%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:09:33 +0000
Date: Wed, 12 Feb 2020 12:09:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
 dc_resource.c
Message-ID: <20200212170926.4yj4r75licznmgbt@outlook.office365.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
 <20200212043258.1123758-3-alexander.deucher@amd.com>
In-Reply-To: <20200212043258.1123758-3-alexander.deucher@amd.com>
X-ClientProxiedBy: YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::37) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from outlook.office365.com (165.204.55.250) by
 YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Wed, 12 Feb 2020 17:09:32 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 712e6c57-e987-4f8b-8e27-08d7afde547e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2393:|MW2PR12MB2393:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2393304DB246D69516DA3EBA981B0@MW2PR12MB2393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(366004)(189003)(199004)(966005)(4326008)(6506007)(21480400003)(9686003)(956004)(2906002)(81156014)(66476007)(26005)(45080400002)(7696005)(498600001)(55016002)(16526019)(66556008)(8936002)(8676002)(44144004)(1076003)(66946007)(81166006)(186003)(86362001)(52116002)(5660300002)(6916009)(6666004)(2700100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2393;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70YPmbT+kKX47uf9sfeWF/aCGXW9W+qAMJqXxIND2TudZcIW6tRmw6X8QyzNW+JWKZdiaTiAu3XqY7FBuGY2YmEXPv/wtDJdn0X/4TSl5jdCkgBVl4H93fpZP1ddtHB21Sm3jJyT270X1vfUTM48rIiMrrzqtVaK0waG1LZooc8ea6Qsk4LycSIN936klcnxRdPs2xIQI4wXT7cQGQbvmHTHRsYZDb2hIMARhqJ5u4sITRB/v8Vi+sYp5cgQVrojUQoxstkuOwxveytNKEzDzdYirfB3OndZAlhUdJIwx6UZ3kjZBVueyQ3JVoj/YDUouyYrLU7syDIA7rLG/E2Pth79pozK1jtuRpKSiWTjvD8thYywMTvtUko1J1O3ws86VrBHxFLK2uSiOa7fwR4DiRn+TgN7je5VHUnXyP3qilz82fHjh8Abe0u8ba7Fa1EUkOr+nERPMVjsZw2GiwZOuapMGCvR11e2exM3IA6jZHVYbXoYMpaRX/YTK8Cy9QEpi37Upg7jmTmgw017XqR+uzORxiE7l/Ho1qWbiDU1w8ShP5W7hQyUHb8LSU+YJn6160D/XVMFbn/YCZmBYZurD4KZY5wuEQQryiNA1wQWsEMQRJukmRZmHAVvWoy2bnub/qjA22O7FN/+YwfKt8U2og==
X-MS-Exchange-AntiSpam-MessageData: GJGF/+9ET9pMMAM0PRgzUI8IreJIWC/r8GUC3M2x62sGeR2a2ZcwqRgG1KQWT0gnEQDAR+Kk62kp/5GkZAmiqEEg8iylj9Qd3piONZCHpTa6Dj3EXKkGmtFLR2guf4xE0eENSc96mqz0zvbQHysZyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712e6c57-e987-4f8b-8e27-08d7afde547e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:09:33.3054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Qn67YyF85SikBmbOFOeBHLcKbHTQqzEb6kWJh/8q9N5DKsrCkmLwsdj04S+eKLLKE9+43M0+Dz6BUTxIY8ECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2393
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0121317691=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0121317691==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2zq6tlutmfpkm4w3"
Content-Disposition: inline

--2zq6tlutmfpkm4w3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
On 02/11, Alex Deucher wrote:
> It's used by more than just DCN2.0.  Fixes missing symbol when
> amdgpu is built without DCN support.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/core/dc_resource.c    | 16 ++++++++++++++++
>  .../drm/amd/display/dc/dcn20/dcn20_resource.c    | 16 ----------------
>  .../drm/amd/display/dc/dcn20/dcn20_resource.h    |  1 -
>  drivers/gpu/drm/amd/display/dc/inc/resource.h    |  3 +++
>  4 files changed, 19 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index c02e5994d32b..572ce3842535 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -532,6 +532,22 @@ static inline void get_vp_scan_direction(
>  		*flip_horz_scan_dir =3D !*flip_horz_scan_dir;
>  }
> =20
> +int get_num_odm_splits(struct pipe_ctx *pipe)
> +{
> +	int odm_split_count =3D 0;
> +	struct pipe_ctx *next_pipe =3D pipe->next_odm_pipe;
> +	while (next_pipe) {
> +		odm_split_count++;
> +		next_pipe =3D next_pipe->next_odm_pipe;
> +	}
> +	pipe =3D pipe->prev_odm_pipe;
> +	while (pipe) {
> +		odm_split_count++;
> +		pipe =3D pipe->prev_odm_pipe;
> +	}
> +	return odm_split_count;
> +}
> +
>  static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, i=
nt *split_count, int *split_idx)
>  {
>  	*split_count =3D get_num_odm_splits(pipe_ctx);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 39026df56fa6..1061faccec9c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -1861,22 +1861,6 @@ void dcn20_populate_dml_writeback_from_context(
> =20
>  }
> =20
> -int get_num_odm_splits(struct pipe_ctx *pipe)
> -{
> -	int odm_split_count =3D 0;
> -	struct pipe_ctx *next_pipe =3D pipe->next_odm_pipe;
> -	while (next_pipe) {
> -		odm_split_count++;
> -		next_pipe =3D next_pipe->next_odm_pipe;
> -	}
> -	pipe =3D pipe->prev_odm_pipe;
> -	while (pipe) {
> -		odm_split_count++;
> -		pipe =3D pipe->prev_odm_pipe;
> -	}
> -	return odm_split_count;
> -}
> -
>  int dcn20_populate_dml_pipes_from_context(
>  		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *p=
ipes)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/driv=
ers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> index 5180088ab6bc..f5893840b79b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> @@ -49,7 +49,6 @@ unsigned int dcn20_calc_max_scaled_time(
>  		unsigned int time_per_pixel,
>  		enum mmhubbub_wbif_mode mode,
>  		unsigned int urgent_watermark);
> -int get_num_odm_splits(struct pipe_ctx *pipe);
>  int dcn20_populate_dml_pipes_from_context(
>  		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *p=
ipes);
>  struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/=
drm/amd/display/dc/inc/resource.h
> index 5ae8ada154ef..ca4c36c0c9bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> @@ -179,4 +179,7 @@ unsigned int resource_pixel_format_to_bpp(enum surfac=
e_pixel_format format);
> =20
>  void get_audio_check(struct audio_info *aud_modes,
>  	struct audio_check *aud_chk);
> +
> +int get_num_odm_splits(struct pipe_ctx *pipe);
> +
>  #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
> --=20
> 2.24.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Ce2697beeff3847ea057408d7af74b286%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637170788143697503&amp;sdata=3DXUELq7%2FDPfX%2F=
ifA635o5DUd09JSwzPIXZkYjB107Jk8%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
Software Engineer, Advanced Micro Devices (AMD)
https://siqueira.tech

--2zq6tlutmfpkm4w3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl5EMUUACgkQWJzP/com
vP8lHg/9GdF1vMLBAYWqIQyq5HZ6fiG3+tkU1adCw0KuLRrWEtXApKGUVml12bNp
43rOzxezzhquS1egwKw9a2ZswWP8jOpHUyWUjOuNse5you0QMjTT48tEa+EEVm0O
mFsdL4gquhjvb3HQa1MhsZfHL2JAVEM0xUxGBKPJbP0RcUcvdmH7m0lhcGmngXIU
RmjNYphJ9s7yfsS0sPgH663O41PhYPy5by2oyQEtQEZWdDKFMNqEg9MA3ILXiO1m
6Ow4znJAJ1BNQoGRXCh172Q+icCHfTDYofznZ0Gu6+ndXg3V2dyRMJyXFa3QgiUn
U5Dq/iEDs28SulcQFfeH0rTf9PW545NlPC2UB2v4Uqe1s0qB2Y7cqNeY3TCB2cHo
z9fuAIWQRDv5IWxqG8DxbW++1yYmSLMRNXIhBze6uf355uFNwR3PA79FJNvaAtrv
iSFzQ54lBiccqkfx6ik4++BgkgLlJ8UGachESKoy1JS7PPzqBsYwh7KGLdhBTZEX
WQKSEK9b27WUu+sap9CtGRC3XoakVSD0SMB+GZkH41Ol9axeeFbOlyTUsN+Mk3Ad
nfPdoKeHA/GG3iYLrMyIcWnlsfaHqIHoaJ6+I8PpTtLGtktV1fMZlSl2Fy9adXPw
ecF6zsV45f/H5WufRqLS0/w8KkbZhOFG2kLBE0FvXafAftAFlTY=
=8x6o
-----END PGP SIGNATURE-----

--2zq6tlutmfpkm4w3--

--===============0121317691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0121317691==--
