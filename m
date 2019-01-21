From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amdkfd: Fix if preprocessor statement above kfd_fill_iolink_info_for_cpu
Date: Mon, 21 Jan 2019 16:52:15 -0700
Message-ID: <20190121235214.28455-1-natechancellor@gmail.com>
References: <20190121223516.24340-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121223516.24340-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Mark Nutter <Mark.Nutter@arm.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:866:5: warning:
'CONFIG_X86_64' is not defined, evaluates to 0 [-Wundef]
#if CONFIG_X86_64
    ^
1 warning generated.

Fixes: d1c234e2cd10 ("drm/amdkfd: Allow building KFD on ARM64 (v2)")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Resending as I forgot to add the lists...

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 5d85ff341385..2e7c44955f43 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -863,7 +863,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
 	return 0;
 }
 
-#if CONFIG_X86_64
+#ifdef CONFIG_X86_64
 static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
 				uint32_t *num_entries,
 				struct crat_subtype_iolink *sub_type_hdr)
-- 
2.20.1
