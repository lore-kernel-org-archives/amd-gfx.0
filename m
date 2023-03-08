Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962EFC678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 14:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1328B10E5F2;
	Wed,  8 Mar 2023 14:58:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5ECB10E0E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 14:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhLdk0riHgrH7G/H7Gg5pSxS9bnm6mwciMgpup/MiKet8joM6OEZ4rcqoiz8ME8jl4WVBszPhz+ycs6sCE/ZzhRV1/e9ZhApDqVE//lpZCOMePc5adl8D4lGyvPAJ5mwZmhTC1HCS0DEgZ3xNeJlMZDTyQjZpK1WePXcMCDRb8yi8T4Ep67HkexnZKrenYz3dR8UcVENQGdi9SdUbVoHm5zBdMExNYZb/FL1dxzLeOQOJDu/umeGBeGrW6CholX5KYV/PJjgsVf8JSrvgELrch7M8Phnb4IlDssbXN/I+40sIfc+e1RWd4kq3LcLt3kGe3KUcD7rjyhy8pLhUknvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0FHItS9vgJsLzS6aoRJG7dEElp7NXVUC/naqncGL9Q=;
 b=bQQj1h1PO8YHgj/RLZhEIiBDBROG50QgKdF6ahScghGZgnhZN7qAI0Kk+cuiVXwdZcDBhb2DEWrhkzoVtea8WGxEEXqRNtVrqM+zmThzeRNcFc4xknH/LeSRkRAQBX4rah4BzPvh3N9csN0cq09LZfWbEfaHL9ObtIzo1iUu6pw34hJgRVmMjBXCMk5pjxNt28CIo/mbtTGd/wOh//HvSNtcdfpL2og/X22ypujMCxx6rbysF1FRbPRzmXAjL1HhTCsKLpbRItSosxKmZ5LmE1iInsgP6mNk8gKfsqlW7F6OpDarSgdFvgT6fkVDiqdUgbV6J7yMPHGwMyfZxek4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0FHItS9vgJsLzS6aoRJG7dEElp7NXVUC/naqncGL9Q=;
 b=GKDmDwcyGe1xjWF58c186tZGAfk+MRUoi6aNd0dBElpDeJUPxd6zDsuhww1g89fEqqcn48/OAxleIkEpUWwNLRIdUaOdcAzFR0eTJQk8FfBfH3hkE7oNgayb1sbCg0sn7fp8sQyE/EbmOOiwVdA5ryhsgcZGE3LS8ixjpvdXEfY=
Received: from BL1PR13CA0140.namprd13.prod.outlook.com (2603:10b6:208:2bb::25)
 by CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 14:58:41 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::f0) by BL1PR13CA0140.outlook.office365.com
 (2603:10b6:208:2bb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 14:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Wed, 8 Mar 2023 14:58:41 +0000
Received: from amd-Lilac-RMB.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 08:58:39 -0600
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/soc21: Add video cap query support for VCN_4_0_4
Date: Wed, 8 Mar 2023 20:28:17 +0530
Message-ID: <20230308145817.717169-1-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|CH0PR12MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ba496e-ddaf-4f3e-ab77-08db1fe59b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOqos/VQgocmWLr6Yx9dGS11QoO+iL02okAipnCo3YM9fwRVF49g1P4Lsy2ZLO3CTzZZ5HNv3aocawy8uu+mhqhQorWZJIX8XwYT43dp/TnaLnnQBKZ4qBoC1AI4IM6QKfTt8MH4o5+JsGEK4dFZohHF0NtgC3uJ3p66x/GMHlGplYytYQzS8mmC/zGPo5g2vInz1y4iLnB0MUMDe1viHd9eD9oRik1udPbDBBU+p2nty+vIb7yl50n8oEfqoRAU8YowN7X+zP4mRrnOiFw9KTVRJvcQjwx6CbCLyzwyYrDwUTDrZjV2T9ZXmCBfBx59kCOAVQMQMDMqW3rD6YxfENIlC1vL66RcoHme0Kb29zVclBQ14TuH3wxPv4dAIMlu1fFW2YTRf+SJs3ObeT68cojudIJ91VhS0wLvQiWX/T8BzG9H2oyiOtxpf4aOhXsxLIMDk2cR5AuAWzNvIilhAlGwL8FRE8kI3o9hCZx1/BUolILgHMLaBGlzMh/+1UuSBd5o48ltAFUcr60NqNxDtezzX5IBMWEdNyZSxMHnNkXSAd74AswuucxC/GKTN4Xm4ipiZyQOpWPY3DujYZLGBw+dkxPr++v38OHovnZxhWxEkoZjvQ0+rnvgXB66DJtIADaGVYHaihOAfQGzidECX09htCcd5jTT4FY34MDqE508NmP9Wx+1tN/ITe/kxgZUcQ3a/FUDf06UNSYA7lbNOKbftf+mQcrMg28o7DplZH8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(36756003)(16526019)(6666004)(54906003)(316002)(7696005)(8936002)(5660300002)(2906002)(6916009)(70206006)(2876002)(8676002)(4744005)(70586007)(4326008)(41300700001)(356005)(36860700001)(81166007)(478600001)(86362001)(40480700001)(26005)(82740400003)(186003)(2616005)(1076003)(82310400005)(426003)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:58:41.5725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ba496e-ddaf-4f3e-ab77-08db1fe59b47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
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
Cc: Alexander.Deucher@amd.com, Veerabadhran
 Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Added the video capability query support for VCN version 4_0_4

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9df223600..061793d39 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -111,6 +111,7 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(4, 0, 0):
 	case IP_VERSION(4, 0, 2):
+	case IP_VERSION(4, 0, 4):
 		if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
 			if (encode)
 				*codecs = &vcn_4_0_0_video_codecs_encode_vcn1;
-- 
2.34.1

