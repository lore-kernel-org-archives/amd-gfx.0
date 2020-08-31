Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7839FC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493BD20719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BgM3IB1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493BD20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06CF6E393;
	Mon, 31 Aug 2020 15:51:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9908689C49
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHqRe4JqSD9P+cP0DOm7O80BGLVd+bu0L3+Rf7+EOJxA/sdiBkaDfgQrYmV6BB+Z7qOINhMD7tiqZbB09e7ob6cSUn2qw/AbrHDAvgDg2XDF7LVML06J9Y8Uy/b0s6tYD/Q+yOkpDUnT70CiwDP9dQxzqJCSIR/nSHYTuvHkn15FDQaM2Z+fPmtHwicoQENz7oS7e34mbc129MmRtglnorGuxSSAWtaasyzZzCaHL6r0WA1nzpgWqFY9P/4oAHezT1VE3oEFUN33B+ahEXS51+bWUA6thkVGeD9znRzOa65BBNBcyndlYukGjX79towl4lnohfoh6opa+uZABRGz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc87bi/ySbwv0DsCt9ZYRkUJwyNnPcw5lyixISskkkg=;
 b=Xrgn919jYhTQHbSjN/1m/Y9lzEKKWxlLeWuCOJ31sfBE9GxjSQ5rcwZiRiEVXLNpztgGGlAhQC3WsFrlzeycW6kSq4lzN65fT2DWSuwZI/kckz7ucmDVAU8v1+xrdjnEAPyHKB1qxG3xZtB8263EKIJCzu0jGJdIDcLlmqD3QctyV7fi2cc4+IMY/EZl2jSgxgvOwfX5Ujh7NQ3vzBdEqAvbr+KhbYX2zQyfTWG/S4KsLVt1H4Jr/1qCxj0iGNc0IBTr8Kgmm+CytPIAM7T27n+lNYVXHduY6gIkcHis2Wa2va5pv+57vu60u/LVBozPEfktgwBn3bFJDvNSkcjGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mc87bi/ySbwv0DsCt9ZYRkUJwyNnPcw5lyixISskkkg=;
 b=BgM3IB1TVWmPd0klJgOzrKDxTWMA0HwEr+ZuRjbtf/zhma7agKWZxfDoLxEAtkIglSS+gjG9q+RVaDbkSPQd3fEtAe77evo/Nt9Hl9OsqRo8hO782n0vWzgiCczyrMKiEIv6K3SWhirQakq31QDAv2slHt42Cbx/bxJO7MgLMfY=
Received: from DM5PR07CA0150.namprd07.prod.outlook.com (2603:10b6:3:ee::16) by
 BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Mon, 31 Aug 2020 15:51:07 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::f) by DM5PR07CA0150.outlook.office365.com
 (2603:10b6:3:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:51:06 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:51:04 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:51:03 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 7/8] drm/amdgpu: Disable DPC for XGMI for now.
Date: Mon, 31 Aug 2020 11:50:48 -0400
Message-ID: <1598889049-28321-8-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d21c3152-44eb-410f-a0a6-08d84dc5ac7e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4178:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41782F142AF4DC81D03EE3E1EA510@BY5PR12MB4178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XN6NOPFF1FrCUo2zVt3KkPKl7weiwW4/Hzki1zVZU3Ni7BHDjCYER2CtMfhUVEq6tFak4Ab2XIfA8rLkwR8MFrsX/znC7rOp9Xiub9pcsrC1RtJfY4M2TJapkO7CEQ5WLqW/esUDiQLt20Fj/E2OzM7ORSHyOZDvflFbcnO/px2ehqli7X48NOVH4rF/d9I18bgDqf/qPbAGh/Z9hjLbC91Y5G4vuI3519iREjSeSc7IgrhVG540htsn3Wk+YW/ZHlA70fY32KK4Jn2eyN6KKdDtYLmYg4GZDJgA2gOdx/RhI8sTfFO2AYezg2XkviSVHjcGS7FY77KmHJ/lc9XjI1YEpC1/Cqco6qPCuS4TC+2E6fyU9WYT1ZQaXjVmWU/EHxP4Bz9QiNst6aK1tYzXeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(4326008)(86362001)(70586007)(478600001)(8676002)(83380400001)(54906003)(70206006)(316002)(5660300002)(6916009)(36756003)(26005)(186003)(336012)(8936002)(6666004)(2906002)(2616005)(7696005)(47076004)(426003)(82740400003)(356005)(81166007)(44832011)(82310400002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:51:06.9891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21c3152-44eb-410f-a0a6-08d84dc5ac7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
questions of synchronization between the device recovering from
PCI error and other members of the hive is required.
Leaving this for next round.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b31868a..fe720c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4781,6 +4781,11 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
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
