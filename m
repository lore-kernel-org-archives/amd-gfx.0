Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEF8CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 16:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5470010E9FD;
	Thu, 30 Oct 2025 16:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KttJkeXX";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CB110E9FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 16:15:49 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4ed0d6d3144so11771371cf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761840948; x=1762445748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cNSEPV58qZhIqk3ynDXSyhptUAhiFI23pm/2SdUBgBQ=;
 b=KttJkeXX3aHAsX+ZJJraFYx4HMmdV6ifqyaXquj/WxJNWta9aoKT2qhnCozpJwaGZS
 XY5tW1q/HcS1qAvcWR5agAYorpEBVxka0UniyUpcSRP7vdh+Sj9Yxw/4XvNwjTy5VA/1
 /AWuyNXe/AJtmjVyjlhuTsgSEqlOQby2LhHMTnValuWDCFpP/u2RIpv5VClHc+DGgG2j
 7VDFWpYyDFHj01ZWnHuCKUq+Pg+tEOnrzyCHruQ0EGw9HAmUYnnlgGcocxbqHosNUD6S
 jZQ+QswsC/YjoTg3OoPBndqWFe7PHb1QmbgCkT8FLqunPXZXZhyvvImi0XoIeXUQzMZu
 ErOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761840948; x=1762445748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cNSEPV58qZhIqk3ynDXSyhptUAhiFI23pm/2SdUBgBQ=;
 b=d2+8Qmdf2YPFAgcVicIEEK1fMAEq/k84s6YqogPbVe9Wm9KiB8bhpZWaOzNzzXwjzE
 n/Lf2kMkV93N/LjsyzmkIO3t8my2K8jdhMNK7KSSy/N0vxqfNoUc99eB0G8BHP8Eiye+
 TxdX90a+i0mESCyytKy1mHEL+UEHDbaavv6uhIdl/UixBvp3P2XkV1lJaf3v6b0hBS0v
 GwbO6C6sSa85ZUtYKo+jSvtmnsu9fo32bUyobTGf4JYNc89nHnegFAvpXS1HuQpDpH8W
 6gwaBIdP3ZZFZ60HAX1+xNHZzKLuxQap49rQHJTMTonGoeM/YCeH9nY7Wkpt0tWa/RzQ
 x5OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjjkpuGs6GbwL0+D9M3lWl6jOi0xAhMJPKo9B0HrK/DAnF4svOOH6C9VgDTPTu+BhlsPaP5Itw@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0t57DtRAmXINdDg8u431fmfwUTf1Qpnzj8ba0eS6x2rjl563I
 7bzHdO3hFaZIY1vioF8UmhTHAWT5IzN4/QAJXrxf+VgHjNRDVkKUeL61
X-Gm-Gg: ASbGncvaq6tR4rIB/ub631a159XmayFKEqpiLYkuXkZ552JNKB3H/TqLuBpmcRK433K
 bk7HU4Pxt5ABWMB5pAIPg4vMfDnE/WER+FZXCewdvWzV/KqR1WHr8CkazN7aZZp0V6zsAsKcjnD
 WBia0dHo2ArgoibLJ1xXUofW5bHzIOT/5XypHR8ydLFutd9r3C2qvmXxnZSHrnI9iaiiojMwhBE
 rgQEPPHnokyuWUcsX89S8Sx89pZyXDSysw+KQ3HXGMrc+jTtuTHmObwTwEadMONGzMSgRmugw+8
 K7b4reESDfxx7U+TK/MM7TnolYNJCCcs1S1lQhtk44cuxQ3G5A3txnI8ZKpCOUghIHj9igXMgWZ
 WFoBToVllKKtiLPUqWkQz42+n+Q8fuMaP1n+9UOTL3akzmUGvmglk4yCVZ0cRxxJDGfXwX3/WhU
 kOvYAQ9IYQvLiEqTHZz+pXyCebFdtZV5Dnv7pHEGPhpw==
X-Google-Smtp-Source: AGHT+IEsPUUk04nyW+mDO4YtEGeUASmWU4z/53mKaMnSC+RUbGZ2KsaqcB0/z223m4ltVP77RKF/Dg==
X-Received: by 2002:a05:622a:198b:b0:4ec:f001:e186 with SMTP id
 d75a77b69052e-4ed31055b54mr1652151cf.62.1761840948223; 
 Thu, 30 Oct 2025 09:15:48 -0700 (PDT)
