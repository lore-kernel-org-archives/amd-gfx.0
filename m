Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD8CCDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 19:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AF810E63A;
	Fri, 13 Oct 2023 19:26:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0583A10E638
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 19:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4jaFt5DNwUgLTcsa35oI48UeCEI6t+StzUAvCWM34QEG2XX9nDaYNO8S6kuiDyp8rBjFVaWNP9kOkOs1TQW0a5tpbt+5Q9FawpPevuUv+igVSXS+t47QCtAumY3THSsMI407q6STyHLGLG9W3bq3XK+WdxQY5bw6TxmJqhz3W++AVsnx1Xkz3s90I5Au3sLhXAfxFV1z9Pl+i0BbZ8qQz5X45V+om0Zr2DwzfxAIdD/YOeGrIBKXghKl4dn599jwZEjQoYIVYgBaHKCpDcezIDT8+djm5XK3FgrDtMGNBdfc7uqy9lPGO+2pwLddhRbGj3aAhPBRzdEqlwHWvFmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9PaDEK5YklbjZp9bV70byBOXnXxIQXA2fvRqO1GKkI=;
 b=Sa0j0W+4Y5ScIv/dMpzsAnvHqhlN40nQJMSENRRTpyF+zxJZsrpH3qSPlrNUE4SwOWjOQddcAqZzEVw8r3D8VNhJBwJh76qgieS8+32KwpSGIubMjNZxOGxxU+2V3LI4LbzN6o4TMjlpJYCv7Mzzke/IEveIhhH1zu1JYyCjL6+jwGuKpmHtUOd0bWuCMUR7z1+amZIefYN3UE1S9KEZdLPzT7hfhA5V75yigKJWNiif4WxYDlT7uqbZ8LvrFZeCpkEfeOmOByhvA+rOtFhZMTAlgDVmQRa1GhBAyaHYRKPsNdPZ6WgAQ2Io5+w5pBK0k4N9j30vUNo53af0/vU3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9PaDEK5YklbjZp9bV70byBOXnXxIQXA2fvRqO1GKkI=;
 b=nG79s985uATe0AxJa7CiEXST/Mrrd1yHeeD3QGqF8/mnQB48U3chsVoelWhGJA1TNkXGO6Fvd9E0v3dHu4BomvHgQOkTtZrR5E6oEjPF9Il+B97kUYt//b3+4kfi4PpQ+xIpdQn5ZJEh6OR9wpRDbrBOnYqJaxdNM/Z+QvFdVPw=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Fri, 13 Oct
 2023 19:26:39 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::82) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 19:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 19:26:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 14:26:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Don't parse IMU ucode version if it won't be
 loaded
Date: Fri, 13 Oct 2023 14:26:03 -0500
Message-ID: <20231013192604.200515-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013192604.200515-1-mario.limonciello@amd.com>
References: <20231013192604.200515-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CO6PR12MB5441:EE_
X-MS-Office365-Filtering-Correlation-Id: 236df64b-1681-487e-e31a-08dbcc2252a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdZOwcOiShMnGD8Fs7ktEUPN0tZHbRA9iKsZjCmq1/GIEGklMn80kbbCvhClD9DqtDhkSFCUipFxvmmc6o10JJSEdFPH/4s+CNcyXPTrtWZ6UBkNlIN3MAImEmcvTByl3TQ0PZSshsuoT6R0K08wWMAyGvDQDlXqjX6L7LZKwV1y1GayPrzp2qCW9a0QT/fQH/Yzm30oa0KX26kla37njh4gUttxKWgPqbYj7pftXtLJRJ1KVxMp4OrePQpKzxYDDC/GWoVcprp5TLB4Ihd8SiMN28FQJSEzdo2wHqYKliLACyDAhP37qy14ZUEd4H2D2/jJ1ofyGnnlovJ/DvYZT/X5ePwKiW3ftepjLF8SZsW2fucmETu0OfVB3nRyW7jh3mWKsC8USbme0hq/kDsPPtmilQS0D6py6UZ7V6cWU/ymQrX5JJsOK9CJ7j4/1sIqSPdNJt50AKjMTYo5uqxvPpaOWcjQ/AwSfxhhFknxXwniKcxnLY6UaU6sldUE2AIXyh6VTSeg6fB3YPPntpYUXXp4hK9IZjbihvnzRAANREn24uQ3pDEEnxTFkiYcPQaBzEo9uqqEIvoo4zIeMsDEXa1bOPtE2wh/b5Izw4Blh1CpkMgUO39jEfaGIFmIGWdICKne2rFAbtmuQQEjzMjaX/N6lxt6IvvOkf+Smo/Uj82RZwSNeKO+sQ+L/uW7/PpuCzjnYPZlWq8tjwWcX4mHCFllg92xigfGjrYnfZ0j9gPC6GXACt0v6hiGs6pwJfUzP1obfinJz8FK3OZkqUK0BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(86362001)(36756003)(44832011)(40480700001)(2906002)(5660300002)(7696005)(6666004)(4326008)(41300700001)(70586007)(8676002)(478600001)(8936002)(70206006)(83380400001)(426003)(336012)(2616005)(1076003)(40460700003)(6916009)(316002)(47076005)(26005)(16526019)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 19:26:38.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 236df64b-1681-487e-e31a-08dbcc2252a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the IMU ucode is loaded by the PSP parsing the version that comes from
Linux will vary. Rather than showing the wrong data to kernel interface
consumers, avoid populating it in this case.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 875fb5ac70b5..c0bdab3bf0e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -55,7 +55,6 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 	if (err)
 		goto out;
 	imu_hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
-	adev->gfx.imu_fw_version = le32_to_cpu(imu_hdr->header.ucode_version);
 	//adev->gfx.imu_feature_version = le32_to_cpu(imu_hdr->ucode_feature_version);
 	
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
@@ -69,7 +68,8 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 		info->fw = adev->gfx.imu_fw;
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(imu_hdr->imu_dram_ucode_size_bytes), PAGE_SIZE);
-	}
+	} else
+		adev->gfx.imu_fw_version = le32_to_cpu(imu_hdr->header.ucode_version);
 
 out:
 	if (err) {
-- 
2.34.1

