Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36DEC02198
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 02:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D0210E0C2;
	Thu, 13 Feb 2025 02:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F86ulkGJ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C5F10E0C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 02:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ro60jkiiOJCRGZeiwC0R1JSHNCSGYjh4uWdO2E+HAg0KdjvBa+S6mCKvNuNqVksJ85gZMoF8fSptS/RAplvna4EEQ0xqumhyDlPTOvu8y/8zV3mYVCVe+T+splYF/YbBu/kfEhLRxcqCdNkm5kskeVOD7IQWvEKpQb9RvBxzACtM4V5qrKqkWnjjg8XTFopsXP5BS48zbWtkXJCHP5tHaoWWfWzH1ouNLhnrOu7/Fpu+MA9janlM7kuTDcb81H/mwUzsdBRyK1uOE/GHaFdT5IVQDe5Z/Du82KDatVXh9Fdek7twqiiwZPAzQQ6/22T7yOiCfwwaHOgJwLck4sNk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXhVkpt0npZ0TvJEKb0s+i5XQgHc633x4/x7iOgRPqM=;
 b=Lxn/zRrrsB4rLJVJLor1Mdmx0KYLOdaGCGsCjZlkJh6fe3Y6FUiMRrcRur9f5r2kwomTAPJGTHVfOwGw8oOC7s0kM3DxTQTjPlicwfJKXcVJcSB0djezur8ZUJf0JriOYcJm74OeJIQr6/RkhS3DPSQkkHl3ugGC6kqG2M3okNZ2H4HYnARsXCF7xxZ3n0WaXN1ElmuF6R6uoMBMzOZj4CE6Ur24oxJW6HxL7DsxLLFO5jMBKUuF418gt2HHtH8WbMinrNC1uxOBJWnToyQWKonz0PBkF+Kx1d1w921TFgr+8uoshjB+dMrCB9FajXAuWd3K26YPFoWSqp1O0URnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXhVkpt0npZ0TvJEKb0s+i5XQgHc633x4/x7iOgRPqM=;
 b=F86ulkGJVxDVhIQZiF5E6o0Vq0Yn5jHHN04YATc7WdMs3UoNgPvHVHsWOZtqBWK16PpuPFC/xE4aypXfqJxFbcY/prd5F2iaN0RQbGBrhJy6hO57DBlrYtx1AA+hK5ludh6Sg/fkRKSBR7hB0v+i8EDCxi1CK6uLaZRLRKAV7nI=
Received: from PH8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:510:2cd::11)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Thu, 13 Feb 2025 02:59:53 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::1e) by PH8PR07CA0023.outlook.office365.com
 (2603:10b6:510:2cd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 02:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 02:59:52 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 20:54:34 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v3 0/6] drm/amdgpu: jpeg ring reset callback
