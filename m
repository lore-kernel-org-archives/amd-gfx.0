Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BB5CD612C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF8F10E2A6;
	Mon,  9 Oct 2023 18:34:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9F610E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/iHRpZrytNLp5RIO4DaNrDzatcIcH3AtEnfFg2gDS1iPGJvY6ajm9Px4BJurPMiIflwx4A+ymLhBHww53lX/QdkiUAm3crwln2nEMuAMgI2gdFp9H3R0DSLmBuVd5hfFvhHHjPE8pQG2LCHFXz1Yank9Wd9ncJxPJU4cjaS9BwtbZON867Y4e2rUFvHvL50lL4ihOAInB0xpxrlgRUWh6t9lLcD5aIJjYmBRALe+38P4xx/x0gXCNz/xF9Yluc5hmHrnGQdfDInjhNIXcMWFVrom6ZjWCeeidcJ6A087cBtmUAPSuJoNY/vFwHh7es43MzLHUyK8U5lZMFCOBkx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMCbb7/iOnOA0dbn5uGqDqHyrn0UdomrEBAbMUGChCQ=;
 b=erRKJnAmauo1fCphSFK1JpDo3tIC8CQ5Wh9Ztq7dVAHwsW19fXhT9wHapcHSV3XMkM/zIpDmnxnX/ybgILX+Ah+JCwbhDxMPuWgpks/TVMZJRxlKiCVNA0RT8Pds+zzlnFPJvLYlkLtlE/K3hpAy7DSsXesmszjhyzaDY7zpybGnprpGxomMK3GU6BE/DGd8iPMEXbgZNx3brcVgqHXK5WtEAEK2CwigpUt3TJq/z/+Z9DHoVEiCNySacxnWe/q80BbOT+ORXURhdDH4V4yjLURRpGDfmIMxUyfjRTMjwVfvTmuzxVusS1c7eYeqdAIS6t0eU2NGDPnB0yxOsvutQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMCbb7/iOnOA0dbn5uGqDqHyrn0UdomrEBAbMUGChCQ=;
 b=ggf06m48c6iNbRhAtlMBMQ8s4I4hVGCnHE3XzbD/qOxpk4FYXRQCy+i2z/kS/6OKK1lj9shtWUee/pDYCKnG5O2Cm+1BL67D7080/U6d4e9D6lrXkvtb5TTtanZ7LP3wqcGUFYLznhy2WflHdPo22TaEjr95eytuHUxk3/gTI0U=
