Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C044C38A2A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 08:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0185F207DD
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 08:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7VYxLIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0185F207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19416EAA1;
	Fri,  8 May 2020 08:48:55 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56676EAA1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 08:48:54 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id 188so9364118wmc.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 May 2020 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s+Cd44/CS4LXU8tbl29pl2FkpUH4mA+7y1eC2/YKdoA=;
 b=I7VYxLIFozuUMdHVdegUwCwHSJlpeqzb84CNAt+xoKTdEaRT5no5gQnzptdA3syH/M
 +w1LeofgpgbrFkRBYOBi6vuFREvj1hSu4JkLtjuxug7EUQXvsLZ6U960oswE26CRrrIi
 pplAfmMqn5n5ACS8kAlGRIjPGSDZdD8N2FqC4ZnShBzP/t8gY9arxPCEd3rsPXbuVEJu
 hZHa/gSEwP5qq5mA65HzPksberj3/7loGwfoKI5DMtNQYKt1rZvoNzI60w868Hg/zSJO
 Gk+hApugVLt4/NXE4HKDzBw8RcjVrgX4sotoyCoxB0EkEFfqxWWyJUtcTpEDPA7sk937
 Pg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s+Cd44/CS4LXU8tbl29pl2FkpUH4mA+7y1eC2/YKdoA=;
 b=czSeAojrAWbLrbtjerVgpLWhLdxovNf6vRqhYtR06gvxh0/NEU38KHmbvGxmuRLi2h
 QbB2R8AwzuF1C7gaa1GYSpA/f0sh1Jq3BCYUoW1hXza63BIP8Sz2bT3CvjRhsTQV8MzL
 s8nrQlD4wGv9+5j5MpTnrCnAIdJl/QzjL3JO+jzqvzrmAQF+gxHjFm+fsVHEIZODSCZI
 DhFk20jEF1BDGXlLiSxviyr8sEcpX+OPlzKyKyG0d2J5Wbbu5EgCX0BMAGruwnQU3WZp
 yW6eF5Kay8GTaWOoME4FqFDlgddY/368Qrzi1w6Hxhl+eUdwA/r1e2KgG9OAqZUqJn9e
 Nrew==
X-Gm-Message-State: AGi0PuZFXJa0RLqryXcH7cd1XLbkhpt1KMzTce/omAks06Mo9Is7ppPF
 YH6u1oUJFg9k1UwSPaC5FEf95Wqmyas=
X-Google-Smtp-Source: APiQypJQiFGlwBXmnEDQ1cWsdHXTW9tnAcLa7AuozMqcBfii2wTUU6yH+oiwl+FxWIOnsvhui1KhKA==
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr14151598wmn.81.1588927732925; 
 Fri, 08 May 2020 01:48:52 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F2302003937D8171F6206EF.dip0.t-ipconnect.de.
 [2003:c5:8f23:200:3937:d817:1f62:6ef])
 by smtp.gmail.com with ESMTPSA id e9sm1877002wrv.83.2020.05.08.01.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:48:52 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: cleanup sysfs file handling
Date: Fri,  8 May 2020 10:48:41 +0200
Message-Id: <20200508084841.10157-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Create sysfs file using attributes.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++--------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bf302c799832..cc41e8f5ad14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2918,6 +2918,14 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	return ret;
 }
 
+static const struct attribute *amdgpu_dev_attributes[] = {
+	&dev_attr_product_name.attr,
+	&dev_attr_product_number.attr,
+	&dev_attr_serial_number.attr,
+	&dev_attr_pcie_replay_count.attr,
+	NULL
+};
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3267,27 +3275,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
-	r = device_create_file(adev->dev, &dev_attr_pcie_replay_count);
-	if (r) {
-		dev_err(adev->dev, "Could not create pcie_replay_count");
-		return r;
-	}
-
-	r = device_create_file(adev->dev, &dev_attr_product_name);
+	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r) {
-		dev_err(adev->dev, "Could not create product_name");
-		return r;
-	}
-
-	r = device_create_file(adev->dev, &dev_attr_product_number);
-	if (r) {
-		dev_err(adev->dev, "Could not create product_number");
-		return r;
-	}
-
-	r = device_create_file(adev->dev, &dev_attr_serial_number);
-	if (r) {
-		dev_err(adev->dev, "Could not create serial_number");
+		dev_err(adev->dev, "Could not create amdgpu device attr\n");
 		return r;
 	}
 
@@ -3370,12 +3360,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	adev->rmmio = NULL;
 	amdgpu_device_doorbell_fini(adev);
 
-	device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
-	device_remove_file(adev->dev, &dev_attr_product_name);
-	device_remove_file(adev->dev, &dev_attr_product_number);
-	device_remove_file(adev->dev, &dev_attr_serial_number);
+
+	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
 	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
