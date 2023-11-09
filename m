Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283C2C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 22:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0D510E403;
	Thu,  9 Nov 2023 22:14:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0EA10E403
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 22:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzXr+DJS0MGiD28QpAchnzy373GSaJjorWse8Ru4K0q944evX5YZvtUIbfMf/jR/UbAhsAr5ocW6gkfJrv6i0S5B7s1Cpf+parOGnZW9ehYVc64g948O00acJMsEcmgqtNaaqnF8KPvMePTXfkxPBzICVgGOIvPZ26riXVjpC8djkbp6nXTdmutNVYMKCfqjdvZowgNW7UyJGMQE4Tz5NWvb51liva19j7hPOpGaqwaY1szyI5W+Yv9W+IdlRBpUVALy8PJYlEd+23KSJEHGRkxNQuaOvon+8N2v8+CNEQ07RRAYsL+JDukQMZHMUeb8zs4M0DTeyOO1GTyemQtCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=If+dDjZz2j4pGR2KR75FMRyd1HrHemL2abefxXmLinU=;
 b=iReMOhvY8b7XjzT+njWgyaDlhuPyGlynovvAiu9kc9aIPbTAiKGbO8fqFyQLBO3z5UmNmtmInrMWcHuLN4CVhGHS/XO62jR7KnXs1fiqInkmZgiPy9LVSlQBptoi7ixtSnhyG1sLshN4g+eu9SGSXV7ZmfO23O5NKbVIm5MZ5RnZdjRRiNTHPeZMgl+VVl3FNbMevKgiz+hFPL+N5zjMc5DklZLj9p61HU5t2y9T5Wd78JpS7vW/pdcUN/8Qeb7fGNRRhGNYEtOShKLN2yjPhGPxRX8+qrl2dfkEE4DH7uqce/tVq5DTVK4VAtLy+PLBFSHKwrLc22Z8H9CbLL+mSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If+dDjZz2j4pGR2KR75FMRyd1HrHemL2abefxXmLinU=;
 b=bzzcpsceZ7t44gPLc7JM/tBuhNCeciAzIiSZlGke6+lVjz0HYUA0TE2V2P/wB4wiilAPQ3kV2Qu7TDmDYhII0SwZfOCvu3y7AJstnBXFp0I476REtE1xddgWqH0KMfGrHPVMPe3sv4maJa+E17zS7aBjyVtNqt1//3SFwW/N5aU=
Received: from CH0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:610:b0::21)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 22:14:15 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::da) by CH0PR03CA0016.outlook.office365.com
 (2603:10b6:610:b0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 22:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 22:14:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 16:14:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: fall back to INPUT power for AVG power via
 INFO IOCTL
Date: Thu, 9 Nov 2023 17:13:59 -0500
Message-ID: <20231109221400.936847-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109221400.936847-1-alexander.deucher@amd.com>
References: <20231109221400.936847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BN9PR12MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 804f2929-ffe0-4d09-a05d-08dbe1713611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjw0l+PKgeeJT7AORt9OfAQ2Ni2Kki3suTr5KEbcZtxmvf7A2nHYfsjMh5G41zGRgaNgc7DIBE2t58boSoPectC4gYMxaQA7dyC9FbVN1LDOhJCYyJ6STFIO9nHun/8LwIz08f6bmrKCvZrlZDeUU9ji3XUdSeTilyy12QvVR2MIk2Ww7g/BhannALpTXIts/dthUkN/4oLPcFkW+32+FyEVyYYiybny6g4GQfOkZR82QCVNzZDdxELISyV0B/AC9zUw+vJuKMKjzG6uTfF/xL2vkNBnKPj2Y4XXoUJeiTWAjN/I0Xz8DLUK9Rh4AIMMUZfgLr1tryhrwSBej7obvGbxEAtZmkNdp7p7NCG14BAIvT9n9BZmPgzRtzmMc96MKWWK8iv67WGXOiGzXj47N9Fqk2dfQcca5x9YToLxxpyDu+HH+dWzhQf3UOXLQ7e7PY6Ptf5IZ82jDO4IHc21GOyzXquPtlbWuvzzXqw9PodAdDvQFmnfVoI1bLbtE3jAX5hiAbL56sOfgTE0k8ma185fZKG6vtbOBd2K+BJmSi2AZ17pYZJaL5ZwfkxU/k1uui00tONYV8PXI871Fgo/yjvSYgNTlTY2m0GueXtWVXE38+OQlpXR+NAFwQJiY44POzm36abRdTKEhdLjX4Q19w5oYQv4XS572TGpn/kxvyfCuFyy0RRLY2D5frHWDjL7id+IXdnSDUthh3TNpp1vYyxk8sL0TgHmSPWVVm+/6GTUSFB8JwUasNI23C+mMoat
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(4744005)(2906002)(426003)(5660300002)(2616005)(41300700001)(4326008)(316002)(6916009)(70586007)(8936002)(36860700001)(8676002)(356005)(81166007)(47076005)(82740400003)(16526019)(336012)(1076003)(70206006)(26005)(966005)(83380400001)(86362001)(478600001)(36756003)(40480700001)(40460700003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 22:14:15.6954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 804f2929-ffe0-4d09-a05d-08dbe1713611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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

For backwards compatibility with userspace.

Fixes: 47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2897
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b5ebafd4a3ad..bf4f48fe438d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1105,7 +1105,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			if (amdgpu_dpm_read_sensor(adev,
 						   AMDGPU_PP_SENSOR_GPU_AVG_POWER,
 						   (void *)&ui32, &ui32_size)) {
-				return -EINVAL;
+				/* fall back to input power for backwards compat */
+				if (amdgpu_dpm_read_sensor(adev,
+							   AMDGPU_PP_SENSOR_GPU_INPUT_POWER,
+							   (void *)&ui32, &ui32_size)) {
+					return -EINVAL;
+				}
 			}
 			ui32 >>= 8;
 			break;
-- 
2.41.0

