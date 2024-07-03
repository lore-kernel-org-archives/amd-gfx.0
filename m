Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CF7C30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 05:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BCC10E72A;
	Wed,  3 Jul 2024 05:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fYWaGuAp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0C510E71D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 05:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJwTbqyY8lPW3FczxhpxdbFv4hyxxW5QUyWeBmDV9W0XMGKW+omkwah2UR0iqjwaQhEOqg2hrMjggBPxW1136ItPJoNhbPZ/5iU6W+AVQJ/78VoYy/vn+Xmd/nHvK6UK4NxJNfG06O/rx+EVQOYjtCXaYdSzRbeVmP3ScgMebA96u+AMntr26iQasRoeJ2u1JkU3o1xedPZei5xGOFR4rSdzweEVww96kjWXwJyqQG20lbbpVy/DhsktcUpLC93UVvwitDAoRAjVdVFwSRc0uVdWM8GH/NScLHJ7U+Ki4vKG6m2JBwOtO5jmcKwKfy2I7d92qj28oNl618y6vQoiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLeM6i7GTFboDsD690saSzX9WvgYi1RYyEWIkSXpSRs=;
 b=J43fQsXR7pByD+3trMqIqhCWBkE7uj+ztT0h7IBWiADyjD0vPQhlZwCV4Vih84chgc8ZfScn6IV2XtYfYAk1HibuaqLg4OTmXv3h1y5a/SXQRaBhGbpeuXGxA1Mi+AtOLqS6flCamLk4ZcmBbZ+6WjCNFxI920rg+xPaUKZ6jI0BjJ0//gIrDa2aO2RrT6DOtfnp2IpeGdu3S8jwsMQOUm0VsAqYbsYgZ/d4Od6LsJRqPEWZjciSpDe6KPVn68TrhxVTTVFBKTxHSrqbfgQtmFGFxEYggHIVjqbgmefCdUeOyhX7IrFUhfAwB0g0iK291C+SqCwTm0tPI6OGAa24pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLeM6i7GTFboDsD690saSzX9WvgYi1RYyEWIkSXpSRs=;
 b=fYWaGuApJ7L98zefsimY6PE2KLsuJX2xZe1cLe77P4x6ee1FuKI2wPlb66CtSsDZAgd34nYSsuX+NT5vyfaEl4v999Cs5XYxXw+EZfn4+MuqLGjle8D1Zy7fUAw/6RKBitOid5o0nUmjkMkFHmsStlZ+6IdfT5LcTM82PsNM2Pg=
