Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF84C3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 07:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746B110E93C;
	Fri, 26 Jul 2024 07:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BRnk7pem";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370A810E911
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 04:57:59 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7093c94435bso20884a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 21:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721969878; x=1722574678; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P+Pfg22TdHsx3cKNhYWh6gTgA22xrRmaPlTjXn7g0iI=;
 b=BRnk7pemSP+BB6H3Ok6Boqqr2fMWUpx+yO9nRiOZSrHk5T793dYbLZBViQvzaXI+Bb
 7S5dYXWfje7dFeVjzRtBvTZVzCg43cKvWxTBAxlvphtz65Mn6oE0Opgqo7h8Kr7gC/29
 nLMi5hK0UZ1TTHgGlvRvvWKlaLK+IIYPejdkvvyiCfjs3Blx5wNNLe1P7yiJR0vmaLWT
 Q74T4U/AGKnhcmTv3EgXs8mD34OqRXjXk6gAEotmHlZTatNwTjSm4FxizeO+0YW5IsBl
 0oSHw8Pm9+KLAGcN7h1+f62jV/ab0zqqGzEi3gSC8KVHAW8U+RAiE1SdCd/9tQkPqfFy
 LMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721969878; x=1722574678;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+Pfg22TdHsx3cKNhYWh6gTgA22xrRmaPlTjXn7g0iI=;
 b=relQi9jjXyF5g3HaXruZbt8yNJI0NHXvGyw33q7S9c95pf6F/FDbrf598jOlhLQcxy
 FIDs5b8m/Y6cohEvzDYy9ZQFtuUqfpqfZb+iyOEbAadwGGcSEH+qB7Rcd6fIB1Dl4GnM
 zwEoNcP+Q1e7HAsO1tcLiREHXo5p2eUoiRmZfgDVm/O3TIJfOIO1281eZLFW0xFfLlfJ
 4p5La3V15GYWYB2GiXmRY6M7bG5rEFLJvqXY/m5CYtOsO7OfspA6AMlYnFePtMsW73M3
 +vzL1MhGtMYb9llx9PFxM+6z71s/dkV7uTar2x2kegRYvl+Af/H8SH66TQoqgFgc/EGY
 OFtw==
X-Gm-Message-State: AOJu0YwQR8g5TOBRUXdvHO5f+YuzyWJ5VccT6LXPEavqDmH7F5njmrxL
 YdcZ2dKZrR53TEjls6aVzu/cn7cUELzkZwZI8X5s9gHIqAGB8vVAMrVpb0BBVyA=
X-Google-Smtp-Source: AGHT+IE1HoE2T/jpxi2YMybSHE+dNo1z2GvHtOjw7tZQbZrcUn37YtLMZyBTs1rQvywgoiysCSHp8g==
X-Received: by 2002:a05:6830:3887:b0:708:b32f:ade5 with SMTP id
 46e09a7af769-7092e754f12mr7067450a34.32.1721969878297; 
 Thu, 25 Jul 2024 21:57:58 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:71d:9448:a412:cafd])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930787545sm617094a34.74.2024.07.25.21.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 21:57:57 -0700 (PDT)
Date: Thu, 25 Jul 2024 23:57:55 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Philip Yang <Philip.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdkfd: Validate queue cwsr area and eop buffer size
Message-ID: <2598a896-a649-4fdf-af37-cb426fc24db1@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 26 Jul 2024 07:40:26 +0000
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

Hello Philip Yang,

Commit 629568d25fea ("drm/amdkfd: Validate queue cwsr area and eop
buffer size") from Jun 26, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:265 kfd_queue_acquire_buffers()
	warn: missing error code 'err'

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c
    226 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
    227 {
    228         struct kfd_topology_device *topo_dev;
    229         struct amdgpu_vm *vm;
    230         u32 total_cwsr_size;
    231         int err;
    232 
    233         topo_dev = kfd_topology_device_by_id(pdd->dev->id);
    234         if (!topo_dev)
    235                 return -EINVAL;
    236 
    237         vm = drm_priv_to_vm(pdd->drm_priv);
    238         err = amdgpu_bo_reserve(vm->root.bo, false);
    239         if (err)
    240                 return err;
    241 
    242         err = kfd_queue_buffer_get(vm, properties->write_ptr, &properties->wptr_bo, PAGE_SIZE);
    243         if (err)
    244                 goto out_err_unreserve;
    245 
    246         err = kfd_queue_buffer_get(vm, properties->read_ptr, &properties->rptr_bo, PAGE_SIZE);
    247         if (err)
    248                 goto out_err_unreserve;
    249 
    250         err = kfd_queue_buffer_get(vm, (void *)properties->queue_address,
    251                                    &properties->ring_bo, properties->queue_size);
    252         if (err)
    253                 goto out_err_unreserve;
    254 
    255         /* only compute queue requires EOP buffer and CWSR area */
    256         if (properties->type != KFD_QUEUE_TYPE_COMPUTE)
    257                 goto out_unreserve;

This is clearly a success path.

    258 
    259         /* EOP buffer is not required for all ASICs */
    260         if (properties->eop_ring_buffer_address) {
    261                 if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
    262                         pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
    263                                 properties->eop_buf_bo->tbo.base.size,
    264                                 topo_dev->node_props.eop_buffer_size);
--> 265                         goto out_err_unreserve;

This has err in the label name.  err = -EINVAL?

    266                 }
    267                 err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
    268                                            &properties->eop_buf_bo,
    269                                            properties->eop_ring_buffer_size);
    270                 if (err)
    271                         goto out_err_unreserve;
    272         }
    273 
    274         if (properties->ctl_stack_size != topo_dev->node_props.ctl_stack_size) {
    275                 pr_debug("queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
    276                         properties->ctl_stack_size,
    277                         topo_dev->node_props.ctl_stack_size);
    278                 goto out_err_unreserve;

err?

    279         }
    280 
    281         if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
    282                 pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
    283                         properties->ctx_save_restore_area_size,
    284                         topo_dev->node_props.cwsr_size);
    285                 goto out_err_unreserve;

err?  Not sure.

    286         }
    287 
    288         total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
    289                           * NUM_XCC(pdd->dev->xcc_mask);
    290         total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
    291 
    292         err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
    293                                    &properties->cwsr_bo, total_cwsr_size);
    294         if (!err)
    295                 goto out_unreserve;
    296 
    297         amdgpu_bo_unreserve(vm->root.bo);
    298 
    299         err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
    300                                        total_cwsr_size);
    301         if (err)
    302                 goto out_err_release;
    303 
    304         return 0;
    305 
    306 out_unreserve:
    307         amdgpu_bo_unreserve(vm->root.bo);
    308         return 0;
    309 
    310 out_err_unreserve:
    311         amdgpu_bo_unreserve(vm->root.bo);
    312 out_err_release:
    313         kfd_queue_release_buffers(pdd, properties);
    314         return err;
    315 }

regards,
dan carpenter
