Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DFBC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 10:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BBF10EF1D;
	Mon, 18 Mar 2024 10:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A8ud6h8L";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A97210EF1D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 10:32:58 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-513d23be0b6so4146770e87.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710757976; x=1711362776; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jz5VE8rb9auasH1hWdpw1tUHRe+vfMYKfWLojnnJVK8=;
 b=A8ud6h8Lh/wf1bTm2BXgqbYOTcqFekelCirg7A8WmCu0VnM6jMzJYUNVvtRR+9veD0
 QiTxeZbS5AY8LncSsML1ksy8u58KDp+paoOTypBZIVpWugrZkR3YpBxipsAPLsnZOM3L
 defd8Z88UGx4HfllymNR7YVJdClLVkK1l+cyByqo2uhfmschh4SGujjTsvyjdOSB6XAZ
 +0pL2BeaLddIGaeqWLxSKqmH+NO24cT1PDj3axyQ+b83XvSNQVsIC3IH1XXG1yXw5HX7
 oDjynF4V4hdYeZ4YScA1txVEvrPYgQqMqQwDfexDWYJW5Mtqh40jCJOkbLZRVf2950lA
 zoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710757976; x=1711362776;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jz5VE8rb9auasH1hWdpw1tUHRe+vfMYKfWLojnnJVK8=;
 b=qsI559sIvBfbJUVRvlCgUyLUOtewOrQ6gk3y3cw3wB4oo7cbAcOrfFqRZE6Ym8JA6s
 guKhLBarAHdawCQEqtRksFb4kOPWb8TTfAdr2FzsHyAaF8/L1QCJcnhShG7XoETb9Era
 eHeaXvjYKg08qGcqKc62rOelJSa0Te9gzuZVP38diE3nWjQ9+JH9Qc/tS5DQxNrdSHQV
 4V7KiEEg5q4twbrtcgEnnJXNgFTwUkj4nuWKnF7Mzr3uadcEn8c4iozH+LMldqwBfwCW
 ltm/IYo+AsAGqgeOgeruoFzgz/6I+9hh3Jc7vO4eMtT3zbN39PX+QAqOzl0vm88Nf09L
 t9+A==
X-Gm-Message-State: AOJu0YxirgHGB3qEyBXM7mxlKau2UI+mKkszbeMXED2ZXtXwIuaqSfjd
 AglR+tXShBxHh6JCX/wilV8X774h0pDJAVLnBa4kaH0xVwa0JqZ5
X-Google-Smtp-Source: AGHT+IHxP8GySFM0XcZwm2Hy3dRyQp9YYqgPyfCxzaRhcPzzBOJewWR2ie6Mkm0JYLZRhsNp3UPpig==
X-Received: by 2002:a05:6512:2013:b0:512:fab6:6df6 with SMTP id
 a19-20020a056512201300b00512fab66df6mr2025254lfb.4.1710757975697; 
 Mon, 18 Mar 2024 03:32:55 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a05600c1f9400b00413e6af1bd5sm14267772wmb.47.2024.03.18.03.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 03:32:55 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------ayYns5kAbnRHkTS0Ib20v0QK"
Message-ID: <ed3cb49f-071e-4728-afbd-8b2411fd677a@gmail.com>
Date: Mon, 18 Mar 2024 11:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] drm/amdgpu: add ring buffer information in
 devcoredump
Content-Language: en-US
To: "Khatri, Sunil" <sukhatri@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, sunil.khatri@amd.com,
 christian.koenig@amd.com, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain>
 <72df7acd-4019-4159-b9c7-ffa8cda9e86a@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <72df7acd-4019-4159-b9c7-ffa8cda9e86a@amd.com>
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

