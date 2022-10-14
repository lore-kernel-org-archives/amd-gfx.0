Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96533C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Oct 2022 07:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0B810ECB6;
	Mon, 17 Oct 2022 07:11:34 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEEF10EA4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 02:41:42 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id o21so1104620ple.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 19:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZJ1ZupV4pNYtfLm2nRk080Y8SXTuWCwx9eOCEUYrnLk=;
 b=mOTc8KRBadMqtPwLlQpMoDRG7Y/LhVh3ONQQ0+J/2DeJP9z2WBpqzM2zCbruFAwGQ2
 Cg9NrAsdBApxkVi7G6+/BmIIhGYCILZRVDKJgLmeZAjnkd+DscSYsrIh2d0DhZEicFJ4
 JC0NBSOAxXyESKVnAJK6Z1UcYpKzjFbwvjdW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJ1ZupV4pNYtfLm2nRk080Y8SXTuWCwx9eOCEUYrnLk=;
 b=yDwN+hBkiEMaGaecRPxXAo5RmkxGur/gpOsxj5MBaP+INi3GObwhW3JcrD1jaslWk9
 4JPAS85dLhYIeNTdHngccc0ZZuV7WV7PF7CZ5o9nEDaVV/4Gjjcy0QvQRb16JdZtMhE2
 K7TTYgdmb7VWtVeyOkpQ5kfgGsT5WwFbkIEJIdLQ+Y7lJ53MOTz2wT7uViLQpNF/RaH2
 faXqDIn9g3YJge11UDVur6r0vGMTT7DkRtSdzlWcGvfBYm5j64KXhHm/Hz8GIGj0aWd0
 61AkjmU4iX8oqwV7PKoIS14U/i8wAnzCUSgakltc3s5U+HelfZtD6PNGs2WddRpAIMAv
 9a1w==
X-Gm-Message-State: ACrzQf1wZCdsF4QMWlRgnZmGsFcjkm2m+adrGz35+h8HoyyeN77ZOn1s
 8u4l6sIrx7KGUVuVML+GXQa4Mg==
X-Google-Smtp-Source: AMsMyM4+EvyJIPbh8SsjJ5/w//6R6z4mUB4NPnFpN2sJpNlsISjzDqMI4t1DceTMwEIjNQHzGR0rDg==
X-Received: by 2002:a17:90a:d983:b0:20a:ec04:e028 with SMTP id
 d3-20020a17090ad98300b0020aec04e028mr14425285pjv.122.1665715301104; 
 Thu, 13 Oct 2022 19:41:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a170902d4c200b001708c4ebbaesm467745plg.309.2022.10.13.19.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Oct 2022 19:41:40 -0700 (PDT)
Date: Thu, 13 Oct 2022 19:41:39 -0700
From: Kees Cook <keescook@chromium.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] drm/radeon: Replace kmap() with kmap_local_page()
Message-ID: <202210131941.5D2AD4403E@keescook>
References: <20221013210714.16320-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013210714.16320-1-fmdefrancesco@gmail.com>
X-Mailman-Approved-At: Mon, 17 Oct 2022 07:11:15 +0000
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
Cc: linux-hwmon@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Ira Weiny <ira.weiny@intel.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linaro-mm-sig@lists.linaro.org, "Venkataramanan,
 Anirudh" <anirudh.venkataramanan@intel.com>, linux-hardening@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, bpf@vger.kernel.org,
 David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 13, 2022 at 11:07:14PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Therefore, replace kmap() with kmap_local_page() in radeon_ttm_gtt_read().
> 
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
