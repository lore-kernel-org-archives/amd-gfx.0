Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21AC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271CC20716
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C5617SlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271CC20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14F06EA76;
	Fri, 27 Mar 2020 20:24:51 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C73B6EA73
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 20:00:31 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id u4so12143560qkj.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D8fCTtzi21rJlCDdrk/Qt4mRhY2LRYMqkZWb9k+PBbA=;
 b=C5617SlJKHaltq+P4jD+zs0K+W3xo/qPxCOnByb/v3+uCZBo4Uw70HHcyTUH0tYvgz
 I3jOTCrtR/FJDnqCuavzCyNe/VlZQkUTvnkjJHzReUgOotK95HUP3J/V430Z3dS7ahya
 7DsUVJg0Y4hUIwJSJm9aa5WGBoU26QeTO7KzarIiEcINrKXaHeIR5eeAyLHzysBr0CNW
 1aLFndYPAFSe/4jeO3bxY0dFvAnB2I+5vAkgEzFVsUVZ/hEcYO8JE4iOKtbn1UNH0Vqb
 KWBPZ+lxf4V+NpQSm4AW7kbPjbRSj9R1jJBpuTahH41hQodlwY3ziH+JRit3oCbOXnLs
 sEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D8fCTtzi21rJlCDdrk/Qt4mRhY2LRYMqkZWb9k+PBbA=;
 b=Ttt60YUWZWKgAPXnaB1CF7ISWV/wDx57ezHwv3FPTxKv3DV0Yg9tifidXm18Ik0ckP
 Yf4CO9U/7vqcQqk6vHr34e2uQY8Yg0IZQgv4Syf6Bmuwlr1X7eeMwR5NRhbYhUKOr9MB
 q+Et3PaOI0j1qb6I0KsOzkckpOYx9Nw/JATOO06wHnVcmCm24wTOnBKMRI+78f+VYkvU
 HMjMj7MYR0VSccbA1e5QHDOW29LIEJ9JRohYeLjbigx96dECqaNoSmfXtPR52xOEzd1y
 r6DgEDbQCy/YfEnB4ICw4N3b2qMVRgtrV0HgY4vi+rLtZ+fszhXbCzVd0v1MM1UfIMP4
 coWw==
X-Gm-Message-State: ANhLgQ1roYUM6tFoqB3OYc5cKV2DGjjtQCiVU23kGwxMQrJq5XS7cJHr
 WdUG9PQXQGGLwsv/tuYkHNBFSA==
X-Google-Smtp-Source: ADFU+vvrgv81gk4o6ZONBv5TnpgQOQoDOlqWAan4RLn09G+ZQn+4gCIv3XDzhdy5FMhauUz+aYj37w==
X-Received: by 2002:ae9:ed45:: with SMTP id c66mr1018159qkg.488.1585339230457; 
 Fri, 27 Mar 2020 13:00:30 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id b189sm4414461qkc.104.2020.03.27.13.00.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 27 Mar 2020 13:00:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jHv9U-0007fN-Rs; Fri, 27 Mar 2020 17:00:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v3 hmm 0/9] Small hmm_range_fault() cleanups
Date: Fri, 27 Mar 2020 17:00:12 -0300
Message-Id: <20200327200021.29372-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Mar 2020 20:24:43 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jason Gunthorpe <jgg@mellanox.com>

This is v3 with some minor adjustments made.

We are at the end of the dev cycle, and as nothing major has come up I'll push
this toward linux-next to get some coverage and decide next week what goes
this cycle.

v3 changes:
 - Keep NEED_WRITE_FAULT and NEED_FAULT separate (CH)
 - Use CH's vesion of hmm_can_fault and drop the inline
v2: https://lore.kernel.org/r/20200324011457.2817-1-jgg@ziepe.ca
v1: https://lore.kernel.org/r/20200320164905.21722-1-jgg@ziepe.ca

Thanks to everyone who looked on this,
Jason

Jason Gunthorpe (9):
  mm/hmm: remove pgmap checking for devmap pages
  mm/hmm: return the fault type from hmm_pte_need_fault()
  mm/hmm: remove unused code and tidy comments
  mm/hmm: remove HMM_FAULT_SNAPSHOT
  mm/hmm: remove the CONFIG_TRANSPARENT_HUGEPAGE #ifdef
  mm/hmm: use device_private_entry_to_pfn()
  mm/hmm: do not unconditionally set pfns when returning EBUSY
  mm/hmm: do not set pfns when returning an error code
  mm/hmm: return error for non-vma snapshots

 Documentation/vm/hmm.rst                |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |   2 +-
 include/linux/hmm.h                     | 109 +--------
 mm/hmm.c                                | 307 +++++++++---------------
 5 files changed, 128 insertions(+), 304 deletions(-)

-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
