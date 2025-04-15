Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839C1C369BD
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 15:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE7410E7DD;
	Tue, 15 Apr 2025 15:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0oeA7zEX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8569510E7D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 15:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8SE3zVn6xntpD2VzgXMVs6N8MZqEj0tkAm399UWC++WAUdwfHaqQRVX+xP8krCfaLoNqRhkcvwFTThhmzDnJWgWelKn1yNZzw0NKHUnKe++QeEoSBjDMFffCYTdI72bPWc5x/rUMmuJxX8HGFZsT09QuzhH8uacLt086w6AsbLgnvYp665Ef13D25dTWB1wUaUw+48Mu5wovFL/GtxMmVKQ6wvMEWhBWr8625/qWrhDhQhqHFYm1Rt/5dcWOjYzxyZUOfmDmJo+FH2J5Ealk/07C8mOHvYYCakZT9fvpWTDL6sL90hBWg0ws15ixpXU+53hrSDVBf+D1G+4ix65Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/XXX4Oe4EV2Luu5jQWRnQkHQnl8MLohE8OINsfGnCI=;
 b=qQv4rByyZcqhO5Dp7sRo+pCDSdJkdOSP85n0vXVUuWN4pFJdTLvvNkqpgRTbXxXop6wCnuDQP4FLMMZXQDoBPl48K2yHrIp2v2zR+jQF77t1ajtTR8JfNHobVOb4xOF+IMCIn6MEGZB6mVOV345B1TCi6Ml77rssd5fN66CaCed7CismLs3TMYPgKYz8MzKbtOGvZ1U65wuluH+2tUWx8RkiI4Yr7RWDaohfd5UUAmJCM2KaLP8R16Q6eL7IFODBnRnFnOAhkpvZNJtXyvoJZKsrRZMuZf5pDWJLC7O1V0g/hHZN6zYSndMW0M6v5VcXcqX0v6+0TavsuQRXlKZ03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/XXX4Oe4EV2Luu5jQWRnQkHQnl8MLohE8OINsfGnCI=;
 b=0oeA7zEX4oIsWgDXBlY3I6LItImSdHfYzq5I/7lrbCNntdPVUUYIamKuZWc5qDQkhKwxtpf5Jq9YlK0wTq9IMg38YEBCHsNXsVxlmOpn+uCCu5dDyDIhFQepbYCyZdd8jnKR/B7Uv3+ea3cpsyWlXoOD3d4yZl4VzaOyef3J5Ws=
Received: from SN6PR01CA0033.prod.exchangelabs.com (2603:10b6:805:b6::46) by
 CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.33; Tue, 15 Apr 2025 15:00:03 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::35) by SN6PR01CA0033.outlook.office365.com
 (2603:10b6:805:b6::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 15:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 15:00:03 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 10:00:00 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 18/22] drm/amd/display: Default IPS to
 RCG_IN_ACTIVE_IPS2_IN_OFF
