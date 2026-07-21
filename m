Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01610C531C7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C5010EFE2;
	Thu, 23 Jul 2026 07:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBE29qTM";
	dkim-atps=neutral
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3D610E39B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 16:36:35 +0000 (UTC)
Received: by mail-pj2-f3.google.com with SMTP id
 d9443c01a7336-2ccbff2e6a7so67612155ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 09:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784651795; cv=none;
 d=google.com; s=arc-20260327;
 b=DCYJt6ibF585mrDkT/ayt5DQvNj+6XfUvupJwpytdtoLmkFw3AilKeH8Wnpxw3OXeE
 nb0zPuWl07zdH3Mv3TmSp53/ffTrSZ1WKKbco2WRoR+kQtFJRnvclDLBwFjLeAG9Us4E
 E11Yleyy4/oVnubO4z63B7IU590JPLzHugg4KM5oH/e760vXFlO6IBXieurHdexwog4l
 mSKdoBEEowlMaRLWucXAa0kF+6/0qS92B5hJ+hw0a6yRYyrlHr8L8owTY8zq1lHf2Yj7
 d6uvA7J+FW7N9HqHTXBo9V5GgCYWsRz1twStQUb4dWb5KUJRD/qBPaO0v4Tx6CqdBEH3
 7HBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vVqgX84jQjtV56FO/L90fCXJ4uFy/82Ndepm6gSaM0k=;
 fh=wumL4+FV1t7tbyIJayffwwmFQL+NFAckuYfEbbKFGWU=;
 b=nwU3EWufiGLbSV3o5ADpVtkd1fMNhdnNxN3GchKhO6xx5XVij7bAzMF14o8j9h+4rv
 As5LYc98kxueiHeL2+Dl+V5lIma1ysaE1+63KM4y1qB/eArDNZsUhhf+FQ0VA6DmaZxR
 v7Y5dwPhBh/UTdx8D34epcnDV0YnsIo0sm/VznZO3esPNbUdmVM9l1rcQ+k1uwIRcwGq
 Nuu57ZTWemWts1d8KOL69eXV2rbzf1dsthmC5uw671OScr1DotDbKg68wA4nA3hMqRgF
 vfgmKfby019+hm8DZequjKw2L2w/G4YWcegJcqGBPB8KIm8F68DBZWOo/QkgglwNs2J+
 EdnQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784651795; x=1785256595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vVqgX84jQjtV56FO/L90fCXJ4uFy/82Ndepm6gSaM0k=;
 b=BBE29qTMembu/Ya5aglDxSJshwR6v+56QkO8qbBSR+UoSAqW8ck0mtCrYuGYCQG0DK
 ATOajazHXAoOE19+sHfOyKNZDc36th7Er6jxz/TfINULz8O7C9aRfDASIp78EZC3bmCa
 /iLWFjcoh+AZ27voqFceD6DjwPtCMq43LkOdKezs4GZteF7gaZOiDc/tk4ww1u3Rzx6W
 vZRJ9/3zly/1UR9LOoV/hw/L456YGDCdqNMh/IiPlN5TUds9qMSIaP2XoWpDcNlPSLT4
 qdm0E+fCGLaNjpVwwbM5tQKkN5aPa1lDwJ6Yxl2Hke4SSrYM8vfKYlYVE2bT+CUk/DeM
 rk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784651795; x=1785256595;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vVqgX84jQjtV56FO/L90fCXJ4uFy/82Ndepm6gSaM0k=;
 b=nhuhQ/iMOLkZxiu1ZJIwLISJslK9toVC5L3MoLh3tEKYqg3sTCcpOmbOTGvkfbb/WT
 QqB05r3MXbDHCsRWmj/kndeUTc3qNZDfiLgyPdqBY+bZGjKcvYftku19JoduD/vZJedp
 aU7I/pkuSUYWRO76OJLS1Pl7qbw3yXQ8wrsLeFpBTqstXms5J/wpIpFg9XqGbj1RvYXW
 M1MFw+Jl2iGbozgR1iMiTUFRgSRP5WO9JvXfoNFT72ZhLI/ShLFUqiyBKbDxurI8jxxr
 J9XXe1fnecVDxpBIcEoq2kIY/8pS5fgvS2/A77zu8TG0/mT7ZlF2Xs2yE+PFt0NwD9iR
 f0cA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqC4c9giMf2wnXJmAq3Y+YiYNN8ypnjz5iOjWppE4dPXWM2ffI63+i/YPJslHHgsJlok2ypB6xf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuWQH/58d2K+l0DvJo4B8IdudT4W8GK2JpgRPO8xT0BMOY/Fhu
 iz033tvMaK9WHEWmMeuagVeSCAOg4UuDW8NRMX3dyOjDBKmPRnTe9gjh3ksE+AT//JprAUwkNTn
 IsV9yxDLyzzcUBsz2D3JAfA5Ky+LPdA==
