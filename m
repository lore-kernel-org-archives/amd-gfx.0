Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CCAECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 12:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E31D10E44E;
	Mon, 12 Sep 2022 12:37:32 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D77810E467
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 12:36:46 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id z21so12561907edi.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=n8m5/Y6MpUvPe1e/1gGmGx4fix9qgu3Q8BvFeDGYwog=;
 b=eEs/tDMM9rYLuowcwB8aVJI68Ob6pYuU9DPtTeTvz+sPlbYBahHbBG2+cjFN/+hC48
 Te6bq8MlqVI7/ew37ala49F1hBUF5+kP4A2w0D3EJzyQe2awD3X0W00ZNxm9PmmjW9wq
 ZxKNgutYCvQ9rUIT+VqdS632liv5e2U+b444Vs8XGj1KUaXoGvaZte+hLwkceSotnH6l
 n4wmwIRC30//pBkjljJ9fiZBXlbFeRySqB41yTkFEZGmbZ4uRioEkaJ3vp6rSOMjnuVP
 TtAJ3D9CM6wy/lUiplSjnAv2e6tVfP97GQlKSbohN9Pl0Ho62jm1VHWo0pD+wwyo4dJb
 a8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=n8m5/Y6MpUvPe1e/1gGmGx4fix9qgu3Q8BvFeDGYwog=;
 b=A4CyCQmMsmA8fE99z1p5etDv3V7ho2/2UINADg8nxttwRuyvnNIe2c6SX131/E2os4
 SEi1945uP4tTaY8NFbsv35WnsoFDCWatLQKNBmp5Q28bJqm+YKLoLtuAe19YLEyFiBrr
 koE5lgVOLjT9+NztZwyBpxz6yQB7zPVsO7/8XzUnrQ+hDw88DUbwsuaaLR85iWt0HKlr
 Kdg/vVbktlviRAsXMZghVUbSxQEFcSFoQriV6gWME/B2WOM15ANyyAQFgrO79purlmfU
 MgdQfeaXCRwVC0C+lSghUsea0K3tLLtIGfvU9/Alu1MlIqD8DmV34ojk3nMaZq0fj9L+
 uNUQ==
X-Gm-Message-State: ACgBeo1l76z9EbatVZwKG9EfFNDa5Urs6GQc/p9RIQDtPOoMBK0UwTRV
 shPw9upt+SGt2KF0NVtYr+c=
X-Google-Smtp-Source: AA6agR69x3CBnWliFw0yMZ1ZH1lH58sG2oGa3VxanANnfJBCj8SCL5KbCFa+Fvbtaean8V9KqxaCXQ==
X-Received: by 2002:a05:6402:3215:b0:451:4ce5:d7b8 with SMTP id
 g21-20020a056402321500b004514ce5d7b8mr9014468eda.223.1662986204679; 
 Mon, 12 Sep 2022 05:36:44 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 au6-20020a170907092600b00770c8e157ccsm4335639ejc.136.2022.09.12.05.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 05:36:44 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu: remove SRIOV and MCBP dependencies from the CS
Date: Mon, 12 Sep 2022 14:36:35 +0200
Message-Id: <20220912123640.20058-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912123640.20058-1-christian.koenig@amd.com>
References: <20220912123640.20058-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We should not have any different CS constrains based
on the execution environment.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b7bae833c804..6f80cf2ea9ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -814,7 +814,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
+	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
 		BUG_ON(!bo_va);
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
@@ -898,13 +898,11 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
 			continue;
 
 		if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
-		    (amdgpu_mcbp || amdgpu_sriov_vf(adev))) {
-			if (chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
-				if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
-					ce_preempt++;
-				else
-					de_preempt++;
-			}
+		    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
+			if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
+				ce_preempt++;
+			else
+				de_preempt++;
 
 			/* each GFX command submit allows 0 or 1 IB preemptible for CE & DE */
 			if (ce_preempt > 1 || de_preempt > 1)
-- 
2.25.1

