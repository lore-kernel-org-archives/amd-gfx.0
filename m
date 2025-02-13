Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114A9C021A0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 18:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A505810EB70;
	Thu, 13 Feb 2025 18:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Yrt+H0p";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D5B10EB70
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 18:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJdg9A23WHqVOho7uNOOQ711LhBWfAyCffffTnINK4kDIOXQbxTf7gFBc8QuoCHKtEoERiKmzgxCjN1yEIwBK0jmEsHSnY+fjQVvfv6twPpPIATsF8GCaYVxQlbiMnAUa83UALwr3uj7jQjmnqqqqpDbdTqr8SccgUvxLDzt1FaErqZqwcsY4SgHPUYD0Y+SgHFd/vlgYtUT+2oCPFc3D9WH5t0erWq7SBfp9O1W+lUYy1QsldXxxNeyiVsDNJUq7cM/N3L4R8143GUu3VkQVGxk62D+xhYUb+7uC5U8DS+Sz82Y/tI1EWUtkCEcYxgOBpVCbIfR5uTRyHV2JX8tsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKlVj77i3hNKfVLE9nr+d41D0pGIFYLTWS2xzwDqW9Q=;
 b=Z9gU73vCCCuz+g+lPT6931IrEFRGEqwC6onYIrLPibLJp0VwihGWw/nEpGS/j1whOwvbC3FaOzKt9iwREhjd+eg/ZuckM3P0e2dgf9/rZCEE7xl5C1ukipMsSPXNclxym+h3cb0RFNKH1j768x5JFNTUusfnVRxZ3XslQ677ABXMvYUXRQHKQ/QWYOOokK1FDlUtNzYTGIrWwj+RUwZUZu95/GZpTtbUkELrZxZYGmiaWUOinGvtCYrKUT29BjdGbRLTfR5+YK1+kmp7WX7dr9VeWw7jhoVVoXpgia7ukcyFRe00ZUF5VDEakIp3/W98Yc1z36v+5MTFXuVbtsCthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKlVj77i3hNKfVLE9nr+d41D0pGIFYLTWS2xzwDqW9Q=;
 b=2Yrt+H0pikqqXrhstU6j3HF/Ogc9su2FUUfYXHHhO33M0yD8wY9IswG/ArizWuP23JMbsOXSR/CVailKYRROQPU1880U6NA24jER/f+8Dbo/7rcqpfdQw/YXr46pC6ge2Uoh+BAAOKf0HNOCdlizM/ttkc6UvcSjLq7dg8Aqmlk=
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 18:40:15 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7f) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.8 via Frontend Transport; Thu,
 13 Feb 2025 18:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:40:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 12:40:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Shaoyun Liu
 <shaoyun.liu@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx: only call mes for enforce isolation if
 supported
