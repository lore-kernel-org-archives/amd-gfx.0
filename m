Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E25C3DA7A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 13:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EDB10E873;
	Fri,  6 Jan 2023 13:00:01 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACC810E18E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 13:00:00 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id h26so2006700qtu.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jan 2023 05:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23VlC83ankn7N0YoENmDzM/CzbDOfWkbeyToc3APK50=;
 b=MCtN1zv6J2Ero4sggrOPo8fiv3x7hiQtUzqUvK0o9CfmiwX2XfRDqBBzPfHQEzAXJZ
 9VGgChbnGdaHcP2t+sgSVm1Z6ro+n49bZ8xtcGOzo2mtfBVBkKSRi6MbdVQeYARqvytp
 BdzkoH/29Xhnc7P64ILUS20oFChDa8nbEBsKM1gRnLY1NDz+kp0I64T0ViTcbJCXVYvV
 bYWYEW2sletTZS0fI8rNOmbTHjKnWBtm7RkVcQstUe51kiY7yO6maaZc4l7xdgXKeLSb
 lrkEqL8FI7NIdQNTkvPHrDUMTnFAELZtZB5SBtZqsR9jtMTv1BctNNDB0G+sQPkhIT3E
 sVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23VlC83ankn7N0YoENmDzM/CzbDOfWkbeyToc3APK50=;
 b=nMUE84scfBee5JqwsoVRZdK/RgWMBVoOtpw/MNk6Ro/bdu7b0D52L1UxtMOITfwLej
 M41j1N5KPS9HEtR8kIkKJxx32q+wZZgxZCS4DY2RwlLmlPu5gaCJ9GymTtjMbWIppqC9
 XeYNR8+X5yEEz0lt999XQ48qyCt7MAlfu8vSlM+XzyWYuQHOIWhnZC0n291oi+HZReJW
 jmPNMq0BsiQE25IF2xorQuO8czLrOBJoBABgrwv+wumU2IfX9Vzr9fZnWE8PP1OfmQfi
 dT2QtsnjJLQCurP0S1IsfLwtgITZOQY5QHdL+qm40tKbinlegw38jN4Gv5nhIlydYITM
 C2RQ==
X-Gm-Message-State: AFqh2ko8vj/CZKo/vjcRirXJNwj556McXvambd5QKy37uVeMXv+4qv2u
 51tZJ5vH9fQtK/5MvJQEOT5W9quDgDR/yed8ggY=
X-Google-Smtp-Source: AMrXdXtM530v9qyWVILuCpkL+v9wi+G6YUh9n9rxwhNuDJsvimdFjdVls4rkxdSh1Hwx9NRAvXD04RNdeI7piafQgT0=
X-Received: by 2002:ac8:71da:0:b0:3a8:2ab9:7f97 with SMTP id
 i26-20020ac871da000000b003a82ab97f97mr1796145qtp.619.1673009999307; Fri, 06
 Jan 2023 04:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
 <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
 <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
 <CABXGCsOmtfo=7YWUv0QmGGrCat1Md59oz7UWw9-7MPn7f6AAdA@mail.gmail.com>
 <e6b6a599-8fdd-a4fc-a2bb-d0750e6d477d@gmail.com>
In-Reply-To: <e6b6a599-8fdd-a4fc-a2bb-d0750e6d477d@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 6 Jan 2023 17:59:48 +0500
Message-ID: <CABXGCsOL2SVg=FSOfhzo3wFHB9DqU=B34x+grCxQMhJsmTCMnw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, michel@daenzer.net,
 Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 5, 2023 at 3:03 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That one should be fixed by:
>
> commit 9f1ecfc5dcb47a7ca37be47b0eaca0f37f1ae93d
> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Date:   Wed Nov 23 03:13:03 2022 +0300
>

Christian,
This patch was written Nov. 23, 2022, but still not submitted in 6.2!
Why?
It will close my questions about amdgpu right now.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
