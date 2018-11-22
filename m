From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 28/36] drm/amdgpu: fix bug with IH ring setup
Date: Thu, 22 Nov 2018 14:52:32 -0500
Message-ID: <20181122195240.13123-28-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit c837243ff4017f493c7d6f4ab57278d812a86859 ]

The bug limits the IH ring wptr address to 40bit. When the system memory
is bigger than 1TB, the bus address is more than 40bit, this causes the
interrupt cannot be handled and cleared correctly.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 5ae5ed2e62d6..21bc12e02311 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -129,7 +129,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	else
 		wptr_off = adev->wb.gpu_addr + (adev->irq.ih.wptr_offs * 4);
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO, lower_32_bits(wptr_off));
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI, upper_32_bits(wptr_off) & 0xFF);
+	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI, upper_32_bits(wptr_off) & 0xFFFF);
 
 	/* set rptr, wptr to 0 */
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
-- 
2.17.1
