Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11B2C3DA7F
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 18:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5574F10E0CE;
	Fri,  2 Aug 2024 18:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uMSrGmNG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F41A10E0CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 18:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyNwZwK/OqxEMOpIkHpPxWIkADPPP7tPOulMQD8AErBnFJzdra0MwtpCL8LoIDJGUFCwZkkQ/8hSorOZqxGpa46Vp5UZ7uC9OerQWR+22pM6sIoXQ2NOB1MikFOnR0iFJysGhdC2+pAJu8QKV1r4AGrMjTL8mUzOyuih3QjEyIi508E71Lg39Gy/TGbHDWay1FEPdC8cakYvcFtjfajXw6IyXQ+maiL95ZI9hAK5fjytrtAh7SUdoUGzmGo8RwY6GGVge2SOXRTyDCU+kmRZqByHPgMHXW5I/KhBW5H3Am9fsDfJ5QCD46yaL6It84YFB734pjuO9d2QTFJgLoHlHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gAWHwQPUgIZF+IJWfp+RB7hUXxs5lbQsvrF0durzy0=;
 b=TxKGDJVuQvs3W19Ywz8ekZAWF8GG4/WsKbEQfaPK2MDoh22SioQ/hkryb/Ex1xjGWgvVtiihqE8G7dZP6akooQDqFJCeJNq4Woli3h8spQguIAB5ceWPVU2zZAsdzR3zO96/5uIQQ7YwwK6jM2G06LjbvceZwG9tnDSh+UctOuulVrioAmIr0C62uZEO0mQOk9tJbzfP97XvLR0XcXNXIlmErULuxODDBzEBVD+khe0qhYMAp3Yi/sEpwvoAY82P8z8uBI5BZCodMerTD+1zvGsaOf2TrqQhUpxr+qQ/mWgLkqgX+4t8KrbcXfArxZOZE+NsUGmnxZD1J9PJCYEqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gAWHwQPUgIZF+IJWfp+RB7hUXxs5lbQsvrF0durzy0=;
 b=uMSrGmNGjrjH6TwcONUOQUHBnAQ0g9LdI3MZQHS5OAP8MqGc2jAPrDuCsmfjnvjIroTcc3D+WXohohvgGIZxGx3KIskuMjY/6U41ymhV2TUzMKb5HlVNxgLwQigQXkmbT7zkYFMRCFl28Zqv4QZm3ffK4XxZD/Lyylfq5phBgUM=
