Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E0DEB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 08:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463E710E62D;
	Fri, 21 Jul 2023 08:20:48 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B53F10E612
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 03:32:09 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R6ZqW0pwgzBRDtG
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 11:32:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689910326; x=1692502327; bh=DgngVkhS4Y2EpAg4Rz03E9/o90m
 U59SYiP+mSo3EkDk=; b=GoQ72x9nmd2y6OKp4qyJPmwiKCQ0W16YcKBSzA5ERLE
 PCRINd+rr5fLFyUcEp/rQqkbDvHn/LiXGofvX5wH19t0EOmfAqlIzrWbGNF/ZY7l
 CkqKrPu84naamPg8Q+HIL3gjurrZ4PAM/xAps54S0WU4YcquiYpFmurWuuSVdB/+
 4QAGlqOqlPNsaA2B6t/8PrrRAv46SIT6Ii3S428gX4KKRDeNEYquBzReFZmo9kwB
 Nm2yEIgtMQIYbWGFQ/33ZEkbkZHUOiSUmJ9jGTz2EAwvS5/eH1aaUU2ssPX7hFhR
 FdpLndDyXlu/hQ91Fc1VvMjGA85edG35kZzlesik1gw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jjI-25dzcQUr for <amd-gfx@lists.freedesktop.org>;
 Fri, 21 Jul 2023 11:32:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R6ZqV5jSmzBRDrd;
 Fri, 21 Jul 2023 11:32:06 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 21 Jul 2023 11:32:06 +0800
From: sunran001@208suo.com
To: alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu: open brace '{' following struct go on the same
 line
In-Reply-To: <20230721033048.4840-1-xujianghui@cdjrlc.com>
References: <20230721033048.4840-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d0906df99cdf6f76220e298bebaa5029@208suo.com>
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

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h 
b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index 52045ad59bed..eec816f0cbf9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -24,8 +24,7 @@
  #ifndef __AMDGPU_PM_H__
  #define __AMDGPU_PM_H__

-struct cg_flag_name
-{
+struct cg_flag_name {
  	u64 flag;
  	const char *name;
  };
