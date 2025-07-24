Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E82DC83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 08:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71AF10E1EB;
	Thu, 24 Jul 2025 08:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qd97M2hL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0D910E1EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 08:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJW4Cqx3m1QwYBRj4dlcs92ypeZaZsWHQkJF627KEMgxgjieMrQCO/UYiB6TbDKcVK10yuQ3zRXE8CNz7mrU39O12ZnAZdIBlzUAhxabW2v6P82qF4ryiFZ6hd559qlif6vgsLussuC766vli0ERhrRc04R4Ct/IjvkeVyUj3MnGI53SaWJQKtbNG/Ht9KKEpqV32eEnq5AhYF/gP988qYWD0Q/FYsiZ+YqkMNv1Hij15hARhQotl8RTCqzu8RL1+fmF45SwKgQSNE6RV5knVtvcKGvvaacLTInseVokSxP+1Oe7wBuDWohxgxLkaMARn8J0lAN79L3UZ6/MqC2S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0GUcB24yqJV7f+rELz78yRTMo3dCdEPVodKgVHL0oU=;
 b=EKIf/zOJTJOQEx94TEOXQnSo7IF4smNfsnq5IggSSzrIdNIVunKTYXFH6aDV6ZY3oxHz5Ee0GNEqrQrYH99rG3I8yNwlU4r5WfoszkWoxtRY3kc8wq9e1KLGEB2jl8cTpVPDnKu4bGJX//FBeL/rssgT7O6kh9/pcEyBdLhJ/+LfNsw3ZmvoajAX4AhJ6olaw1YYzJvJ+W8AKX8z/OE2BEolKCrtuuHw2HEv2+WNThJLngkhxWDP97PkYfF5cxAma2jZpCuG043TuxCNU5GqWxfE+5tAMx4HyPNtc2V/eu1Em/lLgATVLYsWhP5RjHe+/xoTowBDEpB3xmCMzvtOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0GUcB24yqJV7f+rELz78yRTMo3dCdEPVodKgVHL0oU=;
 b=Qd97M2hL/eyzKfXw+6HU+Wu/tpNHwRqEEZVg5iqVGZwruZ+AQ5ywyBAf0Q8gOH97UqI85blAsMQQtYOdjYr9zJdHp98cRAYsIsMM72EC+ehbuucHuRpcjNKb08CYluphycf0po0kNMn+CfJtPFJ/XQZ+con45x17ljbeDC1FzRQ=
