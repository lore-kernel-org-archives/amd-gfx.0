Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B6FC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 12:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0523310E0F5;
	Fri, 19 May 2023 12:21:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FF810E0F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 12:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9ghPlC9F+J4101vDCw0mEomGLea5Sx+QanCQjuVLRFW0BG4gMoUr3nEWz5KWzQZsLI2cXZc3uAgyuWEoMK8XEG9YpxW7EmQf08cO/orZWi1kgwkhUGYe2bSjLH1DbPue8cjwYTawQBTTSnFKyI8IvOBSTsfTKCeOz4YWtNCW4UnpH+vXUkRtSqTyW5LPdUiMewJODHcxg0ruG/nSBuu6OIIgqq2kc8cVpGNHTwVtrP4Ft8Zu/ZobrARf6e2X0McYKzqiH8n0DBh+PKlffrxaSZA7tDKaTWFwchkHkGOmfdz5A54MuBthsF0VpLAj/ZNa6E29nzbszfCZXnNUldsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Tt2J/YjZFKNXd03TiQc25G0z22FmWFIR7HX0byKupc=;
 b=YvPaMaDa1OFaEyiv+z/0lEVgkfbwS4LKVS37mLQzQQ3PT9p2/7if4r/sASwK8thUo32kX3IZpOWYDFLOP1znQEzSTc6fuE7Hi5huAHRvayP2EB1m3HADfRLAZu1Sq1pG1VMj2QWJ1Q/P6FGL79AlzwW5eF88HjsEVnTnJjx1SugSowobmjybkmyZqGMGNmN1RF3FfMIAFwEFnXsWwazhZByesX2Ptty0bspjCM/ldN/ZvvsgDZh/CggYcv67ikkruBZCN2ixoWHxc4jUKjs1kS2SbAPNTvXTrCVW1N+erYEJXj+LX+sgKC1O/nt+Ssxqk5Kbw7VZZZoQn6UeZn6jBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tt2J/YjZFKNXd03TiQc25G0z22FmWFIR7HX0byKupc=;
 b=IKyfIhZ4haCjj4VM6uce4xc8jzHl7xbUZJtRVBf5/QmUHpjXP0gfMtFbPXqY5UC/QFWubKFsXvrVCJhF9Waq5mcl/3AqmdzUOwQtRlLNp9t/QZ+/L1e7MDmFYjk0zhOvcTh0kW1l8Fg0zrQHrSsLyIGwQGCPZPbU/FWZJPA/Hdg=
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 12:21:42 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::2f) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 12:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 12:21:42 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 07:21:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix unused amdgpu_acpi_get_numa_info function in
 amdgpu_acpi_get_node_id()
Date: Fri, 19 May 2023 17:51:24 +0530
Message-ID: <20230519122124.328736-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|PH0PR12MB5434:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cb2397-4e14-4016-9830-08db58639aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPBgX2utV/gQCtj1rExrmCjlUtuCyXb/YgnwlEmD4mS+mQDmEMDzHdDPoEDlKi5tur1LDLA5eHrHAg8H+UWJR80oJAdEIY6O4hDxqhB8csv7WyQ35kvTXRbwEenqgf2je+WCtygxNXRcY/A1hpqjnxAr0tnmbr+cr4G7iTRyrvcew2LRbf7yE9FAUsB/VQO9t4kGeptk4nMECnuZ0exhgEAJE5hiMgiCeZm82ij1ZAPV/37EbvuOYyHfwApX8K1Lfj0RFSPZWZhe6wXFbjCb0DAPjD6f4DpK4W749AgAK8YTngW5AsinTynJrX3Auq9Ynp1dTSh44GwxqGhDmtjDlau5G+2oTfnOhHTddWagr0wRISASu+4wyPkSqcxEc4a/icI6mKli+gFWMAYJTRmvNHTjf4u7hprNXHxLiZbI8LHazQ/eUOA08W2ZAIlswbIV//eT56CGIB1gHZki8F6VUfDxZBVTNSy5gQwUHYorLCuxaAcoZO7svnCo/LT5mVi30TxhJD23lYUD89XvRTbKhd86E6JJFl6rPYVu/2vAlUUleEN4yARHgcppi90m7ge74yUTNm2MhPOHNonIY9uRaR4HAOMygLT4AlHbQ3aR1m2uHiPkeaCriBK/Ch1LpdbJbjW1xFHlWr5EjU2wx6xJwgM2HO8mQ3/eW9ULBKr2XQ4CmQBPGQ3tyIvhWJds52ibBNsHYEaMfOHIfvQlwhtsWgJEKJWrkgwr8z+p6KIWytEMJP9fT+IrC/XV45W9bA30REmRnqEJ+3QXjSTttp/yXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(86362001)(36756003)(2906002)(40480700001)(36860700001)(7696005)(16526019)(426003)(47076005)(336012)(1076003)(6666004)(26005)(186003)(356005)(70206006)(70586007)(82740400003)(4326008)(6636002)(54906003)(40460700003)(41300700001)(316002)(2616005)(8936002)(8676002)(81166007)(478600001)(110136005)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 12:21:42.0979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cb2397-4e14-4016-9830-08db58639aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the below compiler complaining error:

drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:860:33: error: unused function 'amdgpu_acpi_get_numa_info' [-Werror,-Wunused-function]
static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
                                ^
1 error generated.

By guarding amdgpu_acpi_get_numa_info function,
only when CONFIG_ACPI_NUMA is enabled.

Cc: Christian König <christian.koenig@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7150c09933cf..9433596076d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -857,6 +857,7 @@ static inline uint64_t amdgpu_acpi_get_numa_size(int nid)
 	return managed_pages * PAGE_SIZE;
 }
 
+#ifdef CONFIG_ACPI_NUMA
 static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
 {
 	struct amdgpu_numa_info *numa_info;
@@ -886,6 +887,7 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_info(uint32_t pxm)
 
 	return numa_info;
 }
+#endif
 
 /**
  * amdgpu_acpi_get_node_id - obtain the NUMA node id for corresponding amdgpu
-- 
2.25.1

