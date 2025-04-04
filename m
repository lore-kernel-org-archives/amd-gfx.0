Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D72C3601A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 05:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3BB10E2E9;
	Fri,  4 Apr 2025 05:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CTpb5/SP";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52AD10E276
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 05:22:41 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-476a720e806so15141971cf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Apr 2025 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743744159; x=1744348959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YCeNF+jA8AluU9Ef4ebwTTVGi562FccM7C0+ptJGKfg=;
 b=CTpb5/SPYxTU6/dD8aeACP85ETjaZba+bezYHXbnIgudEt0XGBAyWtdq+BT7Fn0snP
 12CRLVKL6R9vddyI9cKkAw5ZLjpF98QTKEkIcecfI9v5kh1TPFV+P921lHVQ+4ixUggr
 0jb1CXWMnANuIuTM0XfQx2W9YBTmTeuj/9f/z1nvNkBuToKKVesnpehOb59M7oP1acK7
 r9uUvufF2NMS4MfsFTRxgW2Aug92Q1peS/aw4TeW+sTll/0MksCqH2lLhOS1iwTapdYN
 qsDLdW1kZg3inNbD6i6v/ZFLkv3ThBWoeg8nnIFuxcccHBy96/niQLLVtuMKmXEepN5K
 n2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743744159; x=1744348959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YCeNF+jA8AluU9Ef4ebwTTVGi562FccM7C0+ptJGKfg=;
 b=OKDBsaogJyLdCkUv5QJfz1F2WIOX5AT9jhu4d/+IH+XryBWfvD8NHKU6s0hWSB0lsL
 UHcrHxXBC9dMYoD2dJ51JI8DZvMtFlOuQFUoso3ViNPYf8phtyftYzBeG41tekx6VGRF
 rPeflak20HEkVo9wCpaRkJyK70jtey2m0/lNQH+NtFg7jtmfsNJAkYGJGuV6S1lkHqCc
 sko6z+7TKfgjaWd8JpB3NQRzq7QEr0hGkHnZN1xpFcKZ3dE0pdYR7XWYO3G+1QhVpo4H
 ih4OV+k7U3uShC1J5xPl3BHhe8j9GspOTtAVM4hGog/XvFr1JtBdot2JQ0WaZTVpE15G
 BfrA==
X-Gm-Message-State: AOJu0YwZa+RFfranJZtwrpavtdWVsNtwK/Bgkad7vVh4kbn1u6eQxpQm
 VhWIuFERRc588DV+P+XyhgoolWGzKgP4TToLkaPJF1Rv1pWvQvA+cWcoBA==
X-Gm-Gg: ASbGncsYVTZhUQn0plkBUt9awKtyrjWPC53igFmblc0nbU8ghRIbUeXiv9waP6pG2CE
 f5cExCuXBqwpEKKEezoaCbsxN72ujtoeZ9pu2ryd495rZYvU3xCWKaRZAcGBy+wvu2QYLxjCD0G
 bqzV/AzXhd+MXXKvoY+JN1VIlLzWutkx99+qv/LypJ2JHBdAj7GTfIDERVFCi4ggMwu7cr6SkYn
 LJ9HcR0c7Twq5EYngaAO+O09RcGmmzWztEZCArnPgo6Lz+bTXPQFsrWnsK+XhOYhsnag6/KukHm
 2r5JVReS3BO+0dtevOZkEn/mludNS0eXqtvo5r2nShiibkWUOLN+oyr4q5TKm8vRUHLo
X-Google-Smtp-Source: AGHT+IEkVdsfvAiRUin7mp4C72av2f4APMxB77QRthFqfinrp1Kxny9F+pQjJ/p9jWBEquOVnq3KwQ==
X-Received: by 2002:a05:622a:1353:b0:472:133f:93ae with SMTP id
 d75a77b69052e-479249d6aa3mr27577111cf.48.1743744159609; 
 Thu, 03 Apr 2025 22:22:39 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4791b071b42sm17238651cf.27.2025.04.03.22.22.38
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:22:38 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] drm/amdgpu: typos and standardization
Date: Fri,  4 Apr 2025 01:22:20 -0400
Message-ID: <20250404052222.19955-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Typos were found in DCE, where hpd should have been used.

DCE6/8: standardize the "interrupt" vs "irq" usage in function names
with DCE10/11.

Alexandre Demers (2):
  drm/amdgpu: fix typos in DCEs
  drm/amdgpu: use "irq" in place of "interrupt" in DCE6/8 as in DCE10/11

 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  7 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 28 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 16 +++++------
 .../drm/amd/display/dc/link/link_factory.c    |  2 +-
 5 files changed, 28 insertions(+), 29 deletions(-)

-- 
2.49.0

