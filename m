Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9659DC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 08:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1F810E921;
	Thu,  6 Mar 2025 08:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f6UMBK4m";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A3D10E91F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 08:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUWYtHdF51k9W/Ib4z7vcrbIfa0qn37I9OwGDwbCayTEsIVWAYSG/a1gLrye84p8/6VX6HfeLV0bONd/8At1EwSgM829t31xdT4JjJ5/JvR0p2PNQDKZtbBDChPwIxhx9skfHsBDBWGDqt1JjJf3ixmpU2MxeiMqcvPZsFTDkUnxa9Rd/Dg1/BXrffetNwZ24dUI0jxMCS/suQh73Ypw6/dlYIKmF9I/JbIGXWGwUgsox2vmDUVdiqj1WLAwqYGLG5b7OeCLGRsyEZfEyohQpzYUxiFteRPJqEFGjnz791RhHkBKpqwnryZqd6iL8EMVsdXl5OEDXNFJ3VH6pe4LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwomgNZsLEbV91r0g5Ww0FJU86W7LLIyx6T0dLF7uF8=;
 b=FqQMJBxAFR4QmwdoXH0ZF3Ed2ZKwy4Yt3Eu/0OKlN+yz/ZFlQDnbf3ks9aL96ZNQWcayKLFIGcNp6UM051Kk4M6bGBSSJzPoZ/oYHQDHK4sHdxJW1CFA92WBMQENVWfiJ4N5kIcfU3jPrFhEBootvcFxOWvbJtxvkQFcGr5a/E5zfyBumyqW03zpbOIRUct8sSLP8gj9cn8AzLRT8jtwIkaQ4T8IfmNF04ijyGTRpjUEpByEO7RTh7juMua6PYKV+a7eJRQcbHQq0bm4A4bIGLFHmmAzmfprV5RakrKhRuNEttSdKFwHvpBtx5f1ekPK7nIOdf53ikwaEwj1U1LVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwomgNZsLEbV91r0g5Ww0FJU86W7LLIyx6T0dLF7uF8=;
 b=f6UMBK4mZftYOMeZvL884TEOFGk8y7a5vFpR7ZdKitIwLweTaz4JtkqvP2R65wJTOSCAoVVU3Z09QFW3dlMO46Amo4kZyfPY2xNiDT5PRB0hfsMtsLbaDvIpCsLIHbt0KCObH50ZNy4pPN/sN1xUvAEz0arrqr1fTzghMDt28x8=
