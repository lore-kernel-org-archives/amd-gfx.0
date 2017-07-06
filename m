From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amdgpu: make arrays pctl0_data and pctl1_data static
Date: Thu,  6 Jul 2017 10:58:04 +0100
Message-ID: <20170706095804.16456-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Jerry.Zhang@amd.com, Alex Xie <AlexBin.Xie@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The arrays pctl0_data and pctl1_data do not need to be in global scope,
so them both static.

Cleans up sparse warnings:
symbol 'pctl0_data' was not declared. Should it be static?
symbol 'pctl1_data' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 9804318f3488..4c079207d699 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -249,7 +249,7 @@ struct pctl_data {
     uint32_t data;
 };
 
-const struct pctl_data pctl0_data[] = {
+static const struct pctl_data pctl0_data[] = {
     {0x0, 0x7a640},
     {0x9, 0x2a64a},
     {0xd, 0x2a680},
@@ -274,7 +274,7 @@ const struct pctl_data pctl0_data[] = {
 #define PCTL0_STCTRL_REG_SAVE_RANGE0_BASE  0xa640
 #define PCTL0_STCTRL_REG_SAVE_RANGE0_LIMIT 0xa833
 
-const struct pctl_data pctl1_data[] = {
+static const struct pctl_data pctl1_data[] = {
     {0x0, 0x39a000},
     {0x3b, 0x44a040},
     {0x81, 0x2a08d},
-- 
2.11.0
