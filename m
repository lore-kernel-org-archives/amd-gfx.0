From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu: fix structurally dead code vcn_v2_5_hw_init
Date: Tue, 1 Oct 2019 16:43:20 -0500
Message-ID: <823b10a3-fe0e-2e8c-02c3-534944dbe6d2@embeddedor.com>
References: <20191001171635.GA17306@embeddedor>
 <192815d9-5ecb-09a7-4624-5fd36126890d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <192815d9-5ecb-09a7-4624-5fd36126890d@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Leo" <Leo.Liu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hi,

On 10/1/19 16:29, Liu, Leo wrote:
> 
> On 2019-10-01 1:16 p.m., Gustavo A. R. Silva wrote:
>> Notice that there is a *continue* statement in the middle of the
>> for loop and that prevents the code below from ever being reached:
>>
>> 	r = amdgpu_ring_test_ring(ring);
>> 	if (r) {
>> 		ring->sched.ready = false;
>> 		goto done;
>> 	}
>>
>> Fix this by removing the continue statement and updating ring->sched.ready
>> to true before calling amdgpu_ring_test_ring(ring).
>>
>> Notice that this fix is based on
>> commit 1b61de45dfaf ("drm/amdgpu: add initial VCN2.0 support (v2)")
>>
>> Addresses-Coverity-ID 1485608 ("Structurally dead code")
>> Fixes: 28c17d72072b ("drm/amdgpu: add VCN2.5 basic supports")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>
>> Any feedback is greatly appreciated.
>>
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index 395c2259f979..47b0dcd59e13 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -258,6 +258,7 @@ static int vcn_v2_5_hw_init(void *handle)
>>   		adev->nbio_funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>>   						     ring->doorbell_index, j);
>>   
>> +		ring->sched.ready = true;
> 
> This is redundant. all the sched->ready is initialized as true, please 
> refer to drm_sched_init()
> 

I see... so in the following commit 1b61de45dfaf ("drm/amdgpu: add initial VCN2.0 support (v2)")
that line is also redundant?

> 
>>   		r = amdgpu_ring_test_ring(ring);
>>   		if (r) {
>>   			ring->sched.ready = false;
>> @@ -266,8 +267,7 @@ static int vcn_v2_5_hw_init(void *handle)
>>   
>>   		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>   			ring = &adev->vcn.inst[j].ring_enc[i];
>> -			ring->sched.ready = false;
>> -			continue;
>> +			ring->sched.ready = true;
> 
> Because the VCN 2.5 FW still has issue for encode, so we have it 
> disabled here.
> 

OK. So, maybe we can add a comment pointing that out?

Thanks
--
Gustavo

> 
>>   			r = amdgpu_ring_test_ring(ring);
>>   			if (r) {
>>   				ring->sched.ready = false;
>> @@ -276,6 +276,7 @@ static int vcn_v2_5_hw_init(void *handle)
>>   		}
>>   
>>   		ring = &adev->vcn.inst[j].ring_jpeg;
>> +		ring->sched.ready = true;
>>   		r = amdgpu_ring_test_ring(ring);
>>   		if (r) {
>>   			ring->sched.ready = false;
