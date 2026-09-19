Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED2EC982CC
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Sep 2026 20:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE9B610E15B;
	Sat, 19 Sep 2026 20:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mhtN+xj9";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BFE10E15B
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2026 20:08:25 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e620fa473so10535935e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2026 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789848504; x=1790453304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4zH2coYvkCFk4ebyaBOaXh6iikHxkJzRaCpn2ESsA3w=;
 b=mhtN+xj9lvZYzW5aWjd/Z5ehWMsUMy0bv5qnXhCM/39cmP/n7crfYzFNjGPlkqTKQV
 7uu2fyI4NXCxQwkiLNPBBQtXQHAm6R27MwwGTD1Gt96DHuy2tSoGPYIRrQqPpMhk0qpt
 OFV6lAFNS7Ek+PwmVfUSEUyhwygfZzxjSl/uih2U0xYXCNtKfkG/Jm5x89sA22EUuPqa
 wQTk0qMi/LguzTTSXjKBLgqguxjMRiw8Cc7rL2RMnOtjZEhyqXEFlEBPKAKCpiyX1SHo
 CTcoGKa6wlpA+VWujF8NQVBKUck8ewEdqLJHOpzwPvf0UouBNxilM3o25iCplJgb/tuD
 e2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789848504; x=1790453304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4zH2coYvkCFk4ebyaBOaXh6iikHxkJzRaCpn2ESsA3w=;
 b=zFe0FIKDQSqaNHFBaDXoGUfdKykg8HaAaOMeeixyigXxP+U0rFwDE9XEN4+EiU+LXM
 3WZx73LXtsd2dqNiDj0dapRrW8si2ztI+eSzryJPEcAqUDF9+AufcHQw5x9x2dj92dLl
 vyTuP1CIHdYfwHYDnXrXl692B59qX5QNq0ih4nmcuncpy7OmGILHdOSTkAP4TwFuggSm
 Zb2yzgZyKeH+AzUVocvD+tBHBnN4p1kG3lF29fON3BB5+IX1gPO6gav7E/FZP2n2FlLs
 YJNfl5DeLjRxXrC6Vmwhq+joi/UhXNurrWTBx7yaDL6SAIp0bkTYOnd+ZAy9xNM6HSX0
 3ACQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTbY81b8mGIXFDPJuL9JO2Y0D7EzbIiCmdAgUdmjKoBKzDR/djsWWgVu8VRrGqjDbC4At/odKq@lists.freedesktop.org
X-Gm-Message-State: AFuF++naIL5bwMBaHAj7WNRFVv4I46b2KWE2JjwlHuoxq/nawIDlkA4c
 ojr29anWmHl6DzDkeCcsVPG5x09dZbC6V0VYXWUjT+OvUt7hFko3kqOy
X-Gm-Gg: AYBFou1aKyC8d5BYEuSbFa3t7q2px1xUAq6+nEj9EujxR4davNDyMJcka4D8SQ+vv5i
 Cb6CtKM8IENZdJ4JlJKPsCVOzOSpXLnYa7RKI2H7zJACg/g1qm5lox3afByIQxqGbcRsbB35a/I
 U8/S3i/6pcCRZTDdAnEu+OwYLQei9ITYb+aFQKEnAeAxTHC7IlIoYEqMsIMEmr4C0Evd0Akqxoy
 cH8qi0HeqgQeub9Xvxdu3aij0daAWF7ZPXO6ySND4+t9KgBDM+K4oyXzlI4DYGACxFnPhg1Umm9
 Z2m8X5YztotgtAXXdH1aZKIQ2ZeSmoFa0qzEIA6JRpt/xZOD3BfUmwkeVCQ41FUF7IgrEIeHqWD
 tF8tYz/56L1ptF9AKAPrrvj+4KFs+sP7ZhQlnk3P7WYlGMRAPwZd6Zvhn37fQkMmLZFfjSRnVO/
 S7Pg/on6RmEuqfxH2cnMUTGXpMUU0+FZ4E/+7vlnHKc2A6tuZz8liN6XuaIslW0/qmYmjd1dmP7
 lDAAq7DJXiFVjBXvRLpJQTnHs2PcE40hj6vvNaBChamhl3fJEntP7pMB1J4+l3oBrUAG70=
