Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2954CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 01:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6143010E072;
	Thu, 19 Oct 2023 01:43:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE80C10E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 01:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLSb5Y2KDVNvvh23f/31oEj54ZOpDl1RLK4qIwvdhqEKCDKXO5c4CeKhv+EB3p5XGaQK7GGV+SA8H5XkDP/LuC9v8CHo8/lrLZ+C1jzZHsSHUFmXtG0b706zqfYdQe8cjqVjWhqk+nKvc+LvJWrkYWxAIYi75RdEyOl8CPYzFDM/Joso30txZF3L4MaGMTjitzTpO7fawQOrQGIONy3gf7v0SEyu4F7CWf9qXM0e+GqrT8+D1i/fnL+geKTRH6nylUpinSj1hwNFONSpYbsuM6xg+P3yPgekPUWV20OUdf3mSpN8QPKFOEcw6RYA3bp9yZ01U2VZElEQPl/k/qf7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGCyLQ+ts/Ndcc8VwQUQXa/lKOFJny5jlAxBGeFVjH8=;
 b=Gzf6pwvtR/smR0LewL7jZ8yt1mQazV1L8ynrl2GEmkP1KUdVSzNX8g1xUs5GjkIalJf8sJeZPCord0eGcfa7wXdmfhjcYbuRXt5zr3T1JhHj2E2mR65jMprcq9MvUzvsKc87e0wPE3INwgKbEqPkVL1vSKBIGmHAkN1e6RTco7zSCa7CRCRzXoiwaY90uvYn6pNgDcRl4rCQst5hOqtuRfvRLLN7SK6hryVjA6LnP6KRlySkKAfV6/B0IzQcW/aK1ehM3nV3RjKMQAdy+4zwdwpEhlGnCBt8V3yUBJ6S2Uun0lKA/WXYgtQDxyYwrgExHz5Fl10IxQUg6q2UCteuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGCyLQ+ts/Ndcc8VwQUQXa/lKOFJny5jlAxBGeFVjH8=;
 b=xs0N/vrT253AUJ4uBKSJbHY3fNmMRGn7XX6AELg0NWzRJvc7jtJf7p4uuv5kQycOn0DqCBJLJX5QeObsbTyAmrAqaM4zMJxkKp7E9j4TBXwgW2tCAa+RiDXv6d7P5fl8/Vf702Z84bph566qusqyTSsVwWRZPRsxYQWoEBAXPAA=
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.25; Thu, 19 Oct 2023 01:43:39 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::b5) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 01:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Thu, 19 Oct 2023 01:43:38 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 20:43:33 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Log UE corrected by replay as correctable error
Date: Thu, 19 Oct 2023 09:43:18 +0800
Message-ID: <20231019014318.4188092-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f582c6-0835-434d-81e3-08dbd044d110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OTWa8AL1sAmzcWLfeE4ndh5VPj+XekPErkJ4g9ei048CYLGT+bJmaheK1vUUyRMnYVM+szuM86HtV8s1dcNDCUDlvRDw7RhyALzR+h+OSDm17qKbPTxM/InCea6WzT88C9tbWChswf+rtimr88DdQrfJDaWptBkEwVd51wjQaYwM1cEJL3MV2c1sFNa4D1vXQdU9iCeKO8tUU1g9/AR0UohTPqpltOjrsdeZMFoFtlc+qgW6xi0lx6oJNaXNNoS88xpldRQOlXzQVZSsLJe1CSYTP+TTQAgvHgR6FLFsKQ2V3pFayLqMhlSWhr1H8B5IPGhwSBpkcZsSWgGevamYIHjgJrCNnAz1V4WM6acCCVJSsbmtZLWXuw6JxN7Br0CwY7EAxezpz110QV2aFfWooR7H83HK8xXkXR3g6i1xNG3fvfpdKmztM/UHr3jjHQgeomI7WJi0KBa1P4TknIJEwosXAF4+YkoWCNgo5UW/k4YGjiDmdJa4GHfZCh0DOGyXDfhHA5hcCPxGc3PfWghooY3q8QFqU4I8Rp8jX5cBLWCrsByu2XX+zGAQT7gyq21iLWtG3nZIs08dszDiwmsi5OIfAD5v1dbr3qv276gN2J1vnlB9gKem6/Sn9W5kNfJI8/6uNJev7o3jU4pK+awNvArhNKNiyX3DmG+XCEkE6zJkstyZ0ZV8OzyDU5haM8joBappwNhKFyKrZ3nui+XFgGJGT7KUxXb2uCqWLQEcxmTMrsdv7886atz/X6AJWHhtN9FKPbJ/GuOseYmPrIGvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(7696005)(6666004)(1076003)(2616005)(70586007)(70206006)(54906003)(316002)(6916009)(478600001)(86362001)(83380400001)(47076005)(36860700001)(336012)(82740400003)(356005)(81166007)(426003)(16526019)(26005)(44832011)(41300700001)(40480700001)(8936002)(4326008)(8676002)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:43:38.6149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f582c6-0835-434d-81e3-08dbd044d110
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support replay mode where UE could be converted to CE.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index b664ee3ee92d8d..025e6aeb058d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -105,7 +105,9 @@ static void umc_v12_0_query_correctable_error_count(struct amdgpu_device *adev,
 		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
 
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1 ||
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 0)))
 		*error_count += 1;
 }
 
@@ -125,7 +127,6 @@ static void umc_v12_0_query_uncorrectable_error_count(struct amdgpu_device *adev
 
 	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1))
@@ -293,7 +294,7 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1) {
 
 		mc_umc_addrt0 =
 			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
-- 
2.25.1

