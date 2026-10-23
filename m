Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E65606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=syGGkbFr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0036010E403;
	Fri, 23 Oct 2026 10:13:05 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCEB10E627
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 10:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX+0aa4NhCBDoquLuiJiH4v6AjqoFugqJSbmdld5VI/tDiObz5OYjoWV0ZYaxH96hpfAaKHeQ1FZ4FDznTZ1QT2GbTJrzLK1dKQ4IByXd23C3Z2zHduBEfcwHc8fT3e5z3QjJ1l/C1OoaCAW8eLzuMT0o0oQ/zISx6FCsDPdwU2kPa7F2nk5Y6Sb0rdSLvLkHHrpE2nyWDuomlDyD5jWBNXL21kgErv1CSfKkoTAxEGkoMPbZYRWaQSHx8yej+UpdyWrG+4zSzVStF7B9XHwn+GsUAdufxzwXTH771/ciAm391mc4hwu8jTYE6VaXf5aXo0CMyw/dA0vlSgGR0c3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Sik21ImxM/BPlpAXszDVokpyTVgzKZVeB8oStjYk0=;
 b=viXOSQLKC6PXlx2Xt9Vyp5/D8X4fnqENzYIOKH54074HG63NoGpSPAZ0wxkG2A691kOizHDU/Rq7SEheJyWolDiRQZpGCApaZQWS10CwGOekvKeLsadnqWw4wuE44R7hcUBp5rwh/h01hjg2QuUh6LDez4wPeZMfo0ojMsqpCBWv24RswLS8GNaQ2sSBN4UmfdMWtyRA1h4IqYEKk4zC2IoGLmw4oLgEBvNMLBeXEnFYkVUHTYxTG5YnuqSScsEH2ai9dry5wHuNFPel5uhVgP21v8lTQGJEkQqJKmUfuOrBy4CCQmq3139UEKFPiJQ6qFMZHLGaPxwPq+Mll3p9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Sik21ImxM/BPlpAXszDVokpyTVgzKZVeB8oStjYk0=;
 b=syGGkbFrGJRdRdnz7eSkyKrFTtcCIIhOM/+GexhkqBGrc+SttHR5e77h9QKHNmvVReRloDZ9tyYxnOqlfUKmewYPcN9mvtvT9BJCy1zu7BXohxHmBecTLxd2Bf2u41tzNbDQyz+lLxjP3T8FQdDOdZa6WNV7e0eR4RUXx/Z5eAU=
Received: from MW4PR03CA0040.namprd03.prod.outlook.com (2603:10b6:303:8e::15)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 10:12:55 +0000
Received: from BY1PEPF00026959.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::15) by MW4PR03CA0040.outlook.office365.com
 (2603:10b6:303:8e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Fri,
 23 Oct 2026 10:12:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026959.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 10:12:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 05:12:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 23 Oct 2026 05:12:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <David.Francis@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: sign extend the addresses
 GEM_OP(GET_MAPPING_INFO) returns
Date: Fri, 23 Oct 2026 18:12:32 +0800
Message-ID: <20261023101246.937830-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026959:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fe59cd-79a4-4a1a-e963-08df30ee3469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261022105027099003|56012099006|11063799006|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: WokSqoVa/QQVNqqZHRV+Q0R3h0s0lnKZZ8dUJZMBlG0A5+zxYOAbtsXDMyMk4cqmQ+Gq3gZvzlvowCi8WBsI1fX35dCBigwhXrCw+QrMxI4Xcn6e7DoNFUI20sfw0KbggqAmgyS5odwDan3gGa76ZJjDyvGGBG5CGoYuNjea0zVfxb3UARcwdiBKW4UnWVHD9rbi1GbhaJ19EpocSVtEWmML+kBjr8iSilYS8c044h45RdaveI+U1Cf+XA4p1cs9SmPUGnFDOXl5+4ZrXfY4Y63GZ+o7SoAqUKdooPijINjyvp9pD70VN1g0dqSwsWTZ5xL5ikgBDGKCnDqPCvC1ygWsYSUF3UOhBQ54aXudmlb7eA2BZtPDPZU2dtUdtG9OtMGow3inDXJRx3IfnN6POl++1r5z6NVILCcU0Uxdxoutb5eTxATNNoFP3YTcME3JXNI12IAfEEfzs/Zx7pBb8lWNz6N/k48wi8uHOyMnsvc2VjEmodQxXVhft6OG2ZSa/96StDoR0T1a0l7gldOhDL39SKwIYoEa1vCLr+jsdhGW1okmF2ETEX3hR1d9uOFdD4pp0TXGRo3MCBlr5lmmAbJ42KNZgme5dGOH+KP6sse8ETid3QtH758zrv/hfhcmMvglSjmrtR4miQP5PmI4xaE7jfPpH+TsFcRj7Vg7HebpwTjP1Rzk3WMioY6vRIGY3gyNX5DEhK0unmi9zet6mQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261022105027099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HLdljldd0+ZDgMxl6pwH9Tstk7ZfHVLLUodTt1ozE/68ilB/VwQ+pWh2Rn8OhTlu77rgfOk55xtfLKoVybV5Dhe5T2WSXtXqknah5z3eSSUvRyeAQ9K7npGfJmSZ9eRpXUgwxcga2BLfhjaLVo2t3u+pxJuXL+85K6ywaieMs0WB04UNHcE884wrijTTdiyOpToW5qwfoFfBOTGWWBA/tUKwXcbipEfrLzLi5yTbDvGdEgJAK6lzNcBs4xmQEvQzFBOJ6UM+yy8ZNg5Fi3SMFEC/8jTAsFm2V3kXOCsTGKiFwU+KChnpzhe8ifbfMb8A/JBH8axL6ph11nGVMqRGzMobn5QK1SSgpDwOCb3sLoRiQPg/vh4L540uoCKKeS4DqMhb4XdFTAAta92QVHnLASMQ0nKl+ng9VDtbkXJS1jFhJrmVkDXChBQ8iTa6iu3p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:12:54.8386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fe59cd-79a4-4a1a-e963-08df30ee3469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026959.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GEM_VA takes the GPU virtual addresses above the VA hole sign extended,
like the rest of the UAPI, but GET_MAPPING_INFO reports them without the
upper bits, so they land in the hole. Mappings in the upper half of the
address space can't be recreated or removed with what it returns. On
navi31:

  MAP at 0xffff800100000000                 -> 0
  GET_MAPPING_INFO                          -> addr 0x800100000000
  UNMAP at 0x800100000000                   -> -EINVAL

Sign extend the addresses before handing them out.

Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP ioctl")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index fb60a99f43c1..c982d102614e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1082,6 +1082,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
@@ -1188,7 +1189,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
-				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].addr =
+					amdgpu_gmc_sign_extend(mapping->start * AMDGPU_GPU_PAGE_SIZE);
 				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
 				vm_entries[num_mappings].offset = mapping->offset;
 				vm_entries[num_mappings].flags = mapping->flags;
@@ -1198,7 +1200,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
-				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].addr =
+					amdgpu_gmc_sign_extend(mapping->start * AMDGPU_GPU_PAGE_SIZE);
 				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
 				vm_entries[num_mappings].offset = mapping->offset;
 				vm_entries[num_mappings].flags = mapping->flags;
-- 
2.50.1

