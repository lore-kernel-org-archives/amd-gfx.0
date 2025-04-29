Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39ABC3ABA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0EB10E498;
	Tue, 29 Apr 2025 13:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WY0EjQft";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516EF10E493
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 13:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpTMmzjJfbo7bdAdlausLeHMc9A96tDcgs/5xwS0gxNjzcjVrJKFjjmTjH54nNMCKrt0OaLeZ0U9TWg4x9q6+v+M7CzVfepuccYybVFSO6ERUSM9Ozt9b6DzfwqACj6e0cHbTwShVL/1S6YaI1fGm4kXhmEsrdGCYMEPesSzchn9fda2mr8zYzSOERGHqlbCjtqpbDgSpTqg3OPqOeQkKwgzttzGGM8GoB67Tx9gc6QOXqBX93PzxGq0wKEvuvBOmMB3WStIis7ZsN6VtHH+oLL0VMG+ldK+p1cboEnDJivjWn8cvHD9DDeYjWapO2VJdH9vT2lZwSSv6AFZfdRfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zZrKe7hC04wfDdDXYm7NK7QNXMgaEy/S4YOAwRNyVY=;
 b=vkI270ZtC7yYHeA30LWBEVYhN6OGz7kbT2Lzza4axgBQUFZOQXnc8OkAi0WoPm7YweG0PtXZ5ZWLdaBXN7tJg6BlZl+uRr/HJKNT3JZ1obkjoytE1ldU/4NPo6Xc1EIyBxlUN+efv6SLnBZQg3Px+P2lCeHUhVkp6wRmy8DzhCsFFDmWKA4YOqftUoQLXsPCcde2DwJ7iNeIweVSfcV23Utx7Gq9Cq8bK+9Of6hHTOR/rehLLns7a+q1fKtHIxkqkLVeNzMPaHTyJHn+xdN47G1xHSvYvsEWvBEZoNqMzxD0ZaBUdTnUcRYJynkIc4VL0rK/Uorsbs/CtjPPDM9IMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zZrKe7hC04wfDdDXYm7NK7QNXMgaEy/S4YOAwRNyVY=;
 b=WY0EjQft2qW3dt+VQfY5fedzDSe9ZilMmZ6ES/V89Q7tpu4+QWLSex/hhRWQfgzRt5NF9cUbF8XdzFBOGPAEV3pWJNJz3WPqB+keXI7OnApc5Gj2awF4XQ9me9NYdyUenJTR8Jd2zKoEP1tPUSOjLw61RoPfhO9HOy+a+Acbf4k=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 13:47:54 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::bb) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 13:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 13:47:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Apr
 2025 08:47:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/psp: mark securedisplay TA as optional
