Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B189EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3360C10EE4A;
	Tue,  7 Jun 2022 17:14:11 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0D910EE4A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:14:09 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id o6so10272119plg.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eV2sqimESyEBoOWpToAEYIFXkSifHyaBR/mX+uJ/fkA=;
 b=R/PtdolzToTAPHuKJrWW3wHLAeRNHiipbOBV1SRMl1w66h6SAYZCJjbniBObk5trST
 IjmwAmkBP89x0OhC/YaGcAmuGqSMzvHcTZpwUiJkC2fGpKW7gJQxx76XEB//ldHQSBfl
 6sv8qBB+433XRwInTUJ19Kj4X4B4IkrOMQWB1bt6h6J2V8njIInnkBk0v2aSaALz9DpX
 jzv7IBDV2Ky9I/h2FWy1MjDjAUfaOeaJcBE8i3ob7CqBJ83gv+oBLWqw3/nmGJDnsMsp
 0noI8pbhbJfE+oA1XL3lbmsIe1EI+pFuxsItl9o0MDirj7eK+Q7lxz09tgkLlZMp0jRR
 kZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=eV2sqimESyEBoOWpToAEYIFXkSifHyaBR/mX+uJ/fkA=;
 b=8DZhNyUCFkYY94NUjkP4ziACjLrj5yuvrobKLZQVAU7Fima2BzXTlxBzRoCLLPDy9+
 1jWJZmGxP4gQJ1HovdTnjmzoBcvEIygiqQv6tPRT0LFM98b6VDHFTT08bYBsOuClgIEB
 T+wX1T5xA0F/JGDRF568+kti3w+fpPGiM9D5wS30CXPLgwHVyB9/UrARcKW5kqYfAJ/3
 uqqvC911YahXG+8b6SckktEwle2li1gl0BFuSMjltE5a6cg/5VqYgX1b78SHFDTKOe6W
 4g1pp/BL8T7Ia0MT3S73EvjfEkR/A95ZZMP+a6N409pzavyUc7BwFEQImxKzViyAlewW
 +zog==
X-Gm-Message-State: AOAM530FD5tfZnVjHJdJ+EFmJLSDVBiIWCPU0mU8LhkhFdrOgLJbTI6r
 ikb++DUH3L9fKjX6gS+62lw=
X-Google-Smtp-Source: ABdhPJx5bDWecPgzIRwKGZN78trXz3PN89rJuBhbVNd1U+08tfORCBQ/xNx7TroBLjKgcPh0HYBnBA==
X-Received: by 2002:a17:90a:f2ce:b0:1e8:3e55:bbfa with SMTP id
 gt14-20020a17090af2ce00b001e83e55bbfamr23908605pjb.204.1654622048983; 
 Tue, 07 Jun 2022 10:14:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:fa4d])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a170902edca00b0015e8d4eb22csm12792137plk.118.2022.06.07.10.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jun 2022 10:14:07 -0700 (PDT)
Date: Tue, 7 Jun 2022 07:14:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Message-ID: <Yp+HXowR9nTig331@slm.duckdns.org>
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
 <YodIquufXzK581gw@slm.duckdns.org>
 <8df16635-658b-b381-9a40-3544828910fc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df16635-658b-b381-9a40-3544828910fc@amd.com>
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
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, May 21, 2022 at 12:04:00AM -0400, Andrey Grodzovsky wrote:
> From 78df30cc97f10c885f5159a293e6afe2348aa60c Mon Sep 17 00:00:00 2001
> From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Date: Thu, 19 May 2022 09:47:28 -0400
> Subject: Revert "workqueue: remove unused cancel_work()"
> 
> This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f.
> 
> amdpgu need this function in order to prematurly stop pending
> reset works when another reset work already in progress.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Applied to wq/for-5.19-fixes.

Thanks.

-- 
tejun
