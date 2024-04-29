Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198A2C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E3611255A;
	Mon, 29 Apr 2024 14:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gz9KDJ49";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B5A10E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO61SmujMy5Y9qNu7i37/uGq3em76zEwlxzvVCbNsdKB9PAM2zymGpNaMMozKbVSdWa7fIBSDe95XBMk51HvhdYCCyrsoVpfPKX2cr05mDBT6UorJJfpCiG8MDR0GlOFA6alypqu2aSBGpXCyDaG/a/Z50bNKsw+Jgp7NZlteoAt4t0i0neiUXGFIXr32XRLPGSt+SxJj7sY99e1Lu4ELCU+NI4l15kZEWJhsV1ACeL0pKfglsKhNxtBbqsUDoEgDPwnwSF4rWDF6aS9sDEsQ1aTHgY5HzpEy8vfjiHWgkkAYgi5K8f/y+boWRhh9G2fC5LZZMNYdmG/aMlpGx+IJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGrsgT3ibWjOo95qfdOxnuwX+lXQjULVhBoyMzYKNLI=;
 b=fadKs7gGNRyKuHHnwHWto1NbDX6wJypvnlp0buCoXCgR1j0pF+60Z4AeVjb5IY5l6ruHnu4E/jY2CMcmtg2i/bbi9UADfdn+tqQaSIZtDmC4/+6t7gmoy9w4LOWV4JMkhXqVz50iYCNvoimwhuvAyT1PRF5NWOg7AkChkioFJK5zM9h/7jqBcsjA6M3LalShYUobWRGOjYjUKDxLX+9b3GhaKgyP7ypYVo3M9BtMsK09AONnaIIc8OWpSR3NkY/h0UUEwXPs0NDGLZmaWh4hFfFGRR3bMQe03kafDYdEd6lnLQ68khC0GGZ1Ni42f1SFklQfTUXoeQDAKmfdYkVDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGrsgT3ibWjOo95qfdOxnuwX+lXQjULVhBoyMzYKNLI=;
 b=gz9KDJ4902bY76WtwOukkhLXT06XvfIf3WQjf6HTjDUEqUsCey+IrL+4WepB0w5S+vuBjOJ3yp0Nms+kgjIjn0hsr78vyTCOKNtoUtnTt3QuCvONGKt2UJNHSOlD3vW4WorDFZvp+QUKMJ9WPoQu9lLl61ssuWanH5j1E3joo74=
Received: from SJ0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:a03:39c::10)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:01 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::eb) by SJ0PR03CA0335.outlook.office365.com
 (2603:10b6:a03:39c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:33:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 01/31] drm/amdgpu: Add gfx v12_0_0 family id
