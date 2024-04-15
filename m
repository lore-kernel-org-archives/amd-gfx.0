Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE443C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 04:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E46112114;
	Mon, 15 Apr 2024 04:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3VJqxNox";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAD5112114
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 04:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+AFRVCbNYBjFFWdZxrb+suk5enT/Zvaasbw/x32gjIvbagJNru7595e5KqrN8ygSRVoe3sWUK8U+gLx+xQMUSSjPm98W4OZ3hfs723dJHMcxlWi1EoSTBr9P/sxdKJVEoypFhgaHGb3FH8k4Zcd4eB25iBmKq9D0AkEeMwhJHqGAknfScqO7ATewhR/HaFTrdOaMCbvBut7Cn+vXj31d3wFAFL9qbZ1ZVnf7tBVlCPGJaY7mWzhrv3d7aG3T3TjeZB3YI1/d0CiQtC/ErfRyFcVL/k+D2j3MqbswWJvZ+vmymITVCJfqqiHZql1CD2hReSMkqKZMivMFXokpLzdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAIYJA487McnSWzNYpx93bZW+48ZgHWD7BjyeMuBKkE=;
 b=ik/THBc7xBV1XAd/6Sy9/6D/AYt6jvtjvPOee9HUPp0Wxc40iGDeISTXki4eYFrWHRIZyDMT50UUiLu+pYtZfOOvDah7Z2eNAiHV5TrU/QVKYh/YFm4dBijFxBuwimou9f2COUSYT4QA4Ow5CommJUcv0Qn4o6rMyAAbxE3wJcyS8AaKgWDiBDMQjKgsA1AchjMk60du572jH7epV4yMZ6PCRPzxbZk1eD/yBvdY/dHdHuFyspZL7iLlL7Shrwui/UBI9mpfZoOJR9ScJAFQHteRgEt7UVTH3uS1ZrstJAhy+xqj1FeEzqLlHIUfSJq346lowg4mRfrEKfxyIm/Krw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAIYJA487McnSWzNYpx93bZW+48ZgHWD7BjyeMuBKkE=;
 b=3VJqxNoxFDZnRlwBQAnNlfpt13l4Jhl9IkUFWDKkOccT2X1D0BOIy/F/fNKvrpXj+2Ff4QhqBzv7Omy4LnxkK9rvM6KaGXIu8d0Whh1XrWQukjRQvCuKq9XLbnSBeARBkfSCiV1PjXG1wBkLtpLfYRWP82ziBSMXjl5c2nsb240=
Received: from SJ0PR13CA0191.namprd13.prod.outlook.com (2603:10b6:a03:2c3::16)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 04:42:56 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f2) by SJ0PR13CA0191.outlook.office365.com
 (2603:10b6:a03:2c3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.17 via Frontend
 Transport; Mon, 15 Apr 2024 04:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 04:42:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 14 Apr
 2024 23:42:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Change AID detection logic
Date: Mon, 15 Apr 2024 10:12:36 +0530
Message-ID: <20240415044236.142024-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: a892ac42-43b0-4dd1-4318-08dc5d068500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apZxGoXgr2Op9vF4ltucenkfXeBp31DIpqAlPV7hJzi7QLIP1JfN7bTTbFrfRri3HGWOOCypT46BLaOgGFlA9vTcomxiYIxWkpHESN3CpuyihU1crn2OCsKfsNZ4DE2Lj2TN0aYEFzKl5NLNnu6lW5Fg8iGLjJX0wDZd4haljbqQPoBGCzYbJ+uZhP1qZF6/3uXQXnHXhkLLqfsMymGQinaCSgeaQu3bH7NyLTgEQ6thm0wF2vmL5gDQ8UJmpvhcbiAsREFmvbwpTigrzZycFJU1e2AK3yhQBCGjsHkRsO1x62RU031OG0Mn3dfJg3HdQKIkVCYK31ZD5Pr+H6LXLJmnquLfX6BTX4bx5XK11aYFWvZk+Ae8IPg6L3fHuPCYzeG52IiSOnlmVCmkAVZ9nY8BeYxVS2S8crDBprdJE3w5XOod4pfX32hbbh3QdnsEhFeP4JMjJ5WkSae0S5cNpKPM2rP6pHpgV66LQWNMG4EvA/yF5BPrVf9qHD5PQaYl5L0Vm2MCN+OsYNWjSvXT4IzjNi8SxfylAesSSL8lEVI2QWbFWdVeYaUaCTHJx2bMuKN2NMSOCzEqO1U4PCfHBoMiO8I82IBI2Lf099DXNosGZh3+stvIBvVb0+yrK0xvSxx3V82zePvI/P6RveMT+kZpNKxj+/6UXWg8exzVBGxfYSYQHugV+jwr+X/PMIM8ixu5BNZqon/LFCDjQptdvsnYqV+utJD8JSXyvRMagiG9wV6Dqdw/ArC0EPUzfPc+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 04:42:56.0935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a892ac42-43b0-4dd1-4318-08dc5d068500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
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

On GFX 9.4.3 SOCs, only 2 SDMA instances need to be available to be
considered as a valid AID.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index fbf5f65ab091..bdab65bc3105 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -649,7 +649,7 @@ static void aqua_vanjaram_down_config(struct amdgpu_device *adev)
 
 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 {
-	u32 mask, inst_mask = adev->sdma.sdma_mask, sdma_pres;
+	u32 mask, avail_inst, inst_mask = adev->sdma.sdma_mask;
 	int ret, i;
 
 	aqua_vanjaram_down_config(adev);
@@ -662,8 +662,9 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 
 	for (mask = (1 << adev->sdma.num_inst_per_aid) - 1; inst_mask;
 	     inst_mask >>= adev->sdma.num_inst_per_aid, ++i) {
-		sdma_pres = inst_mask & mask;
-		if (sdma_pres == mask || sdma_pres == 0x3 || sdma_pres == 0xc)
+		avail_inst = inst_mask & mask;
+		if (avail_inst == mask || avail_inst == 0x3 ||
+		    avail_inst == 0xc)
 			adev->aid_mask |= (1 << i);
 	}
 
-- 
2.25.1

