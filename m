Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9E7CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 13:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336D210E8B1;
	Thu,  6 Nov 2025 13:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jegeA0o+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A6210E8B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 13:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCTnKIAOx+dB24N7yT8hcWXjwWE+PUiZjgAJMMjB+xWFapJdJ3m6epaSBCgs17kKeWjgpqzRT2E2rh5MMywQwcYy9fF75riGJhd1kOO7E8Nc2PIPCzvpZ6MVGFu7X/xpIaWEOrmcke/cYkzDihx1ZPgJZPcS5uhcGhTuztvQqg8KTLW9H4kWUHJ82ehFqsI8jFFQK1V2ZItzUgYgSNgDTyINAXic/AJ5JIJSl8lMpFExksNjNdRW2HIOQWYLZdyOcAmIEs3BGt6h4J7lIwGzKaGs+0dnnlxbtM9R/fiMR60QVTMTvGdrT94U8+YprxXL5V8ruQJZnnxF20CWkhCFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAL2qtzsG+TIckcenRo7AS9xETxVWk1degmVVNl8tMo=;
 b=tmYQN8mtLNRh+QDsCvZ9h7feYTjnGFmpd67EOcRdOBAJOcIoX9WdwN2h8Y7CBzgWnsl1CQU5s/LZyFbJarGOl55MGoFJ4Y+Gl6mptyCcZCeGjMZB21rUrkLM20VQRVDoeG89Q7xZgKaMdYu2qGPpz+89CUQ3sGpp/fOW4sNBB3thn2x4kna4WSK/sdAWGZSIQLSgIQc1NN7eU7F2VU4G9pNL7FBtP8aGRrKEZQbbV56urHoduDqk1r7ow44eyzOVCtqKizXBZyQkCYZaN/T/O7FlksF2RMxZaNQQw/pcLB5kiH0iRfB1PtN7cZizdDoTNOdl/XsNuhY+OksF+t5bnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAL2qtzsG+TIckcenRo7AS9xETxVWk1degmVVNl8tMo=;
 b=jegeA0o+AQa1OZ37G/RsysRzA7PHIfz7uE8x0+7fRyAbLQP+exKWqWAfxNc1twOG+7uc5KffPQNvqeTlM0CT1JTpkp6vE9CQFIraY+2YGeAI5nr9BDoft9lmZD/Ecn5QOCzZUGaMX+0HGtnp4hfUGQCGe7h5/Dv6YH3WOChGaY4=