Received: from PH7P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::17)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 05:52:14 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::7e) by PH7P220CA0028.outlook.office365.com
 (2603:10b6:510:326::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 05:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 05:52:14 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 00:52:12 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add ras POSION_CREATION event id support
Date: Wed, 3 Jul 2024 13:51:58 +0800
Message-ID: <20240703055200.1610956-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703055200.1610956-1-kevinyang.wang@amd.com>
References: <20240703055200.1610956-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 74dd98e5-4915-4733-0ad3-08dc9b2449f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JmuDo2lAW7M9RuhJhc6vhNvv4BeX2Areadq70ky1iay4qJ3D0zwH5qpidRlr?=
 =?us-ascii?Q?wfvYyE/mzoSvqOzjjnZh355jW1PK+nmTBbu6/2OzrCSLEArdaQkBmfzDfEYt?=
 =?us-ascii?Q?wtUngRfL2VmNsPyuGH9qCcdUGlEQ54tSPYm80mciDsBNKPJVbRe6oDin+X09?=
 =?us-ascii?Q?hcb3D1IKrFMNkwYNyeXTA23X+zE5H42qm2KBdg9TFZzhoClLYwuZ3MxQuk7d?=
 =?us-ascii?Q?JfOHFQ8A7aoiEQH4DXFRHvAXsxTKIxw9KyUIaOebFLcyssa57snarr2utjJM?=
 =?us-ascii?Q?URAMkAQ5cLy6QUfpUO7QVexf0efWnpIJj8as6NE6w3k87TfdSUSEQVPCYULA?=
 =?us-ascii?Q?FEjt71/vrH9alK6BwEOU5alGqT2UZKLlL+D88iOHQSmUwTVLEfrB9fXoHLoX?=
 =?us-ascii?Q?STMWAp22vNpWiT2OD8QeBwllP4TCAUl/on2ZMJY7wlQ1wWZJMTDIW8Yueu42?=
 =?us-ascii?Q?EKdAKRtOhTD/+prLG0JBcm7pdouKPPJNaaiQVAS0JsoH6oLVUZcbQnvyq4AS?=
 =?us-ascii?Q?rd9TZe1Cphhq1VpEFrSb/G8g+rntRocE3fyEIirQj+ygu0aJKIAHMmPCRRGv?=
 =?us-ascii?Q?NszRW7pV2KS4ecwSSOW3/xNTJmqcja6NgdG2DW651isPcOaI6kHALN3FUPKY?=
 =?us-ascii?Q?1IdRl6lXyBcNAqtyMjA7zc4YG434a+1VtgRohsOFPu/ojDOlzWa4sutuessE?=
 =?us-ascii?Q?OIFEmB0CdkQtNoprmDYDuXHAyvd0cS27IseHTyiSOOPYbLn/3ita4v18jhwP?=
 =?us-ascii?Q?Kgqz6Ha5opBXaSjetb88/ewfCvc5lTlbaeTcxG9Y+P0qJnqOWHFLVMyARucF?=
 =?us-ascii?Q?BlmpwqO3Osi6YWHNDI2P7nTx8ElJ/qTU/Ekk3rhM9JS6R7yfZJ8c7fBE3N3O?=
 =?us-ascii?Q?awnmxTV3XZgzIh7XEeEU8/AWTPpG3F8WySydAenomjZDdX9O8ccKCnbrz+d8?=
 =?us-ascii?Q?PoLf8VcqNQhbgeVJC1w+ugPyQrAoYEX0Oq3qBVtjpZAVbY0k0w4p5Pg+6ITH?=
 =?us-ascii?Q?nmMfNa92a3gg9p+Rhao4wwgC0ZbOucfzQHtkcCuiKPih2K8shai7jtUWfjGZ?=
 =?us-ascii?Q?NHg6W23nzZVyqw9l008GidHP52ycivJmhR1Lj64ITU3NC4w6whnz3LKila6s?=
 =?us-ascii?Q?qqqkl4qDk/hdTxuIbfNMsdviyQ6bkNxODS0xMgxcwV5FRaDzno/6vMoRB9iH?=
 =?us-ascii?Q?M4XSxk0KZCJXgsP2w+Ri8xL0HzCpTvmqZSsNXsbyjAFZoLJYFjALluMBYNLJ?=
 =?us-ascii?Q?au0BVIDJg2FJJCCitSuWbusOAs+EObXFntRwCILJWLs7zFFU98IOOC7okFS+?=
 =?us-ascii?Q?eah4hymhPY62oEuOpvA2dvy6LnTK235vsTaTcPRJgdo4NYVVxWZkEB2c92vC?=
 =?us-ascii?Q?WVNYAYMIoHkCCDqDmSsUVDbQFxgXtMAzWEzDe+u5YOfEmzRNlcj/M8xwG6Z0?=
 =?us-ascii?Q?qGzqMx1gzOgQN7rxRGRjLp6S+rkS9wJg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 05:52:14.0416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dd98e5-4915-4733-0ad3-08dc9b2449f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
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

add amdgpu ras POSION_CREATION event id support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 45ac82a34d49..8a98611d2353 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2116,8 +2116,17 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj,
 				struct amdgpu_iv_entry *entry)
 {
-	dev_info(obj->adev->dev,
-		"Poison is created\n");
+	struct amdgpu_device *adev = obj->adev;
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
+	u64 event_id;
+	int ret;
+
+	ret = amdgpu_ras_mark_ras_event(adev, type);
+	if (ret)
+		return;
+
+	event_id = amdgpu_ras_acquire_event_id(adev, type);
+	RAS_EVENT_LOG(adev, event_id, "Poison is created\n");
 
 	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
 		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
@@ -2889,6 +2898,7 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	uint32_t new_detect_count, total_detect_count;
 	uint32_t need_query_count = poison_creation_count;
 	bool query_data_timeout = false;
+	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
@@ -2896,7 +2906,7 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	ecc_log = &ras->umc_ecc_log;
 	total_detect_count = 0;
 	do {
-		ret = amdgpu_ras_query_error_status(adev, &info);
+		ret = amdgpu_ras_query_error_status_with_event(adev, &info, type);
 		if (ret)
 			return ret;
 
@@ -3964,6 +3974,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type
 
 	switch (type) {
 	case RAS_EVENT_TYPE_ISR:
+	case RAS_EVENT_TYPE_POISON_CREATION:
 		event_mgr = __get_ras_event_mgr(adev);
 		if (!event_mgr)
 			return RAS_EVENT_INVALID_ID;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 88df4be5d122..1343cfbc913b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -432,6 +432,7 @@ struct umc_ecc_info {
 enum ras_event_type {
 	RAS_EVENT_TYPE_INVALID = 0,
 	RAS_EVENT_TYPE_ISR,
+	RAS_EVENT_TYPE_POISON_CREATION,
 	RAS_EVENT_TYPE_COUNT,
 };
 
-- 
2.34.1

