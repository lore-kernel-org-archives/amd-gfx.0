Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAC5C47DDB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 08:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB5010E41B;
	Tue, 23 Jan 2024 08:09:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1149810E41B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 08:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf9B4xPfXu6Bk5MnA9GIqxQmLsEXMT46/zAsh9vUghuJo9n5eVROdGaYyHNBhm57X5oB8YzIEhEPZ+Ih8zFxGWGciH8oaWHAVTef6WIzF/HOuacE8cJ2JqYslNXgTYe07ID3evO2Zbyso8smYu4d8VN2mGGiZLcPr4rgTrWi/02KhqyuNDsC6O71geqGGf0ZU4b2oqDnB7l77CsHb/4M5BiYqeYTHSJxuxjXral0Gj9s7K5t/HqGTajDwKTQPxV/c7AYFXERc7oX4h6t+N4jSRoBHSZ0DoflS68mSmgqCO5DX80gZJzW9WYXyu6wmnvnSiV8WqtMItdtXzdQ9S0pLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vqZWCj1k5CKeW7wH8dB1/PhzAGxFK93+88U17BUxL8=;
 b=S7ZRhP4fDvOGI9kzreK9FoYg1oTvyWwIuQpEiOds1uftSowry50uN6E6hQccOtGDfu0VbtjYolMpeoqQgyXcYJivJb81XPUJH9ngM3dw9CGF5g9F5qOGY5eWok/OnM5H5xRV1swp0HfpnI1T9IzgOo+P0bfnL0BJuw7y1S7kbSktHSWMiEh+CZ+HWpkQn45bKiz190/k0ODmmmX02T3rtcEexQPuhthDmpJ52lBTW9eif4NdCMCdxy0lpwH5vankMnMyGUKz1HAhS4ejDGRTiE/X28xPQ5/JwPgvMoVRgBEqHP8T2WeCJBflcpEMDu29dxVSNlGxLbUnKBFp/6DV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vqZWCj1k5CKeW7wH8dB1/PhzAGxFK93+88U17BUxL8=;
 b=sRJtmI7MEK2uYoUw7xgxrIBYDQXZEkyUpSTHoFujNsXEIsy6g9GPKwcUA/DjBKUmYB/mVWaL2uUqTKXk4L21hUEelB/DMZkqoeqyRRjokI3MxY9haTsmVqvVYZNJh+Hi9qhiJ79kaTGxWX1hXsloyC0t1UxNAjMN3GYr8HrCzBs=
Received: from DM6PR07CA0071.namprd07.prod.outlook.com (2603:10b6:5:74::48) by
 MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.26; Tue, 23 Jan 2024 08:09:27 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::33) by DM6PR07CA0071.outlook.office365.com
 (2603:10b6:5:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 08:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 08:09:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 23 Jan 2024 02:09:19 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix 'adev->gfx.rlc_fw' from request_firmware()
 not released in 'gfx_v10_0_init_microcode()'
Date: Tue, 23 Jan 2024 13:38:41 +0530
Message-ID: <20240123080841.387004-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MW3PR12MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddbbd20-b311-4fea-29f7-08dc1bea9e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKBgflyy01p6ePDS7omDVB0Q5SmyX7oPKiKVcGUrUkwMJ6QApsRjaAZf5kP8XfrY8xi4cbTVnG41Oy9GkeNYT81rLu/qieF/B52OqKmywHk4gUKsQHg2pDEcKQrNztbjYVreEb98glJ0I7exUzrHENh4jZ5XH51LjMaG6mjPpwFnWwQjchi8U2lHP94Y3EGdGOIoEm0CRjsCjC6VNQL/EMOOm39QwownzcGNqGwXQF3GwCAK/rfdxSSnpnfBUpKerMb+ckE2wL4DdYfMHw5gFCnm3Bw6wRWkF1Yzl4mdB1rOmkzgt79u/+6jQTNF9ibSeFPLMPOAquTcDnqpeCqhSjl+1jsMqdM1Ng6Uhz8a1wtVczNEpW1AzRIdIwQkKPciYPDwSIP75q3Wt000XqPwFK8GTMYuOFxbilOlgEu0Ldy7SM24rvRRJ7PmfdrubQnhfH5dWJAnd2jud/sJpWzBtYnAtKMhbecl8fIPqqvpUytXHULLaHD2Y6dniqTkat3UxRaGy8uN8Dcx5LomZg+96ERnSni01oQ6JjX+U+mldk5U8gUe3BRzWBPstaNOa7Bw963bAZzca9TEonfrtN8QRtQLSXj5J3A/kUfqWHtE4S3on/m4EPXHk5KdL2krLjfoEL9FT04NpQp3epaGbZhBH3AavtSv7BBJYQVp59Enq6YsC9Z8N9pSxBHRmJkoYlBoQD3byoXWKTe4WCRoNurbZdhV0jl93gkzz7aPOhkPoGnIVIXEnxKYLejXEope1A1YBvfcKAVDsvntHZ/o2AFYXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(26005)(83380400001)(2616005)(44832011)(66574015)(1076003)(336012)(82740400003)(47076005)(4326008)(7696005)(316002)(2906002)(5660300002)(6666004)(54906003)(426003)(8936002)(36860700001)(6636002)(478600001)(8676002)(81166007)(16526019)(70206006)(41300700001)(36756003)(110136005)(86362001)(70586007)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 08:09:27.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddbbd20-b311-4fea-29f7-08dc1bea9e46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'adev->gfx.rlc_fw' may not be released before end of
gfx_v10_0_init_microcode() function.

Using the function release_firmware() to release adev->gfx.rlc_fw.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4046 gfx_v10_0_init_microcode() warn: 'adev->gfx.rlc_fw' from request_firmware() not released on lines: 4046.

Fixes: 1797ec7ffd1b ("drm/amdgpu: skip rlc ucode loading for SRIOV gfx10")
Cc: Monk Liu <Monk.Liu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 420c82b54650..ce76fbcc2602 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4006,6 +4006,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 		version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 		version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
+		release_firmware(adev->gfx.rlc_fw);
 		err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
 		if (err)
 			goto out;
-- 
2.34.1