Received: from DS7P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::20) by
 DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Thu, 6 Nov 2025 13:19:10 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::dd) by DS7P220CA0050.outlook.office365.com
 (2603:10b6:8:224::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 13:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 13:19:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 05:19:08 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Check if AID is active before access
Date: Thu, 6 Nov 2025 18:48:48 +0530
Message-ID: <20251106131848.943373-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS2PR12MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: fce21eb1-e0a3-4199-a40b-08de1d3712c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZWLTBRb4Pm6ctuwdetPZRcN0njRxypTUI53eGZFBCZyvEutnttB9CritIiZM?=
 =?us-ascii?Q?pfZDUpWusyRkj9NKZfo++XqW6Iqmun1rwBP5ts5ipielheSQvf/gP02liqZV?=
 =?us-ascii?Q?dwwNGrW1w2aFYihJEPADIj33wN+Y/FG18hUVpHOO1I2ctu9zjfitZUFFwsaq?=
 =?us-ascii?Q?azRVD7/Ddl+9hXIX/eSCjwqejT/rCzErWW9rBGpq4YJBmHZEasQXWNizyT7l?=
 =?us-ascii?Q?LWcSX0RKTkYlHHNtRdVYZKtWmNsHlDeqHdGmY0cgP8kD24yTSenH515eMuXi?=
 =?us-ascii?Q?V8g6VGZT+tlk3N5xbkxJGXh86AVKypESpbNVKRSA/f2QYGrf03cncx8sTgrx?=
 =?us-ascii?Q?Cb2rxx2ZjQb4lwF0R2poo0WFet486sqL9JpkcjgKDLPn0f5mlhqd5yOQ1bHm?=
 =?us-ascii?Q?sC6kJlBmZQI53qbHw7nFPw8R4NEdvd/7x4/iXM9mJfea7mJwpe0hYXz4dblo?=
 =?us-ascii?Q?Y5bjPKaYiiE9vwRbBS5EioU+WxuR9djKFWHxpgQ6a9WMB6a6x9x5TnjSEmxr?=
 =?us-ascii?Q?xivCPBECqa3J4MkDIQjq1FesBZTO4rZKh0Z9to6lV82AbMN51QYm/J3WfGjS?=
 =?us-ascii?Q?Mg/h1yxHye7WGpPDTnOxsLbh0e5GmCLXyErcxSvM1AZx57q2LOmCRZPFy1ar?=
 =?us-ascii?Q?O0lBjdRrFSdBSAYMg6BWrxfaeklFr6o9Z98Dy45fOKQPL3LBc+pfZ7EDZQTK?=
 =?us-ascii?Q?8d5lPzbjRj1tsfdiu1xaQWVPFQAaYW+s9ymNzdfApsS+lvgQrY9qhoPG9NDR?=
 =?us-ascii?Q?Ms6ZrWx7WCB/dmq87dFZJTPO6tPVNjZVitQpqHtwaui5mz7QHyDZ3q03tlw/?=
 =?us-ascii?Q?ZpwnIUJ63L0+uowAtRVE5hJV3VzGXHEzrl2F1LpdB7YlvodV/XoER3b2vfik?=
 =?us-ascii?Q?6KvPXT/FmVbtO6IGS3ji5bc5TcMSbnf2yhhvHUu7OzPJK1Mxmu/N/vlRpEJJ?=
 =?us-ascii?Q?xYm9cOPaJhcz3dD5BJ0sMOrFDooo8pL+SHPL3zWYb2qtaPTIqfeXAoJ7S/SB?=
 =?us-ascii?Q?afjuw9mXRYZKWt0CfOwASvGgNma1vBhnNPFjpoY9UzCm0lrkf26prfKDEtTQ?=
 =?us-ascii?Q?ch9GSjqtgPgQo76MJwvQZjG8YnSgpa5lKvY7zOfq4VyliRiLLyGzUg4P5ILm?=
 =?us-ascii?Q?ui0FbLYY2XskRbCngkgQvyWpuMqDXuRMQ2mbI2mJxI0HpG0sGU32itjNWAF8?=
 =?us-ascii?Q?3CkW9o+wz1hxPb4dNu7qWzGYPf9POFLSOKG/02ZS+2ol9ejEdl6fLm4j8Lod?=
 =?us-ascii?Q?KqSaNA4/keXG5reY/cQwMeMG48XCBTWbKb6R7OI9FqsZ/D9I/otSSfS5grWH?=
 =?us-ascii?Q?pPyvIEltxyo8hUL+o3nJoOXH+T3bu5goITE5kONRsvGe3HXwr6Dmz/87DZbF?=
 =?us-ascii?Q?yLCkDhMbEm12JCXBB7z5pANKGNhQPxVVFUrbunHQn0zZFWPsYjelEoroEsor?=
 =?us-ascii?Q?8CKshT3Zf/f/rwU78BNoAStWzbHcBfLcdg37Ke6ub0hHu+ko8RDbC6XVMoYB?=
 =?us-ascii?Q?hDzHuqVatMe1Bwk2tzFSCd/1lsxVW3DWSzLUECjcrP/KVNtsyqt876+jn5+w?=
 =?us-ascii?Q?aSG+jEx9KTqjNXcSSw4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:19:10.8094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce21eb1-e0a3-4199-a40b-08de1d3712c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566
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

Access XGMI registers only if AID is active.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 1823ce74b990..10e42b0ff7a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -336,6 +336,10 @@ static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int global_link
 	}
 
 	i = global_link_num / n;
+
+	if (!(adev->aid_mask & BIT(i)))
+		return U32_MAX;
+
 	addr += adev->asic_funcs->encode_ext_smn_addressing(i);
 
 	return RREG32_PCIE_EXT(addr);
-- 
2.49.0

