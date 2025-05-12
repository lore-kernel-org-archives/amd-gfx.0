Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09613C3ABCB
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 01:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6034589E36;
	Mon, 12 May 2025 01:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O6Nemrrf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A15E89E36
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 01:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOSuL8M3XJ831JGEG2sesJcZ2azQQKVM5k0f5BWfYL93xxuIfTrDLnq+az9z5xwe4i5e9BS/0eKRMEIwpEkhmyyGfUQyP1adBmF1Z9III6NlVBFd6BmLS32w0DUGEu3JqFsQfLEwCHor9QoRhN8MZaor3uY6A8Nd6ASqo66VtSmsCJZsNz5EaM0bT8tbQvMF3I+Ejn8ZX09lcd9Pbzm39cwzRMudrPh/8vA+5KhmE0gWLW56MXQP3OrDIZJ1mqh17uU4EPJizYlY5cvtJRfAdYyt2AkWD83ElzrmX4UU/zhlWZazJ1euAugygbQqsP6Sleu5356M8w8PsNdSQNzksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA4iQ4rf9qoIUnbhrn15vtVOaITce8WCJtBocakm0Lg=;
 b=NM+DoQmUHSpIDGXtyGe+gl3HeVg+Da6KVDKf/t6dGQrE1W2m8O5l0fNt8MaUUQQ77kCysKFx2PnQ3JKxac6nn1kCsyibBEkDSxIt03VR96L5TWSxx2FnTo6UIxCysrLW1Bic4dyzQn8qLxkY7+RqNtF0tnAhgY9bArLXzrcE5lrnzbdwPnaK13eB5Na0+aWAsLieHCXrkYdsOpxJYAQ5V3sIkXgIh2UFjW9WJZaBcWQvrciDjtgsLVY1dDjaUxv6wg5UaimPDqZZ5dgdqtRpDiOHDE6rqLYCECnmtPKrPbA848gePzLfN4GFNiHJ2I+0NkA6uE5GRVbx8X6+jQj+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA4iQ4rf9qoIUnbhrn15vtVOaITce8WCJtBocakm0Lg=;
 b=O6Nemrrfbk/w82nu/jK9wNtbGbJCAUUW8kb2jZCn0hZq31AJ7tUeAbjSAlF20nO7o1wPpdl3bQY9cMw9BE4lXAEkXxqYy8yrLWEfwsA8pCmoOMjwrku3b7DdmBaNWDke2D+W8bsBWnf0b/FWirbQ6m6cdA7Y/LKM5bGYHqC9QGc=
