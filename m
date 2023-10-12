Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2201FCDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 07:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A545F10E429;
	Thu, 12 Oct 2023 07:35:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1892410E42A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 07:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeTyWSMu9aM0712SUSMFbbA0qfplnQ97yRMVIbozh5kCiQiVQDQxoNdB5aGP8VN0uxkUpLVnw8A+QPx48ohG5ro9SFuxxXwN3ctU8+3uP/h+doklSJAvJHW1YyTnbq3mysnDKiZ1AeUfe8xotz1s/AFe5KLuHDwmdA8tYlUoCbJ6eK7bfccedZPKTJMEMPfW0TAFC5tYQB77otTStDsD2u8CxnjkNzqTFxYQUnXg67jIa9JQIlf9iuax4z4AO0rDZYXt096A07pzMkLjYmY7d7N/609e7CyotXU/O+gMev3cyeTl+L2/n5jSHXPR1F1dF/k35bwWL4Ljjf0jQLRHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kctoNhURj1bMKzJZeXyCAbWlOVD8tr3JuKy+qS5/GaM=;
 b=gD+g2wlvnSRGw1PSYadPEB+bBsPmyjJZSY6s6vKUO3k5ru7EBJKCsXyDv5ico3VMgKFup3G57LHhEvQxY2CjJJDI9CPbkFwlISH81O3xfuT44LGkX8iJG6LiPXeUf9z7g3IiVQIf2ftaNUlJKGOD6OMyYqimZqPWJmFsqSa2reasVQpX0gBcu8emCouYEhCqSh+Xl4bxXdxB5NAv3jknlK2RKYAwo0A/JLdi+THvN7pyxYGOwtsqHWONP2CxJikYUWV2kDK+L1nZXFUEF7lxBwx0dpJCFVQubp7Fwc5Pj5hls/VTjwHT/KQmwmNNO1qKhAi9w1vWOSPHWjL3yw04ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kctoNhURj1bMKzJZeXyCAbWlOVD8tr3JuKy+qS5/GaM=;
 b=LXhEnGLZBp670YlbGjAk+QfSyJjBnYNyfD8QlYgM59DImUzrxVZQeUprwjVnh9BiwaXNq4JZOguPwXMXBTxoCm4vbiR+w9fxIW1J9uRP8S6PH4Mg+wY3ZVzOmtTkhFWA+KKQvFTqO1brnDc0xgFRpFEsPnGQ8gqrGoMp5x9qVoI=
Received: from MN2PR18CA0017.namprd18.prod.outlook.com (2603:10b6:208:23c::22)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 07:35:21 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::66) by MN2PR18CA0017.outlook.office365.com
 (2603:10b6:208:23c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 07:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 07:35:20 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 02:35:19 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/umsch: correct IP version format
Date: Thu, 12 Oct 2023 15:35:05 +0800
Message-ID: <20231012073506.1076224-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff33876-0a95-478a-d49d-08dbcaf5ca1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqYhWw94hUsBHm9orAl7mXqYBOmwF9bG25ZJS2oZ8XocyiDwsVLTAJylgwzKpKju75PpZywz+FaQV5qp6vMmBIBw17Lr9f8584xMPeRGzMXAijqdM5JU9BkLJsCm7uBZBvT1DQDEBS3EH8EBbt13mnoUudN6c4ItuJhAA8meizyQVIgd8O47vvvDhN7AZJSj/+DmN7PPNbLuMMBd/tZVFawUpBT915ADshSqpxiwaVixdjl3qxKEftbnd7ta7dUO2dF/wXTm/E7Enbz5HDHpkPurYpXkHz/QBeISA0Cb5UaXEAdqbpl88aDVEz7V1PSN/g2Kce74UzUSUrLMcrXdrfL/qFStJEg9zFWt5BRdIHep1B5qbPE3aeGH7JIAgxn54Izy9kRAtv26qX/TkxBRPkMG5jtrbCAGK1LaSdyko5kNpDPQPyfvNX7gbDmtKPnFI8S3fwPUfhPbNulz3VhzwEYM1jd1eCEqX3kocaCwvFZf+yA5leJQctm4x+z/xfntgYhoC3ff8jGToU2ot5+KVLnblppCjGRR6DAx4FBR+fOmIfunbrQA9EuZVyuJEMxRlZktAs6uk93NgvAlH/zyBHJraskZFeuBDcfPFZaa5oQDFshfBi0yJXQ9vy9S7aTc2E1/F2i4Ey7H+K22TR7cV5GYq6G/gbZvdAHpMda4F6lRrNRyS1ehUWUrWgl4veAMfH7d1z6iSvRfGlQzJmpUkB/CFDtn/X0oHu9er1PuL/ItF7gMtu9j1dUS3I6RZsQmy4vguKYWqXbdfRzzbhFHBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(426003)(40480700001)(83380400001)(47076005)(2616005)(16526019)(336012)(1076003)(8676002)(8936002)(4326008)(6666004)(26005)(7696005)(36860700001)(478600001)(41300700001)(2906002)(316002)(82740400003)(86362001)(356005)(81166007)(5660300002)(6916009)(54906003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:35:20.9470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff33876-0a95-478a-d49d-08dbcaf5ca1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

FW uses IP_VERSION_MAJ_MIN_REV format.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 63917e2b51b4..8e7b763cfdb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -285,15 +285,18 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdgpu_umsch_mm *umsch)
 
 	memcpy(set_hw_resources.mmhub_base, adev->reg_offset[MMHUB_HWIP][0],
 	       sizeof(uint32_t) * 5);
-	set_hw_resources.mmhub_version = amdgpu_ip_version(adev, MMHUB_HWIP, 0);
+	set_hw_resources.mmhub_version =
+		IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, MMHUB_HWIP, 0));
 
 	memcpy(set_hw_resources.osssys_base, adev->reg_offset[OSSSYS_HWIP][0],
 	       sizeof(uint32_t) * 5);
 	set_hw_resources.osssys_version =
-		amdgpu_ip_version(adev, OSSSYS_HWIP, 0);
+		IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, OSSSYS_HWIP, 0));
 
-	set_hw_resources.vcn_version = amdgpu_ip_version(adev, VCN_HWIP, 0);
-	set_hw_resources.vpe_version = amdgpu_ip_version(adev, VPE_HWIP, 0);
+	set_hw_resources.vcn_version =
+		IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, VCN_HWIP, 0));
+	set_hw_resources.vpe_version =
+		IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, VPE_HWIP, 0));
 
 	set_hw_resources.api_status.api_completion_fence_addr = umsch->ring.fence_drv.gpu_addr;
 	set_hw_resources.api_status.api_completion_fence_value = ++umsch->ring.fence_drv.sync_seq;
-- 
2.25.1

