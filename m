Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4D8C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0755610F388;
	Fri, 21 Aug 2026 16:15:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eofqO/8O";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350BF10F384
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W44naOiQC3CMCNuSU+KK6ft7az8r47ZuqT4FmggXU5yEs7giw8VwEKre5IP+tHnjnb8flaHXS01T/ZhQs0wH1ilfc0N+BxhGhL4DfgTe3eEmGXckX0kATXMW/7wBTfMKlfLGIrgIWtnJCZRv4nkHInAP5U4blQeT1xOsvpdvqu40z9kSOInTiNN901Z1gEMYyHrbuMQXsCWdpQznYizlq52l6j3AfE2KDqNACfGd1Iat6legei8oLuFDwuDbR+QumcXl4x2bAHtY3VrwW9Z1xpx/IsfXJrQyyLpqH6C3d5WFbyCazHykxHBOpsZN1lt8n8/PMROIt8t7rUt1/DMxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmQOmZh1Rlrznh1UzIw2Sxes0uGNhL1J3NYdfYxwn+U=;
 b=xW+iqCPK299wNSUoxt4UV8hoEpc/sx9SZ3OcNEnGFfKWUNu1WH2akg2R+BLErZ+umsxdmav+kvQi+VooVC2of4AAdCywCg0ZmNH6KAwnQcyOC1yjvfZhMqvyj6FawObi3AYiHm6r759r6JWLpgEG1UXa+vS73IimdBtVd/boUGzM7NFWC15i9fRIphcTMjzhRRxrnVvpnDAgsLVlo25LheO7uKl7SOCobvPzpgkOsPAsrfBib2rdBA9HS85dyFX+9TWp1uBaxM8ovS2pCNqypLxJfHLkSbPWYAFzGlr3Pr0wWSa/YF5qt9TAVAUmf91nz1zXlTh24ns9f2Xy0SuLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmQOmZh1Rlrznh1UzIw2Sxes0uGNhL1J3NYdfYxwn+U=;
 b=eofqO/8OJp9yLl1vCNsDwF5Da+Wm6n6tX3T1D3Ka+JzDZD/RvdDjE3UxXGaJsD3e35nzWCHif7o8CgJSQM8dyJXad2sKDqetIcxk4zDxtkiz7Foww5QHxM4Q8LqrpDoR1bAkK3bn4bmHVKBvDTRllXdGW70vibcj1FEy9CtzerE=
Received: from MN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:52f::25)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:15:13 +0000
Received: from BN5PEPF0004698E.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::6b) by MN0PR03CA0012.outlook.office365.com
 (2603:10b6:208:52f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698E.mail.protection.outlook.com (10.167.245.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:15:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Candice Li <candice.li@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/14] drm/amdgpu/discovery: skip MEM_RESERVED_INFO on
 unsupported ASICs
Date: Fri, 21 Aug 2026 12:13:58 -0400
Message-ID: <20260821161401.754042-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698E:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 1871e5a1-fb68-46a9-7578-08deff9f60ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ng8dSpWNhjGCzvwAWom6lsEwHciEbkEoL/4pdIg1QY9y0rW1afAZGgMF6DE5xwf9Yp/xVeQhZxKuey4oIf1955I69U4raAX5Eiz+HlEPULnSOljrHEU6ZVunG/GuAUliLI6B9xqezUfNCyk57yx2HfXdUEQXGLbhRXHDfGyvkOqQH1ZKiwauhIxlk02XfKj2d/fl0C+BEClDLduhd6+D5StLJ00B57ZUL5jGlwL2Fjc7NNJt8mFT46O8TjyvoL26f02tL1tNzAApjO9pGPcUiVg0JBYHrmQOClYLNU3pTOvhw1xA4hT5KhOGZwJ9L5AeBcEbzyxXUncVjuHu/kbMyGj9HLEloCJLikVhqmz8zg9AImYnKqv58UOjqvSHDS3eak99L7PJhltPAhtQWCOFoxzpJT53glocxO7lQo4OmUkb7smjKYRq2eeMZD8TPbufxuGYdcCvmLMgNNJOW1942sE7KtzEkmoeU56tIUoNmiFkSDdOSQp1rQTaFLpvarvjJZd90D973XVsC5crOimLYiHsKg0AcW9K5y9YHJVkC1vpvHBa/3gTj+/jH2IrfDn8a9lnzPweao2hBzMXZWc2GMmpHG6HEZKrFY4QnsIkKXxPLWauUNKi+1XKikyY9Z1my4Rvj+uiq5XlSx/QmqG061D533ZAP+V1K1gAvQZduMOKCMFIDY4k/RZaFt5dlRXUQZzzcR8mMzOPOTAgPsytKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NrPecaVKVSExyzy6XYKODFnGwmapc5J8ulGrB5n7LBAg9RYJ2rLp0pI2H40PmqkwveZmAfsSSb76F7X48gOOmgf6nxZcdURzgcjeBMwPaeYH8NrPHpp2fC7fXWOtp3EGOaEuYmy5aUHkAESrq+9Izv70e2DTLNTlJoOTKwBJwgEj7ASm+kIfsayGeLO6XNdwmt7jnHICS93tNm4Ka/nul4U2x4Y33mj3YfXnSNlXByRa3B8htQFjYa+3YMiDjlQ8oEup/l3j5u9kwOthnLhKN2FDoThVsN3RX4AbYEAbwtFMw1MsjuLxx1ukdCIkZHOTNXNq/YNUsuJN2l9sZLExB/RZ43KJsM4hstj6wtuPF0/uMfMryOUqhgHfbivx4EFhbxiq6iC/nehxyOGY9JCzvFjaIJk2Qs/x6+Df3iCDVkyNeL5td56jgq8bxiAzt/zB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:15:11.8855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1871e5a1-fb68-46a9-7578-08deff9f60ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

From: Feifei Xu <Feifei.Xu@amd.com>

Some ASICs' MEM_RESERVED_INFO table_entry may carry non-zero garbage,
causing signature check failed thus probe fail.

Move signature check in amdgpu_discovery_get_mem_reserved_info_table(),
returning -ENOENT when invalid so the table is skipped.

v1->v2: Add discovery binary header check before populate the
        mem_reserved_info table. (Lijo)

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Candice Li <candice.li@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9bbdb9cba5018..6f3da085939b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -685,15 +685,11 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 		check_table = false;
 		break;
 	}
