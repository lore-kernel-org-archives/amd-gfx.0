Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2D9C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2653410E424;
	Tue,  9 May 2023 22:17:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC60F10E424
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmmCalpkT+Di0K2AKQD2IDC6SGltPNsNGjdVs8sIfKXglMejlKPeYXoju+SwlLsYMxYFx5vIuQNfICwVeP6rFZ1SZtpBqtlTFR0he/CnM9swmvodvPnBHkZRsVfz5Pjf2OdsBU79YoD1BKIxT9/f44XcheGvEk0lUhtmEVFmOK77fIbVMzcsWI2bD3do9EVvIbZ5dyE4Z623SBKTWtkSBetJsbGqT67V/aoT87EIK2vgNpTWcL/axdkNzvbPD0ihXmrTE9nimNSBU31yMEE5B6S+xHtM2rQM9S0mjWyyq+pt6gH9nJdZCT40ZWPAt40qxKkbn4slycgxBead6j+etA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/Ca+ZFvHv8L51+y9tCpJfdeU9J5ED3a2HIa/fMYSjo=;
 b=UZABY42qY3+HkoR8qv0/Ijji16MjSIBzQLMqDy2zYPgDY+qpbY3yuwbwYHClbMmMx/Xn/8THAzxElj4puJTtQ5gjdIAX0msRJDJgFojraDeWVOODOrQgt2R6m2EgWlFCsAHs6N4uRfJwg6j6GJn3OKdPuj9080WzRw8B/+DhLoTe0DEopbmQjlHO4RXGpHoMes8eMbTzb3NKiAJmfelw8NMo1pOLdTH0JOroyxIHFkzdA0cDgiK2qVWse0v1OqCW3r5Y0JqRltuwlt+GWnX0WIK0viw4W978wAyzqbF1x+DBkhkAyUeJ4tFOoIbPMzx9yhsgPAxOXzCsXi+n5HM5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/Ca+ZFvHv8L51+y9tCpJfdeU9J5ED3a2HIa/fMYSjo=;
 b=tY2lIemz0SBUn4r7xe6iu+zcjKBrDZzb3BiAd9ajnC4YmSUu4NZIUbycY9UWUOwqY7KQ3iGfbLrmETuafVifTUltT8FAvAPG3w/A5Dk995a9gRBmQDZ5sN589yyUwY0frgNT3ezUy4tiXg1LMeEpj9HAzGOvhuW94K1yQBwZqc4=
Received: from MW4PR04CA0229.namprd04.prod.outlook.com (2603:10b6:303:87::24)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:17:52 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::b8) by MW4PR04CA0229.outlook.office365.com
 (2603:10b6:303:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34 via Frontend
 Transport; Tue, 9 May 2023 22:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:17:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:17:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix xGMI access P2P mapping failure on GFXIP 9.4.3
Date: Tue, 9 May 2023 18:17:36 -0400
Message-ID: <20230509221738.477282-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c93aab-ab79-41d9-5379-08db50db3b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVeDCK+qBmHsfrr3abcZLe6oYZsLk74VHQ7QO25AvuY3HDVqXYzF9enLQ/qGP8kVu0bfzFDCRv9zRrSZW5nW5A0arPakKeLipb22FVCrnse+/lLzXHdDBT9vUrJZGitOrxuX0gut+4gbXeCZSmFxcDUjGKstFFv6UigNAHBam9Z6/YaJSjU70khCKugnHwbUgdQTQ9f47fU0Ey8p/YVpIEhSrsk7hlB7hEU8HoqEKGJnb7RBMaP2A6ZVPr68JDfJ2K8pLMff7vye9lnfmKxd4ATA2fG/e7/4cg4yQ3JwM3SraSkMqg1oSPLP1JTycqkrMEYDejOuamPV5DQ7xru7hFn019+SWK66jhGSKinPtZldiEJIs/Rwc/VEqygHYfHsiwvQeUZBB/++XfhrUkDQ1sgyJmxA+w5DX4cl8272WUzbVp5BH99n5weZWT7qJ8+J5zhu+xRrA9VXduf349oF5aknaM5qTPHwndj5v+jpemFgidmAV+pBit1z7XNPQX8kqe5/g655m2shO7jIwQiSW8NmE2MNCfp4gBQZ8K7HRhpj2/DogmAWrHCdoi9A1pre9Qr2BCJcqTmyBelTLbxRH9UO3zv29ryffirMDZW6/0499AaIUl0QZA6TqB4dzwcW2n3MU2O2kuDmf1wctEAUPZfpDHkf1V5col9/E4DSVyVGMnUwLqTKGXNjmVCxQBfrmR0GR0Jxj8BayiI6PlBVZyN4clzdBo9qXGlX2GgOKSlXzcpYzYUAFO5CZmFZakNRK1yHtpbVSUBLWtXHagBH8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(186003)(16526019)(40460700003)(2616005)(336012)(426003)(6916009)(40480700001)(70586007)(70206006)(4326008)(6666004)(316002)(41300700001)(86362001)(5660300002)(81166007)(356005)(82740400003)(47076005)(82310400005)(8676002)(8936002)(478600001)(7696005)(26005)(36860700001)(1076003)(54906003)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:17:52.4740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c93aab-ab79-41d9-5379-08db50db3b51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On GFXIP 9.4.3, we dont need to rely on xGMI hive info to determine P2P
access.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-and-tested-by:  Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index c6bf66c9377f..58a774647573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -813,7 +813,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	 * if peer device has large BAR. In contrast, access over xGMI is
 	 * allowed for both small and large BAR configurations of peer device
 	 */
-	if ((adev != bo_adev) &&
+	if ((adev != bo_adev && !adev->gmc.is_app_apu) &&
 	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
-- 
2.40.1

