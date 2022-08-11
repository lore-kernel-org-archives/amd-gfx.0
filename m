Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67641C25B0C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 07:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F21EA7072;
	Thu, 11 Aug 2022 07:30:17 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E4E112FA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 03:05:05 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id b16so21376352edd.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=CG6MAVobgAYGHZbI0IFM6W4PbFNyxeF/bPZUNWhmbHI=;
 b=i9WldlQgb1YGnmOMjtTEJNK/5uZC9isGoa0gAQSHsoM4nTWzDbJ8gMpoQSkP9uY2DC
 0aT+mqnPiVdpavbJmuIl6gYr3NrK5muaTiCf+sx47ZubIRQKUSR1W//cDbrbykFRodL0
 xw2oLZOAAM9JG6XiyKlGM0Jj1Pnvn/TK+xWTStKZ+oI5PK+Ag5keDylpFA7966dLiOHH
 cf8kAhu2p1u7yDdBpxhR7nXmnV410l/g5Q0rQrMUYmCJcADPNxz29+BP98E7esxnFbio
 Hslk4ArLWCxqNG9u/yE+0ORGZjEqN94DQsZwf3OyCSr9TNUumLBotjCp1wkXBlpvIV19
 rxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=CG6MAVobgAYGHZbI0IFM6W4PbFNyxeF/bPZUNWhmbHI=;
 b=r/5brNVVlz9To3fp8refI0+eMmYIZ1c4ZJx47I49ZMRQ/bpi882g/aeHxRJbgEMCi6
 LMLQ33RrPoBAK5467ISO7jphrjUyJdItw+mUiXeVFSam2BQEQZJK1Kmq+/UVdp3leWzl
 Dq6BvvnbO5vG7hx7AAZf8I0Cg0H4aiccIyuSq/bFYhrya0rK9VHyydU9AlZ215pVsPd/
 xbmyRfv9Bom74hezVqg71GDNpVu/DcTqTydCg4H3qxcXx0rXkv6Tr++BRSJy5EwZwe9J
 B866iGsadBq7nJm918LaL9sFhCFxIxMvXCrtX7aBJit6eTj7v+Xrgyl+sSAqLbHP4Tfj
 llSQ==
X-Gm-Message-State: ACgBeo2yHMWhSJU2Tg8sJgc75P30kKriIQXlt2im9eKoBRRuS7DjIBTD
 WmeFkdpYhKObbgoHBGZkOF/A0GWuDB0+QlXNGOngYmNUYB8Sl/ih
X-Google-Smtp-Source: AA6agR51BIEzzCvEF6+PKfUaoAUTpclrHYoeUmny3JEP0CWzT4pVQvFolfiaKvJY5Y9L77qS0Whk292/UwtZc5ST7Kw=
X-Received: by 2002:a05:6402:2547:b0:43e:4cc4:85d3 with SMTP id
 l7-20020a056402254700b0043e4cc485d3mr28586932edb.233.1660187103905; Wed, 10
 Aug 2022 20:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-2-tales.aparecida@gmail.com>
In-Reply-To: <20220811004010.61299-2-tales.aparecida@gmail.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 10 Aug 2022 20:04:52 -0700
Message-ID: <CAGS_qxryOVG_ZvV1+i_egPZO8Ngq4EoFRK=Q_J9S8urj3kPyxA@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amd/display: Introduce KUnit tests for fixed31_32
 library
To: Tales Aparecida <tales.aparecida@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 11 Aug 2022 07:30:06 +0000
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
Cc: andrealmeid@riseup.net, Thomas Zimmermann <tzimmermann@suse.de>,
 siqueirajordao@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, magalilemes00@gmail.com,
 mairacanal@riseup.net, Trevor Woerner <twoerner@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kunit-dev@googlegroups.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 10, 2022 at 5:40 PM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> The fixed31_32 library performs a lot of the mathematical operations
> involving fixed-point arithmetic and the conversion of integers to
> fixed-point representation.
>
> This unit tests intend to assure the proper functioning of the basic
> mathematical operations of fixed-point arithmetic, such as
> multiplication, conversion from fractional to fixed-point number,
> and more. Use kunit_tool to run:
>
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>         --kunitconfig=drivers/gpu/drm/amd/display/tests/

Nice, thanks for including a kunitconfig, that'll help a lot.

Just as an FYI: if you're working on top of torvalds/master, I think
you would no longer need --arch=x86_64.
Before, CONFIG_PCI=y was tricky to enable on UML, but commit
6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
landed for 6.0.

I.e. I can run this command on torvalds/master w/ no other patches applied:

$ ./tools/testing/kunit/kunit.py config --kunitconfig=/dev/stdin <<EOF
CONFIG_KUNIT=y
CONFIG_PCI=y
CONFIG_DRM=y
CONFIG_DRM_AMDGPU=y
CONFIG_DRM_AMD_DC=y
EOF

I haven't tried to apply this series locally yet to double-check, but
I'm pretty sure that means these tests should work as well.
Running under UML would hopefully have faster compile times and be
less resource heavy than a QEMU VM (but I've not measured to verify
that).

Daniel
