Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BA0C388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F8A206E3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQcQ8Age"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F8A206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 602906EC16;
	Tue,  3 Nov 2020 08:15:09 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CBC89F07
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 05:43:05 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id a7so20537676lfk.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 21:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MuNT1kBsmjFVlwCSohMVH0XAUpaiqhjCv+VgJCXYn0k=;
 b=LQcQ8Age9Axwo8J/829d2HXmpiJvQwk7ycJxrWRlT8zpJ3qF9MuzhIpBhvAhiSR+hb
 mG9XHWU7bdhknsPJxSxxMMLg2F/tuhgOGAcbS5bIbu7IeoTnEGsRaRlBTZHrssQgMhM5
 dhL4qOSKVAlKR/eigT63eGr05e8xe7fyDgp9mgTKE/F5t0ckHbU2jHiXavzhSYScwq1z
 xibrtSd4QPFO5DuMkxd0GEc55SHeO0TFYSscQuZyNrxlrlMlxMgYVMWyBguiQ7If+zgS
 dERkjRfy/0TIDpDmOZVyuv2rIHF4fV2COuff1yXN3jCbSObv098KCXOJVKUbWHf6GhOE
 7pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MuNT1kBsmjFVlwCSohMVH0XAUpaiqhjCv+VgJCXYn0k=;
 b=AMCMDHTvY2JgcSup7MHCXsjxyIsFAQruW3cC+AcNwab89Nolds0pTqiCyxinuHniOe
 iFO3WsdN/sIf5ML3J14ugBdtt0773djMSYV8qQT5NXF2jGeUBTD2VrfRgSTOAWw4nruF
 tQq/lKAOhHiINvBZmJEPy3wkJ+IsgaPR2/7/wgeoWXOCMy70ejLF8qFXQkkIhYfNndlN
 01k0B52yO8mdMOrc9mGVhn0yEcjlCqNPTceTJ5gPb5R0ARtwB3dw7LsK3mU6f9wCf3d1
 c+tF08YZB3UFbQ3o0U/gy4RJ0ynAP+oZ0arLll97mEYq/3yqDX1MFM/NWByFmGQA8omM
 v8uA==
X-Gm-Message-State: AOAM531tqSZlnKsS8SFZE3h7BWbsGhagHw71axUONXb8g5BSS2sd38qv
 h4Pe6uyrpvyikpDRZuBzaOIncICqsT5bSPZuAxI=
X-Google-Smtp-Source: ABdhPJzqM9tOchv/OdQTFpb4w5KVIztjOUzx5R8fylmEUY5nbuLVIZ9e1iYxtp9SAi/9XGaS0db3wka/hT7ZlRkwOjU=
X-Received: by 2002:a19:8317:: with SMTP id f23mr6590718lfd.554.1604382183579; 
 Mon, 02 Nov 2020 21:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20201007152355.2446741-1-Kenny.Ho@amd.com>
 <CAOWid-d=a1Q3R92s7GrzxWhXx7_dc8NQvQg7i7RYTVv3+jHxkQ@mail.gmail.com>
 <20201103053244.khibmr66p7lhv7ge@ast-mbp.dhcp.thefacebook.com>
 <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
In-Reply-To: <CAOWid-eQSPru0nm8+Xo3r6C0pJGq+5r8mzM8BL2dgNn2c9mt2Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Nov 2020 21:42:52 -0800
Message-ID: <CAADnVQKuoZDB-Xga5STHdGSxvSP=B6jQ40kLdpL1u+J98bv65A@mail.gmail.com>
Subject: Re: [RFC] Add BPF_PROG_TYPE_CGROUP_IOCTL
To: Kenny Ho <y2kenny@gmail.com>
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:15:01 +0000
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
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Kenny Ho <Kenny.Ho@amd.com>,
 "open list:CONTROL GROUP \(CGROUP\)" <cgroups@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Network Development <netdev@vger.kernel.org>, KP Singh <kpsingh@chromium.org>,
 Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 2, 2020 at 9:39 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> Thanks for the reply.

pls don't top post.

> Cgroup awareness is desired because the intent
> is to use this for resource management as well (potentially along with
> other cgroup controlled resources.)  I will dig into bpf_lsm and learn
> more about it.

Also consider that bpf_lsm hooks have a way to get cgroup-id without
being explicitly scoped. So the bpf program can be made cgroup aware.
It's just not as convenient as attaching a prog to cgroup+hook at once.
For prototyping the existing bpf_lsm facility should be enough.
So please try to follow this route and please share more details about
the use case.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
