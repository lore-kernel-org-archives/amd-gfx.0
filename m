Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8473EFA3741
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 01:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA8610E2BC;
	Tue,  1 Nov 2022 01:45:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C962F10E2BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 01:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULBaajVmlbE9+piBNWAoEizr1HpAovDyp74ebcpo/1Kvn0i1ECHxIgzZjcjMRM0iqkYuW7WTvxH2mzyfHn9d4Q1ev+CN4y/F/MR8bgzoqyjdAitnhfTgRR9Ozslx3RjUVWW3HADYva0WQRlpjFVXBBxdhPISV47pxYA8aZp9YaX307pz/D5VF2Eq9WChErMKbn15bIyE5H/3aWk8kETn2OPcAZqvAhtN+f5UuP9aG4nu9QMeT9INmljEVhWXWNiIexsKlz2DvLgmBwEWN1+0Q/1vgCvWZ4+TRHLIAfeUPcKIMPflsdn1l4rG7OgUWHvcRBc6cs1eTH4t/j0nEXbkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL6hDMDnN7fh+oO/9/jK4EwbD7ylBS3l2yi8CVCN0bE=;
 b=abfYoamTrCOxUd4KP87Ur2GYRabhn43G/1QUr3efi3meFlfqdRca7Tsv4iuhvoPYfysrwfwUwR9tDfeLAueMHf367hvHgnmF4kNajS1pcjhBbdrJJRj7LmiU/jJauD420qyGNnrvcQ4Cgab8cYcYJfGlMI/Ng9RMb9cmKmiC4C31IpqJdlBMsDuP4fb911qX7KhGXFGL+qMiK3mxiJgarrzRjkIMt33jhPDSJqJn8HKXEScZmayypUUoLT2gwJfdC+2BBbyGdz/V2GKtYX0K+0xWIcN/2YlZiS1oLcz2J1DlA0KpTIqhluGH8TU3fg9pP4LXnLc9MLetn3XeLUZ6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL6hDMDnN7fh+oO/9/jK4EwbD7ylBS3l2yi8CVCN0bE=;
 b=zoud7dxKgggXB6Kf0So3AtFzOY/OmYSGqGlLIahGZMI9m45YVqutry2qmA5qFpUs0C7+cACebX7y6eUz+yEvr96SDX3rYEanMBkeribPLii8VwcgKaaZZXNOQV4I+/mJOTccJ8qj3skb8s9ZTkR7kpCCnSj06dorGQW8rKWs/ZY=
Received: from MW4PR04CA0188.namprd04.prod.outlook.com (2603:10b6:303:86::13)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 01:45:46 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::aa) by MW4PR04CA0188.outlook.office365.com
 (2603:10b6:303:86::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Tue, 1 Nov 2022 01:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 01:45:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 20:45:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 20:45:44 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31 via Frontend
 Transport; Mon, 31 Oct 2022 20:45:43 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove unnecessary register program in SRIOV
Date: Tue, 1 Nov 2022 09:45:29 +0800
Message-ID: <20221101014529.8842-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 042efd09-ea32-47d5-983d-08dabbaacb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rohLy1ChbE4gw3/vhF1hNeo7FGdye6HNZL/TPcPN5lULGTrsvQT+88EZdrh+rsC/s36e0QSADfmmQWftK0OYX8/1QRxhqKfZbvMoC9jhDTcI/BoiVBj01mlgNi85ljynKMyhOWE+UxlVI7Nxt3Q5LYXyhLd4z7BOPugjKGF5r34UnL9uO1m+iprljn41rDidZ9AlPoVEWwWHsXa777CglO6SVEMBPDp6ouBEHlzQb+3dY7k00hwyEn0EHH2oaK9/phheK1AjmJpbMk+QMfIM6LVUgDVzWRsJlvp8tKjBs4L/cNRjVsliuF4SGIcfcIXfoDyxGZKB0sbL3ffbTxiLJymgKb2c18utubHgOnZsP+jHoi3DplKSGA07iFbYsdMveNdCuLf9KN3veiHdZHGFN/lmJnZ/Mqh/sXZWEL+6o7HheNjdlSymrvTs0dwQnPU/OL/Kl2kjngMob3cJBY50h99hePeGDwx8U0tl5T8+IRLF0EWwXh7ottUBQPIxa2FHX8NVO2hZOUPK5Xk5/fRNrVNST5xSa1CijtaKBjixQOy3ktBJL/3WV+UTU5WwSC3QLZPp3zne+apKr0uS30RK/0MJhrJ6I4kMuhuwE43Oo2YxFI0dIIYnXh3hwAWmIPsr892BL3V5B/i8w/zxEPC7Zb8tvmqBCzRMRIKfShYM+GY3ZfFEA1vmACGt9M8PM7273J9CfCjcCYtXFm3/tkZjU50Y9Iw390KaM69GJjquBLVHPsAkdT8DoH5Kys3U22lATfsj2ONzlZ8YuEtArp/EdMjnTI+YyI3Gjg6hypzJFiSUAv08Ubtar40LUze7vu/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(5660300002)(6666004)(4744005)(26005)(81166007)(356005)(426003)(2616005)(4326008)(1076003)(316002)(336012)(47076005)(7696005)(186003)(6916009)(82740400003)(36860700001)(41300700001)(36756003)(40480700001)(40460700003)(2906002)(70206006)(86362001)(8676002)(82310400005)(70586007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 01:45:45.4060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 042efd09-ea32-47d5-983d-08dabbaacb49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
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

Remove unnecessary register program in SRIOV

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index ff738e9725ee..6aa02d835ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -395,6 +395,9 @@ static void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Setup L2 cache */
 	WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
 	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
-- 
2.33.1

