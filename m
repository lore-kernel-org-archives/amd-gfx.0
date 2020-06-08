Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C88C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594A32072F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bp/lWJYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594A32072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183218953E;
	Mon,  8 Jun 2020 10:53:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8A889949
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 10:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXBvOMchoXp/halKJfuMxOFttDWJoXnjHsjUonRit7o3/ml4427yZYBY3tuycddO666Bw3aJvLP5fLINRi6ppukN6Eqnkuf0ta17qmIf/vkFUGnkOidytjK1cvwcUoeIn6NPX1B7DAXbsbK73LorRWKlPGE08vwjAvL8MO0YosuBtgC/8w7E8XFQKsIB2V53Xeqj666hnYkepRXLncCYuV76JuLXHXBxM+7GqxHAGTSYstCQb1ph6jKcwTkw+jPHMhPWje4arDZyWAi4cDigxJ1NWQoAJZWTql1/iPJ20D/i6aSajMS2VI0ja1CR6FL/F73D8SaHguUTZctAjiK1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjSBCGYT0JVjeVoaRHe023mLHCMYP7ZHaDhY9cMy3UI=;
 b=B4MNkc41Md3E+8m2nxo57MCBb9atMoQ3spRUkX+sKVcl84EYHJwE65cfV19nH3zktnLBPRBJmEg4jFNdhSi9AD0wNqV5ihVYAgGm3Ne4an9R6pePt986z4b7rFUovAvMKuV5OwkZdjCt4+PxFpQGMR1ZMVZJ+apXA7Iwc3y7GV5j1JVQ6+8XLcwc60xE1ybykBNn+vopkvmezzKymZQvWAVgFTj0VsVMj79vlE8c53opabxHqfn1gcl/dPSOw7VXpnzr9Rqgpb165s/QEPKo5XyCWVDIOyIb4yNVcf/BMII6U60kyEswZgsKgr1qlcoXqj+V8PwyhMdbYNZVAifdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjSBCGYT0JVjeVoaRHe023mLHCMYP7ZHaDhY9cMy3UI=;
 b=Bp/lWJYDVBOpV0kuestrGZLWr4Q/q2/WyxZLviX/YWMuzv+sdBvBlKYwk1h+aHVeTBzHhLUDiCM7ggtYPOt1i/8RlviJb5NNrU6XSi/atKQ9UnAex7yPKyG/S+bcXCJLl3JgdKY+AddkNuQXohEQafYSqX9HnzPXpxyqnzM200g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:53:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:53:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amd/powerplay: drop unnecessary
 get_pptable_power_limit wrappers
Date: Mon,  8 Jun 2020 18:52:28 +0800
Message-Id: <20200608105234.29864-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 10:53:18 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00bd217e-5e5a-44ca-b148-08d80b9a27bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35464296C66AB2C8EB5EFFFAE4850@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFVvaS2nDc9/DgiHOrOd3WZtZ4ghXhNdIWAmdjwcAEqOxUO4f40RfhY10s8LCBsgPqNT6vr38sfEVwpo9to0LZSZEWHPaVKFysUH8tORuKBZG0NylH3hedTGvUXV/yyNJ17yECCcMTeWTo4DMD3XdnmoME4A6ijMeAqNBgPEYbEYVbxqDWq9gJSaBEoEJuLLlAwtvqh19edpnwwfqf7RDfzj7yzRihXgD8ZEOoTBGy0HHIB0NCvMnpjYIEp0J2orHWo8GIN+ZdwR/0qf6UxB8jsD5k9pjptq1cCaE/3yFNp96/+xUDoJ7jyoMFMytg4CpRVI7yqgomBAri2zbL7Mig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(2906002)(66476007)(6666004)(66574014)(6916009)(8676002)(956004)(66946007)(2616005)(8936002)(26005)(5660300002)(44832011)(4326008)(86362001)(6486002)(478600001)(83380400001)(316002)(186003)(52116002)(7696005)(36756003)(16526019)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1O2z7eQjbElhl9g444oZGxEkQRu3xwoqD9P+ST8FPlLjgaVuX8SM7nJctcxkxfyDkLCrVKyajmMUL5EeiRRAgMWghjv0YQb8tCQvAwN+8taWIQ3KBaMT4jwt2UgFMFjD58icTmY+ycjXXCwubdJqaOfy8dI72/r9TmyuptZY0PEYjsDpWk9sBMj6qWkKN/u4irlSt/JK2iyrr5A5QBZUca+PUZV+p7mJeaDlxE3Wk/3YNZ/E+8mpklt92DjHiLLzkPuvKimEKKRV2QZOPSQOSgW6dDvzqpgxszHEZrtLlms+PcAgNpA+Isd+cOgImK2J4Yctwa8rRuCfEfSJ/l279uoaWkE6pNeuytmAn7OOHRpkI5hdCD24QUvp8XW0ag2lfQ4hkNsONDu0pxg5w/JqHMTNXPKO5stKIBGIkj8TOOiB4WALmTi7nmcEkUk++9YWQ/pKiP6WXyKJEoomMAbE4Eexwh8NTDrvGt8vagdR+2FWa26WYsyW/CcrbwBQKX9N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bd217e-5e5a-44ca-b148-08d80b9a27bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:53:19.5555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwysa/5AM6es0cdVPPHrc+hWT05bpnP5Dhy8cXNM9MCW7R0xyZjp8OVLXlmft1qu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Minor code cleanup.

