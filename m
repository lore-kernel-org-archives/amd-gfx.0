Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D95C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7872D2082F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 15:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EPC4OuYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7872D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0366E079;
	Wed, 12 Feb 2020 15:58:09 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A9E6E079
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 15:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvPMb3ARiM9RpfDRMiyHe5aGMICtMs7j/Onf73vIg7Tt3u/JruysQ9igKE8i4Fg9PRdYJbqL9vcnRszUFovPxrI9+g/QMiTqCyI4B6qdxErzUCoJY+5BTouUP2j5BECKHFpBYR05kvE0nNqPAawQcKNlIx3ohilJlU3+EUaOcW4aLX6ZaWbqwFVKadiEbp+/RuqSgxI1VY/X3VEnxK4rPnoUgalIv9Fxfc2w77zYtYu9GtHQCZ5vVpaxVQyt6jaL6L7B8GawMRWi8F2CyOdrwMoiqJQsyMXTO5pKJTNXDvn/L0s7zpLzKyydn+poFx2pvqbxqAVfEu4pzI1nSkEVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZGSabkMqry5dJD773+ZAsTCD/+HN/t9QqOqvVDsTsQ=;
 b=MAM9quZkBrVQncdEJVjBtUAsLFkJB3mfVidaEEaNdk+iS/DXoLC4NeuEwDO6sAv7atTkpWyGzWruCZR4+1OWL3Uupe6ToEVh8By18dFpu1lAZUIaq8706ocE/PzGq11hIiNK0TjdYM5ny8xLiF6/kSCFSTgArYWhkOLhIZZcZfj2yq7n4ebJa13JNLiuunag9WdBj2jMvYp7vVhrXH8t9mwY04ayux4TfoDO0KuUhzCYpCgFlaPXp5mY4xhaVJ3mRH/7DHbbzMb8M+oNuglkWLP890EetVs9D5MdAMFlYYVDBH7pnVYgg6L7tCcRZFeExT0BrmusQn6oNIrzN8uVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZGSabkMqry5dJD773+ZAsTCD/+HN/t9QqOqvVDsTsQ=;
 b=EPC4OuYSGATACERBJV1PJLpVNn6dAKN8X5vH7991stYIMf5fJExHCao+jdkG503a5aB7IxxrsWI/jNR4+Bj48VzFg6WB4AQ0WMrMEQmaelnKbPooqCjvYyPkNo8zzf8ycUTwVqdIyCX4Fb5NG6kosnJIvxonl1qXI0kK4HGMK+c=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB0012.namprd12.prod.outlook.com (10.172.89.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 15:58:07 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 15:58:07 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
 dc_resource.c
Thread-Topic: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
 dc_resource.c
Thread-Index: AQHV4V2YLntWO6rF0U2TgpNOOFdNcKgXth3g
Date: Wed, 12 Feb 2020 15:58:07 +0000
Message-ID: <DM5PR1201MB2554165EB95580B5B5E20FDD9E1B0@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
 <20200212043258.1123758-3-alexander.deucher@amd.com>
In-Reply-To: <20200212043258.1123758-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd810a49-5694-407e-4cc4-08d7afd459f7
x-ms-traffictypediagnostic: DM5PR1201MB0012:|DM5PR1201MB0012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0012CA1508B47A6BBCFDADA79E1B0@DM5PR1201MB0012.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(8936002)(81156014)(8676002)(478600001)(81166006)(2906002)(66476007)(76116006)(52536014)(55016002)(5660300002)(9686003)(86362001)(66446008)(64756008)(66556008)(66946007)(26005)(4326008)(316002)(186003)(6506007)(53546011)(7696005)(33656002)(71200400001)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0012;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8fTaLozAxFcQYDciaq+PQ9it/S7zViGiToFD1wamErWugVqshYRYDi/V/Z/uyi2bimgy9gmjtxGCVUR8vSJdTrCceTWRdseo5n77J55FgJyfvNx0nBSrR5qV/Fn7pFXh/ihddQmJobxHTrcxY+Y7Fp8rrp/8qXDuKif9pAzq/jcjH3ftmygC023olJfQkGGIs7EfMCL/OisL9tZmhrp21c1z0QPHtCo/+vn8YHsrZq43gM8BfP0HFN60E5oVR9bCeZJudtrJzb/hK3E9NDSrHifIhENjnHVP7+q2OrYG+/4+DKRtnAH/6F6PISOty+gZtXh77NtjJf5PE1K1GluGazXjTVAEbGth89nVbMWJQsmtf8MSjhcQOqAnPiCJuk3FMRVELgSgKUrvfc8iPMQwYrXSZ0N31AEdVCflCQYcH52F9b9Zzct66A6jSQZdJKpb
x-ms-exchange-antispam-messagedata: R6/l5UDtDPDpebjL6sH6Jo/5Nwv1H5hRcGZrK56hBlta7FNivMuKt7cc9nq6Xq1KRa047MM7yqhkY8M0Fm2OMK0Ksbh6yPHyvYUqVxpTm+0u6CKx5NDts9+atXGwBieIh7EbukzALbMOoJbkGdEF6g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd810a49-5694-407e-4cc4-08d7afd459f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 15:58:07.1842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+VtCJq2TTeEcanVo8+TrvaXaPos/3/abDAhNRHiUK1TqBChYWs8c0RRlqMaqwOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0012
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please find my reply inline.

Thanks,
Zhan

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: 2020/February/11, Tuesday 11:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
> dc_resource.c
> 
> It's used by more than just DCN2.0.  Fixes missing symbol when amdgpu is
> built without DCN support.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/core/dc_resource.c    | 16 ++++++++++++++++
>  .../drm/amd/display/dc/dcn20/dcn20_resource.c    | 16 ----------------
>  .../drm/amd/display/dc/dcn20/dcn20_resource.h    |  1 -
>  drivers/gpu/drm/amd/display/dc/inc/resource.h    |  3 +++
>  4 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index c02e5994d32b..572ce3842535 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -532,6 +532,22 @@ static inline void get_vp_scan_direction(
>  		*flip_horz_scan_dir = !*flip_horz_scan_dir;  }
> 
> +int get_num_odm_splits(struct pipe_ctx *pipe) {
> +	int odm_split_count = 0;
> +	struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
> +	while (next_pipe) {
> +		odm_split_count++;
> +		next_pipe = next_pipe->next_odm_pipe;
> +	}
> +	pipe = pipe->prev_odm_pipe;
> +	while (pipe) {
> +		odm_split_count++;
> +		pipe = pipe->prev_odm_pipe;
> +	}
> +	return odm_split_count;
> +}
> +
>  static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int
> *split_count, int *split_idx)  {
>  	*split_count = get_num_odm_splits(pipe_ctx); diff --git
> a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 39026df56fa6..1061faccec9c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -1861,22 +1861,6 @@ void
> dcn20_populate_dml_writeback_from_context(
> 
>  }
> 
> -int get_num_odm_splits(struct pipe_ctx *pipe) -{
> -	int odm_split_count = 0;
> -	struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
> -	while (next_pipe) {
> -		odm_split_count++;
> -		next_pipe = next_pipe->next_odm_pipe;
> -	}
> -	pipe = pipe->prev_odm_pipe;
> -	while (pipe) {
> -		odm_split_count++;
> -		pipe = pipe->prev_odm_pipe;
> -	}
> -	return odm_split_count;
> -}
> -
>  int dcn20_populate_dml_pipes_from_context(
>  		struct dc *dc, struct dc_state *context,
> display_e2e_pipe_params_st *pipes)  { diff --git
> a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> index 5180088ab6bc..f5893840b79b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> @@ -49,7 +49,6 @@ unsigned int dcn20_calc_max_scaled_time(
>  		unsigned int time_per_pixel,
>  		enum mmhubbub_wbif_mode mode,
>  		unsigned int urgent_watermark);
> -int get_num_odm_splits(struct pipe_ctx *pipe);  int

Seems like the "int" at the end of this line actually belongs to the next line.
I am wondering is it a typo or a format-patch glitch?

> dcn20_populate_dml_pipes_from_context(
>  		struct dc *dc, struct dc_state *context,
> display_e2e_pipe_params_st *pipes);  struct pipe_ctx
> *dcn20_acquire_idle_pipe_for_layer(
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> index 5ae8ada154ef..ca4c36c0c9bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> @@ -179,4 +179,7 @@ unsigned int resource_pixel_format_to_bpp(enum
> surface_pixel_format format);
> 
>  void get_audio_check(struct audio_info *aud_modes,
>  	struct audio_check *aud_chk);
> +
> +int get_num_odm_splits(struct pipe_ctx *pipe);
> +
>  #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
