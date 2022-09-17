Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084F7C54EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 08:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2054A10E57D;
	Mon, 19 Sep 2022 08:06:08 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B77CD10E20D;
 Sat, 17 Sep 2022 10:55:09 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id h8so32867195wrf.3;
 Sat, 17 Sep 2022 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date;
 bh=qgeFEKmlCeElYtmQhO2NHIF7009WxIJXwGvauIaMgRY=;
 b=jTwbtV+yyd/9MW4yeNhB8fqWF5IfLZXmGqFokfSHdqBzJOpR3tqFM/OzSvmTo85V0s
 oCBbiWbFULuvLd3Hij1urxgaUx5L/BzoUcvud2cNV1gg0IeW62AdIanOsm/pSOaGr3m1
 ZiQoj6MVGNibMNxlPoj3EZViF4QqbCgVXjG/v2oxzwBQ9R23+JcOBaLSaaGFSEbO6Ke5
 KFD1B2PQ92gql3dyP/p43UVBHPDGATa2SaxRt5E+Aw7VVGX26DntFEJhvSL27j/eSAqq
 rjGs4QnRboK5UugvL1SVRVoxcrijYvlgq335VmTBp5CUWOIOh8iZ9r4/+5QjtyM6CNFg
 K70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=qgeFEKmlCeElYtmQhO2NHIF7009WxIJXwGvauIaMgRY=;
 b=o/SaKXEGUhbKdFknQgan/lo3V4HpvcDydP94moj91W68qf7CatzhfrzglPxCv8wCeM
 /N6UbinWG1M90JvZ9zxJf4CRYvGzt0LP8+Qk/vkvz8ybM2FDbKPgRMfbhhn2y6JXPjL3
 4lk0vdpHc5gQBCZikMixe28MerhralTS1jvUsc3aVGVOJhdXRosgo3l4NfKrJGlAPvPs
 YlEOeU+bH1AdRWHZHtKZtzdmKfISCyHHBLXfKaVV41VdW3HM8jbjtxqkn/LcT4/OGQJr
 I9WfIpsdKimDczcy451uZA7+fBYfiDVx+YhFKNPT7bY6JlIVS7hOQZzD58WM3EfVZRON
 vnJA==
X-Gm-Message-State: ACrzQf1LtuWjeHi1aS0xrcPkpz6habP465BAoZSzcSJ/5xi37UY7Rt06
 Eurwun67tevyCR99JIoOH3U=
X-Google-Smtp-Source: AMsMyM7hhfKCI4x+UY64D+f0D7/k+FZrG5LGnSK6gzywitR/qTjOUZeB+KzC9ZGxKfbbACcwikNkXA==
X-Received: by 2002:adf:d4c9:0:b0:228:de3a:220f with SMTP id
 w9-20020adfd4c9000000b00228de3a220fmr5599938wrk.597.1663412107392; 
 Sat, 17 Sep 2022 03:55:07 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c4e9100b003a5bd5ea215sm6026813wmq.37.2022.09.17.03.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Sep 2022 03:55:07 -0700 (PDT)
Date: Sat, 17 Sep 2022 11:55:05 +0100
From: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: mainline build failure (new) for x86_64 allmodconfig with clang
Message-ID: <YyWniVAqJclcbSqN@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 19 Sep 2022 08:06:05 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, torvalds@linux-foundation.org, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <nathan@kernel.org>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi All,

The latest mainline kernel branch fails to build for x86_64 allmodconfig
with clang. The errors are:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:4020:6: error: stack frame size (2184) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
     ^
1 error generated.


Note: This is a new error seen on top on a335366bad13 ("Merge tag 'gpio-fixes-for-v6.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux").
Previous reported clang build error is now fixed, thanks to Nathan.

And, it appears Nathan has already sent a fix for this:
https://github.com/intel-lab-lkp/linux/commit/4ecc45d7585ae2e05d622879ad97e13a7d8c595b
https://github.com/intel-lab-lkp/linux/commit/819976a950b497d7f10cd9a198a94c26a9005b30


--
Regards
Sudip

