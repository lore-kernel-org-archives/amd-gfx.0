Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07523EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 07:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8301510E7DB;
	Fri, 14 Jul 2023 07:16:16 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D9D10E0F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 03:20:56 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R2Gvg67z2zBRSVf
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 11:20:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689304847; x=1691896848; bh=4RThHj/DNsNyooB75oPh9gIzWA4
 yeEuFdFd3SjfPcMY=; b=xbbO6lOgpFwD/BA1IFiZVSZDjHtlJSe9RMNxTkie6D9
 yU19LkyjYjax75jtvCX/ukSR8nupYhmz73JowPy7Y9HpgwTxvrc7k/5gRrGqdYml
 okGjarGNTNipRvqbWzqXy0hmwCOKGfRa2C5n2rfHEj1nlf/xXshg3egeOuhujlTY
 171xj6+ajhU0z4wqn+GOQZbxhclll25GXm/JUchqMzYmAs4VyJryaW71SxYmXjd0
 21eGWKUtZcpLXaShyOz3er0/UVS5X573SoKij3/4WTJIrIOtEYFFlO6DISkSUZnj
 Yf0aqfBgy2y6cl5jJ9AuFd4RD681IsP4boe8WUzi4TQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id pii9BkZZoEys for <amd-gfx@lists.freedesktop.org>;
 Fri, 14 Jul 2023 11:20:47 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R2Gvg3pGGzBJk54;
 Fri, 14 Jul 2023 11:20:47 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 11:20:47 +0800
From: shijie001@208suo.com
To: airlied@gmail.com, daniel@ffwll.ch, christian.koenig@amd.com,
 alexander.deucher@amd.com, Xinhui.Pan@amd.com
Subject: [PATCH] drm/radeon: ERROR: open brace '{' following function
 definitions go on the next line
In-Reply-To: <tencent_21616D4FB2F221FE67B71858B197C646AB08@qq.com>
References: <tencent_21616D4FB2F221FE67B71858B197C646AB08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <50bf0cff1b048f24484f32ff0e5015f6@208suo.com>
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

Fix four occurrences of the checkpatch.pl error:
ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++++++----
  1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c 
b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index 6f93f54bf651..2a3c3f8b02e2 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -61,19 +61,23 @@ struct atpx_mux {
      u16 mux;
  } __packed;

-bool radeon_has_atpx(void) {
+bool radeon_has_atpx(void)
+{
      return radeon_atpx_priv.atpx_detected;
  }

-bool radeon_has_atpx_dgpu_power_cntl(void) {
+bool radeon_has_atpx_dgpu_power_cntl(void)
+{
      return radeon_atpx_priv.atpx.functions.power_cntl;
  }

-bool radeon_is_atpx_hybrid(void) {
+bool radeon_is_atpx_hybrid(void)
+{
      return radeon_atpx_priv.atpx.is_hybrid;
  }

-bool radeon_atpx_dgpu_req_power_for_displays(void) {
+bool radeon_atpx_dgpu_req_power_for_displays(void)
+{
      return radeon_atpx_priv.atpx.dgpu_req_power_for_displays;
  }
