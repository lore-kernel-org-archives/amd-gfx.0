Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11369C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 04:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA31164E28
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 04:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA31164E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C2A6EC24;
	Wed, 10 Feb 2021 04:02:22 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB236E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 02:58:15 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id j12so320075pfj.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Feb 2021 18:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3bu6rhwPlAhXegz5ya/guGHb9ivWaiNn90hlHhoqWy0=;
 b=Xsr0lRZF/BxZR/Lnaa2h58X9BEJqoiTpCd762yZRztYN2xz7yL3FnfCE20L908tMC1
 Fed20YfnFmQiO+6KtAa4b5KficcxRGgIuBOLEYensnppsl42DCHHLpajA7wjV3T1H9Mz
 0EzsnGCOv9pBuxyg0qfqEOFpk3Ia0lx2iNjJuGMTais+6sZipPcT0CUqTw+T2SY71RhH
 hItXm+902F5vVT6pJoEy5PneIE96DvDgm79KFVjX4uof+AHA6esPQzW9isF3cnM/ctyU
 6OkRJSbTEUsfs4T1C5lSMldcZ/rF3w5Et+zV4fIVSM7EiYZBM89V2A271KRMxTK2SyXp
 Ma+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3bu6rhwPlAhXegz5ya/guGHb9ivWaiNn90hlHhoqWy0=;
 b=nOrVJIV4HtCZBjxVZkIiObTWkUy9iDjggkaISSKH/IYYzyeC1CS26UM2t1mp6kd928
 d5U/jCJMNAwvxwJ2M5s5iutW9HF8EauHpL3hoI6hbxH66DimtZeJ1lqvWw78Ib6LcBFW
 fXa+8SAK+VABwm87JdyHQmsSJCUbSeH6t8Tlg4LU+p1yGw6jjHpkew4uQPZZPZzyz+PA
 I1jAxvP2ROv55hXXxTkXqSP1zETz0lVydXJph/Pz7xpoPs//SDGMfBVkjMNilMV8baDo
 ZxwJOIjEBDsDCKwiHLJ83AL58UJ2L2m9R01apYkjvrehlR1gNNC6tIGh3hODl3Sx7g2Z
 FZRA==
X-Gm-Message-State: AOAM531Q+/O8SeaHXnxhtvO6wVu3NxgPAVWBbQ8qZ7l6SFDpJ7FgYNiS
 OQ6dWP1YSWzEy1Yv5tMcEaw=
X-Google-Smtp-Source: ABdhPJzM9PtJ9CtWTbz5/pSQBQY3dfquX5xB+znW9NW1QZTx1aSnElHCtXS7y8S+6XtcNmP6sOIRow==
X-Received: by 2002:a63:1e4b:: with SMTP id p11mr1055543pgm.301.1612925895311; 
 Tue, 09 Feb 2021 18:58:15 -0800 (PST)
Received: from localhost.localdomain ([103.114.162.148])
 by smtp.gmail.com with ESMTPSA id r68sm279189pfc.49.2021.02.09.18.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 18:58:14 -0800 (PST)
From: youling257 <youling257@gmail.com>
To: Bhawanpreet.Lakha@amd.com
Subject: Re: [PATCH 05/27] drm/amd/display: reuse current context instead of
 recreating one
Date: Wed, 10 Feb 2021 10:57:42 +0800
Message-Id: <20210210025742.7855-1-youling257@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129212752.38865-6-Anson.Jacob@amd.com>
References: <20210129212752.38865-6-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 10 Feb 2021 04:02:21 +0000
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
Cc: youling 257 <youling257@gmail.com>, Eryk.Brol@amd.com, Anson.Jacob@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com, Harry.Wentland@amd.com,
 Nicholas.Kazlauskas@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: youling 257 <youling257@gmail.com>

This patch cause replug hdmi blackscreen, https://bugzilla.kernel.org/show_bug.cgi?id=211649
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
