Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E153BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 06:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD0010E53E;
	Thu, 17 Nov 2022 06:09:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1D010E539
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 06:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iifW+L83SK1bqxSESaiBwIbl2R91FW0+MuTauCChK9Mk0u5q0/jKqnaWoKZMSAFntm9HzAW2nRVkvevJGTTgowQjKFykiKKu5u5KXqk81xz2PYllGAED9mmFArtXQhwCeJh4mgaEnMIpw7qz1YuihzLv2wq3NYQ6zb0+Xlcrs8EX5ntmk696C62V7fF5lUH0xX2zJs90D+b1+NAlKgJjy7kmdSfxaCigiHfRDlXEXfa7+rqMx6IMs0iDbnIqCvXbnbksJBvINAuIXwoOx7hmrU702MPHxn50ZCc2+WOoIulOX3DuVO6urqq0lwBIKLNyI5dX6Wzzf0Ert6QHHAlFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q01BNHBCY2d0S5YK9s0uQE7oOcIehro0YyR1ZOC6xC8=;
 b=EgoFp9sjzDmsLWbE27MQGsQB40lw6JRJP0oxJN/lMKbw+8Q0SMfKJMTZko+Ntx3f1gsUGHKCfKMyW2HxXn2f47xzoMRP/wWjed7n/iEv1FJPCpGK7k1v7qWu3TzV8V5A1Oq5USMCc4ZSN0irc65aiCZdFIand4+H1fxeOQ6jiAD5kBAIasc6ANFZ6I+0+407ZHtHU4AQCK0Gl3504nj75fb6aCP35sPk4Utb1jQ99D/GFGVE9X5bFkv9VLz7nEUHonWBKSk+pyX+/N90pSRMflXil6Pg7QkrYkXyZ2IOpmECA4SZaKY2FqhlczzbUTHAYI6+NHX91bgm7yNRG1o8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q01BNHBCY2d0S5YK9s0uQE7oOcIehro0YyR1ZOC6xC8=;
 b=RESVmrPL8Jk5ViZY8huqPw05XVjhj56rDtXNQ1R4pziBMniqtoPmtOqASeJDcs1PEA3Rc02Wqww/nTvzJPbriAws0b1WwThqeUs8Fma11MmHAGNR5gbjfZDhUbXoh3O0/c9a3z6wweR6EkpcHpCQ7s5Kc/n0GiKA1+zDyTRvxT4=
Received: from BN6PR17CA0056.namprd17.prod.outlook.com (2603:10b6:405:75::45)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 06:09:34 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::38) by BN6PR17CA0056.outlook.office365.com
 (2603:10b6:405:75::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Thu, 17 Nov 2022 06:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 06:09:34 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 00:09:31 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: add irq source id definition for VCN/JPEG 4.0
Date: Thu, 17 Nov 2022 14:07:53 +0800
Message-ID: <20221117060755.13655-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117060755.13655-1-tao.zhou1@amd.com>
References: <20221117060755.13655-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2998ae51-9586-43d5-cef9-08dac8624ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kFfe3vrRWni0cxns3qqB123Vtx1qChOdp/thJn4lKQQmbj7NTWw5lE4AEfX36D4pRmOQnbLFHou37YKaqipx0HT4wF9rz6BhfDX91WToRhbhxRqHYiavjTYESahhWf2rx/yPU7VqlyIHV8fBLZsxQ/0qOYNHcmQP5IUSe20V2xNraaDFZKbV3IMzn5ULxB2b6cukn/0wCTpn8reotODDd4s7KKEEaslak6IAvM/7QCymP1++R77oQ0BkPot2wVQjU6eI4td+ra6P3R0YrQCZrra+6u6+wN4IQNiLjFxNLu0ZQj/f5qSbJEhaRmN5G3PWVHsur4SRDapjzjjbWlGoXA/NkEyOO7JDKblqSZlyXZQ2VOU03wDiNLhUMqp4R1XmqcRcYQcv0AhNoPj+BrAEhSRgj+BqjqrCRKsbQPadGhVvIENQ5yemCoLe6/YtHRI/59Bi6Y1yrBjI8MMpJsb39Y0sY2JPPXdlNWGiGJNPBcLapzEi4mzRYJ0DGXUuVaStx9bcTra+khn6rE6nhS1NJjxJRZnWBcEcMD+HFdp7lz8M5ouqglslBkJWVvyO3QLH+bE2FdGVpGhKwjtt2XreLKm8/B/XXXZGpZikSkUBZdpkCPiIs1x+jYLmb80xeYsv7JXnQVpdL0JHi2dzNsNhPJXIzko1oGqXr8p+1TWU5mU/QR72dguqTG1iV4WDQMLFljmq4l6yDHrJuF9YEQawAQGPuN4bpk6f0H0qnnPKsw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(41300700001)(4326008)(36860700001)(6666004)(8676002)(54906003)(70206006)(70586007)(1076003)(426003)(16526019)(336012)(47076005)(186003)(86362001)(2616005)(40460700003)(6636002)(110136005)(7696005)(26005)(316002)(478600001)(356005)(82740400003)(40480700001)(81166007)(2906002)(82310400005)(4744005)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:09:34.3185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2998ae51-9586-43d5-cef9-08dac8624ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interrupt source id macros.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h
index a81138c9e491..03cfa0517df2 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h
@@ -38,4 +38,7 @@
 #define VCN_4_0__SRCID__JPEG6_DECODE					174		// 0xae JRBC6 Decode interrupt
 #define VCN_4_0__SRCID__JPEG7_DECODE					175		// 0xaf JRBC7 Decode interrupt
 
+#define VCN_4_0__SRCID_UVD_POISON					160
+#define VCN_4_0__SRCID_DJPEG0_POISON					161
+#define VCN_4_0__SRCID_EJPEG0_POISON					162
 #endif
-- 
2.35.1

