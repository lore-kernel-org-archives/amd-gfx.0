Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA62BC388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 13:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FAD22249
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 13:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN5ulN/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FAD22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FB26F554;
	Thu, 22 Oct 2020 13:59:33 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1056F52A;
 Thu, 22 Oct 2020 13:37:56 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id b23so956927pgb.3;
 Thu, 22 Oct 2020 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=IuqDlc/9sVmn6w8y6S9W6kIXAO5b3CW/ksiq6MJe4cw=;
 b=IN5ulN/lhVpkv0cSxQVYeQmL8e6XC9Ui0ongH71NZy+wDEtGl/7jnitdi0qhAAyIZY
 fC7g6ckIDcNipQDDU/l95Zz5SIw5WgFDHGPbZsnqwhcPDWDUeYQ+K0+pZ4exBAq4gbcw
 rqJ6yYA5w6lq9ZOLdFbpsKUwr7R6EDI8UsYT73x2NUL9/nh4In959E24DYHQiR4z5JBY
 3PhmcpvnBuuDiLX7PaDg4d9j17853UB9O1sXkM4XGUKK+pIkSbJwNUlF7Kq7ZfYzjjTA
 UDpUqi4GQ2QwwzVjXoCBSJUnNgaE17+WjxzlHjS3QXF8s9sEEYtv9MqLfP/Xm8h49QZ4
 R9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=IuqDlc/9sVmn6w8y6S9W6kIXAO5b3CW/ksiq6MJe4cw=;
 b=olszCwgk7FFGv16fOk+1/VyDQ1dz9N60K9NOv9LGjGlyG59yD5Dp8NSivYvimik72A
 OGxnqmJxlAZ9ewArC62QFU5nz4VP6dooe0ACLKYA6QSDA08fB2ITeLHwweDo4bx/VLMD
 AFw2M6up8sVq17OYxDE2WdAKJzMf080vCmYP95wziPmavZojzHqJiO2O+M82bZKwAbo4
 pXsUdxaqkMAEeNgWbr59ZPz0eGi/OggBrQyVlo5zZ/xgiB0GoMhV2tJ4hbxLqipehGKU
 eTmentiLIk42B8VsU9p7MQ46w4ct+sVJVxiuBNyh+AgwkOrh8+tRV73iupY0WdF8sbwY
 e/vg==
X-Gm-Message-State: AOAM530GuTNn/ukxsBGLIbcZJNln3gGxCvKBkkjNX3Rr8MY+e7WxqcdF
 lbg1s+hucfFhi1bp4qul1qVMbXZ5O0Vv9Q==
X-Google-Smtp-Source: ABdhPJxzYwjbdLDADhpa8w757osNj5Hty2iFA+tEbvr3E1nQBdPpkX6BpAdeBon6QKBNbFuEjHUUvw==
X-Received: by 2002:aa7:9e9d:0:b029:152:5ebd:42a with SMTP id
 p29-20020aa79e9d0000b02901525ebd042amr2500221pfq.4.1603373875970; 
 Thu, 22 Oct 2020 06:37:55 -0700 (PDT)
Received: from adolin ([49.207.204.75])
 by smtp.gmail.com with ESMTPSA id a22sm2538214pfk.29.2020.10.22.06.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 06:37:55 -0700 (PDT)
Date: Thu, 22 Oct 2020 19:07:50 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [Outreachy kernel][PATCH 0/5] drm/amdgpu: Replace snprintf() with
 sysfs_emit
Message-ID: <cover.1603371258.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 22 Oct 2020 13:59:31 +0000
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, melissa.srw@gmail.com,
 outreachy-kernel@googlegroups.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using snprintf() for show() methods holds the risk of buffer overrun
as snprintf() does not know the PAGE_SIZE maximum of the temporary
buffer used to output sysfs content.

This patchset is a series of Coccinelle cleanups across the staging
directory to convert snprintf with scnprintf in the relevant files.

Sumera Priyadarsini (5):
  gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
  gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
  gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
  gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
  gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
