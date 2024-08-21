Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299D5C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 06:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC6610E598;
	Wed, 21 Aug 2024 06:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QnB7vBGq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491D110E598
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 06:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3V3K6Me637SzRkDrMj+4Y2nNVtDIek5CWBoDD6CMpaZGvf6vuUsserQ9jkGRTDbK/O5yYB3iuO1d013Rez8xxzXN4yEt6KqyYZEgTWvGc7Hynf/NR5fgIkuX38w79GVoE8o2h6I17aZwmAlQrtkBi9VMbtEHpq60IRKvM4WogHxQpblfdQJb5RsneEtZ5uEhgF0hHxt8f7/3sOnJh5+ygjHRgNXE78hDUgtgSgNm3f9KTc+CFsvZ05Mnj5O0h2me9GXceaSnBo99IxDO+rlG3EKEoHaitWat7pidxc5/YxpX+aW3ny0h/rTwH+UmPB5xd+n/O2Zi5J5KH2inWh9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfhfRsEwtpZoNCVzFjGl8LLShrNm4cMtc21y6HM+d+0=;
 b=y5uMAqUO2vQsMLgh690Mmy1b2R3dnxjN7nPfpdG/3T6rmynk3wdsezZaAeadpaRlN8P+VduI4Pj7JoBveQV+pJxcr0S/+iPvnYkcFype8uBtzb2+AeEt8I/u8HvD5RTWO8JXTuSCdOAdq7xZPM3XT4qficRbgTdRBm3sKwnAYq4rlPNS9HA5XmmD2sU/drThPtIpQwGfSBi0/oTZzeD+24Mp9Hr1yQKY963xTmjoARagmvmmHcYLkG83StkvcWdqyC/K/prtV/U9yYKoLOmwmTs4kOSJeZCtwrxL0GeXTBdMYti1C1n27k6XSsetKexRiRaf+LfkMLcqpaI5aHtIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfhfRsEwtpZoNCVzFjGl8LLShrNm4cMtc21y6HM+d+0=;
 b=QnB7vBGqr7r8NhcRnaANHJzRDidTb4I05q2mZN0V+0UvU1Xl/GCGNHVG2t0VXMOWwqBjnRmhB4L33GiuLZIlHz0L4+roHAaC8NUNN/vufI/10Ld0UrILvz18rSBAdpkaOc63Dv5chM8QEL51vHlpLXPCjMZgcNKH0r17tKCmkhc=
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 06:57:35 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::42) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Wed, 21 Aug 2024 06:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 06:57:35 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 01:57:33 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add list empty check to avoid null pointer issue
Date: Wed, 21 Aug 2024 14:57:22 +0800
Message-ID: <20240821065722.353171-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e62be4f-9de3-4815-736b-08dcc1ae898f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r1y/iadBpHnESy/GrOd1wDXi8P+1czuuVp0YqvWcnYfd7XImsHMftJZt4ZBL?=
 =?us-ascii?Q?r1fXIptKXPDips58+7n6LY/uya8MYh4a++UZdLGVZJ8ArHC+I3HcYRPY16/o?=
 =?us-ascii?Q?tNN4h5kiLlIyENLFkvIqNcikXSdNTpbn80QbyiZvcyPFAEUrmd5F3jsCdIJK?=
 =?us-ascii?Q?wgaXPxthrHit3dOk771qSlI1uaJFL95BDxv7Fooxc/0rudMebBIA7xe/9m0S?=
 =?us-ascii?Q?8szhPlzSKH5wpOE5JS0dOxeZvwVe0wrn+LLO1MVmfAduO61Yo8FCiSYDem3I?=
 =?us-ascii?Q?rJ7/rxHJk/mTjNl5DhR3IqD6F0LdMCJRSoT5oAZsAqtcbvMqGhJoHD0rDmNX?=
 =?us-ascii?Q?zfaNn4sczN1rRaMLnq9otnBvWQz5/krtLXMxku3hOBz1FWZuRzMz98GMM2DH?=
 =?us-ascii?Q?VgE+rX+sO+UNtgCFP+ZOdMl3lsjEeCVxxElXhKDedzbN9s6AIDWibjINsTLJ?=
 =?us-ascii?Q?F3oppzJe+/M3JTql+1sjeFK+x8THQmeyy34e5Md3u3cmVMA0Jz7OLdPTJ/a6?=
 =?us-ascii?Q?xWl2xH+sgJZ0i4IGfOfGz+4lN+K7xja4Ku+3F8VgOcol0NA17e6b1BGcCLv3?=
 =?us-ascii?Q?Mcr/6Z7UNU/JXzvpH2Cvfk2w56jzXjgCVqccfCH89S48TFGMhfvRbV1yca3k?=
 =?us-ascii?Q?8LsgeE4SX8dS5TH+UvBNKH8l/ht+xZxfM9xIAGpMqpOS3zt9Fg6nUtPV3dUQ?=
 =?us-ascii?Q?o4A3/5W4lsx984VCL+yDo0eo6Qh87UigonpaRty8O9iPtRm5kOGirVxZksAy?=
 =?us-ascii?Q?Wtzu3FC1a6qsZMP4kfAJ/pZ6mJEQxt4ui2ctJKaPsQr4l8jC0jzDEixjd6bp?=
 =?us-ascii?Q?asuAQeSpfZWAKUqf78/ypLKMWSy8OVrbY517PwiPboIdY8uVbSVtLtfiV5GS?=
 =?us-ascii?Q?GlOmNUBfW1iiSvPx4ZQF0o7pqFcEulgcKAYlKR2rHsLCdaoxG9VutckvKZnI?=
 =?us-ascii?Q?a0PiBb9l3RD2K0mWQllQgjxxhtjLEuh3TSqGk3aixnyb3yaK+4w8WiLNiRPs?=
 =?us-ascii?Q?SxWGTNLYxdZnIrUVxzB6ovuMfDNiBke2jZxMg0K0v7hpuzROKQzQHw9w/Nep?=
 =?us-ascii?Q?N4sjqPV2Um/pxjhI6hujq+Uu5RVF9XUotvcWBWOG7NHoQ/eepLwj7hDB2Qje?=
 =?us-ascii?Q?AAo1NiHKAk/KHLldrTNErdOeeaM2hozVf4kdmzbRF1CDe97LpeOS+X6UqCLh?=
 =?us-ascii?Q?08VmBQk5ngDFYofWfHnAxs2FzPVtqbztt1WhD1z2TdfqGMORLNZYX0vfwYfy?=
 =?us-ascii?Q?cgIpFnXUUXjmGI6dDRIUPq9zFH1tI09XnMuxLFOtwOR6FFM6m54FjnEO9W7o?=
 =?us-ascii?Q?3OeRgy9zzBxw7LmvbMK+EnzoR0yv+jvHJe3uOaM62LiFwaW1HcOKYBdiZod3?=
 =?us-ascii?Q?oiJAhyZqfZauiB2LY4O7xaVyWkHFPQLHfHG6PxYtOKsFKBSIlfblPuhCarz9?=
 =?us-ascii?Q?+Yly3PtwnwMFpzS65D3lvznnosusGSid?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:57:35.4867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e62be4f-9de3-4815-736b-08dcc1ae898f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
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