Received: from DM6PR07CA0054.namprd07.prod.outlook.com (2603:10b6:5:74::31) by
 DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 08:22:50 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::ef) by DM6PR07CA0054.outlook.office365.com
 (2603:10b6:5:74::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 08:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 08:22:50 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 02:22:48 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Use unique CPER record id across devices
Date: Thu, 6 Mar 2025 16:22:33 +0800
Message-ID: <20250306082233.307681-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: c857008e-ce02-450f-8454-08dd5c8815bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0XsOSKQ74KEUgpbfb7VwxQZJI5tZauJPDhY3JLuG+mKkQSPAgSb98VRm8YjL?=
 =?us-ascii?Q?9kQFOMvR7WnMHdBnk6nqSQqUubrOzVpk5WUFenZ2TBcZPLHgPHbq9N9+JxQD?=
 =?us-ascii?Q?4cd2fl2CC5R9gzjSTyl/I2kr8iHMJfdoZ8sNP3tchgtxQ2ocISvQ71Pg+Q4Q?=
 =?us-ascii?Q?eW9ij9peg8TY5WJ4ID2fhB65cPjXg00S+cH/DRifaa0okSLWzP/KCwXMxOgu?=
 =?us-ascii?Q?zkifXQHhiaZUYZ0kp/gApRQImKabwtl4MLIxNW6LxaGHuunOzJ9zHkN3ln7+?=
 =?us-ascii?Q?S5oB2YFrcnDIDvmxQ2LkB/RCCZ8ZlvK0vvDkwVuUO+Mw2A0QrzsrqPQHjVTk?=
 =?us-ascii?Q?Kl7UlFWydomZrtTEsXaRqDRWCaphNc61G8zF+ZVik+96y1qumZ/epaHzwEJO?=
 =?us-ascii?Q?8iyCIbjJNvuX645GJHiT47PhskmqlW023Qmz1gaodPsboc843LmpCBBMb+Bi?=
 =?us-ascii?Q?jIJKgTJAbBh7fGHLyxDOdmQBqfiym+2Anq3Mt72TRvjAlE8PyMieOo1qS/fT?=
 =?us-ascii?Q?b3KAIJlgGzETbzv5BmUNwG5BNdB1ln2h+0bSATgYxWYTF96UU3CmHF9JrmP/?=
 =?us-ascii?Q?AY50XPtGzdpixkD4YPc5YxPu/AWdwGnKLiBAtO2yfV1sTfg500yTP6fMwmZB?=
 =?us-ascii?Q?YetpinoqYE/eHefJ08gopQWf7T67TU2PiYkgbZxyuc4eqTeFQr/x79UCOKws?=
 =?us-ascii?Q?s9L8LKVMnDJyYYLHpCDl1YOuKLsrmh+x4oPaI2HbYwyW6FgxWaZvRp4hMU7c?=
 =?us-ascii?Q?DqG6Yij4lmIUN5+PrmvKO28BQY9bT3ODaH7xTXkoqdL0ybKvFm8YximpPm3j?=
 =?us-ascii?Q?XRIT62ujCBywYyCfDidtCMzpTGTy6ka7rpI0yzZFTVhsYS42D3tiq8xpXNah?=
 =?us-ascii?Q?AFlFiYhUxEZ4KajOdWlwOZNrfSx2kqi5HIRxeEGEzxB9pEcjCMlP52VVluEr?=
 =?us-ascii?Q?Xkq1H9Dw67KI1Pc+btF3OHNY3nxRHqRb47KnSKNNkEpJ1cEf7ik7xqr9lbLa?=
 =?us-ascii?Q?0L10stVVT/MV4la8WpCn0u15S7KuQ/RbgSXjUPjUSOvqztut8xfgwNH62ygA?=
 =?us-ascii?Q?XMM8nFn2WGpvqrx556ZqiJB8TZsSjy1Y4ZL46y+/KrwTsoTi40VBud+yxAqj?=
 =?us-ascii?Q?SY8xhzs4/pivf69rmJzdUgmlVxl3Iw2eFtKYhpIobu5hH7nWdGvmE+zdqtVm?=
 =?us-ascii?Q?l9nLQHFu6pzajmh84RqvE3vq6h/PkAmVMA2DgQq36Ay41UInMLnADF404yOw?=
 =?us-ascii?Q?oVnB0GgLjbp6LCXx2fRBpbr0jJ89OZXQuovP9n0POwnFgjlVCMkRC71gMjhw?=
 =?us-ascii?Q?iIhhMXgBOZqFNMFBEXApO4MT0w92oVF8H8jzOCLoCGRufFVUNj18KFHJ3pxS?=
 =?us-ascii?Q?38FfzoERxRXdFVvaRd1ApXU4nKoANhPIz5pJloB8WJVXLbXky2zHa/v7Sv2k?=
 =?us-ascii?Q?GJbci15H0d3BFn5H8a+9jwLMXPgKaC0clLwSiOpkSfFxKdESCJQfIdJ/DvbR?=
 =?us-ascii?Q?uGc6x91OiEZOjaY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:22:50.5303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c857008e-ce02-450f-8454-08dd5c8815bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
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

Encode socket id to CPER record id to be unique across devices.

v2: add pointer check for adev->smuio.funcs->get_socket_id
v2: set 0 if adev->smuio.funcs->get_socket_id is NULL

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index d77da7ca9a87..bc8473306063 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -57,6 +57,8 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
 				enum amdgpu_cper_type type,
 				enum cper_error_severity sev)
 {
+	char record_id[16];
+
 	hdr->signature[0]		= 'C';
 	hdr->signature[1]		= 'P';
 	hdr->signature[2]		= 'E';
@@ -71,7 +73,13 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
 
 	amdgpu_cper_get_timestamp(&hdr->timestamp);
 
-	snprintf(hdr->record_id, 8, "%d", atomic_inc_return(&adev->cper.unique_id));
+	snprintf(record_id, 9, "%d:%X",
+		 (adev->smuio.funcs && adev->smuio.funcs->get_socket_id) ?
+			 adev->smuio.funcs->get_socket_id(adev) :
+			 0,
+		 atomic_inc_return(&adev->cper.unique_id));
+	memcpy(hdr->record_id, record_id, 8);
+
 	snprintf(hdr->platform_id, 16, "0x%04X:0x%04X",
 		 adev->pdev->vendor, adev->pdev->device);
 	/* pmfw version should be part of creator_id according to CPER spec */
@@ -117,10 +125,10 @@ static int amdgpu_cper_entry_fill_section_desc(struct amdgpu_device *adev,
 	section_desc->severity			= sev;
 	section_desc->sec_type			= sec_type;
 
-	if (adev->smuio.funcs &&
-	    adev->smuio.funcs->get_socket_id)
-		snprintf(section_desc->fru_text, 20, "OAM%d",
-			 adev->smuio.funcs->get_socket_id(adev));
+	snprintf(section_desc->fru_text, 20, "OAM%d",
+		 (adev->smuio.funcs && adev->smuio.funcs->get_socket_id) ?
+			 adev->smuio.funcs->get_socket_id(adev) :
+			 0);
 
 	if (bp_threshold)
 		section_desc->flag_bits.exceed_err_threshold = 1;
-- 
2.34.1

