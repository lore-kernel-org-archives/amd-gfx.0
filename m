Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AEFC79FBE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 13:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276D810F144;
	Wed,  9 Sep 2026 13:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aicharmers.com header.i=@aicharmers.com header.b="lPy9xgPb";
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F6B10EFA3
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 08:02:47 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-6b1497f0453so3976206eaf.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aicharmers.com; s=google; t=1788940966; x=1789545766;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NVqqZQHFQjLI1fAxKN559sk1nfYU8tizBv/uHckeKLc=;
 b=lPy9xgPbR8Fd2ypCWnF+dwl8JmPnM4tZ5BWx4f3A4sb4EUxNZguI/6nC9wuyFAuUI+
 CXnTzsy0Iby1GMW8SAFwkwC2lrN14n6huLnwaFQfIGNHZ9ian6Z+VEtngqO6KWjEOwjl
 acZQvIoDYjzJG8epopJ0zgoqyj3EWDsFHbQw/ONEgZvKYsWWKeZFKPq0RNzushD1SBOl
 2ah4DoIDe8fRtx7wmIhM+RjqV+BSmI+2ASJLOE83sYTiZB0GRox7DaI9+67JAt3nTTuI
 8FGLRjRjjfCjKu0V7s50B42jBg1CHBaIWLj308AgK/fLIYFaftR34gGkIJT08j9qgh1n
 T2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788940966; x=1789545766;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NVqqZQHFQjLI1fAxKN559sk1nfYU8tizBv/uHckeKLc=;
 b=lF4I+ORoY6/QoOEequke42UKz/EfJzLRAqm7LxEGigBbGCraytHAPhdRGzF/uvfMAJ
 +frUyp+BjN5Ix1e86VT9Wu9NqxCwvopasyNpVilRn2Gcx9/PZ7jrKtr+Q5pQv4UiWio+
 5y9oMP2/KpbBTntSEzRzKnhRuT6/XIg+0tpzS2mrWqM463nY0o3cs+Ol1p9K7h4z/lYI
 5FFzlhz7/evzvcC5YZeJJnGLDGTU5BJbu+Lak9bIVu7DIQlMIP2nTmJ0qztofDcebAyP
 jC3AVIdihNmUuaTPU6eMTJJj1JImv2L/dM4ya1hBpL2VeNsRinxT0PrFNzAeUBczNFv5
 0Bdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwazZoR5BRZU97kmROnIJ3RJeQbstN++y7gmKbHGw+wUD0vuz5XSHlwea+wpu7FCnxmPUVZjFF0@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMtPlQs9B2J7ZEEqrPj0AchBaBFPzR9AmJnwE9NjiyKgY1RGGG
 sM6f+5XQU7bWl63TBAp/YpqAX3BfHjF3ltRfZyHVPAieaFXavNvfZm6WwvZCt/BY0K0=
X-Gm-Gg: AYBFou1PTxEeDLR6VH+DDJQhWKN+dPuANhLyye8vnA3j4NPQqHQXWrvmNmrJ6M75HKy
 tv+arbiLbcng61CEEtfjR4R9e7aHibjQq1BlMyYv+4ByeF7EIv95llizFbEIf6ald3VyDPupfm/
 qiITkOysWZw6QduRmfWLP8ueuFSc7F5lUf/axsVFF3JBaUXNcQTI0tOeMkk+i8mZk64sC+Xv57W
 2fEncRZmdugifLoACZQ/hMvL6Ppfsx4KrftGX8n7tlgqibTW10omW4bXIQ6Qca7NKorxml84muK
 gY0m7iNruuHr5wDF2+4hrYruQYyKrGGeF4yjB9x/CDQZfhZwOHI0ZoNKlYDn5FTLPU0dCBKm5g0
 ywjqj7+FrZExCNhsCz3ROOaxCyUML/eA2+Cz6wjlV/Q3D2PKVxcwNKA40NOMYskPPF8TTm4R4w7
 SOHyMhL4lXfeml5M1GBf4HDbB8+yk8jBcZ1FiWouKl8yVCrMyPrBAGmNfkxmJXRSGnDhsj/aRSP
 uTFknZrenS1o27r0wd1WE6zpkoKp+Qap3/8t3T3zr5SO0GJXJSZ+budvcp3yCIU2urBN1AA1qIm
 RmFK7xj193CikU3FUy5XYtcCjmCZ2YDk+EDMMDvMtypU
X-Received: by 2002:a05:6820:16a1:b0:6be:9627:196 with SMTP id
 006d021491bc7-6be962710ffmr414461eaf.7.1788940966464; 
 Wed, 09 Sep 2026 01:02:46 -0700 (PDT)
Received: from ip-192-168-20-24.ap-southeast-2.compute.internal
 (167-179-142-232.a7b38e.mel.nbn.aussiebb.net. [167.179.142.232])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbf1feesm42549886eec.26.2026.09.09.01.02.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Sep 2026 01:02:45 -0700 (PDT)
From: Ed Schofield <ed@aicharmers.com>
To: Kenneth Feng <Kenneth.Feng@amd.com>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 "Guna R . Bharati" <062bel313@gmail.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro
 5300
Date: Wed,  9 Sep 2026 18:02:09 +1000
Message-ID: <20260909080231.85025-1-ed@aicharmers.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com>
 <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 13:00:09 +0000
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

Hi Kenneth, hi Atharva,

Thanks for bringing the two threads together. I've tried your suggestion on my iMac20,1 (1002:7340 / 106b:0218, revision 0x41), with SMU firmware 53.38.0. I tried two warm boots and both failed.

On the same AMD staging base as my RFC, I moved UCLK enablement to the beginning of navi10_set_default_dpm_table(), along with the readback check and supported-feature update. I removed the later enable and refresh from post-init. UCLK was still excluded from enable-all, and both memory-voltage features stayed the same. I didn't add any delay or extra mailbox tracing.

Both boots reported:

    SMU: No response msg_reg: 8 resp_reg: 0
    in params:00000008
    Apple 0218 default-table UCLK enable failed: -62

AMDGPU failed to bind in both cases. I checked that the experimental module was loaded and the firmware files hadn't changed.

This also fits an earlier test with T2 7.1.8. With UCLK excluded from enable-all, I tried enabling it separately immediately after smu_v11_0_system_features_control(smu, true) returned successfully. The trace shows EnableAllSmuFeatures returning 0x1, then EnableSmuFeaturesLow with argument 0x8 timing out with response 0 and -ETIME.

The default-table function is reached only after enable-all returns successfully, so waiting for that acknowledgement doesn't seem to be enough on this board. I don't yet know whether it needs more time or some other initialization step. I'd keep post-init for now: that version passed the ten recorded AMD staging warm boots. These tests don't establish the earliest safe point.

As for Apple, I can't speak for Apple or confirm their approval. I'm testing this as a Linux user. Do we need their input before merging an Apple-specific workaround? If so, could AMD help find the right contact? I'd still welcome a fix for the underlying firmware problem.

I agree we should coordinate the two patches. Mine covers only 0218/rev 0x41; Atharva's covers 0219. We'd need to test the combined change on both boards before broadening the match.

Thanks!
    Ed