This is a multi-part message in MIME format.
--------------ayYns5kAbnRHkTS0Ib20v0QK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.03.24 um 20:08 schrieb Khatri, Sunil:
>
> Thanks for pointing these. I do have some doubt and i raised inline.
>
> On 3/15/2024 8:46 PM, Dan Carpenter wrote:
>> Hello Sunil Khatri,
>>
>> Commit 42742cc541bb ("drm/amdgpu: add ring buffer information in
>> devcoredump") from Mar 11, 2024 (linux-next), leads to the following
>> Smatch static checker warning:
>>
>> 	drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:219 amdgpu_devcoredump_read()
>> 	error: we previously assumed 'coredump->adev' could be null (see line 206)
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>      171 static ssize_t
>>      172 amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>>      173                         void *data, size_t datalen)
>>      174 {
>>      175         struct drm_printer p;
>>      176         struct amdgpu_coredump_info *coredump = data;
>>      177         struct drm_print_iterator iter;
>>      178         int i;
>>      179
>>      180         iter.data = buffer;
>>      181         iter.offset = 0;
>>      182         iter.start = offset;
>>      183         iter.remain = count;
>>      184
>>      185         p = drm_coredump_printer(&iter);
>>      186
>>      187         drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>>      188         drm_printf(&p, "version: " AMDGPU_COREDUMP_VERSION "\n");
>>      189         drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>>      190         drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>>      191         drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec,
>>      192                         coredump->reset_time.tv_nsec);
>>      193
>>      194         if (coredump->reset_task_info.pid)
>>      195                 drm_printf(&p, "process_name: %s PID: %d\n",
>>      196                            coredump->reset_task_info.process_name,
>>      197                            coredump->reset_task_info.pid);
>>      198
>>      199         if (coredump->ring) {
>>      200                 drm_printf(&p, "\nRing timed out details\n");
>>      201                 drm_printf(&p, "IP Type: %d Ring Name: %s\n",
>>      202                            coredump->ring->funcs->type,
>>      203                            coredump->ring->name);
>>      204         }
>>      205
>>      206         if (coredump->adev) {
>>                      ^^^^^^^^^^^^^^
>> Check for NULL
> This is the check for NULL. Is there any issue here ?
>>      207                 struct amdgpu_vm_fault_info *fault_info =
>>      208                         &coredump->adev->vm_manager.fault_info;
>>      209
>>      210                 drm_printf(&p, "\n[%s] Page fault observed\n",
>>      211                            fault_info->vmhub ? "mmhub" : "gfxhub");
>>      212                 drm_printf(&p, "Faulty page starting at address: 0x%016llx\n",
>>      213                            fault_info->addr);
>>      214                 drm_printf(&p, "Protection fault status register: 0x%x\n\n",
>>      215                            fault_info->status);
>>      216         }
>>      217
>>      218         drm_printf(&p, "Ring buffer information\n");
>> --> 219         for (int i = 0; i < coredump->adev->num_rings; i++) {
>>                                      ^^^^^^^^^^^^^^
>> Unchecked dereference
> Agree
>>      220                 int j = 0;
>>      221                 struct amdgpu_ring *ring = coredump->adev->rings[i];
>>      222
>>      223                 drm_printf(&p, "ring name: %s\n", ring->name);
>>      224                 drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
>>      225                            amdgpu_ring_get_rptr(ring),
>>      226                            amdgpu_ring_get_wptr(ring),
>>      227                            ring->buf_mask);
>>      228                 drm_printf(&p, "Ring size in dwords: %d\n",
>>      229                            ring->ring_size / 4);
>>      230                 drm_printf(&p, "Ring contents\n");
>>      231                 drm_printf(&p, "Offset \t Value\n");
>>      232
>>      233                 while (j < ring->ring_size) {
>>      234                         drm_printf(&p, "0x%x \t 0x%x\n", j, ring->ring[j/4]);
>>      235                         j += 4;
>>      236                 }
>>      237         }
>>      238
>>      239         if (coredump->reset_vram_lost)
>>      240                 drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>      241         if (coredump->adev->reset_info.num_regs) {
>>                      ^^^^^^^^^^^^^^
>> Here too
> Agree.
>>      242                 drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
>>      243
>>      244                 for (i = 0; i < coredump->adev->reset_info.num_regs; i++)
>>      245                         drm_printf(&p, "0x%08x: 0x%08x\n",
>>      246                                    coredump->adev->reset_info.reset_dump_reg_list[i],
>>      247                                    coredump->adev->reset_info.reset_dump_reg_value[i]);
>>      248         }
>>      249
>>      250         return count - iter.remain;
>>      251 }
>
>
> Although adev is a global structure and never in the code it is being 
> checked for NULL as it wont be NULL until the driver is unloaded. I 
> can add a check  for adev in the beginning of the function 
> amdgpu_devcoredump_read for completeness of the tool but still not 
> very sure of it.
>
> Christian and Alex Do you agree with my understanding the adev does 
> really need a validation for NULL. I dint see throughout the code adev 
> to be validated for NULL. Do you recommend to add a check for NULL for 
> adev in the above mentioned function/places.
>

