Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034FDC11F66
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 23:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9293C61241
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 23:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9293C61241
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196EE6EA9B;
	Wed, 30 Jun 2021 23:26:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261C16EA9B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 23:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2tW2fIDcqpgX35tbpmQ5ru3g+2HAEaqZRkCNkYwypQA9Nhz3x/9ongqqrYVhbp5B2Nzjw0yqF1xqsCCTF7pdHxKPS87CrRFgx3OkWPc6WiE4I5TL0aUop73NwSh62ii8q8ZGSEflWFIYWTevRNyg9dln8XMCslN3GRDoWLheKtz33puaI3qpYP5A2/7CwpxbCX3OjEd65Jzsg4EDKgj3SAnMbJLZRgx28u0TR8J48V8bWaR7mRs1LOQa8gpbei0SNhfxRJIiNbclSD7kHDoVu/yV86OOpr0Ac72VipbDdeL/jIo11zTUuIn6605a2qntSwUjdPYN0T5vOON+sNbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMR64XoAetHN3qQ+QXZ2S2pD79Jc3BdexiK2uNtF9hA=;
 b=Xm8O558Or/pVylGnc6qv2uD2GEcY1xSRwWLZyG1jz25r9wHfkMiNgG/2yhU0V4Vuxvt+3/efqzshqqotJI5ti7E1o7t8/3fsLDwFbBpBNDcym8jo9PsYwXD/Dsf6rAKGMa/3TOcso0peAnWvueV3UjhFm/ztiSq8anWNcg/4FH8VwlreQDlUxXN7ssh1CVvSSKYAblRfYVaUZBkkCp1SAbwBwCXrtvGPGcD+aeMxA75wJsa9Ow+UctQZK6UIsxGaskpv4RKuTawMBaNhW/ZuefZMF88VKC6HYg24p6pRISdx1qQc2KSv4tRgAqvWldGuutOQo3ETrprVKLmi3JEVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMR64XoAetHN3qQ+QXZ2S2pD79Jc3BdexiK2uNtF9hA=;
 b=OsioQF9tbHfjKjCIRoaatss3rwfwQ1dX4V3FcPlVWnMichjAz8YPF8/vd0lnquh36ED+QFJSKNW3KsQHdo9PDnLcxvMpSOUmOZYVK2SjTuNIFmfoGZ0MvF5gn/BDo1//yl0HcBES01xM2OBr00GiF/HHsdm7rMZ8g1vvZipnIFI=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 23:26:39 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::bf) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 23:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 23:26:38 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 30 Jun 2021 18:26:37 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Only apply TLB flush optimization on ALdebaran
Date: Wed, 30 Jun 2021 19:26:17 -0400
Message-ID: <20210630232617.107492-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a11f9aaf-b550-41d3-6b6b-08d93c1e8284
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0266:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0266CCE07684F20002556D2482019@DM5PR1201MB0266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v11X+SYmc/VecKqRsUxukjFkr5S92JtKNq9gmFeGQY6oos5Zq0Hh2G7QcaET6cxk2I0Bj7yOea7A0nTOsSWS6hl68sd8X6+UdcqMSMkuLYc4yib03iqo9Of19D5kQTGCOQKqXOchM9hA6n+94KkrwVxAgYjoBR66Mx23Bll6t/fnAzOKz1aF5dwlV1sFHAtqQQ87OFDGv0m7sBzEz8Uy//Acu8Vf5R04wMifDmRjYDEtpzA7qvuqKZ71WgKxO0jUhqd3QjuwoDUvjAt8VdG8EI4nZNJpqQFkHIhPw/0mYs5xxHRpZW3jHYihm54rQqZcxR410GRU2nuQQ9HKEMW6ogeSXSv9YDXwMagyrecFMl7Jc3VMtsslw8vLSjyUrgF09TF5dx0xzkuME9+TV4VTr5sKnvu+BP1wW8Li17BIRTqF4lo+yAqRN3oZVmEn0zuD3dd3cqz+G0i73N5Wb5G4GnSz14hoLUtSsSmWcLzNP2UKrsdgWHJNr4BaAh5fWORbmVbov69kLAxbXqcU9TWx6SVLlt02ag4hSWQbQJQquteOiNZLuNx8Y3KUQ2AMgQgrpGxdG1A6n2UZAYO49LqPm7Su0dotOtrmZCkq9c5ty1/izV9MQWszbjO7PkfWW6ORR7KsuOcvmzucK5+z5oWr0a0e9gArA54iBIRQGxfgGvmwEngcWuzX3U1G3DBzoDfU/OiVOFyu1kFWqaTxuU3PGvk+sJ0zKAFdQf19PFGlqAQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(4744005)(2906002)(83380400001)(356005)(6916009)(316002)(70586007)(426003)(6666004)(4326008)(336012)(81166007)(86362001)(1076003)(26005)(70206006)(8936002)(36860700001)(16526019)(82310400003)(2616005)(47076005)(186003)(82740400003)(8676002)(7696005)(36756003)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 23:26:38.4338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11f9aaf-b550-41d3-6b6b-08d93c1e8284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is based on reverting two patches back.
  drm/amdkfd: Make TLB flush conditional on mapping
  drm/amdgpu: Add table_freed parameter to amdgpu_vm_bo_update

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a6c01d624246..13fcef6836d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1845,6 +1845,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 				true);
 	ret = unreserve_bo_and_vms(&ctx, false, false);
 
+	/* Only apply no TLB flush on Aldebaran to
+	 * workaround regressions on other Asics.
+	 */
+	if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
+		*table_freed = true;
+
 	goto out;
 
 out_unreserve:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
