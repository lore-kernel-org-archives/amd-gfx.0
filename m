Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDA6C5AC7C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 06:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C82510F360;
	Fri,  7 Aug 2026 06:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bn9T9XYo";
	dkim-atps=neutral
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4CC10E31B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 14:44:03 +0000 (UTC)
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 88A2B3FC00
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 14:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1786026852;
 bh=2yq57qGtvEjW+CJVmbXHe+PX8QI8M5GPxDPW30jbEL4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=bn9T9XYo2DB4u6kRS48adLV+cfmHT8wYe2/5xls/TMT4LHwgD8+Nome5bBSt1k2wf
 0eqowUPhSXlmLP8oPU/kAWi8OkQs0xd7W4vI2TyyFlf/yTaIqWCBzLeqdyS7bCXGZC
 4BhglXalUbjcqkpkxxxTv+5XQ/Kjr/mPOVOpb24tmMfAmN9xzDCFUoI2z7b15pgQb/
 iEy+45DIEdTKzaDFaGTi02K5LOIlN7QmZyvP297Hpe0cgbd67eDX6HycEZp132ttGV
 yLSdMleUyzpFpUr3JO0SU/3v7rovymZI/8Vip/y6lMMNmTCzETnNpeu/ZIIO6ZmW2A
 Oq0NTQFjZUnv1wgxGoWxoLzFkg1cCZvqGoYgzVbEqsDPKP1z4F5qncPlwSgpJ4qgEO
 zdJPZh6cbax7X0phvCiFvAxgGtgpwzIyMVTlFe6AEm2FKIB+7MyJs+/v9r0ayyni6D
 bty0qV2yYZ7Cc6mqlkzBwCy6LhKefKLIbws4Ce48q3ngKjKLg4UlXdMlJub5F0Tf5J
 agLuyyFoL2qVdjNkNwx+hWOMS845nEAUHYQNHc1vnXIhWgUipFZOsKj2NAvT4xidgk
 GJZLsdPLOxReOjDFdTbn3xYrrpAKBLspZaq2LspWpKi0yG9vjp3OJRZ4bPFga5mBdQ
 aux8iwW9G6+oeZ9HNx/R3VJo=
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66850cde3a8so5778798d50.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Aug 2026 07:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786026851; x=1786631651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2yq57qGtvEjW+CJVmbXHe+PX8QI8M5GPxDPW30jbEL4=;
 b=hQuYUYPCObmmBA9MqGZHxbKVIKO6qdNe7BKo+ATRSwjGgRjV8v+s+WWcM3rli1mTLs
 3LaC3j9Wen2FeAbbd4QVPvFMhroCsHEYV9OEWhKW6SS+mCY0PihzQXYiond3fUxsbpHL
 bpyFe8KXiLXsERkaTaqDSBMUENL5wSOn6a8QAqdb6eNEwXwGdF5Kr14CfVOtvL3zlS4x
 PIPBw7E30QonO3QeHxDLPLGrte62RcKr22W/7bfwi/Mm3x2+2mZyyZWyHR6byTsLDNZX
 hNFq/lsIjWD/ffewVFX5TW47+m1rRpWgYLzNuzb2KrwJQ8GYzIvjZRgwNtfw+cb7lfTf
 B5Bw==
X-Gm-Message-State: AOJu0Yw9oJnfhf1O1XGzuTaOYlblSauBT0uZxEZIRvAvuR+7DXzHeVFj
 FSq1xNzMo4uX3JHXmw5kX0C4rflOTXJ+RYgUWD3Xk9adk/jLP8rnnA3MwthXEhEkHLkCAkY2tk1
 gf0aUu2v46QR6uAJUNEH1WNk0hnKNBvFv+d6zYLExb0r+6Kd/6KVazgWCwty7MUn274GaTnPh/9
 c5scE+amm/BcXDVAQ=
