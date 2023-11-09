Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9475EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 20:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A3C10E91C;
	Thu,  9 Nov 2023 20:51:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6C110E916
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 20:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffs0cMFDE/M0MsDa8T2Pdp28AZ+6kB3nPj1SZ53+n0jNgXimZLUNUFn/KepgHz+Y5I6eEFZlJockA9yRLC47FoOJWOzOQfnc1+73IN8UPzSLJKjukN2Q6iwVei/OBHlVdlqLgG8P6/j16QpsELCifY+/G5130aCn+oMLMF7UhPrQ3HtB/1wUcfTwsxpLL8XBAyRBg4QGfgTdV2E33+NIubTNt3XzoiMh1zlhZkF0wTCG+ChFr/HBOrGEUvcJKbwnxpTy4DHL+w9aaUS5Xjhdh8Ob3pjGKKJtqBmlJlbetXOfSLhX0Tw+sSkvy7Bau90WY6TyW3tE7xFf1x0fFSvbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XDkOZ+sMfH4XEtWnnub9Au/VQNN7lnER8oxPF4lRHs=;
 b=ketETREtyjQvCo2qOBTOnFTaXBwS4OHWHxeA/EnR51w2G0Slj2OP4YFx6vS44hKFH/mvo+H0rUPVhheRNrKpsCQn19lUOQqpzet6PO2lzPm68NwdoPk9Cn3q3Veku/dL0dJFz5GVMjFlk56wOYLaYCWyDG1kA9nRNRw/B9Q0OjQymvmrlezxJcdxSScf2jkAdXCK7Jyv51A6QhTyEURB/d+i6vQ40VwCHuteixOdGAHXP5c+9QUcjrBFMgne8znjgD1lszqoEin3ZqD1p0heAAHRFFjAaCvg4oYVuy9mrfdRcZxlI6lWEFtUahxpIWzh3OrSiXM8e+13cmfu99nK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XDkOZ+sMfH4XEtWnnub9Au/VQNN7lnER8oxPF4lRHs=;
 b=Q1ST8mTt215BQ8J/5ACaMj7UJCFoQf/3yuedw5Ahq8qoK3KxS3SjPzokt1Pb1CxxhlwSfN2VaTVrUjwZhnLpONr3cN7tlCOYy8JCkmaMSn5d0i5AVtaKvO4zh7Lxc+jfuKp21Iuln+aXQ6Gi4MBMGTSSpdm0lMAvz22Pp0RjcVs=
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 20:51:43 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::56) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 20:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 20:51:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 14:51:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu/gmc9: disable AGP aperture
Date: Thu, 9 Nov 2023 15:51:25 -0500
Message-ID: <20231109205125.513643-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109205125.513643-1-alexander.deucher@amd.com>
References: <20231109205125.513643-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: f65c9c98-af31-468a-5682-08dbe165acf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSVbaM83m8w7OgPzObJMXWDKqugvLO44Jw14eJeaA4n2P/hEOjITUEbj8WTmkaLta5pYDoaQ5+DquOJrmfD/Mi6bZue5V+vXWFdHVhoIRegOlelX3u/RVFYS4rAc+LUHsMZ8FSp/kuJi2Ap4ofmVw898IukS8hDoqYTWbcgp+Ogd1Dr7/2MDf7xJbQq2/8FP0RfNnRoZE/uCkESsrT/abQfOYfjTGQvoh7RNaCDQmLXTw7/bqZDCACX/HZt7hbe7xtQAoQOwJuKS2qf0LHH3fZ2rI0zVfRjdTyd2YjDy+VAFULbE2DE2yAejSVubWSggRu/Ae48cUTGVgjGvc5A7liXSQkuQfsO+8no8f9jxYhNlBJ22LnQYNkqpt/Z9j65msnwjsxeZRiPVWvs0/sJt83ll7R/nIXpJYHSDCIDvCpBD7eAMvHocBVMIcje2Vdf6g3pkuSsH5nc6TIAjE1HuH0dO1HDNNQ/fyPpBwPIbKfSRyvAP9X7JLLDEMYrWh8npEfuB3h17ZyzqeE530qceTBirlJc8eFO7JrURZVWjG+i4LwDIyo3Vb07S95WtNIuZCIac3wW9G3AO4gQBL1hauwWD3S3zkz76ZthT+FVWcvmNq+nlQIfAxymQPrIJJWNttvFUT9FiNAUbTa/Wu8owWVduYYjpLyADtu6r/uPxllqRtvK79wtIAJL/nHmQ89pXxoifJNRGDqQWD8/TEgFevE+QNbw5szkvNVm7snc76EmGHa/Zu5e4buDmrZJyDLrEnytxLUCH/kT9+TkIGUth8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(47076005)(316002)(6916009)(70206006)(54906003)(70586007)(7696005)(26005)(16526019)(1076003)(2616005)(426003)(336012)(36756003)(6666004)(478600001)(83380400001)(81166007)(356005)(5660300002)(41300700001)(82740400003)(2906002)(36860700001)(40480700001)(86362001)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:41.2022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65c9c98-af31-468a-5682-08dbe165acf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We've had misc reports of random IOMMU page faults when
this is used.  It's just a rarely used optimization anyway, so
let's just disable it.  It can still be toggled via the
module parameter for testing.

v2: leave it configurable via module parameter

Reviewed-by: Yang Wang <kevinyang.wang@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 22375fc23412..bd69cf61de06 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1630,7 +1630,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
 		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
-		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp != 0))
+		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
 			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
-- 
2.41.0

