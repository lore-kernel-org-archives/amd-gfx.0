Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30889C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 20:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A913010E14A;
	Mon, 24 Jan 2022 20:21:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9438310E731
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643055500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LK256wQogjCX5wa9UmsP7s8Vi1buTBnWqTcBCjO4e1M=;
 b=L/XLgTOZ0Kvqjw+/FggItrh1/yqVyFyY9IXNh5vV4NQJTPN+g/tHTT1EFnjtAyEJpbvhtd
 9rX6TXm4j6JcLztDa8QAIHS9+PWbfycxEewcYMoR2h3tL8AOEc2brxKMWuxA1mOOr8sxCs
 mkcY9NIwD2imFRNDOUEUeZytHDi5q34=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-7gterrxQOw-4GYvTjbIRPQ-1; Mon, 24 Jan 2022 15:18:19 -0500
X-MC-Unique: 7gterrxQOw-4GYvTjbIRPQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 u126-20020a4a5784000000b002e3688852c8so5373698ooa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 12:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LK256wQogjCX5wa9UmsP7s8Vi1buTBnWqTcBCjO4e1M=;
 b=aYEpEXDvqYrNIj+iv6Wf0idFNRFIcMJYFdGckD/CHOWRPJkP8ikXq541Kkuscg33uo
 oT5EhZthHvxyTaoq1b3Z+9y3UKXU3QgkxEzhaajYYYazw6o6CO5WoQfoecM6gqLlDX2V
 sYpYa/duU/Vy+coBWnSfiMQHLa5DKFu14wZBWDraqeDSnmEix/E+SwWMVur0puzi/1Ow
 kxxN4evSjQu/UkBQxiMD/+k/6WCL2ieUreSNYCkfzGfbISnQsyYImoowRtlvBH02o3m2
 O5w9R7bs0Q6/n1+cnVhRtLZ0Xy98scvELeOxU4ZBxS4RvtZ3Mb5Pi6lcy1BDSJzifOmN
 oDIA==
X-Gm-Message-State: AOAM532a6TNl1zCjjHulAl86wIV2aPesQIEVhTP2vsjNbNFZ8091amQo
 F0xlhOgnz26awq5LFcfSKzdW/pMIi44ze0WHpzMnUMyYgzWlhhqySQ2HewOlVAg/sDOenotGn77
 g3GGA0Bs0eztKtuC0IvidFbVW9Q==
X-Received: by 2002:a9d:d08:: with SMTP id 8mr13197881oti.334.1643055498358;
 Mon, 24 Jan 2022 12:18:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTEn4ya3/5eCInZIkS/C/4U2Q9wOWBRRyxGnlMA9linsmQiFFzkE//YKVVW2gVtrkOgoqmKw==
X-Received: by 2002:a9d:d08:: with SMTP id 8mr13197856oti.334.1643055498138;
 Mon, 24 Jan 2022 12:18:18 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com.
 [24.205.208.113])
 by smtp.gmail.com with ESMTPSA id bk23sm6235774oib.23.2022.01.24.12.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 12:18:17 -0800 (PST)
From: trix@redhat.com
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
 ndesaulniers@google.com, lijo.lazar@amd.com, darren.powell@amd.com,
 guchun.chen@amd.com, Arunpravin.PaneerSelvam@amd.com,
 andrey.grodzovsky@amd.com
Subject: [PATCH v2] drm/amd/pm: return -ENOTSUPP if there is no
 get_dpm_ultimate_freq function
Date: Mon, 24 Jan 2022 12:18:12 -0800
Message-Id: <20220124201812.1078824-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 24 Jan 2022 20:21:10 +0000
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
Cc: Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

clang static analysis reports this represenative problem
amdgpu_smu.c:144:18: warning: The left operand of '*' is a garbage value
        return clk_freq * 100;
               ~~~~~~~~ ^

If there is no get_dpm_ultimate_freq function,
smu_get_dpm_freq_range returns success without setting the
output min,max parameters.  So return an -ENOTSUPP error.

Fixes: e5ef784b1e17 ("drm/amd/powerplay: revise calling chain on retrieving frequency range")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: return error instead of initializing min/max

drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5ace30434e603..264eb09ccfd51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -116,7 +116,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 			   uint32_t *min,
 			   uint32_t *max)
 {
-	int ret = 0;
+	int ret = -ENOTSUPP;
 
 	if (!min && !max)
 		return -EINVAL;
-- 
2.26.3

