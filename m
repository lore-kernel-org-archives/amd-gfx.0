Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF19AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 02:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75F210E1A5;
	Wed, 25 May 2022 02:09:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A1910E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 02:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1f5SjMFuQuJu0rsO7/pZSTlEe2BBFCg+go9NUU8SZfM2f9vhYDG3VzAfm6vh0nS7YedUfH0Xpc3Xko1iwxY8+UQR1c/4jKgL9sQgpwiczvLpBjrg/6b3m6YqT+bg5w8eN/mY2cojZNBmJYJjm4FgpAmwjmxPFn3GUBmNoNa7T/Zioui21YJjEau9y73vwTlPxMXwIHjxk8AnBRxOH+NKO5njriFCvCHItzitq7NWFJa1uaevz/7mmbZUDIJGbI8sYhQOD/jrQRhWpyejEnY5SJ5MdFrEsnqBl08BKOM8FQ7PxCB2bO8sI99Wa21MElw+HcwsL1THAxarX4ymF+jHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbP1PCPM78m5o8oGrmiBV2Z2y7tU0PHg9j/jhj9bU0w=;
 b=GjCx5YNp6p02dUYKWtxcKBYtxRwtYUbrPmPF8MPVBPCVxgn8hjAsy26Kg+hDzmQDx7nq0stK+FWsg7ho7qSYZNcOn6ntWK24+XEsyMnfxVl3FpHmJChRzY4vPA6bWR2XCE2aMRsVInnGFse66WbrWedQyN4K6mxJLz8UUuf5vjd/vZk/i9RLP9cjw3p7kTKw/477kSqglIgzpzO42y5HKjOy7jeMI8L5D6cMSMsxEYsB3+hh+dxRVVf4Rw5N8mZCUO2ofzfaqhGYXZkEtP/pA006bQ90juD1KZ1wTk7z0RBVs5sTgB9u48DCNdgUizlteWvI1KpnZyH5jfIX/epeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbP1PCPM78m5o8oGrmiBV2Z2y7tU0PHg9j/jhj9bU0w=;
 b=Y0CdnoIIYK88Tah7j5kK7niK62jLbf5+MNd4K67Wfswijy0S8Az/kwSMrglKpr2RIa+sGi9O9DMdUT76wkk8N7qSfVhOLJxPWS1p6VdVQLphDE1xBFI216P5nTntnqsW058I4dDtVH32BGC/vlakawBzmFOTs2r6ccccZeluu9M=
Received: from DM6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:5:1b3::24)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 02:09:44 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::a0) by DM6PR17CA0011.outlook.office365.com
 (2603:10b6:5:1b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 02:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 02:09:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 21:09:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: convert nbio_v2_3_clear_doorbell_interrupt() to
 IP version
Date: Tue, 24 May 2022 22:09:26 -0400
Message-ID: <20220525020926.1951685-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525020926.1951685-1-alexander.deucher@amd.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25fadb41-a44f-4656-3b3f-08da3df3a2f5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255DB4F53F95ECD81AF9B4BF7D69@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPTjFRe0EU+cYB09pjclnlPmJ4M5kbxlX7tzbpGS86B+BSIzc/umvBMD7S1WWr26+apM/koIfAkssqSGQKTZ2M4jzw1GjEdW7SQe+BQhjo5VaMUlDH4mifoxcDwn520/X8R+MLarcUtBnfXT1sgWG0Sdz2GD7JtFO+bjJnqaaKL6NzGAw4A/ay5NqKH+NXSTChIB3iXFeB3L8Plrx62wR0jb8i6RaOVJ6+lv36m+jQCGddE9W0qWuBApSiXD5xStiYZDXSfKkRYbqWlPQP9EPmZ0U0uLmSyBOg8tV8KFFsiKjgthVexrUEu0z/qcs/OwcLnyV1warW61rs5O6ebx/8uz4Lyge3F3BEoE5boxH/mxu6hFcOEq7a8KaGp5/2LGjPyiYNr3a71xlzfHvLpReADqPqk0bDk+mU5mI15TPPDfG16C26pquLWZbFCxpnnebDBul8i+TIVbPo881XoNmjsGyd0p0ZG/DzS6Q81ECEem3amtWbYNRnqLyk03FLX0BwWPYJrWay5r8gqv2aH4OF5OGMr6atbcFiNacMd2D07U5OIignVT0RrEjL0MAs3B4DAR5J/8FySbLO/wfTqBzaA0defsPf90CPrj28Pp+5UNKtV4nAd6aKIS+HQPdfs/hU71rnmqcEMrMt5Rh7EYhgzBedVUOT+q97dB9pEwDMhh4ZPUxsFPSuSH2Gn4BpL+E1/VE3puCVnV8WqrFC5QaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(336012)(5660300002)(47076005)(70586007)(316002)(36756003)(426003)(70206006)(82310400005)(81166007)(83380400001)(16526019)(356005)(8676002)(4326008)(36860700001)(6916009)(8936002)(508600001)(2906002)(4744005)(40460700003)(6666004)(26005)(2616005)(1076003)(7696005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 02:09:44.5580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fadb41-a44f-4656-3b3f-08da3df3a2f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check IP version rather than asic type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 6cd1fb2eb913..34c610b9157d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -547,7 +547,7 @@ static void nbio_v2_3_clear_doorbell_interrupt(struct amdgpu_device *adev)
 {
 	uint32_t reg, reg_data;
 
-	if (adev->asic_type != CHIP_SIENNA_CICHLID)
+	if (adev->ip_versions[NBIO_HWIP][0] != IP_VERSION(3, 3, 0))
 		return;
 
 	reg = RREG32_SOC15(NBIO, 0, mmBIF_RB_CNTL);
-- 
2.35.3

