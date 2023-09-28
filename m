Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95D5E732C8
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 13:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5825A10E642;
	Thu, 28 Sep 2023 13:20:16 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B1110E5D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 07:05:30 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-405621baba7so98022025e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 00:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695884728; x=1696489528; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9KD6LTg5MocDkm9XXqsAMkPcYaW+FgiMjHGRH14fDoA=;
 b=U+MJ2D1yHX8kpB+ucPVAW868I69VXMsaPWZspwJzH3O4yCDPYDhqX8BveWjtA1OjqR
 /+T47TtsS0PbOy/4h2MGVQfxDr6WdE63Xw1ifn46FgsKIFhMWO+t23IaG0csEpkfgph9
 PMlB97PGBgLjcsPgg3LXYWMJjkh/dpT8q+eW711n8GnntKsn/yaE+H7XXAMav9AYuPMH
 qUe7pcTnSvJAETPM3MCWbc9ylslu8PmJz17xNMaPrM4vkTxVfanhw9Y3Ubsq6MtN++ml
 XymhyTMOGkENuiScBMayMSTP794YAxRK88vtKXbu6zJlP7cSFs8DioSGczMdqrYBFLsi
 cE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695884728; x=1696489528;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9KD6LTg5MocDkm9XXqsAMkPcYaW+FgiMjHGRH14fDoA=;
 b=sk7EyxzyZMdNVCCW1zNkBhh1ydOCUSG4c07S1UbruOWqxXm2tTUdbkWOe856SUh/47
 RmVdKZgIbnnamfQu3JbEGhUM71VRR65CHGR3zXklp5l1OQgqS7bSbSCmRZ2LUHn/Qt7J
 XSCzejLdgxjgsMg0D/65p6M//X+WJYYR3CArUSF6P3dy3kejXpPyhAUfXluQuxzIKDPN
 bpFQPq71wiNR2HMbAELrvrUPt9yAwvYHYi+xIq7XEz8zsfyEduedIJBhB/7oLVKYf9zb
 P7kyHRbcZISOZSz0OnNdFMXlmfwvtqbdubfN9Hg5Nlq3VLKNdLg9dsi3hKHEgXVa76kr
 cvkA==
X-Gm-Message-State: AOJu0YwUh9kObonG5f8ymu3j5pC7TczQY4SFpZMlSagJOhnQ2EEFq0vu
 GpmtcULahLfIfyFwfKgBaqeWfQ==
X-Google-Smtp-Source: AGHT+IF3hNSuw23yvw2c/pmR6tcTr1lFYk1kCUk35u4VSWVDCSMZwId4cz9b3+c3Qr/tdYbSIq8QhQ==
X-Received: by 2002:a5d:5547:0:b0:314:1230:29b0 with SMTP id
 g7-20020a5d5547000000b00314123029b0mr360431wrw.52.1695884728429; 
 Thu, 28 Sep 2023 00:05:28 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm9746671wru.6.2023.09.28.00.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:05:28 -0700 (PDT)
Date: Thu, 28 Sep 2023 10:05:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ashley.Thomas2@amd.com
Subject: [bug report] drm/amd/display: add DMUB registers to crash dump
 diagnostic data.
Message-ID: <eef3f8a3-4d0a-40e9-a81c-f98514e57e60@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 28 Sep 2023 13:20:11 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Ashley Thomas,

The patch 2631ac1ac328: "drm/amd/display: add DMUB registers to crash
dump diagnostic data." from May 17, 2021 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:800 dc_dmub_srv_log_diagnostic_data()
	error: we previously assumed 'dc_dmub_srv' could be null (see line 799)

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c
    795 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
    796 {
    797         struct dmub_diagnostic_data diag_data = {0};
    798 
    799         if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
                     ^^^^^^^^^^^
Check for NULL.

--> 800                 DC_LOG_ERROR("%s: invalid parameters.", __func__);

The logging will dereference dc_dmub_srv.

    801                 return;
    802         }
    803 
    804         if (!dc_dmub_srv_get_diagnostic_data(dc_dmub_srv, &diag_data)) {

regards,
dan carpenter
