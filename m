Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBD1CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 10:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9DE10E6E4;
	Wed, 13 Aug 2025 10:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VBmPJVAC";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F6410E3DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 05:48:47 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b913a76ba9so1204719f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 22:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755064126; x=1755668926; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G7GKmP7EYKimenKpnrcCAAQuhMM8aTrwuNcaLiW1X80=;
 b=VBmPJVACu7sY9tgTXLGiAqfBZ3re0Sw/TYy3HFm12C9ilOy76zHW6FGCISg2JMvxxb
 95Qmp/F2oIwfw7gCTjHw0D6HocxhcGGO5x1mnxiSkFEn8910W8xAc81OkY8ktBt2nsEn
 SOHqW/LZDpa1zSzQ8BHBBiqAKrmg339hZPGdvN9f/xPduCI8l4Ym9+7BJIWijp+iIE9A
 GziIZ80OXGIFEpBHgg+PAq3DOGbbaIfjaUbFtE6oC+RPmjodUeV5OZV24RyskCqfaOaQ
 YAmsDsEjv4kOvXKYuy5LiDgRDXW+aIYFoZXq0/qSu6LoaB/3h1RmZFsEF/9Zhw44z/jI
 mwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755064126; x=1755668926;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G7GKmP7EYKimenKpnrcCAAQuhMM8aTrwuNcaLiW1X80=;
 b=fKoh3FcYEYzDCeh6cMFwRG6kXt8L00zomRrw54/i51qAdyDhnKUHxguQbqz/p2rnMr
 A4v/QBJcPPkdcx+2ilSFozpKSZcXkOM+Di3uUvyxpNHwvmJnnAJ0s9QBn4+4hV6EJ6oi
 1QD6sHSh7sa+4bsmDRAp+U2ekFx8wooFHhyUY8GqbZRnOJZsJU2loHHJtQ2lFptGNxA9
 81rXFk0+9b671Fm5HY9bUUD5Nm96AnnDPRj/zoprtVXBryvNfy3S2m5zoySfokF2lkUd
 /Xdck9TSQ7K2aEpveydtJzlW76BONUEr3DW47swPFqAYTwtQPSZobh3kz2QwFSrrB3vk
 c5Zw==
X-Gm-Message-State: AOJu0YwVhkGamRhN6HULzufbdtNsv+3PFQyUk0HszxijCjwjwcAlpHAY
 SxTkQ12SfYZX1KmaVGTYaHXAf0/lJKW6s3MN7o67qDvQMPI68qwl1kHpErJyi694fiY=
X-Gm-Gg: ASbGncsa+qv4oYv2M9xYZc3PsLHgT15rbDctDJiTmZ3ZY/DwWlukL0ZvC8xIh6qjVNs
 TYWFKBi+PYM2pLblo4lsqQyTQkDWnt/3FeU1cDMMeYNFrh58KQzm3glulNf4YOXXuL3lbonD+mu
 iMd5L2DekVL63WfO7KKFChJxvhoAGk+HNHgY8//QZPvotzk8grjpuiGlCwVu62Nk2xChzdTmJm3
 +UCCNqXoIpU+kYjKgiKkZypo32ze/TaMqHD6R5V9yXSxSUe5eLgqIrxHphtl8qdcOd+cIc0oz5C
 XjNkUL234APBQXqEdInImFPi67Zjqb+E30GmkOOr3Tis3tBsWAber/aO8UF1H9qK0Wa6MrAx1k8
 dHYrgbKZG9xfYALkQ32auHfJ/pNMghXk/0EYcVXQUVFs=
X-Google-Smtp-Source: AGHT+IFTCsP1mdmHIwa28LIx57Nx/T/u8kF0GfWBroSeYqSPtHxLbhX1Az2AT/hjARaCGOX/OjlTAA==
X-Received: by 2002:a05:6000:2381:b0:3b6:8acb:a9d2 with SMTP id
 ffacd0b85a97d-3b917d2a0a7mr1074871f8f.7.1755064126178; 
 Tue, 12 Aug 2025 22:48:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3b79c3abec8sm48404308f8f.8.2025.08.12.22.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 22:48:45 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:38:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dillon Varone <dillon.varone@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Refactor SubVP cursor limiting logic
Message-ID: <aJwk6e5nzvod7WFT@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 13 Aug 2025 10:15:14 +0000
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

Hello Dillon Varone,

Commit 4465dd0e41e8 ("drm/amd/display: Refactor SubVP cursor limiting
logic") from Apr 1, 2025 (linux-next), leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:336 dc_stream_program_cursor_attributes()
	error: we previously assumed 'stream' could be null (see line 334)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c
    327 bool dc_stream_program_cursor_attributes(
    328         struct dc_stream_state *stream,
    329         const struct dc_cursor_attributes *attributes)
    330 {
    331         struct dc  *dc;
    332         bool reset_idle_optimizations = false;
    333 
    334         dc = stream ? stream->ctx->dc : NULL;
                     ^^^^^^
The old code assumed stream could be NULL.

    335 
--> 336         if (dc_stream_set_cursor_attributes(stream, attributes)) {
                                                    ^^^^^^
The refactor added an unchecked dereference.

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c
   313  bool dc_stream_set_cursor_attributes(
   314          struct dc_stream_state *stream,
   315          const struct dc_cursor_attributes *attributes)
   316  {
   317          bool result = false;
   318  
   319          if (dc_stream_check_cursor_attributes(stream, stream->ctx->dc->current_state, attributes)) {
                                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Here.  This function used to check for if stream as NULL and return false
at the start.  Probably we should add that back.

   320                  stream->cursor_attributes = *attributes;
   321                  result = true;
   322          }
   323  
   324          return result;
   325  }

regards,
dan carpenter

