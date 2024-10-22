Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD314D2C556
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 13:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8E210E68C;
	Tue, 22 Oct 2024 13:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="byyGGQHp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF7A10E68C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 13:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeEs53Pqq2UuvKiVys9AtxNHUIkG8irL7CiYTnzYW3UCWH1L7mT9cTINIGwtusTF13tqtp4LLK8945psujgbBitS6Xd+cOEv5Wj1gp+j4hEn7A8s9n/qboLGtodYVLNCBhoyw3ExFuVbo/3iYpAhjlK+71htaouVTA0iGyCZLIU3upMpPguVPKIqrxHDtfs+iWsyPDdsXbSRoFCAtlz8FFJIz9/b1u2lOKY3J5iWGK6xiQVRDSrIFS+VWX+UI3aUZs3E0chkJk4vapJE7cwswf6Kqp59dLSD0RCsQSpRS1kzOnJmjb9udkkVHskJKGn6lpLUVKx6ChSo0pOf1XG7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9YMj4TX43dTJI0re5wk+W+YMZUiuLZ+bfcMaWKL5uA=;
 b=N1I7nVj+8H7eyB9peDrxE47aPyBpwSAqwSjI9titVgjTvb7B9UwOq9PgnSq8TExS7uxYLz3pVddEaGwpQA0K9vjR6b9+vzCu/CACaRsvowzUVxez63ARI35v2F3BFZh4A/aahUvgIL0JaSGYA3X4cFCrzMfk/4wpX4TQJzcFJvOmEiFmSdqZSeykTw9abnO21tFKtqkRdHoyAhHddmtaiTmkMrFXIUxg4bIhckJxCDvM2h5WZgz4QHbvVjvVcrkOqnO/K8W9ftR1a8LKcEgWQxxtAqSYjAlLlTieNIDSyMKXIAtO2M45Gs8NuTbbwPXPi+TG24DbyWGqhb1GuOlakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9YMj4TX43dTJI0re5wk+W+YMZUiuLZ+bfcMaWKL5uA=;
 b=byyGGQHp5nQpxp54ZQSVU77f80axoRQ+JNoKQWqZsckFDqXfuLz4JnVMnYzI6NJNSozNfcgJLl84nheCh2u0ZeJ+aU4zbz9a4yBh03qUoYkmflixiDCs46kEEZyeRuQdqZj28RT0FwREADgVfEQMluRCR0YhMOF1IT/l+4XKX0Q=
