From: Yizhuo Zhai <yzhai003@ucr.edu>
Subject: Potential NULL pointer deference in drm/amdgpu
Date: Wed, 9 Oct 2019 22:09:32 -0700
Message-ID: <CABvMjLQuxeZnRMV0T5VDeEj7zV7mD4wzp5QPFCJ_oVhH0vRihQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Evan Quan <evan.quan@amd.com>, Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>, Chengyu Song <csong@cs.ucr.edu>
List-Id: amd-gfx.lists.freedesktop.org

Hi All:
drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:
The function to_amdgpu_fence() could return NULL, but callers
in this file does not check the return value but directly dereference it,
which seems potentially unsafe.
Such callers include amdgpu_fence_get_timeline_name(),
amdgpu_fence_enable_signaling() and amdgpu_fence_free().


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
