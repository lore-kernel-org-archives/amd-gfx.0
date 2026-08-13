Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D578C5DF67
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 12:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270BA10F2F8;
	Thu, 13 Aug 2026 12:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d9X7pXWM";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6E210F2CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 11:27:00 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-848743155bcso889180b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786620420; x=1787225220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NnsKlsQfAgw4TYphFLbsBTyUS9mLXz1EROz2+K+BZeY=;
 b=d9X7pXWMRdgQtSk4EKmHoRHrNslaRra4TyANwEalINqMX0Xfu8wre0QhT4Rpultdh3
 EE2B9AqzyTVhfdC/llD9H909WwQ5aAc7dU4pDYMZZ5vdpZzbPdo77pS6K/gTmIQ2QNTd
 hlPr1JEnOXn4tFG7osLwn7q6COps1iUhfla1Kiokl8Rk01m9JLZj1nTrul3CxuYIjWiR
 PI3wLesnagdrPoE1dFCNfl7lr6yzdaB7XO2zxaXE1UzC19tn8TdnNqOQePw7bTGHstGi
 OQanLjdntu6WTEw0MGwMjU0M31ITzrs7riiz+7fn07gn1mK9jXgeWovQYEe/ggpTlu5H
 fNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786620420; x=1787225220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NnsKlsQfAgw4TYphFLbsBTyUS9mLXz1EROz2+K+BZeY=;
 b=Xxzj4pjwTQbZOrU8tSSEfT4261LHAA6/RiEU8CQNDKa7/1Iqii00tExjPG/8k0KUpI
 67vRDNUFCg4SjFnIuURS/NH76evaoQNlaVTbOd/SpAR3ab6Ctcyz7F1rwcKbvWswUVFU
 eN2eGnofdzuD4cGJYwNi/1a5AdoMFV/6y2BHqLg1SnUOqZz1OFaXvcKPZmnkSqgmjSJm
 EAxfpLEBdblQINtnPYdvs4zxPcVmeZDiAweBIkFkxZiJZp77Dmp/JQgk0PWjc1oNCnK/
 OL8iFW82j31LZJPUOc37oDnaEKvcp1z210PhQQGqF9oPdM2Nzv8BzS1RM5R964Y+TD+B
 qJGg==
X-Gm-Message-State: AOJu0Yy72A7xlpe2TFOLx8IdH744YO+OCZ8mszjsWd4TpuNfxM5kyHgm
 3Wa0xW6zeMgPoze+B0k5nsBCGUzS+zCI/BQLoypAw27wkAluTTb15ePluVkANQzHzNCxcg==
X-Gm-Gg: AR+sD10lwo++cCmtZidT466mKWCYhZbholXZy85lzticiIUoywGbBhOAHlu73dZM9KD
 xD6MDyVRXt9oVfW98rjafKqian6YQymAznXYfPE78x394wlYMyMPmTKIRclYgSQONMp9YNWupm/
 d25iEsz7WPb/jlx1pk2WEgJqcGt+eQZaUHyzMrUdnWn42kZg1MGg42QmbkYm9KK2V6FvCP5900H
 w4ejOGUtWFW3LiZw+v4SeuPHmJg8MbN+ZVP1PQ0DjdOwH+0qAr61TlR/5ClxxuaC6V3uytDDi1r
 YsjsIRrsAr3h2t70SDOX1IiqYpnHpoNAC9lkFsdV7ucD9ukTsnXjwwtDZsMcgLJcUgW+gvl/6uA
 63hMYu+MAmJR+WlYi6yy/dNry/iE/1omXQvtTIKpzEyCCp2eJKtDzXgomKuMo77kDDo91yfMyZJ
 mQFfOTYxhEWxrQBjoSQgTfoaJoIGkP4bXv2VuyH0xgIIH3TYG173wKEN5P48ExjsJFYdjQFQZDl
 V59vhgs7Vd8t1AAahy2ebPM
X-Received: by 2002:aa7:88d0:0:b0:848:70dd:f5a9 with SMTP id
 d2e1a72fcca58-84fc74958c7mr4544635b3a.38.1786620420195; 
 Thu, 13 Aug 2026 04:27:00 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef6a59d80sm894282a12.11.2026.08.13.04.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:26:59 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, David Weber <weber.aulendorf@gmail.com>
Subject: [PATCH 0/2] drm/amd/display: Fix streamless connector update and ABM
 modesets
Date: Thu, 13 Aug 2026 13:26:32 +0200
Message-ID: <20260813112634.11455-1-weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 12:59:36 +0000
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

Hi,

This series contains two independent fixes for connector property updates
in amdgpu_dm.

The first patch fixes a reproduced NULL-stream dereference and is marked
for stable.

The second avoids the visible panel blank caused by modesetting for every
ABM level change. This is useful for desktop environments that want to
adjust ABM dynamically for AC, battery and low-battery profiles without
making the screen go black briefly on every profile transition.

It would be nice to have the ABM fix in stable kernels too, but I am not
sure whether this behavior issue justifies a stable backport. I therefore
kept its Fixes tag but did not explicitly Cc stable.

David

David Weber (2):
  drm/amd/display: Skip connector updates without a stream
  drm/amd/display: Avoid modeset for ABM changes

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.54.0
