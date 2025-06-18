Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C9EC71136
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 02:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8EB10E004;
	Wed, 18 Jun 2025 02:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f8UFP8NM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D384610E004
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 02:12:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CCE84A1B6;
 Wed, 18 Jun 2025 02:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0399C4CEE3;
 Wed, 18 Jun 2025 02:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750212734;
 bh=gzCfwKIwjyGV0QAAoEJ57jwHMzI4KtpqYcqIW3aqJkU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=f8UFP8NMXlQxbjEC+5LX9J1C9uvXewsAtRNW5oXIyWMZraFxR+VsdpuxIRmQD1Nrf
 PncUUvOIHRm07e+FiOgogGyBoP16jkwJEmscXKXaqFcMzqvOWHcT8RI6xzaFrVoxse
 r6n2h+LzXFaNJwtinqrvB9HBBPurxbek1pxoonmJo176cc7Su9yIe0bfz8RBeyTlxa
 pCk4aZTSufHrBBUK9kJRYMSNg6eS3tEoOzOJ1yr7vPilLh13bR3GhWH3VvoInv9Q+t
 LYpuKvZqy0OltoQ4u8qpGfGqKMLPd735M/u+9/gYqb1XhRIFh4NnlBrvtn5gGPxGzC
 OrjswNY77eWjA==
Message-ID: <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
Date: Tue, 17 Jun 2025 21:12:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu vs kexec
To: Peter Zijlstra <peterz@infradead.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
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

On 6/16/2025 9:54 AM, Peter Zijlstra wrote:
> On Mon, Jun 16, 2025 at 01:51:21PM +0200, Christian König wrote:
>> Hi Peter,
>>
>> On 6/16/25 11:39, Peter Zijlstra wrote:
>>> Hi guys,
>>>
>>> My (Intel Sapphire Rapids) workstation has a RX 7800 XT and when I kexec
>>> a bunch of times, the amdgpu driver gets upset and barfs on boot.
>>
>> yeah, that is an "intentional" HW feature and yes you're certainly not
>> the first one to complain about it :(
>>
>> The PSP (platform security processor IIRC) is designed in such a way
>> that you can initialize it only once after a power cycle / hard reset
>> for security reasons (e.g. to not leak crypto keys used for digital
>> rights management etc..).
>>
>> On dGPUs we work around that manually by power cycling the ASIC when
>> that situation is detected during amdgpu load, but that unfortunately
>> doesn't work 100% reliable.
> 
> Right.. hence the splats.

How about if we reset before the kexec?  There is a symbol for drivers 
to use to know they're about to go through kexec to do $THINGS.

Something like this:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0fc0eeedc6461..2b1216b14d618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -34,6 +34,7 @@

  #include <linux/cc_platform.h>
  #include <linux/dynamic_debug.h>
+#include <linux/kexec.h>
  #include <linux/module.h>
  #include <linux/mmu_notifier.h>
  #include <linux/pm_runtime.h>
@@ -2544,6 +2545,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
                 adev->mp1_state = PP_MP1_STATE_UNLOAD;
         amdgpu_device_ip_suspend(adev);
         adev->mp1_state = PP_MP1_STATE_NONE;
+
+       if (kexec_in_progress)
+               amdgpu_asic_reset(adev);
  }

  static int amdgpu_pmops_prepare(struct device *dev)

> 
>> On APUs the situation is even worse because the PSP is shared between
>> the GPU and the CPU.
>>
>> We have forwarded such complains internally for years, but there is
>> not much else Alex and I can do about it.
> 
> Oh well. Thanks for the info!
> 

