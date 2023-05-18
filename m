Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E5BC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 23:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7796810E57C;
	Thu, 18 May 2023 23:35:36 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D96110E57C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 23:35:35 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-75778c1121aso30885585a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684452933; x=1687044933;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+bBjc2pOJ6Uyq/nBco+oaTCPhBKha0MzdONm56qSxM=;
 b=eGqkxBNa8fLPRzs2kydWg0Cmz1vo4RaRuNqVOyM1/Tny8uOhIAtF1+FiSVfQNU4qb5
 M2hmsG7BzvCO1NYFir+QR+OW6VmULSg28X1+gPo06ghfJ6yMTk0tfP+eLUZpgnMh4eUF
 Es/GiPB9OkLXSy+JRa45lOuvPb/OK/4v0PA4+xNpnNlB37qix3uVxKhFTVHRoAv57p2h
 uSJJsZJEg/OSI61aC9ZQEI3LZvp8QWYVBT1sZb7Na2z0u+N1h0oQPOHaWGKp+a17RwZW
 qrt1lmO7Xzov3JM9L0yO64xatoBdpmPMLVfQd4ZqXU6CD23H0pFZ8MS1883cfK3zmddL
 KFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684452933; x=1687044933;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+bBjc2pOJ6Uyq/nBco+oaTCPhBKha0MzdONm56qSxM=;
 b=C7CNqU0fZuYQj/bwsTMBtpT3Jxr19DaV2l65Ybdas+1xiYx3QaT4RVs2Y1b0BrrFdc
 l+kLGacR2+PRN/eoTHp1jrDVQiMhUpADjz5n3QpNEn9cx05dinMjOCjU2ZgI2KdKBmnJ
 OtrI/c8ei2NBu5iOy0MBPnMs6lcU4ILNGvqt4F/gddod6v7T/yZDxk4Fv5bGRJyRqlSA
 0oEvUKD5NUu0Az9II+LGT461yFnJ5eRgIvhRGb4HI/0tcvhspTHENRV1Gi0iSwZ9YFyz
 LQ/jpkdJaVNI3PaLrghCeQSsmmVeZ1hOixE/waqfR5ODf2Rz2qVN88hh+9ben0qYF2yc
 RC9Q==
X-Gm-Message-State: AC+VfDyyfyC2Ua2v/8gjAYo8KU4aA1IkoYqBz6zO1i7b8yR6yhhJTx0P
 U83q13z02ykPMUeFjp79+zIsL75cswTXccqlbJI=
X-Google-Smtp-Source: ACHHUZ60JZ5V4fp4GT0w+1msyOxlDt1MJPV/XmSWJhiARevOTYPUocbFvLN5qAhEwAr0l7MBemqN2IkoiDEvgUJMGfY=
X-Received: by 2002:a05:6214:509b:b0:5df:55b5:b1a with SMTP id
 kk27-20020a056214509b00b005df55b50b1amr1345397qvb.4.1684452933475; Thu, 18
 May 2023 16:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPiR4Lwd0NTecp8GMN9YVLU4OXTiHm-z7Gsa_4-LEm1ZQ@mail.gmail.com>
 <CABXGCsOWCp=KYFFvWA6ExUotUJe=YViZEsomqkCJb7dwNUFAwg@mail.gmail.com>
In-Reply-To: <CABXGCsOWCp=KYFFvWA6ExUotUJe=YViZEsomqkCJb7dwNUFAwg@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 19 May 2023 04:35:22 +0500
Message-ID: <CABXGCsNECpnkt1LRTKuGcJdN=mPyFt1sW6c8tY86Ba_pUrCNvw@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref in range
 [0x0000000000000010-0x0000000000000017]
 - RIP: 0010:amdgpu_bo_get_memory+0x80/0x360 [amdgpu]
To: "Olsak, Marek" <Marek.Olsak@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 8, 2023 at 3:40=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> No one can reproduce this?
> I prepared a video instruction which can helps:
> https://youtu.be/0ipQnMpZG1Y
>
> 1. Run script which would calculate watchers:
> $ for i in {1..99999}; do sudo curl -s
> https://raw.githubusercontent.com/fatso83/dotfiles/master/utils/scripts/i=
notify-consumers
> | bash; done
>
> 2. Run the game "Devision 2"
>
> 3. Run 20 windows of Google Chrome with such script
> $ for i in {1..20}; do google-chrome-unstable
> --profile-directory=3D"Test-2" --new-window --start-maximized
> "youtube.com" &; done
>
> I hope after it you see the desired backtrace.
>

I found another way to reproduce the problem.

Demonstration: https://youtu.be/6cvs4cCMo4M

1. Run the game "Devision 2"
2. Run 20 windows of Google Chrome with such script $ for i in
{1..20}; do google-chrome-unstable --profile-directory=3D"Test-2"
--new-window --start-maximized "youtube.com" &; done
3. Run "nvtop" and got kernel bug.

After it "nvtop" stop working until reboot.

Can anyone confirm it, please?

--=20
Best Regards,
Mike Gavrilov.
