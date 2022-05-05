Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E09C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C118810E7F1;
	Thu,  5 May 2022 20:08:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3408310E705
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm8p0JHY0WEs1Eh9Tw3sHRJokD7j1kubtPx+Q/VNgru2pPHFDHdd5kofpNwImY+4jau3SYhcqrIhupiK/9bH/v9+LqLqVzSCy/MqKi/1vc2hb29HHiaSeheNpUy2rmzGZ2Cm3zJhjFaAzgz4xI1t4d/cp9OiFx6un3E4Slkw9c/sw6c2eI1iq41vJSMMzniG6f/9sisAolamiP8Et4QaolEgNDoh5tqalVJvbIxgw+7oc6ee8qJ8CuWxXrZWCxsLDBONaFRGJD5z6azUUHneOW7k2K++5yMT9+YISjG+Jf0p+/T8vzboU8021zGAn0i3+6JIvJPaY9v8+TNQ26e/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8iku0IiKAuL0FzGIqu0pxd0FleBbDy/Lq/gzqXTR6w=;
 b=TmU5KJA585IXSkyYsgebpSS147AEFJG2gqw4SgugpUYFIGurIyCGlhBcx2Xyznd0grGdGCr7db2gqJh/s4F2l2qATTeumgcwhZGN7TuBHNCUGF7JXoPSCEtQiyOgsosaAyoyg6T6TCbycRsldHjfwNhNJ3rsUHFK5StQdSuz4WnAIuNHPgRL6ljfcjl5ZXCg3q45E0SP0iRKNh1otn08wcmlk8XMSY5CnYK5k/+DYISyB7s57h8d0F+L3Bvrcawa0I92nbTvt+bTzW9Xgy0Wyyib+OhbynrPRgDOg1/9iD/In/U/B59IThkktD0++UgxpEvWMDFdaePS2Z/mxunb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8iku0IiKAuL0FzGIqu0pxd0FleBbDy/Lq/gzqXTR6w=;
 b=dID5sdaDMczukRM7yCu6mEvACJ9qM90UE4GsxEZvmrJ1velODpQK6aysVDQZYjDLlpacMc0K75T2fN2FGzNnIrlaRWRHBbUqxss9/M/uxDEpd7twBaU17ct5S6vi2gdQqUJYVZGB0F0Waz8aTaeY7f61p0nCKfRfbDQPPf+D6iM=
Received: from DM6PR06CA0047.namprd06.prod.outlook.com (2603:10b6:5:54::24) by
 BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12; Thu, 5 May 2022 20:08:36 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::fe) by DM6PR06CA0047.outlook.office365.com
 (2603:10b6:5:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 20:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable FCLK DPM support for SMU 13.0.0
Date: Thu, 5 May 2022 16:07:43 -0400
Message-ID: <20220505200750.1293725-7-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: fcea4f88-9efb-45f4-9adf-08da2ed309ed
X-MS-TrafficTypeDiagnostic: BL1PR12MB5947:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5947A5B4C7135CD88162F58EF7C29@BL1PR12MB5947.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqK5motzyxm4gNY3GA13F3Agiha6Djv9LgxlTIm0qUO/QU992PVVpWuW5n74Z2c7JehVgYT1a2o2k5ef2YQ1qRpKk+20piIVRJ65CELr5NabsfvbbOVab9VrmjtcmrUHzjtPRAHxBH3wJ1S7IfJTor4WojaswkK8hFKqyyP9vRnAi2QPdO0jx3m3MTpREBEQjq6710lA01RCaJ8S0y3lWqvpev6z8w3Ovk+J2vsh7edbivNhcfTs5JSZzswXvSiryB6OkRST3n+hHbVtSpMICKAV+UaJ2K8O1pnDXLjlIjdm5hKktAKODQ6BRtlojxuiD5XDgxJHxTPSuNKPMdS5QZtEVdvoF1R58r2I55v10q8K8OaUlNRvGHuLujFCeTE10BbbERYXsiXDxwfFo/htFlZXo9kfw4zZ6dQYrIfXRg1Jrw/k53NB7g24PacQpsOykDxW6LOHgP/AqEuow/TIbwEhnb/MXxFBW5gk5ODukvWUo+gSbEbDHWeo5vze71vVLRk/mI5Xgl3RFN8CD52u03bIP5gCyxHsgURMMJIrqQXQSVIEXmrQJlJdDg5lvQGZkSEwUPs2nAlmbMoaYFdjruLmMuI/PdJRE7OR7CHsfQw/yt1hXh5Ry2dHOzOUFQlb8MUsruTJ5H5atYpODkmVLoAmq1YYhajX5FwC07zPxLsRK3L4nsGG/8PiJTDuAvc6uzxBuBIxSjad6e0RQ+2mig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6916009)(54906003)(356005)(36756003)(83380400001)(508600001)(316002)(426003)(336012)(47076005)(81166007)(36860700001)(82310400005)(70206006)(70586007)(40460700003)(186003)(1076003)(16526019)(2906002)(8676002)(2616005)(4326008)(7696005)(6666004)(5660300002)(86362001)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:36.4796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcea4f88-9efb-45f4-9adf-08da2ed309ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
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

With PMFW 78.35.0, the FCLK DPM is ready to go on SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 6a4fbcb5c4aa..80455fed7a4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -252,9 +252,7 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_MPCLK_DS_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
 
-#if 0
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_FCLK_BIT);
-#endif
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_DCFCLK_BIT);
 
-- 
2.35.1

