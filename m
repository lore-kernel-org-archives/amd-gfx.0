Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9091CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 11:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0881610EA17;
	Thu, 23 Jun 2022 11:16:12 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5F310EA17
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 11:16:10 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id c205so12074498pfc.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Eimu2r0+Putpb0Qf0slNyoDa6KslIz2JFxHLLNZKDkk=;
 b=FtQlk3bjUaOBSKtosQz1mzseIQUSbK8ApHoKshZJ9O5uYiG3SuvSkJBgQasxvGFXra
 n9/IsZYgKtXaKEDEBz2cpPOMtmuO459E9G296oacM/wZiKe1D0pkJOT47nixL5IuEyY4
 yK2dlVdFBcPgh3ZCcv+OKY/o7DQ/JFMDzfViAcpU0aTlRMtuQnrnI/8mwd9+oVHS6nx+
 5ChaGdMSvPFdCpdrPdypfB/tcrr7YfWFS+14rii9w01+f6GeOwPMosbHFYLwZNCQCbQm
 W1MMAh3ZyxMq0RhL4+CNEyiu7PqD5a+BNc4/bnLXC42AJF69Pp5RnaLzWHrb3EKgz7KE
 oW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Eimu2r0+Putpb0Qf0slNyoDa6KslIz2JFxHLLNZKDkk=;
 b=iSNLmrm9ay0UmUoy8E7D32KjtN4F7g1oqf1v/3WZYCuoKLVMnts22lqpFNL9xRYZ77
 JWkTs4vNQLm0qDk6puGP5S7s90pY5PbUoDd38dIRRjJFbuWar+y0cASk/wWQuSZR+4eo
 4DyBG9ar4wO2Coy2a9fJad5sEKDLnXCR2un1tVAdA/4QwScnZdTSVj6Xm9h8Dd5frIs1
 tJXEUAMJLwDbONNYplQnHewx1hUerX32Lm8DlXWq/4nRDVtDmhouzimYf+BelxZR6tLq
 zugiuG+/r04BhtEd8Cnxqth6RTc7TJdSXSXxH4J121ymhd+aoda90Sn0whqaSZYD0HPc
 /paw==
X-Gm-Message-State: AJIora8z5dInTG2eNvDUfrZAo9QVNKJQ0OoIOG+RtFEvF+3GNZem3mdd
 oi5x5CF9g+U3Z2jRkNJVVQofQEmRFCtHT3Yc09NjvA==
X-Google-Smtp-Source: AGRyM1s7DqocWg0I8e4JgZw9XsKNBQGKACJNoE3kY5IZKvQ1e1xYIs+AMtz6aT8Gnqu64ArdLX/Xv0sD4yiTI+4A6mg=
X-Received: by 2002:a05:6a00:1481:b0:51c:4e9a:f618 with SMTP id
 v1-20020a056a00148100b0051c4e9af618mr41145833pfu.43.1655982970407; Thu, 23
 Jun 2022 04:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220407054651.3924-1-Arunpravin.PaneerSelvam@amd.com>
 <CAHbf0-H5uE4RtZwY0L8Wz0VG6QnU1+E3yhg3fDFVc3n__=nrNQ@mail.gmail.com>
 <c0facbf4-0e14-fde5-4334-499135a36f0c@amd.com>
 <CAHbf0-FMqAA3vWx_uRDYG_vr=FX+tFoLAL6BZLDe5upv7KJqrg@mail.gmail.com>
 <CAHbf0-En606VT_HYDyeo6TtsfSZmR_+wsZaVgS4XiedLO9ndiA@mail.gmail.com>
 <8b99ca20-f711-ec32-0cd2-16fc52846ce0@amd.com>
 <CAHbf0-EzPP5gAyZQmxeAo3Ep0g-rO4XbDgEB_SdsR84xY+at9A@mail.gmail.com>
 <CAHbf0-G-rnvNXaXxMzkPerW6h=9vkxJyysUUV-oJV5UGD67KqA@mail.gmail.com>
 <CADnq5_PTRPTsCvGwKFzNA_k7diAVqYEv1xV1yJszRD1K-v2FfQ@mail.gmail.com>
 <MN2PR12MB43425B6EC07A7F6877B884C7E4DB9@MN2PR12MB4342.namprd12.prod.outlook.com>
 <CAHbf0-G8Qgv-uKHBYxhv=SLUv7-z4gzjMziN_x+oAobTrqW0PQ@mail.gmail.com>
In-Reply-To: <CAHbf0-G8Qgv-uKHBYxhv=SLUv7-z4gzjMziN_x+oAobTrqW0PQ@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 23 Jun 2022 12:15:59 +0100
Message-ID: <CAHbf0-F36EonCAUVeWnhoiXD95_7=8fnbNo0wGWD-L74L-cT-Q@mail.gmail.com>
Subject: Re: [PATCH v12] drm/amdgpu: add drm buddy support to amdgpu
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
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
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, Matthew Auld <matthew.auld@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

The buddy allocator is still causing me issues in 5.19-rc3
(https://gitlab.freedesktop.org/drm/amd/-/issues/2059)

I'm no longer seeing null pointers though, so I think the bulk move
fix did it's bit

Let me know if there's anything I can help with, now there aren't
freezes I can offer remote access to debug if it'll help

Cheers

Mike
