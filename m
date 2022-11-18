Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526EDC4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Nov 2022 13:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912B310E01F;
	Sat, 19 Nov 2022 13:14:59 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA5410E0D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 23:32:51 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 w3-20020a17090a460300b00218524e8877so7933004pjg.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 15:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sF+mjl1jC0hLTc/ZO4U2u3tN+h/LpCMa+fZR8zog+RQ=;
 b=oSrB4hAbMX6lTfJDPKaVq5iQSuyUyKUtsCOu4mXQ4ttQRxAJ7lx/7hsbifQ6kprOsj
 gQVSo+PfRc/ojwLAWauHo1SKiKVoQQXJ+gTG6qGGxNYDQdP4iyBLnwTSfmVqMqFehzrC
 g+eKagomB6RZYdtIiUIpCSk19uBk3bJ6dX/M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sF+mjl1jC0hLTc/ZO4U2u3tN+h/LpCMa+fZR8zog+RQ=;
 b=miSTXlIj8z/LuY4dIyocR6chIsCoB8ChBPEBorQ5l/Yu7Zomft6W4lNmryINSQ39OO
 59X/NyiXniFaD06W3ODwasnoTteOIaYqs/bkkUDbwOtSECHlrdc1a447EOJaGxJG5w14
 od+kv/RkfpLlIRDczIRjVLiWgFt2ZQt0SFEtZitoX9WyA/pyEBQA6qtIbIaJnIXM41IQ
 Rcv75o+o1QSrQyESVD2tvpkvAEKlHJs3ZBtQWA4vg3A3u6oX3OrVsi6aJvVQKvfh6idg
 HescekTWNSW2dzuFQZYEGGZe7ZM+Q9LhsHLJvAxxVI/WB00m2Lp7rPX4n++g4Y+4apDi
 RX1A==
X-Gm-Message-State: ANoB5pnup/PF+L0Xm96UBUHPBbsh/UAXt+kA4vSSbC8cl8+YyDIJAvfQ
 +ICPtGI2x7AjYBrr/hu5IvaOgA==
X-Google-Smtp-Source: AA0mqf6+ymBGi/GDL8Zl6LSbwXOkYnX1J8FgjF+VEzn6WbWLCrdOPsqrSMJBEnlNtaUatbvJPpzGtQ==
X-Received: by 2002:a17:903:1311:b0:189:1e5:8422 with SMTP id
 iy17-20020a170903131100b0018901e58422mr1818781plb.17.1668814370987; 
 Fri, 18 Nov 2022 15:32:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a170902e84400b001767f6f04efsm4317543plg.242.2022.11.18.15.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Nov 2022 15:32:50 -0800 (PST)
Date: Fri, 18 Nov 2022 15:32:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Ma Jun <Jun.Ma2@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix the memory overrun
Message-ID: <202211181532.7E8F1C88@keescook>
References: <20221107070806.1217215-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107070806.1217215-1-Jun.Ma2@amd.com>
X-Mailman-Approved-At: Sat, 19 Nov 2022 13:14:56 +0000
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, guchun.chen@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 07, 2022 at 03:08:06PM +0800, Ma Jun wrote:
> Fix the memory overrun issue caused by wrong array size.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
