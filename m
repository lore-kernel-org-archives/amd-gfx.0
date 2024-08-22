Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5799C52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 19:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9B710EBDB;
	Thu, 22 Aug 2024 19:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZhC6cIXE";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEE310EBDB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 19:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UG/kG7KQUGAJqN7NVFb2AmH9I6rIcs75MqDOv8K17JSgUu9y6psnFOED6sUSjoOqXrW9jEPeCBLfvMFuaSK874sV5dhjGlCtkATTV6Hiafnyl5pLuxRPWYr4fMmilUH+ai5QQIXUaHo3ZMK6h23iwn3o+9q1EeIOJeQfGuJ83S3WI/sKCBAXk1KPdnryZv2XZlkbF/hUSOwzKt6FHl+7cy9NbcKWULe6VcoQCyWGS+RqLmOOEpSpLg31tz/l3OLWZt9P+Jtx0R9ozkntt6gZHdXd/YBCGZnhVERa4uXaLFnGbnNnU+s4WQNrppKmn756BTasM2R3TpYwAZLRAAurwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ/K1vJ1Xeoc0yzMaxAQSpEqJyGnRP1U79K02KnU0CU=;
 b=lR0xAnnBRM5UCcjQCcaUzh6JL/PNeMxxSi3OsV5Rup/ZRL4s396dgmoBDg+Ijuv9OmUzXdHILo53oA51R8b2U/+NwLxzVfhhw7o9bWfWTkJT2YGJSTIu+EC0xPOgpXvZExLw37S5ioryDu1G9+KVhZnR01lpxU/VDhyR7pM3Q0/jEOLKnmzOKI+PD1X7fYNLfKXPvyL5eQTK7ri8ZJI3DJ10WrSpQkGTAtNTVMKqsEx5nYO7pKlOKlowttYicCSqmbxxxIDpOBUh9CFOVcEh6PMTR4Rnw2fDypXeKQk4cemao4/G8yZFprLtTU6yaNGaNtTSo2wjtN2YRh+ONJjIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ/K1vJ1Xeoc0yzMaxAQSpEqJyGnRP1U79K02KnU0CU=;
 b=ZhC6cIXEoL9efsC60YSYTShnjGCWCT98vrCHXKIz/v2sQXiPK1owZ07yaFzfuJo08lsdigPOiQiIRLtiULhX/5/vFjmz6hOvSqJpHe8ewcmY0/NjSpxRLuhmOnyAk1gqtojTboHovoi9E2OnYqyMtVnDVfyYmDoZ5VsbRFaVzoM=
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 19:15:30 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::71) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 19:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 19:15:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 14:15:30 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 Aug 2024 14:15:29 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <jirislaby@kernel.org>, <amd-gfx@lists.freedesktop.org>
CC: <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <roman.li@amd.com>, <hamza.mahfooz@amd.com>, <wayne.lin@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Fix Synaptics Cascaded DSC Determination
Date: Thu, 22 Aug 2024 15:14:17 -0400
Message-ID: <20240822191417.622336-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822191417.622336-1-Jerry.Zuo@amd.com>
References: <20240822191417.622336-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac2e6ea-3c0a-4e00-123c-08dcc2dec9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pOEl3l9Bf8VSR4do0LtYl6SURbo4DLpCylqCwVcBZyhVkXU/mKq1HVKOTQsV?=
 =?us-ascii?Q?UiTtTSqHQSeDtDqBSRMPYvY4qafwhBbjBfHLXagfaT4LcBFwQMTNxP4QT4dL?=
 =?us-ascii?Q?8bT+i5cjBFWXThMrtXKOKEic7Eu8Z0G8KwLB4sqwHE8y3KPCEGxO12Voj0xd?=
 =?us-ascii?Q?QhCAWdqRVQbuwU+Lg8751J8pTXEBO5nzKVzVLHRvIj8ZB+VZfQgWDPOFhfCw?=
 =?us-ascii?Q?eo24eNIKER/+odyVWoAvBN60wo7SfHsg+b0CmwBTIXtZ5P00Y61L3WNShPv7?=
 =?us-ascii?Q?832a/IXfqPlhOhR9y56mZdph2iBonYwf/8VhX1yNeLhm6hv55lcVfPVqQ/j7?=
 =?us-ascii?Q?VryhZCWtP5Q8PH98FjTUyur+MKpqk8bNhMM6S4R/hCkXvtO3Hb7jitlH+QZ1?=
 =?us-ascii?Q?dR0rwQ0s04lIRKEAJ7dxHcuOdpPA42ocTXOlOje7G5zujWICYFp5aVVTKLm0?=
 =?us-ascii?Q?QMEGTQpcsTgrlmb5Hb3NEGuKh1VREDb9tKj7XU+o20OPa+GTEmbp5+5+D0Is?=
 =?us-ascii?Q?xj9D9Re2ecIo+VbPjgpFiqGgSfCc65okIakCjyMY6EOmU9Alqbms41Fqlhuq?=
 =?us-ascii?Q?R/gjxbVTCLfu919/ipq6exf9x0QewYpWO/O9TTVEFuLTPWEHKRIb0XyihnZi?=
 =?us-ascii?Q?FGd6cG8fheOWbFoYJ9cTDcshlQllHh0OXlaE71CY+fWW3yddO92NIbnly4p5?=
 =?us-ascii?Q?MoUEXwNMl1A35+2FOyP/K8YBo9JSLbBPdHHVTjofrxzX2Mzhva+Ijy+bebNX?=
 =?us-ascii?Q?0hKopgYyUQV1g9LXNZUwCc61eNC35X8Rd9r7F7L0FGiT1CywK2UzFlVQzhZU?=
 =?us-ascii?Q?GyXScOeGlpe//lg8eLdvtuYHaNsZguKECeMM3Wzx+e889AeHTVs9Zbv0f97y?=
 =?us-ascii?Q?hlbA60horUAQ67TLrnPqXh8IScosuqll4mPHKJl3TYMv1bC6Le38b1uE/Tyv?=
 =?us-ascii?Q?mXDAvbrtyxH4JMIjoWQsUP23evxGWPkiAmdBUS4Tdvi3SebeOIqWNbWemo+J?=
 =?us-ascii?Q?bSXknt0GCEaOQCPDTSuXSt4DIiPs5MXsZxDex4eRWbcXE9yxMcSLEpU9q1ou?=
 =?us-ascii?Q?D/g8N5zUcu6SopLo2NKXlu0NxlYakew1mI2gIxmf3OI5RFgRZP/WxO/YM0KP?=
 =?us-ascii?Q?9IozPPhR1ShaYqH6MA22ns7nubBtnfRJXfOSKejpSjHAHppmYdvuxwIvhgco?=
 =?us-ascii?Q?mxcV8mGaOXuwvMUp6v6jMIzxS+hCqPG94PmRS6YknLjBSRLA8Ge2BkAb+vl/?=
 =?us-ascii?Q?MhEgD01fdK2LzzOgZri5KaGKP7yWjxBjeJvk7B/qksh5P6V0qr/vqdPOoQxV?=
 =?us-ascii?Q?Bi0IHARV6fqJx65EQRbYuZ2AaoNb1pA5yWzGFof9mugII1LL7oBH9ls8Of+Y?=
 =?us-ascii?Q?oRfPBGmoWs4buOucXmPfvPrpvqRqPcaZD8B3XpQZSigYGC1OyEKWQN+O+UV/?=
 =?us-ascii?Q?2NERV6WkCie9B0E+3FRdt9iPRLEHuOZV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:15:30.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac2e6ea-3c0a-4e00-123c-08dcc2dec9f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

Synaptics Cascaded Panamera topology needs to unconditionally
acquire root aux for dsc decoding.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5e08ca700c3f..b77ecf3fb60c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -252,7 +252,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 		aconnector->dsc_aux = &aconnector->mst_root->dm_dp_aux.aux;
 
 	/* synaptics cascaded MST hub case */
-	if (!aconnector->dsc_aux && is_synaptics_cascaded_panamera(aconnector->dc_link, port))
+	if (is_synaptics_cascaded_panamera(aconnector->dc_link, port))
 		aconnector->dsc_aux = port->mgr->aux;
 
 	if (!aconnector->dsc_aux)
-- 
2.34.1

