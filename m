Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2C2C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 16:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD98610E153;
	Mon,  8 Jan 2024 16:24:58 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F8510E153
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 16:24:57 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e4cb5328aso341845e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jan 2024 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704731095; x=1705335895; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23Bwd6CHfFnhPLuovxa/8Rvggc/IHSpFAZiZk8bIGVc=;
 b=ZwW3aheNsinFRLoGXaocu+lCJ1xhCQrU+5b470g9QgvPcOJ3+RjVs/oOOhfGnjlBmY
 uZ/9XWjAKKY0ikf9Zv0qz7vNvrEkFQMoOKDEJOnYRxOadLINNcVWNM+s5QGqx2hirj/W
 gPHICojSu2wctILcg2XsiFR1TaZZwjCYuO6K2EMxEiiimUzoL8P1jsSQYlWpdldMIxfS
 0uRpUDocvRRE0oBV9QFM8rCOfyyKQTPmue7XIccTTBY5b2+AklSK8E6/5EoBHJjJFAxt
 RfrIj9lcr1mrXUqiPZSJOQHktAPbrSREAUqIXBaFMzd/Rk+eB9Uscnpp79QuTLSx6Ep3
 UTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704731095; x=1705335895;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=23Bwd6CHfFnhPLuovxa/8Rvggc/IHSpFAZiZk8bIGVc=;
 b=IXL7rMjO9RCnRj7VvqoUiJPeGdL0rGg+RnFydchRhpGAPLERqVPAncebeRvgSqLNmv
 1mNarAv163Bv0RJmhQ0ZsIVWic0GOUu7taaxQMk14VoZH3JrWUr6lxGT5xIwHFt3wWkG
 R7na6DgEJmRoXZDQTOcx8Q3/VNTSrh9v5ljmNeqrgmb8lpnxoqBQWPGyifQV3JQKWhop
 yOcfyvQFs07KJk6g6UFQPivjSbLZMgOl/IjNSsvj1Q5erUhkNMUyR3C1qj4XATfHVE8x
 qzS/tELinMAQSLxvJmvh/B3lTW7DXXHCHGhTdf9QizfTGsjZOidzwO4b8kiRlUnm4Hn9
 jWDA==
X-Gm-Message-State: AOJu0YzkiWsrFhDVSSJlN97JyFp1kb1iJSjgJWXBO/+fu93o9+03sZfu
 RpXoixJyFLuceWIcLP0HBus=
X-Google-Smtp-Source: AGHT+IFewYMOt5eKin1V1UBF9lFwVRmOpfVV/413iDGtnWY0ppn5u/XA2CvgqPMCyApm9DS2DGtX+A==
X-Received: by 2002:a5d:4fc4:0:b0:337:4eb6:199c with SMTP id
 h4-20020a5d4fc4000000b003374eb6199cmr2129072wrw.60.1704731095204; 
 Mon, 08 Jan 2024 08:24:55 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g4-20020adfa484000000b00336344c3c3fsm38204wrb.90.2024.01.08.08.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 08:24:54 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------8I1zluleVctX5oqAvJwB8L32"
Message-ID: <8f5910f7-f19f-409d-871e-97ff3bad5a43@gmail.com>
Date: Mon, 8 Jan 2024 17:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
 <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
 <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
 <3d92db26-dc1b-48d7-84e1-2e509742f174@gmail.com>
 <3f060c10-15be-4aef-916c-dbcb554c35c2@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3f060c10-15be-4aef-916c-dbcb554c35c2@amd.com>
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
Cc: Alexander.Deucher@amd.com, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------8I1zluleVctX5oqAvJwB8L32
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.01.24 um 10:24 schrieb Ma, Jun:
> Hi Christian,
>
> On 1/5/2024 9:39 PM, Christian König wrote:
>> Am 21.12.23 um 02:58 schrieb Ma, Jun:
>>> Hi Christian,
>>>
>>>
>>> On 12/20/2023 10:10 PM, Christian König wrote:
>>>> Am 19.12.23 um 06:58 schrieb Ma Jun:
>>>>> Print a warnning message if the system can't access
>>>>> the resize bar register when using large bar.
>>>> Well pretty clear NAK, we have embedded use cases where this would
>>>> trigger an incorrect warning.
>>>>
>>>> What should that be good for in the first place?
>>>>
>>> Some customer platforms do not enable mmconfig for various reasons, such as
>>> bios bug, and therefore cannot access the GPU extend configuration
>>> space through mmio.
>>>
>>> Therefore, when the system enters the d3cold state and resumes,
>>> the amdgpu driver fails to resume because the extend configuration
>>> space registers of GPU can't be restored. At this point, Usually we
>>> only see some failure dmesg log printed by amdgpu driver, it is
>>> difficult to find the root cause.
>>>
>>> So I thought it would be helpful to print some warning messages at
>>> the beginning to identify problems quickly.
>> Interesting bug, but we can't do this here. We have a couple of devices
>> where the REBAR cap isn't enabled for some reason (or not correctly
>> enabled).
>>
>> In this case this would print a warning even when there isn't anything
>> wrong.
>>
>> What we could potentially do is to check for the MSI extension, that
>> should always be there if I'm not completely mistaken.
>>
> Do you mean MSI-X? There are no extended capability registers related with
> MSI or MSI-x.
>
> How about reading the 0x100 register in the extended config space since the
> extended capabilities always start from the offset 0x100 according the pcie
> spec.

