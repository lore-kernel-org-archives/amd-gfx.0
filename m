Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F24DC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 16:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA2310E161;
	Fri, 14 Aug 2026 16:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PRjwkEsK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B76310E161
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 16:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzP3xGhXNG34FDVQwV/FBP+WDdT9LWS/6i/4ANlg44+sLyEbSSO54jAvUHuuR9y8F8uAM04+n5Po73Jku0fKl9SrHOGXA75sBWEkVi3S+oKX5P3wl1kedUHzRvlBLGcHXbaxYk4yl/VBf8q5Qs7b4TQ0315tcC5bzdxWL/Gr1H3GFsJRDSnrDRPZmQI/pYxwZu3CFUfZigQxGeSBY+ekni7e3tRQLIga/C3VG0zg9LKRLDVwd34Ck7SO0CliRG3ZIcaOQflxxXWE74Rh+XrQL2tExQIQpd/Kddvnxnq8bBF0hBPq+8RKrjS6woOpun8SJVesTILU9zgSTejaKxD1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQW2fNTSjZhtJRsiyB4AmwuJxCuq9rJ8XVCtHYcltHs=;
 b=RSqfvUuAzKhCWUyI5sj9HtOIqYVzd03c0N74kG3V85mih6cJZbJuxJ6oawAlfNgZU+8xga9zMyMtDPLe8wBsoaHSTlt6RRby//kxwV92i1fcv5D50v0Od20VNBYyq5YgLhHWgyjLmfUkjSzfJ5PHSwKdEYtx+N36DYxEc3UMXsLpDM2mV6RbjbBrT5fnIwwJh9OPcz+6HdCmCqAUY8xMiEMGBlvLf9ukybyUalzju1g8t2aiWKdNKy1qJL9T9Lho1q9bsEe3rblCisaLAd0hi0bQiR/n0KONh1V0zSclzC8UIrc6us6yh/+f2dVDNUdEpK423JMoRIv5iuuwYyifjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQW2fNTSjZhtJRsiyB4AmwuJxCuq9rJ8XVCtHYcltHs=;
 b=PRjwkEsKPTJEwxnpQClV+MvvQjxvyneklkgDPsW+O2Q/nYSCGW3kiJoks0XCQ7FWXmTiq2IqTAiauTqfmXRjzz6iAhx/lNfe+AVQLX57avZkagB1HHJSmzzfttll43HuSUyzZnoiK39emnwAyVeA/yKAsWBQkbf7uyWLlZle/Vc=
Received: from DS7P220CA0051.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::24) by
 SA1PR12MB9548.namprd12.prod.outlook.com (2603:10b6:806:458::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 16:18:51 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::9e) by DS7P220CA0051.outlook.office365.com
 (2603:10b6:8:224::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 16:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 16:18:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 11:18:49 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 11:18:46 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Sunil.Khatri@amd.com>, <Felix.Kuehling@amd.com>, <Shaoyun.Liu@amd.com>,
 <Lijo.Lazar@amd.com>, <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v3 0/2] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Date: Fri, 14 Aug 2026 21:48:38 +0530
Message-ID: <20260814161841.5906-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA1PR12MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a3b819-44ba-450c-d7d8-08defa1fb9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: MgQSZvgcltql4qV1S2EwhZzIDvY6scRkyUz12THUVbOVm/qJNtDI+Y6LHV6c2+T9HZ0wwOGU+sT9iAdtBQZc05R5leyxYdiGpCGkGayRrmMTF/lJZA2t8ikpPXZKJEfBD5988KfGidXAUipuGP/JhxZluCSy6NpgAtAluXE1+QWlPZn/CvqceZAosG9FK6IYV+nDJ4bsy744eS7rTfpm4w44Am7VFdJrSEIz/gr1FIvLgumvId/nWkQEjgp+Hp0dgLqHlZPM/klbZHts88EqlNPWYIWbDYqpFUcPN9xwJwaATG01MGCO0ItTBoUFnEBi8VTx3PEI4tpUlQESPnvhyIFGBg0zD8peWno23mTfM3kmRPLfU5yXPAY3odl68rVZkZ+VpiPY373Q6+a7Ms985s91SPKoxkfT/12gF5X+u4E6h6wBO5KLHyVgrA8Cuvdwq9E4DIRWViBoTlmUqwVb85K0VShmNwRNMACLYkfVv2G0KzVhbuLwPjl+ZkGYLeiufR1vTFZW/+S15zUoFjryp9dg+mbd3Cu+LSPoYyu6V3HtcBe43dA9QM+U3xSikPU5BMDfdaSbykAx7L/FOz7bnjUggud8c9FLMN/qr8NbxgqHkeEUioSd58nD0GXhAJBnFqECPW8dFlyx9qUdjFoggAe+3TtRIG4OP9b/5YMNE7baYJA6SeXMUYgAw7iyb08RmF7WaaWqWRUTUyWWxB7MEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3hkvr7B5UdYvN2C2U/ueoD5VEP6b5FfH/+3nXcOL8wpjAmwZ/1nuWh9w3dgsSAMAKrs23mTYvd+RpwJcC6bxwjyJ3FlwDXczd56D6eQ82z2Zmp3/I0p4wBjSL8dmcQI76XzJHygtKo2ac8RNJ2hzJFDclHrplQBN+rn27AMZC+vTZjOfR6FPzELkcyz1f2ikmmqZK0o438Mlc/DNYONQExg1mSuGT8pIWS3WjXFvw+jAsTGyx6M8GNRnBPJXZeuMUXjTPHa1aQyUaX04RPyfo3arqAn86378v/BUP+Eh9d6hxgj6QMh26eXHjbq5IKC3ryYpXGsZxbMFw+k37V36KHJxnn1pdW9E4hsaWINurQwZN5j2JfITl9yBRydc4soGRB5nkYva+tP+oEnwU6Jv6mpt5ByOBI4BAwIBhU3k4Oqujb8wSixw31/rwG5796q5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 16:18:50.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a3b819-44ba-450c-d7d8-08defa1fb9fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9548
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

This patch series adds heavy-weight TLB flush after MES queue eviction/suspension
to fix SVM page migration hangs on gfx1151 with XNACK mode enabled.

v3:
  - Split into 2 patches per Alex's review
  - Added userq TLB flush in amdgpu_userq_unmap_helper() (amdgpu_userq.c)

v2:
  - Removed "SDMA" from comment as this affects all in-flight memory
    accesses, not just SDMA (Felix Kuehling)
  - Added Reviewed-by tag

Priya Hosur (2):
  drm/amdkfd: Add TLB flush after MES queue eviction/suspension
  drm/amdgpu: Add TLB flush after MES user queue unmap

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c           |  6 ++++++
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.43.0