Received: from PH8P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::16)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 01:14:15 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::7d) by PH8P223CA0026.outlook.office365.com
 (2603:10b6:510:2db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.29 via Frontend Transport; Mon,
 12 May 2025 01:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 01:14:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 20:14:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 20:14:13 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 11 May 2025 20:14:07 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add GFX 9.5.0 support for per-queue/pipe reset
Date: Mon, 12 May 2025 09:14:00 +0800
Message-ID: <20250512011406.5272-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3d1bf8-128a-483c-2736-08dd90f24f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AFnC8vEtRQL/V9TTdIq6oqKmRBrqIOapfrKaj7wrxliC/pAMOtDm9SK3T1QL?=
 =?us-ascii?Q?Te8KgE2xWYz6kE1ipNcVWcinWbJrItjBn27svYeptfwbMHAumRdOjLs5fpIt?=
 =?us-ascii?Q?RfpmgFSHf+RAkfRVB2y02s9QREMTBz+PH6TeAUkKFKnYhBcfNjR7tmMKbOfI?=
 =?us-ascii?Q?1bv4fAKn6ycVZ7F2TVZs4oAUjUqzVo27Jv92oQduQZ+/ESrK1BOwUh4BTd7H?=
 =?us-ascii?Q?K17wdtNcu81tRTU2lCRqSmgXqq33MS/m0g5kRQY+qRBk9k2t53+nbxudXifv?=
 =?us-ascii?Q?tV/SlKnL7lT7dRjXKVHpr2a2lWnryedsjIRNDISxf4Hx4vtCBFI9tiR1de9s?=
 =?us-ascii?Q?W+3tvVeFg+gt5Zp0cluSG3tYBNpvDGp0oWk6Ydl0XI5Mz/JzHshd3QtcSSj+?=
 =?us-ascii?Q?Ly7CfloaNGHvTi0VIe7fi20RqBoyGxFAQKNXAhXPR1geIhfXGMZB+IGVUt0D?=
 =?us-ascii?Q?SSPnB+A7fDMSErGILnJ5Gy2b7CrN929EyyASemJCmeNSwsA1lHctO81dng1G?=
 =?us-ascii?Q?Q+bR8Iz//QTJ3MY7caonQ609KOMiTBn12rGIc0FWAq0ICmEf08I8fyOCSlqF?=
 =?us-ascii?Q?pDDbr/cu7ftA6nOGEl5QiBb5fnQyxbEm67d4Vk1ms/7BxrioLCsF82EiMWx8?=
 =?us-ascii?Q?AKkYzs43Mw9NhnHO7tloDozhZuX/uN9KtqdI+sJ0NJjGwXmsTd+75c3NOpBY?=
 =?us-ascii?Q?oHJw5u5a8ZwRJabam2v8SmK6vJvUikv9zMQkj8vIiEPLKmWS2Kg5YYjdD+V5?=
 =?us-ascii?Q?rSLPqTcHfuqf9eo4IzodLZ9nXEK09kGzreToK0m1D/TYNpyaFACwDzorFc6+?=
 =?us-ascii?Q?dBOoTLVoW/vnNAZAnB/LC1pgcGGwiNF5GZAO56tpFqmjvdh+wkUYraStrllG?=
 =?us-ascii?Q?P/02YyNRN0QzEWEix18tblddwdKG3wy2NuxV6hsg69cVQJlPURc2tweQHnHM?=
 =?us-ascii?Q?0xF2QZJJrbJyJbEEOU9+MusphyrjcpjooX6IcCqmpgvUN8XTYXQrwGzOFACv?=
 =?us-ascii?Q?s6esSKfuP07XTxaQN7kgjLZ1vp4kOWkK7RzH4aJKeS1kokZzjguvzu63K9oc?=
 =?us-ascii?Q?Toec0iEe4Has9/kvzfv92yMOKrjX/c7d1PC9FzeIYHUdPWVWU+ArcCqRrPzJ?=
 =?us-ascii?Q?Jb1/Eqp+xaT0OO7MKMQmofVPELAzvkWEuA0ooUaz7u39/ioKU+APr5bd5nkx?=
 =?us-ascii?Q?vjBWb9pwtQnisjtoaq8A4ZMp98D8vOGR0l0KY7CNJWXdb8WLjc+h7z7T6AW/?=
 =?us-ascii?Q?2xidtYomJGG5UWsQurmX+bMo4goMIFJAxktR+jI9Hg3LQlakkteKjGJwC8sC?=
 =?us-ascii?Q?nLYWsYmEmvxHDIiTUfQZ6HHC3SqPn3ho48bblfoR0oWKnzNlAqBf1O/sj0Sk?=
 =?us-ascii?Q?pbPJlCDXKZ/IS9DZL6rJeEzgsxICl5WwHdDDOUS6lnKPOnQVnKsqvaAf+RQD?=
 =?us-ascii?Q?ruMwnLNFbTYS01XSdI5ls+wkAx/snji3bCuCquBxOcJEs6E5Uu64qBemwLJD?=
 =?us-ascii?Q?qa39jbIKwON8esDMN7PNOr9bzYayUjuCrygi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:14:14.7218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3d1bf8-128a-483c-2736-08dd90f24f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
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

This patch enables per-queue and per-pipe reset functionality for
GFX IP v9.5.0 when using MEC firmware version 21 (0x15) or later.

This change:
1. Refactors the pipe reset support check in gfx_v9_4_3_pipe_reset_support()
   to use the compute_supported_reset flags instead of hardcoding
   version checks.
2. Adds support for GFX9.5.0 (IP 9.5.0) with MEC firmware version >= 21
   to enable per-queue and per-pipe reset capabilities.

v2: Replaced mec version check with !!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE) (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9db2bde5c59d..e6d516b1efd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1153,6 +1153,12 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
+	case IP_VERSION(9, 5, 0):
+		if (adev->gfx.mec_fw_version >= 21) {
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
+		}
+		break;
 	default:
 		break;
 	}
@@ -3452,9 +3458,7 @@ static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
 
 static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
 {
-	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
-			adev->gfx.mec_fw_version >= 0x0000009b)
+	if (!!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE))
 		return true;
 	else
 		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
-- 
2.49.0

