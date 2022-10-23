Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00729FA373D
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Oct 2022 20:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CEE10E1F0;
	Sun, 23 Oct 2022 20:09:42 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FE510E1F0
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Oct 2022 20:09:35 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CC18360F1E;
 Sun, 23 Oct 2022 20:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76F7C433C1;
 Sun, 23 Oct 2022 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666555771;
 bh=Xh170m2MPAycTlCxN9ZIqms5387Ekq3BgBUqfqKYrhI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nr1IWUdRABMBmoQ+m1iaGTrw9YBLI9hfnAdHG9l8lGqdwvvh2xMg39U4+u+Tlt8Q7
 I7iaci787L3j7eJ7+3DbxmF5NKLLJfwGLx6vlCmqANegaDo5WQPFuCdEP2WvwzK2tM
 3FEUvRrMOT1ei6n1gy0bDVQFndbGQFZgQaGVKN7W84znZtFen3VG6yK+ltatBHFm5F
 Ayjgjqd0F/HQ7mOQ08xJcRGWAZE/4Sujx54wbE504Izo3wFJAGS2CWcrF6XrOEauaU
 6AVCVe/VQt0VmMngo1KHhFq6lyICM2p65QLQoyrLkx8GPaZW0IUqymhCiYj07E2jQK
 lJHOKMcvPalvQ==
Date: Sun, 23 Oct 2022 23:09:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 2/5] x86/sgx: use VM_ACCESS_FLAGS
Message-ID: <Y1WfdDBzOUumhJ65@kernel.org>
References: <20221019034945.93081-1-wangkefeng.wang@huawei.com>
 <20221019034945.93081-3-wangkefeng.wang@huawei.com>
 <Y1WfD1x+XDi3xvpL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1WfD1x+XDi3xvpL@kernel.org>
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
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Dinh Nguyen <dinguyen@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-sgx@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Oct 23, 2022 at 11:07:47PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 19, 2022 at 11:49:42AM +0800, Kefeng Wang wrote:
> > Simplify VM_READ|VM_WRITE|VM_EXEC with VM_ACCESS_FLAGS.
> > 
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> > index 1ec20807de1e..6225c525372d 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -268,7 +268,7 @@ static struct sgx_encl_page *sgx_encl_load_page_in_vma(struct sgx_encl *encl,
> >  						       unsigned long addr,
> >  						       unsigned long vm_flags)
> >  {
> > -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
> > +	unsigned long vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
> >  	struct sgx_encl_page *entry;
> >  
> >  	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
> > @@ -502,7 +502,7 @@ static void sgx_vma_open(struct vm_area_struct *vma)
> >  int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
> >  		     unsigned long end, unsigned long vm_flags)
> >  {
> > -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
> > +	unsigned long vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
> >  	struct sgx_encl_page *page;
> >  	unsigned long count = 0;
> >  	int ret = 0;
> > -- 
> > 2.35.3
> > 
> 
> Why?

Only benefit I see is a downside: you have xref VM_ACCESS_FLAGS, which
is counter-productive. Zero gain.

BR, Jarkko
