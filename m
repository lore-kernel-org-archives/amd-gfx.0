Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EB5C28B2F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 02:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E35F110E2A9;
	Mon, 17 Mar 2025 02:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KkzEHh+n";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B2A910E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 02:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ok50btF7VVChTd9f2CQiY4JxTBYJjZXJOcYSB4fpoPcpgb7np9jyPBSY2UbMXHVKhKSUcGaLaG865Lf6N0LRU6R24YmiKdP7rLy/kCR1ljOOTcr45q48jAy7tTqtsdnldyG91IYv1EVbv8PrUI14k/SWXJs4spvZE7r8y5pq1QMfPiOO9eHEcbkvEQSmNCLOm0wBhYsb+5n+8RkB9/mE9ZoBhaUOQdpaCi7l87g4ePxuZ3bFpWMbH7q34HwqnCtZRn8pckq/9yrue60MiYazwRZl9rJPAfUrU+a3ArWgoVLIb4QxfELZaYf0cjqfM2ZSJHtS8KT6lD1y6pilqWDMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yomLiNFasnx1OloubzHMaOGifqtZ9JpSPfPhqCIDF64=;
 b=CBnINUpSGNUPd21oqfWBad34uLdCJf5u3KoGEMdJ3GKJDtiD7MULe5f+DRzKl0pBShN5F9r8oHN8wOJB80pMtzYz/KvVVP83X7rmKl379GKcQz9kRkGq8DWpFlW2KEk8VuAxslotFf6sQiDf8rthVP10AMAGWzH3WsfhaARPzTwklfkWDc/oRWN+UliR0Ml6slZa0wy4UzmBS7a/ijA6TuujGM7y4O84qdZoCsF1femoZbcvogpX2nwzrHHHJiGFNIbhtuR5VOvGYX+J1aSAVqD/FBzDA9ymOwmMqymq93uPVI81f0QRbfhlhOAoOfGxlq2NFEh4EbzYU7n97Deu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yomLiNFasnx1OloubzHMaOGifqtZ9JpSPfPhqCIDF64=;
 b=KkzEHh+nJOBK3w568xL++3lyyE63RwvSjgi+VfiX9JgdUuZQkciEYxajuG/xvANrJd+0u5xbVCuiuOeOu56RpbAn+T+DYQLu/pfxP1t6SQYl+Vqmou79bUeU+1EcxqdqqwZ7q/lWbGKLAnvoqYf76rDBMorX/kwnPR44r3rgX70=
