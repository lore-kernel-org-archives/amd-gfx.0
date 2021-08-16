Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142DEC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 20:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A900C60F36
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 20:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A900C60F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458DD6E054;
	Mon, 16 Aug 2021 20:28:10 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F096E054
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 20:28:08 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 v33-20020a0568300921b0290517cd06302dso9639732ott.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8mwQubwEsSy38PfBmd1OOj3dYElxiyvawR0nH6MAA+Q=;
 b=sCYJ/btFXzGRAA1oRGK5gG1y9etkZQNkFPlWpN2t41Xv5jekTk2feCEUxtMm99vXie
 lX3mZNUp72wgVFkaduW3/StiRh/WmPl3meMaJNZtxiEaFfocxhPyqb6/aSOGYubBvJtw
 TA50COVt3h+ho4a97m9ZhqO+bvonpiIEuNAZ67o9iqoqrIYnoKrSYAGGeYpPTM29B7Ob
 AasK5xsfRC9zomKhEo8xY1tRWJXr0E12pXmXHZDyZKT2MF6/io9IiC0zZo0Ee+P3+NYx
 jg8Fu7r0PCClCRMtVI2ZRtX+gdHfd36yoY+zP7L9naL0SaXgcVqKE1vCRbtMlsm+DnGR
 OSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8mwQubwEsSy38PfBmd1OOj3dYElxiyvawR0nH6MAA+Q=;
 b=Gj29vwyIm4S9VKgh6XQb4z0PONQw3vy5i1CnH5TZEJpBoxzwoHNuA0qoYwUEJBxDVi
 4JhjFMN6K4NqCJG4ljse1BxCWlBwYLFdlhTFbXLY1iEYUiKzi88M18s97jyevxUAkhOg
 k6k3v/LgzHuW10UqkQa8X/faoATSMpveKMzq7//Zv8OjoyETYJo/u2XZiCRw4/q8njxV
 sLPZCVNA6nFihzVvdbh17iLs8nAZsQerLVs8P6rhUflycaXBj8ELgPvuEXSFRrh6Zpvw
 +TYFutTRLFLGwIVyvezME9FX86lko6CODLk4r9Cwg2XUR+C7ektu6BhvcpF2evEi9r7e
 RaJg==
X-Gm-Message-State: AOAM533dSnM0AotM/iFF1ufgjlAx8ywhfMNDTRBDTPrPOlZ/mksVGjE/
 JZTqw0QGrUyzJc5r5TyrtfziJ1YnjCNBv564MKk=
X-Google-Smtp-Source: ABdhPJwlMI5IZe9IKltrDxpgi4V7VUf4XoxWMlW2T1Ah4QR4FAGSf1YnlMLxaF1ogmqtpvAPrPvvp1QHdt3KEyc2oxs=
X-Received: by 2002:a9d:5a15:: with SMTP id v21mr14991oth.132.1629145687554;
 Mon, 16 Aug 2021 13:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <DM4PR12MB52146EC560946C5875B085FE9EFA9@DM4PR12MB5214.namprd12.prod.outlook.com>
 <9c1f29ee-a1d4-c745-f87e-52bb4b896b90@amd.com>
 <4d9fbe82-22ea-5ff2-3c01-a168783bfc35@amd.com>
