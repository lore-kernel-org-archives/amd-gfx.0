Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3764BC4743E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED19E61249
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED19E61249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 249B46EA98;
	Tue,  8 Jun 2021 04:35:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D086EA97
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 04:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4H1gXz3IpFVXx7YQdzrtH2VOVsOK6w12HRRRjPkIug0yDJRANFNTTpMQGgS2P3UErm4jWXXoxluI8750EtNRKcZOuio/D9EE70STx8Dq/YG0I0YkEkHwa+DQuDvOiwd+cRM5TPMm2bnqtDQeR+f/RebjqUO7PRo05HtiqChRoklyg0LESq7/mFUh+8Bgo65fpZQNgu3EKVM8WFz31VKzKF4+j9wveGXVmbYj93os/YyAtBqxdUGzDPAwFFQ+HXOYT5+1EIuVr8BCTWwlM6ybxigeO3QhN6gkcdOe0MwJS3QdGSG2s8ILDGotTCGh65S7Tk4DIo3DJsU3/hzPCLYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWZ44ZqvFccioYaD2MFAIPI6K1OCwd7uC2lXMBUzA78=;
 b=PG9MUGb7DgGx9MNc5ELTvQBqUurFnrz3dpiYLk+M0Nqu+9sy13t2UVLg99BGk/z683d1wE0s8KIuL+z886gz5ov5OxyzccmadxnvSsxNXC8MEND6f86zKvJUoMSDUihn9UfMzeyt3LDFeEG9Je2CFYAUrMuPXwFX+CYnRVwaPOQ4y1FuotfPe2laz3VafPHVF1T/8/4FzFsfAzmVf4cdTYc7oqgslYoxtYc9/TNrkZf8V0zDFnhThtxwHbr459+K4v3Bj95xEZ1e5itn/F+Dvi1hFYUqFFGfcPBXiLioHhauENCNyTRdjKORIPLJuLRaV7/kiEcchLLTnCdZa1rYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWZ44ZqvFccioYaD2MFAIPI6K1OCwd7uC2lXMBUzA78=;
 b=h0sZhELmv3+rJyn6j0jC+fsVJy/Qf4rgRppCBfjqoZH4Us/K+/yVivlusubi8/3knbxc9uPlULRVLpazSlZratLpoEy+reeLQYMvo1IyCLA8uXoqcsfiLvWbixuvtDordDj4jK1iPrjDeN5b2VH+GHqwu/X8Hp9NnmNVVWHd9xQ=
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by BN6PR12MB1521.namprd12.prod.outlook.com (2603:10b6:405:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Tue, 8 Jun
 2021 04:34:55 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::e0) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Tue, 8 Jun 2021 04:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 04:34:54 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 23:34:52 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 2/5] drm/amd/pm: correct the runpm handling for BACO
 supported ASIC
Date: Tue, 8 Jun 2021 12:34:28 +0800
Message-ID: <20210608043431.1855151-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210608043431.1855151-1-evan.quan@amd.com>
References: <20210608043431.1855151-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1c83bf0-1e68-4f4a-ce2a-08d92a36c380
X-MS-TrafficTypeDiagnostic: BN6PR12MB1521:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1521AF2246A54FF2DFE020EBE4379@BN6PR12MB1521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5oBK/GOZgfSqqI/cdu3MCnFxrIG5ERYen3CIeF5aQUv+IBFUL+4j7++O29bRwKhPrIYU0s9yE1Gxfe2VmIsAdEU/PwaEyVh+sE7RiFkvxJBh1One/7UzvTj/e+d4lxHMUb1GkJ5hU97nj8yAbcGHHstwNSmV76P3bQctWdxwKwRBpRv1Th7BKdS274oA72w6KcR3UkLtHUQBrdkf0JEwxWAxytyG8rDqe15fy+dyl0j+dEUYTykRZ7M8B+/vSrPtdmxisw3BgGE7yLgyij8T/2+V6Q1Qyf0dYLpZkSubmMU3zzMdJVKFcBgzBBn2t6wd8zGox/0X4Znl8ry9iWZgRgCy2F0kGXm2tGGLMK8uZ0NA2pNochsJqDvuKjIPeynsMdTNJ7rTlEYsIpNrZnatGkzVN2QQvpaLwhgat6zktm4oNLV8Oq1qcuLIIHtBVPLgt6IwWijcU+Pl3Td62AJlfiBLPNbkA36dDaXLLxGfHhSASJVNwef/anorviierdZANfAOTzzQmKP2vp05O5YaNYEagGy92t4zSFCp9P4Ad4Wiql9M49aYdF9YOpN5/5sA4zN4k7oMwxJ/KL9bEL5K+AjqWqgtu/4iTkfLyiM6LZVTWDH60qhTijH+o1sa0rdAVa3PDwjkqjmYLPlZMq2aDRloX4vPzmBIgSg6eccfb40OMq3qqCBJdwwLPciKZC6K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(54906003)(81166007)(6916009)(82740400003)(8676002)(356005)(47076005)(70206006)(70586007)(44832011)(7696005)(6666004)(478600001)(426003)(26005)(5660300002)(36756003)(2906002)(186003)(16526019)(2616005)(82310400003)(86362001)(83380400001)(36860700001)(66574015)(1076003)(316002)(8936002)(4326008)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:34:54.5800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c83bf0-1e68-4f4a-ce2a-08d92a36c380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1521
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Via the fSMC_MSG_ArmD3 message, PMFW can properly act on the
Dstate change. Driver involvement for determining the timing for
BACO enter/exit is not needed.

