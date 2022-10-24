Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EE0ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 14:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F4210E7ED;
	Mon, 24 Oct 2022 14:42:57 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E04610E7E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 14:39:49 +0000 (UTC)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MwyJw2YFFz15M0d;
 Mon, 24 Oct 2022 22:34:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 22:39:46 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 22:39:45 +0800
Subject: Re: [PATCH v2] kset: fix memory leak when kset_register() returns
 error
To: Greg KH <gregkh@linuxfoundation.org>
References: <20221024121910.1169801-1-yangyingliang@huawei.com>
 <Y1aYuLmlXBRvMP1Z@kroah.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <8281fc72-948a-162d-6e5f-a9fe29d8ee46@huawei.com>
Date: Mon, 24 Oct 2022 22:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y1aYuLmlXBRvMP1Z@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 24 Oct 2022 14:42:55 +0000
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
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com,
 joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org,
 huangjianan@oppo.com, richard@nod.at, mark@fasheh.com, mst@redhat.com,
 amd-gfx@lists.freedesktop.org, luben.tuikov@amd.com, yangyingliang@huawei.com,
 hsiangkao@linux.alibaba.com, somlo@cmu.edu, chao@kernel.org,
 jlbec@evilplan.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, alexander.deucher@amd.com,
 akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022/10/24 21:52, Greg KH wrote:
> On Mon, Oct 24, 2022 at 08:19:10PM +0800, Yang Yingliang wrote:
>> Inject fault while loading module, kset_register() may fail.
>> If it fails, the name allocated by kobject_set_name() which
>> is called before kset_register() is leaked, because refcount
>> of kobject is hold in kset_init().
>>
>> As a kset may be embedded in a larger structure which needs
>> be freed in release() function or error path in callers, we
>> can not call kset_put() in kset_register(), or it will cause
>> double free, so just call kfree_const() to free the name and
>> set it to NULL.
>>
>> With this fix, the callers don't need to care about the name
>> freeing and call an extra kset_put() if kset_register() fails.
>>
>> Suggested-by: Luben Tuikov <luben.tuikov@amd.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> v1 -> v2:
>>    Free name inside of kset_register() instead of calling kset_put()
>>    in drivers.
>> ---
>>   lib/kobject.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/kobject.c b/lib/kobject.c
>> index a0b2dbfcfa23..3409a89c81e5 100644
>> --- a/lib/kobject.c
>> +++ b/lib/kobject.c
>> @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
>>   /**
>>    * kset_register() - Initialize and add a kset.
>>    * @k: kset.
>> + *
>> + * NOTE: On error, the kset.kobj.name allocated by() kobj_set_name()
>> + * which is called before kset_register() in caller need be freed.
> This comment doesn't make any sense anymore.  No caller needs to worry
> about this, right?
With this fix, the name is freed inside of kset_register(), it can not 
be accessed,
if it allocated dynamically, but callers don't know this if no comment here,
they may use it in error path (something like to print error message 
with it),
so how about comment like this to tell callers not to use the name:

NOTE: On error, the kset.kobj.name allocated by() kobj_set_name()
is freed, it can not be used any more.
>
>>    */
>>   int kset_register(struct kset *k)
>>   {
>> @@ -844,8 +847,11 @@ int kset_register(struct kset *k)
>>   
>>   	kset_init(k);
>>   	err = kobject_add_internal(&k->kobj);
>> -	if (err)
>> +	if (err) {
>> +		kfree_const(k->kobj.name);
>> +		k->kobj.name = NULL;
> Why are you setting the name here to NULL?
I set it to NULL to avoid accessing bad pointer in callers,
if callers use it in error path, current callers won't use this
name pointer in error path, so we can remove this assignment?

Thanks,
Yang
>
> thanks,
>
> greg k-h
> .
