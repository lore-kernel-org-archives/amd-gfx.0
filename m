Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E78FC55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 13:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBD72073A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 13:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBD72073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC9B6E41A;
	Wed, 22 Apr 2020 13:13:35 +0000 (UTC)
X-Greylist: delayed 470 seconds by postgrey-1.36 at gabe;
 Wed, 22 Apr 2020 09:14:04 UTC
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E7C6E394
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 09:14:04 +0000 (UTC)
Received: from localhost (unknown [192.168.167.70])
 by lucky1.263xmail.com (Postfix) with ESMTP id C10097A6E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 17:01:20 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from deepin."git.sh.deepin.cn", (unknown [117.174.24.65])
 by smtp.263.net (postfix) whith ESMTP id
 P27278T139895708092160S1587546079459076_; 
 Wed, 22 Apr 2020 17:01:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <aa5f73e2e09de55f16b19d2095e42ebc>
X-RL-SENDER: limingyu@uniontech.com
X-SENDER: limingyu@uniontech.com
X-LOGIN-NAME: limingyu@uniontech.com
X-FST-TO: amd-gfx@lists.freedesktop.org
X-SENDER-IP: 117.174.24.65
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: limingyu <limingyu@uniontech.com>
To: amd-gfx@lists.freedesktop.org,
	dujiangqi@uniontech.com
Subject: [PATCH] drm/amdgpu: Init data to avoid oops while reading
 pp_num_states.
Date: Wed, 22 Apr 2020 17:01:19 +0800
Message-Id: <20200422090119.4692-1-limingyu@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 22 Apr 2020 13:13:34 +0000
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
Cc: zhangyueqian@uniontech.com, zhoubinbin <zhoubinbin@uniontech.com>,
 limingyu@uniontech.com, honghao@uniontech.com, caizhaopeng@uniontech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index abe94a55ecad..17de9dc60ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -444,8 +444,10 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 		ret = smu_get_power_num_states(&adev->smu, &data);
 		if (ret)
 			return ret;
-	} else if (adev->powerplay.pp_funcs->get_pp_num_states)
+	} else if (adev->powerplay.pp_funcs->get_pp_num_states) {
 		amdgpu_dpm_get_pp_num_states(adev, &data);
+	} else
+		memset(&data, 0, sizeof(data));
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
-- 
2.20.1



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
