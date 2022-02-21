Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690AAC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 19:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3153C10E3C8;
	Mon, 21 Feb 2022 19:54:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4A010E3C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 19:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSpX5jWtg3cUnmvJSj2SETm4nx28Hm+O3MOTtBNtUSE1pz7TGsXOT/j6a0X18VKAn3J+uxO4EzDIscqzi9JRha9nkeg9n5fnjTl9gnesT2eSn9gtw5cMg+YRw4tuNeNCp0oVMJi0LNNtSCqvJHjCT+X475Ak+iQ9iSGnR7LmfZ2040XafDdQrpN0XI4YEw1wgYlHopqrdKcDH2MpBMp2idwxfR18qV/QGoZFqqG9mqMa3jrl6WGEftLrUd1l5mOzERAyAifcTmd8WvwrS52gZHlAE58z/5zdACuOhC0gYrj3QXDh8ZH0lhFB2EYiDfFKMSHf895PJXJ+816ZaX/a5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj82gSUD++C1MziQ1gD1ZLPgqDOiAxuQv5eASyqvYgk=;
 b=EwmqeEd/nX4aKBje7iGe6lNIYR2GB4hy6BlodQS81GuL9xRf5DUoN/nGbFhPoMFzN741L1cpYjhgdjmxhf/jp+PW3tKCzq5Mit6LrTHbI6efVPeZxM39X/yajYCifyk3Gk2bGJEMkQa22uOl29hQddJsDj0UickPujapXHDV3lBuYkosRdRYc0DRZTZXY9zO746WzookTjlzbskTZJoKOjAec7CMlA05QNiyTkXe6ZNgx9IfKyBHWAcCdt2enhtSXrEhqoDPKlgPoLyCqCSpRNsZwV27GIHtlW2UPTUUJtFk1/NRqG7ao4q9a86Rh99VN7KPKf5veeM+U9HOLOCYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj82gSUD++C1MziQ1gD1ZLPgqDOiAxuQv5eASyqvYgk=;
 b=5q87SZxw9bG3lYSpkMbiZZet3/lSKTh/z8yf2vtrIZBoN9ixr98Rk2VgYQHFRqF0v0DMaNL0SqY5kXFAO7YJox1WJxHMp5f0roH3BbQ9HfnQKMQdXjyHZmJw4KxqDh7ySFD+fKoikjjAlexZlxI/t86hPF4v7uILlowCTOKOEeg=
Received: from DM5PR1401CA0001.namprd14.prod.outlook.com (2603:10b6:4:4a::11)
 by MWHPR12MB1438.namprd12.prod.outlook.com (2603:10b6:300:14::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 19:54:18 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::6f) by DM5PR1401CA0001.outlook.office365.com
 (2603:10b6:4:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Mon, 21 Feb 2022 19:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 19:54:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 13:54:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/display: split dmcu and gpuvm handling logic
Date: Mon, 21 Feb 2022 14:53:54 -0500
Message-ID: <20220221195355.135192-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df15aada-fa73-42e7-de2c-08d9f573f19f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1438:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14386309877C9C6B2C275072F73A9@MWHPR12MB1438.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAUBqUgkM0Pdg8ppmRydRsg52tZdEc1+lIcUdvQkMKYvl72iHOI6fvvehhkEHkmjP0JAo/oPaSl3IQQqmcLL2HwQZF4N5PryBSIYXjachuQUDqrZmH6lTYPGvtn0tOhVuTOOK8EPfT2WM5qZSVUHz8YWHtaIKhSaFPPX5DrF+Tq4MdMakYn2F26XXo9Cg5jKg/iChNyzyOpfrHW7Q7O2jmU3322++kEQIyg1Xc2EPEDMk7tTWcG6HQRBbOK+6nJ47brWHIketluK6M1nIJjPsiOcn18B2wRlF4hYQHZ8Vw7xcpuc/tqnIZ3qimWThyViD+icVQaC16aOBq1XNZgiVnyZl3DOmS4YlxrRdEbfoJw+gVt+VtujzXHFnVYMKpze2hqgx7zy9gZdgIDMyEjbecQwfdsS4ncvgwaxvrTBDXiLNETIRRcrpPQc78Wr0VLTVSSxmLhnSmwSYM2lXsdKbMFL2tFN2A8P+6pTDaBwmvAuX8wm17MaiurErc5qxLC9hhLh30bT4+91Q4OYxdY7bYI+MBUtFyW6zWkk5GweIxoONy+QBEj8V7OX7ZN0ljoHka8aRr+7K1z8K+OPQG6FX2H0sq56TMhtp7G240mDNjsw3/ZzW36R375l8+ytkhr/xyTUIoS1Gc2TZddHCz0nwhoBBHN0Pk/bcYrSGnewsj6R65ehBwAGN6TDL+rTgCAb16NQ2gMj5Z8lPRL0hgobiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(7696005)(6666004)(508600001)(5660300002)(8936002)(2906002)(26005)(1076003)(336012)(86362001)(4326008)(8676002)(356005)(2616005)(16526019)(83380400001)(40460700003)(81166007)(6916009)(316002)(426003)(82310400004)(70586007)(47076005)(70206006)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 19:54:17.2372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df15aada-fa73-42e7-de2c-08d9f573f19f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1438
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

Separate the logic for each of these features to make the
code easier to understand and update in the future.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 +++++++++++--------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8cfe18b92c99..306b321bb70d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1443,6 +1443,25 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.dce_environment = DCE_ENV_PRODUCTION_DRV;
 
+	switch (adev->ip_versions[DCE_HWIP][0]) {
+	case IP_VERSION(2, 1, 0):
+		switch (adev->dm.dmcub_fw_version) {
+		case 0: /* development */
+		case 0x1: /* linux-firmware.git hash 6d9f399 */
+		case 0x01000000: /* linux-firmware.git hash 9a0b0f4 */
+			init_data.flags.disable_dmcu = false;
+			break;
+		default:
+			init_data.flags.disable_dmcu = true;
+		}
+		break;
+	case IP_VERSION(2, 0, 3):
+		init_data.flags.disable_dmcu = true;
+		break;
+	default:
+		break;
+	}
+
 	switch (adev->asic_type) {
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
@@ -1450,29 +1469,15 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		break;
 	default:
 		switch (adev->ip_versions[DCE_HWIP][0]) {
-		case IP_VERSION(2, 1, 0):
-			init_data.flags.gpu_vm_support = true;
-			switch (adev->dm.dmcub_fw_version) {
-			case 0: /* development */
-			case 0x1: /* linux-firmware.git hash 6d9f399 */
-			case 0x01000000: /* linux-firmware.git hash 9a0b0f4 */
-				init_data.flags.disable_dmcu = false;
-				break;
-			default:
-				init_data.flags.disable_dmcu = true;
-			}
-			break;
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
+		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 5):
 			init_data.flags.gpu_vm_support = true;
 			break;
-		case IP_VERSION(2, 0, 3):
-			init_data.flags.disable_dmcu = true;
-			break;
 		default:
 			break;
 		}
-- 
2.35.1

