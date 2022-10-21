Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A81BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 13:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A85C10E295;
	Fri, 21 Oct 2022 13:09:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE9010E631
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 08:05:50 +0000 (UTC)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mtxjn0wbFzmVCy;
 Fri, 21 Oct 2022 16:01:01 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:05:20 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:05:19 +0800
Subject: Re: [PATCH 01/11] kset: fix documentation for kset_register()
To: Luben Tuikov <luben.tuikov@amd.com>, <linux-kernel@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <linux-f2fs-devel@lists.sourceforge.net>,
 <linux-erofs@lists.ozlabs.org>, <ocfs2-devel@oss.oracle.com>,
 <linux-mtd@lists.infradead.org>, <amd-gfx@lists.freedesktop.org>,
 <gregkh@linuxfoundation.org>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <20221021022102.2231464-2-yangyingliang@huawei.com>
 <eb0f1459-7980-4a7b-58f9-652eeccc357e@amd.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
Date: Fri, 21 Oct 2022 16:05:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eb0f1459-7980-4a7b-58f9-652eeccc357e@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 21 Oct 2022 13:08:22 +0000
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
Cc: alexander.deucher@amd.com, mst@redhat.com, richard@nod.at, somlo@cmu.edu,
 chao@kernel.org, huangjianan@oppo.com, liushixin2@huawei.com,
 joseph.qi@linux.alibaba.com, jlbec@evilplan.org, jaegeuk@kernel.org,
 rafael@kernel.org, hsiangkao@linux.alibaba.com, akpm@linux-foundation.org,
 mark@fasheh.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022/10/21 13:34, Luben Tuikov wrote:
> On 2022-10-20 22:20, Yang Yingliang wrote:
>> kset_register() is currently used in some places without calling
>> kset_put() in error path, because the callers think it should be
>> kset internal thing to do, but the driver core can not know what
>> caller doing with that memory at times. The memory could be freed
>> both in kset_put() and error path of caller, if it is called in
>> kset_register().
>>
>> So make the function documentation more explicit about calling
>> kset_put() in the error path of caller.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   lib/kobject.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/kobject.c b/lib/kobject.c
>> index a0b2dbfcfa23..6da04353d974 100644
>> --- a/lib/kobject.c
>> +++ b/lib/kobject.c
>> @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
>>   /**
>>    * kset_register() - Initialize and add a kset.
>>    * @k: kset.
>> + *
>> + * If this function returns an error, kset_put() must be called to
>> + * properly clean up the memory associated with the object.
>>    */
> And I'd continue the sentence, with " ... with the object,
> for instance the memory for the kset.kobj.name when kobj_set_name(&kset.kobj, format, ...)
> was called before calling kset_register()."
kobject_cleanup() not only frees name, but aslo calls ->release() to 
free another resources.
>
> This makes it clear what we want to make sure is freed, in case of an early error
> from kset_register().

How about like this:

If this function returns an error, kset_put() must be called to clean up the name of
kset object and other memory associated with the object.

>
> Regards,
> Luben
>
>>   int kset_register(struct kset *k)
>>   {
> .
