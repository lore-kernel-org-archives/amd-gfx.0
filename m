Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3358FC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 16:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0659820714
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hIKwN0FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0659820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB286E868;
	Wed, 12 Feb 2020 16:12:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040446E868
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 16:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGLdBIRtwfK0FUQgQWsaauKVRe2JnAp2nfSJOJhudDUzKgqkfAcf/U5H5iwnM1ZPdODXWrOxg8VvzzrVXrlQg1geDPidxX/oqu7KZR0LgmmPKExuHs+1zSAZEXKfaPcXUjcngLvO0eiygymhu0d8hPKjKCTeY7Ujev/Lpgq2DBkLCh9C7DVU2U3INDnvMPc7bwd4fYhmDlnge75dEPcPreEktJABj9sqofUmLylIU8UCBZskAQFow7ERLwAs25ra8947JN9cgFP3CyIJrc76FQWc41QGEWBF1py1ly9d9TljprcgliJh102G/eIeHBbfJUSov2AtleMu3R82JP2AYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1btJmFtVXPyTaI1qEeD2bLz3Ig7jTcVqLICdsh1GwpA=;
 b=GcipfM1BLhYMjZK4xyJJr2BNIBKEpLui2Vys2pT99Lx0PYV/A6OZT5LrJULRf5PhAgtZwG34eL6IuK2xZlM4BbtaT24tzKTMSBe7MlrVR9PwHqXG0e77g3gZwOukeLcSG1goUXkJMMBNT6tKh0ynLolZa9FMa7SxzJDcL/lCPOWkCnbSxQqQDgbaACA8J6kgSSzTi9BJcluhun6mz2I2a88Ka3DOQUaCopHtNNmOq7Tiw3I7+alTYGaU+s+XigEhXQmYGqGX7UuyefmJAIKlC0ngCLsmS/lO215/Ldw/F+wLyG2rOAYnCOv/8kSJTC45/wSbd9AxTvvbOvH1nY4CUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1btJmFtVXPyTaI1qEeD2bLz3Ig7jTcVqLICdsh1GwpA=;
 b=hIKwN0FG5UAl/843pqABGQ4O4tDHZIvyfb8b2dj4YRXHPSedYk8IEwbGp/RrV6xE3h6akI/C8RrrizRwhLO0XVqkg6K2kzMsng6Jhf1xFxqOoGy0/uDtKNVwPUVaIb/xA78PClXb3QkopAiZBLlDp6faZL92OFxMiB5Qe/wz+HU=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB2537.namprd12.prod.outlook.com (10.172.91.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 16:12:32 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721%6]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 16:12:32 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
 dc_resource.c
Thread-Topic: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits() into
 dc_resource.c
Thread-Index: AQHV4V2YLntWO6rF0U2TgpNOOFdNcKgXth3ggAADfQCAAAGFUA==
Date: Wed, 12 Feb 2020 16:12:32 +0000
Message-ID: <DM5PR1201MB25544F2C6D007E4391F831A89E1B0@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
 <20200212043258.1123758-3-alexander.deucher@amd.com>
 <DM5PR1201MB2554165EB95580B5B5E20FDD9E1B0@DM5PR1201MB2554.namprd12.prod.outlook.com>
 <CADnq5_OuXJeX7mxm_6oCzApKs-K_6Z+eLYH4=d2h88hR77xqkw@mail.gmail.com>
