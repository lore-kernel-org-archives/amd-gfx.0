Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AA0C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 10:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301E810F553;
	Mon, 18 Mar 2024 10:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eokjr6YE";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15F010F553
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 10:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS7HzDydxxd42w3kOnt5E1RzzkW2WIXxlRT/pX/tnrRh85sF56U28TrQ+j2P4pSn/JFhiHzOyGiVtsBxgIaTTp88jcIREbVWr39OcRENg4sDpj1G1MP0Z4wDJCMyDgN4ugmPLirzGHwurzkSs4dxJCzVjVQ8BdfArFV2XuYr7KTxLW1DNF3I67OqYvBWdr8IzZ7F/YdVhnN6CvyDBVYM5/6pb088WuBWmBKSCc9hQbHWfry4D9I2fNLSSmwFiLiBQKFZq4jqXMPhytKD9NQcg0hteb7GVAfIWkHAF0bjQjXs0coLnXIl/4AE9ryxtNVcihjIm8wi5SStX4CuR9wmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHgHN+aSDA7bcE6FZcbdzs+qrGQC9Ivzx0ouoE7yFBE=;
 b=EynBW3S178IrJe8tXiqC6Y5Qn7jtHVYJolmbuYfripApxWjPaIwyScHEF1tQKLy7o8cej3Kdhwyk4CAJ98RBuSJH2ct+isGs7gNl0X9fPAy6QgMTahRtL6ZtrHsPYijqrcd1sYc/1XRq+DfZh3/bq3kMP5lsHuIi+Zt59bfbs7LjvRpgkDsDoe0fAnOebsc8p8a2Fkv1c1/XholXf3iBBzopOQxbHjggPiX3pvw1PvgzJRe4YusnwatmpDneBQPEocVwpjmGd8yTQ4oEeU+axqkwvF2yl0YsgGV2yHll7kmfjphLBJMmxIhZVSfkipcm0tYUB3xtJ1EXCKC0YujkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHgHN+aSDA7bcE6FZcbdzs+qrGQC9Ivzx0ouoE7yFBE=;
 b=Eokjr6YEY7exUbD2aylNfK15QdjWCLSIJ+PdocKABnkbDwKjc2FMO6OP4zDieQ3CMGarRJnKuTC5FIn8K23qD/ujH3R2RxFxsTKCKwtM978RSfCyqjJ/S5PeLTMY60Ij74l59U72JgDQROch8rmTXMqOmsj7f3LrWSSVguCeUJo=
Received: from CY5PR17CA0009.namprd17.prod.outlook.com (2603:10b6:930:17::14)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 10:38:18 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::c1) by CY5PR17CA0009.outlook.office365.com
 (2603:10b6:930:17::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 10:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 10:38:18 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 05:38:16 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lee Peyton <Peyton.Lee@amd.com>, 
 Alan Liu <haoping.liu@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu
 <Lang.Yu@amd.com>
Subject: [PATCH] Revert "drm/amdgpu/vpe: don't emit cond exec command under
 collaborate mode"
Date: Mon, 18 Mar 2024 18:38:02 +0800
Message-ID: <20240318103802.3009373-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 297467b3-5504-4737-e151-08dc4737865f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uV7Lz7KhVucemazGJ50biRXTbejBBPTnjlGHUu12Kg/EZnoEuVHyjFvzAlRjPgtuB3tNiXT1DUlBtZdoZjqKX83tIjIZLjp4s915Bc+Esv/zDI3gUzjje0105KVEyDt55ygpQWBYaXOmM/exHBPr3SRaAqJk6i7lBCkXlLnNDxr6PE8BNWHUfkB3xZpyPDjwZCROsOVfDnmeWewOBM9ANf1+2RHnHR54Y5wc0AaB4eHyk6JQL6yoCyTkesJl+VsJ+2O03+ZNdaYnC9jczHOz94u64uuORR98iyeZYnws5ki8jSChRJEiYbpXEDqv7OofQrc+oxAeH2csZIHayJlKOL/MlTtnJsfVLuzz7kCgnChGo9rzvda8W8w/vlzYaFd3HeUQXqxttNah0lcq8d7DbcMM4MVZ4D5Qy7KmT6i+/fTceFZq8se3/u4JCNpIzZqMFVrw3kJ8kwjpGVWsneh5olSZAO37AMVTK6f1XAHDaKa15Efsa8tQay0R5tm72EfrbXPz3RzULSR7CqnsC7+Nt5FklaA/nAb2NIaDGMdk9pLvfO9kZpv4+jAZ2wKmRcZLyNwL5kjtOSg8Y8BeIlJAtH23FYv1xOXFgYemXSJ8BeUgm/Ga1AXa1AJf+y8SDOsKbwJIt4N3XQjcYTrS7NXAWUwO9rdcjvJSEUjVMq8ldUTGsH/7702o8JsGmZtS5UqU6mni8SLlLS8XLRqWgp5FeBHUeNlRc3/IDwXsrrl12zdCKGu4eIxZ6M/TNGOvmPbb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:38:18.1877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297467b3-5504-4737-e151-08dc4737865f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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

Ready now. Remove this workaround.
This reverts commit 1a2bb3bb2a84f8364f0a8b338afa9b9025e1bcc0.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Tested-by: Alan Liu <haoping.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 70c5cc80ecdc..7a65a2b128ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -575,9 +575,6 @@ static unsigned int vpe_ring_init_cond_exec(struct amdgpu_ring *ring,
 {
 	unsigned int ret;
 
-	if (ring->adev->vpe.collaborate_mode)
-		return ~0;
-
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COND_EXE, 0));
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
-- 
2.25.1

