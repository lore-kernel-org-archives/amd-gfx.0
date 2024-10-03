Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34FBCF34B0
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 16:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B7D10E1AE;
	Thu,  3 Oct 2024 16:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u6daKmPk";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1AD10E1AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 16:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywYsPAozbfwTKkOruU/DYao0Vzz5XAJz7elg+jPZzXieoPRcsOlYYIm2KgSB315/qVKcU2L646LvbEvGG8omjF/YQDAtaI7urc0M9L7OtMAfM2OAs/INF5xk9gasSqmD1g/KWAFMa65vwJ/nRZs6haMzOspTbMSteZUnhYGSIy/cP5SCrs4Nat0Jq9RMsm/qHT9LHgg2IOd9kZrTlQ6BSfCw6ld5CPtjh90gE4M8ugr7IPh10n46gUQ16KTRyBAYqPaxHAZEbLNFqKDhtQSqXiRMzqQVbhhJv6Zw21dhtII+kK+SHYShE/VSQ1muUEezDcml/iPhtgxznBwVgL+CSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSZd8t/CGOqbkElYlXa8mYq0GbzVkb2jZfWHzyNg5nc=;
 b=EkebHC1mdSrFAQU5xwI6t13OKcTMJWrOeqjyOoogc7NDIpSFa0LCby73cWoVwiW84aJcBK4hdnTjjpwz9tH+bjqPW5Sohs2AKppyjw2EyMUD4o9q0fIjjwHzcRLkdpisTDBQBa62M0rLdWHq0SNbjezALd+TSkbaVJYJuy/oAeZCiv4BWXNL3NTsdz+wnBURoK2joutd+wgtIXrV2oK7ZLZw4qFw4yhreYNqqhB0DREl5HBfLeRrhyNFfQo0EmgYlK00t7BngjC4oNNN2mQS0Jop0tDevby+5Y2peUmQYPZbF3Tz6XiBh77uLCjcqN6QTeoccIuvoUxw/ELv/kxoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSZd8t/CGOqbkElYlXa8mYq0GbzVkb2jZfWHzyNg5nc=;
 b=u6daKmPk+wcJXAqdrt4uRo43eyP88y1dc22fXbqrivGXvg0yaVulj+e72e/ie9Z93VzX0xK0STbd26z+XazRl0RUld15TQIXv9I99gdSS5Z35xE0C2FHZoejl99DSGXMpGNph9dqZUKnFCPGiWZb2beLjrh149icuQu4x+0v9MQ=
