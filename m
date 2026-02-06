Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE730EE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 773E210E7E2;
	Fri,  6 Feb 2026 14:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ER8p4j0P";
	dkim-atps=neutral
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7107410E74F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:39:25 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so13633775e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 05:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770385164; x=1770989964; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BuQje3pA3puYqE5cqm2DgR3QniDFMdzkaAWaIa9THpo=;
 b=ER8p4j0P3QTem91Fdquhgcr8qLVaoFqoEaaLg92yeZOMtv/NOXJOL9DOQc/GtjRusa
 5v0rASlYPy1LV4ERLdEGnKA0FJn+R8ySmiV0BZ1qalUKyosacqP5R01QuvRHyCC+YesA
 gpqtYhIV+bYWsLl17dxkbd7SgkaPaAmdh9p0vKMHD36AxLWP1j9JJq4TYVv0bk9NId0o
 Kg3LR2albUEsGLT1pOAhwDhU/lzeST17ecA3efT3s9PD2NM1o8NymriCUOdkqBpEqiut
 Vd2dBQplzknjodkJr/F366fUrJfb6Z15/eciS503EhIh8IfYITpKgrC7QxsFMs6z1mcp
 5I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385164; x=1770989964;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuQje3pA3puYqE5cqm2DgR3QniDFMdzkaAWaIa9THpo=;
 b=OAiseS+jBZdTzSAg+Kj3JnXrP8KDKspYK59g84DSsDs2qA9vAKBoW0Dr7K0Ef+YVGZ
 5MTV/T0nLJ1C6cyUzRRmMNAzrxXFj3GuDGlOecW9CRsmYMM2PJTZqKqH1fVTyugtVs5Q
 pZWuqu2v1qWOR86aMAkJ05zzAQuMmhZCcc7qSfOcDlvhXrCv15eZx4kb15qp+ZJOPZSQ
 l3sLTYtGRbVymAC57BSMfqCHNjzMEQuc7jlq/A+IjoMz7yWpWa3aPc2/acFoQ683fUZH
 lNyrBRw1vlSH1ALDUNDfELzaSF7YXMZHMglzOn5nboOxcjJfWRy0ogpGRLlWTCknNU8d
 NLTA==
X-Gm-Message-State: AOJu0YwMFiQ5vqpxbc3RW4JzY5ei9Gvke2+3c82P8UjuM52Efiz0di6L
 tTFiSVzIxBi4HvrExrqZAqnE2sU9O8x89WifqaZv7TppNFW+wec1dzx8BI4OgX1JZDE=
X-Gm-Gg: AZuq6aI71UpG1eQWkYbu270HfHA2cHF3orfR/xsNez0GXOqqhEf1yqJx5pHP/PbydHb
 iE/T4WTBckvjbuQs0d3pM9+uTEDLaSPEfs8MvJJgEEV+zdl3wdsbQ+bzsPH0tCX7hXZ5LS2yigE
 c6nFtzAZS9i2c8kz+Stj43cJARtEDa6T29YNRfvFWFAvN5WfDDvwzXHWG2d02Y/TxWCw5GT9Lgk
 /m83SJmhh5neI/tR4sK8BBNPtH7h6n2QNChAD88xyGkhVXR2tmdGvUfuMKqMOd++8bOYpho4yV6
 QhVqSiGz++CGK9X1W7D1xnrLgst0Aqzh1hfW2FAgEUb2+nUEf2r38xOqn2SBl24Qu0lFZHfytol
 l27FyAREN4DkbatbgJgxqG5/uE2QWzJACEU0cATtcOTwm3rXOy/en9ef0Xhg4GCRcH9pKTN89oN
 IO5jM68U23HRXlIso9
X-Received: by 2002:a05:600c:8719:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-4832021b461mr45585285e9.17.1770385163857; 
 Fri, 06 Feb 2026 05:39:23 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206b8bbbsm81414275e9.3.2026.02.06.05.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 05:39:23 -0800 (PST)
Date: Fri, 6 Feb 2026 16:39:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] drm/amd/display: add DC changes for DCN351
Message-ID: <aYXvCFo5X2l73tyZ@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Mailman-Approved-At: Fri, 06 Feb 2026 14:22:59 +0000
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

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Hamza Mahfooz,

Commit 2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
from Feb 23, 2024 (linux-next), leads to the following Smatch static
checker warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn351/dcn351_resource.c:1284 dcn35_stream_encoder_create() index hardmax out of bounds 'stream_enc_regs[eng_id]' size=5 max='5' rl='s32min-5'
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn36/dcn36_resource.c:1285 dcn35_stream_encoder_create() index hardmax out of bounds 'stream_enc_regs[eng_id]' size=5 max='5' rl='s32min-5'
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn321/dcn321_resource.c:1222 dcn321_stream_encoder_create() index hardmax out of bounds 'stream_enc_regs[eng_id]' size=5 max='5' rl='s32min-5'
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn315/dcn315_resource.c:1252 dcn315_stream_encoder_create() index hardmax out of bounds 'stream_enc_regs[eng_id]' size=5 max='5' rl='s32min-5'
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn35/dcn35_resource.c:1304 dcn35_stream_encoder_create() index hardmax out of bounds 'stream_enc_regs[eng_id]' size=5 max='5' rl='s32min-5'
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:1241 dcn32_stream_encoder_create() index hardmax out of bounds 'stream_enc_regs[eng_id]' size=5 max='5' rl='s32min-5'
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn316/dcn316_resource.c:1245 dcn316_stream_encoder_create() index hardmax out of bounds 'stream_enc_regs[eng_id]' size=5 max='5' rl='s32min-5'

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn351/dcn351_resource.c
    1246 static struct stream_encoder *dcn35_stream_encoder_create(
    1247         enum engine_id eng_id,
    1248         struct dc_context *ctx)
    1249 {
    1250         struct dcn10_stream_encoder *enc1;
    1251         struct vpg *vpg;
    1252         struct afmt *afmt;
    1253         int vpg_inst;
    1254         int afmt_inst;
    1255 
    1256         /* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
    1257         if (eng_id <= ENGINE_ID_DIGF) {

ENGINE_ID_DIGF is 5.  should <= be <?

Unrelated but, ugh, why is Smatch saying that "eng_id" can be negative?
end_id is type signed long, but there are checks in the caller which
prevent it from being negative.

    1258                 vpg_inst = eng_id;
    1259                 afmt_inst = eng_id;
    1260         } else
    1261                 return NULL;
    1262 
    1263         enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
    1264         vpg = dcn31_vpg_create(ctx, vpg_inst);
    1265         afmt = dcn31_afmt_create(ctx, afmt_inst);
    1266 
    1267         if (!enc1 || !vpg || !afmt) {
    1268                 kfree(enc1);
    1269                 kfree(vpg);
    1270                 kfree(afmt);
    1271                 return NULL;
    1272         }
    1273 
    1274 #undef REG_STRUCT
    1275 #define REG_STRUCT stream_enc_regs
    1276         stream_enc_regs_init(0),
    1277         stream_enc_regs_init(1),
    1278         stream_enc_regs_init(2),
    1279         stream_enc_regs_init(3),
    1280         stream_enc_regs_init(4);
    1281 
    1282         dcn35_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
    1283                                         eng_id, vpg, afmt,
--> 1284                                         &stream_enc_regs[eng_id],
                                                  ^^^^^^^^^^^^^^^^^^^^^^^
This stream_enc_regs[] array has 5 elements so we are one element
beyond the end of the array.

    1285                                         &se_shift, &se_mask);
    1286 
    1287         return &enc1->base;
    1288 }

regards,
dan carpenter
