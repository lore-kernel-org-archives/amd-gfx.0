Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F54C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 06:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432F810E24F;
	Thu, 31 Jul 2025 06:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dhyv1Mt9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FD410E24F
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 06:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq4tpqWOnaHYbc8pcZv+xkzPtdJ12cKHBv/IRv6rm3wKQ/3DunUUBxedI8FoufxhU3nPDybmTirDzh3YbceU+Dx8pVT4zXv9UYiPUl8N/EzeDEjKdLdhxY+8RFVhKEyaeEXgeTXfvg6Ut+JyA4TP7q5DqHQv/+Efnm9YrwnaSp5G/GHghof27i+paIGNbI1sAvOctjA4/vf8iFBdXg8Y+QJo92Owc/9GZ2QfLh7zPDfMS+qm0t6F2xsp9Qvea1GW9MV4rYHCUblCUEDCBeD7hDSd8t62YJcyTfVYOpLUwA/vEqCtFNldwxX+n5cIYzj2KdsCw5C1kO4Y+m1FsqUwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0GUcB24yqJV7f+rELz78yRTMo3dCdEPVodKgVHL0oU=;
 b=i/4gaqvxytkfiNaHjVIYPvswe8mq7GR1PR6RHS1ecL2EsUr/xlIWGL7XopNh/EZOMULgp3pGrHAyE9X5T9mIJoGoTU1e+4oar3sfwU3ggR/PKmOR/TUpOGM8eQgaUmY18JxgYcM3XJiBATQwvgD5Tm2bqe83dT+IvUhdQfS4FIl+u3g6dydWCtWSFcDBGxh4zkgFfpLxfQ16sOIH/YHg0GlY/4s/SPX9k7yucg1nmZ8gFMLEG52kn5rrsTVMAeBFgaW/I/cTNSkyq7te6nHj7xjZ1coRUxYKSN9riNMqkluHvhUR3MDkqUF2uw3xZ5AHAzwQ00uOMdJu/TWhKLRuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0GUcB24yqJV7f+rELz78yRTMo3dCdEPVodKgVHL0oU=;
 b=Dhyv1Mt9nAWbkKR2PF0+j9rt3Y/ALWivoTmdrfCaB3AvLlbRfbSYX2JKoUSPDEjRJwLO828FvcmsVaCMK3GT34SJ/3WdANWoJj5D/SapAbP4AAJIysniseei+mISi7sQ6A3vs64MqCkOEWxV8ETLtM45fvUlkp5wjxSZFwGRap8=
Received: from SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 31 Jul
 2025 06:09:49 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::a4) by SJ0PR03CA0166.outlook.office365.com
 (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Thu,
 31 Jul 2025 06:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 06:09:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 01:09:46 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Ce.Sun@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Add priority messages for SMU v13.0.6
Date: Thu, 31 Jul 2025 11:39:20 +0530
Message-ID: <20250731060920.1694915-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b90febb-7594-4e21-5d0b-08ddcff8db32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hc2bA1kwn0u5in29aOfKU0GjUtSjXxjlVYV8rYbmW6y3VTD0tww3HwyDHRw5?=
 =?us-ascii?Q?Ewij9CYv/n2LaEl4TZ3U3c6mUH0GvEurZT5fYGkZZxcJZPNHOnHeN4PHozk4?=
 =?us-ascii?Q?lmdQT5ah1ySjxEtBqYHlCjew4QUt9CaIU47bwtKTg2hJFKTlxQ866HmU5wat?=
 =?us-ascii?Q?G4R5ytBsyGx4+S7KVEBigm1a+l/4u1EECLARRslvywtc+ABS+lJiHJsBg2ju?=
 =?us-ascii?Q?sq9IIcDp/ie62M8qxjI18guo0DKLuPeHNv0BZi1Tuio93homZFI8XhjbRKZW?=
 =?us-ascii?Q?YeVD84mSDTqiA7TcYkeHZJ/1IEPcaXMSzo3p9tKDxKQcj3u7kmxLf8rePyAE?=
 =?us-ascii?Q?Imm58F9h9O77kAJJo/1LZ7bVDj+RCTNHIWmPsXhpFhK28lmxeQ6wK5tfpHWz?=
 =?us-ascii?Q?aVYtzFH9kpZuO7M6zs9UNusBxUo+kPd8YW1lkkYrWyPWyIQ7kukPC08z3yHf?=
 =?us-ascii?Q?Yjh14DI6ZmJmpeeouBIm8hIQIbb4lHF7TDZhESTFa7Sacy2owIEkKa3+kF5V?=
 =?us-ascii?Q?Yc1vGdtna0W53PCEoTGzSh7Xj419VaYQhpOMvBWcnfb4qgC2B4ZFnPr1e6rn?=
 =?us-ascii?Q?AQ63JsSuZ01y+30OayLvonfesP9P7fRylg7+07sBbtCojJTR4QP+R5vqdGCG?=
 =?us-ascii?Q?ygwXSmEdSHXsuXMujWTO8n1oqQzlVDThSkXbkt1nUXWZDQ829SQwbT+bMhZN?=
 =?us-ascii?Q?OWiHrbiedUT6UXoxZie59EMR0ZPN0Qxp8u1UJYawrTbnOQ6GAItYITf3MOpx?=
 =?us-ascii?Q?zqnetlGgp82MNGjb9BY3pZDK7o38k97a/knlfPs9iQgKW4vffKrC7zXQHC+t?=
 =?us-ascii?Q?mNheXq02cKQegesMbMcC2n8dUqGEle48442qIlHpZtHxRNoVZvAD9EMby7JM?=
 =?us-ascii?Q?OJHJ6s6qMgprrmFrzqNtE8MJ+kIuPfg1fSGjd1yf7qI6lA9XURh4kbSlmVAj?=
 =?us-ascii?Q?iPmrdhGh3c417qN/YKZcsv0PvhjhH0dUvpOahXhIzH5sa4+5JefL7Pku74Mq?=
 =?us-ascii?Q?PM+kNA0U/32XbrNmO4XLioZPObJwzpe1TeRkzbCDvj0zNvaGwjU2Iso/49OM?=
 =?us-ascii?Q?1FrobSUo0/RCUQzsi/GPFIArKFMrw74U4FTiDs+vsrSPE7YHx+AoedXaH1ih?=
 =?us-ascii?Q?bFnOW+pYIDFgtJddKOTYwLio4Jsdcf27PkZaro9BIw7BZSArrra+gDc97VIX?=
 =?us-ascii?Q?RkVGSvjOQ9JNW/96rzmfssRUlt787BnKo3WVx+dcjnwwpyuUjzpbxeGtWlqZ?=
 =?us-ascii?Q?M8fwNO8+6xG38ZlUW2R7WlWHAUvEdjGeRu79+FQVXm99/esfnVFdtxBBzK8k?=
 =?us-ascii?Q?s/Vq2SXjz4C+AmlVTNsCZKpBEHJzPxbqVazou4cZ+OXEeAYDUdU4eelbjM9u?=
 =?us-ascii?Q?rYow5j07ceGSdp+tTrdLnVb7iSF8eBrtWaQyQiGC48pwd8/kk7dMNKljDJgQ?=
 =?us-ascii?Q?zUweENB+YDfkXTIEdZIhqrr/Hb0ZjYC1E2ZABb3RyaM2A25XwpKqeoZNdCOG?=
 =?us-ascii?Q?ox2Cj8i8QT1tDZm4K4ZXhhHipbeyxevJFN5Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 06:09:49.1495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b90febb-7594-4e21-5d0b-08ddcff8db32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717
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

