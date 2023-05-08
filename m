Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2972CC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 May 2023 10:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8982810E213;
	Mon,  8 May 2023 10:40:22 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A022B10E212
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 May 2023 10:40:20 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6186119b766so7164396d6.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 May 2023 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683542419; x=1686134419;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOLarLbPEw2BzQnlH1NcQezuXJK2sUMhOzGscxqhSmI=;
 b=szGEV5YbuseSTT2QhxnkprtYX6zVniR4AZX710LSV2FNdm2UEe1dsq9MJMXE67D25P
 VDItCbJ2B1EtrmvWegZIJ7dKGwCYVFsO74nwYdsAn43Pd7pyj2Egeyu54mHT1w4PF1Tu
 CnLg1TkOZiy/Fkdiy4izaXMTb/EzTOuGba/2TTCSnbGVJBdvcxBrilwMN3sZcMsUIO+k
 Wm7AkufaY45+fCrZJsJ2dzYxWGsi81HOa1IJGn5zI7b3pZjxExtz+1GeXlxhX9YcM/u+
 UUtYfRp+rJJQ94IDiTem5ZXUBXkpZc3kUU2+QIJSN1vXo0ccDGKSMvcvZnI+v7vWhVV5
 7Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683542419; x=1686134419;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOLarLbPEw2BzQnlH1NcQezuXJK2sUMhOzGscxqhSmI=;
 b=SaAmbXrO3+TKRmUQz/t1LG6qekfL6l0p4F9Xm5/F8u9JSoVMtg2G0pxSB2UkFqdX+T
 //HNaYSumNZeMz7kS9+ZItEPKLYjEgo2QMLiv1zwkHDT7K+tVDVDx1xwgzuqg4b49asc
 jFUbcNGm7N4pW0whRhg8yH/MC449Ryqn53BLhKv2Hr3nTachKVSRy0EaKOQwNHWT12p0
 kg+DVYrQmayqyTSLXz/ZiPWJX4PKSmZBcl+MOGe9IyFCIU/ldEWnHfg1oXzdfyt4NiNC
 LdOnmRg+jM4pmlAZSwLNYUK2OB09OK0i/nXV8gGK5qyo+qRiBlbLlE7gGvCv28LjjnJ9
 8FDg==
X-Gm-Message-State: AC+VfDwozfks+HfewLCVm0cTgX1c+BXOcH6TmycptNGvQlu2PDGuqMDH
 mLFg3gUSVdFy33Ry7trnwubM+9dl6uJ0NiqA+N8=
X-Google-Smtp-Source: ACHHUZ5iItQygWtfgG27YbkNns42GQ2GwBwYRcbTfphBkNC5JHBOvYHayfIU5uZmZdKKjmsB6uKI5PvuZadFGQsXIRY=
X-Received: by 2002:ad4:5ecf:0:b0:616:73d9:b9d8 with SMTP id
 jm15-20020ad45ecf000000b0061673d9b9d8mr12826533qvb.3.1683542419276; Mon, 08
 May 2023 03:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPiR4Lwd0NTecp8GMN9YVLU4OXTiHm-z7Gsa_4-LEm1ZQ@mail.gmail.com>
In-Reply-To: <CABXGCsPiR4Lwd0NTecp8GMN9YVLU4OXTiHm-z7Gsa_4-LEm1ZQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 8 May 2023 15:40:08 +0500
Message-ID: <CABXGCsOWCp=KYFFvWA6ExUotUJe=YViZEsomqkCJb7dwNUFAwg@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref in range
 [0x0000000000000010-0x0000000000000017]
 - RIP: 0010:amdgpu_bo_get_memory+0x80/0x360 [amdgpu]
To: "Olsak, Marek" <Marek.Olsak@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Fri, May 5, 2023 at 6:44=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> I need to say that it may not be easy to reproduce this bug.
> For helping reproduce:
> 1. I looped script above:
> $ for i in {1..99999}; do sudo curl -s
> https://raw.githubusercontent.com/fatso83/dotfiles/master/utils/scripts/i=
notify-consumers
> | bash; done
> 2. Launched google chrome with 26 opened windows
> 3. And played in the game Division 2.
> A little time and luck and I get the desired backtrace again and again.
>
> I am ready to answer any question and open for testing any patches.
> Thanks.

No one can reproduce this?
I prepared a video instruction which can helps:
https://youtu.be/0ipQnMpZG1Y

1. Run script which would calculate watchers:
$ for i in {1..99999}; do sudo curl -s
https://raw.githubusercontent.com/fatso83/dotfiles/master/utils/scripts/ino=
tify-consumers
| bash; done

2. Run the game "Devision 2"

3. Run 20 windows of Google Chrome with such script
$ for i in {1..20}; do google-chrome-unstable
--profile-directory=3D"Test-2" --new-window --start-maximized
"youtube.com" &; done

I hope after it you see the desired backtrace.

--=20
Best Regards,
Mike Gavrilov.
