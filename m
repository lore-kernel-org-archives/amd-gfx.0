Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1285D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 14:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842BF10E133;
	Mon,  1 Dec 2025 14:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j7jX2h7b";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC5910E133
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 14:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrdSRsZtkvCcdY0F5o09NLWCaMJYSlSgPkQCeu0rPg/7TBIBozV1TCjo4H3arp00jC8N+xmmIM0z9W/Hhzwd/lHfNsPO2y81z7YB82roRFg2IEEs1BpXsfrY4nefnElNxP2vAXiLOwF7rusY8OWKA4X335hXobmlW5ZyLtPgUMeZ34QvnZY1tNNkwdW3n9dcZKRELTiMXfImINBqarFCLQ9tt0L56jLXzocDFAzs+XloxxS8Sp7WSmcDocpJ1nRYI/gxNG/CTPxuR8siTF6hPghQb8YLcHura2YobJTBYijsXrXHwNZ+7JaIFwwLNIKVjPRxOo7wY4+P3Ri7kd29PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGafFnNVh3LN50dY7CrE82vbaTS/4WcfAqnZcBRkHmQ=;
 b=yiqLjp/ijha13636Ldol4br5dwsCE3Plo9Xyza5JSM00nut1pXNS9d0S/apQ+FRlKtHvqM8s+uHlqURTfxHcsHeSSgkp30+B1hLYXlw2akp47RjX0eVjaQbxEpv2ibFnKRCOiGDluKEwZWaS6SE/Gk6CRDJ87tsL9BtkHkvMzQ3G1iCpibGxLgdDBlVmvUlHXRLCzzCe0s8zIxuBDKsOcat2bejHudFPFZ4G4WcyYYXUAMWjMr0JpPr1UXkTISf+H9mk11qlRoebW4+KpiYxLARZo42UwyG01mOwC9sipE3s9z2Qv6FY5EJQmY1xSAp2/8/BNrk1dvTo6RCMofS5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGafFnNVh3LN50dY7CrE82vbaTS/4WcfAqnZcBRkHmQ=;
 b=j7jX2h7b1zDGeSBVjiucTwCSGP3DE3JApfoM5SfQqBRkH4fRxhaTCUaNpb08V5fJdS4e/jhOmILW8jX6+YsxIVvRn2/wXOa3/vVFknQ01SOS8scc3n7Edzgv9Mo5ip+RYYwfIIrCt2GcZV5w0QXJnQfE76U4HWFqWwjQSJippdE=
Received: from CH5PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:1ed::23)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 14:28:55 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ab) by CH5PR02CA0003.outlook.office365.com
 (2603:10b6:610:1ed::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 14:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 14:28:55 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 08:28:54 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/4] drm/amdkfd: Bind gfx9 MQD in GART with mtype RW
