Return-Path: <SRS0=ZRVW=L5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF502C07E9A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 07:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D34C61351
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 07:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D34C61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1447789C07;
	Mon,  5 Jul 2021 07:05:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84FD6E1F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jul 2021 19:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625255585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KRoKHMQ/QYj7rUDlz3XNGWb+wy/iN7sUlepMrk5JPbo=;
 b=Ah2dflWYnr+mGhiX0GNbUaqtcGYq29KRviYSB+dQ+34C569uxCcwCOQjXMajRLuJSKmqA8
 UPGvplbA+mcilrghe0HNW9gMmL+NoealkiDjR8Tijo9wv99s7eqvI8PT7LxdKj2etEq3ij
 7zNm2pZL60rD/CuzEdxxa4IX24Uu/jc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-HSXhqnvSPAWYYCMfHiP4BQ-1; Fri, 02 Jul 2021 15:53:04 -0400
X-MC-Unique: HSXhqnvSPAWYYCMfHiP4BQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 g72-20020a9d12ce0000b0290464115c5c33so6895717otg.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Jul 2021 12:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KRoKHMQ/QYj7rUDlz3XNGWb+wy/iN7sUlepMrk5JPbo=;
 b=U91cz23Qg/ueeeAg5CuJC9L9a+h5O8THoAM8lcKno+BoTkamPumWS9FAEQlvFZPWHs
 0xaI3oT34T5aBlQmvYgwY3a+nceGq7r2S8mWlk7U3foDBmvexvmhlwIyLNTTL83FvUwq
 m3RYWyeLxyuFDqdIU8Wn0QWhHnO35zuT00LYccSCsm5wY/+bQh8wiBfv4vGL1UewC6CT
 zjEnfnDnYUOn+jmKGRBlMozbS1zgQwQtGZDhtGsfqDUW2xOC6C3AsKtV3202xZkp9SpU
 wnh072fkw6lusI9srfTxoM621kkeFcfqUOfs1X3vuYW11nWzv6FMYNdtWDDJFMdssBqH
 /ldg==
X-Gm-Message-State: AOAM531j46ur8rujij4hdckerBVwFeStO3++8VZT/ebchuHItyYP7TFB
 Zg18mE2/YxedWjdSDQtI//A9ffAgULwVpTgKSdc0ks1pLbRgRRY1Y/e9/xmcAD76/f0IahsT/UX
 EPixXYZFPxRDjO0J7WYyzn7iFCQ==
X-Received: by 2002:aca:4302:: with SMTP id q2mr932146oia.111.1625255583754;
 Fri, 02 Jul 2021 12:53:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeVRL/DQmiY8F2uMYWaBUYWtTORAPrUvyzc7HoM34TMuLz0GslVBRJe+SamgLTpcc4McWv6Q==
X-Received: by 2002:aca:4302:: with SMTP id q2mr932125oia.111.1625255583503;
 Fri, 02 Jul 2021 12:53:03 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id l2sm810062otl.27.2021.07.02.12.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jul 2021 12:53:03 -0700 (PDT)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
 Dennis.Li@amd.com, guchun.chen@amd.com, luben.tuikov@amd.com,
 Stanley.Yang@amd.com, nirmoy.das@amd.com
Subject: [PATCH] drm/amdgpu: initialize amdgpu_ras_query_error_count() error
 count parameters
Date: Fri,  2 Jul 2021 12:52:45 -0700
Message-Id: <20210702195245.1629908-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Mon, 05 Jul 2021 07:05:26 +0000
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
amdgpu_ras.c:2324:2: warning: 2nd function call argument is an
  uninitialized value
        atomic_set(&con->ras_ce_count, ce_count);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ce_count is normally set by the earlier call to
amdgpu_ras_query_error_count().  But amdgpu_ras_query_error_count()
can return early without setting, leaving its error count parameters
in a garbage state.

Initialize the error count parameters earlier.

Fixes: a46751fbcde5 ("drm/amdgpu: Fix RAS function interface")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 875874ea745ec..c80fa545aa2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1056,6 +1056,12 @@ void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	unsigned long ce, ue;
 
+	if (ce_count)
+		*ce_count = 0;
+
+	if (ue_count)
+		*ue_count = 0;
+
 	if (!adev->ras_enabled || !con)
 		return;
 
-- 
2.26.3

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
