Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F94C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 09:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE8510E636;
	Tue,  4 Apr 2023 09:57:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE83010E636
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 09:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cyj0y7SieYW9aGV3zH9Dv3HsAh1/wCHG2T/XnHVHZO8RgBUC5/vow6T1OavO0lyMGRZkm+s9LsgYL9btwpu0KUEkufhWzbUe3TlZXE55jwsLnIw4d8JZq++lGBuLWhOBcq3USMw0pgzagP73a2cLPYfPknDGUTSgEa/lW/zejiZA1+TTro5Z7TFFKMHeakVjL2GhMFiuAn0Ia0YGbDJasQuFpneRGhu0INL+PJZSKxO+vcpGm89Nliybu9gG+GP9AH69mJI+fP+N6AAibhcIqywswpRwiop6lldZBigDP9SBnDJ81+R4fOCd4dljntqtOsbCg5AjjvB7ztEyZmogbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jcPKawFCgsBq1yxge18VjaEqjo6oIPn2jRPX+dbOZ8=;
 b=Hqdf8l2RJXqkjrq6RuOjeQLEjDrwRUsbJhN63XfuE39UwDankd3off9+xKTwER4F5JC00L46fZRc3PNbOHmNCEw1OQp6eKNz6DagasNje5uzpPT84T7R5eYiBUK9llRxSG/XH/KFnEDjTMhwle9CX5i4da7ZPx1P4fBdL8mvSw2kg9NsSo8SQC9ch8IopSCk+xUIoE+cZQtc64UzratzrKDFjjGewIKK9vj7iUoyecwZ2f17uoxwW4ZFbrsG5xsbbdil2/+FRvv/hJCg/kfUKDSLELiu0Xy7h0W2VrW0DtF8IEO/uvl4Fw580CgnvhRh7fgItPYfJffWstK32k/Caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jcPKawFCgsBq1yxge18VjaEqjo6oIPn2jRPX+dbOZ8=;
 b=DLOx4dt50epEPi6PSUz3bEmb7Vr13Xe7Src7pH+MqJZPZXUGXqo5GXKfZ3YgPWGltcE74BfVOkMKstohMMtCKYMUZ3acoXR24gCcmVz27aH7cPeMq3mZTMYVa0iZISMfI6xkUKspkBVhWtmssbB/gHRqCRZ5JBwGxMEDeDr9HEw=
Received: from BN9PR03CA0868.namprd03.prod.outlook.com (2603:10b6:408:13d::33)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 09:57:25 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::58) by BN9PR03CA0868.outlook.office365.com
 (2603:10b6:408:13d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 4 Apr 2023 09:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.16 via Frontend Transport; Tue, 4 Apr 2023 09:57:25 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 4 Apr
 2023 04:57:23 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <felix.kuehling@amd.com>
Subject: [PATCH 2/3] amd/amdgpu: Inherit coherence flags base on original BO
 flags
Date: Tue, 4 Apr 2023 17:56:39 +0800
Message-ID: <20230404095640.3277840-2-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404095640.3277840-1-shane.xiao@amd.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acf5c6d-3d66-427d-1937-08db34f2fe13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntdxSeRLYBWYlmC8XxMNJjDkziMSBTJA2B7DaaH2/aWCj5H4ykDuIfWUcSC5DEDFTqsjo0sdf2Wj31TxJlNfTQI+yolIvYoa3A1DGib8iOCu0xF5yHnjslVwIjbfH6putJWfEem1iVtzITaznBPOxgl4Y0IZrr0VYG4QQwYQx1KfAgnc7ufam08nrFnvOPX33iL9nrpDkv4TAFtp8qXZXpxCOwmMaTkerCKuptLRVH98MJc1Vk14mxhnsY+lTW5kXYOFQmuFbpAAXMkQYTSFHZTTKUZqU6T7BbS6qgUYhr1lAbmuOaQwBt0yYdIUEYBOn28/O55iHC30OY+hIHkziqcPnGQYonCXp1nu4ywl9OfNLkaAaMmmYmev5dXH4+n1psrh3PPLRoeU4JbmxnmW4KAo4fzKpOC6KJTPIIPknaReE/DCmZqeXwj6P6MoviinpYFUoXczh4V3vc6E46VnHoCDM17ZACPpbVUWBDrZZt29q8pm7KKKOS6hF2KRZF6S8ig7rjSLiyKeF+DrcXAn5tjU5kwyjQeHaXox7MqlNHjasC8nLkDUXG5BkrWFogTaEGr1+tpNrvUmuYob6QI/r6YPDhGx2FsncXkSLxaNwBhLYpA8W46lpL/ErgAWmQu8vARtH4tH998s3YrnX7oNhcQb0UfvzIndwwvJnNVTeAEoGu6PLuk0fOdpJebWpNpeKHLotm1G5D+bsu0m1di07vUrDq3cV7OS/+FBHaNzC2s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(478600001)(54906003)(6636002)(110136005)(316002)(70586007)(70206006)(8676002)(426003)(336012)(1076003)(186003)(26005)(16526019)(36756003)(2616005)(40460700003)(47076005)(83380400001)(2906002)(82310400005)(6666004)(4326008)(7696005)(81166007)(36860700001)(356005)(86362001)(41300700001)(8936002)(82740400003)(44832011)(40480700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 09:57:25.1982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acf5c6d-3d66-427d-1937-08db34f2fe13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919
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
Cc: Shane Xiao <shane.xiao@amd.com>, aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SG BO to DMA-map userptrs on other GPUs, the SG BO need inherit
MTYPEs in PTEs from original BO.

If we set the flags, the device can be coherent with the CPUs and other GPUs.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 33cda358cb9e..bcb0a7b32703 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -253,14 +253,22 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
 {
 	struct drm_gem_object *gem_obj;
 	int ret, align;
+	uint64_t flags = 0;
 
 	ret = amdgpu_bo_reserve(mem->bo, false);
 	if (ret)
 		return ret;
 
 	align = 1;
+	if(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)
+	{
+		flags |= mem->bo->flags &(AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+				AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_UNCACHED);
+		align = PAGE_SIZE;
+	}
+
 	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, align,
-			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE,
+			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
 			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj);
 
 	amdgpu_bo_unreserve(mem->bo);
-- 
2.25.1

