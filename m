Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE734CCD184
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F5A10E2DF;
	Sat, 11 Oct 2025 07:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GU+xiprG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5973F10E2DF
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfrSZI22+6abVgo+fVrpbA521YKqGCEo8Wf3lIpr8opV/rNakEMLSmDv5+zU7gGPZBepwH6x2So2DZH2KVzYB947ootgAbcFpRc/nQKGRRC+rmiZzPGx5zam/eobz4KbH6RnoVkeuZv2dHXbOo9MgFLHMIXLt1jb5FdMLjV0lziIZd98YHcYiOadW77vh3oKPDYl8DvbrPciBLX+E8BNdsbrJKNmTyyuUMYUp0lZ9GxkJRZBJYQ3saSv9qFynZi1kfIRiGelSYV8BiS0BHcofVBtOKyGYmEPayVwRJY1jtNvIYvJGZD0m4OTghXkim8w0iwWR7tahB22y0YdJvtpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5FvzEA+d76CD6NByY8ksLGmuUonZUegNIrNjBv6O6Y=;
 b=j3bshueUHiC5KJ2hfbfdoOPv0PKLo/qeYHco0C9/RJ81ScTt0BCOdIHTVCJZoxgIYag0aN05ka5Sspkepmydz6e9TXivYa/STnFRin+HtT/7/W0zi6nFNcku//iNnA4S3P4CgGjr4MXwyQ7hrUqweHvVE8MpJmLCDQlJRzkC5Ox9CFSUhJ0ABhY0Y8z4i7VaGPkzGLC6Baa9qqLM5NaBHOBtW2pfx1wW59cAffwJcUxJlL31kmCYRSD/Sr87hamOGYslRaETuqTAyyn3W98xlUmQtug3sk1A/huauFuCadzORgkgx9Ik/Cr/O6z/I5vpDcw5lfDOI3SgrwvbCoTGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5FvzEA+d76CD6NByY8ksLGmuUonZUegNIrNjBv6O6Y=;
 b=GU+xiprG7D/hKnhOZzyq/DgA1Pm+0Ahvwgn/RYH5GHu2590GyWzqQB+rL76jP74DJtEbeUbHECu3VssDtedL494xpajrXlgUGN+EXDdw14giBrz35nSBAO4uTX2lieo7TmhJ/Bdl1cbX5C3o4SKP2UFzvktmFPjAmPUA+VBXU+I=
