Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AA0C531DE
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF7F10E326;
	Thu, 15 Aug 2024 00:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nBwSknIR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1045B10E326
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD4JDOjSEzdKEPOw2o4rvX0GrNctm3mbgUX2tJkoc34FcukNccbgvuh0Lcp/x7jaKJrI9P/QX7vzL9GvqabrKFkF2NoE4SMiJm6jHKL0Gyorz1DKxEL7FV0hiX0nfGQ2jXhZWUl1uZmdFbPDeJPzCSJOeTGWxU6ZF9OGFCr8gEEV7JfCpv5VwN5E2oAOCS+tmli0mARm3YiPBeSXidOH6Ut8HBlCjOlwHBEk7NqqjS1KgZLQwJ6riyLMqP3vVgDeOPSMHQFepoXPZLxyOnwoqYJ/mHb3NmjS+Nrwn/UfhfDhXl4SKkaYD1kEoNqaYXnwJpvM1ekn60UuxqHxq1qY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRFTmLaLqMG4M7t8pmrjIiPAwUWBUvJW2CXa7qmXEm4=;
 b=LO6IdJ0xoRhwfoJdjkmveUJfWibnkpF5F0CXoQalGuoriaTL5HJ6adhqJYqWbuxfe7ZPAi1uayz7Aug0ClVPEi/n+f979C/Al+dcCzKMZ6LXwTMG/O05UI23EEXb9KFW0kjcDXqKQ7j/ljgL50BpvlTsfvWCdZmdzrtvSEgltXl8WldG8+hu+WMQDM3rlSRVHYa9bzsYZcIC14MNQEoP+czenz6O4znoRLZkxI/lK78dFJdPCdz05R3ZZw7NYxmlf8km5uzVOMaudqrFDDG1UWeAnk80/j8SGGlIqBfY2xUBRISuT7AUHOG9zH0cvSxSSN484J5VJm5LS5sic8+9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRFTmLaLqMG4M7t8pmrjIiPAwUWBUvJW2CXa7qmXEm4=;
 b=nBwSknIRlMbSkFFX4v8BanAjfuvoN7MzaLyc5CcmkBUBGEikVtVKLJgrDGRoexr2NoBWhdgeJ9LEMPLmbAYloNmM+wLqlIVZxG65ld8DD76AOGJBM0S5qkKMvFiePJBvAGyuGmD3vBQkXH2081iDMVRrO6FHal7aOL+nvN3T1eg=
Received: from BL0PR0102CA0032.prod.exchangelabs.com (2603:10b6:207:18::45) by
 CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Thu, 15 Aug 2024 00:05:19 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::83) by BL0PR0102CA0032.outlook.office365.com
 (2603:10b6:207:18::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/17] drm/amdgpu: handle enforce isolation on non-0 gfxhub