Date: Mon, 29 Apr 2024 10:33:09 -0400
Message-ID: <20240429143339.3450256-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: c84da82c-783f-442d-a5a4-08dc6859696b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1DOaIPw2eKhS4R03Qvgk9WmNQdMtf5w7DpLAZJTl5j656oGCXfAtLKT2b3/A?=
 =?us-ascii?Q?auhFPzwBnJET7vPmk7hnEEP63T8dDT4InWGiuSuwxlaFVXORfxJ7PSjGPC6Y?=
 =?us-ascii?Q?+cT4syM9dWYTAP9jn7Msv/XK7QzXveiYlc061jxowiQULMn76nJvzw3gJHC1?=
 =?us-ascii?Q?Ck8oyZzCUGipam062Zxmof+XYF8cmakEMVTnOvY+ao4D5eYFiRfNIbBg4Xr7?=
 =?us-ascii?Q?HwMO7JDkDYz67A28Bjjde7NQmYkeoqrbyCkf6wlFtkjbx13K3Ei0c+Vnc+tF?=
 =?us-ascii?Q?pAwiQfSans+3al2Fj53FIFYqMPS0AGYq18V9DleFkW5aZDvU/vSaiCUGTeHr?=
 =?us-ascii?Q?unLOI2eJnUe5V3AXfTWptwUqbE+8vqZxhnEv6ytmNfOET6zSt63a87XR+8Ea?=
 =?us-ascii?Q?GKUlgp4QjxzZKBLsSqy9aI+AIy373Hcb3pNMu9Mx6k4k2wUI8ZEhmhpjRQEY?=
 =?us-ascii?Q?wQbTjoebIdp0deoe32shCZm1yrlZm4yPyUdCt6ddBNwopa0H6+8itBtYncE4?=
 =?us-ascii?Q?NCrSg1moQADeemyN33H+QSmms2d0Udu97qA6k6Ea207buM0GJniEGTyjEHZY?=
 =?us-ascii?Q?xbVIuS84UUqKc804VRjcceIS42DuMlcn6svf58CtynUDQOHy25sEGB7yidDk?=
 =?us-ascii?Q?sX70JKFESBPecrjqMBhMvsYJjGoCVOckqWIADExUKv+OQy5jpcPTAIcA0QT8?=
 =?us-ascii?Q?38S3I9NyUhwZuQ1AanZebZwYNP0nZQVWt0mXU/xNsfKLxtbZKsa0mPw7rocM?=
 =?us-ascii?Q?noJK5Xy3VrdhGhDDta55LUq80i7J6FM14x8qqwPSYRl0Ghl0pnsPldZ+yHKq?=
 =?us-ascii?Q?yydAWFZkW29vvJcDFwCJWhHnlMksLQd1cqS0zhR3EjqWEGP+JgSMYivCJUaQ?=
 =?us-ascii?Q?IHBn7gA+9CoPrGKuiWsv+reG3noUzJ8x78DtRvZim1JNzHTU12QJFrc29TTA?=
 =?us-ascii?Q?r8yv/NLL0zvJBLpH3CBvlRjV9Ahm8L0//fiP4/r+FtPfJb6J6Modc8Smo7SD?=
 =?us-ascii?Q?XtwQ7FreTM9BOd8qvAFiKdmt3UOVbF5p27cIfvOyMtqxoOQ+zIi7Wti/Dp7G?=
 =?us-ascii?Q?0M0IXlrUIx8dG7eKuI1OjbhSV3zltgUB3q2aJFyRrYLqXc4PuIxxqAs07M2d?=
 =?us-ascii?Q?ExWJ17pNHIJ7hBYUGDFP99e1FHJln+EkT8d4PeJ18najDoTMyF0Aah0QYdKm?=
 =?us-ascii?Q?ehY9sXLJlRC7CxcNKdNWytEOHd1v97S/0LCjKDKC4h2K97Hbgk4PTvU8T1zV?=
 =?us-ascii?Q?ZsA0AhVpRthK9XV8KneD2LLz4KlzGxngugnUAGhTNYpZEWhnr8kUcRxq7sh6?=
 =?us-ascii?Q?Cwe1eVDsEruKDsWCvaZU5JN9eqPVHCerh5vEDGmbKiaIkL7lSO4CKfXrgS3o?=
 =?us-ascii?Q?IGGeIBtgiY+pTQMj7dk87Ov2DdH/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:00.8558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84da82c-783f-442d-a5a4-08dc6859696b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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

From: Likun Gao <Likun.Gao@amd.com>

Add gfx v12_0_0 family id

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index feb47623458a8..5b6c0055cfcf8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1279,7 +1279,7 @@ struct drm_amdgpu_info_gpuvm_fault {
 #define AMDGPU_FAMILY_GC_10_3_6			149 /* GC 10.3.6 */
 #define AMDGPU_FAMILY_GC_10_3_7			151 /* GC 10.3.7 */
 #define AMDGPU_FAMILY_GC_11_5_0			150 /* GC 11.5.0 */
-#define AMDGPU_FAMILY_GC_12_0_0         152 /* GC 12.0.0 */
+#define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
 #if defined(__cplusplus)
 }
-- 
2.44.0