In-Reply-To: <CADnq5_OuXJeX7mxm_6oCzApKs-K_6Z+eLYH4=d2h88hR77xqkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd98c82e-227f-4867-f239-08d7afd65d80
x-ms-traffictypediagnostic: DM5PR1201MB2537:|DM5PR1201MB2537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB25371B4696B56121120BD8BA9E1B0@DM5PR1201MB2537.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(478600001)(316002)(53546011)(7696005)(4326008)(6506007)(5660300002)(71200400001)(33656002)(86362001)(966005)(81166006)(66946007)(66556008)(66446008)(76116006)(52536014)(186003)(66476007)(55016002)(64756008)(8936002)(8676002)(2906002)(9686003)(54906003)(26005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2537;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fes1k0HBm6XBma/RewyQqTwlGho/ThAhtJZ1LhTFbFZF++RF1QX4oeQkBinlFG5bvdTemzDGnB94FRuYI9uDRAGGTvmSxpgeCNPj9u1RwQTDnwH4UR4beVoiZ4NavL1HwgoplyGMKoBX5HYTMyNipA1xxZt1ttCL8HOCk/mTaEU3EWUVDEXsz1gi4EEtnMGRI9Cypdbr6mphLJ6+vXTCKXRWToTabxBnv5BnzYw8XiQszdRALhhy7HhqOQshHSXzp3/EzBepC98wlxBi6l5oEVOWQcXj/PfEthMNAHTOYK3bmqCrr49z2MOlu0uSJaQKCs2WZUMJMFJrJp3UCfX2VbiwT0Kkdv9Wd9M0pbV03ru1pp0tkWCrGocUq1giICaTbvDEnovNEO1ek196jISYdKaFor6eqVjz9plRwsGGJPkLDMhZeDT02P6YyLwmyurkOLlSpbm3O2SGoMe03irJpl4qD9Oe9WcHr1EZ2eTv+ToOBHiZYVnBzAIf9GQZUGNdLXOFo4OgxeKMWyHyZL600A==
x-ms-exchange-antispam-messagedata: OnXZQB70dirxLdYt7aLD/pD+Oi7JBky3zIzE+P6ixDcsEdzC9fOobDlaA3lX6Rg2lIwPX9q6YT0bIG2yOrSyhdo7+d3j9xR/E2n8J7gpBGvcbTOQM8juGujViokklpoYq10U5sfWTHD5ydYpoRtoLw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd98c82e-227f-4867-f239-08d7afd65d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 16:12:32.1548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSwCdWOZAG6G/oNXVdMHEmZzqp6f97/nVToIOa8H72D39RY/3MBn/zeS+zs0Wk4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2537
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: 2020/February/12, Wednesday 11:05 AM
> To: Liu, Zhan <Zhan.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits()
> into dc_resource.c
> 
> On Wed, Feb 12, 2020 at 10:58 AM Liu, Zhan <Zhan.Liu@amd.com> wrote:
> >
> > Please find my reply inline.
> >
> > Thanks,
> > Zhan
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Alex Deucher
> > > Sent: 2020/February/11, Tuesday 11:33 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Subject: [PATCH 3/3] drm/amdgpu/display move get_num_odm_splits()
> > > into dc_resource.c
> > >
> > > It's used by more than just DCN2.0.  Fixes missing symbol when
> > > amdgpu is built without DCN support.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  .../gpu/drm/amd/display/dc/core/dc_resource.c    | 16
> ++++++++++++++++
> > >  .../drm/amd/display/dc/dcn20/dcn20_resource.c    | 16 ----------------
> > >  .../drm/amd/display/dc/dcn20/dcn20_resource.h    |  1 -
> > >  drivers/gpu/drm/amd/display/dc/inc/resource.h    |  3 +++
> > >  4 files changed, 19 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > > index c02e5994d32b..572ce3842535 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > > @@ -532,6 +532,22 @@ static inline void get_vp_scan_direction(
> > >               *flip_horz_scan_dir = !*flip_horz_scan_dir;  }
> > >
> > > +int get_num_odm_splits(struct pipe_ctx *pipe) {
> > > +     int odm_split_count = 0;
> > > +     struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
> > > +     while (next_pipe) {
> > > +             odm_split_count++;
> > > +             next_pipe = next_pipe->next_odm_pipe;
> > > +     }
> > > +     pipe = pipe->prev_odm_pipe;
> > > +     while (pipe) {
> > > +             odm_split_count++;
> > > +             pipe = pipe->prev_odm_pipe;
> > > +     }
> > > +     return odm_split_count;
> > > +}
> > > +
> > >  static void calculate_split_count_and_index(struct pipe_ctx
> > > *pipe_ctx, int *split_count, int *split_idx)  {
> > >       *split_count = get_num_odm_splits(pipe_ctx); diff --git
> > > a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > > b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > > index 39026df56fa6..1061faccec9c 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > > @@ -1861,22 +1861,6 @@ void
> > > dcn20_populate_dml_writeback_from_context(
> > >
> > >  }
> > >
> > > -int get_num_odm_splits(struct pipe_ctx *pipe) -{
> > > -     int odm_split_count = 0;
> > > -     struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
> > > -     while (next_pipe) {
> > > -             odm_split_count++;
> > > -             next_pipe = next_pipe->next_odm_pipe;
> > > -     }
> > > -     pipe = pipe->prev_odm_pipe;
> > > -     while (pipe) {
> > > -             odm_split_count++;
> > > -             pipe = pipe->prev_odm_pipe;
> > > -     }
> > > -     return odm_split_count;
> > > -}
> > > -
> > >  int dcn20_populate_dml_pipes_from_context(
> > >               struct dc *dc, struct dc_state *context,
> > > display_e2e_pipe_params_st *pipes)  { diff --git
> > > a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> > > b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> > > index 5180088ab6bc..f5893840b79b 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
> > > @@ -49,7 +49,6 @@ unsigned int dcn20_calc_max_scaled_time(
> > >               unsigned int time_per_pixel,
> > >               enum mmhubbub_wbif_mode mode,
> > >               unsigned int urgent_watermark); -int
> > > get_num_odm_splits(struct pipe_ctx *pipe);  int
> >
> > Seems like the "int" at the end of this line actually belongs to the next line.
> > I am wondering is it a typo or a format-patch glitch?
> 
> Actual patch is correct:
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next&id=c8d2c8eaa3bbcaf8e2bc20f3e3203ed444f90bcc

I see. Thx!

This patch (and this patch series) is reviewed by:
Zhan Liu <zhan.liu@amd.com>

> 
> >
> > > dcn20_populate_dml_pipes_from_context(
> > >               struct dc *dc, struct dc_state *context,
> > > display_e2e_pipe_params_st *pipes);  struct pipe_ctx
> > > *dcn20_acquire_idle_pipe_for_layer(
> > > diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> > > b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> > > index 5ae8ada154ef..ca4c36c0c9bc 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> > > +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> > > @@ -179,4 +179,7 @@ unsigned int
> resource_pixel_format_to_bpp(enum
> > > surface_pixel_format format);
> > >
> > >  void get_audio_check(struct audio_info *aud_modes,
> > >       struct audio_check *aud_chk);
> > > +
> > > +int get_num_odm_splits(struct pipe_ctx *pipe);
> > > +
> > >  #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_
> */
> > > --
> > > 2.24.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
