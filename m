Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC65EC47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 06:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529DE10EDFB;
	Fri, 22 Mar 2024 06:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EaAMH4rh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA19610EDFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 06:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+0lyrUuXTNIQVs46W30yNfswXkR2b8ltkOBctV+hcFXultL1V5abVAzkP5i9HvPuvVI0Uwl48kfpPsYFH9xLGe5V/xUHCSJvWaUFv8NRNdjtsFU5GJ34qKU3kC/rO01HAtAOnI0oDVh2wjZKGKdjkWS4P2M/btM7suKqtzKLaV7Ix40WPmpQv6KEoTaTNoEOq0wE8uO73v8wz0TOMohzhLZ0EPEBADBRsub6egiF+UtuASrsY1z9t3PSaenzczEbS05+9fRX3cHGHvEJooqdto6djfbrCqxtnjBfRvFgCFEoKEC3sXuLlZum3DiA6ROXVHqA5yKRSliQJ+vRmBCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBoKr5NgagbW1HorC9n/Y6PDJvSyIhrkD9jwFt0DxWA=;
 b=BDMmS4pvn27EfoT6HaJFuIBphr3mRRU2UEx+iWVgcFGpKMdv6G/g4CqXSBP1kJP0H9fjgTxrTPTu/A13s4d+Aw9NBQctDYqVgBQsKbaNYFSh/asJnJFBVLT1FhjY9SwBhTmEPgPhwihnyig176J+GqoXSWtIjJlahHhlLseS2ct2Y2vcISgUmDSuFl7QqegR6bK01gRxrvwowpmD9rVB+/wrCwXzZb/yM2SIhDyFY+tdT/FZ4QdsdHBc/zZJMQxsiX4Poqa4A3nV6YNBq8wgbJlR6uiJJqT3/hy6Gd6LUngJYxFrXJuWStMzlNBhpY2um0Mz8n68A42MJVQWPlU+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBoKr5NgagbW1HorC9n/Y6PDJvSyIhrkD9jwFt0DxWA=;
 b=EaAMH4rhGZ6awd45MboXlKGZhdI+2s29Ox9+tTtwMNFKdYMHZKpX3PlAzMOWJlpWWb7YOgOoG2KeuJOCgrMzs5pYrcEfOQZgmQQ0bLsZN98idkzqA3lWR+dJazXi8fn1/RIsuo/GYNHk5wdb3w08YYaFAQgaVQi5MxpUkIfZaXg=
Received: from CH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:32::7)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 06:32:29 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::c2) by CH0PR07CA0002.outlook.office365.com
 (2603:10b6:610:32::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Fri, 22 Mar 2024 06:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 06:32:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 01:32:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix truncations in gfx_v11_0_init_microcode()
Date: Fri, 22 Mar 2024 12:02:17 +0530
Message-ID: <20240322063217.4121194-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 097b693d-2622-4329-0753-08dc4a39d89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdLU/xMg10dhVs6W4kEm0q+HwEgxiYkDV6l6a0T5tGC2VrgPV61Xsdjt13LBZ2ZnzSe5+EegbqDxIL9MW8DQv44Sn/2K3kM3EwxodaOFHVke4lDoTvhmzzThaHNwaSK0C7fMci2RhyNS6qzwcbOpmNkUjyA40S+ZwxHcDV1kZ7PsSQ2dtbF+eT6vWQKDqupfi//8teNUUW+U+e3NnhK1kHWBV22P/n1zHo/DjYCeVoXrCQtQyqsYXj0zK+MXd0+lwCjqYPAxFOjrBnOEgq/fVKJEhiSh43w3l93S/VAUa86wkruuuhVAUq3uqv7zVb4IrmV41/Sen8lqRyAWmyZh0C7ifnLz39uaQh760e5FSYx8pXv4F0EYKrMNJVzQUrlQgkfdl2gCXhY+PUFxtWk50cLco8Kh50udReARa0HWa/qbonhfOZ1DhiOIL4ldkfEDC9k5YOTWpLwEgWjJ3lk0gHXDSRqtHxjaWUsP07CEVW3o0HWIev9WqGY79nuiOs2P/G6nINicdlcJb0yk53Dx9npGrfAG8SPzPj07C8b2D6dGc7oUN35M9CSHePg35x78cONd6eKxCepKP+AlBYNH2mxYQdXzrh/rcKUchozahhqR12+Cc39MZjhsCfepMb0BLGCbhVLfIm9Sl9j/PI1EkqhUY46pZHVVSDaZQyNZCBch1//jDPTF0hJUE283ZpQOWorJRHKCQJuPG793ybGOFRBF/uHVvnK0nfRC3eI3/6XAPVNiEzC8zRdO4tH70OEr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 06:32:28.6969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097b693d-2622-4329-0753-08dc4a39d89e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
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

Reducing the size of ucode_prefix to 25 in the gfx_v11_0_init_microcode
function. This would ensure that the total number of characters being
written into fw_name does not exceed its size of 40.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c: In function ‘gfx_v11_0_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:523:54: warning: ‘_pfp.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
  523 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
      |                                                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:523:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
  523 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:540:54: warning: ‘_me.bin’ directive output may be truncated writing 7 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
  540 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
      |                                                      ^~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:540:9: note: ‘snprintf’ output between 15 and 44 bytes into a destination of size 40
  540 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:557:70: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
  557 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
      |                                                                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:557:25: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
  557 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:569:54: warning: ‘_mec.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
  569 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
      |                                                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:569:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
  569 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC [M]  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_clockpowergating.o

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1770e496c1b7..7a906318e451 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -510,7 +510,7 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
-	char ucode_prefix[30];
+	char ucode_prefix[25];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
-- 
2.34.1

