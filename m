Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C24C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 12:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A7A10E036;
	Wed, 26 Mar 2025 12:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sfFMVDPL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DDF10E036
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 12:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scKoNKecxEpnCOoWVFkmxWxVPewA8w4SsfBIiAz49ElVw4+viQJFrLDnv+BnBQKkyoZE4ZB6jK6PDqknViOvDZL+b98sgMudZR6h1QspUJTE7PsQVuphG1KqGP3RKOEi6VyaOn3B6EMqVrrPg4LQkQK51+U5a5G57XW+7Y5THZRBn7enx1YWlYSw+EtkmT3vTIgaH3K5B6ZRhMWuYQKNdroK38yQH9Yveov1jmhdVZaXDdTWMc/6VcaaFBHD6NJ9OOtTPYSwgKOvzw/rRhJsuTmAgRtynd59HbPqjBRlrc8loJFqkaY3r8C+SXocxVsOR4Lhl65JlWXKaRdBkFfXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAV5hmfW9jPeccePCWlPxXdD5QjlsK5YMIwGBOsvDnM=;
 b=upPLXgjMxZfD9ho5TtioKEwtv0yuxVh/eL+A+fjTtV/ciAFjk1ytPMRr2K5qNBL5VYQG+QML5unstyisB3F08tfqmJDHm0Tvei/9llJIsgZ8A7XTNx5xcDW85BNXmC2EpzV38xK9fyAVE/6F/wGasDv/z9cR9PVTNOrJ2v08hJ9YcFbhB298uYhPJG8Y1j1a/FYXpmXumwcNnFC/OfxwW4kV2JBUMQL0x/OEr4Wmoc3DRCAQD/QDUJjwVukqKSKu22+O/SUNzE5XjDhGQeEEj4MxV4JuuCp//6wKmcqh6QG5THmZFIvnFLLJuwvhGYJBlnEyxC+A04k0TpmgR/Iq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAV5hmfW9jPeccePCWlPxXdD5QjlsK5YMIwGBOsvDnM=;
 b=sfFMVDPLp+alUuOY0AOwjz7h5VQvebjnef1wD/17qFNEpZOgM08BdYjVCCfu9656epMkS2FCjQvZEpjeWiJ5+80w1uJncvkDT+/oTUXOYlbPGPDpV4jPMpU4szjtal3hh1GkkGvPXUj44JV5l0LgBhkPqGlXQo+MMKvRvIduYN4=