Date: Mon, 1 Dec 2025 09:28:35 -0500
Message-ID: <20251201142838.1516452-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201142838.1516452-1-Philip.Yang@amd.com>
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: cafda926-9f8c-474f-19ad-08de30e5f542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R5IPTyIL36xTIRkGUg/1hTpv/336H3OQlsJzuC1YqbUbA9kgUSIE2YUXVNFQ?=
 =?us-ascii?Q?CwD1wsP6hhdJZS6umL19kuhguQvTm4H/aL8FJ8rujYBjrTSkjUdAm/Q1Whjo?=
 =?us-ascii?Q?u70UbOSw2Jr/BR+d2aYI6ECde/bpOTs3TzNQ313jpOqTDOPxFtV7a8JY536D?=
 =?us-ascii?Q?YGFUsW3FaP+F7Ci7pNpomtEf2OBDyhJNnBKkpmoU4sad+QBBuAPRuedxH7G5?=
 =?us-ascii?Q?T7RbyNt3+fqImVVIIKyPo9/ePv/69el3U2T5sRnwXezntUogdCL5XX9zRb38?=
 =?us-ascii?Q?1UVjqmNuoEfwPQcehzya3vLTFCNbxrXAiH5ekCCIRXdDIKGX5FDWoKMliln3?=
 =?us-ascii?Q?hzOMvpWtrY/+kqIP84WK4BF42KVwsv5ZFUMMdgXpdLhV/HWQPOcsdQiWOqyQ?=
 =?us-ascii?Q?KrWVP50XAjk2AngmXtqJe7eHrzo1eibGIXzljzoH8SWI7X0Ek3rcAGcAhFDX?=
 =?us-ascii?Q?t/hD+Qv9aqFnUlg8M0JIXdPWZrY5UCIEHz5T8SuROyaiQvGDMWOvkeaNAxQA?=
 =?us-ascii?Q?LMjc6W8mYIVXf+zCPOWBUIoO9ATj47YtDTCRV3FUSDwK3Ktg73Rmgwh1SFfw?=
 =?us-ascii?Q?reXoQEIYvkXrCoKjmQfFdJS8Mlrnd1vgQb1aVgqWVdaOUcIoo5Pj7uIUfGIJ?=
 =?us-ascii?Q?8WjQ5mUIvE9D7KKAfE2B8GiYpmKPTb7SyDe2n8JMoGvmPEXUjq+Zsh0dnNeG?=
 =?us-ascii?Q?kIiyb1cg9HLkPp7SePM1T/K610PVo4zNw6JR43D/j6YF3ssR9sNJBMEmBO6a?=
 =?us-ascii?Q?ryG5khBAHLUj7cI7wLmX/ezUYHfygVTzgPO8uEwNHwWo2aOCdDTByVzi1mUs?=
 =?us-ascii?Q?VnQp332jMf9q5cTIt40WywugU8NaDmvueWfc6UawlR0anTP0Fogg2g/jZvtM?=
 =?us-ascii?Q?6S3fDjtBSapU6TKPNoQcbsrqu573TG3Qi955MO+CH2vn0I6IGsWFqbv6cMeW?=
 =?us-ascii?Q?WD+UjDRTIB3FxBd89dhPRS8KlyBl8nW4RsW9800dx/yq4OF3qtijDDsARGPm?=
 =?us-ascii?Q?/pwwxee2flGVG7WMKszdg8PlWswzxyHR1c5FjqE4r4MP3lxlcCLzQoGKNcV6?=
 =?us-ascii?Q?fz/leTO1jFbFZC5LLy7O06fwRzd5LDCnrdquiXDfJ6k2C3wF1wWvQ/iAmk9B?=
 =?us-ascii?Q?RzHE8nNSSckkkXyNcD+JMrIhuUS05WkgfOfeyiHiUo4GHJIdOTz7EIXUZGpn?=
 =?us-ascii?Q?SJVok+Yave9gMfBIRhn9H4psvIBEYQ+270oVn4kOfRTPKTti6oLTf2k8ccIo?=
 =?us-ascii?Q?9pxBib2fyAbp4R75+EEIhB4MQMZb0wLvW35bdVBPkuisFLM1cJ2kQK8SpMRT?=
 =?us-ascii?Q?ea7o607TrecpcJvhDE1DGtSXIsGWPVDpPANwezJWgUF00BvkVNSU/TDTGIuQ?=
 =?us-ascii?Q?vIdf5Wj8qBYuIvqbav455knCzxtGOiw5K8JGsTitz4gZIuvHJyl/89HFy3id?=
 =?us-ascii?Q?aISgEyzDLPze4OcY5liPyzcrq4TQKMGjVMsbDpOOF4N2M6uNTj9UlXExB888?=
 =?us-ascii?Q?7/06NcAe/G5GKd8S9FR0B4k1dIYIQqIml7hc4SLZvfDPCC3v5Iez17vvSWX0?=
 =?us-ascii?Q?EXcCi/pF+pIuHo6Pu58=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:28:55.3050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafda926-9f8c-474f-19ad-08de30e5f542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
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

For gfx9, bind MQD in GART with mtype RW to enable caching, to
reduce queue switch latency.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e553cf411191..5f58cff2c28b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -841,6 +841,8 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	int i;
 	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
 
+	flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_RW);
+
 	pages_per_xcc = total_pages;
 	do_div(pages_per_xcc, num_xcc);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..4dd15767a722 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -101,6 +101,7 @@ struct amdgpu_bo_vm;
 	  AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
 
 #define AMDGPU_MTYPE_NC 0
+#define AMDGPU_MTYPE_RW 1
 #define AMDGPU_MTYPE_CC 2
 
 #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
-- 
2.50.1

