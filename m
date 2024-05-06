Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BB1C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 17:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C38A10F16B;
	Mon,  6 May 2024 17:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jECu8+1E";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947B410F15C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 17:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoThL638qoEylGtjmOTK4y0uJlszWYFUssiSZrZ6zT9IqEOQmmq2lVQvNFOiHmYIpEtbpPzJcn7ih7LQtYK/Y2vt1kra+89Rtlqs/wJrxuFaJTu4EmkiiNoRooMlddxUIaewHmB18iDF/j6pHTX3umaA20R8HLQmJGTDm2LH94pseINvGSSPe/MEUkaFjTqSiTwHBQYlPSbUU9x8FxEKK2i5s2ZBDUDDFFZOoK8XqmlJDzLeGCUHaaNKDaO+Jl7gb/YoXj2u44iRytpZz9ATw5gHSkxkC45Ynr4CT2ZBK10cfEU/QEm4KmDBCuptWPM2YXbDHUsvSvZrMRA3aPxYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GF/zPAStY4aJsdn/2OWRRSu+7UAQKzDZYNJDlgdz/Q=;
 b=mupScNYNsKhk002tbiGtaF571n92ZQHls6v0ObnVnl2u+tIO6Cq1y1wFjCgNrmzMta+z8rFs45poazgKd8t0Oo3EnP6hUXntb4tZNYFutS6ZtJDImhuLwwt4e/+hSrRuK0+dk4DNdJkE4hDp8eWXmuqrAlIAPqzjgaCTllmS0R+Jdc3iqRuT5y9ad5U/LL9VIqazEG27BUywTPkXCsy9p9fBY/SoBwP2YjrEawPaTZ91Sgq2vXYUJGE0fcz+B0812vfwrvIhKbdDp8qkxuLUuIjnNhG04/64+18UpwRwgG6z33aLV4M4DtAcxv72jolGUrULH++frqks0xHljzi4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GF/zPAStY4aJsdn/2OWRRSu+7UAQKzDZYNJDlgdz/Q=;
 b=jECu8+1EapcLYCBNUiz8d6lkC8LEmRk7cqQr7Go0MdW0DBXaw7ysi7aEONfGpjDIxaW+lOKJ/Mznd3x1AF5k5WVq+H/FpXrgzmNLBVfNvLm+vGk2b3f3+taD80uYlCOvGFUwXta5fs2hLSz2TDuexRsCn7fGdSmUtwBUzN+17Dc=
