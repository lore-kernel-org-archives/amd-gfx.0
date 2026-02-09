Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC47E81BB1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577FC10E3DE;
	Mon,  9 Feb 2026 13:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FUfcCHrw";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D39110E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDmMa5X5D6HdTSEV7JQadfQZJX9akT0yGEntFLSEroJmG4PFjWfKVaiicgrLlIXz9Xyr6/LAc3oxSAGLWhoz+IkMMzg3r3RCzf/chOvmAolgWZEq3T87b1a+1hTa45/jkxbz/FQn0RTMa2Cf4sEt0Jzkj+FouvJOt14y1/bci6xkU9gz0fr8lfwtHZveYK5yH3Xgz6qvoo0yxaVdfPiO1Px1exIy5xEK2p1DlG1v0YeuH9SSTsJDkDRQ5TDfDqP85WtxZjpsaih8YU/5n+fmiplq+fAcBL7mclK7zbXkYUoQWvMJS7tM43REX9gK/cwS4Ueq9LT1qjqE9HHa2Z5WEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=NBYnagMgU5zxC0+TGgxUZya1w8qn7Js2rGWLEYGRWbHK2buyOLEKFx+LV50zoLgb7kMtHmg9vk6Y1r2Li70D1IxUjmcaGTSW2T+UuHTLST0hqcahc3CTRyg3ZS6KOnaDlmfP7mb3MtMulnDAYm3++6dbu3If9JtN+iWSkMp3BpDSLrZPv7jLvK2gNA4QRFct2waVqRUonDEv2rHngt/YPrcz29XhJ0vY8HK1zvDDuWfm1FRTkkBr302w7ArEQc6LhKJow74uaZC/ktjvTNZnb7UJ2ohyQAuhBdppkwL8y1Sr7ZNcn2eelcfjNcWpXp5HfiIMdp1Z+OPX7lRT9x8k+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=FUfcCHrw+Yih9AbjKdg9cvEo/qpVF0NAtPgyDYxOrvgepaucElnMf+Djjco25d40MKjhCBJnTrBmSKEvcItVOSoNPA1ISKWvoSsDuht/SPngb5GuiDgrziDHClZJHMfFkjJRgb5erjhwA37ZkionFb9dto2MBmOThhKqNqsK9AI=
Received: from CH0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:610:74::30)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Mon, 9 Feb 2026 13:04:36 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::7b) by CH0PR04CA0085.outlook.office365.com
 (2603:10b6:610:74::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:36 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:33 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 01/11] drm/amdgpu: Load TA ucode for PSP 15_0_0
