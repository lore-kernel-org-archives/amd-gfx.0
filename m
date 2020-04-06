Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A171C2BA18
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 08:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D5C206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 08:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgDP9CEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D5C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 236D06E2E5;
	Mon,  6 Apr 2020 08:08:24 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3566E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 08:08:23 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j17so16167731wru.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ciDyYdm9PHqZLF9d1EtJ7kjRaenPpRmeZeruBBoFFNQ=;
 b=vgDP9CEkFYj78t/gysG6+Cgt++tpCIphetAIVzlvEQZjt269UubwyGe8ZyuLRdDX0V
 D3WMIObYEanqMR8VS4ONSYcr2hTCHYp7hSv4+TUogNMzE+39NxfAEQ8ukfVwXUQ/l3ZF
 ANzAw4wxq2SuPlVz/18i6RiX+NAbUEOnxe+mr/J35lQeFw65OzM2XW+TDxpqgjYrHPSl
 w5T6mY2rLzZnU2Gk8mlkcAyEtAdB0AG6I5bMwJ+29g7CCtgCg8GoDIt2htlqvxfhkqL0
 81qW5iHLz9yCaqOxUgWnOsvlRjUA0mLMHe8ISdiZa0ALeduH+n20FwqoctXoMPuqOyaE
 4bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ciDyYdm9PHqZLF9d1EtJ7kjRaenPpRmeZeruBBoFFNQ=;
 b=Qprrv1MoIxdvYp+AyqYxhco9QCk4CKg6+t5RdZdJ+s8Ou8+0Fss4imExp5xudacU/T
 sobNZMcSioypzkHym4aPkhXSMQALUkvjo4EWvxqwBq88drvv9cTVwKE5D9wyIVNUpVyn
 YpZsLijsFZAzTYuYyI9WYTfPxJftbEksuMWPtvsaUOzNpgOg+/dkdQant3jH5ZxKzpWG
 pdV7uedDgnqqgbnyihq+LabzWcYtRwNm9Abci7SjW3S2oUDcESXbPkjppDfcalnemSL/
 r2m53vyMbc+UbGOg7/PZ0UfnW1nSxyt/UrMZLfJrvhNL74poNHQ3HX6ID2pvZeTfmp7+
 2U+w==
X-Gm-Message-State: AGi0PuYeiZHRzfjokqeeUebzyotr2LFKX4bqYL8rad6iJq12gvA8Ndof
 OdRMVB5Ba89uj362jk6ocZQ6KiYY
X-Google-Smtp-Source: APiQypIoMdbvSThzUWh4dpLyblq35xY9satiaRvoFQb9lvAltrmT3Ue01PhPLgKgr3d3eCi5wHNyDg==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr9642648wrv.348.1586160501341; 
 Mon, 06 Apr 2020 01:08:21 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F21DC00CE1941D67FBF767C.dip0.t-ipconnect.de.
 [2003:c5:8f21:dc00:ce19:41d6:7fbf:767c])
 by smtp.gmail.com with ESMTPSA id a13sm25615659wrt.64.2020.04.06.01.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 01:08:20 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amd/powerplay: fix a typo
Date: Mon,  6 Apr 2020 10:12:54 +0200
Message-Id: <20200406081254.22246-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.26.0
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
Cc: Prike.Liang@amd.com, nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Util -> Until
Fixes: 720de5122254e86 (drm/amd/powerplay: implement the is_dpm_running())

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index ff73a735b888..95eb44515e36 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -896,7 +896,7 @@ static int renoir_read_sensor(struct smu_context *smu,
 static bool renoir_is_dpm_running(struct smu_context *smu)
 {
 	/*
-	 * Util now, the pmfw hasn't exported the interface of SMU
+	 * Until now, the pmfw hasn't exported the interface of SMU
 	 * feature mask to APU SKU so just force on all the feature
 	 * at early initial stage.
 	 */
--
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