Received: from MN2PR19CA0019.namprd19.prod.outlook.com (2603:10b6:208:178::32)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 12:14:01 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:178:cafe::3b) by MN2PR19CA0019.outlook.office365.com
 (2603:10b6:208:178::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 12:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Wed, 26 Mar 2025 12:13:59 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 07:13:56 -0500
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Flora Cui <flora.cui@amd.com>
Subject: [PATCH] drm/amdgpu/ip_discovery: add missing ip_discovery fw
Date: Wed, 26 Mar 2025 20:13:23 +0800
Message-ID: <20250326121323.2451998-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: d196f804-ea2b-4d60-d603-08dd6c5fb0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p9vTxm0mSt6E5cs/l9y4Ftj85IR5u6NT3OX4aTE59kZVoaayqW1N+s83A26S?=
 =?us-ascii?Q?tOSWWpxmpK9bUJu5MDoaUbevYXVLY+EED4WkNN+b5pvFBPqXdxnVXGBKCRXm?=
 =?us-ascii?Q?P45gOtCdA84n/8x7zUiHr0ieswxMnpEQcgzWFe6B1yP+aTV3F3Ah5uDTNSVO?=
 =?us-ascii?Q?n5xVG2pvnguFWkqLTY3rZcU6r/7Q7pM2DA7yG7L+6hYqOOX+oY1k7JnW25iM?=
 =?us-ascii?Q?Iw0XyChY2FQ1afwu18sxk8rmWqmTlf8OhEyRRT1wPXLsH0ArYjetcpyLRrhY?=
 =?us-ascii?Q?sqN6Sh6cXp1OhlAYKriimRbiej7jF3HJxY2aIh/WPt05WH1LgtrvN5UnjZBB?=
 =?us-ascii?Q?C/1G5GFZ66tGMf0er78aXh265AQlDQzCxOgMELLoRTxKRdLto6gomvCONgtJ?=
 =?us-ascii?Q?P3Lpv7YYfsiT0a2IFGANZSV42r75GWUJB72lpKeSMVFb6fU8pQE3NpPSaWja?=
 =?us-ascii?Q?01SFMCnpibMGXW0JjX9DFmhnl10nxN26W0m5eM/Cucqr3OECurFytrZDyi0T?=
 =?us-ascii?Q?TSi0/epDbymmYi9UtKCE8VaatS7yOdXqXwbLWEm507HUU5K0rqyKZk9gQzOQ?=
 =?us-ascii?Q?GhKIvdLYqveLn/+sTjfTXU3mbsUu8OP41HKZb9zNbTYHyzF0S97RxBh2z6N0?=
 =?us-ascii?Q?sSJ+kgN3M0ZJqHiUUa3dqNcWYZLhqDRP/7Es8HE6YUx/MpjaZnbPifNLXdOR?=
 =?us-ascii?Q?n9mCk6IsmpfRy5fGzOLvcUFwkZhNZid91wyQFm6bI4gwvbj8u9/Hm3gPilJl?=
 =?us-ascii?Q?TYIDX8nBWCoOJE61iHcsQcEzRU2wBXvhs3W03nRNaQc9JBXCzWPjp2ZRjSWL?=
 =?us-ascii?Q?tJ8sunY3UkA64yQSzyR9aygJRPFTjkgAee2CCwl9fB9IlBeYd2B5HGbMT69g?=
 =?us-ascii?Q?/Qbxn/eBb/o+Q6hxLcjPVSH9SNhWeAv60ssgSSEiNoYEezZz+MbETfrU9rQU?=
 =?us-ascii?Q?DweLFMWDtIrlse1dFpt2RMKQFNHbRzeX4QFF7I3mcDWsjvIkeOQDHRx/Ljbz?=
 =?us-ascii?Q?/WFar7vqDv9Wgwwt7gcD2jv8KE+MEtYeW2tKxaUzVKNq6kEBD9C7xwWB+Mf0?=
 =?us-ascii?Q?tADd6KJCXYjt8baAJJki2F6FO1XY7gf8/l61aGrzcO6/6Jk5MixxmRK+QE7P?=
 =?us-ascii?Q?/0ifWNU6v3Oq3SJUIwyWal4mpdhYQHKQX3dGp5hY9VJLGDCoKUSQ7hGY9awy?=
 =?us-ascii?Q?AF1ZC84HZihqV1rQuzbOu71K7PoPvSI1DSQHXaR36Pwdx2qVxUXzKOQ5xbx0?=
 =?us-ascii?Q?JsxGAHC5RBekULjuUgxHN0nDC8DZ/CZcRB+nDPGRjJQ5SuUHULZeIF5b2YZb?=
 =?us-ascii?Q?3vP9AQ3+5Rmp9GBtihChwN8BjQGmCiqRuTzPAfjjS+/rXLyyt2sPKoZMJ2lJ?=
 =?us-ascii?Q?USyZO0hTH+xq7DEeZNEatRZU/0h3L9T0IvLjvh7t/hWsTpN0aoZFc3YKTpfw?=
 =?us-ascii?Q?62q2KGy8aClIiTSDNSRvW/X16d3upFdXlNBvV/cQ+l2NhqJMv4Hk+T0uZlb+?=
 =?us-ascii?Q?UUivWJwU6Jyk1nyMpe4kS+kgM4I0lY15wEby?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 12:13:59.8577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d196f804-ea2b-4d60-d603-08dd6c5fb0b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index dc2713ec95a5..9e738fae2b74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -120,6 +120,8 @@ MODULE_FIRMWARE("amdgpu/vega20_ip_discovery.bin");
 MODULE_FIRMWARE("amdgpu/raven_ip_discovery.bin");
 MODULE_FIRMWARE("amdgpu/raven2_ip_discovery.bin");
 MODULE_FIRMWARE("amdgpu/picasso_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/arcturus_ip_discovery.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 
 #define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
-- 
2.43.0

