Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AB9C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 13:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2719620663
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 13:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKaUOsmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2719620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AD86E8E1;
	Fri,  5 Jun 2020 13:28:23 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78556E8E1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 13:28:22 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055DR8iK062767;
 Fri, 5 Jun 2020 13:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Mn/V2oygL6H+go8dtN6XmHxlx94eSAbhhS7/ouCJ5uI=;
 b=gKaUOsmU/5UEyCqTu6YIYxY50KarLH1FGVviJW8S3Aw2v7+cqZ1F7CuuzG/FbWGEJBmQ
 Rlfgx9lF/TZlIJsqdRg1rkvQu5i057acflLEMPaOOkJBPWGgP3GmYjk3/lNRm7Vb/A+f
 dkHNFmZ+fli2PsAneft+9J8l6uebjLrdugznmYI5dnNbZe5MgJgMKNzkDYRALYSVvFXT
 qsWvzcPQHEqcmscP9Lbuwf/M7jR4rZ2mXffe1PZ9Idts3uX0nluqgSoYnTn9rZ6VXaIO
 0rBVIKqP3VqpbHGjMVb7Kvk9A5iVepGqJ55JFCJuJVqFBlM/z8Esd1zlXEGcDTecpYzw yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 31f91dtve0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 05 Jun 2020 13:28:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055DS74s123503;
 Fri, 5 Jun 2020 13:28:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 31f927jtbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Jun 2020 13:28:19 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 055DSJ31000670;
 Fri, 5 Jun 2020 13:28:19 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 05 Jun 2020 06:28:18 -0700
Date: Fri, 5 Jun 2020 16:28:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bhawanpreet.Lakha@amd.com
Subject: [bug report] drm/amd/display: Add DCN3 HWSEQ
Message-ID: <20200605132813.GB996387@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=816 bulkscore=0
 suspectscore=3 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=3 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=851 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050101
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Bhawanpreet Lakha,

This is a semi-automatic email about new static checker warnings.

The patch 581b9589487e: "drm/amd/display: Add DCN3 HWSEQ" from May
21, 2020, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:618 dcn30_init_hw()
    error: we previously assumed 'dc->clk_mgr' could be null (see line 433)

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c
   432	
   433		if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
                    ^^^^^^^^^^^
