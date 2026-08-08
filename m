Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36382C5B568
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E314B10E6B9;
	Mon, 10 Aug 2026 06:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AFN08+O1";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A79610E043
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 22:30:25 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cbb973e6749so843418a12.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228224; x=1786833024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0T8hsbR8l/QSpKtJo+gqmSKNs2cFgYd9YKdYEYcvNTs=;
 b=AFN08+O1HJl9tSi3CbGwH+A0jMCfsV3L95ZTjWqVhga+6Gc1eHblxReVRVvoV9IJQ7
 EpYTGwf3iLYOMSc5cbQ5vjyIIJvbe9fXuzqdHx0+1Kjzq1BT1Pp0q4ABgcUr/88yHCYL
 wA9f1sNlUaEJfWL6SSqm+VDNT8yM4PAZBWruLC0VDb7ovf/YxGrZEsYIWSQBEqWUN0Ba
 4mfL+LHmcaJprU0X0hslJ3NoS+0yj2mkiNx8sf+1MKlXmTGFIC5r3rEmkjZKGp9YW6x/
 DuO16TKmQprHnF2SyEoNtQoildLFtroGeeEHUxiG5qHt7t/boh1QSWMRBXfAn8/Nzp9P
 q4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228224; x=1786833024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0T8hsbR8l/QSpKtJo+gqmSKNs2cFgYd9YKdYEYcvNTs=;
 b=Vq/pvkP5mEvt03LA8f2hzLpZnzWB7LIMa6E0MMbuZD7/KECh2QpZU9DzL7u885i9zv
 kEG10JEXyIhwJfB2eT1UD+3M0zFShKEEfXRG7ysEJFqEQIvFJVRS2g1btMVUGCB149hb
 b+vquRBbsdjW5pgGIJOC9FHaHoRfs0qi9ezuRiog6oU5EXYZuOknCKYU9icVgVW6jOwd
 14hBGmm4H8GDWA2Wc+ByZ9OlVTYHxV4fUmW4I7N/qD7HN4dSAjkZG0PRLzm6oHWjCEGW
 13lfLpCbB5YuRvseqs+6Or6U3AkVhMNhkI8WrFtVZX7kTtZwXwRRH5XQndQk14EYoLqj
 Z+HQ==
X-Gm-Message-State: AOJu0YzGiTaADx0CufHazP1ubp97LkCZosr7OCLcv0icscDNoFJX7F0I
 XllIi4aeGl2ZaIuSA9uUTU2HSap2WaDz0JaluFeswtnW1POG8fdCfpGz
X-Gm-Gg: AR+sD13qdAcqOTnZ4Zd10E0wupDxAfeycAS4gAU8GHfAx2ooZ1+XcXqxUQ36/6oGkrd
 UhSkmuTM/0HnpvFQE/X9106aIRtRTQdK5YSIa2mbli9vUPzN0NVICg1Iue67YX1W2fDLMAyRdmo
 pWAl6ytCLyWPHAnMkCz3lQotAfaXRw9hP2lu4T03A/+9GvpRVGUnaQB5VmMKlaCIkQm2kjE46qb
 rxlrwOsbgHfYEBOjl9m2eQORTBdC/Aswg4HiG3sJpteM9TMqRgSVjavmHVutXs847evugiKYPw2
 n62msfzAd/8QKCWXpbqLhmx0r4JAvcAXJZpZjCyvnlmkqlAnbPSPgoiQ8MAraWPxVnrw4ceEmRD
 AQgrUqeEZUpEDvMwrjPKc4M7PyAHHk0euJhaMOu6jX0x6b/1wtYGMP2KR8bHbBAy36rdPiq8kuU
 hylGPBO+SERdmvdjS4FL3SB3a0P1wTJ3jcRFXDDCspPF6shJd0HPK0EGVgaUuvM6b8ycfmijWkZ
 ACsw2f+tTrGUZwQWTSQtg==
X-Received: by 2002:a05:6a20:728c:b0:3c0:b4f8:bbfb with SMTP id
 adf61e73a8af0-3cbc03b5531mr13804904637.22.1786228224701; 
 Sat, 08 Aug 2026 15:30:24 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:30:24 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 5/5] drm/amdgpu/aca: Fix off-by-one buffer size parameter
 in add_aca_sysfs
Date: Sat,  8 Aug 2026 22:27:42 +0000
Message-ID: <20260808222742.2859-6-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
References: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

snprintf() guarantees NUL-termination within the size limit specified by
its second argument. Passing 'sizeof(handle->attr_name) - 1'
unnecessarily reduces the usable buffer capacity by one byte, causing
sysfs attribute names to be truncated early.

Pass 'sizeof(handle->attr_name)' directly to snprintf() in add_aca_sysfs()
to allow full use of the allocated buffer space.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index f22b58c559b6..c2fe98b83eee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -682,7 +682,7 @@ static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
 {
 	struct device_attribute *aca_attr = &handle->aca_attr;
 
-	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
+	snprintf(handle->attr_name, sizeof(handle->attr_name), "aca_%s", handle->name);
 	aca_attr->show = aca_sysfs_read;
 	aca_attr->attr.name = handle->attr_name;
 	aca_attr->attr.mode = S_IRUGO;
-- 
2.54.0

