Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FB0C25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24D110E805;
	Thu, 26 Oct 2023 14:20:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF81810E7FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKtP9203jvQuBD7nPPHeZ5TXkzqKt9GQa8dd8vXirsAK93aopGwK0EDNVkBs+r1PI1nbxvZIym4nu+94LvWZw4QBPcrkS6yuEdGH30ejc7183BOtxfpxG8v7S9VmNjiA6Yb/4TClL3JpZmp4rDQeg7PGMV4f4NBG6/7NLxbYPxVwbNtYRQFlVsqxIN4/1Ciq9eYu2TTPHXqOrlZQSaF0UUsjhirhddusacsQxFPhOjnP55AE9iGhosZb0tFdNTH+c+nvKpzy3NstDXVsN75R7x5dz1YJhVqDLIYfssX9ZLuqSKz5LYMuePCcvTWffWiXg2wUnGzQoU6PRYV4MKbu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=901eRt0D/CB8oO/zeKMnSgfCI6CJTou+DdNo+vT90eQ=;
 b=NmN5CZ3faTruDc25egrsgzyNCRmdVPfHJin1TKZP/UYWcQ0knZ7p9roPVrMcK6QvxSKXkyxD+rZgH08o6hgUowb+1ONqnDgBSBhUiW7hkUbzUYDpXjec6roKndPYuePsM4hk0eBve7dPURetXbZRt/aS0kGtMbGeUrW3bzUAMDqiz8okjK1h2/FvHT8XMAPKEvt6uJZlou/PxgYqJfTPjwZkL53zxYIeGFmDBxjIx+LyX8/IcNjS80jbjPMoEgD5LOdOPkTSaf4aJHAWze1txAmxztdE0+pMei1joVyoLHuKmQZrgMV7K462uTiM1PRxt2i6GeG9A8OaXDJxjXhmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=901eRt0D/CB8oO/zeKMnSgfCI6CJTou+DdNo+vT90eQ=;
 b=yGnDwNYY5KY1dTssrKlYLFD+TZBOcR/lYn0e0AWXQ7lZHoRpYHMvGDebOfEiyYSrTmUpnQSFOFzX0YWQBZcYi4IW5NiVjMZNKI+Dm9DPL1TMRK/Ux19NX90lIQMTz00S9XicH5wBGK5dNmmQ+v3o7b7G+LUaMXP8fuh2zp8Nhqo=
Received: from CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 14:20:40 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::f6) by CH0PR03CA0086.outlook.office365.com
 (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:36 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:35 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/25] drm/amd/display: 3.2.257
Date: Thu, 26 Oct 2023 10:20:03 -0400
Message-ID: <20231026142020.67861-9-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d71054-93fc-4065-dacb-08dbd62ebae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOe7AYuoUE7nVlZ/WrFsP4BdJLhzwKiSTZ8tKPqZOp4fRyOOt0loT0RiQtvx1wji2damh6/ztcbcM7Ax1P73DSs9oaklMHPiCJQDd8sAK8SWgmqGl6OrUJSps5n7Wt8D1UjTWQT+I2jXruH00BOWHtiizM/3Ic8D5XSlfL+ENrZLYZV7a0c66FogISj4o8at4atr7xhjVJsopFsZ1yH6n7kY9WbHjXMyrpZnJQXzAj7JkO/3zp3QT6YLeRZ1u8zu+zqYpIZDb3KaOANwp+q8iiFN5rVRDgjjKGM0anfy5BZiKu3HexcXCeHK6l9GHJ12U8Gc4Q3aKPsKfCBtSYv1K9FLAvsIsIlulB7okMVBiFsejmmXCG137oG7d+RcFgO87bORw8UI0y6Bxk4cyvDyXPNi8B6rjotLHfi3HQJrkTxwxilexxtmPdkPIZRRI3B/aFZ5cxPIyYMgsi532/CEr5RY/Kvjqfn2vavsIICrGu5oSiqbJpV+VXQBJKumSTtj25AjRO9RfkOpEO5bbue1HKDMqc/mhYVe4M0aie0YRQyVRD4ks4zmw0R1URuxVXgyd1PeJ18CjRl2F+CBgKzj4Vh05q1600flz/F81h4i5Bg4ZI0BsDiM5cNsdaZfCR10JgcT2Q9tkyzG5tWpjs4ALooufhKEzC0SiFhbeI3G8yorp2N+bS/t01W93E6EJLY46BnNZL5vAfNhjy2SiuzzYNEyEajrWUn8HwkGaN2quiXfugXfcVe7s3xqNI9LdSSkK3EpVK0INcewQxID8vg0bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(2906002)(86362001)(4744005)(83380400001)(36860700001)(47076005)(40460700003)(426003)(81166007)(336012)(1076003)(356005)(40480700001)(5660300002)(2616005)(82740400003)(41300700001)(36756003)(54906003)(6916009)(316002)(70586007)(6666004)(70206006)(8676002)(26005)(478600001)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:39.3894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d71054-93fc-4065-dacb-08dbd62ebae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
On boot disable domain22 force power on
decouple dmcub execution to reduce lock granularity
Enable fast update on blendTF change
Fix blend LUT programming
Program plane color setting correctly
amend HPD handler for Replay
Avoid NULL dereference of timing generator

Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e6e6377a8ce3..220609361eab 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.256"
+#define DC_VER "3.2.257"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

