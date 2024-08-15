Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2BCC531DD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6919010E386;
	Thu, 15 Aug 2024 00:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWwxAj+z";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCF910E370
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WblmXQntctQQdCuFP6OZ8EMNeFs1lhxl/BioYbHGfGghp27HyWjQ/lQ/rDZjTtly1WUKUryh1bq317OMOXL1jurhpCxIfCyJyWxUBvM/216io+VGd9QSJ0fMJ/2H8ApNlUyTaeh4KIQA2tsWNIagR5DKpbg51+SWfjIETpurJiST4U2pQNLEUkHIcGZkd/q5nQIpZwof44eO0frWEZXQFXPil/heTjQ9X3lzunYK6VaxutWVzuV1Ri9dVMDlMwVMppppUPXtgyus1ScF9ur0VUriWtq0ZwEY4e3M3eXcUeWxSXFjJuetePaB3mWMvjdo2uQuh+NIZEqrd/PHV5aWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETwVFCgZrmcazwC5ezJYMfkY4y9R0E7mguNerYF7aO8=;
 b=YVVpI5QuO8mg14xDv+BP6+8CwJz/YgPWCXr3Q6p/5Uf9WfsLolU6YFWqu2wrBnBLzD9BgIE7qmsAkTmGg6ACcTZTab7/8qYpPV1DCccrBPKdy8YO2Ys4ZTT86cfK+711ExqmLZHIMWynyHFJRICFEb1Q+rF53++u3fTILOIkvxBsvhfplY0RCPErrVAsHdxpKwHJjc28Efnf+HbTzNzWUjTIqc1qA2rLPCuBJ5u8pU4dS5cd7y1xV+RokAf0d5VbGignRvsP3S6i0NKcPCcnywvDJDcsA5IzRwHPu8zQRDXJvylf6HER66rjor7edk4xTVpRvF5UP/HdwrhEGeI9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETwVFCgZrmcazwC5ezJYMfkY4y9R0E7mguNerYF7aO8=;
 b=vWwxAj+zuVeCQsikvgyBe3v4VmfkI7py1VQUm117L75fIVrV7FG7z0Dag1Jcn57glgQ7DTyBRM8QRVAp70VFUL8BQ0wIM54HboxjQLdl9DXjEhlOtplNjMKa12C1MFUwNn1uxKtjT1pdTdG0z7DdxhFQFZmmmo7ylHAFs0f2u+8=
Received: from MN2PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:d4::22)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24; Thu, 15 Aug
 2024 00:05:31 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::d7) by MN2PR04CA0009.outlook.office365.com
 (2603:10b6:208:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/17] drm/amdkfd: Enable processes isolation on gfx9
