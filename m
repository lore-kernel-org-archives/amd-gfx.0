Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA4606A6A4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMNa1y10
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA441112D29;
	Fri, 20 Nov 2026 21:58:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57553112D42
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 21:58:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F9F660258;
 Fri, 20 Nov 2026 21:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E1A1F000C0;
 Fri, 20 Nov 2026 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795211899;
 bh=vlohFc+QjOpD0o0Z3rC4eRuijTjNhdQ3/mRUK9izYbo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bMNa1y105hR7ixDVkNk29G+glNwhTF8TK1wKTV3U8PEGJVJHHPWuqMq4BNi2f/u+l
 YhU2b0QzMEJoMuL1ELY8D0Aoq7hFPU8/M83hVyRKLcFtc+DdftHmeQcpQQTFRCWgXh
 STYOdCTvTdnrlaYhSrmoQBcpwp1uj+/AxIqBVWY6vmnOecDyn8hXnEH1qgjbWtNicw
 qqxktVHLnuuEqIqtoVJvtHmi4GJQic4TJ0Hu29TCTt8yOhi3yJXOamTVlbsxDgClrT
 E7x7ob3mdxfNcsCESa8uhuGSJMPLLW7bD1Yt7qkb/ZDTcdw5RPn84IWyHR01IBwcOa
 Np6+X2GlvSusQ==
Message-ID: <sashiko-outbox-226214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Don't require a VM for the profiler PMC lock
To: "Apurv Mishra" <Apurv.Mishra@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261120214925.211726-1-Apurv.Mishra@amd.com>
References: <20261120214925.211726-1-Apurv.Mishra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:58:18 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amdkfd: missing Fixes trailer for commit 8a2a98891184
--

commit 28d61bf0c9928d470a0760fe0edf0322918e49c9
Author: Apurv Mishra <Apurv.Mishra@amd.com>

> drm/amdkfd: Don't require a VM for the profiler PMC lock
>
> The profiler PMC requests now go through kfd_bind_process_to_device() for=
 a
> runtime PM reference, but that also requires a VM on the GPU. A process
> that takes the lock before AMDKFD_IOC_ACQUIRE_VM, as rocprofiler-sdk can,
> now gets -ENODEV.
>
> Take only the runtime PM reference, through a new
> kfd_process_device_runtime_get() method that kfd_bind_process_to_device()
> uses as well.
>
> Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>

[Severity: Low]
This fixes the -ENODEV failure introduced when profile_lock_device() and
kfd_profiler_perfmon_clk() began calling kfd_bind_process_to_device().
Should the commit message include a Fixes tag?

  Fixes: 8a2a98891184 ("drm/amdkfd: Force perfmon clock on for profiler PMC=
 requests")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120214925.2117=
26-1-Apurv.Mishra@amd.com?part=3D1
