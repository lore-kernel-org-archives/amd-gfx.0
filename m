Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3DDC3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 16:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3076720732
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsw4SLW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3076720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21A06F47E;
	Fri, 28 Feb 2020 16:40:34 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68C96F478;
 Fri, 28 Feb 2020 16:40:33 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id c7so4086552edu.2;
 Fri, 28 Feb 2020 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=LBzqVgkSBMQoXRl/FnbNZpFHPZCwyHEtb7aUpugamR8=;
 b=gsw4SLW5qCHuoB7Q0zIyZ58tQGhNAJBs9d5H0Qn3wXzcqmGMfbyI21UdDwtf6PgQby
 ckO2iRD7WDVsQpPh2Ckqotcb6Ybl3zsePd3UwVf5c7GA0A3HRwwUAgHxuhtqDERguWZH
 MYMhHmCUAmggzDMoihqnF1EXIfkhyILA+vhuR6h16d4H3pfer/DS2BGaOWRM9Oci9Fui
 y6ScH2YNMQbExT6wFd51vyRpbwKYM1qv1qsp2op+eNFsoAeIWP/31CUxcUnDRi1l16Jm
 ddZKpMrkOTrhR7MjFmo+gJuna9y0sQJLo1tinoWdzktkiEnWmSa1jOzYP7e7nyKizuJo
 vrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=LBzqVgkSBMQoXRl/FnbNZpFHPZCwyHEtb7aUpugamR8=;
 b=ThVV98v1rd1dziwwPI0Zu6V6doIhBtRRepSAb85Tg7RulmETFVOvSBwp9Wsnc5N4H7
 UfVvKpZAdE+W/WkBsqc/aoAViA7ADDskL1pvqNEyAnponP9GvakIUJNHaB9HwS47ZO9B
 ca4deQFxWjwDMMGJA6hWWqVVMf2xKnzCI7LkYJew312EWHrBlJdC7Wz9884upAoGsyYm
 IJ8isI7avsNPN9/ZOdGmOkbX3U9aJmOSMJCOMOVJypLhpspWvqElcXvFWff8HDc51LuK
 f0TSkjYKvO+CUuWAaUB5jF1B37cdSW0i9hWhTSTD0FtCXcembwIpZkee3gfjc9ybYYjf
 rCcQ==
X-Gm-Message-State: APjAAAX8lRE4NNTagbywwSkx+3GHMGTSiy6OiWAAodquGlE6PwQupQu/
 LrkLhCLLcDXsUx1DRs8Hlu4=
X-Google-Smtp-Source: APXvYqx+jWTwk6LGNR0+pA91pM1SSnE6oXHjqXSaoPZBTrWH6xMCWtiZpQzRjCndL4ZT2Uqx+dLWcg==
X-Received: by 2002:a05:6402:cb7:: with SMTP id
 cn23mr5020041edb.72.1582908032490; 
 Fri, 28 Feb 2020 08:40:32 -0800 (PST)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
 by smtp.gmail.com with ESMTPSA id r19sm104180eja.5.2020.02.28.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:40:31 -0800 (PST)
Date: Fri, 28 Feb 2020 13:40:23 -0300
From: Melissa Wen <melissa.srw@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2 0/2] drm/amd/display: dc_link: cleaning up some code style
 issues
Message-ID: <cover.1582907436.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset solves some coding style issues on dc_link for readability
and cleaning up warnings. Change suggested by checkpatch.pl.

Changes in v2:
- Apply patches to the right amdgpu repository.
- Remove unnecessary {} added in the previous version.

Melissa Wen (2):
  drm/amd/display: dc_link: code clean up on enable_link_dp function
  drm/amd/display: dc_link: code clean up on detect_dp function

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 64 +++++++++----------
 1 file changed, 30 insertions(+), 34 deletions(-)

-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
