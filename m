Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91EBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 07:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39BFB10E5D0;
	Fri, 10 Dec 2021 07:22:24 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A446010E657
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 07:22:23 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id c4so13368810wrd.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Dec 2021 23:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=y2CWXJ/56i+lgO9qMBkA0rp5PAMAG0VA0yoZ9pGalPw=;
 b=Qyr2b1HXe1CcvZwX9m4a4uFesmCMrFTMOCLhhSj4mWIfaY2ncNdvrcG56k6W/ibwmQ
 hxloC/GUz75eznFLHZaPxLQow19gw4OyBZhm3KD2LCX0VWpyvItI4jFyknA52oE3C5uf
 qaCEZiYw8aw971n7yOhmdnFzpqXmfw2GyT6c7htQUvw/347450wRBlJkuZNW9nYeqz90
 iFMI9NclKq+9uutEnt1IMKWRo8FfZZYqg7IT3g6OazuhkWcy18kh46VY07/Qm8YDBs03
 3eNrSgNObzK+VpP9G2zygB4/tBsk6WIWhyfsrhvlM/I6e66skMy5dnHuS2moXiwUVvXU
 PvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=y2CWXJ/56i+lgO9qMBkA0rp5PAMAG0VA0yoZ9pGalPw=;
 b=68vfOzuw891GVU1cdbh8WvndK7JL1qcpBwlb9pstlWFvSLNdmGoG6vRPDtjH24tJoI
 /+XlhbB/Emj2HDS5e+dZF9N2xeRPF2+IkSyoGxxsba9gYAcr3ocGWI3KXC5Ssm4+uFiT
 xoX5KPh/GCpDNEaBrh6jCDX7TVFqM1W1o6dbUH1kiWeDVxOdRZxcxinSDhbujQlYFxWh
 9cTDHyr5Ubuh2s04hrqxeRyB/0j95R/ePAGVx6MxveGjeChy0/QTEkC0CgZajr7Lkopr
 dn7Cr2Pif3mmPvBso20tNT9bxb7eqlYwqy5Y70t2X8iPhrWQdvQb6TndUOHsBeycy0tI
 6Otg==
X-Gm-Message-State: AOAM530Pdt/XYdnYq6AaBQfrOTXHADUEww4e4hxIjgComJQXH3av6sk/
 kkskqCb3sozC1WVhMDXUOovJg20XEx4=
X-Google-Smtp-Source: ABdhPJyLLyOUatYpoKNYi3HTwssjvIImQ8fysBmxakOz1VG3RRW0O46ciczU7zwsPshdLXcpfzcaeg==
X-Received: by 2002:adf:8bda:: with SMTP id w26mr11792950wra.534.1639120942102; 
 Thu, 09 Dec 2021 23:22:22 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id g124sm10741645wme.28.2021.12.09.23.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 23:22:21 -0800 (PST)
Subject: Re: [PATCH] drm/amdkfd: explicitly create/destroy queue attributes
 under /sys
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209074918.1555320-1-xiaogang.chen@amd.com>
 <93fd623b-9168-09b6-063c-7ece79c9a00d@amd.com>
 <66721e5c-a5fb-9b8a-4766-e5788bee4ee7@amd.com>
 <25d924e7-95df-662e-7a3d-faa978c4cd6b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <dedee52d-b2e6-c5d7-4807-380aa1990780@gmail.com>
Date: Fri, 10 Dec 2021 08:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <25d924e7-95df-662e-7a3d-faa978c4cd6b@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 09.12.21 um 23:27 schrieb Felix Kuehling:
> Am 2021-12-09 um 5:14 p.m. schrieb Chen, Xiaogang:
>> On 12/9/2021 12:40 PM, Felix Kuehling wrote:
>>> Am 2021-12-09 um 2:49 a.m. schrieb Xiaogang.Chen:
>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>
>>>> When application is about finish it destroys queues it has created by
>>>> an ioctl. Driver deletes queue
>>>> entry(/sys/class/kfd/kfd/proc/pid/queues/queueid/)
>>>> which is directory including this queue all attributes. Low level
>>>> kernel
>>>> code deletes all attributes under this directory. The lock from
>>>> kernel is
>>>> on queue entry, not its attributes. At meantime another user space
>>>> application
>>>> can read the attributes. There is possibility that the application can
>>>> hold/read the attributes while kernel is deleting the queue entry,
>>>> cause
>>>> the application have invalid memory access, then killed by kernel.
>>>>
>>>> Driver changes: explicitly create/destroy each attribute for each
>>>> queue,
>>>> let kernel put lock on each attribute too.
>>> Is this working around a bug in kobject_del? Shouldn't that code take
>>> care of the necessary locking itself?
>>>
>>> Regards,
>>>     Felix
>> The patches do not change kobject/kernfs that are too low level and
>> would involve deeper discussions.
>> Made changes at higher level(kfd) instead.
>>
>> Have tested with MSF tool overnight.
> OK. I'm OK with your changes. The patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> But I think we should let the kernfs folks know that there is a problem
> anyway. It might save someone else a lot of time and headaches down the
> line. Ideally we'd come up with a small reproducer (dummy driver and a
> user mode tool (could just be a bash script)) that doesn't require
> special AMD hardware and the whole ROCm stack.

