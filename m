Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E83AC25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 13:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE86510EBF4;
	Fri, 24 May 2024 13:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JL5H25Gc";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A593C10ED0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 10:32:13 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-354e22bc14bso2480666f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716546732; x=1717151532; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gXkJa6ZfPXuDdrgAZhVkK+DgSojn6WdcIZk/yMnJVc=;
 b=JL5H25GcZfQEuLV3sqLG893MK4Vs1v/utw8EBY3eZk97X+TO4F0A9yoZ0FgfqKrYdN
 em5ZmpEWdAgqba92N5A3aavAHTPqmiSoFAny81cr3AAtjufUitBq44MSGkfUpWebH2oI
 FmmFmN9lcBz/lhOgbl1xXoUFvNqkIGJ3F5FWc8d6f8ROfn8YyvOKr03DJbzhNgMpP1pS
 b1CUnZyTouRPK+7N5DznE90MBVUz5AG2ZQ9HCa5phcSW1Y7yg4i3dLD4pz28vqhEVqeR
 1sKq2HgWpsLeq6hB5idHPqtoHVESzKMF/9u8Ta+VC6rfGLW1888ZDkFEaUKlVgKCl6T0
 YDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716546732; x=1717151532;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gXkJa6ZfPXuDdrgAZhVkK+DgSojn6WdcIZk/yMnJVc=;
 b=wF10S6TlvlBQ2pIcSDXLYEQwu4zdjM6OZiIk5fZmokuQ3f+4TYax4yLQl4DmpbXAXC
 46OmxyR3qNgsLSj3BW2Ibf8TROULeKPK+bojz5OVuZE1AI+iArOa9ss+5GQXVzbiPb2j
 Z+zU2tSz4lZIxs9nOFOgLWbowPSu20Dm+XTBz5gMsIPCd2d2/yKxmaOWARk0Ub+bMvyL
 KTQZ5ZkOa3/BxYDFogA14AYVk9IyUud5ftgB1Tp0hxZ30x8FWgbUDqK3idCgMFjUcStW
 RG6+Ue/ixf16Q0xVHS2+7NRFAfN9HhIjJa+b/7i2DXWMNfquOcbkvRCtKTM594E5IiUY
 07MA==
X-Gm-Message-State: AOJu0YzK3rIj9KnHwPZvBi2apV3TKRrYn6dgHnIg8qzpH+euTdVETYMt
 iI+mD7mwm1XHofBdlZwvUh/Zt7lcKuV63bbgK+EGYC1HdToBdx4tWwrkXuQvWjI=
X-Google-Smtp-Source: AGHT+IEYY3knuYV5MgEjybATI6RxcBhn3gxJFzEChTpbDdsclEM5/+KCHQl7Jt2rmF8Fo4xOvHOGdQ==
X-Received: by 2002:a05:6000:104d:b0:354:f1bd:3c1f with SMTP id
 ffacd0b85a97d-3552fe192d9mr1186403f8f.55.1716546731650; 
 Fri, 24 May 2024 03:32:11 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7da64sm1302677f8f.4.2024.05.24.03.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 03:32:11 -0700 (PDT)
Date: Fri, 24 May 2024 13:32:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: etbitnun@amd.com
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Find max flickerless instant vtotal
 delta
Message-ID: <907686e4-a14e-4496-b213-890803e6d46f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 24 May 2024 13:13:16 +0000
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

Hello Ethan Bitnun,

Commit bd051aa2fcfb ("drm/amd/display: Find max flickerless instant
vtotal delta") from Apr 1, 2024 (linux-next), leads to the following
Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:1006 dc_stream_get_max_flickerless_instant_vtotal_delta()
warn: always true condition '((stream->timing.v_total - safe_refresh_v_total) >= 0) => (0-u32max >= 0)'

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:1008 dc_stream_get_max_flickerless_instant_vtotal_delta()
warn: always true condition '((safe_refresh_v_total - stream->timing.v_total) >= 0) => (0-u32max >= 0)'

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c
    990 static unsigned int dc_stream_get_max_flickerless_instant_vtotal_delta(struct dc_stream_state *stream, bool is_gaming, bool increase)
    991 {
    992         if (stream->timing.v_total * stream->timing.h_total == 0)
    993                 return 0;
    994 
    995         int current_refresh_hz = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, stream->timing.v_total*stream->timing.h_total);
    996 
    997         int safe_refresh_hz = dc_stream_calculate_flickerless_refresh_rate(stream,
    998                                                          dc_stream_get_brightness_millinits_from_refresh(stream, current_refresh_hz),
    999                                                          current_refresh_hz,
    1000                                                          is_gaming,
    1001                                                          increase);
    1002 
    1003         int safe_refresh_v_total = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, safe_refresh_hz*stream->timing.h_total);
    1004 
    1005         if (increase)
--> 1006                 return ((stream->timing.v_total - safe_refresh_v_total) >= 0) ? (stream->timing.v_total - safe_refresh_v_total) : 0;
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
stream->timing.v_total is u32 so it makes the subtract u32 thus it's
always >= 0.

    1007 
    1008         return ((safe_refresh_v_total - stream->timing.v_total) >= 0) ? (safe_refresh_v_total - stream->timing.v_total) : 0;
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Same.

    1009 }

regards,
dan carpenter
