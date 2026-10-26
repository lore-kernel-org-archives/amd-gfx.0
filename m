Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7B606A31F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 03:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xkhhCIHs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B6910E20D;
	Mon, 26 Oct 2026 03:21:08 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29AC10E20D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 03:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur2yKkfedsoVcnOF80eprdj1nLJ0fo4N/katujrd1k6d85JaR6ebaCCPT59mhd6eCZKVMGhOhbVLnJ69gb5cwTE3e2IxJFtAO+7tqhqnQgxwdhRy5EbWeXe5H4abPN3PaxG+1JBE8oeiP/9/D13ewAfWC4ld8SXixmi8qYL+VcS/f5tTDq0Cazwid1XV7nJ7laNlTAk3cpXAVdHzHo57y67jwm6nWKSnLxGJQ95kp62aCnDeGNIKmkahv54p58Iei6HnNVebRbL6jqHmj44hLsz+bU+8psfWb1R3zhekRqgWQJRI5t6fsXDHUnb10B/FG+PKGTCFh03QzmVaVFa3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2WWxkn0XzBLD7xaI+jntAZaEEaDlTSAHx8EEmuwq/4=;
 b=DxuncdgHZXR88MbteqVP/UbwIrIFv8VkDLeIoawq4hHFm2MZEFy6T0lwtYpQ0C0yaU48uoAKBOviSCHcC6eDYH08AEBT7idVCjREkb5Q5ZN1l6oXiuoPlsC9EPzvwWZPONSMsL3297leCHfh0k5Ylp0cTf6K54TiGYRJXKbKakIeVEHe1uOS3QzeWeZWeraY8pZibgGeeGKfrNVEt17MC3A0M690IBGg9LISZDca2YLWEa4f2pVzWMLFcoc2DJDJQFS4Je3N2d7TEB92nTKTuufCR8HQfsZ0JFCLOtZgzd9m/ya1UtOWKRej7kq+lts+14SqoVpDZYJile50A4UzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2WWxkn0XzBLD7xaI+jntAZaEEaDlTSAHx8EEmuwq/4=;
 b=xkhhCIHs6Hr4FRqbIqqJ5THD7kMsvMpuTZ1TnWOrThTFI/bMM+YPp2HrnYzeo3+4UWzIs64p2Mm13iq3hkMpso5wEY3bPYwKDuQUvZMWjkEfnf0sU3oueIH6kLlvHrsEHnGlstCLxOjeg90AyM4yEmmr301bVjJzkn5ouOS06hU=
Received: from DS7P220CA0073.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::7) by
 IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 03:20:59 +0000
Received: from DS4PEPF000001C2.namprd21.prod.outlook.com
 (2603:10b6:8:259:cafe::a7) by DS7P220CA0073.outlook.office365.com
 (2603:10b6:8:259::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 03:20:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C2.mail.protection.outlook.com (10.167.23.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 26 Oct 2026 03:20:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:20:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:20:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 25 Oct 2026 22:20:51 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <igocaike@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 2/7] drm/amdgpu/gfx7: flush the scratch register write in
 the ring and IB tests
Date: Mon, 26 Oct 2026 11:20:18 +0800
Message-ID: <20261026032042.2266892-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
References: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C2:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: aa07af46-c199-4488-8898-08df331027b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: syJkOI/zwkpWMw6bh72rheZN/iQNhNe0gR+GO8QwNsoBVZKZCEmEaG43XqjMS8zzarrdajjLWITGpwMHA/DcjdDK/JSaA5pwnfgSBD4CVpQi8dRIjtsX1M7Gk9rad+b0mg26fvfXdFjcdMlv+zVjvw9rYtTflqQ9aOCoy5jOFK37mLDvV3692vb/L4rSyDAb7udTa74EM6H0GuKwiHbOsw757ZIx8xm/iGtbSQKOnslK2xMsfoQ5Npyzlo0yMOzBlGr8BD5jZ/X5WYT3vYvfiyq/tkONhpmAHHvDcAehgFK5ueLMWVJB92O8sJClK2l+rOtxuaUf/Mpc2un7WlElacAyP3+xHLq0YsrS6NV/hjD4zLv8SjWYTuGyAYT5HJ2aFNLjPkjND7E2X79nGwBSwo67jrKjKbI6h2PlcCL+mKO4FjC5y0qPqyHxYMhTGK7pS6YbQ2G+IKGWIeV0Hgns04L/6vEpavBTGbU80nnqyzLB5u98UbNwdRFSamyiwOYKmCSslMxLUeABmzSuGoeU+R+IxAec2WETSmAMXDwIyJXuzHhKw15NLCmVzgF6x36AOFe6Ht0pkw0RkNFwaUFLpJo0VixrEXlNp0SnL7em6kmD99oJcfHEWxmf9TXlD9/4zMP2mwsg8iPBPHm/4f7mIE4xkIWtFEHVKFTkbI/UOiLeMMcxGv9L4kCBgxW8AIGPTCLfhsm3c/EJy4t2dc/3Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jRVohh6IrI3dnl2gokk5j3T9JSmXSpLmtpyCCDHIQclYLfKaX8iciRjQWD/PLsRwAzW+cijqQamUMMnbb+FtDG7IfseReFYD80ysSpAksIZPDgjSjh+VretP5Xtl2MO3ip8LWx9n3OHYoWgMQ22HJPYpK3y0L9EJU9RosD5cMYB38+5YyjF0kIqoGVymtdgX/yB0NkTJEFiWttO4sCAOvqnGc1AuSP2pmFMVmhPFbxLsC/Q2R/7YaHjZpYVZUP7yveCYVJJ1Hiz65jCJjOIdbUKzldibXqw2VE5yHcePTuizfKheaismPyOMPU+0O2ONGojkZnJskrqtpjyeHJFFN+qBf2CNeY6z81s3xcFPr3L9zRPJgqrnj5Vmfa4tDZl01gMX5pSir5w9hRigpEiBUCEP04WTWJWVHRrEWY40Tqgbmf80EBleTMHXjHWM69b0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:20:58.7816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa07af46-c199-4488-8898-08df331027b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C2.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ring and IB tests write 0xCAFEDEAD to SCRATCH_REG0 through MMIO,
then have the CP write 0xDEADBEEF to it and check for the new value.

Nothing orders the posted MMIO write against the CP's write, so it can
land after it. The test then reads 0xCAFEDEAD and fails, although the
CP executed the packet.

Read the scratch register back before submitting the packet.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 50e25109d0eb..72c84b61fda1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2039,6 +2039,8 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 	int r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
+	/* Flush the posted write before the CP writes the test value. */
+	RREG32(mmSCRATCH_REG0);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
 		return r;
@@ -2299,6 +2301,8 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	long r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
+	/* Flush the posted write before the CP writes the test value. */
+	RREG32(mmSCRATCH_REG0);
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
 				     AMDGPU_IB_POOL_DIRECT,
-- 
2.50.1

