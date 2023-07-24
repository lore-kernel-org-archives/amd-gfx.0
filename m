Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3310C04A94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5120D10E30E;
	Mon, 24 Jul 2023 12:59:08 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB04210E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 08:54:28 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R8Yr15zvbzB7Bvn
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 16:54:25 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690188865; x=1692780866; bh=chwR9bvFIg7iBGHVcSR9ITXkkoJ
 jDG51eV1JMt2fqig=; b=SFzxcNQJfmH2iWnlPIODSRbG3ucbAh4R+FuRW4eH1H2
 xCLYm0bqatfPCsRUMZaQraniglwPE3h4b42OhQ/l2fS814Xikw7YYP/6Sg2hYO6H
 QB+9lAlOfSPvoc5d7PO6GfoM7Pnkyh3SgHiV0ygy12RlobLuE+hbmDVtPhZsxZOD
 H5o/yH76RDH/rOxrsYh3Y4AUrj2IjKIXgfaHdfy1bn+rXDvheqc5nsMPTD9QTVDQ
 OkozNrYdTWPp+jo0HUPOBHSu4EM9qEdRNECXA9mzAlJObAOP0fwcyyzd+0/bCDMH
 wXbk+gcGEwCrMjHjAdCc1RtOPKB5YcQXR1ElCmI/ilA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id nNDCu7jSuzgR for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jul 2023 16:54:25 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R8Yr14866zBKnld;
 Mon, 24 Jul 2023 16:54:25 +0800 (CST)
MIME-Version: 1.0
Date: Mon, 24 Jul 2023 16:54:25 +0800
From: sunran001@208suo.com
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v11_0_7_pptable.h
In-Reply-To: <20230724085303.9607-1-xujianghui@cdjrlc.com>
References: <20230724085303.9607-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <c5575527bac1642f2cf896ae0ee9f582@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Jul 2023 12:58:34 +0000
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

Fix the following errors reported by checkpatch:

ERROR: trailing whitespace
ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  .../amd/pm/swsmu/inc/smu_v11_0_7_pptable.h    | 41 +++++++++----------
  1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h 
b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
index 1cb399dbc7cc..64d60d48846a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
@@ -42,23 +42,23 @@
  #define SMU_11_0_7_PP_POWERSAVINGCLOCK_VERSION            0x01          
  // Power Saving Clock Table Version 1.00

  enum SMU_11_0_7_ODFEATURE_CAP {
-    SMU_11_0_7_ODCAP_GFXCLK_LIMITS = 0,
-    SMU_11_0_7_ODCAP_GFXCLK_CURVE,
-    SMU_11_0_7_ODCAP_UCLK_LIMITS,
-    SMU_11_0_7_ODCAP_POWER_LIMIT,
-    SMU_11_0_7_ODCAP_FAN_ACOUSTIC_LIMIT,
-    SMU_11_0_7_ODCAP_FAN_SPEED_MIN,
-    SMU_11_0_7_ODCAP_TEMPERATURE_FAN,
-    SMU_11_0_7_ODCAP_TEMPERATURE_SYSTEM,
-    SMU_11_0_7_ODCAP_MEMORY_TIMING_TUNE,
-    SMU_11_0_7_ODCAP_FAN_ZERO_RPM_CONTROL,
-    SMU_11_0_7_ODCAP_AUTO_UV_ENGINE,
-    SMU_11_0_7_ODCAP_AUTO_OC_ENGINE,
-    SMU_11_0_7_ODCAP_AUTO_OC_MEMORY,
+    SMU_11_0_7_ODCAP_GFXCLK_LIMITS = 0,
+    SMU_11_0_7_ODCAP_GFXCLK_CURVE,
+    SMU_11_0_7_ODCAP_UCLK_LIMITS,
+    SMU_11_0_7_ODCAP_POWER_LIMIT,
+    SMU_11_0_7_ODCAP_FAN_ACOUSTIC_LIMIT,
+    SMU_11_0_7_ODCAP_FAN_SPEED_MIN,
+    SMU_11_0_7_ODCAP_TEMPERATURE_FAN,
+    SMU_11_0_7_ODCAP_TEMPERATURE_SYSTEM,
+    SMU_11_0_7_ODCAP_MEMORY_TIMING_TUNE,
+    SMU_11_0_7_ODCAP_FAN_ZERO_RPM_CONTROL,
+    SMU_11_0_7_ODCAP_AUTO_UV_ENGINE,
+    SMU_11_0_7_ODCAP_AUTO_OC_ENGINE,
+    SMU_11_0_7_ODCAP_AUTO_OC_MEMORY,
      SMU_11_0_7_ODCAP_FAN_CURVE,
      SMU_11_0_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT,
-    SMU_11_0_7_ODCAP_POWER_MODE,
-    SMU_11_0_7_ODCAP_COUNT,
+    SMU_11_0_7_ODCAP_POWER_MODE,
+    SMU_11_0_7_ODCAP_COUNT,
  };

  enum SMU_11_0_7_ODFEATURE_ID {
@@ -130,8 +130,7 @@ enum SMU_11_0_7_PWRMODE_SETTING {
  };
  #define SMU_11_0_7_MAX_PMSETTING      32        //Maximum Number of 
PowerMode Settings

-struct smu_11_0_7_overdrive_table
-{
+struct smu_11_0_7_overdrive_table {
      uint8_t  revision;                                        
//Revision = SMU_11_0_7_PP_OVERDRIVE_VERSION
      uint8_t  reserve[3];                                      //Zero 
filled field reserved for future use
      uint32_t feature_count;                                   //Total 
number of supported features
@@ -160,8 +159,7 @@ enum SMU_11_0_7_PPCLOCK_ID {
  };
  #define SMU_11_0_7_MAX_PPCLOCK      16          //Maximum Number of PP 
Clocks

-struct smu_11_0_7_power_saving_clock_table
-{
+struct smu_11_0_7_power_saving_clock_table {
      uint8_t  revision;                                        
//Revision = SMU_11_0_7_PP_POWERSAVINGCLOCK_VERSION
      uint8_t  reserve[3];                                      //Zero 
filled field reserved for future use
      uint32_t count;                                           
//power_saving_clock_count = SMU_11_0_7_PPCLOCK_COUNT
@@ -169,8 +167,7 @@ struct smu_11_0_7_power_saving_clock_table
      uint32_t min[SMU_11_0_7_MAX_PPCLOCK];                       
//PowerSavingClock Mode Clock Minimum array In MHz
  };

-struct smu_11_0_7_powerplay_table
-{
+struct smu_11_0_7_powerplay_table {
        struct atom_common_table_header header;       //For 
sienna_cichlid, header.format_revision = 15, header.content_revision = 0
        uint8_t  table_revision;                      //For 
sienna_cichlid, table_revision = 2
        uint16_t table_size;                          //Driver portion 
table size. The offset to smc_pptable including header size
@@ -178,7 +175,7 @@ struct smu_11_0_7_powerplay_table
        uint32_t golden_revision;                     //PPGen use only: 
PP Table Revision on the Golden Data Base
        uint16_t format_id;                           //PPGen use only: 
PPTable for different ASICs. For sienna_cichlid this should be 0x80
        uint32_t platform_caps;                       
//POWERPLAYABLE::ulPlatformCaps
-
+
        uint8_t  thermal_controller_type;             //one of 
SMU_11_0_7_PP_THERMALCONTROLLER

        uint16_t small_power_limit1;
