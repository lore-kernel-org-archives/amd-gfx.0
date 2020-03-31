Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C167C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 10:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E82D20772
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 10:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox/XyHOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E82D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BD66E7EF;
	Tue, 31 Mar 2020 10:55:11 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3213E6E7EF;
 Tue, 31 Mar 2020 10:55:10 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id w26so24529114edu.7;
 Tue, 31 Mar 2020 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=lJ28otLGH/TA0UFRVyaAv3N2y3mbjSrHeAW7r1D9pqQ=;
 b=Ox/XyHODyaHFq5RQDXZmKlVHeUdUPDwHjUDHi8esLUsIw0rB3+3zGmrRd+Qy3P5G3L
 jryZy/jSRFidXNn4mnsqe/vAHuyNCdEpxIsrC0arPlsPOipvVXXsX5RDcCtJP9yoMZwx
 NIHLfam1/tknlph34PC3oWR+QUw5YxQoeTFHV5tJDwwJ2zgcVbiCD8S5FZq86S7cFsy/
 smiQMpxjVoXVxEJoGCcYQ/4w7zSTv8fSVhFQ8M0ae5gulBU8aHNOwbIzlJUKjZYJ0kMy
 zU5jVpZm3AStfZAYAzzJwOwgv4wBNuLbE5cyEpKvkgeWg7HyUeFLzZDz6Qzo+MRN7eo3
 5SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=lJ28otLGH/TA0UFRVyaAv3N2y3mbjSrHeAW7r1D9pqQ=;
 b=dus2QvHUMX8aGeFSsf+PpYRZ+OMZ8TiScVMIKLzvhVehtKgz3Q/kakXo15jiqjS4KS
 2D4l0poxkEV/C5pbiyG76elra21nSG32M1AL2B+1FrEJ0ywXwst3oOoEaVeFRy2GABuc
 5v3MKjakDZCyGRNSb8E1D5Ppj5WUP7GQqDG2+nQcm8KeuzWZ/JmZgC7Ey7XZPInyU2gJ
 kHwzVF1VFiIafewVC60ZhVWlUsvdf51iL6YfIeNsx0NXaZLJYiMka1SldmvPbkJ3wJYN
 CBw3ggPqSPMpjK3bNOtK4YEBUZUEepxFw0m40VCPuMG+/eyOmT6ZNmTA3h04S/qA+aHF
 RAMg==
X-Gm-Message-State: ANhLgQ1tVPFTdFNIxt9vYG+HGzwtJUBpg53R71GHM9gXbSdElPYGjgxH
 PfmnneHsDzqzP3rk3yrB5UU=
X-Google-Smtp-Source: ADFU+vuzYvhLkkf4P6xFXKXPnbxRp15lh/5fGfPH88RWrj0e6JgwXYjh+iwsAu82EDqgRUCBvDi1rw==
X-Received: by 2002:a50:ec08:: with SMTP id g8mr15100184edr.321.1585652108744; 
 Tue, 31 Mar 2020 03:55:08 -0700 (PDT)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
 by smtp.gmail.com with ESMTPSA id pj22sm2144956ejb.79.2020.03.31.03.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 03:55:08 -0700 (PDT)
Date: Tue, 31 Mar 2020 07:55:00 -0300
From: Melissa Wen <melissa.srw@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Rodrigo.Siqueira@amd.com
Subject: [PATCH 0/4] drm/amd/display: more code cleanup in the dc_link file
Message-ID: <cover.1585651869.git.melissa.srw@gmail.com>
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

These patches address many code style issues on dc_link for readability
and cleaning up warnings. Change suggested by checkpatch.pl.
Some issues remain and need some minor code refactoring for proper handling. 

Melissa Wen (4):
  drm/amd/display: cleanup codestyle type BLOCK_COMMENT_STYLE on dc_link
  drm/amd/display: codestyle cleanup on dc_link file until detect_dp
    func
  drm/amd/display: code cleanup on dc_link from is_same_edid to
    get_ddc_line
  drm/amd/display: code cleanup of dc_link file on func
    dc_link_construct

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 358 +++++++++---------
 1 file changed, 176 insertions(+), 182 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
