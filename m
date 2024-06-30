Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E72C3064D
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337E110E279;
	Sun, 30 Jun 2024 14:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFu2JRUt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183C510E25C
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks8Ztm6PRT54OX3gDfLK/KeTgsPlGuJUq5G3DFlW71gaAMvU89BklV/qf7AqHhXMNEL40ey/8gPB45/ebWEybxJDgglsSbgfk9vFIottq7Ua4WfnAeyInXJRKHz0VGfgPxjsU0PTzMQ9eV7VHBG35dpk6lIDRuPV+UqkonXLozgiVdQBgGQyVn7CSt++MJGm8mImf4h3C8emn7vZCD59gb8wIYpYA6v8GJiCN22T/NcEzO/EH/9eUjL862e6yVQaBhPaySh/lb9DyASDBcG8UfJfW7g6GAVqSUFLumTXogpcFDMk3aYkCmUKYtnndkZqBgftPV9CWC2fckt4rkWFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+sW3PtgVynGY04qy1MuTQ//tOgN+rdsJS8TEzHa7LM=;
 b=NejodJ7fEpItGAp9+XWxUz2bTN+jKc1PN/iI4s8O1JQ8daLBToGBPmnpsSzCoctDjjRm83OM110CP/j/uptlaKzbUwj67p69w85boN7uPZ5T0/rliQlgu74RDHC1aigQqxfWoKcEbvRH4qy+BIq3u2DeCoDeiauabX8pOOkga6ZVcBnJCRZHbUafTKzUQ+q/OzK5/YKesf6/q8F+V6BFxevRvVfV/YLIrVTMsTUu3E30cJUOwK1z6h45Y+RJZiByGRNR7pH8c7Sc226a9bMHj7SzK+H4mBllTQV8hPnXpgn5L2EfUe3ptqbmrJDUpG6yuC6Ly23319TIP4Ox+HXkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+sW3PtgVynGY04qy1MuTQ//tOgN+rdsJS8TEzHa7LM=;
 b=wFu2JRUti+bd2xSP3za3Wkqe+IKTcqa7VEtg33v75coDZifR9db2hMXpWt7xCHaM1lc+RQ6EiUh3iV9xm0d8FESqI4Oc6HD9tmHJHrzdMXcTYzktd5MWS7sWXOrp63x/+z8OWmMTA1ohg4BRMAMiXEavDb4Wfd7MbIiin8+OnNU=
