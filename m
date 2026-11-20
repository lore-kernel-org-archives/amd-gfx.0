Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27264606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kQtGrPZo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162E710E028;
	Fri, 20 Nov 2026 14:57:03 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D0010E8A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 03:19:21 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-537548b811aso3662001cf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795144760; x=1795749560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e3wD7sDYHdJ5IM8Gjq16wv20BB8zD8yiMJqTnDWRVYE=;
 b=kQtGrPZo4lKTiEBE/y2i+wBx2dDYOG82R8orkrWpsXwImicYM0F+nDyWeFkf8RjFfr
 J/YbnzK37n1Gfxoy6oeBTHlZWRtfetNs75i9Ck6vAWoBEe8DYcVVZdjkPlMssyELWMZr
 V1TtXrXdoOwgD4PsSaT//1ucINZyh0WMY0UvLBlAH51ENWQ7k2MZ8DP1cJqgsGef3yvR
 tI3l1r7iRUGWN0Ud3siV3x5vFuoUUrU12U12/2GyBlZzomzEYRGTyJnNYNAY6RvC/wMq
 UwjOekIhpMaM8MOYAjfI4IArDKk3Rx++0L5WY0fwigh0yqWMRgaGk+xk/6rW/L52C3XD
 8jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795144760; x=1795749560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e3wD7sDYHdJ5IM8Gjq16wv20BB8zD8yiMJqTnDWRVYE=;
 b=fGISvGtqZmAFzFDhA/14Mzv+OLCoAfOqM6+njwDKeDpW2X7FWrK30tNW/+1lsTwX/I
 TObk2K63Kd+P8nivFqK8x5An+DDkGGLEAdABnaOmIUlykcLfgeq01Rt/mAOP4JDnKXA0
 MY2tGxMElFBCPQJecTN829Bf5tqPMF6a985uP6JcvjvlIsedLEuQhpqtuYIorFWCRqrr
 /UlZC5omHxGhvNAX4K3mRm5NiXSRyDB/ap/nK8NM1pEwZzr9B8IsaTwSxH9sbA7MCSsD
 r80DYqczIE/B9z3vR2UuXUisiejTa3tw+yiVQnKftWzZfWfl4/6NLT3UumdlAaGkosNd
 lFEw==
X-Forwarded-Encrypted: i=1;
 AL+hErHLMAL5V+zFyL7MAHQbC7DNSudo2wuWVA+SM79l/KEte1oYfjFLBNXyxFntT008iA9Eql+ulG9w@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dlOnGln3h7CEo/LDHf3GOpDvAYWTaVDZ/byOlonOq186ri+9d
 x1c7bcGfHm0N7hZL6fsGsx/Kux1JWYQ1lkrsEUPJyEWkPoV0Rtg2LVgp
X-Gm-Gg: AYBFou3FKES+sWPg2ZNPL8L/+f1Bg9b4LOeDE/sEr58hILg+Jw1sQMtk6QltECfZMve
 JoeXpA9Sj+xILpRwMDlsaOVf3j2kUuzPVOW8akgnqQKnqXuLbwHs6srftfUW7DuZdiKCzDGHHty
 ruehFIWGh4+UvdkIwAIGqImvwBmOvcbLRowPgBosKtlQIT8q1eFDZVWHis5jBYkgBamqCFGqQ5V
 uQGFcJwDDxr7o9S92B0Q3rhDaQMS69BmLUINrtGLmnjwGEdeLLTVgQ/kHPUC2jDG9cJi8Z364on
 NgoxfCQ/tfnzF/ErP2zcr4JQBH6cvP4BxBNVuSHT5Qy9MoBdJk653J+TXiw18SThWkbVlqNM2hu
 PTZ75xAy0qhq0+wdsssKc5svGBPAqZsXOrGnk7W4K4iif/VyeC19SeXygb6JnEosym7oXdZ0ARv
 6miOfCIuV8J5m7kuVYmol5lPg2GnV91wMhnWAoI5UQ79IEd4dJe1a0Nd9bnSsZK7CQffCqhUQa+
 SFxamc03BmoNI4CccrbxqyhpTzjOZZpnuGmH9shoPpo5zExZ74DgFWm5z/82J24dfrH8/pyGdzh
 CqrgpfAAxc5tWDmUEDBPVTEU4nYGga3TyeUDxb3e/uTStMTx+ImCxxxVU/RpOfiCG2pKU5FhVk8
 =
X-Received: by 2002:a05:622a:5c1b:b0:55c:abad:a72c with SMTP id
 d75a77b69052e-55d76a6260dmr33689941cf.56.1795144760510; 
 Thu, 19 Nov 2026 19:19:20 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349f6959sm14377356d6.31.2026.11.19.19.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:19:20 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] drm/amdkfd: lock event_mutex while counting events for CRIU
Date: Thu, 19 Nov 2026 22:19:17 -0500
Message-ID: <20261120031917.1708024-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 14:56:16 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

criu_get_process_object_info() holds p->mutex while counting events
in p->event_idr. Event creation and destruction use p->event_mutex,
so the event IDR can change during the walk. If an event is removed,
the walk can access a freed IDR node.

Hold p->event_mutex while counting events.
kfd_criu_checkpoint_events() uses the same lock when walking the
event IDR. Event creation and destruction do not acquire p->mutex,
so taking p->event_mutex while holding p->mutex preserves the lock
order.

Fixes: 40e8a766a761 ("drm/amdkfd: CRIU checkpoint and restore events")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig plus DRM_AMDGPU, HSA_AMD
and W=1.

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..20e3bbd073a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2234,7 +2234,9 @@ static int criu_get_process_object_info(struct kfd_process *p,
 	if (ret)
 		return ret;
 
+	mutex_lock(&p->event_mutex);
 	num_events = kfd_get_num_events(p);
+	mutex_unlock(&p->event_mutex);
 
 	svm_range_get_info(p, &num_svm_ranges, &svm_priv_data_size);
 

base-commit: 8dd68a79583aaf6df6fe4feea3ee9e9f26b02993
-- 
2.43.0

