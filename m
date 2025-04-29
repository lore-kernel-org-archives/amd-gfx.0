Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA06C3ABAA
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 11:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDFC410E42C;
	Tue, 29 Apr 2025 11:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XQSN+H+j";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58DF010E424
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 11:24:31 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7c9376c4bddso716512785a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745925870; x=1746530670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I93vR+ZIBnh0QvqOgDDrqq5CskxXaT62HTsEzBVHpXc=;
 b=XQSN+H+jLf016+QscvT2pGJO43WQ9CWV6QWvqNwQjmTk7umbs6CZ+uVukqAe9sQKRh
 vvrxCnWqjkmn/ILtCIiimj6gl4CsOFmy8A5aBZmI22JmQDqG52Ov51WCwp6708S1BNVJ
 fr4pZ6q5Ax2P02BYQZS4IN5dAceixnQQ6sNd2XHjvF56RvS7D7pMPhKGXg4ejE7w7Sg+
 6ybvwY0BE4O18CnTo7Da1XafuRstehrUQOYbTROyr0rXtwVXzA7Yas6yNNjSeLEiu9Y2
 orhCGD1LTCiTOpJPVAwZiwl3Do+2QF6gSu9dI/kLNHr2yvIXbj8t+jfvLPZzGPptnz4T
 D8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745925870; x=1746530670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I93vR+ZIBnh0QvqOgDDrqq5CskxXaT62HTsEzBVHpXc=;
 b=TPWgxSMo9Oq7+bMp1ChYjuMtkf3sjpgdNvtlvhy+m5TKEgcaTJcZ6VBJF420VUCva2
 lwjqJ/ekfydrm/tYNjVj5lRDhHbkmQgrPuo5xYbHz4Dr0FgqEQWijgnCeibIuRbX53AN
 Uy920lOU+iVew/P2HgV0R0V+eAG7UiWz1LFENus2hCBNl3jQ/gdECIiadXLUvouPFEpP
 SHQUgSzDe22JJILBADKoSJcIxT3cu3xfsBtJM/sCx8zqjc8LJlDbnY7HuL47mvVwhnf1
 XDOeLI0r6xZZn81urKq8/XLp45BI3yQs/29LOcZRzZyWiH6x+JNLKlHEPpeYODhwnq3f
 evfg==
X-Gm-Message-State: AOJu0YygYCysGuzXKNtrxb0vTmHeQbnAcyqo+DBFiZwrzU7Trg7o81nK
 NS2VJ7OruCafte5bx/EjyZoAeHeVU+nw0SV4XI/Z5L+mMtCwBaSo+dpq8X1S
X-Gm-Gg: ASbGncs7xldlx+0TuerJMI3rCOc3tCDkrfq6tou5vNpnw9yCR2Wo8VGI6ktq+CC6i4S
 THYs3k6UO4vnBa0rC4Y4Jwd68dLAkX7owHQ7UVFTYbrVOoEkUaR2XjoqPQRzBw5QW15Lvi6yFbs
 ZVW5qo1pT26T0SARgfMN7Ir33v3eyQlusBDW+psR8JTh5gUicW2vCA55aBQEJNfoYuzxgFcgqKp
 s7MiVI6OKGoD6w0diEvFUZU4eCxGc/G6r8piKNc0aEIAhGpYkpfae/948m+QScHads3AsGVJsiI
 mWsUqA3Y7w6SHTSa2q/+jtp8rZbwtm8lC7B+6HdyMDdUu6Sxebc=
X-Google-Smtp-Source: AGHT+IHMZfrcsGLBnXgOY0WGj1RoGsdqotwaYyMO0v7v4kEA1OzMYlXn+4qr6s7SuaS2JCJsyOooeg==
X-Received: by 2002:a05:620a:bc8:b0:7c7:9379:9190 with SMTP id
 af79cd13be357-7cabddde1eamr473298985a.49.1745925870343; 
 Tue, 29 Apr 2025 04:24:30 -0700 (PDT)
Received: from johnnyzero.szero ([32.220.111.111])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958d86f1asm725583285a.69.2025.04.29.04.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 04:24:30 -0700 (PDT)
From: John Olender <john.olender@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: arunpravin.paneerselvam@amd.com
Subject: [RFC PATCH 0/2] drm/amdgpu: CIK UVD initialization fixes
Date: Tue, 29 Apr 2025 07:24:27 -0400
Message-ID: <20250429112429.5646-1-john.olender@gmail.com>
X-Mailer: git-send-email 2.47.2
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

This patchset addresses two issues affecting UVD initialization on CIK
hardware:
 
* Patch #1 fixes init with <256M vram:
(https://gitlab.freedesktop.org/drm/amd/-/issues/3448)
 
* Patch #2 fixes init with >256M vram:
(https://gitlab.freedesktop.org/drm/amd/-/issues/3851)
Includes a whitespace fix for the version on the issue tracker.
 
[Request for Testing]

Patch #2 tries to preserve the existing vcpu bo allocation behavior for
UVD 5.0+.  However, I don't have any UVD 5.0+ hardware available for
regression testing.
 
If someone with a GCN3-5 card can confirm this patchset does not break
UVD 5.0+ init, it'd be greatly appreciated.

John Olender (2):
  drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to total vram
  drm/amdgpu/uvd: Ensure vcpu bos are within the uvd segment

 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c      | 36 ++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  2 +-
 2 files changed, 22 insertions(+), 16 deletions(-)


base-commit: 092f0316dd74beba6685b5c65ff7d25c4870e842
-- 
2.47.2

