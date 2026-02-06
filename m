Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A6CEE20B1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8ED010E7E3;
	Fri,  6 Feb 2026 14:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zrQVBB8Q";
	dkim-atps=neutral
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FEC10E74B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:41:03 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-48069a48629so19408135e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770385262; x=1770990062; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=L4wcUhQ3FNh4u/EXh+x6aUXh5+ro8iD671/61i0x1bc=;
 b=zrQVBB8QgKLorGDoQ2MHfcMEnFQzUq9JnmnL8JaGMTGvg2AlyZK6yIEv9N3uw5Q9vN
 C9Rfm7qbtga81V1DNHt56bY5+gqQXB2Ggc9ISkLb/JaVvwskA62cpXvlaaf60o6c0HMi
 aGUzMV9g8XjfVYUI3KpQRs90ewvV0fOLJgLCBI7iFLVBPD6eH3HmHzKKIZzPb9bu/T4S
 Zvyr/oNjRswUoLS9Ypy5JCOtyrSxYm8VQnQbPcGsOjjdGqP1cNC4Oq3L31cwhKSYVhHv
 LL7EW2YVTHz5eQV0xbZnVSrWFxHDdG1lNfk98djfBKD657cWXQiW8YEwIHP8tR2+09y0
 8oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385262; x=1770990062;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L4wcUhQ3FNh4u/EXh+x6aUXh5+ro8iD671/61i0x1bc=;
 b=BZ2W6Lf53uQcsMRxNHqTqgH478ZkNL87zi3lvzGulDgxF5c476KnOnwNUlVLUgRjBs
 +KsJioHRFlFPFnOwopBWN/edTNn8OdqoukywgXO3uItVN+ZJe9etGl/CjbNeSSV57M8V
 PjzHYQnlHMx3WOSkFSt9IwekAyN6yLPaCziXHDwiUwlGAFiKjFqqcd5avMGHUVYbb3D7
 PtiP3nLRmkmXHDjpTavCS4m7++tKQHpVLbwV6xN5hNL3iqYvQU4MnL+VZQxDC3KRCZEi
 r947YZL6q95/mlx+WRsyLzl1tiVp9/n6ybyff4Uer/dfv/PtKKsT9Mm761KwNhst3w2X
 1lIg==
X-Gm-Message-State: AOJu0YyyF/8PCAZlUsL2PGhRRegGn+/idAt5GcHBamURO2q1526rlt53
 HxEeu+CYEEhVR5nmfmJM6+lGLMXXgNo4RWUPzBPjPeQ1qe8RrNetm9fK2WViJjhHpWo=
X-Gm-Gg: AZuq6aIeAREjOnPv3KfbeB0K6R1N7/HEwm4/Z/reWe1ErvDPjEUlmF8fBLume0htZY8
 oNlOzb/BlmQUI1hrYiIiboiudMOjv8S5DqWJ6gtC3OO9M367sRkWiMaSu8HqATl5U9Da7XXjqHQ
 gHwr/q532MaZJ0d3N8q0RzJRm9+xemRLTX+x3Gq269Gph5w/f0i1pnkJcNVnWA6izjlFJdx9Bx1
 Jc0BqUFYzKwWdsUB1zWoF4uETUzXOQQnMIy8xLECDnyIb0Zq+ypDjjrwjgyEDf4BL8OtC1e6sAR
 N7ER2mINUUPry07CjtzZfdmJ/E4Ssy00kaY36RPi33gJ7qMyTLHxqPaEXWx5M2QTdh0tx568Zc6
 j2Widv+EdabmIaUPxzTdXDugTHllpA/5edM7RKCn4l4IrD00DCQkiAQbLZ0Nq1kE5zC/J4j920R
 MlohqovHKzeqh6OpRf
X-Received: by 2002:a05:600c:4444:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-48320216ccemr42226725e9.24.1770385262076; 
 Fri, 06 Feb 2026 05:41:02 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d835f0sm127113025e9.14.2026.02.06.05.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 05:41:01 -0800 (PST)
Date: Fri, 6 Feb 2026 16:40:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] drm/amd/display: Only poll analog connectors
Message-ID: <aYXva0vNgvjdwvk2@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Mailman-Approved-At: Fri, 06 Feb 2026 14:22:59 +0000
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

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Timur Kristóf,

Commit f6cc7f1c11a7 ("drm/amd/display: Only poll analog connectors")
from Jan 18, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c:940 amdgpu_dm_hpd_init()
	error: we previously assumed 'dc_link' could be null (see line 931)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c
    923                 /*
    924                  * Analog connectors may be hot-plugged unlike other connector
    925                  * types that don't support HPD. Only poll analog connectors.
    926                  */
    927                 use_polling |=
    928                         amdgpu_dm_connector->dc_link &&
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The patch adds this NULL check but hopefully it can be removed

    929                         dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);
    930 
    931                 dc_link = amdgpu_dm_connector->dc_link;

dc_link assigned here.

    932 
    933                 /*
    934                  * Get a base driver irq reference for hpd ints for the lifetime
    935                  * of dm. Note that only hpd interrupt types are registered with
    936                  * base driver; hpd_rx types aren't. IOW, amdgpu_irq_get/put on
    937                  * hpd_rx isn't available. DM currently controls hpd_rx
    938                  * explicitly with dc_interrupt_set()
    939                  */
--> 940                 if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
                            ^^^^^^^^^^^^^^^^^^^^^^^
If it's NULL then we are trouble because we dereference it here.

    941                         irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
    942                         /*
    943                          * TODO: There's a mismatch between mode_info.num_hpd
    944                          * and what bios reports as the # of connectors with hpd

regards,
dan carpenter