Date: Tue, 29 Apr 2025 09:47:39 -0400
Message-ID: <20250429134739.1523228-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 37755767-1a09-4a01-dffd-08dd872470c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BB+NlnNOKsPNJwDqpJz/08ltVNvdYVgpa8o66+NTVVLidu+1k/v2SdwnYvPn?=
 =?us-ascii?Q?50lJKPNMPXFN3FUw7g1xYQWdTJ0FQGTp6jM/U3ndCh/7kEsaBegSf5we6AW5?=
 =?us-ascii?Q?u22tdKtZkjI4XkXMNS3yuz5GM+H19VZTkVdqiGU7HkN/KAyA3udWLfaStBZ2?=
 =?us-ascii?Q?6ltbtVKxMDaXsEJWDu8PMJrbnKCZ23YlPGxyVNigeqyjElzHV+9X7txqM2t5?=
 =?us-ascii?Q?+bWp2Oul5Mkw0rhZkSHXW7h7PF1JxYYWFACJktWFd6cJ56ATImmUT3b0fk9X?=
 =?us-ascii?Q?1Hkzcs4F1aAUbJvYrShdzsHCdr1327pY2BRmK/MlMoTn88BP6LZjLNAuqv8Q?=
 =?us-ascii?Q?w1kOPYpxibF1VUeDqP9Cr6bAaVBU+Ioz/8+eD3QEStOdyNH4LQcQABrSqFrg?=
 =?us-ascii?Q?HeeMvVbW0qfuQQ0aQgiL8eFsbaQaR6AG0V4NoPDe6wSbYrBaCwQSiKnlZBU3?=
 =?us-ascii?Q?Zrtezdk7Fw+/a6hztsKiRWuBVnI3klHziCMT+zdaYZAjWet/9NtCCcomL3bS?=
 =?us-ascii?Q?shCiboOjcawBgiF7SvS/H8hrGTxS5R4o1Usxs8SF+mzQ4x3Oyd+app6FGf4k?=
 =?us-ascii?Q?dhSrffUSTelHV5UpQ580QI76z/p/SzznTMn6mO47jO6f5UCAf7vmMUsxSekZ?=
 =?us-ascii?Q?WlhJbqWjRJCXTcoRN6FePjzbLspur8repjwjyxdRaZ6VSDZ2mxzOKDq+cCUR?=
 =?us-ascii?Q?ehhixhtUFoMP3REoC38niTzUrCikWgjaHnxctfeUVkGQNMV0I0CRWaTcxz9d?=
 =?us-ascii?Q?04ZX/8OXUpMtqfP6Dt4eDp/bCWB/CRCLY9jxhnV4MMOupBe3SxEL9UvWdKxB?=
 =?us-ascii?Q?LbyKXjiewg4VGTPQeob0O+VDPP9iSJW9i/y/U8iyUFOP1V5UI2nowq5jwWzs?=
 =?us-ascii?Q?7k0fdIBYta7/mSQLlhiJL64Zh+U5HCA9UJXaCFOJBnXRQWFBhpyxHfz4sOBg?=
 =?us-ascii?Q?EzdnJJjeH61jFODOGBYooKvWKGk2/IQgBQIuEIxLzBNFgPaKuh799wV+i4D4?=
 =?us-ascii?Q?vfGLoRn6Kq8PhdPcZQqut7f0Y9MKzdyzcN01BRR5JZXlLFhATKQIKdkK1G2d?=
 =?us-ascii?Q?gmOA0xPIvEg20OXxiecNSnyA53DNJs9XtgFlPmI9ptpdE1eUhqy5RxY7aNHO?=
 =?us-ascii?Q?5RkMhYYbIZBZN2S944hheI7bEd6pJ3RXg28o2dQzLI3L69B/EnCnvJ4b5z5l?=
 =?us-ascii?Q?GqmbgSfC7Wa0juEVA3GWd6ZvBXvUpmsGAk6Yw67QPSz0Q1g3dzX6Uq2cYAhe?=
 =?us-ascii?Q?UKLJlMb7/xRNIEmTFLa/g4F5Fu6uZrgUDoJvjeI+ZHpMf2lhT8B+FGjEH8Ez?=
 =?us-ascii?Q?ObjXKH89ybxG/5tqpv/Lfh9N9lI+4yflSeSj8F6/cyMLnXM/zd9ftm1JG0U4?=
 =?us-ascii?Q?sFQfa5GVKImOAnOLv9fDKrAEbw2Gx60cSTDklnvg9Ty/KyaXvCLEzkF/29sF?=
 =?us-ascii?Q?341QXdRKmCZTui6kcWHy7PKa33Ovb9mKYn12R2SiYxPKtSBAByTSQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:47:53.6462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37755767-1a09-4a01-dffd-08dd872470c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552
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

This is an optional TA which is only available on
certain embedded systems.  Mark it as optional to avoid
user confusion.  This mirrors what we already do for
other optional TAs.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4181
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d54bb13772622..1c843b888475e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2214,7 +2214,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 
 	if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
 	    !psp->securedisplay_context.context.bin_desc.start_addr) {
-		dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta ucode is not available\n");
+		dev_info(psp->adev->dev,
+			 "SECUREDISPLAY: optional securedisplay ta ucode is not available\n");
 		return 0;
 	}
 
-- 
2.49.0

