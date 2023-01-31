Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC550C38142
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 07:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E34B110E341;
	Tue, 31 Jan 2023 07:50:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3352B10E341
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 07:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILpotkbJURqFSvXGEq/oTDHWAvf2H5aMcEFI/xtVgVcX4KeXOudUReyp4of18iYpT8GM8wBBW8LCOkAzSp5MbYDVX76aCE5y202RNdMyHC0zNVu93iswVXOeAOhASfOMfMKX/P+WTDlJF5WFP9D7cTMcpXOyv1sxQlE1DaPqhFgQ37zGF0r9Vgt/WAJHR+X0HoZjiSVqhOv/uUVsreu4CAYIJbZ35hyDKQC/7iQW51RegF6gD4FqF+HNxz+6yP19cdBtpsY1wRhdqffCTS189EGOWM8fM+p5cl3dEr3GkQrWoCDIH7/G7E84eEzR01ovQRYB9kFk6qmAPUUvwPxFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJoyKmPfbjy3MLvfO2nnmA3BGEhgI+mjq8hzTz8imo4=;
 b=KIlTduWQ5sp1oOq2jvdQn1/L6ZD5eIigLWReSsLNXABPlOtSOYVHQ8fpn2w1Jlfj0u+oNmofwFBOhy2X6kqurxckPhSaFUok6NlsLf1jQ1qdz9PHle7RLdqBbrXUdRWNKP00XDwAr2vsCdIwjjApiHeyHn4HIKLGu3/cEoea8FX+7/kVYLFnQwH3bxZVc6JjQVJDRMUiHa3TLYWrBX1y8VLxQzw9ncqZBEvAxbKhlpXyprNG4sCkBPe9zj/o8Jd7OSZITXlK+upEig8Fh//+kDuaC8ZVhfdZNY4p3j23E5hZouN+SweVacjvJ3cX9DUAUz1GHyHQxxAM41FtUT3u7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJoyKmPfbjy3MLvfO2nnmA3BGEhgI+mjq8hzTz8imo4=;
 b=s1jKJ2zugE950LxvTt1Z30psCbv2WwvuSb9bBFuhTOIg6pJJgc7lc15b1WgpF2GtbOFIBNx54R31S051UXKmunLhvDEGJDPvE5+q6tX8h8W7uGanIj5X4g+T+xxAiYo2vmvZASjrCvjedST/QwQfzxU9wy77JwLx/kuPWpUppW0=
Received: from DM6PR11CA0022.namprd11.prod.outlook.com (2603:10b6:5:190::35)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 07:50:39 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::59) by DM6PR11CA0022.outlook.office365.com
 (2603:10b6:5:190::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 07:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.28 via Frontend Transport; Tue, 31 Jan 2023 07:50:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 01:50:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 23:50:38 -0800
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 31 Jan 2023 01:50:36 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Remove writing GRBM_GFX_CNTL in RLCG interface
 under SRIOV
Date: Tue, 31 Jan 2023 15:49:10 +0800
Message-ID: <20230131074909.799022-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: cd54dcb4-651a-4638-a2e4-08db035fd82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZFi+x+LafBtWVUPLyBVT8RYHaEWVIutbYBeKGP4g74FrYZVq2wwELYno7TH9LVZgYEYAQnsWlbIygS0iv+yRVPMHg2a3BqBeHFqyFEWkLGNYEiYqxwyJhtm7q2aJrjNr93SwrtzwnLzxIEpb3au/i+1b9CHk2FC6cYop4Z5IDKEg090d0lCD0AWJvq1EMMqKyzvJW92/DrKbLxtvt2zSisks2obY5kB8/Vhmu3ozAraeN0ca9a/4aYxWLQULFrkqmXsn6moUvME4HFHln5sSoWYwjYLWQnA/wqTA7ebl7ZghjOL8Nq34o6/qUEpVwRc0SDL6lYrIztfypk3WybcpfTYnv4R1gY+K7wRaXId+0+qkbV86EHefPiuCDVSF9wnhVf7WCHQ0ernARBbbh5YGK4mblQ146hwNJCFeW7Rh+99km+rXUMgMi1y63fVUh7xcYctUrXVV38hzk8d+qpM03mIysJBfrSova2if212L+k3/xupO20aQh1NUd4PovdyxjP7zm/KYyy5Nzx0A9GPAMmugBi6pkm2JFl4BJFwGF+TuC41vqWiW6kFs3S42tA8kZm9f12JbyD0/ULmXEvFjbnxfvcFFklPDwWoK8vNHpCRdOh/cvCsk9ZMAkC2jN20m1WC6KVlYSFBRY1PRhxNryT5LhswNAwJZaXa7Y5N1g6aMdNNnO6hjHGPDawt2VSO6PLsEsyLc0mIP8VpNJSHCR9cZptIeboLVfSEtQXHmC96h8h56W9MSzwhVqwH5FdC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(54906003)(8676002)(41300700001)(4326008)(70206006)(70586007)(8936002)(316002)(5660300002)(36756003)(81166007)(6636002)(356005)(40460700003)(40480700001)(2906002)(426003)(47076005)(110136005)(86362001)(478600001)(336012)(6666004)(7696005)(82740400003)(1076003)(186003)(82310400005)(26005)(2616005)(36860700001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 07:50:38.5987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd54dcb4-651a-4638-a2e4-08db035fd82e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Accessing GRBM_GFX_CNTL in full access time has risk when VF is doing MMIO attacking.
Therefore, VF writing GRBM_GFX_CNTL are blocked by L1 Policy.
For RLCG interface, RLCG use SCRATCH_REG2 which is copied from GRBM_GFX_CNTL.

[How]
Remove writing GRBM_GFX_CNTL in amdgpu_virt_rlcg_reg_rw.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f39391e03d46..0e05fa0001f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -983,7 +983,6 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 	if (offset == reg_access_ctrl->grbm_cntl) {
 		/* if the target reg offset is grbm_cntl, write to scratch_reg2 */
 		writel(v, scratch_reg2);
-		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
 	} else if (offset == reg_access_ctrl->grbm_idx) {
 		/* if the target reg offset is grbm_idx, write to scratch_reg3 */
 		writel(v, scratch_reg3);
-- 
2.25.1

