Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12CAC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4832410E17E;
	Tue, 15 Jul 2025 06:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I+Sh6NpH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C1C10E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft2w73BHQmuobtymV89XyXL0tR2JpVfLDG0tEjceDQJDODTQgAhQS69qlFpDOWpbTDjqn3nRir3WoHFRMV1QSc8NfMDHKfMnLUNTLz088seLmJ5eW7f9+jO8ETP4nVwv9GgKjsKRXKfu2GVSdqmx2KlIvVHMOsTwHMNBrziaM4pfQlj/qRpoOK1WgHhxYproaY4Ws6m2s+c4sJkXIgvm9ZAfkOW3TglyRRtOcTFLuRO9Itss+P1WMKbt1mtVUkz3GXHZq54L1vYVFsuHam4bhb3JyJNGl9wdBcBFa/xim4Fnh055JGqgHFQ7WYXjFw3M5NktXWate0AZf5suBqeGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpLSMtGUSnNMHF4m2I2ZWj357nE/76AFr6FH9EccVCA=;
 b=pNA5HfNE7fFf8tMyc+4OETmoRS3bnY6gS+nKMLcRuikMfrTUWI9Fu1Yj5O7Llpe6Za41oiRt0XmEA7wS03JhjuOtM1RujLOtDLFPkHBjaod+MPelh0NKOmOPOQFFGxJk4Q28TXzMeAxbem85CK9n8tcGhvncrhnAw8G344He+Tzhxth8SdBbGI3q6FSEAKYXRjI5tGBmAYUAV24NtPnwFwu4VbzKNfj/TTTDxIk4m9/4bxALItsd+njnv911W3Lpnm+e04U/8aYy0+j3uO/NUZ+05r56Uxe4ieEyrAl6FlxEkXKelVmma2G/Mu+F9g/jxD0hdrRbubVRJuxEBcTrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpLSMtGUSnNMHF4m2I2ZWj357nE/76AFr6FH9EccVCA=;
 b=I+Sh6NpHa06w/GLSnxvoaBmj6SQ1CJxgZP0JtbZZPAMP6rW/jrlN3Ovu4yb7WhtfhL+PsLwwV4OS6fQAmgyahn8Df3NTysdbIzophiDM+dNimDeqjshr2iTJwboM6mzGvXuAfxjjySVTlXm6Fp81Jb1hBME/6wkKEacsN2u57B8=
Received: from CH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::29)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.23; Tue, 15 Jul 2025 06:52:57 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::1d) by CH5P220CA0006.outlook.office365.com
 (2603:10b6:610:1ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 06:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:52:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:52:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:52:56 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:52:52 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 01/10] drm/amd/display: [FW Promotion] Release 0.1.18.0