Received: from SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::23)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 02:33:42 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::1b) by SN7P222CA0029.outlook.office365.com
 (2603:10b6:806:124::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 02:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 02:33:41 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 21:33:40 -0500
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Flora Cui <flora.cui@amd.com>
Subject: [PATCH] drm/amdgpu: release xcp_mgr on exit
Date: Mon, 17 Mar 2025 10:33:25 +0800
Message-ID: <20250317023325.99537-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 76584c75-8ba0-4767-d78a-08dd64fc21e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LKXhFTfewA4Urwd3OITog4DSgb5cGojVv/C2b3I+LWK9JoAE8Bo7mW3x2KFE?=
 =?us-ascii?Q?FyxY8p6UCMpZuQ2AlmCZo3B/On16VTcLseBPvseF3oEV3TZ+U7Am0bddD4kK?=
 =?us-ascii?Q?LjZGxIt/9PwEZw4GoJlftZW5aFTdkhCJq9r0NW3uYXNH+CtfxgpZEHk5JM61?=
 =?us-ascii?Q?nGkEXCC4Ut+c9ASZ048DPYK0oETTRJPRL/TYw0LPUJximXPC4j9BtkFp+nbG?=
 =?us-ascii?Q?bMy3ED94kbyU9CTf+md84u0e+5+jEkDy8sRYj25qw2aEiFFpQwfU0bIuMI4b?=
 =?us-ascii?Q?huyfkIx70ZWGrTrkKsExgSO3ARiM9wJR1+UaMJC21jqC1l3ePHukqlI21HaR?=
 =?us-ascii?Q?l4fN1dq7ZdSP+/WvC7rzYIGTFvhUKFXaNxTnBOhORAFZAsO9/KYMUqZq9CFs?=
 =?us-ascii?Q?szdT+5gM6o11mDHgPA5x2jh+199H/zKWwI7VU78iRNi3nSnfqBH3iePfhOdg?=
 =?us-ascii?Q?qS4tTc51AR4K5LvM7TeB7PdDcqVMm91QnP0GR+Tl4iIetgTK8r0UleweJNvl?=
 =?us-ascii?Q?BRK9XQ1YlKe5SHFuRlTNjsc0GPc/Wc8pgxdJD3rpqzOTP7aaUybx3aB9jjMJ?=
 =?us-ascii?Q?+xTaqTDryPGPCJp0m895aU7oc+t8nFmmfgkHCnrQf4Q3q+4Jgnyh0WJO8mGg?=
 =?us-ascii?Q?Kku8nhk9x809dQrhANK8Dd/+801Ur23wTN98E6i3xNuBk0Bi/TbOkOUsiC9A?=
 =?us-ascii?Q?hev+NJf8Ctig/ToNea4jpFlB/dQvaBFIIsrrFOp0oXbs3ywmR8hMkPGkP7r1?=
 =?us-ascii?Q?TLFRJ0VZxEGSmH17fXTKx4Ky1mlGIla1dPfGtHBxLoQxuNdFhhLMd/iLvW+2?=
 =?us-ascii?Q?aHlSpy+xUfh/IKOvatWl2lzKivnJb+UYcLArNDw92kjHt0qDLhcTD1ZM6d/3?=
 =?us-ascii?Q?64/aZfl36XbVjNmZgrU19RTBcVDICITzoyzI1N71iCc8VB1fUfzAhy9U2jn+?=
 =?us-ascii?Q?6Tx1+4eCg6glmAwzXl4s3/yzVpjG+ipOLyl6w6OYF3sEfJOv57aE/8euO8bc?=
 =?us-ascii?Q?QuFap2KSdf1z7fiKnwHZS5yiSk2VTo5dLCkidhwVhnZoMTCv6nFsN0deCw/D?=
 =?us-ascii?Q?d4wJR4tEnSwhPZzAYxOP1GQoUuKrDI+PsNRcHv82YXvFLud3lNXjdcg1XRww?=
 =?us-ascii?Q?/B/OVoMDHKnCmkYkijGlhkSDbJj/X+5BVqPDh57PIi60nhpIKNkdJvvM3kUY?=
 =?us-ascii?Q?BIPXE1UXxYirvWV87nSqDH6FBX3vv+DkwVsjYM4Zbyr39SIb3okro1EkZYDt?=
 =?us-ascii?Q?RfaLhJbztehh5zaSugyw31Gn3C6Ilhc8IoNvCyYBp4ZmN1Iaku02OtYSBTOB?=
 =?us-ascii?Q?bX/jjdXqEmVkcHm+XJSOY2kdysXxkhQuW99DBeGRGs8HNzz1U/5Ay0kMk8cd?=
 =?us-ascii?Q?8l8P7dab4wifLDxnX0LRyiotiKKPq0qiM1Q7AdkSsSB1mbbxJx+VRjiPNDKs?=
 =?us-ascii?Q?jwJSpLEjTphMey30tJy2F/sroxynXQB19vNKBiRMTnfP82ZRhxB2a7OT4uKM?=
 =?us-ascii?Q?YoTt4zUv4mMHJhk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 02:33:41.9362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76584c75-8ba0-4767-d78a-08dd64fc21e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ca2ebdd3c95..ca556fd84bca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4796,6 +4796,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->fru_info);
 	adev->fru_info = NULL;
 
+	kfree(adev->xcp_mgr);
+	adev->xcp_mgr = NULL;
+
 	px = amdgpu_device_supports_px(adev_to_drm(adev));
 
 	if (px || (!dev_is_removable(&adev->pdev->dev) &&
-- 
2.43.0

