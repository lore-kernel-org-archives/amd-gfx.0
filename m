Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E3CC47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 07:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD78206CC
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 07:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANKj2dhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD78206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C581F6E10F;
	Tue,  5 May 2020 07:47:47 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A926E10F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 07:47:46 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id x25so1114919wmc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=l35BxYIu1s+7MrWkmwn63TZRntZcJAoQ4s84Ao5vY90=;
 b=ANKj2dhNYauA8I4xtOE6TffXKUk6bacPLTifr8A2KzMrsPAYXmi4mDP62AnXeeRXdE
 WZ7uaBDqlISPqslXgnYvS6LCDUwAhjrxL0wBwn2kUhK6A+iwZJtYq5EbltGIcBpwqFWh
 kLbqKCk2KDp1TvEbb6dN0rh2UWU9TbWekkycNi2bEJ2kvsXcBExg9eUfmWtxFvoRxEa3
 VQSiIUMPtGSc2eHpPYcpxc4+UmQajRtIOUlq+qSG55nS1rBROort4rUKHLf1+hoTYuCX
 36G2FeKJR97nt0PekoHzbFGJJB5DSVYzaLOYAyMqRhFUCEPyigrabJ7hqy08VCPUlu4r
 tUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=l35BxYIu1s+7MrWkmwn63TZRntZcJAoQ4s84Ao5vY90=;
 b=HyNIYGDJq5enPc4IFCWxHUCIK9e/GHoT/Qwong1fjL4KniPuQmpBYmFceYCm9PU/C+
 AzDDGUojhDOZ+b70cD2Ohc70GyAuXpSrRGVP3XOytHkVKn+6vcQwIUkhScPy7HHQlYrP
 Zp1WjKsZUpQ+HM55aJ2j4iLZ5BodFwkS5K+8aI1MIjgTFsZKF1RU/kor6HcShT7TQOrJ
 OxRGcR19rucF1m9eRczZi2T5KWmZ+2wJF21hItxtGOfLtLxkaamRauNZsaKP0TgSc+Io
 Xk/T838fWYgc4O6BckDb4gdAVMjVlAMQ320/1H5+fNAvrAlTGegtc+yPacaLKfyvLyUx
 L5fw==
X-Gm-Message-State: AGi0PuYRbaVYHLZZjYL+h097Mm6BRFCFdOM2NMxuQ2TecKiqhS5Wo+JY
 1QprA+5x/qjn0q5YCZgB1os14AM7
X-Google-Smtp-Source: APiQypJ620Yp6fs6uyb++Wr3/ordwkTtaQ3eFL2KI+xNbOkAuB23sICjC3Wbsy6gVESzViESJ22/Fg==
X-Received: by 2002:a1c:4989:: with SMTP id w131mr1888976wma.137.1588664865041; 
 Tue, 05 May 2020 00:47:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a8sm1769062wrg.85.2020.05.05.00.47.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2020 00:47:44 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Take a reference to an exported BO
To: Felix Kuehling <felix.kuehling@amd.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200501142127.14202-1-Felix.Kuehling@amd.com>
 <70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com>
 <551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com>
Date: Tue, 5 May 2020 09:47:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============1462452286=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1462452286==
Content-Type: multipart/alternative;
 boundary="------------D413B1BBF5B0CF1A4C707896"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D413B1BBF5B0CF1A4C707896
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Just to reply here once more, this patch is a clear NAK.

The references are grabbed in the call path of drm_gem_prime_export() 
and dropped again in drm_gem_dmabuf_release().

So they are perfectly balanced as far as I can see.

Regards,
Christian.