Yeah, that should work as well. At least some extension should be there 
in the extended config space.

>> But how does this hardware platform even works without the extended mmio
>> space? I mean we can't even enable/disable MSI in that configuration if
>> I'm not completely mistaken.
> I think the MSI related configuration registers are in the legacy
> configuration space. So the system don't need to use mmio to access these
> registers.

Ah, yes that could explain it.

Thanks,
Christian.

>
> Regards,
> Ma Jun
>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Ma Jun
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Ma Jun<Jun.Ma2@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>>>>     1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 4b694696930e..e7aedb4bd66e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>>>>>     		__clear_bit(wb, adev->wb.used);
>>>>>     }
>>>>>     
>>>>> +static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
>>>>> +{
>>>>> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
>>>>> +		DRM_WARN("System can't access the resize bar register,please check!!\n");
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * amdgpu_device_resize_fb_bar - try to resize FB BAR
>>>>>      *
>>>>> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>>>>     
>>>>>     	/* skip if the bios has already enabled large BAR */
>>>>>     	if (adev->gmc.real_vram_size &&
>>>>> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
>>>>> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
>>>>> +		amdgpu_find_rb_register(adev);
>>>>>     		return 0;
>>>>> +	}
>>>>>     
>>>>>     	/* Check if the root BUS has 64bit memory resources */
>>>>>     	root = adev->pdev->bus;

--------------8I1zluleVctX5oqAvJwB8L32
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 08.01.24 um 10:24 schrieb Ma, Jun:<br>
    <blockquote type="cite"
      cite="mid:3f060c10-15be-4aef-916c-dbcb554c35c2@amd.com">
      <pre class="moz-quote-pre" wrap="">Hi Christian,

On 1/5/2024 9:39 PM, Christian König wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 21.12.23 um 02:58 schrieb Ma, Jun:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Hi Christian,


On 12/20/2023 10:10 PM, Christian König wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Am 19.12.23 um 06:58 schrieb Ma Jun:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Print a warnning message if the system can't access
the resize bar register when using large bar.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Well pretty clear NAK, we have embedded use cases where this would
trigger an incorrect warning.

What should that be good for in the first place?

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Some customer platforms do not enable mmconfig for various reasons, such as
bios bug, and therefore cannot access the GPU extend configuration
space through mmio.

Therefore, when the system enters the d3cold state and resumes,
the amdgpu driver fails to resume because the extend configuration
space registers of GPU can't be restored. At this point, Usually we
only see some failure dmesg log printed by amdgpu driver, it is
difficult to find the root cause.

So I thought it would be helpful to print some warning messages at
the beginning to identify problems quickly.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Interesting bug, but we can't do this here. We have a couple of devices 
where the REBAR cap isn't enabled for some reason (or not correctly 
enabled).

In this case this would print a warning even when there isn't anything 
wrong.

What we could potentially do is to check for the MSI extension, that 
should always be there if I'm not completely mistaken.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Do you mean MSI-X? There are no extended capability registers related with
MSI or MSI-x.

How about reading the 0x100 register in the extended config space since the
extended capabilities always start from the offset 0x100 according the pcie
spec.</pre>
    </blockquote>
    <br>
    Yeah, that should work as well. At least some extension should be
    there in the extended config space.<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite"
      cite="mid:3f060c10-15be-4aef-916c-dbcb554c35c2@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">But how does this hardware platform even works without the extended mmio 
space? I mean we can't even enable/disable MSI in that configuration if 
I'm not completely mistaken.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think the MSI related configuration registers are in the legacy
configuration space. So the system don't need to use mmio to access these
registers.</pre>
    </blockquote>
    <br>
    Ah, yes that could explain it.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:3f060c10-15be-4aef-916c-dbcb554c35c2@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
Ma Jun

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Regards,
Ma Jun

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Regards,
Christian.

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Signed-off-by: Ma Jun <a class="moz-txt-link-rfc2396E" href="mailto:Jun.Ma2@amd.com">&lt;Jun.Ma2@amd.com&gt;</a>
---
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
   1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..e7aedb4bd66e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
   		__clear_bit(wb, adev-&gt;wb.used);
   }
   
+static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
+{
+	if (!pci_find_ext_capability(adev-&gt;pdev, PCI_EXT_CAP_ID_REBAR))
+		DRM_WARN("System can't access the resize bar register,please check!!\n");
+}
+
   /**
    * amdgpu_device_resize_fb_bar - try to resize FB BAR
    *
@@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
   
   	/* skip if the bios has already enabled large BAR */
   	if (adev-&gt;gmc.real_vram_size &amp;&amp;
-	    (pci_resource_len(adev-&gt;pdev, 0) &gt;= adev-&gt;gmc.real_vram_size))
+	    (pci_resource_len(adev-&gt;pdev, 0) &gt;= adev-&gt;gmc.real_vram_size)) {
+		amdgpu_find_rb_register(adev);
   		return 0;
+	}
   
   	/* Check if the root BUS has 64bit memory resources */
   	root = adev-&gt;pdev-&gt;bus;
</pre>
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

--------------8I1zluleVctX5oqAvJwB8L32--
