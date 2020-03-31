Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A353C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E9D20848
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAOCWSpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E9D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21D66E836;
	Tue, 31 Mar 2020 14:05:00 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993E96E58E
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 07:39:42 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id y71so18112966oia.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mAUnvEZguD6CfDl4gHndNC/T8IwUXTZiBxjH+at4TTc=;
 b=BAOCWSpovHS0fIzkHaAGLyJ47omoO1No0w6POuhEJhxM3BQxFtCIbzRCWf0zPfRKRj
 6OfEIHVk/j/rjUqoxjuMMF52nXczqJ10r9iCobz3HDYqDefLXsR0OmFWRzwCSJ92irbY
 wgfj+acI9+lHCdVUNqwdpXeAUGiRBMHhzj2UQzE8JNtJ0zXrUJfAailu6TWp0wVENI62
 4wKj0ufFmyVbBDCHUuOkoFg5ldXn9aCiJmKw/oYb1eX8X+1itIRLQ4F0BdeQxwI0zyDD
 g3hzQ1XGclY9h+WnU1WHf5w3/COjdbxDJ5A3J/bdu+sVRswlryTgdni4TcbkplX+tEop
 RGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mAUnvEZguD6CfDl4gHndNC/T8IwUXTZiBxjH+at4TTc=;
 b=uS4k5eZ2YkOboWn3IH8aD3V8V8GmQ8QlZF68hdiZPzLll4c48kdkxWb4AQFKf14Nni
 cHmKJFWs5shsEqU7u3dYgIBdqEuTri4gobJeIBcFHM+QBG2lXf239/PGs/X5dF7SQ5Cf
 UqoXlLC4I4BEccjnZbjrxg+zY9Z8sQ8TBJ4/Xf8sxfjUunNdXmC2e7FGw66Lyoe5Kxvx
 Zo/OvmHVCGDo3zbHbNA8J1iDiNuluR0svdAffWwscaIbw1uLKq9aEPQ7Ed6fkmk4UmbC
 +Z3dyNejZCp6WW8LgzYLm+AbqAuy1CgIT16AyDayaQ39GRiHnuGbRf9A2BePtX/v3M1f
 aW1Q==
X-Gm-Message-State: ANhLgQ2le+nJrAumuzEADDvvWQUjbl3seBiOQ6xet4R92W7kes8CdmVv
 ibS9dYqnP0+jxYFd0UkA5bE=
X-Google-Smtp-Source: ADFU+vtnEAPociO8YfQmbNs0FQoZh40NVXPYe+BT18z9nE1Y7XHAgXGynisBg3O1sZtZwTgULToJvQ==
X-Received: by 2002:aca:c3c1:: with SMTP id t184mr1222939oif.113.1585640381659; 
 Tue, 31 Mar 2020 00:39:41 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id g39sm5084010otb.26.2020.03.31.00.39.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 31 Mar 2020 00:39:40 -0700 (PDT)
Date: Tue, 31 Mar 2020 00:39:38 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: mmotm 2020-03-30-18-46 uploaded (freesync)
Message-ID: <20200331073938.GA54733@ubuntu-m2-xlarge-x86>
References: <20200331014748.ajL0G62jF%akpm@linux-foundation.org>
 <a266d6a4-6d48-aadc-afd7-af0eb7c2d9db@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a266d6a4-6d48-aadc-afd7-af0eb7c2d9db@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Tue, 31 Mar 2020 14:04:59 +0000
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
Cc: sfr@canb.auug.org.au, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 mhocko@suse.cz, linux-mm@kvack.org, broonie@kernel.org,
 linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 30, 2020 at 11:18:26PM -0700, Randy Dunlap wrote:
> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> 
> on i386:
> 
> ld: drivers/gpu/drm/amd/display/modules/freesync/freesync.o: in function `mod_freesync_build_vrr_params':
> freesync.c:(.text+0x790): undefined reference to `__udivdi3'
> 
> 
> Full randconfig file is attached.
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Hi Randy,

I am guessing this should fix it since I ran into this on arm
allyesconfig:

https://lore.kernel.org/lkml/20200330221614.7661-1-natechancellor@gmail.com/

FWIW, not an mmotm issue since the patch comes from the AMD tree.

Cheers,
Nathan
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