Date: Wed, 14 Aug 2024 20:05:01 -0400
Message-ID: <20240815000501.1845226-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: d528eeee-13b5-4013-d523-08dcbcbdfa10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xzGzhItlsJVKOrFZrYXJt26i0S0ahdSd6XRqfpfiDeK11AvuFPX9PmJguIvL?=
 =?us-ascii?Q?cEK3jpCeeFD7klzIgqPKVsHHS6AGqaM1QEeLg5bNC5wE4o2Nsf/WCu0ngjl5?=
 =?us-ascii?Q?gUgMoxAQUKdN0V7Q8vmT0PwDXlFvohvxuvCrb9sCTpFaoWwnPhPUR23SVp1H?=
 =?us-ascii?Q?IZ8ye3AeefmGi5WygJDyZzQxnTqhAV5ziXRPSWyJM3/G5rTlQrf9ZwFTpcmD?=
 =?us-ascii?Q?J1Xf2C2W5Qw+ImiLiWMIEjMRYyq5sfB5WMBchEY/i6NtSMom4tcvAmeBGzi4?=
 =?us-ascii?Q?Uefn/tUUk33d0MXT/EXpUf0HosmvaLBlKaA1k0ahBo7Qb2kDuljzYPCDI/qj?=
 =?us-ascii?Q?j1SQS8vGjLVNiBIbVwsJTjUe+nymP4i2Y0hqL7as3j9kOvyOplmR21AxZtbH?=
 =?us-ascii?Q?UqAWI2RNKElIS/q+ucOQDxDQUHJwlNRFQ6OA4grX01KeSZPdxEpirzM8hvUk?=
 =?us-ascii?Q?8sPURJxdCQPesIomoYaIKDnUbu+iXoGWr4pkej6pEiYUYtPGzzal2mdfD2HD?=
 =?us-ascii?Q?QWWFS5Flg9i1AI8QcLyofnPzJ4SircwSOBdHvWGbczDrk06XgOdrcVyTgWat?=
 =?us-ascii?Q?giOL3q1Cb/EBIrNA1ND2t1wb7wQfLjz3zJ1/Suy65JkXJrUjV5/D5ycX+MHa?=
 =?us-ascii?Q?U5HJTg4FxVvpx7nqeyCnHyUgsqGvzX+DuY0/NSWub/Z0bAz0uIFKtVR0vcCo?=
 =?us-ascii?Q?MqQZifHhUFCK4sKbtBPZ5mAUb2rvuhTDmXzTv1FSKUjKjTQI7MN091X4pzKZ?=
 =?us-ascii?Q?6Cug/6Qe31KNDvyb7wajjdcuXkUt0t0qgHKus8bjzRR/bxAgzjar4jE8HkE4?=
 =?us-ascii?Q?m01ft1ilpzx2L0vRiIftePjfd/URHd5r1sUYqPRoXFHuLOFCyNHIVWCj70e7?=
 =?us-ascii?Q?tG4YxafwbT/B7uGWyxS5bfLKdTAKPeq9WYpH7uxa5KJrT1W30wFbABHsYH/A?=
 =?us-ascii?Q?yDVseKMSLE5kxYs6CdyjfJgfdVrXErNrUKQjbJ2CycGsny2Qf3AlaCbcnNAo?=
 =?us-ascii?Q?2AtZ5Ck3oahYvsl+CPZWtzy4HtC8Tu1Ji8f5ilV5JWYfeNds3B0JojenvD+G?=
 =?us-ascii?Q?A6JgfVQo3uETM3pi6wapGa8DQe4xrWbnYSNZeInJsnCQyHn/32FF5HpfVUkm?=
 =?us-ascii?Q?gL/xqLsWEmRhMpWEatjkAq+K+1CUwolgeNMn76TLwKLyIxXzzF4THXadkMhr?=
 =?us-ascii?Q?5TZTHbnoMPpFFl9i2w6gTAd3I3QG/IGSDh4S4qYYqQxv3J8U+6Re3i7DY4ks?=
 =?us-ascii?Q?lVBgKEDH0ES7qpRwmNZkunfxsnGFBFtjn1svqO7jIy8lCbPc4UpaTphLTaZu?=
 =?us-ascii?Q?fD1JVI85SXlW0mCgjDwhd80+2qha6v9oCJ8xvgDA748KnyX0d2qiOykOm+fl?=
 =?us-ascii?Q?Dln9ZIhBLObAMXwWebEtGfq4QawBU2EgwpAMrSPaqcco2IC47qqjrPmSaCPp?=
 =?us-ascii?Q?gSFzecNP9jRA4sM7iG9C22LBZw3hj0pS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:30.9390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d528eeee-13b5-4013-d523-08dcbcbdfa10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522
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

From: Amber Lin <Amber.Lin@amd.com>

When amdgpu enable enforce_isolation, KFD enables single-process mode in
HWS and sets exec_cleaner_shader bit in MAP_PROCESS.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h    |  5 +++--
 .../gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 00776f08351c..1f9f5bfeaf86 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -37,11 +37,14 @@ static int pm_map_process_v9(struct packet_manager *pm,
 	struct kfd_node *kfd = pm->dqm->dev;
 	struct kfd_process_device *pdd =
 			container_of(qpd, struct kfd_process_device, qpd);
+	struct amdgpu_device *adev = kfd->adev;
 
 	packet = (struct pm4_mes_map_process *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_map_process));
 	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
 					sizeof(struct pm4_mes_map_process));