Date: Tue, 15 Apr 2025 10:59:04 -0400
Message-ID: <20250415145908.3790253-19-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f0df88-a2a8-4b28-3ff1-08dd7c2e33af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vlfW706Y0oW31AQgWrsMCMxrR6EetoczTBQIB9ew9/6vLnN3H6GfXvFBp90A?=
 =?us-ascii?Q?TowcjC45xdZ5ACNJ9Z+Rh4I45MFcYRKLApPtQAsEnks7P7U8i7A2Ujlaap+e?=
 =?us-ascii?Q?LWWXIF+7n6BR2/qVx6b3knay10VbekC7q58h85Q6gwaCz9Q8PyifN/awpAkg?=
 =?us-ascii?Q?Zx0UJ+32caPdR6IaUZPgsMwScVKmdmAGmFfVrTjBKVVqz4Kp9II0f1UWeYTk?=
 =?us-ascii?Q?0QT3d70GciCUsxiMK7Gl8PwM4NPzp1qgtft1y8FjctTHUDVfbtyaDfy7HfRA?=
 =?us-ascii?Q?T8zIqx7Ah5Cz7thV/u0SkGhY4x+uRGTIINuyCY9pm7vP8Y3+NZNiLirPde8S?=
 =?us-ascii?Q?JxNhSrlOBcYXots2YLgX3jZoCAJjtBlJxSKAUIlVEFUOGVamuQkFmJaL9NC4?=
 =?us-ascii?Q?a+sUvbVpOi4ZFC08zpqLrehI33AGhDDILp1eNHaAayILnpPoo/1wlnLAaDDI?=
 =?us-ascii?Q?ZdpCC6jVHgY8LvYVUhInsbb5gL7rnjdC5ynaky95L3gDjXnU389iezCJTPrm?=
 =?us-ascii?Q?DxSQrrGFGNyxMCGVooceeaZgddK9RaL9D+NxHzkjKr3mD9tryh2vinc5TVZF?=
 =?us-ascii?Q?5KHXYOntMWAZzWhvlZQkUkYWXWqpt0mBH25z4GXMQLg+32gr6slgmqDzolL7?=
 =?us-ascii?Q?2a+9xrhchsgshnewPAZSElPWG0n+Jkb9VtExkjKvJ/asNVehREAK8st+IGL6?=
 =?us-ascii?Q?TBlM0+ivWbBxWzRjcNVNiq/Wg7rP/V0kF7K2xqBEHUa9E3bJ5LtW7ysMZwq1?=
 =?us-ascii?Q?49u6drTJ+4T9Cd5GsBcpp4bbVVycp7IkQTBoh9b8Os9vBctKC9Ay7jN8hwGE?=
 =?us-ascii?Q?vJKA4kx+DQM6eprMErvqqxEdrkxD/fAk5Cf5X6U2MtAnUp5i+uWBoybXnuG8?=
 =?us-ascii?Q?g9/w+RIFcrz+PfAPQ6MLmxpEBwkYSYAHgOpXwvAWVr6rcFNb4wjckGIuxEg8?=
 =?us-ascii?Q?BeZO86C2go3mvVV/Sm1Z+goxiSrNLf4QbvdOfksy6yubsBn13t0f0QQBCAWa?=
 =?us-ascii?Q?uw69uEpI5sVShOuSdk3+2tDxJCNlLzKbBS4AFFuPl/wknFW0Uwem7q3B7WTl?=
 =?us-ascii?Q?WI7/t/djaomnxC4Z1lzGCKbtZknkx5gFxWeQewROS4g5GpbN7AdPxSmsjTCd?=
 =?us-ascii?Q?PrxrD1lvNjBAOz5SMcC7ALyEKu/hYcGC/GNmJsQwKkKnGxKRuWl7dz12wy+X?=
 =?us-ascii?Q?GCyofpiLF2HRB8f0CoZssFn0d7U2LJ1XMIC6yT/UBx8H4daA+nUkshwUpoa+?=
 =?us-ascii?Q?zBwdiZE9o36RUnRcLQKui6MqpB5HW6vqvLqWU1yTMVRMwjaVBt0+cRC9i2Ai?=
 =?us-ascii?Q?G69kezR+tKFkSYNKYgXZNvTdXOusZfsUSULFzWAczE6d77ZDWNTnoPYjEusH?=
 =?us-ascii?Q?s3Whzuv4y7+qZiB7mEnRbC4hgkNsow7BFD/ujaSu1EKty095xjBeyMQklpiQ?=
 =?us-ascii?Q?8kDVBjHPQ3aEkQ3O5hISJDANAGWSdjDpw072V/y60J5nYHTymWuvaDPMgGM2?=
 =?us-ascii?Q?PtrS5KEPDO4eRNIY14xgAfNZySRngP6dJ759?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 15:00:03.3316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f0df88-a2a8-4b28-3ff1-08dd7c2e33af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

Recent findings show negligible power savings between IPS2 and RCG
during static desktop. In fact, DCN related clocks are higher
when IPS2 is enabled vs RCG.

RCG_IN_ACTIVE is also the default policy for another OS supported by
DC, and it has faster entry/exit.

[How]

Remove previous logic that checked for IPS2 support, and just default
to `DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF`.

Fixes: 199888aa25b3 ("drm/amd/display: Update IPS default mode for DCN35/DCN351")

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fc9fb7500254..ca73271035aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1962,26 +1962,6 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(3, 5, 0):
 	case IP_VERSION(3, 6, 0):
-		/*
-		 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
-		 * cause a hard hang. A fix exists for newer PMFW.
-		 *
-		 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
-		 * IPS state in all cases, except for s0ix and all displays off (DPMS),
-		 * where IPS2 is allowed.
-		 *
-		 * When checking pmfw version, use the major and minor only.
-		 */
-		if ((adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
-			ret = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		else if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(11, 5, 0))
-			/*
-			 * Other ASICs with DCN35 that have residency issues with
-			 * IPS2 in idle.
-			 * We want them to use IPS2 only in display off cases.
-			 */
-			ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		break;
 	case IP_VERSION(3, 5, 1):
 		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;
-- 
2.34.1