Change-Id: I56a56ebe4a86e7fca5de02d41928f533dda4d185
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 10 ----------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  3 +--
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  3 ---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  3 +--
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c |  3 +--
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b84eabfc1976..a5fd1284ff1c 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2827,13 +2827,3 @@ int smu_get_dpm_clock_table(struct smu_context *smu,
 
 	return ret;
 }
-
-uint32_t smu_get_pptable_power_limit(struct smu_context *smu)
-{
-	uint32_t ret = 0;
-
-	if (smu->ppt_funcs->get_pptable_power_limit)
-		ret = smu->ppt_funcs->get_pptable_power_limit(smu);
-
-	return ret;
-}
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index eb213504c6c5..0704a9c1d567 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2561,7 +2561,7 @@ static uint32_t atcturus_get_max_power_limit(struct smu_context *smu) {
 	struct smu_table_context *table_context = &smu->smu_table;
 	powerplay_table = table_context->power_play_table;
 
-	max_power_limit = smu_get_pptable_power_limit(smu);
+	max_power_limit = arcturus_get_pptable_power_limit(smu);
 
 	if (!max_power_limit) {
 		// If we couldn't get the table limit, fall back on first-read value
@@ -2669,7 +2669,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.override_pcie_parameters = NULL,
-	.get_pptable_power_limit = arcturus_get_pptable_power_limit,
 	.set_df_cstate = arcturus_set_df_cstate,
 	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 91e29444134f..9276320c09d0 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -567,7 +567,6 @@ struct pptable_funcs {
 	int (*get_dpm_ultimate_freq)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t *min, uint32_t *max);
 	int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max);
 	int (*override_pcie_parameters)(struct smu_context *smu);
-	uint32_t (*get_pptable_power_limit)(struct smu_context *smu);
 	int (*disable_umc_cdr_12gbps_workaround)(struct smu_context *smu);
 	int (*set_power_source)(struct smu_context *smu, enum smu_power_src_type power_src);
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
@@ -767,6 +766,4 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
 int smu_get_dpm_clock_table(struct smu_context *smu,
 			    struct dpm_clocks *clock_table);
 
-uint32_t smu_get_pptable_power_limit(struct smu_context *smu);
-
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 9095602bfb6a..e63498e747ac 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2397,7 +2397,7 @@ static uint32_t navi10_get_max_power_limit(struct smu_context *smu) {
 	struct smu_table_context *table_context = &smu->smu_table;
 	powerplay_table = table_context->power_play_table;
 
-	max_power_limit = smu_get_pptable_power_limit(smu);
+	max_power_limit = navi10_get_pptable_power_limit(smu);
 
 	if (!max_power_limit) {
 		// If we couldn't get the table limit, fall back on first-read value
@@ -2504,7 +2504,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 	.set_default_od_settings = navi10_set_default_od_settings,
 	.od_edit_dpm_table = navi10_od_edit_dpm_table,
-	.get_pptable_power_limit = navi10_get_pptable_power_limit,
 	.run_btc = navi10_run_btc,
 	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
 	.set_power_source = smu_v11_0_set_power_source,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index d1018122e474..b83675227a6f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1903,7 +1903,7 @@ static uint32_t sienna_cichlid_get_max_power_limit(struct smu_context *smu) {
 	struct smu_table_context *table_context = &smu->smu_table;
 	powerplay_table = table_context->power_play_table;
 
-	max_power_limit = smu_get_pptable_power_limit(smu);
+	max_power_limit = sienna_cichlid_get_pptable_power_limit(smu);
 
 	if (!max_power_limit) {
 		// If we couldn't get the table limit, fall back on first-read value
@@ -2674,7 +2674,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
-	.get_pptable_power_limit = sienna_cichlid_get_pptable_power_limit,
 	.set_thermal_range = sienna_cichlid_set_thermal_range,
 	.get_max_power_limit = sienna_cichlid_get_max_power_limit,
 };
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
