Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D29FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5EAD10E057;
	Thu, 30 Mar 2023 19:27:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6399C10E057
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InnrBAfYvZQ3zKtKqBYufFkrqGH5CZstemIx3JQ33cdveGKQFNJVs7gxhInlZ1dy0EmvNbC4a3S/9HmvJlVeqNRO/Ayhu9ONNKn5FpyN4CoMDGXzmT/YXhqfI7bp+aJvIe0Z/XYTHiGis5CeibdAFlOistyiEz2/ihajPLvNN2CdChdoL9ZqI6k3iWaleq3An+xKawVZBsJp14Et/4kfbQQfl7GkrknNP1TM/GarZV5hGR7g9gznIsDU9nM4kLRSeBkjyxRyEkmKCCvgV/8/0FyxOo9Ut/8bCYvvb7vdV91rSHyi6HiYmmroadLX8qNwI0ZJZss63RQShg1nPqAV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8zUs9CXOC5YvdvpUlQGffQKnjDuWL8ExLe6II4GjNw=;
 b=Dpn6/upjdkRXXhJpY7O95EAW6ZrvB46sMIbmO++4fVSZge6RD64Uh3jyrfs126c4t5Z69Hc1eekFsGyp8zinCgaQsG4D0riRoZv2WDbw35NVXSRROTE0Yuhf12DeNGgC7Ilf2qICrrujl69yNY3U7TR8UQn67eQWPF9ki1YVSuhX9V7K9wSQf84yLn5v+XYdnPzcFTIIH0aP5VzD5doB+an4AGF0l6ZL1kBTRWKQi5OOROpl1ObCgLQkuh2E0DIrF8daRU9aY47wUDdsF5iXvoQ9RmD2Oh/NTzqyN7vRlk8fHczm4n9DLg0J6tdoUHEVxOHBRIPHryL66TRW+NLWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8zUs9CXOC5YvdvpUlQGffQKnjDuWL8ExLe6II4GjNw=;
 b=UzUDLTOy8NyNaoqNQERvUwm2OyLzXBWLrXxcJMs2cTXC2b1tOyH3wvYo9U3nGY5bydE7j2cDNJrJwDAfYVimN3r8gwX68IdSWLGqVI+QJI7EOJMhymZHNfkjSlJ8mMCrj7s+lo5Dz+7zeytGOo3i3XzIwtCOoLVrZd5fKiS/Skk=
Received: from BN8PR12CA0007.namprd12.prod.outlook.com (2603:10b6:408:60::20)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:27:11 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::d5) by BN8PR12CA0007.outlook.office365.com
 (2603:10b6:408:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/9] drm/amdgpu: Revert programming of CP_PSP_XCP_CTL
Date: Thu, 30 Mar 2023 15:26:50 -0400
Message-ID: <20230330192657.1134433-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330192657.1134433-1-alexander.deucher@amd.com>
References: <20230330192657.1134433-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdb608d-e10f-4b84-2fd6-08db3154c255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2E5AHlS2S7WILusnXCD1HAUgO+a2l1G5m0HkNXa6C5V8AO075A6XhYY+4rZvMTqKdTe2KV6FCeG8+sIQ+shXfjT8BizPx0XxvQr9eOZ4W6tlqJBySgZ8JE//lz94+bwNV/pIE4v6j8GTxX6bYMuC8GRkueakEnXcAs2G9OE1ng6suxTleDBpMLAYNETPPT6qzi/42j40TjGy2JzabfQjrR8Wh7bKfijkftl4tcAjyBPVH92w+cxpOqBUW8A1d52EiZgcXzGeQlQRn9a9hTBm9DK9dhuK3LBNq2FuQwVKUTgaT0ASXlhZ4zfiCnvSdYctE4i3PtDLfKVIMdAVzzzy29MX2RQNePMIDBaQv87kCEhIoc3He/YwbwLnkR9HrmyQVn8zSzW8tZ1fyGrgKjDRQAjHQlur15wAgbk1WXKOiXWRl5lAZ/OruMjTKBqDHSvT5LRTBkgXHMthwo9/UIfzjwu9toJrQs6ZTRSnUzJpS+aQz/bfyBf52S7zoTq30mBEcmKP7eBjKu4aNA8bUgnRtFK5oZtrN5Jz2MQCIXDyQ7VQxUi+CllB4AtBZQ/ryENBMFx9tKLVTaYc0zwEQtKpsl4w3puHh/sd3vv6U5Otht6QxcoyF0butXieIzaYeekeBMCt+PuUZ6lD0YKwpks1SI144+BVoVyHZqNS1PQp7spFAIlAEmOKkrx9foMzefWbJB/54jHiWeyYA2sx3DPhpVB2z8brD2Sn8bAQzj21K8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(16526019)(186003)(82310400005)(8936002)(478600001)(7696005)(4326008)(316002)(70206006)(36756003)(5660300002)(6916009)(41300700001)(40460700003)(8676002)(6666004)(26005)(54906003)(40480700001)(1076003)(70586007)(36860700001)(82740400003)(356005)(81166007)(83380400001)(426003)(47076005)(2616005)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:11.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdb608d-e10f-4b84-2fd6-08db3154c255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Alexander Turek <Alexander.Turek@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Programming of this register is taken care by PSP. Incorrect programming
causes CP not to detect its XCC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Alexander Turek <Alexander.Turek@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0c153d4e8d4e..8d1f7d995830 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1060,9 +1060,6 @@ static void gfx_v9_4_3_program_xcc_id(struct amdgpu_device *adev, int xcc_id)
 		tmp = tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, tmp);
 
-		tmp = xcc_id << REG_FIELD_SHIFT(CP_PSP_XCP_CTL, PHYSICAL_XCC_ID);
-		tmp = tmp | (xcc_id << REG_FIELD_SHIFT(CP_PSP_XCP_CTL, XCC_DIE_ID));
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_PSP_XCP_CTL, tmp);
 		break;
 	default:
 		break;
-- 
2.39.2

