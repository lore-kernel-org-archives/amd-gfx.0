Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AE0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 12:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1E46F911;
	Thu,  2 Dec 2021 12:43:54 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E43A6F904
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 12:43:53 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id gu12so24766311qvb.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Dec 2021 04:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jD5nqiL1rdv/g0FZXs9pCK58VRq43YEGFrgNNwHXOko=;
 b=kVmPIK5+UzDl1K+mOGtAsXKgzKiHdQPUIAthzhgAj+PYbnpF9SLZpY39z6jlBc4PYz
 E3Cu5Pyv9TBHbriOv/IIGV+zitOJdkp6351wVpAGosGeUlJu8j1T3q19MCMAfC0hP8Bv
 KF7+Ff/gRbAJG5J8wrZ+Uu0T5NYb7c5JyhQ2sTAx0zzVMSgiM5Nxt2Ii3cCCoyFNo61v
 za1EcOUjqubDMTHJR7NrqZ3DWgGtlDVyZGWd/fvcsfOGmrjNdMRFsW1mjsbIO+j0Nmvj
 L0Zp2CUtyw4OlCT8eFGpT+BGTYEUtz0wV0qpdQSdAxEsufglpxx3QUDVksm7XNKXptwj
 +pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jD5nqiL1rdv/g0FZXs9pCK58VRq43YEGFrgNNwHXOko=;
 b=IXo1r2eQLNWACVD9GBUrzV0KJPOJDMs6ESIbaaZuoUlgzhmj0rTzeRS0aVrX+hp62w
 DyuJJ4STdiFQD/kXZW7TPoAyMwkr3soY0s+13Dm7BU3pEAt1PjHT5O3YHFTlL9aP76RN
 +6xB54AJvUmpRAlxpfguq4+KAMXQmL0q9yRqp+mdtO48LhUpn7ndD0pIagqiPFuMyKCJ
 1SO+3ThWc4yPtzhyCwOF2v4fjtEsYu+mwUdrmfBigBd8+M61IlIwqQj/cCsos0xtMU3I
 hKE9XBdVF0i09x/I9ye7tOjhjUBUHBMh5BGs0s6JOMI4Dpkbil1p/eDPJ2aXEWgKpfBC
 gOSA==
X-Gm-Message-State: AOAM531oFNYQtSM/khRW+ZOo4mAR56tKZcMYBtPAgujYG+UZoJ2nfybA
 UGml0ha/imlNspXQRepcuazyR3Rc7ZBUIGQolGot4A==
X-Google-Smtp-Source: ABdhPJwI2fHOQMXqTTMcck5s/M7DQ5/mriKHFcsNVmNq7En8S3b8A1YrjMFwigwGQxgYMRvYoXK0F+Xdv8qNmUMfwjM=
X-Received: by 2002:a05:6214:300b:: with SMTP id
 ke11mr12142631qvb.42.1638449032407; 
 Thu, 02 Dec 2021 04:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20211125203003.18038-1-Philip.Yang@amd.com>
 <d5862808-c97e-a1c2-4429-7d0216425fdf@amd.com>
In-Reply-To: <d5862808-c97e-a1c2-4429-7d0216425fdf@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 2 Dec 2021 12:43:41 +0000
Message-ID: <CAHbf0-Eyn9O_hzXa4qfQcQqmme9=nadEnhrWW7fKHAorw3Dr_A@mail.gmail.com>
Subject: Re: [PATCH v8] drm/amdgpu: handle IH ring1 overflow
To: Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Philip Yang <philip.yang@amd.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 25 Nov 2021 at 20:42, Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> OK. Dealing with processed timestamp rather than decoded timestamp fixes
> the race condition where drain would have returned before the last fault
> was processed. But we're still assuming that each interrupt has a unique
> timestamp. We haven't seen evidence of the contrary. But I'd like to add
> a check to be sure, in case that assumption becomes invalid on future
> hardware. Something like this (before updating ih->processed_timestamp):
>
>     WARN_ONCE(ih->processed_timestamp == entry.timestamp, "IH timestamps
> are not unique");
>
> With that fixed, the patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>

Hi,

I'm seeing this on my machine
https://gitlab.freedesktop.org/drm/amd/-/issues/1818

Cheers

Mike
