Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476A5C4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 18:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B62C2070A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 18:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O+T+k7Qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B62C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD64C6E062;
	Thu, 19 Mar 2020 18:52:16 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 823466EA5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 18:50:18 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id l13so2772248qtv.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+iQmmyqtxCtarJ4YRBKb0yWGqnthI8hUUC43IFJE2lc=;
 b=O+T+k7QcGsKIEHBjgipyL31XPaNddanzbawgGU863gdvDPNIX7LYi3WVs/mOCkQatM
 kp3xPR0l9A+vuyX750Q+3/7jJVu4icOVMoEC/ohdQ5GVvA3ARolXe4ZZVnWtakCYOGal
 boy4qnC1A6on3cpFaP6DgucabbLC6sHg+E7Qo7m9ag0aas++wv/SLWln/6E5qDazux78
 cdzi7JujpLBWCBJqNIB5d7eOJ93n7akLN+Ctr6uYuANCJPwzugp1TU5/0Zr3jU0FqhYQ
 5GF51y82KW0QITwSWN2Y1KbEajR7yA6aP5DQTQFmk2rLd5pBravF6IH6lq8HScNN4zv7
 xo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+iQmmyqtxCtarJ4YRBKb0yWGqnthI8hUUC43IFJE2lc=;
 b=otIDk9krR0mfQTs8yrewWstxvKot/ODbB2JX6nc3T8ShAqawHceWqBHI9N2BJJHEJP
 j5XbOukAA65OIyfrhPXXVFjs5pGPxx9dDrf4zQkMUWPyNj1M9B/hYOx6juEEz1mRfYAD
 C1TTfstBS6hb+4K2cLY5L0jfge9b5vDUWhoAnC6SIsvCc7QyeC/uCSq48zvbcnG4NWv2
 mZv9Cai7UB1Q89UHenKcQmK60/+TqW2ogCEI927NacyIcOTXYhYINadF+rkS0Z71gseo
 R94WY0vzwuRlLTKxZ0ldjhc8dLNBs8QgCowEJxaZJ4sEvBkn11hYLqSQTNq2qTh1XwSb
 GFjQ==
X-Gm-Message-State: ANhLgQ3h2HXXfSVTgxqM8+srL3IEA1bllijAeX8suj50TgbWLBMOeDUV
 gREOT0daPfnJFNXf/Q9kttJc/A==
X-Google-Smtp-Source: ADFU+vvq32in5Qjs8YAHdFEpYAPgT41J1WfLa2uHLd4XxlB1EmISPkcd3J2y54DRcA2TER5nFwTi4A==
X-Received: by 2002:ac8:4548:: with SMTP id z8mr4613857qtn.188.1584643817615; 
 Thu, 19 Mar 2020 11:50:17 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id 82sm2177475qkd.62.2020.03.19.11.50.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 19 Mar 2020 11:50:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jF0FD-0004NT-Vw; Thu, 19 Mar 2020 15:50:15 -0300
Date: Thu, 19 Mar 2020 15:50:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: ensure device private pages have an owner v2
Message-ID: <20200319185015.GM20941@ziepe.ca>
References: <20200316193216.920734-1-hch@lst.de>
 <20200319002849.GG20941@ziepe.ca> <20200319071633.GA32522@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200319071633.GA32522@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 19 Mar 2020 18:52:15 +0000
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
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 19, 2020 at 08:16:33AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 18, 2020 at 09:28:49PM -0300, Jason Gunthorpe wrote:
> > > Changes since v1:
> > >  - split out the pgmap->owner addition into a separate patch
> > >  - check pgmap->owner is set for device private mappings
> > >  - rename the dev_private_owner field in struct migrate_vma to src_owner
> > >  - refuse to migrate private pages if src_owner is not set
> > >  - keep the non-fault device private handling in hmm_range_fault
> > 
> > I'm happy enough to take this, did you have plans for a v3?
> 
> I think the only open question is if merging 3 and 4 might make sense.
> It's up to you if you want it resent that way or not.

Okay, I kept it as is and elaborated the commit messages a bit based
on the discussion

It doesn't seem like the changes outside hmm are significant enough to
need more acks

Thanks,
Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
