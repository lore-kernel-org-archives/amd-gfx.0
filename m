Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959BDCCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 18:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378FE10E2F7;
	Wed,  5 Nov 2025 18:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="Y6w0eUao";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E5F10E2F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 18:05:04 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b70fb7b531cso15038466b.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Nov 2025 10:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1762365902;
 x=1762970702; darn=lists.freedesktop.org; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H17nkd4/iTUq7IHGcbDm3znHw/aVwhX+cPOmdeUStPg=;
 b=Y6w0eUaoU6iaHY9r50LK4MOxVYg/zIz51KoX6Py2RVDe1TBbJMZqU61ECTLlfVhP0b
 o6IVTUHjXX7DDm/HahuJxv5BJ0ZHsfjPkLhlklQ9bG49LRvDICZlTCdCnObGhRL45Aw1
 Q/UBbpw8X+d1V78lcQEsMULu936Kl3mZug1v0nD2l7EvMDeWQhnO2Lwy8lQrrba40xJm
 6ubWt64EkSziFeAsVZFiZLmCi9tGT68Cpedtp42dZXwS1XdRP7uDf9dF6ky+0d50a1kB
 E5gjFVMFSf3ebqsOs75xBzK5WLwJZtGrjJI9HF069Olg4pT8Auy9oW8t9iiquxaXnlke
 jDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762365902; x=1762970702;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H17nkd4/iTUq7IHGcbDm3znHw/aVwhX+cPOmdeUStPg=;
 b=v4u96y4KUnfto/VTFIquTmZ1uB5lv1U4NA0/8hWO00ozUIa1AsvYZFKvWZfE/R8X19
 5gzHcLq7pc+2JW+4VmNZaihZYrZ3nwYByS1+PYI9XopfPwAer0E2Z6/qy8L5FKH1QjR+
 g1umXTzol57bpGkP2SJx25qkOij6lkex0x4UkORXRy1Ql+YHw/s2UIlzTZdqOZ0BT7x4
 THzaCfJ2dWCoFPqdiM98e4oz9HVH0oGWyDnlA6jImhTY03sgdfDQquTCg+HoN+cg9u2f
 ++ymHsScYa3Q185fBK5z+8TK2nuzZiVjAnIf8IBdXhPBV1YS6WnGPQhE0oYeJrH8pQaT
 Gn3w==
X-Gm-Message-State: AOJu0YxvIx9CHwy8w41GcSxfTV8YysVB6H5/8fneNQydSk2ICEaa2fTH
 gStIojVxpq+R4+fFKtM4+gL4ckLykLm0/UScJB/CEWaF6+uTq5H/EzwqqDEBIuEKiR7fJIy0YMD
 OqxvqkAKq2Z4QAIZQIV/t2ZF2aBiZNZttplh7rnx7L1VYJBlOggCBWQbstg==
X-Gm-Gg: ASbGncuL68Oruco73M5kzEB/DnZ5t9ksZTymWjjoQWcP19H2CX6+oeR8Z/utlD6QMwh
 z3sb/75y0W1lEFXZkTaQYVEAJq1gttdd5BFcCqwrKCfhDbaocOcGGu+Ys5lTiB4teTtIT8f3sLD
 VBy274Qc8SxwrS1LqhAY2KxMLw732zGKPp/LoCQWoJBjy9P3iB/mja3Henk4/v8Q5NPZ11HVNF1
 unTzK5QiNmPXx8qFfy3NRaxeC1wLfx3RqCT4OPCUMBje5ZvmgaRvUBLZH3SSg==
X-Google-Smtp-Source: AGHT+IEk/ZDdEqisiI9rtGnPb42wfU6HrnAovh5bs+qZfHN3r4Gb+UQPybvvlJv9JH1vy7RCIpBzklzMJisJQPXHeDs=
X-Received: by 2002:a17:907:3d10:b0:b6d:6c8f:6af6 with SMTP id
 a640c23a62f3a-b7265297e84mr405868166b.16.1762365901745; Wed, 05 Nov 2025
 10:05:01 -0800 (PST)
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 5 Nov 2025 23:34:24 +0530
X-Gm-Features: AWmQ_bkjVhPC-r9Ovu__bj_xm6-x0D4mbVU5YCptTOLaffJ9_nRBwHr8rpgO3iw
Message-ID: <CAG=yYwnWgQWZTMpHJYJo0qwUL-7a0N-wRMWOAfMfGHg9H-Br=A@mail.gmail.com>
Subject: problem related to amdgpu driver in linux kernel
To: amd-gfx@lists.freedesktop.org
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

hello ,

my firmware files seems to be ok
6.16.3 is running  fine i think .
6.17.7  shows warnings  in dmesg
----------------------------x------------------x----------------
[   15.568702] amdgpu 0000:04:00.0: amdgpu: failed to load ucode
RLC_RESTORE_LIST_CNTL(0x29)
[   15.568706] amdgpu 0000:04:00.0: amdgpu: psp gfx command
LOAD_IP_FW(0x6) failed and response status is (0xFFFF300F)
[   15.569239] amdgpu 0000:04:00.0: amdgpu: failed to load ucode
RLC_RESTORE_LIST_GPM_MEM(0x2A)
[   15.569243] amdgpu 0000:04:00.0: amdgpu: psp gfx command
LOAD_IP_FW(0x6) failed and response status is (0xFFFF000F)
[   15.569878] amdgpu 0000:04:00.0: amdgpu: failed to load ucode
RLC_RESTORE_LIST_SRM_MEM(0x2B)
[   15.569882] amdgpu 0000:04:00.0: amdgpu: psp gfx command
LOAD_IP_FW(0x6) failed and response status is (0xFFFF000F)
--------------x---------------------------x------------------
please help :)




-- 
software engineer
rajagiri school of engineering and technology
