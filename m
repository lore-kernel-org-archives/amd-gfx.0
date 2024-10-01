Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFAECEB2FD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 13:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51F610E327;
	Tue,  1 Oct 2024 13:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jSyOPxct";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A894510E054
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 10:04:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 45616A433AF;
 Tue,  1 Oct 2024 10:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF41BC4CEC6;
 Tue,  1 Oct 2024 10:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1727777088;
 bh=i2tcObmlpvsS8NgZbupkXXpot1pmlYredro7AtO+pyc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jSyOPxctnMyGOgWtdIydISdY0Kz4VE1SFalG+VytV1zSTtUSKbWZ2c9MBkuCoCGlP
 vOfjWU6Shc16DwWtFns3jhWGkXGmC9G6cKek60BTY861vz547Oitogvl8Ecgi6tzNl
 ZMA3PwnZSqaU32ROxQVpRZqn6jA5slHhGStcz6Uo=
Date: Tue, 1 Oct 2024 12:04:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024100112-flounder-paralysis-eb25@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
 <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh>
 <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
 <2024090447-boozy-judiciary-849b@gregkh>
 <CADnq5_MZ8s=jcCt_-=D2huPA=X3f5PWNjMhr88xoiKc_JFwQtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MZ8s=jcCt_-=D2huPA=X3f5PWNjMhr88xoiKc_JFwQtw@mail.gmail.com>
X-Mailman-Approved-At: Tue, 01 Oct 2024 13:21:11 +0000
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

On Mon, Sep 30, 2024 at 10:10:25AM -0400, Alex Deucher wrote:
> Resending now that rc1 is out.  These should be ignored for stable.
> 
> 8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
> ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
> 332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
> math_ceil2
> 295d91cbc700 drm/amd/display: Check for NULL pointer
> 6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
> 93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
> 7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_common_modes

Thanks, that helped a lot.

However the following two commits did not apply, is that because they
are already in the tree or do they need someone to properly backport them?

c2ed7002c061 ("drm/amd/display: Use SDR white level to calculate matrix coefficients")
b74571a83fd3 ("drm/amd/display: Use full update for swizzle mode change")

thanks,

greg k-h
