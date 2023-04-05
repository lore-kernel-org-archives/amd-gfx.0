Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36987C76188
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 10:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B4210E8CA;
	Wed,  5 Apr 2023 10:47:51 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0887310E04B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 05:32:33 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrtYh30Hrz4wj7;
 Wed,  5 Apr 2023 15:32:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1680672746;
 bh=6cvZnTNdwRmgAZ2M1VYA2Gsp2e92pYs++vVV/vBNJI0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YfZvmH+FVv9XziLRu5Qy0A59sFncSyDVUTEY9XnAANVK87Rj7BcIp7Pr4igO888Wj
 7fEVYZ6ezUGVvYRpfEYBpt+/rsqwlyGm51T1Ocbfrth0iO8J2iYQ/zNcI+duNkPddP
 WEJa9k0ih/LUCi1xme4jWirECKyad4GxjkLJWaEhO3XIUbU4QGr8M6rqqrUxvYlIp3
 XXzlLj1te8KtwjzDxT7Z+8QaiK8N/dA0Ksf1iaIy0DL6VrIHabBAhfTz20X4qWZl9H
 3I7PFOMSZlj3noQzITqlCpBOWSHxa4q3nZC0/kOItcmVaakQrbOHemRvnCnTkSvBSK
 SA4zKynbM994g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: Always build with 128-bit long double
In-Reply-To: <20230404151010.GC25951@gate.crashing.org>
References: <20230404102847.3303623-1-mpe@ellerman.id.au>
 <20230404151010.GC25951@gate.crashing.org>
Date: Wed, 05 Apr 2023 15:32:21 +1000
Message-ID: <87edoyki6y.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 05 Apr 2023 10:47:48 +0000
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
Cc: dan@danny.cz, daniel@octaforge.org, amd-gfx@lists.freedesktop.org,
 tpearson@raptorengineering.com, alexdeucher@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Tue, Apr 04, 2023 at 08:28:47PM +1000, Michael Ellerman wrote:
>> The amdgpu driver builds some of its code with hard-float enabled,
>> whereas the rest of the kernel is built with soft-float.
>> 
>> When building with 64-bit long double, if soft-float and hard-float
>> objects are linked together, the build fails due to incompatible ABI
>> tags.
>
>> Currently those build errors are avoided because the amdgpu driver is
>> gated on 128-bit long double being enabled. But that's not a detail the
>> amdgpu driver should need to be aware of, and if another driver starts
>> using hard-float the same problem would occur.
>
> Well.  The kernel driver either has no business using long double (or
> any other floating point even) at all, or it should know exactly what is
> used: double precision, double-double, or quadruple precision.  Both of
> the latter two are 128 bits.

In a perfect world ... :)

>> All versions of the 64-bit ABI specify that long-double is 128-bits.
>> However some compilers, notably the kernel.org ones, are built to use
>> 64-bit long double by default.
>
> Mea culpa, I suppose?  But builddall doesn't force 64 bit explicitly.
> I wonder how this happened?  Is it maybe a problem in the powerpc64le
> config in GCC itself?

Not blaming anyone, just one of those things that happens. The
toolchains the distros (Ubuntu/Fedora) build all seem to use 128, but
possibly that's because someone told them to configure them that way at
some point.

> I have a patch from summer last year (Arnd's
> toolchains are built without it) that does
> +       powerpc64le-*)  TARGET_GCC_CONF=--with-long-double-128
> Unfortunately I don't remember why I did that, and I never investigated
> what the deeper problem is :-/

Last summer (aka winter) is when we first discovered this issue with the
long double size being implicated.

See:
  https://git.kernel.org/torvalds/c/c653c591789b3acfa4bf6ae45d5af4f330e50a91

So I guess that's what prompted your patch?

> In either case, the kernel should always use specific types, not rely on
> the toolchain to pick a type that may or may not work.  The correct size
> floating point type alone is not enough, but it is a step in the right
> direction certainly.
>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks.

cheers