Add list empty check to avoid null pointer issues in some corner cases.
- list_for_each_entry_safe()

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 929095a2e088..57bda66e85ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -80,6 +80,9 @@ static void aca_banks_release(struct aca_banks *banks)
 {
 	struct aca_bank_node *node, *tmp;
 
+	if (list_empty(&banks->list))
+		return;
+
 	list_for_each_entry_safe(node, tmp, &banks->list, node) {
 		list_del(&node->node);
 		kvfree(node);
@@ -562,9 +565,13 @@ static void aca_error_fini(struct aca_error *aerr)
 	struct aca_bank_error *bank_error, *tmp;
 
 	mutex_lock(&aerr->lock);
+	if (list_empty(&aerr->list))
+		goto out_unlock;
+
 	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
 		aca_bank_error_remove(aerr, bank_error);
 
+out_unlock:
 	mutex_destroy(&aerr->lock);
 }
 
@@ -680,6 +687,9 @@ static void aca_manager_fini(struct aca_handle_manager *mgr)
 {
 	struct aca_handle *handle, *tmp;
 
+	if (list_empty(&mgr->list))
+		return;
+
 	list_for_each_entry_safe(handle, tmp, &mgr->list, node)
 		amdgpu_aca_remove_handle(handle);
 }
-- 
2.34.1

