Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4A5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC8910EA3C;
	Tue,  3 May 2022 20:09:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A18A10EA1B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAKE6qT1yFI1fuSXYt72Cc5i6p/biSt80a30KoE/FX0acPayNDikEfjm6SXGfM1btclmdezOC0pyZoD23gBykc3bw9opHZTzyBWAmDnmqw6G6EkWqirVnY8hXVWOkDC2yiiPLRUrSNmCJomzPRUClR6L/q0n5mLH94KN/h2NMbi9JKV1bKRBOZqunElARsyv/vzHwavoSK+yt/yjpcgIA1JwD35gTqyVWeFI1sV2dNNAOnAldQN64cXux0MJO4jrIYyw7PKKSzFl6lBYRYpE+MQsqg6Dw1qzTdcpT2Ku9+WGClwQWGytAx8zs8DnkjIkoeILQ+T5dNUak9K/0tV7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqNUdO8xaEIJ4+znlTF5afLFCFlQxDYqJOdcyXDmI/o=;
 b=GgU8+X6TjhEbMYMW5QbFICu2cGURSGTFD9KEUGevCshOEzXpM1zYTob4OwNhfqSYaya4aydZ+Bak7+7aKJt2CdiLqDPbkPfefhbUFKXDM4mJmc0eB9lFOD9FeHZ3U0CZikl1hdDSAoBRCeJYr+N0SqtKTxp9vkZbSK6KvLWwmq/Z9wl+n3oXDWgr6Ct4MaPV/aitTPjE0J0C+6lc+Z7xnLqVx/OIBRCwIjXs6QgY12ml75ReSNaZ88dnMHZcpIX/cnMYhQRGfs3YjEdbJijQauj2XJ27lH7XBoMxx7EIKc8gHPL4K0G7irjeeWtkdf61lhmdIaEryERFZGi1GaWpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqNUdO8xaEIJ4+znlTF5afLFCFlQxDYqJOdcyXDmI/o=;
 b=TnJ3LaAa0FYVY6LWc4U0eND0lmpfn/I77WWtNpFbniPA4Fzq3y8NDRlWsZmokIbMKaPtkHB2j95/R0MEdbVmgQwT4HjLiKSxWvGb1/qjdZ3b/Wj1VjLDyNAe9HyrgBBYHhQLllbNZ0Ee2okpSr+fflwjkUgMcJ7eqwzqeKQIh48=
Received: from DM6PR06CA0037.namprd06.prod.outlook.com (2603:10b6:5:54::14) by
 DM6PR12MB3884.namprd12.prod.outlook.com (2603:10b6:5:1c7::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Tue, 3 May 2022 20:09:20 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::a2) by DM6PR06CA0037.outlook.office365.com
 (2603:10b6:5:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:09:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add smu13 support for MP1 13.0.7
Date: Tue, 3 May 2022 16:08:52 -0400
Message-ID: <20220503200855.1163186-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fe0239c-305f-4b54-3093-08da2d40cf5c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3884:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3884D0DC4403FEFB1F5DD6FAF7C09@DM6PR12MB3884.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bw587yHn3mV0VeVnrMiMCv9If40NHs1/EuoLIB6lVTL7vtDMkIkCDMuPG5LJYzVm/u8dSn/7S6V/WnQAUytu6iBFEDdQ+VBXh9xKDKrQHuEZF5V7QH3m30QIps/T2nrQ3WLvof0YbAcRip/0mrVzFsPzIUVWKhj5A6/pEbAhZ2yzrK5HXhkBEz17hlP9mS3vY0RJh7Riouj8tlRL3a3dwZzBbObSTuCdkv2U256qVNRFb1irZu/7J3xx56ChLzarvBOBwgx80VJwaQhlHs4WWpz6LUSx1uurJtQ66/EjlM4yCGlwKl3Q1IBnAVhsjiaYqvG+ifOUWEgjfOg5lKWSi1BZDyyNx3LUzla4GdGW3MvwhXFvP1QWKIsTDHgH/Tii3Cb7KqtiwdLKMjhSlE97ETJB2/D1bllc3PeBDu4rJbjGlLau8n17CywnFQC8V0Z3koVr2kPaLThkVngXN/IWcLFWusqq+LVEztSo188wF0IeY4Z6xStobWd7eIr0qdk5Wg0TwZm0BbKN4f4Rvsk+IX0k+dAjp/Qb8HBW7pBFIGhd/zRre+grDhqona92yxQvM6YeXB1uAEpGb+BftzKku3gs1ouL10CldBu3VlhoIKBSbW+lEIiheUoVhqNoUmRhs+jI8qj4+jR7e+WA6VanABuoP++7TGtt5Wj8VtJ7lbYNavFQp7JyuoWb79BbRDn2zszmGe393WD75CT/rjQcTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(186003)(5660300002)(36756003)(316002)(2906002)(70206006)(16526019)(4744005)(36860700001)(4326008)(6916009)(8676002)(83380400001)(8936002)(70586007)(54906003)(336012)(2616005)(426003)(86362001)(40460700003)(508600001)(82310400005)(81166007)(356005)(6666004)(1076003)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:20.5335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe0239c-305f-4b54-3093-08da2d40cf5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3884
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable System Management Unit support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fb30c31b5d92..5263f94ff182 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1646,6 +1646,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
-- 
2.35.1

