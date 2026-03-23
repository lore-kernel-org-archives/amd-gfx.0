Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CF9D58CBB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 01:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D3510E294;
	Mon, 23 Mar 2026 01:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFQ8vTRJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD4410E294
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 01:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/R9MpkO04u3lMk85BszhSUz8HnZeAvw4CIvO5CmZyBwVoVtI8yW05OyM+JoPobSSi29Ga+Ymj/SH4w6y4IUxZ/m7QFDw/Uh6rJPykVawbWl8MPnzM3Q3LI5cHvqrsW+Hnw12XtZ7Ywv2gdzw07Csc+R+rN6E/fBkrgpfzWJF/mU+G5o2daJbKpyPyUDU5VVEALgf1OnoHe8/uZ5ZTglhe/5fk7MSMBVUEatum1L+eACBq8KzmsRDDDP+Ttzh++sX5Be+72Zcpq9wQQvyeTUpa41l45IDCkUqToKOJMzRTbBjI+UDUCOjWhitCR9JpW2QdejMAcS3+YtSfNxx0+kqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLtZSp/KJUjv0toov7KCQd4BGDzWDt2/YnRY78i+iCE=;
 b=fr6BoDG9w9N0nrRbmde8zDQdqGE9DQzc0Xbz4FwhrHdRBdDrfhDa7dMBiVFprlU5Ap0xbXYlhEj0cb+lArB6pUanckgqghjDP+F5k9oWaSRHDoADmIUqszgZKuGS1EVQI62calaQyyuqClFRaw9mUmK4PSxBopIesmySkjDW666v1QzNwGDVHAv1LfMo9+HrrqqEAFnsH98z3k6i1HZTYkVC3yo2IUdtU42trL2bIocIDDA3jdhXRnJzvNbYTVn9Z9M6pD3osTnY3jfg95YwuCqmSs61SoDblYG/ZQFZvGp+ASBbJ9FFWCWE62F/9oJF3nY+owEvC5gNvQUMz4SqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLtZSp/KJUjv0toov7KCQd4BGDzWDt2/YnRY78i+iCE=;
 b=QFQ8vTRJU/i0tkTzI+hxEPPpVsryaHK6qfDHziWhswLTvdOxHCBAvA3rNDa6W/HqFqAT3IA/WrD+u6a2IIxImL1+gEGIk8YZ5yTnF/90vvwZvNPN7pMivBZRP7tzQ3uBeBYBuFprdZWDPOPS6vi1myGjAHraWJCtMSVPpurvPEo=
