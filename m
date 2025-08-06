Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B680C87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 13:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBD010E76F;
	Wed,  6 Aug 2025 13:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jcfi6TFr";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAD310E279
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 11:44:18 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso579763f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Aug 2025 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754480657; x=1755085457; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V+xclzww9zhVZnrBcIEQYZHUgeeaGDY2SjA26hNKznY=;
 b=jcfi6TFrdGtlDT51Ox3tobwxLoDznPZ7cfmU5XUjtAsHGHp/r1UaSqWvOPd1cfL329
 kjaY6Ws6fG0gkpe4win20tl3oBVzziHSGX2xAYuDWUxXvMrS7B2hTZYADf9Zy1WK93+M
 sxmlzG3E4ycXHNamtFrDuQtu7W9x4zcpH+EFkcXNGDNY/VHuk5vP18RVJLrtIVPW26xp
 eCjYkApvKnIToshNNu4gcSBLVa1SDqaG/8NaM6IM32fk8KGQ2bcoJLCWG60kl+nJYQ1U
 VEV7wjbHp/58WdfVuneCvkXCH8m2MMZGtpFuIvFUZfXw0ARsKbEK5XMz9VGKAzIQ1JBY
 PS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754480657; x=1755085457;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+xclzww9zhVZnrBcIEQYZHUgeeaGDY2SjA26hNKznY=;
 b=oOlmy2I+itz+43uLC2EGDGQMBJIQhzYCDiMK8dUbf67FLu4/dJAriOMrprsRdrFOdf
 i3N38C9ReAz4a/s69zJ9L2IgKgdbko8S6C/GSyu0rVnCg0dxUHoNY/woKtCi5LHoXL0x
 xXHWB8Uc7NXHZPhBwJ/kFXhNlCQCtlWlzBloK5ucllIVlnGgzC0ZG5EZROl7hfohXOxr
 93oiufiJmWg4XbsLntF1a4q7JhxQPbcjUgPCkUDwiD/G1d7d0FC13lImlMq8LExU0VH1
 WDdtr2xql03IGcsuR9WhyIMXr6BRPXJlLwcaJskrETUb7QI6Vemc/vl/hS67WzvRCpNq
 TzkA==
X-Gm-Message-State: AOJu0YxoLxv1yZTqaIT5JvzXHNpUW8XdjYFpKa4P9hReeEM7faaJc921
 vUpAVEUAIJ8Um8bPEP6QWD53q6uOEpz3mE2MxYgOhWzllYvxK5d//m+a+b/2j6D50aY=
X-Gm-Gg: ASbGnctaWkiGL0PWOEqKjVtIa6robusXA4YaKciDYffOR6G688gB/ZUsbjPRR7Xxf3t
 7piunrBcg2VIkzMqB5AKuDIzDkZYIiiAQfxAOrAM7vcEueBrRSqIfusAFS+lfHLsUdMswPxBUD3
 dNi8lqQeakzPOAA7E/YB4oMjMlXbak4/h7aGC5g4ubNWCuRk8suacsQgVNB1UBZPYL4+A+SJ6/K
 c5Ysn7H3tHuu8+CnC8YmzmCVzgGvBit8Y0WK+oefVBX+D1QNEO2G7GkbvbmnwfeRNX0o8qC7Mro
 OFcYS8fAnBe4IoJZ/+21UEqU8t+C9Izb3oovABoQyQtya4CgqQzrTY0X4blonvKtPQ87xnHPme0
 Ws1BjhErhBTsNXgpoawmkPRWg5tE=
X-Google-Smtp-Source: AGHT+IEo5o+jSRJcamgbPX1LI1YvNkVZTkK0zgrqqyhAKU/znN9JB0NMQSjdbnm4eAFqHQmx7gnk4A==
X-Received: by 2002:a5d:64e8:0:b0:3b7:8735:9453 with SMTP id
 ffacd0b85a97d-3b8f42fa46cmr1856664f8f.3.1754480657167; 
 Wed, 06 Aug 2025 04:44:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3b79c3ac158sm23108909f8f.4.2025.08.06.04.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 04:44:16 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:44:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: more liberal vmin/vmax update for
 freesync
Message-ID: <aJNADS35YfuX8v3X@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 06 Aug 2025 13:11:42 +0000
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

Hello Aurabindo Pillai,

This is a semi-automatic email about new static checker warnings.

Commit 6d31602a9f57 ("drm/amd/display: more liberal vmin/vmax update
for freesync") from Apr 16, 2025, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:623 dm_vupdate_high_irq()
    warn: variable dereferenced before check 'acrtc->dm_irq_params.stream' (see line 615)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
   614			if (vrr_active) {
   615				bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
   616				bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
New dereferences

   617				bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state
   618					== VRR_STATE_ACTIVE_VARIABLE;
   619	
   620				amdgpu_dm_crtc_handle_vblank(acrtc);
   621	
   622				/* BTR processing for pre-DCE12 ASICs */
   623				if (acrtc->dm_irq_params.stream &&
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
But the existing code assumed it could be NULL.  Someone is wrong.

   624				    adev->family < AMDGPU_FAMILY_AI) {
   625					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);

regards,
dan carpenter
