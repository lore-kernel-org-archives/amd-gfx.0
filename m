Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A14C369B5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E4110EC61;
	Fri, 11 Apr 2025 18:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gsw3lBwr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A0810EC61
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akDtYX95kLOTxYAL1rwaVwB0QWAOAtWaW9NaGF2OLiLlC2iUVotkDuLB0lTLslKMKb0ClphqtqaeOyQKcn+k5gJqT/AUXJthsBYiyIR43IOwwL3fJhDwsYevGqdWP0mjAlaUeKDfs7voUcEmu2sMohL/kFrYhWukU1WDsGNhFbZ4aEpkXpmL7ZdwlMmryfghZ9IhZC0+BChZerLShpPy6Lil+yTUlgDgsQl50t6GjAs6/Dzl/j5X+kNqGDNHH3J9EwHoUmVVb5jgWqnPLdwq9A3wSpEQLzVfaiBrkpODauaqJn9WiL+Eo8Fd8AdHZFTydhgWPGCe/lS6KktjTrdvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUiGLE5WvMQX6AHNRuqf2hT01fjRQjeASbAa2CQ6Z78=;
 b=uZIAEg+11qr+mSelaZSBJ7X7/OjQaloWLNK5zZxzlGqhsY4xnP8pPRtPFtilM235OzFvC7YO7lO23sKiDaTEtvU8ZdWq0g4OZA8Icd1uLnYQxH7M4fyKP4UaNXxEc4KAmUsv8MFGHt8Ztv22HAoBa5oyJvGbkZHgKCVA3xhLO7+NQ23dTabEj0OAIPZHCQbnOWLo9GDKuCOF/r5cQIQ1mtMycfDAQasP/FrhYBHyWZ1s8lRSWEdqQO4aIlTPWh37+FqPw+vjGEvFbx8dHAN7T31jNwvmUlJMmUv3OG/ceqp48H/JKDYo936bVnm35Zyh1XLC1HX4vO4f4NYv3YYBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUiGLE5WvMQX6AHNRuqf2hT01fjRQjeASbAa2CQ6Z78=;
 b=Gsw3lBwrzRfCUBQAFYI83CeFceKQY0/Lv1kEOybrOvliAmdxWsClt4/5UeP48WOv4DcaA6T9s1zMlPBpXnrglG9VApsg6T5+UEdubG3tvMPJBxB7DNe6bOLF6AbXAHCzNUYeEptpMjTsSbmVYM0N4gAFkY+YMASk5UWiWW2uk9w=
Received: from MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::29)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 18:48:44 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::5c) by MN0P220CA0001.outlook.office365.com
 (2603:10b6:208:52e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 18:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/10] drm/amdgpu/userq: track the xcp_id associated with the
 queue
