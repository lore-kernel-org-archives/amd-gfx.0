Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FBDC54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 16:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9008112368;
	Fri, 15 Mar 2024 16:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mHLd+vcN";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D54310F55C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 15:16:14 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-413ef770363so17845095e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515772; x=1711120572; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=29w950Mjo10TxKJfti7sbRRg9YOuroRLPRcz7P9Xo18=;
 b=mHLd+vcNqn4tHrxzOpq26YsDNfEHObYds82iyfAqatO74qiQXRrGjWV8BNtudcEpRe
 RNz+D9CtU5oynV62ypAnvZ+3SB0sAIgyoSnfEqso7p3YaryNpscOJR2OjTUduGPs1jp3
 7N72PG5VGU2axQ13FVY3oUVdtHOJNljof0dqy/BxM14VuyFdpHxfhP6Nk5LyNAUVT3Yr
 xfERpDAXj/oMqd2x+XCwVJ02jP7V/swKj0rqw7Kq8M2eKFsTI3EJwkXhPhJhXSncS4fl
 O292NEnwOHne+1EWFBxWlTW/vDzA/a4i0i7eZJp8RcJjj71ntGCFMC7QOFa1xcAlfTbA
 yD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515772; x=1711120572;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29w950Mjo10TxKJfti7sbRRg9YOuroRLPRcz7P9Xo18=;
 b=DnfmgwOTH9oSOT18YcgFM+UmAgFKKgpS18hGzknHFJ8MTB8JYldodQzM680oVQQMGU
 eswYJdPqXGkUycYBpFjDNaWh8jnAzRXdPqIY7Z/Yvy1YMzY8bAp8WG84mRVPzWbcbgkM
 nWnwk0exIy5HnMG+Zo+IB4y5DLeEiDObfZSBswp+APj/kGtSoqIa/uKXZOI+44RWzRQ+
 H58XcAWQ96Kiex1BEMi20FwXsCf3Z1IuMz4YOJaCtYW1Dk/Lh9vskLka+FQbIi1Qg9an
 WewZOCNU1wQzMEy7uB7iYdfbKQcL/ICp5kpHHPh8nMK9i11YX9y8gtg+tH96WvGvzav/
 bzig==
X-Gm-Message-State: AOJu0Yz05fmraCM/+izX+xWmd4Clilrj2Q8R3G89wVY5ULjJZOs62BbL
 dnGQqkcGf1wQ4bPRlE1urxC8mC+DoYfN1cskFL5GWjbkoTt6OVAqfsH6ZPCRkzw=
X-Google-Smtp-Source: AGHT+IFy+wg44hTur04HddaCTPodwmGbB+ZfhmCFCovMDzsPmUJGhg8pFbZNBb3/m8fvU5efU/y8Yw==
X-Received: by 2002:a05:600c:46c9:b0:413:2ab7:4396 with SMTP id
 q9-20020a05600c46c900b004132ab74396mr3347529wmo.18.1710515772284; 
 Fri, 15 Mar 2024 08:16:12 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 m10-20020adffe4a000000b0033de10c9efcsm3355603wrs.114.2024.03.15.08.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:16:11 -0700 (PDT)
Date: Fri, 15 Mar 2024 18:16:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sunil.khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amdgpu: add ring buffer information in devcoredump
Message-ID: <9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 15 Mar 2024 16:22:14 +0000
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

Hello Sunil Khatri,

Commit 42742cc541bb ("drm/amdgpu: add ring buffer information in
devcoredump") from Mar 11, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:219 amdgpu_devcoredump_read()
	error: we previously assumed 'coredump->adev' could be null (see line 206)

drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
    171 static ssize_t
    172 amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
    173                         void *data, size_t datalen)
    174 {
    175         struct drm_printer p;
    176         struct amdgpu_coredump_info *coredump = data;
    177         struct drm_print_iterator iter;
    178         int i;
    179 
    180         iter.data = buffer;
    181         iter.offset = 0;
    182         iter.start = offset;
    183         iter.remain = count;
    184 
    185         p = drm_coredump_printer(&iter);
    186 
    187         drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
    188         drm_printf(&p, "version: " AMDGPU_COREDUMP_VERSION "\n");
    189         drm_printf(&p, "kernel: " UTS_RELEASE "\n");
    190         drm_printf(&p, "module: " KBUILD_MODNAME "\n");
    191         drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec,
    192                         coredump->reset_time.tv_nsec);
    193 
    194         if (coredump->reset_task_info.pid)
    195                 drm_printf(&p, "process_name: %s PID: %d\n",
    196                            coredump->reset_task_info.process_name,
    197                            coredump->reset_task_info.pid);
    198 
    199         if (coredump->ring) {
    200                 drm_printf(&p, "\nRing timed out details\n");
    201                 drm_printf(&p, "IP Type: %d Ring Name: %s\n",
    202                            coredump->ring->funcs->type,
    203                            coredump->ring->name);
    204         }
    205 
    206         if (coredump->adev) {
                    ^^^^^^^^^^^^^^
Check for NULL

    207                 struct amdgpu_vm_fault_info *fault_info =
    208                         &coredump->adev->vm_manager.fault_info;
    209 
    210                 drm_printf(&p, "\n[%s] Page fault observed\n",
    211                            fault_info->vmhub ? "mmhub" : "gfxhub");
    212                 drm_printf(&p, "Faulty page starting at address: 0x%016llx\n",
    213                            fault_info->addr);
    214                 drm_printf(&p, "Protection fault status register: 0x%x\n\n",
    215                            fault_info->status);
    216         }
    217 
    218         drm_printf(&p, "Ring buffer information\n");
--> 219         for (int i = 0; i < coredump->adev->num_rings; i++) {
                                    ^^^^^^^^^^^^^^
Unchecked dereference

    220                 int j = 0;
    221                 struct amdgpu_ring *ring = coredump->adev->rings[i];
    222 
    223                 drm_printf(&p, "ring name: %s\n", ring->name);
    224                 drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
    225                            amdgpu_ring_get_rptr(ring),
    226                            amdgpu_ring_get_wptr(ring),
    227                            ring->buf_mask);
    228                 drm_printf(&p, "Ring size in dwords: %d\n",
    229                            ring->ring_size / 4);
    230                 drm_printf(&p, "Ring contents\n");
    231                 drm_printf(&p, "Offset \t Value\n");
    232 
    233                 while (j < ring->ring_size) {
    234                         drm_printf(&p, "0x%x \t 0x%x\n", j, ring->ring[j/4]);
    235                         j += 4;
    236                 }
    237         }
    238 
    239         if (coredump->reset_vram_lost)
    240                 drm_printf(&p, "VRAM is lost due to GPU reset!\n");
    241         if (coredump->adev->reset_info.num_regs) {
                    ^^^^^^^^^^^^^^
Here too

    242                 drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
    243 
    244                 for (i = 0; i < coredump->adev->reset_info.num_regs; i++)
    245                         drm_printf(&p, "0x%08x: 0x%08x\n",
    246                                    coredump->adev->reset_info.reset_dump_reg_list[i],
    247                                    coredump->adev->reset_info.reset_dump_reg_value[i]);
    248         }
    249 
    250         return count - iter.remain;
    251 }

regards,
dan carpenter