X-Gm-Gg: AR+sD13p56OQ9rHaRpdSRyN1t+AfQ2zt9DDtF4oS+ufD4uluvt6v7cvJC4YQG6iOzs4
 oK0Vefs/BNVQBF5hW9C7Y4pMmU5T08+/XqebrWKQdXoZFdOOAvaKXEhZeYN4/VGpLbDSAGyDkm0
 T52ZBXVXbaKaHzhi7ieI2D5wnpoLP2+9fYAJTuITp3S6iMgDPdMbqtB4WS8bzxzMile2Ch8EtUV
 RU3pdHZ4jglVPRPoFOeTjHh2gSDrc3vDzJpQmATIqnhP9ACDG+llfBDRKzitYKrnEHMwHf3yyoz
 TCge1J5ifC4fpzpKBrIGmEoM+fTJ6YMoPwZ2rq+lt4sKN/hGKfHsMNL7J+5NR6qmchT5gBiF9Yg
 ammMfa2ro26LupCG6Bw==
X-Received: by 2002:a05:690e:4394:b0:668:56aa:6d77 with SMTP id
 956f58d0204a3-6699a8f4c7dmr6432626d50.9.1786026851336; 
 Thu, 06 Aug 2026 07:34:11 -0700 (PDT)
X-Received: by 2002:a05:690e:4394:b0:668:56aa:6d77 with SMTP id
 956f58d0204a3-6699a8f4c7dmr6432571d50.9.1786026850184; 
 Thu, 06 Aug 2026 07:34:10 -0700 (PDT)
Received: from localhost ([2600:6c40:657f:4180:2a3f:d445:3d4e:f355])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ac236a282sm529915d50.16.2026.08.06.07.34.09
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 07:34:09 -0700 (PDT)
From: mitchell.augustin@canonical.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/1] drm/amdgpu: Do not enter PSR if multiple displays are
 active
Date: Thu,  6 Aug 2026 09:34:07 -0500
Message-ID: <20260806143408.979209-1-mitchell.augustin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:54:51 +0000
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

From: Mitchell Augustin <mitchell.augustin@canonical.com>

Issue: https://gitlab.freedesktop.org/drm/amd/-/work_items/5394
Ubuntu BugLink: https://bugs.launchpad.net/bugs/2162904

I have proposed this patch for inclusion into the Ubuntu kernels.
It is really more of a workaround than a root cause fix - but I think a
necessary one until the underlying issue is resolved, given how
disruptive the failure mode of this bug is for impacted users.

I realize that upstream amdgpu may prefer to reject this patch and
fix the underlying issue for multimonitor users, but wanted to share
what I am proposing here regardless.

[ Impact ]

On some laptops with a dGPU and an iGPU, the DMCUB's state transition between sleep
and wake states on the laptop's built-in panel will (at irregular but frequent
intervals, a few times per day in my experience) cause the amdgpu driver to
stop working correctly.

This will cause varying levels of instability, eventually resulting in
the system becoming unusable (described in more detail in the LP bug).

Given the intrusiveness of this issue, my proposal is to simply disable the panel
self-refresh feature whenever an external display is connected.

[ Where problems could occur ]

Since disabling panel self-refresh means that the built-in panel will always refresh
at its standard refresh rate, users may experience decreased battery life if not
connected to power. HOWEVER, given that we only disable it *when an external
display is connected*, I expect that the vast majority of laptop users will
not be meaningfully impacted. With the possible exception of people using mobile
external monitors, I would expect most users who have an external display
attached to typically also be connected to power.

Additionally, while I have never reproduced this bug when only using my built-in
panel (with no external monitor attached), related reports across other distros
indicate the underlying bug might still be possible with only the built-in monitor
- so this patch may not resolve the bug for 100% of users (but I am confident that
it will drastically reduce if not eliminate incidence for configs like mine)

[ Test Plan ]
Install the patched kernel and do the following:
1) sudo watch -n 0.5 cat /sys/kernel/debug/dri/0000:07:00.0/eDP-2/psr_state
# (switch eDP-2 to your built in panel identifier). You should see it switch between
"0" and nonzero values when no external display is connected (indicating that PSR
is still active and switching to/from sleep state regularly). After connecting an
external display, confirm that only 0 is shown even when builtin panel isn't drawing
(indicating that PSR has been disabled when the second display is connected).
2) Use your machine normally for 1-2 weeks and confirm that the bug does not reproduce.
(It typically reproduces within 1 day, so 1-2 weeks should be a comfortable
amount of time here.)

Mitchell Augustin (1):
  Do not enter PSR if multiple displays are active

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