Date: Thu, 13 Feb 2025 08:24:02 +0530
Message-ID: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: d9da63a0-1cdd-4b9a-7a6a-08dd4bda7cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnlwWlZJakxxSThVQlJUWTMzakErSEtWVXd5TjdodlVYOFUrcmI2OHBaYmY0?=
 =?utf-8?B?WHFIZHQrRzUvTGRVREgveldmQ3FFZktGWDhqQjA3elNmTEk3dTNhelVxZVBF?=
 =?utf-8?B?dE8ySFpOOUVZN1k2RzdXUHdjRmcvMWFGK0pMN003eWFVVzF3YjdUS2FNR1NT?=
 =?utf-8?B?Zmc5NTFNMTI5bWgwOVNoZUxtcWVjRVRaZ1JRbVRoV09BNFEwNzFNYVJNK0dR?=
 =?utf-8?B?VWxMT3JBR0F6QW1VQ0FTWkNyQStBR3kwaFFJL2NGc29hUHNyZWY0V0Y5eklH?=
 =?utf-8?B?WGk3UXMwM1RWTTA3bnVTRGtZQ3RHSGxkWjhVaSswOU5KNk4weEZIK0puS083?=
 =?utf-8?B?QkRYQThBakNlMSttTDhKdGhvdmdjdTl3bUdvQUtrSmduZ1gxcmR6UmZnb3Vl?=
 =?utf-8?B?dHZNWlZyQUpjRkd3L2V1ZmVDRlZEbGppazBXeGF0SnhCSGIrd0RrMEdEQUtW?=
 =?utf-8?B?ei9lS29VL0NVeCtqMkkrRitqd1VLNXY5RU15TU1LeUtoVWhnZXNkQzdxZm4z?=
 =?utf-8?B?UE9iWnppWUUzRi9iYkRZZkgzemwwcXJRTGo1a0pyT1NHTHFFRk8ybE5vb2Uv?=
 =?utf-8?B?aWVQOFVVRWNtK0UwL2dHbHh1OUVDL2h1ODd1U2JmNE5EV3dCWXRVSWhxVE5r?=
 =?utf-8?B?MU9uVWhRQTIrZEd4WldwT3NxQ29RUGsveWZJUGZpT1d1UllCd1JSd0ZUSzNt?=
 =?utf-8?B?VUhzVkVMTlRxQmpnMEMxWU5wWU93bzRKWmYxek1Pc2tleC9CZWxaQUNDa21U?=
 =?utf-8?B?ZUNOcWtFUE5vVFR6TVJtSEFIUWRKZWhwRWFrSVhsQmJRNmVnSjd0enhQMjZl?=
 =?utf-8?B?VUZ2aEtNYkFsdFoxSUVMZU5UZTVzYmxudE9MTWxTU0Y0WHg2alNoZTBWbm85?=
 =?utf-8?B?cnBaWHlnMU5hMjRPZ0FWN1c5WWx0RFhWeHBvbEpHWXlqQ081SzNmYk00T0Rw?=
 =?utf-8?B?TGwzRGc5QXZFb2R5VWQ5cU5McnI3Z29vRk95RitQRzMyTUpjdXR4WFRVZ2g4?=
 =?utf-8?B?Ylo2T2NFY2ZLK1NPVjAzY21wS2drTk8xVDhmQlhyUWhvRVZsbDlHRCtjeTd6?=
 =?utf-8?B?RXh1WHcwSFcxd2VpL0ROSVhQYnFVTkVHcWRJRndjYVFmUlM4S1FiOVExWU5a?=
 =?utf-8?B?TjIzdHJjVmVFTnhlOEFRSXlWKzFybitxUDBsb21XWHZLRnJ2Z0NyT1U5UWRu?=
 =?utf-8?B?ci9xTzBNemc3Z3F1c2FqOGJyVkNsOVdYTXAwZ014LzFiSFBqMWtYbUVxQld4?=
 =?utf-8?B?Q0d2QzAzMUhhYXF4NDBwYnI0aGFLY1BxSXpIMjJlczg2MEQvRGg0OUdhWXZr?=
 =?utf-8?B?UEc0Z1paaVJ3UHhqOW9KTVJNMmpyU1RZL09kajlUUDhCSWtoRTBGaTJvZWZY?=
 =?utf-8?B?WGNXVC8zbzloeEZwbllGWmU0MVByV0xFR0NFVUJncWN6L1pwZURzK0FESWd6?=
 =?utf-8?B?bUJvcnBtaHRSRTVrb1dDRlUvb2MrUVV4YSs0WG9wa0lCQzh0RVZxUGZneDVw?=
 =?utf-8?B?OFJTTlZ2cWRaaUhUOXpCNGRpL2h3QlpMTzhMK1d2Q1FvSlJ1L2NVbmgwbjg1?=
 =?utf-8?B?SW5uTkZSTDBYR08zd1NmeGl4c2pNMkdxMldCNUJKWTNGdWd0N3JwNTNFSzBo?=
 =?utf-8?B?TzZJMXNqSnUwVUFSUGc1V2NvRGdmbk1FaEhCeis2RWxDNUdXVDBYaWtxRktr?=
 =?utf-8?B?NkFpeHA2UGYzV0UxWG5YSThtMUVZR0V0a1FoRFUwcHlNdTBGbUpMN1gzaksy?=
 =?utf-8?B?MGo3OFZlcU1lSG56bFhGbGNPT3oxN3I1M09OTnJQSEtObzFFRkN5bWYyMmdS?=
 =?utf-8?B?Z3B3cXlranJKN1phZ2tEdVBjSnRkUWFHdVJLOXM0d0dPOUhsQitOMkJhemho?=
 =?utf-8?B?RkRDTmNOT0xlREVOaWtCV2UxaTMvYk0rL2t0dWo2SzlCVzNvemVjZHhmY3VB?=
 =?utf-8?B?T085OEZ5SEd6Ni9HN2RBMEgvaTBkNUZIcUpMSTJuOS9XUU5EQ29lRE1uM2ta?=
 =?utf-8?Q?njR9BgbdGr/f7JghpTU/Cs92BAVO+4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 02:59:52.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9da63a0-1cdd-4b9a-7a6a-08dd4bda7cef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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

This patch series enables jpeg ring reset callback to recover
from job timeouts without having to do a full gpu reset.

V2:
 - sched->ready flag shouldn't be modified by HW backend (Christian)

V3:
 - Dont modifying sched/job-submission state from HW backend (Christian)

Sathishkumar S (6):
  drm/amdgpu: Per-instance init func for JPEG4_0_3
  drm/amdgpu: Add ring reset callback for JPEG4_0_0
  drm/amdgpu: Add ring reset callback for JPEG3_0_0
  drm/amdgpu: Per-instance init func for JPEG2_5_0
  drm/amdgpu: Add ring reset callback for JPEG2_5_0
  drm/amdgpu: Add ring reset callback for JPEG2_0_0

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  15 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 118 ++++++++------
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  15 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  19 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
 5 files changed, 209 insertions(+), 148 deletions(-)

-- 
2.25.1

