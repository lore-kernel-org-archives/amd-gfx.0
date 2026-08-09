Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE95C5B56F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E70710E6C2;
	Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VL5J7qE3";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BAE10E05B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:21 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso441875a12.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252401; x=1786857201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mqhs7Zhem08+gKWpC13qqFjQ+/RUK8tqoU89vwfPtBM=;
 b=VL5J7qE3qxFHU6hRo12QC3WduaqsVFW1092Adb+6YaljE5Py95gMBziYJoJqo28z37
 4Kc92fod4vocr9Kiv7aSkKbiLAx/YewZH3703hxNlSKmweNg/ScobbxV2ZwyJ/PC6Xv/
 6Sm5lEZLsaMgaqldHory4vXpleo287di153HXaAoIT/KQx8jmx6k5xupGQ6frGi/ItjM
 hzN6foZg1oeDEcTFOIThDXi44HTL3tA5KR4g0GzL8U5I+RSmceJVJWkYTfWw7LgPNN1u
 7dB982gr40nakYYPyVlMRnWLvNZruvPaJTRVT2eovoh/pbiIbVwN9h5HZzyplrwGuUjh
 CWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252401; x=1786857201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mqhs7Zhem08+gKWpC13qqFjQ+/RUK8tqoU89vwfPtBM=;
 b=AVFBZo490dN3GuaRr9X1Vzl1Rztz5KhRLFcEwfSM4uC7V2GHbJo0Mqd0wpajzzWmr1
 KRy8qnbfyABQy7lnShaDpzKp0L6OG9RsKd75DrHaUcQA+aSGi3nPmOvmmgQ2dd95piTr
 beO/BioDtAxR++68SB4c9ix/l1D1oL0JVZW2Z4Lva4j+ozsOewU9wy8mInQXtAv3Mnzd
 EyvTVhXpe4n5FvKD/0CCWTH2G52eH9KGZYtpuza7lfVeuvIHx0DywapOOQtQskdDk6sP
 PMjhWBKBVKq58ROVl0JhPszBGS4oNzES02rqIjbk7ZeDhaRKsdVgCPmnZrcHlH8UfPaj
 9INg==
X-Gm-Message-State: AOJu0YwAfu4q7mJCD550bpBY6kP0Pb4DV9JejhpWTyflkIaNiNnV1YBT
 UUX1PRBCII8RkHfz2hzRwQD2b3B4C8n3PyTz7WuDcnrsHz2lZfyR3q7K
X-Gm-Gg: AR+sD10iG8/muQz1v73FxlEOZgvOKDnYBEXrCmr74MDg6w0xyl3zJvEIWfvNtj59QrH
 bRk9Bn+hwtwPRGQoy8U3cgIlKRbX+BJqtzjk46SxI0a6PjOzsP6au+0Emd2UNBpxncXBBt5u40e
 qe7gUCRfmTDdrCwxbPzPA9A0VXawi7CRv+Th4Iz30alT982wfVa5eT1qVa+v/sbVJtcKADbE3YO
 TZuQAWG+cV0P2BBIu8OitL0GTLp7eAXdTNOUBJHngnVU39RiVwx2/IPXvMiaWDxfaeXCf1BPgv5
 /pW7uIYcRdYWpCIbwEsY/+McEncLkqWk8Hfc2uBwx441Uz34w5HNkDb39dkwGn9gIhlUBqJ3TpH
 wIIsv0ja6xsJJBlemWxTz9Zf0nQFLq08byUMvT5rCrkHAzWRre6MAMBICQqYEay10od60amMvWY
 I1Oc8hBYcKfySU0u2LLnT79/nAtTD+C5h6iSsLy6WoIkM3kVmUo5RIqNDVla1g9DRqfRR5Moifd
 TPzJ4T5+b+/OFzYKDgSh2k=
X-Received: by 2002:a05:6a20:9e0e:b0:3c3:66c5:68cc with SMTP id
 adf61e73a8af0-3cb85efa4f9mr43331123637.21.1786252401232; 
 Sat, 08 Aug 2026 22:13:21 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:20 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 3/6] drm/amdgpu/aca: Fix inverted validation logic and list
 cleanup
Date: Sun,  9 Aug 2026 05:11:57 +0000
Message-ID: <20260809051200.3276-4-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
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

aca_handle_is_valid() returned false if !list_empty(&handle->node)
evaluated to true. Because active registered handles have non-empty
nodes in the handle list, valid handles evaluated as invalid.
Consequently, amdgpu_aca_get_error_data() returned -EOPNOTSUPP
whenever aca_handle_is_valid() evaluated to true.

Fix the logic in aca_handle_is_valid() to verify that the handle is
non-NULL, contains a valid mask, and is currently registered in the
list. Update amdgpu_aca_get_error_data() to check for invalid
handles and return 0 instead of -EOPNOTSUPP so non-ACA blocks in
global RAS queries pass through safely without breaking error
telemetry.

Additionally, update remove_aca_handle() to use list_del_init()
instead of list_del(). Standard list_del() leaves node pointers
poisoned, which causes !list_empty() in aca_handle_is_valid() to
evaluate to true for removed handles, leading to a potential
use-after-free during device teardown.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c76664af9902..06cb3ad1ce62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -586,10 +586,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 
 static bool aca_handle_is_valid(struct aca_handle *handle)
 {
-	if (!handle->mask || !list_empty(&handle->node))
-		return false;
-
-	return true;
+	return handle && handle->mask && !list_empty(&handle->node);
 }
 
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
@@ -599,8 +596,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (!handle || !err_data)
 		return -EINVAL;
 
-	if (aca_handle_is_valid(handle))
-		return -EOPNOTSUPP;
+	if (!aca_handle_is_valid(handle))
+		return 0;
 
 	if ((type < 0) || (!(BIT(type) & handle->mask)))
 		return  0;
@@ -717,7 +714,7 @@ static void remove_aca_handle(struct aca_handle *handle)
 	struct aca_handle_manager *mgr = handle->mgr;
 
 	aca_fini_error_cache(handle);
-	list_del(&handle->node);
+	list_del_init(&handle->node);
 	mgr->nr_handles--;
 }
 
-- 
2.54.0

