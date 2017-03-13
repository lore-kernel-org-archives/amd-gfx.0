From: Umang Raghuvanshi <u@umangis.me>
Subject: [PATCH 0/1] drm/radeon: Fix GPU lockups for the R7 M270
Date: Mon, 13 Mar 2017 14:18:54 +0530
Message-ID: <20170313084855.10851-1-u@umangis.me>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Umang Raghuvanshi <u@umangis.me>
List-Id: amd-gfx.lists.freedesktop.org

The AMD Radeon R7 M270 card's OpenGL functionality completely broke down in
Linux kernel v4.10. Before v4.10, the card was incorrectly identified as a
Radeon R7 M265 but worked perfectly (possibly due to the similarities between
the two). It should also be noted that this issue is also present in Windows
but is fixed by a vendor-specific driver by AMD which hasn't made its way to
Linux yet.

After bisecting between the v4.9 and v4.10 tags, I discovered that the commit
3a69adfe5617 ("drm/radeon: drop oland quirks") was the culprit. Due to what I
assume as lack of firmware support for the chip, the quirks which were
addressed in the firmware never made it to the card resulting in this.

Specifically, when an OpenGL app was run with DRI_PRIME=1, the GPU would stall
and the kernel logs would fill up with messages like the following:

"GPU lockup (current fence id 0x0000000010e5 last fence id 0x10ed on ring 0)"
"ring 3 stalled for more than 40952msec"

This issue would crop up everytime DRI_PRIME=1 was used and is present across
various applications - everything from natively supported games to glxgears.
When the aforementioned stall would happen, the screen would freeze and the
only solution would be to restart the X server altogether.

The attached commit reverts this change only for the M270 (the values for
identifying it were obtained experimentally and checked across different PCs).
It fixes the issue completely but I strongly believe that a firmware patch
would be a *much* better solution.

Should the need arise, I am willing to provide any additional information that
would help fix this issue.

Umang Raghuvanshi (1):
  drm/radeon: Fix GPU lockups for the R7 M270

 drivers/gpu/drm/radeon/si_dpm.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.12.0

-- 
Cheers,
Umang Raghuvanshi.

P.S: This message was re-sent to all its original recipients because SendGrid
decided to append HTML to it which blocked it from a couple of mailing lists.
Sorry for the inconvenience.
