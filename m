Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E89C072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 15:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D9610E306;
	Fri, 17 Nov 2023 15:23:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426A510E313
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 15:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1l6/qlMIXTAqBvuL4Kj9nxeLXhksC9KNDK6i9wcloj/qgdG8WeKkh07/MnZUAX079k9c64PxxZiK6MrJn4U68RsGQbL51ZPR1liiYH+fYW905swYLtJK9MU74D0MX/6XZVSYVGzs324PbD9sH7rdWQKcnA7Y5dw//cCU1MagEnvlcSqZXuZvXEDAij+87c7KMky8dbcksyNthDlxfPxSaOn4AMJb8g3SMfFpJ6XwTVi3Pow64twAsx0AFB0fOYfC5FhVMVzOm0dgffHNJ2n+wI79lLQ+0yLHqwqUYiDYK1ZGS5dpLxuDSrIDoToqPuwSxK4TPT/LtvVKrXUd/dpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9SxtTMAl8olTq14NTVBwjHA26C835W2mGAFUKOAp5I=;
 b=QVdJF1FtIIbuTtUPDsVoQ/31lhxnFIctoVD9+LHfdumZU2T2rKQO5unbWaehCsKznoZIG6f3n14Op0pWEazlZf83jHX6fjus+2mMdG7SqdUaidewB899wKiJ697T90lRcImWk4eSCAhWpHcO2AApY/etlmqM2iY/kWDzW7FRHi54ldIDYqohRIKjD05s4DCn7IGzCb9AqC1hKot9bv5Qs6GIlSySpESja/u7wnRz8YwrwYjKLpqRjOGRqJCd1rvNx6tYQotqs721nOPXwQytC9PQecuT4/h0V8lGlCFSgdlZVqqvW58Xyw0bO7aW9PAe2/U9xwV2F0ksl+Vm75oasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9SxtTMAl8olTq14NTVBwjHA26C835W2mGAFUKOAp5I=;
 b=3eArru6xzrN6kzUgsCESAW+gHTGNxbtKGrmrLgfqe4B75/7u+AcWS8U/PkmmsZ+w/+Xcje2pPOWu3CdnMwOy1gwtwt9h6rec7/mi6ezU+fq7c6R55ImBWx2itzF06IIyh25v1xXG5ZOpzk1sytE6VsSwo14RWPGNJU14CCVtpsc=
