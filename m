Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2EFC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 21:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6DB9112641;
	Tue, 21 Jun 2022 21:45:09 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E5710E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 20:39:27 +0000 (UTC)
Received: by mail-pf1-x449.google.com with SMTP id
 br7-20020a056a00440700b00522d222b51bso5858073pfb.22
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=TBTJUKxXl6/CoGemYB3REqJFiIeblmjK8L2EWRNC3hI=;
 b=JkQhyN+x8xO9p13An8lNUc3EIJj4b6DAyE7xZpJ7T7EpKBDtW2fZkVhM7DfjEQtJ7p
 6DI2hX0snVjQiA0cxY+7w2K5CTkr1lE3ImkqKi/WeJg/2eU2RAl8vDaQsC0iRPCfzc6j
 dlM/IwEY/mGrodbwRYQ7PCbIAARUeEMGzqkUlBnGmfAk0fTq+Uvm2QhpJjNQOJBhcqyW
 ucYnMt380S0hDSbNup1QcqxPAAZYvor5zrk7qQToX1oy754i1V3nPdifsyF+w3/bW7+1
 pf8oBBosJG04k2+FrshmyenC1ATMgUdchPUs2TRnmHb907CjwN2ckgEoG60OSv3zc/9z
 mI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=TBTJUKxXl6/CoGemYB3REqJFiIeblmjK8L2EWRNC3hI=;
 b=R6m+B6Kq0vMRaBkD8YWcH3BSo9qW5wHmh2h731qaG1dlw/yaWsu/Kf0pt/BvsUSi4a
 ivzd0npVEYGLQZiHFbMB049uLp4F7OeaVGp8FKa4urcuCMoFJMsfisi3KJJDuGTsruMY
 /110NkAhbYv7LH7yYooCnR3/l6udpGHJBEg7+vcOZugRoRdDbj0AEpuhKrkIRXengBzz
 KxAjtWX14Tk4o4FNyOBQJaYsQNyEh5Zh1vleex+od20CUz22JGqncUbCUEll4JebvMUs
 2DUo+0TDlqrW4jqtVm5v3hNpQ5aHpNCkiDeP9vpV+7pDkwcEbf3br7RrQwq6lhdCHd3+
 OmAA==
X-Gm-Message-State: AJIora96o4s8JHxhC0Cyc4UCzSHF1OFTqzr74aDEqzXBfYR8gib1H3no
 OBj6aAgqHHqtiEEDwIgiZWLTwcxwXoJPD8zfMeWu+7Dhlt84fyFY+oPuQj+UMQ2LbX7SKO9Kd9O
 Sf5azvzLdtO2GAXnhYAVNUJbXp83XCnRPA9Rjm4DLyYaRlsuifjk0THSmJrOt0VDy20oIBwedAX
 3W
X-Google-Smtp-Source: AGRyM1ssb1j9pdEhTyuXhD8tWoHrkikkmhIQybOMDN7v+xBmjMvp9r+GQEe+ZTCmcx6n2GR7vd6pM9Lx6nqQHg==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:902:d5c3:b0:168:f037:98d7
 with SMTP
 id g3-20020a170902d5c300b00168f03798d7mr30454468plh.117.1655843967320; Tue,
 21 Jun 2022 13:39:27 -0700 (PDT)
Date: Tue, 21 Jun 2022 20:39:21 +0000
Message-Id: <20220621203921.3594920-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH] drm/fourcc: fix integer type usage in uapi header
From: Carlos Llamas <cmllamas@google.com>
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Jun 2022 21:45:08 +0000
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
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Carlos Llamas <cmllamas@google.com>, Maxime Ripard <mripard@kernel.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Kernel uapi headers are supposed to use __[us]{8,16,32,64} types defined
by <linux/types.h> as opposed to 'uint32_t' and similar. See [1] for the
relevant discussion about this topic. In this particular case, the usage
of 'uint64_t' escaped headers_check as these macros are not being called
here. However, the following program triggers a compilation error:

  #include <drm/drm_fourcc.h>

  int main()
  {
  	unsigned long x =3D AMD_FMT_MOD_CLEAR(RB);
  	return 0;
  }

gcc error:
  drm.c:5:27: error: =E2=80=98uint64_t=E2=80=99 undeclared (first use in th=
is function)
      5 |         unsigned long x =3D AMD_FMT_MOD_CLEAR(RB);
        |                           ^~~~~~~~~~~~~~~~~

This patch changes AMD_FMT_MOD_{SET,CLEAR} macros to use the correct
integer types, which fixes the above issue.

  [1] https://lkml.org/lkml/2019/6/5/18

Fixes: 8ba16d599374 ("drm/fourcc: Add AMD DRM modifiers.")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/uapi/drm/drm_fourcc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index f1972154a594..0980678d502d 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1444,11 +1444,11 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 mod=
ifier)
 #define AMD_FMT_MOD_PIPE_MASK 0x7
=20
 #define AMD_FMT_MOD_SET(field, value) \
-	((uint64_t)(value) << AMD_FMT_MOD_##field##_SHIFT)
+	((__u64)(value) << AMD_FMT_MOD_##field##_SHIFT)
 #define AMD_FMT_MOD_GET(field, value) \
 	(((value) >> AMD_FMT_MOD_##field##_SHIFT) & AMD_FMT_MOD_##field##_MASK)
 #define AMD_FMT_MOD_CLEAR(field) \
-	(~((uint64_t)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
+	(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
=20
 #if defined(__cplusplus)
 }
--=20
2.37.0.rc0.104.g0611611a94-goog

