Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F4BC48BEC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9FCD10E281;
	Thu, 15 Feb 2024 20:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fd9LThKS";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B9510E15C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZePBokQy62ttQvSrN4DPGrCPqqy7SiOvGN0UATlIhJGt24myPW1ecLHtCxsJrow9dh4mia3xxEkJ+eRpekft54OPPWWYwd2HEX76aDFFwUmH0xfX7TVo4Ja/zOTRLmbALKuInRAvtz8OMUwGq0m33mGNHbR8eJ1Opmg2Pq937zCokui0/RjyHHaqDmnRIohxHECF6YnXezew20+dy2O6H+DgRSkdClSXAesG2bHtccmiCYyBppU1FW5gEgqGBpuCt3PejGMiA3DG6GQGPm/lRsrw6zF3/PMbfOQTVOBxPaAi6b3FDhn3S6mgP1zCnYHsVh85nxuoW1sKS4PZHP0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQfc8NwrkVTbpzeWX+d4eHvKIp08hEeWgp2KfoYO5IM=;
 b=F5jlzrw5vbpuxcpfeISg86oah6+98ykKtR72MD1mX3hA8rDTCnt7FIw7c5KIVtX3MOVHJ1QV2So0deKRkR6EROuwHOVxrhnQK49DAB6Sf5CjmxSYdxiE8teNAJ+G/b60GLAQoQrr39EaKTS7EcASoRoBkGoRqclNBauakaLoB/YBlbH3ozIH4JcdkWTkF0NEGB7jLedviZoyuf/u6d8Ha57J83di0kLk1zdncwVgZVQuf4kByiRWv93GbPRe0lcEqKxGxj2vwbe/TTn4fw9NkE8kFFhpkK9QZ19t+NzSxsg8gPiMyhVPZRwVDN+Et+Fe8spYrJ9X29Iq+Eb/LiK8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQfc8NwrkVTbpzeWX+d4eHvKIp08hEeWgp2KfoYO5IM=;
 b=Fd9LThKSpnv21h9cEdimGWBV6ICzH7v5n/mgK50Cz/v1EQnIivQiXdVcfG9RJnwRkcwtvZq0y+xherg6kiT5uCF2q/rHoVN0Cc+PGNZVdgn+2CKx9V73TEQnA2zfkvI9LfYo9F5xqynbh991NEMWB1h/EbWml98dlsdg4Cdg62g=
Received: from CY8PR11CA0020.namprd11.prod.outlook.com (2603:10b6:930:48::11)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 20:26:07 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::71) by CY8PR11CA0020.outlook.office365.com
 (2603:10b6:930:48::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:26:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:26:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add MMHUB 3.3.1 support
Date: Thu, 15 Feb 2024 15:25:45 -0500
Message-ID: <20240215202548.415025-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d757ea-f358-4016-e6bb-08dc2e64571a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkW9S4+Z4gQJaPDPCR10qrnYdCJICwA6YFNhx7iRPqc49mj4Rdxvo0+Win6IQyBfZcLI796rfaEUU4NOZn5hIsMtcTtrmvbH+JqPyt8xHSSOMd4NKOuWmAuSj+dpXdRxTnVr1wdqxF8S2jqg2xfy2gGbjsI9Nl6GmTI4n+DOMnhm0aX+xy+gEBOdZyCmjm04APhhwzjFQIccKRpCUg8p4Lx7Fo+nJmgHhS8oWVexKf4pfDC6N1xb7OiZwy4EuNqgw+E9R3bCj3Dehkao1T6M8uLMaC+rk9H2KwIBvcICoIl7d7htKb3szHuH+JHdPQxawZFl93fgnuFn/LnQsfBEQrCRMvmyqAyKmZd5Za3NBL75fqEjvKOwMLwy+yzPNXf8s/CaFXBMXlFEdii8jxf2YTfljkFb2BFtkcMFPdbxL5bjiCzAWlRaT9IT9m4oLS7Yhnyis/LGnc8WNEY1+Zpy9ZFEV49CiXjUrSUUzrck0GHQLbgykRrBxjHtJ1+BSH3f9L6t1xPZ+EevH5xTiW4KDljsIy9x12EcPbJ6uSCM0zPW+HGa06rxnyJTMzfwAwIJOhYdFkw1K5sgv2bZvTrqASURRCAaIoo2wraadYrh48XUeuHo9Z/GjDPhvrWwDj1okok3b0E8Tma31rBkHMCfzNY294pU4UNlKdsACJQFymE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(82310400011)(36860700004)(1800799012)(64100799003)(40470700004)(46966006)(4326008)(26005)(16526019)(41300700001)(36756003)(8676002)(356005)(8936002)(336012)(2906002)(426003)(5660300002)(86362001)(70206006)(1076003)(54906003)(2616005)(81166007)(316002)(70586007)(6916009)(478600001)(6666004)(7696005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:26:07.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d757ea-f358-4016-e6bb-08dc2e64571a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add MMHUB 3.3.1 support.

v2: squash in fault info fix (Alex)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6c68135cac9f..998daa702b44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -571,6 +571,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 		adev->mmhub.funcs = &mmhub_v3_0_2_funcs;
 		break;
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
 		adev->mmhub.funcs = &mmhub_v3_3_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index dc4812ecc98d..b3961968c10c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -98,6 +98,7 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
 		mmhub_cid = mmhub_client_ids_v3_3[cid][rw];
 		break;
 	default:
-- 
2.42.0

