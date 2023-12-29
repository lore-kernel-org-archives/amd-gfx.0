Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABEFC47073
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 17:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE8910E2D2;
	Fri, 29 Dec 2023 17:43:49 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE8E10E2D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 17:43:48 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5945ba54d54so2772077eaf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703871828; x=1704476628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EbPPRS8CiXOtfNf9hdBdiAU5rKDEDixn4cOuVVPZO8=;
 b=AvVhBeBkIdqfRJ/nwslmpyQXbAeO6ZDtlTkbq2wn7881aCKXwCSNPCKmoXZdNs4gNX
 k/1/TLzEGxG2qnW/zD351frXMGJjmets9IkDxIgf3WzUi/ztSUz7g+HRDjrmcvs3unPI
 Qc4ptiJXT+owuyApunemMhcVRbVn8qCv1MdJWDzRcw7/LbByUrTn5C1T6fwGizqCThDw
 N5hc4JwEiRfh3Z4KK4XM9T5U7A224dS0s7suI8YssAKq14tSFkwE9zxJ/Pg5XpAeCz/Q
 a3Q0kAizAoV2Wm5/fDnIc2YLJeu/QzBiSyZzoiEknM4Cqpy6nFt5oLdh8oqlxD2OSzZ6
 0NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871828; x=1704476628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EbPPRS8CiXOtfNf9hdBdiAU5rKDEDixn4cOuVVPZO8=;
 b=E2RJz8VFkZzDAS1VnXQpvDGoyeAWWhi9epImXSnZcFa1tBbju2NCCWWb+sT8/8D+mO
 wCx8MtICXG7aBthpkRJstUDgX4xVYwjgmaTDPjqPREi8Ni+U2BQLFq0X4Y0Oz1NcS4u+
 zzi0xdiRrZWXL3Ne5b120wl6F7dYlkZND1IVIYBI+eZ0PzwsuQscys6tmZW+KAtgF92E
 x1whX7Jn7QfRNi/A05HtHc6/NIZ6BQWeLDJXobhThLenNayIiv85HBpMmVuV4dCGgmLK
 nOzJEPBF06ZvVNHqXEdE3U43mYkDZvBLsr4cT9MNvtR0VZ5rRgwjk+4QRfU+9aEfVR9G
 dZlA==
X-Gm-Message-State: AOJu0Yxeq5Lj/wN2Rkm+yhbRFzvTpHge7qLCMHbvPqfO3ETMEvpKFxJi
 twuVAbncinNlcw7fARbASRU=
X-Google-Smtp-Source: AGHT+IHciID4AHXYPF4pmAPHfSulvXsSkgTgarN5eX48nLDFIVzE6g9I6IPjucOAXYQTzmnShgqozg==
X-Received: by 2002:a05:6358:339a:b0:16d:d0e7:e7ee with SMTP id
 i26-20020a056358339a00b0016dd0e7e7eemr12529536rwd.28.1703871827685; 
 Fri, 29 Dec 2023 09:43:47 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a8c2:13af:e16c:ee4d:83e4:91a0])
 by smtp.gmail.com with ESMTPSA id
 m25-20020aa78a19000000b006d9b38f2e75sm10056424pfa.32.2023.12.29.09.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:47 -0800 (PST)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Subject: [PATCH 7/7] drm/amd/display: Fix power_helpers.c codestyle
Date: Fri, 29 Dec 2023 14:41:56 -0300
Message-Id: <20231229174156.1800-8-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231229174156.1800-1-marcelomspessoto@gmail.com>
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Place define macro expression inside () in power_helpers.c file

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 1675314a3..4e8af166e 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -31,7 +31,7 @@
 
 #define DIV_ROUNDUP(a, b) (((a)+((b)/2))/(b))
 #define bswap16_based_on_endian(big_endian, value) \
-	(big_endian) ? cpu_to_be16(value) : cpu_to_le16(value)
+	((big_endian) ? cpu_to_be16(value) : cpu_to_le16(value))
 
 /* Possible Min Reduction config from least aggressive to most aggressive
  *  0    1     2     3     4     5     6     7     8     9     10    11   12
-- 
2.39.2

