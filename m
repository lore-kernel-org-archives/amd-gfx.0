Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7240AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 19:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBADC10E36A;
	Thu, 17 Feb 2022 19:04:57 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD2010E36F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 19:04:19 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id b38so836823ljr.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=76YOh3whmbn2kqx1NwBv+Kz6cPFzAMtnxeUYyfGd/q8=;
 b=OBKQaFy2RxcRVMpclPmkX40fNiFA9xZ1M06FDambm/VZj3ozimFF9yfzH/IPJFXzHa
 qPjqXTszFuUqE8TXV1lXww3Z667n79ql/oVQlDLn/oPHQ1q/MexRIVFEQUMJkqybd5yQ
 coR1wSQC3lcRhRR4h+/kGuDvBV++mr9JoSg5cN8MQEDDTqmKmqhx2F5cUR8utIGnHpPd
 kmum6m1HYQZH2kpVGKNMISBRkNbXw++ofNJuZD/jMGHUPGgRC7pUf8Ab3eN89o28jljd
 u57aRQ73nEt0EatfpZNV56RywMxL2P8tNMiOUBwvv1qfch/8IBOiO6cKTMbJlUsm+71L
 78sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=76YOh3whmbn2kqx1NwBv+Kz6cPFzAMtnxeUYyfGd/q8=;
 b=niF+9jn4FAa9gfukst3MR67jh2V4Z+34Q2absIotKfHoPV//5q6cllZvzP1AlVEZk8
 RyY1Vg+VnKBYB6AJ3hKoW5NeoCuNWX5MVWaXDXJ9efqUWQ38svgRa9y4xZR72zzn5Nch
 6Q0ksby6s9bneSu+gdgdxssmJlouyopeQP4ugTQXASiwmfIFM5nVeYsT/5AUgeCDpxlg
 U4M/Tlzo14nwGTB9/FPyUUuY6YKKLTjs3Nkck9IB72S0dWr3cxR5xkRqlD27FGjWKMKp
 bnQn7IndEc5tkxdEUSmf/cmII2Gg1YtyH9sdThrldKaZhIgGCMxalAxfa2zVQwWmZE3O
 qlHA==
X-Gm-Message-State: AOAM5322B0gDTeiKuGBlDjwXtoycF35/vXDo66Ulz5BWA94OBSoKEzBe
 /JAX9rUaNML3Gb2/+OUbOrvsy0Xw5N3yt+A1bwJNJg==
X-Google-Smtp-Source: ABdhPJwh4DkU47MNBi0jwQYcYgp6ASpJqNbuKqJzALTbNGbz8cXoRGuLMjThUw0rnBxNBoUoQBdM0fjAD/6dT0KFPOY=
X-Received: by 2002:a2e:9206:0:b0:244:c5e5:977c with SMTP id
 k6-20020a2e9206000000b00244c5e5977cmr2981200ljg.339.1645124657897; Thu, 17
 Feb 2022 11:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20220217153842.3252424-1-trix@redhat.com>
 <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
 <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com>
In-Reply-To: <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 17 Feb 2022 11:04:05 -0800
Message-ID: <CAKwvOdnYTC7mku1=eVaDLGQFHdoN3u8Afoo582OAQ+ApJmfhQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 17 Feb 2022 19:04:56 +0000
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
Cc: "Joshi, Mukul" <mukul.joshi@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 llvm@lists.linux.dev, Dave Airlie <airlied@linux.ie>,
 Tom Rix <trix@redhat.com>, xinhui pan <Xinhui.Pan@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Nathan Chancellor <nathan@kernel.org>, Luben Tuikov <luben.tuikov@amd.com>,
 "Stanley.Yang" <Stanley.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, John Clements <john.clements@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 17, 2022 at 8:16 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Applied.  Thanks!
>
> Alex

Alex,
Has AMD been able to set up clang builds, yet?

-- 
Thanks,
~Nick Desaulniers
