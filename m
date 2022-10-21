Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6ACC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 13:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FB110E249;
	Fri, 21 Oct 2022 13:09:01 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B44F10E5F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 07:26:06 +0000 (UTC)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mtwr34fC2zVj5k;
 Fri, 21 Oct 2022 15:21:23 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:25:54 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:25:53 +0800
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
To: Luben Tuikov <luben.tuikov@amd.com>, <linux-kernel@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <linux-f2fs-devel@lists.sourceforge.net>,
 <linux-erofs@lists.ozlabs.org>, <ocfs2-devel@oss.oracle.com>,
 <linux-mtd@lists.infradead.org>, <amd-gfx@lists.freedesktop.org>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <2a99c52c-d29c-5f5c-57a8-9851018e7420@huawei.com>
Date: Fri, 21 Oct 2022 15:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
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
Cc: alexander.deucher@amd.com, richard@nod.at, mst@redhat.com,
 gregkh@linuxfoundation.org, somlo@cmu.edu, chao@kernel.org,
 huangjianan@oppo.com, liushixin2@huawei.com, joseph.qi@linux.alibaba.com,
 jlbec@evilplan.org, hsiangkao@linux.alibaba.com, rafael@kernel.org,
 jaegeuk@kernel.org, akpm@linux-foundation.org, mark@fasheh.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2022/10/21 13:29, Luben Tuikov wrote:
> On 2022-10-20 22:20, Yang Yingliang wrote:
>> The previous discussion link:
>> https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/
> The very first discussion on this was here:
>
> https://www.spinics.net/lists/dri-devel/msg368077.html
>
> Please use this link, and not the that one up there you which quoted above,
> and whose commit description is taken verbatim from the this link.
I found this leaks in 
bus_register()/class_register()/kset_create_and_add() at first, and describe
the reason in these patches which is using kobject_set_name() 
description, here is the patches:

https://lore.kernel.org/lkml/20221017014957.156645-1-yangyingliang@huawei.com/T/
https://lore.kernel.org/lkml/20221017031335.1845383-1-yangyingliang@huawei.com/
https://lore.kernel.org/lkml/Y0zfPKAgQSrYZg5o@kroah.com/T/

And then I found other subsystem also have this problem, so posted the 
fix patches for them
(including qemu_fw_cfg/f2fs/erofs/ocfs2/amdgpu_discovery):

https://www.mail-archive.com/qemu-devel@nongnu.org/msg915553.html
https://lore.kernel.org/linux-f2fs-devel/7908686b-9a7c-b754-d312-d689fc28366e@kernel.org/T/#t
https://lore.kernel.org/linux-erofs/20221018073947.693206-1-yangyingliang@huawei.com/
https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@huawei.com/T/

https://www.spinics.net/lists/dri-devel/msg368092.html
In the amdgpu_discovery patch, I sent a old one which using wrong 
description and you pointer out,
and then I send a v2.

And then the maintainer of ocfs2 has different thought about this, so we 
had a discussion in the link
that I gave out, and Greg suggested me to update kset_register() 
documentation and then put the fix
patches together in one series, so I sent this patchset and use the link.

Thanks,
Yang

>
>> kset_register() is currently used in some places without calling
>> kset_put() in error path, because the callers think it should be
>> kset internal thing to do, but the driver core can not know what
>> caller doing with that memory at times. The memory could be freed
>> both in kset_put() and error path of caller, if it is called in
>> kset_register().
> As I explained in the link above, the reason there's
> a memory leak is that one cannot call kset_register() without
> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
> in this case, i.e. kset_register() fails with -EINVAL.
>
> Thus, the most common usage is something like this:
>
> 	kobj_set_name(&kset->kobj, format, ...);
> 	kset->kobj.kset = parent_kset;
> 	kset->kobj.ktype = ktype;
> 	res = kset_register(kset);
>
> So, what is being leaked, is the memory allocated in kobj_set_name(),
> by the common idiom shown above. This needs to be mentioned in
> the documentation, at least, in case, in the future this is absolved
> in kset_register() redesign, etc.
>
> Regards,
> Luben
>
>> So make the function documentation more explicit about calling
>> kset_put() in the error path of caller first, so that people
>> have a chance to know what to do here, then fixes this leaks
>> by calling kset_put() from callers.
>>
>> Liu Shixin (1):
>>    ubifs: Fix memory leak in ubifs_sysfs_init()
>>
>> Yang Yingliang (10):
>>    kset: fix documentation for kset_register()
>>    kset: add null pointer check in kset_put()
>>    bus: fix possible memory leak in bus_register()
>>    kobject: fix possible memory leak in kset_create_and_add()
>>    class: fix possible memory leak in __class_register()
>>    firmware: qemu_fw_cfg: fix possible memory leak in
>>      fw_cfg_build_symlink()
>>    f2fs: fix possible memory leak in f2fs_init_sysfs()
>>    erofs: fix possible memory leak in erofs_init_sysfs()
>>    ocfs2: possible memory leak in mlog_sys_init()
>>    drm/amdgpu/discovery: fix possible memory leak
>>
>>   drivers/base/bus.c                            | 4 +++-
>>   drivers/base/class.c                          | 6 ++++++
>>   drivers/firmware/qemu_fw_cfg.c                | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++--
>>   fs/erofs/sysfs.c                              | 4 +++-
>>   fs/f2fs/sysfs.c                               | 4 +++-
>>   fs/ocfs2/cluster/masklog.c                    | 7 ++++++-
>>   fs/ubifs/sysfs.c                              | 2 ++
>>   include/linux/kobject.h                       | 3 ++-
>>   lib/kobject.c                                 | 5 ++++-
>>   10 files changed, 33 insertions(+), 9 deletions(-)
>>
> .
