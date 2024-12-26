Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD5FE7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 07:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E313A10E18F;
	Fri, 27 Dec 2024 07:41:14 +0000 (UTC)
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de
 [129.70.45.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CF110E032
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2024 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=math.uni-bielefeld.de; s=default; t=1735216061;
 bh=2v4VbNncfxZ5MKZk/LwLC67uTGFNDKhGHRQAjlBGqLQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qa7EVnRxkMB9x9Iy4SoaDSfZrnN0q8dQrY037BFcEcVkbu9WfhLgZbhFLQBhGEHdj
 pgbM41LBNeo0U9pILfHSJrFotzmfJKV1GUXCkyqowTuNaLMI5zo9RihgXJzVV05t61
 nirXCr+3awAh0GFvihOX+c3U6GVz1aMSSAORMj9ZiC0aow9NUDWU6cldgTCktEhe3m
 nwFXk8m0xnuxuQXMp9RHkKuKz1xTIEzNXO/1dakuGfHuPsubw3bQ+JFG+cNhiR8coW
 fsual+RwZeY+UB05U9utG/9VnDC1moeujBq35dLdU9NKgESxoLrbNMRajisPy+zFxZ
 iow9WCWnx1lTw==
Received: from [192.168.2.10] (58-32-133-N4.customer.vsm.sh [170.133.32.58])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id D6315206CD;
 Thu, 26 Dec 2024 13:27:40 +0100 (CET)
Content-Type: multipart/alternative;
 boundary="------------AKH0rn78d0j7Tm9CpWQxpHLK"
Message-ID: <0117fb18-610d-4761-b7e1-3b479376e9ba@math.uni-bielefeld.de>
Date: Thu, 26 Dec 2024 13:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fix random crashes due to bad kfree
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
Content-Language: en-US
From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; keydata=
 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
 JRHWPGCL3BhOxQ==
In-Reply-To: <Z2yw_eJwR5ih1Npr@debian.local>
X-Mailman-Approved-At: Fri, 27 Dec 2024 07:41:13 +0000
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
--------------AKH0rn78d0j7Tm9CpWQxpHLK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/26/24 02:27, Chris Bainbridge wrote:

> On Thu, Dec 26, 2024 at 12:19:02AM +0100, Tobias Jakobi wrote:
>> Hi Chris!
>>
>> On 12/26/24 00:09, Chris Bainbridge wrote:
>>
>>> Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
>>> available for eDP") added function dm_helpers_probe_acpi_edid, which
>>> fetches the EDID from the BIOS by calling acpi_video_get_edid.
>>> acpi_video_get_edid returns a pointer to the EDID, but this pointer does
>>> not originate from kmalloc - it is actually the internal "pointer" field
>>> from an acpi_buffer struct (which did come from kmalloc).
>>> dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
>>> resulting in memory corruption which leads to random, intermittent
>>> crashes (e.g. 4% of boots will fail with some Oops).
>>>
>>> Fix this by allocating a new array (which can be safely freed) for the
>>> EDID data in acpi_video_get_edid, and correctly freeing the acpi_buffer.
>> Hmm, maybe I'm missing something here. But shouldn't it suffice to just
>> remove the kfree call in dm_helpers_probe_acpi_edid()?
> Yes, that would work to fix the bad kfree, but there would be a small
> memory leak of the acpi_buffer struct. It's not a huge problem since
> this code is rarely run, and the Nouveau code has never tried to free
> the edid buffer and apparently nobody noticed, but it would be better to
> do the correct thing.

OK, thanks for explaining. I didn't immediately understand that 
something was leaking memory. Only that we were freeing something that 
we are not supposed to free.

> One other curiosity is this comment in the code that allocates the
> memory:
>
> case ACPI_ALLOCATE_BUFFER:
> 	/*
> 	 * Allocate a new buffer. We directectly call acpi_os_allocate here to
> 	 * purposefully bypass the (optionally enabled) internal allocation
> 	 * tracking mechanism since we only want to track internal
> 	 * allocations. Note: The caller should use acpi_os_free to free this
> 	 * buffer created via ACPI_ALLOCATE_BUFFER.
> 	 */
>
> Which makes me wonder if all the calls to kfree on acpi_buffer structs
> with ACPI_ALLOCATE_BUFFER in acpi_video.c should actually be calls to
> acpi_os_free instead? I used kfree just for consistency with the
> existing code.

Wouldn't it make more sense to do the memdup handling in 
acpi_video_device_EDID()? This way you have both alloc and free in the 
same function. But I'm no expert when it comes to the ACPI kernel code. 
Just my two cents :-D

With best wishes,
Tobias

--------------AKH0rn78d0j7Tm9CpWQxpHLK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>On 12/26/24 02:27, Chris Bainbridge wrote:</p>
    <blockquote type="cite" cite="mid:Z2yw_eJwR5ih1Npr@debian.local">
      <pre wrap="" class="moz-quote-pre">On Thu, Dec 26, 2024 at 12:19:02AM +0100, Tobias Jakobi wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hi Chris!

On 12/26/24 00:09, Chris Bainbridge wrote:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
available for eDP") added function dm_helpers_probe_acpi_edid, which
fetches the EDID from the BIOS by calling acpi_video_get_edid.
acpi_video_get_edid returns a pointer to the EDID, but this pointer does
not originate from kmalloc - it is actually the internal "pointer" field
from an acpi_buffer struct (which did come from kmalloc).
dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
resulting in memory corruption which leads to random, intermittent
crashes (e.g. 4% of boots will fail with some Oops).

Fix this by allocating a new array (which can be safely freed) for the
EDID data in acpi_video_get_edid, and correctly freeing the acpi_buffer.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Hmm, maybe I'm missing something here. But shouldn't it suffice to just
remove the kfree call in dm_helpers_probe_acpi_edid()?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yes, that would work to fix the bad kfree, but there would be a small
memory leak of the acpi_buffer struct. It's not a huge problem since
this code is rarely run, and the Nouveau code has never tried to free
the edid buffer and apparently nobody noticed, but it would be better to
do the correct thing.</pre>
    </blockquote>
    <p>OK, thanks for explaining. I didn't immediately understand that
      something was leaking memory. Only that we were freeing something
      that we are not supposed to free.<br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:Z2yw_eJwR5ih1Npr@debian.local">
      <pre wrap="" class="moz-quote-pre">One other curiosity is this comment in the code that allocates the
memory:

case ACPI_ALLOCATE_BUFFER:
	/*
	 * Allocate a new buffer. We directectly call acpi_os_allocate here to
	 * purposefully bypass the (optionally enabled) internal allocation
	 * tracking mechanism since we only want to track internal
	 * allocations. Note: The caller should use acpi_os_free to free this
	 * buffer created via ACPI_ALLOCATE_BUFFER.
	 */

Which makes me wonder if all the calls to kfree on acpi_buffer structs
with ACPI_ALLOCATE_BUFFER in acpi_video.c should actually be calls to
acpi_os_free instead? I used kfree just for consistency with the
existing code.
</pre>
    </blockquote>
    <p>Wouldn't it make more sense to do the memdup handling in
      acpi_video_device_EDID()? This way you have both alloc and free in
      the same function. But I'm no expert when it comes to the ACPI
      kernel code. Just my two cents :-D</p>
    <p>With best wishes,<br>
      Tobias<br>
      <br>
    </p>
  </body>
</html>

--------------AKH0rn78d0j7Tm9CpWQxpHLK--
