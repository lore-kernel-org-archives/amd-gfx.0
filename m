Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D162D35666
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCAD10E609;
	Wed, 28 Jan 2026 02:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="49jfL0E1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E56310E607
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED7XNQ3EMHnhzwi43/KGPlKul3agB47L2IJOoQ8S6y+NnZC8/mWZmoSQ3jplEFL2h/77kaYzhBQn0DlspueRZOMf6n6CilO1ocPwW0XNE2dyIGJkKm8AOvZxKYeARr5Z3vcbZf6TvhpxrzsCZZxnKplON14mcXteGB99vPLw6V6SZRvcNvdZqHXgpW6XpR+SD+kAYVSHzbGqk7WLXOrV+KYPcjW8SgIPxstmG28psXyiEMhDXd6iI4GE/ju2MsRmwQeYMT4y15kR3EQIud6GH33nszWDbiIj/8bITK6jfAo5zBTTSq6qjhu/vJuvCfHo9pGbuzHKcKw+admEW8TfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKrkrQA3De2yFeDlcjSLkqtlgl2sIxinjUvm92sh0aE=;
 b=Pndsy0nH1CefNgXaNumzzISoz7QmXA5w7wJsZAPh4ykFQD8d0r2IhUOdwTbnX4HqJTRPLelbnszov9dcyoYD8ICZOx4te1XgLyMRUpWqcdaYeGS4XoSvcBgVIF23KTa0raJ8xFdmUh0ay8vJWr4qNRcbhJ2r+uqSCWB1ElOvSlqPAZBf+MMp0W0t30t6hakLvKpHDFdWWudGDapsgKhd8q0q1qZji7KRvywi97Qbo0Sie+OzJLUH1aqc//bXG3GpJa0das6wtDdPLZrktsJRMNq04AbvMTm3WnPlAnghsBBhB9ZhxKsDv1pVhRtmqud2/v134Oh+34vGCtX+1MjvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKrkrQA3De2yFeDlcjSLkqtlgl2sIxinjUvm92sh0aE=;
 b=49jfL0E1f5CbUfAIrDftKLc7lke4h18qXOarREdu9gtfvTiiLoHS7ksrRdbmKsUfObFurlLxI18Z7GObugyTRKgmB5+PahfAfAt2rthieeGZ+gMaJt9E7R25JCaznowO/T0f52DGqwUL5gp8rDUjAF5GuTj4qiFE5VUz+pEBKBI=
Received: from PH1PEPF00013303.namprd07.prod.outlook.com (2603:10b6:518:1::12)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 02:21:22 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH1PEPF00013303.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:21:21 +0000
Received: from lang-cezanne.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:21:19 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "David
 Belanger" <david.belanger@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Add a helper macro to align mqd size