Received: from [10.254.120.28] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc51e3809sm117002796d6.26.2025.10.30.09.15.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:15:47 -0700 (PDT)
Message-ID: <052b10b1-00ac-4a2e-99c1-3433f2ea4513@gmail.com>
Date: Thu, 30 Oct 2025 17:15:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Zhu Lingshan <lingshan.zhu@amd.com>, felix.kuehling@amd.com,
 alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
 <050ba477-c7d5-4420-8f06-6fce0db48726@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <050ba477-c7d5-4420-8f06-6fce0db48726@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/30/25 16:53, Chen, Xiaogang wrote:
> 
> On 10/29/2025 10:45 PM, Zhu Lingshan wrote:
>> The pasid is a per-process-per-device attribute,
>> therefore this commit implements per
>> struct kfd_process_device->pasid in sysfs
> This per device pasid is used internally in kfd, not used at user space. So no need to exposing it.

Agree completely, the PASID is a technical attribute we use internally in the kernel and should not expose to userspace at all.

Maybe in debugfs to narrow down problems, but certainly not in sysfs. That would make the internal handling an uAPI and so not changeable any more.

Regards,
Christian.

>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>>   2 files changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 70ef051511bb..6a3cfeccacd8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -864,6 +864,8 @@ struct kfd_process_device {
>>       bool has_reset_queue;
>>         u32 pasid;
>> +    char pasid_filename[MAX_SYSFS_FILENAME_LEN];
>> +    struct attribute attr_pasid;
>>   };
>>     #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
>> @@ -983,7 +985,6 @@ struct kfd_process {
>>       /* Kobj for our procfs */
>>       struct kobject *kobj;
>>       struct kobject *kobj_queues;
>> -    struct attribute attr_pasid;
> We keep it to have use space tools(ex rocm-smi) work as the tools still read it before they change.
>>         /* Keep track cwsr init */
>>       bool has_cwsr;
>> @@ -1100,12 +1101,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>>                       int handle);
>>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>>   -/* PASIDs */
>> -int kfd_pasid_init(void);
>> -void kfd_pasid_exit(void);
>> -u32 kfd_pasid_alloc(void);
>> -void kfd_pasid_free(u32 pasid);
> This part is right, these declarations were forgotten to remove.
>> -
>>   /* Doorbells */
>>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>>   int kfd_doorbell_init(struct kfd_dev *kfd);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index ddfe30c13e9d..24cf3b250b37 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>>                      char *buffer)
>>   {
>> -    if (strcmp(attr->name, "pasid") == 0)
>> -        return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
> 
> Same as above we keep it to have compatibility with current tools.
> 
>  Regards
> 
> Xiaogang
> 
>> -    else if (strncmp(attr->name, "vram_", 5) == 0) {
>> +    if (strncmp(attr->name, "pasid_", 6) == 0) {
>> +        struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>> +                                  attr_pasid);
>> +        return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
>> +    } else if (strncmp(attr->name, "vram_", 5) == 0) {
>>           struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>>                                     attr_vram);
>>           return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
>> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>>        * Create sysfs files for each GPU:
>>        * - proc/<pid>/vram_<gpuid>
>>        * - proc/<pid>/sdma_<gpuid>
>> +     * - proc/<pid>/pasid_<gpuid>
>>        */
>>       for (i = 0; i < p->n_pdds; i++) {
>>           struct kfd_process_device *pdd = p->pdds[i];
>> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>>                pdd->dev->id);
>>           kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>>                           pdd->sdma_filename);
>> +
>> +        snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN, "pasid_%u",
>> +             pdd->dev->id);
>> +        kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid, pdd->pasid_filename);
>>       }
>>   }
>>   @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>               goto out;
>>           }
>>   -        kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
>> -                      "pasid");
>> -
>>           process->kobj_queues = kobject_create_and_add("queues",
>>                               process->kobj);
>>           if (!process->kobj_queues)
>> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>>       if (!p->kobj)
>>           return;
>>   -    sysfs_remove_file(p->kobj, &p->attr_pasid);
>>       kobject_del(p->kobj_queues);
>>       kobject_put(p->kobj_queues);
>>       p->kobj_queues = NULL;
>> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>>             sysfs_remove_file(p->kobj, &pdd->attr_vram);
>>           sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>> +        sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>>             sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>>           if (pdd->dev->kfd2kgd->get_cu_occupancy)

