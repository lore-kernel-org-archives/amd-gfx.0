Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F449C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0568E10E1A0;
	Fri, 28 Jul 2023 16:41:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B911310E1A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWNlLAeC9UhyaGmcoSSXQEQsqx6KOea1iQZUFG66nZ5a49eHk/RJ7JPtoEpWc8VSjkX9LEDSnq/Ll7cXqp4YmfTh+HdKhjYcQTAuLJlaKX3ytzVKsB0X7OU2/buNONXWo4fUz44nsjCSrnDV8eLhLnafFzOieZkw8kh4vFpmyaRmiStBlKUeomOq6/EdOfveEpzYd0i7oaiRF0dyZKGycSm3pCimnIxTRVkU8VKSGLcL75IkNgeAdTlaF4Ni8hzuLEFSh+3U1hJfMdUhDpEd//hazHbfiL5PXFZDRAWOa4HXJPSGqQ2s7g3j3O9Mgq+bmbg91bAJ4lPpnbq8n93G3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ03Bo/u+7YDtaCL/S8IJhnzgPmlYQT+zw+g2O8E2Y0=;
 b=UEFsrMhhk1Y68jf+1jQtdlgw0HVfETCMhcpTKkeKcSr40ZeR9/xjcnXkxCriArmXFPnlJCnjH1hXMP9ERK2lSZg5AIparHeR5mek2e8JR6XcU0ZWSfIvhTW/o+ZKOvimxXwKVGYTcWhH2Hg26PwAar5/V3cjVZFLOJUZym4og0o1jtLCbszw2wowcSyeSPR1MtWcw4x+aqvWqL3tW3k62FrltQIXqp/0bWZo58OUP0fIFGgW6+xd4iJawbpsw8vxp9bAyiJJ/7ykvAcdQekK8yto13kfxSHx+7BnaNsf0WYbMwOXQGwOzWXWXn8heCY9PySOKvKKJCXJ+ANNDo7kTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ03Bo/u+7YDtaCL/S8IJhnzgPmlYQT+zw+g2O8E2Y0=;
 b=i+NKEDjaOLXQ4PQku4PpyG4IJc9IlxGxSs26iKj5r6QrrHeLe3HgRohV+pXH5QWIk8Fp+RX4Hf9srlbq2AuR3gEbjdWSHX37n22JW3rHn8B5b/VoC/qISBB0dYAviZpSMy4hZOFuJAMT3vISIlMJee5LN78oA3n1IsWTWMHbDkM=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 16:41:18 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::f3) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 16:41:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:41:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: disable IOMMUv2 support for KV/CZ
Date: Fri, 28 Jul 2023 12:41:00 -0400
Message-ID: <20230728164102.3327956-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728164102.3327956-1-alexander.deucher@amd.com>
References: <20230728164102.3327956-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b2d70a-2199-48ee-93d0-08db8f89776d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxObDeyLLyoHBzY86n/OfwANq7NGLq++wrQugf4mOLaZyBXpqY566zwnsUWpxGlHztDhui9EMJDS8H9NWO2g6BIHGhQgrquOcRrZAUW9IrFYmmEBwutY6XEb423UDOCURhXrPMbPkbBXHYG2yI5nzwZVMarEacbnfvhfvHBok5L5Q76mdDijqiLgjqHF2UP+RLw8AOgHkQw6+SIHqO1XaqlrjnJhPriPmEajlRfPCDhAyg//2rTRRNzRJ79EYmH3IKckupArxfJhJ8ECTEjJbzTTSrU9o3IJuLCZWtiGoxw41ddxUonSHxWlpTtVFUTh+RvuDrArpBwhg2o67OQeQ0fszPgYt8yD+RevM8rj9ccfIPq1P+wvlGAKeAUl35eAYwmrrLK8pArocE/fW3K/L7lmLUCIdm/i25qxO/bpN1z22eeOjuyXBMjn8TgtG35hu9Nq0LRAZEeVMMpIflQqwGECm7BEz7GHcD5dodUPkmyGtkQNagoYFT72lm70xilm3pDZgL+P3UA2jMHta6fjyiRHuxkPBvF0KTFCPg8NQhVedC6Ybv3H0k0KpUIU8q5yzpPfny6PZRJdJtFZlH4ty4RCeFDczO+O0lABIIzhy+/MV6bfvmHrBL7nsqrXSe55vdzHxUzKT+hI2xPNfQCV4C+JJpHK8Dv/6P/fDKwTbqT75HaOz4toaaJd+wLmhsOFOE4v/i5zsvLabpTtB6IYUJGI6AIkn093wa7kMlM8stEStv6CTakYV2mgIteojvm1BdU1sdAYyLfWGvoQoEammw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(82740400003)(356005)(81166007)(40480700001)(26005)(7696005)(2906002)(6666004)(2616005)(426003)(336012)(47076005)(1076003)(16526019)(70206006)(70586007)(36756003)(5660300002)(41300700001)(316002)(6916009)(186003)(4326008)(8936002)(8676002)(478600001)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:41:17.9237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b2d70a-2199-48ee-93d0-08db8f89776d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the dGPU path instead.  There were a lot of platform
issues with IOMMU in general on these chips due to windows
not enabling IOMMU at the time.  The dGPU path has been
used for a long time with newer APUs and works fine.  This
also paves the way to simplify the driver significantly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 64772921ea43b..814a6116ca9bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -234,10 +234,6 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 		    asic_type != CHIP_TONGA)
 			kfd->device_info.supports_cwsr = true;
 
-		if (asic_type == CHIP_KAVERI ||
-		    asic_type == CHIP_CARRIZO)
-			kfd->device_info.needs_iommu_device = true;
-
 		if (asic_type != CHIP_HAWAII && !vf)
 			kfd->device_info.needs_pci_atomics = true;
 	}
@@ -250,7 +246,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 	uint32_t gfx_target_version = 0;
 
 	switch (adev->asic_type) {
-#ifdef KFD_SUPPORT_IOMMU_V2
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_KAVERI:
 		gfx_target_version = 70000;
@@ -263,7 +258,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 		if (!vf)
 			f2g = &gfx_v8_kfd2kgd;
 		break;
-#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_HAWAII:
 		gfx_target_version = 70001;
-- 
2.41.0

