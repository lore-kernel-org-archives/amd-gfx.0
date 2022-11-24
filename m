Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C030BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 07:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B40910E255;
	Thu, 24 Nov 2022 07:48:05 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4384F10E255
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 07:48:03 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id z63so1454409ede.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IN8c/GGvFzqj5t5OFQ6idkrf/FbIasWQjhnWhno+4/g=;
 b=muhJisJfz4WGJD9+Fi0013xua+2dRDXZiGkl5wxp9tQiRqViX3iqjJfaNATs3vgeod
 2b3V1IGf5R4iegE6ocxA0p74AJgoe/54kNyKJNww3w96Ld1kv839mnR62PfHxUqpCARn
 2+lweG6Jf7raaMWUiZW16XJU/jYnE/FIPp7JWX/qr6T0sy1l5SNl3938c+LGW1ySh2Is
 IBPlDbmnScz+6Dx58pvGmOS/EBlby99wCB7n/mZI92Y5oGxvo4bBEiI9e+bsa+Otjbhz
 Gxpn3T/29CtLfcgF0IPAoD3yC3BEWOLhF8U1XbOvFCZ0Lg8Bs1J+UwjKdQqab+QcGxcM
 LtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IN8c/GGvFzqj5t5OFQ6idkrf/FbIasWQjhnWhno+4/g=;
 b=TV0OfcI2A0lZONusxbpkseTTVr+Cfp0ZdcKDqtGZmX8uSHYsWHswCs6QBlipWRvPGF
 GBs5qb9dceDSv4knbQNtGVturBdbikBZ2BkQiToeMrkLZw09ENmafXLDiMpbCsOPe0zH
 yxw+x6AQlGgkbInuKpnqRYc/YNr/GayOmvHeiA0t2iBhDjmKjCEs662czhDVzDvledN0
 h4fTDekA/m5jd0KoUNjLA1A7gez5DtdZjlFGwvNJZyRWzIPk8/gyGwdjE58huG1L9cb8
 SYtu8mgo46XznNbvcriS+zrsCP9OXU94r4jUMgmS0IVROJ7XyixZK8rYmqxvpU8v/v/+
 VXfA==
X-Gm-Message-State: ANoB5plgA0VsIMiiKtlkGCjLZKGo81wvM4m022uBm2Erc0zUlrl1qttI
 lzTAYTWgVuXdvOVsDEAw6m0whtrd/RI=
X-Google-Smtp-Source: AA0mqf5n2WT/QArQt+rdg/9fLtZ1rPHS2tVCAUYqZnXKAzRdpGhMaGqTWeufW2ahEY+uk0NpFWSfFg==
X-Received: by 2002:aa7:dc19:0:b0:461:f94:913 with SMTP id
 b25-20020aa7dc19000000b004610f940913mr14153857edu.102.1669276081684; 
 Wed, 23 Nov 2022 23:48:01 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 wl3-20020a170907310300b007b4bc423b41sm127058ejb.190.2022.11.23.23.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Nov 2022 23:48:01 -0800 (PST)
