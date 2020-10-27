Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8908C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 19:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5328420747
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 19:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVWQEmws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5328420747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E9B6EC35;
	Tue, 27 Oct 2020 19:54:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111F16EC0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=l0PCwDa1wHGV+Q/jQHXorblfnJ1kxgpeCNddFrrP2u8=;
 b=DVWQEmwsHVuNj1CUczWg7D0aYOyzxiZFqWZYzi2iTK+zx7YUo7MpklqQRxPHMAdcHMdivf
 1r+E5ThCsrFAPM9ujIFs6GF5LJB4auyTjTCyqnkMVTpUeMRj83m0+A4D6MwZRgl+sKCZLj
 9hmMJDyGL1xd9Ss5uzTetxArIuLeQ9M=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195--KAQ21tVMXuc9RaLbw3tJQ-1; Tue, 27 Oct 2020 15:07:33 -0400
X-MC-Unique: -KAQ21tVMXuc9RaLbw3tJQ-1
Received: by mail-oi1-f198.google.com with SMTP id w192so1111732oie.20
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 12:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=l0PCwDa1wHGV+Q/jQHXorblfnJ1kxgpeCNddFrrP2u8=;
 b=smf57lnkv7KvZZ/mmxr3GeCGL+F8Xch2bmsO3lNyqrKegcXvWfpX9EJggAqK7+fmPq
 /j3bvhvzKqibcTe9wPF6GkFsDemewrAJQ2aJoZteEDHTdClZNhtq5Awwyj0/WJbX9cTu
 jpHF8GUITDjlOcAy0dmo6vrQnmuKoxE7IIXUMnhIkxetTne5LsEbrlogZ7PT/iNTCu2g
 iW2hf5C2vnabZW8pJ6JDAl6Wg8BfyUC0FCXTmZS9CrInOLBYCJeiJMqnfZ7yqkzuSKks
 1W/MadGns4XtFQeSxLzXYP1sP8OUDmB0e8S7mDo6NwhfVkaUXX/QHBUfdikCtmmsP4E2
 om0g==
X-Gm-Message-State: AOAM532v9II/2nhiGJhThnomYntiElUfSFwnUIE+6O4SmGc/fBdAnZCR
 5ZsqzNPluD7sMQ5MqEY0LFnLbKdxiAyaN5E3zNtpZ/Qf/uFnXHgWVgWzKZC48+2Nn9Jm7KyNwDI
 55C2hCw/bZJjFvDpe7WnemtPf+A==
X-Received: by 2002:a9d:491:: with SMTP id 17mr2601949otm.338.1603825652820;
 Tue, 27 Oct 2020 12:07:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWW33cuqBanM3RqWmNlIAsoMbT3S8VnWYdIw36FDCID2skFOgGdV/X/Ei7bypd9s6bTTHJSg==
X-Received: by 2002:a9d:491:: with SMTP id 17mr2601933otm.338.1603825652601;
 Tue, 27 Oct 2020 12:07:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id x83sm1765339oig.39.2020.10.27.12.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 12:07:32 -0700 (PDT)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, jonathan.kim@amd.com, harish.kasiviswanathan@amd.com,
 Felix.Kuehling@amd.com, zhengbin13@huawei.com, luben.tuikov@amd.com,
 Joseph.Greathouse@amd.com, Hawking.Zhang@amd.com, guchun.chen@amd.com,
 john.clements@amd.com, tao.zhou1@amd.com, Dennis.Li@amd.com,
 Stanley.Yang@amd.com
Subject: [PATCH] drm/amdgpu: remove unneeded semicolon
Date: Tue, 27 Oct 2020 12:07:26 -0700
Message-Id: <20201027190726.1588801-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Approved-At: Tue, 27 Oct 2020 19:54:19 +0000
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

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 1b213c4ddfcb..19c0a3655228 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -654,7 +654,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 
 	default:
 		return 0;
-	};
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8bf6a7c056bc..a61cf8cfbfc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -953,7 +953,7 @@ static char *amdgpu_ras_badpage_flags_str(unsigned int flags)
 	case AMDGPU_RAS_RETIRE_PAGE_FAULT:
 	default:
 		return "F";
-	};
+	}
 }
 
 /**
-- 
2.18.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
