Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3FBCD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD6E10E795;
	Wed, 12 Nov 2025 18:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T1+rSYPM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E5010E1CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phe4mMm0EpdG9NJa9fD7YYEkkilrHSO3zsA9+N5I2bxrCp8w4YmaYiV8dxqZ3EbYzSgqWvXhJ9n0JlmZaz6vXWFJoC7VAbx3WZVH1+xLr/ALYvboQOm7hqUFopSXx/FktF4JFYihvlki/kVhw53Arv1P/CTvOf5DRihONqYhkh4LDGdQS9RGkRpoFNoZiwobfaOQhKGDmKQiV+tRZkn8WoFMd/FSbubbA2StIeU40lhvvIBMLm83X7mp7c0xkmRUOevuRLQFwJqUZMGrdZvh3fIGl9Ju7eLb/+MJkfp1JRqObTY0pE6muztB4iC8lh3fW1ov33Z1NONQV2wDm7j4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ARVxiDeuVDnXSkzDV/wnhPBb7RlQnNjBETdk72qphE=;
 b=CYb2H2SX9XphzT8mNMYfc3ehVP9iUf6LaT5o2og0qLKqzMdq1fxhiBDdJnQYhfHJkGyhLDO+Ee6DCzEsG7v/q8J2A/V/g04wKQUqaTo1aUFQuDDI2aDk5hF2XmP55QnBtjHVQF6/SCCY1FO16nBtbk3qQW9lCHqXNeX/jBOrfp5J4Ak1OaJxL01q6YykZYCOjZhGcFCssvytd89l23YpHV5n2diPriHgWBBuvDJygcDR1cT4IIxwHR8WNdtpOmFPKpgxADm9+KfJV7BUOjAIP4gu2qz4R6qmIo62T36JZYpqKd1JvNAPFRTekJ4+Hc1YoXRoNFWPlZgFRRuSZPmKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ARVxiDeuVDnXSkzDV/wnhPBb7RlQnNjBETdk72qphE=;
 b=T1+rSYPMMRPL4rNzI2tvOPFwavDHafSrijFSEK6wGJDeyG56gcdeHE/aCZraPQHjh7ZFG0eeTYHUzupR3Wn+p1qHwbtUsmzWvFpkAB2Z1yBGMnnsChHh+MHl9MBUNlDV0B8jiGDryLSOHXf2j/RGvl/rOY/oqCC6D1LTUZHOhro=
Received: from MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::33)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:22:56 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::1e) by MN0P220CA0025.outlook.office365.com
 (2603:10b6:208:52e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 18:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:22:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:41 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:22:40 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:40 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 07/16] drm/amd/display: Move sleep into each retry for
 retrieve_link_cap()
