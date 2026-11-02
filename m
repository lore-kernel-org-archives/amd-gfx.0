Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A87606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=IGlmEhh/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DE510ED69;
	Mon,  2 Nov 2026 11:57:57 +0000 (UTC)
X-Greylist: delayed 600 seconds by postgrey-1.36 at gabe;
 Mon, 02 Nov 2026 11:57:50 UTC
Received: from smtpout1.mo528.mail-out.ovh.net
 (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CE010E620
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 11:57:50 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4jJ8qf2VZgz66gB;
 Mon,  2 Nov 2026 11:39:10 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Alexander.Deucher@amd.com>; Mon,  2 Nov 2026 11:39:09 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.164.21])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jJ8qd6Wsnz1yhv; Mon,  2 Nov 2026 11:39:09 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.4])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 28AA83E2067; 
 Mon,  2 Nov 2026 11:39:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00563a1f1cd-8d13-4161-9071-6ea726361eb7,
 0363193DE9501D37FECF48204A38B17C3AEFA4B3) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <e6aa9e92-fd51-4d90-b88e-b346d67eb713@pixelcluster.dev>
Date: Mon, 2 Nov 2026 12:39:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the size in GEM_USERPTR ioctl
To: Perry Yuan <perry.yuan@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Yifan1.Zhang@amd.com
References: <20261102082915.2289352-1-perry.yuan@amd.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <20261102082915.2289352-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8528973269849629172
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEXAdDy2ysV1r/oADLUc5NGa0WUf3vrHOoKNxXtavsNQBTrpZenspx2LoYCTK/KXVx3jrLGFPqrPhVnFyGXzm7mLXJfSv+CC5HvRPTYCHmi23H3IS0il0HqFtxJ9DTEa4IajdQxAr4qSHvG3Jdbwd8DGHyqBBbw867s+ksAhPFsQrWfLkC1r/QL4iiBsnW8S2m63CWYp0LmO23LQqJH/q2YCaFg/w8azLGl66QrhqsRyBnC4/YeSvLcHaONsmI2lYjj2I0BrN57WsFzs4K83yGz1qe+sptebTXt/6Iocu+7/aW9bnQGXblyrGtTbqPG5NqkZBcWj9WfLerDOg4XIz4Mrill4/B8zgPSDQoT5WFugwFzued/mncb6G8pj10wc9PXElnzkeWLjSL+voa/vjAWkYiaM18wTOqPf/AjjTeqbhyue6MoAb3634pu7ADLi4qLhgyrFOr/g5uCDalnMEzfWLgsbPURwptKEO8fxm3pR27RjI14vY5wY8N983H5PKTGiO042R5WUT9+6eWScvC5udTzqTV/ylWptwqCierls1ZUCk7NYIW6SyqSFr5HNusNAzMVN7dp2VaUJK1f/GTAhoX1sz5WnG6J/W7vAbV5DISB3JKfywZasfKm3lfEY2ovqQC7H14PUVKyjG6Yg1ASxFCnXUsMI4ueXMILENbeuA
DKIM-Signature: a=rsa-sha256; bh=luMmSckLKzd2Xt5+u4ry3cc43+eLcf5XARDxRG6dXCE=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1793619550; v=1;
 b=IGlmEhh/ehUVEv6g7WibauDb1df2w/ByDELqflNOfgfsKX79/cfMm4Fmywhj48fGC9NU8wRa
 M7XiRsn6oIk8dTT59mE24tCwCQkAcpG0fhpU9/IsT2Hql3NR67rKS1Ecl/xxEAwtPoACk3mQ2/8
 KImzyisOx+oCm8b8GFsZAm0Jkz4q2vGobFR+VU1/OiiT7RekDCpvWxhrgofR6xJePKcrgCd0kzL
 W4P20dSsSxQwCBTn0rK9miH/cjukEsrZKC0sDErTMwmTteA9xvbDbm4+Cj2MJAqWFKluL90XhjN
 EGmx14ZfYXMaXS/nohgz3l7v4fed+hT7oFcWzUY7fj4Sg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/2/26 09:29, Perry Yuan wrote:
> Nothing limits args->size in amdgpu_gem_userptr_ioctl(), only the
> alignment and access_ok() are checked. Acquiring the DMA addresses for a
> huge range and cleaning everything up again whenever it changes is
> expensive enough that a sufficiently large userptr can keep the machine
> busy more or less indefinitely.
> 
> On top of that the interface is increasingly used as a replacement for
> real driver or udmabuf backed allocations, which it was never meant for.
> 
> Reject a zero size and anything above 1GiB. That is far more than a
> temporary upload buffer needs and stops the ioctl from being abused as a
> general purpose memory allocator.

FWIW, Proton games may attempt to use userptr backing for some game allocations,
and I don't think we can assume that games won't try allocating userptr ranges >1GiB,
nor that games will gracefully handle userptr allocation failing, so hard-capping
the size might break some userspace programs.

Not sure if bad ioctl usage should really be worked around by outright rejecting
certain inputs.

Best,
Natalie

> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index c982d102614e..348693023563 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -566,6 +566,10 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  	if (!access_ok((void __user *)(uintptr_t)args->addr, args->size))
>  		return -EFAULT;
>  
> +	/* Userptrs are for temporary uploads, not a general memory allocator */
> +	if (args->size == 0 || args->size > SZ_1G)
> +		return -EINVAL;
> +
>  	/* reject unknown flag values */
>  	if (args->flags & ~(AMDGPU_GEM_USERPTR_READONLY |
>  	    AMDGPU_GEM_USERPTR_ANONONLY | AMDGPU_GEM_USERPTR_VALIDATE |

