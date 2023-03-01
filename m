Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0755BC678D4
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 21:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605E310E333;
	Wed,  1 Mar 2023 21:23:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC0010E333
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 21:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3HxHbKhAl7rZ2f7WDLMo4zd3yMf8wjAs1laBArNxHujN/asyaCSY3ZGjPdazlZ2QirC0jEjn4RWMBcgpnlGjbYf1SYF44tsH35gGQFYjwGFVBb/Ls3xWCJ8rCdQ3NNHdSFmkUjVZv8wEZtsWqhte9+PePnkhAFzNoBofxCCTBGdKTfo3eo/BRrCt6gzVpSOOA9zJjwebwUMSyoFlLlnV3LFGSVw0TiUnFJpRcuL+Fnr9GsPJsEY13HGBaDThOa2qtQp64bMX4EjLx0JVObkvtamAfyUWoRD74BMTgo73g7UChZKimn30TxbO6BwkL+qOGAxYNeIv/VgonJaAIPd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhaUMmdgVmpJx7j0qLz9fPR1H/cSXizLlHHisWl8SOI=;
 b=BN4wDmBDsW9y6zC3IPi0VpQiLFLxkPpcYAOQIkzEjkZ8BGRbmLmm9Z9ijewOw06YNKBUv2xIC53vbPHFg8sA7YBAkKyrDtAMJ3L5RlxcO0Sy8euLKGeYcl9HNreLLKQexTkb1On3mw+lzOWJJRXWmNkF34TkCXGfD7VmUsKq6zTLqYIuI2Ev+5LeCny4SU38mnxPQajibnRJjqZ2C2G1Pe/Z+QlUNiQoSWNe7ooNeEsN5O28TTtZ6N1fzL3FzsN40aHlCgq0CCDk1pid5iG0IYvQDv6NHe9p/0PveSIb5zxVlO9/wE6kewb9gb2CemPKTX6MYRP7iaUnyHWi5BJ9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhaUMmdgVmpJx7j0qLz9fPR1H/cSXizLlHHisWl8SOI=;
 b=Cq5krjJAbdtCywuxmWBb1w5vdfryR/lbEZ8iC8KzuUkerbTrck2yaoIpbbIfl8jYD0bMICveIxTPVCtJa+N9jPL7Nmr8R/92VAbIWOwWfGEXihDE5QOi5KaafkqssvucpTJJ5ILVhD4sILKfiqp9EcAlPRz5h4vJDOkJ8J7wqk0=
Received: from MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 21:23:04 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::7c) by MN2PR08CA0023.outlook.office365.com
 (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 21:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Wed, 1 Mar 2023 21:23:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 15:23:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add support for SDMA 4.4.2
Date: Wed, 1 Mar 2023 16:22:37 -0500
Message-ID: <20230301212239.2098980-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 0843d82f-f861-4604-31a0-08db1a9b24eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXcsCtBHwG/AfZnUxzyDIqAkkRUKUUnr+5kPyRUv9O531mXq/z5Xumb/3Z66+e1mJqAKxGeL9poJabdq0aCBMAD9BU7KUkypcI7t5Eaf+19Osh9/WjV/1i1YRR9qX5GTydjIbk70LnPzqrs9yCpGSRlSEHNsL5e9AlOkaBXhwZU3ZvJBjLo9cM2Hxy4JJUs0ddaZDSF7t9rzIu7vi62j5gGZihccLeS0pmPtBrCPMD3ZP/vnOpqJYzdiN2Zwubgdn4mhggAKh2+Suu9NbtCShKK14kj4uTz4CGrTkvoMBVjfB5KtGMLsKwUjYqg1LmKlMlabPhmQlO4qzxo5aM7Q58Uy1x122AlG9lGuc1s1IRaaR4s7RMFHXg4QD9EwEPvQHTMFAWpWr9uymFwOf8wkiis4W8cX+VzAHkXQXveNtPFc82v6CR6G1JXw/jmTv3FCkrg5EQWqoe1uQT+jG9Etiusqy9X2t8bv1wGXWJU4hok1OLbOaY2Ahxm0dx22gSEZltr+j2FFg6gwi3WUL8oT7241gpgUPjj2Qp71Iec2aEFbvNGD/Qdqc2JORVm2PiCahyZWtwwCiWCow/3Gc84CztEp6dDYvbptlXax7TESCIvxAhFLaisEYraizJZxhVwa0kKypw0eafgNszWNVrPFUvZFMX0iIK8L/2Y3kuIgVQKvw7hRNjwGCshv5Q2Nv5Xz46xERJpO2uH8D1C1cRjTxNk1Gw5aE1W6yluBvdm4qG4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(86362001)(5660300002)(40480700001)(8936002)(4326008)(8676002)(2906002)(4744005)(41300700001)(82740400003)(81166007)(36860700001)(356005)(6916009)(7696005)(6666004)(478600001)(316002)(70206006)(70586007)(40460700003)(82310400005)(47076005)(426003)(2616005)(16526019)(186003)(83380400001)(336012)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 21:23:04.4234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0843d82f-f861-4604-31a0-08db1a9b24eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This add support for SDMA 4.4.2.  The first patch is register
header updates and was too large for the mailing list.

Hawking Zhang (1):
  drm/amdgpu: add sdma v4_4_2 ip headers

Le Ma (2):
  drm/amdgpu: add sdma v4_4_2 support (v4)
  drm/amdgpu: set sdma v4_4_2 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 1967 ++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.h      |   30 +
 .../include/asic_reg/sdma/sdma_4_4_2_offset.h | 1109 ++++++
 .../asic_reg/sdma/sdma_4_4_2_sh_mask.h        | 3276 +++++++++++++++++
 6 files changed, 6387 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_sh_mask.h

-- 
2.39.2

