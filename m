Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5ECC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 20:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3ED58F059;
	Thu, 11 Aug 2022 20:43:42 +0000 (UTC)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D3B8EFEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 20:43:38 +0000 (UTC)
Received: by mail-ua1-x931.google.com with SMTP id l7so7376334ual.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=vfq3pJ5zfQ+WnS65JbneitHsv0wlpWwn+9h4BV1QTjQ=;
 b=FOPREgmDk5GRRe+ezi3LiI4+m3LAoszAmrytmsrTgA/ndEcqQnlCGRkZMf56HKjO3a
 4r/ZzsdciMvSjZFno/s5wVyRyOjIloF+ygZDCvwWLT0+UqNRm0KA4kMz3UOPFRolowVy
 SKsVBdEthLtY0nx70i8xn+kBJ95WG4oIrDRCZ4J3e5LTrVZb0DTVkltivEnOCTgP5wu1
 PD+n4S/z85Wb66Ieoze27v2qfhtRPvaFN50y51ajCm4bBeQCHIGumSveQ9HaFPf4srRU
 uwM0BCutL4To6/E+ARumU2IMAt8/M9vUby/ku8EF64GZzvLIwH/FHNzUKIrOQEIAsoWx
 GUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=vfq3pJ5zfQ+WnS65JbneitHsv0wlpWwn+9h4BV1QTjQ=;
 b=V10GPVFkrkNx86kKvgSZac1rTL6MmAlFrnK+XxEMS25b25XY/BKLm4RHzMb55wzMfu
 heqfW74wqjQHWkgrFFTJ24+YLWqiAa7C4GZ28nbcfIDWoYdXbP6LvBj9TlBtlSkk2qAY
 TRCeYzD9InzXNdCncEhf4ff+tbIzSIiehS++jZ1tfIH4545xYaYwYtpTB3hQWn11N+Vw
 ILSMAD0aCtXo47mhKrq4DQ/6e3Gqy4kpTflLb1t4ovrWsRtAxM+WpqLHo14E3bv9oCz3
 0wY3FpqKpxeyzMWRYJ51o4Tp532shZL7/vrgtY93cUYba2FdMPxBeEQyWpBhEhA3AcAV
 9v+A==
X-Gm-Message-State: ACgBeo1/mH18Ggcerc2QbhnmK9Lkk0+8kAd2XT/9lrtBt8uZccK7+W2S
 bx8MyEzVXz046zhyVLSwPdU=
X-Google-Smtp-Source: AA6agR7ePNZLLmc4Lb3IX/XBH0iqUhdlLNDSrv79My9jIdNGU2TiV3wNtKfvQd4umhbCzkvvbmW8BQ==
X-Received: by 2002:a05:6130:10b:b0:37f:a52:99fd with SMTP id
 h11-20020a056130010b00b0037f0a5299fdmr493170uag.96.1660250617264; 
 Thu, 11 Aug 2022 13:43:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a67ee97000000b00388d3be20bfsm226846vsp.28.2022.08.11.13.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 13:43:36 -0700 (PDT)
From: Tales Aparecida <tales.aparecida@gmail.com>
To: davidgow@google.com, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 0/2] drm/amd/display: fix MIN_I64 overflow on bw_fixed.c
Date: Thu, 11 Aug 2022 17:43:25 -0300
Message-Id: <20220811204327.411709-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: siqueirajordao@riseup.net, magalilemes00@gmail.com,
 tales.aparecida@gmail.com, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 mairacanal@riseup.net, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

This series fixes an error accused by GCC and some checkpatch warnings.

The first patch of this series fixes an error reported and fixed by
David Gow (thanks!) at [1], where the macro MIN_I64 was used for the
first time and warned about an integer overflow.
The fix uses a similar syntax from include/vdso/limits.h

To cause the error you can either apply that series or, for example,
define a global variable:

    int64_t min_i64 = MIN_I64;

The second patch fix lesser warnings in the same file.

Thanks for the review!

[1] https://lore.kernel.org/amd-gfx/CABVgOSmkeybnR2sGEEgn1Cb0cR2eKxW=vhXkHjC5xCuhaxsqVg@mail.gmail.com/

David Gow (1):
  drm/amd/display: fix overflow on MIN_I64 definition

Tales Aparecida (1):
  drm/amd/display: fix minor codestyle problems

 .../gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c    | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)


base-commit: 1a60172c97fd2b51151cf17483f372bb61246c0b
-- 
2.37.0

