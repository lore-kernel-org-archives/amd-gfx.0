Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40944C19F32
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A24310EA2B;
	Thu, 27 Feb 2025 05:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bUP88+sm";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1DCC10EA2B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:22:58 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7c0b9f35dc7so74497185a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740633777; x=1741238577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=cw8CZmrlkeDJ6FTyh5f8c7Pb7H93Q2fumd1YwQbu2l4=;
 b=bUP88+smSttKE9kCoAXK8a30uGn1toktlsCBDTn6m268oepfrkiLwK/hfqcXrrwlDS
 lLtl0kjmHiKJUxXg1UXgQu8R5EvqxBQexGfo+cGCR6QnN40MU0mQMkxcJYnFt0pSEKA5
 pGVlvkhQXcxPQ/mdTgWJhLtfS5h8UKt/o62sbpcHQGdmRfTv4jCsBv2xVa1E6LIBvA2K
 y8KPy+xH4Ib5JFp9B3G/I1QabeEclcRMkeziloZxiIY7VtUArCes/0w6JAo8ZUbDxcHj
 uWAYdi+G9iMfBvbOAUkPFWiW3maeJV8EXzVWrE9MIoDOLfP/vzg/bfgghWrxi/51KNuL
 PfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740633777; x=1741238577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cw8CZmrlkeDJ6FTyh5f8c7Pb7H93Q2fumd1YwQbu2l4=;
 b=uX2BKmfgLGig6Z8gzkRFa/1CJ5ep3Vxlt1tJXof7fvfoEx5Dznf/2VasCl5InHG095
 izPK/WW1lQDVap7IsxyfOLtRYphA/Cf/mRK/RAZFa1LdOBxKeIoXgF5WuChRHnU+wwd9
 qcDctoXyOKzKFmWrfZIkvPS0jvvSDoTMo53vir+EtQZQJ5QrM6Fv/xkgbxY51FMo2mii
 veJJQWwQ0VJUJH1pTwALDxu8AcHzXlnvIUKbd7fYsqtYjFuWvWFIVHifIvknWr1vOxwA
 g2JXVJf6c47hvSAdLSHm9JhBb345r8bhH0khj1yN1UTR9aJcdZTit+Bz6gwaJuz3WIDv
 Wwmw==
X-Gm-Message-State: AOJu0YzRQokAQOK/zz2ZpfAOytd2TO+kjLHVRCdc2bfO0mxlKu8hQd70
 Ti2OCTzpiAVyYQUFxzHSQ4bJLmeNfae9Ra2cFmTiJANUKaxmV1gY9stgSw==
X-Gm-Gg: ASbGncs44RFi2t4c1+WuI/oCnleYaVcQGOGUXJqFOv+yxY+TG/hSSNkD11vdMyZ1jlf
 u25gzVGjBLms8W/qMoaX7NLs29iGRcfap/lqoMIzCjtO1UFvjxyd7Nna29Y91AE5ZsqacINtjQ/
 B7M5qejSROAnY25wYbiUKFkVE0uCMju7X5JwRQjTflGV9zdUA1j+8ImAQXimd/GwcYsir0QJUVb
 aJUJzwz0cCY7Xu+9xZervUUfa5gpvBws6FbqDPBjmtC3km0Eql9WYdTnyjCxArI5M4U6DX3Qw13
 C4d1izDlfD78AiUThJfuGIhp0yPdSCd+QIoGYUDOcQaYcfzy
X-Google-Smtp-Source: AGHT+IEeXnEZ/I23YlYLgQV1XCW50/Aj56jdDzTg0zdiwNmI3qhwYmlZXl/AAlmy2kyQxZQQlPiSJQ==
X-Received: by 2002:a05:620a:2491:b0:7c0:7d34:6a7b with SMTP id
 af79cd13be357-7c247f2540emr696835185a.19.1740633777224; 
 Wed, 26 Feb 2025 21:22:57 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378dab64asm65670085a.100.2025.02.26.21.22.56
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:22:56 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/6] add missing DCE6 functions and uniformize value
 definitions
Date: Thu, 27 Feb 2025 00:22:35 -0500
Message-ID: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
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

This series uniformizes some value definitions between DCE6, 8 and 10.
It also adds missing code for dce_v6_0_soft_reset() and dce_v6_0_set_crtc_vline_interrupt_state()

Alexandre Demers (6):
  drm/amdgpu: add or move defines for DCE6 in sid.h
  drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
  drm/amdgpu: complete dce_v6_0_set_crtc_vline_interrupt_state() in DCE6
  drm/amdgpu: add some comments in DCE6
  dmr/amdgpu: fix style in DCE6
  drm/amdgpu: add defines for pin_offsets in DCE8

 drivers/gpu/drm/amd/amdgpu/cikd.h     |   9 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 201 ++++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c |  14 +-
 drivers/gpu/drm/amd/amdgpu/si_enums.h |   7 -
 drivers/gpu/drm/amd/amdgpu/sid.h      |  29 +++-
 5 files changed, 193 insertions(+), 67 deletions(-)

-- 
2.48.1

