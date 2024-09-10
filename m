Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15EFECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 14:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D00710E833;
	Tue, 10 Sep 2024 14:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DsVEZBy1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EFA10E82C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 14:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IstHALNbgQZcZJJocYJ7TbhwhbTk1qFrnrjU5uuklEf34B5jG/J+u3QrVdDZHEahdbybRMXvRGFrtqp4VjJOKa8u9HoLzlOYgdnj7iNy1NAe/BsohLLH9dnvETJSODUP0AKO9nRvl3V/e8xWP98v/mfgsugfYkfjjnswIpIfo1pIyFi102UFKQ10hj+7Rojh1qFs9Ax6WgEQrs70V4Aa2Iir/FETErBCpbnmtlu8KYahWqCyzzJV/7YTT9Bwe5vXHlaOO9oeiClTXY10A0g/dYZWAfnMZBIxbHK8owSrzRUAASIayvdQMZdfOKNGyhaidUjJCHSqhS+9UhW+7Hzjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laoO77qyUXDuBECTzbzZAP9TS62y88xNreqoe9FB+hg=;
 b=ANWNoJc0F/N5Rq5q2mWeT3stZWQmTGzb1JBIllaScs2OfWf2nTTfe083lmkkgqo49l73jE1VGWzeV/dprNmYe4i+Tx4IhVFo+63ypK7ooh69uDRUfiNPVM8v2NgXLmV/YaE+Mk0sCRbSCdydYAABxoHFvOXSpTup/lXGcTxuo6pqV+73eIBfZIF0FRJZSC3RrlB44YAI0QvwUtf3qdtjF/8ceQ9m0Gt2pbllt2Wm752jFlPIM2XvQ6N+ge3hz6eBHzBKCb3ENOhGaeGw0SAIQhGJ4wFf7Yzag0HFhwsSYxcORMbTeykCbiIp78jbQaiu6pRvm1x4HcaEJxV2dMqc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laoO77qyUXDuBECTzbzZAP9TS62y88xNreqoe9FB+hg=;
 b=DsVEZBy1i6pyoT4zhLvI5iNX8TOLG8dBawiR0f02U/gH0Bm9IZOK0BE+AcJAYpyz4tlgkUoDO5ZSxS55fav7fUxbtyD8TeBfFEk2eJRGXXDEXd9SXsZe5aBch7xAIV/t29lw18SCm9Ajae+Vaz93va80F5T8U6SoLycaOsC8hAs=