I think we could do this in the DKMS/release branches, but for upstream 
we should rather fix the underlying problem.

Additional to that this is explicitely what we should not do if I 
understood Greg correctly in previous discussions, but take that with a 
grain of salt since I'm not an expert on the topic.

Regards,
Christian.

>
> Regards,
>    Felix
>
>
>> Thanks
>> Xiaogang
>>
>>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 33
>>>> +++++++-----------------
>>>>    2 files changed, 13 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index 0c3f911e3bf4..045da300749e 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -546,6 +546,9 @@ struct queue {
>>>>          /* procfs */
>>>>        struct kobject kobj;
>>>> +    struct attribute attr_guid;
>>>> +    struct attribute attr_size;
>>>> +    struct attribute attr_type;
>>>>    };
>>>>      enum KFD_MQD_TYPE {
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index 9158f9754a24..04a5638f9196 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -73,6 +73,8 @@ static void evict_process_worker(struct
>>>> work_struct *work);
>>>>    static void restore_process_worker(struct work_struct *work);
>>>>      static void kfd_process_device_destroy_cwsr_dgpu(struct
>>>> kfd_process_device *pdd);
>>>> +static void kfd_sysfs_create_file(struct kobject *kobj, struct
>>>> attribute *attr,
>>>> +                char *name);
>>>>      struct kfd_procfs_tree {
>>>>        struct kobject *kobj;
>>>> @@ -441,35 +443,12 @@ static ssize_t kfd_sysfs_counters_show(struct
>>>> kobject *kobj,
>>>>        return 0;
>>>>    }
>>>>    -static struct attribute attr_queue_size = {
>>>> -    .name = "size",
>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>> -};
>>>> -
>>>> -static struct attribute attr_queue_type = {
>>>> -    .name = "type",
>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>> -};
>>>> -
>>>> -static struct attribute attr_queue_gpuid = {
>>>> -    .name = "gpuid",
>>>> -    .mode = KFD_SYSFS_FILE_MODE
>>>> -};
>>>> -
>>>> -static struct attribute *procfs_queue_attrs[] = {
>>>> -    &attr_queue_size,
>>>> -    &attr_queue_type,
>>>> -    &attr_queue_gpuid,
>>>> -    NULL
>>>> -};
>>>> -
>>>>    static const struct sysfs_ops procfs_queue_ops = {
>>>>        .show = kfd_procfs_queue_show,
>>>>    };
>>>>      static struct kobj_type procfs_queue_type = {
>>>>        .sysfs_ops = &procfs_queue_ops,
>>>> -    .default_attrs = procfs_queue_attrs,
>>>>    };
>>>>      static const struct sysfs_ops procfs_stats_ops = {
>>>> @@ -511,6 +490,10 @@ int kfd_procfs_add_queue(struct queue *q)
>>>>            return ret;
>>>>        }
>>>>    +    kfd_sysfs_create_file(&q->kobj, &q->attr_guid, "guid");
>>>> +    kfd_sysfs_create_file(&q->kobj, &q->attr_size, "size");
>>>> +    kfd_sysfs_create_file(&q->kobj, &q->attr_type, "type");
>>>> +
>>>>        return 0;
>>>>    }
>>>>    @@ -655,6 +638,10 @@ void kfd_procfs_del_queue(struct queue *q)
>>>>        if (!q)
>>>>            return;
>>>>    +    sysfs_remove_file(&q->kobj, &q->attr_guid);
>>>> +    sysfs_remove_file(&q->kobj, &q->attr_size);
>>>> +    sysfs_remove_file(&q->kobj, &q->attr_type);
>>>> +
>>>>        kobject_del(&q->kobj);
>>>>        kobject_put(&q->kobj);
>>>>    }

