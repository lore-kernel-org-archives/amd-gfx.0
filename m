Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5890DC5320E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 06:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0183B10E4BD;
	Tue, 20 Aug 2024 06:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLLOvmQI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B536310E4BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 06:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnRH57WgZIpt1lDfok+jjRDJ+tbtdn2RbmG49MGGczsMlbSh9AB6HBuCZ11uDdzeQHVBMFgjseWPB+j8ZIwxm9bhjs7l4f0p9Jv9YWmGPoepHG1JjjXv2vSb6kDQozO8DLdn23sJqKP/6Mt96cv31/C199z+acpY3Ii/foktlt+f7p5wyf6D0dmZMGAs7bcagxxfcAH37Pbncu0k+vQ0qo2RMhGLHGn6Ch8Fjvw+2cZsvLbE+B4ShDXdkjkxcAA7zWn0Yv2k6TndNzm3DFjLrPQwu2I9A/u/wIL1C8k+1E5mRTPkQut0CPNfF3J7u0Zb3wuDsFgRINMtuJGu+9BlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsgMQOBJem5zbALjg1PQpx0MfK2PcBEjlCiAraGLUcs=;
 b=RFOQ9GcqyqJuVxFSzjhbRapOhsHlR5i7BcHHm4vXkW19hfYBY1lAEKgoQ0qKN+j04KOArx4W8AHfVWsC1s/ygMEpf6igX1bDuBZ3GrtTTci/Ou7wS/bil1PNYKcu1zgBKL1EY9vOLmZYh/nOn2j/oDpazOtI2CVXhfDnbXU5993Dcg0SsKejujhBh6kUGJ26yzPmXllXYTeq4VX3e1OOlYhgBgS62KvgJjH5dAuQ02HbKszEYV10OQzGjxT0BUJEkADqfnsAbRr4ai41PgSZqk10dSE0s4ugHvRDr+3PHryYJKPVhoAr7b2Wc2HOUTZsY3P31g9RGkpb36CsspPFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsgMQOBJem5zbALjg1PQpx0MfK2PcBEjlCiAraGLUcs=;
 b=uLLOvmQISdz1N6vW+YncFSaHBHQi8hdNtKtovj6S+IXb6UG4k7PgB6uBdjHUi4COXOwOwhCdN/TY2bVJK0NaNJ0fT4JrFo9Eylvt3XCbdUFAy9L69H5gl6S2JuzdTIhm5HbOrvQIBEcyvla8EdkL95OayeGsfU6z3wij0Kvepm8=
