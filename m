Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF87FCD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 07:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7921131C2;
	Wed, 10 Apr 2024 07:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V6iT7hPN";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88DC10E8B1
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Apr 2024 16:00:31 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-1e3e84a302eso20335165ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Apr 2024 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1712678431; x=1713283231;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ob0ro7FSSBWAju2FEQv6VuPCAZIPXeO9HsRIIgDJaOc=;
 b=V6iT7hPNDzhDkSHaVhoc7shzxuLb74UPKgyoHxO8QiXOp2FaHz2RYzRvBL5Z3g9l0O
 JCdvny7/mIkH6TDTkvaYuWJyJ7XIR//1kdV/8RqQyG6vMSS7pqTEGoEWFlHGI9qYpJ88
 GYQN9/zTXXhBdSkxKwenKl/g6HcYv6jaTvN/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712678431; x=1713283231;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ob0ro7FSSBWAju2FEQv6VuPCAZIPXeO9HsRIIgDJaOc=;
 b=MEaaMkIm+dCPmIVM6IYBHyPyBTMleOiM+JWhbpHOFU5B/e5xHiRpFdU/skCpNqyLK2
 pPT5BKlUNE/OHNQx2Fn5kTxot24lwCVjezByED95RgKuk0inYp9fcg7WEgzyX3xZFC7u
 GAQVdRscFdocpn0+adIyVJ7eccZn50RxlHS7ozPSza8t4VT4ehzs/pWCG6loy1QtfUzO
 dqTqMRVZI47gK+hhu3QKtgr/XBg0j3ft+a+KuuQjFFrFuUK1MxnF8R5NbWFzbc12YTSX
 oGaga/HbDg5lktk1RwxOri+Tfkgwc66LhJBXS65FkYJ62jiPGzhgRuCv+I6vEgzq5w/V
 2Qyw==
X-Gm-Message-State: AOJu0YwB4l7y2OiUNkPNphcjBSTiZvwGAHRyZUABDtqtNAtkVWPFR8Pw
 tDekffLks1cw6SufME1+qy6m70aJEyVYY4hsv7KQ8F/8eObKfhpyMhuexK06yA==
X-Google-Smtp-Source: AGHT+IFc4Kh82+1yv0nm+3V7eZ28kcTLWxWAaNynUAjJdUyF3a5Lei27EJTrvaKBmYzBJ1KNbyKDGA==
X-Received: by 2002:a17:903:11d0:b0:1e2:8832:1d2c with SMTP id
 q16-20020a17090311d000b001e288321d2cmr206922plh.27.1712678431029; 
 Tue, 09 Apr 2024 09:00:31 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a170902f25200b001e256cb48f7sm9046147plc.197.2024.04.09.09.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:00:30 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:00:29 -0700
From: Kees Cook <keescook@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/radeon: silence UBSAN warning (v2)
Message-ID: <202404090848.2C6802635@keescook>
References: <20240408173748.6598-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408173748.6598-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Wed, 10 Apr 2024 07:12:48 +0000
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

On Mon, Apr 08, 2024 at 01:37:48PM -0400, Alex Deucher wrote:
> Convert a variable sized array from [1] to [].
> 
> v2: fix up a few more.
> 
> Acked-by: Christian König <christian.koenig@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/radeon/pptable.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
> index 94947229888ba..3493b1f979fed 100644
> --- a/drivers/gpu/drm/radeon/pptable.h
> +++ b/drivers/gpu/drm/radeon/pptable.h
> @@ -432,7 +432,7 @@ typedef struct _ATOM_PPLIB_STATE_V2
>        /**
>        * Driver will read the first ucNumDPMLevels in this array
>        */
> -      UCHAR clockInfoIndex[1];
> +      UCHAR clockInfoIndex[];
>  } ATOM_PPLIB_STATE_V2;

The comment slightly above this hunk says:

      //number of valid dpm levels in this state; Driver uses it to calculate the whole 
      //size of the state: sizeof(ATOM_PPLIB_STATE_V2) + (ucNumDPMLevels - 1) * sizeof(UCHAR)

This is wrong now, as ATOM_PPLIB_STATE_V2 isn't over-sized now. It
should be:

      //size of the state: sizeof(ATOM_PPLIB_STATE_V2) + (ucNumDPMLevels) * sizeof(UCHAR)

or better yet, struct_size(ATOM_PPLIB_STATE_V2, clockInfoIndex, ucNumDPMLevels)

I couldn't easily find any "sizeof" uses against these structs, but are
you sure there aren't size changes associated with this adjustment?

Also, if the comment is accurate, then clockInfoIndex can also gain a
__counted_by annotation:

	UCHAR clockInfoIndex[] __counted_by(ucNumDPMLevels);

The use of __counted_by() seems like it could apply to the other changes
as well?

>  
>  typedef struct _StateArray{

This has a fake flex-array as well, but it's a flex array of flex
arrays. :(

typedef struct _StateArray{
    //how many states we have 
    UCHAR ucNumEntries;
    
    ATOM_PPLIB_STATE_V2 states[1];
}StateArray;

I suspect get_state_entry_v2() may trip the runtime checking too, though
it's using a bunch of casted pointer math instead of direct array
accesses, so maybe it's avoid the instrumentation for now?

> @@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
>      //sizeof(ATOM_PPLIB_CLOCK_INFO)
>      UCHAR ucEntrySize;
>      
> -    UCHAR clockInfo[1];
> +    UCHAR clockInfo[];
>  }ClockInfoArray;
>  
>  typedef struct _NonClockInfoArray{
> @@ -460,7 +460,7 @@ typedef struct _NonClockInfoArray{
>      //sizeof(ATOM_PPLIB_NONCLOCK_INFO)
>      UCHAR ucEntrySize;
>      
> -    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[1];
> +    ATOM_PPLIB_NONCLOCK_INFO nonClockInfo[];
>  }NonClockInfoArray;
>  
>  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record

-Kees

-- 
Kees Cook