In-Reply-To: <4d9fbe82-22ea-5ff2-3c01-a168783bfc35@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Aug 2021 16:27:56 -0400
Message-ID: <CADnq5_PjZpEWT0QcM6SmBF=M69HHJwDGDF31bntnu1JUA+ZgMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use DCN30 watermark calc for DCN301
To: Leo Li <sunpeng.li@amd.com>
Cc: "Liu, Zhan" <Zhan.Liu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>, "Logush, Oliver" <Oliver.Logush@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 16, 2021 at 4:25 PM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2021-08-16 9:59 a.m., Leo Li wrote:
> >
> >
> >
> > On 2021-08-13 3:21 p.m., Liu, Zhan wrote:
> >> [AMD Official Use Only]
> >>
> >> [AMD Official Use Only]
> >>
> >> [why]
> >> dcn301_calculate_wm_and_dl() causes flickering when external monitor i=
s
> >> connected.
> >>
> >> This issue has been fixed before by commit 0e4c0ae59d7e
> >> ("drm/amdgpu/display: drop dcn301_calculate_wm_and_dl for now"), howev=
er
> >> part of the fix was gone after commit 2cbcb78c9ee5 ("Merge tag
> >> 'amd-drm-next-5.13-2021-03-23' of
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=3D04%7C01%7Csunpeng.li%40amd.=
com%7C723f9131e57b4bd99db508d960be2441%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637647192045690562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Df2gL9TVAvdXl=
CbsZCDa2prF1J4l2ZDbpY8L2f6vK7as%3D&amp;reserved=3D0
> >> into drm-next").
> >>
> >> [how]
> >> Use dcn30_calculate_wm_and_dlg() instead as in the original fix.
> >>
> >> Fixes: 2cbcb78c9ee5 ("Merge tag 'amd-drm-next-5.13-2021-03-23' of
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=3D04%7C01%7Csunpeng.li%40amd.=
com%7C723f9131e57b4bd99db508d960be2441%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637647192045690562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Df2gL9TVAvdXl=
CbsZCDa2prF1J4l2ZDbpY8L2f6vK7as%3D&amp;reserved=3D0
> >> into drm-next")
> >> Signed-off-by: Nikola Cornij mailto:nikola.cornij@amd.com
> >> ---
> >>   .../amd/display/dc/dcn301/dcn301_resource.c   | 96 +----------------=
--
> >>   1 file changed, 1 insertion(+), 95 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> >> b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> >> index 9776d1737818..912285fdce18 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> >> @@ -1622,106 +1622,12 @@ static void
> >> dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
> >>          dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip,
> >> DML_PROJECT_DCN30);
> >>   }
> >>
> >> -static void calculate_wm_set_for_vlevel(
> >> -               int vlevel,
> >> -               struct wm_range_table_entry *table_entry,
> >> -               struct dcn_watermarks *wm_set,
> >> -               struct display_mode_lib *dml,
> >> -               display_e2e_pipe_params_st *pipes,
> >> -               int pipe_cnt)
> >> -{
> >> -       double dram_clock_change_latency_cached =3D
> >> dml->soc.dram_clock_change_latency_us;
> >> -
> >> -       ASSERT(vlevel < dml->soc.num_states);
> >> -       /* only pipe 0 is read for voltage and dcf/soc clocks */
> >> -       pipes[0].clks_cfg.voltage =3D vlevel;
> >> -       pipes[0].clks_cfg.dcfclk_mhz =3D
> >> dml->soc.clock_limits[vlevel].dcfclk_mhz;
> >> -       pipes[0].clks_cfg.socclk_mhz =3D
> >> dml->soc.clock_limits[vlevel].socclk_mhz;
> >> -
> >> -       dml->soc.dram_clock_change_latency_us =3D
> >> table_entry->pstate_latency_us;
> >> -       dml->soc.sr_exit_time_us =3D table_entry->sr_exit_time_us;
> >> -       dml->soc.sr_enter_plus_exit_time_us =3D
> >> table_entry->sr_enter_plus_exit_time_us;
> >> -
> >> -       wm_set->urgent_ns =3D get_wm_urgent(dml, pipes, pipe_cnt) * 10=
00;
> >> -       wm_set->cstate_pstate.cstate_enter_plus_exit_ns =3D
> >> get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
> >> -       wm_set->cstate_pstate.cstate_exit_ns =3D
> >> get_wm_stutter_exit(dml, pipes, pipe_cnt) * 1000;
> >> -       wm_set->cstate_pstate.pstate_change_ns =3D
> >> get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
> >> -       wm_set->pte_meta_urgent_ns =3D get_wm_memory_trip(dml, pipes,
> >> pipe_cnt) * 1000;
> >> -       wm_set->frac_urg_bw_nom =3D
> >> get_fraction_of_urgent_bandwidth(dml, pipes, pipe_cnt) * 1000;
> >> -       wm_set->frac_urg_bw_flip =3D
> >> get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000=
;
> >> -       wm_set->urgent_latency_ns =3D get_urgent_latency(dml, pipes,
> >> pipe_cnt) * 1000;
> >> -       dml->soc.dram_clock_change_latency_us =3D
> >> dram_clock_change_latency_cached;
> >> -
> >> -}
> >> -
> >> -static void dcn301_calculate_wm_and_dlg(
> >> -               struct dc *dc, struct dc_state *context,
> >> -               display_e2e_pipe_params_st *pipes,
> >> -               int pipe_cnt,
> >> -               int vlevel_req)
> >> -{
> >> -       int i, pipe_idx;
> >> -       int vlevel, vlevel_max;
> >> -       struct wm_range_table_entry *table_entry;
> >> -       struct clk_bw_params *bw_params =3D dc->clk_mgr->bw_params;
> >> -
> >> -       ASSERT(bw_params);
> >> -
> >> -       vlevel_max =3D bw_params->clk_table.num_entries - 1;
> >> -
> >> -       /* WM Set D */
> >> -       table_entry =3D &bw_params->wm_table.entries[WM_D];
> >> -       if (table_entry->wm_type =3D=3D WM_TYPE_RETRAINING)
> >> -               vlevel =3D 0;
> >> -       else
> >> -               vlevel =3D vlevel_max;
> >> -       calculate_wm_set_for_vlevel(vlevel, table_entry,
> >> &context->bw_ctx.bw.dcn.watermarks.d,
> >> -                                               &context->bw_ctx.dml,
> >> pipes, pipe_cnt);
> >> -       /* WM Set C */
> >> -       table_entry =3D &bw_params->wm_table.entries[WM_C];
> >> -       vlevel =3D min(max(vlevel_req, 2), vlevel_max);
> >> -       calculate_wm_set_for_vlevel(vlevel, table_entry,
> >> &context->bw_ctx.bw.dcn.watermarks.c,
> >> -                                               &context->bw_ctx.dml,
> >> pipes, pipe_cnt);
> >> -       /* WM Set B */
> >> -       table_entry =3D &bw_params->wm_table.entries[WM_B];
> >> -       vlevel =3D min(max(vlevel_req, 1), vlevel_max);
> >> -       calculate_wm_set_for_vlevel(vlevel, table_entry,
> >> &context->bw_ctx.bw.dcn.watermarks.b,
> >> -                                               &context->bw_ctx.dml,
> >> pipes, pipe_cnt);
> >> -
> >> -       /* WM Set A */
> >> -       table_entry =3D &bw_params->wm_table.entries[WM_A];
> >> -       vlevel =3D min(vlevel_req, vlevel_max);
> >> -       calculate_wm_set_for_vlevel(vlevel, table_entry,
> >> &context->bw_ctx.bw.dcn.watermarks.a,
> >> -                                               &context->bw_ctx.dml,
> >> pipes, pipe_cnt);
> >> -
> >> -       for (i =3D 0, pipe_idx =3D 0; i < dc->res_pool->pipe_count; i+=
+) {
> >> -               if (!context->res_ctx.pipe_ctx[i].stream)
> >> -                       continue;
> >> -
> >> -               pipes[pipe_idx].clks_cfg.dispclk_mhz =3D
> >> get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
> >> -               pipes[pipe_idx].clks_cfg.dppclk_mhz =3D
> >> get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx)=
;
> >> -
> >> -               if (dc->config.forced_clocks) {
> >> -                       pipes[pipe_idx].clks_cfg.dispclk_mhz =3D
> >> context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
> >> -                       pipes[pipe_idx].clks_cfg.dppclk_mhz =3D
> >> context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
> >> -               }
> >> -               if (dc->debug.min_disp_clk_khz >
> >> pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
> >> -                       pipes[pipe_idx].clks_cfg.dispclk_mhz =3D
> >> dc->debug.min_disp_clk_khz / 1000.0;
> >> -               if (dc->debug.min_dpp_clk_khz >
> >> pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
> >> -                       pipes[pipe_idx].clks_cfg.dppclk_mhz =3D
> >> dc->debug.min_dpp_clk_khz / 1000.0;
> >> -
> >> -               pipe_idx++;
> >> -       }
> >> -
> >> -       dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vleve=
l);
> >> -}
> >> -
> >>   static struct resource_funcs dcn301_res_pool_funcs =3D {
> >>          .destroy =3D dcn301_destroy_resource_pool,
> >>          .link_enc_create =3D dcn301_link_encoder_create,
> >>          .panel_cntl_create =3D dcn301_panel_cntl_create,
> >>          .validate_bandwidth =3D dcn30_validate_bandwidth,
> >> -       .calculate_wm_and_dlg =3D dcn301_calculate_wm_and_dlg,
> >> +       .calculate_wm_and_dlg =3D dcn30_calculate_wm_and_dlg,
> >
> > Hi Zhan,
> >
> > Using dcn30_calculate_wm_and_dlg smells fishy, IIRC watermark
> > calculations for DPUG and APU are very different. It's likely that
> > you're now picking up corrupted values form the wm_table.
> >
> > Take a look at how struct wm_table is populated in vg_clk_mgr.c v.s.
> > dcn30_clk_mgr.c. For APU, wm_table.entries are populated, whereas for
> > DGPU, wm_table.nv_entries are populated. .entries and .nv_entries are
> > under a union, with very different struct definitions.
> >
> > Have you taken a look at whether the pstate latency and sr enter/exit
> > latency values being used after your change are sensible? It could be
> > that you simply needed to raise these watermarks.
> >
> > Thanks,
> > Leo
>
> After some DMs, it looks like this change is simply restoring an
> accidental revert that occurred due to a recent rebase. Given that this
> is needed to fix a regression,
>
> Acked-by: Leo Li <sunpeng.li@amd.com>
>
> Nevertheless, this still looks iffy. I'm not sure if the pstate and sr
> enter/exit latencies being used here are what you expect.

I agree.  The original patch that fixed this looks like a bit of a hack:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D0e4c0ae59d7e
We should figure out what parameters are causing problems.

Alex

>
> Thanks,
> Leo
>
> >
> >>          .update_soc_for_wm_a =3D dcn30_update_soc_for_wm_a,
> >>          .populate_dml_pipes =3D dcn30_populate_dml_pipes_from_context=
,
> >>          .acquire_idle_pipe_for_layer =3D
> >> dcn20_acquire_idle_pipe_for_layer,
> >> --
> >> 2.31.1
> >>
