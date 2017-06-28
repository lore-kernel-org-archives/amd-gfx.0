From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [gpu-drm-radeon] question about potential dead code in
 vce_v2_0_enable_mgcg()
Date: Wed, 28 Jun 2017 18:08:43 -0500
Message-ID: <20170628180843.Horde.KKnryIaN7wki5B896j1w8Sa@gator4166.hostgator.com>
References: <20170628092229.Horde.Hsk18WJyYojTJE5OKzhVd3d@gator4166.hostgator.com>
 <BN6PR12MB1652D3DE81BA07C8634AF5D5F7DD0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BN6PR12MB1652D3DE81BA07C8634AF5D5F7DD0@BN6PR12MB1652.namprd12.prod.outlook.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi Alex,

Quoting "Deucher, Alexander" <Alexander.Deucher@amd.com>:

>> -----Original Message-----
>> From: Gustavo A. R. Silva [mailto:garsilva@embeddedor.com]
>> Sent: Wednesday, June 28, 2017 10:22 AM
>> To: Deucher, Alexander; Koenig, Christian; David Airlie
>> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
>> kernel@vger.kernel.org
>> Subject: [gpu-drm-radeon] question about potential dead code in
>> vce_v2_0_enable_mgcg()
>>
>>
>> Hello everybody,
>>
>> While looking into Coverity ID 1198635 I ran into the following piece
>> of code at drivers/gpu/drm/radeon/vce_v2_0.c:107:
>>
>> 107void vce_v2_0_enable_mgcg(struct radeon_device *rdev, bool enable)
>> 108{
>> 109        bool sw_cg = false;
>> 110
>> 111        if (enable && (rdev->cg_flags &
>> RADEON_CG_SUPPORT_VCE_MGCG)) {
>> 112                if (sw_cg)
>> 113                        vce_v2_0_set_sw_cg(rdev, true);
>> 114                else
>> 115                        vce_v2_0_set_dyn_cg(rdev, true);
>> 116        } else {
>> 117                vce_v2_0_disable_cg(rdev);
>> 118
>> 119                if (sw_cg)
>> 120                        vce_v2_0_set_sw_cg(rdev, false);
>> 121                else
>> 122                        vce_v2_0_set_dyn_cg(rdev, false);
>> 123        }
>> 124}
>>
>> The issue here is that local variable sw_cg is never updated again
>> after its initialization; which cause some code to be logically dead.
>>
>> My question here is if such variable is there for testing purposes or
>> if it is a sort of an old code leftover that should be removed?
>>
>> In any case I can send a patch to add a comment or remove the dead code.
>>
>> I'd really appreciate any comments on this.
>
> I wanted to leave the code in for debugging if we ran into problems  
> with dynamic clockgating.
>

Do you mind if I send a patch to add such comment and make it clear  
the purpose of that variable?

--- a/drivers/gpu/drm/radeon/vce_v2_0.c
+++ b/drivers/gpu/drm/radeon/vce_v2_0.c
@@ -104,6 +104,10 @@ static void vce_v2_0_disable_cg(struct  
radeon_device *rdev)
         WREG32(VCE_CGTT_CLK_OVERRIDE, 7);
  }

+/*
+ * Local variable sw_cg is used for debugging purposes, in case we
+ * ran into problems with dynamic clock gating. Don't remove it.
+ */
  void vce_v2_0_enable_mgcg(struct radeon_device *rdev, bool enable)
  {
         bool sw_cg = false;


Thanks for clarifying!
--
Gustavo A. R. Silva
