Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C04CC48BF8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 13:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A715910E939;
	Thu, 22 Feb 2024 13:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MckV302e";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7751E10E939
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 13:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWol2tHS+xFBXDXdsmwtUo8FTSkUtsRr2AwbeeTTzfKIbkYJZ/k79/oi3mMTYGsNoHQ+AuBW/zjLFSrY6mgFSRGaueR8K8E/YkG5lvKg5aD73kADNaef9XmD5ZvBYIQppgzjKrvfYIdXub++Z1NitiITdT/o1IBU/4URNJYE6WcFJX/Ba7iPg8om7tUOueGxZd7jKUxJLuINwd+Vbr5FdciduqdlvF2rEkHafI/cq4Sa+kJ6u59tBCOyzNqr5Xr04jl9glPptTsh7nWLs8PbR0FGvFFWgDe9dm1SdPv/Ipo+nHsX/Oe24dU1bhFVinvdwt0MPEYuxz4LlXbvQOk01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szEYTQnUlpcRnY/bA6lAVM5QdrjE4AVWIqsF8BVIEk4=;
 b=E1J9LY8ZHCbo2BrSWh4z2BZqHfFwBvv8jZAdFREbWgduQVi6tyZymPGOBa26kXaQgbwcVY7TvGe/nZ/jWEFpsy2nxm0tSPnhVaG25Itx4nFd2DJeMqtRfBZ3cAHLWySBqWB1dlXfcksZdqn9Muu/jSh+aHvCMnCsWwoXIUumExbxA0EZKGKCA5EOFw4hRi33g0/1bfSxVrxf6pe1TyPYiexQZwJm7P7Ltfpx9dI0xwYbtN36kaifH832U7dgjrzOyJIC3WBpV5rm/OyWrf3qyyC8dG9dVfuZsfXNXGvPvux3Pyq7Ra7Z9lF1ozBIDZNsDQUpBrJLzEwJwRGg1gU1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szEYTQnUlpcRnY/bA6lAVM5QdrjE4AVWIqsF8BVIEk4=;
 b=MckV302eHQs+9jC0WGC9RLnB9pScPzSAP5p/OH4vAlZEU9LsLfxWvSZD69CyzMaseOjFWBf9KEAUegIOIg9cq2OcJxAvoVbbDWzm6R/8KvxQ2KqKTQf99N7QAQNwQsuMn084UHHQ0LOnhtHTO1zsB8FOMZCh3vClXT8C/Jm3GXw=
Received: from SA0PR11CA0107.namprd11.prod.outlook.com (2603:10b6:806:d1::22)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 13:41:37 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::27) by SA0PR11CA0107.outlook.office365.com
 (2603:10b6:806:d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 13:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 13:41:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 07:41:35 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Enable gpu reset for S3 abort cases on Raven
 series
Date: Thu, 22 Feb 2024 21:41:26 +0800
Message-ID: <20240222134126.1111837-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 19848aa5-f640-4e63-118e-08dc33abfdd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JnwYprI9Vss/+9IVUtj80pXSTCQHYjhT3xitsMFZ780+D1gBflMYUFtGVMbqJo9CyiS+fTDYGDJyFh1+1mQ6DdUs0VGPnH9/scRloLQZ4dzu0B9/+95hcZs1WIbZXah8zSMI1ZZRYzSeJTR0JzwjN5SFxDJXHKy188GQYbLYP5kivgd+YsCp/ZHiep3uYnZL+Fgv0fogGORj0Rp4GP8yGQd1UWN3J+m2aoJQdQF511Ntr5S4fTtqSJQBONuDKEEz+v2R23JtyH4lOkIgZedTrethJNw4HK8PUOhm2/300Y8ACAcbbEP+taDg4RdjX7yDiG4vVcShNr41YOIJpGhFE8sxFDH038pWThvYDLba80GwdbidF1LN65GLbDSm5wSR9Hqrib4CYlecvdWOZCKtGkrVAigmzjITFbcD4TzIxviecQ5rSakyhwwff5sq8nFBouAAfBGP2Ub0H9WnlIOe0IQuMj0Ol3vA4mWBsNJplJSMFR44J/q4KifpXRm5NTQvsuhdGdicy6EhmyKQbI7XfuB9wWt/DNadlAHf2lgiCd6YmIgyLeDuyXHPIafYdc48mYRRL3F1jFKd6cb386ayIn1iGsvt5ooY8J7rCxTgHHKzl0x1hc4H63mWnnfuN35JIJuiaBVzWSXLBBnfokUsXvkoYUMhoL45L0/ErhwuY0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:41:36.9878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19848aa5-f640-4e63-118e-08dc33abfdd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
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
index e4012f53632b..f68ef0863cb0 100644
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
+	if (!soc15_need_reset_on_resume(adev) &&
+			((adev->apu_flags & AMD_APU_IS_RAVEN) ||
+	    (adev->apu_flags & AMD_APU_IS_RAVEN2)))
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