Received: from CY8PR11CA0044.namprd11.prod.outlook.com (2603:10b6:930:4a::9)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 18:34:20 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::23) by CY8PR11CA0044.outlook.office365.com
 (2603:10b6:930:4a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 18:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 18:34:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:34:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add power up/down UMSCH ppt callback
Date: Mon, 9 Oct 2023 14:34:01 -0400
Message-ID: <20231009183402.518574-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183402.518574-1-alexander.deucher@amd.com>
References: <20231009183402.518574-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca33538-caf4-47a9-df80-08dbc8f659de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtXisIIlfrD3Za5lhPOHSO87JReCNEHCpDlfQ7h8KpGOcoRtE467/N7wEcq8DWg2BuDaQ9BIOYWNjMf2tHmRgaPpCA1mRmhz8176o8XQK4dcVavtNgnKEzDHqDdnsrhbCilqlZVCVoGaxMDebLs6VmitSd88nhUufi/oSc0xwFTo1GuzJm/+uGBv6QIxqKk44DcVlf+Y3mMzIZTT1R3L8f3kE7ZUFD5qOLuN1HivgkiURrbzQFkD7DmE89E4CGLfAqZbSh/X8T/2E4GK4Kjg6QpthT47M6Txq9Y0/qPERxo1+e86apfd3JPD/w3UDMDigqEBicIEa5umqPYs+vZ7msoI1f6yZe2lGz1XhUEesw0fEGHa4lwi6ZW52bvhuYe5PNqEeOQ3CF4S63FONVlMzpQFzKxUKtzISNgD1S2E2Tf2gVcHEi3bq4N0LbywakkCU+ldir3VBrfGy0lemAduTCyFn2Yz2/wIr4EKMfC0WtjDaJaluUeM675g1h8AsQokGfVcjJ0XmRAX3/DPdSZGWWxzy6AMbPodPXXZ0MVzpMW+n906MB6NT27ljNkKLOGr2sbVwwiCk4gqKryWfdENNcGjJb2SRRyggd9TrBildvbhshiJnM6nroP+U6ysAxf4Q+euM/4Of7NEn2L00gpKJQjEDKAVK4y2ZGR2pgqLl9y4HGlZ/++dauDg+4kndxvztOICuCa9Cqf2lx55IxEQCXVnv1xxR573FZY6vz33J1b6NC0bcDE2OHKDOIm+VBRa22EDOvYrKhvJHNB+GysWTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(7696005)(2616005)(1076003)(40460700003)(82740400003)(36756003)(86362001)(40480700001)(81166007)(356005)(36860700001)(83380400001)(336012)(2906002)(47076005)(426003)(41300700001)(478600001)(316002)(26005)(8676002)(8936002)(4326008)(16526019)(5660300002)(70586007)(54906003)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:34:19.7251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca33538-caf4-47a9-df80-08dbc8f659de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add ppt callback to power up/down UMSCH.

v2: squash in updates (Alex)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h       |  6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h        |  6 +++++-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c    | 13 +++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index c8cd4e3a3d3b..190a2ce38ac1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1350,6 +1350,12 @@ struct pptable_funcs {
 	 *                       management.
 	 */
 	int (*dpm_set_vpe_enable)(struct smu_context *smu, bool enable);
+
+	/**
+	 * @dpm_set_umsch_mm_enable: Enable/disable UMSCH engine dynamic power
+	 *                       management.
+	 */
+	int (*dpm_set_umsch_mm_enable)(struct smu_context *smu, bool enable);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 3958c9cb4e91..098267ec0a83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -255,7 +255,11 @@
 	__SMU_DUMMY_MAP(McaBankCeDumpDW),	\
 	__SMU_DUMMY_MAP(SelectPLPDMode),	\
 	__SMU_DUMMY_MAP(PowerUpVpe),	\
-	__SMU_DUMMY_MAP(PowerDownVpe),
+	__SMU_DUMMY_MAP(PowerDownVpe), \
+	__SMU_DUMMY_MAP(PowerUpUmsch),	\
+	__SMU_DUMMY_MAP(PowerDownUmsch),	\
+	__SMU_DUMMY_MAP(SetSoftMaxVpe),	\
+	__SMU_DUMMY_MAP(SetSoftMinVpe),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 5db29fcf699d..eb613687513a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -104,6 +104,10 @@ static struct cmn2asic_msg_mapping smu_v14_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,		1),
 	MSG_MAP(PowerUpVpe,        				PPSMC_MSG_PowerUpVpe,		1),
 	MSG_MAP(PowerDownVpe,        			PPSMC_MSG_PowerDownVpe,		1),
+	MSG_MAP(PowerUpUmsch,        			PPSMC_MSG_PowerUpUmsch,		1),
+	MSG_MAP(PowerDownUmsch,        			PPSMC_MSG_PowerDownUmsch,	1),
+	MSG_MAP(SetSoftMaxVpe,        			PPSMC_MSG_SetSoftMaxVpe,		1),
+	MSG_MAP(SetSoftMinVpe,        			PPSMC_MSG_SetSoftMinVpe,	1),
 };
 
 static struct cmn2asic_mapping smu_v14_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -1025,6 +1029,14 @@ static int smu_v14_0_0_set_vpe_enable(struct smu_context *smu,
 					       0, NULL);
 }
 
+static int smu_v14_0_0_set_umsch_mm_enable(struct smu_context *smu,
+			      bool enable)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, enable ?
+					       SMU_MSG_PowerUpUmsch : SMU_MSG_PowerDownUmsch,
+					       0, NULL);
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_v14_0_check_fw_version,
@@ -1054,6 +1066,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.set_fine_grain_gfx_freq_parameters = smu_v14_0_0_set_fine_grain_gfx_freq_parameters,
 	.set_gfx_power_up_by_imu = smu_v14_0_set_gfx_power_up_by_imu,
 	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
+	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
 };
 
 static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
-- 
2.41.0

