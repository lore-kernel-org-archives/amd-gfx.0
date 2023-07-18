Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9CFEB64DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 09:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E40010E076;
	Tue, 18 Jul 2023 09:17:14 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAF710E076
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 09:17:11 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-636465d3966so7723636d6.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689671830; x=1692263830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJcVs2LgJCwb5O0XxcSvYoYLi10sNbkUreq5yDMEGUg=;
 b=MH/Vm+kw49meziT2GYy7ODWOF3LLqPW7nnmlvrwEcPTjw2cDtZ5KIGhRJA1Iz9HsHl
 2CJIG0ufbKlK8Qg72NmM55dLkCrKVeuUdUy8BrccSApC/QlveC+MqUc0g/SV1coo3B2o
 iTWx8Kdi4oz/7XeAb4vDqzlU/p1HVpDs0g2BXo9joOl9cv60OyS7ZQMqaVch3nQr0T3s
 eFWtZ3l/9MaF3hYc5xjbz2uePGELGd8nomEyaAQ2eBbyjYmHbG/85fC00dZudLZgFF2W
 Yuk1Z4rpjBsqYhKd3mNqaFxqksLY6zN03af1r3xZSqQFZmyNXX5tFVSHnP0dWatDF7ju
 S83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689671830; x=1692263830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJcVs2LgJCwb5O0XxcSvYoYLi10sNbkUreq5yDMEGUg=;
 b=iuHAyNLwc5Esf2EJkyWYZA3z2iwFEa+mM0HTk4d4JMW1YobhcoDlIMNVpRxBeVuPEc
 ngg7KmkjRcOeiPwgEkrgLSwT59geM2QgDrD78fqsnygHi9sSIuF9KVAyHqwbTxi5pzQS
 PdM7id1vdSyB4uffzYCL60VOpaVH34oMkC/gCAOQ+3at1XtlZ9lkEDuoOGe9K4jSNPQg
 6A0483ErWLWnLz1ijba4yCrx/Ik4RdKQK7EUhiylUU1b4Tc6cVMzrmJR8sDdvAUHkKq/
 1SvuVMmFckahfyB2ZmLbxyEcpQNqoinCYevehBDCSUjJpEljpYjAPcSTqWj0uZcnvvuh
 O/Rg==
X-Gm-Message-State: ABy/qLaJzB7yYE7eS2B5ZJeYokXStYJgsDvLKTjObrMFSbmAlIm1bGKW
 huOq6OYao9zjH1H7HpXuL+m5S2+0yQEZ5r/d44g=
X-Google-Smtp-Source: APBJJlGeVxT3OiHo/zWCPHVTC9gYgms4ynClc8I6gkukgO8R/TmSV/wUW1vQhUj+zg/z/bBbUKTVONbzrNHgnzcMZOs=
X-Received: by 2002:a05:6214:2aa8:b0:635:da19:a67f with SMTP id
 js8-20020a0562142aa800b00635da19a67fmr11015276qvb.1.1689671830421; Tue, 18
 Jul 2023 02:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNc6mSOLHv1W5qPuvn56Yy0Bsjgg8X13qzg8uUwCaYkjw@mail.gmail.com>
 <DM5PR12MB24697E6B83397ADD6F8F6556F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24697E6B83397ADD6F8F6556F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 18 Jul 2023 14:16:58 +0500
Message-ID: <CABXGCsNXfk32HmEc+45qM7850N1PQhZS=2ypTkZhp9SpBJfxRA@mail.gmail.com>
Subject: Re: [bug/bisected] commit a2848d08742c8e8494675892c02c0d22acbe3cf8
 cause general protection fault, probably for non-canonical address
 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
To: "Chen, Guchun" <Guchun.Chen@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 18, 2023 at 7:13=E2=80=AFAM Chen, Guchun <Guchun.Chen@amd.com> =
wrote:
>
> [Public]
>
> Hello Mike,
>
> I guess this patch can resolve your problem.
> https://patchwork.freedesktop.org/patch/547897/
>
> Regards,
> Guchun
>

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Thanks, the issue was gone with this patch.

I didn't say anything above about how to reproduce this problem.
Case was like this:
On a dual GPU laptop, I ran Google Chrome on a discrete graphics card.
I used for it this command:
$ DRI_PRIME=3D1 google-chrome-unstable --disable-features=3DVulkan

--=20
Best Regards,
Mike Gavrilov.