+	if (adev->enforce_isolation[kfd->node_id])
+		packet->bitfields2.exec_cleaner_shader = 1;
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
 	packet->bitfields2.process_quantum = 10;
 	packet->bitfields2.pasid = qpd->pqm->process->pasid;
@@ -89,14 +92,18 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
 	struct pm4_mes_map_process_aldebaran *packet;
 	uint64_t vm_page_table_base_addr = qpd->page_table_base;
 	struct kfd_dev *kfd = pm->dqm->dev->kfd;
+	struct kfd_node *knode = pm->dqm->dev;
 	struct kfd_process_device *pdd =
 			container_of(qpd, struct kfd_process_device, qpd);
 	int i;
+	struct amdgpu_device *adev = kfd->adev;
 
 	packet = (struct pm4_mes_map_process_aldebaran *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mes_map_process_aldebaran));
 	packet->header.u32All = pm_build_pm4_header(IT_MAP_PROCESS,
 			sizeof(struct pm4_mes_map_process_aldebaran));
+	if (adev->enforce_isolation[knode->node_id])
+		packet->bitfields2.exec_cleaner_shader = 1;
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
 	packet->bitfields2.process_quantum = 10;
 	packet->bitfields2.pasid = qpd->pqm->process->pasid;
@@ -144,17 +151,22 @@ static int pm_runlist_v9(struct packet_manager *pm, uint32_t *buffer,
 
 	int concurrent_proc_cnt = 0;
 	struct kfd_node *kfd = pm->dqm->dev;
+	struct amdgpu_device *adev = kfd->adev;
 
 	/* Determine the number of processes to map together to HW:
 	 * it can not exceed the number of VMIDs available to the
 	 * scheduler, and it is determined by the smaller of the number
 	 * of processes in the runlist and kfd module parameter
 	 * hws_max_conc_proc.
+	 * However, if enforce_isolation is set (toggle LDS/VGPRs/SGPRs
+	 * cleaner between process switch), enable single-process mode
+	 * in HWS.
 	 * Note: the arbitration between the number of VMIDs and
 	 * hws_max_conc_proc has been done in
 	 * kgd2kfd_device_init().
 	 */
-	concurrent_proc_cnt = min(pm->dqm->processes_count,
+	concurrent_proc_cnt = adev->enforce_isolation[kfd->node_id] ?
+			1 : min(pm->dqm->processes_count,
 			kfd->max_proc_per_quantum);
 
 	packet = (struct pm4_mes_runlist *)buffer;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
index 8b6b2bd5c148..cd8611401a66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
@@ -145,8 +145,9 @@ struct pm4_mes_map_process {
 
 	union {
 		struct {
-			uint32_t pasid:16;
-			uint32_t reserved1:2;
+			uint32_t pasid:16;		/* 0 - 15  */
+			uint32_t reserved1:1;		/* 16      */
+			uint32_t exec_cleaner_shader:1;	/* 17      */
 			uint32_t debug_vmid:4;
 			uint32_t new_debug:1;
 			uint32_t reserved2:1;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
index 38f5cb6a222a..e0ed62c4ade0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
@@ -37,7 +37,7 @@ struct pm4_mes_map_process_aldebaran {
 		struct {
 			uint32_t pasid:16;	    /* 0 - 15  */
 			uint32_t single_memops:1;   /* 16      */
-			uint32_t reserved1:1;	    /* 17      */
+			uint32_t exec_cleaner_shader:1;	    /* 17      */
 			uint32_t debug_vmid:4;	    /* 18 - 21 */
 			uint32_t new_debug:1;	    /* 22      */
 			uint32_t tmz:1;		    /* 23      */
-- 
2.46.0

