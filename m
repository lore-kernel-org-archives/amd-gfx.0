Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A8EE7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 06:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3117710EF0B;
	Fri, 13 Dec 2024 06:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZwypvErU";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3058910EF0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 06:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aO9aTHYcpAdbswLsTpn8vO26+Rs6gm+ryiFoVp68U5Dt8XAt5OyFjyO5dPLQfjQhp3a8bmSafzi3Gwj3ftLkk0v+4DOISYkQ9P7GeMMbsN0e1nO6WgLk8Bly2xWqIij/yOgoiDVEOGSc/ez2C00oCnrwEKpXM/e9iRiDlFwtPCarikaAJGA+1WsqFreX0DN+Qs1F6e+wwrT9e+dwJ9SEVYjKIVEY5hzLnx4t21Qb9LK+895YLN0WoIliTtZRNPXP/XDGGEFn7mSAo507NJ3Id/0K1PESvRrDr+Iy2lk6ZlSnZtkd7oQQ02fA8Efe/qKZ81y7f5zg2TSnU6eWAVKtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhqEm7AF+vrO6SqZ5G2vLN29diBZSpVf9x6ufre1jkQ=;
 b=dDqV4um5+SBQpfdvZgV4hzmo5cxfpzt2hLEpzcVjT7ucRzS+GALso3I6snYf2m6ki0QN4TgbEjEhVoc9st0X2iI1GPisWUc0puwGVQN8c4mgLJuuOUDEAQ0cB5ymmgimDkgN4ROWD3+mE589yWHxWqkESVHJKdgAFrfdnHdhF7sq8JNyocsqvhQ5q7VD1KAfusxQzKy++03BulQJJFjz27r0Ic4Bbr03lju2HjxLWR0nC5OmPZaXsUR78n4gfbhqmqFl9QdZ7aUiNe3qj4Z5HSzHVx1ji94rdiC1iBbUVfqMkmqH7dI8mwxEdxUJKDTlY0GgEDKXCw5Yq81dKeuxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhqEm7AF+vrO6SqZ5G2vLN29diBZSpVf9x6ufre1jkQ=;
 b=ZwypvErUv6YPPNwhlaqbKiCj0BnNEaL1R8R16L4IEqUY6yccv2qU3DT8YJJnZEKw/0xD4UCs8yPf9gGZQtaBe6dWed4glNan7iOH1jGrFxmmpexyGALmtDwK0SVsINRyvTvWjB7WRpR/KZpi/GBhNT8osORZtNjkhZe3vE9+zuw=