Received: from CH0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:610:cc::8)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 07:50:11 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::58) by CH0PR03CA0063.outlook.office365.com
 (2603:10b6:610:cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Sat,
 11 Oct 2025 07:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:50:11 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:50:02 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: add ras module rma check
Date: Sat, 11 Oct 2025 15:48:07 +0800
Message-ID: <20251011074811.533871-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011074811.533871-1-YiPeng.Chai@amd.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d4acd2-3c50-4f23-6005-08de089ace83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mpbdX9oY6Tqz9NnQaQloFx9TUG22Xk7jOgPEhUiTsqsvjzk5frvcwiFHjqLD?=
 =?us-ascii?Q?DsS2wlP3JJ5b0OOMIZs4BqtE+ZGtsZRNO/FkS24cyc0NDc4v7SriuJPQ54u9?=
 =?us-ascii?Q?wodXHgKmcN+SZo8PFHJHMVA7T5cxBPVY3GM74AfXJzVEah+J/VadLB9JVCeM?=
 =?us-ascii?Q?GtJ3Ljzy+VHy4xrsvJlqL0ypw7midEZUXYA0eh4EsB6BpXgq4+7Oa8/hVw2N?=
 =?us-ascii?Q?JHIVkWiK7E2PNlgYZsX7wGPcKpZiS8RYXDuKjJFHTebha07vysGBQW8FHelg?=
 =?us-ascii?Q?yo9aQjm65ddQGXmoPTjY8cOEyjXRneRGdYS1enPmRvkb+7UqLlweFXsRo4FM?=
 =?us-ascii?Q?nOsdRsz2zB+TeAkyBHm9q3Hxja+54qUsuwWe8/gNSbjbbLYmdlMQD8Pfgy9V?=
 =?us-ascii?Q?byGSR2jDjm1dHgZOknS3EMVNK33HUFK+elSgzCD7JkXNWlHJMpkietfhOp1V?=
 =?us-ascii?Q?idGCeokEWx6UbOLjz1/NFJWtp2g4HVXlmhBHQSlmWEOcXeZFSvxSs52JIxtx?=
 =?us-ascii?Q?m3NincKvRAk6f8n+OPB6513lPfuQ+kTcogQKLixtTcAw6KFez7v6E84KvdDT?=
 =?us-ascii?Q?Kxb4gfCI4ti2lRELQ6+coEeH9o7+l0OV0930j/Bu5WFKzovShpztAuxfKgk1?=
 =?us-ascii?Q?AMC5MG33Cd9dEOwjRapV7bQLBmYBlCnqHdVo2idsZFZKvkVl2zE8obVylSTN?=
 =?us-ascii?Q?hKLPOJuAPF0UuihObKvoP+q0OOnTZmtkLaOJemyEueNVP8OTYMZlYH5f8zH1?=
 =?us-ascii?Q?2XDpBfSxMqB2WeeNuOLBBPjV8GKrYaXrqF7sMyVQHqwYlQdBD4AnsYDvv346?=
 =?us-ascii?Q?N/QTftW96B9X3bKZKZnkxn47nVZOwipT/diidPWiWwu+w1IgZVavpzbbAmzl?=
 =?us-ascii?Q?k20/YGTKtBWSGLqEgp8qHZ85mA1sGK9ZavJeXXcPJ7PGXIEf9lgN1Bx4eoKX?=
 =?us-ascii?Q?3PDO2otyGqk0v78fQgKlCJmvaZ0Jz3c8F3z7DLIwGLJ5UDPSrkobtyAOju6u?=
 =?us-ascii?Q?oekmA8ZmK/DU3/ZUpSe5KFXpkqtgPauBDM6Y5iMIDUKA92sFICQeLYk5TGNq?=
 =?us-ascii?Q?R/mcWvDtcWBwxnE82Ar+iXvNyBd3NghvQ/2c+3X4ZUszwbuPMpsqhvO3/w7F?=
 =?us-ascii?Q?WYTYAgwaAtcPG48A42DjpwBW7V09x7Cihk1c9fbrJNpw+oUv0kxmvqL98pfQ?=
 =?us-ascii?Q?gnRV6NBFs6GmEUrecpc0S0uD4SWNyg9tG+5RhN5wYUWqb1LTql1src3BE+8T?=
 =?us-ascii?Q?IbJQrDKTB7yPwzmXbK1B/piYH+F0CZO4DCTwS2DkZcr98XlUVCYdMmDjrnuC?=
 =?us-ascii?Q?Jdzu3R6bkFjfuF7zMks+3f54Qzq4f40kHaSvlR2a/nY3VcZhLXqQiZtyYjPH?=
 =?us-ascii?Q?wOUWBAD5QJcxi/hQ0INvpIUQobl8amxL8XHfc1yDSvx2xyfsUSP8cjNvanFH?=
 =?us-ascii?Q?iOIl4OHH6Zx4DEZqZe0ryNn4KKnUv0MnWlbrkYJvIn4Zy0MdrHzI+5kq+von?=
 =?us-ascii?Q?39ozEHPiEhYwTCQ9W9Quyh6IxvqdWO7giErcYogZj4NH/330mVzbJ+fLbv41?=
 =?us-ascii?Q?se1+TYT08pFKX0h7OAY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:50:11.5348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d4acd2-3c50-4f23-6005-08de089ace83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Add ras module rma check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9b7afddb4a16..29e1f98e3994 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5424,6 +5424,9 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
+	if (amdgpu_uniras_enabled(adev))
+		return amdgpu_ras_mgr_is_rma(adev);
+
 	if (!con)
 		return false;
 
-- 
2.34.1

