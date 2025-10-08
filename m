Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8290CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889AF10E8C7;
	Wed,  8 Oct 2025 18:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YYc30Q2g";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EAB410E8A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAvxE88xLgnYz1Js3AwGja6ulaZEa6zhxUGZrpjZG25RYy4tLpKbSLQmrdHkVUjjUNKTA0/P/XNBdzX7Ke7xWY9/F0dhMj27wb6ys97y2RzdPjWJLoV8RY38sQxgI91C35OebUQau9p/dMbrR6QxQBam4VWh19PwbVpMtgPJXUpL3k9kbIWlu05mYSumccqt0HaUxbzLFrPrxr55JruyiTa1Q/sKU6rpHBYtVjQhW/UoRzzUhdi/VUrzs8B/xYQAZUGgy2RWocdWiPyC/K47j6P75wz3cYrfo3JcAvypY3AEBV3Lk74NCT0pgv09nOdVCrj2tANlq4BbSlMKpbSb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsOaKReXr3e27IWazy5y4Ghby0cu/2hORA4+fx0En/g=;
 b=KquG+QojV9jP4571VPqhG/5taK8QKJvcvreFi4JZA6Z1pfuXWPpuIztmkDeO/4VRfHEtl9LkBg2yzylsJ5oLyWdsKsV8zdBHHyiaGNzE2hxgPzUlexrDM1KnRkauYh7Fc88oIAlkSPyGS+G5tlbCl0BG6TlW20YmyAyopnnFIv9naJhphGbmeG8VmyEAvwhci3W3VLgiCj/wObzOaqsg58uZvLp26E5vX2vobUznOr1cAGMOc8lhk2NOM3nWhbYp3/B1dWUVBqKK+CqtTPEqIqEfo8IWpgPrtQ/i7MTN3UW8FxZOLF8lrS+YK17iYxZ2CSGoWbHvLiAD8qNiPjEt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsOaKReXr3e27IWazy5y4Ghby0cu/2hORA4+fx0En/g=;
 b=YYc30Q2ggKQnF74pLppTHsz1e7EZPzCLr7LBjfa/t5E63/wAJkFOQScdFUb+vGYOG6TIwpov1SdxwcKO9UcCPldoonIhKRcF6YTEX/ZgPjKV8VGNWID9f5mKnZGmqLH07V/TI7NdK3I2ExHBxFzg1GcxEmsXCFm6VYA7HLejNho=
Received: from SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:49:20 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::41) by SJ0PR03CA0032.outlook.office365.com
 (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:52 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:51 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:51 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 17/22] drm/amd/display: use GFP_NOWAIT for allocation in
 interrupt handler
