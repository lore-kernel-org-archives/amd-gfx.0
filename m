Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46364C021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 11:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BEB10E350;
	Mon, 24 Feb 2025 11:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PxlKqVXx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA58110E350
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 11:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvFgpN7oOt5NKH3tJeluopxNKRahC78UYohUywbfO5YcuuX3NMJODRlFU/7StfNHzZ8q3JxFQSf3zarpeGB7sMBX4M7lmc1/m42HsCQdL3NM+Tup+A0NkaYtCNTmE2CL1Ep3VMejfZcviQNgNeVHhkTI3MdtxzWWm9RyGDgDktwpZMyRHBCkB2hXxoYiErFhWY4Xx+/O8JEK7zTQQzsmRNRnNfGDSjSNVTH0Czav/BA24UAqG+GYKfhx7bKNt7VSviMWiSd75BUB8F9espnmqGIkJsHmJmj6a2lw6g8ELDRW+WkE1lhWwU6lsW6KDaSfUrLzj3Nnm8Dmg8WrJ26YGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auvyEOKW+1p/Usj/Dh9Y7pYxWEVJORN1GA33JyCU+3Q=;
 b=x2SuThHvUxPKqNzgFb2KzJ3IWZr8y+6Ro6WW5jGnOJEiRiEFJEfBbCX/l3lN7uUnKP3KwSwhOMBcopLuX1ILSmJlLZ6u2s/eeR3ZMLKYEg+K/50BXhKzfNVr7hyEVQpApK0I+pQNugwn6nZkl4MPOGQfPz7XW2Z+kTIOxGph2f9APEi3icoBgCVqITONq0/5jqJCmptFuBExjkCx5Qu9hu7kUXJDb2ufM6vjKxCb+y1jtMqesdXiU2SohRY4UmFnXh1xUoSk8MzZ368Vl3hnXA7oULRe2KBJEKa1o8VtugRJ2s1Rruc6h+L4sZ/459bkCQLg8NYtXW05XhEpTs4bfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auvyEOKW+1p/Usj/Dh9Y7pYxWEVJORN1GA33JyCU+3Q=;
 b=PxlKqVXxTCr1x+vchyaw9eGtLSqj+nB7hPWWnYFQfKDDmoQoJP1hz8Hv1lOOhCaeoBcXltZe5k4EfFfe/W8Dtv51viVakHZZQryC0dxK2UAWy5/N/QRb0RGGkOuHBvIpv8VcUtL32NKDm4dpBqTIZYPpB4uQu/bKg0OKfzMPh/4=
