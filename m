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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10658C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99272065C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U56MP+Az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99272065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB656E0CC;
	Mon,  1 Jun 2020 18:03:00 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7E16E0CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:02:59 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id b11so8447833qtt.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2WGuUQs/rojBrgKcJ4EjdcZPHoUoP1UZ9QHLd2p6e+o=;
 b=U56MP+AzK1FrEf8KS0rUGqU9s5pdArLHKK+0dVFw9Q8TB4B64PDMIFhPW8a9PUDydy
 j5VzZT+phpQCNPhNU9EIuqABD5guF2iHzvhxZQCM2iHayWP6hgtDrgf4+clyhJVilXij
 ZUGdEqqWQFPYcLv6buTO8IeAZSqUGkCPQPAWTCtZ/ERo+ve9Wbd7lAapDoBqvmQr+rFg
 Bwxq9lF6Jp+4NEJuezux4WYeYmzHLG9YnmE72MTr6GMeQzzh0M+C0+8Kxr3nPW3+H4uf
 PgUSSqqDAOA4jxTKO6eg+AiMNLeCz0ImnAo5Vfu+ETShic0bDNsiz8KLEiVEqgCzf2GO
 MuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2WGuUQs/rojBrgKcJ4EjdcZPHoUoP1UZ9QHLd2p6e+o=;
 b=EiAz9wrgBRRIbgr4GOQlp70rT3ni9R/IinC1wtCXRtwKsZz2H26JA0yJmdlgcfHIaT
 ruvsEyHCt4AdBnvcsuJ3cisdkPeuqoYPGwWehBqsTCk+5sYZQs+2BBzQKs5BYSbBr7Sj
 1/Y3a7mQVldNsMGSZXi1h2EINDn9F1cHbnaX4ZzjkpxS+rC8VQHEMasAUQbIXsL2QheJ
 B+53/DE++i2BVukxDDU1S16sEJybWqIccmfoPFDan89sW/5Ody9+wmFRp/sAKbkxNJJ9
 OiOxaUu/Qd++bumOGtD++DItJBcI6K8tfFrSzW6zn/rfEJ4+KIuL9Zu0JzeDeUWqY8E2
 i7lA==
X-Gm-Message-State: AOAM531y0LS7DUiSxwtSNu6CcF2dRNQcQqfW0O2suUVykUTJsyhJfoRn
 qDYCqO0ftWdrMjd8LTCC9lWNRsWP
X-Google-Smtp-Source: ABdhPJxMXmKNXo9Z19Y06LijHSSwl4GySFuR6/MQlC1SJMOTt9PTseWvMyMlkCvScwb5bw8YhmRHfg==
X-Received: by 2002:ac8:1b99:: with SMTP id z25mr23066498qtj.209.1591034578261; 
 Mon, 01 Jun 2020 11:02:58 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:02:57 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 011/207] drm/amdgpu/gfx10: add clockgating support for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:23 -0400
Message-Id: <20200601180239.1267430-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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

Same as navi10.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c2fbf037defc..8a6a9ba85714 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7154,6 +7154,7 @@ static int gfx_v10_0_set_clockgating_state(void *handle,
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		gfx_v10_0_update_gfx_clock_gating(adev,
 						 state == AMD_CG_STATE_GATE);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
