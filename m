Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C2CC54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101D710E80B;
	Wed,  7 Sep 2022 18:12:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E267B10E80D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM8gdQXEXn7VpWgV1RIxZ0p4oVxQ59MkD1mG6pRrwpBci53gl8aG7cdBB4TKf9FFwbhJPweXZxiNFQcmeanLbyAHZxdOgh9cnS5owokHm4Rj7b2Y94YfT3hAf6KRS/rz9OtEA/q893jZY9gfNGi7Hfho9oojour6WyoDObzg4UHdDCmdpD75hzLAy/IvsmVxE3PLlbdbboyqyT58I3QoSkl59OCtB+nF/ql32lDIm6s4guKJhURVnxqmDLDYXv9GVCu129JL9TTv4vT+qmOSNakWI1MxjNEwZZW7tV5S6fzxoE/01ADlUBqKeIqfAtHRwiCg+EIbbZ/j6F1qJFdNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTj8Rphgrkz/O+Df/chl0Vu2zk8LTRbyWPmsJULV3gY=;
 b=dg8SIlLebXkh5w0vRrZcE1hKbhi5nz9unYpeLuoCmS0qyhUh+6jKXwVQiDLsIe9dPG+TCTUBbVdq23EfJ8BDyps1zSh1gyyAIxm25NjeenoKZ3vhwWJlotsb4atYuEH0t+S1hW97dXP6Miweq1tFbUUCQsYRspOIYJAHyzHVS3HVUJClPC8DxntlRari2kbBLcaMWPK/GlYgchkLGDalVOdIklkdYg9rc3Kga1Yhw9pgVE0CHhBKxuYl6IOabkKSjzpMSlQinD48a6PJsmQ5NdXacdwMAsUSoBo8AeheKQOqxW/5k3paDnc0/YWqw2BRSsq876g7+DFHgPx2AfhycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTj8Rphgrkz/O+Df/chl0Vu2zk8LTRbyWPmsJULV3gY=;
 b=v4JODcI3Age/NVV04TvSDVzHKNSSDEnBi1gZm8iVcm9I2JYLvH9GbzS2ezNkwlvZnARhLh+HR+0vjE4nAt36VjUSBkiMjTZRx6TscCJBzQjrR3ysNdqyEfWOw55JmuMy68dplwNBpD2pw3L9ldpQeSxJnCN9Lk6g7prqnnNEnZo=
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 18:12:34 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::31) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:34 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:30 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/21] drm/amd/display: add workaround for subvp cursor
 corruption for DCN32/321
Date: Wed, 7 Sep 2022 14:11:53 -0400
Message-ID: <20220907181200.54726-14-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: ee672149-955d-4e9f-ce1f-08da90fc89ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQfj9d4z+hQZNCL6vc/UGjiK3dehGcat6gqsuFcx+EZXdUhm4wbtGWiIYc0VSO9hWchozrBlYd5rVMtA3f60rHfNDrxsYZPzYKfBIebpI3/OXxL8IUgb55UvqxCXvQn+qIvhd5W+qq4daJyVQM4SYL7kTVPog1uyb4xcD1Mw6e7ix+UysuxsJoQxloyXS+LjOfLCUsv1UqYE+E5XE23siPahi3LtSU5FHNHSRMknBZhbL0vg482ZHdsRRy2ikiyFBTfjJJsCv4bhXxPQkFItS+5d+63BxZzFHZOSks2fGilPMeyjoaeNSaXDQn8ehiXNbojigwcXZKu5VsD82uO7yFcD4dPpXDJhzYyrVhU/yruAD0m5f+5UX0Jo3VBEw6Q3sEM8fVQUlbU03PqFKZ0MAAUYpb2J43nQQXg6BKtuVmrgcGvtm2PZcMktD70rFz6PI86qRNekJSVJtXc9pQXxNP5DOelc0S8lo0wCETFyhLAp+Uu8znCtbB8HiQ2/jJloA+Z7ZRvQmQdFUgPnqEFvF6e68R3ozm//PYdtMQGpwtg5X6V4kz0QsFVSVa8HTJlVfcypPE991p3kmVVyvkbFPqCCTj8RXMJ70rVuAHnCp/of+0M87vKfKIqJVhp0woC8TKpbXSF6F0v70hIVyNWJzho0+W0NpB87plxSIEDfTDEnUB9IJvswmbwUe3Lf8Bnzu+lfT5FuTKCqoP43wLlF6C/rUfpmP+eVlDdLDfXHrGUMCw/fFGaWfVcK5MGdykClkLeQsDbKcvkLz2mDN6fQCSeuNQbUu/E0a4c8nUcPD63I88WUWXt8QNmkd+UIe+MO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(40470700004)(36860700001)(356005)(40460700003)(81166007)(82740400003)(316002)(6916009)(54906003)(5660300002)(44832011)(8936002)(70206006)(70586007)(8676002)(4326008)(2906002)(1076003)(186003)(336012)(16526019)(2616005)(47076005)(426003)(40480700001)(41300700001)(83380400001)(6666004)(478600001)(82310400005)(7696005)(86362001)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:34.1305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee672149-955d-4e9f-ce1f-08da90fc89ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Kernel does not have a means to tell the userspace to use software
cursor. Due to lack of this functionality, reducing the max cursor size
is the only way to ensure that power savings of Subview port feature is
utilized for asics that support it. The workaround could be removed after
cursor caching is fixed while a subviewport config is active.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 5953083b76a7..0b94a783d285 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2116,7 +2116,8 @@ static bool dcn32_resource_construct(
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a applied by default*/
-	dc->caps.max_cursor_size = 256;
+	/* TODO: Bring max_cursor_size back to 256 after subvp cursor corruption is fixed*/
+	dc->caps.max_cursor_size = 64;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.mall_size_per_mem_channel = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 64c225ee3a46..b602fdbbaf10 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1721,7 +1721,8 @@ static bool dcn321_resource_construct(
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a applied by default*/
-	dc->caps.max_cursor_size = 256;
+	/* TODO: Bring max cursor size back to 256 after subvp cursor corruption is fixed*/
+	dc->caps.max_cursor_size = 64;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.mall_size_per_mem_channel = 0;
-- 
2.34.1

