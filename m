Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8789C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 02:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5FE10E112;
	Tue, 17 May 2022 02:06:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9917010E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 02:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chl3302iUOBUxADIcZlwyXy7vFm+45hW/zACzf+6prS+iPu2kgSDXhzoZwcRlV5pg+o5mu593Fy6+w/yAPf04akLehs87LWch2GW6eBAE2cKlkxG9hVf1YL4VDwLuhg84O2JjWr2isw17eY48pQNe0s4VVZq0g9Tigf2hA6P+hKSB2YHn+q1geaKC5IqeR4biXqEDPQS5SojMekEaKYhmhbQsmPZ05ckSRTI6xaXgexWxF6ilaWQIY6wiKsM+24sDqVx5P+c6DnwapVSnZbwGu2+1YVYMBNvOhH3R0p9pnywJ7vPrOuwuspsRThkLOaQkIe9NJhmuBeXjpCaocu/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei5M+tj6Q0SFyXI4c6f3ZT0DSYGb3d9KIiqkzJogVuc=;
 b=Oj6fzEc3yWUc7AporjfzHxxc7zTlPsyVjdchd0QcfTo/ceRTrXXb/v3eNcTlCL7vUSZ2jbIMb8Ync3HiW3X0AenWL+A/6B18PzMN5IKVcxmVbFH/r+gxEcXMhhydonunHVrkBoXoTeEzLork1d6BwSAFdiSQBznd5AMXele8X4srBgBdLeSjLRwtqxj7RXAKmnDAS1uOT7y/qA8ab+YESQPMdiCn4Rcx/K9siQU6LDfb3yxdwaxY534lMcACOYbJ3lkT6tV2pJhA1BCyVxdGMXsEmXZbJGoV/gBfk4HcXxeoQplb7VmDf1r1uGrw2i6p7yZrG7O5MS9Dh16H/DZ7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei5M+tj6Q0SFyXI4c6f3ZT0DSYGb3d9KIiqkzJogVuc=;
 b=sF4xLEFJUyCYU8e+Fn2ZuQDRq+jOQY1nsN2NSZalSl2hDKIowqQHNCFjH+e6L104wRltRR3ZmjboQEvZeLF4sRTcY/RNOU78G48shk2cnTnYVY1jqZU6/IkxubPor8YgDZeos7OKgonPwvLS+e1yfsuailW7hrkRCi+3J4Ih8sM=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 02:06:46 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::a8) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Tue, 17 May 2022 02:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 02:06:45 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 21:06:44 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amd/pm: enable more dpm features for SMU 13.0.0
Date: Tue, 17 May 2022 10:05:57 +0800
Message-ID: <20220517020602.160108-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39875b41-d7ec-4de9-cce5-08da37a9e524
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51019F5A65D7769E3D2EEFD4E4CE9@DM4PR12MB5101.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvZdowxdmF9BgM1FowVmRXgLpoUyVx0OyCXyUUS1W/UrP+7YOCCfnw9s6ucybTC0m7jNW5Q+mpRaEfdGPhUh7kx1TELt0G6+rdYV3QbZ6zUcBtdBvCY2aUuOw+xNDcyJ8br+cj04NFnKxrrZRzkYny4agH9kks9XfbncRaypRJn5V3Iv7WcHIvmRgrSfRyQ0yOaxrohWUK/huo1JDHYmNdXfNiFMUK4K+Il2TQZP1XmgU2/kG60MRheb8jawN87c1cqDYBRyWK57xFMTMXRVrDVyByNgUTolDxTaWAyjEFSKsv1XnNqqU6S39szyhmz5oeeap3OAyQfJt2FbGObERRms+Z8YbfjWbR6ONaW59PTq83cpMkeBr0BjWgMseqwPtG+IYWqbP5REwAjpgwKmftBK+xU4BnOtRjpo1eMEI8HaPwCykY/5QsqHj1LfVg8MBzIkVZQFLJhnVxxfJ8mdJ8BLCrDg+l26NO4+zfx4ocXanknkjzog/Bzz4FpUshf9PPOFbIrS8makt1Z41uWR//796HzD1pO8gHeSGxg9RB5zR/4P0bNzttjWnHnDbO1gLFzPxNSQZNtJKfDY8qcirHg83Rw1/jIUQcZQPvA+vvHbJQ0nYi4QUlNc0imoGk+zvNz2OhoCTA5lmLbUsRK7sn6Cm/NUHAiBpO0w4Bz9ZZ8uaiSKeb/443Fp+vO8X6DiGi2iZ2sAIWTHiH2nk4QwuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(54906003)(47076005)(336012)(426003)(36756003)(8936002)(356005)(6916009)(1076003)(4744005)(44832011)(186003)(36860700001)(2616005)(81166007)(70586007)(26005)(70206006)(40460700003)(8676002)(4326008)(2906002)(86362001)(7696005)(6666004)(316002)(16526019)(508600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:06:45.8022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39875b41-d7ec-4de9-cce5-08da37a9e524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable MP0CLK DPM and FW Dstate since they are already supported
by latest 78.36.0 PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I75b6129dab509a51ccaf92bbc0b094eae41ea20f
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 197a0e2ff063..7bfceca246ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -296,6 +296,9 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_BIT);
 
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DSTATE_BIT);
+
 	return 0;
 }
 
-- 
2.29.0

