Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6A7C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 04:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCC110E073;
	Tue, 14 May 2024 04:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="na2RGVce";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048E910E073
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 04:12:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm0s6qFDPF7qzdrz+7ybTSGxhxleWGgB67OVVR4BBcdxaV5uy5tQCyaGtZKkWWgQpnwXDT5hQNIy1w7sEc8QCERDM2/GsYY4VKkvI560hBgWscBhtqNN64dnFfieTxBQ0qc+27jn+yzgfCT++RTBwf9tYH88QOyZlTSa+BDZYhnJF4HwmA0pmNUa5Z7zqY+EtSpVBjgKX3xQSGwUSbBYdjMuohf7U3A0PGMwi0/5HJeChRwSpkatSS+mm0NmdpR0bbJWueHgBBxirWjz9OeabfbEhskcadz1uajplX/3a4pT5VVyL9jtDOpxVJfwLPnY4mYEcVtOdM0okRvLJWbpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mb9roZhiKdaqn9FvVweDZLRDYPTwHx4OzCx/1GrLck=;
 b=KY9JjmXg4RkT+td06oCsS7veUmOKhZvMBeiKpyhxVaOo0UAjnzDfhs/nAOr8wqjL21lTrpy1JQbikQ4IC4De1ttvPI9MkP3fZ9a3oLwmLhPeeo0P+++W1/h9YtUfpQS0OAwRu9bud1/mG5W6+yeX1x7pZ67AUNQR+qVxIA2vAw/yXdHQZ+t8BSHYusf8HNiAGeaSMpwEJtKs2g0rIbjBZBzH2LaLBebbRjTjEXT764Wr0FkyuCwjqXgaBK33badOI3QM4mMmXzTgm/8qOsT424PruEWs9gsYZMgWj0z6JW6NS0vDmAxh36TdIVwLryVt7yAycPi4RFVu33InPQw2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mb9roZhiKdaqn9FvVweDZLRDYPTwHx4OzCx/1GrLck=;
 b=na2RGVceELRMirC8X62ZitM6X1tEYTbVS1hNvYYaLjqerYaVbRw+9+RruSbnEHu3EP6/VdXULmCI1/j5+8CEEDGYaUSX68l8cJgZ8RgvGL/1A3lIrBPyl4K8kuwWXGJD3I6Jq2ZU5ja8kQH7CcFLv5TfotaxmvAZXqxPaXEdINw=
Received: from CH0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:610:cc::32)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 04:12:51 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::76) by CH0PR03CA0087.outlook.office365.com
 (2603:10b6:610:cc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 04:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 04:12:50 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 23:12:47 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, <lijo.lazar@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix the null pointer dereference to ras_manager
Date: Tue, 14 May 2024 12:12:30 +0800
Message-ID: <20240514041230.605539-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: cb64e6c6-b7c9-40c7-c585-08dc73cc1ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AJoQl21sjVo7q1/IPm/iNdOr69xaBbdeisXocNRL+6EkY4pSEm4WUMoGPC0O?=
 =?us-ascii?Q?FGv3WolxI/9cnFaWEx//hMDQEsRMLBwfJzRspKPQfuuYkaJ7iLtxprdV9Cb0?=
 =?us-ascii?Q?zFqNpZr4PushLGBA7m6B9E6cDBqzfsn5kQc7C3ARSO4e7WuF+yp9flZ9iN1+?=
 =?us-ascii?Q?NTNBIAjWm/xMEuO/395K8IjA2Ook9E56kPvhrT3EbiQmrVeKGIGchD20MQeD?=
 =?us-ascii?Q?wWGBarpty5aHBktxZQZGyz8yXhkoxyntgVpA2/oaQ9DfK7+HLrykvXWXgwrw?=
 =?us-ascii?Q?57LyjcX/I8a7ZOFup20iPstUEFUhqtpUM30rdHHE7mtIrwvgxjuT876/BEmD?=
 =?us-ascii?Q?VBvWc/9iyaNdUnliyEHRvter5eHuO7C1Axit4KpOePl7qvebUMdXiicUtVkP?=
 =?us-ascii?Q?w0G8KjfyL+8Qt/K4V1qb4fhyBKGj3fHsTQwETi2EsAHDNwVmoFdlQ7mwrbKS?=
 =?us-ascii?Q?JFGduXNYuW7woOTYPx5lNSv7ApFZTn41Q9osvK2QlJiI31UZbd+qOZHyQ9Tq?=
 =?us-ascii?Q?WQa+eT0oACmh3cliIU3OPtfGM0/VTZOZojFOM87s5Aeh8/7a3YrfKSnxhOI1?=
 =?us-ascii?Q?fz98UVH1FcexI8945ltV0QXsJi27SHFt1G/Q+SIPcResPTKqV0g3mSNPK0xH?=
 =?us-ascii?Q?7Vt1V9CIBwkjJ36pIT657pU/w8he6rqoIGmlTBCdmhNLtaFlbz3eKNUk/VhC?=
 =?us-ascii?Q?4BPdY/IxUN3BYtS4UD82biptkFdZRIQXN30diTg75po7FbSTVYs4TCzECIAD?=
 =?us-ascii?Q?Eigmxft7oNQoZ9eu2yNNGaCbJ6vruE2I6Cuival74S472hZlwRSdIZR0WVu/?=
 =?us-ascii?Q?W4OrdZr9QLLBNOMmeEyc1g6l8VoIKT6nJJJ7xpWzTIn2o/ore+gG9uvNgt1W?=
 =?us-ascii?Q?FwlWWfCKw8SbH4wEQE+Rz7e4UXTgcg/alwPaWYAdGrGzWiIxyy++cybuvcyB?=
 =?us-ascii?Q?1I5L4wsBGJwJLi4jhzynUXDKNWLF87SR3Jqc/K5NBAJnYpImKdf2Fq7OimfP?=
 =?us-ascii?Q?yf0n/ys1tfXiGRGWDC+hOAO/gKoYU3ge0tlapIGC2x3LeBIFTAAvID5XBtvu?=
 =?us-ascii?Q?hXJlaDdSawlVv7zDlW87UyIAJcTNHtpip8FfvadV30Q919GMHdbhWn0890Tp?=
 =?us-ascii?Q?IrsTFJBbppIznWwB6Ztxi8YF/1DoZFk45G1/NywOOM+A4+Y/2zCBPaF1q8z8?=
 =?us-ascii?Q?bJKty4X2ioohj5lKMVtKZTE+rDOHgA5lwbaCmaoJNaSg8nS6nbEu/c3r3Hu9?=
 =?us-ascii?Q?VhZn3oztMRL037NBuU7YaMe0OdraBpZtu10UftWy0Qait9F6e4PAAVQiTyd+?=
 =?us-ascii?Q?B1LlMbiXd1GP8XYcNfMpzPEOybDjvCMQf67fJWHvibqnzN/UPJOiRH9YPnaT?=
 =?us-ascii?Q?OrzNnY1qpsZexjUpsKR1rwQJeSYK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 04:12:50.8201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb64e6c6-b7c9-40c7-c585-08dc73cc1ef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410
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

Check ras_manager before using it

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 925ec65ac5ed..2bcf5c3b5d70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2172,12 +2172,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
 int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 		struct ras_dispatch_if *info)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
-	struct ras_ih_data *data = &obj->ih_data;
+	struct ras_manager *obj;
+	struct ras_ih_data *data;
 
+	obj = amdgpu_ras_find_obj(adev, &info->head);
 	if (!obj)
 		return -EINVAL;
 
+	data = &obj->ih_data;
+
 	if (data->inuse == 0)
 		return 0;
 
-- 
2.34.1

