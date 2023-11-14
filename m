Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8F6C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 10:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7C710E1F6;
	Tue, 14 Nov 2023 10:55:51 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A5410E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 10:55:50 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6708d2df1a3so7605626d6.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 02:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699959349; x=1700564149; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iz/8sUCEjt69vJ4XCsLR7jS+dcEmOCYO3kX5c/nwzcc=;
 b=mY40aDnfeAlhRVM9vXKKAZ2AtagI9DSNmo4Hh3GVl+UOH9byC/x4W2P3FT6Eypo/+F
 j2TJAM6iBEWGNrUGy/rhzh/tGlzu/OCvh8d9+P5g8tkjs7M8lu/3tW+3hWsPkMnqFch/
 g1v0YhfPFEdBd+NsYCBgxF+hSXx/tl6xR5jwaoNDsJwN3PEHCOy7NjFmtrbsAfPjVSEQ
 i6H14y61oMI/ThWjcmWcT7diN0FEHTs6B0dG9R1t5j0ax0wQuhERLH/iCAhUqCGPAnhI
 nHEZ/5RbeYQFjc0YJgbqWGjrAx34qPsPrYE7a6jAGoMzzywOdoPpxVu/2jX/9SrOcoRh
 JpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699959349; x=1700564149;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iz/8sUCEjt69vJ4XCsLR7jS+dcEmOCYO3kX5c/nwzcc=;
 b=xS5yqpoBiPJbxJpuWWSApzFiSuFgmZWivpwEpDA0LVFh5wGg9XAS8wzlAeN9z70OCK
 4ezD3HmWusvuUIvKhhcrTueWici1jQc41fFWjI4ep+8DBXJPi3BYjxRSXgEXETyRBDmr
 VluEmN2GZi430g0GM5Opkazt+vqXa0jqKStA0aIK8rMPe9AAZtig43y+8r0ApvhVTuIx
 xhA9kE9ecwnFo+I0/lpX8VqXPoTW+wafaXDZqBp2JC9z0qDVHBEpmojcdriA72WW7BM0
 SSBrejVWh4C4r/5MQmi/Ree8z3MpNtBF+2qHDxUJq5jpnGSbLmDJNX99vxPY1GK2gl4z
 cbyw==
X-Gm-Message-State: AOJu0Yy/eAM9r8eX3Af0drvRoS+obeQYcUhpa2VDDaayJrtb2ojJA98b
 M3JA2yR2iW3/FS2SJlEsunlP86lkt/NE3vg1FXs=
X-Google-Smtp-Source: AGHT+IG7ap8IuRRxIfvqMo1zHHQzkuGEMlwEuAGQI+uH+u//FH8jud6DRfHdd8gd40Zrpjl6T2q9as8IxpGZhmdEVVA=
X-Received: by 2002:a0c:e80d:0:b0:66d:6111:5c5f with SMTP id
 y13-20020a0ce80d000000b0066d61115c5fmr1838674qvn.2.1699959348918; Tue, 14 Nov
 2023 02:55:48 -0800 (PST)
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 14 Nov 2023 15:55:38 +0500
Message-ID: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
Subject: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: alvin.lee2@amd.com, hersenxs.wu@amd.com, daniel.wheeler@amd.com, 
 "Deucher, Alexander" <alexander.deucher@amd.com>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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
Yesterday came the 6.7-rc1 kernel.
And surprisingly it turned out it is not working with my LG C3.
I use this OLED TV as my primary monitor.
After login to GNOME I see a horizontal flashing bar with a picture of
the desktop background on white screen.
Demonstration: https://youtu.be/7F76VfRkrVo

I made a bisection.
And bisect said that the first bad commit is:
commit ed6e2782e9747508888f671e1101250bb19045be
Author: Alvin Lee <alvin.lee2@amd.com>
Date:   Mon Oct 23 14:33:16 2023 -0400

    drm/amd/display: For cursor P-State allow for SubVP

    [Description]
    - Similar to FPO, SubVP should also force cursor P-State
      allow instead of relying on natural assertion
    - Implement code path to force and unforce cursor P-State
      allow for SubVP

    Reviewed-by: Samson Tam <samson.tam@amd.com>
    Acked-by: Hersen Wu <hersenxs.wu@amd.com>
    Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
    Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

My hardware specs: https://linux-hardware.org/?probe=1c989dab38

-- 
Best Regards,
Mike Gavrilov.
