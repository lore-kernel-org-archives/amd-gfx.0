Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D8CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46E210E7E7;
	Thu,  5 May 2022 20:08:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B6110E20F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUkdW4h7I7FMr94K5046rq0GOs36XYHjT+KQdywkbKO6/0qOikOfzQ1u4j3qK8vvH3uNyOG2MJJ7cRf+pyrd7xgdvmGTModATNS/euxXGY8Dmqus4uKpAIt2V2Ftna8NN/aEWPT63Kn+gzE31v07bZj5AhdM8bVuFfDl+UejARK7QS1Qbu4xoqVoXviBduFaYLaZNMLNBJTUR2nDyKl5ka7Z3yim0u0+bjIzGyvHhElxRRcznZZoHCx0ZTt74CyWU4GtnPU9J4BTQxQlcqHW07i3MAWxp75O6zi/l0xjX6KQwLTh0E1xRhT3/8nOjSFyG5NvgTWDJy2hFYZF7SZaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/fh8lLWEzTmzFuX+26ufnyoc+6MPMltgqQhCDcmY3A=;
 b=J5UeT8LOhTgMtkTyardoRYgIvFzfF+xpCEiThW0I786+FGmo+ULcV8cT1Ti4lYeTdlDKcWktpmNeIB5EnsHW9FimVwKat9p38eR2I7rtFSTbbLxlpUvl1WfM2RxxucjWEcFtH71WsGpeKmMx/NftIT2L0/gvncsU15WXWRW9OzW0klWi7faHLKeonxgEHqGj5eyzJ8MVc0E5mrD9IgeZM5ZTcr41raSIBhhbXGy/GjpOJTsJ/VDOrWwxq2ms+t9lU8Okq+uGa8CQlgZcy4iG+V3dsf5Ar+2XmlNLMvzq5lZQ5/0c0NNuOeUhbIUVPoYbjGad0U6niBgYNNEqrjTXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/fh8lLWEzTmzFuX+26ufnyoc+6MPMltgqQhCDcmY3A=;
 b=0eUdvVSDev8N/NJgoqvWIUCogw0ESFpZLGJLhRv9t0g7PNladGH0YvEikaRx8PRhY1z4NcUKCRQGnQMeoA78SrDh9yfUm5jcvCYUVYEJ6DG9IsOcfsgPgqMY26JWVLn74OYWkDv5GUfmUMRD5J/vW1gyX4U7cDRDUdfjzi10jzk=
Received: from DS7PR07CA0007.namprd07.prod.outlook.com (2603:10b6:5:3af::25)
 by BN8PR12MB3475.namprd12.prod.outlook.com (2603:10b6:408:48::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 20:08:37 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::d6) by DS7PR07CA0007.outlook.office365.com
 (2603:10b6:5:3af::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 20:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: disable the gfxoff feature temporarily for SMU
 13.0.0
Date: Thu, 5 May 2022 16:07:44 -0400
Message-ID: <20220505200750.1293725-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c5aa28-ffcf-4e6c-36c5-08da2ed30a26
X-MS-TrafficTypeDiagnostic: BN8PR12MB3475:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3475E600BF26E9D289F3CC6CF7C29@BN8PR12MB3475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0NaoBIsqhZqaAJYs4hWJGnNrjrnL3Iuzm7G94UaL7m2RpB6aabXz52ObeZFmRoZ1sf9obmJ6CT4suh6NKAsZsNs8LrPKFn/Ccqaevg8Q1tB25YjdW48dQM2+YlYd9G46KucfNHTl3HwQYH0/O6/oCXAwTlqFI0OQKM/8I64r0vAwNoiajg8AfCA67kcDRFOciXTJqNKDxUumrUVxqlSZqB1I6pR1U1L/tyvzh6hN5Usp4E9OVXiVfj12mg8svzLCfc6E0FIlYH1rv36lhqEbpTlMPI8LENqEIGusSfaWk+zsAO6HyhODJYU9xsPGnKJ051hxR6mPqkOJDVyqEchgwfL1BW+eQii6p2BI5VCHMtEXukgH1OLb5HNH1sEQi/EH2ppQJsISoeN4bm7DhNC4yzb/MoejhBAeBjwN1EOgwsDebix5znbGTbmm/ikBWEFAmJ+D3K8lYz546+pb8RsLyH7NeBOekYHCJEScYvenAvGGaxf0qCx3X0hmfMZ7gFohdgMlxvlnUA48B796btmiKIvfkJ7LT9HrTlsHpMWNL8+CFvEpDNNnKS4nku7bTtemyB46ol0QIEFdDTwHqQiyoDsL9yX4qEpaiDM46HXuPBZZwTtogfcesBZY54iBQypp5qWA3ye1/I/6Z2oZexSSiJKqT9ZMEx9LypVPVQ7G62/OHQJyNL8vuqb9SqyuiPQNAEgEASvvy+KsdsaTeq3CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(426003)(336012)(86362001)(5660300002)(2906002)(7696005)(36756003)(47076005)(16526019)(36860700001)(6666004)(1076003)(8936002)(508600001)(186003)(8676002)(40460700003)(6916009)(54906003)(4326008)(70586007)(316002)(2616005)(70206006)(82310400005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:36.8662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c5aa28-ffcf-4e6c-36c5-08da2ed30a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3475
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
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

There is a known "sdma busy" issue with gfxoff enabled. Let's disable
the gfxoff feature temporarily until that issue is fixed.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 80455fed7a4b..86f98e968341 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -228,8 +228,10 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
 
+#if 0
 	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXOFF_BIT);
+#endif
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_THROTTLERS_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FAN_CONTROL_BIT);
-- 
2.35.1

