Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D120BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 17:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A21510E1A9;
	Mon, 21 Feb 2022 17:55:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB08310E57E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645465072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DzRKkl9MBsnLJO0MZvrmofSvJyauAO6DGXYWnBBejVM=;
 b=b0hII5Bxt/68demRYwLwR26AX55iKyZxLl3Hp3iFbUYSBOn4+uKe/jfQfPwa6OU6fDBMZt
 Qm3Djm7mIxKiXOa/1EJqEOBSBsKURIu0+yTr+q559455Q/+OVaDByomyUqm11ujmD6IY0x
 as3wFkw4XEZAQuWaYp5yFlhCeXVy/F4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-Fqj_8UULOGOZ0dUwvf5ssA-1; Mon, 21 Feb 2022 12:37:51 -0500
X-MC-Unique: Fqj_8UULOGOZ0dUwvf5ssA-1
Received: by mail-qv1-f70.google.com with SMTP id
 kc30-20020a056214411e00b0042cb92fe8bbso17872805qvb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 09:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DzRKkl9MBsnLJO0MZvrmofSvJyauAO6DGXYWnBBejVM=;
 b=ndpCvdSjzPo0PfOPGTmvEWWl7LYqx7PPO4gqtPwA5soCsMxcOMNOkziKFGhok1Aphv
 XFZSUU+8a23WsnO6qn1Dw34aUSuY9BRH9UDTf/VuMzMtE4RJMVZ7OmhGdcvTxrd85QfI
 q+bvODmRSRixu6sATEz30YAdcrnwWaw5vbPmBmjyG1l5Iz9wxiiG1lEG3r1bBuvy/cVm
 Tkr2+JW91cH4oZV1ygYHk+JrlXJV6T6fgKqfAmoyXoW6iXg6RtfdsuhbHQXdyYJs4rHL
 KA22SVZPQLbglGiwoMO2qXaboM2IyT2OyuHTXsq/+Ak63H9megfM2/ab0qRaGyk6rDee
 d5GQ==
X-Gm-Message-State: AOAM532UdL8MSyndjV8tb49F8z+H+p02QuxaS1ABFPtyB1ROZNm0/Xa1
 RobSV1GBS5CQcJU5tITAXeLPRgj5LLtLKgXKJq7T3vbZxMNyPLR8UNnz2XOOdHuf7xaKHJcfZtL
 q+fcDoR0ORrtKk+euyDEdY0Spwg==
X-Received: by 2002:a37:674c:0:b0:47b:8dc5:df77 with SMTP id
 b73-20020a37674c000000b0047b8dc5df77mr13055132qkc.95.1645465071278; 
 Mon, 21 Feb 2022 09:37:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXF5C5Kq2+dKAFlNYYC/4KY8Ajcg6ukvTAULE4uB/5fl5oE1UylGbMhdwn4F9QcBZp1i/H3Q==
X-Received: by 2002:a37:674c:0:b0:47b:8dc5:df77 with SMTP id
 b73-20020a37674c000000b0047b8dc5df77mr13055105qkc.95.1645465071015; 
 Mon, 21 Feb 2022 09:37:51 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id v15sm1895466qkl.37.2022.02.21.09.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 09:37:50 -0800 (PST)
From: trix@redhat.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, guchun.chen@amd.com,
 Prike.Liang@amd.com, Hawking.Zhang@amd.com, luben.tuikov@amd.com
Subject: [PATCH] drm/amdgpu: fix printk format for size_t variable
Date: Mon, 21 Feb 2022 09:37:37 -0800
Message-Id: <20220221173737.3725760-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 21 Feb 2022 17:55:44 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

On mips64 allyesconfig, there is this build break
amdgpu_discovery.c:671:35: error: format '%ld' expects
  argument of type 'long int', but argument 4 has
  type 'size_t' {aka 'unsigned int'}
  DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);

For size_t, use %zu.

Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7c7e28fd912e..58238f67b1d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			    le16_to_cpu(ip->hw_id) != ii)
 				goto next_ip;
 
-			DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
+			DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset);
 
 			/* We have a hw_id match; register the hw
 			 * block if not yet registered.
-- 
2.26.3

