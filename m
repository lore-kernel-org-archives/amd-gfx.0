Return-Path: <SRS0=tImT=KE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751C8C433B4
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 15:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD4560FF1
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 15:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD4560FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776686E20F;
	Sun,  9 May 2021 15:42:16 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6364C6E1CE
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 May 2021 12:11:09 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id y32so11331504pga.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 May 2021 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rgnivCnwUOL+7jUiwYwX1I74kp4hGBvTbYjp5pejkHE=;
 b=aXY8W1aSADd3h7KTimcqLEAaFMPpxUt1bfmOiH1rQeEY2mFqYxliGk1fK2H/9DHYCu
 ODSijyR5MXCOqnkMqnHDSdogm6l8PytZk8todvMt3ZQ1ppdUGardJasoDpknHv0KfmO5
 /12WpYEu4xVkDnLro024lI4aCCQJ80LwPk2+ec9qF7xpoXTGlQvfImcrVkA2IGW+wpUh
 a96Z7TpqWkmXUDoMwNcSz1sX+F+QemOtgIKT1hPkSst+uulEUJvJXTgVA8lbUBueaIAE
 eupLgvuKhh4MCNdV+Oi6xVPuSq0Ga55OPng0YYi95/Gq0nxngWpn+fBHwyeUKPmr0lus
 XEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rgnivCnwUOL+7jUiwYwX1I74kp4hGBvTbYjp5pejkHE=;
 b=cn+kt398YinbKs0R97k6ig23/bHLeGbnjqJ/MSBWhYZMey2+/Iu6mYU3CPJHU1jc4e
 bIRT4mSWKSByVDW1TukMeh1Oj5L1X6MHaEOokfgpuh89ga/acmuXSWAVyM20TYrWlvv5
 h4W/wDhHu888W3ObhIVEuJxf4KHKB9bk6eJUThfbmV9rYsp5gDo83Lwbb4fv0bhRnlsv
 jFV0T4jGQ3vJ6p9TNejRa5M5696dTaAjNh9ta+GVV9yUjNpOxdoIlRlb8t2bU04olPw7
 SND3c8+TyBEPZWme0XvN0DRM9CF3ct+LR/EkB4Ydzz98lci0coBHYGTfec/MgEkGPNzu
 zCvg==
X-Gm-Message-State: AOAM530KfKzNQUSbwQD34PTtZInHFOVkbmp5AWueFcZgPx4DkYiXnOPA
 AUMHWOA6PXsWuURW5vcvcFY=
X-Google-Smtp-Source: ABdhPJwCNMY37pXoAhszbNse9uNUm+L2/gxVBAPvQtc7Xrc2z/CaEkBkDPeCVhc4iloobnBW80KSsA==
X-Received: by 2002:a62:1c0f:0:b029:25f:ba3c:9cc0 with SMTP id
 c15-20020a621c0f0000b029025fba3c9cc0mr19637319pfc.56.1620562268641; 
 Sun, 09 May 2021 05:11:08 -0700 (PDT)
Received: from localhost.localdomain ([104.200.131.246])
 by smtp.gmail.com with ESMTPSA id g13sm9505146pfi.18.2021.05.09.05.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 May 2021 05:11:08 -0700 (PDT)
From: youling257 <youling257@gmail.com>
To: qingqing.zhuo@amd.com
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
Date: Sun,  9 May 2021 20:10:55 +0800
Message-Id: <20210509121055.24728-1-youling257@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414233533.24012-2-qingqing.zhuo@amd.com>
References: <20210414233533.24012-2-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 09 May 2021 15:42:11 +0000
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
Cc: markyacoub@chromium.org, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, daniel.wheeler@amd.com, bas@basnieuwenhuizen.nl,
 alexander.deucher@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I using amd 3400g running with android-x86, this patch is a bad commit when i use android-x86 on amdgpu.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
