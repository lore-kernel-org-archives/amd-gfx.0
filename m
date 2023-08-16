Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAA7C27C52
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2C610E3D4;
	Wed, 16 Aug 2023 21:48:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B895610E3D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhRhMOM1iKqF+nKSm7gGz3lz1QuDqGk17Zk7UdRTFP7hKU5MHpFNa6jN7DJZtL/poAatQTyrakb1FUovwTyPROb9+dN9gp/r6i3PQ68TgLGTb0+DMzCAJG677nctb24Lu+kSvMTG/vWNjmHl7IZa+eTAkIJku8wJz32jnwIgvjGTetvm+6KMOBVLl/69EHTyesQ7M6aNmMXuUUIGffmJiOLkH7CPI1gEILeXV3UTjSa7DkCM2zKd9Udq69em45iiIPQK3jEnBHi+4T7Kmqk6eLDATh2gpBMwgISHszfcds0qcIKNZOuQIz/0IraFiq3D7z4UdyAN0VCK12QxBk27eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7modakaN2RNx5p/zx/GdV98P39gvj/oI4OO1BCT1yyo=;
 b=F6nOk3WZ5ajveFyxZujGFXTQYTqX0zbYw/F5CmvaWtvYDYR9atHAvDni/2AOkZYieqlCxbptg5y9iN8jLpOlM+TDgGgerA894yezyOHTldRzmU2qNgCxf5VdDUW2UI3XHyJ4cMZH3/9FHPM6ZdNK8ZYnvTV4jMBsZhkPc2zR/SorTBTp/WO464A4tifsuc0APhfBtUGBbe5PuPGMN6u/OD+NqyiZC9tqJgDt/F0u//i4eyvgCHUpQFbMdD7G+66v8984RBLAi7RN3+hCdEGH5LrGzalO7B2sI70n8Jv8L0VmHHcqmurrzVIAB5jnyXaY+lEIopSrQnqG7iO7EeN0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7modakaN2RNx5p/zx/GdV98P39gvj/oI4OO1BCT1yyo=;
 b=IsqLueHTJ+G0WL/dxjAdupQ/Jih3T7XDk+S7SlvKdGePdjOSmVG7LvMVmsg5rKVa183oBArGPGBhtWvCTWn8laR4crriozwIJaQfRPWpfXWBEX7pTLS1HD/us3J77OOBHHEnv0wbEtt+8RzPztO+GMIpoqIAVVJpxxAvnBH/0pk=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 21:48:13 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::dd) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:48:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:48:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/discovery: enable soc21 support
Date: Wed, 16 Aug 2023 17:47:54 -0400
Message-ID: <20230816214754.826506-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816214754.826506-1-alexander.deucher@amd.com>
References: <20230816214754.826506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 130e648f-2246-49b5-5e18-08db9ea27d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJX1sQWLH2g+VffCGQogRGsLYV5diHd8+gzfUEEQCaRWKeDQ3EL5D4wvtaCw301pxXtcASbi2lKiW67YfNR7nlxXjzVJpM5xsUXb/LcU0EtsDPkAH4tWMF6XwNX8M+yIJs8I6WBGaO+VZLi7/ih0gyTlPdEvFA+YgCTs9ShyFBa9yk63fs2g+nC4fqA1wPl0DAQpG5kA67ZzRFGFlnqk3tsIe6VdYSxZSukOp+5Sa+dOMR5YmaDjDG/E0BA86WEF02KyQb9rfWKrqtePnYAhMDwlx9zzQ6y338icXJxPfBdPvzlxAOEPc66oNoBQatenoBtoghfnRSVLVnP4U0XRdudY6hsb8ZHPwYjNtA9SCehqMc1BVZZRNrXwUHqQyTMgJJtOQ5joO+dsG8MQx42KF1pMtQkqA4VCptUZt6ggH2rJM5iscmnu9YTuyt1sj9DezcMSww7F1mScHWNmzDkoJy9deWTeTcVY1/mv08f0dgAhRYsEh90/I3449vlSi9Cgw/9PhxpAsn27zfd7D0NA94Cc3mjCwr1S+i3zmaV0QlDhY4ITtFjTiZ/AwUGmKbeyhUysbk5gh1+5MJVMEg2q6ymBre91OGu37KJsJ722nrUo5Pr+BCwf7kN1yBB4A3yd+i1gImeniTlRgzzv4tzEOMR8QCXS1QenEL6Enqtk7547MGxIJFSRraftvitsUvIdUwH2BLRVHLVmddczvFnG+/PadaIm/IKdn+jQEC+7rMrygQsLIHU67MDnGPSY58zrRwZVVEIMtn0sMeC8P3aEbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(4744005)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:48:12.4337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 130e648f-2246-49b5-5e18-08db9ea27d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add 11.5.0 to IP discovery table.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ed92f28a9171..704f97116119 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1617,6 +1617,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	default:
-- 
2.41.0

