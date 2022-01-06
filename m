Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BEAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 07:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B44F112EB1;
	Thu,  6 Jan 2022 07:30:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC58112EAF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 07:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGgmzwFLKeD7/kQeUqy6tazBLFIv4+BSggD3JXSJBwviPr2GODgmnxOe+nMlm6C6pxteDEORJ9fu4QGmiWuxtMLWQB0XVcEtUHFcmfmUXLbWvCDkWCLx92UcyTUuW/I7NuzVbgTKrVFTQWZ7TrchDnJcnRD+FPLtLwrikb0JhYMU485+mTzY5U3rXuGk42VTqR4rDrxAwriRlK+U/o22ak5C+RCB//emftx6HjB1kxAlP8Z2MsQuyBaZPawhb3//JfYIllEw0Hcrtmb516Rbwr/k1kY37dga0Lq9o13mVm24wh/83OTklRhtRh4bA+1h3OoJ4hOZvneFobsLHYgyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhtKT4mswnhNZu83VQxJ1tbzAHEM1rZl9a07A3IIcNY=;
 b=YbVQ5x0ICz61uqWS52e/tJvCQe+ZPWyz3z9U+mZleo25v2vToRhGC/Ez3xLE5Q12RvqbrPiPNsGX/F5Qndq7QN9F2GTVdGoWLPJY5pz/Hay7UbzZF4Ydcx/oFw9QStj1nv2caKfmDEmCRYrd4yQsMVEPt71eWgCsPA4ujr7TrTkjFBxgBG2T93qHDPy5AxxlcgshOpTo/H4CVkIjY9EJY5+DsZNBXCQ6okCJNeUsnk+t0upD689yyzMMlfxr+JG9xNSLysJ5GRnSN6BzikFcKGtX+jn1M63i6C9W1Cb3KIOu25JPIs5/LV/+OE6BYioUy2A4Tei1y+1P4rBpyrCbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhtKT4mswnhNZu83VQxJ1tbzAHEM1rZl9a07A3IIcNY=;
 b=U0XFEj1ftdCfXCwD+zgNHVV9Mf8Qu+YhlUZZ31i+pnZHHrFRn05rWzuDpk61bI3l5S6EAgL/RaiJT27SFVHPnvb0osmtGd0ZMZ2tBzJdeK7eWRnI5UoUjLQ0eYUDjLjmhmEmDahOOwUD+VdfxfUmuMua/9b8DqUAspd9lUhcOdI=
Received: from MW4PR03CA0195.namprd03.prod.outlook.com (2603:10b6:303:b8::20)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 07:30:14 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ca) by MW4PR03CA0195.outlook.office365.com
 (2603:10b6:303:b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 07:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 07:30:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 01:30:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 01:30:12 -0600
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 6 Jan 2022 01:30:11 -0600
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Enable second VCN for certain Navy Flounder.
Date: Thu, 6 Jan 2022 15:30:00 +0800
Message-ID: <20220106073000.14878-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bf69866-d39c-4663-cced-08d9d0e66110
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2981A4A1DDF901577F34EE19F84C9@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fajqe+mC3sHOSx4y2z1EjlTpAzr0ADYVpXRQ7ZoSCAgoOmv1jnLQUgLvf9IHAuUEDWHuC2VVtswKuIJpHzIrFoAvolcrjidXCtuiyYB8eyCwY5Uh3ICI8RSjK2y4Jk4/p/bzK5pCrBKY6KKgRy32zHu2zeHrl4f7v8dit5/Rb+wj2Zt2jP+Y6R8oqa0Lz6d7Y8NZJ9WrLwD/6CKLAWD3AC2GE1KlzgFZFPntQU/Ly0SpzvRr9PCGXDO+ZjDHzddh1YAryGGguOUB8/dKGitd04nuAzoxn1xkIPUrvg+d9WVPo0wmCLARXC2mIuX4miU09EJuLTGgbTGmmftaQRoDQLE86GK1LRzFXlCs/EvtVYxB2jycbBZbnNq4dYG7BQXdinQGTNJnWMTlbp/XEJwLkMT6NCeyrPEO6eJRNBZU6g3toxaAA9gpZUnEo4x7krUbFbBJmOsZPMvis2PBLPIObS2cz/1m3PtXT5+OAUSd8Adglhp5HHgcn+88gsKx2G8JKB9OH9RJhOz/lYktLJ/1PWSz556KSfottczGZ7BdEAjscMF7CRnaPfYEysDNOUSzro0P/fir3tFiouvl9BfV5yDLdosINRvW0NgKtyoRx1rfQilt6jLUpLLYxG8G7G4nnrvN3LtAB5A68bh8/RosR61/LxdktxRVsMNucmFJT6e/s8CciFhsIeVNmoqDbeguF5O0IZ+RyLPaGl+ObR00aBVyJVF/mYgWZMgfYhtGu2PJb7TR6wfDzaaBPhc7AFZzsL2RsKWORLIQO+017r7ftEn29R/S4bwtJCIapF+iB+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(6666004)(86362001)(356005)(2616005)(83380400001)(316002)(1076003)(36756003)(40460700001)(5660300002)(4744005)(26005)(81166007)(7696005)(336012)(8676002)(47076005)(82310400004)(70586007)(426003)(186003)(508600001)(70206006)(2906002)(4326008)(36860700001)(8936002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 07:30:13.7776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf69866-d39c-4663-cced-08d9d0e66110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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

Certain Navy Flounder cards have 2 VCNs, enable it.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 580a5b387122..57e001d73ec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -550,7 +550,8 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 	}
 	/* some IP discovery tables on Navy Flounder don't have this set correctly */
 	if ((adev->ip_versions[UVD_HWIP][1] == IP_VERSION(3, 0, 1)) &&
-	    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)))
+	    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)) &&
+	    (adev->pdev->revision != 0xFF))
 		adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
 	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
-- 
2.33.1

