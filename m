Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C80606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMfAsoA+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F049112460;
	Thu, 19 Nov 2026 14:11:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459D810ECF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 05:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795067656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yy6UPA1x+dgBp1oYwsbJqoBQ2EhZbFzvPu9SCMCc1gU=;
 b=WMfAsoA+zqI328xpzbFsLqOAZzCvooGMABpLQ33ymrnOOwSX05qJvals8VixrG46LmwZFk
 eJB+vJraLjLBSnUqvCKW9oRJ+wKODxhlhoXtnMix6uFmjrTSOCHzRamfbl5v4QOgBJMdSI
 BRQw4W2/2SI17XASKU3e19IGLfida8Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-PcjgwyrJN9yblOj5Haa04g-1; Thu, 19 Nov 2026 05:54:14 +0000
X-MC-Unique: PcjgwyrJN9yblOj5Haa04g-1
X-Mimecast-MFC-AGG-ID: PcjgwyrJN9yblOj5Haa04g_1795067654
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2efad644688so16787865ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 21:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795067654; x=1795672454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yy6UPA1x+dgBp1oYwsbJqoBQ2EhZbFzvPu9SCMCc1gU=;
 b=l2n5XqLrtR1/0AStNmnPSQDSNiUlYrgY3f4vYlzs21ZXGsbLXNlsKIfL0/EDYMVV+N
 Fs5Ffgxd8HuTErQnEIIBB8YJMMy12K6yznQ/bw/7CGSogjvrNeLenBGKUpXfQ5kfzWdc
 jgZkbS6HJJpF8EL8EM3m/HlbGB2hO7nQ5ZwTqQtnK8kFmWMusXviaVqe1QNW1NW2eSqx
 9F2R//S4X9lb8ZeVYPX70CTFnr+ZczAhGxxnMAJ9wOeMpr8tTyZbPHJ/fVJxzzuaxkBO
 v5Hgjnzj9LJYTmrrLVFk3QObfwTZbgc6reLXe43xsTWtubFOV5rO7e0PXEiQ/pIf8ev6
 MXVw==
X-Gm-Message-State: APuU4Z/zZJakJNPql6rodtlH9OhFEOKv6JE8ekzKuubX2fmsmMulMQY4
 mhG+bLw2I4D8uSipb0/13ti3CCpbGnRU1luZWWIqPCtEEbEtZVn+1cmUkzP6bAz8lrOTFNrwI/N
 uMDcB4ybT9ml5hMPuVzw2q4iUpRmfetxvPMhargVy+sqXfAqyyOnF1cNwoJxLEuxYE2kSy4bU42
 L6IQ==
X-Gm-Gg: AZFdTZdsFfUrARtQqGVioyRPQVyg5/5MWCZxF/NZZAFJtwISy/BU3puj+123n1SPuyL
 x/t2D0dEMJWvM+aRvqjotynumrVrBf6qk0M1qh//F4CIhyP8Ay1OGeWTg5/yOnNx5Lv29hsm4qI
 CgEz00Gnh9gdc7Bq+4QKYOlgrs9Tsa4cCEL2v+9j7NfXydkKqk++NHd+Ygd5LG9n9Uoj9KU4YxE
 in0JKm0D64J0IKpjBsBmObsYkpY/d/BgK3EidIZpcpjoY6OWhAekNZrG8x/bASDMKqeJePDu4ee
 geU5YHDK7RobdbCjJB5ufa/vyoYWMkVEc3vcmDaLTgOY0mRWH+WY4EDHKsJxEpGU1T/Ev06iLxP
 GGzUcJBeJt6N40qbE/E5XD4egcjOmY2ACgmX3Qhw9Rfy/OX38bGD8oiD2z7tsVViT9MnLWPb2A3
 I4m1CtKXKbC/8BNQ==
X-Received: by 2002:a17:902:ccce:b0:2ef:f652:a08f with SMTP id
 d9443c01a7336-2eff75352b3mr49821545ad.42.1795067653645; 
 Wed, 18 Nov 2026 21:54:13 -0800 (PST)
X-Received: by 2002:a17:902:ccce:b0:2ef:f652:a08f with SMTP id
 d9443c01a7336-2eff75352b3mr49821325ad.42.1795067653185; 
 Wed, 18 Nov 2026 21:54:13 -0800 (PST)
