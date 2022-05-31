Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E329C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 10:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5213B10FBD2;
	Tue, 31 May 2022 10:00:19 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBEA1125BA;
 Tue, 31 May 2022 10:00:16 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id er5so16781521edb.12;
 Tue, 31 May 2022 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mIxGnBiNQH7wWhpTAOYvfGm3yBUdW2Lv8hSFkOKs0aA=;
 b=YDb0d+PyOKs210qCqYAFGBvUZTTS4RAIRhhK/d+QO9gshGdaDWgKspQVMQpG7nrtX+
 TufVc/6A+Te4bjWf9pWyv6ntrZjNTvO1o8tYpzOoAdjIqo9Bklfzy8dXk7BYMrxpSM95
 usfHUfKLh7JEKoG9wN5zLAoQm71wvfUxu+xCGMzIBHPjTBYFFRg/fQ8Bc1mbpWvV9bwY
 PR/pdpoW3OmlfWODJKjL9jIEkGs8hD/ZjjXmxLFGR2b/njvlb082VeR+rrGF1R55oj4p
 qQAdYumTKMLx79UKpj8YkktDQvBcFKlZvP9zcVhZ48lAtSdY31sMnKI1F4yE0kXKaL3w
 HsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mIxGnBiNQH7wWhpTAOYvfGm3yBUdW2Lv8hSFkOKs0aA=;
 b=E6Ly/q9pmfLfRSpxIAZwv6RnhgtaULYgilfobcOkc7xFKm3O/E6HDDaeoKLESg74xq
 EqyPrRg7LFClG6gxJ0CqR2vyIIRoXyE6vYvFmn6pQEq85SDqfRUdABGAA9w4pI5hSRdx
 M+Y9aVelHxyvggKcGRZZFCcoQobClr420wiBEIUenfcRSTP6G2ELXfDenTO3sdvtmp5P
 R4vKAn81zPcveGIUGevXQI2kvdn159DBpcXsw3Qwoi271RK49xcmXdZFLmFkyKCf7HE7
 6R19uqAbhhnZihA6ziE7RUaicjDwbLElH0deMkFgGZIU6BPURL3mZ/JjpnJY+nUy0Z04
 tKLQ==
X-Gm-Message-State: AOAM530i/2VoVPnd9akdTuxjdQ8kM1Pekt6B8NwXM0AM51HBmsqHWA9Q
 pEo3YinuJ2RVwW0xiPzMnnQuEvniAbhKMA==
X-Google-Smtp-Source: ABdhPJym6XbAZzn9cN4OBs65hCeI931sSsPopVK1yV+b7qr9DjRRmdjRD8OGAyhyWkR+LhQlwkaGRQ==
X-Received: by 2002:a50:8754:0:b0:42d:e92f:c924 with SMTP id
 20-20020a508754000000b0042de92fc924mr902302edv.389.1653991214818; 
 Tue, 31 May 2022 03:00:14 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 May 2022 03:00:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Date: Tue, 31 May 2022 11:59:57 +0200
Message-Id: <20220531100007.174649-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531100007.174649-1-christian.koenig@amd.com>
References: <20220531100007.174649-1-christian.koenig@amd.com>
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
Cc: andrey.grodzovsky@amd.com, hughd@google.com, viro@zeniv.linux.org.uk,
 daniel@ffwll.ch, alexander.deucher@amd.com, akpm@linux-foundation.org,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This gives the OOM killer an additional hint which processes are
referencing shmem files with potentially no other accounting for them.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 mm/shmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4b2fea33158e..a4ad92a16968 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2179,6 +2179,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	return inflated_addr;
 }
 
+static long shmem_oom_badness(struct file *file)
+{
+	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
+}
+
 #ifdef CONFIG_NUMA
 static int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
 {
@@ -3780,6 +3785,7 @@ EXPORT_SYMBOL(shmem_aops);
 static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
 	.get_unmapped_area = shmem_get_unmapped_area,
+	.oom_badness	= shmem_oom_badness,
 #ifdef CONFIG_TMPFS
 	.llseek		= shmem_file_llseek,
 	.read_iter	= shmem_file_read_iter,
-- 
2.25.1

