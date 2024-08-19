Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DFAC52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 19:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD10310E33D;
	Mon, 19 Aug 2024 19:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKTVnvwk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A22110E33D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 19:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTwmNIu+1+KN9228yTcOt8hHx8e4275//LD4XfWOmfas1nNST1LQq6Y13guXeObUeLM9B+EOnSsgvhy1bbSDUrlMqfZDDySAXrB+M84T7nwnCTMRanP9MqZXd39NNl7YwPy0BwpSYKuSj9q+O0/MkR9LaMFxbeyBOycwBT2WE5JudOMMJMtt9g3fxSKlRP6yXdw0piHvOmzZdrisF4UvAT0tUejvw4FlhA+82zUi075B61PBI3EbeTjpexGko7e1cuI5fccaQq0PNyHnRGpG4Um4vTo84p1Vy0pVEH4h6n8vcIc3ABRb7+5NLfbOJb0QUOpmqD2H5RVkz2nVsguNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/kYMghmYSCWR39SfzRGfvZolGTxh1PRUI49Q4FnE9U=;
 b=Gx2EKGP+/O0rrSJAbWg6TXkSjCevJ8zvJiP2bh2oFi9XNEn2vTybs5ungi3dakYO6nUEw6HSV0E2cvy0/nJwMDdz5l7kVrkYyMpaFgEG1HdENqttVeyWbM2W5DgeDRTPoeNGSV34jF0WF8skNYRosuljxeX9+h4FLTSXg3D6nWVjxHFFoG281j7c6Ocwu0IW3otm9mL1TM9A1itEHxwItcSl9auq2DWqFfX6IOoZVidsoI4+7YWe/eTUuFfivPrp9FGy4FKlntmvHcvuMisaBduBjhvXA9buvlT0/ho6FfHTfM/6YfY7ekC3RjyvRagI7UKjsk2OOso4F4UoGGP9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/kYMghmYSCWR39SfzRGfvZolGTxh1PRUI49Q4FnE9U=;
 b=oKTVnvwkyv9EiG7DiN5ZFBxMK34HxVVTzC3p1F6zT5pFZjochVQ0dYSaBxe8lsixORVf1gGZhcKfSVEyB6ysEi6QB6S+0PnQ0K4mvktIpsm3fejCMwCLBwDgwhp1bqW+HLkKiygYdHvTxtGslqwezd45DhDr9Cdh6CQGQgBQ/5w=
Received: from SJ0PR05CA0189.namprd05.prod.outlook.com (2603:10b6:a03:330::14)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:23:19 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::51) by SJ0PR05CA0189.outlook.office365.com
 (2603:10b6:a03:330::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Mon, 19 Aug 2024 19:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 19:23:19 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 14:23:12 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <chiahsuan.chung@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 5/5] drm/amd/display: Default to DMUB_IPS_DISABLE_DYNAMIC
