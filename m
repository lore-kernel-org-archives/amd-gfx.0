Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331D3C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 13:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903A311326D;
	Wed,  7 Feb 2024 13:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DXHhEwxr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02FD113274
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 13:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNgLlvdYVAu0XXILcZlycV1F8kz5Nyii1pQ4mL2Uc5UmeICOrNHvRZFycAhmhNJAVxDR0SXpXJCDCHYC5s0SAQMqfK8/3JcKYJcTmqa2i1llsPwwK4XxirnXNzFzveT02Pb+3SK6oNvLsNTUgPtwCRDs7ioqDireL6zZMUvjPfG70SdrOxmfq6PPPVNs/6CqKnW6mMgVKyI4Q9uXebYwzZ8s2+s2VtVeN9Dqy2E0Ys+p4xoyqHKVoXvQR2OHfxPvKXk8VzpIl81J56tmZ/bgVSbJQz964urZ+JDHGKN5fjCFd/EuV2wl6iuvXkBd3tD/nA3TpKwUUDz4RYPPExiYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUQn+8wZHxfFJUumH+313jmeQ1nxB7aU+068MeAaT1U=;
 b=GgG73Plw0zkqabeuVh9intbLdNJ/M0s1hgRh/H/PcmfMKG1ZyZMpbvDJr2hNWewlBeoQtWKqurJ4+P3GUPiUj63592Y09ZAPAaP11p7rD/MzKfODOqus6AYujRnZIfqDdhV/wLsr2rfDoyGcdw2XhVew0o6kwANnmujwbSdVIjQ/WDDv7TqIsDp1srwqs3LhYQDl+/tm3D79HFlXtXhSxNY6fPnb1HGG842VKsJlbpph/v4EbCPbZWJGvGhnLZyElF+FBmgV3THySlhzwcMFzPafUiMmgYX0eiyAWgFoxUclmUPk3IeWY5hLNKg5ZGFpb4yFbWUF/xmaYPt4TayBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUQn+8wZHxfFJUumH+313jmeQ1nxB7aU+068MeAaT1U=;
 b=DXHhEwxrDa8EtnAhKtktJboTBZ/ZCcefTLlqQSQSUHiOyGArc+WMrmKKkUX+vkZtkJl126wK38X6Y2DOm5XZlrCHahSv/hQ3K+wXRzo19ZDKAKHwfdUY5wje8C7EIHG9t2iaC3FtD9Aeksy2Jk6XEG3oHrG/eMeA3pgWuozq5I4=
Received: from BN0PR04CA0173.namprd04.prod.outlook.com (2603:10b6:408:eb::28)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 13:54:57 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::3b) by BN0PR04CA0173.outlook.office365.com
 (2603:10b6:408:eb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 13:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 13:54:57 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 07:54:53 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <lijo.lazar@amd.com>, "Yang
 Wang" <kevinyang.wang@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: send smu rma reason event in ras eeprom
 driver
Date: Wed, 7 Feb 2024 21:54:18 +0800
Message-ID: <20240207135418.693925-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207135418.693925-1-kevinyang.wang@amd.com>
References: <20240207135418.693925-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6fa5f8-eba9-43c2-b0f5-08dc27e45e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6S4L1uGdwXs88EQIWtL1i/DjPyv42pD+Jxruwl5uPlv29i8J0CS8Q8/RngPl1bHi2mrUjkE47vqiM3H7S9q0EvOQBLZdoUBnUJIQ0PL/6guYUrtxC7ZFqW3DpehCqLMh6hdPmTXabcQrv/MjDPWTIT33Rm2U0ir+gf50FT1P/VgJl0JsIzs4XujirJcJJFXF3JVOtGVljlidqJNEVyDn2r3nJ28jEtEq0vX+0JESN0/yFH7NaubBzy9ONjvcCgfyKc5jO8/ViKbeTyyHaMrz2UGTZn6h6x6um3fBdfacPoBkicX1/Wu6iYhp41fWUeVaru5WYfWEiprCDfHN246UojLKL8insMGv4zM0kEH2Um/W17vUC05hCB+1LQzpSk5I3wzhUUqR87HAtpnp7Yvglp7pM3iLsNsiuaNqThP4qnA5lyTt8xVLwFIdH7d3WmqTuv9IcSftAtp3A5WUGyxFdWGqWlykVtVKdaXIbpW86dXNBFMaLknUKQXX/x4MtJDU4G9nSJ2JrRd5BlNUzVLN7PEKLd58jlEltWvBOvhlLjFDCQnMP7LqpB7B9s3O+gI8wzROQGLj6ML+IFAO7c75nYOZlTjcxVFwPU75/SyqJ6oVIiYfl7HCs63TOJFmaDsrCXkqpk82aalzAFQPigTaKP/fwWcFz9YCvLwigNxNyjRupQg39/I2HLCgtzIoUkMup2EaeQCdbtYDDq4QAZGc+8i/6MQ6IMPiu9ri1+lHuN3O/QojwJ6lIxqzJfspoclia9PUXon6yOC/Ah4mmsKaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(41300700001)(2906002)(47076005)(36756003)(6666004)(316002)(86362001)(2616005)(8676002)(478600001)(70206006)(7696005)(5660300002)(6916009)(26005)(4744005)(426003)(4326008)(83380400001)(16526019)(54906003)(1076003)(70586007)(336012)(8936002)(40480700001)(40460700003)(82740400003)(81166007)(36860700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 13:54:57.2496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6fa5f8-eba9-43c2-b0f5-08dc27e45e9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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

send smu rma reason event to smu in ras eeprom driver.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2fde93b00cab..b12808c0c331 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -735,6 +735,9 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			control->tbl_rai.rma_status = GPU_RETIRED__ECC_REACH_THRESHOLD;
 			control->tbl_rai.health_percent = 0;
 		}
+
+		/* ignore the -ENOTSUPP return value */
+		amdgpu_dpm_send_rma_reason(adev);
 	}
 
 	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
-- 
2.34.1

