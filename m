Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44665C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCAC10F35C;
	Fri, 28 Aug 2026 11:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lst+jwYv";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5D910F35C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:28 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c25099bb1fbso112194066b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917287; x=1788522087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=toqD9yS0aYvgqBIcQFoCiKlSBYjMGjd2jy5czfHnOQY=;
 b=lst+jwYvITursjbAcaC1seHA7Gh/jYYxLIYw3/qvUHFp245ccmD9eRja7WyoqGyKmT
 J7gI2CykKbj1CxfmhfjK3+oLhUtnyly5CAjR9L39rouB21IPNKV985o+nnplCIFMDTwa
 c70QQt05KG+2fSzJ9Q0neC1hvCazKMQ5+HxS6QN6RNe7wlq3ytZOExWOtzc+cEOXUfvE
 d7xlcbwMsD8T1mjcL7YIwy23zUEdPs26nep14hrjwqx0DYOgMIWP8IeiMIIWLbotjO7b
 KnJLswKJpMni3SPzynMiNVndLiondGJ1V4Ra9d44JUJeiOKVkMDstoxFQ5LeSrhMAtYm
 W4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917287; x=1788522087;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=toqD9yS0aYvgqBIcQFoCiKlSBYjMGjd2jy5czfHnOQY=;
 b=B46gARzz0+ZarAM3wKYNJKhBF4q2QwVwKR/2A+NQo8mmec5P6btUd6H+Kn1z8Y6j8U
 4VHsfRmqKWuqTN4SSDbLZvu/SlU7M/nQOky0jJFItCrUdSY9T6Pc62PkdOoOJh9xYti/
 K/JM97hcMwZDVvsv+IujrTMHrEYXJhlemA1xbXTOKYCxmlkLIdhriXSRZDjuq5C0xuPW
 jy4LKWTAfgXqutij1UCxL61Ppk27rmwgwUUXEqLisJvpayQGhRFszXBvh6LYRzt955vy
 h3cD6r/8Bogmeb+8n+ujtwLFePBKMNt2DAX8VWBb7gKXTdowFUnpTagqHZmtdRB91a5L
 VV3A==
X-Gm-Message-State: AFuF++kApP5qxBnbPCax2+ndfz8QaNKDxbfaSj1DWFg1HfVKC2c8iypb
 ZpA91WbCNmQTdh30b9yZHcmYjZsVKhDaSeUcOIcL1yROAsP7b18pdAG+svgifV33
X-Gm-Gg: AR+sD13BGojVLiL/v7sdN0z9IalBqtr7iGzPJb6/jyshUTvtpqEPAOgj9OW3dEgJbbk
 D9BdN4z+Ejv1FTFuS1dD434M7NkJmsUCj/dmMqDuXnt8hOzUKjA2jiXrRLdMSQZQL67pqw3vhaY
 outJ+heDlgWCTQ0BqlCQC7IW7Mshg9S/0zwVUzmPX3gxqRMtEyA5iQI+PTZtR59lEZavwUO2pmf
 YKPsqS4y25CKNIug/TGe+T8h0qB3uVKngGsYyCajKPoksnH3FEmrbF51rfCtJQCdJhHfoyyu6Vr
 bunp1i65hEQ/077neywayGQ9sOiwMHaXoDTbcb2X2b5froGK+BcVbp+T5iuKUN5o+mwqy9vgva0
 sQ6vW+b4pkBEvJ+tQeH5ijl9Zu6Jphsda83rJng0840hliTj+4j88BrPA6kSTx2uWUBTS1cf2rP
 +wJjlS1fTC3oR+bihX0E7VKYaoUsKm7YhwguFZIwu10qR1EDPXAoAvS6CqmlBEc7nRoMFnYEyJu
 vX0+YuBD0euwafipwW2FeAb
X-Received: by 2002:a17:906:fe04:b0:c24:c24f:e176 with SMTP id
 a640c23a62f3a-c25571576e4mr374100566b.15.1787917287213; 
 Fri, 28 Aug 2026 04:41:27 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:26 -0700 (PDT)
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
Subject: [PATCH 07/11] drm/amdgpu/gmc12: Pass cam_index to retry fault handler
Date: Fri, 28 Aug 2026 13:41:09 +0200
Message-ID: <20260828114113.13523-8-timur.kristof@gmail.com>
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

This is necessary if we want to make use of the filter CAM.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3add79c474f3..988dc74642b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -99,6 +99,7 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 	bool write_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	uint32_t status = 0;
+	uint32_t cam_index;
 	u64 addr;
 
 	addr = (u64)entry->src_data[0] << 12;
@@ -110,7 +111,9 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
 	if (retry_fault) {
-		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
+		cam_index = entry->src_data[2] & 0x3ff;
+
+		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, 0,
 							write_fault);
 		/* Returning 1 here also prevents sending the IV to the KFD */
 		if (ret == 1)
-- 
2.55.0

