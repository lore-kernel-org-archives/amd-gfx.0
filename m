Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9649C61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2463C10F347;
	Fri, 28 Aug 2026 11:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QpVU3YVd";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D9710F347
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:27 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c250f28f1cdso126605466b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917286; x=1788522086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8EjV4QotlCv+yS3qj41eFMdCQ+D3mFOTFoQOuQmtV+M=;
 b=QpVU3YVdpfqvQDYR2X8b/AZ4zY4juaQ8SR2p0bOhSesXT7Esa4t+vYtNqhR7DiN3NJ
 Sk0IVo23xDo2ATD4TLNEtXe+eVvs9dvoyjMWoNdQTIDNItLtzM5fnbzvJ/iSJ6dnyO5T
 ajCuD6/yclqvwtKRmQQVg/b4fhdS6bbMv64D1f67ccjjApyeha+a6VRD40liPL59KcWc
 HhSbE2TISeHXUAER38emmvNK+fQCTk2KdYqBqmLz4tO14Y4HKMwKsM+r6LHrzRG9XlUa
 wmPstrGCsAQX3eytv+vMqSB+Ao1X+Hqerq8ZqMwWrNo7icFQ0h/tHyVPH80yAZGB80z0
 SXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917286; x=1788522086;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8EjV4QotlCv+yS3qj41eFMdCQ+D3mFOTFoQOuQmtV+M=;
 b=fZqpDXkWTAJeTXHvQVdN9Tu3aBDYeNWvQdF7W4yUsP/u/PNJw6huKfqcjUrkRXTF+8
 v5kov3SGVi/z44R1zjIKEeQfycxcENPhj83/ar48ooSNts/LNyuNT7oPbjd/HBTJWzqw
 lQ63UZS706lFlGYMFmayCEHO5egYBI84xkk75LPKLzUURZ1f6bWl7JsVYVoWUOdnSq2o
 a7QhORrrxXEoGsA4rMv9yawh8DLFRgfee8aXWGEbBSIqIp4Pp9FwiAYFGQpRXpQAFEgm
 x9BtjI1gohAPKxvQI4F1OwPbTS4vQtFS4JECs5VUNY5c9jty+Vona8OZBRzGa/MygPIA
 /OoQ==
X-Gm-Message-State: AFuF++l/qVGWaeomqCoK7m22PW35Vcn5kxq96SMNMnIrSuW/N2tQryZO
 t5M3KBpyoQmzNK0dTboGJjlqNsse1eyWvYITsslZKsTut03RfRDJ0Suvo/KnDke9
X-Gm-Gg: AR+sD13aXK3EgEBxC0i0+/5qezOoUUkQagfSn8eIQ4/pqKSwz1cPghmdCOSlz546UEW
 +AUWpONYMcYqo0+DL4QfNhA9WXsrKhQDSquR+y5EmeRgsSdBP8yyfWYhkxvudwwnRPZOkkwdUNM
 gwaTw2rd2FKqmf1yfqCVRsdGylla2Hu0Cz9YaH54OZIcm3PrGqMqe8cFzsGJW2O4MxTlvGyko9I
 ASsNqDI/9JkM+cBXuULkTwccrupa0EeijZbUdqbeDmpw8boQ0Y5Tj2JOlzrXXgk07R/vp5Fwv13
 tq9XCtHnhp4ZpFA8M0xYOMha0xvAXL5bb4kpuHgTWws8739Bo2+hUUx/3Kb0y34qIAEf/0aQORP
 siYAnTVKK2wqoq5gMnnupq2MtBaudismdwDuMc/8LKgW4DcEaBtOZwFZpgf7eU/fLinilJCAjj5
 wGopmwPWWgrKqbF8sPdLZdbNrFeTj3tuhbd1g/6lGWdupDdCrYNSPynNcb10/WS1BmRhCNbEym/
 yJRRfzd8zpJU6/NrKJNJuzuuA==
X-Received: by 2002:a17:906:2099:b0:c25:64ea:4d70 with SMTP id
 a640c23a62f3a-c2564ea50c7mr188809366b.1.1787917285583; 
 Fri, 28 Aug 2026 04:41:25 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:25 -0700 (PDT)
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
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/11] drm/amdgpu/gmc11: Pass cam_index to retry fault handler
Date: Fri, 28 Aug 2026 13:41:08 +0200
Message-ID: <20260828114113.13523-7-timur.kristof@gmail.com>
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
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f454aff831b0..7fb97be16b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -108,13 +108,16 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	bool write_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	uint32_t status = 0;
+	uint32_t cam_index;
 	u64 addr;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
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

