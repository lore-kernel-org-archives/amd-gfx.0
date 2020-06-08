Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947E9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B197207C3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP8pPkKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B197207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5187889FD3;
	Mon,  8 Jun 2020 23:06:33 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101FE89FC5;
 Mon,  8 Jun 2020 23:06:32 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 151D920820;
 Mon,  8 Jun 2020 23:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591657591;
 bh=x7XNxG+6Ey9iNd/8UiXWD76fUZIbSvQFJ+JJaQo5fqk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YP8pPkKbQFz25zt4gifp3yg/NIvpC8zOuz4CaJURDjLKfy56qMgPKgZORxfFg2ouC
 ZRHLoMuDvl1pJBaoBwjT+tJw9TTt1sImXbXbl2fr+rqhKGGEP2lqe6e7NPZrdNa4jV
 dAFWQVXNfkiio/j1THRY7vtg9uyQ/rIjo0gUxj3k=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 019/274] drm/amdgpu: Init data to avoid oops while
 reading pp_num_states.
Date: Mon,  8 Jun 2020 19:01:52 -0400
Message-Id: <20200608230607.3361041-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
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
 zhoubinbin <zhoubinbin@uniontech.com>, limingyu <limingyu@uniontech.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: limingyu <limingyu@uniontech.com>

[ Upstream commit 6f81b2d047c59eb77cd04795a44245d6a52cdaec ]

For chip like CHIP_OLAND with si enabled(amdgpu.si_support=1),
the amdgpu will expose pp_num_states to the /sys directory.
In this moment, read the pp_num_states file will excute the
amdgpu_get_pp_num_states func. In our case, the data hasn't
been initialized, so the kernel will access some ilegal
address, trigger the segmentfault and system will reboot soon:

    uos@uos-PC:~$ cat /sys/devices/pci0000\:00/0000\:00\:00.0/0000\:01\:00
    .0/pp_num_states

    Message from syslogd@uos-PC at Apr 22 09:26:20 ...
     kernel:[   82.154129] Internal error: Oops: 96000004 [#1] SMP

This patch aims to fix this problem, avoid that reading file
triggers the kernel sementfault.

Signed-off-by: limingyu <limingyu@uniontech.com>
Signed-off-by: zhoubinbin <zhoubinbin@uniontech.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index abe94a55ecad..49e2e43f2e4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -444,8 +444,11 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 		ret = smu_get_power_num_states(&adev->smu, &data);
 		if (ret)
 			return ret;
-	} else if (adev->powerplay.pp_funcs->get_pp_num_states)
+	} else if (adev->powerplay.pp_funcs->get_pp_num_states) {
 		amdgpu_dpm_get_pp_num_states(adev, &data);
+	} else {
+		memset(&data, 0, sizeof(data));
+	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