Received: from CH0PR03CA0303.namprd03.prod.outlook.com (2603:10b6:610:118::16)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 11:58:30 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::8b) by CH0PR03CA0303.outlook.office365.com
 (2603:10b6:610:118::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 11:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 11:58:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Feb 2025 05:58:21 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix correct parameter desc for VCN idle check
 functions
Date: Mon, 24 Feb 2025 17:27:51 +0530
Message-ID: <20250224115751.2306233-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a392a56-9815-4a5f-830b-08dd54ca8e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDJVOWlKcHplcUE1ODRVOFVybVVDTVlYaVJHYTBDQVh1WFMzK1JEaUp2Vld5?=
 =?utf-8?B?djAvZVJ6SUxnQTRNYUpGbmpTeXI1NXlnTmdXZ1ZvZW1JTmFqZi9RenhoVjVZ?=
 =?utf-8?B?clRyUHRic2J0aG5oRHNUci9mRDBFWnF1bHF0UkJSS1ZtQ0dqbGphdlJqS2k1?=
 =?utf-8?B?TUs2aEFmRWNveFI3SGROS05nT3BPOXBrenp5c2x6UFJLcjVYVnk5M2VhVnBF?=
 =?utf-8?B?bGxFOWtLV05RR29ZbE40VEgzTmxGOUNGektRSFY5LytKbUpJRVJuUDZzTmRI?=
 =?utf-8?B?K3lNdzRsZDEyRTYwd2pEYllFOFhIZk1NSUY4TkxHQ2JFYktlNndjWEdBZXlH?=
 =?utf-8?B?UEZtb3d1VkVoQXQvWU4yV0M4TUFMS0lkU1V2NG55OS9XU0loTXRKQUZmRk5j?=
 =?utf-8?B?QWlrS2llVytCRnVGd3ljWlBxeEFyRXAydnRiMEdxSHR3OVhXeXA4NkVtbURt?=
 =?utf-8?B?ZVBOTDV3ZFJIcUhPOVp2Yldvd3YzUW5DZEpGSDdpOHRGcndOUmd1bUdacWFI?=
 =?utf-8?B?L0w3d1pBa3ZTZWpkVUpQUHdtR0NxbG4wQkpXckd2eGhDcTZRaXJUa2V5QkpE?=
 =?utf-8?B?cEo4VzZ6RFNxeVR2bmpvVlNKcElqOTBqbTN4S05OTFVCQVFqaWhMcENTOFM2?=
 =?utf-8?B?L3dqM2hKc3AzTERUd0ZPbDlTNGpOWjJJRVJUSGxGY2JqMTN6bmloMnVXTlhF?=
 =?utf-8?B?ckZ0Ukh4UE9vdTh3Lyt1Umw5R3Y1eE83bDlWaXZ1ZTlVcEJQUEUrWUxzK3lG?=
 =?utf-8?B?SThGdWtJbzY2YnB5dmZoNGVQdEVTQ2QvQ1ZBdEplcjFuaHU4ejlwM0RZTVNK?=
 =?utf-8?B?RUJjcS9FQjdkcklaUkRVWkRmVlErMmxnS3RRcHZRaGtFU1VGb2JoZjVZSXUw?=
 =?utf-8?B?Yk1SNkthRWcwQXFYUmpvV05VZ3BGS1RCZTlySnhxOVZaVHAzbHdlWDlYbERa?=
 =?utf-8?B?K3FQM3p0T2NXUjJTQml4aGY3ZG9SUkFNUkpOYnRPVzZpWXhrY3hDazkxQVdn?=
 =?utf-8?B?dXNVRTlmd2pnQW96UmtTa0xlMEZXVDU2YVhkNEVCeEgyRU40eEhLamtzK2dl?=
 =?utf-8?B?QXJSbmUvY252TDR6UzZBZXNtK0UyUFhsaTgwZklEWElFTWNDQmNYUUdHdXo4?=
 =?utf-8?B?Ynd0MGgrY0R3Nm9Uc29xbzVaeE1wcVdKejJTSTVRVCtWTUhjdEJVTFVTLzlW?=
 =?utf-8?B?OUQwV09xRWd4ckUvMGlMZkR4ayt6bjVDSTJIcllCK01zQ1htZ0c4RzEwbmtN?=
 =?utf-8?B?M0hxNHpkNmlodGY3ODk2Vkl0ZEpUMlh4TTRkbTNhUEZVem4xU09rM3Y4Nm1G?=
 =?utf-8?B?OUxUM2lNTWFXeElqYTE1eHp2Mk1FOS9LL2JIQjVXZWZIWkhuT1pBNFlqQVBT?=
 =?utf-8?B?NjVNOUtQb0dNYXB1cWJwSXVKV1hzR1hESXhZTWF2Yk42Y3JJN3FhZzBUM2Zu?=
 =?utf-8?B?bWRSbWlONm1US0d5bDdvTzlITXpUZk1ZcWN2SVplS2ZKK0MzMjdEdms1YVlp?=
 =?utf-8?B?KzZNWnJlMURSalBqa1plZ2I4Ukt3aUQvd3JxQ2QvTjBSelo2QkxBRDQ5QVB6?=
 =?utf-8?B?dUZNL2hwOS82cVlVRHU2ZHBMclZ2a2RYaVp5TXNtZEZFRGc1cnFpVE9QelJ3?=
 =?utf-8?B?QnJ3ejNMdkVmR3FPSGtoenR4cjJnUUhrUDB1RERFQWlPMFFJTzBVQklqU2Ri?=
 =?utf-8?B?ZDdrSHJzQ0l2a1k0TEsvQ3lsQ0JhKzJuVjJiOGdIdi9sKzlZMWh6eGoxTE5z?=
 =?utf-8?B?S1B0T3dkenhjcnRkdXpnSTdsV0toSHdDZlpEZFZxY1N3ODdSeTYrRWQ0N2Nn?=
 =?utf-8?B?ckhNMTlselFGRm9LcFdUVW5tWXU4UDI1YW5RUXEreitFODRqQ0huOXdzc3dO?=
 =?utf-8?B?a01ZU1hETDhQQ0NWS0o1OWIzS0VrejZneFAwamtNTjFRQzRicndxUmpNRmtL?=
 =?utf-8?B?bEsyM1VjZzQ5Z3pTOWYveGFwSW05ckNubWUwdWVjcThFNjFjQjRQUWpYVHov?=
 =?utf-8?Q?hnb12Bs117b41o46Ll+oTiBsZELf0M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:58:29.8812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a392a56-9815-4a5f-830b-08dd54ca8e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
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

Fixes the kdoc for the following VCN idle check functions by updating
the parameter description from 'handle' to 'ip_block':

- vcn_v4_0_is_idle
- vcn_v4_0_3_is_idle
- vcn_v4_0_5_is_idle
- vcn_v5_0_1_is_idle

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c:935: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_1_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c:935: warning: Excess function parameter 'handle' description in 'vcn_v5_0_1_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1972: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1972: warning: Excess function parameter 'handle' description in 'vcn_v4_0_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1583: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_3_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1583: warning: Excess function parameter 'handle' description in 'vcn_v4_0_3_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1200: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_0_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1200: warning: Excess function parameter 'handle' description in 'vcn_v5_0_0_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1460: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_5_is_idle'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1460: warning: Excess function parameter 'handle' description in 'vcn_v4_0_5_is_idle'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fe539f7957f0..0dd844243531 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1964,7 +1964,7 @@ static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 /**
  * vcn_v4_0_is_idle - check VCN block is idle
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: Pointer to the amdgpu_ip_block structure
  *
  * Check whether VCN block is idle
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index dda5ee187948..c936bd08963e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1575,7 +1575,7 @@ static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
 /**
  * vcn_v4_0_3_is_idle - check VCN block is idle
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: Pointer to the amdgpu_ip_block structure
  *
  * Check whether VCN block is idle
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a482658cbf86..5e6ad825cc47 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1452,7 +1452,7 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
 /**
  * vcn_v4_0_5_is_idle - check VCN block is idle
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: Pointer to the amdgpu_ip_block structure
  *
  * Check whether VCN block is idle
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 721c29f52451..40f36c9a4132 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -927,7 +927,7 @@ static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev)
 /**
  * vcn_v5_0_1_is_idle - check VCN block is idle
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: Pointer to the amdgpu_ip_block structure
  *
  * Check whether VCN block is idle
  */
-- 
2.34.1

