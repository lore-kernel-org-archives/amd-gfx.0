Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA907C3DA70
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8C910E8E2;
	Fri, 26 Jul 2024 00:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GfGujZAt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D3710E8E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 00:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjmICpQB5tguYk9UZT/wTSQP2weI65cMkSaxPuxGe82rmNfFqH1wmKt5sdsQ+0L9JAJr0UP963FvO3BZ8P+sgHdN0ltmpM2hguVCfSIAYejigkvs2f3WG0hi77RDYue+OmLeoE25YAUEUjlqWu/Vx/xhD5Lddv8qirJoqtuWe/VF4GZNvdYEsVApYkY+3p0lXX8GDrk9iWslnt5YRFafEQS5h8HrsnrU1IAxRYWpKLZA/oG0OnDfY8j4+HNquhjxkb+7PRg9M1nSrVkm1RdGIh45M7KUpO+TW2v/z5g5X81ED6D4zUQnZvF6MFaRiKaijmqEfGLJJcVjJqmBphk6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zfT//ipOAfhX7WAgTS+hcMgpaFnyX3/sV/Ltmf+Ots=;
 b=xMKRo9YDmtqy3DJOfzwDZQLSAazqWqIe9wXigr4ZS3w0aU6NGS7jpyRPE9h0toyUxC/T9vTVeU2RUhWEPDGcPuQasIDlicD2wQGIQQdMel5NhPz9r2/5KRMS358XxJsbxkGwKBikhZYm32Y7AmiOcAMh8BI1J85amS+AJA2wualDahJTljqRsx1LL96oHFeBtnG8QIKyEXYccouRi0776mFY8f9UnRvxFXnahklvVoj6BBMQMB77iGSiWjfDBP1Zw9/RdH4aF7bYd+vZySYaIs62zIUW0uvxG4VZ7d0vQBGc4QhDkXno5LEw24oZ8G83lPkFH2PEqIGubXS/Af87yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zfT//ipOAfhX7WAgTS+hcMgpaFnyX3/sV/Ltmf+Ots=;
 b=GfGujZAtWwmM0Kj5uuSKNB4cqi6kiHHZiQmZj4Wn9EOPlv4v+FdfkPf3/kZxYO4TYYZ94CyJinBC0MBjZWFK7Jvk3+4QWaCv3s4iuHc+WQw/9wvJ1egXPQaWESSPiMh5fky1U3oDYjpS2x3lu5whOtnw6fKFCAYYygTXA0vlt1M=
