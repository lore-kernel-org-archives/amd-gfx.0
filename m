Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C211CC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 21:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6198A10EABF;
	Fri, 11 Jul 2025 21:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mwsWIZjO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD7C10EABF
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 21:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpgTE948gyMEA8T91U28WWaQbUe53L3xlHYm+KmRek7cj55IlBrzhDtC8DxRas+SiQH3gXTLg9MzkBj6S9ns7tTwuEp8Q2h42sY8t9STs0GBMAs3rNuRfnLIzRfzQQtOqb37YPW2Ru9W49/8mLSRxH4SU6iIfSQrNj2QPvoUU6zMJXlAl9Y5XQzuE6xnXdjyl5+ZRX6o6Mk049OgUHsxFdQXKY5eUXc4eRmEbLaEADM6s5bz5vtLThgGxSildd7fnh34reEHKzUXywavwKeCqaL9qRvsD+nRrOMitaCZkP0SC8WH5DV2BhwmLwbpHdvy7y8e51wFiYIHEiUkFY7XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc/XXiXka/vPropoK8pJyEf8BeYngz60M3TI/kjAuJw=;
 b=rQZsv9ah+/G790uEoRfM387EMYRJrgyFJs3SNVvhsmmmRagu4X7niuxVJI+mWjTNC5ey18zxs3bxG9rR44XRBPTXDgqCiq4/dZVg2DvIw3ppVk+oKEK/ICKt7QQEVyA6bJtELrrhUjPmcN05x/4fjO4/qRQZfP/BUbr/9zL4qhYzkGBSTy6NXMcAY8JDpkeYivID7d3FqhpMU3Vm+wWP/PVO3OoqVP7Ar1GxhC78BwGgcshibCURy7WXPtEjmYWDekUFqu91yfpVZQ4ehR5HqQKaRvMR0WnaF0smrT4Xa0Bs3exwGD8+BZFVmQmTwFJYeOr3c6PC6lG128NY41wnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc/XXiXka/vPropoK8pJyEf8BeYngz60M3TI/kjAuJw=;
 b=mwsWIZjO48VOGk1geea9Z2CMVJqx/r88oU1ypRzwV6Qj+wiwmST0vQPQjzlUW3fHEYauHzY2F5qrt/sCzQNKUjG50lKS01VcLNPJpwBSShcuJ1AEtoPzaN4swEU3gDdRdIFSj30sBq9yqZqfjlY9X+OXjpbUpt6OfnCtWDenOZQ=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 21:51:37 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::cd) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 21:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 21:51:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 16:51:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: track queue privilege in amdgpu_mqd_prop
