Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197B4CD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 07:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E34E112208;
	Mon,  8 Apr 2024 07:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oHZcElYA";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223B810E40E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Apr 2024 10:10:30 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-a51a7dc45easo45561966b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Apr 2024 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712311828; x=1712916628; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QU9LnCPWYh2xuGVLRR4ne74RkYhzfXjHlDjtOg5ZemI=;
 b=oHZcElYAlKTqIGq1KzcYZKqV8TeJ2ZNtYZ7ruEPwLNZ/08nRIVv9tNfvTa1Hi4amjP
 OVzyaScYcXlRr8F02rZA0acmfa4g0phYYC1E+1w7tQwq71J7yPiO38EHlnHEOHrXpklm
 33fgbTJHeWAecIrl1NAd+sghdmBPc1UCNfiibE6yokXwl1pr7ImGY75J3Fe3p9eqUs4f
 F/XIytVhf1op5Gij3Kek6EZL6qRl42zLLuUdJY6KpfB7xIUjtN2+ps9i1jToveYEZBoN
 Da3foBT87T0aJ1JZbW81y3m5w+b6LVVNcwYGJ1gkMFbt7jbPVFtj6mGj/NQjeZvjxvr+
 y+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712311828; x=1712916628;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QU9LnCPWYh2xuGVLRR4ne74RkYhzfXjHlDjtOg5ZemI=;
 b=GvRqhL3CznJaBozITuHQ7+BmKH+ehD1gMUHoDLi6xN5bTzDH243slkRP9pJIqRC8Db
 JfW97OKyaLGS7vjKq7klEYDfGVZEH5Oa0EoQh7tk7cSx5nyS2J6PydC+9s6McHcEUjN8
 4sUJ/Grxl9RqcDPw43A71FPpwdREzmcFNzjLsWKQxOtZHR4J9YzPXUZvS0dTRI93UFs7
 jHbz26YuKvuUXJWlFE29exowhu9yOXOX2Q3LTvA1r/UFO4vh4cKB44HuWR7aSnXMdiSP
 5C70jbYuOIlNZsi3pmSE08zpQtnjtEc74890RQXuCAHcfvUFcx1ukIv4rEU5nw4nuFZf
 au0A==
X-Gm-Message-State: AOJu0YzLBBR9Rm8mS77xaghsMIK1RWhjsFUOUuKs/2mgQs9pQK/4Mf0U
 UzMeqFVM1PrPCNnB5MYMWBF+jedboMqq/sNH1OS8RqtiNTEQK780YLxKsEoy/ZM=
X-Google-Smtp-Source: AGHT+IH8wFxmGGesWwz1GeRY4BnEJ/OBCQapXdo9t/G/kf38IMXqsefsXhvMwi+KVQpZ3nEWYVCu5A==
X-Received: by 2002:a17:906:2789:b0:a51:9868:5ed5 with SMTP id
 j9-20020a170906278900b00a5198685ed5mr765221ejc.21.1712311828204; 
 Fri, 05 Apr 2024 03:10:28 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 bj1-20020a170906b04100b00a449026672esm661276ejb.81.2024.04.05.03.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:10:27 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:10:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: alvin.lee2@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/display: Remove plane and stream pointers from
 dc scratch
Message-ID: <0689f985-71a3-4497-a9cc-9b2ce2f074d4@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 08 Apr 2024 07:46:23 +0000
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

Hello Alvin Lee,

Commit 285a7054bf81 ("drm/amd/display: Remove plane and stream
pointers from dc scratch") from Mar 15, 2024 (linux-next), leads to
the following Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:1112 dcn20_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1839 dcn10_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:301 dce110_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c
    1094 bool dcn20_set_input_transfer_func(struct dc *dc,
    1095                                 struct pipe_ctx *pipe_ctx,
    1096                                 const struct dc_plane_state *plane_state)
    1097 {
    1098         struct dce_hwseq *hws = dc->hwseq;
    1099         struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
    1100         const struct dc_transfer_func *tf = NULL;
                                                ^^^^^^^^^
This assignment is not necessary now.

    1101         bool result = true;
    1102         bool use_degamma_ram = false;
    1103 
    1104         if (dpp_base == NULL || plane_state == NULL)
    1105                 return false;
    1106 
    1107         hws->funcs.set_shaper_3dlut(pipe_ctx, plane_state);
    1108         hws->funcs.set_blend_lut(pipe_ctx, plane_state);
    1109 
    1110         tf = &plane_state->in_transfer_func;
                 ^^^^^
Before there was an if statement but now tf is assigned unconditionally

    1111 
--> 1112         if (tf == NULL) {
                 ^^^^^^^^^^^^^^^^^
so these conditions are impossible.

    1113                 dpp_base->funcs->dpp_set_degamma(dpp_base,
    1114                                 IPP_DEGAMMA_MODE_BYPASS);
    1115                 return true;
    1116         }
    1117 
    1118         if (tf->type == TF_TYPE_HWPWL || tf->type == TF_TYPE_DISTRIBUTED_POINTS)
    1119                 use_degamma_ram = true;
    1120 
    1121         if (use_degamma_ram == true) {
    1122                 if (tf->type == TF_TYPE_HWPWL)
    1123                         dpp_base->funcs->dpp_program_degamma_pwl(dpp_base,

regards,
dan carpenter
