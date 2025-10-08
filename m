Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BA7CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 08:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1407910E19C;
	Wed,  8 Oct 2025 08:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j9Axedwa";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B1910E109
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 08:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdAgE5y6T4i73sDykluc4OsHuUFH6DGrdLexdI4LYbTOTnrOOdsSJTUn/aDOw0Lyf7CCVO9a8hkhMyTsdovPNxuOhWdxlgnvpAJsZMEKace+5n1352e3izpGaF4MIZKO8mAOKH10xnND7rnEkxAEwGMtCmRvAJY+6qSZvLSyt9fX39ox+sOJkSnQ1pWK+Fi1D0Vpy7Mt3u0ikT2k1ZgbWE7zOigh87GOUOxf7NhEeDqVoFQsoh0JjCnYqC3prKMAYVMkPiLnhI84ZZljSD0vU+RqQR2QFYvtUYPjisHLk8QMKiaPWq0/fA682o/q/n9p9m0uS/z7SOlyz2D3C02Oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOq8DcaTId7LtM6+DSUFmPCfu7UodESRfsG4AB4XOFQ=;
 b=gRjT1Rw0loLIkFwMDF6/Ay+BwFZEkYX9nYiR/8psfBkRCLo32SdJeMJNg5hgwuLfr6/sIsz9BpIwzlOcwXffxx3w21/r90BsdqZgyLlOKfSyHAiijg3qbDyPy5mrd8oO/eYUGRmulg+uBcZH5XRv3bV8HGOhyCoQ1oX9CYsrheG4N5clXZZxbfBNQ45EPxQfazR9w7+MY4mGwa4bHVTSuMKna90ETTxGcQu/p1hk/Hd2pJJZYG9nZ0KCGhHUPPAwaFLa1EIYWhLqR0cYLQ23LyM9rcqxo6L7Qk1m9oY1zfU5Oedh8KB94M27L5w/InJ4IZZ6k143IdU2Ha0/COYvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOq8DcaTId7LtM6+DSUFmPCfu7UodESRfsG4AB4XOFQ=;
 b=j9AxedwaQE1R0PEYdOzsTRCgOF/NzRLiaWEcqZ7KakuRHOH0abzdUr5HibczCieq26sV9JxRDJ/kZKjNuFSP/z93hx6aYLZYI1WALti3EzOZRvChKUNjt++qP26BOjrIJqKSPA/WJJwXifVx1w3daLB+H9cgVc1R7A7ZszFqxV8=
