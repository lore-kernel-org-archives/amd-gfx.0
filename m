Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2524C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 20:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE4160FEB
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 20:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE4160FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEC76F4D9;
	Thu, 27 May 2021 20:56:19 +0000 (UTC)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565DD6F4D5;
 Thu, 27 May 2021 20:56:18 +0000 (UTC)
Received: by mail-io1-xd36.google.com with SMTP id n10so1935902ion.8;
 Thu, 27 May 2021 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k1Ma8e4VgLih51j4GLcjEplAHTajoYpcn4LnehgSpAs=;
 b=CZdDPQGxmTFwM6p6C4CNikpcwJhyUrQ/DqfYSJYXz9igEti2BxRwt2wzpM9W0nEZ1A
 YT69TIB+NITXPm8fbOvVveR+VcmJrZs/V8OSHztdvJzviEehdqc3CEsCay+HCbRB7bv0
 pZoVOuDz5iSHywRywPvdtSJehFXorFXn37M1xOnq+xsCvAoP5vbGRyuCH5ZLlHnCM4q5
 QBeMQ3U1+cBcg8YZxmpdV+G0SbiaX7SCTHlLU0IggH2yOumBHNBZfwRM5XHj60h8sMfu
 fUhMF+5kR9Rvt7K9MYKzb+wjP5bTK9e7+mg5HHYI0ZqC5mUmTTpTKXffyjIexSeYo+b4
 KAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k1Ma8e4VgLih51j4GLcjEplAHTajoYpcn4LnehgSpAs=;
 b=Eiwr1+IO8s4rlQuIaVqY0MTcAAKFrhCUZcEP78jg0kzCEDsWnHDfXROHd+xnyPz2vR
 VifCKF2BAVYdO4PuvGpDUSTzHkLGPxxH1fhocGGH6cGuYn9NsyDVBs3O2Qpx3SHmcA3s
 7zwMYQYo+bhRyxRmAPv5C2EtFVhdx/SGTPcKwoBDrZDLXyw3XcVF+q+aOuDhkzJUFE68
 o8dVwVN3t17QCF0j9PVFESq5V7UML7hncHUBX34LiM3luwRj+Cdim5LME9YWpTfbFf0+
 JCy0LPROKQGayjxL7u+2iB8stZmNyRLSVvEuP+ElgBw3dz/spvK2Fsi0j4e7YHhDwZKt
 z3lw==
X-Gm-Message-State: AOAM533LZz6PP7NKUHm8chSGnZISq7vud0lxTECh7ll4JQGi8lqzGSdv
 vAOFcCY8FJeiZH6u7ZxM/RMinBb66UbJXg==
X-Google-Smtp-Source: ABdhPJxwoq1pth4gPv4Rv4Zj7JgZlu02ITqu9/GOuwtpWVb9SnoVFOrJ2ciZayfOP8NjF41P8+aQjw==
X-Received: by 2002:a05:6638:12c5:: with SMTP id
 v5mr5249627jas.11.1622148977494; 
 Thu, 27 May 2021 13:56:17 -0700 (PDT)
Received: from Harpoon.amd.com ([165.204.55.251])
 by smtp.gmail.com with ESMTPSA id b10sm1577265ioz.35.2021.05.27.13.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 13:56:16 -0700 (PDT)
From: Felix Kuehling <felix.kuehling@gmail.com>
X-Google-Original-From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 08/10] drm/amdkfd: add invalid pages debug at vram migration
Date: Thu, 27 May 2021 16:56:04 -0400
Message-Id: <20210527205606.2660-8-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527205606.2660-1-Felix.Kuehling@amd.com>
References: <20210527205606.2660-1-Felix.Kuehling@amd.com>
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Sierra <alex.sierra@amd.com>

This is for debug purposes only.
It conditionally generates partial migrations to test mixed
CPU/GPU memory domain pages in a prange easily.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8a3f21d76915..f71f8d7e2b72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -404,6 +404,20 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		}
 	}
 
+#ifdef DEBUG_FORCE_MIXED_DOMAINS
+	for (i = 0, j = 0; i < npages; i += 4, j++) {
+		if (j & 1)
+			continue;
+		svm_migrate_put_vram_page(adev, dst[i]);
+		migrate->dst[i] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 1]);
+		migrate->dst[i + 1] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 2]);
+		migrate->dst[i + 2] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 3]);
+		migrate->dst[i + 3] = 0;
+	}
+#endif
 out:
 	return r;
 }
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
