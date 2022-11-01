Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F129CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 08:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEAA110E448;
	Wed,  2 Nov 2022 08:21:37 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FA310E032
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 23:40:07 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id y4so15022867plb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Nov 2022 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HMjoSMseYo9dv+OYtpDQcotuckgj0OnEhXYZObymQfA=;
 b=N4bCntNKJyNrCrWRnxFbKWGV538e38A/akJR4zZz/OuvuV1Bx92CKGBWkW4XIkb+mg
 at2PxLtvS+9V8fzxowpA0pMEHI/pFRmIUoF3dIlw96H4BwhgK79jOTHaNSb4ib3bQqJE
 AjvoxglA+JnoO3xYI+DkujScXt/j12hqgfLIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMjoSMseYo9dv+OYtpDQcotuckgj0OnEhXYZObymQfA=;
 b=oJ6eC96ArIk1LSJeqQd+U9jrjLcEPXEybIx3u9ajTr7XaSL2HXWnHLX5KE9yRUjiwg
 ajGk/Q3lL/5RQbN37zHqy5QFFEycGJYaJguhWLnX5ST9aBEm7O5AXCCBbw7cdgTVaYwM
 QxqM90qLMa5Uic6BAkhWt3hJYt/duk13mmM7qXxu1pT/Nj2xuvyYZaxHmZZZrqJglhZF
 tkkWRe2ctdn03pGbZN3t7KYfXhua8Cu8lRnNtHjR9fGT8YG1StbeOCuh/uDExkpzbgB2
 eEXI1ZJ5AeSOeuN46x56mAcYJdPuy9tHXckWlKchJAB07ss7GoYfC4iB5PrJnCqoujYe
 CVcw==
X-Gm-Message-State: ACrzQf37w6HGdtj/fy5Zl+dRiDL/q9VCRT5NLkayTnAz+VDKJwTKU8re
 rGVKmTB5l839Qdb83IQFcUV2ug==
X-Google-Smtp-Source: AMsMyM4P4eIG6ZNPzEizuQdoi/YqYr8KPBMw3NArEJ1RJ/GARU4RtwCb2NPtiryMlgBp+ThPDf6xZw==
X-Received: by 2002:a17:90b:33c3:b0:213:f5be:c3ad with SMTP id
 lk3-20020a17090b33c300b00213f5bec3admr9845989pjb.123.1667346007336; 
 Tue, 01 Nov 2022 16:40:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 20-20020a621714000000b0056ded8d5918sm636830pfx.134.2022.11.01.16.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Nov 2022 16:40:06 -0700 (PDT)
Date: Tue, 1 Nov 2022 16:40:05 -0700
From: Kees Cook <keescook@chromium.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] drm/radeon: Replace kmap() with kmap_local_page()
Message-ID: <202211011639.4938CC9@keescook>
References: <20221013210714.16320-1-fmdefrancesco@gmail.com>
 <fb0b7389-7121-04f8-176d-1ababe0ad8f2@amd.com>
 <CADnq5_PP3VCXQ5rbC0-8Qsi5W7Ew87U_bRknz4=qxbrPxVQ+qA@mail.gmail.com>
 <1942083.usQuhbGJ8B@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1942083.usQuhbGJ8B@suse>
X-Mailman-Approved-At: Wed, 02 Nov 2022 08:21:32 +0000
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
 linaro-mm-sig@lists.linaro.org, Alex Deucher <alexander.deucher@amd.com>,
 "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>,
 bpf@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 02, 2022 at 12:11:53AM +0100, Fabio M. De Francesco wrote:
> On lunedì 17 ottobre 2022 18:52:10 CET Alex Deucher wrote:
> > Applied.  Thanks!
> 
> Many thanks to you!
> 
> However, about a week ago, I received a report saying that this patch is "Not 
> Applicable". 
> 
> That email was also referring to another patch, for which I'll reply in its 
> own thread.
> 
> That report has a link to https://patchwork.linuxtv.org/project/linux-media/
> patch/20221013210714.16320-1-fmdefrancesco@gmail.com/
> 
> Can you please let me understand why, despite it was applied, this patch later 
> shifted "State" to "Not Applicable"?

The kernel has multiple patchwork instances, so you got an "N/A" from
linux-media, but it was applied to the drm tree. (Yes, confusing. :P)

-- 
Kees Cook
