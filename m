Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D667DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Dec 2021 17:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245BB10E6B3;
	Mon, 27 Dec 2021 17:11:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BB910E6AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Dec 2021 17:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL5VTxMaDSMHuAixQ5xsXAq1g5IckQoNLNv9ECtwo8hK1ZD/QekZsQVZkE9OtGXCQQLLXJSJkmPC7CAS/Sr2oZOEitLg/E851wpE6uMisO0REms667Y0HDfYCsQsvZ+wp9HvfIVb6+AOMyWZpWP0p9CvaqTmr6kPx8XfRob+6/PXO1rmX/Y1agq0kVtDyssaKaHy5ZNbzey+apMaSnmOzbaPc9BuMpqGmV1zchRtSMJ42fgLjGhnIDLAhzXw9GKXnlaY91x8/T1Nlb4ArSW5YnQE2o6m7VJVXMKw4IlruOuzDfc2UlRnMkOpDizaB/nPRV9zZgjvJP15g1phVVMjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VutMhGAT7/EwcwiOWvNhPCq9+VF0NgJFYkTCmCRm0f8=;
 b=aKvlrzhwPRy2JIzi9za6fqwuB3G9QPU8QLizOyueufMwpmP4/8d4vP4nbGSinuE+Sz6XbuE/ow6XEqAvqK2F9EF+GEJT/voH9NoMa/uxrzl55yTDDlSTiAqm2lbJ8R9N/4mw+MTBKb1e6WM5ybuoI7tHzelmI6nJwwbHjHJbo+VYQ5ORwJOvaIlPHDHJO/gY0JfJq0cMiJJh/ldMQTZ5kqW3F3bvS6tgcqznW+T5UptYBSWCNYGYv7i1P/TGPUnX2OBrdneBijDNbzqEqUJ2/343UBqwQZ3Er/0Yqcb99aVI9PmhdH/RN3jHWE0jyZ4wB4ymviAc5TX45USVQGDDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VutMhGAT7/EwcwiOWvNhPCq9+VF0NgJFYkTCmCRm0f8=;
 b=fR5cHrcD9LWXti6TAOy8/Zp8CWf0wrSVD6CoFu6rc356rOf+n4G7fKUURHmhT4Mj5A1ONq5NHOQjNNcW1IVMKepTtv0TWBOpSbsiqkAs6SxWvLzFtbqknu1aw6yLW7TanQ+gwZKdo7jEw5krvc5Og7qHYxJi1du4VPyBFFDKC1o=
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by CH0PR12MB5250.namprd12.prod.outlook.com (2603:10b6:610:d1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Mon, 27 Dec
 2021 17:11:53 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::dd) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Mon, 27 Dec 2021 17:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Mon, 27 Dec 2021 17:11:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 27 Dec
 2021 11:11:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: no DC support for headless chips
Date: Mon, 27 Dec 2021 12:11:41 -0500
Message-ID: <20211227171141.1503210-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c280bd60-2d00-4972-86cd-08d9c95bfaad
X-MS-TrafficTypeDiagnostic: CH0PR12MB5250:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB52507104FB4F7BF0917D6440F7429@CH0PR12MB5250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2oJabR5Bf6w498L9UpOYDGsfEuFGASAOnY+5Dpwt2xLGfMlVU+zEOnWwfzxnGLaKXab8KypncrUdpvKHVYEH5YAU7s8cjpT77I+CkG16Ao9Rt/NgkpOQdo8Zox8ZcoSLWOKsc3CwwEtW80xfhE3OFPHIkpRo7HmDBPzC5zexblAaT97YiCKR3ad8Ld68SXajp1PLwZiWHiHEjxK3FDSqofBQXQnk0l3HhSvzHx4w2ttZCM28Fy33ntZspPyWLgvaeFgLmOZN9sCg6Jcxu2R6Pdp55rPtYZ8sp3Hc9IAuOaSEgne2/tKTapUYGWuyfNOUYlCSJ7XVo9x6A8W31PhnfXD0dmcodaQg2XZnrA3BrcLUE+dtFPOZY6Wh5SfYEqJ3iCCAI2RmPIoggatHf5iFP9Bd9GodQOaZbUurq5w+DGIkwDMOkfQojUKq8At7mOqbgi2yHDKOqrIeRCLWwR4pEMh9Uu+Srm+BalHMQ1X/Cojm0UENKUYtY8Im0/oxIdl4WrWfcrytRJDVSUDkhRSGxSQMzNqfJfYD5aQBUOMrzJ8It9LzeMiM4S2IgPI72QRHM6aTO54N/bXOUj6Mfv+rLPAzZn3zfqP4vu2XB2qTGkEFpj8ASEkD9cf6hNhfc1uRoBwYB2QhOjnYnghDbsS3XNKzCR0kIA7DvTVGNB/Qj5qS2hnmGWZEE+mo+MpDMHCpe/tO1Z2QYlltE61W6umfVxFQ7GlI9iNB6oYLmpFTXPHBxqgapDbpBlJHu4IzyhJq9kKV5uG7Ilgt0r/0MTtmm/yRM+soLEt+5wECPZ64Ww=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(7696005)(36756003)(86362001)(508600001)(26005)(36860700001)(83380400001)(426003)(356005)(336012)(47076005)(6666004)(81166007)(82310400004)(1076003)(5660300002)(2616005)(316002)(70586007)(16526019)(4326008)(54906003)(8936002)(186003)(6916009)(8676002)(70206006)(2906002)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 17:11:53.4206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c280bd60-2d00-4972-86cd-08d9c95bfaad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5250
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Tareque Md . Hanif" <tarequemd.hanif@yahoo.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Chips with no display hardware should return false for
DC support.

v2: drop Arcturus and Aldebaran

Fixes: f7f12b25823c0d ("drm/amdgpu: default to true in amdgpu_device_asic_has_dc_support")
Reported-by: Tareque Md.Hanif <tarequemd.hanif@yahoo.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9dc86c5a1cad..694c3726e0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3166,6 +3166,12 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 {
 	switch (asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_HAINAN:
+#endif
+	case CHIP_TOPAZ:
+		/* chips with no display hardware */
+		return false;
 #if defined(CONFIG_DRM_AMD_DC)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
-- 
2.33.1

