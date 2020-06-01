Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418BAC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3DE2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/TUD0a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3DE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55FE6E323;
	Mon,  1 Jun 2020 18:21:47 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292006E323
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:46 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id x29so8501179qtv.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DMhQN22vX+KX2WM41vLK5WQkftb5Ampiegkl8AhICPU=;
 b=D/TUD0a5yFwpb5Itzdgvqy3vrOa2aqVNr5oqostaqjbiHLwQMHi45WWkXaQRM6hhow
 EpPpWVvvi1bfuzm6rBnXoRgi3dBxuBR7X0I0y9to1IwAs5m7cJGIhV1330Bss2l4ZCod
 7VOAqnbkEJYVgyHCaNrbWmk59nct+EPLPysj4zofaYFU0CFdeVl7wCrq8IKtO6O1xtFa
 vWDoCe9lAfdAU2MALBOjYW7ROilqOiOLJGg1pQHbBBt/KD4+oGNS0zpE2657BKadf8ip
 kSoixaq0wIiXxmYEpR0jmxPyczifzpTSTGVq90toJkw5X8W8e57MZlpGeHSFU8U3iimO
 LOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DMhQN22vX+KX2WM41vLK5WQkftb5Ampiegkl8AhICPU=;
 b=Rzxvz5ucCLa5WL51mawQYD+4HjgEQ543VIwJmWcqzjBO71KqJTFmxRlHce1JQG6T1d
 AtT1JgvuJSyzyA77YcH0imnPCtquiGCrzMi0nTAvYfIkXWmYYch/kdDqWwvJissqWNOC
 PpcVZEIbUIwPW97uUPpTFsNZA1AKnQjLtihk8STIuAti6uhjtmPtYZmEaEkPEI4qdyb4
 /xLNNO/3F5IEI6JGoFv6NvvE7QypbKKB/MCvTCN3NcNR1c8Z9ICR5z0izeIEhrdArOFS
 Lm3Rr7HmKOCLSjkD1dUG5yPcwu1pWb9UZiB4cuEf4VYFZj93dRQrErt1yNbN5VPcacIf
 JcFA==
X-Gm-Message-State: AOAM532UpJKtiIeuRnj2mH0if+92F6MuUDnNjP9qWm9zJiBkybtxWP+C
 FRH+qAbq1WUwHuVCf8YTD9eAFIQH
X-Google-Smtp-Source: ABdhPJyxhMw8tvXP6K7YcpG14aRLJBalJbcvCpe1FetLTiRXedOwS4zpsI8ScmuwXIma+PBHZfOD2g==
X-Received: by 2002:ac8:6643:: with SMTP id j3mr10470769qtp.17.1591035705067; 
 Mon, 01 Jun 2020 11:21:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 120/207] drm/amdkfd: sienna_cichlid virtual function support
Date: Mon,  1 Jun 2020 14:19:27 -0400
Message-Id: <20200601182054.1267858-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yong Zhao <Yong.Zhao@amd.com>,
 shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: shaoyunl <shaoyun.liu@amd.com>

amdkfd add support for sienna_cichlid virtual function

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c36a352776a7..22348cebaf36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -500,7 +500,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_NAVI10] = {&navi10_device_info, NULL},
 	[CHIP_NAVI12] = {&navi12_device_info, &navi12_device_info},
 	[CHIP_NAVI14] = {&navi14_device_info, NULL},
-	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, NULL},
+	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_device_info},
 };
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
