Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C3BC61DB3
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 14:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837FE10EA0C;
	Fri, 13 Jan 2023 14:46:59 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2744010E9E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 10:35:35 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id j15so13237539qtv.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 02:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JdhGsSNtB42R78tGFv7v51XKaGUteAw39I5vQ6mm8tA=;
 b=pk4zDETBFlnx+ZaXKUu55UHf5V7hkClTih//RmXz/OnQ3npj13bDIGyj+lhcoxiK26
 j7g8NNoVA7pTfF6TUL9+FBMg3nwuuc+W0kXax0xmGp0foXVovEBh/qFqyeVDMfVQLPc+
 992I2Vk5rHseIjYzVf97YED++cWt86IjewU0lEwS/deeqjsCQdAWVuG2pGMnFV7Lvbg1
 i9dMlka7eT/sjnEb6n+/ydj/+VIgmzXBcS7wfBq/LMKr115TEuD65R/LJPONnXQnAA1/
 0h8Ysycp2JPsHhmOvqDrhwXsTst5+H0dvZixB/3vdiylUxYpLuc9fWIgSLSrEU6tS00C
 SxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JdhGsSNtB42R78tGFv7v51XKaGUteAw39I5vQ6mm8tA=;
 b=KMz5h06JByBsXJ8uZnOPaOZtXiqLJPvvMJKBw3sk7ILeCOYHnjdqiCt0Cj870Ukowd
 OgWjSsZ4WB2zW8twC3w1+DPK3YPg4Nsy2E43zEFVQqkIIncaQnucu0EbiNnUOWokTHw6
 tGqMxe1BqNigQPCGQKpMENZPpuiyOobd9wsNCYYUGod7VOpd5LUwkIw3obU9llmapIZC
 H9tgtSHuYT3Z3+b4BQ9ANY8fvEh4rs3l1bXyf3gc5hP5EXy2DD+s4DOLxc7Wa94RJRQZ
 C8fVcpLcIR9ci+ZFV8Ksg0b1tOjpxVDxqu82cDRkxoa0D57cVuLTjc714FSMGjfIF9ny
 PRGA==
X-Gm-Message-State: AFqh2krcEB+0LCklVSMwC2lr6RwdieE9IVXZjulxSWI2qOwkk06pyxy4
 7b+uHKK9JxlxY4kTsIBgbcHb854U/QFqybmsHei8hjzPeyU=
X-Google-Smtp-Source: AMrXdXsrbU8CMPCo/9zTs5i39PfkwbCiWatHzvdyDB14YDrq1feE3sMbyJuktrNi/r7i2AmWtaIgwwZg/kbACxaFgKY=
X-Received: by 2002:ac8:720b:0:b0:3a5:2bad:57f3 with SMTP id
 a11-20020ac8720b000000b003a52bad57f3mr3781900qtp.189.1673606134055; Fri, 13
 Jan 2023 02:35:34 -0800 (PST)
MIME-Version: 1.0
From: Braiam <braiamp@gmail.com>
Date: Fri, 13 Jan 2023 06:35:22 -0400
Message-ID: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
Subject: Is "perfectly equal monitors" really required to reclock MCLK
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 13 Jan 2023 14:46:57 +0000
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

Hi,

I have two monitors with the current following configuration:

Screen 0: minimum 320 x 200, current 5120 x 1440, maximum 16384 x 16384
DisplayPort-0 connected primary 2560x1440+0+0 (normal left inverted
right x axis y axis) 597mm x 336mm
   2560x1440    164.83 +  59.95 + 120.05*   96.01    72.01    60.01
143.97   120.00    74.97
[snip]
DisplayPort-1 connected 2560x1440+2560+0 (normal left inverted right x
axis y axis) 597mm x 336mm
   2560x1440    165.00 +  59.95 + 120.06*   96.04    72.01    60.01
50.01    48.01   144.00   119.99    99.99
[snip]
HDMI-A-0 disconnected (normal left inverted right x axis y axis)
HDMI-A-1 disconnected (normal left inverted right x axis y axis)
DVI-D-0 disconnected (normal left inverted right x axis y axis)

The pp_profile_mode:

NUM        MODE_NAME     SCLK_UP_HYST   SCLK_DOWN_HYST
SCLK_ACTIVE_LEVEL     MCLK_UP_HYST   MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL
  0   BOOTUP_DEFAULT:        -                -                -
         -                -                -
  1 3D_FULL_SCREEN *:        0              100               30
        10               60               25
  2     POWER_SAVING:       10                0               30
         -                -                -
  3            VIDEO:        -                -                -
        10               16               31
  4               VR:        0               11               50
         0              100               10
  5          COMPUTE:        0                5               30
         -                -                -
  6           CUSTOM:        -                -                -
         -                -                -

I have set their refresh rate to 72.01 which is a mode equal for both,
and the MCLK wasn't downclocked either. They are branded HP and
Scepter. Using a vtty doesn't help either.

Is having the exact same monitor really required? If not, how can I
check what is causing
the memory clock to be pegged that high?

I'm using 6.0.0-6-amd64 from Debian testing.

-- 
Braiam
