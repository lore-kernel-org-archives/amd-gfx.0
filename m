Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2F1C7EE26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 15:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD39510E2A1;
	Tue, 23 May 2023 15:47:58 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3467C10E2A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 15:47:57 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-55556745aefso999667eaf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684856876; x=1687448876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAefWcmT04gBXGJTJrPInmd9E4w1/npv0tL/epftxzI=;
 b=euDlBwH3FulzkVc/xePHV9UnRbYyfkwJLpdx6cdGyObAxUeDGE9JFY0fl0fV0GjWTM
 KAficDFFuAxrdFEjTzWNPknepFITcKms0zqktJw/s3MpCYhWdumNMJz1DPw6Z9c9OUYF
 6sslU7wP8/fz92vxYt/tmlStbGs+Kj1ECPyl+F8IkPSJaj8pvcvBYCF/arug3DcW5hyl
 p89ZYXpSk0LxhU5gD2aWhC3nWfrol2kc+IQI5Km5vUxCgBB9vW655uhtvzLjZ/1aerZf
 Zb1Obx/BBi7Lhj3GKBCuVb9Mry/hjDCWT07mF2xwwfKG9gnepG+ON+KQJUgq8EPQP7Ie
 iOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684856876; x=1687448876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAefWcmT04gBXGJTJrPInmd9E4w1/npv0tL/epftxzI=;
 b=ZdgXD3bcrtcbsiZzOz3sohcyUcmlpuxSsu4+eqKy6Ix3lnR56TUGIxXele88aJ4R+z
 JDFOROnxiTi7kJJu7CHDIlnNw93pkjNh88WsFs+RgoZgT+iWnXXggGNN44UdKMNGNt+a
 2MaEn4Pw489JTMfXPtQypqtn+O/8MLPPYd+T3DjlZJYNmCeA6ou9zIYjdGCeQFlEWON1
 OD5IrebNa1RwtKzbbKWZ0XcFpezhW75Ejmo+RAA1uBQmgB4G66UrLcOv387GSCzElhKm
 JvpfmzfE33hzP5mrx4F39LoK0JfvNccw/wNym5i0mes9QMRzxBsHIg1kt+ozs2FI9FGK
 PlTg==
X-Gm-Message-State: AC+VfDzuKORn/1hiYSrDbXNxwEAYy3VwZRnzjqc5lAo9XalkirPURUfb
 5FSkStv9xmfocILa1LDfq8vMlBigrjZM+vFM7okf0nVx
X-Google-Smtp-Source: ACHHUZ519H846CzdCE4wrLxchrUlVrzOS+qw16ab5gSR7yQEwNuQPjiUmkmM1Zwgz7af1c0Caf8K5XYoDvItuw+3UkA=
X-Received: by 2002:aca:1103:0:b0:398:1157:91a9 with SMTP id
 3-20020aca1103000000b00398115791a9mr3361593oir.26.1684856875879; Tue, 23 May
 2023 08:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230522130823.769236-1-michel@daenzer.net>
 <20230522130823.769236-2-michel@daenzer.net>
 <cff1d185-4cd6-f7df-e79c-03515d6cbd60@amd.com>
In-Reply-To: <cff1d185-4cd6-f7df-e79c-03515d6cbd60@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 May 2023 11:47:44 -0400
Message-ID: <CADnq5_P7FGVWXQa7a+2TujD8ivg0z7E2ZXH1pz1R7ZSWceSKdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm/amd/display: Do not set drr on pipe
 commit"
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>
for the series.

Jay, I assume you or Hamza will pick these up?

Thanks,

Alex

On Tue, May 23, 2023 at 11:31=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>
> On 5/22/23 09:08, Michel D=C3=A4nzer wrote:
> > From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > This reverts commit 474f01015ffdb74e01c2eb3584a2822c64e7b2be.
> >
> > Caused a regression:
> >
> > Samsung Odyssey Neo G9, running at 5120x1440@240/VRR, connected to Navi
> > 21 via DisplayPort, blanks and the GPU hangs while starting the Steam
> > game Assetto Corsa Competizione (via Proton 7.0).
> >
> > Example dmesg excerpt:
> >
> >  amdgpu 0000:0c:00.0: [drm] ERROR [CRTC:82:crtc-0] flip_done timed out
> >  NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
> >  [...]
> >  RIP: 0010:amdgpu_device_rreg.part.0+0x2f/0xf0 [amdgpu]
> >  Code: 41 54 44 8d 24 b5 00 00 00 00 55 89 f5 53 48 89 fb 4c 3b a7 60 0=
b 00 00 73 6a 83 e2 02 74 29 4c 03 a3 68 0b 00 00 45 8b 24 24 <48> 8b 43 08=
 0f b7 70 3e 66 90 44 89 e0 5b 5d 41 5c 31 d2 31 c9 31
