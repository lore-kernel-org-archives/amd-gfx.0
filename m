Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C73C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 03:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0276B10E22F;
	Thu,  3 Nov 2022 03:12:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCBD10E22F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 03:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JICtHYYzcmESD1LOGjVNgeHwkivFNf/MttbHNwQFq7x+2BOHZc33UPhOroZlZtOJf6pbcGPP4j/Civc0o1WPgwkIziYZ+LRIm/ogWPRcfzdIct28elXWkNeDgCaJe4CQvRz/6TXTl/oQUlmQQvph6lJkOPU+LqAFuIY5mjW7QM+nOKyKHfOKQ3fNAnQi5bi2BKcNQHsSJ686CulAJTd9+hspZcjdaMmZcgOiXW1gIv94AXa29WWQ4zbuDHQU/jGEdjELNRJZWheHe8qEK+9TdimFtlNvvuCfvG1WMqdJs3hWTmxzjuFwUzMlc48MJ76ildfLEPdcju62UXIAns8zLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHACyId9H1s39HTSS1guAHRI2jutAELZrowMyxhUo3g=;
 b=gyrvo2/pxZXklXZ5CPyQuqgdpgi06ZFwv1Us1D7Y+KUfCFKxmbgG1qpNNsV4Cmd/CC9TLpfvz0h9Lt2Jq2OanOI9p4WwhJRvS055J8kBpHcZ6gLe8RkOAege0d6kYLDTVbeOIICApoCZL4d46sjNMrRNGIAdBOK+6ynNoUr2nzC9BYSdBLCzDNz5RaVCZv1a/xtkEZPle//RDMpCFGRMpuUpQk9jFce0IqFfy2UIGOexDyLuwiJIOZ8J1OzqkNjrlbpCDrDlo736I0ZjTmIEUMU62Gz2ilqiArm3Ri8G87UeTYkaHDPcBEkwufjOoCjAfjqMdLqXMfs/VA0RSbUC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHACyId9H1s39HTSS1guAHRI2jutAELZrowMyxhUo3g=;
 b=I32PiCpOnshItIHv9pek+le3jG3YHf6FAPUj0V9W7p8c8vlexe9vFSyxlk+jEPI0t9GW8oUJnIUs03owckq+Dz/hPtKfonuQUkGeD3COBPmq7s+c8JV6eKDgOgR+pTyHe4yfrjmSdHNd+loU/UfY4y/1SuZpJEHVKUybwJvm0uo=
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 03:12:37 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::e9) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Thu, 3 Nov 2022 03:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 03:12:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 22:12:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 22:12:04 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Wed, 2 Nov 2022 22:12:01 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable GFX RAS feature for SRIOV case
Date: Thu, 3 Nov 2022 11:11:57 +0800
Message-ID: <20221103031157.3901004-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: def27c69-09e2-4047-ef65-08dabd494286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4AWPSSLVQHwzVyqP2sCueMVObThWOgZoSslEovrnM6eW9JecyP0/YPQAIaohE8dgWQGwQ2DbN4qF1DkuIJ6B+GUFH2tAbUMCt5o8GhTZdUhKAcnJqPqt82DC4RNduAmekqsSbnyqH0qL0htFfJ1xmaOcNy+317x3gkI1LzOI0UUQ+Y0y7QRcg0xrS4Xey9ejpgPzvlEMMsN+j0+NO+jaWoA/VTGspdvfRcN3eQxpX23K0vfiD7lXrJalVXcBQmfHmY89dH4Ht8QyIeFrHAe2/vPLe4+11KrrR6QVqcvx6ax4GRin5bRAvbWbBd6InKwiZw4nuvLbw9baPDtFUZT/mzcKEvLHXv+giPKfX9pcmBeUlrUVy41+FhNx69KwUJm3zAYTN8L7J7B7goetF18mN2dTqHDT1NkEDH5Py/F8aA6FpgWR138tfxqg6kUlFSWUagQXHThJORRKNBLfdq6kSFaZaeE772ArCcPB9x++CUwyGmo4ONnWvAO2dQTV77s9UFyVG6NA1yGahHv/MgNRla+ysoJSl3NffSsVV+LQgPEFN/HoKEJNYbikyz/PmmdYqyshxHCZNuKD6TQsvVQQP5tvHT3matIibc7TtBDG0r67pmNu0rxo13TmafEePVQyEO94kto6MILghFVyWm+j7zY4xRRc2n1VLYUwA/33cIt204jVAL/94i+hzb98G1hCLbRv8SpxKJCCUsyaPoSPzswsIlCEJX6RfMuHI3qyLmFUAd4/jUzMsm6QBJRT29047FT7ZnSsBxJIlf02VulkxVpo4WfCpokGvU1meSySBvozzEIi07ipmS1saiH2Yfj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(336012)(86362001)(83380400001)(82310400005)(40480700001)(4326008)(36756003)(7696005)(8676002)(26005)(6666004)(40460700003)(356005)(81166007)(41300700001)(54906003)(316002)(36860700001)(6916009)(82740400003)(5660300002)(8936002)(2616005)(426003)(1076003)(47076005)(186003)(70206006)(70586007)(4744005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 03:12:37.1185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def27c69-09e2-4047-ef65-08dabd494286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In sriov guest side doesn't need init ras feature, so skip it.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 84a76c36d9a7..be8ed617e269 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4707,7 +4707,7 @@ static int gfx_v11_0_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3)) {
+	if (!amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3)) {
 		r = gfx_v11_0_ras_late_init(handle);
 		if (r)
 			return r;
-- 
2.25.1

