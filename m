Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EB2CCF9E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEEE10E8A6;
	Thu, 23 Oct 2025 07:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g43Y0L14";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E2510E759
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 11:04:09 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4712c6d9495so13683025e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761131047; x=1761735847; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=60d4FN8I12bjhkv2m/h29YuwY/zOYE0TJa+JTgDeqZ8=;
 b=g43Y0L14q7Kxxb7CZ9QoYbMWFW5x4wMPy0l6c23O1A+HbPu+lWbCsfphfll4HO4So9
 VTg5bRjy+l5vS3b5BHXQvfdsown5RKcKuRh+XdOenGW+hIwlJB3fcFVY4m8a97nMZxvd
 WnoSvWxEpQnE3nZvppxgW5wvAHS8mYTKIovLC/Qs2FM4oinUu3GVI2fmhB6IB8PnHFsH
 QC4OsqQwn/0O5mWgTFy7nwLYc7e7stDzJMS4xPe4Qj0UDEa16L56GYo106v/OejgxiD3
 aS1ilNMBr9i3vFEqSNa/DfR2NLCuGEbB+aLc4SNvUdSCJ53Tyecf0LBGELPB1y5+ZMWv
 RsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131047; x=1761735847;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=60d4FN8I12bjhkv2m/h29YuwY/zOYE0TJa+JTgDeqZ8=;
 b=MMX9CPjjp3wBmO2AXwR6SFJE+Mmx18c0V9DBT4+oHE+i3ZIR/7OAwNOm7RTu0LJdIC
 FmEKFj/Z77MI/laNJE846CbTSJ3qJC/U17ClhokmnjIi8o6Io4kmLu5yGOLweepwp8Dr
 mfLo8YcsN4w1RjuEKrjOz6LIQ2XAAaHECK+rOyqMSOj1HSet564oz4gMEtKeqQSYrjrR
 JDpGGauesVsRFiec+B3EqsEZ+p793+20noQM+g/CCNSdcJZXbFTYERzWU3Io0K7mOHzi
 4lsqiX6vjDc/lduGnVE3gfLwtPEzUE2f9foNO6f5luytCCFJT1q9XTWCRYU/wlS+3wts
 d1dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWJTeGZBfsM3VQED+RHYR/fKwX12+rcn3G7ilDQ8roM86eO6XAYSaQ1VS1z9/if1CajROIzFBB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdN420CUari7ONkBl3kF0w/2lVpJcqBXAN6nLcyXg84M34S7h7
 ptoRX/rzi6aYqBEcdoJQglLNu7Rj088gx3ElqaJj+KmoDCpmThAD6ZisL4H/wMIb/JE=
X-Gm-Gg: ASbGncsVhajivK4eZOgMiYlEaxHxRQ+yHiKSSuefdD8ahyfpNXNHqrYnQ/f+j+1w/7y
 6bVf36QUyfYuqjF7U3tusak52vHIcSvEQ9O9OG/qzwmzoYnts26zxgLOv2DxVl/8PdYPHVFWBXL
 YVxadkjz5ZtAJIk1hhRE3vNqRxMYIitFlgf4q+yvK4H/sRaT4gZGTWYhAjLOMiU6ulf98ScirBu
 IXjPgBPaZk+abTnJpztaYyWjxOgcLGHRLZn6EYF0IipfWUQ5YY25G01m/gOryI3LCcSA5E3RrXy
 W/oqzIUi6xlK/btfwZbgAGbKo8tsqHH/HLUWPwmGaLsVCOwvzWR4OoStQIc6YaY6Vsf3hZ4EYcF
 6bW5PDU8VVT3OjIuFWGJZ7MMngjgmdCJwlEbcpfSlqz00+F6XibkI3bUO9z6TvgEP4PzIEIU31v
 tAat0KiILhj9qporOpxGndi5wz50o=
X-Google-Smtp-Source: AGHT+IGVxOZg/SGvzQXDgSR7/+Whdk7ScvRjRe/N1IbTeIwwfj/PV9uPXXlolfy5kHmMZfmv0uyAbQ==
X-Received: by 2002:a05:600c:4e8e:b0:46e:46c7:b79a with SMTP id
 5b1f17b1804b1-4711786c702mr178910745e9.2.1761131047078; 
 Wed, 22 Oct 2025 04:04:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-475c427c3casm38721405e9.4.2025.10.22.04.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:04:06 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:04:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amd/ras: Fix memory corruption in
 ras_core_convert_timestamp_to_time()
Message-ID: <aPi6I5z5oenppEuu@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 23 Oct 2025 07:51:01 +0000
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

The div64_u64_rem() function takes a u64 as a remainder.  Passing an int
pointer to it will result in memory corruption.  Change
"remaining_seconds" from int to u64.

Fixes: ace232eff50e ("drm/amdgpu: Add ras module files into amdgpu")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 01122b55c98a..d8a004878a64 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -67,9 +67,10 @@ int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
 	int seconds_per_day = 24 * 60 * 60;
 	int seconds_per_hour = 60 * 60;
 	int seconds_per_minute = 60;
-	int days, remaining_seconds;
+	uint64_t remaining_seconds;
+	int days;
 
-	days = div64_u64_rem(timestamp, seconds_per_day, (uint64_t *)&remaining_seconds);
+	days = div64_u64_rem(timestamp, seconds_per_day, &remaining_seconds);
 
 	/* utc_timestamp follows the Unix epoch */
 	year = 1970;
-- 
2.51.0

