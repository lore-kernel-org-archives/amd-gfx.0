Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817FAC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B1660527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51B1660527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC566EAA4;
	Tue, 21 Sep 2021 18:08:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37546EA7C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWSGWhYylw+Lc17Vq7rbhyQdgYUfySWUacHtNxp+A0h4t1e0/qBNP6+U3S7U8vOhmgkEqU3YAZegetqr4w551nb1bq1R6n9hH0csVjW+pZ5g2wfh/ym0S0d1dPZ2fvDQ0u3PhZiYzAWqsx/x6i/RLE5XYOGoz6GpJXeapVLrNS4OgFhz5+JzodJHadJ5mmIVduhZlaCTDSTHqYJHwAdAuPcUmuYCrdnY5BheQNp1QIstlN2+uS+bd+90X5EPx1Weg22+DaJBQiw0vtlCX1MLHs0BCV4uEENVwD3Iq0BrzjtGdxrWQrhN9XiJYkHzBpu6WHLPvKB5SfHipbDKhWCpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/rUs0tCJtCl1rSF8aLs5BR/dBX11Yo0587mcKqY3Mzs=;
 b=PHt89nG2noGDyEcVPc3KMyKfQLB3RGebAc6AHqLg2HcMclBgjbAZnZSzYVxEIkIVjdNriIeEi3zoE1wup4UNqwOloZMVUJxXWkCNARdjaaBfuAIenQ6OUSL9D9blAXFGqtLcZxa0GawORhEwRM4cOpBG2HKNNITdydoKMolgT4g9vj9rqGRo26oD+AC5NC2UuIsyzu9jE9D3ccGTrd6DSUzUoc3TQOKjluiO5wgpuHuzpW6YuZSijP1eyUCw6UA7bvHX7JOAlBK9wcUXEL2qzJtyQQI0vYDpmaiXly2Xac0JwumSdSoVqvlK1f+GQ8L9KfRbtzUNM0c9QUQLOI2iKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rUs0tCJtCl1rSF8aLs5BR/dBX11Yo0587mcKqY3Mzs=;
 b=Xw8Yfgo44cCXfXpCDeEC7KGDOnht9VPtS0Vexs+bNL31x0vSZSctT0UUGUddZczYOrlyJaFHJQ7t01E4boAQm/BxpDt4vrg7dAfSmwj/XWz7RzgLtm9EBd82cyfKkTnEPvaDWiohfW+xvRRwJQSQyalANG03MfHkVAfOoXIWkuI=
Received: from DM6PR21CA0025.namprd21.prod.outlook.com (2603:10b6:5:174::35)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 18:07:52 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::11) by DM6PR21CA0025.outlook.office365.com
 (2603:10b6:5:174::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.5 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/66] drm/amdgpu/athub2.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:39 -0400
Message-ID: <20210921180725.1985552-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8957e14f-2ca0-4e8d-30c2-08d97d2abaa7
X-MS-TrafficTypeDiagnostic: MW3PR12MB4347:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4347385E7F875E436B315793F7A19@MW3PR12MB4347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjuG7Ucr2fGJ2tZyz4TVskkh5+Ph6gV4GH8HuOJsGZOaxq5uYndgsotwVrUDL9RbmANywoyTTJoo93ZS8Mmu3myTQ4gmwqKYR6cOkUsdnXM1gttOmBVJ7SLYAQ5I5ZxaDyP4T8uyemms++xasHybxeTtS9LJc+8usOOQ4WiO8xh5kLIVoUsGAj1tOU0m/iQtTnrWltT/5XlqByAbPncBxpAY9OpizLi4AI19/8RpHNrUsNxZjiF/iqgUyJecJxsbHOpjDb1p2qrV82b1zBLI5ga6TL35NQuiBTmzQmP3eexD3RKkFRlSgDq+imiEQFltkU8k0OzD2EWV/N0IGYA16k/Y/jXsXasi5vW2aeFCILzHfz0t9cx9KrBXb07/dEe7valhX7IZ21qdo+xBrp1Hk4WmunmPQ2eGaHrVzVN1LKPgSzB5PE1ZyRpxO/kMdkv9gwJZ3JX0COCU36ZlvDgacBIMwrGU/DP2XRzWxAUgu/MpoAhQ4kBEzyEfdSqDiF8IRyZ5My9gDcOfxnSVyqxqogl2hn/hhSc/p/6TfQp9jGJ72lTenCImvdais0npclgi3M8pxqGKQ1qZagfdkYZvzZh6xgARUXTX2W/EuLA+Jjd5oKMC/IufsPvbnXBCfBi0Q2KPxA8bzKtJg1tr9UzzVkOdBesibh7sWe50A0q0pqgDp6t1yBO20jTiOQtXCR1RS/4zEfMowauS+XNz9xxV733pHidzfQ4cMxb5uha32To=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(186003)(26005)(36756003)(1076003)(86362001)(4326008)(47076005)(4744005)(336012)(82310400003)(426003)(2906002)(36860700001)(7696005)(508600001)(83380400001)(2616005)(70206006)(6666004)(5660300002)(8676002)(8936002)(316002)(70586007)(6916009)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:52.2454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8957e14f-2ca0-4e8d-30c2-08d97d2abaa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
index 3ac505d954c4..d3f634eb40fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -77,10 +77,9 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
+	switch (adev->ip_versions[ATHUB_HWIP]) {
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
 		athub_v2_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		athub_v2_0_update_medium_grain_light_sleep(adev,
-- 
2.31.1