Received: from PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::25)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Fri, 2 Aug
 2024 18:27:44 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::64) by PH7P220CA0003.outlook.office365.com
 (2603:10b6:510:326::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Fri, 2 Aug 2024 18:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 18:27:43 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 13:27:42 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Vignesh.Chander@amd.com>,
 <Lijo.Lazar@amd.com>, <Yunxiang.Li@amd.com>, <christian.koenig@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: Extend KIQ reg polling wait for VF"
Date: Fri, 2 Aug 2024 14:27:19 -0400
Message-ID: <20240802182720.318993-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: bad52e44-aded-4fbc-262f-08dcb320ccc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xg0gFO/CnTQnw4pIuR2FzwcPSt+uZrTsIXgRYoBOnVfyQvYKofP9z9faqPnb?=
 =?us-ascii?Q?mgGdj2HIqglOLpC9axKd11ILuZEyWyzimpRxaaW+93GnJ8jrCR9mZ7RjAljB?=
 =?us-ascii?Q?OkhURvUAizrpUXRiz0q1K05jJFJ1nOL8WH3WPo2CaXqN5NpL0AEILeP05879?=
 =?us-ascii?Q?Xhf9kJZ9S5apHUggoeUy3NDRpS3vD4Mgb98zvDjHbaVvH+MaAoI8vPeCTaHd?=
 =?us-ascii?Q?OL6L7jfkOXRVdu3kDgAWdF2cAm3dpcqC7n4+ruAxzohmCb8jQWcgJFMlGurJ?=
 =?us-ascii?Q?yqbIlQFHnzwzPz0TjZdR1nF51Dh9VVDNXaiqvOqrE6QUfWZ+jy2umELqkjog?=
 =?us-ascii?Q?AkO12i1DBXQ14FAsfDwA99ehA+LBga1om5oxRQEM/k2B8KQ8gYx1h0WSeWHN?=
 =?us-ascii?Q?GgYciQldeKuhZamTRldTobJ8HZwc0PY/cc0RdHk89Ofhieuo32pDf/eIj8VR?=
 =?us-ascii?Q?9xaYcmGtn4/QChGs4PtLLFFN7wkfKY7gPpvbqCJb+zwLZC0Dq2I/LUB4Olys?=
 =?us-ascii?Q?yNjxNhZFVng6JZlrNX/aWZOSpxLE9l4/+j1jTGKgt0jSnZNdwIYHgA4YEi51?=
 =?us-ascii?Q?IV0+TgC4oPPCMfcIqkQW7V1La/+4D96rBQ8tdDMstKdSL8wpiDuo/5miFq6C?=
 =?us-ascii?Q?P/quKDrfl74NZGIN/IE9ypn34r76RyZDwAQTeqYWoNdyMIO03c47VvFc9uqs?=
 =?us-ascii?Q?tXcAiQbE8YnInT8bht0I7Gubu5KhAhJ5ROuqh6uoR2QhEd7gza1UDAYlUBHC?=
 =?us-ascii?Q?VaDOvDipe3rWkTeEfhaDhefFBiMfd9FAi5GQwXlTCw8HCxE/g5FRimSwJNzY?=
 =?us-ascii?Q?wcVGKTwZkUekrC39CVOuefRlQQOKicLym0N8Eje4/Lxor+hDoNQv4FHqNoOy?=
 =?us-ascii?Q?qXotK9QYlsg2QYZON7MgefyJEDBjNYoYEv+3TvJL2JzT0LxLqbfFGpq2/F+S?=
 =?us-ascii?Q?ACEPuHlyW8O5OHCd8DHO6jTOGYuqvQ0hx40tO1qc+SOc0u8Ehj8fH+ElgkMe?=
 =?us-ascii?Q?4qQmRY9m3oAVjcOOZN1/mMtDcYoEZq5kv2Wq7hFUSltdfRKV+utMrtILnkpQ?=
 =?us-ascii?Q?wmVU5LvL4CUfy0PhupW/Dps2dr2RcTix9y+Zrnfs0usNV5cqzOugfNsms+Aa?=
 =?us-ascii?Q?t3lQvkY600V4JX7+uyXOL0/FHMLPpywx/8FzuwOoRZ/5Vf7VND6h+cwWEGH1?=
 =?us-ascii?Q?ixXl8hzsCE5QibkP2sXzZ8Zxa6DRGSccM1GQBotlTD9m25S+as5pIH/uRq8o?=
 =?us-ascii?Q?PirxQZqkwGcqH02Q70GzJT11uuvhpLjrlPeZt3VBwYc8q5YvRXOX39Tbgywe?=
 =?us-ascii?Q?JnTNAO8XauBns4jhNL4sc3AQTA3Or1VtV6x0Y2xnJSThDf1KlPr0APjdAm3G?=
 =?us-ascii?Q?1Ot7LkKvOqyHWrbJ98/61dZfca+FPylMpDHRiJMW7YkOSWU9NTpxCh4MsCHZ?=
 =?us-ascii?Q?mo7A+mAiUP85s+amcLHsOjIVDjvUhIqi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 18:27:43.4300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad52e44-aded-4fbc-262f-08dcb320ccc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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

KIQ timeouts no longer seen.

This reverts commit b4d12cc00ad69e8a0dea2ece7202bacfd8b894fb.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 137a88b8de45..206360503136 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -347,9 +347,9 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT 1200000 /* wait 12 * 100ms for SRIOV */
-#define MAX_KIQ_REG_WAIT (amdgpu_sriov_vf(adev) ? 50000 : 5000) /* in usecs, extend for VF */
-#define MAX_KIQ_REG_BAILOUT_INTERVAL 5 /* in msecs, 5ms */
+#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
+#define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
+#define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
 
 int amdgpu_device_ip_set_clockgating_state(void *dev,
-- 
2.34.1