-	case MEM_RESERVED_INFO: {
-		struct mem_reserved_info_header *mrhdr =
-			(struct mem_reserved_info_header *)(discovery_bin + offset);
-		act_val = le32_to_cpu(mrhdr->signature);
-		exp_val = MEM_RSV_TABLE_SIGNATURE;
-		table_size = le32_to_cpu(mrhdr->size);
+	case MEM_RESERVED_INFO:
+		/* Optional table; signature is validated in get_mem_reserved_info_table(). */
 		table_name = "mem_reserved table";
+		check_table = false;
 		break;
-	}
 	default:
 		dev_err(adev->dev, "invalid ip discovery table id %d specified\n", table_id);
 		check_table = false;
@@ -2497,7 +2493,10 @@ void amdgpu_discovery_mem_reserved_info_sysfs_fini(struct amdgpu_device *adev)
 int amdgpu_discovery_get_mem_reserved_info_table(struct amdgpu_device *adev)
 {
 	uint8_t *discovery_bin = adev->discovery.bin;
+	struct mem_reserved_info_header *mrhdr;
+	struct binary_header *bhdr;
 	struct table_info *info;
+	u16 offset;
 
 	/* If already queried, do not query again. */
 	if (adev->discovery.mem_reserved_table)
@@ -2508,19 +2507,37 @@ int amdgpu_discovery_get_mem_reserved_info_table(struct amdgpu_device *adev)
 		return -ENOENT;
 	}
 
+	/* MEM_RESERVED_INFO only exists in binary_header >= v2. Skip populating it on v1 */
+	bhdr = (struct binary_header *)discovery_bin;
+	if (le16_to_cpu(bhdr->version_major) < 2) {
+		dev_dbg(adev->dev, "header version = %d\n", le16_to_cpu(bhdr->version_major));
+		return -ENOENT;
+	}
+
 	if (amdgpu_discovery_get_table_info(adev, &info, MEM_RESERVED_INFO)) {
 		dev_dbg(adev->dev, "MEM_RESERVED_INFO table entry not present\n");
 		return -EINVAL;
 	}
 
-	if (!le16_to_cpu(info->offset)) {
+	offset = le16_to_cpu(info->offset);
+	if (!offset) {
 		dev_dbg(adev->dev, "MEM_RESERVED_INFO table offset is 0, invalid!\n");
 		return -EINVAL;
 	}
 
+	/*
+	 * Only populated when the signature matches; skip ASICs whose
+	 * slot points to unrelated data.
+	 */
+	mrhdr = (struct mem_reserved_info_header *)(discovery_bin + offset);
+	if (le32_to_cpu(mrhdr->signature) != MEM_RSV_TABLE_SIGNATURE) {
+		dev_dbg(adev->dev, "MEM_RESERVED_INFO table signature mismatch, skipping\n");
+		return -ENOENT;
+	}
+
 	/* Cache for subsequent lookups. */
 	adev->discovery.mem_reserved_table =
-		(struct mem_reserved_info_table_v1_0 *)(discovery_bin + le16_to_cpu(info->offset));
+		(struct mem_reserved_info_table_v1_0 *)mrhdr;
 
 	dev_dbg(adev->dev, "MEM_RESERVED_INFO table exist\n");
 	return 0;
-- 
2.55.0

