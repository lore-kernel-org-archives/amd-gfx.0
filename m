Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D25C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 13:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C2A10E868;
	Thu, 10 Feb 2022 13:35:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573E410E86E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 13:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+5/IGCaVnDsqGULtEE/qiKqUUpLx69j6AuiU5snf6p1Xj8sVE4sLcesfMtA8t8J8rZvbVUHhWUVznfiDJ7s3nveXiAdZjEf29xCLMuKg20Lvm3/5rsZilFIDc9uF5zbISKDStlmSJoT62a6d6gsbeRX79B4vY6onNAsM3LKy+cwNGxL2zkaU8d5LQ2KZHPR/48hWrXjOxr0lC2oxz94Kb7is1hRHwH2T8C9iV0bFjUFJyjRfDtJCh6x6S0gOxUPJODiOCxFM8xNjZfNo14ZSLXgnxz3PWJ9qiTf7TQbODYwi83ZHO1i5kWgduXIh4P3sYncSbAlN/9x9un2BONi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxR2YetdEFeDkFMTYrmQ46HBSchxm85BoLyEIgnk0u8=;
 b=DvKsAf+4naNQ3lkhmAPMt7b7Y90ojMjdJeI9Wnfol46U8bqeafhbXMoVMg1CkZ6l8JkN26kI0ItkG7qMr1lxH94cvcJHWY7vVzOMjF8SPHttC+pTGUtuSqPw4d34wKpcpHk7Zpv0cZix3pLWiDUvaIcpF27XLj+fbcAdw/DThXjHGCOXeLGroojb3QrntpIPZRcCg2k49+OpzgUqKkrkuEGqm+pBkVCAgRNzQRhds1ujDL8Txwukjr8Z7BqCH8gZ/lkjVtvgvBOHHlryVLGE5SsOqCMBt5rJbRNCctvM5r4W8BoYvVdtKrY6fgz/Dl1V+7GMy0q8+qb3eCwvsjaCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxR2YetdEFeDkFMTYrmQ46HBSchxm85BoLyEIgnk0u8=;
 b=ljJsYpRzsmXlCDNn+rHMdDdAyrum+2ZXA8CSvTl2Ugvuyw977ay+catHlhRJj22I2I68nm3DjVIs1FvDV4EstwA+HKcHk9sgkEqxeP1Gm6pivzDlOAorXeAiObIMK9DKovtyOEACYxi/IkXZn9E5esDcBAM7fbn2pKoTIcisURI=
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 13:35:33 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::5) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 13:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 13:35:33 +0000
Received: from ETHANOL-DEBUG-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Feb
 2022 07:35:29 -0600
From: Rajib Mahapatra <rajib.mahapatra@amd.com>
To: <Prike.Liang@amd.com>, <Mario.Limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
Date: Thu, 10 Feb 2022 19:05:07 +0530
Message-ID: <20220210133507.5954-1-rajib.mahapatra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e60226-be5c-48f0-d617-08d9ec9a3682
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB520799E287AFDF4777F5499DF22F9@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC04ylrRIWpCPdGSAuH14ZWKhG2+/W8ru3sudVGQgIIy0AzPKz6ns8iPro4QIGSNuHmS+h4WwG02mNnE7a09ZfaPLGNX2lM2Lu/RSxzsAhy0u8C9BbrO+QDDjKDnKljnwec8gGw9dfoT0AM6kkp/KOWnMSWY8QGq0YvK4nfFmsErmz68ZhvmxCPhYGnNUjx8qXOOJENYrp2mQ7Z+u+Ds2XUz2W5khIqSdWKw5L0rrkEVxh33/kWLrQNuBZsQVTHrVH90fpVYrPQK5rioWN+QCATNZQ92dqb+rPrM9TbNfXiGnCKMDnHISGFzKU5SnYm1B2HGAKtl7f+12JrTpyUIE7DdlDOtne1KJfIwh5jQUmsUpWMqOcyaYIl6oIqV4ApbqTSSscGGPv6P8kockZMIKkAhEGRTMiPvhsWSHWdkCxpdDwEfK8wtgebHl54QIt16JwxqEGqGZFE+1u0o0JcR281IgYJB0NbzKEDSLLw1056plt1o361vXR0GV7x43MO1BElk7UYXOnARLt+oe/UfOjyhGTUjqYKc/c8EMiXfbsQJLkY9V62hJKV3L+ZKRGXtODFPZZRlnSso33XqPMwbpD3EyDhYiQNBMxAL4VC+EBHRYMZbgdsfb2QeOuFsMgnKKTxEyw+e4yCf9zX2fDl8SaKPWF322tVgm0UEMy1rxYjNTJJhRjpd33WKGAQmhJ/9DSsYj3QCBbIQB06/Jj+4fD6uH1O0BRcLerH6TnZodd0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(82310400004)(186003)(70586007)(8676002)(5660300002)(4326008)(70206006)(8936002)(6666004)(508600001)(316002)(54906003)(2906002)(44832011)(40460700003)(6636002)(7696005)(26005)(1076003)(110136005)(2616005)(426003)(86362001)(16526019)(47076005)(336012)(36860700001)(81166007)(83380400001)(356005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 13:35:33.1267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e60226-be5c-48f0-d617-08d9ec9a3682
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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
Cc: Rajib Mahapatra <rajib.mahapatra@amd.com>, amd-gfx@lists.freedesktop.org,
 shirish.s@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
SDMA ring buffer test failed if suspend is aborted during
S0i3 resume.

[How]
If suspend is aborted for some reason during S0i3 resume
cycle, it follows SDMA ring test failing and errors in amdgpu
resume. For RN/CZN/Picasso, SMU saves and restores SDMA
registers during S0ix cycle. So, skipping SDMA suspend and
resume from driver solves the issue. This time, the system
is able to resume gracefully even the suspend is aborted.

v2: add changes on sdma_v4, skipping SDMA hw_init and hw_fini.
Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 06a7ceda4c87..02115d63b071 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2058,6 +2058,10 @@ static int sdma_v4_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* SMU saves SDMA state for us */
+	if (adev->in_s0ix)
+		return 0;
+
 	return sdma_v4_0_hw_fini(adev);
 }
 
@@ -2065,6 +2069,10 @@ static int sdma_v4_0_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/* SMU restores SDMA state for us */
+	if (adev->in_s0ix)
+		return 0;
+
 	return sdma_v4_0_hw_init(adev);
 }
 
-- 
2.25.1

