Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0F1C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 18:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D4A61026
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 18:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D4A61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D01976E332;
	Thu,  8 Apr 2021 18:51:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6046E311
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617907906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BD/3IJ//4IbIiQsBvvArASrfK6cu+iAAJOBJpUvbC/A=;
 b=DWxm99yvMg88z4vNMmAGSjpJTcxX4/vqK2NBFBIiwz0bPtjvLKdskHKDfAcST8qUNLvcM0
 mQM/NZG0e7BUtB9c0c27OLn6GTlaKNztKhxp8faNtibH9lEjnidHiOJ+N6o5X6/NUxRtd8
 1Qv6nynZedB61kgDdwj7t5Ti0kf+wLI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-AnlgDL8NO9a16aFI70SF_g-1; Thu, 08 Apr 2021 14:51:44 -0400
X-MC-Unique: AnlgDL8NO9a16aFI70SF_g-1
Received: by mail-qk1-f200.google.com with SMTP id t24so1893541qkg.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Apr 2021 11:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
 :in-reply-to:references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=BD/3IJ//4IbIiQsBvvArASrfK6cu+iAAJOBJpUvbC/A=;
 b=kkJxWsJ0y4AWXu3oEl9TCVTwyfQjOU+H767c6sParXQkWYfvMxJiOFfFglgZWLwsuC
 HZ3dJbOxmw6lfpyyXVTdi+k9FEA/cZNgfn08AI0jnaeRmLnOOkVJgImj/gBi4qG3bkut
 zBh8zp+2uKtc4QDB8hydLb9Z+Wi/C8+ZI1ta+72sgK3H2Mr8mOvPLmKooHPwV75m5cW9
 E3qPUjC01ASrqq8O5Q0t9GOuM1Gc7arjybA5AZ9CmaCFs8U7ToAOe2YWAnnAf+G0sNkZ
 zMlBChYIdMmkgf8MOsI85yujOpmA8LHaJUNkBS6zSYqffuLJEQ5keREnNIJA3kHKNHz/
 +j1g==
X-Gm-Message-State: AOAM533Q4PL1dWGytcWt9SKNHuifzq6DKt6NhAZA5Keq7PttH91dLfBR
 RRZHCDgHf7TRPldvARA08Px9LW6IDvvRSy0ckaanYONYsvgUNWQMdjcZxEdLLPeR8eNe1lsC+JM
 /D+It0eNL9sqaLy13T9QWSMuJ9g==
X-Received: by 2002:a05:6214:204:: with SMTP id
 i4mr10502071qvt.47.1617907904544; 
 Thu, 08 Apr 2021 11:51:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrMnVVlxnhuJ6a9rN/xNvll03hc+4P139kmw6bFat7NGytQIf28KfBPqtGSmUXky694Mxo+A==
X-Received: by 2002:a05:6214:204:: with SMTP id
 i4mr10502051qvt.47.1617907904388; 
 Thu, 08 Apr 2021 11:51:44 -0700 (PDT)
Received: from Whitewolf.lyude.net
 (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id y9sm235018qtf.58.2021.04.08.11.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 11:51:43 -0700 (PDT)
Message-ID: <893131fcec2cd4d85d840439ddc2f2899f412f1c.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH v2 00/20] drm: Use new DRM printk funcs
 (like drm_dbg_*()) in DP helpers
From: Lyude Paul <lyude@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 08 Apr 2021 14:51:43 -0400
In-Reply-To: <87zgy9hvvv.fsf@intel.com>
References: <20210326203807.105754-1-lyude@redhat.com>
 <87blaym8by.fsf@intel.com> <YG7fz5UmK/SaoY/U@phenom.ffwll.local>
 <87zgy9hvvv.fsf@intel.com>
Organization: Red Hat
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Reply-To: lyude@redhat.com
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

JFYI too - there was a legitimate looking CI failure on intel with this series,
so don't be surprised if I have to respin a patch or two (I should be able to
get it asap as I finally just cleared most of the stuff on my plate off for a
while)

On Thu, 2021-04-08 at 14:13 +0300, Jani Nikula wrote:
> On Thu, 08 Apr 2021, Daniel Vetter <daniel@ffwll.ch> wrote:
> > I think Dave caught up on pulls to drm-next, so after a backmerge of that
> > to drm-misc-next I think should be all fine to apply directly, no need for
> > topic branch.
> 
> Yup. We've done the backmerges to drm-intel-next and drm-intel-gt-next,
> and are all in sync, it's only the drm-next -> drm-misc-next backmerge
> that's still needed.
> 
> BR,
> Jani.
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
