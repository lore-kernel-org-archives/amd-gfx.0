Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD98C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 14:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9DB112B4A;
	Tue,  5 Mar 2024 14:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSw1evcq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6867A112B4A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 14:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhJE0Cz1N9oOl6/N8wg+C45QVZHrfTYqnped66avsO7A1Dun2TBMMSewOTPwABCc/3W45pzr/EoAY6iwjPCEHZt7Qve04GiaGcjghaRgPpN1j/xC6VwSKELVWkQ/OFBWecL6wy0nQ9vhQfzC5KL/sLeBNFmn34Hd7kx9WKld3EDJ/2XC+iw5DaFsIOR0dxOLGdRXAYJvPiz8MzcT3DZnm9oFm7TtSpnmgI3GKY5sCFD6mtP/RSJlUvzfCSpyVx2K6gHSDAqm5BjVK4V0EwM23FudH0QtuorpO1NNUvbM3WVEKdm26q0pd5FU1zvYidd2c3LVCTJF1GrI/7tWsrFnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6N3FRO3TnPmkVJg0SlPUdKHTRDHl3JM83fg2jUlmpA=;
 b=k57V0yR2I/ZFddgIJAj+/10AzJ006OrN1CJZK53C8i6jXsysBsVVb723fZWa/v1f5hgbIPAtql8MyzT7GtxYToW286T5UegtOLOM+lHgXjgCHS0GEMpMzWIPwlCGmPi/6GIjpXT2Phq232e6ogM+X8KNTF8qFI4rs8NVQctFzPW0j0seGO7XAF0atUaCsBaCk0xtu0lG8+hbNyV08QNLoDvN6SKTEp4aG83v92vFLtIzf0jPVfKUuitrUvcNOr2gTXS8uaOlQMFzgTuzV8XCtOOisut6cpMPcHufymTeSKbvK7Cr9ieGFdDy4BZvTLSjozjhYIvZkQQlu2QuxyXfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6N3FRO3TnPmkVJg0SlPUdKHTRDHl3JM83fg2jUlmpA=;
 b=NSw1evcqMm5+WMayvHtIC8Zf21KqHGNUFFk74iHpCnaQ5WOkHZvZGPMUFTtMYdlgwdHTK9q0SOb9A0164stjaakSh7I2JMiHDNCvrGpdMFNW8Wh8LhTSz9LewMd1CPOcKWe3E7oR6bUJs4U2wYIbhUS7LiAdn/57qBpuJcvA1iU=
Received: from BYAPR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:74::31)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:31:16 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::6a) by BYAPR05CA0054.outlook.office365.com
 (2603:10b6:a03:74::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23 via Frontend
 Transport; Tue, 5 Mar 2024 14:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 14:31:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 08:31:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <Lang.Yu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu/vpe: add PRED_EXE and COLLAB_SYNC OPCODE
Date: Tue, 5 Mar 2024 09:30:49 -0500
Message-ID: <20240305143053.1262593-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305143053.1262593-1-alexander.deucher@amd.com>
References: <20240305143053.1262593-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d682c6e-b32d-4956-3f40-08dc3d20e9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fk/ABgwXYCY7nGqPpmcECoIQmZI74j217Lm4OZ1ULVl6ijNhixIFccBOdsvdDNgKAyPaPfebNcmwWEp6sSE9bHrHJ8KuNIReH9HMrvBXqhLhV9oZwBKK5cdlsd+43R77jvy/BTZCDwm3WH0GDcesh9eQKKGkA1I2/n8A5b5NrnMXViIvSFbi1lrUOZtHa4TZFY9p7sbkkYI/5CspjbDbUuzcam5ddD0OaH+ILHJoX8bUBaqimtv/MWVHn0RD8buVFbkTEaiaNL4iktdxu8r044yZwKO46H42v72kXGUXPmGBzswyPOTWYdpuDVDyfX17PVlCo5XeCF1C7twK0RQkqPUAdCK7b+C8+PuEGP2imZ/metGmZ3SF41L9JPQeQrDqGyPnfk+BnrfY4KxIKOwGKPG309AhDC2WwmDc5T0yxXMKR7BhbAMZbPCafxfmQYBuwrxq3tVqY4738XGMEnLwlUj//GGbylJVre0pDvNB8DIt12AahrNmDDIgkxWjyHQpUBDrbPZ239Ok4bX7v90JrK19NJ1o6+m6eOAydWSCDofEIvBR5X50DUogv/nA35dodZz8WINmh48A9VYjz9zAYv0/reE3btRBBDu7fo0mlO7vDOHnvBYKg95rHhyl2klXA+74V+5nwehM0xc64HwCH2FATJb0LgV59LYAQR6yHEDAg54nriZ5RIJntob5mpUdQzNy63TY8MkPFKEozmkx6Xo/igv4lp/NVLrG6zzrxxhNyVZ4hITG5k5KFSpVs1zP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:31:15.1158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d682c6e-b32d-4956-3f40-08dc3d20e9ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281
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

From: Lang Yu <Lang.Yu@amd.com>

To support multi VPE collaborate mode.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h b/drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h
index 9b550deb48d34..47534dbbd137f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_6_1_fw_if.h
@@ -40,7 +40,8 @@ enum VPE_CMD_OPCODE {
     VPE_CMD_OPCODE_POLL_REGMEM  = 0x8,
     VPE_CMD_OPCODE_COND_EXE     = 0x9,
     VPE_CMD_OPCODE_ATOMIC       = 0xA,
-    VPE_CMD_OPCODE_PLANE_FILL   = 0xB,
+    VPE_CMD_OPCODE_PRED_EXE     = 0xB,
+    VPE_CMD_OPCODE_COLLAB_SYNC  = 0xC,
     VPE_CMD_OPCODE_TIMESTAMP    = 0xD
 };
 
-- 
2.44.0

