Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0623EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 05:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F18F10E1B4;
	Wed,  5 Jul 2023 05:31:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B8410E1B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 05:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enkcM6iKbISdv6uJtRsV0dGH9bmElfhKyzqHdfMvDvHy1Werd8PRpNjA87S355Kqvd+/gVLm8dT3T+VSSVSxd8FxtznlcjXBe2T9qLHDCk9hVvsDfhpDbF2tBJd16cEHELAHp9w/pMBNkYJUSmsgoHYiyTaos2lTv9QsAd0naegnhxG3LnRtPWVIndXmb23/Su6xt8L8J/0Ohv518EUzmMNJjMc2T3b2YG7VOBiXTTmUxOqOc6WF1f1GsrGN61ATrOP1m7L88sWMBSCyhzZQgSORBGQBPfMkC+RIdEmMK0/3Vmof0ZJGC+T+k3SfQhK6GrLeS0+w5EULJgRsjkYGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvwzNZL8MqmEEo8GSHAQC2xV7vAp+6lVkQEIKLMpGIM=;
 b=NU4gvKRBC6cIwvufB7pNdxfzFhqKw2wHXOUseuAoM1j+uvd6JBojoshPj76kZFRLdKqpt96EKbyn+IlRFk1k3UyylSlfiWVganumstQyxKYqZKIby6MuOScHQwahChOhqgx+Z1vPRl9ve01KlG06G1cNJQHBQJF9zzaDJZ+T5OAVsXpPiJDW/kHYOODaOUDLDNWMIgbBz6w5XHM0GobEMjM79YNXdQszbl9l7NPfzvRW35r+EI4IEsHXcSkb7x+Sgpb8GhNtcmGwRsXKoslBmaMDf5UPrUCEiFFXcY+IxjYoD5lk0ItgOrU7Hafn50LoxDUmEbCeA98R1F0fMUkJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvwzNZL8MqmEEo8GSHAQC2xV7vAp+6lVkQEIKLMpGIM=;
 b=MicogbRYO3zq2OMdX9uoBMTDICnwbTBEJwaDHiUYOO9zVgZF+PXtD4eN6fwMHePgX3WLNy0buPG6jM51up/SzYqSn5+Q5DRxdKhYNyK7oMpNNlJaUKc9DaHILxP9q3TkvEghrPHPb1+LcQywufLc8gs9JFVHluarQ6Xf5o+ykKQ=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 05:31:09 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::3c) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 05:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 05:31:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 00:31:05 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove redundant GFX v9.4.3 sequence
Date: Wed, 5 Jul 2023 11:00:38 +0530
Message-ID: <20230705053038.2739012-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0dcb80-224a-405c-ebb7-08db7d1909bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p09XnHYXGaF/42UZbu8TQ+XdfkDjcD8HHoBwPYRu8LM6j1kVrI6BobUJGikKqZyp2G19zZtHquG+cNlGkEx7dlV51krOXvyPKcE/fygw2sC/0I1kIKNPOO9e9+g1T8nUVpVpwKTV1SEazEANy5DQeKOQqOfIUqRXX+VrdUDNljngdgW4skPnlxuB/L6+h2fU3ypHCUr07J/E7B8dAVB0iB1PD7NqlSci8ho8AauSIBrE3yCwbP1UOHH83RfqwiRNCvYe76SHqwItymBz5WGiEjaxWEuH+Ika2gUe4uQw6UWZGzVi0EZ0PPWqixtoIkMJ1JLXCkQLYlEwU9O3Qy0qpz5aywXVTE3uXhiD+HZE/ij0kT7JaifdUNeLXcqCL5eYRiF+U5a5YrsJJNKWyt/ftyY/NGKisC5LSJ9U/8s+NshAjhWcJ4NLNgC3ULgm0uwEAxSah1tOCJ92MbzEvaGBQL2vas0l14bObb3S8afPPQ/OY6H4yYB/thfgZUOnUfu7b27oyg5t0SWhWH0uyWJYxxuj0Ldip643JurOfVuEwElNEQM+N0zyBDRR+L+FN1ykZqjqBYNQYgLuEpEIfc8ljwdrdlCZS+76x4FTznBCjmdo1eFesT5J2eICcrwPRFzM4txP++4bpOUFdjyGw1TLt1JLxTU2nl9BWhfjniu9nXN43hlV4ZZAm5YaH5YPE4mZA33hi8hnLf28PSpFvg9N6gt4n1T+91W3ydDK+uEbaB81pASdBbjSNQYqT3I/r2pE6SkX6qMKvP/WXLZKq4w+mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(7696005)(6666004)(70586007)(54906003)(70206006)(1076003)(26005)(16526019)(186003)(2906002)(82310400005)(41300700001)(316002)(6916009)(4326008)(5660300002)(44832011)(8936002)(8676002)(81166007)(356005)(82740400003)(40460700003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(2616005)(426003)(336012)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:31:09.3553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0dcb80-224a-405c-ebb7-08db7d1909bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Mangesh.Gadre@amd.com,
 Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Programming of XCC id is already taken care with partition mode change.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29 -------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 51532d0dd7a7..548b1123f7c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1034,32 +1034,6 @@ static void gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPC_PSP_DEBUG, data);
 }
 
-static void gfx_v9_4_3_xcc_program_xcc_id(struct amdgpu_device *adev,
-					  int xcc_id)
-{
-	uint32_t tmp = 0;
-	int num_xcc;
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	switch (num_xcc) {
-	/* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
-	case 1:
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, 0x8);
-		break;
-	case 2:
-	case 4:
-	case 6:
-	case 8:
-		tmp = (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
-		tmp = tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, tmp);
-
-		break;
-	default:
-		break;
-	}
-}
-
 static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
 {
 	uint32_t rlc_setting;
@@ -1917,9 +1891,6 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
 			return r;
 	}
 
-	/* set the virtual and physical id based on partition_mode */
-	gfx_v9_4_3_xcc_program_xcc_id(adev, xcc_id);
-
 	r = gfx_v9_4_3_xcc_kiq_resume(adev, xcc_id);
 	if (r)
 		return r;
-- 
2.25.1

