Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D8E909D3
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8237310E516;
	Tue, 17 Feb 2026 16:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="Mr4HPy7q";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="xImIZDLr";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A6C10E515
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1771346290;
 bh=BSEjUYJSOicR1z+WnJOG/Qz
 mo24H96F2B6PgvcRqkDk=; b=Mr4HPy7qhbK2N2QWxCqxW8QxsTRUoZEwOpI7aqGM/2W15mqiaV
 POOGqVGM1svGJGDgSwEF1xnavCMn8DBWX1gg+UhIUz6xIFOo36Kq9m/QTQ2050gvURc/3ksbOFS
 K2DZJlU0FkIzzmp7+cVnmP3RO6fevSg2lqFyIldsAmAHkDTZsknqhvrjWmVWsFZeDPQ159hOV2J
 dQNfpf2nJig92fwB9f0PLcwz58cUjSJa68KsL5HP0kFlbUzKskApJdFfvhZRNjVUVWG3C1fpwFN
 aYGIAkdD8+WGnMFJ7buJJ0Xr+CWZoRVk766Mog9ldlb7ecFmBGOhvGBJQNXLOoInDBw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1771346290; bh=BSEjUYJSOicR1z+WnJOG/Qz
 mo24H96F2B6PgvcRqkDk=; b=xImIZDLrcKWoRpx1kMwMsLerqZdarUQaLmBr/AT91m1I/0SZCj
 RuEfZcbbAFePgUqOVxqaDrYvLP8fkBJggkDQ==;
Message-ID: <78b10f62-60d1-4dee-94a0-fa2eaf139cb6@damsy.net>
Date: Tue, 17 Feb 2026 17:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] drm/amdgpu: dump job ibs in the devcoredump
To: Alex Deucher <alexdeucher@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
 <20260211102657.4180-6-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_Ndh2zaQ5VcoA1jNjAohkurqofd5_TweCfX+iaKz9h+vA@mail.gmail.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <CADnq5_Ndh2zaQ5VcoA1jNjAohkurqofd5_TweCfX+iaKz9h+vA@mail.gmail.com>
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



Le 17/02/2026 à 17:20, Alex Deucher a écrit :
> On Wed, Feb 11, 2026 at 6:07 AM Pierre-Eric Pelloux-Prayer
> <pierre-eric.pelloux-prayer@amd.com> wrote:
>>
>> Now that we have a worker thread, we can try to access the
>> IBs of the job. The process is:
>> * get the VM from the PASID
>> * get the BO from its VA and the VM
>> * map the BO for CPU access
>> * copy everything, then add it to the dump
>> Each step can fail so we have to be cautious.
>> These operations can be slow so when amdgpu_devcoredump_format
>> is called only to determine the size of the buffer we skip all
>> of them and assume they will succeed.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 84 ++++++++++++++++++-
>>   1 file changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> index d0af8a294abf..d576518c212d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> @@ -200,12 +200,20 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>>   static ssize_t
>>   amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_info *coredump)
>>   {
>> +       struct amdgpu_device *adev = coredump->adev;
>>          struct drm_printer p;
>>          struct drm_print_iterator iter;
>>          struct amdgpu_vm_fault_info *fault_info;
>> +       struct amdgpu_bo_va_mapping *mapping;
>>          struct amdgpu_ip_block *ip_block;
>> +       struct amdgpu_res_cursor cursor;
>> +       struct amdgpu_bo *abo, *root;
>> +       uint64_t va_start, offset;
>>          struct amdgpu_ring *ring;
>> -       int ver, i, j;
>> +       struct amdgpu_vm *vm;
>> +       u32 *ib_content;
>> +       uint8_t *kptr;
>> +       int ver, i, j, r;
>>          u32 ring_idx, off;
>>
>>          iter.data = buffer;
>> @@ -323,6 +331,80 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
>>          else if (coredump->reset_vram_lost)
>>                  drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>
>> +       if (coredump->num_ibs) {
>> +               if (buffer)
>> +                       vm = amdgpu_vm_lock_by_pasid(adev, &root, coredump->pasid);
>> +               else
>> +                       vm = NULL;
> 
> Is there any point in doing the loop if the vm is NULL?

Yes : when doing the first pass to size the final buffer I skip the 
buffers mapping + read operations that might be slow and instead just 
account for the outputting of ib_size_dw dwords.

>
>> +
>> +               for (int i = 0; i < coredump->num_ibs && (!buffer || vm); i++) {
>> +                       ib_content = kvmalloc_array(coredump->ibs[i].ib_size_dw, 4,
>> +                                                   GFP_KERNEL);
> 
> Shouldn't this be GFP_NOWAIT?

This is executed by a worker so GFP_KERNEL should be ok?

Pierre-Eric

> 
> Alex
> 
>> +                       if (!ib_content)
>> +                               continue;
>> +
>> +                       if (!vm)
>> +                               goto output_ib_content;
>> +
>> +                       va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
>> +                       mapping = amdgpu_vm_bo_lookup_mapping(vm, va_start / AMDGPU_GPU_PAGE_SIZE);
>> +                       if (!mapping)
>> +                               goto free_ib_content;
>> +
>> +                       offset = va_start - (mapping->start * AMDGPU_GPU_PAGE_SIZE);
>> +                       abo = amdgpu_bo_ref(mapping->bo_va->base.bo);
>> +                       r = amdgpu_bo_reserve(abo, false);
>> +                       if (r)
>> +                               goto free_ib_content;
>> +
>> +                       if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
>> +                               off = 0;
>> +
>> +                               if (abo->tbo.resource->mem_type != TTM_PL_VRAM)
>> +                                       goto unreserve_abo;
>> +
>> +                               amdgpu_res_first(abo->tbo.resource, offset,
>> +                                                coredump->ibs[i].ib_size_dw * 4,
>> +                                                &cursor);
>> +                               while (cursor.remaining) {
>> +                                       amdgpu_device_mm_access(adev, cursor.start / 4,
>> +                                                               &ib_content[off], cursor.size / 4,
>> +                                                               false);
>> +                                       off += cursor.size;
>> +                                       amdgpu_res_next(&cursor, cursor.size);
>> +                               }
>> +                       } else {
>> +                               r = ttm_bo_kmap(&abo->tbo, 0,
>> +                                               PFN_UP(abo->tbo.base.size),
>> +                                               &abo->kmap);
>> +                               if (r)
>> +                                       goto unreserve_abo;
>> +
>> +                               kptr = amdgpu_bo_kptr(abo);
>> +                               kptr += offset;
>> +                               memcpy(ib_content, kptr,
>> +                                      coredump->ibs[i].ib_size_dw * 4);
>> +
>> +                               amdgpu_bo_kunmap(abo);
>> +                       }
>> +
>> +output_ib_content:
>> +                       drm_printf(&p, "\nIB #%d 0x%llx %d dw\n",
>> +                                  i, coredump->ibs[i].gpu_addr, coredump->ibs[i].ib_size_dw);
>> +                       for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
>> +                               drm_printf(&p, "0x%08x\n", ib_content[j]);
>> +unreserve_abo:
>> +                       if (vm)
>> +                               amdgpu_bo_unreserve(abo);
>> +free_ib_content:
>> +                       kfree(ib_content);
>> +               }
>> +               if (vm) {
>> +                       amdgpu_bo_unreserve(root);
>> +                       amdgpu_bo_unref(&root);
>> +               }
>> +       }
>> +
>>          return count - iter.remain;
>>   }
>>
>> --
>> 2.43.0
>>
