Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887FCCA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 09:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314B010E2F4;
	Tue, 26 Aug 2025 09:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8wWqcvt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D735810E2F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 09:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oY/KA8vrz5kj4UTOpcTN6hyr0dsSO1N2ZgkcgWqkcSLzBEZB9BmbOe8PFphZI1aFxsYgMguFY+ZNvoALf8x4vi7VD78eXJm7nseRkHxhsV+6bJubMjOxrGIsYFeh8dhZYPgA9n6US9xQItzpzmg8YtmCY27MD8DrmLGpRXbgFamXTRrpdR3O2vmCeDg2r9l9rec+W44JoBAmO3L+AAxj5AY33+GsOFovHFhu5//2PFvlwf7uJYODgO/QFbI3fXyR8KgakW7PKezsy1wWoOzxwkamg3mZ/oXxkUAQxLWNP8nRZvdgYS2hEL/z0sNu0I/Dqbad/TZ3tWVGNBeomu4g1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jiup2OTeWJwXB5stMc7z3+NscqsfM7Uf8Zl9RzTFRFQ=;
 b=IMxv/vyXiczZCuIKwdUj3MkYi6lvTfNKn/Qy7HSu1LH9PiznICP6B8oRtc08WsmOv0gZEYPHfJRg6Yb4HdvkqknI4pfErWtavOBthvsuT67ucYwJCprTNxNP4Pu44JUa48Ym0XDioDLQhr3lebUMtZGCjl8bdVqkJoMiMqPoAs01C4+y/H1NKDYXShIVP2rVhx8UlHbuvMXeHHc8hn/rfPz28NO9Jan3Gcd91rPgJsFfQVmt1iuZmgPiU9yr1d9zHfmDobF0lJFQMWNEzyHR6tjFdXtmWDDrrKneHBXIsMTX6ELZc/0JB7Ot/sjzM/9kXYe4eJjbRQApy22Wmsew/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jiup2OTeWJwXB5stMc7z3+NscqsfM7Uf8Zl9RzTFRFQ=;
 b=s8wWqcvtubqx5DtBmchrhAxABrK70mEIQqD+Fepv0w689ST4po/ykgrc4lIUpE/6c5vxHfdWLYHQ+dJN9NhGNSj9b/lHfmhbri8BioHjQBboHVboLEP6ryulcD58VNm/gm0E43sJHH8WPgTmyGEJgpqLHzw7hUtHKint+rYd0cU=
