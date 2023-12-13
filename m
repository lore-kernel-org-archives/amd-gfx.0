Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B89C4167D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 16:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526AF10E084;
	Wed, 13 Dec 2023 16:26:53 +0000 (UTC)
X-Greylist: delayed 396 seconds by postgrey-1.36 at gabe;
 Wed, 13 Dec 2023 16:19:52 UTC
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EDC10E782
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
 t=1702483992; bh=4XxyHnJEJKkc+5PvBy8tJ98Zzp6SReQrbmR5u3CSVkY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FdZA5oT75tJH3PJN0bxT2ijMm1wBFi9fAIDpRIiLKEJ8qcv7c86KrC4Caujnwy/Qz
 h0yWOBpr5j9YQlGHX6bTEdnz+dQUQ431E11+MzKZsjI9OYJQRIedzGgmfPSOvFDP5W
 xvNwB4vhFx3KjM5C9g2J1KLykNu0MN4NW1kORqlg=
Received: from [IPV6:240e:388:8d05:a200:783a:c9a8:595e:71d0] (unknown
 [IPv6:240e:388:8d05:a200:783a:c9a8:595e:71d0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E250E600D1;
 Thu, 14 Dec 2023 00:13:11 +0800 (CST)
Message-ID: <cc762327-796a-481b-9d79-3751361daff8@xen0n.name>
Date: Thu, 14 Dec 2023 00:13:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/12] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-7-samuel.holland@sifive.com>
Content-Language: en-US
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20231208055501.2916202-7-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 13 Dec 2023 16:26:50 +0000
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/8/23 13:54, Samuel Holland wrote:
> LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
> asm/fpu.h, so it only needs to add kernel_fpu_available() and export
> the CFLAGS adjustments.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/loongarch/Kconfig           | 1 +
>   arch/loongarch/Makefile          | 5 ++++-
>   arch/loongarch/include/asm/fpu.h | 1 +
>   3 files changed, 6 insertions(+), 1 deletion(-)

This is all intuitive wrapping, so:

Acked-by: WANG Xuerui <git@xen0n.name>

Thanks!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

