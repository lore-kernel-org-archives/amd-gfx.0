Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC8DCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 13:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B5E10E5B9;
	Fri, 20 Oct 2023 13:58:57 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B3B10E0E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 13:54:10 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso605308f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697810049; x=1698414849; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vaxQKyBIIqPqw4ZLaGsJttia3ebEsf2c6Qv9i1pJuD4=;
 b=puXnLFJC1Whgct3fQKFLo4q613NeLGKm3AuNr0BnDy8zWmExp3VgQqdK1mOkNUVpkb
 +FA0ohW2pvZVrNzz3+TH4QcxtRIa0mCKE9fDCzQt5TvK0BiCtd9x3EgdH36sLkZwvotO
 v7CWlJr9nR/oRlFGUvezrTyNk6HwEVL3K0zswrJjxhOyY8Ki7Ijg38CVPrT7dHcp6W7s
 QpDtZLisiOid69Xc1e+kTx2s9LU36r7CDIHIpynkjcedrBl2LpOgAMJUhGRV5aUkbjIs
 dHRpisE2eMRBcfwp5K7LNNdd0F4hLJIkUdAT0ee7xIq5pgFO2EkuTbIW2GDMG8pt6+D8
 KJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697810049; x=1698414849;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vaxQKyBIIqPqw4ZLaGsJttia3ebEsf2c6Qv9i1pJuD4=;
 b=nqDrBiaAlEOuLY5W9liAo4UESf51ZGvyMIa5kAXqWgIJVVf9xnICCRAEkx0xqHNsw2
 buiqQ7Ppvr0Jwen/vC3yX9bdJgRUFY8RIuIoVW5exnNHVHzc2jNd2kmrzeROlUgaSrc9
 Gq/IeopVtnPAmuIC1vG98k9zUgbNhgZSIKF0cSFcicf0k6AL691J7GTtmhTgnz2aNoKI
 VHDCa9Oxy2oUi0A80c8GESgeGv27OROylvhd9plDqy8ACNGZv9UessJAkAGj0kVuVP6/
 lS+xssCuZ+jlgF2qm53tIxyMeE4ksiPV/tXmMK+62fJB3Xg/AP93KfvGioF5sE/vzwNw
 sZVw==
X-Gm-Message-State: AOJu0Yy85pvQWo+HXle4QShOfmEj9XAqAsZAYDYOauICQjySQwfBrpHw
 oyCuqnUD/rZkg0RbwRYC+BYxhSmXr3BYATNIC9Q=
X-Google-Smtp-Source: AGHT+IEEtOZBrzqw15i/Fk3l2uBP2Xef23poD55mjgCPdAfykh4YBFKECujRA7trBMnZDwLsAipMEQ==
X-Received: by 2002:adf:f091:0:b0:32d:aabf:1db3 with SMTP id
 n17-20020adff091000000b0032daabf1db3mr1794189wro.24.1697810049346; 
 Fri, 20 Oct 2023 06:54:09 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 p17-20020a5d68d1000000b0032d687fd9d0sm1755769wrw.19.2023.10.20.06.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 06:54:08 -0700 (PDT)
Date: Fri, 20 Oct 2023 16:54:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingqing.Zhuo@amd.com
Subject: [bug report] drm/amd/display: Introduce DML2
Message-ID: <cd6292d4-ae5c-4c30-b253-0fdae835269b@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 20 Oct 2023 13:58:55 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Qingqing Zhuo,

The patch 7966f319c66d: "drm/amd/display: Introduce DML2" from Jul
28, 2023 (linux-next), leads to the following Smatch static checker
warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:77 map_hw_resources()
error: buffer overflow 'dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id' 6 <= 7

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:79 map_hw_resources()
error: buffer overflow 'dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id' 6 <= 7

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c
    59 static void map_hw_resources(struct dml2_context *dml2,
    60                 struct dml_display_cfg_st *in_out_display_cfg, struct dml_mode_support_info_st *mode_support_info)
    61 {
    62         unsigned int num_pipes = 0;
    63         int i, j;
    64 
    65         for (i = 0; i < __DML_NUM_PLANES__; i++) {
                               ^^^^^^^^^^^^^^^^^^

__DML_NUM_PLANES__ is 8.  This loops 0-7.

    66                 in_out_display_cfg->hw.ODMMode[i] = mode_support_info->ODMMode[i];
    67                 in_out_display_cfg->hw.DPPPerSurface[i] = mode_support_info->DPPPerSurface[i];
    68                 in_out_display_cfg->hw.DSCEnabled[i] = mode_support_info->DSCEnabled[i];
    69                 in_out_display_cfg->hw.NumberOfDSCSlices[i] = mode_support_info->NumberOfDSCSlices[i];
    70                 in_out_display_cfg->hw.DLGRefClkFreqMHz = 24;
    71                 if (dml2->v20.dml_core_ctx.project != dml_project_dcn35 &&
    72                         dml2->v20.dml_core_ctx.project != dml_project_dcn351) {
    73                         /*dGPU default as 50Mhz*/
    74                         in_out_display_cfg->hw.DLGRefClkFreqMHz = 50;
    75                 }
    76                 for (j = 0; j < mode_support_info->DPPPerSurface[i]; j++) {
--> 77                         dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_stream_id[i];

Both of these arrays have 6 elements.

    78                         dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[num_pipes] = true;
    79                         dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[num_pipes] = dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[i];
    80                         dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id_valid[num_pipes] = true;
    81                         num_pipes++;
    82                 }
    83         }
    84 }

regards,
dan carpenter
