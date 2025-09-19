Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6A9CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 12:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1273F10E162;
	Fri, 19 Sep 2025 12:21:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PT3MgYeA";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C6110E236
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 12:21:50 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45dcff2f313so13042395e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758284509; x=1758889309; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Voxe1kk6FV1/wbFpiLteNflSqATXcrxuMb7/wSFp/T4=;
 b=PT3MgYeAbUW5K+XmyBNXwktIyaBcmi6foS3SEvgsabbVIjv1D9hD22oUZBc5xwjiVn
 nKznv+FMnaLZ4q6TknQusewLNt0fycLI6IYRSr1rnJxYNZ80NEaaNqDWA2I08blod6D4
 lYS3Bfl40B26bYSSFyJr6OZZEe6Xfmh299Vmn/W2lvuA0YX7WRRwpq0XQ+I7f04i8Zo1
 +L71H0yxXI65MCUAhlC+25rb2dEFxeiIBLD4Cz1JaDAgg8wOiNHOM9b0zafYNK67tYlf
 MvmYYCJrAsPvlY53iGwzSTs0VqaPTpIK75eUdwCTJJyP0dgWrn13NEr54Hg9zJ+KLjBH
 78tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758284509; x=1758889309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Voxe1kk6FV1/wbFpiLteNflSqATXcrxuMb7/wSFp/T4=;
 b=sdj9yKuLaOPiwOeRrcbSn6GH00yDbzTKsDxw1/zC5Ql7r5yin2nELKg9DwQ/YVzyww
 p0O1rf2I1VShtRxZ7bfKJak+pbdh4V5KduO5GS7i/HR1j0Lp+0/1gP1bNCRVVsGCeXhy
 7HBc26wTYK3iObTMr32xew06STW3fIQkFrBIrzFmei0E5HEVf3f38nvCa1p1/7ZyHEi7
 Q+YeYuYkdLf2xJxuxKPyjGetSCuQ7l4nxaEK2xaj4obfiiHOZMY5aaOB+LSDxBFZtsqw
 Drxpo8znmG6QuEf4/aXTD0eJnw2LP64CZop2JrXJGFAMKTu+olXewrasJPixQX/35Xgm
 Q5TA==
X-Gm-Message-State: AOJu0YzDSsGENPuxeVq2l0drbQLani40pDCP4/rBpuUC1bbPmkoLZWLR
 5H6L3HZpgIGxJxk2PjHADEZMdbe/1HgrjvRPk+D//6BPX8dLKGYTIHhi
X-Gm-Gg: ASbGncuHJ+Z7MX3qUvrm/CBf/mDWOPAbHUrbWArzakCRhgVn1eirUpJItcyaDTglzIg
 ARfKk4bG2p1BJbEexh4c94281R56BrtAvKWX+h2FoR6brZ550XtCrJu3sj93r6vLg53bcsa3vbf
 HmsTuFs2CgXamqb6pWjd1xKgvSq6uLU2OU+0Z11cxSHRRXepgXfLYnFrRYC0Ua8oyKIM5t2lb3j
 M9jBCXN+APlr5/vRXwx+R39EjNme2DSD0ZtAmXiEzXrDvxDHejYF65W2nVtMJFw0fDlTKxOsaGZ
 E05B3X2Y7NBUKAc69mCjob85DMHMsZunD0Hdd2SSMq6OXK6VnhJVJVNksdAUuQkP/n2qCFPH7s4
 1gCjr+hfQZ02n/7Fc0bnypxYqk4EnxUyV0A==
X-Google-Smtp-Source: AGHT+IF7Thi7sjiSGcB7WJrXlp3cv6CcMJsC/xcWxGR7c94gsUIAEebc4qcIbEjERmn9gWd6NlG6yg==
X-Received: by 2002:a05:600c:314c:b0:45c:b56c:4183 with SMTP id
 5b1f17b1804b1-467ee8c56bcmr24064585e9.18.1758284508993; 
 Fri, 19 Sep 2025 05:21:48 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f6:c100:27:890e:2d7e:79e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f3211e8c7sm78241075e9.3.2025.09.19.05.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 05:21:48 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, James.Zhu@amd.com, srinivasan.shanmugam@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: remove leftover from enforcing isolation by
 VMID
Date: Fri, 19 Sep 2025 14:21:46 +0200
Message-ID: <20250919122147.2538-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initially we enforced isolation by reserving a VMID, but that practice
was now removed.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 5dd78a9cb12d..cbdf108612d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -594,11 +594,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
 		}
 	}
-	/* alloc a default reserved vmid to enforce isolation */
-	for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
-		if (adev->enforce_isolation[i] != AMDGPU_ENFORCE_ISOLATION_DISABLE)
-			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
-	}
 }
 
 /**
-- 
2.43.0

