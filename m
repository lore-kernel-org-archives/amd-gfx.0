Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93423C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 13:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163F710E99A;
	Wed, 26 Apr 2023 13:11:17 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C9D10E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 12:08:59 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q5yMN19DQz4xMv;
 Wed, 26 Apr 2023 22:08:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20230404102847.3303623-1-mpe@ellerman.id.au>
References: <20230404102847.3303623-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64: Always build with 128-bit long double
Message-Id: <168251050518.3973805.12660158568220286420.b4-ty@ellerman.id.au>
Date: Wed, 26 Apr 2023 22:01:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 26 Apr 2023 13:11:15 +0000
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
Cc: dan@danny.cz, daniel@octaforge.org, tpearson@raptorengineering.com,
 amd-gfx@lists.freedesktop.org, alexdeucher@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 04 Apr 2023 20:28:47 +1000, Michael Ellerman wrote:
> The amdgpu driver builds some of its code with hard-float enabled,
> whereas the rest of the kernel is built with soft-float.
> 
> When building with 64-bit long double, if soft-float and hard-float
> objects are linked together, the build fails due to incompatible ABI
> tags.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64: Always build with 128-bit long double
      https://git.kernel.org/powerpc/c/78f0929884d4811c225fd2c57ecc602c84c07392

cheers
