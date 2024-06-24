Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D9AC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 13:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B542B10E05C;
	Mon, 24 Jun 2024 13:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ATvEUSDZ";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BB110E05C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 13:46:55 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-36279cf6414so3435390f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719236813; x=1719841613; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YUTrhWfA2vWRBD4MQfUVOwshds7xPdhOg91CCryJCY=;
 b=ATvEUSDZsVxFs+1NepdkhoARH1ofQeqhRz/2tNpF7ueRt+c2XFUJwyRzVNZYhuhxdD
 06xiOiQ0GogMbBs+AxqDvDBVk6ab8vWGLyBbGu5I/1o3PA3RX0vlZ8tlmKnIsmNysIio
 c+hlsIROxYH4oyjq5dqdcKYl10leTwzJ9GSkQ+nGh8agPLPxr+O5YZi3INGCiVNgz/EM
 jz3lHdsp9MWSuYwFK9OeiRctoTsi5wRpRADNiw4wRAsN+eHEx65X6mFWV2nh4Sq2ctbJ
 SwwIZTbh7PXtJDKzuicE00jXd8wehtAup98KM6wWOrGRhIqN53oYDWOWTCRq5ZP46l2T
 PU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236813; x=1719841613;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8YUTrhWfA2vWRBD4MQfUVOwshds7xPdhOg91CCryJCY=;
 b=R4mOyRbO10vgszk7i+zWWR62aPeOVkJEqmdP2R5M37wZyF6sQxU2pLw3FkGuqC0xDo
 CqPRSw0Uev8XWiBp+x7+xY7GFmR1Mp0JyT8NYz2u5I/sSbovtc7AyRZBipdZsFX9Ar0H
 2KOxgDtssl6xeB3EWSX6l2VpXKn54h6T1xODurTrr7Xjkz9q54YXsATsdGRcLFy+pFMk
 iBmwneYtwfvCnh2TMqs5FTY0EuHGqbS0RV0sxJxkuY6Cj/ttoRjCv6/kf6xzCjdwP02d
 /LbT8Zp0dlzV4+O8ItHszXnB6klWw0oledhdeyzhcxE7YGrEWNowTyGHK79+s7cgdRrj
 s/sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd/TWHzPwqJ56ZXdmxhVHhJPWZd5M3S5zVNXAS6uH28LrkFG0w6t8t46fvWPlXJwYlzhObhNDmRfpxUMSCu9197bLsQDt5wdBZyZp2nw==
X-Gm-Message-State: AOJu0YyVAIVOFFHhcELAwmeXwupkKQxiCakGjVdut8HMix/1IHploS18
 RQD1FkGloYfyhP95f2kmj9aOo59ccdfZRTE8TQP/E3TMIF1lpRvw
X-Google-Smtp-Source: AGHT+IGzDyaW/ga/iPp85Z1/rsKW6rmsqORPWXNPkkArJBfrjOi3YM/EIyID348S6LewTDNtGDCNXg==
X-Received: by 2002:a5d:6c6e:0:b0:360:8200:858f with SMTP id
 ffacd0b85a97d-366e937da60mr3945544f8f.0.1719236812927; 
 Mon, 24 Jun 2024 06:46:52 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366389b861bsm10052511f8f.29.2024.06.24.06.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 06:46:52 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------Ko0g1FNgMsuxOoancoKhuP89"
Message-ID: <af221b92-2f37-4b4d-bd48-5d36a0e9fad0@gmail.com>
Date: Mon, 24 Jun 2024 15:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop kiq access while in reset
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com
References: <20240624063109.655690-1-Vignesh.Chander@amd.com>
 <6f21496a-282c-428e-b66d-92edb82b21d8@amd.com>
 <5d63de6b-0d46-422f-bc6e-6f59fce6104a@gmail.com>
 <ddc93078-bebc-4414-b6c9-07e01d663838@amd.com>
 <543fd667-6e91-4efb-b3e2-49d0c9a5c467@gmail.com>
 <fae5960b-b782-4f7f-b8b2-64a1af62f61f@amd.com>
 <95ef35d7-4056-42a7-9e81-46e84eeed315@gmail.com>
 <b572a287-4ce3-447a-a211-c5caf9ec09cb@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <b572a287-4ce3-447a-a211-c5caf9ec09cb@amd.com>
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
--------------Ko0g1FNgMsuxOoancoKhuP89
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.06.24 um 14:24 schrieb Lazar, Lijo:
> On 6/24/2024 5:31 PM, Christian König wrote:
>> Am 24.06.24 um 13:57 schrieb Lazar, Lijo:
>>> On 6/24/2024 5:19 PM, Christian König wrote:
>>>> Am 24.06.24 um 11:52 schrieb Lazar, Lijo:
>>>>> On 6/24/2024 3:08 PM, Christian König wrote:
>>>>>> Am 24.06.24 um 08:34 schrieb Lazar, Lijo:
>>>>>>> On 6/24/2024 12:01 PM, Vignesh Chander wrote:
>>>>>>>> correctly handle the case when trylock fails when gpu is
>>>>>>>> about to be reset by dropping the request instead of using mmio
>>>>>>>>
>>>>>>>> Signed-off-by: Vignesh Chander<Vignesh.Chander@amd.com>
>>>>>>> Reviewed-by: Lijo Lazar<lijo.lazar@amd.com>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38
>>>>>>>> ++++++++++++----------
>>>>>>>>      1 file changed, 21 insertions(+), 17 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index a7ce8280b17ce7..3cfd24699d691d 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>            if ((reg * 4) < adev->rmmio_size) {
>>>>>>>>              if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>>> -            ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>>> +                ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>>>> +            }
>>>>>> What has actually changed here? As far as I can see that isn't
>>>>>> functionally different to the existing code.
>>>>>>
>>>>> In earlier logic, if it fails to get the lock, it takes the 'else'
>>>>> path.
>>>>> The 'else' path is not meant for sriov/vf.
>>>> Yeah, but the read or write is then just silently dropped.
>>>>
>>>> That can't be correct either.
>>>>
>>> These are void funcs. Moreover, the drops will happen if there is
>>> concurrent access from another thread while a reset is going on. That is
>>> expected and those accesses during a reset won't help anyway.
>> Nope, Teddy has been working on that for a while as well.
> This silent drop is already there in bare metal.
>
> https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L738