Received: from BL1PR13CA0082.namprd13.prod.outlook.com (2603:10b6:208:2b8::27)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 01:57:47 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::86) by BL1PR13CA0082.outlook.office365.com
 (2603:10b6:208:2b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 01:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 01:57:46 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 22 Mar
 2026 20:57:44 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <asad.kamal@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: add dedicated dram addr msg for smu v15
Date: Sun, 22 Mar 2026 21:57:32 -0400
Message-ID: <20260323015732.564251-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e3c5f7-9eb5-48a2-8129-08de887f947a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: s7k/6CDUyYqn+og6jr2IDPaaZcVMkvmILNYle0YpJXDKvyzdtEyGK14WdWCQ3vEPFF3qCzn3x0DmM9OGPIUQCT7T1ViC3OEzijsZwdvtmcpiYPeOrbsXnUiaHXnIgiDxgavcyBUYYpIMATsLIYk5BRO161ngUKhsUYVv5XlZgN92t2GCnwvn440Yf/KQTaVqOOaqhSomRctB6p/O9jNCIvIBoYaW941k0bqKXcvcw24TeoZFHEDc642iJg2iJRnyvcBOs+z17/aVsztU1fOkeX/5VSlRGKeXwtMSu1JKZgvus7BjZoQZGwESCh+vr5BfmVDMcfqFLitqCYVuhWA8p12eOFlOZ0beSgApH09LP+f5f6spLS6ESihj0/ZFYmqcNIrUZ89dm/qxotm1i83SGMzXUO3zBKT5odTrDtXokCM9GbnsRepoLAt55tH2dXhlG8rwc2N8yrRU5XKJyNz2ndZPasH0X4yQqRKLTCl7pWfHZnjmMgMZMP8KNECgLShnvaE4bB2PUxyu4iB5aPfxAwQ6L6qsgCjMMmgzhKEz4aeRe4GxPkwdhUrR2hdGFkIJZsjHMPXReWeq25+ROL56v+IuxTFcsHAj0jbiqrr3HeNEnMb42xm+kvRt/QUe9mHlp0hx4sc/oLBgTG5R3krJXKHv1iQXw4BKCd6jlfgb4EqHb0EP8s3jvIOufFE7OLga4fsvxeVFe7RLDlVyee6ttWMjcG4yjcnpa0liS0I+kodqpmphp+Cb8nbOBS42MjKoSYx11g6BVRwgIUnlHprHVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RhKgDUv1UTeawiaYXnadbwB5s+8EFqCo6GDCTSmx4IQfp0BsOgJoBXzo5tD74Y2KMhqRr8KxDdhf68BxB/v4XpJFMfBCOGlHg3e46LWUBLnH7VbkXzPNy6zL7662cJccedqGa1EIvUjjiOKDtaSeUcUv1eGI89PHY7oNI1gcsxFf0LwNMwoHd39tfTvOJHgpqMtbg1bSRLsiLQSwjIoYcrL3LJlqWFDXlVcb00Mg6a3usulDvb28L9qLblkB7vAQDuWbWgCbTQTpUiizFPNZ2ace0i/D3Q8MZQgzla20V+SAObGKQglSVXkdVnBMTBAt6kMFsq6Ecp6hF13X8zWo1Y7LjX5hsmAro38XO/9A8i9GDVSZrLhJ/9TprvegHzImGbvhiVwTTety0hLGzHQcpkkyMz8j2Q1SSKVMdOq6M/k7eU5bL8+6ZdtZTs2FnS2Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:57:46.6033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e3c5f7-9eb5-48a2-8129-08de887f947a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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

Add dedicated SMU Dram MSG mapping to avoid conflicts
in SMU IP v15 common code for upcoming ASICs.

add new smu msg:
- SMU_MSG_SetDriverDramAddr
- SMU_MSG_SetToolsDramAddr

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h         | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c       | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index fc31cc5e97c8..636ff90923d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -42,8 +42,10 @@
        __SMU_DUMMY_MAP(SetPptLimit),                  \
        __SMU_DUMMY_MAP(SetDriverDramAddrHigh),        \
        __SMU_DUMMY_MAP(SetDriverDramAddrLow),         \
+       __SMU_DUMMY_MAP(SetDriverDramAddr),            \
        __SMU_DUMMY_MAP(SetToolsDramAddrHigh),         \
        __SMU_DUMMY_MAP(SetToolsDramAddrLow),          \
+       __SMU_DUMMY_MAP(SetToolsDramAddr),             \
        __SMU_DUMMY_MAP(TransferTableSmu2Dram),        \
        __SMU_DUMMY_MAP(TransferTableDram2Smu),        \
        __SMU_DUMMY_MAP(UseDefaultPPTable),            \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 966fa0238ad0..8e95a62e186c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -611,7 +611,7 @@ int smu_v15_0_set_driver_table_location(struct smu_context *smu)
 {
 	struct smu_table *driver_table = &smu->smu_table.driver_table;
 	struct smu_msg_args args = {
-		.msg = SMU_MSG_SetDriverDramAddrHigh,
+		.msg = SMU_MSG_SetDriverDramAddr,
 		.num_args = 2,
 		.num_out_args = 0,
 	};
@@ -626,7 +626,7 @@ int smu_v15_0_set_tool_table_location(struct smu_context *smu)
 {
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 	struct smu_msg_args args = {
-		.msg = SMU_MSG_SetToolsDramAddrHigh,
+		.msg = SMU_MSG_SetToolsDramAddr,
 		.num_args = 2,
 		.num_out_args = 0,
 	};
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 5938e88726d2..89a44b456e8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -87,8 +87,8 @@ static const struct cmn2asic_msg_mapping smu_v15_0_8_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(GetMetricsVersion,		     PPSMC_MSG_GetMetricsVersion,		1),
 	MSG_MAP(GetMetricsTable,		     PPSMC_MSG_GetMetricsTable,			1),
 	MSG_MAP(GetEnabledSmuFeatures,	     	     PPSMC_MSG_GetEnabledSmuFeatures,		1),
-	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddr,		1),
-	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddr,		0),
+	MSG_MAP(SetDriverDramAddr,		     PPSMC_MSG_SetDriverDramAddr,		1),
+	MSG_MAP(SetToolsDramAddr,		     PPSMC_MSG_SetToolsDramAddr,		0),
 	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		1),
 	MSG_MAP(SetPptLimit,			     PPSMC_MSG_SetPptLimit,			0),
 	MSG_MAP(GetPptLimit,			     PPSMC_MSG_GetPptLimit,			1),
-- 
2.47.3

