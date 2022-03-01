Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B606CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 15:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FBE10E496;
	Tue,  1 Mar 2022 15:02:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CDF10E496
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 15:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVqAnKkkofj5n6CBbljdV8E+OEXAMjYCX5y3/x65tptqmWahiy0Ex3mVc2Knb1/xTXvGZluzsTV+L1vGZT0DKTGiWpsI5+ClPk5CT431AhKnS/v0Y0nhl99Rz0xbViO8FgHpfX40vuMeWwzRJqUmeHouTPL0XiWr5tWpB2yaAQVIXogh1ubqFf/R6HkhdA+REmRs4qkaP0BkFikOgvWIS7oKDZXSQye/iFE/utw6FmnBQrSEfVEhV26OA9yvjlJE1V71ceYS3mrMeBgvkGhAkYaHISsnPbXF8phI7z5F7UwJCk8ZsImeW/MpnnVOml4U9cePnCMdAo9NqLSYgMCIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Xi8EIxKJcLT8sX4ZEvCRVPDFTIn1F5J7w6HQYBQzEw=;
 b=d3d6+TIJmaDkt8v8MCiQ698QXaT6gNNIV3j2tUjpDgTxCZ8dZ6YEL8pEniUdGsYDHkFNtfgKfMrCfv+vaEOwV4jVjvYBCNl2XvzwB/IbmYfKwV/XbNA6/40WW3dzewKvmM4dOUOEh8V+t+yeaL3OiMkrfRs9hR11TE9jB2cAJ2tJFVdaE2cOCAZ0f94Zg3jdMs9Vre7taXaFpG1rnHP6P5fUR+zkJ1xaCw/Ox9pkIa2tMaaaqPSIrlWiNje9hVKvu5drDjiDFpmquseVMGUKyonba9cvNsJUs9OE6yqSIHzGQsUXHC4P7ftCsyfF81+oVPmqHLx1JAwT3/mluKHR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xi8EIxKJcLT8sX4ZEvCRVPDFTIn1F5J7w6HQYBQzEw=;
 b=iohXwO48JdSthungtrt+VBwy8jSd9sWbWHARV0pkyoP6UtilffGlBLiO6uG597Hb96i1286Ya9404nGX/M1Bl+pL5ihQ21FBcqcpxGHXM0FBGlh3J6BIsax1XiweRQQ6hCKiOdivaEuVQ/DRlNSxPuST7FUpOP4DCiTE06m74nM=
Received: from CO2PR06CA0072.namprd06.prod.outlook.com (2603:10b6:104:3::30)
 by BN8PR12MB3553.namprd12.prod.outlook.com (2603:10b6:408:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 15:02:02 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::8e) by CO2PR06CA0072.outlook.office365.com
 (2603:10b6:104:3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Tue, 1 Mar 2022 15:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 15:02:01 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 09:01:58 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdgpu: convert code name to ip version for
 noretry set
Date: Tue, 1 Mar 2022 23:01:20 +0800
Message-ID: <20220301150121.3785743-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301150121.3785743-1-yifan1.zhang@amd.com>
References: <20220301150121.3785743-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19407654-93b6-44de-d452-08d9fb947113
X-MS-TrafficTypeDiagnostic: BN8PR12MB3553:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB35537DD21848BBF5A0C62E69C1029@BN8PR12MB3553.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWrRVgTgPd851LFlFwNGsSGI5iY1qjt5LxH32PYbabmi5ip1OO5omTe7EunfIkOK8/9eGQU4xXMqQ5kS+SIevqPoewmAV45TVd2/dQkWiomVBppzjL8fO/ov09oS/DPIzTUmZ4xHktpR1de8D6Yky+ohfk03U7FLy/34hsAfME610orXTxBSgcWGezBTIM8THZLuhSOADEP6d6s1Z3oGSG2C99sTIRFfHyIXZL/vq97/KfV5DPVMn4uqxBaKcvG7btoUBxbyvlo6TJMP8cXpZY/oQZwlnVM5yeFaUEjdhWIVFxVkquDd2B9gLDBdhwtbA+E3/bX1QD9pZ4DoOaLu26nSiu2Ts1VvikO+TigDg3DsB5kr2SiNziysQgRIHn2YGh68uee0pIBCJYCFs2bIWENYUco6SsFSFa4ugICzxzgZAJgIvKbxGxgeMu2w8PDuOyzBFzj0w5D4KaNzjXyMPChIYgWqcDbax53mm4KVcFbraAY/n4HY/Iy8npjuZPMLdF6tGrPQRovxb1B7DurnrIZkmj57/Sc8O5IS12S+76IrlNScrYXznVUnYbGdrze6wmsRpKYJkR8Ni2SvUDm3F9RsBmCyKtH489mg+Lt7MNrWXB0YilkrxkXg359/ro2xvjdkit9Y3jEPkdPV1GpiKRI+kJ/psIYWIvDxmZwILVeQBnlTdfsY43qOBInrgzviRKAyOgv4A5cZIVG7SdfckA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(5660300002)(36756003)(2906002)(40460700003)(70586007)(356005)(508600001)(8676002)(81166007)(4326008)(86362001)(26005)(54906003)(6916009)(316002)(47076005)(7696005)(36860700001)(6666004)(82310400004)(426003)(83380400001)(1076003)(336012)(16526019)(2616005)(186003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 15:02:01.8617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19407654-93b6-44de-d452-08d9fb947113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3553
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP version rather than codename for noretry set.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ab75e189bc0b..fbc22b7b6315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -559,14 +559,14 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 {
 	struct amdgpu_gmc *gmc = &adev->gmc;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(9, 3, 0):
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
@@ -576,7 +576,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 		else
 			gmc->noretry = amdgpu_noretry;
 		break;
-	case CHIP_RAVEN:
 	default:
 		/* Raven currently has issues with noretry
 		 * regardless of what we decide for other
-- 
2.25.1

