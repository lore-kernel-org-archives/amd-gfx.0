Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B0FC001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 07:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48A9C10E7F5;
	Fri, 14 Jul 2023 07:16:32 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6887D10E188
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 06:04:18 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R2LXG3c22zBR9tK
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 14:04:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689314654; x=1691906655; bh=ezthta+WZ36eYrWV9Zb+A2N7VbH
 gwUOqc/NALhwnFGo=; b=eTtIg3AT72wukEEUEmZQSOsx+up3ItDoggfAIb3yyM4
 Fdl8UPMTwtMiMAm56tEAbkEkZCiN6MmPTmrwH/kNBZJ/ikNZvCeFawbsrFkvVdOJ
 oGKfl/3JxmMI2XZcCiFtX7LRdaIJP6Koic95sIled4YTrC7/2hzzRBCAC4Tn16mv
 Dm75ZwI5Olm4j7f3Smx8Mbg1SgMFLx+k3094V42YGK6QgblZJFyh5dKlHnOfV8aC
 iY+OEz81pFW4ukB8TVN0n6umpdv2GQ4qTYnKjqLNtL61iUMbDtyUxpvQSsnYEPDF
 SGOjkFXqGiUo0eijxglHPLdOPXBTLHt7+xCAs6FEezQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id duGLB3lbqVMH for <amd-gfx@lists.freedesktop.org>;
 Fri, 14 Jul 2023 14:04:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R2LXF6blyzBR9t9;
 Fri, 14 Jul 2023 14:04:13 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 14:04:13 +0800
From: sunran001@208suo.com
To: airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/amd: open brace '{' following struct go on the same line
In-Reply-To: <20230714060105.13377-1-xujianghui@cdjrlc.com>
References: <20230714060105.13377-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <e565a40b4ae73352204fbf49e55de452@208suo.com>
X-Sender: sunran001@208suo.com
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

Fix the checkpatch error as open brace '{' following struct should
go on the same line.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/include/yellow_carp_offset.h | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h 
b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
index 0fea6a746611..a2c8dca2425e 100644
--- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
+++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
@@ -7,13 +7,11 @@
  #define MAX_SEGMENT                                         6

-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
      unsigned int segment[MAX_SEGMENT];
  } __maybe_unused;

-struct IP_BASE
-{
+struct IP_BASE {
      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
  } __maybe_unused;