Message-ID: <dea21b09-35ff-a180-7f64-a5b12adcebf1@gmail.com>
Date: Thu, 24 Nov 2022 08:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: add amdgpu vram usage information into
 amdgpu_vram_mm
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20221124054945.3409867-1-KevinYang.Wang@amd.com>
 <7ad77cd9-6c35-1785-6f5a-31397d8432e7@amd.com>
 <PH7PR12MB59978C83CEDB8D1AE8BB8D80820F9@PH7PR12MB5997.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH7PR12MB59978C83CEDB8D1AE8BB8D80820F9@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.11.22 um 08:45 schrieb Wang, Yang(Kevin):
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, November 24, 2022 3:25 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add amdgpu vram usage information into amdgpu_vram_mm
>
> Am 24.11.22 um 06:49 schrieb Yang Wang:
>> add vram usage information into dri debugfs amdgpu_vram_mm node.
>>
>> Background:
>> when amdgpu driver introduces drm buddy allocator, the kernel driver
>> (and developer) is difficult to track the vram usage information.
>>
>> Field:
>> 0xaaaaaaaa-0xbbbbbbbb: vram usaged range.
>> type: kernel, device, sg
>> usage: normal, vm, user
>> domain: C-CPU, G-GTT, V-VRAM, P-PRIV
>> @xxxxx: the address of "amdgpu_bo" object in kernel space.
>> 4096: vram range range.
>>
>> Example:
>> 0x00000003fea68000-0x00000003fea68fff: (type:kernel usage:vm       domain:--V- --V-) @000000001d33dfee 4096 bytes
>> 0x00000003fea69000-0x00000003fea69fff: (type:kernel usage:vm       domain:--V- --V-) @00000000a79155b5 4096 bytes
>> 0x00000003fea6b000-0x00000003fea6bfff: (type:kernel usage:vm       domain:--V- --V-) @0000000038ad633b 4096 bytes
>> 0x00000003fea6c000-0x00000003fea6cfff: (type:device usage:user     domain:--V- --V-) @00000000e302f90b 4096 bytes
>> 0x00000003fea6d000-0x00000003fea6dfff: (type:device usage:user     domain:--V- --V-) @00000000e664c172 4096 bytes
>> 0x00000003fea6e000-0x00000003fea6efff: (type:kernel usage:vm       domain:--V- --V-) @000000004528cb2f 4096 bytes
>> 0x00000003fea6f000-0x00000003fea6ffff: (type:kernel usage:vm       domain:--V- --V-) @00000000a446bdbf 4096 bytes
>> 0x00000003fea70000-0x00000003fea7ffff: (type:device usage:user     domain:--V- --V-) @0000000078fae42f 65536 bytes
>> 0x00000003fead8000-0x00000003feadbfff: (type:kernel usage:normal   domain:--V- --V-) @000000001327b7ff 16384 bytes
>> 0x00000003feadc000-0x00000003feadcfff: (type:kernel usage:normal   domain:--V- --V-) @000000001327b7ff 4096 bytes
>> 0x00000003feadd000-0x00000003feaddfff: (type:kernel usage:normal   domain:--V- --V-) @00000000b9706fc1 4096 bytes
>> 0x00000003feade000-0x00000003feadefff: (type:kernel usage:vm       domain:--V- --V-) @0000000071a25571 4096 bytes
>>
>> Note:
>> although some vram ranges can be merged in the example above, but this
>> can reflect the actual distribution of drm buddy allocator.
> Well completely NAK. This is way to much complexity for simple debugging.
>
> Question is what are your requirements here? E.g. what information do you want and why doesn't the buddy allocator already expose this?
>
> Regards,
> Christian.
>
> [Kevin]:
>
> For KMD debug.
> The DRM buddy interface doesn't provide an interface to query which ranges of ram(resource) are used.
> It is not easy to debug in KMD side if driver create BO fail at specific location.
> and from the view of KMD, the VRAM at some locations has special purposes.
> with this patch, we can know which range of vram are actually used.

Well that's not a good reason to add this complexity. Debugging doesn't 
justify that.

Please work with Arun to add the necessary information to the buddy 
allocator interface.

Regards,
Christian.

