Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66801C04FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61737112C56;
	Tue, 16 Apr 2024 12:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yb1Ujhf+";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A11910EC67
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 18:01:57 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-1e5715a9ebdso27853585ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1713204117; x=1713808917;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MCdwh+b+sTwlfsv4su7NDJ4AdE7tSofK6h9u578+8Wk=;
 b=Yb1Ujhf+l/zU+FZ2Shi80O1zfYTKFEwkiuSRMUr2KT7y7LQ2JrXmLCnCoX7DRCSYMp
 HUR422nHrtAXkQwimzoHKKJd3SpO6n8E/w4wjcDzDnjGBjpZ00DNW9+xT6lzCixwqCyw
 abNBjdd1u1S22boaK4rp2UIKlT8VIvtGel8VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713204117; x=1713808917;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MCdwh+b+sTwlfsv4su7NDJ4AdE7tSofK6h9u578+8Wk=;
 b=FS6BOxEgEqfo+tHcqE/c2oaZt0DzOEqAN03JWswhiWh92t5P5NLV5hPOla9QGBGb6B
 g/sjGxUGqSDnUPmGX7/021+KDXCGv1S+uTIA40zbFWuLD6AR+u+zBahrYeNbWx5cB9U4
 qGbYFAB4U3I3yALTFH7g7THeBTFnU/o/Qw7RIy/I+nxOEZGCnBeZBubbr5uvV8LGVbDe
 DYZi935fOOVuga7DuUGqjygjsnVo/Y3mgCHWoRi70vQxTVdEp/B/mXCp+6d8f+OJbGun
 wmz8Tk6Usa2LEhlIiomYdVp0nAGYhTryvgJPK+I6/k4DVeJgPfuuwux22+2u04zKP4Kd
 GWHg==
X-Gm-Message-State: AOJu0YzKW+AsimDO8gI4/GYqFnMPWWT7n9DfafS+agToBO1fAx7atZuG
 1lBTwqGmLtUgDCOt1aukC9AYMz4/H7zYLDV8i79VeeaUKWoydLhsDhqoEG3/GQ==
X-Google-Smtp-Source: AGHT+IFGzDyoZdSg2A8MIcoveXzFtSf0Fxn8dMSNyPaudXml1Tt1lYQnYXvRfuZ9e08nQ2q6RxfSIQ==
X-Received: by 2002:a17:903:2289:b0:1e3:c7ea:e435 with SMTP id
 b9-20020a170903228900b001e3c7eae435mr12569113plh.44.1713204117322; 
 Mon, 15 Apr 2024 11:01:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a170902db1100b001ddb4df7f70sm8253082plx.304.2024.04.15.11.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 11:01:57 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:01:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: silence UBSAN warning (v3)
Message-ID: <202404151101.709E5A6AB@keescook>
References: <20240412142819.2379934-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412142819.2379934-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Tue, 16 Apr 2024 12:58:46 +0000
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

On Fri, Apr 12, 2024 at 10:28:19AM -0400, Alex Deucher wrote:
> Convert a variable sized array from [1] to [].
> 
> v2: fix up a few more.
> v3: integrate comments from Kees.
> 
> Tested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Christian König <christian.koenig@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

LGTM! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
