Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70503C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 15:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3E52333E
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 15:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3E52333E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC3A6EA66;
	Wed, 13 Jan 2021 15:24:18 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1B46EA66
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 15:24:17 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id r9so1289164qtp.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 07:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G6oe8P4Cun9SiL0t1L9XuoXsNwtXDQqzA/hUUXLRRy8=;
 b=k0FptLBrQ0lIrlPQ5SAAtOS3q1vC7iY4EO1FME5ovzI4Bi6paNTwjqWQDOFVoEFfCa
 ljMbMdpecfgmwjh1gQpDo9qiTS7edrD024lHSpkspbXWJAacFpTebbl465b0lANcy/ek
 CakqOxpW9opeRKq65OtWwmTw7Lxe/7wgNQpWiagvQhTj9uOPYDDYcQ4hsnNlbzMxIyr3
 IG+rpgPXS6eWAvzZ2L4Kc/0aTe6wKaBL5C+vTn9fLRbOpSNM2K37tG722PiLtLfRQIjo
 IAgpMvbOmBHrWUkYypk/S6MBYUzt5mSNDMJZAww9LxHDOZiqSSBfqAa3XKvX30SmaC8D
 L7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G6oe8P4Cun9SiL0t1L9XuoXsNwtXDQqzA/hUUXLRRy8=;
 b=n3SuTNztuMpuPIyk9RB/epe72X0paTeEnLY0z6ZmZVXnRf2jLlNXG1bIf0TFv6S/Qj
 JU9G5WlVPJ4CWCB5PcCzVvrne0ZKkfROpHBP6XUNjoGlgUq3ZkJLm6Bw1LYHMUKAaT1r
 6mWsIfUtsC0VxxSxpzVbMDBh+dNBcx6y38jW93xz9dP3CZ4DaANfsdgfrjrAqkBKF4ce
 FiZfW6iiPB3RroidDh8hicgZGYlCDHPof2Mi1SeWTee7vD4BK37n0fItpHoovvZ0B/e0
 ibpAwxUnX53TT6SusD2qqQNg5hnFrdWUAvN29kJgGU8NarUwb88xP6cMabXiCdhnfARL
 PT8g==
X-Gm-Message-State: AOAM531iX+kXXkqCPLUg9av4pxwscbyJjfV1Nrp7ARxSe+DDZCREEfqM
 OXcCn+Lt6kc2XnVCcW64m7UrS31ZtDU=
X-Google-Smtp-Source: ABdhPJxAugt1k2AHmUlmKMWOdManzJZpZwnQ2YiX+5vGVLEkJjOfkdz9Yi1d5QhWSVWb7Euy2alyBA==
X-Received: by 2002:ac8:6d05:: with SMTP id o5mr2862002qtt.6.1610551455992;
 Wed, 13 Jan 2021 07:24:15 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.241])
 by smtp.gmail.com with ESMTPSA id i3sm1159827qkd.119.2021.01.13.07.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 07:24:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add green_sardine device id (v2)
Date: Wed, 13 Jan 2021 10:24:03 -0500
Message-Id: <20210113152404.1307212-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add green_sardine PCI id support and map it to renoir asic type.

v2: add apu flag

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 5.10.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cac2724e7615..6a402d8b5573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1085,6 +1085,7 @@ static const struct pci_device_id pciidlist[] = {
 
 	/* Renoir */
 	{0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
+	{0x1002, 0x1638, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
 
 	/* Navi12 */
 	{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