>
> Best Regards,
> Kevin
>> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |   6 +-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |   3 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 130 ++++++++++++++++++-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |   1 +
>>    4 files changed, 136 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 90eb07106609..117c754409b3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -53,7 +53,7 @@
>>     *
>>     */
>>
>> -static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>> +void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>    {
>>        struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>
>> @@ -66,7 +66,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>        kvfree(bo);
>>    }
>>
>> -static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>> +void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>>    {
>>        struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>>        struct amdgpu_bo_user *ubo;
>> @@ -76,7 +76,7 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>>        amdgpu_bo_destroy(tbo);
>>    }
>>
>> -static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>> +void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>>    {
>>        struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>        struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 147b79c10cbb..3f6a687309a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -332,6 +332,9 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>>                             struct dma_fence **fence);
>>    uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>>                                            uint32_t domain);
>> +void amdgpu_bo_destroy(struct ttm_buffer_object *tbo); void
>> +amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo); void
>> +amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo);
>>
>>    /*
>>     * sub allocation
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 27159f1d112e..165f4f1a8141 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -23,9 +23,11 @@
>>     */
>>
>>    #include <linux/dma-mapping.h>
>> +#include <linux/interval_tree_generic.h>
>>    #include <drm/ttm/ttm_range_manager.h>
>>
>>    #include "amdgpu.h"
>> +#include "amdgpu_object.h"
>>    #include "amdgpu_vm.h"
>>    #include "amdgpu_res_cursor.h"
>>    #include "amdgpu_atomfirmware.h"
>> @@ -38,6 +40,122 @@ struct amdgpu_vram_reservation {
>>        struct list_head blocks;
>>    };
>>
>> +struct amdgpu_vram_node {
>> +     struct rb_node node;
>> +     u64 start;
>> +     u64 last;
>> +     u64 __subtree_last;
>> +     struct ttm_buffer_object *tbo;
>> +};
>> +
>> +#define START(node) ((node)->start)
>> +#define LAST(node) ((node)->last)
>> +
>> +INTERVAL_TREE_DEFINE(struct amdgpu_vram_node, node, u64, __subtree_last,
>> +                  START, LAST, static, amdgpu_vram_it)
>> +
>> +#undef START
>> +#undef LAST
>> +
>> +#define for_each_vram_mm_node(node, mgr) \
>> +     for (node = amdgpu_vram_it_iter_first(&(mgr)->root, 0, U64_MAX); node; \
>> +          node = amdgpu_vram_it_iter_next(node, 0, U64_MAX))
>> +
>> +static void amdgpu_vram_mm_add_block(struct drm_buddy_block *block,
>> +struct amdgpu_vram_mgr *mgr, struct ttm_buffer_object *tbo) {
>> +     struct amdgpu_vram_node *node;
>> +
>> +     node = kvzalloc(sizeof(*node), GFP_KERNEL);
>> +     if (!node)
>> +             return;
>> +
>> +     node->start = amdgpu_vram_mgr_block_start(block);
>> +     node->last = node->start + amdgpu_vram_mgr_block_size(block) - 1;
>> +     node->tbo = tbo;
>> +
>> +     amdgpu_vram_it_insert(node, &mgr->root); }
>> +
>> +static void amdgpu_vram_mm_remove_block(struct drm_buddy_block
>> +*block, struct amdgpu_vram_mgr *mgr) {
>> +     struct amdgpu_vram_node *node;
>> +     u64 start, last;
>> +
>> +     start = amdgpu_vram_mgr_block_start(block);
>> +     last = start + amdgpu_vram_mgr_block_size(block) - 1;
>> +
>> +     node = amdgpu_vram_it_iter_first(&mgr->root, start, last);
>> +     if (node) {
>> +             amdgpu_vram_it_remove(node, &mgr->root);
>> +             kvfree(node);
>> +     }
>> +}
>> +
>> +static inline const char* ttm_bo_type2str(enum ttm_bo_type type) {
>> +     switch (type) {
>> +     case ttm_bo_type_kernel:
>> +             return "kernel";
>> +     case ttm_bo_type_device:
>> +             return "device";
>> +     case ttm_bo_type_sg:
>> +             return "sg";
>> +     default:
>> +             return "unknow";
>> +     }
>> +}
>> +
>> +static inline const char* amdgpu_vram_domain_str(u32 domain, char
>> +*tmp) {
>> +     int index = 0;
>> +
>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_CPU ? 'C' : '-';
>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_GTT ? 'G' : '-';
>> +     tmp[index++] = domain & AMDGPU_GEM_DOMAIN_VRAM ? 'V' : '-';
>> +     tmp[index++] = domain & (AMDGPU_GEM_DOMAIN_GDS | AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA) ?
>> +             'P' : '-';
>> +     tmp[index++] = '\0';
>> +
>> +     return tmp;
>> +}
>> +
>> +static inline const char* amdgpu_vram_bo_usage(struct
>> +ttm_buffer_object *tbo) {
>> +     if (tbo->destroy == &amdgpu_bo_destroy)
>> +             return "normal";
>> +     else if (tbo->destroy == &amdgpu_bo_user_destroy)
>> +             return "user";
>> +     else if (tbo->destroy == &amdgpu_bo_vm_destroy)
>> +             return "vm";
>> +     else
>> +             return "unknow";
>> +}
>> +
>> +static void amdgpu_vram_mm_debug(struct amdgpu_vram_mgr *mgr, struct
>> +drm_printer *p) {
>> +     struct amdgpu_vram_node *node;
>> +     struct ttm_buffer_object *tbo;
>> +     struct amdgpu_bo *abo;
>> +     char tmp[5];
>> +
>> +     for_each_vram_mm_node(node, mgr) {
>> +             tbo = node->tbo;
>> +             abo = ttm_to_amdgpu_bo(tbo);
>> +             drm_printf(p, "%#018llx-%#018llx:", node->start, node->last);
>> +             if (abo)
>> +                     drm_printf(p, " (type:%-5s usage:%-8s domain:%s %s) @%p",
>> +                                ttm_bo_type2str(tbo->type),
>> +                                amdgpu_vram_bo_usage(tbo),
>> +                                amdgpu_vram_domain_str(abo->preferred_domains, tmp),
>> +                                amdgpu_vram_domain_str(abo->allowed_domains, tmp),
>> +                                abo);
>> +             else
>> +                     drm_printf(p, " (reserved)");
>> +             drm_printf(p, " %llu bytes\n",
>> +                        node->last - node->start + 1);
>> +     }
>> +}
>> +
>>    static inline struct amdgpu_vram_mgr *
>>    to_vram_mgr(struct ttm_resource_manager *man)
>>    {
>> @@ -288,6 +406,7 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
>>                dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
>>                        rsv->start, rsv->size);
>>
>> +             amdgpu_vram_mm_add_block(block, mgr, NULL);
>>                vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
>>                atomic64_add(vis_usage, &mgr->vis_usage);
>>                spin_lock(&man->bdev->lru_lock);
>> @@ -540,6 +659,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>                vres->base.start = max(vres->base.start, start);
>>
>>                vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>> +
>> +             amdgpu_vram_mm_add_block(block, mgr, tbo);
>>        }
>>
>>        if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>> @@ -583,8 +704,10 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>>        uint64_t vis_usage = 0;
>>
>>        mutex_lock(&mgr->lock);
>> -     list_for_each_entry(block, &vres->blocks, link)
>> +     list_for_each_entry(block, &vres->blocks, link) {
>>                vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>> +             amdgpu_vram_mm_remove_block(block, mgr);
>> +     }
>>
>>        amdgpu_vram_mgr_do_reserve(man);
>>
>> @@ -747,6 +870,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>>        drm_printf(printer, "reserved:\n");
>>        list_for_each_entry(block, &mgr->reserved_pages, link)
>>                drm_buddy_block_print(mm, block, printer);
>> +     drm_printf(printer, "vram usage:\n");
>> +     amdgpu_vram_mm_debug(mgr, printer);
>> +
>>        mutex_unlock(&mgr->lock);
>>    }
>>
>> @@ -769,6 +895,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>>        struct ttm_resource_manager *man = &mgr->manager;
>>        int err;
>>
>> +     mgr->root = RB_ROOT_CACHED;
>> +
>>        ttm_resource_manager_init(man, &adev->mman.bdev,
>>                                  adev->gmc.real_vram_size);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>> index 0e04e42cf809..a14c56e1e407 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
>> @@ -28,6 +28,7 @@
>>
>>    struct amdgpu_vram_mgr {
>>        struct ttm_resource_manager manager;
>> +     struct rb_root_cached root;
>>        struct drm_buddy mm;
>>        /* protects access to buffer objects */
>>        struct mutex lock;

