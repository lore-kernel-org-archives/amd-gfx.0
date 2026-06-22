Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A6ACDB470
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7A010E9EB;
	Tue, 23 Jun 2026 08:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdDk8HoQ";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF31A10E4EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 07:16:03 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c0c41ff84a6so247882366b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782112562; x=1782717362; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aKUdsREkXdaAnyx5VItgWz8gGsTg5KgkpGw7xwtapMs=;
 b=MdDk8HoQvQFIK6QSQO9ExK2WXobDGCFaRvpHgO3a6s8/huwMmJhIaBDDHimwuLCmJf
 C19i0Js8hrGNvWk1hlZwlIRMcwHQz8f8kMwk+8jftH+ypKUplDwQFMmE6Emi7jMP7oAu
 iimimG5Rj6uRIXWHDRgb+Twm/4iHoTWFyx3gytRrKyJolOA9C4qdQZoYUz+dyn2oXaNQ
 W7A4hR+4OVzxp8DAKFhql4aPCxjUGCGWteVp1Mw0DmIdCEMnDjv4XcfBhprPDL8NN2GH
 m4DMlQty+z9xosWCwPG+U0MQS9op4+QNzZ1BjJ2bZWNkrwNVjyqxXay5RKNK2AVIV4Vx
 5X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782112562; x=1782717362;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aKUdsREkXdaAnyx5VItgWz8gGsTg5KgkpGw7xwtapMs=;
 b=os4ndXLU0TAXfX2a5Q7aZt7aqEVqoCwOfQh3RRcWAtpT8+j1KnUEr6UhDAB1xUEUM3
 PG6QhmyZjpD/PDXFrJEscNyD75suWZgIcEUQcj1HYjwv1Gi2weim+lNONz8rbW3qqoIZ
 0kTJH5w1CRy0hpq3W73Tsxuw9zb4m+CFLEk/6nTENTRcnNnRIlACWOkA1+8gp+oALCrt
 PtezxVmdRYlsQ55C9PS2FQMfttWXeh3S5elYV8Vy4Lg/yTZBQoetM8nsWkGS8uEp/+dY
 oEMfGMjxbGEosT9fWY6+ZXIXagfu/50f/eNpaotyN7/7bMO60OdOtn49JZhLOcTbXYiV
 zgrA==
X-Gm-Message-State: AOJu0YzGVCfqpOLdk8lCPmMdR+7I5SP82plHbdPJM4G4+Ybt4yvf0j+V
 e27+43F+d8gmYb+M6VEmIPIW9TO75hD8ygr8TLh65fZ1lQXgDAvOZjsEo11ZftqX
X-Gm-Gg: AfdE7cnhxZzpUrAie88gUzdLVEGizlQTbHpqfdt3YZ3xOadhJaUsDCfh8nYfQz6P66S
 XEuNLNgeSRl5/HAgOfnuhtVW4BCungtO4Di3r+ZTP0UrW076PRAKueMzQhL+z5+EzFWpG5JBJjl
 Pb3C39VLiCszIMqe1y3gLHcsAbZQNxSDs4ck0ZA29agY1hXCgdg13I+0fHVqsrdWdlBhmbo/f9D
 5uY5K79yzZvFZSjm0cz1xerFHGiFhq5dEOs+zOU1UWx6camhyy9eW3f/darL4RJEk8KVJeBsr2X
 W0Gvc+8isiTveBwDXVB5jYMptFKzbFKDI72NiJDP6pvdEgqYTzmhEqBY4Ky0CATnVe215znDQhy
 JW7b0V07irEJJC83NdkYiGwCvBfctT7UfR0a8Cbrf89OJ7k/2qenMqPTeySzPWDjG7QrD7ENMVH
 zts4KSYfNJ
X-Received: by 2002:a17:907:e153:b0:c0d:cd71:6463 with SMTP id
 a640c23a62f3a-c0dcd716a55mr107647466b.16.1782112561786; 
 Mon, 22 Jun 2026 00:16:01 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c60aca46csm304463266b.36.2026.06.22.00.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 00:16:00 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:15:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Extract connector and encoder code to
 amdgpu_dm_connector
