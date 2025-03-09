Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74BCC2BA1B
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 16:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6497110E318;
	Sun,  9 Mar 2025 16:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A2m7Nlp8";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D1310E278
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 16:49:11 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7c0848d475cso437695085a.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Mar 2025 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741538950; x=1742143750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CjZJh4N2f/YdMDVNEYTaNvmTANsJ57QyiYoShKJ6UM8=;
 b=A2m7Nlp82BuNnVke6QJZKHohjcOs3vEs/N0D/COtQd+znxdbs2xrX/7Y5KtbXDuOE5
 8AHkMrvFnlokdHPmEGdD+fRrttRsEYCTsK4yIzhDIyiFgSfCBAHK6zGTGnlvyv0IsdqV
 BfopsDRt8LqQttaXeJPKIYi88EriwZHQNr50Mx9bfI0Gh/RcKMwRFl1cO+BG6yH1dRA7
 DBYHpbvSVFKs/5oygwPDD09vz5SRWKjpkrNfKZp7oXpjxttnohB5crJRlQApaZ48quVy
 VtoNBMt2NHhm9yhSZJ2I4PpX+3Ex05+LTp3mB3DI4KD6vRWAXk1b78VsWpMRgicLaaTB
 deQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741538950; x=1742143750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CjZJh4N2f/YdMDVNEYTaNvmTANsJ57QyiYoShKJ6UM8=;
 b=DqpvOGuPECbg/sBPAZqGcpTIZ9suipkPV7JhXG3xJxhK1E7nKk7+AwoMFKcQcgX29i
 239o9i2nzaNqZRHg8B9RlgzfCp05fX7ILO2rTB7kVXwdAubBlMg8UOTEUhl49jD+F58s
 ukpe+sliX05BXHiiVKpwDjeAmO25mwmghJYhEzrxnawG8cR7F8J19q0ZAeUmz07FA1Yc
 sw95Q/f5EtEpvwywJ48Bf20znG2UiAgbJQN7NY1xM9xSBQBsxqJivz8XhtmQIW1UpQeC
 nE16GbfEe0zrQGNUHp0/GWweZsqLsorvG/8uoGNal0P/zjENN4Zf60iu+ewTbJ9GoYsJ
 kVXg==
X-Gm-Message-State: AOJu0YyzviFNDAUliZBk844MNSfuiWsQSgHodo6ImQ3TpgVIAOznAF7Y
 AHRxSFtJ0feMMItnlav39kWWP8Yjyix9uan+nk1yPz6ihxoGSkbV82MVnw==
X-Gm-Gg: ASbGncvgwVGQSt9leZlhVhcWL1Ek7EMeE4lyjmK3Mod+lcFqx07mI0nwIs7ATqyOeDJ
 3bUaNYRRaMGyb+4fODCXZTqtJ+1pfmz0Ca0UcfyXW2UfQ98Xtio917DiMxR3U2DXFGTZFBTsaHH
 sBoDWs7saRmGM5MC0qVFFxEFu/9VRBhFv2RY60kjEc9uHWYKNOyqyImdL+h5tascPymknpyTSLW
 WhekyNwwtHd1S5rlt3nBzTo+HNEQzQBnPYW2HM6JWvlAyRr/5RePh7f1l3U4iDn5s1USPTKaPlq
 KcqEupxQLSLNBlnUdmVSI+7H+gIURJJtvP/zVG75Avgwf/BlbBfldPbq6xdDO2o8Jig=
X-Google-Smtp-Source: AGHT+IF99pTWnZjT6cnorpHnJM3MYqD/dhz4HfyYi6UXOqkGihzHZYKxK4/Gvrh7YpZaTYt5G1azjQ==
X-Received: by 2002:a05:620a:618f:b0:7c3:d3c1:a8f4 with SMTP id
 af79cd13be357-7c4e1678b92mr1896953985a.8.1741538949729; 
 Sun, 09 Mar 2025 09:49:09 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c53e2ff59bsm236996385a.1.2025.03.09.09.49.09
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 09:49:09 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 0/3] Uniformize defines between DCE6, DCE8 and DCE10
Date: Sun,  9 Mar 2025 12:48:49 -0400
Message-ID: <20250309164852.3936628-1-alexandre.f.demers@gmail.com>
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

Keep a uniform way of where and how variables are defined between
DCE6, DCE8 and DCE10. It is easier to understand the code, their
similarities and their modifications.

Since sid.h is being wired up in dce_v6_0.c, duplicated defines need to be
cleaned up in sid.h and si_enums.h.

V4:
* Reorder patches so each one compiles properly.
* Remove drm-amdgpu-add-defines-for-pin_offsets-in-DCE8.patch since it was 
already approved and applied.

A bigger round of cleanup is coming to remove more of the duplicated and
unused defines found in sid.h and si_enums.h and continue the uniformization.

Alexandre Demers (3):
  drm/amdgpu: fix warning and errors caused by duplicated defines in
    sid.h
  drm/amdgpu: move and fix X_GB_ADDR_CONFIG_GOLDEN values
  drm/amdgpu: add or move defines for DCE6 in sid.h

 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c |  73 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c |  15 +-
 drivers/gpu/drm/amd/amdgpu/si.c       |  68 ++---
 drivers/gpu/drm/amd/amdgpu/si_enums.h |  12 -
 drivers/gpu/drm/amd/amdgpu/sid.h      | 369 ++------------------------
 5 files changed, 111 insertions(+), 426 deletions(-)

-- 
2.48.1

