Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD11CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 17:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5082A10E198;
	Thu, 15 Jun 2023 17:49:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FBD10E198
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 17:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ff5Mh+lMNpuPL0KEJV63V36i5IMyx1aCeojjDtyWSuQsgnNje1341GusbP+bsdpQGSwLRutEfIREPkqzcvhnT36LIv976Ui6uUgHxci67JDvVbpL+P17RUjPJnzuC+YdpXmRImktNIjGdSaPuR6AA1RHU7pgs0ndM+hGIZhJp1FB300Th71ix/sWaZk1Qc4tkU8QoETTuBVewmiezknNlOeFT11l9B5Z1ngxYEcxzpa0tyCLUMxgiRsOJZzyZoX6jgV3kvcL8KbLLc3HN3ZugWaPX3ADHyw8ooZxEneU16rcW5v/U4VTaoA/sXQVMJ55N9GLZtA3CjjIApy/wlj0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGvrqQOkopOaG3UNk4NAS2lD0la33v4hidgM0njBQaI=;
 b=Nk/kjdtApSu51gVomvAY6wq+ckDuZuTaz/SHINiFYg78CnnjE89QmUct470Q65ad7sxIkH1hbccKUHoNa4xJlm3AmY+1q95dKfaMH5F5pGxdeDyYs9Yb1ZQUsvfO//2Hlb2JS/wY5ex5QogYNHFJeUE1t1ShEidFYMiTXNVFkrhid6cxVlCNc67t5z3amKWG3L2CuH9yKlhgkHUG+Lg4Y++/UeB930SdFUMG4lOizXShVvbAHoCshR/G9zto+MpukROq+KE184uf6MRpbFw6PIhkN8hzCTHZZKNbl8i66f0sADyTuHC0ErvCz44bh06lz3WHK2LSAQj8ibeuMJM71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGvrqQOkopOaG3UNk4NAS2lD0la33v4hidgM0njBQaI=;
 b=fD2maz693iWXF6Dg0AG5JRkHNxD1DfOcn+4lbd5rBqmxfp8Eyel4wUKkTE40DkCBj3GfB/wPl88f8TKU8DZCc4Es82E4fsB8e+aWuoglohlw4Q5xsq6qKeAxlVmDZhj0MGzLMPOTykAMlg+BH2eRn6Anpl5D2fWqzVbj0UDByos=
Received: from SA1P222CA0126.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::15)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 17:49:35 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::20) by SA1P222CA0126.outlook.office365.com
 (2603:10b6:806:3c5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38 via Frontend
 Transport; Thu, 15 Jun 2023 17:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 17:49:34 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 12:49:34 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Skip TMR for MP0_HWIP 13.0.6
Date: Thu, 15 Jun 2023 13:49:19 -0400
Message-ID: <20230615174920.25499-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BN9PR12MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9ed8fa-fb0f-4e8d-451d-08db6dc8e190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2M8MBsiR1mUDUTfFe6S69fJkZYrN6uQw0S1Acztckf1rLe09aAS006f62pd6wGvn3htFOMpz+lU3hlCIi1GGzMZeUVryJ7Uian1+ATes9oPvASGOYFSGq3bilfN5pEV9QhHF3hQ4nd2/RRHquptGcnL/6VEtfsuZDqloiJ4Cg6QehPUDYfKkG0h2kN8qTWghZS+mL6TD9u4NNRRaKryz0gfgm8WAblj3nxExp8QsXxmbnHWWMymmh0jHZHPrb+nProlCdqztCu450KTU4tg/snWZG6sxivB7qlwCmakJCNV3HacHtx4mpZIVYdnJOLM9WEbGmP9aJ17LOQ+1/OzPDN/9Gq9XA76zTT8mjF/I5ZcJJPRFk6Y5ae8YQ3AHc84FPlv/t7l66tBz1GD/3Ys3VEiSJ1eqEt1fMHs76wqAs2g5o0pDCUEcFIjXR+L3rGrqTzqqChspL7ZFf4Tq/qvuMbrkpZqTIYkAPtruvp9pEc16E8GSrphFEKtbe9hXnkdWtg6hwteoOxk+CQGCxWyuo7iyhBxwE2f9x7qJv8n7ZPkfWMaM9E5yKUdxskwPA2dMDzglBZzJ/fzCCFL/qAQ91eMM78xKiCTTScJ5fjSL8k96Ps0KDmwLkRxuO+R6onRMjMsgkAo4zVdKUDhM8zKk+J3/kZ171km/joeK9yknfETgTnJCn7Fu4FeeuM7oFozmqYyeSzyAyq+cktS/db3LUr7cgubJVnVwguuMWNwBC0MTAkXEnFKp3P8bK1ZV66lBgQ0FhGQaHZV8TOguyxN1gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(356005)(40480700001)(81166007)(47076005)(1076003)(26005)(8676002)(2906002)(4744005)(8936002)(86362001)(5660300002)(186003)(2616005)(7696005)(6666004)(36756003)(40460700003)(336012)(426003)(54906003)(4326008)(6916009)(478600001)(82740400003)(316002)(41300700001)(16526019)(36860700001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:49:34.7647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9ed8fa-fb0f-4e8d-451d-08db6dc8e190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
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
Cc: alexander.deucher@amd.com, Zhigang Luo <Zhigang.Luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SRIOV VF, no TMR needed.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: If9556cf60dfcbd95e102b1387cf233e902d9490e
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e15c27e05564..ac9b57231589 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -839,6 +839,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
 		return true;
 	default:
-- 
2.25.1

