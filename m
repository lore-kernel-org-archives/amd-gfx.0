Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41D7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED1360527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BED1360527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD916EA6B;
	Tue, 21 Sep 2021 18:07:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F696EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvBytTPrHtU5hFssl4TgxQLJ4teHGH3HvAoCsAMRmLVZm1y92ubKufrqMB370rnbjQMKtbmc4bDelR/8Qp++DMHvN0NRvesxW005x1P0pStcusk56fvGBmFzAx0NID9cfl8oymUXpNeCV0oeZ/NXfDmKCI/Y1IyL0wG/7x4VnfABJLG1HnA6B9j3EP6Xbbj1QC+l1eJuMnEhuSI6YkqO47mKzHntYBqX78kjmH/iYDAP8yfNOb2imlU41ZmvVsZUKJnWjdXJ/U5RN9E2rQvXZSOFcj1JFwAKLkOPARf6kdx0PFi3qKycu3XnBYhW3Qluoo+eMvoEVtGxWK0rB7uUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=W0URq8SHMtMp0Bt4NwN/uH5lnZSAEn6A/e8N+PJf6ZI=;
 b=HcIQv87nYcVa6toPtWq8H/PWFtn/bPpCx49M/TpvDregJOItp9uw8wLDPMSO/RfJwtp7ghUAgPmcyaQr6ZalMc+s/k2fkv507ZJPjD7KZC7CNyoBPDf2cl/S9evxNJvl5RDXossxhuo64B9j6S5Qtp8NAJnyq5466ChbiN+wQ+b3arRtHuSx0JQLWSnKzvufoXdYDh3YB2RY1iOsf/yexsTdusfGzJGSIaauuzAWkwt+Q325n+NqolnnZWSfxUT9v9CyiIUtNob6ngU+L/xryAva839NtQEq448kAH/yaKw7Th9eLUwHYIO35QUQ18/1b5gL1ukTQdTuaj3KjKynzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0URq8SHMtMp0Bt4NwN/uH5lnZSAEn6A/e8N+PJf6ZI=;
 b=ezYZriUzOH3WH8wL/rGAS/yGV0ZMMFkfWUz3xUu7sV7eVl/4aSdJFvLtGCL9jfrevMQz5/6aP962Y1ANHVcivgfF52GOhPgDPCAM/nLzWL/6DizVgOfGYqQbWvTsPdsONCOOuXV67P7UeLrpFr2oHwmVTwhYU7M34wbh7JAccuw=
Received: from DM5PR11CA0015.namprd11.prod.outlook.com (2603:10b6:3:115::25)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 18:07:49 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::d4) by DM5PR11CA0015.outlook.office365.com
 (2603:10b6:3:115::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/66] drm/amdgpu: drive nav10 from the IP discovery table
Date: Tue, 21 Sep 2021 14:06:34 -0400
Message-ID: <20210921180725.1985552-16-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e505949-e187-4843-c003-08d97d2ab8b1
X-MS-TrafficTypeDiagnostic: BN9PR12MB5244:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5244DE6770F65F5A5E5A367DF7A19@BN9PR12MB5244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55JdrRgKukQPQOhVmq/zxfwgLg8E6pCluz7YQ3IIzUyhUUiPH47ysV2uG+6Uw8EtWwjpKUwiek40Glbh8Y75Li451qid70yVcDyEdiCAG4lN1Nw8ZM7ci4qEwonoq6RueUvfT4CdqzwCBzLFYlfnQPOexBlnh/A27fKs04Z072joHCbzvOscGvo3NXk64k2rPFU7oiapqgPQnCAKFz5Q31iF+oI9d2V8wuxOaSQ4Vk09Oe3ljbNRrknuJYvJaIRA9Bvb6nF7OC4CPkfEUj8mLirfhNJ0YMQasSaYlfvUx+Hf/z+NI1bU57i/wVOyQL/Bhd3q8k3QyDmHd6JKuaNAphhvFuZaHAHHeZwXgR7cx2ai1OTBo/LDFcxDUbG6yBRe4Qx1XpMvO4m0G0gAFQ4bWChBEzHd9Qz3d5gLUX7eUZc6iVSnByuZ5QCXbgkMApcDlpyr2ejX+7WFlRGPTUglkHgw7CCq9i+uh/IVfmGApGkyHPU6Xe8YmG/AUqAs84BoB/cythK9Vpr8LjtoQRWwbt7P7PB80Xohl10yncfFIH7SbiF+8z0TMSnf1V2nCCrG36t8mKxO4PTtWDwc+U48TzNMZN50DrPZ5lyEXjIm4ONvthMZgNrJrmjubHDEFKJ4UVv49MWD8C4uMYdnNX8r8/Qrv/aSroGKBJane84SeqKwzXlSC/ZF21Zo53ifDZArSJbZed/NwnFSoPeQ/hXtnGFbfOEyT3x+7rWvSG8MksU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(2616005)(426003)(2906002)(8936002)(6666004)(70206006)(4326008)(70586007)(82310400003)(1076003)(86362001)(508600001)(36756003)(81166007)(316002)(8676002)(6916009)(47076005)(36860700001)(7696005)(186003)(16526019)(336012)(26005)(5660300002)(4744005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:48.9581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e505949-e187-4843-c003-08d97d2ab8b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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

Rather than hardcoding based on asic_type, use the IP
discovery table to configure the driver.

Only tested on Navi10 so far.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 782ebd5d2239..a4503e006fb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2142,7 +2142,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 		break;
-	case  CHIP_NAVI10:
 	case  CHIP_NAVI14:
 	case  CHIP_NAVI12:
 	case  CHIP_SIENNA_CICHLID:
-- 
2.31.1