Date: Wed, 12 Nov 2025 13:20:25 -0500
Message-ID: <20251112182212.559007-8-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f06980-b431-40d8-c688-08de2218806a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MZ+XrjkCKDF2Ox1RPq9ztPb6KyCWhAv1HJjOKqwHZCtqIKLGIZGu1u1OBah8?=
 =?us-ascii?Q?qrYUUcDbw/Jfdryb8m7x9yX7G2BhvcF1b/Exq+UFJMZaGzauj2x4o+oHLJUh?=
 =?us-ascii?Q?PME51AU98ukeI3v4s583GFPttMk6i7NRqaU6cB/o9H49swMI6dkepsrQgonh?=
 =?us-ascii?Q?GMsPKMaj6UNzowgPUAEvO6eUOqs8hlZebopm09xj1qV/1/iuKu6CNyEbelwp?=
 =?us-ascii?Q?BM7IoZiWQ+eEZgD35fP2CFKuNcyd9Sksgh1MubAJO00zWlPWIqQ/mJlY80QA?=
 =?us-ascii?Q?MnE1Q+45dp9YauGqQKySvX+/HCjcVANGwh62NPDmAX1ulM/o12cO1t5gCE+F?=
 =?us-ascii?Q?HkLKOpun1LmwEBfGKhS8DoS+Ed0q026joZkQojaxj2FI3KRifbei25zWODjF?=
 =?us-ascii?Q?lMYbDUWGD5sF2J9yiPhHg1ZHxHNw8Vu/IupIzIGB3TtLo3nkXQZs/pJyci3m?=
 =?us-ascii?Q?mP8cKAXzpOJpVIddPlt3AxQeOFRO4hO4kGZi0JDCY8OfDSJcCPvC0u0tAIY2?=
 =?us-ascii?Q?ZZjjbQPnrU2qCjemQbQ1XuITm5SYU3/W8udHdIinalCQ3Q6jxCfAizLXWJg6?=
 =?us-ascii?Q?Y8tqqnJx3RNSoMlCxMgr1vdrvVXeIDu1xE6wnlcBvSa4yzlzvdXFkieA5fWO?=
 =?us-ascii?Q?l4XqyobxmS3z9sXppNmBpuV/WnGOhbrq1qvjyS3iOmBIBch0B0rMR4gqVY+G?=
 =?us-ascii?Q?NRJmMF1aOS8t/PT76e8giBH3Q21D8yUgMjrRVVoLxjXlp/sFKqjoOVE/bfec?=
 =?us-ascii?Q?QG+tdoh7EogJ3WFk32xhIEA5lQMadG8euhZutJ5z2fY4KikiUU4HbkXWO3DM?=
 =?us-ascii?Q?x/GR84nOkq7PpC2X/+LYov1L8R3fX5E4orxlv6nqCD8GqSnoE7JJL57JrFO6?=
 =?us-ascii?Q?ymsVvPvnKt/0iQOboGrnS0N/K64U7H1GC5954SQCXRZxdPH5dSqMiy5G+F0r?=
 =?us-ascii?Q?f+ntzjSySfCxve86AqY6gTgglPcnJ6GuvRH468/IQJH5ZFC/G7x1klV4x8xk?=
 =?us-ascii?Q?D6xBKKYy0pmg/uZc9ol2A/g4OxP/8RRzRvVC/ULiCsfs8S/f7BM/RGqYBoU/?=
 =?us-ascii?Q?PbU0mIio2olFEtvrC9TKCxYaf2n/lCTmN6nXkt1U5BKxBNA2U8B/c7bbHk5w?=
 =?us-ascii?Q?paCu/jZ6yF21cfEpxfjrHkz29HPosb4ZEdmkm8McpbklN9WeFmUAQUEABGa8?=
 =?us-ascii?Q?9df6hz6wj8ga38uD16KQAOdAPZ71xpgZjpqJjGWs7emGE/ql9bhFrqG2cHlz?=
 =?us-ascii?Q?toOBBM2EJ8u0EUybcSEkRfD90zMxtypr4fMH/N0aWVffzikjfd6n7OCj9DGk?=
 =?us-ascii?Q?NFTpwbhnd7o1QBW5RINpckBe9BFMAoE5+lmBn7wTRbeeBLayLrXm78r2M+eR?=
 =?us-ascii?Q?CJodhFd3CL3p/HtSnP1zM/HIMuUfLfA9vxmJs9w7d1Nm7DDcmWjhRNhds0Cp?=
 =?us-ascii?Q?lgKs4PR6YVmEDlDhQ9iGQkfNQYxfC0xnqvSb9SptK4JAgy0SXL93zfY7dIUe?=
 =?us-ascii?Q?y2chN90aUuKyB91weIbP0VCTs+UzJKzcX6lE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:22:56.1791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f06980-b431-40d8-c688-08de2218806a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[Why]
When a monitor is booting it's possible that it isn't ready to retrieve
link caps and this can lead to an EDID read failure:

```
[drm:retrieve_link_cap [amdgpu]] *ERROR* retrieve_link_cap: Read receiver caps dpcd data failed.
amdgpu 0000:c5:00.0: [drm] *ERROR* No EDID read.
```

[How]
Rather than msleep once and try a few times, msleep each time.  Should
be no changes for existing working monitors, but should correct reading
caps on a monitor that is slow to boot.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4672

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_capability.c   | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 168c59bf1f16..a3f64509b131 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1756,12 +1756,13 @@ static bool retrieve_link_cap(struct dc_link *link)
 	}
 
 	dpcd_set_source_specific_data(link);
-	/* Sink may need to configure internals based on vendor, so allow some
-	 * time before proceeding with possibly vendor specific transactions
-	 */
-	msleep(post_oui_delay);
 
 	for (i = 0; i < read_dpcd_retry_cnt; i++) {
+		/*
+		 * Sink may need to configure internals based on vendor, so allow some
+		 * time before proceeding with possibly vendor specific transactions
+		 */
+		msleep(post_oui_delay);
 		status = core_link_read_dpcd(
 				link,
 				DP_DPCD_REV,
-- 
2.43.0

