Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EDAC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 22:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B147E21D7E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 22:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W4g4Z8NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B147E21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357E86E0EF;
	Fri, 11 Sep 2020 22:03:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721126E0EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 22:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTDpZev/YXbtyfIYOwq3SndwDTD+427QQALR9Uh340dEIlzdik6bGgGsWmVm6hf1OZUsHOHDrn209H0eS1fCkH8eJMhzoBm+hVMApdO5CMGif1dH2ytBt0mm7UsrQZzPJ1NeIZrnvRRjQvzOtucKyA5j9HVgT4eSBGzbkOdi5Ln4zCLNYQIiwE8bUJEVsn4XB51koAsTx0qauNgk7yPQp/Y11SPYEdJH+vj7/g7DUI25k8j/g/q71s+x4dmxuxBLK51TT/81arx/ooHC5YBIBDUzg1GZS4zg38cBDqjfVrTu/u+M3rMnLptzxqmFdyTGtG1pibR/Oxep9i9/MQSS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sqaMXiRsigigZE1mWiOvcEBODIlNo5Sy+sIdokJrEU=;
 b=CwsSdCSfieRmgoC8nRv/ydKx08FWKB2r9hE9l/46fp4ifYIMPJ+lIxnFOJfgUr+mnDPdSZL6NnTUN5wmE2OwJJfBsxobZZzXHuh7xzTbTTPEkElLQTMHpiutLIIrW8cz6nSa+4jo07QFBHhAXsZLXfY9Di1/CJP1PvAderz7Te3Ad1rhOcSs9sqk3HKYfIpXxlG/lDvkpX18MjvXzcCpMH2tqeUY7WgMQDaizgNDQNrsCxNd0e83NvGGdDNUAjHgJCA6piY1pEglUFYSkqLaMEXugqchsMbIzOdFP9DxKMZdHFdyGXup7gyFc7QPbj/zF1a9e+QZ9bzP4m8LoEGZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sqaMXiRsigigZE1mWiOvcEBODIlNo5Sy+sIdokJrEU=;
 b=W4g4Z8NJjsENqTgHZmxPhIpHcvqdDI+7qKHtGXWYIJw6flGkyOYREYApP2UIcbU5PMaOziuQbnx0Qj0sZc7iYLvdn0d+1p0whHEkOaOua3t30tzGrGwwwkw5tlX2r0C+MULftf7IjDoUrch8CJCICcKDIFIBNnzZJvc5jXBSQtM=
Received: from MWHPR11CA0030.namprd11.prod.outlook.com (2603:10b6:300:115::16)
 by BYAPR12MB2904.namprd12.prod.outlook.com (2603:10b6:a03:137::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 22:03:07 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::59) by MWHPR11CA0030.outlook.office365.com
 (2603:10b6:300:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 22:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 22:03:07 +0000
Received: from rkhaire-dev2.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 11 Sep
 2020 17:03:06 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Workaround RCC_DEV0_EPF0_STRAP0 access issue for
 SRIOV
Date: Fri, 11 Sep 2020 18:02:40 -0400
Message-ID: <20200911220240.2848-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29f7981a-60c0-46ba-79cf-08d8569e76f9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2904:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29040EDB72049096C13F61DC87240@BYAPR12MB2904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgWXYkCpw66es4s+zY55kUDxNJHIOWN1fliSY0BKzITdSPTMlMhQ/U23dBY0oD69XdpYba/MR/zkAgWoF5W50+KBUa0hQXXK0C6wTCYivQCW6Yo4HlZwvjnqcpf1WF2TYIOnhS+m8HWKq0eQkZHI51bzZBCqh6hewYtchs+MVFFeDCE8Wxk4a/niChchtxn91zXY5G6MuxQPqOzOZemElcnSJmHSWVymd5GnvdHfHCZFQPUZYUSXJIvxmWvYETKS6+RTauHipsOezTs6rzn+1aCYYu7dzgoXeLoNiaUOpL8Sg4nr6ElQDVEVfCOFIBUe8EmcwFcbC/0p4ksK3KuR9i3+MC6nQoFgmdqFeBaXxQFbb13t2ncJa8DSWPzvKt6NxHNPWxACzPfDSwKiRqtimg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(36756003)(8936002)(4326008)(6666004)(426003)(336012)(8676002)(82740400003)(2906002)(2616005)(44832011)(478600001)(5660300002)(70586007)(1076003)(26005)(86362001)(316002)(356005)(83380400001)(6916009)(70206006)(81166007)(7696005)(186003)(47076004)(16526019)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 22:03:07.2198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f7981a-60c0-46ba-79cf-08d8569e76f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
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
Cc: Rohit Khaire <rohit.khaire@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7429f30398b9..fdfa075e6d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -51,8 +51,20 @@ static void nbio_v2_3_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v2_3_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
 
+	/*
+	 * On SRIOV VF RCC_DEV0_EPF0_STRAP is blocked.
+	 * So we read rev_id from PCI config space.
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		pci_read_config_dword(adev->pdev, PCI_REVISION_ID, &tmp);
+		/* Revision ID is the least significant 8 bits */
+		tmp &= 0xFF;
+		return tmp;
+	}
+
+	tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
