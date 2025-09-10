Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4096CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA7D10E8EF;
	Wed, 10 Sep 2025 11:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKCByB54";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8DA810E8F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hue1RQSnLkH/sXzU7TYOeekzs4Z8BtmbF1aj/0YlkvdIMt4RuTQP4S05lOQgPpvJKbnXSHdyQXR5JW2W7LK5QHNfakdwg2Gpuc6EkEU+kmPdrnna8KxIVnvY62JS2PQCL7vG89L3cPbSrSC6hXfL4DMn27PiJg3nGCk5M0M40PesTqhzndoHLeSpQUVjRJQqG0gS4OhmhJf3mbbTsenmNRPAWNJ1/PBL72er6agfZau+XdNlivBWW+Z3OXDsTmEYKV1PJy+6QbgJk+qNbOwInH39mnkGtHNq3C61SZr6+T95Ew1Ljq3LzF8UgfHl2AzVSx3/vgpZj+bqLVnh9ViKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1AZhcxJVWxg3b8PXCaE1jlETkRj08fRNEREYAz+trY=;
 b=tpUKtoao7/rMXRk+sJ1j2MxkDP8QkJ82g1jRIL2HseD7y4AFBIg6Ox2aXWRXxAymxpUbkYNP04wnCvoL0O4PkHDSFGTAH6qKfeAN96uJWE7/zDn8SKKmfvdLXO3cIgj17Amfj//XJQlvsIHpMpNd/K+m5x/eRH3PY7Hlx/FfLNAMWjxYkBovGeemO02MyWdlSjkQbNqUXh8aypmKywYcA8g4k6vaoBrLWcPpM7wH192aLjDV6NDyM9q/FLK/kbqobogJdJwWcRuZWOvEEbU+VWNLq4goJYMZg/KuAXYB8N8Xi1tKasqqV+3iN/A0KR7uwgOzGkg/q+nzl/ztjdl0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1AZhcxJVWxg3b8PXCaE1jlETkRj08fRNEREYAz+trY=;
 b=oKCByB54sZBafxP0RSxCpJT0fkoyT2bsblHvxOxUrn0G0A0IWNDie+AGUlbpCdhDfdT9BTdyf6WpNf248qi9/GG48SBrxivti/m3LNTVLFp1eoKFYM4OoOugQzu5YbSW+LtiTNN0uaf4gjhnXg/fegw8eX0/zSwuArtzWc2z/ms=
Received: from CH0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:610:e6::9)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:37:46 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::8b) by CH0PR03CA0274.outlook.office365.com
 (2603:10b6:610:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Wed,
 10 Sep 2025 11:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:44 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/userq: extend queue flags for user queue query
 status
Date: Wed, 10 Sep 2025 19:37:25 +0800
Message-ID: <20250910113731.2688320-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc8cbc4-3916-4b2c-ab83-08ddf05e7699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xYOy6xcP9JkHEAMQCsvaOMlkhZb2k0KJakWYi7yHMApfOuRr0tlBGwMxt3CH?=
 =?us-ascii?Q?pHjDNR2nnCHFxj1Qyq0ipUNoEnJ0DHVvpvIlumBDwep9eY4IRihlY0SniO6a?=
 =?us-ascii?Q?GHwhleTn1mSDYevSGejhrgELSwbi1kUoxo7iAv8+9QnYgH7l8jdOr5N2xUWh?=
 =?us-ascii?Q?EwveeMyQ9SROBKDq+ZsH9LbbWFqNJ6mbIPoszhgRRP6P6Mn1l7tpqiiVpwU2?=
 =?us-ascii?Q?jat5AbnyTr76Br1W434tPws5XQ6Bnmiz6XeDZHukLAWH/li+3OpZFD/PJXtO?=
 =?us-ascii?Q?ciWSF+eLIUXdWh/RDd5vapE5ZzNUEOjxYYfWffQcOT0808DXlpKg5x/EXHOi?=
 =?us-ascii?Q?o8XweZ57EZbHVjS7c78X7HROMdf1rDcw5GrEwpzsK2SqT0Qfa9A6L0sIilKl?=
 =?us-ascii?Q?u/swA4xVyBq7tHBS1S7bz/GliIwZM8jUO4dq+WoRQ4PFM2Aeq2mtshy3+T1T?=
 =?us-ascii?Q?yfJGwWvO7N9V0VAKi+UyaUVsGmr4jpNqgGBORwojlFOQc9RKEOg9ouV6qo3N?=
 =?us-ascii?Q?+eA4IQi8cbfPFlBGiP7CAGSikfs7dKbBxGo//WqW9Qzpisrf90iPMZoV/8X7?=
 =?us-ascii?Q?FxOSQOTj+z7MAwP2I1sv6OKeBzJaRKCe7fMjl4X76Sc0T4mO+ayajZP8JhdB?=
 =?us-ascii?Q?XRIKffSgGc2YKtK/AbqYOQzFN/2NVgYdIUxDqx3fyMRkYdL97oFGNUkg0Wlu?=
 =?us-ascii?Q?8KFEaw9v9epkv9FBY7VPrq5+SsxXdmRCpHnyswKNRlg7tVVI/w7jCXeZUZ8A?=
 =?us-ascii?Q?SW934axKXdqYyQCRDs4nCDCD5/UTe+yGB1ouk1Y8KcdV37R6oxBtiUlPw4aF?=
 =?us-ascii?Q?hG1vze16frpTw69b+WJC/OmDQJyyuQOBJkeG1Z5LcP71KB54TaqM8jmyK8rh?=
 =?us-ascii?Q?TpzYodtBxEyslJzgirCN4qXhtBxqOAoGeVraxUri/hVfsytPXuRo8V71V585?=
 =?us-ascii?Q?1sJauBU54aXr4+gjmP5aLK7248liXRVG2oMwsXKh5Cmm1ahshLSCVfwugjY/?=
 =?us-ascii?Q?ubYPoXqFFakAvEFtjdJmf1Vju3kF9AEbghF0PJ2oxHZTdVeoyJG960fFbYBV?=
 =?us-ascii?Q?ftXe38/qOH2G00dkQKpJfha7aI1KJv1oV/NzndhfCRV3BjnkV0M5TMCm1Gas?=
 =?us-ascii?Q?w6EpmEHwUYvq5k+uo1VD3glxubPmHy+jIRXflHTItbF20gsBhU6Zk3l6KeM1?=
 =?us-ascii?Q?PkXK+LkaJShA73jzSc3mViFLF9Lk0HHcwvfzMHDzd2XPJgBTcm7ZvtSFwFXq?=
 =?us-ascii?Q?hlPHqV2LKl0OvlNaT9RES09MZdxWnL8hzqZuXybTg96C1stYZmriTuq9rnOC?=
 =?us-ascii?Q?VhDXg8i7bW0pwUWPUuPdujeUcTK21WLqqAZbtJMLVTbn0biYbnbRWtNqz/g0?=
 =?us-ascii?Q?24lz70m/3QPQqJIj74Yfx1EDNfN5O8ePnjl6q3qX2G4a/BSqjFPPYqMGdYSv?=
 =?us-ascii?Q?3xv/OjnNzv8o4gc0qopHHSHwqWCAGLWS0nXr0ya/9LIkRcnl2ADLNmM7Pvbd?=
 =?us-ascii?Q?gV1/7Ew/K7kHfdqTQqlfEe7+luSSKOLW6A4X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:46.3310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc8cbc4-3916-4b2c-ab83-08ddf05e7699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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

Add the userq flag to identify the invalid userq cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7292f7bfcd13..62520c4e4b19 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -352,6 +352,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

