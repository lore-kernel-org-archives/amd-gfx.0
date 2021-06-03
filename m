Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB0C47097
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871E2613BA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 14:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871E2613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C402B6F47F;
	Thu,  3 Jun 2021 14:13:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12A56F47F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 14:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiaQzcgrydliHpx0lReshvDeAQHFZzAS0TQuI9Jd7KFv8xMswluISUJQWk+wC46uCGfduH+pQTkoIIJMroSZV2D+vYg2UDnPPJiwz+lGsobPenacKmGDEPu4duBsOTwRJXd77RvH4qQnlxFvy2V7g54iih0vQwq8yftAnjUSSITkNyjySuvv4YsgBaUJi1UECwd8wqgJJe2koqN7wl2o1kcRNN1PBwqJ6zQCt2xi+kFAs79wniy8mbOgWnPSZ+c2S4hohbXfueCvv3wUBjEZBWexzFSWnZCSKD3od4jJRoUpatNREW68KgcjgCawN587deEDq2aIGKb1tSqOrjZE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23dNaAsN3ZuLnomTMF3clJD0aBI853i7PW2qj6X4dQE=;
 b=VbY2QCaYerSG0zUvcarkarYOb7BwJ8N7yMDfh6FdTHLkRgQ0V+eKZR19HFgBOFcC+bUPzo0vmBGsa8qB7SbP8+dWj26v7H9sVGzKNtl7KZ83V04wvDOyGteU3+KgCi3K3lu61wvDH1WwaKD0kniTNeCrotYcC5kh8JoHYCMFHOBzQlsfCaXTZMuYtyQaaYEYCMEz1Rf0xiOBb9kqLCJP6vvrPMWPxD0GJVRqS9V1p0OjCOaYTS1PpyDoV5CKxR7+f57RxSBjg6bHEwhctfhqwBMw31366d7iGYrxCkN+afeSASHdT5yqkRhcWOE9hEUfRu3T3XjQ4uBfT84luIcUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23dNaAsN3ZuLnomTMF3clJD0aBI853i7PW2qj6X4dQE=;
 b=vBmu+GBRiXFbMGGVeAvuR8HZBV5Be9oHEe6WFIkjc/bEZWDHyTdVWyfDO7nEFAiWw6jjYg6HCMrGMz5q4dVTgLRT93P8z0qYk/bBF4NSjg0K7ni0zXqRgrwYHgu1Pxx9dt6o1W4MFiqV5GDN+fmhpVJdk/CpEx4YpSJhcy7cdnQ=
Received: from DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17) by
 DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27; Thu, 3 Jun 2021 14:13:32 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::4a) by DM5PR10CA0007.outlook.office365.com
 (2603:10b6:4:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 14:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 14:13:32 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 09:13:25 -0500
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Date: Thu, 3 Jun 2021 10:13:04 -0400
Message-ID: <20210603141305.2542-4-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603141305.2542-1-zhigang.luo@amd.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b0c40da-de99-4fe6-b752-08d92699c4ee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1321:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1321280ED26C2D91F8A619A4F13C9@DM5PR12MB1321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ib/hdXFtusrW1HlGxzZO5c+CvGOT2kHBegE2W6ZALsgkFZr9ZPzoRTMUYgbCIdEf+axvieQhpTLrxGdrrnwHY/FLKdRNvoH6p2SvQWm0+YEowmiAEJPEc3WNQwpmGjDclCefRwzkxl3Qljjn53GB+QognHXbF5cZQRZSqsugpvSCPcK4Bq8NbR16Mg3nvBoUN+GYo+sX9KOHz6nZ3VuDUWqccwmMTX9JscshL5Pt1nXcxl08t1vNSH+GzPc3XfLn2XbxKK72LAeJU/YcuGf6h5hV6Kq/Jgw9DPw3rab9myzc27eqO76n29tFDiG/2ytHpjVwuEeGVyiE15YYYPR0niEeQaY8i3GC0qpTc2KO6rlnXkOPRbmOWDNRiHIkeUQ+YGbCAV0qfWm+17p2IxKLPDJQ1/XBunHLPDNwB8FgHPEg0U0+dtpnBA63CBnBo4t/0No8hv1/0wwysHuQr6PqV4k6T2mFhOJbVzsAirPnRtbW78+g/k+UnJ7Ulvj9KnIs8Tlefoae0mEc475li/+pC07qXhb5gfjHJNWL2upsRz56ZNSV0IrOxoeGdO1gfshDEoE4ZV766yd2RNXNPH/YGOCLkrRZLFR6ckMEY1uh6hHOlSYzz12+Zj0FxNx3CoTyRkvgeCgNNMC7VEi7uLWGKVcIZZqKxj2YVzCeH0bujK5CdRt++h69D4nH2UGQqFQa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39850400004)(346002)(396003)(36840700001)(46966006)(86362001)(6666004)(1076003)(336012)(81166007)(356005)(478600001)(8936002)(36756003)(16526019)(186003)(2906002)(2616005)(44832011)(82740400003)(8676002)(26005)(70586007)(82310400003)(426003)(47076005)(5660300002)(70206006)(4744005)(7696005)(36860700001)(6916009)(316002)(4326008)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 14:13:32.4637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0c40da-de99-4fe6-b752-08d92699c4ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

need to load xgmi ta for arcturus and aldebaran sriov vf.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..6bd7e39c3e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -170,7 +170,8 @@ static int psp_sw_init(void *handle)
 	struct psp_context *psp = &adev->psp;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type == CHIP_ALDEBARAN) || (!amdgpu_sriov_vf(adev))) {
 		ret = psp_init_microcode(psp);
 		if (ret) {
 			DRM_ERROR("Failed to load psp firmware!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