Date: Wed, 28 Jan 2026 10:21:08 +0800
Message-ID: <20260128022111.281082-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4f05e7-1abf-4b5d-4539-08de5e13eda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AdcJ1tPfxCi0um57TZcw3zocT9gA0ls2JNeAqzwKDnrjliQeBuctWYBaZ8fH?=
 =?us-ascii?Q?iXy3qSuzl5lKNXimDJvsAPB3sirlnYUK9axfZv0b6wrC6OocuC4OiwVZ2YQT?=
 =?us-ascii?Q?+8/SLLuoIV18FCq/lFkKPBtz8C0KmP196MP0fH3oPEkJExNARy2gORx0PXYV?=
 =?us-ascii?Q?edh9SWS5sq8N376hUy8KvojRbLRDRlC1iREFqlMhGNeee0nC40OTAPgKzkZC?=
 =?us-ascii?Q?wTgYDJNfGiUwp4AfGQrIkxMHBnOVKFa3RBPPWnK3n1NJTTaexGPFGJ4J5MPu?=
 =?us-ascii?Q?s8miMB0w4ffZtvPynoDqNM4ixvkFZtm0BoOVqS5V+5Lz5+6ubXoEfO24OTwg?=
 =?us-ascii?Q?XhF9mPnl4203g1RDQj597IOm+ncXp1YihNL2xJp+xo+grs7WUvjmOX/VXDFD?=
 =?us-ascii?Q?qlaYqGJQ8TUbwdqKNUeNNpD8ATBDtrC/BHmPo8lu1TJGMLakofNVjlQVnpN+?=
 =?us-ascii?Q?1HxjGUHiiiz77ZT8bCCv7UtnJ5Rb/UZG0zV6Es/YQB7SU+hoatANnSD7Dmh3?=
 =?us-ascii?Q?4yqvUw+NIoHMeUa8AwvKewFBe8zZzmfRsMHrqTin13wAgkU9LRRVmY3m5NsV?=
 =?us-ascii?Q?88+HwYhAWV035JEiMUo9bZ5iNW7AVDGKj76jNpjZmTyLboyjMQJyvehred8d?=
 =?us-ascii?Q?JzWpOLPcMP576U6xMPSFwiCyXSNZT7jCg9w19KzljSpWsxlyG/na56ox9Zps?=
 =?us-ascii?Q?nFoyv8mBKWZ+QMco9x0o1Ncme5RFzFYUIdBap+rI7VXT2zAR8igv+/pJQ3Fo?=
 =?us-ascii?Q?sRDbgPEsA64DZes031niYNpn62jgxnbBrMQPaxPi3bz4pQDaHFirX6EpipoV?=
 =?us-ascii?Q?6NWn6TrHk34p2lSCeD6eq+Db/nRvaKq3ede1nd3oeqJfl8UdkugH0vjy+DaG?=
 =?us-ascii?Q?ktmKV3Fg9I4c3220kl2zvLdjrU1+oIWF08Shrk0XInlHYdVq+QSNuCyGVN81?=
 =?us-ascii?Q?iIzG85pX1giuzKko9fPz3aNYFRdEOyga1f9L9bimbjcWHJ2YwWanGjvv1/6V?=
 =?us-ascii?Q?LvCKClCskk+TF0AtH4mssm5loLCtoGYavZ/p1cPAPkf/4y8QJQyUiluyiKnx?=
 =?us-ascii?Q?5BYVcb+cgWQPDtSz97xBVC5KJ8T7+vWc8lrBfTdzRoZGEiCNdTv2cS/ltCxT?=
 =?us-ascii?Q?2LnpIHPhdT761kffOYhOfiIbvpOnBR/H+DhMzxT77kX+PNg2jzSpw8v84g0a?=
 =?us-ascii?Q?3mECPsmwfpEpm8ZWjVDUOiRx9LTHoKICH+PTlLeXMnzIzbCcLANnlaMN3aOW?=
 =?us-ascii?Q?fzapJtxgB2vkEgis9bUIc37Lu0va+jsTTGtjhVzUOdaSwZ+ZeZEzvTA3oMpm?=
 =?us-ascii?Q?8IgHA3yXgczznup2AuTFxnB0SEzLCo6XG5YRn0XOvIqgq/qHToJm2pO9xW8x?=
 =?us-ascii?Q?pcub1dN05xYAq+qxTNzSkZ7Wnngc5EZJHkUTNAikBT7mteBYq0/ZpwvgMHXe?=
 =?us-ascii?Q?fINvqYzKIfWDNQsJD28nBllcQSLY7EWnpDOjPqnydmd9mpwlopkylPL9LZcm?=
 =?us-ascii?Q?/CL/Tznc98MobHBYBAyJXskg0qvdijrWnvaLuvWrPrUqgXpXeWhFw5nMD950?=
 =?us-ascii?Q?Tdr687DZKxNO9KmFscib8hgj0Yn3gcLzppRS6tGd+B/8LzPEBxLNBhoF+q6Y?=
 =?us-ascii?Q?+MlsG5+JzWuwAOpIz0fqB/DCPx7LuQ517jEczBYsZEa5SaD6aN4yG35At7/9?=
 =?us-ascii?Q?AtQcwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:21:21.7285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4f05e7-1abf-4b5d-4539-08de5e13eda5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
as fence address and writes a 32 bit fence value to this address. Driver
needs to allocate some extra memory(at least 4 DWs) in addition to
sizeof(struct mqd) as mqd memory.

For gfx11/12, sizeof(struct mqd) < PAGE_SIZE, KGD allocates mqd memory with
PAGE_SIZE aligned works. For gfx12.1, sizeof(struct mqd) == PAGE_SIZE,
it doesn't work.

KFD mqd manager hardcodes mqd size to PAGE_SIZE/MQD_SIZE across different
IP versions to solve this issue.

To avoid hardcoding in differnet places and across different IP versions.
Let's use AMDGPU_MQD_SIZE_ALIGN instead. It is used in two places.

1. mqd memory alloction
2. mqd stride handling for multi xcc config

v2: Use AMDGPU_GPU_PAGE_ALIGN. (Mukul)

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: David Belanger <david.belanger@amd.com> (v1)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c11535c44c6..8c6edb0f58dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1239,6 +1239,14 @@ struct amdgpu_device {
 	struct amdgpu_kfd_dev		kfd;
 };
 
+/*
+ * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
+ * as fence address and writes a 32 bit fence value to this address.
+ * Driver needs to allocate at least 4 DWs extra memory in addition to
+ * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
+ */
+#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
+
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
 					 uint8_t ip, uint8_t inst)
 {
-- 
2.34.1