Received: from SN7PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:f2::28)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 06:52:49 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::14) by SN7PR04CA0023.outlook.office365.com
 (2603:10b6:806:f2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 06:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 06:52:49 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Dec 2024 00:52:47 -0600
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: enlarge the hashtable of kfd_process
Date: Fri, 13 Dec 2024 14:52:34 +0800
Message-ID: <20241213065234.20998-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b1c98b-dc45-4dd8-43c2-08dd1b42c22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RhxzDCqjjdGWUUgh9jSKPuR2JZTyOOymjNxf77UBxJVH3qWVv+nqmo1Twtbp?=
 =?us-ascii?Q?Xhr2nKjB7faKB/JUmMobcUC6uxBtAAJKv2/DOYqW6oPXA3JKRaLA5nTYu5I2?=
 =?us-ascii?Q?VqgHnJCQwIns3cdOAo8uapAYvCQAOFUX3Jru3JUYuSDqbX2ms5LqSBbDObv1?=
 =?us-ascii?Q?lLCUxxfTczIHMBUvEiNHq85MzyVIBP39HTYUWjOygQbPI8Emex8zS7P2rXYD?=
 =?us-ascii?Q?AUWtLYkrF0MlWvDvHca362cLyFGUmC0H2H3pJHtxcadLS2uLuxoad4lac1Ae?=
 =?us-ascii?Q?wZx8NScR007bdm74PFV2v0z/BjOKm3KvFDlD8Flc8bNuPoh+V7CXeeiduiU8?=
 =?us-ascii?Q?MOnYOBB1N80IL9hfxRLN4GLvNEs8oYQIm15acuKCm+1ZfbuKLmihOwLPG1Cz?=
 =?us-ascii?Q?zyffEGTF1q1wbkbH1xiK/U58IpWQ/mQXX/nGk6dlMG1UdDmsL3BsuEVosS2E?=
 =?us-ascii?Q?t3/nqUrkVshzd8f7oel2ePe2Rz0eXlM+ocqKwBles+Za5/P/kI3P2S3MV4Cu?=
 =?us-ascii?Q?3tvw8E6xlL/30yKEGUTcg83HUSFo0hAe2SnEvQ5s5fiQZIWvNkXzB6x9cn//?=
 =?us-ascii?Q?G9LrQcQ8FtiUAvOkC5MZ6P/pJq58Dt3UxsBNUB6Bl6HbOqzixS0JqIGM8zQc?=
 =?us-ascii?Q?zH0I7tA8yeaYVEcuquEhDWlyAuMvjIdcF3B0hTQBR/yZ2bOvx9VOpiBW2kGt?=
 =?us-ascii?Q?cixZghd8jGnN/tjhU2xBkp1oDpnpeBZuKonRDGhffT82B/bD+dCZRncw4Fh1?=
 =?us-ascii?Q?dqHqq3fDzPyDxx2eTtoeXIKEWJg6dVuLNAmXaF88LUUw72n+LLziJfxtT7VN?=
 =?us-ascii?Q?v+kRQ4mm1/w7rEwAMUx6N4if3Yryk81Eon+Fp5jQbwrb2vUO4QENS7PD5nUT?=
 =?us-ascii?Q?Q/Y5+KKnbPdsGOLMVWjZgcOw++R9kk/ckIYEOAb2Ezkg58dJpkEUYueXIijT?=
 =?us-ascii?Q?dJw4Jzi9XHrC7x8o9sZ/3Seh7mHWp0Ez7tMKJwT/nwXJ8sU/dmFWLaWmqXA3?=
 =?us-ascii?Q?O5FByrX27DDNtw+WjD/LWDSz1agOlQJYyvQHMhUIC9AoeojIFpRKgqTIJffn?=
 =?us-ascii?Q?KieU4/JDNiBCDPxthkPOTuGIvIoEh9+tgyrvbblOBL/G4ZKla+pkHKshGS2S?=
 =?us-ascii?Q?OrZFydc4dViiM7surHkZaA31jm/+u2FxHNRYWyeJTtvBQtrcgGzLRS8srMwx?=
 =?us-ascii?Q?NnplMQye/pSxChqKfaUZ4VwOwh1j5Ei6FiiyE0k0QkZta4BxbOdlQ2xCcH/x?=
 =?us-ascii?Q?r2n+8EDOQc4+txVlwcYMAKA79D/27YlwpbwXN21Qt3VBU/inMwk+MsuLvMKz?=
 =?us-ascii?Q?s9JwQm2APHeQTFs2dNxzni3hijRe9Nk42NPtTl0bKpkJ2fIBWyp+XQkaWFm0?=
 =?us-ascii?Q?y0nEQH7NpF4qDhV+rEaK1NNxQXDVBpi56rdHhNcYIQUnrkmzho57lzTkQrSA?=
 =?us-ascii?Q?9IZLM+EbajSfYUpUJlqZuKQor8izExss?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 06:52:49.5104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b1c98b-dc45-4dd8-43c2-08dd1b42c22b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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

This commit enlarges the hashtable size of
kfd_process to 256

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9e5ca0b93b2a..7b2049720c6a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1004,7 +1004,7 @@ struct kfd_process {
 	struct kfd_runtime_info runtime_info;
 };
 
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
-- 
2.43.5

