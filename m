Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36719C388F9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 13:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBE922249
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 13:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBR9uUxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBE922249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E231B6F568;
	Thu, 22 Oct 2020 13:59:33 +0000 (UTC)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8821E6E210;
 Thu, 22 Oct 2020 13:43:18 +0000 (UTC)
Received: by mail-pj1-x1043.google.com with SMTP id hk7so1000584pjb.2;
 Thu, 22 Oct 2020 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TGoYs6NX+Ndx+a6z9ojq9tBbYhFNYgIJY1nftO258C4=;
 b=qBR9uUxUlHyzRD3U5yeOPNh2DDGVG9brz1blZmpia4NszHbmZ+F9wNVuaJbexA1L3Q
 /eGsZj1/Hj54rAPm6L5LilmL59AZk5K6sjXGE8XLjUje8GMErvT7f0RzBBIzt4bwDR7y
 CP+A1Is9IT0EVEitSCNGlmmmWZ1WHvAnd9ZTIrd0lM1wHSdXPkBVZXAwsdEj9CGOq1+W
 NYw767H1SD7DlQEa3Anp0F9TqIkNbjTargZkMcF5AbXQTTIJzXX/4ocvGZ8e6tajgd05
 OjcAKZCIrST80Fh562Wu+2NAvSfyTI7JHowQpGGjfI3hDZXxM6o91V6d4cuWtjIsgJxz
 Im2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TGoYs6NX+Ndx+a6z9ojq9tBbYhFNYgIJY1nftO258C4=;
 b=sydmmlCM1kH9FVfZdB0pZRsoX2ETE7jkZxHfOglGetwXnow+RLFe0emULPrJMEwdYy
 SoKfH8vBd6dV03h+/WC4IWT3AFYS+1o2o3edNUCbD4evNKvbrFMoNsLv/7QLJrKYTE94
 qcsxwHZKA5uiBSHIFje5pI/5R/6dChHoFo9DM6uV1hhS1Unh2gv0b2MwNS5EOVD+C2yZ
 KXocSRZy8ndxks4NdqPiHYXgezKAOgwbuI6e0YaJZtQHW89xsTb0R0fu24V9u7wE880g
 uyccVs8Iw1wWhcE377KzIgNuim/IisNOEpEowwDGHJhJF36CzcWRd+Gcasc3JsoE/kUe
 dbCQ==
X-Gm-Message-State: AOAM530RqLPcr17lcoIsbsDuDBF9z+ymGgdixAdxCTfTWv5tafRiZLyk
 Q6jXOwLDSuBGGwOOgpViK13nGG1/2xQ1pw==
X-Google-Smtp-Source: ABdhPJysdrkf3tgIA1nwdFfO7BIZMe8vhpQ/9lzdcbY6lgA87r33Xb+5yzfTvWg4NA6sI3LSJUyyRw==
X-Received: by 2002:a17:902:a3c9:b029:d5:df0c:f217 with SMTP id
 q9-20020a170902a3c9b02900d5df0cf217mr2465001plb.59.1603374197886; 
 Thu, 22 Oct 2020 06:43:17 -0700 (PDT)
Received: from adolin ([49.207.204.75])
 by smtp.gmail.com with ESMTPSA id l18sm2404726pfd.210.2020.10.22.06.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 06:43:17 -0700 (PDT)
Date: Thu, 22 Oct 2020 19:13:11 +0530
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 2/5] gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
Message-ID: <78546ad9343ddf1b0f8bc300a3c8ae9a0dcb0ef9.1603371258.git.sylphrenadin@gmail.com>
References: <cover.1603371258.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1603371258.git.sylphrenadin@gmail.com>
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

Modify amdgpu_device.c to use sysfs_emit() instead which knows the
size of the temporary buffer.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f7307af76452..7eef6b20578f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -135,7 +135,7 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	uint64_t cnt = amdgpu_asic_get_pcie_replay_count(adev);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cnt);
+	return sysfs_emit(buf, PAGE_SIZE, "%llu\n", cnt);
 }
 
 static DEVICE_ATTR(pcie_replay_count, S_IRUGO,
@@ -159,7 +159,7 @@ static ssize_t amdgpu_device_get_product_name(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_name);
+	return sysfs_emit(buf, PAGE_SIZE, "%s\n", adev->product_name);
 }
 
 static DEVICE_ATTR(product_name, S_IRUGO,
@@ -181,7 +181,7 @@ static ssize_t amdgpu_device_get_product_number(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_number);
+	return sysfs_emit(buf, PAGE_SIZE, "%s\n", adev->product_number);
 }
 
 static DEVICE_ATTR(product_number, S_IRUGO,
@@ -203,7 +203,7 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
+	return sysfs_emit(buf, PAGE_SIZE, "%s\n", adev->serial);
 }
 
 static DEVICE_ATTR(serial_number, S_IRUGO,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
