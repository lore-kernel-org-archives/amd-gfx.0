Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB828CD5BA1
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 07:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768BF10EACA;
	Tue, 19 May 2026 07:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TksMm5Tf";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4344C10E355
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 21:20:13 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso17074375e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779139212; x=1779744012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eib3eRFzS2+00sCLYIMDe5vm4mlk/dWlRJSkbmyxtqY=;
 b=TksMm5TfdCGVJclcnfxJcT2vlQa5pGrzYY7XL+DUSwd5dauXkaCoTxUbJAP0BfK4j3
 EqK1i3Tb9MDo5ojR9kIaZI4ghfELrWL3rpz7OuZUPN6hDKJ1YrkF0Bxi7uMh5okv9zrt
 jP91TM7i+WYN9Z2tRVZ0VHbljBVaK3C4lZ9BNa+ZUdL1d6fbIhKElft5yUr2qR9Jg48I
 4wz9e+Ony6Ns7VwFsgjBg+mL2hGVZsOzndQPwPBK8Et027k9XEBRaJxg+GPg2Pot3p5f
 o38bicxoR3Buwsj7eVuRSpaNYfOZhoheZP1B3hxam3WnoJcEEPnA1T8gldybuo0w9QkC
 oi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139212; x=1779744012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eib3eRFzS2+00sCLYIMDe5vm4mlk/dWlRJSkbmyxtqY=;
 b=FLVRTwrdZ7Tw0ELMb+KcJlVbiVJGO9Y5WVSyll+5ZwkfghYKxvG+s4KG52y9ipRQ8Q
 nTR5wueipn5k7q/3CgLBxoLZ1WI4YOlmmsSTEyzR51dP0aPE2zw8fvFFjaD/mQpuY4Yi
 D5THhicN0C5JCNQvRk1mvx6QJMqFeZoOPOtu6lRhC/KhFfo+JdDpUgr9OQEyWDEiEa4o
 GEKBCGHe00l8Hoy0hAemIOYonlhqhnNnHZ1Ppv+M92g4otaEfvb76IpBOGoCg9mxwWx4
 RBbbQgcyTeNyXLV0PJPMrn5pYP6iJ5joik0yfrw6pEDvoAYViWbW4OZTu8mP9LHVWNIR
 +pQg==
X-Gm-Message-State: AOJu0YwsUOAkrPLFaxgB1AXoieVhPfTmHWqjAHAii51G1NFvtOio340w
 WU5vD24kNpzsqsV2ShhnmZkQrokvw1Z8matCEHEu4LJnqwfte25cFk29
X-Gm-Gg: Acq92OHx4NTmb1jKBB2+uINZ+R+qhFQ/AV9uu6dLLyMv5PytUBf8liBRIh4JXx5GdF4
 qS0P/8gqeoTZVP8YRIeqqCoKxo9Xh06Qe/DR2ILY9iu9gx9brpFECE98jfshlvVu4PVqoBXG0D+
 +hp22la5RYM8+vFVZVMm3kBLckaflKjXVZYd7lML3vrqjygFu5eKj/Efxw35PKwHsQ960kdXdNL
 rMYLt+JydSa5q0gl6H4Yx0e819B5RdQpjwt8kKxBphBHCSA+7MpK1yvk1sbWckTH+lylKAUJwou
 b9z39zuRNYk8l0EcB3o03TXvgDJHAwXEwW5dxeCLUoKikzYioTOrvEI87WylSjoGBcLXqamEgfn
 DD5FagLouZPyY/g3WFGsRb4WoI4kKFrfP7NqLx8TqiFD8ZcxirLx94gmiOn9BPmoIWVUcVOPChH
 Wd/8mvCgWkjN+riFtZ/dvwJk61070WRXP1K06BVOlsIqVq1XpH
X-Received: by 2002:a05:600c:a405:b0:48a:52ce:a4b1 with SMTP id
 5b1f17b1804b1-48fe60dd5e8mr252074615e9.15.1779139211392; 
 Mon, 18 May 2026 14:20:11 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:564:5711:52c6:59ff])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2ffdfsm37133980f8f.15.2026.05.18.14.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:20:11 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 lkp@intel.com, Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v3 0/2] drm/radeon: fix iMac11,1 dark display
Date: Mon, 18 May 2026 23:14:09 +0200
Message-ID: <20260518211409.4868-3-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
References: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:27:26 +0000
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

Hello Alex,

thank you for the feedback. I've updated the patch to use dmi_match()
as suggested, limited to iMac11,1 only since that is the only machine
I have tested so far.

I will have access to other older Apple iMacs which also show display
issues under Linux. Given your comment about unusual wiring and
potentially broken atom tables on these machines, it would make sense
to investigate this more thoroughly in the long run. I would be happy
to help with testing if that would be useful.

The build error reported by the kernel test robot is also fixed — the
previous version was missing the dependency on the ASIC_IS_DCE31()
macro introduced in patch 1. Both patches are now submitted together
as a series.

Changes in v3:
- Submit both patches together as a series to fix the build dependency
- Use dmi_match(DMI_PRODUCT_NAME, "iMac11,1") instead of
  ASIC_IS_DCE31() to avoid breaking other DCE3.x boards
  (suggested by Alex Deucher)
- Limit fix to iMac11,1 only (only tested machine)

Tested on iMac11,1 with Debian Linux.

Gilles Risch (2):
  drm/radeon: fix internal display on iMac11,1 (RV770/DCE3.1)
  drm/radeon: fix eDP resume from suspend on iMac11,1 / DCE3.1 systems

 drivers/gpu/drm/radeon/atombios_crtc.c     |  4 ++--
 drivers/gpu/drm/radeon/atombios_encoders.c | 16 +++++++++-------
 drivers/gpu/drm/radeon/radeon.h            |  1 +
 3 files changed, 12 insertions(+), 9 deletions(-)


base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
-- 
2.47.3