Date: Mon, 9 Feb 2026 13:04:03 +0000
Message-ID: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2fff61-4fec-432c-1c47-08de67dbc6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xtdDGfHodMd02YY04/DUfy4uZw2HzAHW951ocLE8MpMzGOrJvP4NhfsdiD+A?=
 =?us-ascii?Q?8++SQgb3B/nLFizljB9N6wXPBCRN+E1NdFUW2qKkHacjn0sHQcp6rgliooVY?=
 =?us-ascii?Q?gIzdVtC0wD5Fa+rwZnDaatJd8kq3m48f7mSM7cxyqjae8qwXNUWAtRo772YP?=
 =?us-ascii?Q?zqIs9aUJ4pPlZFcWSIuxf4BQPWh+t3wPnUH8TYQarEU6rgzxSMpgrYMiWWFS?=
 =?us-ascii?Q?kpRla/yo7vuS7lZ5HtRbu70qkcB8wcp2m0AyIkHnvpJyQO0rIvNpVKy8NwIm?=
 =?us-ascii?Q?9iL7/jLexNDmSxSfWIK167gurgRolv9kV8pkWeA9L2KehmdQUaA29yOl5STF?=
 =?us-ascii?Q?E3WD5EQTzECbfh1Pfkz0OOLI4+hVZOKcEZ70T2v6nLfkOiTg6oacCRUHMQD0?=
 =?us-ascii?Q?ubeLlTX4U7klr55SubKYOv6LFFHGgb6D+e+1NH7ImWcrZ+VnK4Xsm9LINCLt?=
 =?us-ascii?Q?7eqQpsB7+XvF0DzJr3EQNYewXY5bVAteO5OzCLJ1KJbhjpMIaJNdFtlAwfFP?=
 =?us-ascii?Q?BnLSC8nN+1sAdgMJJDvIS87wZ3V0l18OnjcpA9dgZFWMu19gKIp0AWYi5jU2?=
 =?us-ascii?Q?paZ4jylD056un2z1asO+uE3SRGZAPkCi/1IWGI+y251vir6tVJ911g0FhZEF?=
 =?us-ascii?Q?fH3UCtsLkh06I9T3hVS2f9i12szMpY6UCJAs/ugrXfYCRwRPzQWcb3ItqFJZ?=
 =?us-ascii?Q?Qty35w8I+GGLP55rE9TcfnyiYhCEF63CUZN6INlgHOlQCM4/VYB7OfCVxQc2?=
 =?us-ascii?Q?PF5LQ3v6ZP6mE9fG8OttkxMjGE+g9bOZ5EbpaOOcRa2EYCSpw7plJGZFvRBU?=
 =?us-ascii?Q?/MFruCUP7P7uMvXInXA5kiS59kYHVxc/UBtoFXlJ8L7qmAWGlf8QnFBq7ZX/?=
 =?us-ascii?Q?+zOPMqCXcBfBqItCub3Ps5QrYTons4N+V1fQjnJWW0H0p1kl6eVUB9L1o8nq?=
 =?us-ascii?Q?hlhdwfeU2zyXbP0l+itCpmP4X4clVqrvbprtCoyAOQw/TVqwNaAk55ZJ3L7D?=
 =?us-ascii?Q?0a6aR1n3fbCEdxC+5tTpFWP3XnywNknHGzT6Rc7EpzhRNQZXzgl97nCJYuHG?=
 =?us-ascii?Q?kaLtqfa9fRF1pj7mbU/9g0wWQldDNCijM+YyOo04Abwne4vouvqU5OTv8wk4?=
 =?us-ascii?Q?vWaJOgqx+AniFjxO3HByftJhu4RASHRfih/W6B4A+22pYIvoy+8xDOR/pMqL?=
 =?us-ascii?Q?Lu7BZIYs3qAyypnwTMn+JPC3FcdUbU8CCLtldpvj0xJD/IvOqUWRoX/S+11y?=
 =?us-ascii?Q?mrPUwbtFsjw7IYYnENo+cWb1gy3s7OBzbqQgCfEUKCxk/iT1NhybRF3pUKAK?=
 =?us-ascii?Q?9W+pjl9UygCcYie6d711oh0oODK6wQUA0fpsp/08O/ox8SQbJC0XqlUj8e8q?=
 =?us-ascii?Q?Mo7+OmIcIkli8DBKK343ZysYJp8HpB/UEuP7eETC1kLzGDdMZRxNRmzqcOh4?=
 =?us-ascii?Q?yd7kLJ98GXMsR/bi/ddz9mPDFx1N5GxYpdJZywtcxNIK/73VNuyqipRgE9Rq?=
 =?us-ascii?Q?RyaANJeyPPUG99QgnclsdmbUs5ymBEndxb1JRA7sVHakcAmYAn9Hf5Ab7f/5?=
 =?us-ascii?Q?vUIFaFPszX8JNtELDCakafnLjwwdTrCp3youJgVy2aehLeIuEbHtVt1mCWwv?=
 =?us-ascii?Q?1Dg3ttyFRsrqpMorgGEMckFMxu2m8hHsZG0odY8fDm9xHX8Wp3mHMeGIlNpp?=
 =?us-ascii?Q?7Nw2gw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uBTi1MZ2kCQ7L0NbF73+FIy3Ug8OaS8Y9wLw984LEofN7hxNCJe4nX4OksAL7tqpugZ8A/GxRtV6hRPPb3sSDkxhWy6gAK+9VmkvFTLcAobZ6PLn/QBkrEMPY9wibgYkEeXfkJzqXQW6mtn4Jx/oZ7o/JALo7SvtK0kQB4nheL2w8BAaZfd7Pfa4ZlcOXOvFAduPu/79ZEJoxtKgiIuOBMUOCoc+Vdb91ArLJXUTwwFr4vY0WVDT1mNm1b8CfKpwFm9c0yeXse54lqc6F8+kD3ZYjCioHf3xMFH/WkAm+w8uAVfp4BzsiYCCQYZBLRndBE4ODRVJ3TrzktT+lzSabRqv78KURnmT6vTawxX5Sux/b5+9bqRXKsCQiJpBzH9wrxJmTKefNrAMkLjlMTDfRkEIsjwbt9Pc5Pu/5bYcuJgnmY5y/URw2fZPU49OZqsU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:36.2824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2fff61-4fec-432c-1c47-08de67dbc6c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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

TOC and TA both are required

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 3aca293e2f0c..723ddae17644 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -45,6 +45,10 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0

