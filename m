Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1497DC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 07:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FF4B40DC;
	Fri,  5 Aug 2022 07:24:05 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7752B9690F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 18:52:28 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id o22so758850edc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Aug 2022 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=d9A+1UrQLh0WcW9MhwNlbIKjJoOc9nVaeZ+f3kn5XJg=;
 b=Wghr6irArPcwVSc+CNnhrrsEu9dnr4MgYqspEvpRuXFzsOtqFWg2OW0RZw0DsbJhbG
 7KYJuxI+hGsaf1e3eCH86NhWL3mKYHLchNkwelwizVdbqx2TCHmSyTmd7/UiTNDRDtqj
 1bkDxMnc43SYw+VE+NmTMF0O+9AkEy2ziVWdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=d9A+1UrQLh0WcW9MhwNlbIKjJoOc9nVaeZ+f3kn5XJg=;
 b=aNXJf8dz38jxt/SEDRjlM2+059IhPo3HnybUxYbhYaaNCuJ/dhEWg0+vaquOk0w6xD
 1PwpymOS38PUfF74LcFx04tlWmq+9oYv4s/5EQzb7hbg/ZNbrydbJ8BkKvgJ08Y3HYPn
 640j6eKC2UaLbx9JGEw07WyLu6BmDpmkDI7htdhjh30g3h/7TwLKAekQE3kja33XFOFz
 ww/ru/2wW1HyBRkcGdtofOim13Nbxj/2NVA7srM7Azx/z25wcNgCdlarhywYucJ03ZpU
 1bUXG7i+fthxnKXencwYdiQ2FiYCFRKdJRHKiTGB7nJiwCzoMcecZROWrQflnBMEOSli
 Vfqg==
X-Gm-Message-State: ACgBeo3vFGTSRrbDQoQJdSpFVM39ysjlj1V7RnxQnBVbWFfP1C7bDeOU
 /GZFGZOA2sI2u8rbjBZIgZBuTH/RRpisAn64
X-Google-Smtp-Source: AA6agR5e2v4MZ6ixpIfPFvoB/nezx6lkks3Hg8SuKVY4QkisnayC+UFLK1wKeNX6TqkMVVrl9KcJeQ==
X-Received: by 2002:a05:6402:190e:b0:43e:1588:4c32 with SMTP id
 e14-20020a056402190e00b0043e15884c32mr3349125edz.76.1659639146395; 
 Thu, 04 Aug 2022 11:52:26 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47]) by smtp.gmail.com with ESMTPSA id
 s18-20020a1709062ed200b007304d084c5esm591504eji.166.2022.08.04.11.52.25
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Aug 2022 11:52:25 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h13so792331wrf.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Aug 2022 11:52:25 -0700 (PDT)
X-Received: by 2002:adf:edcb:0:b0:21e:d043:d271 with SMTP id
 v11-20020adfedcb000000b0021ed043d271mr2265646wro.274.1659639145076; Thu, 04
 Aug 2022 11:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <YuwRyQYPCb1FD+mr@debian>
In-Reply-To: <YuwRyQYPCb1FD+mr@debian>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Aug 2022 11:52:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
Message-ID: <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 allmodconfig with clang
To: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 05 Aug 2022 07:24:03 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 clang-built-linux <llvm@lists.linux.dev>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Nathan Chancellor <nathan@kernel.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 4, 2022 at 11:37 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> git bisect points to 3876a8b5e241 ("drm/amd/display: Enable building new display engine with KCOV enabled").

Ahh. So that was presumably why it was disabled before - because it
presumably does disgusting things that make KCOV generate even bigger
stack frames than it already has.

Those functions do seem to have fairly big stack footprints already (I
didn't try to look into why, I assume it's partly due to aggressive
inlining, and probably some automatic structures on stack). But gcc
doesn't seem to make it all that much worse with KCOV (and my clang
build doesn't enable KCOV).

So it's presumably some KCOV-vs-clang thing. Nathan?

              Linus
