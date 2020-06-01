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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12BAC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C9C2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwtF7uNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C9C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B8B6E2E6;
	Mon,  1 Jun 2020 18:21:12 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539A66E2E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:11 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id c12so8435633qtq.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xP/6WlS3Oe579EZAzrFtdv1qvzhVwwZjcGe5TM5vRoI=;
 b=YwtF7uNTQZaHiq/x47aLU7Gw7qPzZ4SmsENooOPLHPG7fvpDaHPR9YrjwTqUTbgld1
 eANndt/CA+/pgEDoJXh2yAIAywwX+EAe4moXM37W09OrBB1MNHVhKkjqv+PlSXrV+hUk
 qB5b97xmgvOMTw2IEXJ8M66zB9gmW9hScKMAS05VSd+ZtdmJPhsc53ZlYitW+6kq3xQM
 AW6uGgHE/bbbKCi8JxTf3I5J3srt6twlCai36iQ46gDGM0lfpsBQXlDf7FEmUaZufw0+
 L8PaXIFEip0yFWquNMSW2zvjUyTPBUVDBmgMBwRwzb/79q+ylYpDzDpTf2UvCZzc7L/c
 sKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xP/6WlS3Oe579EZAzrFtdv1qvzhVwwZjcGe5TM5vRoI=;
 b=htGHoHcsRDJEAeziS8FiWSFmIbFYJnMrw7d3kn7OoEUTspsGkNqKPqxNqxxB9yDNHN
 vkOn9BdrP8e4GL0hMlEXSLS4FMOSyT4vCVMolaXF+s8B7ofhT3HNiZR0xbAwpvp7dN1a
 nIq093MoM7LvVfaYEovIHZZZRAeXY48Q4vEG4mDdTfRqiCnacLXtPoldmHfsTn5lhwYz
 9LnblnJiBhKhhO+KeNydJyZoldo3xMd+MJo/UTfN8tufQGb3Dl2Mkv/moBs8HxH6mImf
 wXa2oPOl7pDrLffWPGRq8aZWGgZEdUyjPo8RVz6ba1N6Go3LG9K0m+2EXXHgCPZs4rVF
 r5Xg==
X-Gm-Message-State: AOAM5332Z8jLlJeBzjj/ufjMVyEUaJ7CvM+Yy5tcV9d62yRDQM4cyIlw
 zg8FHL6zkZO5qAB80cLnVMdru3Nm
X-Google-Smtp-Source: ABdhPJzVo5pi/Uv3F0XfEPkKZ7KE8+QHYqmGMUp5vtafJZvmV4cSgFdPeich7kw6hp3nMfFwUqCZwQ==
X-Received: by 2002:ac8:548b:: with SMTP id h11mr24452152qtq.66.1591035670308; 
 Mon, 01 Jun 2020 11:21:10 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:09 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 094/207] drm/amdgpu: disable gfxoff for sienna_cichlid
Date: Mon,  1 Jun 2020 14:19:01 -0400
Message-Id: <20200601182054.1267858-5-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Temporary disable gfxoff for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b62c755dff21..940b4563312b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3531,6 +3531,9 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 		break;
+	case CHIP_SIENNA_CICHLID:
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+		break;
 	default:
 		break;
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
