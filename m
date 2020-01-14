Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA23C3F68F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 20:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACE824672
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 20:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEv+cDqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACE824672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B428189483;
	Tue, 14 Jan 2020 20:55:36 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F55D89483
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 20:55:36 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id o199so1931557ybc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 12:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BUYwUy2fDJyl5O/FssXYizN9RZrtlMGcja1+uO0rXSA=;
 b=NEv+cDqSYreP50KlOiF6+PWm8BytNU5kHs9Lkr5uu6HBtRnj5q7NVxlChzeuMmMHw/
 3v0YJ9lPqmdVil4i5JXOSndbMfjo8CnjvoN4+ERv2lhRlU4EZQY24iLiJcWwJtm67b/Q
 TLgSaqqQnsQkNdnwRikSGJaJ6TmGUENtM52XIsTN8B2kjtIwiGuWq6Keuz45H1oC4aCZ
 ctDv0lUAcx16uYj/BmWdy3yLsYBz9seyDxseG5fBCtN6dSUxnsWwogUVpW41rM/9h9xR
 dQ5tCZ9GmfDiO5C5yDg4tigYMdlEH+wZ+m7oOcqVx3zbjyOpR4jolZFIzAAR04geuod0
 eEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BUYwUy2fDJyl5O/FssXYizN9RZrtlMGcja1+uO0rXSA=;
 b=un18JJ2kz4MRceaAMo34b4TCul5KSwmisDHamPjx5REWGbwCXTfGPdPfUS7ZgDThMs
 AgtpsSB6AYG2UYig8UB0vo+CnGE7Nwj0p6fdghflCzoTMT9aqIMK+42jlG8guF1ncTLp
 vUHITghUeTjeIgvIn00a6HtUZ6aAfQcU09VazEYgmKD71zaPuv2qNLTQLBLYwNnImYtV
 IEU3GtjZe89vJoH3p6gJRAdcVFY2wqqMk2fvSNC1xUHRVq2WvFq/h7E5ezwltitCFiOH
 ydOK3Gyo6haWbx015q2uNZaXOLiK/R8dgi6NN1xyJ+Wu9Nj89dAKFzc2Gpkdz49ZT89n
 7UfQ==
X-Gm-Message-State: APjAAAV6aEcq7z5O+xQvBzuWZ0DNgsub2QfuyBELbrS9mlaYg5KtIREM
 n1+0pJ++uperw5lcvpw4jczHnPAc
X-Google-Smtp-Source: APXvYqzrUyqSx8KY0o1U9CC8mTy4P5AWzDm+eAk8T7g7Le2r3qHIWe+VbvZBYl3O/yvTwDMXNJ3eLw==
X-Received: by 2002:a5b:3c9:: with SMTP id t9mr13197020ybp.377.1579035335198; 
 Tue, 14 Jan 2020 12:55:35 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id a189sm7440521ywh.92.2020.01.14.12.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 12:55:34 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com
Subject: [PATCH 0/2] Adjust AMD GPU ATS quirks
Date: Tue, 14 Jan 2020 15:55:21 -0500
Message-Id: <20200114205523.1054271-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We've root caused the issue and clarified the quirk.
This also adds a new quirk for a new GPU.

Alex Deucher (2):
  pci: Clarify ATS quirk
  pci: add ATS quirk for navi14 board (v2)

 drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