> >  RSP: 0000:ffffb39a119dfb88 EFLAGS: 00000086
> >  RAX: ffffffffc0eb96a0 RBX: ffff9e7963dc0000 RCX: 0000000000007fff
> >  RDX: 0000000000000000 RSI: 0000000000004ff6 RDI: ffff9e7963dc0000
> >  RBP: 0000000000004ff6 R08: ffffb39a119dfc40 R09: 0000000000000010
> >  R10: ffffb39a119dfc40 R11: ffffb39a119dfc44 R12: 00000000000e05ae
> >  R13: 0000000000000000 R14: ffff9e7963dc0010 R15: 0000000000000000
> >  FS:  000000001012f6c0(0000) GS:ffff9e805eb80000(0000) knlGS:000000007f=
d40000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00000000461ca000 CR3: 00000002a8a20000 CR4: 0000000000350ee0
> >  Call Trace:
> >   <TASK>
> >   dm_read_reg_func+0x37/0xc0 [amdgpu]
> >   generic_reg_get2+0x22/0x60 [amdgpu]
> >   optc1_get_crtc_scanoutpos+0x6a/0xc0 [amdgpu]
> >   dc_stream_get_scanoutpos+0x74/0x90 [amdgpu]
> >   dm_crtc_get_scanoutpos+0x82/0xf0 [amdgpu]
> >   amdgpu_display_get_crtc_scanoutpos+0x91/0x190 [amdgpu]
> >   ? dm_read_reg_func+0x37/0xc0 [amdgpu]
> >   amdgpu_get_vblank_counter_kms+0xb4/0x1a0 [amdgpu]
> >   dm_pflip_high_irq+0x213/0x2f0 [amdgpu]
> >   amdgpu_dm_irq_handler+0x8a/0x200 [amdgpu]
> >   amdgpu_irq_dispatch+0xd4/0x220 [amdgpu]
> >   amdgpu_ih_process+0x7f/0x110 [amdgpu]
> >   amdgpu_irq_handler+0x1f/0x70 [amdgpu]
> >   __handle_irq_event_percpu+0x46/0x1b0
> >   handle_irq_event+0x34/0x80
> >   handle_edge_irq+0x9f/0x240
> >   __common_interrupt+0x66/0x110
> >   common_interrupt+0x5c/0xd0
> >   asm_common_interrupt+0x22/0x40
> >
> > Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ------
> >  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 -------
> >  2 files changed, 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drive=
rs/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > index 6ce10fd4bb1a..5403e9399a46 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > @@ -2113,12 +2113,6 @@ void dcn20_optimize_bandwidth(
> >       if (hubbub->funcs->program_compbuf_size)
> >               hubbub->funcs->program_compbuf_size(hubbub, context->bw_c=
tx.bw.dcn.compbuf_size_kb, true);
> >
> > -     if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> > -             dc_dmub_srv_p_state_delegate(dc,
> > -                     true, context);
> > -             context->bw_ctx.bw.dcn.clk.p_state_change_support =3D tru=
e;
> > -     }
> > -
> >       dc->clk_mgr->funcs->update_clocks(
> >                       dc->clk_mgr,
> >                       context,
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drive=
rs/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > index 0411867654dd..0e071fbc9154 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > @@ -985,18 +985,11 @@ void dcn30_set_disp_pattern_generator(const struc=
t dc *dc,
> >  void dcn30_prepare_bandwidth(struct dc *dc,
> >       struct dc_state *context)
> >  {
> > -     if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> > -             dc->optimized_required =3D true;
> > -             context->bw_ctx.bw.dcn.clk.p_state_change_support =3D fal=
se;
> > -     }
> > -
> >       if (dc->clk_mgr->dc_mode_softmax_enabled)
> >               if (dc->clk_mgr->clks.dramclk_khz <=3D dc->clk_mgr->bw_pa=
rams->dc_mode_softmax_memclk * 1000 &&
> >                               context->bw_ctx.bw.dcn.clk.dramclk_khz > =
dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
> >                       dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, d=
c->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.=
num_entries - 1].memclk_mhz);
> >
> >       dcn20_prepare_bandwidth(dc, context);
> > -
> > -     dc_dmub_srv_p_state_delegate(dc, false, context);
> >  }
> >
