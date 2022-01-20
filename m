Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10B4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 06:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D8810E34A;
	Thu, 20 Jan 2022 06:13:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73D710E379
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 06:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642659214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsYigPxSNmav9QG9Va6TxR69+mrsv3kMIwPo8ck4XbE=;
 b=CgL/VhqoSrXz34w+7BeQSIeZ02roaR6m9Gir34ICsvcmj3ooX0EMRIBpXIiBxUzrgxfi83
 QzRdYEEm4vyo2Hkd7lM0yJa6UHesb3MlynAEnBjbXsdea6yTyIdINqJlpMinsr0CGxje1Z
 5xbIIeA+NMfm6S2zUaIfHnI+zJ8E1RA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-SpuSPcJqOM-Z2DzSbIMlIw-1; Thu, 20 Jan 2022 01:13:31 -0500
X-MC-Unique: SpuSPcJqOM-Z2DzSbIMlIw-1
Received: by mail-qt1-f198.google.com with SMTP id
 ay13-20020a05622a228d00b002c668f5c811so3033701qtb.15
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=hsYigPxSNmav9QG9Va6TxR69+mrsv3kMIwPo8ck4XbE=;
 b=zbAHbWQ8gN5MnS4emlm10L/kJnuDDzTmiBsln1ffueHHXVcZpRWo6BkHU0VSn2UTFX
 O6thhf/saR6jKAg+9s80QSEr8FEB1fZZLu0+v4cVCVzgSOqNHoonSYtel5Yu5u1RcsU2
 trJJa20t3fSXH0tPo18rM33FjugXdLxs3wftSGZtSogCvHyxEqA8HjwvbmSvThF1vPKf
 t3sshj+YHDhnBO1PpvRG4YDSTsqbko5C9adPP+DI9emdDg7pPR8LJwYR5PCQDcR6XJVm
 lcwqwkseYwkm6079VqQL1nv5fKKxKBXmffOQm+ZEAkHaXCM3s+9fLQld0GzSX581q0ba
 DcIA==
X-Gm-Message-State: AOAM530O7w62YawRL9+GQG2aJcTZ+thQpOrPpjAmrV3HPrbbwu/TYIDT
 jDKb+/pD/QfqkUhRosr7QiUfiWxfUx3WinSNIxjDS/VSh75vGlDvZ0VkThA4S13IILKMyf3llwJ
 XOeJhgqk/PAlwb6amPwD49End4qHHq/0l/bEeX5NybxLKD6PEx9UA3QQM3EDivKCjlw5cdB3pDg
 ==
X-Received: by 2002:a05:622a:4c:: with SMTP id
 y12mr27865281qtw.335.1642659210560; 
 Wed, 19 Jan 2022 22:13:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdxqTkVDkDn6baQ/CklmrGhqh8xjo7oY2Yip6teSrLLN3keAO+JzUCk0W9UECmWQMMI2ODlQ==
X-Received: by 2002:a05:622a:4c:: with SMTP id
 y12mr27865272qtw.335.1642659210209; 
 Wed, 19 Jan 2022 22:13:30 -0800 (PST)
Received: from [192.168.8.138] (pool-98-118-105-43.bstnma.ftas.verizon.net.
 [98.118.105.43])
 by smtp.gmail.com with ESMTPSA id j8sm992632qta.26.2022.01.19.22.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 22:13:29 -0800 (PST)
Message-ID: <967026f3672e48207dede86b67a5866838a36a43.camel@redhat.com>
Subject: Re: [RFC] amdgpu MST questions, and future plans
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Date: Thu, 20 Jan 2022 01:13:28 -0500
In-Reply-To: <15588b86c92b18144be1574826f38f90e9b752ba.camel@redhat.com>
References: <15588b86c92b18144be1574826f38f90e9b752ba.camel@redhat.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2022-01-19 at 17:56 -0500, Lyude Paul wrote:
> Hi! I'm writing this email because I'm currently finishing up removing
> pretty
> much all of the non-atomic MST code in drm_dp_mst_topology_mgr.c as it's
> really made it difficult to maintain MST over time. As well, once that's
> complete it's likely I'm going to start on the (extremely overdue) task of
> moving as much of amdgpu's MST code for DSC out of amdgpu and into the DRM
> code where it's supposed to live.
> 
> This brings me to two questions. The first major one being: is anyone
> capable
> of testing the MST support in radeon.ko to figure out whether it works or
> not?
> I've already talked with hwentlan and ag5df about this and they haven't been
> able to find anyone to help with testing this. The reason I ask is because
> radeon isn't an atomic driver, and is basically the only user of any of the
> non-atomic parts of the MST helpers. If anyone want to prevent this from
> breaking in the future, I would definitely recommend they step up to try and
> help with testing it - otherwise I'm probably going to be pushing for us
> just
> to drop the code entirely.
> 
> The second question is: is anyone willing to help me figure out how much of
> the code in amdgpu related to DSC is definitely not amdgpu specific and can
> be
> moved out? I'm honestly having a lot of trouble wrapping my head around how
> some of this works, and how much of this code is even needed. As well, with
> the amount of issues I've already found in it (there's numerous spots where
> we're storing MST state outside of atomic state for instance, lots of
> duplicates of DP helper functions that should not be here, etc.) it's quite
> likely I'm going to be rewriting rather large chunks of it. If anyone would

mhhh - on second thought I think I'm starting to wrap my head around this and
it's not actually too bad :), still could use some help with the radeon
testing though!

> like to volunteer please let me know, it'd be super appreciated and likely
> will make reviewing the patches that will come out of this easier.

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

