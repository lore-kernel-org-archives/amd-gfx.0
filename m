Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A51C43217
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6316810EAE9;
	Thu, 28 Apr 2022 21:30:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C6010E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc1/dFDfSHAx08sU1w+LCzhD30gdwOAZRDifDeOCBNxKT893megeuW2DvmLNjqPKZPq/g2pez50WCPjs39oLx1i4vdhCAScvDEIhKhzcF2AT2MVslR5i4dciJeIJEH8eKKAOfcnA37D/b+QrZpONQfGF7XdC6sVIO15tkVPMXjCspe0yPjjjFnshzpMlwq2CYw0Wv0hne6k2gKT2sG4c/OXDpGMcZOqwdNE6vjGDK4+NBZQJKhtVNkkgD54VFydWZiS73Yh03hgYIta5vUG8qOox5DWxmkm3MIFqOCYoL6/VkLIpet5W5h2EYrJEoYTFW2YuYGG5Uh37Q0TnFhpRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fR+B0a6SFkjkJ5+DNgDLB7HINjOVtyVfIizEVMzF4X8=;
 b=H/7dSxwbxnsyTGtt3pGYtM9Jij0iYyi8LSmNPIUH7uKvg2TFEksrVGPsHElSmgPG8rRHJVgm1j3/p0Q5Nihzqo6H673sMSlibC3vqIYhOdOrocR7U89HZ8dYtcuLYC888iIQHATrBo35yapI17e4pkbJmyyEFIv5piEilY6D9ZvKzPQiBptHAUKCeWsXPi3Hy9ojNzLJhWq7YnHswNnh9k5oC379nb7jBy0oTMRcqZ2xnWC4vfpoogzPEVH2qv3bmMM4gywNl0nmNIWEOE2dk70nUjLvQBCZlsC7N+jZvZ1/OnxOrxT/hxDw6BNy7tskGDVlFbqXPJbvbwhKYPzEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR+B0a6SFkjkJ5+DNgDLB7HINjOVtyVfIizEVMzF4X8=;
 b=SYnbkNhN4v/vaxwETbPfxd7oFFFS5r5930SweYerreTd8xQg0HMdtfZnWgKZElbf6sSNaduE0m2WxD7ZuEIrP3bBxIPck9Ch8KJmGzsd6v74Lyw0K0JcXB6R5CznkoDsmtG+xw4QEcaut44X8k3mIWWw62vtgeziRX1CcSY1OGs=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 28 Apr
 2022 21:30:04 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::df) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:30:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: move bootup values retrieving to ->sw_init
Date: Thu, 28 Apr 2022 17:29:40 -0400
Message-ID: <20220428212946.700296-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2dec172-2066-462d-0f68-08da295e4218
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6169:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB61690DB52D5A2CAE9F89042DF7FD9@SJ1PR12MB6169.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sysnX92HuaiBhR8GIYZk/hryUsR4umftnCaPEr6U8Y93iyJC7Z9mcN4nnubIvTsedO9pFgnsV8yU/7sZqkTdfJGzBqTq14v75IY3Q9wZ+qdNHcSwNJgrRP0FS0xTVvAgOvh7/FS4R0KoNFp4IKi54aTOf1S0v/jxbgGkSqJVnU7DJYA4mWhGoPrnV+4Pqc7BI9loKeFXg707Ntf6x0WpiXR2uGECg+X81dUDnAnt93rrgsH33cPDoB5TweuM/pd6agDa+PV1mY2XYoimX1S/2kevcqLctsolX5/1ztlTnGiyniBQJcNhBAZ2DGTSIoJ2p98+UqhIaZFyjTouOOFeIIeM/QiaBo7JyeVUQ7F4xJVAFZyAYIEOV19iuehwFzaFrGfZ4aNYpFK2f7snhaoADRLrgBTV3LJkA6Mk7USlqcvMOVsbMkOwbVbvuIm2IT6qTClnGZSrdBaUkpNjvTTTpZaf1bq3gvHTwmmPxHBzPQ/sobzoXNXVtdT2ljoKwKXNxELccOfq11oZmBAE463VDZb3y37BYoj52/ft2WwI64wCHBVO6rLcEGCJ2lrEMYo93JeXTNlH40O/sU1mylVdGvLBC1z+x4u3A2cBV5d+LkPh7FEX8k5CDiaagvP1+4goUpUe5oW2nvl+aKGl/+lNuwFG3redc0yZqnm0DHRmJr0Ys/jS511WLQfcd535v+Ax5ePPv9D+lwvvdsyAq/bK2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(26005)(70206006)(6666004)(5660300002)(2906002)(508600001)(36860700001)(356005)(81166007)(8936002)(83380400001)(86362001)(7696005)(1076003)(40460700003)(336012)(16526019)(47076005)(426003)(186003)(316002)(70586007)(6916009)(8676002)(82310400005)(54906003)(4326008)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:03.7165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dec172-2066-462d-0f68-08da295e4218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Firsrt of all, the operations involved is to interact with
VBIOS. They are fully supported at ->sw_init phase.

Secondly, the new mechanism to upload pptable to SMU is
introduced. With the new mechanism, the pptable transferring
has to be via PSP. That requires the pptable ucode(and necessary
bootupp values retrieving) must be ready before ->hw_init phase of PSP.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 904d516c040b..07f44970bf63 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1020,6 +1020,13 @@ static int smu_sw_init(void *handle)
 		return ret;
 	}
 
+	/* get boot_values from vbios to set revision, gfxclk, and etc. */
+	ret = smu_get_vbios_bootup_values(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to get VBIOS boot clock values!\n");
+		return ret;
+	}
+
 	ret = smu_register_irq_handler(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to register smc irq handler!\n");
@@ -1304,13 +1311,6 @@ static int smu_hw_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
-	/* get boot_values from vbios to set revision, gfxclk, and etc. */
-	ret = smu_get_vbios_bootup_values(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to get VBIOS boot clock values!\n");
-		return ret;
-	}
-
 	ret = smu_setup_pptable(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to setup pptable!\n");
-- 
2.35.1

