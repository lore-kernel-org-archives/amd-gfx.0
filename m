Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BA4C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 14:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA0710E925;
	Wed, 26 Feb 2025 14:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xD2r0x7+";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E278510E925
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 14:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgqAfUpFaqZxO505u4xoo2PJy1tbIwzHsiTKDYfO8Gtqno1i2zIx5ncj3chIJcj7AdfT6B91bF4pFr5Kdsl45lBokgQokY0DFLQxI4kaj/jKpfYF5xo2BsTz9/P7RrVsPXGnXxFdgf4XqToNZtguC27aalGnogu2bjttK6JaLUjCf97SUBuOxJessLaKvhpjz+PWCbixQtjwxMECcuFfa5xr16gPXTG9tmGqVfwrR47QK7IAoQrAEn6kNVDCf6ylbv5ztZZ8lzgMafwn2U9h4vR3H/Fw58eStW5NykLam5zBG00cx8Ik2JCwoDNwA45sgpu6x40Wq0SQz2BnPyb2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39mUwEnP9KTHOm33F455j8wekrXu7Z2C+0AHivrqWxs=;
 b=JY1DV3fSjtV/xeGFuNh0r6EIBNUfhHwSpj74fmvKQECsMBREvbaF5kO8RtAyN0LRNFgpJUSHPZ3waQnV1+nFyyeQst5G4nDcaQOV9sDwgUU/btiKUY2CMZBUefceUysD4TNU0exdu1AGBH89GFQzqGbG/Aex/q6ZnNL1+nkmVQNuSNDUjfz+ZHF+ADNaAgUdDHX4nICFum2cMTJrVVW69xmoIBKSqtJJtNBYkqSbp/Iu5He9Pi4+cT72JeKYdhvIegobGhL5evbgXtrvtjoOQdnnT+7c4oorlNpEJzL49TsZKuia0zN8H/thPQ9n3ni1WeBE/nWefxWL4732SMyTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39mUwEnP9KTHOm33F455j8wekrXu7Z2C+0AHivrqWxs=;
 b=xD2r0x7+W58Pz3uOr6tJsCCow8mgJrEeljed7MeWcOlsZ+cN0KSxICNB3IuNc425Jh7yin6zFSOispOQrbx6MI2y0tVmT9IwqKYlJQmILfqxaq60Fi9JpjfHX9b+JcvWRrdSCg0Lalo9WUKHQihuI+3v65SsI6fVuKkMW9Z0PGI=
Received: from PH7PR03CA0003.namprd03.prod.outlook.com (2603:10b6:510:339::8)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Wed, 26 Feb
 2025 14:39:45 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::a0) by PH7PR03CA0003.outlook.office365.com
 (2603:10b6:510:339::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Wed,
 26 Feb 2025 14:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 14:39:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 08:39:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH] Documentation/gpu: remove duplicate entries in different
 glossaries
