Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16350C677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 03:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BD210E32B;
	Wed, 11 Jun 2025 03:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GjGRRpz7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B98F10E372
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 03:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBp8rlb1U+vm4eqJq3UZpO3LnNZX3PUf6kLk10bDILNPJXc/xGMJYf10fQSgZ4tHhK+uQD3D4Qd9AXrRfUxo7iiGRMofTLtb6JDpXe60wyjwSWzoPJAPFv37QjeXCixRWOeHltF6Yvs6cIQIeWd3E74LsdKVSTfSqJmLhxWH+lpmG/kJ5vptUT6/YJ6l0h8uw1eSGf6YU6muhMj7oiiP5dQulzghhtL/FOiYciQNC3ndn93Z8q8Q3wEZz0mJ0AhjIGgh4JyBGrn7CsAu0+UkXV/9YIMobJ35sytdrDnL9I8lluXn/77A063rPQCrBNRj04cXGorutEjX6ueMRvkccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NcjgBEA+fgKgq99qOZH0FAIwulrmi5VUxbJMe3TK+U=;
 b=fkx9m5I+iovtw4U7d7iV23mbj01To5Jtoeb4Mxw/SI3pcYPMnAqHWzhKtBkUWmNYOHFGYF+cO98FETJUiDsKouiE7yZmpHeVzlGasBmVR5WC/X2tHyY+PNFnW2sDBjJjeDV4wrPWg3t5lRRSlvX45TpptotK8SoiwzR0BzarOBejCH2HPzU9wnl5Cv2aFkqMizh08kcQ2Hh6Wlm3lon7wUu5P4LpbawZ5zhL+6hJ1U5eGhlF/VlUYVZlJCCi8HbLA6hjAmOGn68NfTQtOgrC/YQV3uAAC+wpji5iXMb5XA2TcC59JvGWzEXyjTV+hU5Ebe4rx+0AAo6eVZVhetxEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NcjgBEA+fgKgq99qOZH0FAIwulrmi5VUxbJMe3TK+U=;
 b=GjGRRpz7h1WYUo83ACGW8Z8MwBwo6VjSb65a5tSh97zTq+LRWaAwtpxdvnwVPfpI3k43jw710u6z94DaPnq2HN7BRC8j4L5uC+tdbWSQMfwfY29GY39G+DlYh8eSV9zIXg0LdIDIl/u8nGpU0d4fV7drn3YZUrhw2A1mliE9D/c=
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Wed, 11 Jun
 2025 03:35:11 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::2c) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Wed,
 11 Jun 2025 03:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 03:35:11 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 22:35:04 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: add vmid/nodeid input for RAS poison
 consumption handler
