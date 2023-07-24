Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CACC04A94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A199D10E2FF;
	Mon, 24 Jul 2023 12:58:56 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829CD10E26F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 03:37:02 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R8Qnm1QnWzBRYmP
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 11:37:00 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690169820; x=1692761821; bh=QtbczKRz0FUK6RRntB/EC/QnHLq
 xHBVDRWfCYscwKwc=; b=QSrSlD/UrOyUZ98Zz3buV6E6NJS6T8V5a1mI8VW1XuH
 bHDBtucvsT1SE+VM4LHgv3eYpWAZgbsRuTN6h1D5W6yvdiJKtwyyOUZpKBOmA/SG
 Mu2qPE5u6uBXhOwanCOsdmskVqOssUY7Bvefr46h8B1xQhYA8LtwjN+fBLgcdBOZ
 zwc3RILbFOpAJun4DBuLqK6dajqMbq41yoMCg1Xy2lJSWbyhyadcoLtxp2M6n0PI
 TaLaPSlYchaUK4P433jY9bpMUhoP1QIySz36Knr4AGQMivV3LNhj/YG2kMw7O4n1
 vafZjI/DHgoGJ02X78lvRU/pCLz0amUZv8N2FbMy2ng==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id xkcGdx5PWURB for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jul 2023 11:37:00 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R8Qnl6T7QzBJTF7;
 Mon, 24 Jul 2023 11:36:59 +0800 (CST)
MIME-Version: 1.0
Date: Mon, 24 Jul 2023 11:36:59 +0800
From: sunran001@208suo.com
To: alexander.deucher@amd.com
Subject: [PATCH] drm/radeon: that open brace { should be on the previous line
In-Reply-To: <20230724033555.8039-1-xujianghui@cdjrlc.com>
References: <20230724033555.8039-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <e30b4bea0907fe4f94459e0afd5c24a9@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:33 +0000
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

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/clearstate_si.h | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/clearstate_si.h 
b/drivers/gpu/drm/radeon/clearstate_si.h
index 356219c6c7f2..7da8418704fe 100644
--- a/drivers/gpu/drm/radeon/clearstate_si.h
+++ b/drivers/gpu/drm/radeon/clearstate_si.h
@@ -23,8 +23,7 @@

  #include "clearstate_defs.h"

-static const u32 si_SECT_CONTEXT_def_1[] =
-{
+static const u32 si_SECT_CONTEXT_def_1[] = {
      0x00000000, // DB_RENDER_CONTROL
      0x00000000, // DB_COUNT_CONTROL
      0x00000000, // DB_DEPTH_VIEW