Received: from localhost.localdomain (122-63-66-168.mobile.spark.co.nz.
 [122.63.66.168]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff6183f8csm23799715ad.31.2026.11.18.21.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 21:54:12 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, bhawanpreet.lakha@amd.com,
 ivan.lipski@amd.com, george.zhang@amd.com, adrian.betschart@cinemaone.ch,
 rodrigo.vivi@intel.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: [PATCH] drm/amd/display: Fix pdev lifetime in
 dm_test_conn_init_ctx_alloc()
Date: Thu, 19 Nov 2026 18:49:18 +1300
Message-ID: <20261119054917.184758-2-ltao@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x7BSgV_Xa0V84zOd1qITNKVygCRye_bEoF2a85HtEHQ_1795067654
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Thu, 19 Nov 2026 14:10:22 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pdev backing memory is currently allocated with kunit_kzalloc(),
which ties its lifetime to the KUnit test context.

However, pdev embeds a struct device whose lifetime is managed
independently through the kobject reference count. This creates two
independent lifetime management for the same object: KUnit manages
the backing memory, while kobject manages the device's reference count.

Although dm_test_conn_init_release_dev() is currently empty, the
embedded kobject still relies on the backing memory remaining valid
for reference count operations. If KUnit free pdev while its embedded
kobject is still referenced, subsequent reference count operations can
then access the freed kobject, resulting in a use-after-free:

    refcount_t: underflow; use-after-free.
    Call Trace:
     device_del+0x29c/0x410
     device_unregister+0x17/0x70
     i2c_del_adapter+0x128/0x1b0
     release_nodes+0x4a/0xe0
     devres_release_all+0x9e/0x120
     device_unbind_cleanup+0x26/0xa0
     device_release_driver_internal+0x1b6/0x240
     bus_remove_device+0xfe/0x200
     device_del+0x179/0x410
     device_unregister+0x17/0x70
     kunit_remove_resource+0x93/0xc0 [kunit]
     kunit_cleanup+0x49/0xa0 [kunit]
     kunit_generic_run_threadfn_adapter+0x21/0x40 [kunit]

Fix this by allocating pdev with kzalloc() and freeing it through
the device release callback. This ensures pdev's lifetime is managed
solely by the kobject.

Fixes: 7db85e4b053c ("drm/amd/display: Test connector init")
Signed-off-by: Tao Liu <ltao@redhat.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index f09e2a72c534..b43c4eff2bef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9659,7 +9659,9 @@ static void dm_test_fs_caps_disables_replay(struct kunit *test)
  */
 static void dm_test_conn_init_release_dev(struct device *dev)
 {
-	/* Backing storage is KUnit managed, so there is nothing to free. */
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	kfree(pdev);
 }
 
 static void dm_test_conn_init_unregister_dev(void *data)
@@ -9667,6 +9669,11 @@ static void dm_test_conn_init_unregister_dev(void *data)
 	device_unregister(data);
 }
 
+static void dm_test_conn_init_put_dev(void *data)
+{
+	put_device(data);
+}
+
 struct dm_test_conn_init_ctx {
 	struct amdgpu_device *adev;
 	struct drm_device *drm;
@@ -9702,13 +9709,20 @@ dm_test_conn_init_ctx_alloc(struct kunit *test, enum signal_type signal)
 	ctx->adev->mode_info.num_crtc = 1;
 	dm_test_create_mode_props(test, ctx->adev);
 
-	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	pdev = kzalloc_obj(*pdev);
 	KUNIT_ASSERT_NOT_NULL(test, pdev);
 	device_initialize(&pdev->dev);
 	pdev->dev.parent = dev;
 	pdev->dev.release = dm_test_conn_init_release_dev;
+
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_conn_init_put_dev,
+						  &pdev->dev), 0);
 	KUNIT_ASSERT_EQ(test, dev_set_name(&pdev->dev, "dm-test-i2c-parent"), 0);
 	KUNIT_ASSERT_EQ(test, device_add(&pdev->dev), 0);
+
+	kunit_remove_action(test, dm_test_conn_init_put_dev, &pdev->dev);
+
 	KUNIT_ASSERT_EQ(test,
 			kunit_add_action_or_reset(test, dm_test_conn_init_unregister_dev,
 						  &pdev->dev), 0);
-- 
2.56.0

