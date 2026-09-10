Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA142C88E4C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 08:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385E710F545;
	Fri, 11 Sep 2026 08:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZepLRA5H";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358B710E28E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 17:15:50 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso1034565e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789060548; x=1789665348; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oPi1IgNLqOUMA04/Cu6FTzQTvp2Q7hytMqSvlR+BzXc=;
 b=ZepLRA5HIz/XWVRuXbZktWROVyylvFRa7MllRMDZW1Us/thwiCkRz62Sw7AYh4jGnw
 jr15RQdHNa7HjKtQUIARWL1LBE7vKSZBcfvnkCHcx9N11y1VBW+hNyApOaPl4uOYEUIO
 DbNZ1GdsCP1uMcsHTkrOHTNvwAS/VLPeFa3v7roF3xAM1+eU1RfQkfe5Y5XzWT5EVQOj
 Q53QbIa75qSwx7ABSnbSezL0t+m7wSDXxG3WZwzpIGxjxhG4aMRcDp9k9ORiaguxcKyK
 CUp9Ni2ORph5+HQ0lXM1RJzP62FnVwjcfLhsZtH1ybh66xZrktB0ci9EJRsBdgaeNWoH
 sfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789060548; x=1789665348;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oPi1IgNLqOUMA04/Cu6FTzQTvp2Q7hytMqSvlR+BzXc=;
 b=UqztIJMEohkMBHj7R2AmCd66gTBTWEeHVuM0Aygj2SMpkbbw1ROOR2+HkVlB1glcx1
 gj6ulCxR0N1kxcoP9sJrRGXsColSBbav0zL9Y1fJaxwNjr43sZW8cUaCuqOFCduDyyAF
 QmcHfJoqekxtdGDUKPAKEwEtsSPPHRUZTQiWry00IBxrTG7u5twvnuB0dgzrTCgMGWgu
 unOe3SsmAkedcKJQyY1mQFSuQFp8Y5e/hIHi3O1Gc3fsOHNraugDAOscHaJux4uEgWtO
 8TXmQlqmJWPy9T4Bqe/xGWYyrvrGSNnATm59j21gDx+lgypF2ZQ92cSH8ZWnX+cm8Yq/
 UcAw==
X-Gm-Message-State: AFuF++mr0f19cdkqhmsy0IhgkA17Z8Uhr7aL8FWY9PmgXUm1N8x4BBmz
 NaiSNYC802Y1pDE1OvNGqiuwi0ilE5m3Gxk/FbNmnIVRhQ3v7a6TF2fJ
X-Gm-Gg: AYBFou0XmeIZzyYKo2M1uF4ijqVlbL/nS36QTSjnLfPV+gS6v0eqEeDp7SsewSN4FJy
 iWaZ4Yx2osC7m4FmeDBzIrGosctYX31xXX4jEnljyGpS2t4g9CcPLPF7fu22hSOaXTAlXEBKd43
 NruM1RgREtoSVGFCJITnP4zXIjaLVBk2HnmFygZPtET3zQRGwwyFgAy/Tn2X48w3n1dyCbZC1+O
 yKVZi4dapd9AKrUToMLgClSQLTT+bLtMjphIa0Ssve0DLEU9ilu79+UEq68k5hsoOyRNALcxi0+
 WtyXoyhmqw277BZGy2h2mZwdqh+HkYAiWVkzIz5lGy26LNZRIMNQ54R1/Ky/L6Gcl2/n8+JwptT
 /p70IWVw+UENwMigsACRXIxl/GasGqVE3ddJTnS1PXFSg5YU2mIn1mqMhenfdD1zsfxxjm5e5OW
 hSismfmRG3/3Azgw+o9uC42T/uIp3ftXQPw9zrbIcYYCUY0rH5+iXRyOFXF/uqU7jPNeM=
X-Received: by 2002:a05:600c:358c:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-49e619bb961mr264475e9.16.1789060548080; 
 Thu, 10 Sep 2026 10:15:48 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60aba026sm9357125e9.3.2026.09.10.10.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 10:15:47 -0700 (PDT)
Date: Thu, 10 Sep 2026 20:15:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Test GPU memory allocation
Message-ID: <aqLlv7dOd9WB70hJ@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 11 Sep 2026 08:01:22 +0000
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

Commit e3d5618d4dad ("drm/amd/display: Test GPU memory allocation")
from Aug 10, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_services_test.c:340 dm_test_gpu_mem_init()
	warn: sizeof(void)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_services_test.c
    336 static int dm_test_gpu_mem_init(struct kunit *test)
    337 {
    338         void *cpu_ptr;
    339 
--> 340         cpu_ptr = kunit_kzalloc(test, sizeof(*cpu_ptr), GFP_KERNEL);
                                                     ^^^^^^^^
cpu_ptr is a void pointer.  It doesn't make sense.  Probably remove
the asterisk.

    341         KUNIT_ASSERT_NOT_NULL(test, cpu_ptr);
    342 
    343         dm_test_bo_ctx = (struct dm_test_bo_ops_ctx) {
    344                 .cpu_ptr = cpu_ptr,
    345                 .gpu_addr = DM_TEST_FAKE_GPU_ADDR,
    346         };
    347 
    348         amdgpu_dm_services_kunit_set_ops(&dm_test_bo_ops);
    349 
    350         return 0;
    351 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