Date: Fri, 11 Jul 2025 17:51:20 -0400
Message-ID: <20250711215122.23288-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CH1PR12MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bd9adf-14f0-4ff9-844f-08ddc0c51be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEkzRVRlc3NObC9UNDdMTGlYM1RnV0poYXNHNFg0eUh1WU5SZ1ZONWJTMU5q?=
 =?utf-8?B?SHNKYjhCUDMvdVliTWpBOXNEVlpUSlhheUdkaXhuOXhBTEFBMS9tbmltU0Iv?=
 =?utf-8?B?UmoyazhrQmZsT2ltcUprMC90K01GQ1JTNVlwMDVBRkYxSU5DUnlDYi9ETDBW?=
 =?utf-8?B?OFNhTWJrT3FNdWNlQ3ptTFd2RzFRVUJKUU9xcmlDM2xQTUh3WkJuMGtMRndH?=
 =?utf-8?B?V291K0tocFh5THJZMnNSYlhSc2dDVGVoTWFxV2JRS3pCZXMrRWZvU2RIanVx?=
 =?utf-8?B?WUY0QzRvbFR0amlQMnVEUHNUK2R1U0lJSEpyVEhiLzFJeFFlNklqdmRpcjI0?=
 =?utf-8?B?OXd2eHlWVitpVFM0a29ObUtsUVhwcDlBa00wN3pBajRvMzQ1Ylh0MTJmcjVu?=
 =?utf-8?B?R1A5Q05FSTFmZjRtMWJkZEl0S09Xb1lmcjRUSnVZb0hxSjhrZzQ5Vy9BNmdu?=
 =?utf-8?B?aWg2bnVlZ0xLcExLN0R2eXR3NDg4SDhKSHp2OTNmRjY2eEFuaVJtM1U5OUdX?=
 =?utf-8?B?dkRnYVBhRXJsUjdyZVlZS2F2Zm5ORmk5L2UrZFFVbS9VZGxDcC9aZWcvV2xE?=
 =?utf-8?B?WHZaTmdQWHk1NGEzZTIvcVFZRHdzbTUybWpyM1ErQzVtakdUVmNmNlRUYjZy?=
 =?utf-8?B?cGlJdTBTQzk1c2JETkhkYWRmaWRUeGR2S1JWUzd5bUlqMjlaRVlkdGJLclVG?=
 =?utf-8?B?US90NnpLSGdVWTdrbG5TMm5QQ3ZHR2UvZkNrZytuaFkxNE53RWdmNWZIbGMy?=
 =?utf-8?B?N3l5WStKYi9LbDc3SmF0cW5tMkFLUXFlbU52c0FKQnhkbWNHYkd6dys1VVR5?=
 =?utf-8?B?NUFyRmRnWnJyN0VXOHU3RVZ0OEFQcUoxcU85Z0wwZ293c0VPYndmSFpSU1Y1?=
 =?utf-8?B?R0d4ZmxoK0paL05TSGQxZ21HcVJMYTF4ZkNBV0NMdTBmbll1MFdlbHB4RHVn?=
 =?utf-8?B?K1NaU0p2UEVaMitpMnVaSmlKRkZjRnh0dTZQeHN0RlRNT0VsdG1LN0xybXFa?=
 =?utf-8?B?ZmR4Z0ZQbWJyM3pYcjQzbTNXTlNoSjIvZHJYcm5jWnZNazVaRkcrQ3pJQ0NW?=
 =?utf-8?B?VldvNXphcDNKc0xHSE1KUWhVOTdpd0lXRFpLcVJWWFozNzMxNlZ6ZVFzdURh?=
 =?utf-8?B?aVN0M25EY0VGdjlYeGw0Y0tENDRNOEJsTldoMW1rRWdaRW9INkxHOGxXcFha?=
 =?utf-8?B?NnQ3bFNQOHRyWFp2NE5pWjZ6ZEx5dFZzcXZRVFJDbDBadyt0WnBZUnV0M1pU?=
 =?utf-8?B?RXJsdXdRQjg4ZUk1QUI3Y0xNQW1UYjBZZVo4S1EyMThvc09kZVAwRm85R01u?=
 =?utf-8?B?ZFV4bGlPTWJxSDlpa0czcndZSWJGQVRVRzNvVGt4NWRLQ3BidGdhdThIVHND?=
 =?utf-8?B?YUJ6dnRsMEtGYVlvbmJ2c1hyWFFIYjFkYSs3ZjNNamVxRS9VZHNNMlRkR1lS?=
 =?utf-8?B?a2RaTUZ5N2ZrM09KczFHZ1l1NFVmUVRrS1NLQXY1bnZ1YmtKS0VydEtYVEl1?=
 =?utf-8?B?OUQvV0R2TXJCT0I1Q1ZlT3lNaXJUelBtVnU4S01QK0g2em9IaCtJRFRYZDc0?=
 =?utf-8?B?VmJEZzYrbWlhRW52NnBjQ0VKSGdDY2M5aXlLR0UyUC9GOVpjYzFkYnY5ZFBB?=
 =?utf-8?B?NVVVOGtTSGhYMXp0OURZMlpsK2FoS3U1bDM3SmdiOEMweWpReXJiWVluVVZC?=
 =?utf-8?B?UHcyaVhLNG9FMDJEM3BwTHVFVjZ3VjRRM1JnWTlKNWFadzFCTFo1dXBWQzJl?=
 =?utf-8?B?Uk1DbWlwRUxxb0dDSnBIZmgxdlppR1BMQmJhTlJCd042SzdienRWK3l2YmZU?=
 =?utf-8?B?RE9nOGluaTNsUDlhRmNrMXpjRVUxd09sTDd1UXQycmxNQlRwc1RnSlVRdGVK?=
 =?utf-8?B?T3o2Wkx3MFEwQndSUCtvTXg0VlZpOU5aWWc2Q3BhUFNHQXA3eCsyQUNJOUwy?=
 =?utf-8?B?L3NZTG9qRC9LS2k4WUNYRXg4Ry9NamUzcDJvbDYrY0dUR3NnMTJYWncwaTJI?=
 =?utf-8?B?SWdCbFJZMlNNQ1lRRUxCMmhmREl1ZFV3N3Zqa2NWU0Y5NnlDMEs4MFRuQzBo?=
 =?utf-8?Q?1lXUgY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 21:51:36.4393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bd9adf-14f0-4ff9-844f-08ddc0c51be7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672
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

Used to track the privilege level of the queue.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a1737556a77eb..51be12bc7c8b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -883,6 +883,7 @@ struct amdgpu_mqd_prop {
 	uint64_t csa_addr;
 	uint64_t fence_address;
 	bool tmz_queue;
+	bool priv_queue;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..08615a20ab4d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -682,6 +682,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
 	prop->eop_gpu_addr = ring->eop_gpu_addr;
 	prop->use_doorbell = ring->use_doorbell;
 	prop->doorbell_index = ring->doorbell_index;
+	/* kernel queues are privileged */
+	prop->priv_queue = true;
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
-- 
2.50.0

