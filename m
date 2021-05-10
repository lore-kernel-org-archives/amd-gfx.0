Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444FC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238936143C
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238936143C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF58C6E426;
	Mon, 10 May 2021 08:26:25 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8306E328
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 02:20:59 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 cl24-20020a17090af698b0290157efd14899so9387392pjb.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 May 2021 19:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GY/5bA7kV7iDdYH9WTyBo3gPdY/tZoyv959MRycTskU=;
 b=iKTuLM8160kceYtUwHLK7FPN7OehYwZsBjGmNeCHIFUYxFPwmn7Yh4WU61KqPdjSW/
 HmVxC41/4kMFLLJmDOZ7R1860R/6d32vu0s71g4MQdkZPoDHiT+FZ/dG4rqkPvDzr4v9
 9xd3zpajUsdubSjxQy8A4KOkYBh2nbB46/fbz68fDcmt4Lhicg1CnvkHLHkndhzFC665
 1qUNhfsOOxd4C2I0x7QuVNf/2X/+l/0aWAlZ1RBku9lInidNJYTvnaIZp2DCqakpK4kf
 D0gxWtc9UfEd1V5LDV2AmlZThEYYTy6BRGZy3DhxQmsrA0zw0RTYLel3E1Q/fcnJQY2h
 M6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GY/5bA7kV7iDdYH9WTyBo3gPdY/tZoyv959MRycTskU=;
 b=J6p0UsEnDhpnz0gSYanrHJuOW2SMPrhgEKqzsiPUYgvkLvINvcE/CO/Fu3fLBrlmPF
 7fbBi/x31o9JI4fgx4KR6LiOk3GhCpAzZSCHJlMxO3uli0PDL4mOZ9ZnmxKwRLWeqMQh
 +UnuLtVF3NU5q0n+hrlDMnJnQXF+UJS04qc7abgxQhCqWOOGSN6bxrctoXVhqdF/XCWg
 Axyu3afAE3775/tQBZ9Iqy3Xo1UMMhMBZ9k+xKrCBc+Vz66yIcw59gKoOEm5hMo4eA0j
 ZLx2fqMdsGCybm8cQuDgJ6wcmHBtwiILt1d35mWOIzO0y1oMKNyK4lmNGXJ99R0xqS6Z
 N+pg==
X-Gm-Message-State: AOAM532CNdkc/diZGvDWKen+wfP3dfU33fvyLI1g9GRDmGVV+G/2bFX6
 vE+uKWGSt2LZETcDM6QYYBU=
X-Google-Smtp-Source: ABdhPJyu/I7x3jQxNu4RPJ2UJ7yYcmR6eAGm5+97aPaMtld4RQPq2Hak6IZTKCHpdZJ3ayJRDIervQ==
X-Received: by 2002:a17:90a:77c7:: with SMTP id
 e7mr3738513pjs.227.1620613258789; 
 Sun, 09 May 2021 19:20:58 -0700 (PDT)
Received: from localhost.localdomain ([104.200.131.246])
 by smtp.gmail.com with ESMTPSA id y13sm9686856pff.163.2021.05.09.19.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 May 2021 19:20:58 -0700 (PDT)
From: youling257 <youling257@gmail.com>
To: Rodrigo.Siqueira@amd.com
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
Date: Mon, 10 May 2021 10:20:47 +0800
Message-Id: <20210510022047.9323-1-youling257@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 10 May 2021 08:26:24 +0000
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
Cc: amd-gfx@lists.freedesktop.org, seanpaul@chromium.org, hersenxs.wu@amd.com,
 Harry.Wentland@amd.com, Nicholas.Kazlauskas@amd.com, Ching-shih.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I using amd 3400g running with android-x86, this patch is a bad commit when i use android-x86 on amdgpu.

Revert "Revert "drm/amdgpu: Ensure that the modifier requested is supported by plane."" is the first bad commit, cause a androidx86 run on amdgpu problem, look the video, https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing

"drm/amd/display: Fix two cursor duplication when using overlay" is the second bad commit, also cause this problem, https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
