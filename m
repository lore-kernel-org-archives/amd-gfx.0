Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6271FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 12:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0255110E0FE;
	Fri, 21 Oct 2022 12:36:27 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EEE10E0FE;
 Fri, 21 Oct 2022 12:36:22 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id h12so2379291pjk.0;
 Fri, 21 Oct 2022 05:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y/vcAMtKCVTrh+E/N/2LlgUlrNzauVl3aZ392iU3cU=;
 b=Qbx4MGJiXE25WxekTP+L8fcKpnb7ojaiGvhvo3d6vwji70BKe+eSk5Xy4ztsbEqltX
 JgFv9eOcepuc/9kqg+OMrrzN6GJi6fOMBVHc15DbxP0Ki+5+imQFlNiR7MChQJT+DHLq
 g3VdB2hDAqIMIx1Nv/hPxNvbWZw2mcwkEpX3uaK7kh7Tqa2RytcaKWIQMKaKaj2iRm7e
 lXKGNqWJE2FLTPXTTXenj/Rfhln9ZkivTorvGAgo9/H0GxqNBp/ydevjIwjnbCnYQ7K4
 MhyUXQTtBIrtlv4Mp994DvJ2wwsN+9/K1dtuunw2YDWB70q8sYUq4gHpAOgRUoGcRgju
 famA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y/vcAMtKCVTrh+E/N/2LlgUlrNzauVl3aZ392iU3cU=;
 b=pfBpOGlZ2sVDMC5JI6VRgJR7qPPqqQy4fZxL2z08LonsvEXTHS+UusaArZnQIbbdV3
 7hyLPIWCiMHj+pl+v3P8azH8Oq+zfN3mnbykJYGEtc0y4WyNXjFkYLQwh8aN2MCZspok
 sejy9KJmbSh81pRYem1VU9KccTrZHuEhvs2gk0n/ddNe15qiLKiNDyfOXBPECLpeO4nH
 o1nUIMBqPYY6ldsYHar24zyXV+uv6enFK/71MoWmIqQ/cvhhzoqfwZKnDMdHZL2AA4bW
 JDo6lvSmhbBBeeRtK+Tg1ddt5U7sYleDawa8yEkaNq7MvWDJcawgqCcFTkAGwfY+T9Al
 yTRA==
X-Gm-Message-State: ACrzQf3pytx+LM5hb136EanpA+tOsYx8sMjzYOU/32D4TeMnW5z3a9WY
 qkkC+8w7KUFEGSzPp5LkKRbMc1t01V1Hqd2jmvFEQJPNZWjf4mHt
X-Google-Smtp-Source: AMsMyM4PFfgcQnS/E9WHft1H10vtbxT+IX20E8TXQbHHzIHseDMNJJbDOkWxD3q+UVA89SBbO1sNpalqZc/gmECW2m8=
X-Received: by 2002:a17:902:8549:b0:178:6399:3e0f with SMTP id
 d9-20020a170902854900b0017863993e0fmr19363524plo.35.1666355781420; Fri, 21
 Oct 2022 05:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOeQ7VYm98jRVaYp6KaNsFVsAnSb33ZT8JvZxcTcEGW0w@mail.gmail.com>
 <a67598e8-c826-2740-03bb-33d37c8c8e4b@amd.com>
In-Reply-To: <a67598e8-c826-2740-03bb-33d37c8c8e4b@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 21 Oct 2022 17:36:09 +0500
Message-ID: <CABXGCsNvFvJz4=N=JKYSGVcd=dKfQ3Nv_zOssMb0Z6oK79xZ7g@mail.gmail.com>
Subject: Re: [6.1][regression] after commit
 dd80d9c8eecac8c516da5b240d01a35660ba6cb6
 some games (Cyberpunk 2077, Forza Horizon 4/5) hang at start
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 21, 2022 at 1:33 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi,
>
> yes Bas already reported this issue, but I couldn't reproduce it. Need
> to come up with a patch to narrow this down further.
>
> Can I send you something to test?

I would appreciate to test any patches and ideas.

--=20
Best Regards,
Mike Gavrilov.
