Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E8BC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6851C10EB58;
	Wed, 26 Aug 2026 12:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DsVkkBrY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C0910E46D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 12:27:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77A8D600C4;
 Wed, 26 Aug 2026 12:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5652C1F000E9;
 Wed, 26 Aug 2026 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787747265;
 bh=1b5BxBxCYq15T9gNAV57zTWWKhZfPx1TqqHG5wvtAXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DsVkkBrYnfLWX2J0XzWx/I8Gk5t/f+H/dn9Tp1KG2VT8WMYzgJ97E+BO+x1ZvvIrW
 OKAv/fTWBIRStE39pq+e6HfXvZl8eSRlu42FOc4v3AzQRIXiJsrnE4o6rGF37Tzw17
 rBGNBW9aVnNkMEh0cLUL+aDgPreQ79Htq0o4VIKyNYqizyfSqMZupeA91Ybftvhldz
 ASCvuBao68bXfPEmHYfdBtTil1dsDUDnd5C9RtV1pQU2QBi6Qxgjg8Gzgz5ybGg1YM
 v9X74JouanhZaTVK+KR+gPsm1O6z5eznrDJRY62RIPWBUMLnRIjqpD2IBliNwqI8rb
 l9F2MaDb8lP9A==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org,
 patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
 shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
 sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH 7.1 000/101] 7.1.11-rc1 review
Date: Wed, 26 Aug 2026 14:27:31 +0200
Message-ID: <20260826122731.33748-1-ojeda@kernel.org>
In-Reply-To: <20260825132541.986300899@linuxfoundation.org>
References: <20260825132541.986300899@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 25 Aug 2026 15:24:38 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.11 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64 and arm32:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

In loongarch64, I am seeing:

    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.o: warning: objtool: amdgpu_vm_handle_fault+0x140: sibling call from callable instruction with modified stack frame

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev

Thanks!

Cheers,
Miguel
