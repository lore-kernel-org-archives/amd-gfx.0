From: Jeremy Cline <jeremy@jcline.org>
Subject: Regression: no display with Vega 56 AMD GPU bisected to commit
 bfdec2340478
Date: Mon, 2 Jul 2018 18:33:42 +0000
Message-ID: <010001645c459a1a-7702e186-5985-4c02-9983-7205df8e3232-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mikhail.v.gavrilov@gmail.com, regressions@leemhuis.info
List-Id: amd-gfx.lists.freedesktop.org

Hi folks,

A Fedora user, Mikhail (CCed), reported[0] a regression with their Vega
56 AMD GPU introduced by bfdec2340478 ("drm/amd/display: Implement
dm_pp_get_clock_levels_by_type_with_latency"). The symptom is that
nothing is displayed and looking at the logs (attached to the Bugzilla),
I see gnome-shell is failing with "Failed to set CRTC mode 3840x2160:
Invalid argument". The problem persists through 4.18 RC2 so it's not
fixed by 10dd2b865393 ("drm/amd/display: Fix wrong latency assignment
for VEGA clock levels").

I see a couple "if (!dm_pp_get_clock_levels_by_type_with_latency)"
blocks which would no longer be unconditionally run, but I don't know
enough to even guess at the problem.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1592110


Regards,
Jeremy
