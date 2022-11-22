Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0E9C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D812010E376;
	Tue, 22 Nov 2022 05:52:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D2910E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCT/+O5TqwrpFoJobXaQIaV4Wsem0O/r5Kohnu3K7p75qLG2HkvZ9Fq46LR58wmRd2TQRX52SIQDUe0R+OEE3/b3CoKdkPgluFJDuOQkdfKkSzgkRL7T+ljBMmmaPqxlDK0n8xu/C/ngsa/eXBwvSmbP8Fx72TJ8BgdM+90wIkKyErg60DthGLTo2ZyCbGtDXG2DzJj5J5a0xoyffE29riYbeB7H+jqOdDWnfPRQgyNGDDWwHErLq+HsC/00oEd3yD3jTLMpQL7oY/45fVrLzyaMB2Q4ZqaeyNQ7VEB6VB8eUjgsNrTb/DnjOYg6XaHs/Ls7inm27FG0/RSNbToKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XKu9CFA66M4VfHoe1CPXQGNJGDf6hZPhIz6v1eAKuw=;
 b=TichH8dw3PE1yEH/k0Zi4FER5TAmcav/ShzWPaBFSJDZv/Yw/4AxVjp1rr4JPdoX3L7Jd84lgjn8HuzdUs9GOUcykI058hYtGVejxeajO7TqUNZuV3PxmvzZzBEnucl64dUcPMix3sf0inP/1zlMEkDrbAY7On4LuQO/spLsODpKO5ePbRSaGMwj6qbZjgRzxIDM27gskuPadgWZ2kWLB4RkDqOjFs6VIkAYpxT4Hch1a6siKoej7g4jryE/FzF12JImzpoKFm0WGb0sCeZ9I0S69G8OCvTtkiNhy8GkB3ZswO9FGG6Ar+6oTiEJ6Eo8y1xgUpOxp62tIfEVpdy+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XKu9CFA66M4VfHoe1CPXQGNJGDf6hZPhIz6v1eAKuw=;
 b=3/MV7ALOtI8eYb7bJqt1FVErdFgwpWql60bSrkzuxIfnFHIGGhwmR3I9nvRiYPVIwqWrwpK57TbkM7X3Gu4Zo64k/pimVKy5ye3rsfZ2DocwalV3ekTkc/VIe7K/QOn0MQroA2e9KJnjpWhe1mxzgavdUGruL1Rs3jMPd+Ps3OU=
Received: from DM6PR02CA0127.namprd02.prod.outlook.com (2603:10b6:5:1b4::29)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:52:07 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::b6) by DM6PR02CA0127.outlook.office365.com
 (2603:10b6:5:1b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:52:07 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:51:50 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/19] drm/amdgpu/discovery: enable mes support for GC v11.0.4
Date: Tue, 22 Nov 2022 13:50:10 +0800
Message-ID: <20221122055025.2104075-4-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: d62e7978-cf9a-49f9-4138-08dacc4db078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ymm2taqIqggOPXxs9MpwAJk0xH3PsXVrzjntkauH5t07JKZOPC3Z0Jcrp1DqfA+cKsdUV3vmapFBfczkqrB/o2qNTD4hH9ZI3Wi81gMmymIWBakbFWVN8cbGDB+bF4H5BjkoldENUi7O6+fkdph4oDdNRaT8F+JJnMTvNnw/wVT0F3ZlE77SPxhxYp1W82+6o7Xti8/M/JcZbz4LdGYhIxDpcFQ/CQJHcu49A37I2UjS/XapxuyF1/UyXe1mz83OR1ORD1sJNN0Vhwsj9oSRfN5T2xu1LHaqquIi53C1faq9bMlYGl01tY+wZQ2BClAf/0M7DrSGPOqFww1/rR2J09/0n/PlcmRApysPffz5IeBBxzFlFOcSqwbWIyCK/naABofD4OC/QKbHFXH7WWKLW0NkDH7w2Ga+fvBrzQYF4KVmeKuVH49u1GDaD9Ln9+FsXHpBQ0zKRmY/W3EYcymThZI0qQCmcmxxPMxOWBHwWQJC69+yndZyQmLDfZuzPiiMdK2Bz+THS1soljipzwAAQvrEBtlZYh67jQi6F9iU6OIMYWD5tMswFsTWIT6Psqm6Z+f3khEJEFAuQ9hNEHWGzMgELwhepuaCPL3psJrnamrEZf2oP4asx/KLhbPH8o9JZg399w65YikIXJxlBMcv60PFslaLh/01lK05fDagmJJhoLsxsblT3z9P6OZ4b40fTdHVqX8cnvf5zM5M15bf/3RjLxi9aH+6wOEtJEvTZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(7696005)(36860700001)(4744005)(5660300002)(40480700001)(26005)(2906002)(186003)(2616005)(47076005)(1076003)(426003)(82740400003)(81166007)(40460700003)(83380400001)(336012)(356005)(16526019)(54906003)(6916009)(70586007)(82310400005)(70206006)(41300700001)(8936002)(4326008)(478600001)(8676002)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:52:07.0784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d62e7978-cf9a-49f9-4138-08dacc4db078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch is to enable mes for GC 11.0.4.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index de8c2d81e09f..45fe805b5f5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1970,6 +1970,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
-- 
2.37.3

