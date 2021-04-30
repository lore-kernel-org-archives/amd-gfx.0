Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE9BC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 18:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1173A6145B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 18:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1173A6145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C87B6E4FE;
	Fri, 30 Apr 2021 18:43:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08E36F586
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619805914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QlUIlAKYE4495cvc4WfUS3fiQGRr+yuPORiuKa9dPbk=;
 b=QXRLXomJ1ygMukWWKfiaz5EOA6DSoiAY9Q7gCgnTVscyaB9X47Y8igCIjCHymWslLdcuXG
 yZM+GSBp62jnug0Fc7JRRUdpZ2QMtUvjA6LPQUSSIlm5l23lNlHGEOjfFFLQLXdDuTEhhf
 mnxx12cStb0z4isNkQkQjEe5pk83828=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-wMBULxqhP02InXzvMTrVRg-1; Fri, 30 Apr 2021 14:05:13 -0400
X-MC-Unique: wMBULxqhP02InXzvMTrVRg-1
Received: by mail-qv1-f72.google.com with SMTP id
 l19-20020a0ce5130000b02901b6795e3304so14002939qvm.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 11:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QlUIlAKYE4495cvc4WfUS3fiQGRr+yuPORiuKa9dPbk=;
 b=AC4We4jU2N2kIYC/nizRytWfwJJrcbch2AYUFR5rTlab+Ju8joWiKL39j00Mo1q1G/
 RciPlLfkR7srVlzpPmitbBrwCJptZL/NeKc1GY9c7Rj52qu4Mg1gQwE0hnaZdroJejZs
 WxL0tvs2gLqzpt0Z2QjHOfpAdsckVrd19hNeS8KFJNCjYn4jxu1DSxo+QV4lIBFY0jL0
 LPxrLnSHTCtq6qlyCy5tA3hi3ACPq0e4tU2ssxgEnqZ9Jp4BvHQX3cQHOiAThr/FVy4a
 TfSDmObWqskZPXKmHwHJgAhNwaq24rPYTljrXJKQqCTxbZwXtva9PZ3HRUOyA016XyeL
 78ow==
X-Gm-Message-State: AOAM533MtD0ZTb/HHDabpBq+GPEcp5vOG8v6O7Lq/XuXVgW+2z6s+DST
 49cfcRRJTlA96/spxHfeJaCIR9Zl3+7fyTHU86AjW5DM96kmTRTpp/HisWL+lZoMAGtswLo7fgd
 MQcP9wJaIqsVR+Ujv8CXen7mo5w==
X-Received: by 2002:a05:620a:9dd:: with SMTP id
 y29mr6472036qky.83.1619805912678; 
 Fri, 30 Apr 2021 11:05:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0fuV+OSVOqxqrRktaPY/gHGGzWK734pNZzRkulGOtAXJjRCbXyYaNKA83MtpCVXrMGEbhuw==
X-Received: by 2002:a05:620a:9dd:: with SMTP id
 y29mr6472012qky.83.1619805912484; 
 Fri, 30 Apr 2021 11:05:12 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id p187sm2061155qkd.92.2021.04.30.11.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Apr 2021 11:05:11 -0700 (PDT)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, evan.quan@amd.com, nirmoy.das@amd.com,
 kevin1.wang@amd.com, ray.huang@amd.com, darren.powell@amd.com
Subject: [PATCH] drm/amd/pm: initialize variable
Date: Fri, 30 Apr 2021 10:16:54 -0700
Message-Id: <20210430171654.3326745-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Fri, 30 Apr 2021 18:43:33 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem

amdgpu_pm.c:478:16: warning: The right operand of '<' is a garbage value
  for (i = 0; i < data.nums; i++) {
                ^ ~~~~~~~~~

In some cases data is not set.  Initialize to 0 and flag not setting
data as an error with the existing check.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4e459ef632ef..9a54066ec0af 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -451,7 +451,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	struct pp_states_info data;
+	struct pp_states_info data = {0};
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-- 
2.26.3

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