Date: Tue, 15 Jul 2025 14:49:25 +0800
Message-ID: <20250715065233.160043-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee498b9-89ad-473b-1ed1-08ddc36c3b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qbOssghyX18BaNCeUzd4BX6iDb/roBYoogiTcbTPdwcaVcsEop/6HCAEk5lW?=
 =?us-ascii?Q?WViZvZv1cUKN7EUCl04HURLt3Ai1jGXVcUstg7sqB/ooW2WwcHp1GB07Jlo5?=
 =?us-ascii?Q?T+wgfwtT8KRIgmYxc/YK2LWO960Qe6nWgU7+K6jVHpybP8J7tw/tZAlHfRdF?=
 =?us-ascii?Q?U6cwqF8o8VQZ2dSrJQBsivBmhe+lQ2HGLL+p1jW00Bmh7AoRJsI2rd8zTYl7?=
 =?us-ascii?Q?fwt8+m1mdkTSntgYCCNnKR1QbYUE7H0Pk9UcKfszu77mWUExWjITPqzvKozj?=
 =?us-ascii?Q?L0VpnxCphq+IfLV6jay/wcIyJXtxNSWGDWlOwowgv56dwhJMoyFTn9W+zoI1?=
 =?us-ascii?Q?rU1FUyPTq0DhpWQ7EtugdVnSULnGi+aVihHACLw/nk5QQCxeyZTuxGygHHGf?=
 =?us-ascii?Q?U2O2COs3fXDk4WUKr97fHgYquk19yDavj35mR8gClkpun+Ypj6343h4psonp?=
 =?us-ascii?Q?uqM/ETgyFfT/Al6WbeyrjXqJmsWXz+u1oEdn/8auwtZupG3XG7Qsrv928Swu?=
 =?us-ascii?Q?VYpBKaVolpr5QWF6p1Vd17TWJfQt3MHLaQn0KJ4VWuBve3FJBEe/XsyRmaF6?=
 =?us-ascii?Q?Pl6/EnRruAaOD1odsizgfPrVJc630kWm3RfHaa16ccMd09uvWzZRrlUuy4hW?=
 =?us-ascii?Q?/Jisat/4D4FMCF3Of9BlVGvD+FDxRXDEcbhNrHwV7eL7c3RIee92SPQNsoRo?=
 =?us-ascii?Q?0cXiSliaLLd480nMlLpeJW7T0F090+GPABsv9PjwurosQ3vkgxDwdR1rHk9o?=
 =?us-ascii?Q?92plfGcFDDVInogNlkX0e5ZqmGR4/Ec80bAcw/7rs9oJAggMHfgBcx9T/Tpi?=
 =?us-ascii?Q?WSJk4etR5x5BLUfPDdOACRWQFjjVBzcdlGeV1wW7uxu3WP09Ob2FS55NQ5ol?=
 =?us-ascii?Q?iBVbAZqV+BXhwU2nayydNxNXezrYwTmt7Js8F+mvl470TMk060Rg6d5IxHFP?=
 =?us-ascii?Q?6cjwwFVmPhQgCRv6MFGAiC0+LIrAVXGhVShcrcOx225C5CXwkNyBOm2HYpmm?=
 =?us-ascii?Q?pYwHkyGjBnLeocLvbPFGvOfv1G4WGZrXqwJHeUcgxMtW9c2vd13xjcI3BrDZ?=
 =?us-ascii?Q?lFpXZCskvtPgfgI8zlAN4+Wl2Mra17E5MsZVlHbA3MHit6uvFacO/wmwbt+s?=
 =?us-ascii?Q?fILvbfFKc4qOSkYU52zmObRqxFNzLJ9246FNOgildkDTXD7nF/VdrXdjLEyY?=
 =?us-ascii?Q?6h2j56QU1b9CZcONcbxRFmQRYcLUQpTVqHDtt376IJTvaeHue7Sw1wi773B/?=
 =?us-ascii?Q?FUsYOLVIiMAojWjHAmQyPVpELAUK8qYjdguOvncAuJXUNleLOXUC8LpNx4bG?=
 =?us-ascii?Q?A6HZtY6M5NqbLoFybV32QOg73yZYRpUiLaPhPE4EwwZscHxulzU2Cq3Sz/Yz?=
 =?us-ascii?Q?jv5pClSfSeVMiCHUp36H2+74f8OSpRolRjWShYMXe30P6r4/y2AnQNVZqion?=
 =?us-ascii?Q?Lh0f/4v7+UsPUkew7PwD9JRODPZDrP4MqViBZjfOoDTNlRR2MZIcEkJ2iyho?=
 =?us-ascii?Q?xM3dXrq4ctbRXZUM/hCn0mp4YpGlQn2lDRqDw+GSyUo/OGcsr/A9o7L/dA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:52:57.3047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee498b9-89ad-473b-1ed1-08ddc36c3b35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

Add new mode in struct ips_residency_mode

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c587b3441e07..686de58a0412 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -882,7 +882,7 @@ enum dmub_shared_state_feature_id {
 /**
  * struct dmub_shared_state_ips_fw - Firmware signals for IPS.
  */
- union dmub_shared_state_ips_fw_signals {
+union dmub_shared_state_ips_fw_signals {
 	struct {
 		uint32_t ips1_commit : 1;  /**< 1 if in IPS1 or IPS0 RCG */
 		uint32_t ips2_commit : 1; /**< 1 if in IPS2 */
@@ -897,7 +897,7 @@ enum dmub_shared_state_feature_id {
 /**
  * struct dmub_shared_state_ips_signals - Firmware signals for IPS.
  */
- union dmub_shared_state_ips_driver_signals {
+union dmub_shared_state_ips_driver_signals {
 	struct {
 		uint32_t allow_pg : 1; /**< 1 if PG is allowed */
 		uint32_t allow_ips1 : 1; /**< 1 is IPS1 is allowed */
@@ -4099,7 +4099,6 @@ struct dmub_cmd_replay_copy_settings_data {
 	 * Use for AUX-less ALPM LFPS wake operation
 	 */
 	struct dmub_alpm_auxless_data auxless_alpm_data;
-
 	/**
 	 * @pad: Align structure to 4 byte boundary.
 	 */
@@ -5914,6 +5913,7 @@ enum ips_residency_mode {
 	IPS_RESIDENCY__IPS2,
 	IPS_RESIDENCY__IPS1_RCG,
 	IPS_RESIDENCY__IPS1_ONO2_ON,
+	IPS_RESIDENCY__IPS1_Z8_RETENTION,
 };
 
 #define NUM_IPS_HISTOGRAM_BUCKETS 16
-- 
2.43.0

