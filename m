Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42AC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 19:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2068D2077C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 19:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB737zPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2068D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B5A6FE31;
	Thu, 23 Jan 2020 19:14:33 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2CC96FE31;
 Thu, 23 Jan 2020 19:14:32 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id j20so4551619qka.10;
 Thu, 23 Jan 2020 11:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F6dtyi0TxFJoF+T23AQH64PDgakD37qLEHUU/wMvAqo=;
 b=IB737zPJ2G+BvaTc8adyUa7tF614GBIlujgS5L+9PAbP2Xgo2yHJ41Ik1yol4PoyEI
 rXx5npJc3QSPTuzjNMgVu4zW9DMwEByrn++lLFIv765DdQrkDwZTlhfQeZBkRXmsqBMV
 R8Fnwnlr22mE4HSnXlV+Ij+OVsTG29Sa5aW/0flrPbzrC/uJdrD0l2U4jcb7LwX814pO
 yOOC4stigz8KU2kMTFzCgl4RSBx/8CFjn7CS94zYleKL1iIcMr2ZeBwtCjvDdfApzBiS
 VV/lV+y9GxHMFxlRH2flEVcOdI0sgaiMOEVFmDIRyy90n37gofo5W2E7+j1mqlzRwlp9
 KvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F6dtyi0TxFJoF+T23AQH64PDgakD37qLEHUU/wMvAqo=;
 b=hQv6OtafX4z4R0qBqnSj/4l/210OWKvPsRpv/1CyODpNn99liFC13OwoY70wNLC4cM
 Go5nyDp7SodK5oUTcwIjX0HYn5jXzv4c077TJ0objKvSqy5D2MFunkVtlw1/wv04XxON
 ipSHUX6auW68zyWKW1bBGom0luDGLymkCV7MbnhPUhVia9EtV2Im4bXKCHDQTPwyJMW8
 Ru5FDvB3vi4whh5ABsV22Ih7YvlMc6Z2HKTKeHRvtdje3/YTIQVrUtivJLMvMB9xcdyj
 VqlKPwAahReVCaQ4K0NplXu6J2Hj/D9qgP+8kk7n+aZ71aF44k6U7rcm2vvHIDGsWwGJ
 kB9A==
X-Gm-Message-State: APjAAAUsiHdxPK/2qDpKSsgsbrILYSaO91hihuG1LEuOh4NQGm6nbxzP
 0CAWJWttYasDcamZ8JcbB4xwYFe1
X-Google-Smtp-Source: APXvYqzJ2RQ+U8VUU1HCW3P4etofOu4ZmhxYAviF2VPhg74oXm3LgTKGQhu/aSBdGlNr1hOfTTyaUA==
X-Received: by 2002:ae9:e910:: with SMTP id x16mr17291002qkf.90.1579806871640; 
 Thu, 23 Jan 2020 11:14:31 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id 8sm1398272qkm.92.2020.01.23.11.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 11:14:31 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.5
Date: Thu, 23 Jan 2020 14:14:24 -0500
Message-Id: <20200123191424.3849-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Dave, Daniel,

Just one change to remove the experimental flag from renoir.

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.5-2020-01-23

for you to fetch changes up to 23fe1390c7f13af417069fc0787f7cc82839a6bd:

  drm/amdgpu: remove the experimental flag for renoir (2020-01-23 12:14:53 -0500)

----------------------------------------------------------------
amd-drm-fixes-5.5-2020-01-23:

amdgpu:
- remove the experimental flag from renoir

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: remove the experimental flag for renoir

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
