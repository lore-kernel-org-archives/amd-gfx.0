Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9D7FED2DD
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 07:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F68A10E982;
	Thu, 12 Mar 2026 07:48:10 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552B010E1F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 14:12:28 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso170258966b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 07:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238347; x=1773843147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
 b=iRDrCmgdqUykC77WPrgH3CMpMaA1T6F6uSebk4acVOl9Jrt7GIrQEteK0RkUecI4P4
 bLG2FnKFCzZIJ0xhK88PA7vB8+cPbdb+sjnjwGVSx2ZMJI3se8hQl6F/M0RTq+slV/bA
 40VIrS0nOKFpzYUR4l5hdb+OMbbEatZeieMD/pGWi9+B6aPXGXTIfy9dmsECzm0I2tKR
 wZaUV8t/lh9cA0D6z4uDKvy9maYEVw6O+8vNNXkrhjHo6qzdUVJ3mnIiEaeG+W0C8yEB
 FTWLZ0GyWLia1x25fYTPDv4ohGNl7MsAMKqz/iwpupzV79rdW5x/zUngUscKhNTjP31Z
 QPXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhyXk+I+Bd3WzbllyvGoQ0udRVQ0CUKUJFQ/9K8o6cp+/fvKyhzCCJZSFsoN0k9o7GD4LTnK/q@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0KTwKoqLN6Ypexrbrb/pP4HmKRGhN9sD0H+c+DhM4TpU/qoI5
 2XIKgePeaMqM3iB/H06QVmp3Fa7ALjF01HkdgIT7kUppHSFCcRlAYoe+AdkoYYMCmfMFEw==
X-Gm-Gg: ATEYQzznBYV2OyITGwebOyEmVGG1FnNBw3wp18h7W6aUQbgRPPVCLMogK1M4qNyQhui
 JYCHpdIdDs8xxNQIu41pB99Rmr4pTxvAVXrz0ahqaaETDP1G3Ye+bv/ByCXETJXsZbM48X95U5b
 FYsrxjaZvAb8pLzNq/++BgNAwC75k2Snvv4Ttq1w4YBTX1gZuPe+V8Zg6FcUilWalcchJGw6806
 hgk+a20yEj9uLSp08wzmODG/zlGDLWcFs60N3AXhARamhDb1VKxiUpA6aaEWQRgxADs1DW8yEbV
 pGU6nIIFj0rhU24lbYgePxpvWPIl8g+V2ni/Ec2vKk0nkup5Z5ksBq0hloM889i8D40Om7NMdaL
 M/XUW8PPOoqwjGuZHW66+JfnyjjTxpJ3A/mqK7h22kqHtEXHSwavKPJBOxX7krYZhvLR+fTRjtc
 WTM7MhUZ6xWU3yEcwIO7uuzO+SATD7j8+MB9fsgir1U/kU2Fc026HWCE1qYuzE5wb+GhBEdnw=
X-Received: by 2002:a17:907:6d0c:b0:b8f:6f94:a618 with SMTP id
 a640c23a62f3a-b972d7b4b45mr156847766b.17.1773238346226; 
 Wed, 11 Mar 2026 07:12:26 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b972de48416sm58155766b.20.2026.03.11.07.12.25
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 07:12:25 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-66174cf4549so2113224a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 07:12:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUx3JU6X872JXAF/suPyM8xZOWyatFyl8khs3Na9wYTfUgUF25uVs6FMUi4A5K9DpluKuEyfQdK@lists.freedesktop.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
 <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org>
 <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
 samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 12 Mar 2026 07:48:09 +0000
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

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
