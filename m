Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA07C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 13:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B9D10E3AD;
	Mon, 23 Jun 2025 13:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="fvdGYxzY";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3FA310E3AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 13:07:43 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-451d54214adso27575335e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1750684062; x=1751288862;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zn4TgrW4kioehQfpdKSOPjOeEv5U2KEo+3+XZJOvU1I=;
 b=fvdGYxzY0q6UQJoEs4joATngVeU0g6ltUoYaRyRn3u74+CwUx23MDKsAJUY1dZ4uFY
 eeKjYZd6JCft0tzZ8+JjrqKeE1/j85xWkPfzmyCLzzBGbwgsFGvHlX2Xr/D4Kv7PfXRG
 qP4BsGY/+1ECMqharXxXsv0Tp9+AAdO8xT6rtkKFKMEM8WscqwbRESUbS8YXgDwSAZdv
 XFzEFZfl96kqAey9hcOT3tdDPY7l/+OE3Pk3OKAoVsCxyYz2zRx8zHnFzh8Hw4XyFzU6
 0/Ak4YrRkvLaksomvAOsdk1BU5TPPTK/LPu/Uu+BlUhfR9sgDCyVoCm8OkIyQvuvTcHT
 NiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750684062; x=1751288862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zn4TgrW4kioehQfpdKSOPjOeEv5U2KEo+3+XZJOvU1I=;
 b=lGogSqBOJg6552u+yx6ySHcKGAyPnunIfIheR3Qz9ey2ScpebP+hx99guYA/uelfAk
 eI6LwKxon1JkANBr5aQ5Bh0Swn11SNZV5x63G2zhNAMmCJ/FjNOxh02PQz86T0+/ezw3
 A4pQRyBZIiSbsbseD0fY59E9LPHCwguQCL572Ale1Apom1dVzfHmsy70sSy/xEYTs+BP
 uvZkQ95B8orAMd+Ylb6cpIJFTVIGdXZzmHXD25ZPmNCl7r6zV1fk/MQW8KEOjuZtedas
 7GF1STuXOD4R5L7UOoc3LIYnRYUk8v6qmpmiJgDSUG9ybpCwyRnfW5eLBgPssay+7aME
 E1ug==
X-Gm-Message-State: AOJu0YwIAOO88Nh4VZcboO8TeLsfXDsmVcg4Oqq8O1IZexAzj3UK3iB2
 j6tUp4WGN4onkxpiS3d2NW8NZ5s4Sr6DerX5S6PwjBl6foOwoBJIGCSSOXzyafOlu2E=
X-Gm-Gg: ASbGncv0fsEfIfixyZvmD34LHSE8W3TkzQ8gSXUgyTOtUWc2Ay1Gu62eJkISEKVEB8K
 83j+GGB+T1QyggcXVYAaRDIkojgl0l3NCYLWoC0W/zpFGvHA2WEdVBCMLniABRGQ8dBfusoWdWz
 tidRDFDd1NDDDdWLAEGyQjeQYzytPEkXUoD8Ik8TVDpyoTOeN1IZCmru4Jo4BqEfhmGRbykgI35
 uItR+rRX24sAkJjHCT6AAczHwsh7Nf0fG+TIb3krtSHpSg6Xq6EqERqTqhfUcGJG0eDOg7MRQM4
 il3vU5CzgX9eGcx88dlQejj8pr+GPPStJSwXwYVFx3Djq3dtqGAsgJwGKShaXRZ3I6DUsF/nWw6
 U
X-Google-Smtp-Source: AGHT+IHr6QUDQq6xdNeBSBfJD0JLohrLYdQWwMr8VsggbPvo9pNJdLyRl09ME/G0LmwIu9/SAJROiw==
X-Received: by 2002:a05:600c:c48e:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-453659c58d6mr117574365e9.12.1750684061925; 
 Mon, 23 Jun 2025 06:07:41 -0700 (PDT)
Received: from [192.168.0.101] ([81.79.92.254])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646d1391sm110713935e9.9.2025.06.23.06.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 06:07:41 -0700 (PDT)
Message-ID: <067c1b95-9411-437c-9c57-0cc040547ffd@ursulin.net>
Date: Mon, 23 Jun 2025 14:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] drm: add debugfs support on per client-id basis
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, simona@ffwll.ch, tzimmermann@suse.de,
 phasta@kernel.org, dakr@kernel.org
References: <20250618134747.3893138-1-sunil.khatri@amd.com>
 <20250618134747.3893138-2-sunil.khatri@amd.com>
 <d1372124-616b-4bc7-8a5c-50c524bc3e5d@ursulin.net>
 <090b8491-329e-4dd7-9480-cf58fd4477da@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <090b8491-329e-4dd7-9480-cf58fd4477da@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 23/06/2025 11:24, Khatri, Sunil wrote:
