Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1853EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DA710E459;
	Fri, 30 Jun 2023 11:56:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F2D10E458
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdHNh3VU1MJfidhmGqShGH3kGxfsBcYeZJ1FaKcwj5Ah+SjcQ1f678FuPuDcnMdgRdqE7n9h46nMwijcj2px9CjnN/M0MTupQi+D5uA3jPUpMCozBVZ6wG6mxiWf9+EIrqY4g+N+7MtbPq5QDegOu5X1hnWktfACh+pfm9bFDJ7CTTOdI6cd9l4RmiJmlZ5Imq7osRfQlYLK86MnkzI5G/rJY3ZfeG2o9AXBpg4RIJdgro2WBizdTlYnMmpU1TnKh5q2abqZv7T6BIDknuuAl+N5IdxBLPVUMjneq3wOlMLJBDZqSWoiDz2rqyapn6Y8QglVdvg5l6hUZ8TDqJhseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbSVQVviwYQATnETnL8J0jkbxyz3gCW3UVLE+HAEDbs=;
 b=fTsUJbK0CMwNMo4e4GIToZWXLU/VFUjnWy5neS2ub1+t7viI18S7unZsxlArNg9TgtZ924+fZzdx0IB6oLHFKXdywQvaXcqRGykY0NvVl5xSuZqZviORiuF1S2jFFJaaTV4513vaVQ+JKMLuR1KcBdKKw70gLNCLPfd+trmZ65qtgeEHxtCE0qEue+IjAE07CyOEeWQk6PCBqKGmGzIzVr1AxgpRMX6bSKkqYZbXOf8R4E/ZxzOO85jGB6J5SISalP3daodDX0Ukh5SbwEKSsX16CU7gx+FGl/eklk1NoN+3bV8ALClg7xGHyUQbPZmG6nJ+55lBWA+hX78sK9hJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbSVQVviwYQATnETnL8J0jkbxyz3gCW3UVLE+HAEDbs=;
 b=m9Sct8mgaPlMm50OW74oi0EGu8AaDpcdywEKbUxyaVq5P0Yn/tpPSHCTJpPc+lnPrAG0EC77pxhv8kqZDX8Nkw6qCZHzwnVviSbQRNIJTKpEgRU7ISzjE6MnJZjip2ZdRVQcQHo9cUuZ5qI+x7+DGy2m5pRdQcn2IX0LB99sxJg=
Received: from BN8PR15CA0007.namprd15.prod.outlook.com (2603:10b6:408:c0::20)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 30 Jun 2023 11:56:38 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::ea) by BN8PR15CA0007.outlook.office365.com
 (2603:10b6:408:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 11:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 11:56:38 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 06:56:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: Fix warnings in gfxhub_v2_0.c
Date: Fri, 30 Jun 2023 17:26:14 +0530
Message-ID: <20230630115618.2855618-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
References: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 349c9c5f-898d-4cea-00ce-08db79610f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZzVleZI15jC4NFtE0UbMy9NCBJ9N0O5IuSTvdfbKpi2CFrYrd9GxzLtiSfWDP9hVCSEcy4Ej+ndgC8JaSCpezL8LrYDwsaSO6yNzaIR5Cx+WkkjHfrL+8rxMPbH86kova7W/DiJE9EdsrIAl6V/c6qU5DA4qEGUKWxVWKS+lOWtIRKenWfUW+o6+tH9vN3RkSxoTszCPFx2ZBDc/7/tKTm5GLcCf7Di90oiT8FKDxVV45FW+FJEhM0e/0f3nJNjfbjI/Naj3raXz4D9Sxi//pJVtR4xRa3DGhGk3zAELEzAeXF5NPMAtwnZEeQCSoX+w2aUKjIx1M+1IAHM9TcuD7+X1c+2SbO2vVwWnS8AiDDsbPc7OFftc/2XNVr/5YeHvjNc7mSG2IUG3aGm4iQdQdr43IjJ51G8zjRrSNbkWeJ8LuesfGf/eAD5V73Ki2ModQ57bfjIIjcNswBnSlnUq0zvV0b8em3TZRiY1FFrkRxiN4w0PHpDq2thXJdfgY0eb6bWaTtWcWbi1t02knBi83cbzxkNMcYfLk5XHq7z1/BtvVNjkRhekPFnsCt+teTAlMrn6R9zb+bBBsZODmHVYRX0Ovr2BPOVbmecUim6ZE8lx+6/Sqwju/TpPBJiUk4T3o2B+xvmpJfIKB3D7LTkYsy8XGD9wn8AIwXAszM7Jigka3sFRsF+l/79ZOG7YwpuWn68Nt+BVQGsyFadHyVtBCYq44Q+egdYSdTwwG9ls+WvJSFKtIOUU2N+tzI/wZJuYLBA5HwvSaFYN09HfASwgrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(4326008)(478600001)(70206006)(316002)(36756003)(6636002)(70586007)(8936002)(8676002)(2906002)(16526019)(6666004)(66574015)(26005)(40460700003)(110136005)(36860700001)(54906003)(41300700001)(82310400005)(7696005)(186003)(40480700001)(426003)(336012)(47076005)(1076003)(356005)(86362001)(82740400003)(81166007)(83380400001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:56:38.2341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 349c9c5f-898d-4cea-00ce-08db79610f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
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

Fix the below checkpatch warnings:

WARNING: static const char * array should probably be static const char * const
+static const char *gfxhub_client_ids[] = {

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned i;

WARNING: Missing a blank line after declarations
+       u32 tmp;
+       tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index f173a61c6c15..a041c6c970e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -31,7 +31,7 @@
 
 #include "soc15_common.h"
 
-static const char *gfxhub_client_ids[] = {
+static const char * const gfxhub_client_ids[] = {
 	"CB/DB",
 	"Reserved",
 	"GE1",
@@ -332,7 +332,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0 ; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
@@ -393,6 +393,7 @@ static void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 					  bool value)
 {
 	u32 tmp;
+
 	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-- 
2.25.1

