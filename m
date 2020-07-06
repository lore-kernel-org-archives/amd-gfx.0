Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7844CC433E3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 13:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8D72070C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 13:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH8C6p+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8D72070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF2589FDE;
	Mon,  6 Jul 2020 13:07:22 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BA16E393
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594038548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=Mc/ldKPt/EXYFlwVXR6UGMdQ57wZ+ah4uNI5EbcP1/0=;
 b=fH8C6p+UgDsq5cD3Zm2p9gbV1gUvcyZs5s9us7VJZkcVCE9Th3pIrkAaTJcReyr8safaNy
 SgNUZcgyER3EgEuk7lFEUtSBuPYNcKG9IrFJ75hTJEsM9yizYNyZv11UUNMBicaKjvqRBy
 jiWqpI+X0Dm+lpKGZzvXuBe8SBf+3KQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-tpfKAknsNBKfmmPXgw56rA-1; Mon, 06 Jul 2020 08:29:06 -0400
X-MC-Unique: tpfKAknsNBKfmmPXgw56rA-1
Received: by mail-qv1-f71.google.com with SMTP id j18so24789428qvk.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2020 05:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Mc/ldKPt/EXYFlwVXR6UGMdQ57wZ+ah4uNI5EbcP1/0=;
 b=JRD9F5ni+UKLrguF0I780hbWGfiBO/7OZhRWLCsc4wiw3TdHzIDGOKYtMPBImZwPLe
 6RudpII4LPsxlhzmkFkQoZzi8D4DEsUeRGV5H2921gpLJKbp3J5mEUlroXG1hwnJc+95
 sKqyRrgDMoVUofxxXF59cG42cJ4ZBYhQL66h1YOplXXNFNc0bpi7WyruWKegSpVFkEw7
 NgZfcvzr7hvxPqyNidzarzfsAYfS4ty9ST2/whbqbpwEJviK1NVsx1FzKodeg1uUttj2
 G5bFPYY3eCr6ZPbOzlrH58bHNS9LVU6Qsg3R0kqN3eWBUUFIZUZ2nmi0JRIM+wKgkTSk
 ChwQ==
X-Gm-Message-State: AOAM531xLZpl1zyhl2YvTEyxG+ADkOE9GdFx5TViZOz20BgefqgpV18L
 y+8E1B4qyvj9z0sFJgA81ipttN5WOO6Ox1/bdDp8j/WDnMIe8P8h12NoIT0RlW81uSTIFMRzGE5
 WFuqV5cBa1Z7cABoCS58jFSQPAQ==
X-Received: by 2002:a05:6214:d4d:: with SMTP id
 13mr13540402qvr.22.1594038544912; 
 Mon, 06 Jul 2020 05:29:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMy8mu7HXUm95aP+rznm4nycrjLabnqqCu0tSzaAU0UirnpXs5EwtEIjiB8f3YLEf4kXnE0A==
X-Received: by 2002:a05:6214:d4d:: with SMTP id
 13mr13540380qvr.22.1594038544638; 
 Mon, 06 Jul 2020 05:29:04 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id u6sm22032735qtc.34.2020.07.06.05.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 05:29:04 -0700 (PDT)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Subject: [PATCH] drm/radeon: fix double free
Date: Mon,  6 Jul 2020 05:28:57 -0700
Message-Id: <20200706122857.27661-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Mon, 06 Jul 2020 13:07:20 +0000
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

drivers/gpu/drm/radeon/ci_dpm.c:5652:9: warning: Use of memory after it is freed [unix.Malloc]
                kfree(rdev->pm.dpm.ps[i].ps_priv);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/ci_dpm.c:5654:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(rdev->pm.dpm.ps);
        ^~~~~~~~~~~~~~~~~~~~~~

problem is reported in ci_dpm_fini, with these code blocks.

	for (i = 0; i < rdev->pm.dpm.num_ps; i++) {
		kfree(rdev->pm.dpm.ps[i].ps_priv);
	}
	kfree(rdev->pm.dpm.ps);

The first free happens in ci_parse_power_table where it cleans up locally
on a failure.  ci_dpm_fini also does a cleanup.

	ret = ci_parse_power_table(rdev);
	if (ret) {
		ci_dpm_fini(rdev);
		return ret;
	}

So remove the cleanup in ci_parse_power_table and
move the num_ps calculation to inside the loop so ci_dpm_fini
will know how many array elements to free.

Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 86ac032275bb..ba20c6f03719 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -5563,6 +5563,7 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 	if (!rdev->pm.dpm.ps)
 		return -ENOMEM;
 	power_state_offset = (u8 *)state_array->states;
+	rdev->pm.dpm.num_ps = 0;
 	for (i = 0; i < state_array->ucNumEntries; i++) {
 		u8 *idx;
 		power_state = (union pplib_power_state *)power_state_offset;
@@ -5572,10 +5573,8 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 		if (!rdev->pm.power_state[i].clock_info)
 			return -EINVAL;
 		ps = kzalloc(sizeof(struct ci_ps), GFP_KERNEL);
-		if (ps == NULL) {
-			kfree(rdev->pm.dpm.ps);
+		if (ps == NULL)
 			return -ENOMEM;
-		}
 		rdev->pm.dpm.ps[i].ps_priv = ps;
 		ci_parse_pplib_non_clock_info(rdev, &rdev->pm.dpm.ps[i],
 					      non_clock_info,
@@ -5597,8 +5596,8 @@ static int ci_parse_power_table(struct radeon_device *rdev)
 			k++;
 		}
 		power_state_offset += 2 + power_state->v2.ucNumDPMLevels;
+		rdev->pm.dpm.num_ps = i + 1;
 	}
-	rdev->pm.dpm.num_ps = state_array->ucNumEntries;
 
 	/* fill in the vce power states */
 	for (i = 0; i < RADEON_MAX_VCE_LEVELS; i++) {
-- 
2.18.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
