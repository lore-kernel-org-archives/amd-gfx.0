Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21350D26D7D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 19:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8F410E935;
	Fri,  9 Jan 2026 19:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N5hKiiSq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C724810E935;
 Fri,  9 Jan 2026 19:18:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B97DB60160;
 Fri,  9 Jan 2026 19:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2AEC4CEF1;
 Fri,  9 Jan 2026 19:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767986292;
 bh=OKvKp1Ti/hPBY0N6wg+4fPIhnPUnu5v/JxpSgb1bhho=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N5hKiiSqoVUHbTdytYx847LJ4X5nIdddVL9tEXBrYVoUA8LReVINhGKHggVQQf341
 yDpm11/qBvJzHtWgLyj0LCH3wug4q0MyFTVOZoeCoGlaKYHPDy6o630PWNWk3ZPLHj
 8EFKXyANFxtbjT9Yh38sUu4U7ddT370rRWX9rzWk4TcEZkGWWIthSFqtonGF3D1UOQ
 qUSx/uZajWvZ7h3A09nO2zeZHgFEoUHPWgrvNtbJY0mxtmHjuLc8sMgwlapiIoQMXm
 3oDPLAhVw1lZwzbhBDGSdYpBbEdXciiZf62SuvPzeRx+WuCYrb/hy2j4M9VWTQgI3B
 UnDqd7nT7oEUQ==
Date: Fri, 9 Jan 2026 11:18:12 -0800
From: Kees Cook <kees@kernel.org>
To: Yicong Hui <yiconghui@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy() in
 amdgpu_virt_write_vf2pf_data
Message-ID: <202601091117.122A9268@keescook>
References: <20260109162514.308143-1-yiconghui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109162514.308143-1-yiconghui@gmail.com>
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

On Fri, Jan 09, 2026 at 04:25:14PM +0000, Yicong Hui wrote:
> strcpy() is deprecated as it does not do any bounds checking (as
> specified in Documentation/process/deprecated.rst).
> 
> There is a risk of buffer overflow in the case that the value for
> THIS_MODULE->version exceeds the 64 characters. This is unlikely, but
> replacing the deprecated function will pre-emptively remove this risk
> entirely.
> 
> Replace both instances of strcpy() with the safer strscpy() function.

This looks correct to me -- dest and src are both fixed-size, so strscpy
happily checks everything at compile time. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook
