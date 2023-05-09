Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48203C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895A010E412;
	Tue,  9 May 2023 22:11:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B33610E411
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i99cm/tsPPu+K41YxLABguRtDHE7O/hFCZnvQ8oz8PGMzsoei1wrL/+2IiP4j81PVtyxwVY46G3lMsHgbm2A674z3Oiny4abIvQQYWLqP0f/6v1Iz1EBRmn6Oird+Qmb3WhXhKHxxbHfadef8B/A5N+a9pos+lmKB2mcP8uNaCtgTMx/XchpUgRqKZnj/nS2zYFbo3nYGsqgJOP6kMuF83psDOOK1gFAa8me5sWvdtnVJFjdWkKsFAbts3sYIAQp7zLogUekaxJTmS+sCYgyGhjlTRIS5pdWAdWA5Y29liOY0U9HQzlsYYdSgdryvmmNJAhOn5ei6f3e1Qlxpz8lXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzkNpLKScC051IaJfN5mKkmuTy0jBM6PPFp/+QRg3C4=;
 b=J/Qsjlg2yreoM7nmNgTetNvbqHvpZVlggzVFS/1LseE3lIZsHWBNMCvgE3hpCshyk+7RxIdrp6mjMc1jb6y1OqMKD+ePi0e1PkPUk4OEkUdic6ScJnkradRIGYKyewKmqwnkBT9QbXiNg1c0Y+JO/U4VuYrmM/7F+iYEButnep42RfxPToEeIyIlxA7Y492Mqjp9Zlklf5HpVj/WBrYDGHZdGwRmG0qLIoyaXgRwcSVIXYYnhKOydMNPOsxpgIUmo8vo9BxHBDV0wX3RcyoVFHFzCLvcqomxH6tadS8EFWjupmuJFq9IEpaZejeuy68O22KScZa0Y6XcIHojv8zs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzkNpLKScC051IaJfN5mKkmuTy0jBM6PPFp/+QRg3C4=;
 b=ZxWV2o7CsH+z5YzZZAFsp2IOzKvWGWFmYvDQQcefzFaEUxiXpCSaQVL0n0uC3jYHglIrPz3sEskxElKOcgqkjsVFP+uBDEc2RBPJCY5IIT9ikBiYZOZPBVle3zWEDjJqpqhY0TqBe+tdV9g/X7zmRht4qvmK9C1NnfQEtyvsCWc=
Received: from BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:11:49 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::60) by BN1PR13CA0023.outlook.office365.com
 (2603:10b6:408:e2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amdgpu: Add a read after write DB_CTRL for
 vcn_v4_0_3
Date: Tue, 9 May 2023 18:11:26 -0400
Message-ID: <20230509221128.476220-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 47002665-1403-4b15-5b99-08db50da62a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFtv9qtfFotp9PzFHB8HDMrslJ8zbEHsk9BVtuRFoPA58iA7ukixCJktV94/A8fA06YMLqmOBd8+osPN9sS51pWHSbOvR9iUHj63D/V9xuLbsZ+y62ND/1gA41kzL+gPATRhL/USFuLiiBgDj19J17E659OMwS8zw4mXmsn5G/Oi+TTtiKBt+LPuGGOUDQYT7KPyl8CeuPYalGgILtD+0pq6eH9vS5cN4hLVx49Yn9MA/qJxuhJUNM+hba3dVfKb87PPdalgWcs3W1OO51QS8ieTteVfO6+LUvpnfL3krssUL8UIxOoyCgnvDfn4EI1d8kxU+TVYmWLulUDtXzJ/IP+t6trqyPF82UDTnCO3YlTaEFSZF13xrdnKY2v/8IRFN6vfvrKXyNUpIqXiGTvfNQw8kmXcBDTV3ONgQGgJmbBk/lKFZ+J6D/M8KutfX+OiwhcEhH9iS2Mq8/x2cTPpRhj5SbF3H/Is9CmIi1I2B433GEkDshY7UeFfA1ltlKDaFD/QFkZY4QTefE4JvV8T3bpTOBMydA6H4fBskhOlmHrK6xtFLznOP7rD+pCuMR4kNEJfdTuj+1G2f1wWy9BUM5GWBM6Ndtjqe9/OURUZ11X4mpCj5vNWvKxp5cQ6xw0W/xAQdMABYGxg8a6u9HANS6NXDrdN2i+yczvN3DYLnndFmi/8wXul1AlNXPjFRC6zaOWVhEXbO3JOn76Hrk4mppyhBTF/UMxl97GO73hFoRk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(4744005)(8676002)(8936002)(5660300002)(41300700001)(6916009)(316002)(4326008)(16526019)(36860700001)(40460700003)(70206006)(70586007)(478600001)(1076003)(186003)(36756003)(47076005)(7696005)(26005)(6666004)(2906002)(40480700001)(86362001)(2616005)(336012)(426003)(82740400003)(356005)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:49.0750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47002665-1403-4b15-5b99-08db50da62a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonny.jiang@amd.com>

To make sure VCN DB_CTRL is delivered before doorbell write.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index b0e28d611f2d..9d0c3dc76547 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -195,6 +195,11 @@ static int vcn_v4_0_3_hw_init(void *handle)
 				ring->doorbell_index
 						<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 					VCN_RB1_DB_CTRL__EN_MASK);
+
+			/* Read DB_CTRL to flush the write DB_CTRL command. */
+			RREG32_SOC15(
+				VCN, GET_INST(VCN, ring->me),
+				regVCN_RB1_DB_CTRL);
 		}
 
 		r = amdgpu_ring_test_helper(ring);
-- 
2.40.1

