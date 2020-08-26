Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779FBC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4222078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GwovrC6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4222078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75B66EA5D;
	Wed, 26 Aug 2020 14:46:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089B46EA5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 14:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5KQB9AHzUNw/RTxuyMmJjjFOKhj1Szdf99ey8SC+ZM7pQSEkFZFJFG+YVoQ3/9bRE41azrvj6xJYt0UiWedww2pQmzN2tSEuojUbl9IWVYiF1TSFEeXiSGQYaRp5/4Edc8l0LitoFa1h3Al2eC8M4MJ8CuqQmYZP1tar9J23i0UkfiPQqaVN92AFZUkCSDeP8a1a7R1nkbPeFlFXayoKE9aT5xRCTNRPqZFqxFbHYWoKEe2KRDmXEUFrtzjgT+vythAxQ1RmD3PT50ZgOIiwzFpuVGkJpViXUfKTtSP2gw3FRSsu02s6FzJ+O/DpUjHuhUVIOlf1AwLrhx5LdIjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHvLcUtVi+3IfGGKnrTZD2OOq5MnFUViIPSIyeeziK4=;
 b=a4WNp67l6uK/rVK6lOd5Mv0dQMJOg64W+v8lGBA65GawB8ch27MLacT8w/3DFD7Zcozp4+G/u2p8EVozSJIlORreu0OnE/+Emnk8dpMVS4Hwvgd1vHkCLYgMDYDqxC1X3WG02D22F39lfjXV1eqanl4tQ5PCB5/woHAO1od4N+s0QceNSHpybM9ZH/IlFy6e2R3H4u6L3hO7PY5mx9VGnFAxNEKAfA5cp2H72ZTc+DPvIpwwZyuZS198MG6Pf4sBQelPW/slcI4XYVoaqub3J6yS63xaR2Jg3B2CdeFFlaMYP3RBUY6mlNxVaXi6n05sVkMdj/WOUCjgbrDCX9UDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHvLcUtVi+3IfGGKnrTZD2OOq5MnFUViIPSIyeeziK4=;
 b=GwovrC6ilSZOB5CWvvRjxqJAcRmiX9r5spZmo20jgSeXH+UX6/n+/f3htgNpeGGheNwG9RnLP8sQtk5Cjfd1sqtiK1ruEEZLVz3Kpdxpe2gMTuYXSX6dMYHx7m3faw37aNGw7+kHaXFZJ0158D/sdyM6BK4SClJiP3mYQFiLiUU=
Received: from CO2PR04CA0106.namprd04.prod.outlook.com (2603:10b6:104:6::32)
 by BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 14:46:42 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::75) by CO2PR04CA0106.outlook.office365.com
 (2603:10b6:104:6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Wed, 26 Aug 2020 14:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:46:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:39 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:39 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 26 Aug 2020 09:46:39 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: Disable DPC for XGMI for now.
Date: Wed, 26 Aug 2020 10:46:22 -0400
Message-ID: <1598453182-6946-8-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30df309b-f635-4c68-b4cc-08d849ced898
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3350B6149CB12B34636CF4ABEA540@BYAPR12MB3350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6+b8UHPtxXGSHYbduf5vJcjjyFUdHGjTsKKMLrjUvm2SMnvmpicwX4AfdvP0zADu71v03cgz4xsinaZcYTLihoiVYwyVZLSGGQ+YW68BzFlmcRcpUckP69r8+UjDwSwoUYi+uSPdIdZWPHM/e4P5tlxkddpj5rkU/tSXiSCMt1hwAarvE6jZiEUDiQ5HSP0aYAowStWilyRMsVV20o0vn4oiq4M+o4Ook6rFUI2KKT4BMTvNET1SnkxTpBdgXpFRzSG1lauBqbB7TQQOtQ7bK1SRePRSo7p3eQsR5dK12+moEx1iBfl7FbEJFLNKocNsXrM/kshLaZfDm1lM/aTgNq0llI51wIK8r2toeszU6C/u03jOC8TrE8WP5gGHB1zd8V2VsuQl+xh6wj1JQh5gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966005)(82310400002)(70586007)(70206006)(47076004)(2906002)(4326008)(478600001)(83380400001)(26005)(4744005)(7696005)(5660300002)(316002)(8936002)(336012)(86362001)(186003)(356005)(426003)(54906003)(6916009)(8676002)(6666004)(81166007)(2616005)(44832011)(82740400003)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:46:41.7303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30df309b-f635-4c68-b4cc-08d849ced898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
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
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XGMI support is more complicated then single device support as
questions of synchronization between the device recovering from
PCI error and other memebers of the hive is required.
Leaving this for next round.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 473553f..50a6d78 100644
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
