Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6382CCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 05:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0980D10E13E;
	Wed, 22 Oct 2025 05:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hqyKOdxD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B1C10E13E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 05:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4ti2FsclYZaBNdOo6snPr456pYEB+Gf9c3dR0mJABlyGoBxwYbtDY42T7vAWDfpwjxq/oIxJhTsWxVnlh1Ck0iS9WbgOSY+JZEURdYUOTzhnS7GCdY2ncOLrIyFT7vmibgW/3i9AkdozCgguEXeDBojsQE4yENerY66ACYcsioTXXdWOz1L9rRCfPR4gD/zyTPvW+/J25Tt5AVnE5s2vp/MAbidtkstuLPXiXZua8xvKPMz3x5L4Z0VQIfGLI9BDoLnzaOUNYvHPiPTyQRMCkdDQ2we/IybmWfrYmo9lSV9nEjj3HJdoJ66IbUMUFcoWRnjAf38k8Yt619UIQXMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26c4AMVdRMb+VopQ+OVKSwc214hl0nNqZdnIeGy/Eoo=;
 b=gKmsmSa1Mk9Jnp8bYOMjFcwtBrmyNbLs/qSOSDTC3Lvnd3yi3TapB/tZ2vnmcArnrTt4YJGxujl4FL5epTuyKKV8h3TVCH5989Yjp4ZZSCVzZBxj2ykXihLXAAdnL+sTK3x9KpShgtv3AgvXVNRF5LOjYx2sJc0yrmAB2f4mLNYA/Uk4vTEqsGwtEVFk1KU5znMBJsXAyd4ZQbYhwHuj04HgeEWo5Y/uGYHRWj6jeFQpY7MXY57y3WEJq4rLpI6jkslGw2cYB/E98ApjYXLpKiaoLHB8q8DD1Tf5gY0u3/eQ6MtFPdayoeCvSmSMSW0QLujjJvyUd0qjY0SAbRDsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26c4AMVdRMb+VopQ+OVKSwc214hl0nNqZdnIeGy/Eoo=;
 b=hqyKOdxDjZi5RUc6sRWZ/LPJs28N1m/xf1iod8JtkMpwAvXJHmpsKW9Dr3LP2oztqA67OPfBXBh6t8292uivVdlxZFeqR6jHRxf5+Pqmn4cPCXiNKlMEmoYK9WlBzHQAOnNX/8bbWIjlme+MiBM7MJn9DM0JZV7z+hwgHcEUjJ8=
