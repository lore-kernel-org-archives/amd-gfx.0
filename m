Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F8BD1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 07:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F88A10E1DA;
	Tue,  9 Dec 2025 07:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sWpK8xNG";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F1E10E1DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 07:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8VmKCGXv3XvWb81+LD9SzHwNbNP+5LnrmrQSVXrRnSPfnQRARsdlp0zlfPigz6rvqGufDluR4gvGuR1BNFYsthVvo/z3UORoSfWRWoafZLCboRQpNu6HN27ju2T3CQmNtOD31Al0xC+7pI0pZ1i9u8NDOcv3XdnBYftQBvzdUTWp5AbihAVTA9BM9i5qPYjYyUYIw67mg6B82RzmfMWlxXuTUDkwud+k7YPO/Ssxi7zgk1JFWWJBRCc6QP45XvP78MjK54Tqmuc4cFxfoJ+RyE4Zyxi9sar0KHqPziLud6j5HjyPSIOIonwSpgrgUM/5N0UjXoTFBytYsDWKoGYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxqWjFFUUPnhjXEEQBq2grkRhN8NYNxI1GqkuFcazEM=;
 b=eY5QRHdFRNOwUGd3XIbD0PqjDAHkR+durfh08E9PnLEYhxWueG+/4T+6uOMPHPvoHnMhYmu00x9Q9zMQ7yTBDzieCBcSJyDx1afuxIqNnR/TWtMf4TtlIuTL8j9/Zc56yOGaBpM8ao3rBGBnqp0lZSgMquthJEFshN1+fmDWrFSWBPVfEH1BEJIldiUeGtLLZ5YUDqKmw0BWUiPMq5kP0KH6i9noswuJIIOvvfR/HDDaI/AygPPWgIF4zhh+ktsDES2zVNSXEUVYbil+pGSalc8frYgqBf3Sru9U992N4OYxxxf/AgmZd/yI9HlW8nMMPyxIX4TQEXR4eWG5xUgLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxqWjFFUUPnhjXEEQBq2grkRhN8NYNxI1GqkuFcazEM=;
 b=sWpK8xNGPQtpApCtKr1oc23j66W47nWktuquxIlDlGAi5fhHPahpRFHxnu/72S997UEv3q4GZZosxDrIq7VakMdaSXCbsZG6N8UTtO+apy9QJMk35o9F9chufsUXgKV45nItbUfoSOr7T2lx8gdCgU5/e7Fs85gUydmTli4tbQc=
