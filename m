Return-Path: <SRS0=CFUU=N4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C605FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 07:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904B060E8B
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Sep 2021 07:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 904B060E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC0189A57;
	Mon,  6 Sep 2021 07:29:44 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45BE6E8EC
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Sep 2021 01:25:13 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 ot2-20020a17090b3b4200b0019127f8ed87so598215pjb.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Sep 2021 18:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=+Umpy1ebMJPGJbFqIMmSlGBHhOcRZaKYiB1u746gTzE=;
 b=gxGrIocgu8uQcKzASoZR7kFnD5yy1pm4V4By5wv5aqfyZ7DyGlo2tdeEnQRbFhUtBr
 3Fk74McEJDdwPOEvaMsADrTEfxELH9fkQurpFlVlLAy7A8GaW9jmMSa1/sYaiioR72Oi
 vAsnbC4IL2yr0s8Fo8tnO0m9PnkWea4ItIiv13hw6sDJMV5bVEqLm5ELmlLf9xR4lHZJ
 DJPHa1F5/e5rchUoPosYe5PlPSdl20iEx0POSIu0z9QK1D4HszPFpJkPYiInbRMimZ9m
 cIhVNaUnJ5aWIRlWK3yGwI5GUvEMC+HTSJrSLXgParWTh1UvoN8MpWt8tY+ao0RFA0cM
 PTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=+Umpy1ebMJPGJbFqIMmSlGBHhOcRZaKYiB1u746gTzE=;
 b=rgN39SLkAVyiKb+izgDM/6jSKOSgyDX5YSKc1aybN236XuOeAb0aFOEWq3rUChMvBV
 TyKOqUYLiZ9jky2ImySW4qlyYY3ZO4ZbRsuClTEYowCAMMPL5W34ZMwANttwAHe2H+Ht
 YPhilekTSIR5gxC4K+zKU4Rwl5ePIjZt5PwX9mGdmlg5TB4AQqZ1nIaafxuAfYc57QCU
 XSjEw11vv1sX3oOUvr4NmVMNgTtE8Bh31bpaMmZL5P/lP5lFGVpHeE59iyTLkGtZlBTx
 Xo/MoMEdJsVGup6iHoonFlayMjhjaO/Ohd68hfUcshxI1mIRcbiQuYsQow9t9ClkQ9tm
 eyOA==
X-Gm-Message-State: AOAM532+sw+gOQqRTBUEqIjODA80v7fOuSaYRaCom+vaAFZqH/EYS/gh
 L5sfPDATmoPgZluhTKVYCw5D8OKmMkYe3HlL8VGFyS5oR6xJcQ==
X-Google-Smtp-Source: ABdhPJzE4fgKt4KPe3sR8p57HMoYmvJdOh2ui+3ZUAyHlL+ZFtKqlY+KE3mDBlfC72NACiLFBD6Y2sJ552qriS6DBzM=
X-Received: by 2002:a17:90b:943:: with SMTP id
 dw3mr1685809pjb.87.1630718713067; 
 Fri, 03 Sep 2021 18:25:13 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgdC10LnRh9GD0Lo=?=
 <franchesko.salias.hudro.pedros@gmail.com>
Date: Sat, 4 Sep 2021 04:25:02 +0300
Message-ID: <CADyKhVxusfAwpywq8pKPmT06fMi6Q3tKyuCWBCb1Qi5+GOCSxQ@mail.gmail.com>
Subject: [QUESTION] [amd-gfx] iMac 5K resolution
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 06 Sep 2021 07:29:42 +0000
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

Hello. I try to install Linux (Gentoo) on iMac 27'' with 5700 XT Pro.
And I want to get 5k resolution.
5k uses 2 DP 1.2 links, but Linux detects only one connection. Max
available resolution is 4k.
kernel 5.6 and 5.14.
Linux-firmware latest from git.

Display sends EDID with max 4k resolution. It's standard behavior for
one link connection.

I got 3 EDIDs from macOS:
1) 2.5k from eDP-1 connect with tile section
2) 2.5k form DP-1 connect with tile section
3) 5K (I think it's fake EDID, not works)

And I force enable ports (video=3DeDP-1:e video=3DDP-1:e
drm.edid_firmware=3DeDP-1:edid/edid1.bin,DP-1:edid/edid2.bin).

But I get only 2.5k resolutions with EDID, Xorg detects a second
connect and uses it, but the monitor shows a scaled image from eDP-1
only.

I know that the intel driver works with LG Ultrafine display in native
5k support after 5.9 kernel. It's the same display that in iMac. But
connected over one TB3 (2 DP 1.2 too).
I checked last ubuntu 21.04 and fedora 34. Max 4k too.

I don't know how to check where the problem is. In DRM or amdgpu? Or
does Apple use non-typical controller and need to activate a second
connect over i2c or another bus?

edid1.bin base64
AP///////wAGEDKuFsR5ABYdAQS1PCJ4IghBrlJBsyYOUFQAAAABAQEBAQEBAQEBAQEBAQEBxbw=
AoKBAUrAwIDoAK1ARAAAaj3oAoIAAQpAwIDoAK1ARAAAaAAAA/ABpTWFjCiAgICAgICAgAAAA/w=
AwMjA2MDkzMTZDNDM5ASdwE3kDABIAFoIQAAD/CT8LAAAAAABBUFAzrhbEea0DADxM0AAE/w6fA=
C+AHwBvCD0AAgAEAMyRAAR/DJ8AL4AfAAcHMwACAAQAVV4ABP8JnwAvgB8AnwUoAAIABAB/gRj6=
EAABAQASdjH8ePv/AhCIYtP6+Pj+//8AAAAAAABykA=3D=3D

edid2.bin base64
AP///////wAGEDKuFsR5ABYdAQS1PCJ4IghBrlJBsyYOUFQAAAABAQEBAQEBAQEBAQEBAQEBxbw=
AoKBAUrAwIDoAK1ARAAAaj3oAoIAAQpAwIDoAK1ARAAAaAAAA/ABpTWFjCiAgICAgICAgAAAA/w=
AwMjA2MDkzMTZDNDM5ASdwE3kDABIAFoAQEAD/CT8LAAAAAABBUFAzrhbEea0AAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACVkA=3D=3D
