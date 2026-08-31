Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE99C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CE010E55E;
	Mon, 31 Aug 2026 18:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sVoCOYYB";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA27B10E55E
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:47:41 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-396afefb35bso496910a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 11:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788202061; cv=none;
 d=google.com; s=arc-20260327;
 b=aJ2PALWaaBjfYHE+JqzCkH+LQPJ8G943Bj3P3k5FisHKRd6EWYiW4LfK4RBd3aZy/5
 6W+vOdIM0ssvm367XJp7oL502KbCallmM6PJ3tsWlSPj8JrSxmWxM6RUyu6DQuFgg01o
 dhg0ZmH8XdApwifupKfG8qwJXpy1Jnnty6MX5n2Ei0fkfhd1HRZX8F2AAJJjNU/ual3c
 R8npg5EWaCYN40S5vX9EOeQ8olEDe1WkY7IYi50YCH+DnJIZ7lC/A58QAx87CPM3Xxdv
 A9HqBvuwxvn40tiYAkeC+0/Vw3DpZ+ULCkx5Sdb/vKbfq5XNZSl5YtEYbEW1QRVR/XAg
 ehyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Ha99R2bTFpGHkNbrwTi9GV1Xb+ybK3budtBsLGnfUU=;
 fh=/pQqhhcgyDQSojRB63JcFSOdY/brWlux2efOQZLNdeY=;
 b=Fk4UZiQXy6hPN4/EA9PPh7IkI3NBmnjiWUif6x4nh7rZgBSb2RBjRNWrtJL6hG7diM
 yDTPQ6Zueu1OIOjzKmUwYUdtCeqGxVifrvAB86x1PeSIu7Af4Bw+N4B3Pb60DqqC5bEK
 DCqdumxAbFkrgiaYNbe179RPXhL+eqlcwyzancRuEBcG+5qskmq0hShTSwsuOwAgX679
 zvLG8cHW3/ymvuG+XdrfMWhFfWoP6uQeHc9vAr56YXnq6BWPMifG3UnX4VRJG0RAGQg6
 cHINxEcO2nnR8+yoFBhWVWmC1Uiod589WVvD42OTXkgwwdMBD4Lf3hx9xJ2eC6Zj+cMG
 SS1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788202061; x=1788806861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Ha99R2bTFpGHkNbrwTi9GV1Xb+ybK3budtBsLGnfUU=;
 b=sVoCOYYBc64ZctMCZXlvBSD1/NR9+cZ4yAhg+6bCcg4oxiAKH2nxliSfDz5EVMTD6t
 YLgHz0uGt2Ke0HXl/2m/ApLLVpH8U0SHQ2E7R9BsgMlxdmd01iDMuzI/NxOs2SCE5fe3
 sumCSXK/b6ZMF2oYpWoJ6qtWor2V56r6XUBm5i/smulyEZJ2av1QYpsBXIlawTZM5woD
 7alNf8ZChaa1bA3lqA8eQb1+Wsc2E7cUDGeA2k95znhFnSe4zktSIvcbYmuPJn60vwKs
 Ab5EKHVEzgKlBEwdlaf+RyTL4JjgIo8GdBy5bpTfXwydT5SDiJTMwofahnFtwLUE9vbE
 4dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202061; x=1788806861;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Ha99R2bTFpGHkNbrwTi9GV1Xb+ybK3budtBsLGnfUU=;
 b=JWv5Gh6GAkIr14pAyXKDKJtTej+NFa1b4Mow3/abpsD4wZvfm7uZIw1zRBKBZ8fKhf
 csoGHXmZOn1s91DkfphBjSwftUHyqxU3Oa2AZLw8pizWu7IC99nMRJkaXqP185xxE+D5
 cbYHrswzaD0/2Y7VcGSy2qK+Nig5bMEtnynL8Wl157rxxdhptaJTat4ATpFETlGulWfy
 JCTclIRZK1e2gx/bi6+eLIBTcGW6jyDCmSMMDXbKp/NLQeaZrWdixEEm8ZQdJyIUuoWv
 lFI6IBGp1M6vBeSQ1PuO7OFTlx0Alyp44/ABlM/FsNE2gwQV33h/tImNxxb6HKR6HgAL
 F5YA==
X-Gm-Message-State: AFuF++mxzS/5GXL8c3wpj15fu7C++8hTXYq1wIC/qFrbdj6bBK9cdZsN
 hwF0jjtXSAXfD7MRA6JzntvBpjGq4BQS3cWTOCHIpv6sa1PpfOBYZJOMKDURzjKDJY+MFsi3ivB
 oGXU1Db+0vZEHAhPOIkWha8+WYLbJU7WBcQ==
X-Gm-Gg: AYBFou3oVOhqUihAy1bgo/CA1LsM/hz+KkoTqAkdb8FgGtKHVPWA7Z1MlQdwmxvkgWz
 CjtfdGgG5vrBJV8yT8JEVQoVr0MSlm1HKgN20r6562I4bOzEKwYAuUZCe23T3mmU6GGucR2VtR4
 hcauY8/lFOy1FbYXBcTAkVqhnHMuf8HPq1gfLMs/IbK3OUQzlib7deHf9+5lt0wV4Mf64Oe3dK8
 U9gH/TyHV2DpHbIwCWn+mhAXdfhdtbfpvvUwmhcpCyqfTRsXcsxPP53d767VJupQ5i72Gtsivf4
 3r+pphFR54HAiNE2z5RWteKb+wfAvv+sbdk4d3M+OwAgAejRe8Jx1HBHoJNKvjHjrUnFaN6jze/
 yhH4YTcjAQh78+x9AQ/RBBKOrvve8keA=
X-Received: by 2002:a17:90a:d40d:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-398bac21022mr15283953a91.2.1788202061207; Mon, 31 Aug 2026
 11:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <24915fec-468c-48f6-85cc-da7b008b937f@rawbw.com>
In-Reply-To: <24915fec-468c-48f6-85cc-da7b008b937f@rawbw.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2026 14:47:29 -0400
X-Gm-Features: AcwNN1UqiMbjG7oXGw4ZEH7tAVwNs_Lh8XhGT4dDmSC-EZR6x_9RkVdJCt0i1MA
Message-ID: <CADnq5_MAeEZbqsb9-0_7PsDQNgcoHaaUfiNX7Duz2of4+nBubg@mail.gmail.com>
Subject: Re: error messages "[drm] Fence fallback timer expired on ring
 gfx_0.0.0" are printed after which Xorg becomes unusable
To: Yuri <yuri@rawbw.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Aug 31, 2026 at 3:04=E2=80=AFAM Yuri <yuri@rawbw.com> wrote:
>
> On FreeBSD 15 the amdgpu kernel module built from sources from
> https://github.com/ROCm/amdgpu prints fence fallback messages after
> which Xorg becomes extremely slow.
>
> More details are in this GitHub issue:
> https://github.com/ROCm/amdgpu/issues/229
>
> Googling reveals that a lot of linux users also have the same problem.
>
>
> Is there a fix for this bug?
>

Most likely interrupts are not getting delivered on your system for some re=
ason.

Alex
