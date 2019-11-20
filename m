From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 0/2] fix inappropriate use of declaring variable 'static' in fixed31_32.h
Date: Wed, 20 Nov 2019 21:15:31 +0800
Message-ID: <20191120131533.12720-1-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Jammy.Zhou@amd.com, tianci.yin@amd.com, sam@ravnborg.org, luben.tuikov@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

The first patch remove two set but not used variable.

The second patch make the variables in fixed31_32.h 'global'
instead of 'static'.

yu kuai (2):
  drm/amd/display: remove set but not used variable 'dc_fixpt_e' and
    'dc_fixpt_pi'
  drm/amd/display: make various variables in fixed31_32.h 'global'
    instead of 'static'

 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/fixed31_32.c | 13 +++++++++++++
 .../gpu/drm/amd/display/include/fixed31_32.h   | 18 ++++++++----------
 3 files changed, 22 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/fixed31_32.c

-- 
2.17.2