This code assumes ->clk_mgr can be NULL.

   434			dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
   435	
   436		// Initialize the dccg
   437		if (res_pool->dccg->funcs->dccg_init)
   438			res_pool->dccg->funcs->dccg_init(res_pool->dccg);
   439	
   440		//Enable ability to power gate / don't force power on permanently
   441		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
   442	
   443		if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
   444			REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
   445			REG_WRITE(RBBMIF_TIMEOUT_DIS_2, 0xFFFFFFFF);
   446	
   447			hws->funcs.dccg_init(hws);
   448	
   449			REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 2);
   450			REG_UPDATE(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
   451			REG_WRITE(REFCLK_CNTL, 0);
   452		} else {
   453			if (!dcb->funcs->is_accelerated_mode(dcb)) {
   454				hws->funcs.bios_golden_init(dc);
   455				hws->funcs.disable_vga(dc->hwseq);
   456			}
   457	
   458			if (dc->ctx->dc_bios->fw_info_valid) {
   459				res_pool->ref_clocks.xtalin_clock_inKhz =
   460						dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
   461	
   462				if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
   463					if (res_pool->dccg && res_pool->hubbub) {
   464	
   465						(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
   466								dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
   467								&res_pool->ref_clocks.dccg_ref_clock_inKhz);
   468	
   469						(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
   470								res_pool->ref_clocks.dccg_ref_clock_inKhz,
   471								&res_pool->ref_clocks.dchub_ref_clock_inKhz);
   472					} else {
   473						// Not all ASICs have DCCG sw component
   474						res_pool->ref_clocks.dccg_ref_clock_inKhz =
   475								res_pool->ref_clocks.xtalin_clock_inKhz;
   476						res_pool->ref_clocks.dchub_ref_clock_inKhz =
   477								res_pool->ref_clocks.xtalin_clock_inKhz;
   478					}
   479				}
   480			} else
   481				ASSERT_CRITICAL(false);
   482	
   483			for (i = 0; i < dc->link_count; i++) {
   484				/* Power up AND update implementation according to the
   485				 * required signal (which may be different from the
   486				 * default signal on connector).
   487				 */
   488				struct dc_link *link = dc->links[i];
   489	
   490				link->link_enc->funcs->hw_init(link->link_enc);
   491			}
   492		}
   493	
   494		/* Power gate DSCs */
   495		for (i = 0; i < res_pool->res_cap->num_dsc; i++)
   496			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
   497	
   498		/* Blank pixel data with OPP DPG */
   499		for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
   500			struct timing_generator *tg = dc->res_pool->timing_generators[i];
   501	
   502			if (tg->funcs->is_tg_enabled(tg))
   503				hws->funcs.init_blank(dc, tg);
   504		}
   505	
   506		for (i = 0; i < res_pool->timing_generator_count; i++) {
   507			struct timing_generator *tg = dc->res_pool->timing_generators[i];
   508	
   509			if (tg->funcs->is_tg_enabled(tg))
   510				tg->funcs->lock(tg);
   511		}
   512	
   513		for (i = 0; i < dc->res_pool->pipe_count; i++) {
   514			struct dpp *dpp = res_pool->dpps[i];
   515	
   516			dpp->funcs->dpp_reset(dpp);
   517		}
   518	
   519		/* Reset all MPCC muxes */
   520		res_pool->mpc->funcs->mpc_init(res_pool->mpc);
   521	
   522		/* initialize OPP mpc_tree parameter */
   523		for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
   524			res_pool->opps[i]->mpc_tree_params.opp_id = res_pool->opps[i]->inst;
   525			res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
   526			for (j = 0; j < MAX_PIPES; j++)
   527				res_pool->opps[i]->mpcc_disconnect_pending[j] = false;
   528		}
   529	
   530		for (i = 0; i < dc->res_pool->pipe_count; i++) {
   531			struct timing_generator *tg = dc->res_pool->timing_generators[i];
   532			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
   533			struct hubp *hubp = dc->res_pool->hubps[i];
   534			struct dpp *dpp = dc->res_pool->dpps[i];
   535	
   536			pipe_ctx->stream_res.tg = tg;
   537			pipe_ctx->pipe_idx = i;
   538	
   539			pipe_ctx->plane_res.hubp = hubp;
   540			pipe_ctx->plane_res.dpp = dpp;
   541			pipe_ctx->plane_res.mpcc_inst = dpp->inst;
   542			hubp->mpcc_id = dpp->inst;
   543			hubp->opp_id = OPP_ID_INVALID;
   544			hubp->power_gated = false;
   545			pipe_ctx->stream_res.opp = NULL;
   546	
   547			hubp->funcs->hubp_init(hubp);
   548	
   549			//dc->res_pool->opps[i]->mpc_tree_params.opp_id = dc->res_pool->opps[i]->inst;
   550			//dc->res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
   551			dc->res_pool->opps[i]->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
   552			pipe_ctx->stream_res.opp = dc->res_pool->opps[i];
   553			/*to do*/
   554			hws->funcs.plane_atomic_disconnect(dc, pipe_ctx);
   555		}
   556	
   557		/* initialize DWB pointer to MCIF_WB */
   558		for (i = 0; i < res_pool->res_cap->num_dwb; i++)
   559			res_pool->dwbc[i]->mcif = res_pool->mcif_wb[i];
   560	
   561		for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
   562			struct timing_generator *tg = dc->res_pool->timing_generators[i];
   563	
   564			if (tg->funcs->is_tg_enabled(tg))
   565				tg->funcs->unlock(tg);
   566		}
   567	
   568		for (i = 0; i < dc->res_pool->pipe_count; i++) {
   569			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
   570	
   571			dc->hwss.disable_plane(dc, pipe_ctx);
   572	
   573			pipe_ctx->stream_res.tg = NULL;
   574			pipe_ctx->plane_res.hubp = NULL;
   575		}
   576	
   577		for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
   578			struct timing_generator *tg = dc->res_pool->timing_generators[i];
   579	
   580			tg->funcs->tg_init(tg);
   581		}
   582	
   583		/* end of FPGA. Below if real ASIC */
   584		if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
   585			return;
   586	
   587	
   588		for (i = 0; i < res_pool->audio_count; i++) {
   589			struct audio *audio = res_pool->audios[i];
   590	
   591			audio->funcs->hw_init(audio);
   592		}
   593	
   594		for (i = 0; i < dc->link_count; i++) {
   595			struct dc_link *link = dc->links[i];
   596	
   597			if (link->panel_cntl)
   598				backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
   599		}
   600	
   601		for (i = 0; i < dc->res_pool->pipe_count; i++) {
   602			if (abms[i] != NULL)
   603				abms[i]->funcs->abm_init(abms[i], backlight);
   604		}
   605	
   606		/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
   607		REG_WRITE(DIO_MEM_PWR_CTRL, 0);
   608	
   609		if (!dc->debug.disable_clock_gate) {
   610			/* enable all DCN clock gating */
   611			REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
   612	
   613			REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
   614	
   615			REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
   616		}
   617	
   618		if (dc->clk_mgr->funcs->notify_wm_ranges)
                    ^^^^^^^^^^^
This code dereferences it without checking for NULL.

   619			dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
   620	

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
