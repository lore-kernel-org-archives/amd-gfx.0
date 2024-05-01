Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF2DC19F53
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B881130D2;
	Wed,  1 May 2024 07:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJSBckRE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C2F1130CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7zZDC97uSCOnArpFdgtYTXf1XwzuOhrtaUW8wPcBI/rT5i5+beZU5zJPfMJ4WPQioyZ9BcfKQLYQtVxMhm7C6vtVNXeyPLACQYkVzF6B89Zm8JTt+Ib/Yuk4eoh1c1QxJ3vNIpamBqUtMzBGbGjAJl3+tzjdVVE5cXjBOm2GO6f60DtxkzoTEGgQ7yubru/vXDDelJPNYGNlBfiZiAwEhkrk1euhbijcjRcTvhNWoqJKhVzdeyPmVyedKx3720WkqEZoVsF3JFSLhcbpBMyy9i5TrLlfktiXU2v0MBPCVcq4xVsYHtr8jootXQ/K+ofgDMRd5PIUjpOQqLp0SNe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3svogFgL5P+pPdRMGcsnByLWDd8tIznh2pwHo7eSq+4=;
 b=HMbqrawiDUNrUikROpwOjCbajrhzz+QiBntnF+5SuuP7RFr/1vmuW9LI3C6Pyu7lDqEqb0q7vVQJv2nM6/vPjEi4NX8nw/b7Y1ZoOKKwFSiECIgBBt1z58qnOuy+zcQ8a4Fb654d7QgTHVGJdI6Bea8l6g6Sx3IfjfEXuL3hvM3gX6lDagh+C5oNFDIcj2VYkHXu6Pl/ZE2nn9d2cu1TLTWfzihJeojna/Vb9UvEXj+UEM9kAajxhkMVK1yT5iYuKr2KloKLNBCwwPl/6QAxWZAAU+arbs8+BfOX+fZbdnHVB2fKTMEVwvWh2OPl4we1UeCkvpoLuk7L4nZK5IfRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3svogFgL5P+pPdRMGcsnByLWDd8tIznh2pwHo7eSq+4=;
 b=KJSBckRESll2CeOlZSYtwnCbQaE+/3hf5WnvLG4B8GEP5k9tU8u9u1r0XZ6lE4B4AOdcux7hGbGjXc6dAzb7ZQmCG1Y+TTfKlcAEXfRm1gopzHnI4403PLGyzXG3ADxiB8CgQ0W2rfR7n98JOLUGDM6SJ7k4ZydOqjp8YVutlvA=
Received: from SA9PR13CA0072.namprd13.prod.outlook.com (2603:10b6:806:23::17)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.24; Wed, 1 May 2024 07:20:30 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:23:cafe::af) by SA9PR13CA0072.outlook.office365.com
 (2603:10b6:806:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.23 via Frontend
 Transport; Wed, 1 May 2024 07:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:20:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:20:28 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:20:25 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 35/45] drm/amd/display: Add NULL pointer check for kzalloc
