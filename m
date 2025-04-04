Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285D7C3601A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 05:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F014310E276;
	Fri,  4 Apr 2025 05:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rtd//EeV";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1CB10E276
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 05:42:38 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7c53b9d66fdso216653485a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 22:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743745357; x=1744350157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ax4tFaDNfSBe8OwieuN54bJJ11A29N/Q1Dhvw5XXad0=;
 b=Rtd//EeVz5hndxHUQZWySysnKTkekLHuhV76DcnCdVdfvfoE5Gcc3qsumNDutLbRH1
 HWa7FHINlw1Ggl6/G0tmfdDMq4ZodtXWiITJHRSOJVL+qBSsstR7/DD9ze92CDVcUZfR
 sDSU2Wba6AWhOIybUuMJc8bAiGgDhjcrk0ZpR15PJNG7XOm0PyO/hluMCFeHpz6SnWPq
 jXmk0VUYTw5+ukpHYqLCvZ+Af25EFdTuWoOOrChvd2G96gjjfYfV9tOqU+ns1wa+M7nn
 6DtWYL9Y+xtxsoo5MPm6kIvE9qeNcAfD/R6MyVTaZiQhUEdpm7gK6iV5fKDl11/d4bDW
 L+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743745357; x=1744350157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ax4tFaDNfSBe8OwieuN54bJJ11A29N/Q1Dhvw5XXad0=;
 b=Ti2q8dWIkgLamiPkHHaV7ftgcONBMwOdIMNWhKa6jhbyt2gCx1ym9Gq9CbcbOkhf+D
 XG9c5ms6XJDxvI+DWsVwMOHuUyKG5PB0/bBxjZB/H6j+DRAzs8G/hEFY50piGqfD+vDH
 omj+nbiLUxr3qwUJKRg60fUnQO+FKvKqwFQtML3U651Xo2S1vSt3iZ3WlGK8JqaYsDXH
 Rpz2iGhtwPdFntZ60dfNsqIUkkTYTZOe0gr7g6CvZU33nnV/Y5FTdEvlGkQ25pPq0PQN
 EzhL1rxPfYp6xpMOIx87vXxy/fcd109XhPZTbMGKW+w6WUhSeeb598j59pS5L7XZq5Ee
 Pj+w==
X-Gm-Message-State: AOJu0YxGmcyrVe0DlmrtBJCjx0Y21O2vJdVaBKc+9urdnxXgE6x8uQT4
 vcjptne8NJ8uqXx/3V3f1yJXMcY0HfJ65pfWXMW8zmPwwHlnLmmF0Xq6ig==
X-Gm-Gg: ASbGnct3Iedy84DEmRZZGUNGj+rWMjuxHmGQV0q8cpC+MVl7mVBJuZ/a9czSorZynT4
 xJI63tcljFDvLCXxiXNR/WZBFoMoQiMD7aIl2eGkM3yF3oh9H7tKbjVo4T3iv9+WauJfg88Qh1F
 112N7D59po6XajzIi3rKQZPAIFb3YMZPCpXTnHRlurFeYtQI+K0djRsKehdz6HuxZbwmWQos5UX
 9WtgV1nRA2t0IVw2P+Vc1kw2OaSqsctyvuGm/WAYdSkZsSRyhLQj5o254azNN+bkcHqu1GzvuIQ
 9x85I57nz90QAM67INUMUm+PWoStNa3Pkam27SdvG45OZZh0vQxv57fSi9aqAQCQuPeS
X-Google-Smtp-Source: AGHT+IFXVQymHJZ1cFaK6B/y0ZoadDMTyTxlcaO2GZ2P3LwHOeQVzq2wozooy/Mc91NQnfxcAkfaog==
X-Received: by 2002:a05:620a:192a:b0:7c5:6a04:d0a8 with SMTP id
 af79cd13be357-7c774d27393mr296100385a.5.1743745357270; 
 Thu, 03 Apr 2025 22:42:37 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76e96e566sm171746385a.63.2025.04.03.22.42.36
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:42:36 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] drm/amdgpu: better complete DCE6 and GMC6
Date: Fri,  4 Apr 2025 01:42:23 -0400
Message-ID: <20250404054225.101791-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
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

First patch moves some DCE files around so they are distributed as are
other DCE files

Second patch implements gmc_v6_0_set_clockgating_state(), which was mostly
there, but commented out. A few tweeks were needed to make it work under
amdgpu.

Alexandre Demers (2):
  drm/amd/display/dc: reclassify DCE6 resources and hw sequencer
  drm/amdgpu: fill in gmc_v6_0_set_clockgating_state()

 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 44 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dce60/Makefile |  3 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  | 24 ++++++----
 .../dce60/dce60_hwseq.c}                      |  2 +-
 .../dce60/dce60_hwseq.h}                      |  0
 .../gpu/drm/amd/display/dc/resource/Makefile  | 24 ++++++----
 .../dc/{ => resource}/dce60/dce60_resource.c  |  2 +-
 .../dc/{ => resource}/dce60/dce60_resource.h  |  0
 8 files changed, 63 insertions(+), 36 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{dce60/dce60_hw_sequencer.c => hwss/dce60/dce60_hwseq.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/{dce60/dce60_hw_sequencer.h => hwss/dce60/dce60_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce60/dce60_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce60/dce60_resource.h (100%)

-- 
2.49.0