Date: Mon, 19 Aug 2024 15:22:17 -0400
Message-ID: <20240819192217.18799-5-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819192217.18799-1-sunpeng.li@amd.com>
References: <20240819192217.18799-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: b94eeef2-5cb0-404b-6ff0-08dcc0846210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1X5uoe10c6Z7dE86GJW9zX6p0U9OUwCK1kKDYlV6LSVSd3IcDKsg4t8uRRAU?=
 =?us-ascii?Q?x6rKIteNonZy9u9kHdDzOEquEpGeAU+mlZ9HmfWwxSmzC35HCKjksWDwlOKV?=
 =?us-ascii?Q?I3oqjBhV7W7KwkTI+pXRBYtQTqqGonCQyeMuySty/5pgVVoI053caS7zESRC?=
 =?us-ascii?Q?Q99da5DXwFcGAn+1WoiXL2QtAN4AB00zx5FcnXE9jZDk9HzJCC39acBg6LWk?=
 =?us-ascii?Q?slptvwHNCWqH0dNdcfftadDS+Qf/g1+PeunX7IAhuYCKl7WGPhWgTFyUs8hL?=
 =?us-ascii?Q?Qucm7CzOE1Hci4Pn5AYMa9SCfGuYy2D3JNuT6X+EG7Xerhgw1RzmG2lw1NNu?=
 =?us-ascii?Q?b7sTgLntOp0ybeiHQh+/1gWTsQhTzen3kTsy2AMpV2KUVctokAogAX3V32+q?=
 =?us-ascii?Q?isAcdBJTEcGz0FE3f+8ruvEVtWQc1yWYc1mRy1cRDOY4OPfvZ6SOxHNbqeaf?=
 =?us-ascii?Q?hVwQR+hwA/EGUZ/B9UGBKDJTbSv9MX5owOyacrALgQsL7oacrGiB+Kb6o9Vs?=
 =?us-ascii?Q?sS6fkc6nWb62IpgO5Cow9kgiq1/2/e/82hySQeUAjyNmVohgIICUGjgWkKBQ?=
 =?us-ascii?Q?CkC2z5csVjRia8jTT6eLYLnWHrkkZ48dQ/QXh7HVsODKPZO8VxjHV2/EVemu?=
 =?us-ascii?Q?eq/iQyhrgk62pthpkpUsSiuDi9vNI7hLeMxYxmj702v+zGGHycdontFyBmNR?=
 =?us-ascii?Q?4XINZSEt4X/GphwoC2+iP/yfq2YbN7pIozbbsmzwAQqyNt9/TftsszGT8thE?=
 =?us-ascii?Q?wSYVLvsIXDBfWYvB1OW1HVksRNtp9VMRQVnKWxKaqKBqn0c/TB0k/9UvvTPn?=
 =?us-ascii?Q?OouMnwYPD3M9XhTxKpWXt3Qp4PpkHaJsJlDp2yFonqPQuesk48Xf6jAnmfZI?=
 =?us-ascii?Q?A2xnX/gdiLCyRa0ixas/FJA9tuhUQyrQmhxfYglrBGWprwCAsgibgc0pvBZC?=
 =?us-ascii?Q?UE4URyZjsA1t6Je0fEOJG8bBf06BNj2NoJZ7EPzb+0NwX71WHic61TeFwGka?=
 =?us-ascii?Q?WsJXM/aAUH6vkF/38y04vfpHqd8VDlIZs8LV39Z+wTdZOX8kFdHgRTrAwl+F?=
 =?us-ascii?Q?c6ORkPacMNm5H1WHCvLHG80YCvgCp74iE7SYfmb/75BLTDsmwJHyw+BXQLf/?=
 =?us-ascii?Q?xhDyRXnqJqJ6f/R9qP23uJqHV6Dv85Mv0iBQFWMgxNbP9wee50YxSWpVoDQ/?=
 =?us-ascii?Q?2wa47p/eNpoqjeIZFbvoovuqLZp3JV2EgUIbyT6uqVB9am5ZTMzhLTKQaq9Q?=
 =?us-ascii?Q?7n9ZquULxyrcnFZH6CMRtfAEssfw4ILDZ4Gx2Vh91X1YdVDBt9oRgVT0cbZp?=
 =?us-ascii?Q?EZ4a3g17Fyan8B5O+KgGdhdtcgMLYlg+2Nbo1WOUoAIX8m/cvQe5TY4RZwcS?=
 =?us-ascii?Q?G0W1cbOq/vWaQHAu1+o5j8XETNKO3LqqEMUdThP40+eLut2dBcts/CvbUYh0?=
 =?us-ascii?Q?QMbNl4SLy44qq0ZJjXTfeHduIZNZ6c9L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:23:19.1665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94eeef2-5cb0-404b-6ff0-08dcc0846210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

There are currently known backlight and abm issues when IPS is enabled
on DCN35.

While the issues are being ironed out, let's default to
IPS_DISABLE_DYNAMIC so users will not experience hangs. When the issues
are resolved, this patch should be reverted.

[How]

Set the default IPS config to DMUB_IPS_DISABLE_DYNAMIC

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f9b5966746c73..b1794ced82172 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1907,7 +1907,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
 		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
 	else
-		init_data.flags.disable_ips = DMUB_IPS_ENABLE;
+		init_data.flags.disable_ips = DMUB_IPS_DISABLE_DYNAMIC;
 
 	init_data.flags.disable_ips_in_vpb = 0;
 
-- 
2.46.0

