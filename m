From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] drm/amdkfd: Fix potential NULL pointer dereferences
Date: Wed, 10 Jan 2018 15:58:49 -0600
Message-ID: <20180110155849.Horde.DDGbi3ysasL2eHmvZ4k8adb@gator4166.hostgator.com>
References: <20180110165008.GA10691@embeddedor.com>
 <c4197e6a-ba58-23b9-8fa8-8a9b3ff74ef9@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4197e6a-ba58-23b9-8fa8-8a9b3ff74ef9@amd.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi Felix,

Quoting Felix Kuehling <felix.kuehling@amd.com>:

> Hi Gustavo,
>
> Thanks for catching that. When returning a fault, I think you also need
> to srcu_read_unlock(&kfd_processes_srcu, idx).
>
> However, instead of returning an error, I think I'd prefer to skip PDDs
> that can't be found with continue statements. That way others would
> still suspend and resume successfully. Maybe just print a WARN_ON for
> PDDs that aren't found, because that's an unexpected situation,
> currently. Maybe in the future it could be normal thing if we ever
> support GPU hotplug.
>

I got it. In that case, what do you think about the following patch instead?

index a22fb071..4ff5f0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -461,7 +461,8 @@ int kfd_bind_processes_to_device(struct kfd_dev *dev)
         hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
                 mutex_lock(&p->mutex);
                 pdd = kfd_get_process_device_data(dev, p);
-               if (pdd->bound != PDD_BOUND_SUSPENDED) {
+
+               if (WARN_ON(!pdd) || pdd->bound != PDD_BOUND_SUSPENDED) {
                         mutex_unlock(&p->mutex);
                         continue;
                 }
@@ -501,6 +502,11 @@ void kfd_unbind_processes_from_device(struct  
kfd_dev *dev)
                 mutex_lock(&p->mutex);
                 pdd = kfd_get_process_device_data(dev, p);

+               if (WARN_ON(!pdd)) {
+                       mutex_unlock(&p->mutex);
+                       continue;
+               }
+
                 if (pdd->bound == PDD_BOUND)
                         pdd->bound = PDD_BOUND_SUSPENDED;
                 mutex_unlock(&p->mutex);


Thank you for the feedback.
--
Gustavo

> Regards,
>   Felix
>
>
> On 2018-01-10 11:50 AM, Gustavo A. R. Silva wrote:
>> In case kfd_get_process_device_data returns null, there are some
>> null pointer dereferences in functions kfd_bind_processes_to_device
>> and kfd_unbind_processes_from_device.
>>
>> Fix this by null checking pdd before dereferencing it.
>>
>> Addresses-Coverity-ID: 1463794 ("Dereference null return value")
>> Addresses-Coverity-ID: 1463772 ("Dereference null return value")
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c  
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index a22fb071..29d51d5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -461,6 +461,13 @@ int kfd_bind_processes_to_device(struct kfd_dev *dev)
>>  	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>  		mutex_lock(&p->mutex);
>>  		pdd = kfd_get_process_device_data(dev, p);
>> +
>> +		if (!pdd) {
>> +			pr_err("Process device data doesn't exist\n");
>> +			mutex_unlock(&p->mutex);
>> +			return -EFAULT;
>> +		}
>> +
>>  		if (pdd->bound != PDD_BOUND_SUSPENDED) {
>>  			mutex_unlock(&p->mutex);
>>  			continue;
>> @@ -501,6 +508,11 @@ void kfd_unbind_processes_from_device(struct  
>> kfd_dev *dev)
>>  		mutex_lock(&p->mutex);
>>  		pdd = kfd_get_process_device_data(dev, p);
>>
>> +		if (!pdd) {
>> +			mutex_unlock(&p->mutex);
>> +			return;
>> +		}
>> +
>>  		if (pdd->bound == PDD_BOUND)
>>  			pdd->bound = PDD_BOUND_SUSPENDED;
>>  		mutex_unlock(&p->mutex);
