From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [gpu-drm-radeon] question about potential dead code in
 vce_v2_0_enable_mgcg()
Date: Wed, 28 Jun 2017 09:22:29 -0500
Message-ID: <20170628092229.Horde.Hsk18WJyYojTJE5OKzhVd3d@gator4166.hostgator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org


Hello everybody,

While looking into Coverity ID 1198635 I ran into the following piece  
of code at drivers/gpu/drm/radeon/vce_v2_0.c:107:

107void vce_v2_0_enable_mgcg(struct radeon_device *rdev, bool enable)
108{
109        bool sw_cg = false;
110
111        if (enable && (rdev->cg_flags & RADEON_CG_SUPPORT_VCE_MGCG)) {
112                if (sw_cg)
113                        vce_v2_0_set_sw_cg(rdev, true);
114                else
115                        vce_v2_0_set_dyn_cg(rdev, true);
116        } else {
117                vce_v2_0_disable_cg(rdev);
118
119                if (sw_cg)
120                        vce_v2_0_set_sw_cg(rdev, false);
121                else
122                        vce_v2_0_set_dyn_cg(rdev, false);
123        }
124}

The issue here is that local variable sw_cg is never updated again  
after its initialization; which cause some code to be logically dead.

My question here is if such variable is there for testing purposes or  
if it is a sort of an old code leftover that should be removed?

In any case I can send a patch to add a comment or remove the dead code.

I'd really appreciate any comments on this.

Thank you!
--
Gustavo A. R. Silva
