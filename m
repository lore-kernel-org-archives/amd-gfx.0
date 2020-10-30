Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0252C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4103520719
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRD8AmlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4103520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B046E953;
	Fri, 30 Oct 2020 04:12:19 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A36A6E948;
 Fri, 30 Oct 2020 03:27:31 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id o3so4013948pgr.11;
 Thu, 29 Oct 2020 20:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=bnHvCuE87pUUeamFRrdRkC3/PfrKdLRFG6Yr9LjsnHU=;
 b=nRD8AmlOqJ8JayRjEopJ5gsIvdMeLsA6FdS+XJv2WFxcMo/+k7r9F5ErGu6fOFW8AQ
 RTdDljKeM5HQDBummdsxSpQUh3IjjRVzi87ByrvD2MkiJrhTmGRT35F+7aLPWD7+sidl
 Kv9plJtGdW2FL9gT2gv5Ri69CUQrpxWgieYZM2uZXZmUt431/qypzu54jCsKUAFsG7nQ
 f07ABRL0UayrZZsHvk1NfDvTzhRtiL4uBs/K5SGIIB+6Q6gbcI+mcfKw7kTPV7Owsq+X
 3bI33+X8zHRUpqf0Ehk6Q9xJQkjcVMbWirQ45OILc08QA7/bdbhZjg8RTuOpUyERvQDE
 7dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=bnHvCuE87pUUeamFRrdRkC3/PfrKdLRFG6Yr9LjsnHU=;
 b=QarEImy42AkKvKi1O/4BIiTRMg8FTRR93f4mPozjObc90TjcoxShWkcdEZ+jX26veP
 I0p1YuKSoK/T46HriVMH0AGOcw3RyNfb63cq1n0udw3PiLLpk0l10E7NmX3+2YXmBxVs
 vs0V8c2zgvXG2WO4PCG/sYGISl6K5LTKClpzmYUfFgzWl9khcGbc+cHnAxjJ5a5F5nHq
 0cOvLW+b9knwQgdAXU5af3zwB+pqLRhKY+lserdmy0d13wTtddhGkk4ZnTHlka5U4qWY
 7bWLUAGl4CeGO4nMAyVcdw/fqXOk/3TU38KhEDGnzfmwiU5iWC8zvjsMfZRYkxW2pAaL
 rE/w==
X-Gm-Message-State: AOAM53240IalZGtD+0ZHbl2upqixeapLM6acBh/U+m/Isy5lXcsr7tWX
 4WhZ5T6QJa3+erFpWRWwc90=
X-Google-Smtp-Source: ABdhPJwsO/zwvK0kUCMTFALpAm2G4TaQ+/FtpdQPfUSL8E1dywEkU+dfQeT0it8MKkuUba3+AQFDIg==
X-Received: by 2002:a17:90b:3658:: with SMTP id
 nh24mr310667pjb.177.1604028451119; 
 Thu, 29 Oct 2020 20:27:31 -0700 (PDT)
Received: from my--box ([103.98.79.70])
 by smtp.gmail.com with ESMTPSA id z66sm4274336pfb.109.2020.10.29.20.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 20:27:30 -0700 (PDT)
Date: Fri, 30 Oct 2020 08:57:25 +0530
From: Deepak R Varma <mh12gx2825@gmail.com>
To: outreachy-kernel@googlegroups.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: use DEFINE_DEBUGFS_ATTRIBUTE with
 debugfs_create_file_unsafe()
Message-ID: <20201030032725.GA274689@my--box>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 30 Oct 2020 04:12:14 +0000
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
Cc: melissa.srw@gmail.com, daniel.vetter@ffwll.ch, mh12gx2825@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
function in place of the debugfs_create_file() function will make the
file operation struct "reset" aware of the file's lifetime. Additional
details here: https://lists.archive.carbon60.com/linux/kernel/2369498

Issue reported by Coccinelle script:
scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
Please Note: This is a Outreachy project task patch.

 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c  | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
index 740e2fc7a034..1e79baab753e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
@@ -252,12 +252,11 @@ static int init_powerplay_table_information(
 	phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_max, powerplay_table->PowerSavingClockMax, ATOM_VEGA12_PPCLOCK_COUNT);
 	phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_min, powerplay_table->PowerSavingClockMin, ATOM_VEGA12_PPCLOCK_COUNT);
 
-	pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
+	pptable_information->smc_pptable = kmemdup(&(powerplay_table->smcPPTable),
+						   sizeof(PPTable_t), GFP_KERNEL);
 	if (pptable_information->smc_pptable == NULL)
 		return -ENOMEM;
 
-	memcpy(pptable_information->smc_pptable, &(powerplay_table->smcPPTable), sizeof(PPTable_t));
-
 	result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
 
 	return result;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