Received: from BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 09:41:45 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::9b) by BL0PR02CA0135.outlook.office365.com
 (2603:10b6:208:35::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 09:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 09:41:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 04:41:44 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 26 Aug 2025 04:41:43 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update firmware version checks for user queue
 support
Date: Tue, 26 Aug 2025 17:40:37 +0800
Message-ID: <20250826094142.1750970-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 80319956-8992-4a7f-03b6-08dde484c529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/SNav5U+slWpvij2N65Qk3NKciO9hc2LbVBZY94iJfI9NoNfNso6Pyje/BWj?=
 =?us-ascii?Q?GJ0PYt0dOBfyPu5UiiKCzz8UEMxzBjjRv7cfnAxzala8Xew/BKoxX4YvyHrS?=
 =?us-ascii?Q?IqU4Wyh5d7txUnq3sEMfTNCLsFXXCuHnd8WGwmKPvX6Vh6F0KdhG8TPyNKSX?=
 =?us-ascii?Q?sI/qpIyr6JTPcwC1+/2kX7UgYVYEpZjy5erXHnv8LDGcdFXwRI4yA4CrNhU4?=
 =?us-ascii?Q?fNEfIN4ZjBHNgC330MvLi4ZWngv7+B6BtWO1mPlvm0aRrF5Y9CJTypqMV1cq?=
 =?us-ascii?Q?Rmobj3Ko03qakGYGLtmUAdU3kaLYcBSFnCkpc0sDfiu8EbtC4a87G8E/GCzn?=
 =?us-ascii?Q?9wvj+4CH+76GgkkasoUqZRkU5zQ4HdUOG2fTFIZ25SUl2G5/CUZ2XWqIkgaE?=
 =?us-ascii?Q?3o+QNoqnjwU+r16KRNV/oloHxKgkGC3dpi5M0kNvE6qEQtRtakcdgCu7kTQv?=
 =?us-ascii?Q?li/iSSql0R0tluOXI2NfvaWxeNhFZlOtvFhRIIWQErj+V3IhGtUm4FpgkKgs?=
 =?us-ascii?Q?S3LCFN6DCBtmoGF6MO2TGEvg4YtZsn4Tuvrlhl9RjMk0nAfZaPLZCVPOfB7R?=
 =?us-ascii?Q?Wgh8lxaSD/BnnBLh56TcmhJ3bxhl8ri3Q/U/8iWo3FfUWmoLPuiR7vi6vUqg?=
 =?us-ascii?Q?9KatvTM1llqFTxKSRGp2ueFW8X6lrS+kN1Dy0jZwf9e7Vsq0Ei8QcQsgNhJ1?=
 =?us-ascii?Q?qFD8/JBozCIS1JP5j7Ju79lsizJWv55tLTvP2YJfQN5g2ozCEX5H/1xwK0j6?=
 =?us-ascii?Q?ocsjSkvbY0AgTa1XvM+LMhXF6DuXsxUe60OoyPhRSd5ds2IBaDT4sxu7CnzM?=
 =?us-ascii?Q?VrYtD1QKMCjvFy0Y2TxkL9OGA3atWUp8VVuUOy5Oyr4JA5HIHFwyxTxuLx/L?=
 =?us-ascii?Q?e/GVjjvZUiDe8aQ1oCQiNDl5RUXhg0g/c/y/8Rs30cLs2IcPZLoHMoXrAMdq?=
 =?us-ascii?Q?Mgymw7e10esQ+ga3TyRfsWzM3XDYHSQVMeivRaYw8eBfMFuxJqXG0dRd/bkt?=
 =?us-ascii?Q?fTnmU03QTuI4n7z//cqBw9M4s1K5YNgwQNKFC9pYJM7Wwj8N4RQX3+BDst83?=
 =?us-ascii?Q?Ahi6mctonvgRbjPfF1v+aPuHMr7egLqyY/IT6H9cuDtZ4FZYXX0rtuUV5uh4?=
 =?us-ascii?Q?JsVwBDx+E8yCECZ54sJJA62KBTHyyyr8UENwc3+WMqWOt6Jly0x/4l3r6SJH?=
 =?us-ascii?Q?sI6k6SWSIOFMU4vB/zmW09HHwgrprkDHbZmvbsmD1yEbXEdHOIeoUi8NY9cl?=
 =?us-ascii?Q?C/7ZD/B/KCZML9ZcTnVa/heR72GDyJDUA1dompP0HAcDCwOE5/xu3zdbACb/?=
 =?us-ascii?Q?kfiXZCznbNdFW6Se+Fey4HQFk8biCGYRZ0bgixW6GQzEALhpO1IMhYAjUU/O?=
 =?us-ascii?Q?s7GUYt2pdAnL8PYMu7tCe0SruiRAXpemf74cojzomKrowkUMfJb1HO6ADce+?=
 =?us-ascii?Q?hbcMGOWGhxtc+VFl+tTDPtrDPjxA1p4y0VgicjRaig1JQlP9GeJOU5/1uy0G?=
 =?us-ascii?Q?CfwiP4q+Jq9CQJaOFmT9ivRJp4dqT3ToJOo5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 09:41:45.0671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80319956-8992-4a7f-03b6-08dde484c529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
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

The minimum firmware versions required for user queue functionality
have been increased to address an issue where the queue privilege
state was lost during queue connect operations.

The problem occurred because the privilege state was being restored
to its initial value at the beginning of the function, overwriting
the state that was properly set during the queue connect case.

This commit updates the minimum version requirements:
- ME firmware from 2390 to 2420
- PFP firmware from 2530 to 2580
- MEC firmware from 2600 to 2650
- MES firmware remains at 120

These updated firmware versions contain the necessary fixes to
properly maintain queue privilege state throughout connect operations.

Fixes: d84f90e2bcec ("drm/amdgpu: Add fw minimum version check for usermode queue")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 456ba758fa94..c85de8c8f6f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1612,9 +1612,9 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 		if (!adev->gfx.disable_uq &&
-		    adev->gfx.me_fw_version  >= 2390 &&
-		    adev->gfx.pfp_fw_version >= 2530 &&
-		    adev->gfx.mec_fw_version >= 2600 &&
+		    adev->gfx.me_fw_version  >= 2420 &&
+		    adev->gfx.pfp_fw_version >= 2580 &&
+		    adev->gfx.mec_fw_version >= 2650 &&
 		    adev->mes.fw_version[0] >= 120) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
-- 
2.49.0