> 
> On 6/23/2025 2:58 PM, Tvrtko Ursulin wrote:
>>
>>
>> On 18/06/2025 14:47, Sunil Khatri wrote:
>>> add support to add a directory for each client-id
>>> with root at the dri level. Since the clients are
>>> unique and not just related to one single drm device,
>>> so it makes more sense to add all the client based
>>> nodes with root as dri.
>>>
>>> Also create a symlink back to the parent drm device
>>> from each client.
>>
>> TBH I can see an use case for both clients at DRI level and clients 
>> under DRM devices. I guess you have an use case for global and per 
>> device can be added later if it becomes needed.
>>
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/drm_debugfs.c | 32 ++++++++++++++++++++++++++++++++
>>>   drivers/gpu/drm/drm_file.c    | 10 ++++++++++
>>>   include/drm/drm_debugfs.h     | 12 ++++++++++++
>>>   include/drm/drm_file.h        |  7 +++++++
>>>   4 files changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/ 
>>> drm_debugfs.c
>>> index 5a33ec299c04..875276d5fb9f 100644
>>> --- a/drivers/gpu/drm/drm_debugfs.c
>>> +++ b/drivers/gpu/drm/drm_debugfs.c
>>> @@ -298,6 +298,38 @@ void drm_debugfs_remove_dir(void)
>>>       debugfs_remove(drm_debugfs_root);
>>>   }
>>>   +int drm_debugfs_clients_add(struct drm_file *file)
>>> +{
>>> +    struct drm_device *dev;
>>> +    char *client_dir, *symlink;
>>> +
>>> +    dev = file->minor->dev;
>>
>> FWIW, as dev is only used once and string locals are not overlapping, 
>> you could reduce to a single local variable like char *name and re-use 
>> it. Up to you.
>>
> Let me see what i could do with that. But yes can reduce locals.

Ok.

> regards
> 
> Sunil

Usually when you sign people stop reading. In this case I accidentaly 
spotted there is more below.

> 
>>> +
>>> +    client_dir = kasprintf(GFP_KERNEL, "client-%llu", file->client_id);
>>> +    if (!client_dir)
>>> +        return -ENOMEM;
>>
>> It is a bit more work, but I think a clients/ directory with numerical 
>> client id subdirs would be nicer.
> 
> It was with the id only first but with feedback from Christian i moved 
> it with client-$. Also since we want it in main root directory along 
> with nodes like 0 and 128, it makes sense to differentiate and make a clear
> 
> representation of clients.

I don't mean id only in the root dir, but add a clients subdir in the 
root, where clients subdir contains more subdirs for individual clients. 
Maybe it is personal but for me $dri_root/clients/1/something feels 
nicer, less cluttered and potentially easier to handle in scripts and/or 
code that $dri_root/client-1/something.

> 
>>
>>> +
>>> +    /* Create a debugfs directory for the client in root on drm 
>>> debugfs */
>>> +    file->debugfs_client = debugfs_create_dir(client_dir, 
>>> drm_debugfs_root);
>>> +    kfree(client_dir);
>>> +
>>> +    symlink = kasprintf(GFP_KERNEL, "../%s", dev->unique);
>>> +    if (!symlink)
>>> +        return -ENOMEM;
>>
>> Worth removing the partial construction?
> Ideally it should never fail and but yes makes sense to clean up.
>>
>>> +
>>> +    /* Create a link from client_id to the drm device this client id 
>>> belongs to */
>>> +    debugfs_create_symlink("device", file->debugfs_client, symlink);
>>
>> This can also fail.
> sure. Noted
>>
>>> +    kfree(symlink);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +void drm_debugfs_clients_remove(struct drm_file *file)
>>> +{
>>> +    debugfs_remove_recursive(file->debugfs_client);
>>> +    file->debugfs_client = NULL;
>>> +}
>>> +
>>>   /**
>>>    * drm_debugfs_dev_init - create debugfs directory for the device
>>>    * @dev: the device which we want to create the directory for
>>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>>> index 06ba6dcbf5ae..8502c5a630b1 100644
>>> --- a/drivers/gpu/drm/drm_file.c
>>> +++ b/drivers/gpu/drm/drm_file.c
>>> @@ -39,12 +39,14 @@
>>>   #include <linux/poll.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/vga_switcheroo.h>
>>> +#include <linux/debugfs.h>
>>>     #include <drm/drm_client_event.h>
>>>   #include <drm/drm_drv.h>
>>>   #include <drm/drm_file.h>
>>>   #include <drm/drm_gem.h>
>>>   #include <drm/drm_print.h>
>>> +#include <drm/drm_debugfs.h>
>>>     #include "drm_crtc_internal.h"
>>>   #include "drm_internal.h"
>>> @@ -143,6 +145,13 @@ struct drm_file *drm_file_alloc(struct drm_minor 
>>> *minor)
>>>       rcu_assign_pointer(file->pid, get_pid(task_tgid(current)));
>>>       file->minor = minor;
>>>   +    ret = drm_debugfs_clients_add(file);
>>
>> Slightly tricky part is that as soon as this runs userspace can enter 
>> debugfs. If in the future any debufs clients file is added which can 
>> dereference any of the drm_file fields not yet initialized it has the 
>> potential to explode and/or be exploited.
>>
>> Hence I think to be safe the usual pattern of exposing drm_file to 
>> userspace at the end, only _after_ drm_file has been *fully* initialized.
>>
>> Slightly annoying part with that might be undoing dev->driver->open() 
>> but maybe it is not that bad.
> 
> I need this before driver open as the entry is accessed in driver->open 
> in amdgpu to add files to the directory.
> 
> So, i could see to move it just before the open but not after. Anyways 
> if we reach till driver open surely file is fully initialized. Nothing 
> else is done in that function after that.

I guess it is fine as long as dev->driver->open() will be the only place 
which will be adding files. If one day DRM core decides to add some 
common file it will need to make things it can dereference are fully 
initialized.

Perhaps what makes sense today to make this more robust, and it is not 
hard, is to simply move drm_debugfs_clients_add to just before 
dev->driver->open()?

> 
>>
>>> +    if (ret) {
>>> +        put_pid(rcu_access_pointer(file->pid));
>>> +        kfree(file);
>>> +        return ERR_PTR(ret);
>>
>> Onion unwind already exists in the function so could have used it. 
>> (Add a new label and here simply "goto out_put_pid".) But as above we 
>> discuss tweaking the order lets see how that goes first.
> Sure.
>>
>>> +    }
>>> +
>>>       /* for compatibility root is always authenticated */
>>>       file->authenticated = capable(CAP_SYS_ADMIN);
>>>   @@ -236,6 +245,7 @@ void drm_file_free(struct drm_file *file)
>>>                atomic_read(&dev->open_count));
>>>         drm_events_release(file);
>>> +    drm_debugfs_clients_remove(file);
>>>         if (drm_core_check_feature(dev, DRIVER_MODESET)) {
>>>           drm_fb_release(file);
>>> diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
>>> index cf06cee4343f..4bd6cc1d0900 100644
>>> --- a/include/drm/drm_debugfs.h
>>> +++ b/include/drm/drm_debugfs.h
>>> @@ -153,6 +153,9 @@ void drm_debugfs_add_files(struct drm_device *dev,
>>>     int drm_debugfs_gpuva_info(struct seq_file *m,
>>>                  struct drm_gpuvm *gpuvm);
>>> +
>>> +int drm_debugfs_clients_add(struct drm_file *file);
>>> +void drm_debugfs_clients_remove(struct drm_file *file);
>>>   #else
>>>   static inline void drm_debugfs_create_files(const struct 
>>> drm_info_list *files,
>>>                           int count, struct dentry *root,
>>> @@ -181,6 +184,15 @@ static inline int drm_debugfs_gpuva_info(struct 
>>> seq_file *m,
>>>   {
>>>       return 0;
>>>   }
>>> +
>>> +int drm_debugfs_clients_add(struct drm_file *file)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +void drm_debugfs_clients_remove(struct drm_file *file)
>>> +{
>>> +}
>>
>> Static inline for the two above.
> Noted
>>
>>>   #endif
>>>     #endif /* _DRM_DEBUGFS_H_ */
>>> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
>>> index 5c3b2aa3e69d..eab7546aad79 100644
>>> --- a/include/drm/drm_file.h
>>> +++ b/include/drm/drm_file.h
>>> @@ -400,6 +400,13 @@ struct drm_file {
>>>        * @client_name_lock: Protects @client_name.
>>>        */
>>>       struct mutex client_name_lock;
>>> +
>>> +    /**
>>> +     * @debugfs_client:
>>> +     *
>>> +     * debugfs directory for each client under a drm node.
>>> +     */
>>> +    struct dentry *debugfs_client;
>>
>> Is it worth idefing this out if !CONFIG_DEBUG_FS?
> 
> Surprisingly i dont see CONFIG_DEBUG_FS used in drm much.  So keeping it 
> same for this one variable too. Need a whole new change to keep debugfs 
> related things under the if.

Ah struct drm_device.. I see what you mean. I guess the waste if 
progressively worse as the unused fields move from structs with fewer 
instances to ones which can be a lot more.

Regards,

Tvrtko

> 
> Regards
> Sunil Khatri
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>   };
>>>     /**
>>

