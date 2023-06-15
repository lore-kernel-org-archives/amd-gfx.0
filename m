Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB07EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 22:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FAEB10E55B;
	Thu, 15 Jun 2023 22:13:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3519610E55B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 22:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnpMxDLlJCHl7oBKqg9uyXqgg/vciE+8RFtC2HRJU+m7UFAZ8ZXrHWsr9zphoeht67Tam0fZd6dXwhz6/gGMImMib3Oil9X+oFRrmuMJ6JVIBCrXgLiib/EksgHlyesc6PeRm3SRoHvf2wMcakxudxE19buzFvd1A8Sjc46S2eEMCqtDt0VAUULdaIzYIaj4wMocIscVdcxXY63BLQ05LRJ5mexvtQP9qdI59zDpgxJDyBoW7ucxbIYLkBr6ARXNvKGMjMocZgvCfOmv4ukplm4N3KkBqvBbnF+IXjRXkv/me9HfyvbrlG3Ifl2sPYxWN63Hdm3T93gjZ56718Odmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wcLanI2ZrHclOwbCmiCBbhYoXY9Ki2mR0FD4gxT/NY=;
 b=XJBd6DL+qPB8P8MaElqEjFCysjinQaqn1fZVeQsdbhC2opIYC7/eEmgyLU2GM+C6oShZcqYBuBQ3al88SI+fUDlELznWS9DwND2XmPenDz9OrO+eTaWcpE4Qb7t5z5XQfsRbywMWYQHLsL7+pDkeLGigtv7rD4GuCCAXKELD2B9E+ZcKFC2hbWHFbm/bcO9OulGRLntbH0ESVj3xf8pGJs4xhNc8sD5PtPQK41HU9JtYFNkgQ8CDQcCmb8owp6Nk/PwyOibPNRP/ALafoopXB/8Q/HOYeIBDdW1HplNsmrn1YWODwq5z627TsHDT9a57FSK67Jwnc6aql+U0Ia0joA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wcLanI2ZrHclOwbCmiCBbhYoXY9Ki2mR0FD4gxT/NY=;
 b=jmBpjx0LVuQrdf0oyDKjnvqbEKM+KDdcXiLtEbxm47tuU1DOJSf9K071pM2cK1gtyI590gT1StDYq35b6Ifpq1kk3xwx9z95cK1FoFlEdAzurUBquhsW7XbE6bVepYzUYHR0n5dB3Cgno5UkIgYWyMKNq+rqiCnl451YGhQOQBo=
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 22:13:33 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::ba) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Thu, 15 Jun 2023 22:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.37 via Frontend Transport; Thu, 15 Jun 2023 22:13:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 17:13:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/atomfirmware: fix LPDDR5 width reporting
Date: Thu, 15 Jun 2023 18:13:17 -0400
Message-ID: <20230615221317.3795214-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: d649526b-af95-492f-92af-08db6dedc0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmdZ41VTosCgmACQpGIYTSF3GfmxNVCFt8NWHAqC29U6ZGc5eXpO5k3J5/Ff3VD1LLxuzPaROrxYxIO+TqdcEJTEd7xmRflU2RLI1AaDuHTR68Tv1R90VnJwUr+RSXOdasXIo2zx3hOoItDrUNriDW0BnKk/+kCXPBJWQW6r9i2EarAu689eKvKKdRJV2HpUHZZyRlm2awEobRekmsMMW02M3dfKewL3YwNwPwWUmfljlmuVRb7EnTeHh2A07yq0cq4Mrp5NnJV8xfKkv8V/Gb8NuWuQShcmQLyZVPE3D+bn2jlyAD0dj52BTPZCcoot/Z/woDAybZzPm5dEbVP2Y6qDq6QxuwZ0B+mPkYSJIfL1AhfMLEpRhDrtJcQbNl9UFeRwjm7HUQW0USf9FwBo0zOOvZCyKmeAieVWFZCZwDNDItI5gA2YKnJsDuvafpMN+i9m6tHYlYMPOQqzCFcPgkr2o0eXeHRgwLzfg1O4Q7fdMDWxE6YQqrDGBbexvW06WhdpNAms5O7c1sf5c0CGJleTDtFxxsxL3/vnxqw5RJPhzzPJwJkFXCKYd3NnAWk5EHYBbo1V2kgBWAqMJ6eyeBtrdBoYdvEl+ZIJcdqxP46R+AnnlpyvUnmWKMjsTkrsOFeAeYD2orAcMdTP9l66zmnwQdaCisXT1X2jvyMzEhGBNJ7YvqgeM8a9FQke3ibyvdfCuoss3V+gTRCKFOH/OLWTSr1LGwT3G/uDtQG2cpg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(83380400001)(7696005)(2906002)(4326008)(966005)(47076005)(6666004)(186003)(16526019)(26005)(1076003)(40480700001)(2616005)(40460700003)(336012)(426003)(36756003)(81166007)(356005)(86362001)(41300700001)(478600001)(5660300002)(82740400003)(8936002)(70206006)(70586007)(82310400005)(8676002)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:13:31.4428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d649526b-af95-492f-92af-08db6dedc0f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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

LPDDR5 channels are 32 bit rather than 64, report the width properly
in the log.

v2: Only LPDDR5 are 32 bits per channel.  DDR5 is 64 bits per channel

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2468
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index ef4b9a41f20a..0b7f4c4d58e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -327,10 +327,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 					mem_channel_number = igp_info->v11.umachannelnumber;
 					if (!mem_channel_number)
 						mem_channel_number = 1;
-					/* channel width is 64 */
-					if (vram_width)
-						*vram_width = mem_channel_number * 64;
 					mem_type = igp_info->v11.memorytype;
+					if (mem_type == LpDdr5MemType)
+						mem_channel_width = 32;
+					else
+						mem_channel_width = 64;
+					if (vram_width)
+						*vram_width = mem_channel_number * mem_channel_width;
 					if (vram_type)
 						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
 					break;
@@ -345,10 +348,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 					mem_channel_number = igp_info->v21.umachannelnumber;
 					if (!mem_channel_number)
 						mem_channel_number = 1;
-					/* channel width is 64 */
-					if (vram_width)
-						*vram_width = mem_channel_number * 64;
 					mem_type = igp_info->v21.memorytype;
+					if (mem_type == LpDdr5MemType)
+						mem_channel_width = 32;
+					else
+						mem_channel_width = 64;
+					if (vram_width)
+						*vram_width = mem_channel_number * mem_channel_width;
 					if (vram_type)
 						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
 					break;
-- 
2.40.1

