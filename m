From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 0/2] drm/amd/dm: Misc MST connector fixes
Date: Fri, 16 Nov 2018 18:24:37 -0500
Message-ID: <20181116232443.1709-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Jerry Zuo <Jerry.Zuo@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@linux.ie>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, Roman Li <roman.li@amd.com>, dri-devel@lists.freedesktop.org, "David (ChunMing) Zhou" <david1.zhou@amd.com>, Shirish S <shirish.s@amd.com>, "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>, Lyude Paul <lyude@redhat.com>, Tony Cheng <tony.cheng@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Some fixes for things I spotted after trying to look at a bug Jerry Zuo
mentioned to me. Didn't manage to reproduce the bug! But I found these.

Cc: Jerry Zuo <Jerry.Zuo@amd.com>

Lyude Paul (2):
  drm/amd/dm: Don't forget to attach MST encoders
  drm/amd/dm: Understand why attaching path/tile properties are needed

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.19.1