Received: from CH2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:610:57::26)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Tue, 10 Sep
 2024 14:50:13 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::5f) by CH2PR12CA0016.outlook.office365.com
 (2603:10b6:610:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Tue, 10 Sep 2024 14:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 14:50:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 09:50:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix spelling in amd_shared.h
Date: Tue, 10 Sep 2024 10:49:57 -0400
Message-ID: <20240910144957.2728976-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910144957.2728976-1-alexander.deucher@amd.com>
References: <20240910144957.2728976-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbd92f3-7f67-4560-b77c-08dcd1a7e090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6a4Vhgs/+2mpDecMNxBpWVVVCU1HINqMRPBXvZ/8IFjcPef5Pmlh+mfOhnz7?=
 =?us-ascii?Q?JyAL71vzZegIQ4IZ6DzrLihaBIEDl21bbAUALAfvMJQxNzAbX7fIxo6GRgz5?=
 =?us-ascii?Q?9jTrpJst9kT57sv0PUZ5lFu2l/fEHxc5zVA0LVt1SyUIFqM25ffkUXaB6Vgy?=
 =?us-ascii?Q?VXqZijPu0erfkL1KfsXkAAeAYtmBDHYpI9OkBoUMreXrZCnMasSknk8IYaDa?=
 =?us-ascii?Q?ffveoKOilXjv+z6cHujRkLsXAB3JlFpb/Vf9HkpTJuhbN9cembgVnzhsiIbL?=
 =?us-ascii?Q?biITcMsXF1r8/WoTeTLVnQSxwZwM9ech4901FliCVxFTLAc87ORHWO9hiIhq?=
 =?us-ascii?Q?kAfSwPdv2/BHwoN47MGuhvles6EKcFnhmgB1wBn4SwPIpPgGcQNhnPUdgUE7?=
 =?us-ascii?Q?2xtr+wWUopQ1g8mtpOKvv/Q2Ov79zx8yIHXwPHy9KEOHvIylX9JflYNhF4mg?=
 =?us-ascii?Q?DNghkKPBRO5kEDr6Qa1Wg0a5DJkpMBjwQo1Cf/tbqKsqmjYEeKzUu3Nm9Iaw?=
 =?us-ascii?Q?XxloCwLeEznuZ4EJmOQ4eFpOoU4Dtg6kDBiOLjuYK20aUwd/XO08DWPVloQu?=
 =?us-ascii?Q?5lzxCFIbXz8WLuNNy213xh0chp1tlHGiZY2w/IKtkASLvDBMYpTEF7/K+kI7?=
 =?us-ascii?Q?rVe6APJF7LHUpPi/O5Cyk0H7NCX6586UhSI9TCe8DsLH5YiqV02glNjyWtmW?=
 =?us-ascii?Q?dmMB3zZjcsY3SPA3PwXp+Rvrt4cDJk3ZlNmVh7vU0dOFom9sjxDfPLBeohjl?=
 =?us-ascii?Q?dqzV3ONaEOzKGzv9wGnzV7Qah+M7HXE4G61v1YCgmPr/3MR1C1ib/JCQf7p4?=
 =?us-ascii?Q?l/2E8BvKQ7YOOc8i4zQZZBCB8dSj4340dSkV2WFdszRbhM2BrTabYgEULBNl?=
 =?us-ascii?Q?7zDcWpARCnhGADyvwuNWYUwAuy/1rZv/gTA85+aiTTCQYYsO2zkeqtub58pH?=
 =?us-ascii?Q?W34uwVzh5gUv4yigt+9PvlsNCX84wU1U6ZG7adtmvWwQqRx70pyKv3NVdfCv?=
 =?us-ascii?Q?ylyeprKfOXosbqSWxAsswkH0CIhhv+G9XOd4utVrF2aUELgwiP5ZHfeUIGh6?=
 =?us-ascii?Q?VIY0gKiM1sdd7j7iINn0mH3DUrGgDxFS4Pvctet4pffY5wuYDnLByhn2IuG3?=
 =?us-ascii?Q?mK/i4NdIfQY3NS4tXY8/tCump+vISFxYzDEMnzXhhap9hvP1lWlGGo5qQe5r?=
 =?us-ascii?Q?IT5jtEJASuAb/lce8cnltOGefI81B2DrJ2e1u+ndOlOUT6BORnX9CfVoLIKa?=
 =?us-ascii?Q?g7YJ/vBzLIGfJ964JcuL9crNEYna1TeqrVVatn4JU7BkF5q12XLGSu81gN7q?=
 =?us-ascii?Q?UcNX0Qvnr8B+H1FDHnXImcExtkOQh+E7xjwUfm7U0ZMhB+mlFXGGB2BZhRzn?=
 =?us-ascii?Q?4We/TKel1wObe0aC3QP8fLrwSRvRkc+pTPcjyOMiIJW2/P0MWydeftKubdeb?=
 =?us-ascii?Q?Bd4+a5Vn8dc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 14:50:13.6310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbd92f3-7f67-4560-b77c-08dcd1a7e090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422
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

Fix spelling in documentation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 745fd052840d..3f91926a50e9 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -85,7 +85,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_MES: Micro-Engine Scheduler
 * @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
 * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
-* @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Schduler for Multimedia
+* @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Scheduler for Multimedia
 * @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
-- 
2.46.0