Am 01.05.20 um 16:44 schrieb Felix Kuehling:
>
> [dropping my gmail address]
>
> We saw this backtrace showing the call chain while investigating a 
> kernel oops caused by this issue on the DKMS branch with the KFD IPC 
> API. It happens after a dma-buf file is released with fput:
>
> [ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
> [ 1255.049727] #PF: supervisor read access in kernel mode
> [ 1255.050092] #PF: error_code(0x0000) - not-present page
> [ 1255.050416] PGD 0 P4D 0
> [ 1255.050736] Oops: 0000 [#1] SMP PTI
> [ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
> [ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
> [ 1255.051752] Workqueue: events delayed_fput
> [ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked+0x1c/0x70 [drm]
> [ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 <48> 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
> [ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
> [ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
> [ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
> [ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
> [ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
> [ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
> [ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
> [ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
> [ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1255.057763] PKRU: 55555554
> [ 1255.058179] Call Trace:
> [ 1255.058603]  drm_gem_dmabuf_release+0x1a/0x30 [drm]
> [ 1255.059025]  dma_buf_release+0x56/0x130
> [ 1255.059443]  __fput+0xc6/0x260
> [ 1255.059856]  delayed_fput+0x20/0x30
> [ 1255.060272]  process_one_work+0x1fd/0x3f0
> [ 1255.060686]  worker_thread+0x34/0x410
> [ 1255.061099]  kthread+0x121/0x140
> [ 1255.061510]  ? process_one_work+0x3f0/0x3f0
> [ 1255.061923]  ? kthread_park+0xb0/0xb0
> [ 1255.062336]  ret_from_fork+0x35/0x40
>
> drm_gem_object_put_unlocked calls drm_gem_object_free when the 
> obj->refcount reaches 0. From there it calls 
> dev->driver->gem_free_object_unlocked, which is amdgpu_gem_object_free 
> in amdgpu.
>
> Regards,
>   Felix
>
> Am 2020-05-01 um 10:29 a.m. schrieb Christian König:
>> Am 01.05.20 um 16:21 schrieb Felix Kuehling:
>>> From: Felix Kuehling <felix.kuehling@gmail.com>
>>>
>>> That reference gets dropped when the the dma-buf is freed. Not 
>>> incrementing
>>> the refcount can lead to use-after-free errors.
>>>
>>> Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index ffeb20f11c07..a0f9b3ef4aad 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -398,8 +398,15 @@ struct dma_buf *amdgpu_gem_prime_export(struct 
>>> drm_gem_object *gobj,
>>>           return ERR_PTR(-EPERM);
>>>         buf = drm_gem_prime_export(gobj, flags);
>>> -    if (!IS_ERR(buf))
>>> +    if (!IS_ERR(buf)) {
>>>           buf->ops = &amdgpu_dmabuf_ops;
>>> +        /* GEM needs a reference to the underlying object
>>> +         * that gets dropped when the dma-buf is released,
>>> +         * through the amdgpu_gem_object_free callback
>>> +         * from drm_gem_object_put_unlocked.
>>> +         */
>>> +        amdgpu_bo_ref(bo);
>>> +    }
>>
>> Of hand that doesn't sounds correct to me. Why should the exported bo 
>> be closed through amdgpu_gem_object_free()?
>>
>> Regards,
>> Christian.
>>
>>>         return buf;
>>>   }
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------D413B1BBF5B0CF1A4C707896
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Just to reply here once more, this
      patch is a clear NAK.<br>
      <br>
      The references are grabbed in the call path of
      drm_gem_prime_export() and dropped again in
      drm_gem_dmabuf_release().<br>
      <br>
      So they are perfectly balanced as far as I can see.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 01.05.20 um 16:44 schrieb Felix Kuehling:<br>
    </div>
    <blockquote type="cite"
      cite="mid:551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>[dropping my gmail address]</p>
      <p>We saw this backtrace showing the call chain while
        investigating a kernel oops caused by this issue on the DKMS
        branch with the KFD IPC API. It happens after a dma-buf file is
        released with fput:</p>
      <pre>[ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
[ 1255.049727] #PF: supervisor read access in kernel mode
[ 1255.050092] #PF: error_code(0x0000) - not-present page
[ 1255.050416] PGD 0 P4D 0
[ 1255.050736] Oops: 0000 [#1] SMP PTI
[ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
[ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
[ 1255.051752] Workqueue: events delayed_fput
[ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked+0x1c/0x70 [drm]
[ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 &lt;48&gt; 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
[ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
[ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
[ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
[ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
[ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
[ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
[ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
[ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
[ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1255.057763] PKRU: 55555554
[ 1255.058179] Call Trace:
[ 1255.058603]  drm_gem_dmabuf_release+0x1a/0x30 [drm]
[ 1255.059025]  dma_buf_release+0x56/0x130
[ 1255.059443]  __fput+0xc6/0x260
[ 1255.059856]  delayed_fput+0x20/0x30
[ 1255.060272]  process_one_work+0x1fd/0x3f0
[ 1255.060686]  worker_thread+0x34/0x410
[ 1255.061099]  kthread+0x121/0x140
[ 1255.061510]  ? process_one_work+0x3f0/0x3f0
[ 1255.061923]  ? kthread_park+0xb0/0xb0
[ 1255.062336]  ret_from_fork+0x35/0x40
</pre>
      <p>drm_gem_object_put_unlocked calls drm_gem_object_free when the
        obj-&gt;refcount reaches 0. From there it calls
        dev-&gt;driver-&gt;gem_free_object_unlocked, which is
        amdgpu_gem_object_free in amdgpu.<br>
      </p>
      <p>Regards,<br>
          Felix<br>
      </p>
      <div class="moz-cite-prefix">Am 2020-05-01 um 10:29 a.m. schrieb
        Christian König:<br>
      </div>
      <blockquote type="cite"
        cite="mid:70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com">Am
        01.05.20 um 16:21 schrieb Felix Kuehling: <br>
        <blockquote type="cite">From: Felix Kuehling <a
            class="moz-txt-link-rfc2396E"
            href="mailto:felix.kuehling@gmail.com"
            moz-do-not-send="true">&lt;felix.kuehling@gmail.com&gt;</a>
          <br>
          <br>
          That reference gets dropped when the the dma-buf is freed. Not
          incrementing <br>
          the refcount can lead to use-after-free errors. <br>
          <br>
          Signed-off-by: Felix Kuehling <a
            class="moz-txt-link-rfc2396E"
            href="mailto:felix.kuehling@gmail.com"
            moz-do-not-send="true">&lt;felix.kuehling@gmail.com&gt;</a>
          <br>
          --- <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++- <br>
            1 file changed, 8 insertions(+), 1 deletion(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
          index ffeb20f11c07..a0f9b3ef4aad 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
          @@ -398,8 +398,15 @@ struct dma_buf
          *amdgpu_gem_prime_export(struct drm_gem_object *gobj, <br>
                    return ERR_PTR(-EPERM); <br>
                  buf = drm_gem_prime_export(gobj, flags); <br>
          -    if (!IS_ERR(buf)) <br>
          +    if (!IS_ERR(buf)) { <br>
                    buf-&gt;ops = &amp;amdgpu_dmabuf_ops; <br>
          +        /* GEM needs a reference to the underlying object <br>
          +         * that gets dropped when the dma-buf is released, <br>
          +         * through the amdgpu_gem_object_free callback <br>
          +         * from drm_gem_object_put_unlocked. <br>
          +         */ <br>
          +        amdgpu_bo_ref(bo); <br>
          +    } <br>
        </blockquote>
        <br>
        Of hand that doesn't sounds correct to me. Why should the
        exported bo be closed through amdgpu_gem_object_free()? <br>
        <br>
        Regards, <br>
        Christian. <br>
        <br>
        <blockquote type="cite">        return buf; <br>
            } <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D413B1BBF5B0CF1A4C707896--

--===============1462452286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1462452286==--
