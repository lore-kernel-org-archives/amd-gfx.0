Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E136C3B19D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F5724689
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1bkT8HuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F5724689
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2C46FA53;
	Fri, 14 Feb 2020 16:04:56 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A7C6FA42;
 Fri, 14 Feb 2020 16:04:54 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4057624699;
 Fri, 14 Feb 2020 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696294;
 bh=Q4JZlLKaoaY9EBcVmw7f8lt78ZDUSaFNgPHucgZNZJU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1bkT8HuInPFfW/N3YVdBYJtuaEIAKOYMrCMfZ0mlhnqCTGtjBeC3FLL3KMMIIeZ04
 zrbushFd5QcEY4CHwOMJaGGPzhvAMsSvktRPIcoeb7NPCOT2boqmKqzvGtKq6+1EAl
 rZkDAz/5vNRmXkSKLY/BFRyom7hPPJOIopAEIMTI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 140/459] drm/radeon: remove set but not used
 variable 'backbias_response_time'
Date: Fri, 14 Feb 2020 10:56:30 -0500
Message-Id: <20200214160149.11681-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit ac52caecbcf2c30ce95b2536c1caf2643c49b91c ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/si_dpm.c: In function si_program_response_times:
drivers/gpu/drm/radeon/si_dpm.c:3640:29: warning: variable backbias_response_time set but not used [-Wunused-but-set-variable]

It is introduced by commit a9e61410921b ("drm/radeon/kms:
add dpm support for SI (v7)"), but never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/si_dpm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index a0b382a637a64..8148a7883de43 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -3640,14 +3640,13 @@ static int si_notify_smc_display_change(struct radeon_device *rdev,
 
 static void si_program_response_times(struct radeon_device *rdev)
 {
-	u32 voltage_response_time, backbias_response_time, acpi_delay_time, vbi_time_out;
+	u32 voltage_response_time, acpi_delay_time, vbi_time_out;
 	u32 vddc_dly, acpi_dly, vbi_dly;
 	u32 reference_clock;
 
 	si_write_smc_soft_register(rdev, SI_SMC_SOFT_REGISTER_mvdd_chg_time, 1);
 
 	voltage_response_time = (u32)rdev->pm.dpm.voltage_response_time;
-	backbias_response_time = (u32)rdev->pm.dpm.backbias_response_time;
 
 	if (voltage_response_time == 0)
 		voltage_response_time = 1000;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