Received: from BN9PR03CA0325.namprd03.prod.outlook.com (2603:10b6:408:112::30)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 05:08:44 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::8) by BN9PR03CA0325.outlook.office365.com
 (2603:10b6:408:112::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 05:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 05:08:44 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Oct 2025 22:08:43 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd: Reset the GPU if pmops failed
Date: Wed, 22 Oct 2025 00:08:23 -0500
Message-ID: <20251022050827.552763-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022050827.552763-1-mario.limonciello@amd.com>
References: <20251022050827.552763-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ff1f0a-5bc1-4b50-9b61-08de11291303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFowN3Y2cjZWU2ZPSU1xVWhlV3RUUkY5TjdYaTRTdmVaUU1vOWV6UStNTDkv?=
 =?utf-8?B?dlJPUFhBUzBzWGRjdnduUnVjaEVyM2xDRU9jaXZjd2xpZ0Zzb25ad2ZIZDM5?=
 =?utf-8?B?aWMrSEpVUGRqZ0RCOERNNlk5KzVsMVZsMmk1SGtrOEk5dHljSTRoYzBKeXlP?=
 =?utf-8?B?QTJqWXIvZkRkbXhzYW13SkxNMlo2MjErODRlQ0RlZ2diWlpVQXY4WUtMQVFY?=
 =?utf-8?B?SVR4YWZzTzZQTVdYa0h4eXdQaGVrZDY2QnhyR0ZQRHRST1BqZVFuZU5aZVFE?=
 =?utf-8?B?cjRQb2NZRVJhelBYT3hSbjh1WXl1eUtHYXd0S1ZxdnlRQ2hRQWlHVFRGZnpl?=
 =?utf-8?B?TmJ0SGMrcWdWc0JnYlp0UjBjV1Q0WDVaaE1CVUpQSjJEdUc1bDE2QUJyTDRI?=
 =?utf-8?B?YmxVQXdrb05aYVJkT202Q0M2c1VGQmUwYVdCOFU2cjNEaCtBb05ycmZtTjVN?=
 =?utf-8?B?Z05xa2FhMlE1cll1VjJpZDJVMVdJNmpMNkI3Tyt6aHpDYjZYVG1CYlR6SEJa?=
 =?utf-8?B?dUFSa3ZKMjd5TDZjeHBmVHB6b0JKT2EwOEVNaXhFdkVua0VzN0xzeVNkV3VG?=
 =?utf-8?B?M0x0a25pSTdlTmgrbk44U1oybW9QMWNLd2pQZ1RRMXhrNEY5MXA3dWZiYlNV?=
 =?utf-8?B?cGNlK1BDU1NFZ1VmYlFCK0dzaTh3NGhJaTBKU3VzYUM4STZQMXJ1a204RVdD?=
 =?utf-8?B?SXdDVU9LaWlYdlRUaERnWXc0YUI1amJnc2I4YnZhS3VZdzU1T1RoQXZEOE9I?=
 =?utf-8?B?UFF4UEpPMUJRSGlxMjVzd2xnU1RiYmQzWEZQcTVBVkNlN1RwMnpVVmt5aWQ2?=
 =?utf-8?B?dkhNR25kbkRjUmo2Q0ZDdjVUa2EwS3NUMGd1cWZ1VCtZV2ZSVjloa0NTS1R2?=
 =?utf-8?B?bHc5NmtrTWtFUXhjakZMUVJRRVJnK25tWUJyem9SWGNVak9xU3BPM2VqeXZK?=
 =?utf-8?B?Szh3T2FnWWdYQ28wNXU5TFNxOXlZMWloQittVTZKaXRqaFJhZXdtWi9JZ0s1?=
 =?utf-8?B?MlR0RGlEU2VkUFUyaXFwdElpb1dlZG56MGlZdTJOZXhBb2IrRnhZNzh6SEl5?=
 =?utf-8?B?TktiQ3Erc0dQdklvS3RQMjZFNncrc29TU1o5OWxTWVpQMFZ2SzIwSUhYWkQv?=
 =?utf-8?B?RktiNkNpL0dJSjBuM29TcnZFb2IrODVlMGpZaTh2YVg5QldhaWFucS90YkVv?=
 =?utf-8?B?U2FwK0tuZndqTStiZkJkVHc4RXhPcEQ0eUhqdm9pVzlqOWNXTDVVK296NVRQ?=
 =?utf-8?B?WHk0ZGZ3MzZGUldPV0ZJTXp3YmRUVEFDNU9yOEg3bE8zYktRNUkwYU11RXVW?=
 =?utf-8?B?cGpHS1E4TzkxUGlZSjZrZHgzZjk2U0xsQ21uUlNXYWJlT3BVV2FlNWtxZ1dv?=
 =?utf-8?B?MHJWNTJTMVd6L3RPZ3dWLzh3OFQ1ZEV0UVlUNElLazI4NDZiZGpSVllickxI?=
 =?utf-8?B?MmNyeXBEamZyMFZuWlBmOTU5QUU1dkRLWXdpSDBBbXp5VTB1VTFNOU9sRC96?=
 =?utf-8?B?NkkwOGt4NzdRY1BNb1NlL2RwQ2JnanZMeHU4UEZoVWw0MndzZko3NnAwb09Q?=
 =?utf-8?B?OFgyS2dHN1hQSERINlFPdm8xN2ZaTUhlVlNYNytzdU9xaU03R1JNYUUrTTMy?=
 =?utf-8?B?QmgvaEF4SDNMV0lnYkZvVlQzMDhoM0JWWndUMitndEZTSFVWamM4N0UzU2ZK?=
 =?utf-8?B?SXROVzExbnZhKzNrVWo2Tlc0OTcrSUJvSWdpNkl4NjVmVE1qTnhxcmJGbXZD?=
 =?utf-8?B?ZW8wNE9WbVpJdDBxVmpWZDNia2RSb0JvS1VIK21mTW5nRnVKSFZ4RGRWV3lr?=
 =?utf-8?B?UnVmVUhsZTh6OU1TcWFBa1AyaHMrYlVxVFR2Ti8xL0F1MFhYQjVKekQrdklp?=
 =?utf-8?B?K2VMZVFwYmFCUEFsUi85RHpwR1BrRWR0U3dXYzBNWWVUS3ZwZ21Ra0w5em1Q?=
 =?utf-8?B?aDhlQ2gxSjFNQWVTZXpDYklzcmJwRjkyaWNXU3ExUjRISVJJUWJEWTEzOHpv?=
 =?utf-8?B?UWNaVm1pRWZmK3VlWGg3WmpGTnIzelVkMHNTbmlhWk1TRmxpZFQ0RFEvTlBQ?=
 =?utf-8?B?NlhqNXJLcEUxRE1DVzNFbkgrQ2dVcEJXYTMvQT09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 05:08:44.3086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ff1f0a-5bc1-4b50-9b61-08de11291303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
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

If the GPU fails to suspend the return code is passed up to the caller
but it's left in an inconsistent state.  This could lead to hangs
if userspace tries to access it.

The last stage of all pmpops calls (success or fail) is the complete()
callback.  If by the time the PM core reaches this state the GPU is still
in suspend something went really wrong, so reset it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Big hammer for complete() callback
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 63582874991e..b32983594bd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2590,6 +2590,17 @@ static int amdgpu_pmops_prepare(struct device *dev)
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	/* sequence failed, use a big 🔨 try to cleanup */
+	if (adev->in_suspend) {
+		adev->in_suspend = adev->in_s0ix = adev->in_s3 = false;
+		dev_crit(adev->dev, "pmpops sequence failed, resetting\n");
+		amdgpu_asic_reset(adev);
+		return;
+	}
+
 	amdgpu_device_complete(dev_get_drvdata(dev));
 }
 
-- 
2.49.0

