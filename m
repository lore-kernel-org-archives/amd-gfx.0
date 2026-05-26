Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C69CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53C110E487;
	Tue, 26 May 2026 14:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M+fC2EGT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493C910E487
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEoZx8Ghg8jFccN2JAidJ5kIcggdVEmmctTK1fsIGX4GrydNInhE121tRMrHxZ+xu0Al4TZZ1aKKU6U9eCFVc2r3GPq+l9sOpJX4GgJnJMSLxBmeJSBbQfLZSSt5DXcH8dn6fJ8W4tDG9PkAANq9l8DdE61a87d9dRp6kwlKdqfOg2Hyfgtq48yuA68ApF1w+0472q7g0/f2x7Fa3BZJdeIxlculF5+8w+OdAn6XUCqeoNqlttL0Zg+K3xFAXr6mjgaNGZcAXXETx0oTg2ob29sTNF91ALKJlzVJIPW0FDusUiAYC2UOTHzVR86dku4/7onNJIcWY2yoVNmTn12xaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEq3V06pKvEIL0h3Lii5iDpwAahMTxuxACI4ZSzHH2o=;
 b=eyQ5LSIXrCXBOWKufD/e1TCMm5P08a21QWAP75BilLVeAWanLiemj+RJ4foBJWGIBX/HzsKUGt65DCkByBPmWHnSPMp1HrxQCafQm08CG12CttGmaoqbXFjSjCIcTg6i4BkM6lTEJ2O/dxk+foMQx5QI1K+OmMSYcViLjjYhhkm0sVFzC6lqvJgIcTFk1hiDMLPPUrROpC947A5qNA8zIALa0jmx1ndXvZMa02XXmIi+MZzDDVMPTNlIMLdQWyVVXPkEmf7IsvXEFrU/B7kjtRzY9gwsjuxY0LWAGYei3VLJlduzwdvKlM30UHd1mAzaZm8eiNNfhsOuqX1Wqtp+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEq3V06pKvEIL0h3Lii5iDpwAahMTxuxACI4ZSzHH2o=;
 b=M+fC2EGT2hcpfm7X8g/vyOZrb1RD5pVcQz9g3sLUHJ98d2r+GinSKC5CTaE5cWpDA+4hGaXx7YzKig3Q1Z7rJyJjFof/oZer1dRVSViERPzaP1J4p34jqsz99hLl9y0BknS4ZRZ/tZi1pW2IHBn9AoYGjqwTCNXxhUH7h4Cxdi0=
Received: from MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 14:39:55 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::5) by MN2PR18CA0022.outlook.office365.com
 (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:39:54 +0000
Received: from caden-arch.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:39:52 -0500
From: Caden Chien <chih-wei.chien@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Solomon.Chiu@amd.com>, <Peyton.Lee@amd.com>, <HaoPing.Liu@amd.com>,
 <Yu.Wang4@amd.com>, Caden Chien <chih-wei.chien@amd.com>
Subject: [PATCH 0/3] Add vpe v2.2.0 support
Date: Tue, 26 May 2026 22:32:16 +0800
Message-ID: <20260526143219.609033-1-chih-wei.chien@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf153b0-fe77-4cec-0dd7-08debb34a724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|6133799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5cvQwB3mslSaBFZrWDDrrMHlcmacx7ewIqQ4KBgwUgHbIrg8VlfnrwLoAiBvzKnBOaR8Zw1moLMOASEo11V3nzxAy4eQ7Q7rG/5+Z16L4V4dQSK29K6cxWt78TsqB312k5pcsohLVyE0SyV2G9ELscm/ke8gXJkcWSYv2ARmwJob04E94Gez9B3tIZgxWPtt6xyBTEz0bxggZ4UW7aH04vImz0TZ+IZE1tTSVMIbG9vuQ2V+NZQzwQ6iFdcLQx9oAlsRICidLcudPjgEQN+XaadraeUR0U/f1IPjtKAixSK0p2BXnTdrvEpyp3GtDCyN8NZvKm9ZtefrOffXWSwFmnh62ShoBp8D9Cx8a6396BHu4quakjxKzcAq7wP9YGlRW2kRiQ6yIWST7aFhRN/Pqh7jSQ3xlG+h7eF1shXTmmW9bkjHYBX5+cZKXPZ5f9jiol7BwsPl4bSj+2lu+TptJTY5aBmQMm/iREr8oYhtax+5SXO5u1Sq6Us3425nbTQWfP3i+9sB7fWzYoqvCXPD5RM0jyrVNBoNc1dsFV73p2ZGrSsUSEsaGKLXvbypdLQBnvU/VIgdW1zQG1ahixJKBfIbA7CmzNZtdHSnl5w35N+hkX0OomjyZcCY1rNvDjoIv5HY8S41TXALnXolPToHXD80nTZbp5BubvzDglZb1CfggtyGMhr5QAmnoi4xjTYeX0JuttkZMPPDBRxJXLmMFZ4rpa0DgEp9hfwtu/5gyjw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(6133799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yPcMGJnhazWElVOFDcNsrPJ2elMwvX7bCxBxmyt5bkEoWNWvxOoUtwcF9hLDkCUS/N3YN/9swXEeD6cAtU7dWn5fkUwFZn1SQ3qSluh20AyPrZaZF1M/VD5h37mRvc+mehChk7FcWomuLIBdqpSroo+IlHBGzgD/qkjaS0d46+NZgCLFE+6SpfrbAOGECqcpuokWdX3G2SiCInThKUMGe9P99PwCrzhhz9/Hu74P/lbvD0VI08+mHyceVs5yYVTgWkiki0N8S5ZJBlHRbj+xNArUuw5sj9zIghfvUCIZi31EC38kCaDpjlxTpXQkJdP44jspMhg5TsZpUdiJ10Jpaa9vcWhg1HjWc3gELFlwODQD4dSyJXd9g6BUERbXDrWKupCiyqSqtOsZCh/1RZk09JRyu99ULp9PkKz/AU8TtFpJa+qgktLhu194+JrWXRBk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:39:54.9603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf153b0-fe77-4cec-0dd7-08debb34a724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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

This series adds vpe v2.2.0 support in ip discovery and ip funcs setup.
No register update on vpe v2.2.0. Doorbell range initialization is
updated accordingly in the same way as vpe v2.0.0 on nbio v7.11.4


Caden Chien (3):
  drm/amdgpu/nbio: remove doorbell entry5 for vcn on v7.11.5
  drm/amdgpu/nbio: enable doorbell range init for vpe on v7.11.5
  drm/amdgpu/vpe: add vpe v2.2.0 support

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  1 +
 4 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.53.0