Received: from BN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:e4::26)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:05:42 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::b9) by BN0PR02CA0021.outlook.office365.com
 (2603:10b6:408:e4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 06:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 06:05:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 01:05:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 01:05:39 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 01:05:38
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Shikang Fan <Shikang.Fan@amd.com>
Subject: [PATCH v2 1/3] drm/amdkfd: Check int source id for utcl2 poison event
Date: Tue, 20 Aug 2024 14:05:10 +0800
Message-ID: <20240820060512.16061-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240820060512.16061-1-Hawking.Zhang@amd.com>
References: <20240820060512.16061-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: e87fcf07-cdbe-4ec2-cc11-08dcc0de1f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ORAucHnyZDfaIBI5fxCEMUfHn1SyO6ZsGucf+txwVVNjBEKdKVEMNRrWp2jJ?=
 =?us-ascii?Q?vqnNAPnsfWKmGORNu1PsykxLAOyuV3cwumxTFv1bOek7j7hklsw2C7GH8f0C?=
 =?us-ascii?Q?BW3YTa5gL8XLhTPnCq/EuYwuF/W8BNs0W/3nceukc27JVGL5axQc1S7oqLMj?=
 =?us-ascii?Q?YYMHnJ65dK3NyIJROpNE8MgS+m4eUIg18CiBaSzsRvIflHsrbYo4f+Uv8lJg?=
 =?us-ascii?Q?y6vZ9oIK3pD2sEzrNRRQhy/2lfyImaNjHZIQqPlbt7KHYtYvbOkZ2uYXsrqh?=
 =?us-ascii?Q?K+PjR8dhchxbuz97ISM4rznhJwSOkYLSEhOkuZ4GDSQ1zjhWFjNdC5f4F69t?=
 =?us-ascii?Q?Bicn9Yd0j9p7Y+Oba1+yYX4XrOknjnEH0rc3BHL5NvnCDkdqkoAkAOqPjE3Y?=
 =?us-ascii?Q?bMYnQYc+1HoRgoWdGH7XQCCaWpO+n6LfGsQPNF0cW82dzibtCIqBv8sARCzC?=
 =?us-ascii?Q?4PSuzmf+FtErAKaOdzFI8RXKVbqLKqC6i544XGXOi0mXza11vGg4P8hu4Tgr?=
 =?us-ascii?Q?0FQj6NbEjWkE2IcAe8O3CWEOFO5vsR7+tlR1oKLsDcTYGkpjE7nSr2FPGRHx?=
 =?us-ascii?Q?Vqe9SUoMjj1UA8u31KKKBRH7DY+BeajKo0kwK8PsAFpn+xlpKgbi7ybFyll1?=
 =?us-ascii?Q?Oa61+4a6kr/1beCL3uMp14be4hFLZzUXADTAFYpZg+7LT6PsQE2FmQdnQdQj?=
 =?us-ascii?Q?StEnbpzmAGxEZXD+HcZyLkikjPIKwsBg7RbDQ+Zz/pqSauN49hiagbuR/UQ/?=
 =?us-ascii?Q?wPVy2PJISBI7euIywklGnXccTHxSTptBhfDFzHIgHeR8nzRa4KylAxl3qe3v?=
 =?us-ascii?Q?rLUf7p2TJaWx6UXuoZs3h6yD1pjw/iB40eJiXY4bHcayDYCuqoQI+LZm73po?=
 =?us-ascii?Q?eUUdaxuEzxVlPjG3Ohg49uteH8w0hMeuMh+U4EQUOIB+3NGbTU9GbB1Beo1u?=
 =?us-ascii?Q?u1sDPD6vFY+zlfoKz7dELMTUGL9SqgEdE753vBj6O2fDZ0Dx3R78w4cbzGbg?=
 =?us-ascii?Q?VUBALrrAJ2PWNTlWFYnhWhZoECp9gdhP4waUWtHurqgH9zGRbSmewK75vzyN?=
 =?us-ascii?Q?mjHGKtAaCBBgUR6uhbFXwIkm2QagMcQhnVIt/uKRcB/ePWblPMb2ZLB9poM1?=
 =?us-ascii?Q?JBqkltrNgmvuEjPT9YtQBzu1fKK1STYNmOco8v27sr8bn1/A+sRzGTdqCwhg?=
 =?us-ascii?Q?d8+dN2lTxAR/DGyF/WyMyfCOwMKZeiuDO8lHP/SFLJZOCL/X3FCHybJpU/Zs?=
 =?us-ascii?Q?4IOhUnnAwLPkCNugE9j9+vILXS7AofifGDdlRhP/vcPgXUogsZHKvBLAwngb?=
 =?us-ascii?Q?yvxqrHmkfQLXzrP1aFyMtncgJr5exACkxI0LhD2R8ekxq9vGlC3rFsmA+x3n?=
 =?us-ascii?Q?cNrNSq4M1t3lEvtiz2Gyl8b98pI17hPoqrrKJL4u8XlSYwBgqRxvAZpwjvaN?=
 =?us-ascii?Q?WuP6m82mbvswHOGP2bx9oYZq4amuJlIi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:05:41.7379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87fcf07-cdbe-4ec2-cc11-08dcc0de1f2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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

Traditional utcl2 fault_status polling does not
work in SRIOV environment. The polling of fault
status register from guest side will be dropped
by hardware.

Driver should switch to check utcl2 interrupt
source id to identify utcl2 poison event. It is
set to 1 when poisoned data interrupts are
signaled.

v2: drop the unused local variable (Tao)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c    | 18 +-----------------
 drivers/gpu/drm/amd/amdkfd/soc15_int.h         |  1 +
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index a9c3580be8c9..fecdbbab9894 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -431,25 +431,9 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
-		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
-		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
-		int hub_inst = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
-		/* gfxhub */
-		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
-				node_id);
-			if (hub_inst < 0)
-				hub_inst = 0;
-		}
-
-		/* mmhub */
-		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
-			hub_inst = node_id / 4;
-
-		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
-					hub_inst, vmid_type)) {
+		if (source_id == SOC15_INTSRC_VMC_UTCL2_POISON) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index 10138676f27f..e5c0205f2618 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -29,6 +29,7 @@
 #define SOC15_INTSRC_CP_BAD_OPCODE	183
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
 #define SOC15_INTSRC_VMC_FAULT		0
+#define SOC15_INTSRC_VMC_UTCL2_POISON	1
 #define SOC15_INTSRC_SDMA_TRAP		224
 #define SOC15_INTSRC_SDMA_ECC		220
 #define SOC21_INTSRC_SDMA_TRAP		49
-- 
2.17.1

