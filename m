Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C95CD128A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18611112E7B;
	Wed,  3 Apr 2024 19:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uju081ok";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABE9112E72
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXkgpN2ysDvYFAOOh8LIbnPV4foOxUfuU0TKKt7G72BhKcNqwGdoTJHMH50spbrp4JCZXCSnMwMH17mHs0Fm4kHYOsXwmYmW8rhXUcUl1hZI/jO3v2ksiw0jwV46OxMlRCH4rOEj/YYNf/ZONyu4tdH+7LXihStAYkvPrqHSOo0AFLim6zCEbWafOg+W4IPwbEo+Iqz4pjwsI6A0UvhltWm+CYpyStWWuh8U1xwgiJ3DANj7Pj38lP4SLsqhint/nx5ymjLJZZgXkcJ9Rwd5UKFEBBNbaMck3oPV3idec3PNJpdhOX9GaZOOCBMGzyT1Hz7PKXUlpZ/DY6IkEc2TSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAhioRCnykQW1ceIIzyL2MSWVDe7SLYrYb1TUiHhSzQ=;
 b=UCzZWpJBQNkyqGaEXHhYDdMBGEk5mudvqhBVrMclY75+DlT3yYfCkvPVhWhzGuGdIpYB7RQChXwmzV4BuXFoCtfaurx0oIuba5xqjgW8zhEASfWUqiMmwbh2PKRmop6I8Sc4UR9l84o1Rg9Q/PY2Ozb5CKgR0DflPXapB4KHKsU9QmF/i1r9mqURupDmYoIISdH3KnjQKoAN6Dtk/ajlP0w7nycdJe+fmDGqmmFPJS6/Vp0zvLYLw0oZLmzLUnJsXnSlFO4Uj11NBdcPNMKYh/P122XaSOxknMSnohmeYfDnomm841hTHymhioibMRSH6llFxKz7xWe/I5rfap1zrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAhioRCnykQW1ceIIzyL2MSWVDe7SLYrYb1TUiHhSzQ=;
 b=uju081ok2eQ/oYufRKwbxhR+P2ZKW4AZVn7w32ZMu9tGBjw0p3t31aG2538CWq5cio5mTr6e/1gaVoJ6+j7XVmB8J8AM3gsmMsBOrETKuyb0unmhY5WU36CGelINysZ2p6DbanF2l0SpgkHvspdtJJn6/YHkwqbqgeK+dJjKOHA=
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:45 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::43) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:36 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:35 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, <stable@vger.kernel.org>, Alvin Lee
 <alvin.lee2@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 06/28] drm/amd/display: Do not recursively call manual trigger
 programming
Date: Wed, 3 Apr 2024 15:48:56 -0400
Message-ID: <20240403195116.25221-7-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 3848f28e-4b7e-4619-7a39-08dc541778ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcxWaahdOynSuVynsTzhi6U6Su6vUwi/LJVKTxetzrn7rLjuknR3I1PyQxXmRjCk7sx6WlN5+1bd+yE7A+dF6GC0jBLqp8lNuFthnXn/acgGfeQln9S2u5F09NDSj8VDytNyYId7wtL/jJYka2ELbsM4tWtL0wMd1vbKtXdNUJGgfKMSUtvL8vIZWTTF/xq6bM/I0IEQskuv7PFrAUCbZEJlyM8yNsIjpJ5GXN7lhoGfQeqS2XGa3aQDq1HnIVsGTwxKhZMItNZMe7mIiEvPtibzHvMQAFvh0Wq59dVpV1VKGR5DqGjBoM5jSa1XQl3vxL/bpyUKN50GLUsvXFsyGpyRwh0aCrYLohXVWIgqvg9H9a4ozyaXY7Qgb8fHrkiinSZU0O4feLlE/BKwn3d6amZJRBVLw7Ew/5QdbrX6Bn6+1b2G/dm8JQ80EwNzKRrV52qZOKPDB1z5cQLzsRmJ1JlOVX05Jv6lS5xvCbiD5ebAMIe3LjIRQv6mbvLCKwEcSfFXXY++u6lG/GZArg+PAATAjLEOr6Tfa18RFFFi7MS8liojeKfXkXuuDQMA+JvCi2cFUlp2nlw/ZuSbBP0TmKD4Ru9YdEpv30dx5Kmrm1cDorMZwZ91DeGEJMmlPEyoobmc+0T7BdSW0ETIdZFa/tOpqVWxT7SEBvNUJx/oe5RrQgIaf9A9i3K9DrwbqdaGGQ4TWZpc2oddmNZHQY4t/+btq2wH6uprTOehZ5mM19DOlLRd9IKRH/biJEs94CaD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:36.9240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3848f28e-4b7e-4619-7a39-08dc541778ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
We should not be recursively calling the manual trigger programming function when
FAMS is not in use.

Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index f07a4c7e48bc..52eab8fccb7f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -267,9 +267,6 @@ static void optc32_setup_manual_trigger(struct timing_generator *optc)
 				OTG_V_TOTAL_MAX_SEL, 1,
 				OTG_FORCE_LOCK_ON_EVENT, 0,
 				OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
-
-		// Setup manual flow control for EOF via TRIG_A
-		optc->funcs->setup_manual_trigger(optc);
 	}
 }
 
-- 
2.44.0

