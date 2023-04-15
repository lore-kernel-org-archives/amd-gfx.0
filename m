Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8290AC77B77
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 07:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140EA10E3A2;
	Mon, 17 Apr 2023 07:30:18 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE2710E06B;
 Sat, 15 Apr 2023 05:27:40 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 46480601E3;
 Sat, 15 Apr 2023 05:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3E2C433D2;
 Sat, 15 Apr 2023 05:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1681536457;
 bh=kZR8ns5F4Bcc2fBZdAJkdaZdvVij/HL8fonVpVxmF5o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tgzqhriUxI6WynT+M/ainvFueDAIE9XMhjUOpMUhaLqWyQ20KH4aBkrNQuS7emj8c
 Fsou7e2+b2D1W4taJQ8/uY1y/D6oLiBtxcOmIMBypROx5BrQgUyq+ZzEZM/YooxQXg
 rEEG9EQqNAPRQU/N7UGXUF+we+3k6HkxqotYRyuE=
Date: Sat, 15 Apr 2023 07:27:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH 1/7] mm/gup: remove unused vmas parameter from
 get_user_pages()
Message-ID: <ZDo1xtPG-7R8Zdr0@kroah.com>
References: <cover.1681508038.git.lstoakes@gmail.com>
 <d40cb239d0ca01e51f7fc2a276398e8f4dedf9ff.1681508038.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40cb239d0ca01e51f7fc2a276398e8f4dedf9ff.1681508038.git.lstoakes@gmail.com>
X-Mailman-Approved-At: Mon, 17 Apr 2023 07:30:15 +0000
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
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 dri-devel@lists.freedesktop.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 Jarkko Sakkinen <jarkko@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, "H . Peter Anvin" <hpa@zytor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Airlie <airlied@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-sgx@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Apr 15, 2023 at 12:27:13AM +0100, Lorenzo Stoakes wrote:
> No invocation of get_user_pages() uses the vmas parameter, so remove
> it.
> 
> The GUP API is confusing and caveated. Recent changes have done much to
> improve that, however there is more we can do. Exporting vmas is a prime
> target as the caller has to be extremely careful to preclude their use
> after the mmap_lock has expired or otherwise be left with dangling
> pointers.
> 
> Removing the vmas parameter focuses the GUP functions upon their primary
> purpose - pinning (and outputting) pages as well as performing the actions
> implied by the input flags.
> 
> This is part of a patch series aiming to remove the vmas parameter
> altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
