Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DA2C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 09:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF3110E2D9;
	Tue, 25 Oct 2022 09:06:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C747210E2F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 09:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0i+BDrtdt5u9rvCjcBOfIrsUnYPikUnYs58SZCGAFP0f3q0sM3Xr0ycfxj2eFoqQVPZrnB/TQdhCDqaKFDNfRBf2Jj40hE0v3YNrR/U/DRvVtJpa8zqXjNFkzTS9Vaqd71q0UmP4/vWNHluR0KsXEEUEI5bRD6ruG44v+1+9LULivCxr72CJTDSjGxDRI4hAHRhKgLZnNvRu6pzhcxOXoN7L/WFpgbX43fAUfKvFokct58saW4nlwR+NyHXtl43LjD/OVVybuVsZAES2fnd91X07bYpPWF9cXKESRax3nzU32Pwac2TDwn9OnRzHP0LJTdywVdsEoiBxd1XbFMnow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3wYvoqDb/NsibQyA6o0FtSV6c7pP/RKIjR104qa+EU=;
 b=FzPC2T1JE4y/U1No49mQo2ZkOJXZVLCVNLeoohosNX/yovnmyUIwCRIuAuXItIKzFU6RIfnjMyjYaEnEMyNSaP5TfQhTiZSgF+uRuxdBQrQeoOTzn17kXkHi92ys1CTVuUBptuWUOUfGl/0jQH8OipA4xCdGlIdnveI4dI1+oCIjlcfEazx7MxQc2KJwXfZM1g9ujVA83cammk92u+qVrSx4rtgQjUCs0xZ98tAJGsN+r9TvSKkyd286ocuNAvj8byDcTfT3HFZbsBEtWyzCdE05xyU0+uKWciOgWGr7BB4i+aJ1lPz+k6iPInPB1rTgKLbkUQyeufI+HoFRNBWzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3wYvoqDb/NsibQyA6o0FtSV6c7pP/RKIjR104qa+EU=;
 b=p75ayuoGqK8+cYP4/avd9ml9/7ikah+Uv5bzFbeIltLXXHENzgAwN2RFUMJFR64PJVVqIZdIx7dljaNK24vkplY30YIamFSYulShFGf9IqmhW/sv+KsY1vpkhqWfaBLlCT5e0NqNISltPy+2UN2wbRvfBM33eArwR+JzGXfjC4w=
Received: from BN9PR03CA0416.namprd03.prod.outlook.com (2603:10b6:408:111::31)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 09:06:42 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::f8) by BN9PR03CA0416.outlook.office365.com
 (2603:10b6:408:111::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Tue, 25 Oct 2022 09:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 09:06:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 04:06:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 04:06:34 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 04:06:32 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Skip access GRBM_CNTL under SRIOV on gfx_v11
Date: Tue, 25 Oct 2022 17:05:48 +0800
Message-ID: <20221025090547.1571171-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaf7dc0-e864-4be9-2534-08dab6683b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuS178owCxILKS01sI2AqnwztQ8CW1U2bFaopEt+JKGi54H7iMLGFlpB8sLHbd3zAWnWPSeCqW7cteapsPU8hGNRCvRBO43NbEadmLViBAm+vZDoLzxT8rJaKPZo328lGlGjtJbGuoFjyly01AzVZ1Zhq6wc3dEjY61xe19qM/KGmdXcEzM4WvIeT70ZPf6y7yxDoCbV53PSm5emi+vDMVTUk6SZxeF27444fiRVkC4NZzzmRydr0KBZKIBU9Kq8TlF0NFdgjzKYD9bj5AtnUOAah89G+PMwti/+48Z0SweBqqVptj1EI/q8EyL9r2XCEuNonkgX71sSYwMELiqEbdtGoJyIrTesKIQcmNlabbXIl0mT4Ymw3elFg+Zi5sdzxDAU1YVA8m5EKbQqVXgNeo7/n6i4umJgs5ro5pjTiwXHkSYWnET2TJsWN3fJB9nDUhtLlzjSr/snQdf6ldfJPcb5nDs46xzKFPsIxsuFNtdEvFYKn6TS0beamUWik58o5cJ+P0/li1MEhgTq/wLILWWIptDjuAySdD4PyfwBbzMGPKPQ06GMmzjQpSX9pPwcz+P4WJGo4+zYAr8h3sEyyKWN9QJAcWeifKOSaUoqMNQrNNItjMHhaGaEbUq6XeLWQ20vbIoBa1q7tM+zOp9JNGH7qmtR2jh0QMDiEQs5sXX/yzzGj+7vqXfiCXdSMf63Bgp1MdGYxwhrbB7o7THVGWjIkmFQd2CzQrSxlO27xJlYs/oExI0EBfEZ+63MM0ExOfogpxk5JuVPDiwGPSSsOAlasXXEwGIq1LQ306q0rGWqvw6DOP6NiCg1Aff4aVgit6cYKPmPI/MjUkpRNSXSvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(6636002)(4744005)(8936002)(110136005)(54906003)(70586007)(8676002)(4326008)(70206006)(26005)(316002)(6666004)(41300700001)(36756003)(81166007)(82740400003)(356005)(82310400005)(47076005)(426003)(336012)(40480700001)(2906002)(40460700003)(36860700001)(2616005)(1076003)(83380400001)(86362001)(478600001)(186003)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 09:06:40.9383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaf7dc0-e864-4be9-2534-08dab6683b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
GRBM_CNTL is a PF_only register on gfx_v11.
RLCG interface will return "out of range" under SRIOV VF.

[How]
Skip access GRBM_CNTL under gfx_v11 SRIOV VF.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e3842dc100d6..1330768df0b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1626,7 +1626,8 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 	u32 tmp;
 	int i;
 
-	WREG32_FIELD15_PREREG(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_FIELD15_PREREG(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
 
 	gfx_v11_0_setup_rb(adev);
 	gfx_v11_0_get_cu_info(adev, &adev->gfx.cu_info);
-- 
2.25.1

