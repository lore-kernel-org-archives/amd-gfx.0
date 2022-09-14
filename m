Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F94ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BCA10E822;
	Wed, 14 Sep 2022 03:57:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54BD10E822
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsqwpY90E4jVCw6Sv4Xko+3NtX6i0T2gwKPyDthehoLRLvlbkML0w50q1Nwd0OgUQfK7iTSzlYhcdtGPj5D6o+sN1SaFuEKLh+uhVK5T8NM1XPM+LZ7RZYftTS48FE56tjKWnaYR23DCCwWh9so7lUGdaenZ8A/OJd10yKzvsE2XKE4LqI0H2Swk43JVIapkX3zk5XNT/H/c8S6o5A+8xRmtRJu1dHE06BAzBfagMsL1f80VeWUJY130GRC+/XqgjO3gvs0bWCBOw14rjj7uFKofNXJiPcCFSJbjbMADTGWTCfSvPVaj3SYcZHSv3tLSNsdAsEgcLfjABB8lnZIODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Agz2kjnV0upFMGPyOl3LQMVNbYvt3lq4VsYSrOBARFU=;
 b=fCNDPzHaSPT1vA8ic9QELaNmqYzjNv319ZdOF5ejLPCceeH7OPu/y7Sm2WZKn1YdUsoQr9PeSCcr5PVs+La341awrRH/7CZatOOZ6e/ckPjsi+kslyBOQlCOde10oj72WCih3LMHSDexUIkcwJgV5XvRCbyloD/cEBXVsmEz7GA/4xEANEY6Us2XinBoKvS5EzEMCf07eHfXEjevTxYGJLEmKrAiLWTLapwTs+MUvxvbzh0Tn1qF5wjrt+WGpfS/Xl9S2ACcuI8S34AebZ7wD/+lS2ao8LpXNSYV3Uvlyw2mwm1oFdmYpf/QfzhptGFfU6VrI1Sr3kanWhs/QEGOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Agz2kjnV0upFMGPyOl3LQMVNbYvt3lq4VsYSrOBARFU=;
 b=oCV4IYvxa7Lm8E9ZyDPW9rNfwpoD+APmcP4MeOqcm9W4X7AI32bAcRYOwnOMt4GyP1U5qa5lQkAmHD8OrZ4Cod58S4O0bagqWFGTQDXgfwXFFTyBhJp34YTETEzslIytUAuxte1nD5/z2M3bn3FrhxNOWV/qnyVm3e2QMnkudfk=
Received: from BN8PR15CA0035.namprd15.prod.outlook.com (2603:10b6:408:c0::48)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:57:20 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::6e) by BN8PR15CA0035.outlook.office365.com
 (2603:10b6:408:c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:57:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:57:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:56:54 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:56:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 40/47] drm/amd/display: Revise Sink device string ID
Date: Wed, 14 Sep 2022 11:48:01 +0800
Message-ID: <20220914034808.1093521-41-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 7355a987-a25c-4bd7-3abd-08da9605394c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KA0J3Ci8cdJxUa8a+WfniPccPs4LzzA/34TNZjKaM9yPSUENJ1fOImLsQDfwMlgj08ARJp0ENR2Ed1x6SawVNSY2u+05dPmVGKEY4iJiJilt0IcbH6a1jIRvhH6GyCVmA6hjOZI6NLCzkUmkhnD3SAPiOpglbacm2NLOcSMcA/UGShauBhycggAi2JRMWdHiJzCN8fYlBD6eeCetuIY7NOWGPEG+U3z2IECREpVCnhgEJOaOmauLb1+MSyI7DHGpboh3szBvFhY/VuvfNL+on0AV+5t5XV/9BxrexCXH95uKScDE15xiBM8yGxOYzsVGeI9EIIwW/V/SH7olhIt1AdCcDtVzK1LCvfNXTlmTGAu7tKQnDtM7PSXGVD41vAm5AeEAszh7yInAMR53Zrc6SC+frTWQgGrg0/uaAGx5QWCbvgGUWX93WvEBiB+5+CAfL0ZyQq4wWIyimeUj3intr03aYpbtQHbHKgfvHF/e1VTyjs+/WcR7Sfgio841kR5whXKMYMLmc4eBHuXeuUJ4FIY315edarU+TAMCOwyUo8rkkymlfZpcEt+7NjLI4YAcLyBrFaawDwHudzPbrAB1+9InMiTCEaEVU1ZmaHatkiG0UBDpjEEqc8yrSYd67dd5HzU91oHDAhyYrsnY+uiljE4Mkbf8texjGyGs/gfxFA2Tmxy/tlg7zWbLsBkuHpoes37NVE/pes2h2PVhmy8lCGvELwvwh/NoB2iPdTAOgh8JKqRlNftto9lD0hB1u3mSQYRsM4ggSPxmh6zcRKfn1dkVqABLH85ONzSvPUnCs2k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(70586007)(81166007)(47076005)(36860700001)(1076003)(2906002)(4326008)(36756003)(7696005)(82310400005)(83380400001)(186003)(82740400003)(478600001)(6916009)(41300700001)(40480700001)(70206006)(336012)(8676002)(86362001)(40460700003)(54906003)(316002)(2616005)(26005)(6666004)(426003)(8936002)(356005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:57:20.6021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7355a987-a25c-4bd7-3abd-08da9605394c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Robin Chen <po-tchen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <po-tchen@amd.com>

[Why]
The Sink device string ID1/ID2 use 5 bytes instead of 6 bytes,
so the driver should compare the first 5 bytes only.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Robin Chen <po-tchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c           | 7 ++++---
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 0df06740ec39..bec5e9f787fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -393,17 +393,18 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	if (copy_settings_data->dsc_enable_status &&
 		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
 		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
-			sizeof(link->dpcd_caps.sink_dev_id_str)))
+			sizeof(DP_SINK_DEVICE_STR_ID_1)))
 		link->psr_settings.force_ffu_mode = 1;
 	else
 		link->psr_settings.force_ffu_mode = 0;
 	copy_settings_data->force_ffu_mode = link->psr_settings.force_ffu_mode;
 
 	if (link->fec_state == dc_link_fec_enabled &&
+		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
 		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
-			sizeof(link->dpcd_caps.sink_dev_id_str)) ||
+			sizeof(DP_SINK_DEVICE_STR_ID_1)) ||
 		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_2,
-			sizeof(link->dpcd_caps.sink_dev_id_str))))
+			sizeof(DP_SINK_DEVICE_STR_ID_2))))
 		copy_settings_data->debug.bitfields.force_wakeup_by_tps3 = 1;
 	else
 		copy_settings_data->debug.bitfields.force_wakeup_by_tps3 = 0;
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 05096c644a60..a7ba5bd8dc16 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -128,8 +128,8 @@ struct av_sync_data {
 	uint8_t aud_del_ins3;/* DPCD 0002Dh */
 };
 
-static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
-static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
+static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
+static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
 
 static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
 
-- 
2.37.3