Received: from CH0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:610:119::24)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 17:09:17 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::c2) by CH0PR03CA0367.outlook.office365.com
 (2603:10b6:610:119::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Mon, 6 May 2024 17:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 17:09:16 +0000
Received: from mchen-linux-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 12:09:15 -0500
From: Michael Chen <michael.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <michael.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Reconcile the definition and use of oem_id in
 struct kfd_topology_device
Date: Mon, 6 May 2024 13:08:40 -0400
Message-ID: <20240506170840.98816-1-michael.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7d72a3-d6e3-459f-eb57-08dc6def4291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8L+P7Idnxb99DeftPY6sofT0yt8InwQ9Lb+7251bsnF/fbZO7haPEibi5xq7?=
 =?us-ascii?Q?qBuq5aYjafBFNvFw1k4vvj90eyL7H3RYZpea6dtUpRrJdxDjxp0ls241ZJ0B?=
 =?us-ascii?Q?wraSAhxiZheWp9O1eFcDRbItv6wNaKi42OHvZ/2NJPtFpEOKnvawyoF9sKCR?=
 =?us-ascii?Q?//LcsSTkFY6tRHVoOj2ncPV9IWc0cBTBcGw/SfNjMIbWIKDbJPI6uCR1hN0u?=
 =?us-ascii?Q?y/3vQmTG64u0rLcW5xIU3CEeo5k54KdhEMhhXv9gljd//ALD9rp5Ea6pUGfK?=
 =?us-ascii?Q?f77tEQ9JNDBzi9w1HEkREiD5YnKpooBD3wLsGwvieSubPo5hEl3CX5hcmMON?=
 =?us-ascii?Q?Wmico5cOw8T+GKn62CTvh+9dqIRGu0vT7QmW7ve/ISL69qCSFFit36dcUAPR?=
 =?us-ascii?Q?3uCw6Tj9fMVzeJJ634mrJ76g7hKPDJS8ArHVnmd1oFvbDO888veba3VFib6m?=
 =?us-ascii?Q?Z3kj0djIxNpEUSFzZB7I5FGOkgkZjZkJplolDPJrFSwyrw8i8xYAyTTJ04hJ?=
 =?us-ascii?Q?sBF3CS2RWn/2UI5L0amI2noPsQjlGfE+cTA9KXRleoGyVl5K/QXg7GsVnCzT?=
 =?us-ascii?Q?gm66Y3mJf0V48iJO6qAjOufya4g6oO0wTR7dibDKVJa+MZ11Y8oBsGA4/lVt?=
 =?us-ascii?Q?ro8levTU+tHBKAcRZIoiXw1XZcfz2HPLFg2/y0uH7lilbMaPMB33xhqdmgK5?=
 =?us-ascii?Q?5b1l7xJCaC4nF6rsJ6oC9eriSeES36myoPg2n2ph44icLQTbSg2iN1JLbFTW?=
 =?us-ascii?Q?g0PXP/lUb1PPT+3P/5gUS8X+FEZomIrINBDIlP6g8iO9hSU5o2/0XBWSuqVm?=
 =?us-ascii?Q?lkXMoeMcNKpHX9jDIDYRooyOyTsT+KfRyxkmIB/BSxkGhdAuzd0zQ8MeaTrr?=
 =?us-ascii?Q?dV/i25MgUfJsIDPtgiPrc3Hv8zkOMdNNPwgYFYNkIgV0JmfR4bd/bQNpsdUS?=
 =?us-ascii?Q?kLLezfjOQmtznaSzHG9X6Tr1KqJMtj5PTnAsgkhHG3JT41dH1LOtskhW+usx?=
 =?us-ascii?Q?KCjWsto/Fc9f0YQ+biUFv1rd/aYvCpgN//+GeS18FP3AFe3Fp6sEO7lLVy3/?=
 =?us-ascii?Q?fTCP9Kjh6TP3egG6txzJEBcN3QRgaBuUd65WGfKVbBD0WQrZSD1rgqg7nq8M?=
 =?us-ascii?Q?5LQr4goEDCZsf3HlphVsgkqd3gRSTnt5AEsFLeIej/iuElrV4v49VDbUpUEt?=
 =?us-ascii?Q?Ioe0PwABcDjQE1X8Y11RCYsfoJe2t4FuGcVmtqP70q8iK73jNC5vMRyEdE2w?=
 =?us-ascii?Q?wUho/MCluWP/Yir/gbVN984xsg6j4F/d1WBA0puYfjrrLS8+jW8eDPcLMN5z?=
 =?us-ascii?Q?cfZzCFoDEk315oz52PAK4vpi324ee3JY7Iuo5rUUwidT2CmpQ8tBJBIZ0lwp?=
 =?us-ascii?Q?IE4sFNU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:09:16.0613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7d72a3-d6e3-459f-eb57-08dc6def4291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
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

Currently oem_id is defined as uint8_t[6] and casted to uint64_t* in some use
case. This would lead code scanner to complain about access beyond. Re-define
it in union to enforce 8-byte size and alignment to avoid potential issue.

Signed-off-by: Michael Chen <michael.chen@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     | 2 --
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 6 +++++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 300634b9f668..a8ca7ecb6d27 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -42,8 +42,6 @@
 #define CRAT_OEMTABLEID_LENGTH	8
 #define CRAT_RESERVED_LENGTH	6
 
-#define CRAT_OEMID_64BIT_MASK ((1ULL << (CRAT_OEMID_LENGTH * 8)) - 1)
-
 /* Compute Unit flags */
 #define COMPUTE_UNIT_CPU	(1 << 0)  /* Create Virtual CRAT for CPU */
 #define COMPUTE_UNIT_GPU	(1 << 1)  /* Create Virtual CRAT for GPU */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c51f131eaa2f..f7fa0cb18482 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -958,8 +958,7 @@ static void kfd_update_system_properties(void)
 	dev = list_last_entry(&topology_device_list,
 			struct kfd_topology_device, list);
 	if (dev) {
-		sys_props.platform_id =
-			(*((uint64_t *)dev->oem_id)) & CRAT_OEMID_64BIT_MASK;
+		sys_props.platform_id = dev->oem_id64;
 		sys_props.platform_oem = *((uint64_t *)dev->oem_table_id);
 		sys_props.platform_rev = dev->oem_revision;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 27386ce9a021..b3e79ce3bd35 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -154,7 +154,11 @@ struct kfd_topology_device {
 	struct attribute		attr_gpuid;
 	struct attribute		attr_name;
 	struct attribute		attr_props;
-	uint8_t				oem_id[CRAT_OEMID_LENGTH];
+	
+	union {
+		uint8_t				oem_id[CRAT_OEMID_LENGTH];
+		uint64_t			oem_id64;
+	};
 	uint8_t				oem_table_id[CRAT_OEMTABLEID_LENGTH];
 	uint32_t			oem_revision;
 };
-- 
2.34.1

