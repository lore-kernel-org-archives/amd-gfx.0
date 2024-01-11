Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC432C4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BB110E8BA;
	Thu, 11 Jan 2024 09:04:32 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTP id 376A810E7EF;
 Thu, 11 Jan 2024 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=PEj/IefDs7XXAmaMbG
 Q5wDa1llgebw/3KVMWGYgPYmc=; b=Wtxax/nGP6lTaC9E+BYyWnPHZpZ2/rJwCK
 NeokAYmzy9ATr6eYS6IxN0InPX3MmuOcMprnR0bJZ4UTfKp5qaM8rXdvEuCdcaRp
 epbIZEAqqGnpScOSK4It4Htfgnr41QWulU0CBRYeREvD7fOdJwPDe6ohb9Z1+96y
 qQVUhX4CM=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wDnby_GnJ9lzO+SAA--.17065S2;
 Thu, 11 Jan 2024 15:46:15 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/radeon/ni_dpm: Clean up errors in ni_dpm.c
Date: Thu, 11 Jan 2024 07:46:13 +0000
Message-Id: <20240111074613.10938-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDnby_GnJ9lzO+SAA--.17065S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWrKF43Gr4ktw47tFW8JFb_yoW8Jw43pF
 43W340grZ5tw4ruF43AayUArya93Z7G3WI9w4UAw4fW3WDZryjkFnxCrs3Ar97WrZY9rWI
 qr1ktr13XF4xArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFdgAUUUUU=
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEARi1mVOBk6-bwABsS
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:24 +0000
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, GuoHua Chen <chenguohua_716@163.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/ni_dpm.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.h b/drivers/gpu/drm/radeon/ni_dpm.h
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
-- 
2.17.1

