Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7725BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445E96101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 445E96101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F306E8D2;
	Tue, 28 Sep 2021 16:44:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068066E8BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyTQPSZtpnx/AA8YniPY3C+XDk8VDs9Sl4h7GPP8nQ1J/gMb8n2aFHOSL/0YD6fzEeYuRRRhSPIyn3puLXMRa9ffyA95/M/2hcZ0vw1z8vNvZilTX0GpimS9ROjLjRnhdZF5KzCqUXfYiiMT6AJtqxI6040lNiwcrnuVh0A+huRJ7DZqHfI4gHG3tmBsHYg1BbaJ6zTVnjcNtPF9vqQNCoOO9R/rKcBS5vOu38/QbDmnjG8TRA75DPeaXnCOEN1nlCaFAWAjd97nRp295goa+4Z1yuI0hAc3a3YcUFskl9ru1lw9cg5EEPENMJTR2JjoEKqciUU0btZtI4lfh+KeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=4rCNmfiaMoF12DiXQJAxT+53JFki06QhurTXZUgeX8c=;
 b=nFoM+0hth62hR4IEE5H+Vo4tfNJb2nh7Mh0uFxzPEveGkmXGrghCmT6WBZDVih/BIhgemU+jdH5bURgMJXEsOlvGp0274uFJOGGEL7/AKrLBHXR4wNVg87Shw51Q2yyQU5HRSDDs7V0oVWpHc7Q3tUbKz2gSnHLBQW21LarLNRhUL4jsemuaM2QmtkqtvS5/fGGaotU1+DVTK2RdZ3CZqtCqxpt9wPv2bnnbDhQdwlAHhJBUsx6P5Y5kGuYJIqmQ4v49Z+XHkf4iD+n+QLinP/YoKSIauCQJBJqEwKaYR9HVAZq4y+6n99MzCx66XWPWECusIAOv5mn/CA6XJa5m3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rCNmfiaMoF12DiXQJAxT+53JFki06QhurTXZUgeX8c=;
 b=g7Nd7dzLds6+6jzemrRWekZpC1H2e64XhfOHa3dRDjRhZDaXdCCHByPrney86zMmwFenAbSMjCLAx3ATellrQCAzhoo/ytQXqFRTagZBKsIa0sxVntLgjQl+dH0b3N0Yg8lQlhiM2uWI13G/5uy+F+GoL/QNWqt/pLs/6Gz0fX8=
Received: from DM6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:5:bc::28) by
 CY4PR12MB1447.namprd12.prod.outlook.com (2603:10b6:910:e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 16:44:52 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::eb) by DM6PR13CA0015.outlook.office365.com
 (2603:10b6:5:bc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/64] drm/amdgpu/soc15: export common IP functions
Date: Tue, 28 Sep 2021 12:42:04 -0400
Message-ID: <20210928164237.833132-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e8b281a-47a3-4484-b677-08d9829f4b1f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1447:
X-Microsoft-Antispam-PRVS: <CY4PR12MB144775615346960ECD889CEDF7A89@CY4PR12MB1447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6n6CVUj+RDrFRTCnqka5736N3AVpozOlaSpC0YJx/FlBfVb6YMG1+mPGVQxxV3PPem6v6TkMWyvpFDV/aRiSCucGkLYXyeUzdQwBt85Pyt1da+NGcDL4e3Mge1YgGrfBmpy3lK7vDSS3FoMLy1ToKcQagqIkg49t90sCmVn4T9ppH7IA7HdTEQ1X8sT/VxFfFVHXO9mR0LVizHnye/f8CjOpO1Ofk1J5xDE0BBAVDv8zTmX0t98JqjhbYfruEUgSDyqU+qdN9WYpaSPupiQuQa8KWXifypIWk7ztTxnkrCl7GyJBFh6FK0+cIiuyVjysX2uoxsybKAD3SScGJ59qDIjZkbX2reJD+RwzUQQ3HLrJ7nt52f2pXA8cwEqz9P7kQ6cNh1xaeT+FMdV7VYpWU0FVyagdUbSFdXndKCL+LEuMgQI82PVBCcv34OmSsllto+9LsSnp1o79fBe+rtlC64j/PJjVHeUP1jJHXVg7WouSRIsYRxrgjzcm1E0TIQUPi44Z1pRE65rdIqlrlLThnCG0hvsKEFlGaGY3SAA3fkbOP0Cq5P0FLBfBMQZuxfS174VQYdKg74206AyoTnYp5sLbGAoGyUc5YWAuSAl1/vWuvsDvoWXS/Cq/B0f8Two7RFhX+WzKavL6TGQgj5AVcP+2XTF/DAr22JD5Reggh4j13JbT2MHjUTjO1AN9DV050Mac9izAsuvIOPk32zpPm/Yh9dn9WMmG2bs6JlC+ypU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(2906002)(82310400003)(16526019)(4326008)(36860700001)(36756003)(8936002)(356005)(7696005)(336012)(26005)(83380400001)(81166007)(2616005)(5660300002)(186003)(426003)(8676002)(70206006)(70586007)(316002)(1076003)(6916009)(6666004)(47076005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:52.0576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8b281a-47a3-4484-b677-08d9829f4b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1447
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

So they can be driven by IP discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 1b1e9bfd20f1..dffe7d7ff9e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -706,7 +706,7 @@ static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
 	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
 }
 
-static const struct amdgpu_ip_block_version vega10_common_ip_block =
+const struct amdgpu_ip_block_version vega10_common_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 2,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index a025339ac5e9..f9359003385d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -28,6 +28,8 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 
+extern const struct amdgpu_ip_block_version vega10_common_ip_block;
+
 #define SOC15_FLUSH_GPU_TLB_NUM_WREG		6
 #define SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT	3
 
-- 
2.31.1

