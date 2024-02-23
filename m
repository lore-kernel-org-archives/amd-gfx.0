Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8305C54798
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 02:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1294C10EAC3;
	Fri, 23 Feb 2024 02:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="naWqubTc";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86AC10EAC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 02:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwqZXCawRnx6HaN1TZPd8ZT9eqyLR1vCfpR//5VqHc7Gw1WPWdwxbqoE8vgejNJbV6InFEy4lsdiymRN4ASp2VUfTGJdyEpCIGvbBCIGEXrnlaFCA6icxJYTO9f2xeKvmc9eX5pFt9NFw/IzM5snhTWzft2yxQnNWw+beowq4ITWHMjMMiHd0gV7IYCyaHeGutlqwWbPlKL4BlPxgIK9oQohq0N8fHskJHkpADRqvZZ4LA8Eq1bwYgEYkuoRoqVQy9cjJ3leVZivzgAj9BYRM1b7qVfY5PLTS96Hd1vWScQCAwDAgeUtYzRqj4kYCVv56OzQvE1nGmP470x3LpBwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS2nNfZyqNVS+ioUAfXtB5sFKwE0xBZNtul8ZV0Hj7k=;
 b=iY1SIHOVmCdLc8K5vsb6BTKZYtTLufghwOeCbTC81IM6xGi8CeQo39URVaI0pSVS40nVvNuCjnNOhrHPGuOEzOJBuxtKG5LCRd9cAc8tsEKZRIHUlrHSMenpngHSpvaq0yBxD9VjYuPc7y1B+BF4aqGr/2j3M5FbJq+qtD8iRQr6UCIwJ9dDUsW/1jbat1FHbIZtXA5JToAnSGBrib9H95LFTQVC3cINrYbJg8QgA6dkCK6UEThBVLgKG0pRuikVZA7HudZmCNXRJhgPt9sLExAROO8JO7YjjVTzbpndW/KdpscJQILj7QEy/ra6sKKaxIP8hG/LjHfT+CahMZJHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS2nNfZyqNVS+ioUAfXtB5sFKwE0xBZNtul8ZV0Hj7k=;
 b=naWqubTcPzlHsdNwb8F7WZheTGp/wXx7j9WUt0OdmS7bxjjX75eAlwrUFQ3UGGkWKgUQsOxPIsrJVwIPk5UxsaHkKCZuEEvI8b7qLDTDLDqX3QRZhZ7MILo2NzB/4JuZv0TL/k2Tg5Ax7dU/5L4mdyzeaj5ptyniLHzA4O7GAY0=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 02:39:32 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::e) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 02:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 02:39:32 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 20:39:30 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Enable gpu reset for S3 abort cases on Raven
 series
Date: Fri, 23 Feb 2024 10:39:21 +0800
Message-ID: <20240223023921.1115688-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ce023d-9598-4085-7a5e-08dc3418aa83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNVaWoIRl4x79mUrR5DjggkMnw5TDc8WdO4palOCHvnC2phZbhHAlGn3/YfZz/VL8BZ0XNU1PA7TiIDSi2SFb9dLWFnkobpctFL+qgGoPAlE3Pp0an+vGm/3BzsaSLjX8Mv4IAjXG1wxJ36hMGxDCorT2oD23WpvXcU0hnIgK6qm3Rl25ABWhoINs6eanQaB14HkKsJ2gcgNpoN1AOFvJaUhbRUf3+qzzloTv+touD81UUHx6TkEtX+sTWdZdMrkX+mp9IENXA4TzuSY3nPUR9MmTk7zTjDDJlH6yN3lmaACk1Hoo4MtNVHFhiP+Gf/AO18UjQEGNtE6WjrckFC6nSQYm7HTEKy4FfuQyc1Uy/veNm1EiwaQjIZK+csTG33/nHE2wk1hhOTDXReBmNIWOA4KzCKHxc9bu+Qob5fL5FnLTr0zbesexf5xL8LGJIEm2YtCt0xyHAe5F5QGZWJmiQFZiVCOyVUdxS6CPW77xgKfJIUdfIYFZw0zGqKK0wQkLakkTP0r7VgaaDn/uWsgtWRw9B/me7aN40nB+uuDEW/MiU4VyS0foK5YsEdsVDHyc5+acjnALLhPV3a6hU1nTpda0Gbuncwi0E5UplACw+Khhy0SqXhJqSP/kUxjZPnDdd9ljvRavYCWoDciDM1lpYIsUj88gu5w/+XWwLUqOGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 02:39:32.3901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ce023d-9598-4085-7a5e-08dc3418aa83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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

Currently, GPU resets can now be performed successfully on the Raven
series. While GPU reset is required for the S3 suspend abort case.
So now can enable gpu reset for S3 abort cases on the Raven series.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 45 +++++++++++++++++-------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index e4012f53632b..dec81ccf6240 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -574,11 +574,34 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 		return AMD_RESET_METHOD_MODE1;
 }
 
+static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg;
+
+	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
+	 * 2) S3 suspend abort and TOS already launched.
+	 */
+	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
+			!adev->suspend_complete &&
+			sol_reg)
+		return true;
+
+	return false;
+}
+
 static int soc15_asic_reset(struct amdgpu_device *adev)
 {
 	/* original raven doesn't have full asic reset */
-	if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
-	    (adev->apu_flags & AMD_APU_IS_RAVEN2))
+	/* On the latest Raven, the GPU reset can be performed
+	 * successfully. So now, temporarily enable it for the
+	 * S3 suspend abort case.
+	 */
+	if (((adev->apu_flags & AMD_APU_IS_RAVEN) ||
+	    (adev->apu_flags & AMD_APU_IS_RAVEN2)) &&
+		!soc15_need_reset_on_resume(adev))
 		return 0;
 
 	switch (soc15_asic_reset_method(adev)) {
@@ -1298,24 +1321,6 @@ static int soc15_common_suspend(void *handle)
 	return soc15_common_hw_fini(adev);
 }
 
-static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
-{
-	u32 sol_reg;
-
-	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
-
-	/* Will reset for the following suspend abort cases.
-	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
-	 * 2) S3 suspend abort and TOS already launched.
-	 */
-	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!adev->suspend_complete &&
-			sol_reg)
-		return true;
-
-	return false;
-}
-
 static int soc15_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-- 
2.34.1

