Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9EACD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 05:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C99D10EF04;
	Wed, 20 May 2026 05:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZwXb/E4T";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654F410E610
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 05:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUNj2dx6IFeb3hEt/YcB7c22RuVPPhYcq29rzKim1Wb9ykIHoIKbkJ/Tf56ZM0cU9r9FzXVTFvNGfFHuLJyu4HW+8C/rD7c4QTXabi698RubpVnHtcBeJNBEPMlpIpGpLmiCyJAqxD/DAYJochaIq8014extOgIgrl21S02Rrmj4FNAntL2rD58Sqc2Y+mL5YV2BjfDLgmWk/ED29MB2MPmu2xrStcxuu0/8nKPn9bZSXxEr9FgWLzjxtP53R6WMmFKIBcE8LdcBFlqqsX+rvMu+htlRP8lF1+XsZfDMqRcPUvRaEntrX5KdAiEK3MbyPo6qv56tMleG8GI2w56wSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j37R8PX6sjC2bH/fxv8B+4Mce2RmILbR6qXryUShfC4=;
 b=PAl12xJz1g/ZXiqAy438IMZMwIOZW1XBVwpJotSpLA6wWhlB7/Gl/Izg465vFuWn3zhTDybMHb5NxKzYx5teQD8AaTl1MXMA7yGneEe3sOwnpTBXKSCaf1RHJeDn7H77dW9d7QJ7zZxDu5Nida6IRgbrwl76gQJMkAKRncnTkss/nYLxm4rlOVQJiFvMt8Oug55/HIjBzLaKshkhTGSd8P+SPSKFGUG7fn/UHOMv8LHwW1b0z3cMM5b58od8RtoCKGhaFM/EkBXJbAUoovm57oNnFyNEXbMuYLJJWvheZ3vnPyaplapcFFYeuWK3t200lz9x7JqPfwIlpiYEBKMayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j37R8PX6sjC2bH/fxv8B+4Mce2RmILbR6qXryUShfC4=;
 b=ZwXb/E4TMkkDhQDWxKf9+Lc/rVTQIPSJC/5kSkjPtJxTBSKHcsJpufq/zrbqZmHrcNrpJI0ghmvMH6AOzF/PmlOVU1GHxHbmkhyoOkoS3mYPca+oUw1LCKyTMFdPD9BBfvCVJCp84/Cdw8fv1erB3E9Ql0drOhcqVaUDzA2dPrM=
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 05:42:29 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::78) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 05:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 05:42:28 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 00:42:25 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, "YiPeng
 Chai" <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Add parameter NULL pointer check
Date: Wed, 20 May 2026 13:41:51 +0800
Message-ID: <20260520054151.268430-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e703ee-f446-416c-b1ae-08deb632945d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: diIk6bAyAniV5iz9XUtECC61YW5skGXfMi5ZeqnkZtVdsSkVCttNbU7MnuPsmsyWmW/GK0MsNGvAooKzg4eHwGf1LhJVUFODL532wnBlJlIWgqKYw28ZdM64KdS0VH9uNhabK8fGpouieWW5bpS9OqMf9O0iWzvFu60TkguopDZd+FuD5Y13n/1yvD65lvm+QBION4fPedLLGWXtOaiz1+Oxe2VYKPeQzGT8rPjYIMYc5BnGh2DQq+c1EfB+QkhqIfleb1r3MuguP6v1GDI5VKsKcasdUi828v2lBjMI9bu4f0mgPYdl0YTSy4NQddBnzUQa8+BHKrr4cB2v7+dMvdN1nsjP9+LaPLZ9ghQw3KbcY431D42Za0VfwU6K9AB1Y1vtvA62sYizFr5OIlwVImpUnUm5j+lAlvlhkF+2acQPYYFPgk81+Eupm1DrQxggGaJmUOr11iyTZlKVKBAar+cC8KMBPlnbiUACDhQuYCGfneqSqUPaszGGGifGVEE6rhPIGt5lEPCNV86xgMBWAY400wzoPu75Lhu6UuxWCkLlMqd0aj+QlFnaWrGpbo7eXaWUhtzLFlBrKiVhAIsJ2eaZMpqSwpm34cixewJdYHW5JaXd8IUWzjF1z0K4EArIFVtxmgLJzgEAsth6lkCwre36o6TQ3lriIbkNfYPsU0mZXY5ZccMpyRYHKHZPoVdf6H2IjjXhrJDMaqHaPLZqxzRM5hSo/0ECN2N8DQ0l/GQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IAEyIZ2b9uwaSOX8/6aNtR2jTKiWtmrX+XNr6rm+4+sjzCbaUgJkJdHN+/6V8en5rR1SzwPUWDZW5x1q/tzr51Jx5NbUcOmB1z8WMKgTWLIAzrE2XqpviCZwP3StBFV8y2hwxtqp3H9O1avnmSvI0rYmM037GQ92YlC8WRpnHs4iOo0+koGlxCZ+f80qSXR43gjy/ysl4t+ojck5DEhjxHvzoKgKIUReDmqcrN+DkqR3bAgiYgEj3QeOb3/VSiOzRiKWgVqokASc/RyrwaYoFbSSbl3WAGZGjm/0+c6YVY68+mqZqdY6xMJok319NgKpov8Kxpv+Mhd/HsnlZob7J0a0pfoCY0fbTsy+9WGGL7RQqSCyV9aIk38+rXPYZ5Sl7PRff/BYVKoi6m0dpa60eFaD0X1HTEn8qpglq7/y2Nuu72yOVXnjRl8k4T3eKwO4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 05:42:28.6176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e703ee-f446-416c-b1ae-08deb632945d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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

Add parameter NULL pointer check.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index 44009aa8216e..7c100630f096 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -55,6 +55,9 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 	char dev_name[20];
 	int ret, i;
 
+	if (!ddev)
+		return -EINVAL;
+
 	guard(mutex)(&xcp_mutex);
 
 	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
-- 
2.43.0

