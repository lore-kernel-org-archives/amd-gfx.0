Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A393EECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C55010E37A;
	Tue, 30 Aug 2022 18:40:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2166F889BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7OSAY1Aae2wqTk6jbfihlu58isQphmP8+141E3uHgtBC6UEOQXLNhKjsvGutCt0rG7d/d4yPJa/LQpW2KLS8yPjR+bJa3VtK/E8zygjcmyMamUvgq5/0knuyxlixjkrj0oVaEwKAzxWN9898AO2kxWYmoLxev1IssgGbXBmPjYWsipFDak3i8k6Ly7KNtf8QX4eoiRAoMB049G9QvDx6U3uiOfEeTpuBNDaj+mRziPYxSoURnQXC2SJJEpHFDm5+oWh29cTJzHoRLRWZ1kTxypNP6DWUlZnEllnRgkJO4iaHLrRPqVLNQBe0X2dHqi7KtPxt+AMFYXLzxfqA9N8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxTkhy7QZPZKLV449JiQpN7eMOKp5QKvynryYActt4I=;
 b=iGBk8UZEkbfm84RRVjjVRTfSwvRwxfkUAOS2dcXH88Npv60emSdhhE6EIiAK808COcE+O6ave9ONRq7bhRXM/j2eOeIlQ43quseC6yR1daPSxQyMoetw57FZIYbYCsGKGmTbuxVSLAn43RdP0iuZWdjkaYWSZ9qvSxjPobgowYfHl7D00msrEhGyTEAmiteY7UNSOhZK1HvygUnadPZrBhGEL1Mb1bc9ZEgAKBKDYeRc14BT4DSTcL2riB49nKAdQwxZrtsli0ObmyNntArtNzlaF0Jwj9PjrCe/GL5l0CUZ+OXVy5anVG11gIottTgiMnTvC1O2Xyid3kcuwPVezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxTkhy7QZPZKLV449JiQpN7eMOKp5QKvynryYActt4I=;
 b=W8rb/l/zmlcTYXduzwoiKLskApP6dtt+w3huXP0WmNu2BLgytQzHjMFmOYcw1VJDQJy65waX2Z1DDzZTOn5q21XJYhDYyMcsYSmk3kMDrfO3Uve1g2C3q4zIydEBKAcalEdpN2i7jea8+Xjjf5kgE50cxmbUxwpqix9yc4bs0uI=
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:40:35 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::44) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/19] drm/amdgpu: Skip the program of MMMC_VM_AGP_* in SRIOV
 on MMHUB v3_0_0
Date: Tue, 30 Aug 2022 14:40:02 -0400
Message-ID: <20220830184012.1825313-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6329f05-ce86-43dc-0b1f-08da8ab72055
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEwzjQLlzadh04FPa/C55tY+MdUhwq/BJIERHd+DNwRaIvkavfJdsgmLF/bcUyeqr3+vKMg5xQt/VVWWqV+v4cfPXEuaQsCvWaDeq7ekYKoNFQwi6OiECICZg2wxcs7gc5WwSrKAH2kLmqwxTj3e/kjGP/sHDJ86mCqRB6BC/oaFMxvmExrQ6y9fcXvOKz68RjF4lsshxMI8g8zCDJOGSks0uq+JPW5EDXHmpzK1iPMVVreTDZVpQymGZ5RR17gHtcd/0uCDhG8DGywoE3DLe2jiImv7e1Gzv6uhbKBD8y4GIi6imUAecx++lGqR8VNX/k5WQUfopk9UPOJ7nig9L99c9lYruwyQFTxE7LiMmztHDGxs0S0PWbaj6pMWZ1iSAT9wA6XmexX/8f/z0QRm1lNTxZHuwqdkhpUuBXT2+lPNoC9G6xp1RNwFCbDA7EzIimt+YEm2cpTu1PETu/RFNEq3dDkBfyq65VqXtnBcO+1aD4l5ZyIdv6ocixCT3+iik0X5FemxTQ4h8IA4rJu/rm/zaHdSAOCsCLzHLFRgPjFwChJ6AKgDylzcBt0cmXpPUo537/JltxTrIuuvspK6zy69aMCqSl8htMYhcBPQ4Z05JRp5RX+U+jqa4/yfHOr4Uy9JoPr7TYT/vmcRQMtOulZqNk27zSviDOi9dAgoDFVc1w0IzTLWSYOjQfaD2ia9xnhLrTfVF2Tj+g1KmjO2qIhQZHvgXDfP3NauYN0uGx2TNtBds91+9OBP8q0dk0yd+r/SbW1mj6VetfciF5Wz67D/Tpg1afdzb9bRXZEB7Y7Yh/Q/eE1wMgTm7CL+llW0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(6666004)(70586007)(70206006)(2906002)(7696005)(8676002)(40480700001)(8936002)(40460700003)(4326008)(41300700001)(426003)(336012)(16526019)(5660300002)(2616005)(86362001)(186003)(36860700001)(83380400001)(47076005)(478600001)(356005)(1076003)(81166007)(6916009)(26005)(82310400005)(316002)(82740400003)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:35.1189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6329f05-ce86-43dc-0b1f-08da8ab72055
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan Zha <Yifan.Zha@amd.com>,
 Horace Chen <horace.chen@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zha <Yifan.Zha@amd.com>

[Why]
VF should not program these registers, the value were defined in the host.

[How]
Skip writing them in SRIOV environment and program them on host side.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index bc11b2de37ae..a1d26c4d80b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -169,17 +169,17 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Disable AGP. */
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
-
 	if (!amdgpu_sriov_vf(adev)) {
 		/*
 		 * the new L1 policy will block SRIOV guest from writing
 		 * these regs, and they will be programed at host.
 		 * so skip programing these regs.
 		 */
+		/* Disable AGP. */
+		WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
+		WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			     adev->gmc.vram_start >> 18);
-- 
2.37.1

