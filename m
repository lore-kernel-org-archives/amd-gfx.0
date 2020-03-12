Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA98CC1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 18:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8425C20716
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 18:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KnteymGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8425C20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDB66E037;
	Thu, 12 Mar 2020 18:08:47 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF40F6EB02
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 16:37:36 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id f198so7237670qke.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fmA8zKRe76L9QKXynKJ5M/zisBlIkbsLwFQy3LQahYI=;
 b=KnteymGLpkCc/QfvlROTLY5FU+cvnMfHx3Z/DRw8BCFXZt7iuH6QM2L8dGPveQUUn3
 Xlhpfnj22gbb00Ajojd+xRnUeKGKFC/Zglayy3ZU7Fb8m4VFbcrwr40XiWp3ov1/ykVn
 50j0Xys2kPWj8lJQThzi6h+Abasy7fco7NKHepLokp4T3nUslp5eA0azM8UN5ShssXcR
 /coFE6WQnM7yvxRwRmdgJOv84KxclHIi1t/Vuh6HvLG48YWad9Scekhq9v5t4slQNOVw
 VUBakr2wwlLvqTGCCgx2gzI5gxsHdjkTDbdmt7DrBlCzDNkcudKItHAvui1LdFqzC7SL
 O7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fmA8zKRe76L9QKXynKJ5M/zisBlIkbsLwFQy3LQahYI=;
 b=n1b+gQisUilYQI5cTYh6+V4wuSmlnQABXElL3XkkPJWXkgFKlMqf+XKsTUMb4V8YhI
 WzJvUfNRz7ErdJk2bGBEbaLhE4Z5pnEO/FmpCH749z2kBbDeI92KZLE4ecJjKIHfaCRy
 hhMxCil8S1oe3P86WP6PpElstlOGVzY+IS4lHhnQE8ANaeMfWeLpHmWfUsqzT3qXJCPN
 RyEJXnhbbdLV5ZBrRdks0T09qmB2/YiZElN+CzQRd/xGat+0XKYf+aa2vQE7WlWx2xce
 1UgvSwm74Crql3mLD4oWQoLkUSpIeOf35CxoTahqidVU8Ukx1fBPFVYD+xZtFZTIC26Q
 wljw==
X-Gm-Message-State: ANhLgQ1sTYVeRwPEvaoPQEkW5N+OSOIIhTrtZhOhHqJh0grAWVm4udvi
 SP2ALryxn2w/qZbJ9kg+wDcZ7Q==
X-Google-Smtp-Source: ADFU+vsCZGS3KHARg6F0Q8AUmySkB/O1C49CFLK8V1S8E9P7Q1oeOBUV0BmgWYk1CW/U1GncetrzAg==
X-Received: by 2002:ae9:e509:: with SMTP id w9mr8707944qkf.26.1584031055747;
 Thu, 12 Mar 2020 09:37:35 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id f26sm12590660qkl.119.2020.03.12.09.37.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 09:37:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jCQpy-0008RM-Kv; Thu, 12 Mar 2020 13:37:34 -0300
Date: Thu, 12 Mar 2020 13:37:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] mm/hmm: Simplify hmm_vma_walk_pud slightly
Message-ID: <20200312163734.GR31668@ziepe.ca>
References: <5bd778fa-51e5-3e0c-d9bb-b38539b03c8d@arm.com>
 <20200312102813.56699-1-steven.price@arm.com>
 <20200312142749.GM31668@ziepe.ca>
 <58e296a6-d32b-bb37-28ce-ade0f784454d@arm.com>
 <20200312151113.GO31668@ziepe.ca>
 <689d3c56-3d19-4655-21f5-f9aeab3089df@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <689d3c56-3d19-4655-21f5-f9aeab3089df@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 12 Mar 2020 18:08:46 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 12, 2020 at 04:16:33PM +0000, Steven Price wrote:
> > Actually, while you are looking at this, do you think we should be
> > adding at least READ_ONCE in the pagewalk.c walk_* functions? The
> > multiple references of pmd, pud, etc without locking seems sketchy to
> > me.
> 
> I agree it seems worrying. I'm not entirely sure whether the holding of
> mmap_sem is sufficient,

I looked at this question, and at least for PMD, mmap_sem is not
sufficient. I didn't easilly figure it out for the other ones

I'm guessing if PMD is not safe then none of them are.

> this isn't something that I changed so I've just
> been hoping that it's sufficient since it seems to have been working
> (whether that's by chance because the compiler didn't generate multiple
> reads I've no idea). For walking the kernel's page tables the lack of
> READ_ONCE is also not great, but at least for PTDUMP we don't care too much
> about accuracy and it should be crash proof because there's no RCU grace
> period. And again the code I was replacing didn't have any special
> protection.
>
> I can't see any harm in updating the code to include READ_ONCE and I'm happy
> to review a patch.

The reason I ask is because hmm's walkers often have this pattern
where they get the pointer and then de-ref it (again) then
immediately have to recheck the 'again' conditions of the walker
itself because the re-read may have given a different value.

Having the walker deref the pointer and pass the value it into the ops
for use rather than repeatedly de-refing an unlocked value seems like
a much safer design to me.

If this also implicitly relies on a RCU grace period then it is also
missing RCU locking...

I also didn't quite understand why walk_pte_range() skipped locking
the pte in the no_vma case - I don't get why vma would be related to
locking here.

I also saw that hmm open coded the pte walk, presumably for
performance, so I was thinking of adding some kind of pte_range()
callback to avoid the expensive indirect function call per pte, but
hmm also can't have the pmd locked...

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
