Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9807BCA5FFF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 18:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B83210E47E;
	Tue,  6 Oct 2026 18:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EAxl3gaf";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC1510E47E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 18:34:00 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48b0946c2c2so724679f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Oct 2026 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791311638; x=1791916438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2oj+WguNl9nEHHeid+2xTd3Rz4Ht7n2i6dJDD8jVrjQ=;
 b=EAxl3gaf2/IamsO4s/X5toYv+ZM8OQ7Ib/vSYf1jYIOas2QhJKCjDY0sPctLQbmpd8
 yh7R+Rsi7B3ifIlS16rUAn6V+3S9I/NzS5BMroR0VjQaLB0yAMLfmGO+hQH+yhdGkf9S
 bheoL3ORVniKr23gtRcTGW4vvTqNa5SCSbxGXF/z45mRgFPLP9igDXi5nWXbi6jUpNEH
 SCDdnSNulMQzeXOXxZNFzhlDdtZvTpsUffiYjrkfy5DaOoAJkbpAENWhEmyaFf4p7+ha
 TjofEl0XE6Jxh1bswBvPbsjvAsMMIBflHPVqlAY7yop85SNvlVwbDqjGMkoOwjYFeLhr
 aMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791311638; x=1791916438;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2oj+WguNl9nEHHeid+2xTd3Rz4Ht7n2i6dJDD8jVrjQ=;
 b=1iMrEW4EGXNc0fD+4/feCGO69QAzCBC4afTzEEdsxIxle9d29YFWD5elX94VUnk2lD
 gcatotOsRQz3lRYHiVDYhMhhU7Bknw0r94Nkc4atFj2hUau/HPks+stNFd97d6F9nxNe
 yASUsXW67Atlbk4dCjETt1f9MM4GqV718lNXLChtoXB/+AcdVKhCjAXmFLQjCFd7UNxw
 Yr02HM1QQByVOk0rdNOeU6uDflrPbdwwfyn33v+iY5gmvu9WM8X6Fkj1scTPWnr7OIit
 PaQWjHpoCkKq+06VIup6wTIYUaI+G0j7PVo20lx6gAvS12K/iU1/TZE2N9sYl0D0cHh8
 y7zA==
X-Gm-Message-State: AFq9FYIi1WYGNdMdQCJoc1VXVG/NsVmiTLZOtCSeId7aG2nElhsjIQTI
 ioh+tsjtETazFOWZuWo0rhYG2mdX9Nu0gJ1SD6DqC1RX8Yx4Dy8aFQrnWmH1kA==
X-Gm-Gg: AYBFou36JsXu4LjxTkkmIaryWrZWlfhpdqgYSgnc+I8VfNCS7zOC7ukDJHgSziIdqBT
 48X0bWhcfo5NK+7wEyVhA43AQ7Jwqqdlf5nVa+A8erCR+dF1xcY+xFdP1pna0kf+E0kNSByGY23
 pCBit14uR4qC8i9AXcnwwrI935Xg1vun1mYcXp3d5LriYVYCrpHnuhATtfFpMtAn82n1fMM4P7L
 BjwO7CCga7ckjvwnrLwi0LOHhP69c4yhCEJko9g28wX6Lt5psE0qVpyki+UicfzcGlKyG613Yjk
 N1G56AwBqhm9gNrooa2cnrvABSAorW8nOetVV8PuHPsVIooGQKOw6QBXFZjtK/l5qdw/YR32rVq
 fcTAzqZx8aoazeXNeSrNsuodTlsW34Jvx2A97r9dRJwMcwHep3syqTJMlcA+9l/W3BcU8Ksm24W
 UyOCgJqoMt2dIPoNTtX2HnYCVTQVsMTiCzpMyIg4PttUR5gRCaCSebSOsD6rLCDO+ohkdDUZOcZ
 DrC4y24E3WBK5s14M4fGzI2BKER/wZdsJBa2X9T/NEozA0FooRrZQzcIND3CspCRM0NGmVQGzVX
 nVEm9ksTnCJNZpOIEqHnlflusNIDMrj1o7GtwISivQ7QecZXS0iimCt5w2vbTPZ71vfASGGm96A
 7gND4bBvgTDI1eHv8JgvPuix7AzZ5uNsxXsdHmV2TPZSY8z5CNAm7nL7ZWVEyBZOimmCaE5CouO
 6SrWdV48ee1R8YHgRuL4r1cQjL
X-Received: by 2002:a05:6000:25c2:b0:488:79d6:a4a6 with SMTP id
 ffacd0b85a97d-48c726f17ebmr614618f8f.8.1791311638369; 
 Tue, 06 Oct 2026 11:33:58 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:41ef:ba36:bd76:1e3c:1e5:c273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1f3f7sm932249f8f.32.2026.10.06.11.33.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 11:33:58 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: stop userptr restore retries on device
 unplug
Date: Tue,  6 Oct 2026 20:33:56 +0200
Message-ID: <20261006183356.68286-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9ab809e9-03b1-4168-8ca0-978697a32b29@amd.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Felix,

The worker is only canceled when the last compute VM is destroyed in
amdgpu_amdkfd_gpuvm_destroy_cb() — i.e., late in process exit. On
surprise removal that window is unbounded: in my repro the SIGBUS
exit path deadlocked in SVM migration (patch 3/3 in the v3 resend),
so process termination never reached the destroy callback. The worker
kept rescheduling at 1ms delay, ~11k cycles, taking process_info->lock
and notifier_lock each round until the system soft-locked up.

There's also a self-reschedule race with cancel_delayed_work_sync():
if the handler is running when the cancel executes, it re-arms itself
at the bottom of the function after cancel returns — then
process_info is freed right after cancel_delayed_work_sync() in
destroy_cb, leaving a pending delayed work on freed memory. The retry
loop needs a stop condition; returning -ENODEV on a gone device is it,
and it also avoids retrying validation that can never succeed again.

Transient errors still reschedule as before.

Olivier
