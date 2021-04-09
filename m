Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C84C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 03:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E82D6113C
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 03:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E82D6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65C16E44E;
	Fri,  9 Apr 2021 03:42:57 +0000 (UTC)
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B300D6E430;
 Fri,  9 Apr 2021 01:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=fHB/+dK6Mq9Z5oA7Lj
 LWEposRFG9O6Ln3UZNEI50HN8=; b=F1ZvPebr1a47K3BmCsHrDgc/ilqPNyfTva
 HQTvHC5nBe1UNhMHvroG4X362sGBLURh9yWWM0tuykefmPZJg8x9H312SzBxwCYZ
 cOuZ0Ov8ImN/IaQAb0NecXgBvEC5wc9Koa21/9DQ0LnE+Xl+q4z5cTDE7MxsthLL
 IUABXFIKI=
Received: from localhost.localdomain (unknown [106.19.194.64])
 by smtp3 (Coremail) with SMTP id DcmowAAnL+tzpm9gcYu_QA--.50335S2;
 Fri, 09 Apr 2021 08:57:25 +0800 (CST)
From: wangyingjie55@126.com
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 mikita.lipski@amd.com, eryk.brol@amd.com, aurabindo.pillai@amd.com,
 Wayne.Lin@amd.com, luben.tuikov@amd.com
Subject: [PATCH v1] drm/amd/dc: Fix a missing check bug in dm_dp_mst_detect()
Date: Thu,  8 Apr 2021 17:57:20 -0700
Message-Id: <1617929840-13269-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DcmowAAnL+tzpm9gcYu_QA--.50335S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xry8AryxKFWfZryUWw45KFg_yoW8JF1Up3
 yUtrZrXr1kZa12934DAF1ruFZ0ya4kXFWUKrWUuw1Y9a48Grs8JayrJrnrWasrWrZIk3y3
 Za17X3y7XF1q9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbJ5wUUUUU=
X-Originating-IP: [106.19.194.64]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbi7hZvp1tC6ZkkMwAAsO
X-Mailman-Approved-At: Fri, 09 Apr 2021 03:42:56 +0000
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
Cc: dri-devel@lists.freedesktop.org, wangyingjie55@126.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yingjie Wang <wangyingjie55@126.com>

In dm_dp_mst_detect(), We should check whether or not @connector
has been unregistered from userspace. If the connector is unregistered,
we should return disconnected status.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8ab0b9060d2b..103dfd0e9b65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -271,6 +271,9 @@ dm_dp_mst_detect(struct drm_connector *connector,
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_dm_connector *master = aconnector->mst_port;
 
+	if (drm_connector_is_unregistered(connector))
+		return connector_status_disconnected;
+
 	return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
 				      aconnector->port);
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
