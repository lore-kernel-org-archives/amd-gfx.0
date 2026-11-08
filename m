Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00109606A320
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KT4gaisC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FBF10E642;
	Sun,  8 Nov 2026 15:02:47 +0000 (UTC)
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B09710E059
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 09:28:53 +0000 (UTC)
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-36caa19b0ffso22998eec.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Nov 2026 01:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794130133; x=1794734933; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SHRuDocsQ82mahFLnJgxxsiffMzQsz1Feg2GezQdVrA=;
 b=KT4gaisCxjkLhcsfENoZLfdVvLVif1HISZ+Pj3lAbnR4uzXs5PoGX6GfHuONXJrcbU
 UsAAAOXSdCK8QX9mIzVdg8PILIA4amo7vwq5uQi5HzC2qjf4oLxYK8x9ghRqS0+Yw445
 uArJVduW9zjj1/Rt7utOw2xRFKXvKgdFaNL0B23nlbJJOOMsjx48RS9WLP5dZLDE6Hvb
 guj+O9i1xXJif9Umur8y+qrKwEnqUC9+jsgWEkV7OSUt1gV1Z/OqeVFCC9b9UdwKnErZ
 vw+QEeoxUzlroSBNpoZclSEtByPHyObuLQshmkKkqP5NKazeES5k6Kreon2Xf0yzpKbs
 Qh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794130133; x=1794734933;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SHRuDocsQ82mahFLnJgxxsiffMzQsz1Feg2GezQdVrA=;
 b=kygW6R6WEJNysJnSnJHvITSBg/XOfzYpdURmWMAivSkDD1Q9IzN1zUsuR3d4xihG7c
 VNsldTYmrYLVX4+Lpa6Kki/psELHaBtO2DbqRANcnKII2klkkhfWUks6I2V7ob8xNdhE
 Y13rIcVs2y6q0IeqPxE1+rqoZQjLsGgnM1JldEeUzjiNgtPRUjqPxUQtS4ZY5HvY+Zok
 GiqKhLjKFwXaejYmMD4xbLNgcV1WvbwTiJ2OVFE19oBBTDxG5NZCpJ1ud1jkvbB+HG57
 fT5W9YTG+jhkg0ILjAHrgoUpUXCOFPo3W5P5M4OOmMJ/VXfC1a0LNpNN0pQyMQW52AzR
 Ij3w==
X-Forwarded-Encrypted: i=1;
 AL+hErF6pB2otmMC5+lWRjIisFOcdIPmeH2csoJIiGBcADHx+jVJNZXJaQD9KIFArYJJEBNY051K0PaU@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+u5NJkB6Cigr+QILmCdlJVi4d66QiGTwbOdtassarDeBKfnfP
 sgyUKn1EN8GRaZWwEQ6LQD1eIry5khCQtcne9mCM+mhHw9n4+A9C+RAn
X-Gm-Gg: AYBFou2WKVDrgfzua7G3mUpCvSf59EcBI52Pi36mYxrHjJupNeaFqI0l+D2naTnIS4h
 kRXjfL/BnavhBfG37+u+diJ8oIUcNzCdr8LAIbB53i0yziQWpieoJd/xZ6hxeq3ipE3Nw1hr/jb
 rGlON2TjeYoPt/wX+gAP1VLrbdvSxutOLHcxFfLpjPMBnfomPDyH1mqUoEBuf3wVb42QcE8s44W
 VXNnt5oD+mc4i+L9Ieh8yDOb3xeLnT/xTygz9YIozHPCK0KFg5j87VqyPBcfzE1eyweNKXKfnEz
 sfH+BHU4NhCKxpqebuN8VBcOqZUd5YvayTImDUoD4MQ7R1Pwm7to4GXkJ9h+tkKlTS3gn7WlC6G
 RpXqVlThNC3ko8UJBftZYG4o0SlErCJaE64VWccWzRcAwcZRIKqNGTmMdXktcTYPYKnU2Gi6MaJ
 +7PiEwXpAXiZsPJu0kTxuZ9l+ziwWtjQXHBDACLenvPlGaBogNJl6+HlSg6wKwHzL/hgNU/g2N4
 Fv0RPv+ZQYjNxTRIcd0iTskLqlj7BYuX7m82Lnxdtmz/3ucy1Gpyd9jgaGEgCCOPwxvYvUplbRh
 w9EG+1hRXlvpaQhK7Ws5azO3g6m6v4sBbraHXm//eeRlXUerrKV+FPD5KYvy/EMW0UgNF9zXstp
 qNsp95A==
X-Received: by 2002:a05:7301:7004:b0:36c:9b35:5d46 with SMTP id
 5a478bee46e88-372571d9ac9mr2446013eec.26.1794130132533; 
 Sun, 08 Nov 2026 01:28:52 -0800 (PST)
Received: from [192.168.50.20] ([50.7.253.42])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372667d78ebsm4250150eec.27.2026.11.08.01.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 01:28:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] drm/amdkfd: handle SVM interval notifier
 registration failures
From: Aveline Noir <jm5905938@gmail.com>
Date: Sun, 08 Nov 2026 20:25:29 +1100
Message-Id: <179412992976.2.9438818840890765075.b4-reply@b4>
To: sashiko-reviews@lists.linux.dev
Cc: David Airlie <airlied@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 honghuan@amd.com, honglei1.huang@amd.com, linux-kernel@vger.kernel.org, 
 Philip Yang <Philip.Yang@amd.com>, psirt@amd.com, sashiko-bot@kernel.org, 
 Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>
In-Reply-To: <sashiko-outbox-203586@kernel.org>
References: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
 <20261108-kfd-svm-baseline-errors-20261107-v1-1-9ef4008019ab@gmail.com>
 <sashiko-outbox-203586@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:02:42 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,SUBJECT_DRUG_GAP_L,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sashiko,

On Sun, 08 Nov 2026 05:35:46 +0000 sashiko-bot@kernel.org wrote:

> This problem wasn't introduced by this patch, but does
> svm_range_restore_pages() pass a page number instead of a byte address to
> amdgpu_gmc_filter_faults_remove() [1]?

Yes, I'll fix this in a separate patch.

Thanks,
Aveline Noir
