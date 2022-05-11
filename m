Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDD3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 09:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296E810E4E9;
	Wed, 11 May 2022 09:05:57 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614C810E4E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 09:05:55 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id eq14so1645154qvb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
 :content-transfer-encoding;
 bh=axM/XiXUKEix0R64dc1cXQCZa3MQHR+yLw+4g0JGvQY=;
 b=SGuwNjk8yN5DuReUTFLczxNcdgVKjgL+MxPoD33ffYUPwAHVtGJtMTv9VzvKaEoqs8
 mYP3utWhoEzEGoz44RuU7t//p2ZLvja+vo09eh7Y5maF+EKjnlYI+YkPBMVCCa/MEG32
 YlP2r6V4B3iPeGnEh/NPXXaHdZ1s4iEIIRzNUhoKsnGLNKLBsirUKxj03GU6is2lex2A
 Scv7BtHmnRBV29wtM6WpazlkohkWWhuUUPOzrMX5ymhg+jPPqgBNUWuKeTsNk7lcFvIv
 uZzMSkOgqrB0INoNPM0etm1K07fOpLVpnbKRJk1q/hCh05S2V4AeQgSccOYQyDfIKAqo
 bzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:cc:content-transfer-encoding;
 bh=axM/XiXUKEix0R64dc1cXQCZa3MQHR+yLw+4g0JGvQY=;
 b=Crgb2o7peL0u6p91e4GHm5GobVgJEQB/oWI7LO0y++jZhPH+BGuLWfcWtaotzF/P3Y
 EnrDKMddCkWqEzGuk0Z7Rk4gB+FAqKs3YR+kQ49rphBZFsjyt2Y9SmwsxhRbYjtKCncc
 VggL/h0aQeptYPViSuH+YVKEWcWsOupfjzA36N3zDtTt6VVYa1Aneb4KXtYYNCej92vS
 nN1JHQmyhT123fKybXJwF2DQms9qWoDQA/943ANjNIV07OXejXH2rBS3cKKQoXw0YIEN
 Pr7tWdMZ5HE3PjDNhi3eDU7b5leXgR0RWqPTJCp13RiSCGugTjbVIfE9D4IZAZAiY3w2
 u/Hw==
X-Gm-Message-State: AOAM533JIhIcZwHOigCDNHm9Nr3AI7lIvYe3Ge1NSUK1iks+k3sq1koA
 7YZECo1KM7one3EV5oovlA9coFVg9nqhW5Smxgc=
X-Received: by 2002:ad4:5c88:0:b0:45a:e934:4730 with SMTP id
 o8-20020ad45c88000000b0045ae9344730mt19998534qvh.61.1652259954197; Wed, 11
 May 2022 02:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
 <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
 <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
 <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
 <675a2d33-b286-d1d0-e4e7-05d6516026c0@gmail.com>
In-Reply-To: <675a2d33-b286-d1d0-e4e7-05d6516026c0@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 11 May 2022 14:05:43 +0500
Message-ID: <CABXGCsOqrB5zPFCeLw-VQjePikwDq4EKFQGc9hbOb5f7tGLDgg@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 15, 2022 at 1:04 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> No, I just couldn't find time during all that bug fixing :)
>
> Sorry for the delay, going to take a look after the eastern holiday here.
>
> Christian.

The message is just for history. The issue was fixed between
b253435746d9a4a and 5.18rc4.

--=20
Best Regards,
Mike Gavrilov.