Message-ID: <ajjhLdbRJz30TXo2@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:07:15 +0000
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

Hello Alex Hung,

Commit 0e967e086e75 ("drm/amd/display: Extract connector and encoder
code to amdgpu_dm_connector") from Apr 27, 2026, leads to the
following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_connector.c:1278 apply_dsc_policy_for_stream()
    warn: variable dereferenced before check 'aconnector->dc_link' (see line 1221)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_connector.c
  1220		link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
                                                             ^^^^^^^^^^^^^^^^^^^
Unchecked dereference

  1221								dc_link_get_link_cap(aconnector->dc_link));
  1222	
  1223		/* Set DSC policy according to dsc_clock_en */
  1224		dc_dsc_policy_set_enable_dsc_when_not_needed(
  1225			aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
  1226	
  1227		if (sink->sink_signal == SIGNAL_TYPE_EDP &&
  1228		    !aconnector->dc_link->panel_config.dsc.disable_dsc_edp &&

Lots of unchecked dereferefences really...

  1229		    dc->caps.edp_dsc_support && aconnector->dsc_settings.dsc_force_enable != DSC_CLK_FORCE_DISABLE) {
  1230	
  1231			apply_dsc_policy_for_edp(aconnector, sink, stream, dsc_caps, max_dsc_target_bpp_limit_override);
  1232	
  1233		} else if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
  1234			if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
  1235				if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
  1236							dsc_caps,
  1237							&dsc_options,
  1238							link_bandwidth_kbps,
  1239							&stream->timing,
  1240							dc_link_get_highest_encoding_format(aconnector->dc_link),
  1241							&stream->timing.dsc_cfg)) {
  1242					stream->timing.flags.DSC = 1;
  1243					drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from SST RX\n",
  1244								__func__, drm_connector->name);
  1245				}
  1246			} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
  1247				timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing,
  1248						dc_link_get_highest_encoding_format(aconnector->dc_link));
  1249				converter_bw_in_kbps = aconnector->dc_link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps;
  1250				sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, sink->edid_caps.max_frl_rate);
  1251				dsc_sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, sink->edid_caps.frl_dsc_max_frl_rate);
  1252	
  1253				if (dsc_caps->is_frl) {
  1254					max_supported_bw_in_kbps = min(link_bandwidth_kbps, converter_bw_in_kbps);
  1255					max_supported_bw_in_kbps = min(max_supported_bw_in_kbps, sink_bw_in_kbps);
  1256					dsc_max_supported_bw_in_kbps = min(max_supported_bw_in_kbps, dsc_sink_bw_in_kbps);
  1257				} else {
  1258					max_supported_bw_in_kbps = link_bandwidth_kbps;
  1259					dsc_max_supported_bw_in_kbps = link_bandwidth_kbps;
  1260				}
  1261	
  1262				if (timing_bw_in_kbps > max_supported_bw_in_kbps &&
  1263						max_supported_bw_in_kbps > 0 &&
  1264						dsc_max_supported_bw_in_kbps > 0)
  1265					if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
  1266							dsc_caps,
  1267							&dsc_options,
  1268							dsc_max_supported_bw_in_kbps,
  1269							&stream->timing,
  1270							dc_link_get_highest_encoding_format(aconnector->dc_link),
  1271							&stream->timing.dsc_cfg)) {
  1272						stream->timing.flags.DSC = 1;
  1273						drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from %s\n",
  1274								__func__, drm_connector->name,
  1275								(dsc_caps->is_frl == 1) ? "HDMI FRL RX" : "DP-HDMI PCON");
  1276					}
  1277			}
  1278		} else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL) {
                           ^^^^^^^^^^^^^^^^^^^
Checked too late.

  1279			struct dc_dsc_policy dsc_policy = {0};
  1280	

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
