Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC798C43219
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B002910F8B0;
	Fri, 29 Apr 2022 18:02:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 710DF10F892
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vvhq3D3aEzOAnZznDjj1CyJvTiNzeVwyLlJy7x8Zjj9tFZFwB5VLfWtS0NNgeQZa8TG+OJgoGxKBOGQ9OCsdzzAjxlw3FE6FqIMEfRb99u3/Vv94g1Sxe9I60uF0QHQYyFk0hHuWWfm3Zozz3hg689K0Ga4xFE9vER/72AeKfB0VN94cG1Arcq7WQ8BcanfhI8r6yQ7RdttJqjtKHtc+wsQ8O/Lkqr2PzjJ6FLMsQJPpvHKi4JZEoGh4L6fee2oUy+2uw5DKBN6WdxxcwfRnyEFv5E2NEgD2VRd74J3NwhFenmd8Ra9BFdH0/2mhiQLcTQVIMe+cO1vP0+6r5u+2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tIAkulHyBF+VC+UorwVcw6urPFH3oAzRjtLW3aoZYU=;
 b=N1fkNvvVm2DFCwsmU656ScCwVomvNzZDsck56AXcQyph7fyFdLilF1Bs133M5TTweCWPq1xtioUQ9/JLQb0gR9bwAx4jmlZoaTWMWr0UmyOp+I3savn3nqxYMxLLfk6I8SrvanwpucCgdeMU6lAH0hm+6xnq/U/8r6f9jkbzVYEHOH3lSuxpDhPU9MLaYYAwhiZMK5uaMjXPuFLHwEdSqDtq9hv/RLUVqCyyW84JDkXHnPhbY7M7FxSb6/fCciDOy+c1nIaNrFTNi0Cw933Oyep6hF3bIiivvHaqv5xcPJllcfm74PWRtKi4HGcBUWJylUTB2lwqF/TKEKz0a7jNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tIAkulHyBF+VC+UorwVcw6urPFH3oAzRjtLW3aoZYU=;
 b=Cp0V++mAwglx79ZTJD093F8qSWBWnzXuB27hpTXvHGinTogACb1BR14BgqwC+CzqHga+can4omPiRdpIcJPnfwg5D64v+eGvRPsN/eXuaofHjPKpYjyVqdQZXWzhgOLdHp+sIV4HG/qo/5SuN4A7wibNRxDs9GZo0u2gSUaDb9c=
Received: from MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16) by
 DM5PR1201MB2552.namprd12.prod.outlook.com (2603:10b6:3:e3::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 18:02:45 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::d3) by MW2PR16CA0003.outlook.office365.com
 (2603:10b6:907::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/29] drm/amdgpu: init SDMA v6 microcode with PSP load type
Date: Fri, 29 Apr 2022 14:02:04 -0400
Message-ID: <20220429180226.536084-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99f7ad6b-f94d-49c0-95c6-08da2a0a7687
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2552:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB255247C84F1D7E31F2DFF42AF7FC9@DM5PR1201MB2552.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pW+Ul9mrNoabmniH9LoybrIjBlArqzX+a9VLbLr/X5MX38dvImysKGP4te0MyCd00ve/zwy2WzWsHxBXu11CyXbYYhlACxWdgsFuPcp7HgUpY/bfiQAProd/BbJEBnne6KSN8HtfKLXfistg0ptn/uBoxPQjbRfMbnbLXWvfT9l8vLNVb2nxl8DAvS1oG0g8lW05EftHp5SLT6/SHFFISeCY4EaTfTE6kppFrVF7IBjqLGH/4VtzKcUusI/2jt0OQOc05zjxgVYAo2goKj2NULqFjv/5I8d6mUxP9DNfOqekXj0fZyBwpYnjrKsUwmLSyIELOF5t+eZwZY9JF7F/XYKDTtSW6q7vex3IRKEjHbvg9sTw3xQl1k6xpBqoyTyHpKSPpWhNznvF4jvWrtKJK1B2kCVsMEFf440eD+mPZT5eX7Y153AEG6q95p5WNbiUSVQM6qdh9X/hghPKuThA12UsW/h/EnterzaDThicyZZm5o9uWLc3sVP6oJN+cIv3cYJSyyuiYpARZMOwBGZDnSbZY2m+FvAgY6VKJ22I6BEc+g2z63j5yKyfezOP8imuZ6riyj8yYd4+ZMbsTwWKlp3qN09p8y86EZtbKcD0SXfHDcNRi2qWbVmt+PsSufdl8AoEbVrjVUrzOKBVpYZhGFF1n0R/7CqWn+qtTKeOIiiP+DQxPaSjBkgwvJieEZM92n4ZJp17MlMJvvXzxnT2TQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(26005)(2616005)(1076003)(83380400001)(86362001)(40460700003)(16526019)(186003)(426003)(356005)(47076005)(36860700001)(336012)(70206006)(316002)(8936002)(8676002)(70586007)(4326008)(82310400005)(4744005)(2906002)(5660300002)(36756003)(508600001)(6666004)(6916009)(54906003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:45.1108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f7ad6b-f94d-49c0-95c6-08da2a0a7687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2552
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update to use new SDMA UCODE ID when init sdma microcode for sdma6
with psp front door load type.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 273432b75fda..4042aa268dd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -386,6 +386,8 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_SDMA5,
 	AMDGPU_UCODE_ID_SDMA6,
 	AMDGPU_UCODE_ID_SDMA7,
+	AMDGPU_UCODE_ID_SDMA_UCODE_TH0,
+	AMDGPU_UCODE_ID_SDMA_UCODE_TH1,
 	AMDGPU_UCODE_ID_CP_CE,
 	AMDGPU_UCODE_ID_CP_PFP,
 	AMDGPU_UCODE_ID_CP_ME,
-- 
2.35.1

