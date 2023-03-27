Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982B5C761AF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 07:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F4D10E24C;
	Mon, 27 Mar 2023 07:25:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECFF10E24C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 07:25:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsxIhgk68nBcW6uQGew3wJw5cDFraK/kDkrL9UJoUGkkQ3cBN29VNUZrg6APJo6NdZGTiSwkvYUe9ixqiqK8Rh6jROmhIoJ3jWRvrqfIoq2N9ITKWnsMQTjupOzg/OPO9TI4T1xlbLFEo4UBsMSok0t8MM06086W3Pio3viks1fP+LfC5i8kgamzsPvG4ETvz72CgSY0F1Mu986ET+36kHD1UBc4FX6edb2RsAHyrsSrzzUadhiiRbZTAd5ToX1mAEzQmQWFr6ixZ+UAdF6PXw3i9Adt2tHkBWohXu2esRpyvmpR3JNY13iP0rW1MQ8Lm7wEYF59I5x5JTl0a2MYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCVUSv61KuptL0aLjHuC22QXA/yUSrEFe53Fqd3ZEaA=;
 b=GBQeBzSVc97Qw34C6uWnLKuzKSxlDugIqWBnZHthIgFC/PuwFJL00OANNx6XG/XmqcupeOLgnWFDI40UQyx9nnG42ZmFLp334+/knrOXAKGDPiNRQtZ+/sH0SL/sUFdRs8VUSCu6SEaNLM/+46M3R9JzGzMZOQ0vQRO/PsFAlLLXEZKwBKbJpNSWnmNYMc7zI6sHlhyc3ddyag3l0oLEOgnUWP5HsE3behgE+JasfjxQYvG0dez4xUWt3rjjvz9HK/qPgQK+9STTkEZTMKP7o6XzbnziNWuB/YtJ10Ah/0u+lA9Qe7NSZLDDZEwe2rBucHRe8atcpJQ179NCwLQTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCVUSv61KuptL0aLjHuC22QXA/yUSrEFe53Fqd3ZEaA=;
 b=xDrPymb5qbQpiqB2O5pFgBhS93ZFzets4oO8uMSdjuZbzhbY8JW+GWA0tNFaSp92bGkwB2jJxge2p4FF/7ibPUTI/60MYAtHpsLjo03Z/lB/7MUh0cSEfcwoCgkHyslvgmKEJoxlx1PYvRBBkBQ+Jp4uhl1pV/1PjMluj07ho+g=
Received: from MW4PR04CA0147.namprd04.prod.outlook.com (2603:10b6:303:84::32)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:25:07 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::dc) by MW4PR04CA0147.outlook.office365.com
 (2603:10b6:303:84::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 07:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 07:25:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 02:25:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 02:25:05 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 27 Mar 2023 02:25:03 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] drm/amd/pm: vangogh: support to send SMT enable message
Date: Mon, 27 Mar 2023 15:24:37 +0800
Message-ID: <20230327072437.580766-4-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327072437.580766-1-WenYou.Yang@amd.com>
References: <20230327072437.580766-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d907c43-5332-4878-1eaf-08db2e9463fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Qx4OOI8zKqmth9Swsi+zM8VK0/RJ9DP/1jZbivOvCtXG8uzbhPumzkmZQR3+eurd581oH9nkpZ2v40uNfQ8s5g8xs+OV1qXwz+Nk/gW0n01biAz5dvBoQRCC0MtKSHR/UQf4EBKwCdRGns/0Ixw4Gg12UvfsYwzSSw+tn/KM71A/A+feip2JfPTPJ4Su0VagI8BDXeL0gBF1N8X2UzPCKsREdngQtdPnlHw7wwHJKhCLIePTGsMMKk3jlUWI7+mfoyUZ/boUbTAvLibl9Dop93yak3WDXw3E6teQc3W198dgVTr31uvPTgxrzxbzVZ0uluoytvIUdxos8I8pJ4H0j2KqTiDnJGwqMhaRObMHj+92EDIqGB7J505dU+jEt49kHdT0rKUeD+F4lzROyXZX0qNrHCANVYKD+1+bDv2afbcibArtfjyhLwgP5yDJ7U2BkuTxaNTToTy+1jvFYxf7MIP97kHm3h0TBVujOLRw5OTANMtJOPAjq2WjY3bWJe7i4AtgA3O2xNUHC19O+bU/uGD8zsURgiLzc8CsA1pl7xoQ2xGeDqNMuLGbSp388KOJYiI3TVJ7iIfEPM3LhRR5Cs/8tBhb43BYcwf3Lk9s++RQDxZDzI6LRYLNnm+Ev0w61QPXw/JQEkM/ug8efTox7N9hWLKarnmL4w4cQ3MhreZVDd3dqJ9Sjyva71u8ZFe8Xu7IV0JOmzvflo3dyH5DdLjoENU03fHGRgDP/xMmVs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(15650500001)(426003)(47076005)(86362001)(186003)(40460700003)(2616005)(336012)(356005)(40480700001)(81166007)(36860700001)(82740400003)(8936002)(5660300002)(4326008)(8676002)(41300700001)(70206006)(36756003)(70586007)(82310400005)(26005)(110136005)(1076003)(316002)(6666004)(7696005)(54906003)(478600001)(6636002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:25:06.9155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d907c43-5332-4878-1eaf-08db2e9463fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, gpiccoli@igalia.com, kunliu13@amd.com,
 richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the support to send PPSMC_MSG_SetCClkSMTEnable(0x58) message
to pmfw for vangogh.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h              | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c          | 8 ++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..a6bfa1912c42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -111,7 +111,8 @@
 #define PPSMC_MSG_GetGfxOffStatus		       0x50
 #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
 #define PPSMC_MSG_LogGfxOffResidency		       0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_SetCClkSMTEnable		       0x58
+#define PPSMC_Message_Count                            0x59
 
 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..820812d910bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -245,7 +245,8 @@
 	__SMU_DUMMY_MAP(AllowGpo),	\
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
-	__SMU_DUMMY_MAP(GetMetricsTable),
+	__SMU_DUMMY_MAP(GetMetricsTable), \
+	__SMU_DUMMY_MAP(SetCClkSMTEnable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 7433dcaa16e0..68a2987e17c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
 	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
 	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
+	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -2428,6 +2429,12 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
 	return ret;
 }
 
+static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetCClkSMTEnable,
+					       enable ? 1 : 0, NULL);
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -2474,6 +2481,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_power_limit = vangogh_get_power_limit,
 	.set_power_limit = vangogh_set_power_limit,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
+	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.39.2

