Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13322C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 19:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F33510E19E;
	Thu,  1 Jun 2023 19:32:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8AB10E19E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 19:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLVko46BXuITH4Ls9ufFTXnUw7jfFviaQ74hrbrIHegx4G+kYFPVlXx/ChoLEuS4SFlytHzUT9CQGR7iVRnS4PgEd/7RUg659l8U+BUFCyic9uIQ8+I5t7G89hhFYu/Qc2RCOqGLqsIC8gZiC+e9dCjfyfkoLhq+pvcG6dWnL+Y/8ooiDoEP893L2Z7ESEJoEAMq0jhuQ3OLOspwsmeLQCdYb9g66DuP1efESCSH0shRjGbLTFZtBd6tel2Zb4oRIqQwYxAW8SvDonSJnXVPxuEg8FlorKYnqNJ9pr0FiAdDyXSgs9p2+RAN428PZ67VfqChsSc+5wq/oS8K7lZa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nn2ngzYEHIBuE6blt8/V30RT+E8BSjyL5eucAdtWPg=;
 b=eG7yCZN9um9g5Hs77+64yLyZoGOu0ddsFPPIVCMiyGPNej9ZDUDjWb7Cb8oG0djR0AJ7jymhZWpfqnQ2/3pTmANdoMCrk08dohzCw/xb9g69oX0xOUe6nKUDaby9CRj8z2JGq4S+fAz17pmIll6dRRGv80bIWQEr/dwGT1KSfTWd50LTI5YSiD+tV7aoNxROL7u5bexXjtnCLxFFKY/N/BhQpcekR2HMAF5+1HSKqbzucenHYj00p/fxp6vcMJTCgVxiSY0D9lTCFVN/tJpGspdgLcNxsPhINiQh59S7CJXr/JSAvKYbrM7dWsVUQr5cnRrNWGXCxyW1XWB2Z71x4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nn2ngzYEHIBuE6blt8/V30RT+E8BSjyL5eucAdtWPg=;
 b=FebUnXCsCyJ0+VBkfXbmAk4gUn7T0o4MNx4G3HVrT1bYsWubB52TAuSHRdqPFCbMXqhJR8dS58BGmusZK81IMKonWGAg8xfDGbLX8uQwJnDSAZcmTwYG1knucW4wCfmz6Q7MQoF5mxq0wgKKcNxpg+2Aa/kkSXR2i+WVtXWQS50=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 19:31:55 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::1a) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:31:54 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:31:53 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Page table fence
Date: Thu, 1 Jun 2023 15:31:13 -0400
Message-ID: <20230601193117.13143-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 7481280c-e573-428f-ad4d-08db62d6db87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAOFVcqEn+AQdIj55i9yfK1pi+cvER0+D1dm8DVwwEVRdSbbbG2ZLf+SSc536MWuorkgDZy1ID/m3oImF4rvMmFaC3yMJDkI+iwN8a6946qlu6+au/Fg25jigKgPxFADi/c0tU0Yp5XVNXROIH1FidKwBc6Q2XUVZfZjf5rabESFwnUCbMIPJ/9A8DOP3EwZNacOuZVeE4DrmVtSWjhklhpFSAThDa6Ova8rHc1L2DeBZAxeET7ElsEkgyHA+7+BqHn3FqAK7UWPt9CWm1/UPIyugPIeaRHobfYOIN1+7j5X2kNEBEt3a99qUSDsh1EUdoIpr25o8Y/vYnIkTR+us9DmhLyoUQhvHemSD/Mszs+AUHAApFiCx1HeIDiSW8YGf8cfea+GI4MZI9z5u6HYZV0w/dWOLotlsgoj8ietYrILJVyYOq2wlpCrAurUYHgIshh/OHn8s2CrMwEksJUh2SLh8i9EoMc97P0bUKNk61yWxJZ84QE9y8DW/b8SU5ZRM5RSJcVv2mElBaFtO51p2bY92uDsAFjTeagMYewOsv+HkVbqZuJCd3EVBbAMf2mE9nzmlAxK/97HPWYnq4azu0zuGp2+Z8v2ipdjZ4scPdYhtjz1CyDmI2TpVuK0EqEg9UfUzjzsNDl4r0Kn1p1fqaOM4+tLQ7muiddtEyVCwgTCbEbG8X3XGSYJP288WbE1486XVxOJ+JqZt8waTFzIVBCRDvdErzbEutQdPtEChQTUsTw+lC/E0VKXCTl844TgPg2lB6wSqiczN+lyDpSBMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(70206006)(70586007)(6916009)(4326008)(54906003)(316002)(478600001)(82740400003)(86362001)(36756003)(41300700001)(1076003)(186003)(26005)(426003)(16526019)(36860700001)(8676002)(2906002)(40480700001)(5660300002)(7696005)(356005)(82310400005)(6666004)(47076005)(83380400001)(336012)(2616005)(81166007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:31:54.7276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7481280c-e573-428f-ad4d-08db62d6db87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series to fix GPU generate random no-retry fault on APU with
XNACK on.

If updating GPU page table to use PDE0 as PTE, for example unmap 2MB
align virtual address, then map same virtual address using transparent
2MB huge page, we free the PTE BO first and then flush TLB.

If XNACK ON, H/W may access the freed old PTE page before TLB is flushed.
On APU, the freed PTE BO system memory page maybe used and the content
is changed, this causes H/W enerates unexpected no-retry fault.

The fix is to add fence to the freed page table BO, and then signal the
fence after TLB is flushed to really free the page table BO page.

Philip Yang (4):
  drm/amdgpu: Implement page table BO fence
  drm/amdkfd: Signal page table fence after KFD flush tlb
  drm/amdgpu: Signal page table fence after gfx vm flush
  drm/amdgpu: Add fence to the freed page table BOs

 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 45 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 33 +++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  5 +++
 7 files changed, 86 insertions(+), 11 deletions(-)

-- 
2.35.1

