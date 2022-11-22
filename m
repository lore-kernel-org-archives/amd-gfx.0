Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBCDC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 11:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0830A10E3CD;
	Tue, 22 Nov 2022 11:53:28 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34B710E07E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 11:53:23 +0000 (UTC)
Received: from [192.168.178.53] (82-71-8-225.dsl.in-addr.zen.co.uk
 [82.71.8.225])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbeckett)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 265876602AD8;
 Tue, 22 Nov 2022 11:53:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1669118002;
 bh=Aovf2CwNDzFui7lUmvufMoQOABRhlN8HJreRHfDIgys=;
 h=Date:To:Cc:From:Subject:From;
 b=odgL/lqPh2qovKbnpD5q/VBlbdR9GkPBhr0D6gS2htkmk7cOVZIAlrcWAElGuI5PW
 NZjbsaDjjuJLFuT3xWVAzvVxtQ00NI/O8UzJPWg0Kc583csJgNOMwllaqIU8GlvmeS
 Zek+WpmM8VwRZkvA97iZU3UJvrnkGs7mtn2YH+gx8FMyv1UQdhljmHz4pE3okJ66nM
 fk7c7wAP644HP16qW1KzZA4Ymy+3gWEZOwplcpqlrPH8gZIlIxriUSFH2vD4h+P2+C
 A35mg9nRo0G+RDB+3HTjQ37tOIRSIaimV/P8v8XEHpm70uY1ThnFeh2Cw7N/kJGOsO
 s00dj73yH9ZWg==
Content-Type: multipart/alternative;
 boundary="------------g9ekZyd0eKzlxu70zP0O3wcz"
Message-ID: <622f20c5-5c24-d1c5-f874-6cb80b365e2e@collabora.com>
Date: Tue, 22 Nov 2022 11:53:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
Content-Language: en-US
From: Robert Beckett <bob.beckett@collabora.com>
Subject: Help debug amdgpu faults
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
Cc: =?UTF-8?Q?Adri=c3=a1n_Mart=c3=adnez_Larumbe?=
 <adrian.larumbe@collabora.com>, Daniel Stone <daniels@collabora.com>,
 Dmitrii Osipenko <dmitry.osipenko@collabora.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------g9ekZyd0eKzlxu70zP0O3wcz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


does anyone know any documentation, or can provide advice on debugging 
amdgpu fault reports?


e.g:

Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: [gfxhub] 
page fault (src_id:0 ring:8 vmid:1 pasid:32769, for process vkcube pid 
999 thread vkcube pid 999)
Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: in page 
starting at address 0x0000800100700000 from client 0x1b (UTCL2)
Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: 
GCVM_L2_PROTECTION_FAULT_STATUS:0x00101A10
Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: Faulty UTCL2 
client ID: SDMA0 (0xd)
Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: MORE_FAULTS: 0x0
Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: 
WALKER_ERROR: 0x0
Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: 
PERMISSION_FAULTS: 0x1
Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: 
MAPPING_ERROR: 0x0
Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: RW: 0x0



seehttps://gitlab.freedesktop.org/drm/amd/-/issues/2267  for more context.

We have a complicated setup involving rendering then blitting to virtio-gpu exported dmabufs, with plenty of hacks in the mesa and xwayland stacks, so we are considering this our issue to debug, and not an issue with the driver at this point.
However, having debugged all the interesting parts leading to these faults, I am unable to decode the fault report to correlate to a buffer.

in the fault report, what address space is the address from?
given that the fault handler shifts the reported addres up by 12, I assume it is a 4K pfn which makes me assume a physical address is this correct?
if so, is that a vram pa or a host system memory pa?
is there any documentation for the other fields reported like the fault status etc?

I'd appreciate any advice you could give to help us debug further.

Thanks

Bob

--------------g9ekZyd0eKzlxu70zP0O3wcz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi,</p>
    <p><br>
    </p>
    <p>does anyone know any documentation, or can provide advice on
      debugging amdgpu fault reports?</p>
    <p><br>
    </p>
    <p>e.g:</p>
    <pre class="code highlight" lang="plaintext"><span id="LC1" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: [gfxhub] page fault (src_<a class="moz-txt-link-freetext" href="id:0">id:0</a> <a class="moz-txt-link-freetext" href="ring:8">ring:8</a> <a class="moz-txt-link-freetext" href="vmid:1">vmid:1</a> <a class="moz-txt-link-freetext" href="pasid:32769">pasid:32769</a>, for process vkcube pid 999 thread vkcube pid 999)                                                                                                                                                        </span>
<span id="LC2" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:   in page starting at address 0x0000800100700000 from client 0x1b (UTCL2)                   </span>
<span id="LC3" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_<a class="moz-txt-link-freetext" href="STATUS:0x00101A10">STATUS:0x00101A10</a>                                                                                                                                                                                                                        </span>
<span id="LC4" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)                 </span>
<span id="LC5" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          MORE_FAULTS: 0x0</span>
<span id="LC6" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          WALKER_ERROR: 0x0</span>
<span id="LC7" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          PERMISSION_FAULTS: 0x1</span>
<span id="LC8" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          MAPPING_ERROR: 0x0</span>
<span id="LC9" class="line" lang="plaintext">Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          RW: 0x0</span>



see <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/2267">https://gitlab.freedesktop.org/drm/amd/-/issues/2267</a> for more context.

We have a complicated setup involving rendering then blitting to virtio-gpu exported dmabufs, with plenty of hacks in the mesa and xwayland stacks, so we are considering this our issue to debug, and not an issue with the driver at this point.
However, having debugged all the interesting parts leading to these faults, I am unable to decode the fault report to correlate to a buffer.

in the fault report, what address space is the address from?
given that the fault handler shifts the reported addres up by 12, I assume it is a 4K pfn which makes me assume a physical address is this correct?
if so, is that a vram pa or a host system memory pa?
is there any documentation for the other fields reported like the fault status etc?

I'd appreciate any advice you could give to help us debug further.

Thanks

Bob

</pre>
    <p></p>
  </body>
</html>

--------------g9ekZyd0eKzlxu70zP0O3wcz--
