Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D491C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A42F10E233;
	Fri, 10 May 2024 02:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p96ZkLv1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9F510E1B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0gB3DfbojIMeXBDbP2Zy+nZKXpiuhlUu8qKhoNKBAWjRd8MWR5lkaIP4GfyO9L9Jhx4kKrClQQl7q/Yq88KEkp6qsS4gy9saWUt0OBu3DjrUf/fMpqWefiZEeRB0Q05p2OHMHaCaPTGJwnfAesJHe+hi0Yz1khZt0Up+aT8VwnRP1pskNVUzS2bct8zhBHeCn0JN5ShqUvDx5gjQfk2WXFGO62rHBOUG5WpEeLfHgaA6vQ9CkvomN+Z59O2AXn22j0VKH+zjMX+4yEOQkyz4EYf0l1NqOW2iCGgS2g8eh6pyo1O4WVty06s33HTY/lbM9bTO2yPCcq+93MISjse0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOK8zrxHE1KNh8gRJZEg5pPP4OLF10CjGbY8eVLhVQs=;
 b=mVVOglRZ/elQTBt+DUW1qXzT+mVMxL6/+DWOSqZZHe5Y2MdrVd+GHS9/lVqc1yhGGNNHsLsauBc5Kxpvm4YgYu+m8rgxIu3UHey6GgUV+FTV+VXOZKJJu4r9KXX0kFzVxymCSqJSKdeY/DDGMd45TxBlQh4UewGDW0TSQAXWQwfUvQNsTjNXrKQmIvlEW5AS22f0HGZF0nOoEGSnwSWV+1g6D7vqcUdDOxi+oi7M34G3wzAp+FVLIIOj0RSYvhDc9gsOtzXTkb5sshGUVy7QiVjVug/wMtX1lb1/7+m5meWrpeZWdoLEgrwDCsoN4ImmtFh5Tp47902hUOeRbVsGCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOK8zrxHE1KNh8gRJZEg5pPP4OLF10CjGbY8eVLhVQs=;
 b=p96ZkLv1sfuNI79+xm9U89O7+f7Q9TrXi0mhBVV7DVT0iQH0ustWs9aruIqbK05l2BVVgVvzQ446exzDOGnmnH0W0/Kv/iYhuoFTpcYv3d8dA92SlhF+bGUtbaHkJdsi5M567shY4Qm9VOIaAIgPP0lPvay0xY5q1yfUbmPdroU=
Received: from CH0PR03CA0437.namprd03.prod.outlook.com (2603:10b6:610:10e::17)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 02:53:59 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::73) by CH0PR03CA0437.outlook.office365.com
 (2603:10b6:610:10e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Fri, 10 May 2024 02:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:53:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:53:52 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 16/22] drm/amd/pm: fix enum type compared against 0