Date: Wed, 1 May 2024 15:16:41 +0800
Message-ID: <20240501071651.3541919-36-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fad11e1-6442-4368-70c1-08dc69af2e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k/umPl1ne2xBOvwEaj6YEZZJXnwCCZEgQbT2RCpYvPya7MjhwXXa5Qq2Jlax?=
 =?us-ascii?Q?5yBnU93mO23QRa3AhiAHpDY7d19Hmo+2pix97RhP1/Flu7kjGVBmXCYu1AyV?=
 =?us-ascii?Q?ZmzV31eZqZhLnhdI+o2+UE//3RjJ7aWrhNMi+TEB1awrSpEJYEIls13JPH/o?=
 =?us-ascii?Q?7DNKu1uuMLcjEAD9Dl3ny2x5UqmlQuw6M7aOQYbxsrVw/jyseyYxmwl0krS0?=
 =?us-ascii?Q?znZkzE767v2hzXiaFFiqhBeQeyIOox3ev/PspC7QUbnGgaZotRXhtjByIhhv?=
 =?us-ascii?Q?ljm5/jAgGv5YFZ2J2M71ObkfO8UcMNn1z4qW5d5ioCAKOEhaswBF7nPseYI8?=
 =?us-ascii?Q?ou87qUROxafPveIJ0G95VazK48J2IVjYDGmCCsxSFnl2Tuj4dBMwN5MdDLA9?=
 =?us-ascii?Q?VP5i+0mfun+wbogwLWQhVXoITkPNmBaGx3U9/VCEn6W5SP3RwtDxWFf92x8f?=
 =?us-ascii?Q?iv3saWTACUeTH1N6BRY8daCsrbM6rSy6kXZrle3nwluq1jPonq4Sck+FWtUP?=
 =?us-ascii?Q?gEHhHdK1EU7EB7XJ8s4Q14TTKLQXR+NgVMHNusljn/Baqv2/FBhfF1A75DeV?=
 =?us-ascii?Q?N3FWbCzKGfoDNxsfT65qS4d31LPldGV98mfxmiRLocy7QLt8r6wwNFSSgg6j?=
 =?us-ascii?Q?M1/DvUL55eirqLAxUOI0a67HrBh/GfBIPib+BsMyQAR98Ewg6LXi4/8gXfoY?=
 =?us-ascii?Q?ug88MnrEdtlyZveJN9u1ISfTrNaH7Dle51Kjnli6QZHRfB6EX39H1x84c2CJ?=
 =?us-ascii?Q?5dWydvCYSehtZw0JxrzjUFBNgnBj4xsXLbakhRkS28R+J71Jn39qk5XUx+6V?=
 =?us-ascii?Q?ccf+xg83k+tmMdStWxmFLv2sEgXhdcT7i0zkYmc0o0K0ILZg2xVHOBK6PE3S?=
 =?us-ascii?Q?7Vr0v5inCB3dkhB7x5RxZrbkuXbOs5TwWOME5FFhBaNSfwOPslnleoho8n5H?=
 =?us-ascii?Q?tb1no84Sx1uAHE4z1324qpt+wccwnAVY+MirYTWGW/uZIX4BLaMvPfWR8O5M?=
 =?us-ascii?Q?cRidb8eW17ZtmNg9uWgO6j/Ylcttnbu6Dq7BnXIQrs5cu2QUnPZLmY1FkP6V?=
 =?us-ascii?Q?KxxhxU3qSWXkdou/4zPjGnoEtaE59WIZSgmLuClOspiqfeIeFOcyJFQxcA82?=
 =?us-ascii?Q?LFPJReJBEMwoyDd1/DQfUh0+0eZUKe+Z/8FrXUqY92hk5TVva1jHM4u7DaET?=
 =?us-ascii?Q?b1oXwUHrT9+ywZWvl5+wD3f8Yj38+Nj6NME4Tmiyy4Slqjjp3PXiBpOYFR0X?=
 =?us-ascii?Q?N3Yknik7/CSP6zJRGvS0zb4eGZTdViYNNHO080mFriZC6gUXH7SD0iU36Mco?=
 =?us-ascii?Q?Gqk7cjPVHFWQcuAsWNwmae5Gl32ZDC0IYk5q0bEVbEsPh3Y0K99m760gNL9O?=
 =?us-ascii?Q?cGJF80Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:20:30.0291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fad11e1-6442-4368-70c1-08dc69af2e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why & How]
Check return pointer of kzalloc before using it.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index c244262800e1..75e2c62ae792 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1273,6 +1273,8 @@ static struct hpo_dp_link_encoder *dcn401_hpo_dp_link_encoder_create(
 
 	/* allocate HPO link encoder */
 	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
 
 #undef REG_STRUCT
 #define REG_STRUCT hpo_dp_link_enc_regs
-- 
2.34.1

