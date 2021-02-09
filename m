Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F044C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 02:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB74064DD5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 02:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB74064DD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31B76EC1F;
	Wed, 10 Feb 2021 02:06:05 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E416C6EC07;
 Tue,  9 Feb 2021 23:48:26 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id e17so460640ljl.8;
 Tue, 09 Feb 2021 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cLZtFkHMbed+rABy5CfV1sfDkxWh/w6w89VAEQBWMBM=;
 b=Xk52od/vCRkJrNgX2xOUOcqcEZfsjE1G1qm1+cEHAZJ141du77ilkUTMJnuQze3+kp
 gKUG5m7Stw9T8RVxsN4/sruOSsJYDOKE+0q3oCTM70x74K7tXOCiUN1dd5/itmMh0Uz7
 9Jef6DpzmX3bsLMxNhhZFXXos+I+BXGdwOrTtOZMXC607vSFRTA9WwLq1WsMswRgyYB4
 jDHZvBh0xrPewbnxIxtC0a1ixD/gvp3+JaU9buMRMTlYSC2BP9p4F04q/28sRlDxh5Lt
 iRFnrqklipYdwyMryg34VLpBFht3j97CF69mGv7tCc6Z2opoNdfNavQhduFn1yhINZYE
 8B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cLZtFkHMbed+rABy5CfV1sfDkxWh/w6w89VAEQBWMBM=;
 b=QzMhMy8Qr7nEghLGclisrqtW4/ByVUh6ifLfW9cyIL7yp6P2yrym5sQbPNIY2F2HDX
 3l21/TK8Ff3VLw0UI+mCe7ToiPmerPio0rWabCxv7PGN8K87a/IIabWPCw2G4CIDPIy3
 zhX1qeRKVenCmQKDwch/27xX2ygOT3FozbIZuri7kDRG576T2CTVArCXm1foVLvnSRPU
 G7l528kbjDQUsi7PhKUZoF852IoxhJRsQVfHpxChd2b2JOv3y2E7FlHmz7am4WcxwpJG
 bRjWNz+/m0oo8QVzbQ2hmqivFN4fm5emZou+vb/86eO4Fl/e2BDxxMO5Gow7T4nztiuc
 NYgw==
X-Gm-Message-State: AOAM533KRy5qaoKfcVj8gJhIymiwXdpYK6xve8Zjcvpaz0PBRoFBzekA
 ub3jeu5PDnPcXDPCcN1M4zk=
X-Google-Smtp-Source: ABdhPJzOhLZJW9GPyDZKcQlAB8eHO6X0CxOC29ay/OKYLuVO7/SklISGxX8hQQ49RL96j6DC7Va1dQ==
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr178797ljp.97.1612914505429;
 Tue, 09 Feb 2021 15:48:25 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se.
 [158.174.22.164])
 by smtp.gmail.com with ESMTPSA id c25sm23779lja.131.2021.02.09.15.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 15:48:24 -0800 (PST)
From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
To: David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/3] drm/radeon/ttm: constify static vm_operations_struct
Date: Wed, 10 Feb 2021 00:48:16 +0100
Message-Id: <20210209234817.55112-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 10 Feb 2021 02:06:04 +0000
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
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The only usage of radeon_ttm_vm_ops is to assign its address to the
vm_ops field in the vm_area_struct struct. Make it const to allow the
compiler to put it in read-only memory

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index c45e919e03c5..5fc8bae401af 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -835,7 +835,7 @@ static vm_fault_t radeon_ttm_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static struct vm_operations_struct radeon_ttm_vm_ops = {
+static const struct vm_operations_struct radeon_ttm_vm_ops = {
 	.fault = radeon_ttm_fault,
 	.open = ttm_bo_vm_open,
 	.close = ttm_bo_vm_close,
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
