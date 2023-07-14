Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85F9C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 07:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C881710E7F4;
	Fri, 14 Jul 2023 07:16:31 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C9E10E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 04:59:46 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R2K5n6llMzBR9sb
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 12:59:41 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689310781; x=1691902782; bh=kKU3uyB6okQSTGQqzBMPumiXiBT
 wf7W7pXC7rR7eRcU=; b=jTKq5bHrxgGenSCsBcUePEu8ahT3UeW4zbqUl/8BFrR
 ABqV3UYTd3Ya+6mPCaHL2s4BtxKzAMRtH1mO+76gS+BiQwueJ0qOmtH6vwmNeI7P
 H+tGgLIU2OBqBscEqgKmV2NaYFgsYIdIvBq9fSthQqgcxGK/LXZZStOeT6fPdLrY
 AoebTuu3vgMy/4G78apxMSJcWx381frcOO4fr2/2kkanIy4J8PKmEZqf5nHNdIJh
 /EJUQrMYU6uu/LkNUDuK+CCogfCPEAzFaUAKiYXdHRqUcHDXmcAz5XYs60+qngGJ
 C/VsMxALuxklw59BRABj6Z7FhrAmiaoEAWl0Eeprwmw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id xL0Vdeg-WAL1 for <amd-gfx@lists.freedesktop.org>;
 Fri, 14 Jul 2023 12:59:41 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R2K5n3m0JzBHXhS;
 Fri, 14 Jul 2023 12:59:41 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 14 Jul 2023 12:59:41 +0800
From: shijie001@208suo.com
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/radeon/dpm: ERROR: open brace '{' following enum go on
 the same line
In-Reply-To: <tencent_FDFE1B9D84BD3C51CAE7FADFDCF6613D5D0A@qq.com>
References: <tencent_FDFE1B9D84BD3C51CAE7FADFDCF6613D5D0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <21b12c2d37bff73a0c625b6af9d95021@208suo.com>
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
ERROR: open brace '{' following enum go on the same line

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/ni_dpm.h | 12 ++++--------
  1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.h 
b/drivers/gpu/drm/radeon/ni_dpm.h
index 74e301936906..4e3e7303e035 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.h
+++ b/drivers/gpu/drm/radeon/ni_dpm.h
@@ -59,8 +59,7 @@ struct ni_mc_reg_table {

  #define NISLANDS_MCREGISTERTABLE_FIRST_DRIVERSTATE_SLOT 2

-enum ni_dc_cac_level
-{
+enum ni_dc_cac_level {
      NISLANDS_DCCAC_LEVEL_0 = 0,
      NISLANDS_DCCAC_LEVEL_1,
      NISLANDS_DCCAC_LEVEL_2,
@@ -72,8 +71,7 @@ enum ni_dc_cac_level
      NISLANDS_DCCAC_MAX_LEVELS
  };

-struct ni_leakage_coeffients
-{
+struct ni_leakage_coeffients {
      u32 at;
      u32 bt;
      u32 av;
@@ -83,8 +81,7 @@ struct ni_leakage_coeffients
      u32 t_ref;
  };

-struct ni_cac_data
-{
+struct ni_cac_data {
      struct ni_leakage_coeffients leakage_coefficients;
      u32 i_leakage;
      s32 leakage_minimum_temperature;
@@ -100,8 +97,7 @@ struct ni_cac_data
      u8 lts_truncate_n;
  };

-struct ni_cac_weights
-{
+struct ni_cac_weights {
      u32 weight_tcp_sig0;
      u32 weight_tcp_sig1;
      u32 weight_ta_sig;
