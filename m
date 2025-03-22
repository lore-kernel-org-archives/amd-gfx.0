Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC716C3600D
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA13410E861;
	Sat, 22 Mar 2025 01:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLDfD7bz";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83D310E851
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:19 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-477282401b3so7251421cf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608039; x=1743212839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r+ntlxxMNTGSq5NQ4L9rJUY9slXR3IlR/8T1faW0CeE=;
 b=cLDfD7bzGpAT7udNkl5Qk7XnAjr/8w72SiuvmpPGNd1oTLOGVkHYCzmy1Rpt6K6GMw
 ZtM3Ymmb4hlqPZdDqKTFJKR9z8E+qDdTNxyMEUV/ts/qCN5KsG5pbDb8pE2QMnCMrWWa
 pwcOsXTT25BXNw2Y9++dVS1EFp1d6qNXi1k3nQfgkqZC9c3W+LYxjtDeOzxCbTbMKw/b
 MIrAYKxWlxbro1Z93lq7k12qR2a7ssFum1D/w3xMOUpPZmgNJVMxkOtbPUstoWUeeSBM
 9IR2b72TS2sd0LL1GvoAEYi7GMR6HqKyYUCQvj38K/sUidWcUM6TxW7xPDWrJvIhJgvd
 NmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608039; x=1743212839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+ntlxxMNTGSq5NQ4L9rJUY9slXR3IlR/8T1faW0CeE=;
 b=qI1Wp4PltyxqwvauLogRJz8Zby1DkrFhDQu5vRBVIpUsinXpPoomowPFCPJA1n1SOs
 FOp4OT4kOWdcO/+DL7W5XQkr5Q5Uj5Ymh7VPxWgFDdbTkvgmtFnmg4dHZXRS468GxSTU
 Mw2QX1nnvMRuFRebNW2pt/lR+uCR6lVwdk6R2Pt8hqPVsvyVvqS/PEUvwZ2m/Q8aDqy5
 6E4MvQzJTyfPUOfEuFuOnkjLpNFf3EgZxZ9OADr40ylqSXqoj8NFaVlB6z5g15YXsFwF
 lm+w77ZGHceQ217x1oYTe6hMOKCdh/afwRjRGs4cFbOMNYt4FdnmC431PuWqz/92wv2x
 kgQw==
X-Gm-Message-State: AOJu0Yz0JhTo2P4NLZoN3XQv/c28GVDlbemuv3zW/XQDbjY4FfC2b1ry
 PdC2pt3pTm6JsCUaUk9wX/FnMCcFh42nWrGA5ZcZTzyb+zZJS8+2xfH+1Q==
X-Gm-Gg: ASbGncsWXtv+bTNLnzAkYMWtU8ZFCrN5fxd+VSuFlWcO65l4aeCYXid2iYJs8CXxC5u
 t6AIVnAEEj0jN5Ifq6UaXHf7bIl3nFWkPLFgnBSJLXXvdNbh2MjBXfLWM877ES8jvhRy9QvCNwZ
 ytx5ztUwg2pOycVElwJcxyESrm9RTB5co3VKFcr/BV0lZTMcqh1WAv3YXWfflK/o1WNB+Kvj+RN
 tJdgvbM4aysqdCyQuQB7JEBgNlX1Ber4hh7IdoldesqTqKBXNgVodk8+6KD3ti6iTh34eoE8R+e
 uIL6UzXP3liFGgpJ7wjK84Uafl0knzk6IuLyhFi8wPzKPzdPkLEx31NkBdhSNXutbNc=
X-Google-Smtp-Source: AGHT+IGPaXIjZDC0GI9iepX6njWwdVRwuN4tbFdsFgd48nXx5JOPjMM5NCTLJ13CpA4fyEe5WJKj9w==
X-Received: by 2002:a05:622a:5511:b0:476:8595:fa09 with SMTP id
 d75a77b69052e-4771de1584fmr84510771cf.40.1742608038686; 
 Fri, 21 Mar 2025 18:47:18 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.18
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:18 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/18] drm/amdgpu: add missing GFX6 defines
Date: Fri, 21 Mar 2025 21:46:51 -0400
Message-ID: <20250322014700.62356-10-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
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

They will be used later when switching away from sid.h/si_enums.h.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
index c75aee25619e..a1240dd430aa 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
@@ -1779,6 +1779,8 @@
 #define mmRLC_TTOP_D                                    0x3105
 #define mmRLC_CLEAR_STATE_RESTORE_BASE                  0x30C8
 #define mmRLC_PG_AO_CU_MASK                             0x310B
+#define	mmSPI_STATIC_THREAD_MGMT_1			0x2438
+#define	mmSPI_STATIC_THREAD_MGMT_2			0x2439
 #define mmSPI_STATIC_THREAD_MGMT_3                      0x243A
 
 #endif
-- 
2.48.1

