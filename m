Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C5C33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 09:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634D7207E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 09:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJH8AOXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634D7207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC4B89AB2;
	Tue, 14 Jan 2020 09:56:58 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EE689AB2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 09:56:57 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z7so11434605wrl.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 01:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F0EnpdNnkkoKqm5DRRDz31/LdccSol3qmSJlJ1oiHys=;
 b=eJH8AOXWRcz9txAaKhzheIEoBAMvFWAucxp94bbtWyL8xo9wClbVdG2bIcYNlLLZL4
 FRUSds5s6nnxN/s5Eq3ED7IFh4/i6sOzMTRNh+aAasboy0CV3wcBTv235PYNDJEC6Did
 pp40PZezNgKy4keTurN50ss+usH3xefnW39xG8IKAxlKRDmq81ZoD8qQHLiZ7McBx2nX
 SlydCWPIcRprcJBoj/ibBu7q9qTdhzZmdDB08xNNfiSm+MgAwHmrhsgjqNrT/xOuez/D
 onNtPy99rK2e5b8vl8hUKOHLk4KT74QbTk1YR8gp+7lvQ3FsHWm1MsxRrG+7tnozf+vU
 /42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F0EnpdNnkkoKqm5DRRDz31/LdccSol3qmSJlJ1oiHys=;
 b=aMuvsFEmXooXiS0QlChAlv34QeoSACBUfMmVCNUqvy65ISfRdqm3BlTQAdL2pp+Gmk
 LpY5F5Tm1ljbPYgwaWXiMwgxdVYFC2o4akUFaIBOCXT7e2vz4BXIyyOBL0Jii4ImMIQ6
 hZ2IEpS95DLdRKxDpnhN4TVwmatZ3kDrRASCBFOwqFkNx7p3KiITQJm1USXBLGVbYx6A
 uJXwmMVvAKf0Rhl32ROraUDdN/1voi9sg6F8G8OYE+VJiRxSYfvbehFZ8wbl2UKua6gO
 ApzYo8RgnDxm0Jpd+yPP7ro5mEUM5y34sR6IeO0oBvyz+3R53UClXv7K+JylJX/LG3q7
 P5wQ==
X-Gm-Message-State: APjAAAU4WZiJ9VkLIqC6Mr4vdilwyVMpXGtlukDuDHEOdWrvFylAwLBq
 vaTy4QPj1tX17E5ymCQkapeTGISe9+S7Sp9V
X-Google-Smtp-Source: APXvYqxol2ijrYYhiC9/ME0jWKDJeEMYR8VXgulXFRRnkRq5EVDLfHD+2woIIXkNmQLitDOeTMEy0w==
X-Received: by 2002:adf:814c:: with SMTP id 70mr23184386wrm.157.1578995815500; 
 Tue, 14 Jan 2020 01:56:55 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F343700CDDF573F1071AE40.dip0.t-ipconnect.de.
 [2003:c5:8f34:3700:cddf:573f:1071:ae40])
 by smtp.gmail.com with ESMTPSA id e16sm19010751wrs.73.2020.01.14.01.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 01:56:54 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/scheduler: fix documentation by replacing rq_list with
 sched_list
Date: Tue, 14 Jan 2020 10:58:19 +0100
Message-Id: <20200114095819.8373-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 2e3a058fc239..62bcca855c69 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -45,7 +45,7 @@
  * @guilty: atomic_t set to 1 when a job on this queue
  *          is found to be guilty causing a timeout
  *
- * Note: the rq_list should have atleast one element to schedule
+ * Note: the sched_list should have atleast one element to schedule
  *       the entity
  *
  * Returns 0 on success or a negative error code on failure.
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