Change-Id: Id9ab5e308ff1873888d0acd822c71b0a303fbb01
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - limit the changes for Navi1x and Sienna_Cichlid which support
    the fSMC_MSG_ArmD3 message
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 +++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 27 +++++++++++++++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 27 +++++++++++++++++--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 11 ++------
 4 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index a3b28979bc82..1962a5877191 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -244,6 +244,9 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 int smu_v11_0_baco_enter(struct smu_context *smu);
 int smu_v11_0_baco_exit(struct smu_context *smu);
 
+int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
+				      enum smu_v11_0_baco_seq baco_seq);
+
 int smu_v11_0_mode1_reset(struct smu_context *smu);
 
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 267fbbdbff94..038b5f3c87b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2243,6 +2243,29 @@ static int navi10_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
 	return 0;
 }
 
+static int navi10_baco_enter(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm)
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
+	else
+		return smu_v11_0_baco_enter(smu);
+}
+
+static int navi10_baco_exit(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm) {
+		/* Wait for PMFW handling for the Dstate change */
+		msleep(10);
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		return smu_v11_0_baco_exit(smu);
+	}
+}
+
 static int navi10_set_default_od_settings(struct smu_context *smu)
 {
 	OverDriveTable_t *od_table =
@@ -3081,8 +3104,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.baco_is_support = smu_v11_0_baco_is_support,
 	.baco_get_state = smu_v11_0_baco_get_state,
 	.baco_set_state = smu_v11_0_baco_set_state,
-	.baco_enter = smu_v11_0_baco_enter,
-	.baco_exit = smu_v11_0_baco_exit,
+	.baco_enter = navi10_baco_enter,
+	.baco_exit = navi10_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = navi10_set_default_od_settings,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a9e35c1255f9..9debeec1a85c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2109,6 +2109,29 @@ static int sienna_cichlid_run_btc(struct smu_context *smu)
 	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
 }
 
+static int sienna_cichlid_baco_enter(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm)
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
+	else
+		return smu_v11_0_baco_enter(smu);
+}
+
+static int sienna_cichlid_baco_exit(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm) {
+		/* Wait for PMFW handling for the Dstate change */
+		msleep(10);
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		return smu_v11_0_baco_exit(smu);
+	}
+}
+
 static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3884,8 +3907,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_is_support = smu_v11_0_baco_is_support,
 	.baco_get_state = smu_v11_0_baco_get_state,
 	.baco_set_state = smu_v11_0_baco_set_state,
-	.baco_enter = smu_v11_0_baco_enter,
-	.baco_exit = smu_v11_0_baco_exit,
+	.baco_enter = sienna_cichlid_baco_enter,
+	.baco_exit = sienna_cichlid_baco_exit,
 	.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
 	.mode1_reset = smu_v11_0_mode1_reset,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index e1e1c268f661..388c5cb5c647 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1474,7 +1474,8 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 	return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
 }
 
-static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v11_0_baco_seq baco_seq)
+int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
+				      enum smu_v11_0_baco_seq baco_seq)
 {
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
 }
@@ -1578,16 +1579,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 
 int smu_v11_0_baco_enter(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	/* Arcturus does not need this audio workaround */
-	if (adev->asic_type != CHIP_ARCTURUS) {
-		ret = smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
-		if (ret)
-			return ret;
-	}
-
 	ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
 	if (ret)
 		return ret;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