X-Received: by 2002:a05:600c:1989:b0:49c:e42b:a4ac with SMTP id
 5b1f17b1804b1-49fc5714d14mr89393375e9.11.1789848504060; 
 Sat, 19 Sep 2026 13:08:24 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc56aab7csm115777395e9.1.2026.09.19.13.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 13:08:23 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 George Zhang <george.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [REGRESSION 7.3] drm/amd/display: single-frame scanout corruption
 on DCN32 at 120 Hz since a637a140ab86
Date: Sun, 20 Sep 2026 01:08:20 +0500
Message-ID: <20260919200820.799243-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902073222.206801-1-mikhail.v.gavrilov@gmail.com>
References: <20260902073222.206801-1-mikhail.v.gavrilov@gmail.com>
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

Following up on my own correction: the attribution to a637a140ab86 is back,
and this time on a comparison that does not have the flaw the first one had.

In my previous mail I withdrew the 90x figure because the rate turned out to
depend on the machine's recent load and my two runs had not controlled for
it.  I have now measured the commit against its immediate parent, in matched
conditions, and the difference is there without that confound.

  parent  1d8327353de6 ("drm/amd/display: Fix VABC Init and OLED Support")
  commit  a637a140ab86 ("drm/amd/display: Allocate DCN32/1 dmub memory to GTT")

Same machine, same display, same 3840x2160@120 mode, same .config, ordinary
desktop use, no game in either run, about eleven hours each:

                          parent            commit
  observation             11.0 h            11.6 h
  eligible frames       3,019,571         3,632,444
  events                        7               293
  per 1000 eligible        0.0023            0.0807
  95% interval      0.0006-0.0040     0.0714-0.0899

That is 35x, with the intervals more than a decade apart.

"Events" counts only frames where all three CRC registers moved, which is
what the artefact does.  The single-frame content flicker that moves only
the luma CRC serves as a built-in control, and it did not move with the
kernel: 0.0020 per 1000 on the parent against 0.0008 on the commit.


The load confound does not reach this
-------------------------------------

Both runs began immediately after a reboot, which resets the state, and
neither had any load yet in its first hour:

  parent : 0 events in 434,204 eligible frames
  commit : 52 events in 349,718 eligible frames  (0.149 per 1000)

So the difference is present before anything could have excited it.

The shape differs too, not only the rate.  On the parent the worst
five-minute bucket in eleven hours contained 2 events, and no bucket
reached 3.  On the commit the worst contained 30, and 28 of 138 buckets
reached 3 or more: the excited state comes and goes by itself there, and
on the parent it never appeared at all.

For completeness: the commit run does contain three windows where almost no
frame was eligible - roughly 14:30-15:25, 21:10-21:25 and 23:45-23:55 -
which is what fullscreen content looks like in this data, and the parent run
has no such window.  The first-hour figures above are free of that, and the
rate is normalised per eligible frame throughout, but I would rather point
it out than have it found.


What this does and does not settle
----------------------------------

It restores a637a140ab86 as the point where this starts on DCN3.2.  What I
said in the correction about the state machine still holds and is
independent of it: heavy GPU load excites the artefact, a long spell at
60 Hz or a reboot calms it, and DTN snapshots in the excited state are
byte-identical to quiet-state ones.  Those were measured on kernels that
already contain the commit; the parent simply never leaves the quiet state.

I still have no mechanism.  The commit moves every DMUB FB window out of
VRAM into GTT, and I cannot see how that produces one corrupted scanout
frame while leaving every register in the DTN dump unchanged.

The GitLab issue has been updated with the same numbers:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/5714

#regzbot introduced: a637a140ab86

Thanks,
Mikhail Gavrilov
