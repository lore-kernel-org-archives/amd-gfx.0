Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FFFC88E70
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DAD10EC71;
	Mon, 14 Sep 2026 13:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PyN0/SXs";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1369E10EC5A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1JdAZUVVL2Bc0SOs2Z19KWNAXnWXz6NJtOEeaaWnS5V+8EEloRUn8LVWqwScC3N8RPoPOwiEDnYaEoOR9qtHUK6rcN6lmSqgR3BkNkD2z9/J7txjuyfmetMTiD9lTW09hi1j7EdG/VMDnMJbtrpxXBua6g43yDakT3c69QGpPDvP9HwG4L4AhQ1GoEqk67hHwNtBsIY5L143GCT4atZOL8niUuSb6oEmxXFTPgLKP4/VlKSSCZCeWzTFjfkVb40UgAdl0M24z5XaBaR+gV78RohP9uS/E4lYCe30YZwYgRDp2IBti0ZWU6VAa0PT2vypy+RiY+XV1/XNLJbPnuQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN+Y14OSiDK0ru05mzkh7O1wyLNiCLI72RkXTBwQC2U=;
 b=RNmOE23U2ZAW6/M8d/MFnxgXGc97TPySUYMj4dszGU4Kg/CB2Eej04KKsrbhxnVnOsutNNHd2mMXxNZ3Sz0gS0iU1qykTJ43r+/MtcMKjyojkW4+Z2Da1c0K+4ZCPKDUofw7+otqpQGpC91uf5FcqxKai8bDPagpUDZSyfsJFkKzyqOfatEFjOMnk9Maasyb1xZegKGfWVX7tRbqjkY54AAKiJ028NazbMuyJHy/2MW4mmGMwAMUBM8deTYLSVn0TYrYpICiYpFPQoFFhBk8qOChFO6PzAqB0lS+skjWPtLC5rIdGQe+uhhff3Jz4YrYywHC3TK1Wkq0RWprz+IzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN+Y14OSiDK0ru05mzkh7O1wyLNiCLI72RkXTBwQC2U=;
 b=PyN0/SXstJqqow6ArAOkvB75pQpSbSCyP2ynj9QNCNIa90gfAnqZ6zMfD+6/Y3445j+aTyuHKU0JH4GBYgK18uPXTpHavxiqreJ2FRWnJNuif4YBYyjYSqz7bgtLwWdhmt+dkhV2XN1a18aA131JWRh4zOSj+PaFyWcgXWjBC14=
Received: from BL1PR13CA0280.namprd13.prod.outlook.com (2603:10b6:208:2bc::15)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 14 Sep
 2026 13:07:03 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:2bc:cafe::14) by BL1PR13CA0280.outlook.office365.com
 (2603:10b6:208:2bc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 13:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:02 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:00 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its kref
Date: Mon, 14 Sep 2026 21:07:14 +0800
Message-ID: <20260914130724.130794-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: c052dfd4-ade2-4d0d-5255-08df126111a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|13003099007|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0s477/xyrGzwQNSTrke65PQQk8RfR6PNw+wAsjqB1gNMaixSk/ODKwUK31nFeMQftVMEJPNLxZrGSlu0sHvVPPctTPTEODNi4ifb0VKUEM2Nru5j+uWJxwuiOOlx/kt1ThGnxDXHJUKBSVrV1HyGOjKb4mu/d6Tvo/EqmZXILQVaXTsB2Jr3P8PIqxO2D03efaLr7YA9mwxK7jVWKmdGkDFhmZKiqdSbTHmrJekzVYs1HcDgB7vDrGVm2DZD0/Tb4da0IEZH26afADKdlZj6WUHQu/4b3PPyUbL+Mxsp/dP7lHQEV8kS1BLxKaTDzmeUjxv/Ijnt+OUAvXjjIgJn4Vl8QUQNL25sJxVM5AuGm4EMDiPIrfaff39BOBO24PxY7AJUDeYCZC6I7eG/96+qtGdmqB+JHAQPxQbi2Uuul7NTJ0EvjNfIpCaSXULwbirdS2zd6cSTM5LlPoCx9L36CiHwj0vTAqYdzfufW4zuuplFXCBUIKMjO//MrS/b+J6ys5ptTmwf15hDrHbL9l5udN8fz2efZAzScpCuc+PyOyNflyj78Aq2ozrPFi/9wQu4kqUA0TiD+woCU3sAdHKWxGiO5QuHJxJI18xvn2VUfcNSwtpX/cBms8UxdsVt+ojW4vSBRv2nDOKXYu4DshkUOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(13003099007)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: svpYq8xPHPBQ8wLhPhFafnujVKYhslI/kWdvbDU5NkIl6iMbZGlwMMp6fIf5EbxTFftqD58mcNWpRXiYZUwGS6Jw7kK7NeHZl4y37XYfsDQSpxaOyPoeZNX5Xh8oJ49RmLCe9/FnAzsRgboDBBe+IX7Dk79vACIDRT3ijtPJdynKXnyJllY1d+GCWCbnBtCxB47m2qX4owDGfaQxrRXpfeQK28ECRejhwy/Hl5Ok9HowdIRNL2oOXSU0PsEdlLer+DpwLKrREFv7EUfLt8+Xk2R4Btv7ydh6s86TPU4SymxSwyi+xTWECw6riZffwPpbg8RvUlauwZOigVMplRNeSCHKsfL/Sja60k3laUTNk6BGxAKmcX6j1hox9mbst1WTeuj8lUG5Qx8ZlK8F9o1VFUzmI7slHoK7+5ku9o2ycJxNwHhMokCFOPv33DLGMmHV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:02.6446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c052dfd4-ade2-4d0d-5255-08df126111a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822
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

A struct kref is embedded in user queue, which manages the
lifecycle of a user queue. However, several code paths
access user queues without hoding the kref of a
user queue, especially from the doorbell XArray.

These accesses can race with the queue destruction
process and result in use-after-free bugs.

To fix this issue, this commit:
1) Introduces a new helper amdgpu_lookup_queue_by_doorbell,
which looks up a user queue with locking and hold
its kref during access.

2) Implement asynchronous userq destruction routine,
because the last put of a queue kref may be placed in
a code path where can not sleep or conflict locking
with the destruction process.

3) Hold kref during access the user queues

4) Keep the userq manager alive as long as its queues,
to avoid UAF issues.

This seires passed amd_basic tests in igt tests

Link to previus discussions: https://lists.freedesktop.org/archives/amd-gfx/2026-August/151692.html

Please help review

Thanks
Lingshan

Zhu Lingshan (10):
  drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
  drm/amdgpu: keep the userq manager alive as long as its queues
  drm/amdgpu/gfx11: hold userq refs in private fault worker
  drm/amdgpu/gfx12: hold userq refs in private fault worker
  drm/amdgpu: implement asynchronous userq destruction routine
  drm/amdgpu: hold userq kref in MES reset
  drm/amdgpu: hold userq kref during isolation scheduling
  drm/amdgpu: hold userq kref during suspend and resume
  drm/amdgpu: free userq by kref_put when fails to create
  drm/amdgpu: take queue kref in userq_create to avoid UAF

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 214 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  18 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  46 ++---
 5 files changed, 246 insertions(+), 46 deletions(-)

-- 
2.53.0

