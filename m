Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30411C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C430310E3B8;
	Thu, 26 Jan 2023 00:34:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A3210E3B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAsEdRa8MBXe6iyTqrxy3hKp1NGcxJFVrnOjaOmRGK2Cb6ypwzK1g30DTQnDOo/zA0KIJ1PxpOMq7urnWmXMQeG5WwjpOWxf6eKcbhUN2aLzjlv5vqEbdi4gKsZk8DosMD+bnc8DinA8F+4S4hojbIPtvcws/MrkIEEcuZoYbNdktD54zHQw1ImZlrg6mD/HIX+1U9Zt6LQZk2l0Mo02MT1Fbzii4jRHfVw20rolpOXQeQXdPDCFj55E1qN4V/23FIE2vcuXBzmFVSybnDCUodF5Ksv4VJtKPtGYSW1TNrQocdCXL34QLSBuLZQAgtoKlSL2lE129QT9l7LsANen5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZBhXsdcifrTNZVG/mLdpL/8EuBwM80AbyVse9nvf9Y=;
 b=es5u87cSDh0rDAAT2P066tEDIDoJQNgQ+rY198YtIJGpW0BgZRBYrwLNv01MIrNEzYS3yTGdary3rZROwRDorka+LDr2AAAamcwaWFNujVzELIbyGIhtlkfYEGpfQHI2cAm3LMQ0XipCyOUT880fOOcb/C/OVMESLFAOH3abH7eKp1zC5liQIWkkQYfWyxHX4teZdg+2+GBg5W3H+7D6IEbKj/Ylb6RHtUSooLKAa8kZSyjBd4VO1C8pfuDfoKQUeV78bhSocQNxUYSkIp78D0wwAgtO3yrXy4se/XTForekFZ+ts5NjkBfPJUnhePOKHyd5KQ85HtH+SW428hpsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZBhXsdcifrTNZVG/mLdpL/8EuBwM80AbyVse9nvf9Y=;
 b=kipQBXUcnr9jYYhNQkvv7d75JMVKj1XpXdZP/Ynx5ddS7qR0agdqPUsdmiwoDFwhZN5YPTvp+ObSxMSq4HuiECcgZOUfEsbiPyfe6evIUgSQB5cMIhRoTD31A7LJteXfzi5J5KLWMmJJM8R/51lNoRI4PA2x2zkizBY/DlvDBww=
Received: from DS7PR03CA0123.namprd03.prod.outlook.com (2603:10b6:5:3b4::8) by
 LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:34:13 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::42) by DS7PR03CA0123.outlook.office365.com
 (2603:10b6:5:3b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Thu, 26 Jan 2023 00:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 00:34:13 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:34:10 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: fix MALL size hardcoded for DCN321
Date: Wed, 25 Jan 2023 17:32:17 -0700
Message-ID: <20230126003230.4178466-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 71282157-f625-4024-c8af-08daff350c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opMfFafJh7r2CTBUHnj6S0Fx9pXVIdquvB3cO4xwytAtFXCS2bcAtri+K3UqJjagAU1/y6WV3jTmi3h8BEJBQ++818EIGYNtse6jTzf2T58YlkAqArPeqocoo8BDnqtZCjTvUzpf6INO/HVv99SxoCe3xAGnCt7A9Wf6XdXj4ACdwLtfV/jfU0kU/L394+UPEMBAccxJ7Uu3MVJy/1uc+g2sFdm1SHaLWkVLBBNVNM3XiI5T1C6W1GOIU/y6N/ph0UJOb9WRKXbwnLb+scMaCcbQiE5Okom2L2J7r8XNZszJeG3l90QhNOKgDnRMW7c72Dqi2W9wkSLyO0IZhfNxpeiWx9m+ncuy7OLAmiWUdqBJEwl7BX9JMbMz1AgFWDpOW9B12IK/19KTEq49gS+/PLJZpMkXIkbUp2hE1Y+6J8i/ofcM0IqmxW1Ao/jl3jvzIV0v3mdTz3i+CV2NHVOmL7Yn2yBFHiKRBSXa04+9IbH5lMvYi9LmHUfvKMSEjg0RrBeGhrk/Il2OAPU8vaOFjm7CTPg6qHvcOAKxCfQqqzVffWXwddluri/zh+A3XvTdihMkME0tMi6fSOHH5pRaPJYoXOcAJTTh2SGluyEoKVsbk4mwdP9Hi9T8bBmirb/Cr83yGwOtNo1AD9lxuxSuxPCt6P78PCIIv2izFg1cTS2EdR6NAV8rZIsWtcEsQTKBRi5nNwEIbxYADBQ3GcuOBnGw1DydIsf3CumTY0VvfjM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(40480700001)(426003)(1076003)(336012)(83380400001)(82740400003)(86362001)(47076005)(82310400005)(81166007)(356005)(5660300002)(36860700001)(2616005)(70586007)(6916009)(36756003)(4326008)(54906003)(70206006)(16526019)(40460700003)(8676002)(41300700001)(2906002)(8936002)(44832011)(186003)(7696005)(26005)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:34:13.0510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71282157-f625-4024-c8af-08daff350c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
MALL size available can vary for different SKUs
MALL size was still hardcoded for DCN321

[How]
Remove hardcoding MALL size for DCN321

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index fd57e0167737..55f918b44077 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1714,7 +1714,6 @@ static bool dcn321_resource_construct(
 		dc->caps.mall_size_per_mem_channel * 1024 * 1024;
 	dc->caps.mall_size_total = dc->caps.max_cab_allocation_bytes;
 
-	dc->caps.max_cab_allocation_bytes = 33554432; // 32MB = 1024 * 1024 * 32
 	dc->caps.subvp_fw_processing_delay_us = 15;
 	dc->caps.subvp_drr_max_vblank_margin_us = 40;
 	dc->caps.subvp_prefetch_end_to_mall_start_us = 15;
-- 
2.39.1