Date: Fri, 11 Apr 2025 14:48:23 -0400
Message-ID: <20250411184825.2890189-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d40f9fd-697f-48b4-5210-08dd79297bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cDIuVJ9UI9fu8qyicyIYUImWL22q8FO8DYRK2vWavyTFYVqfaKrod2pA7oxk?=
 =?us-ascii?Q?6hpffYacHuXDwWPqgqX4VsznXCCpozBu+IjgyX6em+/OUA484+LFkIkqJHua?=
 =?us-ascii?Q?aF1pni3r1v6oieG7YR21T43wNpZ1OWZX8zziAF/FW+aVU448gwpinBxxh2v8?=
 =?us-ascii?Q?3uvvZbxoqqM4R7jBoOoDicw34D0XWKYuz5xisohHLoRVuDLUfrhhR5DMsXOy?=
 =?us-ascii?Q?DvtGoP2+XclKr6IEXVCvCsl9jhd0dS7tJZ2pwDfaDIOs8vPIHKcnmTrQCRi3?=
 =?us-ascii?Q?euYfGrQniHOOshRGrkCNQJ/4D+3Z7FFO8zheXw97NcoaZgPRKdYOSSQqkf0O?=
 =?us-ascii?Q?1w8FcroJ7kVJ2fyl2PXulGTy4hlFwO3sJG6jh3scj50P2lv0yNgNxCELB9J5?=
 =?us-ascii?Q?bXINWVlPIseQunaWxISn3RbzJ0Jjwmi34jAWIYk8oXCaepyylfEjq/oe2SqU?=
 =?us-ascii?Q?3Ht7lknoGfI65c8KRjU/DxJHOOUgt+r6wyUSoclooANOlbl3I3cNgKL+mrl0?=
 =?us-ascii?Q?Dg8VF4qmvruTxpdjfF2m4+jn3IY92rSdytbNAER3/cY5+gr7PlPD35l6LDSH?=
 =?us-ascii?Q?MR+U03mw2oqnsOtBSW1oi/wsjCKVBYvXMVVr6TLZRT+NDcoISjchN4QSr84T?=
 =?us-ascii?Q?QrTxgsDT5iM/Iy1tUFAKMQIELUxPVdAhmWeWEeOhVVdMbk+o/8KoOnws5p2S?=
 =?us-ascii?Q?gsORceGIC4HcVTQBPv3/W7zlqn9QuxYh3uD9x6maltngKfuo3Rcl/5aRTuS7?=
 =?us-ascii?Q?xcxUcxkZa374lTNnxLxYLlM32ZAMIbclkotwl0o6GlrYcjVeOGgwGw70E4R8?=
 =?us-ascii?Q?MHhFV0YlGFgtI2yV/4RXNKa/iOdH695xmLEZCam694cVfNiIyAjXVtSTxxOt?=
 =?us-ascii?Q?44ESQlH0PU+rXM32Ku21DRO4IpHplBhK9Lc+XkII5sciYMwOhfdqAly9w59T?=
 =?us-ascii?Q?IUAyc2x1aNEUy4uELo2bxDgXUMqKoEbOyjOK4y7DxbnLs5mKAjF6KiFaakZi?=
 =?us-ascii?Q?mqgFnByZ3Zg/6Xpi+3DlF90N8L86Jst9Fo/YeWTM4y2MIiMTYNqrjlHfY5y0?=
 =?us-ascii?Q?Lt7zxDf8bWT8N/rBPlpL2auTSp+xHgFLfeb4AbW0HyXbdqE+CytE6UqGqR7A?=
 =?us-ascii?Q?OU2w6qHp0NkC1D93n1EPVWQdcgBGEvJns9Ba3r5KpDbWYKCNB3CwdtYPTEov?=
 =?us-ascii?Q?dY7OCI/vEeYdiiwIojjUdMGCc+OVvOrGTvP3Mo0oYdiqLn2puidKBy/xKaKC?=
 =?us-ascii?Q?wgEzqN7uSlFdPsLeu8kTOyIyjDiP0wQ6sXrgJ0xI5ALVXJJk582oOQwbWHBR?=
 =?us-ascii?Q?PCjOJgnLrFeCVRhimGL1H1H6WdzBRCwnIWAg/gd9m/ebGhfj7deA7LASGKGp?=
 =?us-ascii?Q?SG/lk2nAv5ef2a4cnkVtszfQxM6ONpu79piXPZnC9BiRJPVnWOkqCCdfC7+M?=
 =?us-ascii?Q?hddmCturgUCeiscWNELO4OgCtq35YkTaCXoml/guY4jVKIY4tyRoqTbPBijk?=
 =?us-ascii?Q?a6Rprx4y162P6c8Bcxi43xKrs7Q7JJX0oMgw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:43.2092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d40f9fd-697f-48b4-5210-08dd79297bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
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

Track this to align with KFD for enforce isolation
handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index 381b9c6f0573d..db79141e1c1e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -56,6 +56,7 @@ struct amdgpu_usermode_queue {
 	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
+	u32			xcp_id;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

