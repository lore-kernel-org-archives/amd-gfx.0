Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0820C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 19:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C4261353
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 19:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67C4261353
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C581E6E182;
	Thu, 18 Nov 2021 19:55:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617056E182
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 19:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agX1iX/fzrsbR2nPHGMO9n3UD7/Fjolukv0adjL0ZjStsY0e6ONTrAhM65VORzsk8RSaegIQpvkW7mjvr6sc5lWvvA/Joh+0T+6alyg+03BieWc1/BggoWpch6tA76pPC3GaZnjkEhiTaJkVieHFQur/egQ2ZXPuQlgP8/XNQKIAV5Z2UxwG2XjnqH+iDBVwtdfwwckAZC2JhKtV32xbjnoLloiPL6SCs2I/H3tH7bLx2+aePNEElQuY7ddKjtYXde7bY5HQ0cHTdGO7+nwVH12KXLEJrG51lUT4w6XPzIu4hCeFjE3WbxfV8f23EFNKVUItvZ5P6dxi64c2WC0rFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUsx1wtaBuWHTfLd7HEq0KUCzIFhxCGHO8k+pWCm2sE=;
 b=PKh2yGBCiak6+/b+DYr6A6pQW7VBMGQFN79Qhj8IwYBEuF+R3tPFpWkO1ROhDChR0wLEkiX9nbJHrL3tivN3d5onisrP1G+a5ob5bU6PCci9XWrw/rZjAwBsZ19cmCNZXWcwscfTEdszFE/PUlCIA9Z1S61I3pt3ggqmxmYTMUSa97yOHeKX/bHbKhAjBqRJsdERQJM8Ys5Dj/GNU84azgcTozIXfTaL3MNrynR/Re59AC54sQogcdquJafncc58Jo956NjoXM6LuLwQJpzxjRwLUmSKAoRVVTwkrh/SPLj8OTpA2fP4CgK16m3QLOudV2OFRvBz7TH0a6slvfMwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUsx1wtaBuWHTfLd7HEq0KUCzIFhxCGHO8k+pWCm2sE=;
 b=LhIVx55xj9iO3kn0D5OEwKw/y9bpjpHIgkyKYN1R234GnhjpOe6+XFFFgNYWQNUx79b8SROz0HBbBj/smeOCoS6cvOQjF3ABinXk1KKVtVA45gPC9tkODrONiDmUSiIAYs4F3d4g8QumrR1Zxj7In4GlqiTuyWrBPBBLpJWV4jk=
Received: from BN9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::31)
 by MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Thu, 18 Nov
 2021 19:55:10 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::8b) by BN9P221CA0011.outlook.office365.com
 (2603:10b6:408:10a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 18 Nov 2021 19:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 19:55:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 13:55:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: add wraparound gpu counter check for
 APUs as well
Date: Thu, 18 Nov 2021 14:54:52 -0500
Message-ID: <20211118195453.485901-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651d94a5-9e3f-4952-4b76-08d9aacd5298
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36133B21B1097F5D4D460E21F79B9@MN2PR12MB3613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJTrM1AXA7L66SfSH8vK+eQToKPmiu78lOR4iJi4WRMbx3Dq1b65VyThjDvUjktC3SM0HmdHkYT9pZLzm3HB3rtMxFX5ncjGuY24jfDao7mgkoXNBwIJXcLul7ciG+JQ4cs1R/uGvYGcesp9a25xVprWjdciQxLa8SJe8Y2QIsJz6hDhRdvmxJVnWNDLzzfWh452fYNZMAJXMwtcsVlNQlnbIkt0bv0aI//YlJFFUXag4LN4BgZyGqsLMIpnlMAQMsRpqM4XiUAjDYAK0+EhsaMECepaShs4edPeFcIrVW1Vduxol9I0tW5maK8ZMyQIdYwUkw0mRw/vZ3i3pcynBQ8HoeLFSnxGJtZRpULLsiYpWdHzSLz2d9VEjlmcXB4GVZp6GhazPxsPp3vWy7AqxNwtDXxEHBxZNbjZbD6fJhWM3QWA2Zi+qrC3AO3s9dUmLEgZ9EdSAeGFOR6RewYq9pNwx/pA4j4S8eR7z+rvHfO4xnwjrhrMfVmZECYQHroZuQLYGMeiNJtTCoRAX5mPNhiqXSrmfO9saBUggoMTBb85ZN8XhrddV0/4BGSw1R+xynx2RHlvNgTIK9FvomCOgYU7pjrQsKZejEdZhFmZ1RmgYBOHgxZANrbWv1FKMySFsHYLGdFeREaTYWYsxf9Ifop/fSRluq9FIhUxx2X+qhu0mD9C/TcYnGrcSOPbVZQTIsNsLnj/3w0OWV5FOswS4z62+36YxMl+DWMPAeOsK0s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(36756003)(81166007)(4326008)(2616005)(2906002)(70586007)(36860700001)(356005)(70206006)(83380400001)(6666004)(316002)(26005)(86362001)(47076005)(7696005)(508600001)(82310400003)(5660300002)(186003)(336012)(8936002)(8676002)(16526019)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 19:55:07.9926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 651d94a5-9e3f-4952-4b76-08d9aacd5298
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3613
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Apply the same check we do for dGPUs for APUs as well.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e7dfeb466a0e..dbe7442fb25c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7707,8 +7707,19 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
-		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh) |
-			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
+		preempt_disable();
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh);
+		/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
+		 * roughly every 42 seconds.
+		 */
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh);
+			clock_hi = hi_check;
+		}
+		preempt_enable();
+		clock = clock_lo | (clock_hi << 32ULL);
 		break;
 	default:
 		preempt_disable();
-- 
2.31.1

