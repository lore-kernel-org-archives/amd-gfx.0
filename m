Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFBDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 22:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9575510E05B;
	Tue, 12 Apr 2022 22:13:54 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850D610E05B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 22:13:53 +0000 (UTC)
Received: by mail-io1-xd2e.google.com with SMTP id b16so23913581ioz.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=biD1APRJUJQI+50hu3pqhOP+ztS2Vf3EqV6SzkS1kGM=;
 b=dlr95n30SPztVrPSeSKwQMTKUmLd+1TO5BGUorQy82Jc94MP+2595Ol7z9dX+uthmV
 EZpCE3WGyisq/eIjhPJROwOqjX1iOeLTUGs0roM9FUCvehWSi0FUUyohIXxtduaZznGl
 MQlTAOdwCj2t94YspPv3sUkOtMJA/3gbPaCbvbbsfu//lQtp2Dp7pt44LuAyJid2hGNo
 aei50qNbFGmnqTDZkLXCQbjgXlWxYxPEDyLniNDsJ2XFjD4BHfGbz/LaTwn3nQke9hCb
 HSdV93TOUBR2CMRsSY7cV+K8KvnhVfaKtc+OLLw4+v7Ei+KaRH26YOHLER369vWSLJPJ
 U2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=biD1APRJUJQI+50hu3pqhOP+ztS2Vf3EqV6SzkS1kGM=;
 b=jtGdJGG2hm1y3+ykLThcQ7e6m4EbVHIdPTekqcMIdlYMpgcoMfU0nPcWhTXo+bgIdX
 2jmyjyOeNb1DU2qtxV/eo6AdRXGNPDmumdJMzI6tjg6YBFTp71TLXaed19LIzEl1AcCS
 N7bfkom3S7M1P0T0SX4gjcQiExPQLTSPx4Mr10sqRmE8Q30IASnXRa+y/6tVxpfGyitZ
 yeDoyWtQthR3J2YhD9xDalobHX314vlZMrXN7X60CqUGmjzhA7yndlCVIqpj9acBlZRl
 Wa070iRTZAGjcvaMzrHPcMyqKmhB9NcurhPBeICE4Lws/7UXP3z98PAIEfsp6PSFSrZX
 0gaA==
X-Gm-Message-State: AOAM532t8CkDa+MqCRzh8dU5zphfVuklGw/sqHYu0KvfHtx4LHSXRNVz
 usgeMaHHtfHWUQqsKxHoJmbB5c0hDE0c9uziB9BUoUNo
X-Google-Smtp-Source: ABdhPJwtbviuwflLLSYH11U3LxBtDHjoDLIYbvUTyRJ68JLJ8KJlvvYL8qBqXpcT71j+brSddFlPwEY+UpxnZ+KzvtA=
X-Received: by 2002:a05:6638:12c7:b0:326:3439:f321 with SMTP id
 v7-20020a05663812c700b003263439f321mr5196139jas.54.1649801632648; Tue, 12 Apr
 2022 15:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMvbhF-mcZd+mfSUVpYShvKmFiQ6pb+j2eosBr-kvsxE+202g@mail.gmail.com>
 <fae30821-f0b8-440a-a0d1-4c2a7d37ec07@molgen.mpg.de>
In-Reply-To: <fae30821-f0b8-440a-a0d1-4c2a7d37ec07@molgen.mpg.de>
From: James Dutton <james.dutton@gmail.com>
Date: Tue, 12 Apr 2022 23:13:16 +0100
Message-ID: <CAAMvbhFcD_YuoZEM+LyY6Yga9foR5mUBqPZP9TPpto5o4EGo1Q@mail.gmail.com>
Subject: Re: Vega 56 failing to process EDID from VR Headset
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 12 Apr 2022 at 07:13, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Am 11.04.22 um 23:39 schrieb James Dutton:
> So, did you do any changes to Linux? Why do you think the EDID is at faul=
t?
>
> [=E2=80=A6]
>
> I suggest to analyze, why `No DP link bandwidth` is logged. The macro is
> `DC_NO_DP_LINK_BANDWIDTH`, and you should first check why
> `dp_validate_mode_timing()` in
> `drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c` returns false.
>
>
> Kind regards,
>
> Paul
>
>
> PS: Using the issue tracker [1] might make it easier to keep track of
> this problem, and also to attach all the necessary information.
>
>
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/

Hi,

I will do some more investigation. In addition to it not processing
the EDID particularly well...
Since my email, I have found out that it is failing to complete CR
(Clock Recovery) on Link 0,2, but it works on 1,3 at HBR2. All 4 Links
work at HBR1.   (I need the HBR2 working)
The CR negotiation in the code looks a bit wrong to me, so I will look
into that a bit more.
Looking at the current amdgpu source code   (I am using Mainline
kernel version 5.17.1), it appears to retry CR negotiation, but each
time it uses the same settings, rather than try different driver
parameters, as recommended in the DP standards and compliance test
documents.
My understanding is that it is supposed to start low, and then
gradually increases the driven levels until it gets CR.
Another aspect of the driver that I think could be improved could be
it keeping link state of the various interfaces separate.
1) Link up/down status on the signalling channel, where it gets EDID from.
2) Link up/down status on each of data Link 0,1,2,3.  And what speeds
have been tested and work on each data Link, and what the "sink"
advertises as available.
At the moment, if anything goes wrong, it forgets all the information
it has and makes the kernel think it is disconnected. That makes it a
little difficult to diagnose where the problem is.
On other systems I have worked on, it has been useful to have the
EDID, even if the data links are all down.

Once I know more, I will put all the info in the issue track, as you sugges=
t.

Kind Regards

James
