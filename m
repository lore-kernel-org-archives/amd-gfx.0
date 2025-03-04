Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55BBC282D2
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5975110E08E;
	Tue,  4 Mar 2025 16:26:46 +0000 (UTC)
X-Greylist: delayed 377 seconds by postgrey-1.36 at gabe;
 Tue, 04 Mar 2025 12:12:09 UTC
Received: from moo.glines.org (moo.glines.org [34.198.131.220])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4EA2410E595
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 12:12:09 +0000 (UTC)
Received: from [IPV6:2600:4040:7207:aa10:2d8e:bf85:6b4e:52f8] (unknown
 [IPv6:2600:4040:7207:aa00::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: infinoid)
 by moo.glines.org (Postfix) with ESMTPSA id 4DF3B613C8;
 Tue,  4 Mar 2025 07:05:47 -0500 (EST)
Message-ID: <ec2cb30b-7739-4ec7-a290-b1fbc7ea167b@glines.org>
Date: Tue, 4 Mar 2025 07:05:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add initial documentation for debugfs files
To: alexander.deucher@amd.com
References: <20250303230149.3544994-1-alexander.deucher@amd.com>
Content-Language: en-US
Cc: amd-gfx@lists.freedesktop.org
From: Mark Glines <mark@glines.org>
In-Reply-To: <20250303230149.3544994-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 04 Mar 2025 16:26:45 +0000
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

Hi Alex,

I had a few editing notes.

On 3/3/25 6:01 PM, Alex Deucher wrote:
> Describes what debugfs files are available and what
> they are used for.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/debugfs.rst | 201 +++++++++++++++++++++++++++
>  Documentation/gpu/amdgpu/index.rst   |   1 +
>  2 files changed, 202 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/debugfs.rst
> 
> diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amdgpu/debugfs.rst
> new file mode 100644
> index 0000000000000..9d82c770c1e78
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/debugfs.rst
> @@ -0,0 +1,201 @@
> +==============
> +AMDGPU DebugFS
> +==============
> +
> +The amdgpu driver provides a number of debugfs files to aid in debugging
> +issues in the driver.

Suggest adding "These are found under dri/<card-id>/.", or something similar.


> +amdgpu_gem_info
> +---------------
> +
> +Lists all of the PIDs using the GPU and the GPU buffers that are they have

s/are //

> +allocated.  This lists the buffer size, pool (VRAM, GTT, etc.), and buffer
> +attributes (CPU access required, CPU cache attributes, etc.).
> +
> +amdgpu_vm_info
> +--------------
> +
> +Lists all of the PIDs using the GPU and the GPU buffers that are they have

s/are //

> +allocated as well as the status of those buffers relative to that process'
> +GPU virtual address space (e.g., evicted, idle, invalidated, etc.).
> +
> +amdgpu_sa_info
> +--------------
> +
> +Prints out all of the suballocations by the suballocation manager in the
> +kernel driver.  Prints the GPU address, size, and fence info associated
> +with each suballocation.  They suballocations are used internally within

s/They/The/

> +the kernel driver for various things.