Received: from CH0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:610:e5::12)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 08:10:40 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::92) by CH0PR03CA0247.outlook.office365.com
 (2603:10b6:610:e5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 08:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 08:10:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 01:10:38 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Grant interface access after full init
Date: Wed, 8 Oct 2025 13:40:16 +0530
Message-ID: <20251008081016.3411285-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251008081016.3411285-1-lijo.lazar@amd.com>
References: <20251008081016.3411285-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: ea354418-28c7-47cc-7d48-08de06422b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dUShf3suh5DNXIFjn6PdxyCxN6ZHIWmtRqOOw1YHDMsL/zSENyTOZM+2XSnK?=
 =?us-ascii?Q?7vBdS7QsYIb2YXkNREiVWZDuTiZraAV2dpkta3QOg3GqNN3+djIh7N63PGmS?=
 =?us-ascii?Q?U1kAGbN4RbXXIVVPVBfIvzG/QEYSwq8pRKnHxgJTR7sC+a2LFGZrZFCB7FEc?=
 =?us-ascii?Q?ATsfW5e4LQaf4YQumU+/pxWAn+YdE9ns/NgU9FPUPvpFBVAWlpA47V5EyzlW?=
 =?us-ascii?Q?g8Kfibg9e3sljdcNtcXcWsc6MI/bDqD2CfwZfg9JTQCrgdX/zk4gfGnMhsdz?=
 =?us-ascii?Q?AGQsLNrhEuoMBlY222wNSpz5O5HwywWM4v9+NFZiD0mErIMT9dCRwCthqHZH?=
 =?us-ascii?Q?pIWrtNnqbl8nmivtw9p4qIapf8ST9ukDWgTsIDo4dMxCxAGtLUL3g+YKzf2F?=
 =?us-ascii?Q?C8mnoQWgsw38zaLYPaHIcX9Xp8Fmw0FJ5Q+H9GSeV2MqnGG2Z5MDTsBJZfEm?=
 =?us-ascii?Q?zD1m3+8m6Torx5lrVG2vlyxc6QPXabBVnd4HvHCBP8dt2/idDuEKL+rQmy9/?=
 =?us-ascii?Q?lYaBWQY6pZSGL4nWry3r7a5tAMvruamzi/ZHzExe4+lu0W2YaWRuNeo1rj2T?=
 =?us-ascii?Q?HIK6dLypdqzfSzoeFP0Ry3amWFORcHTQRWBtNcaSbBf95Uagxqj5kEVSMMSe?=
 =?us-ascii?Q?g/mlcXcpORh98ytVbwflW7zOrPbgMm7H1WQqFNyNnnN5TdVLzODxMTaDPwGs?=
 =?us-ascii?Q?B/AJxmEHHuoZGsJ5udYFyxTelH3NgjwvwaJODlEWqjucjsvXa0qvqNozhHgX?=
 =?us-ascii?Q?2biAASrGeO8Xt0CnxdIsWWXE2jL2ieNuOVtwYvvGHMlPrwqKWdtWZ6iYjiZg?=
 =?us-ascii?Q?D9gn9K3r7cMCDDW4in89XA9CoSsJHh7NoR8kM2LETAbY0xF9lldyndDJac9k?=
 =?us-ascii?Q?DUbBZoRYdSGNGTIOjIlGizsCmSaStAduvAEIZQEEgSiDNkuhezXyiPafr8by?=
 =?us-ascii?Q?RpsEug7n2lfcSvG4zIVP5UWM+R5vAXQtkiMT+wYDJ08VDoTZ62rMyA1Y3y+s?=
 =?us-ascii?Q?OYJbfxiu7ynXeIA7m/MSBUmleUCJp+EnbptRH43W3J6PX3quqNh+PuXBmsqJ?=
 =?us-ascii?Q?/VQvoD4KhrUYq4NkQtEWxLFRR7pd8Amqh6kLqSUH6tNl7NQFBuoFmqS9TxxR?=
 =?us-ascii?Q?ukqEMBSE3gSECcGDXIxqxlOsc2hc0ZjxbmtNza3KEXTRKg9v/XapxjFiNZYc?=
 =?us-ascii?Q?6CNN1rqN947eWxhbkjNEGrW7Chkani6eCMjIqbeaCoWWUpwAD7n4Le1xmKeL?=
 =?us-ascii?Q?n+8j5jbUQTNOHOEeTwtjRGPQo8kF/o1pq5ymd1VebV4KcWGCiguwFbDzxppj?=
 =?us-ascii?Q?cfEFA+zGrzCV7xhS6l61X84Y/Wy2jd0ASEDkFhng9ugyhhS5zghNu3k108WZ?=
 =?us-ascii?Q?xjpfqJplB1Va+TuL/d6GYqR9cKDJZ0vrS9p64+0/VOi7+Ned7mw3PYbAua6o?=
 =?us-ascii?Q?+5gJSrC7EUjMn/fNLpiexNDyUbVm5GDI8hNKS6FXemciXW71nJMIA4fufO1L?=
 =?us-ascii?Q?L7k5R9u10RLQ4APFPwqyPS3Bkgx4ewM3DevPAGJgcGp+bTKqMQYKSbsL+men?=
 =?us-ascii?Q?r0nPQ84DK5v1MbrtsTQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:10:40.0750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea354418-28c7-47cc-7d48-08de06422b8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
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

Allow access to user interfaces like sysfs/hwmon only after full
initialization of the device. When device is part of XGMI hive and a
reset is required during initialization, the inteface files will be
created as part of minimal device initialization. Full initialization of
the device will be done only after all devices in XGMI hive are probed
and a reset is done together on all.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b5fbb0fd1dc0..c49884b318b3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -108,8 +108,9 @@ const char * const amdgpu_pp_profile_name[] = {
 static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev, bool runpm)
 {
 	bool runpm_check = runpm ? adev->in_runpm : false;
+	bool full_init = (adev->init_lvl->level == AMDGPU_INIT_LEVEL_DEFAULT);
 
-	if (amdgpu_in_reset(adev))
+	if (amdgpu_in_reset(adev) || !full_init)
 		return -EBUSY;
 
 	if (adev->in_suspend && !runpm_check)
-- 
2.49.0