Received: from CY5PR17CA0049.namprd17.prod.outlook.com (2603:10b6:930:12::33)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 15:23:53 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::a9) by CY5PR17CA0049.outlook.office365.com
 (2603:10b6:930:12::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23 via Frontend
 Transport; Fri, 17 Nov 2023 15:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 15:23:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 09:23:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/atom: make amdgpu_atomfirmware_allocate_fb
 parsing consistent
Date: Fri, 17 Nov 2023 10:23:39 -0500
Message-ID: <20231117152339.28627-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117152339.28627-1-alexander.deucher@amd.com>
References: <20231117152339.28627-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: d07aa10f-9045-43ac-8f6a-08dbe781351c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptcmKOnSaqIM/42+dfrvc13ZTdln49sx1lAca1YKSlyTu4GwZ6ZiKGHjq4vMcyw4By+tnpSD7D6vtETEv+jc5uz/WZxITVmfoiQxpmHe8mHzaLCnzfUHkvO81qT1uAMUXaADPR8QuwEEi9bsifxn0p2pPkaIkDMFJljJkMe2q1Semr5IUqYkJ+6qF59LqAg3RRMmEC8V8Jn9tGj45umeWHw0jAbLdvRXwT2Kvvgciux+vW3yjUrKJeY5yfGcJS+Gv6UzWAMEyBfiWlEE1GOXH3m3j5HWZQa8cbMy9dUjgR8yzfv0wmSQH2ffyrMASShbDMWh2gd0k7ZvfIkmTbqwK0WOPIhL8yTcdF/asPhJsP9O3Bvgf4/MeUjRIbHqgF4dNWbJu94ahELbdOU59ToB9gqDMknw/rM7GQz9cy91m+JtsPb13FuYnc2TYZMJVBkEBVMGC3rvrqkybvMyTt9OLaGTjDEKOnBd0Y2iGf0HX6Q7djTkGYlJ4rW+xIaaYNl9nf7Rw7Db4OA2DKtF3VwaZJDsJNTvGVjHCZjxh5LkpQpjpdHtnTvJ22iIWsIeY0abC/vOahMIvdcRpG5WE2g6gt96hhLB9xTTaVAshjDvEydUhBSxpjlZMJrVabQ5FujWFfvrEpPZhmryV1qD74ae10vcZbxbeB7Xj//ShqY4Nj6NX86cUmgtWfGfTxivmXwVbz14ZnQQWa6o7VmB0ts1MtXHTgFI0kKODaQaC6I19fTAG0ZoztTLrwzi+tEFpqlb0wz6XAX2P6zdFS4qIYnK2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(16526019)(40460700003)(36860700001)(81166007)(70206006)(70586007)(6916009)(356005)(86362001)(82740400003)(966005)(83380400001)(336012)(426003)(36756003)(1076003)(26005)(2616005)(6666004)(2906002)(7696005)(316002)(8676002)(41300700001)(47076005)(8936002)(4326008)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:23:52.9824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07aa10f-9045-43ac-8f6a-08dbe781351c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
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

For 2.1, ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION is SR-IOV only.
For 2.2, return usage_bytes properly for the non-SR-IOV case.

Fixes: 4864f2ee9ee2 ("drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2")
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1215802
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 55 ++++++++++---------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index d8393e3f2778..b1c1fafa2d8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -115,18 +115,21 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
 			  fw_size,
 			  drv_size);
 
-	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
-		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
-		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
-		/* Firmware request VRAM reservation for SR-IOV */
-		adev->mman.fw_vram_usage_start_offset = (start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.fw_vram_usage_size = fw_size << 10;
-		/* Use the default scratch size */
-		*usage_bytes = 0;
+	if (amdgpu_sriov_vf(adev)) {
+		if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
+		    (u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
+			  ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
+			/* Firmware request VRAM reservation for SR-IOV */
+			adev->mman.fw_vram_usage_start_offset = (start_addr &
+								 (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+			adev->mman.fw_vram_usage_size = fw_size << 10;
+			/* Use the default scratch size */
+			*usage_bytes = 0;
+		}
 	} else {
 		*usage_bytes = drv_size << 10;
 	}
+
 	return 0;
 }
 
@@ -147,25 +150,27 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
 			  drv_start_addr,
 			  drv_size);
 
-	if (amdgpu_sriov_vf(adev) &&
-	    ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
-		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0)) {
-		/* Firmware request VRAM reservation for SR-IOV */
-		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.fw_vram_usage_size = fw_size << 10;
-	}
+	if (amdgpu_sriov_vf(adev)) {
+		if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
+				      ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
+			/* Firmware request VRAM reservation for SR-IOV */
+			adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
+								 (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+			adev->mman.fw_vram_usage_size = fw_size << 10;
+		}
 
-	if (amdgpu_sriov_vf(adev) &&
-	    ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
-		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0)) {
-		/* driver request VRAM reservation for SR-IOV */
-		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
-			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
-		adev->mman.drv_vram_usage_size = drv_size << 10;
+		if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
+				       ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
+			/* driver request VRAM reservation for SR-IOV */
+			adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
+								  (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
+			adev->mman.drv_vram_usage_size = drv_size << 10;
+		}
+		*usage_bytes = 0;
+	} else {
+		*usage_bytes = drv_size << 10;
 	}
 
-	*usage_bytes = 0;
 	return 0;
 }
 
-- 
2.41.0

