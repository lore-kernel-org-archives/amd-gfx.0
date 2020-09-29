Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B812C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 20:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B532076B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 20:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUyQOz3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B532076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606F589CB2;
	Tue, 29 Sep 2020 20:15:42 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497AC89CB2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 20:15:41 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id k10so6857133wru.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0VDHNjBFR7zg2AbXsZ9J+4CBkdu6xcM2e1hEJZmk8ek=;
 b=FUyQOz3rntLe3XPpFgu32iGST8nMuXHULM6ug7e8BugHju2pkgJyqIncsUEtOGKc67
 4WqIqsMMrZDrWNr/kj7YLEmrH5RUojhX5tash8/Z56CCU0WshzoqbxCyjdL9llP4z2TP
 3icQ1wx/BOEqu0jiIqRUAgMrgSLboN3q7l3yjBSrbKxlbY9V+CMCYpxRisJGpDU4mlay
 atqmCsGaS1u/bE8vF8PK055jS0NxtkucV0tp7metEhL0dYjs/cRl+h1wBa/sat0V5ReP
 vF5e2n65tUoxeopWIodNqRdfK9njL7pIDXy9UloUwgb7ljvtBdhPWGNUebAiF5srTTks
 aTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0VDHNjBFR7zg2AbXsZ9J+4CBkdu6xcM2e1hEJZmk8ek=;
 b=NvCRzMCf8g9nmeofI5bCzegfeFshgTKjbMJCY0YdQQ5tXEHVHcWYGPBtuJRM1dFjVc
 BydQmi9umel+fAmBXal9zSqi3Y6jPVmlyQeXK7YipEx/QYhJrKsEkNBBIdpORQR+QgFJ
 fbeGj1hG0GZ1XqIGu/JdOKVKYcsMREe6CRuxi4rfahWjcuGBB/76aQsSLGGbURnXvEFu
 hK2JfVnnMhGsR072d4wi31g85p1YHFLRWo7KYuvHOV5rjlWrvvO/4zHZCPzdmLRh7rX5
 omfLi5tczi400ITbmESFzsHsBx8xFS4kc80iP7QWLR5NWUtnwPURUMUDzUB48t/ope2t
 VZgA==
X-Gm-Message-State: AOAM533r9h+tYEbjaPRdvDMS6X4TYEwwJGHa5GziYkhvb6hjr74UeW0F
 x/a4V6oKIwhU0UJw1z4KUi+LzYpx2aB9vsDjlGP73LSc
X-Google-Smtp-Source: ABdhPJzvgHD1Wo57PQSkv998My8VfnbN5IDLyg5sHBaMtJ3JMIl+9WvAelI+F0mMzC2IZr/O5ED7n4pn3US0Ujx0le8=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr6545630wrl.419.1601410539913; 
 Tue, 29 Sep 2020 13:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-5-alexander.deucher@amd.com>
 <56f74006-5a7a-c4a6-26e1-1a51cc0be1e9@amd.com>
 <CADnq5_P7P5zTLueV0GwVifo8WXctTCPzYh7CcpmjDet3kM1Vng@mail.gmail.com>
 <26b8665f-1aa9-21ca-b5b6-2aa395affd9b@amd.com>
In-Reply-To: <26b8665f-1aa9-21ca-b5b6-2aa395affd9b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 16:15:28 -0400
Message-ID: <CADnq5_MEc47pMatwL7bO5bN0ZUrWjpbaY9KyoSjC4SSXg43Ouw@mail.gmail.com>
Subject: Re: [PATCH 05/45] drm/amdgpu: add vangogh_reg_base_init function for
 van gogh
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 29, 2020 at 2:59 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-09-29 10:57 a.m., Alex Deucher wrote:
> >>> +#ifndef __VANGOGH_IP_OFFSET_H__
> >>> +#define __VANGOGH_IP_OFFSET_H__
> >>> +
> >>> +#define MAX_INSTANCE                                        8
> >>> +#define MAX_SEGMENT                                         6
> >> No. No "max". Use "num" instead, as:
> >>
> >> #define NUM_INSTANCE   8
> >> #define NUM_SEGMENT    6
> >>
> >> To mean, the _number_ of instances and the _number_ of
> >> segments. (Their count is a number.)
> >>
> >> A "maximum" (similarly "minimum") value is an _attainable_ value,
> >> i.e. something you can get, use, etc. But array indices are 0 to arraysize-1,
> >> and thus max instance can never be attained.
> >>
> >> It is the count, the number of instances (segments, wlg),
> >> not the maximum instance. The maximum instance is 7,
> >> the minimum instance is 0. Similarly for segments.
> > Valid point, but this file is shared across components so I'd like to
> > minimize the differences.
> >
>
> Is it possible to educate the organization?
>
> Is it possible for knowledge to flow backwards,
> i.e. from the Linux team back in?
>
> As a mathematician, this really, really bothers me.
>
> It leaves traces of badly named objects and new people reading
> it would pick this bad naming up, and experienced people would
> either be confused or find it incorrect.
>
> Let's fix this at the source.

We can take it up with the internal teams that generate these files.

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
