Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79EC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2D960FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 09:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC2D960FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DB56E192;
	Wed, 28 Jul 2021 09:04:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AFB6E192
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 09:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9e41A5FojtbjlJDlWWRclYsEVu5yyfz3x+Nuqdsx0aaKffZSp2lUsZWEWVWlGb/d+2Nr3WHWpgL29VUuVsjDpRPjFUOa3cfDZqze80s8q5zmxqVtmGT5cNcNAvyXQpXtIH7jWuytB9MFPCL7pYl0C2JYv+CHf8LETeYOKszFemaGcDFqBIpoCqskhihLvjuU5JeIvQoLGI0oQBgOMLlBeymbgnP9kqpPSnNxp48dYkeBrQQsYo3edWD/oZSEHrQKefp/DJewNjp569YHGnlyvfaQdlXa3sE3wHCYJzgxa2jUoThQAaPnxnBDrk3qlC3hH4EvSukPxREpTNRkp3Wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE6NFJW6IJjthPCzbbsS+F5x5vsWPTUjwmu/HyKfI2k=;
 b=CJ0DO+m5EW/8E9A/2VVw5lQAYFWIvgLHVp6zbjSVpigAWUQi+jfLgUGWKfSCm2ZIdOuoDnAWnqCLi1KqWimeqFQB5hDMpsRGSsgKhcvA0GyZNnHWc8H0ilcCG5Nlm4Cw91KMo2FX7ehdbYzNNo/dSSos3lWJ+5iohjGFOaxf+V10TeeU/hLLkXayOUYcABiGH3DMzJXSVkVN6NEUvY1Dx9DCW3vHVigRBicYX8UlpT8gjYIZ3COYVWIli6uWiM/RqcHOdC71zkJme6MymGxgx8Xa4+cspWELnvtJq/3yqZ7D4Y0m44eB7f/loztYd0gb1G08lpWRhKrf1OPzwu3/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE6NFJW6IJjthPCzbbsS+F5x5vsWPTUjwmu/HyKfI2k=;
 b=aAXjFWsPPC5tuK8gkdOVKnObP2QOu2EOnyldULrKEtDtGkC2/vHC0Z+tKdCNUcGreovasLKNzvvJpnbo485vQE6bf4yUlJddUQAampzhQYsPKuP5F5wbrJpsuruTUYwRdyrLntPMRCKw+pgOjSDjjXtL/i2VIy6uT7vSq2N+tK8=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Wed, 28 Jul
 2021 09:04:23 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::95) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 09:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 09:04:22 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 28 Jul
 2021 04:04:20 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable psp front door loading by default for
 cyan_skillfish2
Date: Wed, 28 Jul 2021 17:04:02 +0800
Message-ID: <20210728090402.638158-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1998a1fd-1965-490d-afad-08d951a6b13e
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5422:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5422D475F4DEA22A18FC4202ECEA9@SJ0PR12MB5422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fh5gMJLOzrswZPoKklfyhlEG1Lm9N3RC1ys+EYuJz6pXJhaFTedFLG7pDsMb9PhDwa+Z88dG9Gt1A8qS1tXxObBMcdNt7iu76rR+2SV7MMNFFHWAEChdSkpRLbcam7e+Y+8+Vfb9bM1Md+++n108Ki8TmTYaJQw2Cqn6OpfqO0vfZ9V6E44BAi1a1A4Juqu0j4qE4/VaEXmhf3qBa/hKjrcaFCdiMOxRohGjO5s8EGcwma1Wdn8etDwLJ7rN3HPtyjRR0Ow/jjFrvolmxSH48LyhFt//ED0TMZeHFk66Qx/Rqph5bNh6LsGwomVR0BM6Hv1z47PeJ+4us4OMBDda9EaLiIJj8lPDwg4mPOJEHeaSr9gremz6LUIDvs1sLTZD1vVrQm/mhDj0XxyvlBB1G8VFWC7VihUI+gDZV7lu7INiRPQsLXxaxg9OFekgH0YBr+N/MpwJvOC8UaS2SesGQxaAVq9qggb5m2I3WxfgR5jyTdH4GwgbVCqw8y5ossGZW21+UgOGJhN0tUpoDjDErf2E0eKg7HrYE2iHwQ+nq6HkvHtKPSMYw1Mmag/UlB+Iaag4vAelshT8NHOFi4wAdA0dxBzOCtTKHyTdFdSvd+U3B2PKEfOrGpax9K5NXut46T95z9X4dBN8/EfodXzuQD2xxkBVrrX6hrpXGUTRM0GgMOT/dGNNwekFI8cIHbqgX0lT1e/B5bOH0O4VERRQGxpoR3+m63pKTjz8G9BIqD4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(46966006)(316002)(7696005)(86362001)(16526019)(54906003)(356005)(5660300002)(426003)(6916009)(82310400003)(1076003)(186003)(83380400001)(4326008)(47076005)(2616005)(70206006)(26005)(36756003)(6666004)(8676002)(478600001)(81166007)(4744005)(8936002)(336012)(36860700001)(82740400003)(70586007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 09:04:22.9312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1998a1fd-1965-490d-afad-08d951a6b13e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
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
Cc: Chen Gong <Curry.Gong@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function is ready on psp firmware, and enable it by default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index e001875ea1b7..5fdeceaa979f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -410,10 +410,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 		else
 			return AMDGPU_FW_LOAD_PSP;
 	case CHIP_CYAN_SKILLFISH:
-		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 &&
-		    load_type > 1)
+		if (!(load_type &&
+		      adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2))
+			return AMDGPU_FW_LOAD_DIRECT;
+		else
 			return AMDGPU_FW_LOAD_PSP;
-		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