Date: Wed, 8 Oct 2025 14:47:11 -0400
Message-ID: <20251008184839.78916-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 092d34ac-6576-4315-8ff6-08de069b643a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hrNkDzQYSHCQkS7eyDKnnSILr4wHt9gDd4HzZedyqiOvRAUU+nXM5S/OAGca?=
 =?us-ascii?Q?NRMIlc5IcsdHQIevV9ZISX4123PxKX279hqODfBek9uz70aNgexSh3fCIyDw?=
 =?us-ascii?Q?P4L3AYjDbfpf0M1eO3aMTWbNVxaPWgNPX4DEPAdtNqrcm7G7VboIW2d+Q81n?=
 =?us-ascii?Q?TR2jRIsc+Eduhe0nJvA925simQtv5ofTW87QmHW20/F24xkbVHH0Zi3S/wJq?=
 =?us-ascii?Q?iLmm0W4XYhc7w3HgyD+v1WzFtw59SF9dx0GKa6gaRJaFYcoKnRpRnD1Q51YJ?=
 =?us-ascii?Q?F0UW8i+cud1EmxEqRlkYuGFBvpQkHQWezLmz0mD3yoeff3wJbVdu+1scj8/p?=
 =?us-ascii?Q?GYVOkupG7iCHzhggeJ9mjtOzJ0+3xyniOouXf2qdtUudcVXKJk2hXpGZZv8k?=
 =?us-ascii?Q?jMRKIukr5TCyn4BpRAMLwR3I/zZM/66JHplH2/JKGSV37bIeBBbRUIreoWxU?=
 =?us-ascii?Q?5hXKx0nkhr+HUQWQJ03KrzgR05g8cQIj8QaEbOw06G3nzt2hJWAoiiJ5+Xxf?=
 =?us-ascii?Q?pxTFj8IJhcFJxcwlNzoWiQYEapHmb72wFuycdoFT6wwsTe5z0oNmqF6ifuTP?=
 =?us-ascii?Q?cvg4oqx8ipOBVh0Z4CJYH0m5S+9pq4WqO/7U/DYW3K7gMGR/yx83eIZJc7DH?=
 =?us-ascii?Q?MwEjXatvgwqSAFu9xnqzVMBQeIZIF62UT/eeH2zzb4WsfDfoAHfQDGLSv24P?=
 =?us-ascii?Q?/BTtCtMRTMQEMt4jY6oMoR49MhMNrQd1qAiasmfcbguKPAnvJeCNA07PNAS3?=
 =?us-ascii?Q?gu7sIPldCAAjWbp12J/qhK3tnntI6lA7ZO0DOsW4KLOXop3unoJRG1UFwp2b?=
 =?us-ascii?Q?F8d5cMFay3GXEMyRGz3nFWJfiy0RZ673nghgvrapvtY/zY9cLHJY2dau/cd0?=
 =?us-ascii?Q?zawngxWvH2/K2e34//GMARJdrYmVXyUXMbsG4d4UqOkPjwCPo2n8RbHqw/EL?=
 =?us-ascii?Q?R6B6FZh3Tnk3MIMkyD/IuLNXwdONJrzkH7uqxw6DVC1/QVUzNpA8RUjAiUnS?=
 =?us-ascii?Q?2wbFlrxINxdelhnMD0UL/mZzB8+MKrhMpWlxC9EoiLA9YJ6t6+25+ssytW3Y?=
 =?us-ascii?Q?+XcmU+5U5l1qSMeC68deqpNQyEXXhtUPUElbnEifxFCe1njJJahkAV7l+Yp8?=
 =?us-ascii?Q?0rfAUbcGZirU3U3dhwUNnYFHpdJOyB3PpYyNOo0hGug3i0MZIg7wHwwZmE7J?=
 =?us-ascii?Q?knOLAGbZVWMkrvfS8l7y3L33xJWygROVeDUSOY5rMiO5013hExk9yjSSP+HL?=
 =?us-ascii?Q?oHCY0et8qW107uDfsvE8zp5TWhASRYNfZdlyOQeJPldkSslltNPG4AJNzXlo?=
 =?us-ascii?Q?a/gXhQsfbC2cDShvj+qGmf3zabegews6/xdKlO/+FFj7PA1RfknepzDlL1lT?=
 =?us-ascii?Q?k3SQD04JPf1jzUlN/Odet64rb36Wpazy7ke7GYv4dz5zqKGBI3QtH/AVyg4r?=
 =?us-ascii?Q?FvRJJShtydT3CXu8SUBAqRJrzXJl2jaqhRTZsArnI/YWImj51rtXk4XHA8DX?=
 =?us-ascii?Q?s+xvx/uw9MDodTYfDXMinFR4cdvtJtycsYcJrERiwthnAMo51TgW7A7ZDqwC?=
 =?us-ascii?Q?VwdQxG0uCkH/aJjwSWc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:20.3104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 092d34ac-6576-4315-8ff6-08de069b643a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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

schedule_dc_vmin_vmax() is called by dm_crtc_high_irq(). Hence, we
cannot have the former sleep. Use GFP_NOWAIT for allocation in this
function.

Fixes: 288ec2b5d06d5 ("drm/amd/display: fix dmub access race condition")

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a0652e19890..2d711a219520 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -551,13 +551,13 @@ static void schedule_dc_vmin_vmax(struct amdgpu_device *adev,
 	struct dc_stream_state *stream,
 	struct dc_crtc_timing_adjust *adjust)
 {
-	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_KERNEL);
+	struct vupdate_offload_work *offload_work = kzalloc(sizeof(*offload_work), GFP_NOWAIT);
 	if (!offload_work) {
 		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate vupdate_offload_work\n");
 		return;
 	}
 
-	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_KERNEL);
+	struct dc_crtc_timing_adjust *adjust_copy = kzalloc(sizeof(*adjust_copy), GFP_NOWAIT);
 	if (!adjust_copy) {
 		drm_dbg_driver(adev_to_drm(adev), "Failed to allocate adjust_copy\n");
 		kfree(offload_work);
-- 
2.51.0

