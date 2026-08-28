Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D00BC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A7B10F357;
	Fri, 28 Aug 2026 11:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RJmAVuIR";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE40210F347
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:25 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c160420289bso126153666b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917284; x=1788522084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xi9JleZzXnB9Le4soyl69Pf8iFvA6hvwk9xu+2RMpZ0=;
 b=RJmAVuIRAJ7vCPVVVM7zdRIABGHb7+1VpZrTDP91KqUu52hGiF2j3XcJ9qecUVxDKv
 FpLBO43pi9EbNC2JEJNGSiD7DArv4hDOxToiWuJ/rEOhjTliNfZAkSvrBL+LKfcAShvW
 RpeJb0ak3C3d4Dsd0GmLYGAZx91XRFihStfReVbzUre6Xq5bna2WQPN9OOvLBXormGG1
 9UyyCitH3eUm4IHOIbpNTnyIdCDnqgMhGrBGGqKkwhJhfbEmaD4LGeRLPDzLgHWNrkxm
 NIqAOmk7vTnZEO7edaCKJrs3S3ErPz5hiv7YJLDVy+Yz1IHRKRz+V+hioVJxHMYWC9yq
 GWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917284; x=1788522084;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xi9JleZzXnB9Le4soyl69Pf8iFvA6hvwk9xu+2RMpZ0=;
 b=URqbypn83LT88fawtMfP/G8zcpx4AC4QXRucze1iUbyNhPtubE0bKr3rMdN+oxhH6W
 zqmCnIxhi6pS3o+tr14E59Xl7twE3XY9GGRe36q2RUmRXe+YGA1Hzv26jyrXdgsfALUD
 BBXdXdrvWpBXhm619AR46J68j2l/2U4Xdg5DkYQw72Tcu8z4Cb6PZ77fKt8YG1jhBgUo
 BZ35/aQofsXYsPHpAZ/CK4pwCFajseK/KGA0+xLvf3cGj5v1/B6QKPqMXdflZECqs9YZ
 bX9yt5Lvn5sPqK0amk0om9tt7ubt5comJbhCnU2h8oUCDwx/EVkvVDs8wKLY3jRqIGZz
 BEuw==
X-Gm-Message-State: AFuF++k4ETvn6vAqEJz0gLNQ39RLszv8GmecCknXL6vzaXyCGQVvEKOa
 i4EvzHtS0n6/mrFY7dit67jkNaHQPK5qxJBvTpRCXq0Iv+O65giZ++iD0S3/ozk2
X-Gm-Gg: AR+sD105uK7GrBQJaxJvRrpdtx7CBDqYDwRd1h/Ay2mB+4YZI9UeewTil1bri4VkX/5
 tNagmBwRlcIajgvI14zlHqgHmrBMoAhwyUFCD2d4dwm9oxzlWYgUnKUzqfw4xnWnOwlPGDQ5jld
 D6tVYOiMP2uu+MFJ/0Lp1OrmgIHe32HocoxsEgdDR1/UHPIBTO9YN0ALxS7FXfnEYupirhpubb2
 Z3l7p7zbS1DfdMnYsdHt7qz4gkKNEy1mGvDGhHF8Cfw+WqSLP2YQGwGS5PsTMGmjs27KbWX3r6x
 j8y8H/Lml7dpMpGJI5st0jvfh2OO9DmJAmyKzKMd3m/iNHvGUQtCojEfIjvdvEye3hL38SqVN4H
 uBt/MdCQztmvbNJVz09zQxba3vp6iihtvGrabtE8LflrQaaCIWKe9Po2nIBWuqr3Oa3P6CfKaPb
 Vy1ZiImFF2+mxqwlkXOZWbPD2NXqsqg1nYe8QQCONbLJHPyJ7ockZs8SldXTIqds1q37sQOzygN
 uiEYAFD8nNX/DPF0QUWKK+3
X-Received: by 2002:a17:906:478c:b0:c25:376a:a16f with SMTP id
 a640c23a62f3a-c2556c24dfemr400393966b.5.1787917284133; 
 Fri, 28 Aug 2026 04:41:24 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:23 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 05/11] drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring
 instead of PAGE_SIZE
Date: Fri, 28 Aug 2026 13:41:07 +0200
Message-ID: <20260828114113.13523-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
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

When there are a lot of retry faults happening, the soft IH ring
can fill up really quickly and possibly overflow. PAGE_SIZE was
too small, use IH_SW_RING_SIZE to match what other GPU generations
are doing.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index f271bc8c4859..741fcef3cfa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -599,7 +599,6 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
-	unsigned int sw_ring_size;
 
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
 			      &adev->irq.self_irq);
@@ -631,9 +630,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* initialize ih control register offset */
 	ih_v7_0_init_register_offset(adev);
 
-	sw_ring_size = (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) ?
-			IH_SW_RING_SIZE : PAGE_SIZE;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, sw_ring_size, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
-- 
2.55.0

