Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF163C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 01:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCAA610C8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 01:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FCAA610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A4E6E46B;
	Thu, 26 Aug 2021 01:55:17 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A7A6E45E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 01:35:29 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 329B53F316
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 01:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629941727;
 bh=jk8Ui+qtJ07AX9acOLSTo6iFK9pe8UkV/wGH/ibhbvg=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=XZmxZG2u+gWwgWPrhit3ZIanMJrZM+siVcllnfvFXqO0VeH8a9txtE6h2LFWB1+DL
 Eihw61HIx5Lg8OabWFvjuyP2MHkpxH19E3WyRnTs/iAfn1Z9Exb74jVCWBJiVHyGcB
 XrPxqySyknP9yhk/W+0Onxal9+niYKx0PaRs24l3O3jQDhPGR155K+Mz2MZDqkZeLY
 F21zl72hj5eI9B9s/hfgCPu80IvAbgyWGgPhnNya63wMOw4fpDkLETGwL4XXdL0gfK
 M4/lLD7ZN+WqNl1z3LB4PiTYw4ggkd7Z1PpRAduincpcs7EL11sMWfbe+W3IcwWVRk
 mRu9scrEIYImA==
Received: by mail-pj1-f71.google.com with SMTP id
 r13-20020a17090a4dcdb0290176dc35536aso154900pjl.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 18:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jk8Ui+qtJ07AX9acOLSTo6iFK9pe8UkV/wGH/ibhbvg=;
 b=TBP1gpy4MCIcRp8d4K9DA3qrSc5e10KpqdOoxXU00KBDcGvtSS8dXwG6XZ+bDZeVM+
 LHXF1NrOWWilj2ukVHlaUCyNpBFQUx7hJml9F6rGAzazC1TkB6KlAJ5JPKSMhaks9Vuk
 Wrf5zIXpAPhdkSP0Mxyt1ScWic90KS7HjHxdlzej5NQRL4hEr5hCTSyp+moDb751x7K7
 429YfGeDfuK/Oj1a1yOkqd1foLTl/pWTO1FQPMElR0g6yKlLTvSg86QxJPzIXCu0ur0g
 nMzzDdBR9qOzbG0iApf+KeA+TmfAvupW6hHyBdAN442Fa3RgoFOd5vQP8l+iPa6PDP9w
 Q8uw==
X-Gm-Message-State: AOAM532Dijk489p6gllSaWl15dYgovN/pHTCnpqkLs1aFX9uNpmXUu/9
 t3AxDxosfgElpeBCverARZmYaWohDLU9KUto9i8aB5x7YApsbHDHFQyzO2nv4fO/VCy5Oy4FRmh
 cMdRKIgd9G4REEgyiEGLVoot5YDS0J2mZoe0dLHAXnVY=
X-Received: by 2002:a17:90a:8005:: with SMTP id
 b5mr13774390pjn.190.1629941725423; 
 Wed, 25 Aug 2021 18:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmpCN8PFGP5PNZw6YDD1upn/Ulf08oShbFiv+wHsZohcTMbvubQC2K+CTA5rmHL9UF+fUTzA==
X-Received: by 2002:a17:90a:8005:: with SMTP id
 b5mr13774372pjn.190.1629941725145; 
 Wed, 25 Aug 2021 18:35:25 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net.
 [61.220.137.34])
 by smtp.gmail.com with ESMTPSA id n20sm877852pfa.91.2021.08.25.18.35.24
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Aug 2021 18:35:24 -0700 (PDT)
From: Koba Ko <koba.ko@canonical.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH V2 0/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
Date: Thu, 26 Aug 2021 09:35:22 +0800
Message-Id: <20210826013523.394705-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Aug 2021 01:55:16 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD polaris GPUs have an issue about audio noise on RKL platform,
they provide a commit to fix but for SMU7-based GPU still
need another module parameter,

modprobe amdgpu ppfeaturemask=0xfff7bffb

to avoid the module parameter, switch PCI_DPM by determining
intel platform in amd drm driver is a better way.

V2: Determine RKL by using intel core type&model.

Koba Ko (1):
  drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform

 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--
2.25.1

