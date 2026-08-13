Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68004C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 05:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93B010E1CC;
	Thu, 13 Aug 2026 05:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5WvzXSpX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34E810E1CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 05:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT0gJ1pMPTe/i8p1OX+Nk+3dQmC5VsgG3wqxI6VKA+KTulKQ+x80z4W2VDFO5qTM3bte0n4fDphNicDW5Ln4656+56/tuw4TuQoTcekj9pwHqkX0M33oOkp96YqM+DtnrKEixBTYTtvnNDGztQSdEQoVn9D98l2XlgJMscaytxE3LKzC46xXefIfYVRg3hwOcK0+Y3ZZuPIZmiAnhzLmrk/YiE0co+ZDqFhzZYjzT24N364CVAdxvATXBWsUSoV2DzTj1Y9xrnMSJRAjlFIK4nlYpBow4vj8GaZwHiyWqLPxr3pXZpDKxJdj8xik3mvs+luJrDeQawZ9SdSKMN049g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KArvEsK0XkLg103js4kS5vQcwdEsN9A7VTF6tZQGKYc=;
 b=X8e69QNDIByfqaf7G5BK6FOXblX+pKGC5AJrLk+JHju+CQae2aF6jkfSSySq3AI8QxtuTsKe96TADVth761mru5qdZtpQrxkQKfEigrW31ZnIxv2mzq3gRWcOQZnmiM+Zw3Y4u4VnpAaz+D6wKboAS2qKve9k+pNIMzHuSi29QyI8BK7ZT16Ywldo4iMLzI/KBYuiegYFzeIJAeAxw4BWUCyv/Min2/PW8avL+1WWM5UQ7boN1PpRFowu6AmCEVB0REIX9zjdMPyADbT7wZepw8naDJC37TpB0C7YvyI6Tv2eFCLj/svDl99WU+U2t/3EcXit9SuZSKnY368kr4Xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KArvEsK0XkLg103js4kS5vQcwdEsN9A7VTF6tZQGKYc=;
 b=5WvzXSpXROWP8BXpOgbawAYt5FFN5aJOsA2bzMCbHFz3WGEOWYLcfBT/8ahWkCOhyyp6qpApD+0rXxQ80cC8DOIbiqplepW8QWMBfXrwjVzupZaCrF/9/NO3xB4yuA1R9BSez9PoxJZckmcJA7N+/7/uqRb39utQcItk7aRgX8Y=
Received: from BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 05:42:24 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::59) by BL1PR13CA0445.outlook.office365.com
 (2603:10b6:208:2c3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 05:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 05:42:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 00:42:23 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 00:42:21 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Shaoyun.Liu@amd.com>,
 <Lijo.Lazar@amd.com>, <Alexander.Deucher@amd.com>,
 <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH v2 0/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Date: Thu, 13 Aug 2026 11:12:19 +0530
Message-ID: <20260813054220.450509-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: eb72ac6a-4ff9-4f45-6b2a-08def8fda6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: zY3kGDkMgPvSfJOj35+mqa16BQukuWjTs4iuL+arQz8qk4qms5mHy1Xa2pGRBIgoeGUe2mBXNWRofd7oplFtMF6+WJCjNfubEW3GXiCJ8fl4Q9TMzYjlnV1i3yu2yTsrUVWT4ptv2JhJTFeGFhcc85o3+4BN/2WqzlomSwV3fLi+NVA9d0Il8ORk5lipCQSdqE+anNbJSyLldvXgc4wy5R0z+URHl3LJnzMIfE59Ioif9FMJ5JPtRxr6N8/+Nkv1jyaJAvMVTV0PSSO6PR6pOBjCsPxlJn2EM9QjDk1yvFyS0QevtRp68sL4Vz173J9gkW0DOZV5NQQvTdetBf56PUtS+5TJw9Ip0EUD5xtXVzTo0ahNFph6fzzUOy8+dYYbfqPPukzspJR1V/XH+/sBznPXyjzslicFkcHMgMvVkh/Z66bFxWzl6zdfv4f2g9yEwRuVK0nGiTDBp9vqLuS8kmCWRE6OGxThvJq1ld0/S1sS5eDmEZZh7/PjcLk4OLOsaA7DWYftsFiobb5Wa7Cs22Jzi+Raw5rHBgr5tHeTEpjQpWYqc/Z2l+mhwLEFZYLfFiX2eKHCJMNKU3dptzEyQX+w7q2EAJ4XkTdj/kiNjYI19//I0rBh0U13mDBqfGvqsiYLaoP8LN6phCW+M8Tp3upMjllCqv+rY4sE01AhEmA+5iORSCzhdDaGHnXrNMkRlw3HqkrQk0Ib9Q1xL7EPOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gvb5Oeytw/Bi7oszdGh30vwTj5n9Kpix8CSxLUOq7OS4JrA+p+1mhfarzUbYR61mf14Z5LLHUVB90WMVMv+eEuOYFcOAxvKH2T5QuDZwGBCS0IrfaNfNnrCkVP+zYjx6BmAPhcVSgYPBhXBTEMEB0WLpUx1Aih1sshnBm3TZ5feqL39Y/HTiHQR2MwTPTPow+lVA6V2zuwEvaMI3a6fy8YpHlplEOWxEOfLPiQ19wucTOPJsxtsQ5EREU8ksxVYjA72aVWCsiPewCH/+eIzmkVwYJyK7e3Upay904qxgAdN/k6zxi775xw2aun3KhJistTmQJZMIR3rc6wxRffafgm1QHjwoN3PEBJQMCVhEvrwafl5V2GV8DT0h9nLghdwm24yw99U2iNpq1TWmUekDoNJx/W1eRK0adbHIhx2Q97MPOM2weqxxLFdPOdCxYNMb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 05:42:24.1395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb72ac6a-4ff9-4f45-6b2a-08def8fda6c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
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

This patch adds heavy-weight TLB flush after MES queue eviction/suspension
to fix SVM page migration hangs on gfx1151 with XNACK mode enabled.

v2:
  - Removed "SDMA" from comment as this affects all in-flight memory
    accesses, not just SDMA (Felix Kuehling)
  - Added Reviewed-by tag

Priya Hosur (1):
  drm/amdkfd: Add TLB flush after MES queue eviction/suspension

 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0

