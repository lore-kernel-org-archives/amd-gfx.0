Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908CC5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 03:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2967410F728;
	Fri,  8 Mar 2024 03:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXb3sK6g";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EA710F728
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 03:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCZ/QSZA7HcKIyVK1jx2qBm7LQfhq1bJBUya8q4yetLmapQZxMo9r/9mKbb/2pPEnQyCfo+UvdYhOs8h6i/GHf1KfIo/88GJvbHkfQH4maI/3XrovB4prv1copkD5AH8Fv1yOEqfIe2DM4Q2sggd+XWITe6IAuxubK6swB9YE9SzbVJ+aF46S/D5gvIgWD33PtraxPH4MqMpJY48XLB3bdexjVZThJLcwyrQNhNj6IWC31JoMs5K54A8lCdSLxOMUzURQqosaHJLcBnrkjDR3ydyx5Teyn1GVczsxeL/U44ZGrfqIfJ71srAh4gWQXPlFKRGtcbi/VMeH6m6Q0cVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IEtOww8VQotgmfgaquzJSg7sqFXu2arESGUXRSYiu8=;
 b=a4UVgSkQMhO1oAW/y/Y7WWD/VYsjV3ihc3zdP3wb4zTu6hKN+H4dUO49T9lMrkpq2q5asGbwC7KHyPHd1I6jFWnnHBuGimlpZzLmjvSGTmxp4ajViyMjvPydDxYNsCl7/ttxv8p62OBswAAnmAft3ZvsczmBlNeKWLWR1uzCWjOaxq4/LYjwmoARO7HBkdzOvLaCNx6gWHerei5G7eAF3Ykcqj4VZGCMSX5F8+Nca0az7e0pLdTb8I3feWgahsxWlc9yB7gwQVsc9LxJKVi93A+ae+v+s0SASIws6iSB1UtS8e+IrDk8XPVAbwqOi9N+aBhRQUoTYJhmqp+XzEAV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IEtOww8VQotgmfgaquzJSg7sqFXu2arESGUXRSYiu8=;
 b=pXb3sK6gOzVA6FKi8JETYp/AMVDkk52G2W5fFha0cs508whleOHgI3yPaNewLkZlmCe0RIjMHupvrDlhDAMYK7YiuYZihT7RY1CNyO9MLdyxaWD+bMlRxpzTvRUWhkprWeT50pfi3M8PTfjIPQxUCDEPjT72ENAboeKDhecRQg8=
Received: from CH2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:59::27)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 03:26:07 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::3d) by CH2PR03CA0017.outlook.office365.com
 (2603:10b6:610:59::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40 via Frontend
 Transport; Fri, 8 Mar 2024 03:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 03:26:07 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 7 Mar
 2024 21:26:03 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <yifan1.zhang@amd.com>, <lang.yu@amd.com>,
 <tim.huang@amd.com>, <jesse.zhang@amd.com>, Li Ma <li.ma@amd.com>
Subject: [PATCH] drm/amdgpu: enable smu block for smu v14_0_1
Date: Fri, 8 Mar 2024 11:25:28 +0800
Message-ID: <20240308032527.1031907-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: aa25bc97-f7c5-4cd3-467e-08dc3f1f7e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdnSfTi14ntpBBDQUB32kiWRN/s/QuICLQTerDRmmDdsaHA5ruQc8q86uUsKB/r1AOwwQ2uCOxltAH42BnqnvFgfIcXUppcKcw1ttJ1pbWZZ9HEVJBTuM1oxdwjOHdiu3BUIx3IuoJbdFUZYmR2ZcdOluSGpIteGI/V2VnwrhXfw5df8p6g7JQ3LzVFb6r14iZcG3vhUBIlY393sy9qDao+aJit7bGGGqe8poeSOaj9J3DXpWP3mUP4mWUUBNqr039vFEtTtti3Cvg2CkFMxD5q3YsUoO5wIZJ8awq6lArBhW+MCz56r23tW5Y4MHMlgD3zfyMnRCiCENlhQaZqXZqpnE+cdJk79M1Bfdwh83pZ6NgXWhqOkgXgwv1vcNNQ1qmfS3N6XpTT4de+JXvGMyVy7WGRlw1gzDFdl9OSXvcXkaslFE5/iTUyvOKd0szWlTFqOMqCX47fYrgR22AMHpN/aqhgmLUuRj5dYxmCzgja0ioa04xUox3bWQWJA3BxkczuDBD3gdBdUAy+o8bEO9kZni7HnAQdw6MacVBisREKvXm+lkBxhkWWlIqPo5zSre2+c7rsgSA6Z5iaW2xVuDeexgg/W/O3Mc555WXV9XRPl8ctTefzvoIwek5i4OPe/LKJamaMEhxOudJpuR1Cq+bVw2zfG5McK0CzvSqld36bRpeR92C3icSX+//PQ/9hQzhiirJlgnoJBOLLmw0w99Xvu2TKXnTpu/mpik1FBlG36ZH1Nrt7iRKYAeNGKVgBh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 03:26:07.1592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa25bc97-f7c5-4cd3-467e-08dc3f1f7e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

add smu 14 support for sum v14_0_1

Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>i
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a07e4b87d4ca..54a0414f22f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1896,6 +1896,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	default:
-- 
2.25.1

