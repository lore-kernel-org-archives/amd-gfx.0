Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC78C44507
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C8D10E4A8;
	Sun, 12 Jul 2026 15:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ADjVwhNa";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBDA10F8DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:31:12 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso7902295e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690271; x=1784295071; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B49BYydG0G+SVwT1ct2zU4r2nKnTZkCjB+W66DADfQM=;
 b=ADjVwhNawWj+BOMtNJxzuSct9ofWryxTvp37apBW3lBeRVQYZ2XGT1hQi0TOlKKTnK
 7F0g3wKiiMZ2/C72U33wHBIlj0MQ2irjvbOcs50PZkpgrdtfVrRjvUfADhKwv6DjshVH
 Jy/QNP+eFlbrxWP2B+szpwteGZDWAB/8ZsZDjOoFDl8g6X8ScHPyV1GdDq1/7db813uG
 TIq2ttnj9mAv5TdRliM65z8bAmH5xbWIdbwjH+Wr+ac8yLIL8TWQBOL88u/Yhw8MQRvP
 rt8bZpFfbiUp2ZC3LCkhHlgcZg1JbwI50jcv8JuqmhDEekxmf3DuLcosVDcTSpesAmCc
 iqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690271; x=1784295071;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B49BYydG0G+SVwT1ct2zU4r2nKnTZkCjB+W66DADfQM=;
 b=ob+HRQNc9o+dOmc0gvQIF/Cw8roCJcKdpcOEKp2a3eFIlkyrZFulayLWbj4OMv1bxy
 N7zVIyaxmrI//q0weCner+uGdS9sTgjpBTZoq0M2PM/CWpquLlYPSRLI/g0ia/qR+oqU
 3blWyYeZGda/F9vhZgxmcRE87lZZLos780vX1OVDkfzOZQfai2PJKO9xCNp7iAVH0JQA
 qICDKTDPB7mcc60BH3GQmbY42bZciElHHsve8In6K6LGfuC00trylHL5A24XGsnJ6jJl
 2xxXy9gkpaqog0xuW944vldV5kpU7w3ONiACs7DQPvX4VcZnYui0P5dUOq9h1DTm4UvP
 J3Lg==
X-Gm-Message-State: AOJu0YzE7woa8nS8WhqFeGcAPifrzhBIK6jwRkjPj4VkRRDxS3EZp/fZ
 aS6UX/aYVGVTlYJ0EQw1v7Gq4cXmbHFnUbLHUDNrIrkrGMvrmQzMIOf7
X-Gm-Gg: AfdE7cnJ527hw7aNRr/uvSyudYJYBoBrWBeehlfeyzzTRrZcv6I0zw6589CDjSQqs8a
 ulQMz1Ba6p+WR02K4/8R9ISz0qN4gU8UopYFRFLLXlPH3UYyeNozHxYELezLEGG2TSFlN5ImvG+
 ScO6ImkVmWMjgIxxAHehwoTqEJ/iXeHFGy2UYwd/iOFrwniEVHAIsMdu3HlGQinG8TCcphmww+Q
 y9GioGof/j1C31pRbrrwHlwgrH0iEZb3oqRMipBBLstdwMk/SAYxZ2d3O4rEL+xbyT2zotN4WRu
 cPts75saFqrupaVBk2/7DbmTWA4T05MWgDJwrhOpbnaTxOJATogqD0PLprQuvEsTI/AqX6Kewb1
 2dMa9YMz/SEXoaJaHeuNzxkHxM0DVadAeac6OYfFSEa3qt4/EK/P5YwzkVAdLR/5lzJPzGNJR++
 ZvQuaYKpva
X-Received: by 2002:a05:600c:6206:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-493e68c8063mr123645755e9.19.1783690270616; 
 Fri, 10 Jul 2026 06:31:10 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f744e8d7sm10990725e9.15.2026.07.10.06.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:31:10 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:31:06 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Add KUnit tests for mst_types
Message-ID: <alD0Gp71kK2Cn6w3@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 12 Jul 2026 15:22:44 +0000
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

Hello Alex Hung,

Commit 04bed7922fa9 ("drm/amd/display: Add KUnit tests for
mst_types") from Jun 17, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c:1027 dm_mst_test_fp_guarded_public_stubs()
	error: NULL dereference inside function

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
    1025 static void dm_mst_test_fp_guarded_public_stubs(struct kunit *test)
    1026 {
--> 1027         KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(NULL, NULL),
                                                                      ^^^^  ^^^^
Passing a NULL here will just crash right away.

    1028                         (enum dc_status)DC_OK);
    1029 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
