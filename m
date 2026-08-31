Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97091C624CF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 07:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6515E10EBB1;
	Tue,  1 Sep 2026 07:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ppBahKxx";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB13110E8C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 13:47:28 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-90cd1012479so35764616d6.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 06:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184048; cv=none;
 d=google.com; s=arc-20260327;
 b=ZpuOMFt1loFB7uxtyjg7uJ3TImvnc7QmEWVCEuznrds3s5+nIV1673F5eGjIwa/17u
 1Lx4/Ys3wDFS5EfKoI2E5VaDoqVb/wR7wZWVzpo0yuXplMZqaUtMa2Y3GM6k9EtmLgE2
 iSdNUxSjxwrewAAMTvb42glM5iwes4pgPQYLI6fQ3PhqQljfNQb2LswCzVWK5EJdKxh0
 iOy1/vYrKgMwI1MO5vE/uDpH2rAXODE60Z+4Wu3LSF0hk/kgf2wbdEUtEdydXj6aYhoH
 JeDCrWD+8+exjf50mdjTt927TavOxN/IQ+pBs0yv0Xg/zdsuQqFonhRavqqARSeOUU9O
 M5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=cFSV9KhWwH8UTBQ/C/MspQ/RwmMPKmn69329QrcNpjg=;
 fh=MDXE10nGoCDgvUSXMaMflaO6KszhysLuc71Ky5lF0Q0=;
 b=DPT+A2KXZJK+ZwOsED/3D8J8UeG1+C5KjoUzAzikFuMhMdQSHiFOPVFgtDFg/KuGkV
 ahMskvNmkLxNbN18Shx605I0Igm+JPOwHN6XzvJjn0RjpiTql7ijUfTfeNoisNUcoKVW
 OVGkZN/+VZM8OjLLCuif1TyjbsFlfCG5kq4duJHfjEZyZG9M3B0XAWayRexEQv/b6fh4
 t/xkHnzGu78oNMj5Bwp1P6an7Whnvbjd4QO+9tXQfaVKpCKbNr+G78rq3JV8l/swOKfR
 h1WcslHM8cTtM5jo4+T1xWEUz7XzfgHIxNtWx+OxnLe1KMBbuqX0Wq+1qBN/qLibaRdm
 fumQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788184048; x=1788788848; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cFSV9KhWwH8UTBQ/C/MspQ/RwmMPKmn69329QrcNpjg=;
 b=ppBahKxxYaHPHOlS5qfRbO5gdoHVTlwolbcnLhXFDwW0/GwNtAIZhTIn0IrSIRC6ag
 GYi8616Pz1KwEvY6gpa1hrMIMRqBVR9HWVsGMdvELCkZ20zy3c2yRCeTv1sBYznt7BgB
 xRK0RFgslDAX+JL4YEDxsw4MKUklBJD/zj/1WY1160z+/J2CbcfFpzcxfbnOp0yvmeqW
 TebvZp1m2k0oE+XUplpfEEaIPouRkJBohl0RHhnVdlhR5+MDrvUkreuLPLK8YsWjkSOm
 BDmxgoDorA7E/sfOKXL9euryKTn0KYtxhD2SGZLQdOYRK/BB0hV+efoOidG7iHVMeYfz
 5Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184048; x=1788788848;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cFSV9KhWwH8UTBQ/C/MspQ/RwmMPKmn69329QrcNpjg=;
 b=J+McPG8fp20UMFm//vEJyVSYwpGtHUlSHEC6d+lD2wITqBEvh9IcwMOrbxWzN/9u47
 VSqOCo/Q6sGWsgW7tcLAGxnS+hfyb8xLHtfTUArR/XKeSQuuH9wpX6rqWCEFt3rkwHDH
 ESW/YGVbAa2cO9m8T2W3quemQFRbdKDqF8h0T4gnTCSGk49ISYn5lYoPZaRoTKeDf/hJ
 p8CgQrX/iOeYtyaGjNn3oa89dd8Lp0qvRQnWrfehyIwKHXwlv+Ap+Ub/ReX41uKi6VH3
 uK+wixVPo8jFPqdgbbMe6ua7kNPH29SDomywzkwarWbe9herHa+YJW4m7KwjGzB36qAj
 Jnvg==
