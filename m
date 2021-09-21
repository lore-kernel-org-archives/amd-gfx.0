Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78648C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0EE61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D0EE61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C21E6EA83;
	Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E076EA3D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWvQ91wL/Mur1MD6rFtBIif1cYtyhnBrSiP/S0dtksSAWHQJMmoIgHIVBZbfJZQPy+6Zezsl5vFvC8I2Y1OQ7TVILMMdtFrcjyKYhq5Bu+aSXq87sQ6YXJVhKeNt0yNmoQh1t5oM10YjV+sJn+es4paRsrp8sBCRukI5zxWMXZroY5l5kQZTDn0bLM32O5gXcbzkS8QL3fvKfrlVGvoEHuXw+cf2FRBy33vS1eqsHSBx5Yc/SxiGz3kH9GyGg8f5IhQSKGWgDnul68aylIkC4945g9JY0rFNPCYFVo4/eLkddeHYeyl8O3UE0DgaZ9u/l+xy/C6GrAd9Y91cI0hunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZGOPVcE5D17F5cQLUWocq21J+HDtIx3FBD2MPaVCdmI=;
 b=dTkw9Xex9Zgmym882V4Z+Q2q6g19o43SU/NfWqYLMy8ZNVeyEZxqAlgn6r6hgOqbO3TEdP9AP+JJ7wZroAqhxJk2aFd6AYm1hN23l1r1YTztnZvfpOIU9RdeMcz0/uW8jlsbVtooY9VHf/ziYoyqWeQmOJf6Bu/CvyrVibalesCSlO8PEzkgOXvi4EhQ/93nV3MTE5T4RuPPhBCoydguhVuSKaCwy13lmUGUYxDgbdCmkXEu0tO7nIZ7tQsEYDFOxHiBAqpdhKrYmynm4QFBZqNSHdj9l5y9siRNl01VCp6cD778CZuAGQs8qdOuI9NhA6+LeuOQr0M08qSWd1zOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGOPVcE5D17F5cQLUWocq21J+HDtIx3FBD2MPaVCdmI=;
 b=ePyC1sVHfOetDGVIDm5ZfpNHlP9/cZfssB7h/ppI8dHm7a39RbMGLril5kAMrJP8Thdr0M+KduZFEsDIGLFZwQlz0DiWzov3s14tFsnJbbZfcaoU5NK6ZN+cq3r9DULWGvv3uH6dkhAg8nlg4wjulBfFRNLzD7tyB2y5ghexR5Q=
Received: from DM6PR21CA0016.namprd21.prod.outlook.com (2603:10b6:5:174::26)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:55 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::2f) by DM6PR21CA0016.outlook.office365.com
 (2603:10b6:5:174::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.5 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/66] drm/amdgpu: add DCI HWIP
Date: Tue, 21 Sep 2021 14:06:49 -0400
Message-ID: <20210921180725.1985552-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fabe82ac-6a09-48aa-588a-08d97d2abc77
X-MS-TrafficTypeDiagnostic: CH2PR12MB4215:
X-Microsoft-Antispam-PRVS: <CH2PR12MB421510075ADFC365C581B24EF7A19@CH2PR12MB4215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 691d3w1GyZ/Z+btu/kLLlXAGCARc2lTjdpTghvVTSIUl6XEBf6H5fubQqIWz/wJPk7p21glROdOdwoxx6XSFCrHju3bhaF28g+SqkOGXt4fXCOA3uySxUCafuOlrrGHaUQay+QPfvAEcn19i0GjpehofekPPYd+U01xxHT1YOIEjZ72wLuOOM8YMWtaPdPWo35vozNCWzNz2lMiyJg8heghl5i8tr8WMUT8TgrguJpXkSOIG85t/ojEm8tNYandy93CB5WdeEwGPVYK8cyQ7MO3cTy3eNwVds55ojMuyRG/mNFkAjv+bvxUsWOyOl2b19kRmc0zp1s5D0DCSzot1zK92+5RszdTXqANh1mKhPHv/tOkKDa7x4tMqY7Ya0Nbm5cys6gTS76RFWd5a0U/zu9hRCXM/gi0dwD97E14gWLa8OWQ188rkrkpbPat8Lcjk5OOS38w1FC+vmJ0uZJ+Xx9udhJB7Xs6YAP4anLqA9cMdXo9W1EP4M7CNMpAFzW1fC4NgfPHyiztWTXmOvXck4OqAPlEkwlAL9s31SergD3oO9RffhG7my+IGsI3xcqFOO5fMIYLonTzNpaYK7TyREd68EQ2qP1+UUbplRhOuWRNQZEEbJTRevjzoWsYyE8MxHzJR9LZ66+dZIP76i7PvqSp8MH0K4IAWt8wehEeuBYgjy1r2SOn5a7s+OMbd8wb1ztsZKbov6wXc938MRufFZr030dfpwNcmmPeYx+nVldU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(26005)(16526019)(70206006)(82310400003)(186003)(70586007)(1076003)(356005)(4326008)(36860700001)(6916009)(2616005)(86362001)(83380400001)(8676002)(426003)(508600001)(2906002)(6666004)(5660300002)(316002)(336012)(7696005)(8936002)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:55.2868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fabe82ac-6a09-48aa-588a-08d97d2abc77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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

So we can track grab the appropriate DCE info out of the
IP discovery table.  This is a separare IP from DCN.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8df4be702870..815db33190ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -756,6 +756,7 @@ enum amd_hw_ip_block_type {
 	UMC_HWIP,
 	RSMU_HWIP,
 	XGMI_HWIP,
+	DCI_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 048a08d7f480..6a993043badc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -149,6 +149,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[CLK_HWIP]	= CLKA_HWID,
 	[UMC_HWIP]	= UMC_HWID,
 	[XGMI_HWIP]	= XGMI_HWID,
+	[DCI_HWIP]	= DCI_HWID,
 };
 
 static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
-- 
2.31.1

