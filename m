Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF089EFCE4D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5088C10EAD0;
	Wed,  4 Mar 2026 22:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k2AfoKHn";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515C710EAD0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p12hNOC7THGSZrfkmOe76LDxhdl4yW0vm2/hAuuA4vecIQ+JQ7lxvl4sD8+DcpRMKeoC4nG31OYEUjMjALGIYERD3lATREb2pFRrcC25LoBz99f4qSZ4WXfP3Q1LmXbTYZ0HQ6/dHyre0FDFFl/4oWnGRc3CmQu9bBhprbU6z2CmMQQbcHUp32u9G1Agf1sl38SgNsJ/Jn6lv5Uv26Q1S2pWsS2p0t8RvxkW6IHUHhqOfoD/l8JzEi39Ks0xYe1LPJXdrmFwK4d3H3VIPMreAyXePaWsX1jYEC2atsnVBEapjbqwRS/JHBZiFyUJ5TNgSkcHyEfxG0V5TNFOrFsosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOf5KQN8sYGEHerakk8T0XZX+V02ihJXzp2JJAJhvag=;
 b=GCobj4DMyeSxQd0s9H+2VpxNPwoJkIkVat0R1lX0kbTx41z/ONohKFzXPTgAoqxUDYPMlqRYQ1lDat7NL+tteiSLwpcunxuO/URr8FMWU9zFMuUhIL7AHDaJUqxq3pyCXAeVAMMVRxBaUoKvaXA8vxq+pUGqu+ICP1nwPQXcPZTTepkdeH4DlXYsxEBmIOaV3ZLAkjXTf8+R5ceFZxzCERZvJEVfvPqIZvhcfMIycKz0vjAatTLIIxzc4cvANsBzS7xTtmKkrX24keP1OmE4oW4MgC0qQFcvLihejdtGs9lgfmPWxfONGDy+FZjBVOp3CAqwCQ5A3DGmMPjU3TkViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOf5KQN8sYGEHerakk8T0XZX+V02ihJXzp2JJAJhvag=;
 b=k2AfoKHnRNbV/fR+rrG8o57uk857dZ5eWIbRYkloL8Ba96tLhrcNkWxvXYZYZ7nr4QdXDzrAWVy3nuy/dw0av8jGAIBn7yxrOkmVVvZiOWrybkJ7lg1i6UNKVgAdca3dVO6TkU6/ieFgMErXZL2qIRJbj/Rwd3u1dpFV+ZDEd3c=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:28:47 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::68) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 22:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:28:46 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:28:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <benjamin.welton@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [RFC PATCH 3/5] drm/amdgpu/gfx11: add compute performance count
 control
Date: Wed, 4 Mar 2026 17:28:27 -0500
Message-ID: <20260304222829.3688601-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304222829.3688601-1-James.Zhu@amd.com>
References: <20260304222829.3688601-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 9465bc21-f808-4f68-53a0-08de7a3d669d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: JCekOQyYPoybzTA1vNhW4/MyStlRSmpMWM9JK1k+fotgP8qink9jHu4KXezZ1iLkmf1YkIUnaixucTUMT1C+u2U/2hb6zbb9bJch5QYEWaCT32q/tY/NEPkD2ci8RfESvpsl5dlVnn+srbIQ3mZP6XbgxpYOhMvLkgWIIn7y+XvJtec+1iWUgm9ie79OiiwNCHgvPKtxmfMCZLg/8dgqwBKUYujesn8L8CTZgTg/BoffyhG/QwOkbNI+yhRb4J3syUHf6kvMMELiSkGIEeuGsOrO0f/mVaoM5kT/t74JjDYfpV0ho7PmgTWDVhM0kXQdJTQMhCklQngtgTUn3mCbwkVBZNtizBoAikE39SHsoCLmlZVZ7Kc2cJnEk0+/g/6KuQNEzQSI9O8dop/blpRKa+EHDAMkJg1YxdvU9YuWKQKKZ7eXKj7EBqfYpJZ1zyTX5EGewhDGizSvcRw0dtfwhE+W9Mbyg5hWk6IZ5b8u5aLqb3VDSeloxLytpOa7st62kGnclwEA7JZI4ztHJp+dwJRlms1+CylFbdOQ5aTZNyQnNF6wCryQL5342BgDacYAXzSOrLY+5u2i6v9NdbkZc9RB9lKNvZ/GzR6uO7JICXnapP+Rkm/sU2tH2moNuDX5a60vs/v34qoQdVX1oY+PAR5dXev3z5wGMZrygpSVo3TQJ3d7vwFXVsKbwXEDkduhemZ1Fvxk7DUQOibClnVMmvSBT8Na3UPb4z/tiWwyiNhZ7w1/AQHa6ZJBuJStGS9H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KJJhvRlCYtgvdlpJ6U47dJXEEu8TxvAotQInLqPRVoEkJKpF0PoWWr1sdhCwQ2AFJHKstkYQVuUNDNXOzkNyaJjUR8+gBR5B4fNbvUlU+3mnRRa6AYbllUdl9/g+Wi8qdivTiwWQIMs4Dy/GRE9DHdGBjdnZDgLH9v2Cyblj1f3uBEJlbIV6IKewqVZYxgfxRD80NwoL/aCdTN8yhUeNouk8mp6TaaQ0UPwnpdIxWivzzTUSVs5lgW7xiPL3GnLRxuOJPSlQ3Ggfb/Ep62r+T5lszNmimBBjy7tddHEVwwIkhT8dWLBEOGBAqesA4C9Rjg/m7p7DecnueHYcv46bHWreklVfGrg9DCq+iWXwTvEOZ1iWLvU9HjO86bT417Igi8GVDuOyrty0MLLxV3xgaxj5N+GO8ZEqJjb+HZic8nueMtca/ryS8kR9a5rMdz9N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:28:46.5028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9465bc21-f808-4f68-53a0-08de7a3d669d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
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

through amdgpu IOCTL AMDGPU_USERQ/AMDGPU_USERQ_OP_MODIFY.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b1a1b8a10a08..231404bb6799 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4406,6 +4406,9 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set CU mask */
 	gfx_v11_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
+	mqd->compute_perfcount_enable =
+		(prop->cu_flags == AMDGPU_UPDATE_FLAG_PERFCOUNT_ENABLE) ? 1 : 0;
+
 	return 0;
 }
 
-- 
2.34.1

