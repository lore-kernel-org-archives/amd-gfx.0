Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8172BC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5342820872
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GwlF/5uT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5342820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113F26E503;
	Fri, 28 Aug 2020 16:06:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C90B6E4FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 16:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Xz80y53wZ9AJhFLyioFu2OTjGCrx7SihJyyc2n1YNdWdNxuwRAfkkMjzmGotIuc/0lSVe4CndKfI7jf7tBj9TrREnkh2dbEtv2jp2Ersc3pYWKNySDb1vaRZd60XNF+BMP5FQAgCIryixkhKBSZ5BtwdHD3ioc1Yp3E6el14SNJovrA/U1eNBlwmubimULwK0CVsKrZwiTzEZiXw6+Hn8w9E7/kWifOoPlu9f0aU4XZtPsPP3yJEL9FvTkZAPeKCqkPREPALkKJZX5WvVRW1KbY0Z9OCLG15mDXKJj1krvXzUgFSsEb4yOm7M2TK9LZhiYxCa9oH96/x0V6zRltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFbWor8Aen/VORs2GscUFuzKrIEjTkm9+uqe/heQYIE=;
 b=gPhQfwBDO08PXXnH52+C2CsCvJ2CYm5D3ItnJTVzmM7Sbj74jd1dMLxatH0QIOr7art0HPIj78KEGI2lgQtZGDo2vKztjY/cVTClz5Y0XiwRH4ICeVqWV43clIWKnqa3p3bIppydVW2K8DCLYQvtdAkQ+AkQ5atikhQ6UGcbTwWV1W7SKL0WxXlXfhKeF4HgGwbCsetgKPpZeoDWZIhmHA2T1+chb4gXLMSVBGGK/QisHmdDE5mu24pCzHiAPDxgWsb4q95do8S7lBvHGrmzGC8gZGK7Oopo6ouUuFp+wUzxCxVE+dtwdsP5w09pqiE/MBwKzX8/m7PuJVBwGpzuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFbWor8Aen/VORs2GscUFuzKrIEjTkm9+uqe/heQYIE=;
 b=GwlF/5uTgbi/gstopxkp2xta7RJ5S1UC3phqEnXNT0l1GDSf1Tw8tVIqhnq6XmGf6Cu23YbrMsS++yN55Jq6KJZbZb/LBTTBYsjniyMD7LfeBz9oken+VaMYj85XuB+d4+zUtssqzhm6MRWLxh9dZ9BkQetxlLk3K0gR3zzjQws=
Received: from MWHPR18CA0026.namprd18.prod.outlook.com (2603:10b6:320:31::12)
 by MN2PR12MB4000.namprd12.prod.outlook.com (2603:10b6:208:16b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 16:06:04 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::9e) by MWHPR18CA0026.outlook.office365.com
 (2603:10b6:320:31::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 16:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:06:03 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:06:00 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 28 Aug 2020 11:05:59 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/7] drm/amdgpu: Disable DPC for XGMI for now.
Date: Fri, 28 Aug 2020 12:05:43 -0400
Message-ID: <1598630743-21155-8-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b66e972-2ff6-49af-1eb5-08d84b6c43e3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4000:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4000A2E16E952BE3D2802404EA520@MN2PR12MB4000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIFHIsdeYjKoqcdz3+hnW5mxL3tlxr6S7Mz+CZIfUy2Xn9/dHQG4l4rivdR33sfTTdsEKCnrMq69R/IuoCSIQalJJB3FoNd+7boNhiApNhe+UDOGi3Zy9SETAMzrkptCbnatbM9/ZfAwzZSq4/NkbcJ2KrDqHxyk7Yg42gdUVo/xyLUgyQbFUKs7VUMK1yMe/r2GfX7aRoF4ulgqS065xPDBwmRHVe83Uq0cWDIiVLxnK43wA0HkgalQCbFNUmTEhtYwxATVpE1Z4jHnaoRDN9J61Djpk6U/lWOHsERKyTJJ5JjcIuz+M+Smef3ZeJrgsWDLPQKSG2nNpfMyr4XQDtklYyGylO/isF4oEj00c9QQ2UskOvytXBtTwIQYlwL3V4VQNt2nCyZtRECtTCT84Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966005)(7696005)(82310400002)(2906002)(336012)(8936002)(83380400001)(5660300002)(36756003)(4744005)(4326008)(8676002)(6916009)(356005)(81166007)(70586007)(70206006)(186003)(82740400003)(47076004)(26005)(316002)(6666004)(54906003)(86362001)(44832011)(426003)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:06:03.8865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b66e972-2ff6-49af-1eb5-08d84b6c43e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XGMI support is more complicated then single device support as
questions synchronization between the device recovering from
PCI error and other memebers of the hive is required.
Leaving this for next round.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 429167b..47e16baf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4782,6 +4782,11 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
 
+	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+		DRM_WARN("No support for XGMI hive yet...");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