That's not for reset, but for hotplug. In that case the silent drop is 
ok because the device is gone anyway.

>> Trying to make those accesses while the reset is going on is wrong in
>> the first place. What we need to do is to grab the reset lock in the
>> higher level function so that the whole sequences of reads and writes
>> are protected.
>>
>> What this logic here does is to use readl()/writel() from the reset
>> thread itself. Dropping that is incorrect and could lead to broken reset.
> This doesn't change anything for a reset thread. This fixes an already
> broken path for sriov where it attempts a direct readl()/writel() if
> taking the lock fails. That is even more broken.

No, as far as I know that's correct behavior.

The lock is there to make sure we can talk to the KIQ. When that isn't 
possible because of reset we should use direct register access, that's 
completely intentional behavior.

What we could do is to remove the down_read_trylock() from 
amdgpu_device_skip_hw_access() and always assert that the reset domain 
lock is held.

Then we should also remove the down_read_trylock() from 
amdgpu_device_[rw]reg() and replace it with !amdgpu_in_reset() as it 
used to be.

This way we will get proper lockdep warnings for all the call chains 
missing to grab the reset lock.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> So clear NAK from my side to this patch here.
>>
>> Regards,
>> Christian.
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>>              } else {
>>>>>>>>                  ret = readl(((void __iomem *)adev->rmmio) + (reg
>>>>>>>> * 4));
>>>>>>>>              }
>>>>>>>> @@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>                                   &rlcg_flag)) {
>>>>>>>>                  ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0,
>>>>>>>> rlcg_flag,
>>>>>>>> GET_INST(GC, xcc_id));
>>>>>>>>              } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>>> -            ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>>> +                ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>>>> +            }
>>>>>>>>              } else {
>>>>>>>>                  ret = readl(((void __iomem *)adev->rmmio) + (reg
>>>>>>>> * 4));
>>>>>>>>              }
>>>>>>>> @@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device
>>>>>>>> *adev,
>>>>>>>>            if ((reg * 4) < adev->rmmio_size) {
>>>>>>>>              if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>>> -            amdgpu_kiq_wreg(adev, reg, v, 0);
>>>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>>> +                amdgpu_kiq_wreg(adev, reg, v, 0);
>>>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>>>> +            }
>>>>>>>>              } else {
>>>>>>>>                  writel(v, ((void __iomem *)adev->rmmio) + (reg *
>>>>>>>> 4));
>>>>>>>>              }
>>>>>>>> @@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>                                   &rlcg_flag)) {
>>>>>>>>                  amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
>>>>>>>> GET_INST(GC, xcc_id));
>>>>>>>>              } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>>> -            amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>>>> -        } else {
>>>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>>> +                amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>>>> +            }
>>>>>>>> +            } else {
>>>>>>>>                  writel(v, ((void __iomem *)adev->rmmio) + (reg *
>>>>>>>> 4));
>>>>>>>>              }
>>>>>>>>          } else {

--------------Ko0g1FNgMsuxOoancoKhuP89
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 24.06.24 um 14:24 schrieb Lazar, Lijo:<br>
    <blockquote type="cite"
      cite="mid:b572a287-4ce3-447a-a211-c5caf9ec09cb@amd.com">
      <pre class="moz-quote-pre" wrap="">On 6/24/2024 5:31 PM, Christian König wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 24.06.24 um 13:57 schrieb Lazar, Lijo:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 6/24/2024 5:19 PM, Christian König wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Am 24.06.24 um 11:52 schrieb Lazar, Lijo:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On 6/24/2024 3:08 PM, Christian König wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">Am 24.06.24 um 08:34 schrieb Lazar, Lijo:
</pre>
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">On 6/24/2024 12:01 PM, Vignesh Chander wrote:
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">correctly handle the case when trylock fails when gpu is
about to be reset by dropping the request instead of using mmio

Signed-off-by: Vignesh Chander <a class="moz-txt-link-rfc2396E" href="mailto:Vignesh.Chander@amd.com">&lt;Vignesh.Chander@amd.com&gt;</a>
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">Reviewed-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>

Thanks,
Lijo

</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">---
    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38
++++++++++++----------
    1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a7ce8280b17ce7..3cfd24699d691d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct
amdgpu_device *adev,
          if ((reg * 4) &lt; adev-&gt;rmmio_size) {
            if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;
-            amdgpu_sriov_runtime(adev) &amp;&amp;
-            down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {
-            ret = amdgpu_kiq_rreg(adev, reg, 0);
-            up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+            amdgpu_sriov_runtime(adev) {
+            if (down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {
+                ret = amdgpu_kiq_rreg(adev, reg, 0);
+                up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+            }
</pre>
                  </blockquote>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">What has actually changed here? As far as I can see that isn't
functionally different to the existing code.

</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">In earlier logic, if it fails to get the lock, it takes the 'else'
path.
The 'else' path is not meant for sriov/vf.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Yeah, but the read or write is then just silently dropped.

That can't be correct either.

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">These are void funcs. Moreover, the drops will happen if there is
concurrent access from another thread while a reset is going on. That is
expected and those accesses during a reset won't help anyway.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Nope, Teddy has been working on that for a while as well.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This silent drop is already there in bare metal.

<a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L738">https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L738</a></pre>
    </blockquote>
    <br>
    That's not for reset, but for hotplug. In that case the silent drop
    is ok because the device is gone anyway.<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite"
      cite="mid:b572a287-4ce3-447a-a211-c5caf9ec09cb@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Trying to make those accesses while the reset is going on is wrong in
the first place. What we need to do is to grab the reset lock in the
higher level function so that the whole sequences of reads and writes
are protected.

What this logic here does is to use readl()/writel() from the reset
thread itself. Dropping that is incorrect and could lead to broken reset.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This doesn't change anything for a reset thread. This fixes an already
broken path for sriov where it attempts a direct readl()/writel() if
taking the lock fails. That is even more broken.</pre>
    </blockquote>
    <br>
    No, as far as I know that's correct behavior.<br>
    <br>
    The lock is there to make sure we can talk to the KIQ. When that
    isn't possible because of reset we should use direct register
    access, that's completely intentional behavior.<br>
    <br>
    What we could do is to remove the down_read_trylock() from
    amdgpu_device_skip_hw_access() and always assert that the reset
    domain lock is held.<br>
    <br>
    Then we should also remove the down_read_trylock() from
    amdgpu_device_[rw]reg() and replace it with !amdgpu_in_reset() as it
    used to be.<br>
    <br>
    This way we will get proper lockdep warnings for all the call chains
    missing to grab the reset lock.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:b572a287-4ce3-447a-a211-c5caf9ec09cb@amd.com">
      <pre class="moz-quote-pre" wrap="">

Thanks,
Lijo

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
So clear NAK from my side to this patch here.

Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Thanks,
Lijo

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Regards,
Christian.

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Thanks,
Lijo

</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">Regards,
Christian.

</pre>
                <blockquote type="cite">
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">            } else {
                ret = readl(((void __iomem *)adev-&gt;rmmio) + (reg
* 4));
            }
@@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct
amdgpu_device *adev,
                                 &amp;rlcg_flag)) {
                ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0,
rlcg_flag,
GET_INST(GC, xcc_id));
            } else if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;
-            amdgpu_sriov_runtime(adev) &amp;&amp;
-            down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {
-            ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
-            up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+            amdgpu_sriov_runtime(adev) {
+            if (down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {
+                ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
+                up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+            }
            } else {
                ret = readl(((void __iomem *)adev-&gt;rmmio) + (reg
* 4));
            }
@@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device
*adev,
          if ((reg * 4) &lt; adev-&gt;rmmio_size) {
            if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;
-            amdgpu_sriov_runtime(adev) &amp;&amp;
-            down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {
-            amdgpu_kiq_wreg(adev, reg, v, 0);
-            up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+            amdgpu_sriov_runtime(adev) {
+            if (down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {
+                amdgpu_kiq_wreg(adev, reg, v, 0);
+                up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+            }
            } else {
                writel(v, ((void __iomem *)adev-&gt;rmmio) + (reg *
4));
            }
@@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct
amdgpu_device *adev,
                                 &amp;rlcg_flag)) {
                amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
GET_INST(GC, xcc_id));
            } else if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;
-            amdgpu_sriov_runtime(adev) &amp;&amp;
-            down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {
-            amdgpu_kiq_wreg(adev, reg, v, xcc_id);
-            up_read(&amp;adev-&gt;reset_domain-&gt;sem);
-        } else {
+            amdgpu_sriov_runtime(adev) {
+            if (down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem)) {
+                amdgpu_kiq_wreg(adev, reg, v, xcc_id);
+                up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+            }
+            } else {
                writel(v, ((void __iomem *)adev-&gt;rmmio) + (reg *
4));
            }
        } else {
</pre>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------Ko0g1FNgMsuxOoancoKhuP89--
