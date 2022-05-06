Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAF3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B581010E713;
	Fri,  6 May 2022 15:44:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3369610E713
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVaLlrS1+/Kzjn25yxNQ50IvsP7MVyIg34yA0CVjEYrgmYE6R0LxE1u5WpweTBKay9s89V2IPBKbkr/co53TPzKJjk5SlLyDuzfTPsGi4bkwZh5xv9tQzA8tS7s0zrK1xgtE/P5t+Xx5E964SLgGP9kKnBymxKvRf99Wm13afC3CXGbe+87KBElEPImd3QJWZjOi5BizWmGfWfMTG4PvW5HsXKFHFsNe3G5fBV0S0QuuUccO43x2UYYjrJk906apAPZHIFl4WsyPyirbUnQrVA1OWMNo4+XiGyvFTZvIoT1ZR77VBE1NOLD58/gQlBPG4uHPxYuJjeUZAxJ5N3U4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Rii76LdYhcQXIMMTxRZPS5nGY2WjbRo/IR4OPJKgF8=;
 b=d8vdLAHdJ5dNFBnGShD3UmoJDZWO8g5tNsbqf417eBP6tX68nklkQ4pI0aBf6A9ey3Mi+Vtl5VqIYN11YNSbgcupOWUc3fT5Q6P3WebpMQtzT+GHXYKR0p9b+ZzEPPHk5jyWswZL5ly3/zmQc0H+fntmFGlZzIk7R2pQ6F2crF3pp6YIUoT5N56y7iXHXxlle/ac9VhMcBg9+N4FZYRyDWJD79c8fWkP9YVjHB9HhZKWtj7RwiMJwj2ZTvar7KmIf3pHmv3BPQgHlHTkdfxc9s+cP+JovV5fo8Jq211TFAJJitfuRLnAUG+cNK4lMC/Tx3se/1a3Lr6tnM8QNn3xpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Rii76LdYhcQXIMMTxRZPS5nGY2WjbRo/IR4OPJKgF8=;
 b=ppk1opVXeaeMzN9d6EwAvmVgwMn3yOJXOq/navkddsMGMpfaZ9MqI/55o5dxLwSjQPo4fvgm6+Z+9cbPrUJmfENNhzRlhnZslNvXYv6TNTuqSzFL5a4EtIfgYsiSOQLH/oZnkMWq2kNMlY69dPXr2ZP5hFdzokqjGd6BniKJcsg=
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 15:43:58 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::f3) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Fri, 6 May 2022 15:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:58 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:47 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/15] drm/amd/display: 3.2.185
Date: Fri, 6 May 2022 23:42:14 +0800
Message-ID: <20220506154214.3438665-16-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 008eef22-8a09-4098-d929-08da2f773c26
X-MS-TrafficTypeDiagnostic: LV2PR12MB5942:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB59420DDD3DBA5128206C6C9CFFC59@LV2PR12MB5942.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8OLmI5GgFwWpwBfB9OEYBHax3cmK3ahUcfqW82fd8joILkGrciCMDiONCSdqJC2LMVvuPNynBySG7wAzbhuAckHyGOL5VJfVb7aGGshelARKLF3KSl5ecR5rXCR8bKjf1bqGJOGYxj6IyLzHsPu9ESWRY42aTwjIWPekbmEXXC31EA+PpV/624sWWoUihAe61IigxVwUT1APGnIokYemCcO2JbBdlfhnWtSN5inZZNIlWGpVg7kG4GWN7OuJ0cJmQd9uBXLwKK8lFt4V/TTbTHDeWJTnDm3qG7SXTjgKSc4e7Hs+gJQ9H/O4cMVez+txecGPBnUa39+Sv1NgrIBufFPjPFmhms8wrbltUUnsM8rPeYXoqhSvEeLwyAg1qEisYmA4hgzjL/l2gZ+F8Jr/+DyWr5aI4nJzyrzlH9k23JcbJMzabkFpzvRDfpZNgQZ6YiqCak5raNfIpt9ZsB4YMnBfm5cgoC7796zO/56Qo9Rt0+tKt7rls5v5jMpz/AFzc+pBocImVerAeMNBrxwMG0dkm+ZsiR2DA4iMFbtAu58/fyutnPznvuI7nmDO51DplNJBTf9uUNLEF42yrPEKzVFBGXiGB/AEpzKYvS95G1t6pfSUbjpz9Q1bKBSmN+GDRWhbI4F0hMa3/ATu/aacUbljjLN+ZoHiDASueZWUQ9gDvc6rjDBRRNrs/WKV6magRUbfsCYt2y1IGQ9h8W59A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(44832011)(83380400001)(6666004)(40460700003)(336012)(1076003)(47076005)(186003)(2906002)(16526019)(426003)(26005)(86362001)(508600001)(5660300002)(2616005)(4744005)(54906003)(36860700001)(36756003)(81166007)(316002)(82310400005)(6916009)(8676002)(4326008)(70206006)(70586007)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:58.1264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008eef22-8a09-4098-d929-08da2f773c26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Refactor LTTPR code
- Fix PSR after hibernate
- Fix DC build errors
- Fix IRQ unregister error when unloading amdgpu
- Improve DP link training
- Fix stutter
- Remove redundant CONFIG_DRM_AMD_DC_DCN guards
- Fix 2nd connected USB-C display not lighting up

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0f86bb809e04..26c24db8f1da 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.184"
+#define DC_VER "3.2.185"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.35.1

