Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B088C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 21:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3634A206CA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 21:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0pYAXv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3634A206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCCA6E934;
	Thu,  3 Sep 2020 21:06:36 +0000 (UTC)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B8F6E934
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 21:06:35 +0000 (UTC)
Received: by mail-io1-xd43.google.com with SMTP id b16so4969955ioj.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2020 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7KYdRGTDTZxwhV/QvZ5B7Q5GzspDm9DONZiquKybtP8=;
 b=f0pYAXv72pEeL42RiBFeq64J9QvT/VZVgWTCHdkQKCycWIAJMxkhbEw95PcMsrVEch
 WFDNQlTpnJgDfjGt4mY66HJ7isvxuhuECKtZYM4XrIxliCk+jEmEa8ntaOI+RrviuLN8
 M5fzgEKm/atS3A1gOBwsgKc3WiRPty+C3u14BK31kLRAjhCVB6N9HhlTvh6UbRSMmjZq
 PplKVlt17TzC9YvKDeVx1VWjv4ob8bgo8UDR90dNg5fN4dDa6q12x5cgVF0qzvTnIQR7
 Ed2sbGxUqDkFNNdJehKtegII9P1t1aqwWJGpW1TWBXWTtcIWkX+fZTjTg3/ydL/2egmk
 68PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7KYdRGTDTZxwhV/QvZ5B7Q5GzspDm9DONZiquKybtP8=;
 b=iEf1iNSi7OYfW3qdn2gKgOjpDFA4WjCoKez8mxpuXs+YekFselVV+vXFxkI08iJuVL
 DIv2/e36vWMd7KJ2kVyzHgrRxC0kq0NFAtfDZt2/ipeAWr7jy1dnfqyyc/MpGL7VeYmX
 hnHLUj3Iwo3Wa/ephDNn8VGLozQ/AZ+CZVyKZHES3o0KNqBzh0KYop5RbDFQ1tjyakZt
 Sda346ATLha0Cyoxvgeo8UJeXFdU2Wyn5+b/reFZqE8CyyGdZUo7AtzTwjXff7igbzHU
 cjZyQtBBbMWSvPWVwzZCohqh8Ak9wmeKdRyis63EMZpxFq/2WhZgfWTnAeKeqE+RgxbM
 HR1Q==
X-Gm-Message-State: AOAM532GuhvzWejDDsnzpzLpCyXG8nhyr6pn7b38tyGALN8re6HTlF5l
 ZKUFKQeXiuRztxBPK6ifoo6sjIjd1nM=
X-Google-Smtp-Source: ABdhPJxdGsvzlJdb+ds21sDcbYigd2tUlsrRpfA1sXHKDO9kmd5HVGtWx8r95+wvDZ4GhHIqSaIjiA==
X-Received: by 2002:a6b:6315:: with SMTP id p21mr4907593iog.194.1599167194691; 
 Thu, 03 Sep 2020 14:06:34 -0700 (PDT)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:4b:a6ae:c000:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id d1sm1946207ila.67.2020.09.03.14.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:06:33 -0700 (PDT)
From: Matt Coffin <mcoffin13@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: Account for extra separator characters in
 sysfs interface
Date: Thu,  3 Sep 2020 15:06:14 -0600
Message-Id: <20200903210614.22785-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
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
Cc: Matt Coffin <mcoffin13@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, the the input to the pp_od_clk_voltage sysfs interface has
two adjacent separator characters, i.e. "\n\0", then we try to parse an
argument out of the empty string, whereas we really should just ignore
this case, and treat any number of adjacent separators as one separator
for arguments.

We do this here by simply skipping the argument parsing for all
empy-string arguments.

An example test case would be `echo 's  1 900' > pp_od_clk_voltage`
(note the two spaces after the 's'.

This also solves the issue where the written string ends with both a
newline, and a nul-terminator, '\n\0', as is the case for `echo 's 1
900' > pp_od_clk_voltage` since the recent rebase.

Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 65f141c777c2..9ab29c21e458 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -801,6 +801,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	while (isspace(*++tmp_str));
 
 	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
+		if (strlen(sub_str) == 0)
+			continue;
 		ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
 		if (ret)
 			return -EINVAL;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
