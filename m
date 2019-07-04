From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 0/7] amdgpu clang warning fixes on next-20190703
Date: Wed,  3 Jul 2019 22:52:11 -0700
Message-ID: <20190704055217.45860-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

Hi all,

I don't do threaded patches very often so if I have messed something up,
please forgive me :)

This series fixes all of the clang warnings that I saw added in
next-20190703. The full list is visible in the gist linked below and
each full individual warning can be seen in the GitHub link in each
patch.

https://gist.github.com/5411af08b96c99b14e60c60800e99a47

All of the warnings are fixed in what I believe is the optimal way but
the enum conversion warnings were the trickiest; please review carefully
as the code paths for some of them have changed (especially in patch 3
and 6).

Thank you!
Nathan