Received: from PH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::32)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 26 Jul
 2024 00:06:49 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::c8) by PH0P220CA0019.outlook.office365.com
 (2603:10b6:510:d3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 26 Jul 2024 00:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 00:06:48 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 19:06:46 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: do not call mux_start_ib on high priority rings
Date: Fri, 26 Jul 2024 08:06:29 +0800
Message-ID: <20240726000629.2558379-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6cb3ff-1b2c-4117-d91d-08dcad06d82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4N6ZYCroDPs+USSs5HWF/xkYQRQ4z/FNW4Wo8Pot6rq/fSFjZ9rWt0prXN5Z?=
 =?us-ascii?Q?3i/s0OAA3rAoX11CQsnWRSkQI9XhKjuBW6rJbAhaPIZ9nSTyMZ0yNkix1Dsd?=
 =?us-ascii?Q?5+1BUjOgmcI5M4Gi+cmBTL6e8xgRnr2FUS+Z/8FFrs7PDzxI0UmQu7b1SGNm?=
 =?us-ascii?Q?LoL/gnj2f95UNOnh9gdGLOZFW7h1boh+ZTa/y5oYyfP1wxEqmFLCsMrwuSnk?=
 =?us-ascii?Q?AnrcDRNRZVpxZMz1FcflRkF1H3Nl9/vbPMXHpbP0g5SfYis5Ouszy4lYlsL/?=
 =?us-ascii?Q?9TY8CB3jVbNWqt0JVnFvM5JmUEtneqWzsHwCKS8s1nJUGRgAsPZkItXWd5tR?=
 =?us-ascii?Q?oV/KgplVbZY6Bcl6bgW5UoEbrPduKwWBSytCKYjNCRIhLlPzjLi2smln4Dqs?=
 =?us-ascii?Q?9DNlNW/GvKYaix119zm9xS2DTRjJE174QtmZ3wXQAbOOGWNZRDPWT+8i+x+f?=
 =?us-ascii?Q?CCQ9XFv3jxMJFAuFqvl7bVaBRDjym6wHxtrgyilKyotkoGxneiv6/R+/h9GQ?=
 =?us-ascii?Q?vgq5e3iU/IGeMcUFllVbmpIcBZtUjWH9vxqeniK2s47r3NtdNISg1lfWq3bH?=
 =?us-ascii?Q?gII+QUEjHrToD8DGE1gJjiDBzkyVdnyNQjCUfp5z4AUjsAv0KPjTMs9PiWp8?=
 =?us-ascii?Q?HIf8qdeu9sfakP6wRrE4mvQlCYe06YKMEGPd7GwRD8jlYcR25nl5aiwv7qEz?=
 =?us-ascii?Q?uICQYXHQolm1Ft2aw5q2cGHZr9zyNgMxNIycUQj+Ukmm74ZZVT2BXMy3NNv1?=
 =?us-ascii?Q?7/jXD8pCPSxOpTmsWteyfRXLH1FE4B+ldJR6pchwe7uww58cvy8bLAxwb1nW?=
 =?us-ascii?Q?LXWMAIT4qgHtAJHssRx6AyVYCnUYW2g5fADRN8I6Xh7lawZBXeKH7ex03I5Y?=
 =?us-ascii?Q?fLv2nJf/1M6yKViId5ioF0DJbDZadYxx/YgBQFSp+XXEh0S20IrqiU3f8yej?=
 =?us-ascii?Q?/yD4e2tZY9O11qROr72N2b4E8aSmnMfH/g+yDIR7KtBPkaAPIhYgCsJCY6Fa?=
 =?us-ascii?Q?j7WTBVXjYOuqFeUNSXbv4dFtMbYvB7eXV+wnHXh0YBDrNt+bWwu8zASk63yi?=
 =?us-ascii?Q?q/mEAQA8GB6elBIu144EDGES+RAUn+S/omCiYA03bHLlS08xR6VCDzl6nvkb?=
 =?us-ascii?Q?R0LkcX3WTm0NwzcG3+xB+tnI3D2c3EXcR2J1TK/H4ZY6LqBxKE3/EC5jZmly?=
 =?us-ascii?Q?FfBak+E02lman8gWlYIlGTTVZ4t8UsJA/45uxZnBc+qvOl52gTo1CmooDcUt?=
 =?us-ascii?Q?SHGWQ99n2nhkPz0uyB09JUd5EJ8a7bzPGR679z9upXfYqfHvYtgKoB6rrMIf?=
 =?us-ascii?Q?K0+TxIZis9wWAtgyGFks6VE50VKF7hWiAs48RiaI8AKqjUr34AYcDOPzMZKw?=
 =?us-ascii?Q?luqpCzcxQmziUCqhxeaGpYriQh9EEcaTBYSRcDpZ84wbIYDI8RC8tPwU++oR?=
 =?us-ascii?Q?jDozGtOHVSY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 00:06:48.5585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6cb3ff-1b2c-4117-d91d-08dcad06d82b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

The function amdgpu_ring_mux_start_ib shall not be called on
high priority rings even if mcbp is disabled. Otherwise there
maybe leak from the chunks of the ring mux.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index d234b7ccfaaf..94255c18509e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -395,8 +395,8 @@ void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
 	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
 
 	WARN_ON(!ring->is_sw_ring);
-	if (adev->gfx.mcbp && ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
-		if (amdgpu_mcbp_scan(mux) > 0)
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
+		if (adev->gfx.mcbp && amdgpu_mcbp_scan(mux) > 0)
 			amdgpu_mcbp_trigger_preempt(mux);
 		return;
 	}
-- 
2.25.1