Date: Wed, 14 Aug 2024 20:04:45 -0400
Message-ID: <20240815000501.1845226-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c639b7b-8808-473c-e4dd-08dcbcbdf2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4D0QnnFUtdqLQdJESi68DIl0PR9jb2aK6uMZkQPoSP2dDqnf3BGtWBrJ3Raa?=
 =?us-ascii?Q?s8+G1mTeom4X7Ga6WxRFqRkaLs77+pK7Ll3P+npQFIO3DSPiKT+bCU7wrxli?=
 =?us-ascii?Q?57eIuNev2JXZp5IE2Ji563cj7H2cBqTrHbd690/etEHaYJWHPB/k8iPndT1s?=
 =?us-ascii?Q?PZmY9cLRWOFFK/l1N6ezvPClvyIN/Kso2Qg4EUOyyM4ANNV8v4HdiVxlSwTl?=
 =?us-ascii?Q?UG1wZSKzWrusihDsq5whzsdsVHO/04KMBcu5xPPhPzcUtrE/lialhFFYrWMp?=
 =?us-ascii?Q?jikwWPYEGz/MGQ9cAnHuktMq8U44sHD3rGc7NOOEcl9BwoqIPjrAub/ZcWe2?=
 =?us-ascii?Q?b808949MrC5b04MhKPv1Uv+WqLXaOlNgpiwmo8hU1oP4Gyk+fp0JpPGz2tdl?=
 =?us-ascii?Q?qMUhNqpbkX9xlHt1F+TXcdIhUyDlf6Y6m0O2SUDhU6G2IljMktgJ2cc8uWhR?=
 =?us-ascii?Q?mVh5/zJWRO+po7Hne5wLAJvmy01bPVi5jYERtG13wIr9er17R+/9Z1pV1/16?=
 =?us-ascii?Q?PPutNeaMKaRN6Jqhi9dOzPjNgB3JtIapdMBv1h+DfmH7DEJFJ9wKFacQL3OQ?=
 =?us-ascii?Q?E5CFMYUbb9nVoAkhBYZrcDJPP40rHtgDFq6Yt+IIoMSXZSEuSskMLygRQeMc?=
 =?us-ascii?Q?EWk9WucHg+/mPa/GLVZwJYG6L/LlCgi/R3zMw77NLpu6P8WTewil+ZM68Mys?=
 =?us-ascii?Q?PiuHNxgByE9ap6qB+wpaO1a2u23OBIQyWNRIkLnQrDwVQ+7pFLvd7HDQa3ga?=
 =?us-ascii?Q?0z7zIdMlpsV5cEK3w+ZMJtKWvgQ9K5p0jmgjwRn5JtgIbnlzUBWYi2i6LopF?=
 =?us-ascii?Q?wEs6cXgdmvni/Iln8tXdF8mm+R5uVP3bGnVeiub2ZDGpJzLZiPrN00CcAXi6?=
 =?us-ascii?Q?1vI4dBNG2vool4Wlv8dIKckCcjcNAlpC7g8gwufSXzgqSywo3gMSLOIlmwEv?=
 =?us-ascii?Q?OPm1ZG5Luy2rdnqPTuVxSLOZfRPCB3VPI3lqEl/sv7VkZqSwxjBhG0jvB9jz?=
 =?us-ascii?Q?PEtdZZbHDew55Yu9dfF+3R3p1OMps9fkFUb8nbNuxL5m4+/0sMo1IMb1PkUS?=
 =?us-ascii?Q?kEDnS6L3ULWCLg7g+bRfPs60hFea9BapTZwx2BfBaURgkTaguErHxtUYNmqP?=
 =?us-ascii?Q?cMdG2QdzzRa7eybrBpHJ94B6tUMF9+Kqvuq6XfQIL1hV69SZndTAy+brBb1t?=
 =?us-ascii?Q?FYkzQtQ4JNiYShxcTHTsEj7f+5NqKTOSXgImDkVWZmhN0u1j/Rx8hfUqRPyf?=
 =?us-ascii?Q?Kloi5I8WOlBKCmDjodoUP/do29W80AjFBb1eP/4bBvw/HqXUMtjiaIpMk5i+?=
 =?us-ascii?Q?rTqx19E0VPtEXgfjsFMPu2sbcaODg5w6YblvdEI4ab9cuC+DgIAYJ4PXUDjT?=
 =?us-ascii?Q?5nyYCARyPEJublbOCsfp0M2jmMZVjYwqA16atkkwxnmt7McCB7tMBXrrU0/7?=
 =?us-ascii?Q?83QuaeKroJ21MXMnflx7R6mxlvngVxuT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:18.7300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c639b7b-8808-473c-e4dd-08dcbcbdf2c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

Some chips have more than one gfxhub so check if we
are a gfxhub rather than just gfxhub 0.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index b6a8bddada4c..6608eeb61e5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -484,7 +484,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
 {
 	return vm->reserved_vmid[vmhub] ||
-		(enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)));
+		(enforce_isolation && AMDGPU_IS_GFXHUB(vmhub));
 }
 
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
-- 
2.46.0

