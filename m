Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497CDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B239210E5C6;
	Mon, 28 Mar 2022 06:25:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6295410E5EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNF7FM+MOx+r8Qgb4JMwb7EJdy92icHIyMprgkSbnZjeI3gqP9ZZ77PaMZRUsXhaskvwydtXx51yCKaXU0dGJypmWLG/KeqDtcxnHPH9ZHRUvpMBeWFICtkW25yqsNReLhN5hcfZYVqUmbhhbavTVKegAGK2OEOpqfL/cB5EwKRK6BMI0uyYtO6WSDoJTF4k8yNrpRZTnQXVknqqw9e0S7N/anDJremLzHD9Yhe7o4XrZJBgALlMaOHzkLXPAKHnwX92UKX1oYt60AHfv6O7mmHOL7dUFDcj2xlj6vAiVXGvwQgCTUjjjJNiXgw1XoBsn1hB3mcHalRnzw0TBtidpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CnAq4Gly1HYGo5LeyRKyB8fRvWbL1h6j0kpUB81pu4=;
 b=axtEeHUIlvNRi7GCyjQiRHO/19p1hHCyir7kn7r8zmKilH0/Diop0lQY5OFtbGZ8MAu1gkOA10C5HoaaLQsDb72EjRnMYMJU1tnQpiB9uZn19kt1fyc/yC1WwQOO3Kh8CrwzItP/NcKGmxk4L4fC8ItxZFN7QYNlrlYd+HTfu+OfUvJ0gXIxsUPMz829er1Qnuz6X/rEzCbMFNrag8tupKbD4UlGyTDnBY2HCMOK4H03zIgEH97EANwuDEDXLU6SIVd5dxrm3vZ2pD81YkooCh9wxv3UzHK6yw6b18WYBDd59xynjz1dM0aJkfqMevxrqIsiq4hz+m3M0PbGzepZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CnAq4Gly1HYGo5LeyRKyB8fRvWbL1h6j0kpUB81pu4=;
 b=J6X+bxBcDIdzSPNe56xENDyK03kYrRdWa6amBI6s2rRTqbqpRBQ8Zd/QagkqZAeapYVp6DsMD7LCAq3FZqP1JTYjabIFmyPMrUL3ER8rOuBDDpjDqcWH3muN2s3CaX0se0n4DGtP+Zw3YCjwfiTpr792XUOhVQ5Dg63dYShsf4Q=
Received: from DM5PR21CA0036.namprd21.prod.outlook.com (2603:10b6:3:ed::22) by
 MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:c2::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18; Mon, 28 Mar 2022 06:25:18 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::21) by DM5PR21CA0036.outlook.office365.com
 (2603:10b6:3:ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:25:17 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 01:25:15 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/6] drm/amdgpu/jpeg: Add jpeg block ras support
Date: Mon, 28 Mar 2022 14:24:50 +0800
Message-ID: <20220328062453.4156191-4-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a9f0b21-5abd-4d77-e428-08da1083ba11
X-MS-TrafficTypeDiagnostic: MN2PR12MB3631:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36311702B61B2037E104791E981D9@MN2PR12MB3631.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDr4Bbnt3M0WR7ZkHthagi7sh6LOhjcEnQSc/9v8te0f3Yt58w94/iDOAiNDkDOEhMmrg/2kc8uOWVugoVVrSlI469aS9WNsih6aoCfTs59sRULupExgxjE/3z7xoRxzgdeHbV/p8g8nlGjiSwS+A5otQgnInfEqDRUMC/cvWy/44hn01jpqZH6JdGDU/YsjemjUXzITNFVkqj56lBbneHw13n9qn7Dv5JAUddS7WypkxWEsDz1K3jQCg3fVFM3I0AfMIgI/tRdZ+wcSOKMG9+KjHKwmmB/vIUOELf6rSyGr0LOTmc8FGbYbNSo2CiWZihPcKaonHZ/x6gnp0g6dxGpYjRsscHrXF8GIxSl6+YGIujD1wLJFQz9ALOM7KpL2A7MovfAk9fdpN7OjD292LSqYpdQl7d1/RyjJljWZS7UPdnFR7VskcxlK1CYegIpKQrHqLmC8I7MW9S/rKivJAc2IDjh854DCn3qhfwdbIqSE8lPvbPCTOrnNlSeb2DfG67l4JLiots5s2ucUAn1/4NvuZ+Pd8N01EV3Z4Y6WEToVWmnKkRJUpz3CxISA+nSfAhBUrCIaRcmPs8DkNCtEUFIi2WIlO2X4W08Gt4nvGm5c1D3GzivdmWHmYHftRQPNs2LN2GPY89+rekkL03phjnFQBMZWnaB2Pl64fRjeLrUELRT0mUFdgSPKibX73xk+Y1b7llP5dU7TUJ4ezg8rvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(26005)(356005)(8936002)(6916009)(2616005)(83380400001)(426003)(336012)(2906002)(6666004)(316002)(36756003)(81166007)(54906003)(40460700003)(7696005)(82310400004)(1076003)(4326008)(47076005)(70206006)(508600001)(186003)(70586007)(86362001)(8676002)(36860700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:25:17.3747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9f0b21-5abd-4d77-e428-08da1083ba11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
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
Cc: Tao.Zhou1@amd.com, lijo.lazar@amd.com,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ras support addition for JPEG block

V2: removed default callback

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 55fbff2be761..b6c7fb00e05a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -24,6 +24,8 @@
 #ifndef __AMDGPU_JPEG_H__
 #define __AMDGPU_JPEG_H__
 
+#include "amdgpu_ras.h"
+
 #define AMDGPU_MAX_JPEG_INSTANCES	2
 
 #define AMDGPU_JPEG_HARVEST_JPEG0 (1 << 0)
@@ -39,6 +41,10 @@ struct amdgpu_jpeg_inst {
 	struct amdgpu_jpeg_reg external;
 };
 
+struct amdgpu_jpeg_ras {
+	struct amdgpu_ras_block_object ras_block;
+};
+
 struct amdgpu_jpeg {
 	uint8_t	num_jpeg_inst;
 	struct amdgpu_jpeg_inst inst[AMDGPU_MAX_JPEG_INSTANCES];
@@ -48,6 +54,8 @@ struct amdgpu_jpeg {
 	enum amd_powergating_state cur_state;
 	struct mutex jpeg_pg_lock;
 	atomic_t total_submission_cnt;
+	struct ras_common_if	*ras_if;
+	struct amdgpu_jpeg_ras	*ras;
 };
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
-- 
2.25.1

