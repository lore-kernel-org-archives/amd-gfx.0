Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22914C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 08:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5E610E2F1;
	Thu, 27 Mar 2025 08:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uu4OMy2j";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4400C10E122
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 22:59:15 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso569558a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1743029953; x=1743634753;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DdJT7/C6Mv3MtdVMV3c3vRmA5DIaye62FsYRt3g3T90=;
 b=Uu4OMy2jymf4A74bSftdPgsdiPJis6xcynF3YJK7ljQFEDDnseWfVpQK1uim3NoaLY
 EH+HEve5X4Tz8a7aKG70qlOzdfksAQpjXhQpKMzSTx5K8wcy1GrjzFef/lvMo1LOCmH3
 uSp/mWfsk7mSL5b0R1s8hwIbZH/0ybP0QqPZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743029953; x=1743634753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DdJT7/C6Mv3MtdVMV3c3vRmA5DIaye62FsYRt3g3T90=;
 b=ipNiPR8KC4XFYXok8bIauvs8ED6Pz5JQ12NoQw8qS67t5X/ZH+VOCekXc2TgvpC5CO
 9KLCJd1B0RyKB0LjVGxuC7lzwtQctwxJjybu6JLer0rBqOcZI+b/uC4J0TUy2wRhvt9C
 CfmE41khndEJ8oQG9vkifIZHtj00DibQhJa2uT4TcC40nnB+KyvkZYaPzhgniPy3ndPP
 ARR3P79Ojpf1CWPe8IqTnnKD85vyNBzQ7UfwSUckwCf4v1W1vlRTJ3xQDTRv5C4AuytR
 fbsyYJb8RCQUBm/yaUoBZW75fnOSwEDCxVZSFLuMSDAsY9Jc00jQ1xR19ZLhM3C5meAz
 /qaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN7kMr2NU6AplxraV1aAr9+8GdcPwGeATcwSprceiqAN8XuH2FagY1p6rNNlrW8XvlOWALkhMS@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4NHFtGNXAJtx/k8/WhLxUtYn5Tlq1fLJ0kf+VHglQ2/93Eejh
 +T/DV3LnZhI8GXFqVuvasOo5PrTVFBQYV2TkF4vD009ZSlrHCW4sUiSuWD/gWPaLxzbUMTvS+1u
 e1Ho=
X-Gm-Gg: ASbGncvSxVSZ4J1ZGOkeyuVZhEPABHcBibFfCwurKl4yuBOlWXRrLnmAmQOoiUEXYCg
 6KgMefUCUV28X6GSeKtf1A+lmZzapH+N79OJZbLU2jXpBZURcoXvXdcUht+YOxBVJBttnWhdsLa
 y2yI9mFzzeSCr0VGp2EiJ3WROR/HujrA8vExBVU7vg2cZaJfcUqD7cAQAybd/BUTC4ImtCSGaKv
 cnLirbUXjr8IvcffgpD4LxRVNr1bKiU3l6xKmsZ5/HcMx8fzSnBdbT3tDWNutXkB343XkqRZ9Jd
 reLGw8VXg2NpT/a37RYz4sog11M84FYFDt7WJi1omdFvDhkV17llmxBTbfJYVUGkras+tsyU+sK
 P10lbA/TlBP5ini9yEWo=
X-Google-Smtp-Source: AGHT+IESD7MSkPmA83A2OssM2x4rmqvztf+8q6qDHs433bgwG+NQGwSOP/az0SCE4TCQQ0KFCAMDKw==
X-Received: by 2002:a05:6402:26d0:b0:5e5:c637:b69 with SMTP id
 4fb4d7f45d1cf-5ed8df6b334mr1212862a12.6.1743029953509; 
 Wed, 26 Mar 2025 15:59:13 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com.
 [209.85.218.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccfb1271sm10527292a12.44.2025.03.26.15.59.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 15:59:12 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso56047366b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:59:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW1RoHYlcJmlZEaH65+vCeebBRV1ludvZYa/JTGtO06XLiEZGPiMqcplV4aQr8ORR3vpYXfYf9P@lists.freedesktop.org
X-Received: by 2002:a17:906:f587:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ac6faed1862mr124221366b.15.1743029951610; Wed, 26 Mar 2025
 15:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250325101424.4478-1-spasswolf@web.de>
 <64945196-f05f-478e-a2b5-f0bd58345136@amd.com>
 <c66e2c03648370d5e5c0745f32ebd58367bbe48b.camel@web.de>
In-Reply-To: <c66e2c03648370d5e5c0745f32ebd58367bbe48b.camel@web.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 15:58:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5Suzp0z7AnK0NgSKfEAWQJw7Dgv5eku=rzBuM1ugQDg@mail.gmail.com>
X-Gm-Features: AQ5f1Joqj6knJlPGY12Qm5E3Ax3-nFRy20R2IbdTOZEIlJ4CJbxhEjPRL7oKvsE
Message-ID: <CAHk-=wh5Suzp0z7AnK0NgSKfEAWQJw7Dgv5eku=rzBuM1ugQDg@mail.gmail.com>
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Balbir Singh <balbirs@nvidia.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Peter Zijlstra <peterz@infradead.org>, 
 Andy Lutomirski <luto@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 27 Mar 2025 08:19:46 +0000
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

On Wed, 26 Mar 2025 at 15:00, Bert Karwatzki <spasswolf@web.de> wrote:
>
> As Balbir Singh found out this memory comes from amdkfd
> (kgd2kfd_init_zone_device()) with CONFIG_HSA_AMD_SVM=y. The memory gets placed
> by devm_request_free_mem_region() which places the memory at the end of the
> physical address space (DIRECT_MAP_PHYSMEM_END). DIRECT_MAP_PHYSMEM_END changes
> when using nokaslr and so the memory shifts.

So I just want to say that having followed the thread as a spectator,
big kudos to everybody involved in this thing. Particularly to you,
Bart, for all your debugging and testing, and to Balbir for following
up and figuring it out.

Because this was a strange one.

>  One can work around this by removing the GFR_DESCENDING flag from
> devm_request_free_mem_region() so the memory gets placed right after the other
> resources:

I worry that there might be other machines where that completely breaks things.

There are various historical reasons why we look for addresses in high
regions, ie on machines where there are various hidden IO regions that
aren't enumerated by e280 and aren't found by our usual PCI BAR
discovery because they are special hidden ones.

So then users of [devm_]request_free_mem_region() might end up getting
allocated a region that has some magic system resource in it.

And no, this shouldn't happen on any normal machine, but it has
definitely been a thing in the past.

So I'm very happy that you guys figured out what ended up happening,
but I'm not convinced that the devm_request_free_mem_region()
workaround is tenable.

So I think it needs to be more targeted to the HSA_AMD_SVM case than
touch the devm_request_free_mem_region() logic for everybody.

           Linus