Received: from SJ0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:a03:331::33)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 07:49:39 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::bb) by SJ0PR03CA0088.outlook.office365.com
 (2603:10b6:a03:331::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 07:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 07:49:39 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 01:49:37 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add vram_type to ras init_flags
Date: Tue, 9 Dec 2025 15:49:11 +0800
Message-ID: <20251209074912.530424-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf04a83-c0d6-4439-09b0-08de36f781a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hxpi7lMXqzumd3Kbz8anouzJbimSbW2wJ0Dw7dj97ChYqHeBAn/kALyoFHoi?=
 =?us-ascii?Q?YaxAIavRyVsSyY4aE16kYqKG/T1R6uIclWL65vUENb+ehxcHxCeKb9QB7Pzg?=
 =?us-ascii?Q?O/2bwKmlRVceWXqzmo4TvR6Nhc3L5UaKQXTmfJsPd7GAWd1A9m6SRFXECsBf?=
 =?us-ascii?Q?VuBkvLC7qgfgI2QuJ36eBaZkj6FMAzi8OOFqZaPETf2LOdCyA/Yn/0WrojB7?=
 =?us-ascii?Q?SAJ6gfcJ3cjEUHMyfd7m2NMgSgvfhmZHZavc6qg/miDPMaOUo05IfoeHdhz9?=
 =?us-ascii?Q?bfUo/1CrxdohqxNdNZ0pEfCoZsD8wDAF6Xg4ujAB4GtgOJxmsmiUPokTpFDW?=
 =?us-ascii?Q?U4d8WfJ7TWvPJkWp49iAPI/9HWB+xgnNrySPCUaTuarJzoEXYvGZm8Keblmd?=
 =?us-ascii?Q?lXEZ4MtO2hZ2oL0kBaVl0CD7k2UFu/Hv8n/q2Ppy1OtaG9PuvIPWG+AE1ylG?=
 =?us-ascii?Q?+SXBGoXu23x3syqW8PkWj8yLcSYRs091TMQpE2gXNVv8Ajiqb3N5EXtDjuUz?=
 =?us-ascii?Q?/SJ8knfThl5iGLEgSAF/9NxdLBrMMLZiPvg+6EiZiEh48EPFYAyMBEwUA0bz?=
 =?us-ascii?Q?yugf8nnW8jB1qWS6M4ud8ONJH57q9VWJEj1BKMi9B5rX/JqrDj66gKvphg4+?=
 =?us-ascii?Q?EX7/d/OHtHBKgQf4FIkybYZ3hjsk82Xg/pEW33moJVzjWgNeRvVUmkkuXnCf?=
 =?us-ascii?Q?1KzrhIx4b8jnJ9DfmxMNSdDWgzuPoYyqwcBrlg4hvoiZjV3f+7WiPA/9g+8o?=
 =?us-ascii?Q?t3qsz+2yc4CWYh4+ychCaE+0W1KiG+hagKSrxH7uohHqr3TkpvP2E3l7Mb3q?=
 =?us-ascii?Q?tt98F9IfvgsMbChVOP9JgM2UaEgMUFm5s+eqWySMPCDrS0BC6lA7jGbWLvPH?=
 =?us-ascii?Q?4pmcixke6O+GciZ0qvfuIxnVfvQIiiONbMj0vm2vRIsxTE5kK8MGpWp/7Fh/?=
 =?us-ascii?Q?p3d1ksD/94NxFdp0Qdggty5ujc1NAYy7LfDBOjFZO6hPjtftmO02N/AqAJfu?=
 =?us-ascii?Q?Aepu/yche6SmKrT26okb6YbyxtiViYeWvbygQirSQfLKeR0LqwzAxjIU3EeO?=
 =?us-ascii?Q?kq2NdVUT0es8ge4fVE7G3ZnT2u4C2hc7hLRDdZHYmidPN9bkieBMjlCmRAbl?=
 =?us-ascii?Q?mFQZBaw2CsTjLQ+8JITZGk+tt3hVVK/RPsYNApHarYKJ/Qq54CLZUqKf/6In?=
 =?us-ascii?Q?AOGpGKYso47FLn0WaMUC/1GfJXYsZoo2Nb/2Gk8vWBcaFUMiSxmxTPvPo80a?=
 =?us-ascii?Q?aKWC4nNcCd6mCjt7V3CgHK7l1WZt6PEbZxwAvipANZK63rVhL9dx3rYYxfgD?=
 =?us-ascii?Q?SD7eGnoj8wcqODAbcjNNm+ZqhTyvgWDVywt+VHPn5YpIAl62UUuv5HfsAkko?=
 =?us-ascii?Q?ueBUkIE3wCS667UFZe0CsNyAOYZTe5A8Z1tbG1WWMW3rW7BE4ZGepn5jR7oz?=
 =?us-ascii?Q?XZ6Xf7JniQ3VtSvFTgJ7/DG/linMMHlF5d/oD9xXfCdVdXEpDV7dtnmae4Ev?=
 =?us-ascii?Q?WUCx99Expz+/Sxpcy4EWbIxyfzznMCVzRt6+p2WlZPJliSR+l21uoX72I0DN?=
 =?us-ascii?Q?A4k4Fo4J03QdVqavTik=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 07:49:39.1480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf04a83-c0d6-4439-09b0-08de36f781a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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

Add vram_type to ras init_flags.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a4ddb14c1bec19..4522fd77bbc36b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2000,6 +2000,7 @@ int psp_ras_initialize(struct psp_context *psp)
 		ras_cmd->ras_in_message.init_flags.nps_mode =
 			adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 	ras_cmd->ras_in_message.init_flags.active_umc_mask = adev->umc.active_mask;
+	ras_cmd->ras_in_message.init_flags.vram_type = (uint8_t)adev->gmc.vram_type;
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 8a3f326474e54d..f6178da910d35e 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -155,6 +155,7 @@ struct ta_ras_init_flags {
 	uint8_t channel_dis_num;
 	uint8_t nps_mode;
 	uint32_t active_umc_mask;
+	uint8_t vram_type;
 };
 
 struct ta_ras_mca_addr {
-- 
2.25.1

