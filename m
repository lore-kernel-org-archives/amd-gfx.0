Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7330DC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 16:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD066E55C;
	Tue, 30 Nov 2021 16:13:33 +0000 (UTC)
X-Greylist: delayed 491 seconds by postgrey-1.36 at gabe;
 Tue, 30 Nov 2021 11:26:52 UTC
Received: from mta-p5.oit.umn.edu (mta-p5.oit.umn.edu [134.84.196.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6016E92F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 11:26:52 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3KgH5r1kz9w947
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 11:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hby5dTNLYcvE for <amd-gfx@lists.freedesktop.org>;
 Tue, 30 Nov 2021 05:26:51 -0600 (CST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3KgH3hMwz9w93x
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 05:26:51 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3KgH3hMwz9w93x
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3KgH3hMwz9w93x
Received: by mail-pg1-f197.google.com with SMTP id
 j3-20020a634a43000000b00325af3ab5f0so522016pgl.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3QROn8xzZY5bJQeJKBLAiXubvRrrPIxieLpkOUMaXcE=;
 b=hW6nGoGSxckS70Hoizh/DTWhmgdqH+fBhKMxpz15VCdZhqHT2SAS9uhDQNkz4wPgAZ
 12AgQnCi+Rs3Caq8v9un7bm6FUc1s124Id/h4afEKkF2EXjLDfx7D3dVTGUF2O+0gMTw
 3BJvFJOIUoa0yty2Gkt7NbgFEjyuOG5BJo3ZRnTWbUIBskhX6i+yqa5B4cHa4naZuqQg
 7tqTq/ztPRWVQLXBgLV4/CESiPlBiJoTfGTGWtHUKUGaVbvgOBNUVHxZv6MurZDEVhbZ
 hqolUaLtsd2AqHUwwyTw6vGIKwNAWVw3xRYcopOLx4W02PCKa6KqSte/xs3sqSYv5mXX
 N04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3QROn8xzZY5bJQeJKBLAiXubvRrrPIxieLpkOUMaXcE=;
 b=AJXfUER28/94v5hOiwiFH5eP0rk8fpG7EGTak0TN8d5pOZ9ts0DBxEHYrqYKz1nQCL
 KxZVz+AVPBNnAaV27NyP5FVEgFAcP1NgZgTgMaUxawBGIW/Ikzfk/2g86GrYx/pNx8qJ
 qLVyLdJoGNDH20lJ/DhH78/Mn4mixnSy2QJwX/dMUdyOQwVdBzrYQte6NQBVE8pdBXE5
 WcoIPOJzl27vh2/6G5maODaofGSyn80m9/vbARiinJNXAckiv8cuB+P7r43tkn/HE6lK
 rS2FKVBN3xQG8oV+MgFG6LojLBeNvYYEpd/z5Pdeq3bBNimtAcffC0SbYkK93XyyUJA2
 vGXw==
X-Gm-Message-State: AOAM533bnWThJoRBJlOYXV8EHEeH2swoU8dQQs7h81NUtZB5uMG7HGH3
 jeVwdbP4Hm9pNfGICz5ltfNG9trWOaS/gwaF+tHhq1KCH5enoNzpcZKNjrkB6UU/V71yxdzOBob
 N+94QgcKZuVul5fnL3g1nxffL6gFB8A==
X-Received: by 2002:a17:90b:3b81:: with SMTP id
 pc1mr5255295pjb.67.1638271610810; 
 Tue, 30 Nov 2021 03:26:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWVJhRBFY+Fevp9s2G6MveEJWhzbOra69RrHQmmZrjviSt5HqStUqYwpwcdh4+JRC0nsIh0A==
X-Received: by 2002:a17:90b:3b81:: with SMTP id
 pc1mr5255269pjb.67.1638271610605; 
 Tue, 30 Nov 2021 03:26:50 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
 by smtp.gmail.com with ESMTPSA id q2sm14594661pfj.62.2021.11.30.03.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 03:26:50 -0800 (PST)
From: Zhou Qingyang <zhou1615@umn.edu>
To: zhou1615@umn.edu
Subject: [PATCH] drm/amdkfd: Fix a wild pointer dereference in svm_range_add()
Date: Tue, 30 Nov 2021 19:26:44 +0800
Message-Id: <20211130112644.116604-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Nov 2021 16:13:26 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kjlu@umn.edu, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In svm_range_add(), the return value of svm_range_new() is assigned
to prange and &prange->insert_list is used in list_add(). There is a
a dereference of &prange->insert_list in list_add(), which could lead
to a wild pointer dereference on failure of vm_range_new() if
CONFIG_DEBUG_LIST is unset in .config file.

Fix this bug by adding a check of prange.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_AMDGPU=m, CONFIG_HSA_AMD=y, and
CONFIG_HSA_AMD_SVM=y show no new warnings, and our static analyzer no
longer warns about this code.

Fixes: 42de677f7999 ("drm/amdkfd: register svm range")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 58b89b53ebe6..e40c2211901d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2940,6 +2940,9 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	if (left) {
 		prange = svm_range_new(svms, last - left + 1, last);
+		if (!prange)
+			return -ENOMEM;
+
 		list_add(&prange->insert_list, insert_list);
 		list_add(&prange->update_list, update_list);
 	}
-- 
2.25.1