X-Gm-Gg: AR+sD10yUb0dsK0QEnex69GeuPtZ99oA8BK/igv2kYJcPGZPW2AhzeqKzHqsgbqd0Dt
 256IERzPaXoN8CxdsR933NdeuPb9LodH7XnZc+T2A+EDXiGBETGcBThaLzEj0h1Ok6MIA9spz8E
 neoBme+DO9GukWpjvmmLXe788a7zaKj0R06qlEz1ClzfyyFe2J/S3jfr4iXdDQzOy/IwrE2nK9E
 0psobKIZnnWzn6UCOafyBLJOnOo/40Y6vrSq/RlWR30Y1+Z62SSHXMSfAOmOR6cV7WDXSEirr7O
 ySK2SejwPjKeQDcBK+8=
X-Received: by 2002:a17:903:3bcf:b0:2ca:ed41:d33d with SMTP id
 d9443c01a7336-2cf34a80342mr224602735ad.45.1784651794678; Tue, 21 Jul 2026
 09:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-9-ap420073@gmail.com>
 <41e73be8-242a-4e7b-b085-439375303590@pixelcluster.dev>
 <8dfbef48-db20-4642-8f50-e37f46af6627@lunn.ch>
In-Reply-To: <8dfbef48-db20-4642-8f50-e37f46af6627@lunn.ch>
From: Hoyeon Lee <hoyeon.rhee@gmail.com>
Date: Wed, 22 Jul 2026 01:36:22 +0900
X-Gm-Features: AUfX_myNLtLISc21KdgKa-JpkJ-v8hHK4oD3B4RXKoOMKPs4a14geDJhHunEcxY
Message-ID: <CAJ=ss6_iUvP3Be735V6_dD0JTF96=NZWe5_G_p0nubdRvCZ==Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 08/13] drm/amdkfd: add GPU instruction
 emitter and disassembler
To: Andrew Lunn <andrew@lunn.ch>
Cc: Natalie Vock <nat@pixelcluster.dev>, Taehee Yoo <ap420073@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Alexei Starovoitov <ast@kernel.org>, 
 amd-gfx@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 bpf@vger.kernel.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, 
 dri-devel@lists.freedesktop.org, Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Michael Chan <michael.chan@broadcom.com>, Nathan Chancellor <nathan@kernel.org>,
 netdev@vger.kernel.org, 
 Nick Desaulniers <ndesaulniers@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Simon Horman <horms@kernel.org>, 
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:46 +0000
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

On Tue, Jul 21, 2026 at 5:53=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jul 20, 2026 at 10:05:33PM +0200, Natalie Vock wrote:
> > On 7/19/26 19:58, Taehee Yoo wrote:
> > > Add the AMD GCN (gfx9/gfx10) instruction encoder used to build the GP=
U
> > > shaders that knod dispatches, plus a matching disassembler used for
> > > debugging the generated code.
> >
> > Is it really necessary to have a full-on compiler and disassembler in t=
he
> > kernel driver? This patch is massive and I'm wondering how much benefit=
 it
> > really provides. Is there really no way to move GPU compilation out of =
the
> > kernel, one way or another? Could you get acceptable perf with a static
> > shader that interprets BPF programs at runtime? Such a shader can be
> > compiled beforehand and just embedded into the kernel - there's prior a=
rt
> > there with the CWSR trap handler in amdkfd.
> >
> > In case you really, really need to compile the BPF to native ISA, could=
 you
> > still have userspace take care of that in one way or another?
>
> There was a long and painful discussion about P4, and offloading it to
> hardware. The proponents of that wanted to do the compilation stage in
> user space to produce a binary blob, but it was hard to prove that the
> P4 passed to the kernel for software processing, and the binary blob
> passed to the hardware actually where the same. It opened up the path
> for closed source P4 where the kernel never got to see the actual P4
> code. So it was not really offload, but kernel bypass.
>
> So having a compiler in the kernel is probably the correct way to go,
> if you want to be friendly to open source.
>
> The other option is to get the GPU to do the compilation itself, so
> you pass BPF byte codes to the GPU and it generates its own native
> code. I've no idea if that is possible, but clang can target OpenMP,
> so maybe it is possible to move this compiler into the GPU?
>

Hi Natalie and Andrew,
Thank you both for the review and suggestions.

We tried running a BPF interpreter on the GPU using OpenCL in an early
prototype. The interpreter overhead dominated because each BPF
instruction required many native GPU instructions, so the performance
was not practical. Since this was only an early feasibility prototype,
we do not have benchmark data suitable for a meaningful comparison.

Based on that result, we chose to compile BPF directly into native GPU
instructions. Moving compilation to userspace would also raise the
problem Andrew described: the kernel could no longer easily establish
that the verified BPF program and the submitted GPU binary are
equivalent. We have not tried compiling on the GPU itself, but that may
be worth investigating separately.

The disassembler is only used for debugging the generated GPU
instructions and is not required for execution. We can leave it out of
the initial series and submit it separately if needed.

Regards,
Hoyeon Lee

>       Andrew