Received: from PH8PR20CA0011.namprd20.prod.outlook.com (2603:10b6:510:23c::14)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sun, 30 Jun
 2024 14:59:25 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::46) by PH8PR20CA0011.outlook.office365.com
 (2603:10b6:510:23c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:59:24 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:59:22 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: add PSP IP v14.0.4 discovery support
Date: Sun, 30 Jun 2024 22:58:26 +0800
Message-ID: <20240630145831.2023399-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630145831.2023399-1-Tim.Huang@amd.com>
References: <20240630145831.2023399-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 834083cd-dd46-4398-953e-08dc99153b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zrYiogWVxUPSRvAR+cEhSPItAiWKUleU8DJr88XZdnezx6s0s6hTfK1Brnt1?=
 =?us-ascii?Q?Y0GzZLTXKhDeB931qqfc0SdevTOjpL+kQ2lq5fcNVovbCVapCFJptIWkYCwf?=
 =?us-ascii?Q?tJZNzqmnPtiHWPVuk++0HdXUy2cJAw64lNHXaW1YP+EAazdq8S1t4IhlfSbs?=
 =?us-ascii?Q?I+Vbg1yDs7hm1jzaNQ5zBesQPgAq/Z7unBFOJi54BrMOi8EQW8KzPLTuXEm3?=
 =?us-ascii?Q?OdxcLBD0+v7K0gYJRQXDC+3sS6jkzmg3ezpiXtrfN6IVJN26OppGFoj+Yq/e?=
 =?us-ascii?Q?dGtKW936Ha3BY6IK3N3WAxJfMC76z72q8F8Toc3HPFkF1bshkwGKEd2zeYaO?=
 =?us-ascii?Q?2/gjtai5nAHwv4FH/MXqbxoKH36zNYusP9IjLADSxReKoktTmpECOUU4PHb6?=
 =?us-ascii?Q?2maeKSsce8AIeTLubygpocbslkgPIHrxrNDKvD0y0SgctVb45DKsJPXPJNFK?=
 =?us-ascii?Q?qKPu9We1JzOxhhSkMp3ITvgNZ5mQaN6dlSylM4fakPvWnWo/w4hBIaI6My6u?=
 =?us-ascii?Q?m3Um4Ag068SrUYaZuDczF/7x50iEQPTHqE2Bm5VvU6yRNYFefeSL8ckZ0iMU?=
 =?us-ascii?Q?emyoYtsCA7j3Je7XlcEwWQBM3YSpeyTtOc6CjmKZG2Vx0hx3V9vW1nhl65DQ?=
 =?us-ascii?Q?wO2VEG0SKedVFR1qxnDuxey/zgq+15a6mSrU05sjY88b9Wi5ie/WiTFzr4QU?=
 =?us-ascii?Q?ffEW75Bh33pUOOIYj8WAbYIxu5OsKy2raInaxm4DYW3tO3oy32pNaVqhAsvb?=
 =?us-ascii?Q?22ySsEOU9ki5lYbG4vO9VARTudfu61YrHN6uaioRbkgsFX3csdgzqFfKwIWB?=
 =?us-ascii?Q?iXAusM+8PdKTxcnz8xHzCFGx8fFKWBZ0ORL/im8YJbTEP9sSWBAKpHn+szam?=
 =?us-ascii?Q?PVWyeYs/9XSmBHvF24/UhRVBKg+mDg0/1Bdz0iXfWTkTlEAkMr4mHro8+WGe?=
 =?us-ascii?Q?oblsuFADS6W/Znvs65F3eIOvIl+kbQdZnAPwjIdRDk4eM4Fq5Qr26PkKbLFp?=
 =?us-ascii?Q?nRhUMb6zJzxKdn79cagtdlRZ2+6NDU5WlQOxsjkzeLKyyHx29RvTMhVNexWB?=
 =?us-ascii?Q?KA3VbOqtdh7Wmm8+AuHoBNwcDwpqeW1RAokMiNBj80FRsodPC+7i2WlMA3Dy?=
 =?us-ascii?Q?lS8bZjNoD05OGQFFA4OPiJhwwhdXSD9BcpcBTCXw64KGQ7R6Cr9Yauw/QYDZ?=
 =?us-ascii?Q?iFUTHyCWFRewarP6awjXxWWLhIhlaiUTWiiI6AQ9mtO6PljuL5bv6GUOFLEB?=
 =?us-ascii?Q?bRuitY9oLLulXNv7aelqJAxCsHi7C7THKGRHo8rdZtOKjX4v9H10t9hvzfpS?=
 =?us-ascii?Q?zdv8wMYXmCXq4GIZSgPlzhoRurOB4FWD+Tw9Tmv//lcOWur8gKy7a4p/HtXF?=
 =?us-ascii?Q?KvX06BEKI6V4T2yIhiUK4x9I2fn+dmxl1lGXV7mJhEg2gcovRmQbto/Fcfq0?=
 =?us-ascii?Q?yDQdaUeP8+7mTDaDnIJIX6r7c2qa6NPI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:59:24.9039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834083cd-dd46-4398-953e-08dc99153b76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
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

This patch is to add PSP 14.0.4 support.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8f5de513d951..43499789b6ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1964,6 +1964,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
+	case IP_VERSION(14, 0, 4):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	case IP_VERSION(13, 0, 4):
-- 
2.43.0

