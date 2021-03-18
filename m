Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA2C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF0D64F24
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 02:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF0D64F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDE66E32A;
	Fri, 19 Mar 2021 02:55:09 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E96796E1E8;
 Thu, 18 Mar 2021 23:20:30 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id a11so5466450qto.2;
 Thu, 18 Mar 2021 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+OQr5EWF14LJSJDPiUoRbhnzYOObAaD7LteF3BV720o=;
 b=BH2GYsC7xrZSawjjvrKi7E1Kc0MBUY8y3HbDcq5CoOVdgvAqd/ZFIB91Cgc4k24rxm
 Jzwfs4OmkG9SSzow3D9RFnInet04tcVAHbS/kvSsZo/n3wxPB0ZblXDe3S2OibEmd00+
 2wsux6NTtdhAS8FBJSVsSQ3LhL8Gz6KcRjYaQRvxrpQ/CdLD9OilEIqqorp2N5IIlFgQ
 vSfj3p9QLGIcCjJ3T6/sZS8Wc6WdrI2KjRy68H3dlh3MLK8Tuu55nd7bh4U3mJAvrkV8
 mietxE68ggbzTJUQQQoU3iZg2WPP9J/kj8U1ZCpLkuFHBhwTnOAJ+EVDGJfNYbTOR4C3
 OztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+OQr5EWF14LJSJDPiUoRbhnzYOObAaD7LteF3BV720o=;
 b=MvqTOR2uaAW/rt7c7bhFtO3RaVY+BwJ3/g/d/auhk3b/KRy/b79+SFouTLQbsjYzIP
 l0U7Dl1GhkkTV72JcC51t/BO9341Z9qXnJjd3AMYWSOeUIwlr8rJfZTPZOZCiEamj56v
 hJnSscPBK+NFXruFnSloeS6k1oRkBRotUm38knVtBDLgARClJi6js40OiNQpSxBKm19/
 2X/1UAEJW082aUTMaKTZGsYEwfa9YixxunYecwVblP+iPqVJKIvkWpUT501G7mRh4qR3
 yw5ShU5FAKAKHzwNkNLzAQHQPlztpJDpVHyuAX2gRW5cQOg8hvRME7dRnzALFHCM3gB4
 /evw==
X-Gm-Message-State: AOAM530ii0t5nKwraVCeSKntgYOrmS+ci2qeRhJ0orCRQTo6kemUeA4Q
 nWQLszoe3Wca7QvqbMJd54BieBQbMPTZSLer
X-Google-Smtp-Source: ABdhPJxfhehGR5xA4asaV7R/Ng3L0bjA7nfBuq/tPpOKrgowt4gEhjUFzXDP4Br4uw7hPIybSiRzxg==
X-Received: by 2002:aed:38a2:: with SMTP id k31mr6157793qte.187.1616109630065; 
 Thu, 18 Mar 2021 16:20:30 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.63])
 by smtp.gmail.com with ESMTPSA id b17sm2438571qtp.73.2021.03.18.16.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 16:20:29 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, Hawking.Zhang@amd.com, John.Clements@amd.com,
 guchun.chen@amd.com, tao.zhou1@amd.com, Likun.Gao@amd.com,
 unixbhaskar@gmail.com, Bhawanpreet.Lakha@amd.com, ray.huang@amd.com,
 Jiansong.Chen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix a typo
Date: Fri, 19 Mar 2021 04:48:15 +0530
Message-Id: <20210318231815.19546-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 19 Mar 2021 02:55:08 +0000
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
Cc: rdunlap@infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


s/proces/process/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index bf3857867f51..c1d5a3085bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -598,7 +598,7 @@ static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, int msg)
 }

 /*
- * save and restore proces
+ * save and restore process
  */
 static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 {
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