Received: from BN9PR03CA0168.namprd03.prod.outlook.com (2603:10b6:408:f4::23)
 by CH1PR12MB9720.namprd12.prod.outlook.com (2603:10b6:610:2b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:57:06 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::d) by BN9PR03CA0168.outlook.office365.com
 (2603:10b6:408:f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 08:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 08:57:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 03:56:20 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
Date: Thu, 24 Jul 2025 14:26:03 +0530
Message-ID: <20250724085603.1611802-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CH1PR12MB9720:EE_
X-MS-Office365-Filtering-Correlation-Id: a80f1366-6308-43b4-04e1-08ddca9010f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6uZBORrdHpdN1R/NIHTMSILgDe5ZCAjnNC6baQko6XZZMRzTzOPPBNezcMAO?=
 =?us-ascii?Q?LZF9Rhju2OUkl9hYXwuxFp8Y3Fh9n/S+Xs8AlDBR1lC6/PjBcH7V6xMoKEA7?=
 =?us-ascii?Q?DzJZh253/MidmSrD8wFPiOjzDgQlRHvxiMD7Dt1QlI9JK97LGibbFlgqZ8cy?=
 =?us-ascii?Q?m9031GIxQywd8qlQT+WvEPbbguZhJR8wMvEAi2HwW359sopjVjQZ5BWtWBJv?=
 =?us-ascii?Q?cX+6JUGaiZRgJmYJKrf19IgyJRtk7j7zjdurdmgVay35fJo+e/wv5B26rytE?=
 =?us-ascii?Q?6uzKtaRoSsXr31nzv2uQQEJsk2tPLpaLBv6kH0Mr950WKlSgMvqCmECAyWQm?=
 =?us-ascii?Q?Y71bTKp7gP8NNNO9ZQAyBgL2RSS9v6Tr8qMYSD9cuarEq6xkLgzfD+CyJKcv?=
 =?us-ascii?Q?CwXkWuxfyggM8Ylgc1ugoxFU5yWfW4wUL3ftl/gXS+JNl8/HJ3sc+tKs6KTf?=
 =?us-ascii?Q?MDGIz+B8f9mfe5dIdbUzz3PlXMwX1lgJuq0v5aje2MSHVyvzWWsdWjwCkmky?=
 =?us-ascii?Q?V7Sqb0ekmDQQ6WMiyJWiHfK+zsctdqeqd6mHY+WRnwq8uUppPGYKMO3zArf0?=
 =?us-ascii?Q?0QhOU6qV8syZK2tGbvMagW1k3ZiGTBbjMG6tvetR+BpDrZwD7+kURdQOBtz7?=
 =?us-ascii?Q?h9yxBpW8Mj5S4eAa60qpdlwEtHJ6I0yPpAwKlUfj8EERc3zAD+foWO2U5JEG?=
 =?us-ascii?Q?WzQvDLC9r0oEinmWrSajsHqie+yVbQrTPzEIpcksnw8/IITuxpwgY6iVd63N?=
 =?us-ascii?Q?dhR/lKUBGSzVFqez8+jvLVF1fH8xXoi22RtZOqS792GQQ2LzHIfjd4HMKuNM?=
 =?us-ascii?Q?YIZYRxWQDyjCB2F6uUqjcZ6uOJ1/Kph45+ut7coZ2/nxXr7qpQg6OqMsMuN6?=
 =?us-ascii?Q?UT+EIMTfsvJudvSqnxS7Rt3er/wJoOZ+nKxlWG/NW7peaNvIhHWdZNIlXP0t?=
 =?us-ascii?Q?6IIc5kLS83BKhA/xdaOhgdac1+EDWdCtgrkGBG0rs75lsCRbVS46E44tSFB4?=
 =?us-ascii?Q?FTLKWKfTKKc8MueWmmHI3qzGmMMjt16yUueBacIiekeW7hdraOUAh5LItDOx?=
 =?us-ascii?Q?GEOC5bARp/pGQ8RoNVLmqp49vZcf0NzAevkRaEIASuYUFpQz0PrIz8uIn3Y9?=
 =?us-ascii?Q?YJHR7OwYSgOh07faWoJrfEO3jbH22P1Yxa+SAdrfovm9qkZQgeVogncfr/8z?=
 =?us-ascii?Q?/C4B/9EyCcA+tvhttDBE8ts3Z0NeF3vn7+OT4UhvLsnb6o0RegfzGzyak8+Y?=
 =?us-ascii?Q?N5f4thWEaxi4BRcc2VLYLogPDxVDi0POYqBkOaLbUZuoAaKIRxRPh7BqCm0f?=
 =?us-ascii?Q?f8OkA4Ux90KTFi/ykQo2l/clSkU4GYTiXqTB0uR+bn5gcgL+oC12Jyu0qcqH?=
 =?us-ascii?Q?zkLbqulZPgh3t83ZG+UlHnDL/Bo5AHJ7/ZXjonWoVuurg0NKbnZRAPO0Wi6J?=
 =?us-ascii?Q?wu2KGJei018tGVttei2Z3WulHMOABlYzp6Lp3wGc23jjvQjholuji9wtgrB9?=
 =?us-ascii?Q?nPoO+u7Irtt02yRQdiVrZbKB7qo2RDB5mWWd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:57:06.4650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a80f1366-6308-43b4-04e1-08ddca9010f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9720
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

Certain messages will processed with high priority by PMFW even if it
hasn't responded to a previous message. Send the priority message
regardless of the success/fail status of the previous message. Add
support on SMUv13.0.6 and SMUv13.0.12

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 14 +++++++++-----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index d7a9e41820fa..aaf148591a98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -469,6 +469,7 @@ enum smu_feature_mask {
 /* Message category flags */
 #define SMU_MSG_VF_FLAG			(1U << 0)
 #define SMU_MSG_RAS_PRI			(1U << 1)
+#define SMU_MSG_HI_PRI			(1U << 2)
 
 /* Firmware capability flags */
 #define SMU_FW_CAP_RAS_PRI		(1U << 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 02a455a31c25..17e0303f603b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -106,7 +106,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
 	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
-	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			SMU_MSG_RAS_PRI),
+	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
 	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
 	MSG_MAP(DramLogSetDramAddrLow,		     PPSMC_MSG_DramLogSetDramAddrLow,		0),
 	MSG_MAP(DramLogSetDramSize,		     PPSMC_MSG_DramLogSetDramSize,		0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..c22b3f646355 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -145,7 +145,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
 	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
-	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			SMU_MSG_RAS_PRI),
+	MSG_MAP(GfxDeviceDriverReset,		     PPSMC_MSG_GfxDriverReset,			SMU_MSG_RAS_PRI | SMU_MSG_HI_PRI),
 	MSG_MAP(DramLogSetDramAddrHigh,		     PPSMC_MSG_DramLogSetDramAddrHigh,		0),
 	MSG_MAP(DramLogSetDramAddrLow,		     PPSMC_MSG_DramLogSetDramAddrLow,		0),
 	MSG_MAP(DramLogSetDramSize,		     PPSMC_MSG_DramLogSetDramSize,		0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 59f9abd0f7b8..f1f5cd8c2cd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -256,11 +256,12 @@ static int __smu_cmn_ras_filter_msg(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t flags, resp;
-	bool fed_status;
+	bool fed_status, pri;
 
 	flags = __smu_cmn_get_msg_flags(smu, msg);
 	*poll = true;
 
+	pri = !!(flags & SMU_MSG_HI_PRI);
 	/* When there is RAS fatal error, FW won't process non-RAS priority
 	 * messages. Don't allow any messages other than RAS priority messages.
 	 */
@@ -272,15 +273,18 @@ static int __smu_cmn_ras_filter_msg(struct smu_context *smu,
 				smu_get_message_name(smu, msg));
 			return -EACCES;
 		}
+	}
 
+	if (pri || fed_status) {
 		/* FW will ignore non-priority messages when a RAS fatal error
-		 * is detected. Hence it is possible that a previous message
-		 * wouldn't have got response. Allow to continue without polling
-		 * for response status for priority messages.
+		 * or reset condition is detected. Hence it is possible that a
+		 * previous message wouldn't have got response. Allow to
+		 * continue without polling for response status for priority
+		 * messages.
 		 */
 		resp = RREG32(smu->resp_reg);
 		dev_dbg(adev->dev,
-			"Sending RAS priority message %s response status: %x",
+			"Sending priority message %s response status: %x",
 			smu_get_message_name(smu, msg), resp);
 		if (resp == 0)
 			*poll = false;
-- 
2.49.0

