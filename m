Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77533C001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 07:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2EDC10E7E2;
	Fri, 14 Jul 2023 07:16:18 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9543510E0FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 03:32:36 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R2H9F3LJPzBRSVb
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 11:32:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689305553; x=1691897554; bh=AuYDgHFbLdSKDR3AAWF4AJBZRCt
 ktO5bYp21CycLwUE=; b=McsvLIXk3Bq/oQFGBcT9NxaV4fR5oNcfADN/MOcZkf/
 7jpZKdjDofruNkcpeo92d+oQXZ7Eqh+ne6aO2bHucugCK7iFs22Ht0l/nYXpjq6A
 ZsT2PHkcBSQjDtn/38q1M912cIvvZcAzBHQn7tJcDMPtau0I2ibpnrNlf5qSV5dS
 K6gH7cfK5IKmWSj2Otq3ChNYX8YBUBdhqKQxjgpcgohP1knRP7tXFkwPh7LL4OlA
 CwNOHQf+ENhj4wtDL2ezdM9Gk2qWM155lk/fbAFjkDOfAJHUTLHhLHxvMWGdeYUQ
 QouhNLwLPdouWJD9KyE/FiYmd8JeSm1RAAp06ste8qQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 1fd63AhRuDj3 for <amd-gfx@lists.freedesktop.org>;
 Fri, 14 Jul 2023 11:32:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R2H9D5yklzBHXhS;
 Fri, 14 Jul 2023 11:32:32 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 11:32:32 +0800
From: shijie001@208suo.com
To: airlied@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
Subject: [PATCH] drm/radeon: ERROR: spaces required around that '+=' (ctx:VxV)
In-Reply-To: <tencent_90453D41C9A3FB57DCCA60655D9218D1870A@qq.com>
References: <tencent_90453D41C9A3FB57DCCA60655D9218D1870A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <97d2ba38071e5c650894c01a56a2533a@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 14 Jul 2023 07:16:15 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix two occurrences of the checkpatch.pl error:
ERROR: spaces required around that '+=' (ctx:VxV)

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/r100.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r100.c 
b/drivers/gpu/drm/radeon/r100.c
index affa9e0309b2..2f0470f927f1 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1327,7 +1327,7 @@ int r100_packet3_load_vbpntr(struct 
radeon_cs_parser *p,
          return -EINVAL;
      }
      track->num_arrays = c;
-    for (i = 0; i < (c - 1); i+=2, idx+=3) {
+    for (i = 0; i < (c - 1); i += 2, idx += 3) {
          r = radeon_cs_packet_next_reloc(p, &reloc, 0);
          if (r) {
              DRM_ERROR("No reloc for packet3 %d\n",
