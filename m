From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] drm/amdkfd: Use ARRAY_SIZE macro in
 kfd_build_sysfs_node_entry
Date: Wed, 14 Feb 2018 15:30:03 -0600
Message-ID: <422e897f-4b65-10f6-4184-36b78b6ea274@embeddedor.com>
References: <20180119003955.GA28885@embeddedor.com>
 <1fea2528-11a5-0210-6350-e916ebfebbdf@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1fea2528-11a5-0210-6350-e916ebfebbdf@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Kuehling <felix.kuehling@amd.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi all,

I was just wondering about the status of this patch.

Thanks
--
Gustavo

On 01/19/2018 04:18 PM, Felix Kuehling wrote:
> Looks good. This change is Reviewed-by: Felix Kuehling
> <Felix.Kuehling@amd.com>
> 
> Regards,
>    Felix
> 
> 
> On 2018-01-18 07:39 PM, Gustavo A. R. Silva wrote:
>> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index c6a7609..7783250 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -677,7 +677,7 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>>   	}
>>   
>>   	/* All hardware blocks have the same number of attributes. */
>> -	num_attrs = sizeof(perf_attr_iommu)/sizeof(struct kfd_perf_attr);
>> +	num_attrs = ARRAY_SIZE(perf_attr_iommu);
>>   	list_for_each_entry(perf, &dev->perf_props, list) {
>>   		perf->attr_group = kzalloc(sizeof(struct kfd_perf_attr)
>>   			* num_attrs + sizeof(struct attribute_group),
> 
