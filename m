Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BD4C001DE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 12:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B99510E2F5;
	Mon, 24 Jul 2023 12:58:55 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C15B10E12E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 07:21:05 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R8WmG0Bb8zBRx56
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 15:21:02 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1690183261; x=1692775262; bh=iOwAQCke2lXlWfG2dYn8lmmgNoq
 nQ8mZuEkdcFl+i/I=; b=mUKfuKizY6u6j5OzRWqTLtd/3KubRp9TyDXYRpTx8o1
 XbZQ5bdoguYlN9Fr3ZZlEgVC7F356tVwH0M92Cbla0AUqVxQD4LSTexfSa70qeJW
 +q5RGzqAvNKj32c5xBG3Gsud6FkNRiEfg1JjEReEFKPhrHBg9M/SC4tkBs2vpbAF
 uyQmLlVx6tucjWwAURpudc82/2IfEwbyGmnFkavuToQuyHqsuN6Jg650ausu46uQ
 peuPkyL0zXamXgZohP3XQ8CreJ6V+5T/tpSDP33VJ8HB2USoGU08Rq7HwJcKmiag
 rl4Qv5Hu0MK6LjEQvqBElZ/Jx3CelLnkykFOvdp4Zgg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gYEWp82HmNuT for <amd-gfx@lists.freedesktop.org>;
 Mon, 24 Jul 2023 15:21:01 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R8WmF55T2zBRx4y;
 Mon, 24 Jul 2023 15:21:01 +0800 (CST)
MIME-Version: 1.0
Date: Mon, 24 Jul 2023 15:21:01 +0800
From: sunran001@208suo.com
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: Clean up errors in navi10_ppt.c
In-Reply-To: <20230724071955.8822-1-xujianghui@cdjrlc.com>
References: <20230724071955.8822-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <3175b4fe4a9d8e4c29a39e9099c109ed@208suo.com>
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

ERROR: open brace '{' following function definitions go on the next line
ERROR: space required before the open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 25 ++++++++++---------
  1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 95f6d821bacb..e655071516b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -136,7 +136,7 @@ static struct cmn2asic_msg_mapping 
navi10_message_map[SMU_MSG_MAX_COUNT] = {
  	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,		0),
  	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,		0),
  	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,			0),
-	MSG_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE,PPSMC_MSG_DALDisableDummyPstateChange,	0),
+	MSG_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE, 
PPSMC_MSG_DALDisableDummyPstateChange,	0),
  
	MSG_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE,	PPSMC_MSG_DALEnableDummyPstateChange,	0),
  	MSG_MAP(GetVoltageByDpm,		PPSMC_MSG_GetVoltageByDpm,		0),
  
	MSG_MAP(GetVoltageByDpmOverdrive,	PPSMC_MSG_GetVoltageByDpmOverdrive,	0),
@@ -556,7 +556,7 @@ static int navi10_get_legacy_smu_metrics_data(struct 
smu_context *smu,
  					      MetricsMember_t member,
  					      uint32_t *value)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
  	SmuMetrics_legacy_t *metrics =
  		(SmuMetrics_legacy_t *)smu_table->metrics_table;
  	int ret = 0;
@@ -642,7 +642,7 @@ static int navi10_get_smu_metrics_data(struct 
smu_context *smu,
  				       MetricsMember_t member,
  				       uint32_t *value)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
  	SmuMetrics_t *metrics =
  		(SmuMetrics_t *)smu_table->metrics_table;
  	int ret = 0;
@@ -731,7 +731,7 @@ static int navi12_get_legacy_smu_metrics_data(struct 
smu_context *smu,
  					      MetricsMember_t member,
  					      uint32_t *value)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
  	SmuMetrics_NV12_legacy_t *metrics =
  		(SmuMetrics_NV12_legacy_t *)smu_table->metrics_table;
  	int ret = 0;
@@ -817,7 +817,7 @@ static int navi12_get_smu_metrics_data(struct 
smu_context *smu,
  				       MetricsMember_t member,
  				       uint32_t *value)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
  	SmuMetrics_NV12_t *metrics =
  		(SmuMetrics_NV12_t *)smu_table->metrics_table;
  	int ret = 0;
@@ -1686,7 +1686,7 @@ static int navi10_force_clk_levels(struct 
smu_context *smu,
  			return 0;
  		break;
  	case SMU_DCEFCLK:
-		dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is not 
supported!\n");
+		dev_info(smu->adev->dev, "Setting DCEFCLK min/max dpm level is not 
supported!\n");
  		break;

  	default:
@@ -2182,7 +2182,7 @@ static int navi10_read_sensor(struct smu_context 
*smu,
  	struct smu_table_context *table_context = &smu->smu_table;
  	PPTable_t *pptable = table_context->driver_pptable;

-	if(!data || !size)
+	if (!data || !size)
  		return -EINVAL;

  	switch (sensor) {
@@ -2317,15 +2317,15 @@ static int 
navi10_display_disable_memory_clock_switch(struct smu_context *smu,
  	uint32_t min_memory_clock = smu->hard_min_uclk_req_from_dal;
  	uint32_t max_memory_clock = max_sustainable_clocks->uclock;

-	if(smu->disable_uclk_switch == disable_memory_clock_switch)
+	if (smu->disable_uclk_switch == disable_memory_clock_switch)
  		return 0;

-	if(disable_memory_clock_switch)
+	if (disable_memory_clock_switch)
  		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 
max_memory_clock, 0);
  	else
  		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 
min_memory_clock, 0);

-	if(!ret)
+	if (!ret)
  		smu->disable_uclk_switch = disable_memory_clock_switch;

  	return ret;
@@ -2559,7 +2559,8 @@ static int navi10_set_default_od_settings(struct 
smu_context *smu)
  	return 0;
  }

-static int navi10_od_edit_dpm_table(struct smu_context *smu, enum 
PP_OD_DPM_TABLE_COMMAND type, long input[], uint32_t size) {
+static int navi10_od_edit_dpm_table(struct smu_context *smu, enum 
PP_OD_DPM_TABLE_COMMAND type, long input[], uint32_t size)
+{
  	int i;
  	int ret = 0;
  	struct smu_table_context *table_context = &smu->smu_table;
@@ -3368,7 +3369,7 @@ static ssize_t navi1x_get_gpu_metrics(struct 
smu_context *smu,
  		      ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 0)) && 
smu_version > 0x002A3B00))
  			ret = navi10_get_gpu_metrics(smu, table);
  		else
-			ret =navi10_get_legacy_gpu_metrics(smu, table);
+			ret = navi10_get_legacy_gpu_metrics(smu, table);
  		break;
  	}