X-Gm-Message-State: AFuF++n/r2dxsp0EE7NzREZjX2R7A3v1Y0uO3rppCVY3h1RCqGSjRw/H
 kPJxNk80jJLs2nhcGpf7vcAvO+2R8wbyHww5h8eLmaoToclilcBSaIZONe+n/K3fZYSRM2bcsG5
 7XpoxPZZ1YTHqg68tMGndsogo30opntdegCo=
X-Gm-Gg: AR+sD10YYGu+EJm60s+eUylkKtzUGXYNTjT4feduj3Wo1s8iegD39LDN+Zjr7kEyVMt
 xdXSkiCsme+ILOazgPVdQ5Up8yelA1mXyt0ujwFn8PQMP66MEkcrYFnkou4zwR2la9AfeyGKQ38
 boI7lGeR52aSylrDAN8Fm/ZIzlRSihFJLnpD4zbCy8lqfYhp/yinedFJRHvL1O7h4he/zF79xny
 N3SU61TAX5TkTfs6UZejZOBbDzoQTikRCMuc+rV9hKsqBgeBNS9OMTAvHC97OtP7772FMwV1HH3
 hIZ87ClRaSl1Enraui3bXDeD0PclOH/qNff7E8gBdvqq
X-Received: by 2002:ad4:5c46:0:b0:8fe:57d4:69cd with SMTP id
 6a1803df08f44-90e87197c3amr94853606d6.14.1788184047385; Mon, 31 Aug 2026
 06:47:27 -0700 (PDT)
MIME-Version: 1.0
From: Robson Candido dos Santos Alves <robsonalves.us@gmail.com>
Date: Mon, 31 Aug 2026 10:46:50 -0300
X-Gm-Features: AcwNN1XiVRIDsV5MvmN1_ctjQnb_kUYK7ID-dXE41cp2gLJaxtcLOJ1RhzUegpg
Message-ID: <CANkdJ2VvJQSBzyOq=LgSW1=Z8-YiN_r9Py2iJ0UJDo55+dbfuA@mail.gmail.com>
Subject: [REGRESSION] amdgpu: "pixel format with alpha exposed but blend mode
 not setup" warnings introduced in v7.3-rc1
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:59:19 +0000
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

#regzbot introduced: v7.2.2..v7.3-rc1
#regzbot title: amdgpu: "pixel format with alpha exposed but blend
mode not setup" warnings on Renoir/Barcelo

Hi,

After updating from kernel v7.2.2 to v7.3-rc1, several DRM plane
warnings regarding unset blend modes for pixel formats with alpha
channels started appearing in dmesg during initialization.

Good Version:
- Kernel: 7.2.2-070202-generic
- Display Core: v3.2.384
- Result: Driver initializes cleanly without plane/blend mode warnings.

Bad Version:
- Kernel: 7.3.0-070300rc1-generic
- Display Core: v3.2.392
- Result: Driver emits the following warnings in dmesg:

[drm] [PLANE:44:plane-0] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:51:plane-1] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:58:plane-2] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:65:plane-3] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:99:plane-7] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:104:plane-8] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:109:plane-9] pixel format with alpha exposed but blend
mode not setup. Please fix.
[drm] [PLANE:114:plane-10] pixel format with alpha exposed but blend
mode not setup. Please fix.

Hardware / Environment:
- Hardware: AMD Renoir / Barcelo APU (DCN 2.1)
- CPU Scaling Driver: amd-pstate-epp
- Kernel cmdline: BOOT_IMAGE=/boot/vmlinuz-...
root=UUID=87f96fe9-4a93-4725-95bb-dd53087bb7a8 ro quiet splash
crashkernel=2G-4G:320M,4G-32G:512M,32G-64G:1024M,64G-128G:2048M,128G-:4096M

Let me know if further logs or tests are needed.

Best regards,
Robson