Received: from BN9PR03CA0642.namprd03.prod.outlook.com (2603:10b6:408:13b::17)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 16:29:33 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::9c) by BN9PR03CA0642.outlook.office365.com
 (2603:10b6:408:13b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 16:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 16:29:33 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 11:29:32 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mukul.joshi@amd.com>, <jonathan.kim@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Copy wave state only for compute queue
Date: Thu, 3 Oct 2024 12:29:18 -0400
Message-ID: <20241003162918.26745-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d396666-0ce3-4b0b-5f0b-08dce3c8904f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nFRyOc1BLwfhzFDSjYUIkpkgnc0DhGakqfIvHWbC4N4/Rzu2db2F45PLavAr?=
 =?us-ascii?Q?ChX0k9XMUMpseKMysgWG4wSdjGpmBbzJEV7a0QDAfnqXEqXV2JSzUy0MblU1?=
 =?us-ascii?Q?p8VjUite6Gwz6gq5Y/CdklhuSvbzALrXGMZtVfS1CcScyAXvGvucs8qwBJEF?=
 =?us-ascii?Q?xFhAcHY3kXynZ15bWpllzTMU0eHrDc7RsTh3U9wbYEnoExKEP6r2300uELlT?=
 =?us-ascii?Q?BYRPguy4fKdKRT+jVpKIadqKcL3PCijFp4E1X5KNoHbDoNvnR/R2cmEzEB2i?=
 =?us-ascii?Q?/yL4Bjvr5WKaTiopsCKZAtBbEc8qydZqp4EFrCaHBkGnm+i0+SuEdnJP35gz?=
 =?us-ascii?Q?rwoKEKxkNOs9cTckYrwGwkLS+cTyt8SuJ5TZhQqugHqbIcEeEAPl80sWftfZ?=
 =?us-ascii?Q?RTPHhAxW7X6F9xXfazBCmV1ktM+3ouK/8K9JwOOb0mfejc0dkkTYvwGIvYqP?=
 =?us-ascii?Q?KselpsQUz9QtAyd/zYB6ZvnH1abyEhc+ZxMg+R+mK6JoTFKlLMnSWWxFN3tv?=
 =?us-ascii?Q?K3OCxQMw8xIlsC2Ab16maGLXNOPFeI/8kU+CwK7mhdlV1FGGExDoackfoYq/?=
 =?us-ascii?Q?0bSPGr5g/koIDd64sCQSYbrKCzwrDoN0qoAyTMjSpWCKoTLEIoIxckSFKKFG?=
 =?us-ascii?Q?IUWcwh+ApOcq1FUxj7HAM05ImK7dQWh+p5Zxz5B3/JoFr7qLtk9jivnJ+xHx?=
 =?us-ascii?Q?kRDa7EyPzTNZZu+y79f3KloCFXORgBYl+AggtVJfj/ZtvJ7ueudr0C2+dSao?=
 =?us-ascii?Q?JF4KRHlBiNyiyFMSdpmRoEy+qbjpT2N7aliDvpx0KPMd7UEr7Ju3McVy751v?=
 =?us-ascii?Q?KM6QB1XcXuSV1BsbSqBdF2wFAXjkyZCB3MKG5GqQS6xrxYcQZkomeYHjpnNU?=
 =?us-ascii?Q?3MZjHSg7GD5BuEbztmfIXPjv8K/reLeZ/58Eaitl5u/tYvVMxqGHzJxIGC2p?=
 =?us-ascii?Q?VT85SyhBR7nFjVbY99ljGZZSlRIdLHBuG69GnN+kM/3ywFauu2ojLxoqm/lf?=
 =?us-ascii?Q?RCQWAzSwfjw2qwXH54hKnXV0rPuoSZELAe6x0l90KjXK+J6cQCsVwHV/HkQI?=
 =?us-ascii?Q?3XhpJxOexz8hK3mTgskvDlLGBmVG4GsnKZCnifWcUCLiSM4x1tnFBkoIwmxA?=
 =?us-ascii?Q?CqpozW6w40C++3oUxyekb2LJwU6EY2tM3/svpYkJ8yZm4O0ZxRH05URk6li9?=
 =?us-ascii?Q?V3Lk707h1n/Z8fUOwROTF4ucuQWQ7jrYwt+ksq/E6JAybjgSgrGMKPcvB+Uj?=
 =?us-ascii?Q?UQEMKvg9oeO9GOXzR+AcjwCXaQUt4ujJEIWhxW659Z8qpb4TTL3/myRC7ERo?=
 =?us-ascii?Q?zAQFYLr3ycreG83x5LBOAq6H6oWl8c/htWkmVPo5U2pDeRSBXs6sTsmuS9jx?=
 =?us-ascii?Q?CQRNTkA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:29:33.3071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d396666-0ce3-4b0b-5f0b-08dce3c8904f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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

get_wave_state is not defined for sdma queue, copy_context_work_handler
calls it for sdma queue will crash.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 648f40091aa3..b2b16a812e73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3173,7 +3173,7 @@ struct copy_context_work_handler_workarea {
 	struct kfd_process *p;
 };
 
-static void copy_context_work_handler (struct work_struct *work)
+static void copy_context_work_handler(struct work_struct *work)
 {
 	struct copy_context_work_handler_workarea *workarea;
 	struct mqd_manager *mqd_mgr;
@@ -3200,6 +3200,9 @@ static void copy_context_work_handler (struct work_struct *work)
 		struct qcm_process_device *qpd = &pdd->qpd;
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
+			if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
+				continue;
+
 			mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_CP];
 
 			/* We ignore the return value from get_wave_state
-- 
2.43.2

