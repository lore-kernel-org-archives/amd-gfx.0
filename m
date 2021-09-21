Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B4F61186
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 47B4F61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C3D6E821;
	Tue, 21 Sep 2021 18:53:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18A16E821
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofdY9OpsphLYClrIdp1WyYbSlvc8IfcjpQgUXKMJ8n3yv+x8NCM5LseTyPagfDCTxzZYbTKu/llxaYMGcBOb4wAPyDRjUD9WP9VwFNbbKxhVOXqN2GCFj0WgneOmizKt/hWJEo+C3RfwMSAuiFt9RXfFPjzqUXiKLY/xNdVpneGgn+TfUiXC55FnV7guTS9Y3+2ddoB/XUnYRdEG0YSf79rD2ytHFidhZdEDm7Ysfk6I+8PmU6pQ+TR+B/b+As8GAEffrlfaDU97Cbatfxn1b4iQ2kTPR+fKvnH9b1vrrnlY9rv0i4/Mmcpzh6zCxbZuuW9HoQ7eMWXOQeWQYZ7UfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Bc6CTqzT+PfrIvX7GEv69vPBg7amDx9VKSSXchhI2z8=;
 b=BKYoBqhVuieqgkYZjiclN55PTHlnT/RL38aGTsHrd0qIe3elfMXTj0ZvzNHi5E7zClV0U1TcYoI+Nw6+g3Xi5wBY3Pxwt71RGC4hXgbv5FoMSEuvRavGZ0RWvjDyEBmv0e3d1VNuHq0HE+N1p48IY+Ro+gfXdPNL1/MdXlixPZixMmN29T8qUFH1Yltfx4z2wzpHUGH2aQdYtKZT65qbbeKlZCRw0BozCmmgFZbAtP821+XHfQW3ko2qXPV6UCmXTObD/jmZZt8+WCOir6IZOY32v4+6Nv/4cV4OyyCvs9qDye/Cx3/kEv0d7BeX2I56+ZSaqDjX0DHdjboiNeqaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc6CTqzT+PfrIvX7GEv69vPBg7amDx9VKSSXchhI2z8=;
 b=nTWCDgwLluFUe1teSutH6RT2pvOSJwkJ3ZLGHK9BRjMabIZ9Ufdsz+FeolZuP39Gq1qoJy8Ak7lSeW+kL6MzH2Hyf2Fpivfm5zpCm9jTg7mSqs9JAm6Uz2GPHrORoGlOPDp9xp/i0zWXUaV3zsX4HGfWmYV3UNufiP0+c3ibXak=
Received: from DM5PR21CA0012.namprd21.prod.outlook.com (2603:10b6:3:ac::22) by
 MWHPR12MB1712.namprd12.prod.outlook.com (2603:10b6:300:112::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.18; Tue, 21 Sep 2021 18:53:21 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::e3) by DM5PR21CA0012.outlook.office365.com
 (2603:10b6:3:ac::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.4 via Frontend
 Transport; Tue, 21 Sep 2021 18:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:53:20 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:53:20 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: handle svm migrate init error
Date: Tue, 21 Sep 2021 14:53:06 -0400
Message-ID: <20210921185307.25811-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce99d8e7-8ea9-408f-5aa3-08d97d31151a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1712:
X-Microsoft-Antispam-PRVS: <MWHPR12MB171234030C7BB88C0A2BF433E6A19@MWHPR12MB1712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Av30Tswlk4kar7YjWdhD8PetSGqsmTH6AXOSoG5ldOPzIZ94oDjNUfjARLt1FPErWbcBzAyWCrAfZPPINivkrdE40afCmRjKn4fe14KfEu+VM/0zPdqwX6xfxfrw7F6qtMCfaTPSc1DaOjao/YBmUs9Mz2lizshoCFAZCxLszk5Z7Qqqd7/QZTEP5kYx9U+dkt/HBNvaYYuCqk68XYJW25DTLYpinWrj0JiPwX24kRJOF3cW5qy7Ho3iJ3sRexH0RJ/SyYVfmzIaARrkxiHYLh7jLA/YocZ6Tn4LSnffq/UQCEyVCqYw5SnwDQcSxbQO6N0GSsPbT6sgpTUNBuVSlpORVMmCUpKDUXywsOdWaul1kQXIE600ruh83WYPv5Dc4QIWiqSEa1oscZ9dlbKP6FChHqAhljO4jzgEEgk1/MyHQ01GgaX94stfTK4AD8I1hwHIyEwETX5K0gSFD2tkPNl2Kq2HeRsjul5L+o1DMyRHARHy7Qyo2hC7hPbapTTEv8/i4y2WgLm4IItUTRyt41WRjS4yrBCwXXG4OBplb7tqHdXbn+ydGQDm7RYrODBbp4YgcbVLQbtvU00ETzA669APOcfwaC95GJIjN1HrV1mLuOMLCRlGK1mVhsnHZVIA8T+wFOA/Mlf5+sbOTOHlXLDcKTxeVRYFtp30ebEKMh0PudBLPNYVwMB8XRQ+qpqL86dL8DvMDYGXzEFjAc3CeK2JxaUwu84HAfTVCvHYxSQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(316002)(36756003)(86362001)(1076003)(36860700001)(81166007)(6916009)(7696005)(82310400003)(356005)(8676002)(47076005)(70206006)(2616005)(186003)(16526019)(336012)(8936002)(26005)(70586007)(4744005)(5660300002)(4326008)(426003)(508600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:53:20.9764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce99d8e7-8ea9-408f-5aa3-08d97d31151a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1712
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

If svm migration init failed to create pgmap for device memory, set
pgmap type to 0 to disable device SVM support capability.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index dab290a4d19d..165e0ebb619d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -894,6 +894,9 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
 		pr_err("failed to register HMM device memory\n");
+
+		/* Disable SVM support capability */
+		pgmap->type = 0;
 		devm_release_mem_region(adev->dev, res->start,
 					res->end - res->start + 1);
 		return PTR_ERR(r);
-- 
2.17.1

