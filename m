Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C28AC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 18:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FA210E791;
	Tue, 25 Feb 2025 18:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="asXJUWs9";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5BEC710E791
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 18:42:32 +0000 (UTC)
Received: from hm-sls2
 (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
 by linux.microsoft.com (Postfix) with ESMTPSA id 011C7203CDDA;
 Tue, 25 Feb 2025 10:42:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 011C7203CDDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740508949;
 bh=wRkknvVwGNrIvqHm/d8V+QKjHBonRK3fAS70qvPpIi0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=asXJUWs9SikwP8u/zQoQFFIYiCQ2ds84jVstUlFuxJgA8mVmIvDwe87wf1RTJ40+u
 PyXI93BsKl04fohHLMCe1g0urfOeBZPZFDbrvciSK0nZir+lGYKpRtiBmL9gIC+bGl
 tgWr8REl5WerYkX8EWpQrr1YUs5Thxaze7MCWbnA=
Date: Tue, 25 Feb 2025 13:42:21 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [PATCH] MAINTAINERS: remove undeliverable entries in RADEON and
 AMDGPU DRM DRIVERS
Message-ID: <Z74PDWLu4wb2bqui@hm-sls2>
References: <20250225091003.890770-1-jeffbai@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225091003.890770-1-jeffbai@aosc.io>
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

On Tue, Feb 25, 2025 at 05:10:03PM +0800, Mingcong Bai wrote:
> While running:
> 
> ./scripts/get_maintainer.pl \
>     drivers/gpu/drm/amd/display/amdgpu_dm \
>     --no-rolestats'
> 
> For a list of Cc's, I got two undeliverable address errors from
> postmaster@amd.com:
> 
>   Xinhui Pan <Xinhui.Pan@amd.com>
>   Hamza Mahfooz <hamza.mahfooz@amd.com>
> 
> I tried to contact Alex Deucher and Christian König back in early
> Februrary, but received no reply.
> 
> To avoid warning emails from the future, remove Xinhui Pan from
> MAINTAINERS and add Hamza Mahfooz to .get_maintainer.ignore.

Can you try on the current HEAD of mainline? There is an entry for me in
.mailmap AFAIK.

> 
> Suggested-by: Kexy Biscuit <kexybiscuit@aosc.io>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>  .get_maintainer.ignore | 1 +
>  MAINTAINERS            | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
> index b458815f1d1bf..3343330fb11df 100644
> --- a/.get_maintainer.ignore
> +++ b/.get_maintainer.ignore
> @@ -4,3 +4,4 @@ Christoph Hellwig <hch@lst.de>
>  Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>  Marc Gonzalez <marc.w.gonzalez@free.fr>
>  Ralf Baechle <ralf@linux-mips.org>
> +Hamza Mahfooz <hamza.mahfooz@amd.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff26fa94895d..d6ea828345fdb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19657,7 +19657,6 @@ F:	drivers/net/wireless/quantenna
>  RADEON and AMDGPU DRM DRIVERS
>  M:	Alex Deucher <alexander.deucher@amd.com>
>  M:	Christian König <christian.koenig@amd.com>
> -M:	Xinhui Pan <Xinhui.Pan@amd.com>
>  L:	amd-gfx@lists.freedesktop.org
>  S:	Supported
>  B:	https://gitlab.freedesktop.org/drm/amd/-/issues
> -- 
> 2.48.1
> 