No, that doesn't make sense. adev is mandatory to be around for the core 
dump to be valid and accessible.

Without a device you don't have a core dump in the first place.

Regards,
Christian.

> Regards Sunil
>
>> regards,
>> dan carpenter

--------------ayYns5kAbnRHkTS0Ib20v0QK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 15.03.24 um 20:08 schrieb Khatri, Sunil:<br>
    <blockquote type="cite"
      cite="mid:72df7acd-4019-4159-b9c7-ffa8cda9e86a@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>Thanks for pointing these. I do have some doubt and i raised
        inline.<br>
      </p>
      <div class="moz-cite-prefix">On 3/15/2024 8:46 PM, Dan Carpenter
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
        <pre class="moz-quote-pre" wrap="">Hello Sunil Khatri,

Commit 42742cc541bb ("drm/amdgpu: add ring buffer information in
devcoredump") from Mar 11, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:219 amdgpu_devcoredump_read()
	error: we previously assumed 'coredump-&gt;adev' could be null (see line 206)

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
    185         p = drm_coredump_printer(&amp;iter);
    186 
    187         drm_printf(&amp;p, "**** AMDGPU Device Coredump ****\n");
    188         drm_printf(&amp;p, "version: " AMDGPU_COREDUMP_VERSION "\n");
    189         drm_printf(&amp;p, "kernel: " UTS_RELEASE "\n");
    190         drm_printf(&amp;p, "module: " KBUILD_MODNAME "\n");
    191         drm_printf(&amp;p, "time: %lld.%09ld\n", coredump-&gt;reset_time.tv_sec,
    192                         coredump-&gt;reset_time.tv_nsec);
    193 
    194         if (coredump-&gt;reset_task_info.pid)
    195                 drm_printf(&amp;p, "process_name: %s PID: %d\n",
    196                            coredump-&gt;reset_task_info.process_name,
    197                            coredump-&gt;reset_task_info.pid);
    198 
    199         if (coredump-&gt;ring) {
    200                 drm_printf(&amp;p, "\nRing timed out details\n");
    201                 drm_printf(&amp;p, "IP Type: %d Ring Name: %s\n",
    202                            coredump-&gt;ring-&gt;funcs-&gt;type,
    203                            coredump-&gt;ring-&gt;name);
    204         }
    205 
    206         if (coredump-&gt;adev) {
                    ^^^^^^^^^^^^^^
Check for NULL</pre>
      </blockquote>
      This is the check for NULL. Is there any issue here ?<br>
      <blockquote type="cite"
        cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
        <pre class="moz-quote-pre" wrap="">    207                 struct amdgpu_vm_fault_info *fault_info =
    208                         &amp;coredump-&gt;adev-&gt;vm_manager.fault_info;
    209 
    210                 drm_printf(&amp;p, "\n[%s] Page fault observed\n",
    211                            fault_info-&gt;vmhub ? "mmhub" : "gfxhub");
    212                 drm_printf(&amp;p, "Faulty page starting at address: 0x%016llx\n",
    213                            fault_info-&gt;addr);
    214                 drm_printf(&amp;p, "Protection fault status register: 0x%x\n\n",
    215                            fault_info-&gt;status);
    216         }
    217 
    218         drm_printf(&amp;p, "Ring buffer information\n");
--&gt; 219         for (int i = 0; i &lt; coredump-&gt;adev-&gt;num_rings; i++) {
                                    ^^^^^^^^^^^^^^
Unchecked dereference</pre>
      </blockquote>
      Agree<br>
      <blockquote type="cite"
        cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
        <pre class="moz-quote-pre" wrap="">    220                 int j = 0;
    221                 struct amdgpu_ring *ring = coredump-&gt;adev-&gt;rings[i];
    222 
    223                 drm_printf(&amp;p, "ring name: %s\n", ring-&gt;name);
    224                 drm_printf(&amp;p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
    225                            amdgpu_ring_get_rptr(ring),
    226                            amdgpu_ring_get_wptr(ring),
    227                            ring-&gt;buf_mask);
    228                 drm_printf(&amp;p, "Ring size in dwords: %d\n",
    229                            ring-&gt;ring_size / 4);
    230                 drm_printf(&amp;p, "Ring contents\n");
    231                 drm_printf(&amp;p, "Offset \t Value\n");
    232 
    233                 while (j &lt; ring-&gt;ring_size) {
    234                         drm_printf(&amp;p, "0x%x \t 0x%x\n", j, ring-&gt;ring[j/4]);
    235                         j += 4;
    236                 }
    237         }
    238 
    239         if (coredump-&gt;reset_vram_lost)
    240                 drm_printf(&amp;p, "VRAM is lost due to GPU reset!\n");
    241         if (coredump-&gt;adev-&gt;reset_info.num_regs) {
                    ^^^^^^^^^^^^^^
Here too</pre>
      </blockquote>
      Agree.<br>
      <blockquote type="cite"
        cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
        <pre class="moz-quote-pre" wrap="">    242                 drm_printf(&amp;p, "AMDGPU register dumps:\nOffset:     Value:\n");
    243 
    244                 for (i = 0; i &lt; coredump-&gt;adev-&gt;reset_info.num_regs; i++)
    245                         drm_printf(&amp;p, "0x%08x: 0x%08x\n",
    246                                    coredump-&gt;adev-&gt;reset_info.reset_dump_reg_list[i],
    247                                    coredump-&gt;adev-&gt;reset_info.reset_dump_reg_value[i]);
    248         }
    249 
    250         return count - iter.remain;
    251 }</pre>
      </blockquote>
      <p><br>
      </p>
      <p>Although adev is a global structure and never in the code it is
        being checked for NULL as it wont be NULL until the driver is
        unloaded. I can add a check  for adev in the beginning of the
        function <span style="white-space: pre-wrap">amdgpu_devcoredump_read for completeness of the tool but still not very sure of it.</span></p>
      <p><span style="white-space: pre-wrap">Christian and Alex
Do you agree with my understanding the adev does really need a validation for NULL. I dint see throughout the code adev to be validated for NULL. Do you recommend to add a check for NULL for adev in the above mentioned function/places.</span></p>
    </blockquote>
    <br>
    No, that doesn't make sense. adev is mandatory to be around for the
    core dump to be valid and accessible.<br>
    <br>
    Without a device you don't have a core dump in the first place.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:72df7acd-4019-4159-b9c7-ffa8cda9e86a@amd.com">
      <p><span style="white-space: pre-wrap">Regards
Sunil
</span></p>
      <blockquote type="cite"
        cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
        <pre class="moz-quote-pre" wrap="">regards,
dan carpenter
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------ayYns5kAbnRHkTS0Ib20v0QK--
