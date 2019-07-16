From: JingYi Hou <houjingyi647@gmail.com>
Subject: [PATCH] drm/amdgpu: fix double fetch in
 amdgpu_ras_debugfs_ctrl_parse_data()
Date: Tue, 16 Jul 2019 04:11:22 -0700
Message-ID: <20190716111122.GA35069@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

In amdgpu_ras_debugfs_ctrl_parse_data(), first fetch str from buf to
get op value, if op == -1 which means no command matched, fetch data
from buf again.

If change buf between two fetches may cause security problems or
unexpected behaivor. amdgpu_ras_debugfs_ctrl_parse_data() was called
by amdgpu_ras_debugfs_ctrl_write() and value of op was used later.

We should check whether data->op == -1 or not after second fetch. if
data->op != -1 means buf changed and should return -EINVAL.

Signed-off-by: JingYi Hou <houjingyi647@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 22bd21efe6b1..845e73e98cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -233,6 +233,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,

 		if (copy_from_user(data, buf, sizeof(*data)))
 			return -EINVAL;
+
+		if(data->op != -1)
+			return -EINVAL;
 	}

 	return 0;
--
2.20.1