Date: Wed, 26 Feb 2025 09:39:29 -0500
Message-ID: <20250226143929.3450065-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: e780a977-cf13-41fd-2df8-08dd56736970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ad13P0JCu6Pk/Kf/noL0G/z5+8mLCb3r3j57kSJkF7TqdRl5n74V9u29g+BK?=
 =?us-ascii?Q?dxKP5d51qUHy2OtJpqsZLe7aHVqzP5A/WCbCXtxEFF6IrOAON9WOANheKz4u?=
 =?us-ascii?Q?Hr4lYj4IE599Dsq/BHQsgK7zw7K4FYk7GyGeALwHzJPjN+vNmiWdI4pb1skT?=
 =?us-ascii?Q?umbAhpPYpiuk/xdpGKLPmgMDMcfLiGE64QoF4U68MHAwLWwIVU+vo/ul7joh?=
 =?us-ascii?Q?jWVCxjui6C5oF57pGLQlLxiGnpOEtu6pTXT+Wk72zI0Nnmbasfib/C+QfAmE?=
 =?us-ascii?Q?NAz5iXa/mM4rMPWoKgD+mk0nKvywGyBOvnBg/jg/nK0uECVhIjJCdTeXwPh3?=
 =?us-ascii?Q?GSgbio2ljGNf5swy/s8dvr7yatJUzxfMcg9A/f6dOtruKKJBlX1H7ph9zQdI?=
 =?us-ascii?Q?eU8I2T8bxJ5Ql3e9KC8EseaijV/aJIP3rfaFJWm1tdKU9M1wy1Jpx/V5pD6G?=
 =?us-ascii?Q?YRlwEuVfok0tYSpvofQ1IH0ORgJgKXIFfD66VDdRZGZ57Gj/AIxibNndMRyo?=
 =?us-ascii?Q?EhazIOEm3n5jcxrDi1T9eGnlX8DfQPOTInHIyHMe9CfqUskl1Yn8Y7JjWW24?=
 =?us-ascii?Q?GLv82lZwJJa9fkgO11DyYaw0k7e3MQjlF0iDZdbvvmWkduM8VP73kSCBp6pH?=
 =?us-ascii?Q?p8x9y90i2Ski+vgnZcDlc8W3GLs1yicKttuwVvMJY6oq/5mCcNc0YXh5Sm7a?=
 =?us-ascii?Q?bSl00v1GZLq62Km2sT+bZe37oxIcPNvhRrLb/QCgUwvXil6TlbdCF6bC6kPF?=
 =?us-ascii?Q?t3Il99eGvNQsadxVetRJAwVDlYBZ2ig6OggyGgBHTfq1CSkMA+QjvYQWJ+Xb?=
 =?us-ascii?Q?klvzvcsjJ6oe0fX4ON3xi/gJceaIOGgv/C4qwzQP0awtdb1Y6Q4EYEU8x91u?=
 =?us-ascii?Q?N7MZOAAx6sjFlekH7mHN0ARNlJ/J+doVWukVV855f2Lf7Q28hHfDDsTh9h9Z?=
 =?us-ascii?Q?SArrlTPM4CvlPHxq3NsN4xiqKn9Dn6CLG5IGPyfAcga/t3y1Skw5v+DtECWe?=
 =?us-ascii?Q?qXcEIBNjkVogAQzpBvKDto+5wiTmpYOGE0fWWcOmasURY3R7sQ6tDjKhBAxX?=
 =?us-ascii?Q?lIO8kY+vXEIe7bJhBNvVQ6IJcZeWrvlMpXiH1k4MImvPd9piHjZH7lSZMUSi?=
 =?us-ascii?Q?uo08OphOO36GS6EWARHfQG3ekMFLkSJvZMqpnCPsp+TU6LlZgzFj+jVOBmfj?=
 =?us-ascii?Q?Hya1fEt5tZ0JO2jIz6ZTMuiPzcijMaCflhN360NLvCqgKSPNaherngifQfpl?=
 =?us-ascii?Q?nE0LbHYtlIsN36YjSnzsUuZ71yaYUu8Pl3eI352ApSeTaQUjokHCNF2pBKnI?=
 =?us-ascii?Q?aozEoxKqDBWnhKn92zrb+bio9+FkhhxIi+z2AAB41cvgsBP7BphHtzxKI9AU?=
 =?us-ascii?Q?Gd2r83IXuL49Cv6TWHDjFRiBwrcOj4o6BiZI+I9IzsKz+Q0zrpaSVWsfekEE?=
 =?us-ascii?Q?Z4Yd3VrEG8ZTGzRWQU3v40ldNXWQLBL113SalAxAdrUVqZiiHcnRj/G9fUP1?=
 =?us-ascii?Q?mHjYGGSahUcVk74=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:39:44.5103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e780a977-cf13-41fd-2df8-08dd56736970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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

Some items were defined in both the general and DC glossaries.
Remove the duplicate entries.

Fixes: 2df30ae0ba0b ("Documentation/gpu: Add acronyms for some firmware components")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/display/dc-glossary.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/dc-glossary.rst b/Documentation/gpu/amdgpu/display/dc-glossary.rst
index 0b0ffd428dd2e..7dc034e9e5862 100644
--- a/Documentation/gpu/amdgpu/display/dc-glossary.rst
+++ b/Documentation/gpu/amdgpu/display/dc-glossary.rst
@@ -167,9 +167,6 @@ consider asking in the amdgfx and update this page.
     MALL
       Memory Access at Last Level
 
-    MC
-      Memory Controller
-
     MPC/MPCC
       Multiple pipes and plane combine
 
@@ -232,6 +229,3 @@ consider asking in the amdgfx and update this page.
 
     VRR
       Variable Refresh Rate
-
-    UVD
-      Unified Video Decoder
-- 
2.48.1

