Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3468CCF2C9
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Oct 2026 22:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087A510E740;
	Sun, 18 Oct 2026 22:39:21 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD4710E054
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Oct 2026 22:39:14 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4956869750eso10478005e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Oct 2026 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792363152; x=1792967952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CvsLpFGelrgwN9Cl66Kd9LpNf+fNDOOYoQY8p06psOA=;
 b=Gm1uKLYU6uYqMSTHZ3gUazu+HDDesRttFMWQ/RpdK3CPWAHUD6JOBEsNki7Nf0zdPQ
 dVcNcUxl+Vcj9DDLAYzhUrnFxjdg4IlH5EgkBhpZC3coL6ymyyRegHHH51ES4C9jqN3D
 n/4L6s3TP2scwOEQc2XxohO0MhjeyUOFeKn1Oo8ZdKWiMM93Ttxl6juKjLzuJbLrWsY0
 MUyQ36Wr50L5mOS9zgZyQQPzlb2q6MhhnHEmXPA9nEqK86wZ+PGoBi2i8wC44xyLZU48
 EwyfRDHon/68kzfwpO4CBDpQpu78mRZkhFj41cqaOuaKqLfOk1MO2lepPgErfZZOdupB
 askg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792363152; x=1792967952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CvsLpFGelrgwN9Cl66Kd9LpNf+fNDOOYoQY8p06psOA=;
 b=zDO6V3W4YCDtfcDLN05FdXJu4NMpL7KETZI/agUZ03j66ZM7ggIp986aX8mH4MYZJk
 8qeU0kSw3ig6hO+n7cdueuKyS4yrdv7t3WEZLiMJ9/MqzjwwzpS8VV4ZhuW2QrxdCa0O
 7ZdcT39XR98t6XtFXc8TcBes2h/Pu96UJD11Hl5uHUjRTeQL3ot1xoUGBkh/3jiPUmbM
 esLOUKGenoJvW4oDqxOJdbD0IUpXtETV//0zoy0NRO3L7JqMfDp5lQukEEWVerjbMuV6
 3OOlxwzKBoDU+JRzTUSZqtP6XF5SrKpKGPpmw+MJilErHCJ0R9ehm+QoW8XVTCferel5
 TvQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrQf3OSs0wIPxtF6sNNLlDamwCnGTp2Ys6IMS8p0MERjH+p6qyoyx1u+N2WsLME2quiCIi7kBW@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKImhEAuq6Pvyz2vfaGqzrsDXgMi5AIt0s1RI+VSK5ILH62NkV5
 hWFnwC+1qYbEa95TaDKUI1o3WZw69din7qqTaMliNCwZ5gnmLl2NZgroZzD6Sh4nXcHL6Uln
X-Gm-Gg: AYBFou05itsvEsOAwak793XrgVaa6y+HuaH5+0eIKuBPiUBfO4dbPhbu0FN0WbYiBnR
 LtHVxV41cJDXQvFJWXu/jn/iL2YO6KpvNkyqrFrh3gIZXXHQ9tWoD+LoLBBrmFQJDYsWOmDk0si
 5a5GKk592WLVBoPXa3sSS2He68YbZgy67xBg4CdOVgSrn3cLus3hkj5dGZTWBhe1g/5LpYqtcUE
 6d7DJOt8St6tyhlubq0EXwifiHpEJM2eAc+fP3aESyIrBQv6SShTcX1i07x6yQ+87xco5SqwNee
 9r4kxREsukK9NxrIN0jN5qQaWvf/LDp+9ZzI2BQLIJNnY8wEPd4i3LKvHT1EuWN48X1hfnZ+EsR
 1AS73P+rJI50Xj2rkBnEyqUTz1g09jXyoSeqCJCqjuwrPMq4ukcwx9QM+zkKHAc7KlP0unGK3mY
 AzoYs+RPWThXy1+n1WgUdFyJI3oXUnoMdFR9nDYnQnPau5TPTvE/fW0hIiywgJZ7jYnd933Glqx
 t9nxo9FcuM05GC+2jsCcpOjiPuegMdydUnlYFOaKThvROIz9I0X7e1TbkFDT1z1e90jh3Q=
X-Received: by 2002:a05:600c:8b22:b0:4a0:1c17:4fb2 with SMTP id
 5b1f17b1804b1-4a1d760d9fcmr130723785e9.31.1792363152485; 
 Sun, 18 Oct 2026 15:39:12 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm16359363f8f.3.2026.10.18.15.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 15:39:11 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 George Zhang <george.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [REGRESSION 7.3] drm/amd/display: single-frame scanout corruption
 on DCN32 at 120 Hz since a637a140ab86
Date: Mon, 19 Oct 2026 03:39:05 +0500
Message-ID: <20261018223905.32324-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011201833.853907-1-mikhail.v.gavrilov@gmail.com>
References: <20261011201833.853907-1-mikhail.v.gavrilov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The workaround from my previous mail does not survive a suspend.  After
resume from S3 the band was back (seen, not measured) with the TV still
in FreeSync mode, because DC had turned SubVP back on.

Snapshots of amdgpu_dm_capabilities, pp_dpm_mclk and the DTN log, all
at 3840x2160@120 with FreeSync enabled (vrr_range 40-120, the EDID
byte-identical in every snapshot):

  after boot                    sub-viewport disabled, UCLK at 1249 MHz
  20 s after rtcwake -m mem     sub-viewport enabled, UCLK switching,
                                watermark set A at the register maximum
  after toggling Night Light    sub-viewport disabled again

dcn32_allow_subvp_high_refresh_rate() keeps SubVP off a single FreeSync
display by reading stream->allow_freesync, but amdgpu_dm sets that
field only on the first flip after a commit, so the modeset forced on
resume is validated without it.  A gamma change makes DC validate the
state again, this time with the field set.  The patch:

  https://lore.kernel.org/all/20261018221726.27259-1-mikhail.v.gavrilov@gmail.com/

With it, SubVP stays disabled across rtcwake -m mem.  Until it is
merged, toggling Night Light after resume restores the workaround.

None of this changes the band itself: in HDMI VRR mode, and at 100 Hz
in either mode, DC uses SubVP anyway.

-- 
Thanks,
Mikhail
