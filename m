Return-Path: <SRS0=O0xp=2E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F2DC00454
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Dec 2019 18:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19249205C9
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Dec 2019 18:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19249205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341D16E3F0;
	Sat, 14 Dec 2019 18:54:43 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C00A6E32C;
 Sat, 14 Dec 2019 09:10:35 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5407A9B8445EF6C57564;
 Sat, 14 Dec 2019 16:55:10 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 14 Dec 2019
 16:55:03 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Remove unneeded semicolon in amdgpu_pmu.c
Date: Sat, 14 Dec 2019 17:02:22 +0800
Message-ID: <1576314144-27602-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576314144-27602-1-git-send-email-zhengbin13@huawei.com>
References: <1576314144-27602-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sat, 14 Dec 2019 18:54:41 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes coccicheck warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:110:3-4: Unneeded semicolon
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:133:2-3: Unneeded semicolon
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:163:2-3: Unneeded semicolon
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:191:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 0e6dba9..cf21ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -107,7 +107,7 @@ static void amdgpu_perf_read(struct perf_event *event)
 		default:
 			count = 0;
 			break;
-		};
+		}
 	} while (local64_cmpxchg(&hwc->prev_count, prev, count) != prev);

 	local64_add(count - prev, &event->count);
@@ -130,7 +130,7 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 		break;
 	default:
 		break;
-	};
+	}

 	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 	hwc->state |= PERF_HES_STOPPED;
@@ -160,7 +160,7 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 		break;
 	default:
 		return 0;
-	};
+	}

 	if (retval)
 		return retval;
@@ -188,7 +188,7 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 		break;
 	default:
 		break;
-	};
+	}

 	perf_event_update_userpage(event);
 }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
