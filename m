Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F0DC5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 11:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1334210E308;
	Tue,  3 Jun 2025 11:35:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y4T0hNdP";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D3710E2B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 11:34:57 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-ad8a6c202ffso1063702966b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 04:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1748950496; x=1749555296; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PFuIusTcNlDtr7ACZcv5YKK7AZMWko4TWKZs3oesbaA=;
 b=Y4T0hNdPLh+yFPxc06PfESFWdLYHQ9f3CbyE2zsyYdex7eJy/4ggbHl22a4lhaDh97
 J8jIOtHX0yukbmowf52TycNtpldr66OFXOF1RKDvZ5gprSDF1PNpVqMo+R4JRyNIxnrH
 fZ0+sPnfAeqNNJyIlm8wRoH6vKkYEx0thZ9Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748950496; x=1749555296;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PFuIusTcNlDtr7ACZcv5YKK7AZMWko4TWKZs3oesbaA=;
 b=JBZ5n75vqg5Hg1RV9NcNi+kWxkKJVg5mZltxSaWGnIpjZPjOlPmjBl2FpX7FSGHBRf
 sV5Pio1IYTPpUDlrxTmisQpeYxMnt1sHJhEH3efv0COBnWTTSczdinkPztqXW530sXZa
 i3Xw9d2DOKxGiBQ0+6Oq7+2NIYE3bvXrtCeJ1c2jWmQpAA4uOtplso1q4LgZr8h15z+H
 N9m6WZk9+/gatC1va5/2S8pNbq0ldU3X9p7ms6/0lnJLYMQJWE100hi0PlHu7jXqyc9S
 Uo3maWxzp6+PK+a+c/aqc5mugHvucyCq+XOHyFvlm/L1tOKsPlRh8gutCjWqkFU6t3AS
 qoQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqWsXtmjBcuOiX3CjjqtncP40GwRjaGLsiO79pgUok1m4OPCiNtHiIOTJA8AzIDJFro+K9k8mc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCufTzF0EnS02x67sr8IL9+9dUWS9/BrGJNNXEfF0yz+yygoIB
 n2g+D0cdlX+VYWR9ItDhyIHWt2OwJ/Y72XrGxIg1JZikWwdSxJymxvKitcNuueNUKqc=
X-Gm-Gg: ASbGncu+3BaXDm+UUwpLn9ZeVdziC1kZFs4l6jPCXWFhF1he6Fh93Sg2zkVHb13kRHJ
 DPptox6AWUdmaok92S3mfFYOkPRIrGe1vTiIzxF+GSo44KHYuMUkXnEjbreYGgNbCX5XdCKNbB1
 4eC6jXcr/iuYxp7s1l63SuPd11IdwAb8SiTY0Unky/BJkfpHi+TlC0niPGGwIFnf+3WWKRuY6uE
 Tsxf4XYZMLcamsYfu02YJSOUNVI3N2WknNfsBQz/pkXVPtMg9+8rRr6hcLhYoG7Ca/7c7SFARbH
 +QriXhD5WrWAFFodYi19Dg/6A76alH2kz9MKKZi4BsEQrgSC0L+Yi8rky3Oxxw/c2kZPBgzRCw=
 =
X-Google-Smtp-Source: AGHT+IHPWtzNUL2u4/jUFXfcGlOj2qM2hFzF0WBNUy3wZrggtO4Ww38E9t7xnP6lMA5OPdTNoCN+zg==
X-Received: by 2002:a17:907:728d:b0:ad9:16c8:9fee with SMTP id
 a640c23a62f3a-adb493a9b11mr1291087966b.3.1748950495484; 
 Tue, 03 Jun 2025 04:34:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6ac07sm947772366b.177.2025.06.03.04.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:34:54 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:34:53 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, phasta@kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 tursulin@ursulin.net, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/4] drm/sched: optimize drm_sched_job_add_dependency
Message-ID: <aD7d3ewxzKAPSWjr@phenom.ffwll.local>
References: <aDCCF0JFhO7lR2VJ@cassiopeiae> <aDCDJ-sK9rRI6wse@cassiopeiae>
 <cd64af4d-f5b3-4f18-9be6-636624833075@amd.com>
 <08bb986281fefb5cbdb35c63a56e1bbd923d9297.camel@mailbox.org>
 <74c4b9d8-5e25-438e-97c5-5aa2035fb9bd@amd.com>
 <cbd3eaa4c228c0d0688745e8a539103eb2278a0b.camel@mailbox.org>
 <aDcB0AbQiHOVUyAU@phenom.ffwll.local>
 <CADnq5_NiMOhc95h-GLRjAD7LXyQ=9nb=Uvim1rwX4n9tekLkyA@mail.gmail.com>
 <aDcgAG0R-NxT0PaC@pollux> <aDch5McYYa3AVtTV@pollux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDch5McYYa3AVtTV@pollux>
X-Operating-System: Linux phenom 6.12.25-amd64 
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

On Wed, May 28, 2025 at 04:47:00PM +0200, Danilo Krummrich wrote:
> On Wed, May 28, 2025 at 04:39:01PM +0200, Danilo Krummrich wrote:
> > On Wed, May 28, 2025 at 09:29:30AM -0400, Alex Deucher wrote:
> > > On Wed, May 28, 2025 at 8:45 AM Simona Vetter <simona.vetter@ffwll.ch> wrote:
> > > > I do occasionally find it useful as a record of different approaches
> > > > considered, which sometimes people fail to adequately cover in their
> > > > commit messages. Also useful indicator of how cursed a patch is :-)
> > > >
> > > > But as long as anything relevant does end up in the commit message and
> > > > people don't just delete stuff I don't care how it's done at all. It's
> > > > just that the cost of deleting something that should have been there can
> > > > be really nasty sometimes, and storage is cheap.
> > > 
> > > I like them for the same reasons.  Also, even with links, sometimes
> > > there are forks of the conversation that get missed that a changelog
> > > provides some insight into.  I find it useful in my own development as
> > > I can note what I've changed in a patch and can retain that in the
> > > commit rather than as something I need to track separately and then
> > > add to the patches when I send them out.
> > 
> > Personally, I don't think it's super useful in the commit message, it still
> > remains in the patches sent to the mailing list though. And since we put lore
> > links everywhere, it's easily accessible, *including* the context of why a
> > change was made from one version to another, i.e. the full conversation.
> > 
> > However, if we really want that, we should make it an offical thing, since
> > currently the kernel's process documentation [1] clearly states otherwise:
> > 
> > "Please put this information after the '---' line which separates the changelog
> > from the rest of the patch. The version information is not part of the changelog
> > which gets committed to the git tree. It is additional information for the
> > reviewers. If it's placed above the commit tags, it needs manual interaction to
> > remove it."
> > 
> > Alternatively, it can go into the cover letter.
> 
> One additional note:
> 
> This is not me trying to be super bureaucratic; instead I think being consistent
> in the process across the whole kernel results in a better experience for (new)
> contributors.

Yeah I agree with this part, which is why in the past I didn't ask people
to keep that part, but also won't complain if it's kept. The entire goal
being "minimal amount to get to a commit message that's hopefully
complete". I think with b4 this has now also become a bit easier than 10+
years ago.

Also all the kernel fd.o lists are on lore and the archive on fd.o is
under our control, so hopefully the archive situation shouldn't ever be an
issue for us.

Anyway no strong opinion from me, but we might want to document that we're
a bit more relaxed here.

*shrugs*

Cheers, Sima

> 
> > [1] https://docs.kernel.org/process/submitting-patches.html#commentary

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