Date: Thu, 13 Feb 2025 13:39:51 -0500
Message-ID: <20250213183951.954001-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b0033b-5987-43e4-16a6-08dd4c5ddb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+tMVHflQwoP0NvCrb1PbZqZzSFwClzKD/3ZVLTaJ5m0Im+Kl8KfSn3EPJLP+?=
 =?us-ascii?Q?pv5ke/DNE4OvJRIb3MzrxXE6X8RQRJQnLszBjAOJa3VcSl4TCyNU1BUwxlUK?=
 =?us-ascii?Q?xi6eWXrBiK0flhMA6cES1FWNXVovMQMFG2AYWieuv9ebKxCZGtQR5QItdPa9?=
 =?us-ascii?Q?BpZSquJD7akpVgITVkykJNHX60FjjEPxmkvZqPjgaeBVRZYzkTeAQQQNX72S?=
 =?us-ascii?Q?eNZuxRHw2vcDmsBo0e3oVtYyCkZVZqb/cGwacvG1CfJWz6PEXr1EjggtQI2G?=
 =?us-ascii?Q?RIDITrl+WMB/YfebCoNRZXGhsOVCRPYX8FNsEbhHmWtI/hwWPV2PpTS1kKlX?=
 =?us-ascii?Q?F5V1x/8jvYLKOZq9Ze6jXNrzAj9qIZVeHu+aYN1snCDNgNIusuEjogYjXquv?=
 =?us-ascii?Q?AeSk0Je1ywEVhfb0SWwMVgwq+Wqw7YKsXnVDyJ1qcz4N76oBekXumpdnXKdT?=
 =?us-ascii?Q?EIS1x1AJy+LkymoUgOxyddrD4Bv/swiQyALCOYpsmN53eVMJ/ZW7l2Wu9U5z?=
 =?us-ascii?Q?MCyYCMVWYInq4E6JtLY7iKkRDs7lHhE/fM/74EfYoDfd7pyniXzv4cVgw9Iy?=
 =?us-ascii?Q?PRygEiQ0GA3b6D8NSzqjVX2kDjHv+BjH9SY/GoEsKcTQI8/0HEk6AubCF6jh?=
 =?us-ascii?Q?5XOpcbAfHAW4FAwSgqTeg0gfF7tMdQpTEfeXPa1jRjsI1WbntxYjgeNJEVq6?=
 =?us-ascii?Q?YgdxmKRd+T4K06+bicStHU95JfG2GiEe1J6uLkG+YVEe0ud7B7rh3I+HbWCp?=
 =?us-ascii?Q?xd0wpmWt7TckQtoUMvn9pVHIw98aYE0ThuAfZp4ZYG5MtYaaZ2h0o99jWsAY?=
 =?us-ascii?Q?XnXkEylaBMxzVd9IRtTXOyu6C89UFuGLrUCWzEt7JVaZms4TddTrtt/PsVdw?=
 =?us-ascii?Q?kSEySkzdGEg5pfpZv8HDebXoX/t2tjj/bYyrIeipVIadfKLfNQcm/TIZ3Sn5?=
 =?us-ascii?Q?8w+zN+10TfACvdl3AD+ignDoK4iUXYOsUc3SjaYRywc0UKFfvxQ+5QS9MWk+?=
 =?us-ascii?Q?1kTQWn6XrfSylf9Ymd0+OyoxxCrq9y05c9gLxbQDd7wIV5rzVVf5oUf0N/Ft?=
 =?us-ascii?Q?6Lzk++Q03USHVCUt1gittB3P98jQlx/So3sGLmDkrzo4tZKgaTJ0Fy4MZ0TX?=
 =?us-ascii?Q?V+lOAnolE8bgH5G/PbppmJjw4bsS+JRCMVdQKqytx0YQBdhdTyU/0QlRYqf4?=
 =?us-ascii?Q?UvTs08JAl8Ovxl0Eg3JoaxMQcFU7pKVpEvStX5ELeA9IIGuIOXOLiAZNNAyM?=
 =?us-ascii?Q?iLALpkh3RDGTpn5nsu5sYBLH0GbCqqtTxkwK3pf1gW1RV2GIKyCa02fsENmd?=
 =?us-ascii?Q?c1wRHgw1PEptEP9Euc1ws2LN04xy9Tt6PS2jeHzv0f81QsFz5qK2uXHdht95?=
 =?us-ascii?Q?yhR8CX/Q3Jbovelg9hf9DAuiXo/QyWrOFCmYscxrH7fYsgTWX+p3oKaGd0+j?=
 =?us-ascii?Q?IbEUHHT6672khrE4V6OqOaJ0C+MQnw6/mccrljbcXS6YEqYqijURN9rmv9kH?=
 =?us-ascii?Q?gavB4cFXY1f3fvk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:40:14.9686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b0033b-5987-43e4-16a6-08dd4c5ddb41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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

This should not be called on chips without MES so check if
MES is enabled and if the cleaner shader is supported.

Fixes: 8521e3c5f058 ("drm/amd/amdgpu: limit single process inside MES")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Shaoyun Liu <shaoyun.liu@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 27f5318c3a26c..b9bd6654f3172 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1670,11 +1670,13 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 		if (adev->enforce_isolation[i] && !partition_values[i]) {
 			/* Going from enabled to disabled */
 			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
-			amdgpu_mes_set_enforce_isolation(adev, i, false);
+			if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
+				amdgpu_mes_set_enforce_isolation(adev, i, false);
 		} else if (!adev->enforce_isolation[i] && partition_values[i]) {
 			/* Going from disabled to enabled */
 			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
-			amdgpu_mes_set_enforce_isolation(adev, i, true);
+			if (adev->enable_mes && adev->gfx.enable_cleaner_shader)
+				amdgpu_mes_set_enforce_isolation(adev, i, true);
 		}
 		adev->enforce_isolation[i] = partition_values[i];
 	}
-- 
2.48.1

