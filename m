From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsigned variable compared to less
 than zero
Date: Mon, 11 Nov 2019 13:27:02 -0600
Message-ID: <cf7d4cfe-be29-39d8-8a5e-bac217475597@embeddedor.com>
References: <20191111172543.GA31748@embeddedor>
 <b5b41653-3536-b0f0-2f49-2c010370ec99@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b5b41653-3536-b0f0-2f49-2c010370ec99@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mikita Lipski <mlipski@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mikita Lipski <mikita.lipski@amd.com>, Lyude Paul <lyude@redhat.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org



On 11/11/19 11:46, Mikita Lipski wrote:
> 
> Thanks for catching it!
> 

Glad to help out. :)

> Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>
> 

Thanks
--
Gustavo

> 
> On 11.11.2019 12:25, Gustavo A. R. Silva wrote:
>> Currenly, the error check below on variable*vcpi_slots*  is always
>> false because it is a uint64_t type variable, hence, the values
>> this variable can hold are never less than zero:
>>
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:
>> 4870         if (dm_new_connector_state->vcpi_slots < 0) {
>> 4871                 DRM_DEBUG_ATOMIC("failed finding vcpi slots: %d\n", (int)dm_new_connector_stat     e->vcpi_slots);
>> 4872                 return dm_new_connector_state->vcpi_slots;
>> 4873         }
>>
>> Fix this by making*vcpi_slots*  of int type
>>
>> Addresses-Coverity: 1487838 ("Unsigned compared against 0")
>> Fixes: b4c578f08378 ("drm/amd/display: Add MST atomic routines")
>> Signed-off-by: Gustavo A. R. Silva<gustavo@embeddedor.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index 6db07e9e33ab..a8fc90a927d6 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -403,7 +403,7 @@ struct dm_connector_state {
>>       bool underscan_enable;
>>       bool freesync_capable;
>>       uint8_t abm_level;
>> -    uint64_t vcpi_slots;
>> +    int vcpi_slots;
>>       uint64_t pbn;
>>   };
>>   -- 2.23.0
> 
