Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0BBC3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 10:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B68EC10E029;
	Thu, 27 Mar 2025 10:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VZs1Y/Bg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C88C10E029
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 10:53:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 34D32614B0;
 Thu, 27 Mar 2025 10:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A79C4CEDD;
 Thu, 27 Mar 2025 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743072803;
 bh=Rc5Mxq2TcTjCXS+XzMz/toWf3IRsgO9pO5DY9xPzNxs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VZs1Y/Bg9TzbUqnxAfKTcnAhDWFmYuuFVY1Z6pVv+WMAH4FXKXhzprH5MSBGSEDO2
 yhUa7jVZfeaLhh7k0366tHZbTsYVR0BU3rrEWlqfeqZngCSvwL1TRvAjx/X5Bp/SK6
 FApxRp6GyHlQKlIpaktNjCorBy1xb0kmMzfERTPM0blrVhgYM8tImW2KuyAWOVV0lz
 7BxtvzyRZehR8nRBa7TjcmGbiK3KjX4zrUDubCZBzI/dHIMPk/GrTNlo57M0G6oRBy
 HUBTHYhBzDikmEOtdfrQkMSlAe72R0d655pvqstduwzJ443+4SNi0bqEJqKfQKRoJv
 Lj7jyZx58Rz/w==
Date: Thu, 27 Mar 2025 11:53:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: commit 7ffb791423c7 breaks steam game
Message-ID: <Z-UuHkUPy60e1GWM@gmail.com>
References: <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
 <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
 <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
 <261e7069-9f65-4a89-95cb-25c224ff04f1@nvidia.com>
 <eb041c610719c8275d321c4c420c0b006d31d9f4.camel@web.de>
 <76672910-423c-4664-a1bd-da5c1d7d6afd@nvidia.com>
 <a9f37e3b-2192-42d2-8d5d-c38c0d3fe509@nvidia.com>
 <79a263b2af01e7ed6594ca5896048bd9d7aae35e.camel@web.de>
 <c6d996b4-5e44-4066-964c-5a2a27dfaa6a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6d996b4-5e44-4066-964c-5a2a27dfaa6a@nvidia.com>
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


* Balbir Singh <balbirs@nvidia.com> wrote:

> > Yes, turning off CONFIG_HSA_AMD_SVM fixes the issue, the strange memory
> > resource 
> > afe00000000-affffffffff : 0000:03:00.0
> > is gone.
> > 
> > If one would add a max_pyhs_addr argument to devm_request_free_mem_region()
> > (which return the resource addr in kgd2kfd_init_zone_device()) one could keep
> > the memory below the 44bit limit with CONFIG_HSA_AMD_SVM enabled.
> > 
> 
> Thanks for reporting the result, does this patch work
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 01ea7c6df303..14f42f8012ab 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -968,8 +968,9 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>  	WARN_ON_ONCE(ret);
>  
>  	/* update max_pfn, max_low_pfn and high_memory */
> -	update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
> -				  nr_pages << PAGE_SHIFT);
> +	if (!params->pgmap)
> +		update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
> +					  nr_pages << PAGE_SHIFT);
>  
>  	return ret;
>  }
> 
> It basically prevents max_pfn from moving when the inserted memory is 
> zone_device.
> 
> FYI: It's a test patch and will still create issues if the amount of 
> present memory (physically) is very high, because the driver need to 
> enable use_dma32 in that case.

So this patch does the trick for Bert, and I'm wondering what the best 
fix here would be overall, because it's a tricky situation.

Am I correct in assuming that with enough physical memory this bug 
would trigger, with and without nokaslr?

I *think* the best approach going forward would be to add the above 
quirk the the x86 memory setup code, but also issue a kernel warning at 
that point with all the relevant information included, so that the 
driver's use_dma32 bug can at least be indicated?

That might also trigger for other systems, because if this scenario is 
so spurious, I doubt it's the only affected driver ...

Thanks,

	Ingo
