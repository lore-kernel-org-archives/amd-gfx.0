Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFEBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 20:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4AA10E1DB;
	Wed,  2 Mar 2022 20:20:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B6110E1DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 20:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StzyDiD2ZNRKjemHsdQSL1C2p3WSix1ldpuTzEP5xNiHZ3coj0Q9W0ra6/HJQJ5tnWEEI9FtoWwnMMUY9fhq/MG7STEUx436s4j3ovQ6nKIZ4V71dsNparBONj/61rNg9RpvSl+z36dOdQ4gBjW39yPBoLimnizCcH1DVZ2rE8SA+leaOeE/2VFysD38CxRFAzPIgMi4JOSbQEGgN/F8N5vgKpx5V1vXHfo0raI8tmrVdwkMXd8RwR69HOb0uzGTuGC5cTmkIcyQjvVEdeVmsRdY4RBZ3k3IYKvjrQMpkcbGCR7r5o2qJOXOuTd4KZinpROKx4TWa/7VgeV2pqrWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/0JCO3cJJYLf+qtXtvZGhAL92vPFhZ6XnnZ20sW2e0=;
 b=HTgCy44/DwAWGJ7xKAzSFG5Vg1tYPyqsuZyPm+fuOD1w3kyva+/xTdwQt92tKRoSs0vfChfyOqPWrW59RQXQl/22R3Wfk4XvfFFX/mVjNE0M25Sv2uaJPvJPRAKeopZc9Y/oRyQdArip1R2UrD9fsS9PwVqtHp4m05u9qCpcUYyYQpRb6UadxjllVzMEVqHGAZuPHcO1D0Sek7rlwO8VB7mz/mmoOkC61yTY1gEaPGsYIQbSzZzlzDr6UHuXYQ30pVI0ta9lL6gLHSA7oamgJ3XSpPry2EP005v96kAlKK5nrazPDo7qhZNY1/j0HjH2JKqInlgLUi9DUOFVm1BhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/0JCO3cJJYLf+qtXtvZGhAL92vPFhZ6XnnZ20sW2e0=;
 b=HP3hPQEKGbA6oAsuTioDi+LIlkW/PEJrZSVFCMQlJ51sXSwywK1zxCRs5XiM720awqXmB1qeS9usCvctHfYWdsP5DNm1rWTnKAZErfFbRij7z1K8vuIPyy5VlGMsy4SP1xji3GL/K9bOdzVgv6rFolM/YesROUcQjUAD85nTLj0=
Received: from DM5PR16CA0042.namprd16.prod.outlook.com (2603:10b6:4:15::28) by
 DM5PR12MB2391.namprd12.prod.outlook.com (2603:10b6:4:b3::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 2 Mar 2022 20:20:30 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::72) by DM5PR16CA0042.outlook.office365.com
 (2603:10b6:4:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 20:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 20:20:29 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 14:20:28 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: set noretry=1 for GFX 10.3.4
Date: Wed, 2 Mar 2022 15:20:14 -0500
Message-ID: <20220302202014.2439629-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b99f564e-eafa-46c9-0532-08d9fc8a1879
X-MS-TrafficTypeDiagnostic: DM5PR12MB2391:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB239182B54A4F9AD14A4C5C3092039@DM5PR12MB2391.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1r0xubt/TY4dzABI2JbODKIVP8xiQ4z9AvwuYF2E/F1uPC7Yogzexjj6ig4bZR69LnMw45PXPpDQ+2wweP6PLL1bHiCstArCvqWRKQwduK5FZ99Tb2K8DW2tRA2J8L6ph3EyWFUexd9YPN0L5J3If8zk9uS8vW4LbLVrFL3VpyjX8dgCxhpQ6sw1MYbx7rD2Gg4U9LELMtH7dfZxyIGWQBo61+OCsXv3Zg0UfOEfYPIKnY1kQOEYi+MdbtrTrfLH32Q1aVg7se7QMqQdId76tkFexTgDCpS5OHQONxQxd9itO+hRn+OkqmaVPjp0eHqY6AB6UL7hXLkar/XWR8TD9JIXBN8pXuUVv7Qssq89tpJ0laPHQJcRAlfHF1GmnzSnQdfbjqXxq4NY6J//iigCPvcfb6CftFrtnVUsgNLjJWlXa8jeuyxZeVFKPw+z9cgbOPjHIFmfh5K0ubl4kdInAtce9mdB5Rw4N7n1iMeLAA9S4CQiJuAWfCNnpQ180fi7Lro3NGPOmwWAUvHwAe1XeHGgXywUfzzwM0ZUN+zpVWJf83DfADcVpYYTKc8RFCBvg+ReKSdz5ZHftjqR0xQtkdl5hgug004u8u4eMi6OvV4YmQpgszfU34mRsh0PYxblBjEMpunaQW6RbgOIPyyMKwlxJkERz5xB3isA4G2B0vqIeJR+lbWkiBI8aErbHQRpAPZqE2xoOjZXBMrXOTbC6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(86362001)(40460700003)(8936002)(5660300002)(82310400004)(2906002)(356005)(4744005)(26005)(186003)(16526019)(2616005)(1076003)(6916009)(426003)(336012)(508600001)(7696005)(6666004)(36756003)(47076005)(70586007)(70206006)(36860700001)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 20:20:29.4812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99f564e-eafa-46c9-0532-08d9fc8a1879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2391
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

Retry faults are not supported on GFX 10.3.4.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7c2a9555b7cc..622eeda9ea45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -568,6 +568,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(10, 3, 6):
+	case IP_VERSION(10, 3, 4):
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
-- 
2.32.0