Received: from MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18) by
 BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 13:53:12 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::70) by MW2PR16CA0005.outlook.office365.com
 (2603:10b6:907::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 13:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 13:53:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 08:53:10 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 08:53:10 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <philip.yang@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdkfd: remove extra use of volatile
Date: Tue, 22 Oct 2024 21:53:07 +0800
Message-ID: <20241022135307.3566557-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 273fca6f-20ce-41a8-4dd6-08dcf2a0de4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rohhF9RsHyHOjZX0W/GgOPhiX449ji1cPeI26sKuNM1NdQxUVxhkWggqClJn?=
 =?us-ascii?Q?Ztl2P/y3mFHckQ2u2iZipvlR809MWMeWKHUibA+vY9UZZUj2l1NqjAFzehUU?=
 =?us-ascii?Q?z1MpZdL/HOSurN4713as1V+Xe9pEQjSP/htcVkNAcdibFwxwJSr+NQwjXwul?=
 =?us-ascii?Q?aihgbr1GewLKnqnu36+w4vat2LV9KsVcDy6ENS6UzVWhx026H0yomE099HFD?=
 =?us-ascii?Q?L+7bYgm6tBWYwikvaHKkXu+VUduNY0+k1FD/e5M2wx50mtiaSJ0j9blDg6O3?=
 =?us-ascii?Q?yx+MV1hQEp3ATk52TyeJ1YPrLIB0ycE6nXtCN9rXqODcYrKlq7RzxWDozCcf?=
 =?us-ascii?Q?TDwpcMaT1C7ABQgPsKSGRHR1XrsW+LJAvUtZBb/nrMqrLgyCfMClCBcDKkGC?=
 =?us-ascii?Q?2RMeXXj/pyW1VNEebDJCucpVuS14E5wQhBT+E1aHVtnK0OVzGy+VNCzHxHO4?=
 =?us-ascii?Q?E+iLHp0I3zCxDUa5JWpeukSCCFi7UU+e0NHTQquqbz/Cd7Ae43PKMjnXOXKc?=
 =?us-ascii?Q?NnWTEpBAza8CrgHsvMHZyROsBwUtq7a2pihiFexfzB+yI6zHk5m0epEvS8fM?=
 =?us-ascii?Q?HPa+YAFg3WMVzl3RYkj+NmpsmSaxfeSBaACAngIHx7Ax4wHiYf/vcOhLAlPw?=
 =?us-ascii?Q?C9zBoGSiOcN+MGHiwHnix4dyTnlsEdyWk5Ww2rMq3HnoRjNmEDzfXtzCRN24?=
 =?us-ascii?Q?SUf7D8/eSJNDTIFA4pHP8o0FEWtG4LqnuwpDaxDQalGOC5NQBLdxOeTpnR3c?=
 =?us-ascii?Q?2WgA05/mopxVM5zNAnjvSt2YZQEUWZ81AS1GN2q63gaKWL7rhfXht3P9QJ4c?=
 =?us-ascii?Q?iFhBiOVRF3CXSXsAFTeXezo9/ZJs9SoM429oNHaOIxf/qH389u1FkxrsRhW1?=
 =?us-ascii?Q?3VtsRvClJqdYSTKlRULixjIWyWQxnQUhVzW9m1gQsdpdT22Hn2Fg+OLNhTvO?=
 =?us-ascii?Q?zDhxkpfmGIggG6I0nSq2T1tdffH209Xqsy2H0+zAQF0YLjNtnKzHRKwCq+Ey?=
 =?us-ascii?Q?necBgfBP68pnuDirEjqT+ARooBm0O4GhYUC5bz6IpSmy6T/ox+yAc9oyuRPQ?=
 =?us-ascii?Q?v1UZ3ukI3KZpV7VyYe7qCOSBhGpa3Lv7zOLMfLbuieyKMfcZJYIDG+pjq+eF?=
 =?us-ascii?Q?Cx1q32nDlgZGB+TD0e8x6tIABeCwroe3a3OSi4rk9NGmpOUHbMWDcTZySa9u?=
 =?us-ascii?Q?79pk9YgEv4/3604/IrryrIWJMFJNfhshxswZdLrceS0k+l8O1Fs7hhWzlT3U?=
 =?us-ascii?Q?faN4jATCEobt31ktCInsIfrCNYqVniKUomNN8dSg/xAmRfoYsbF6BeRTwQuF?=
 =?us-ascii?Q?NHI+Rzj0lvEBSEaHLI04iqJtvHafPwV96oKbBaASFLItJFK9e1eem8yNIAw+?=
 =?us-ascii?Q?IFWjyFqFf7PiKOiHD00M2UT49GNMHB8yoKnrupWEewLETzsPSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:53:11.7243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 273fca6f-20ce-41a8-4dd6-08dcf2a0de4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
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

as the adding of mb() should be sufficient in function unmap_queues_cpsch,
remove the add of volatile type as recommended

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5a318376203c..38c19dc8311d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2048,7 +2048,7 @@ int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
 {
 	unsigned long end_jiffies = msecs_to_jiffies(timeout_ms) + jiffies;
 	struct device *dev = dqm->dev->adev->dev;
-	volatile uint64_t *fence_addr = dqm->fence_addr;
+	uint64_t *fence_addr = dqm->fence_addr;
 
 	while (*fence_addr != fence_value) {
 		/* Fatal err detected, this response won't come */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index bddb169bb301..09ab36f8e8c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -260,7 +260,7 @@ struct device_queue_manager {
 	uint16_t		vmid_pasid[VMID_NUM];
 	uint64_t		pipelines_addr;
 	uint64_t		fence_gpu_addr;
-	volatile uint64_t	*fence_addr;
+	uint64_t		*fence_addr;
 	struct kfd_mem_obj	*fence_mem;
 	bool			active_runlist;
 	int			sched_policy;
-- 
2.34.1

