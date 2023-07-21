Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6A9EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 08:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BE710E1C6;
	Fri, 21 Jul 2023 08:20:42 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE7310E154
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 01:31:14 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R6X7z1n8pzBRDtG
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 09:31:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689903071; x=1692495072; bh=Qq62sLIO6ROPq/epkdPBhc/KPvU
 UIj4lTk/QHIBHckU=; b=exwDGHjJyLXPDiDr6d+fWHA6TZFDscQnhyPw0gAKMcn
 ZK2aQi075XlBAWPyQwPHF5709F6h4hF7SJrR3cYlt+z0V8nKkof/6FJL+E91qyBu
 gaqTe8ZEjZD5x3GrJC+kbm9wnexxiC4QOF3loVsjh/4HFyAWuaiOt56AFfwInDJi
 6awS4gwxcSDqh3jZ2gCvHvy+Ev+DWSgeJtJjsjBAlL0kWsgZGFo5mX/THZVgNxyl
 dILNLnECjUvJ79B088rGON54PE4tIRcvzqRxF777cZKUISW/YIwGynOSvt8xJgjM
 heDtXdKRJdrKJklUyBDzKeJnbvCyS7Dg64kPzhvfbwA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LSPE47GhmGvj for <amd-gfx@lists.freedesktop.org>;
 Fri, 21 Jul 2023 09:31:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R6X7y5n73zBJkk9;
 Fri, 21 Jul 2023 09:31:10 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 21 Jul 2023 09:31:10 +0800
From: sunran001@208suo.com
To: alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/amd: open brace '{' following struct go on the same line
In-Reply-To: <20230721012635.4552-1-xujianghui@cdjrlc.com>
References: <20230721012635.4552-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f9f0077b8f91d858777e9ad2db972db8@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 21 Jul 2023 08:20:41 +0000
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