Date: Fri, 10 May 2024 10:50:32 +0800
Message-ID: <20240510025038.3488381-16-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1e9332-a39d-4d48-901b-08dc709c7143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?avqg2OfqRpTqPrpFCRvb92m0CKLEI/AyTadZ860qZSjHBa7WDUDxGD/Eg0H0?=
 =?us-ascii?Q?rMVwp2aiGZwDGvniQqpS8p+UANDPCL2jPVaQRnOMq7/Mu5r/IszdlEVGaWhL?=
 =?us-ascii?Q?mF95cUaX+pCoO+sBGF/HBtcNPlBIxM41DxP2NNWXrmt/T9OYDZv1bOZhOwpK?=
 =?us-ascii?Q?YRjebLptir3t16z9GJuIcf8k+KeSpaiM71D+ugPntGV9HJk0JiAXhBHptEUj?=
 =?us-ascii?Q?FUvPvnnwmnqfKKOAXei8ikPPmnIBS117zHhf0dx2Itk017NeVujZYnSOkeMZ?=
 =?us-ascii?Q?RNzeEZDCcR74RMRvf79iVyD9iHc1MVkirVRNv5PljPba3lTMTawmMgqw4NXd?=
 =?us-ascii?Q?blf4/ffERshTm/hcIvD77R4k3LTTyp7AFYhi6zX8FymA+fyYvf0gcHPP3ZIY?=
 =?us-ascii?Q?yGMUqQEdVR/HSCB9G1A3Y8Z4n2gPIk7PoQNGJvJ1WfQp8QD6xWuntohrAxGj?=
 =?us-ascii?Q?wIDdDxkmB+atPjJKqSUwQz4RqP98PCKs89Hj6wjU8gF05k8ovXp/hSS0Easj?=
 =?us-ascii?Q?wrzWoo7Bxb9XcaGelFLBU7NX2gBjsSCjWHx4e1WG8I2B0Sda1LriBrlVufLF?=
 =?us-ascii?Q?HMsON/rVWf26gI8UKZ297EjtIqgFAyyxzkWnc7ATrIUnRsLGG0se+TWq1TAu?=
 =?us-ascii?Q?eWKpGBLNenv25UZ0LvSf9olnHt7VeeyMAIoUzGOmH35yQ2Ieh08jW89ayJsx?=
 =?us-ascii?Q?9hyaQOof0+LUfqcpT/IjSdTkH1yQ4qtcTLBNwNu6DVzJEuGnNzyW6vBC0MHR?=
 =?us-ascii?Q?NKimhLgIEsApnZ5P2j2DtHur9OzV9J2C/JLmkYFjG9cy7P858D1hEPI3flm2?=
 =?us-ascii?Q?F0RdAjKRLLu9qRNc7thcQT1uohO92u+i+4A5LXx556SVpEINrYBwr4Hqc4T4?=
 =?us-ascii?Q?kFPTO/qi32nAw0i0hZUs4p4lh9p66ix8DeaIIxccMv94hS+vhmC9cyzZiLMD?=
 =?us-ascii?Q?AEBb8P+5WgMi/PujBKnZmhnR+1yHbgm7AQBbOili/J7Nm2hpG7Wm5nWGkrAj?=
 =?us-ascii?Q?qlbUMK/ez98j+oSI2Bu4JLho5gCYdcO5qQ2+IOFHQpBG6DA3G/oHUKytnX7F?=
 =?us-ascii?Q?ned9y59VVyhNLUwU+ykJ8k54a5xaGcNP3KA6MLUXW7726kS7JF05NK7skn6l?=
 =?us-ascii?Q?faM5Bfm3OVxDruTsD/D4qJfIZtNEhlg8vqLpLtl9VghNjhIWD4wiHcl1C2Ga?=
 =?us-ascii?Q?NtlMXK038+qdhYGqqNhzKC0N0mcYiQB/KxO2KHxJlBejrgIX/B1gyxf3xt/D?=
 =?us-ascii?Q?RlTrtwW3HWagNSwm2r1I0i6HPhHsxpMXQrsWofaAeM4zEicrtdvWhNhaKyFs?=
 =?us-ascii?Q?TjL08r5zPPJTOO6L2VfoVT7Uwcq5xUSbr6jnarlbOqPz7vRGofxGcIetjm9E?=
 =?us-ascii?Q?zZmEMfY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:53:59.6292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1e9332-a39d-4d48-901b-08dc709c7143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
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

This less-than-zero comparison of an unsigned value is never true. type < 0U

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index d439b95bfb79..602aa6941231 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -56,7 +56,7 @@ static const char * const __smu_message_names[] = {
 static const char *smu_get_message_name(struct smu_context *smu,
 					enum smu_message_type type)
 {
-	if (type < 0 || type >= SMU_MSG_MAX_COUNT)
+	if (type >= SMU_MSG_MAX_COUNT)
 		return "unknown smu message";
 
 	return __smu_message_names[type];
-- 
2.25.1

