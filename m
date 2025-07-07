Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588B7C83F12
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E500810E542;
	Mon,  7 Jul 2025 19:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1cfNjS8r";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88E310E536
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYowRelicjWjmKRBz1eBE8r5PWvNcch5KSGYfRhyiwH2E/S6eMSSiWyCNHGCkP6mb0Wj6V5Weokrv0h+84HIi+S0iMsUyHfBYL9aJtGTaiqoC+NwU/ssP2CbsCvaEFCwJ9DUO0W6Bz2XTfcr8Y+YkKB92H08MTT+y16PG1xaRwLnuo6Mt2R5dH6uau4yk2K2BKABPQt72++VAHRNu0gb1MRz5i+aeLXatmaDFQuPcKX1ge5Kz7Wcs1f/uIeXN1dGNyIDKhBV0vcWpToAGZE/d4FQbqIZNXML+qdY0FAMHivGf/86O7Ui+dNlF5X578hqlEJtDjBMtU5tRpB3uZ5IyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fj5dkZss7ZLnjYcnqAhGcr6bDZjVVLjM9+dpcSIR6k=;
 b=spSnHVWrxMhHfvvGKUBSHnAPV/7uuO2isg/yIAzXZyMqQyhCUM6vPb9ehgYrL7lLcQ4eKzJYaBXeibG1uBypOwoVPluoovTNP9hGNqDowM9smprOsO6CtGCl3waDGV2URUdNVBpIWhcNbbWVNV7mAO6rskuOIMKRbvFttWGQ/NqieMA1dJrMISWqx8rYnjrjWppHtk1C8GMdtMCVl06jpvpAI1apFU/QV2cObLrDaUXCcHd81iXgtqxEJx1I8jqWwKUlGaxq4oqmDtSRQ9OLxqe06T/obRwi0ERCNLMlBmNXwSlVaHerX/3cBnmHWqndlg1LWRYCPt9o4oQMw41S0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fj5dkZss7ZLnjYcnqAhGcr6bDZjVVLjM9+dpcSIR6k=;
 b=1cfNjS8rUKK33O3OzUE5Of0l5CIfZrN+lcQUZ6DFmVnlywBDc+ONtmQJ+YRlD21C0WVTRA69q+MUmcFhSHhkhGiJk+pLNj46sUAAJt1J5tDclwOzM1zdA9d/y6XGxzS5bRn5lTbRFLwlto67KpGDOIz2lQaxSswrMz2+ACLKLt0=
Received: from PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::18)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:32 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::40) by PH7P221CA0064.outlook.office365.com
 (2603:10b6:510:328::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 32/36] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Mon, 7 Jul 2025 15:03:51 -0400
Message-ID: <20250707190355.837891-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: a3296286-7f74-4732-790c-08ddbd891ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yfNg/2pr08SuVF59nakHfl7JlrBNmijRGlw1MUkri3EPGgEf+Tf2Su1KLuXO?=
 =?us-ascii?Q?OtJZx+tVWoFQ9yjDzO897upW4xzTIIpoGZohpxFFSl5bPcQEAQWhIc8hwK9p?=
 =?us-ascii?Q?m7WEnXYuSz1xtvWMe3AZ5Iykif6R9n4LKedJAej1c6l2j1yKCfAsBxAy8DhN?=
 =?us-ascii?Q?6yUeHtcAvlxlSVqTIfEVFsmjZvautVfEkOSmr5k69UsY8aqGUN+Xty5idBqr?=
 =?us-ascii?Q?i66FfPflTJUzWl7fFEf1FibLfXvOH4x9BRPkxCuc7pfbTD5mcDES/NGRiIYG?=
 =?us-ascii?Q?Aly1yMbDY50XQOr294wlL8YpOXbQmVhriaXAV6xipcivI7EZKse15N95MiDy?=
 =?us-ascii?Q?ClvF8DmYm4uzXUevOHY5J2bs1IItwnox45vlzRlbKyEOxiYO4Rl0IslDgmZA?=
 =?us-ascii?Q?PkI4hWztQqURqllIJ++/mhAi8ojdGGtSiU5mCfNZRqG0lBwkgSRC+Of5Os2h?=
 =?us-ascii?Q?C4LAlYlIjUPpxGy+5ztrlj/H7GNiUJXHu9m5SeLorNI1A9U/YSXC069w+jbQ?=
 =?us-ascii?Q?Wr3zQJxse+35sOd8LquywrSOJVk50goar08XW3hDgtzdPzNraYzgyHR68hdK?=
 =?us-ascii?Q?0HAwA/wISwUl6kSm6BQDW4HLIo6w+uUYeJBoLJTcD4wSHluvts1xm9c53rR3?=
 =?us-ascii?Q?A6O3BTybJTNY9Db1iPC3b1aVleYArhKCN6F9qtyzzelbUUqw32yFn4ScEUsX?=
 =?us-ascii?Q?PhJxuvVaKFnCHkhYhsouOVoVH2RQERz2txubnpA7STxnrO5VaHV8cmHuL3by?=
 =?us-ascii?Q?0XQ2O8k/0BtBV8vLI9+cjim/e7bfMcCP+76RrIAMdG4fPxo3at7fnHytNwKm?=
 =?us-ascii?Q?KtjWs/njAnI8e8Xy+x+RDGypWkTxWpyPvgawcwvut2QJ4gh/l2uelYuZuorm?=
 =?us-ascii?Q?+G3jsROZ2nE7B0qOXDTFFTN0KqoUdqhhWK0wlLzj4Xslt1sROm56Y/3htBXT?=
 =?us-ascii?Q?Hts9RPTwMKVBnPk384amMt16Y64gPgNHcPlw3JO3SE0SrZ9Us+PvrcblqENz?=
 =?us-ascii?Q?TbH9m0IqIrM74cH/vgiPdUpQJPxuA9vAAMAZRu+n5tp/leaUn7RV5CbRZT6F?=
 =?us-ascii?Q?PLGeKB+SomtBaDR//JKtakzmButM4MhMLBwRYFHrftV2ggDLzKo656RjgUEC?=
 =?us-ascii?Q?/3W/KW4AXPK2FKUYPNxfaSTR15dsB9QLSAf4rooFTDQ8zitUQUsL2ob9L3o0?=
 =?us-ascii?Q?MNfYkf3yz8rYjbDECsEh86UUwDvv1P8+KM1dfovVNod263EYnRP83tyVfc8O?=
 =?us-ascii?Q?1Ay3W/gJ1qUbbVHxRF5wzGUg01VmBNB8eFXg4S+y8j/ujI6UZ/8G4dmAd+Gl?=
 =?us-ascii?Q?WDhI2cLHguRUNGQP0h9Y3RB/1mhaMdJWznlJNHhUBwqveRyrfEfmjfbvL60j?=
 =?us-ascii?Q?9a40JZuDzn/NmelHeFhPrtgJcDM5sXLRo+riaIllufLfUgLMr3KFtJzIcUlI?=
 =?us-ascii?Q?Gdj/lRhnvN6RqABhjkSxmc5/WiiHOxj9E5yqHR6H6ChNFJEEZ+OoBO7fNy0h?=
 =?us-ascii?Q?5RPDmSKgqqeMhQacjXpdT+WIHK/XbvCbTSv8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:31.4106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3296286-7f74-4732-790c-08ddbd891ad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 3d3b4254bd729..8b2ab6a13becd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1203,20 +1203,14 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v5_0_0_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v5_0_0_start(vinst);
 	if (r)
 		return r;
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.50.0