Date: Wed, 11 Jun 2025 11:34:52 +0800
Message-ID: <20250611033453.48610-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033453.48610-1-tao.zhou1@amd.com>
References: <20250611033453.48610-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 002e114b-48d2-4826-8ae0-08dda898f8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2bEdwcy8toQhS7WMR4foXuylH98t/xGjPcy+36qpwZQDcS6/DeO/lgw9VMI2?=
 =?us-ascii?Q?RWRcIcV5TWxZxVJlMDKpIP9FzTeDS6sDYMRY0xCMaNmnTGgVeYs9BFKNW4i5?=
 =?us-ascii?Q?Pf07hO0azwkyt+qI579gGcFhLffJrI7jIdQXEF6219A6YefohmCXm/lSaauO?=
 =?us-ascii?Q?5U5tz3m+cVavUN1SB9Oll6+WzS88cSiO8M4/WjuYIazHEZhjAb0bNIPsYAVc?=
 =?us-ascii?Q?Xa3g1fLuht+0RVehsQuBEK5xf5nCRaE2SfBSN9UWFM7qI6rjvfCdb/3ZZB3W?=
 =?us-ascii?Q?TkegzqyARDjVXUojlcbYlJU1Qvrcvl4WTWARHyW3/JpYCv2XAO17XPkcVkGZ?=
 =?us-ascii?Q?ey/R62UcNC/rvGSwagLaocyZroguoHuazYQr+sKnI5+QAxdRGwTS4UnUnaq7?=
 =?us-ascii?Q?SGJz0nSmFTwEuy4tPe2t8ZCD4WmB/Dsm+Gd001Gtjq69hJQFWoROZoI+U4PL?=
 =?us-ascii?Q?vEBOEPV59ruN2tM8NlimnRyTTxMqlNWjZNP4eDf29Icf7VBPWspORVK1yFpe?=
 =?us-ascii?Q?WvnStUH7bOiMc/eD/fOt3M835SoP94Q6cx5ktqBWTVqhkNbvW3bbs1Pk3pwW?=
 =?us-ascii?Q?h11eUA6oVIhfF8CNClmOz9/OJDS3Nonz/uQqfmymEc3OhK3SxrnNSPpUZYMZ?=
 =?us-ascii?Q?2vMgekzYcKe1ue6+Zt6HM2BsINUIdqmQhUK2zPGHpljFNoj/1dCqvlzjOnVE?=
 =?us-ascii?Q?O5M219rBu1MH2UxCpHOPa6BdtrrxacQ+2057lI40dTqh8+PaxE407G0Hfals?=
 =?us-ascii?Q?gXLuExNpNlFd+gsO8tn9H3cujbgjkUUE/p6//ciNF0ReWMTFqCKmlbbin9Oy?=
 =?us-ascii?Q?2YiVOJXSrD3Kz/llq7HFdpJ6QbJgfofbLerdyhhvxa7UfwmAbP58ot8J6x4j?=
 =?us-ascii?Q?HoOBfB8t7PX67v6MyRsJ2VUVdu2wbg7dKEsVmIsveu4veGzBH6MQeTVDsEMs?=
 =?us-ascii?Q?ORvqWriepWm0C4l8kOEyVNhrE9KrVOggNXRg6q1O3hlw0hTBHCDl8WDXxtCm?=
 =?us-ascii?Q?hpYx+4wiN9LXv30+q7GkXzza7e7FMtL0ujEdZC+5bk4uNxXasMq7PIY1QxU6?=
 =?us-ascii?Q?Kta+1F4GbV6y3gtNFogT7aIzXhzwSnM9yczmvRVcIoC8rFa5rGdjhXx16KRQ?=
 =?us-ascii?Q?64ZrReryK7zer9LWQ0WQsJ+10GshT/RPF097EQ7pR/TwEp/aX73M00OxSuUS?=
 =?us-ascii?Q?CkaBpOxiaSGdHzQ5116MnOiI8Ezsl2YHj6qZ9rNrS/WIHNfjmDZaccC8DAdp?=
 =?us-ascii?Q?CoXWLo1uyKxv5k/j5A47pMbqFOqa0JtwskBnd7923qQ3ULphaF4Q3z/FHjoz?=
 =?us-ascii?Q?v8H3gkUpNMXJLLNbm4hwBrqeet+Szp7QaGnZDy9fdRZt9qppAcupqTR0Cy3v?=
 =?us-ascii?Q?YGAU/9dlRFOyZqRRBFG4swXENGTw3X6uJebs6zWgNzKgenEDIq6d+GIubfiW?=
 =?us-ascii?Q?T7bv4fl2GT7XZU66qnBmmst6axCIfFyKpQHfUdZU2Pernm9nb0Fyt8p+EyCl?=
 =?us-ascii?Q?+Ql2t6fPd61eYJY1AcBb7xvHJ4L1Hi1ddu2i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 03:35:11.7403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002e114b-48d2-4826-8ae0-08dda898f8be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
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

Prepare for the support of specific queue reset.

v2: also input node_id to the handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 4ceb251312a6..0018d04f4b33 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -142,7 +142,8 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 				>> KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT)
 
 static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
-				uint16_t pasid, uint16_t client_id)
+				uint16_t pasid, uint16_t client_id,
+				uint16_t vmid, uint16_t node_id)
 {
 	enum amdgpu_ras_block block = 0;
 	uint32_t reset = 0;
@@ -357,7 +358,7 @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
 static void event_interrupt_wq_v9(struct kfd_node *dev,
 					const uint32_t *ih_ring_entry)
 {
-	uint16_t source_id, client_id, pasid, vmid;
+	uint16_t source_id, client_id, pasid, vmid, node_id;
 	uint32_t context_id0, context_id1;
 	uint32_t sq_intr_err, sq_int_data, encoding;
 
@@ -367,6 +368,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
 	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
 	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
+	node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
 
 	if (client_id == SOC15_IH_CLIENTID_GRBM_CP ||
 	    client_id == SOC15_IH_CLIENTID_SE0SH ||
@@ -501,7 +503,8 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 					sq_intr_err);
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
-					event_interrupt_poison_consumption_v9(dev, pasid, client_id);
+					event_interrupt_poison_consumption_v9(dev,
+						pasid, client_id, vmid, node_id);
 					return;
 				}
 				break;
@@ -527,7 +530,8 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
-			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
+			event_interrupt_poison_consumption_v9(dev, pasid,
+				client_id, vmid, node_id);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
@@ -538,7 +542,8 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		struct kfd_hsa_memory_exception_data exception_data;
 
 		if (source_id == SOC15_INTSRC_VMC_UTCL2_POISON) {
-			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
+			event_interrupt_poison_consumption_v9(dev,
+				pasid, client_id, vmid, node_id);
 			return;
 		}
 
-- 
2.34.1

