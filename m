Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D54107BCE0
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F92210ECB2;
	Fri, 13 Mar 2026 16:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cKeTrWaO";
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D41810EC20
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:43 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-467161c4b7aso1095818b6e.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408282; x=1774013082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeA7b49GNmqPBpy8bbweHTxpApMcFe3iFgz41hqVwCU=;
 b=cKeTrWaO8+7NbjvlsLvxuJdULdr8/5E1ueOEF+gFvVZT5/OfTShPZOtz48zOx0P9jj
 L7VRYk0b9JURzCuOmD6iprkxhORHgbHP7aGyMjFiMV+tCILx69JoO32SpRrpG5Dz1qLa
 lY8chmEwKPvddi1oFmLWBYV5z6/iCVZ1AgnNoPZk8YL1l+GwCH3AANM/sIZ9q+G7wEKR
 q6KxhvXyN+7XsoRDXF4J4YdtDz1c4QnfoxSsvaV5evo8UHI7x1RPgr+1iMmZK4RHFOta
 9ZEqML1c9B6gOvmTUcbNev0Zw+frDhx8a0p9eE5yOLZ/NWh05fhS2K0TpDopBEQknjgI
 HmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408282; x=1774013082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QeA7b49GNmqPBpy8bbweHTxpApMcFe3iFgz41hqVwCU=;
 b=QeJsqIZ3lgJ2LS5EC3M4wJ2Ak1+7qNDsdWLeslsXg294Z0510yy4V2aR26CUpjTRTF
 CrdwvbmCzmUywA5+KldNAgse2GHxxm8mdfBrZPYTVq6A5vo48CAfS74o2qwywqVeZayA
 Fdt7YY3n6bFTW9IrH5hoQr0hUWW0yqdMppB5uemfcURYWqZBsD+IO/UKEb0OrPtvfTF7
 szfXWCniEdMLZCkQH7Pscnt+KoTEjpCKueQ8KwumqEao7zskDZMHWLKPdeUT3ZHv43+v
 tbl9uPjJUIIgA+811a5ojXeOybX8PZZ7VAdzvMUm1fzagm4fqmNLV2IytWTj6fHH4qc0
 kBEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcQjmvKx47vIfCTeiim1K8y2GqI4W1BNn1aHMd4v2R908cygZuu8hselhETHakZFJhRc0FcDi3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYGxGckxQbY5oxytFT7TOlMCcPGaVJ+Z/nPxxeYSZsJHGVZ4YJ
 s/e72bEXhGeKlgFz14CeQw5DwWrD6SmEBNIfcsCEBhF8IXPK0XPQ+bXB
X-Gm-Gg: ATEYQzw98fCFguIG+1Seb5aMvaGQaChqqK10oYUOeaNXu8Uu0fUMknlHE2jCbGHztg/
 wvNJU8ERmvxPBpVa0r6ZAl/7sY/+R6Dj1cDUrLbadSCOFX+Kev0SWZ5n9z50EFExnPkmHD/j/8t
 aDN+vqlEQHCv39iQC18rFd1P7SH5Esl+xRJI2mStw2vEDWEy6dsOn6WWjF5eSxNiN/jYqSueScO
 ZzcNuRCm0JU6lsvlyK2f7uDJapbGqm7jH5mBdbAZfLt7Qrm38eK1y4dCwaV8SDhdmZ0U/Hnmhze
 Qhz9IOxkJAlf2Jw1nLCeDnUZSdLx4v2cMT18a6ROaZyjv7BvNdBCE/CR6i2ICup54dbdjaSDf6i
 z0E9kF2iAwDzFmfBj4qqqlMRARZiIOo2XexUXb8PRUDkUN39Ydy7C+tlPkbh20WYKMo3y4G2Hai
 4JEaE9n/HHEM2qJG/BHrFjzbE2u1pKEuljoyqPPRskTqymJOk2
X-Received: by 2002:a05:6808:c2c8:b0:44f:78fb:7b11 with SMTP id
 5614622812f47-4675753904dmr1572573b6e.39.1773408282489; 
 Fri, 13 Mar 2026 06:24:42 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:42 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH v11 50/65] drm-dyndbg: add DRM_CLASSMAP_USE to radeon
Date: Fri, 13 Mar 2026 07:20:15 -0600
Message-ID: <20260313132103.2529746-51-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

radeon has some DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg about its use of
the class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 87fd6255c114..a7133fb6377d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -254,6 +254,8 @@ static const struct pci_device_id pciidlist[] = {
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static const struct drm_driver kms_driver;
 
 static bool radeon_support_enabled(struct device *dev,
-- 
2.53.0

