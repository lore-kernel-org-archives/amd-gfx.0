Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C8C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 13:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567B810E5D1;
	Wed,  9 Nov 2022 13:56:39 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761F510E557
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 01:22:04 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 d59-20020a17090a6f4100b00213202d77e1so470711pjk.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Nov 2022 17:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X/7LWEJz0+L5ZmpQmdaQTLywAe07bO1jBNMRgwCToFg=;
 b=JC3ABDrxqqlvCMQDvshcXI7nRZ2IAs+p1gg9FcQkt4gMOI9VtHZp/D/ggc8GJnMbX3
 57F+7cto25IxlIv67TdOLlFXUpyGUJ8+EOqmQqRAtQvOBoQi58h9QNCO775JiLmnaA/P
 pQLrbKtIGYQLLa//xuwYo1MAQiTjan98e3oRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/7LWEJz0+L5ZmpQmdaQTLywAe07bO1jBNMRgwCToFg=;
 b=CTvxHZviItyNvCV1LFw/rVrBqw4ZVid2q4dUzUrXe1xKVc/g3Bb59mUWzqs6+3uB//
 lA8UfQi+sy0KCyIb2SM7wGDfnpxTPyoly4ETRKPVAUkuuE+Y78/FWoxIbGaRa7SjITUq
 AOXPwBfOKJeyN2PK3ksUV113RYYAlh/FmCE9bVCbkyjRyarPS7sxhbAW5Mlu1yeGWo8z
 yr0fdDpJYrZzbsuF8K457b9EqvP5dyVTRiOF/wObXhVnZuijmv7ygasb3IxQ05GWQ3K9
 +NyRDRcJA9an+21HCgyS1zNDlKmhfvUEfpU1igFEKhCCtefwEOI5VMsRcq4vjYyLfQKo
 a7DQ==
X-Gm-Message-State: ACrzQf2b+nmMA6eHKemt7lEQsS53AALwYX41tsfpZeIiVRt4CcBRjyRY
 URFv8Wb3XN0ux/o40D0Rmv60LA==
X-Google-Smtp-Source: AMsMyM79wV03PeOCgAWiXl4AktoLEnB0mGs99UWHXE5f72dWr3bJFMGh0MaQKuBmpYynGlRLpU9/BQ==
X-Received: by 2002:a17:90b:2393:b0:213:ecb2:2e04 with SMTP id
 mr19-20020a17090b239300b00213ecb22e04mr47944640pjb.100.1667956924038; 
 Tue, 08 Nov 2022 17:22:04 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:953c:d63a:4da6:1064])
 by smtp.gmail.com with ESMTPSA id
 21-20020a170902c11500b00174c1855cd9sm7545805pli.267.2022.11.08.17.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 17:22:03 -0800 (PST)
Date: Tue, 8 Nov 2022 17:22:01 -0800
From: Brian Norris <briannorris@chromium.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Move racy global PMU list into device
Message-ID: <Y2sAucYLR4FsGIfc@google.com>
References: <20221028224813.1466450-1-briannorris@chromium.org>
 <6e237301-9c30-a463-0f28-5279e655646a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e237301-9c30-a463-0f28-5279e655646a@amd.com>
X-Mailman-Approved-At: Wed, 09 Nov 2022 13:56:36 +0000
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
Cc: Xinhui <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 08, 2022 at 11:50:04AM -0500, Felix Kuehling wrote:
> While you're making the pmu list per-device, I'd suggest removing adev from
> the pmu entry because it is now redundant. The device is implied by the list
> that the entry is on. Instead, add an adev parameter to
> init_pmu_entry_by_type_and_add. Or you could move the list_add_tail to
> amdgpu_pmu_init and remove "_and_add" from the function name.

Sorry if I'm being naive here, but does that mean trying to navigate the
list pointers to move from a 'pmu_entry' to an 'adev'
(list_first_entry(), etc.)? There are quite a few cases where we're
trying to go between 'pmu_entry' and 'adev'. I guess I could turn that
into a mini helper.

I'll also need to scrounge around a bit to see if I have an amdgpu
system around that actually supports PMU. I realized the one I tested on
doesn't actually hit this code path... and this would be getting a
little less obvious/trivial.

> Other than that, the patch looks good to me.

Thanks for looking!

Brian
