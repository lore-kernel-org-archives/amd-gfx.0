Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA37C04FF6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 15:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A6710E194;
	Fri, 19 Apr 2024 15:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPFeL4s3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA15410E194
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 15:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3kVI2yVmaoMQPool+8rnlv8J1F/NXG0qCcA8QYSxO+C/lytOR5BmgKLimDAAl4CSjAQ0FxEgDaN/R9xKjcZiylquzHgqFZe72QRd9J10hW0D28JAS4/wxhu2MTOZ9ZUXrSe9jsqMafJqIl1jne+LTqydclHcO1Wta1MnFR811IGseBixwVk9qQSOIr9f0yP+vVFFp6hJXxP6zB+0So1HNkLgyxDG83DQnxS8vuyMM5mtZ5fdSz7wuLDQ/91VMozogLHXHxDIlP38a4N2P+TK0YldVjHyReNaQLHMA9lPbaMGoF677ETuNKzPQz4GohftM6Aw1hBBXHIhu7kp5Lw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnGqUnIlWLzUT90oIHX5B0CqAdWYEO1YIYNhdgAhbX0=;
 b=U8GICIgtrJTUFXeioJYzKFffKw/C9W9ilmSL+V9RMvCZ17kdKn2/y6zjC3DLhZ953wQ4QC4ciIaj+PkS+uPAk/GNYmdZNPy+i2Kj4bHnja61dgvJPZvaSVtwYUkGQEJSxsxtzSYeA1tKQDJGtzEfQJhDCBikkqH6Z1DweUMXDWaIKMhRK6/vH7MswY42GO0XTFIIk3JQI6fV+SlcMX5h3Jv0IBGj5g7Crm746Ph8WYg13dr/g+05uhCdqhXHr8mY114atdQq60IGzlRW2vjQ99sd0JYUPMvpVi9NGn+C1HOn2WcIGf0j3YIbvruNVHIv3drHrFicXAe3pwOXJ1c+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnGqUnIlWLzUT90oIHX5B0CqAdWYEO1YIYNhdgAhbX0=;
 b=mPFeL4s3ig5EWIlCTxCZpb136wC9gwZXq+1K/oL/BKl23lZUlYTqJmYP19bJfWGPCexvI+acOZc7pLScXB4sLoDK9KrbZHru95KQvp+yWB8tfZL96HIZGHcZ1Mv25EU/cOxjqgFB2Uz3O+lTn2Yg1CpCDPrfsx0H4RtC0GdtmIc=
Received: from BYAPR03CA0034.namprd03.prod.outlook.com (2603:10b6:a02:a8::47)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 15:45:14 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::fa) by BYAPR03CA0034.outlook.office365.com
 (2603:10b6:a02:a8::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 19 Apr 2024 15:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 15:45:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 10:45:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Li Ma <li.ma@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v4] drm/amdgpu: Fix snprintf buffer size in
 smu_v14_0_init_microcode
Date: Fri, 19 Apr 2024 21:14:52 +0530
Message-ID: <20240419154452.237393-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419092524.98737-1-srinivasan.shanmugam@amd.com>
References: <20240419092524.98737-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf9f492-d70a-4e8d-bb4b-08dc6087b437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVmv9sTgAenefKUxOlhVAoTSSD67w7teKO6EW0pJdA3G+2d49JIp7ZUOT2srodPrugNwqP3R3VY8iTxKXZKL0ffQ8mmRSEZ3hUOPfoNQNhkBIh/Tji2VC8azWcMT385GcI+gFR4mGmDAzqHLEuRTcpzE7OholwuhegzdXwpf1dtnOU02ZMVX97cmNk6R4+uznaWERqE2HvJ0z7BWPkeqdYZM0LjVwsevrxksf102CeeUc/52wpAt8aUALOLCD3yXf2JNOC4IM2FFf90Ot1U+qNwdxM+mBqogPVYym8YmIyJZlHc/nxRnnNd9PALbM4k3CMMXGvmqXn3n6qkp1SthJeFYp9hWKNmYGnJm7PkHZiGBSm/I9o5w8V57tJX1IBvhvRJDNCu7bhjVYTob5LNP2Nb4QUAK8SBUxFVL31Ji1fTQFwNS+Bef4SQRXQ1RBDWttEj/mP3OULUylqlGf91J8mR2a5IpVXWEzY4s0+xj1lsixE2d12MLgeI6PqpxCfkm5fdbzUmp0zS9QFxRsDM9Z0ivUJt5X4TJmMxp9GVleC23q2SQ+Cmy8foI6fKESw7n40ECrQ/F36DW7vfQ5mjtHhNHKtXrSwjWc39H+iXl19nB9HsRLN21hpEvAO1A8OFuqjX0fF4OZlwB+ZiJIybEI+hz4CysoGMw3IY5N5sIUaxNpmdipbFYNaB0OP0evzzPTJXG2IYSWGLnXBPDSFuc3ty2c7AijVKxCps1iFNhezqDiSCW5Rc2NhoEOnQGtcKy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:45:13.7514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf9f492-d70a-4e8d-bb4b-08dc6087b437
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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

This commit addresses buffer overflow in the smu_v14_0_init_microcode
function. The issue was about the snprintf function writing more bytes
into the fw_name buffer than it can hold.

The line of code is:

snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);

Here, snprintf is used to write a formatted string into fw_name. The
format is "amdgpu/%s.bin", where %s is a placeholder for the string
ucode_prefix. The sizeof(fw_name) argument tells snprintf the maximum
number of bytes it can write into fw_name, including the
null-terminating character. In the original code, fw_name is an array of
30 characters.

The string "amdgpu/%s.bin" could be up to 41 bytes long, which exceeds
the 30 bytes allocated for fw_name. This is because %s could be replaced
by ucode_prefix, which can be up to 29 characters long. Adding the 12
characters from "amdgpu/" and ".bin", the total length could be 41
characters.

To address this, the size of ucode_prefix has been reduced to 15
characters. This ensures that the maximum length of the string written
into fw_name does not exceed its capacity.

As smu_13/14 etc. don't follow legacy scheme ie.,
amdgpu_ucode_legacy_naming

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c: In function ‘smu_v14_0_init_microcode’:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:80:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
   80 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                    ^~       ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:80:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 30
   80 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: fe6cd9152464 ("drm/amd/swsmu: add smu14 ip support")
Cc: Li Ma <li.ma@amd.com>
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v4:
 - Reduced ucode_prefix to 15 instead of fw_name size increasing as
   smu_13/14 etc. don't follow legacy scheme ie.,
   amdgpu_ucode_legacy_naming (Lijo) 

 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7d2055b9d19f..68b9bf822e8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -65,7 +65,7 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	char fw_name[30];
-	char ucode_prefix[30];
+	char ucode_prefix[15];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
 	const struct common_firmware_header *header;
-- 
2.34.1

