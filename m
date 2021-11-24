Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF57C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 02:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E2189C59;
	Wed, 24 Nov 2021 02:43:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49B589BD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 02:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2UrJSprVaF7K4bDjw4BdES+fGLar+ghZizP0IdPNodzx/Tf8mhA8hj57/YQx2uXSgrKD8O5NJ3N3Ksr2Eyw5O+wxTrccrt4CE38EO27P1UhOhpJr3ha5N9A637Oq1eIzgBJIw3oT3SaN12Zh9Cdow0TK6UNBW8eN1XDsqkL+d876FbY6uVTFqbxPR9DWuHyFyMCk7FwrJ/G/1B3VnA70+9d3q/F6LbxA/1v/FpcLL+5FUi4tVtVCY6dySKxgU0M48dj04FCq5MggekhZyDLnbRFtk+10mdrxJY1VNFsWkwAJ9WT53YooaCMu9cpPyUFgw142e3MH8Fa5CH0YL3MUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfS+1HKlue6G4wc3dYVJwXI+QLg2x0DvEKYYK+I5YU0=;
 b=HvJO9qvt4b3tDQQYTspuAvR/ZtGAblrNlnwGNXgZc8ZhTRy4aUUGpBqbZu4ef7zWt6Q9wYjyqO2w+jVV5mypgsl7W4FhTQuVkgC46wD/ZzP/xkl5XEoXtQMhu3dS9q7usERMCn3YR1Ghi8c8zOOtal4c+dgTQrXvYdK17Ui4tVwIcfnuOeI9d7rSfgvqU0ozpkcPf1nSgr4abaWWGCcjMduyB2Mw7NQqrsmPLrJriDsGTThGsUgSztiBUPGQwJ9ff0ExtOd2tgyvYZDMJmfEsDDNvdnSMtYM6brG3aZ4CcbaaB4Z4wPg8FAMzMwx2gpGnegsw7jIPn6LRS3spbpI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfS+1HKlue6G4wc3dYVJwXI+QLg2x0DvEKYYK+I5YU0=;
 b=ovH/mr2ZwGpCJiKXX3LqP3js6VdtaUwIfy1hcZ5R5BLbNV/w2IQM06YVTbPtXUlc/sYUcK5nxbzf8xVw4M6nSPL3MS+hxS5eAxFwoVueZyLNHU5ocTNVo/mmT3cUq3ULQacMAx5OnwdNbP2zbRhyTi1aqYaYYEVGRohcxgX/epo=
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by DM6PR12MB3947.namprd12.prod.outlook.com (2603:10b6:5:148::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 02:43:23 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::c5) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Wed, 24 Nov 2021 02:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 02:43:22 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 20:43:18 -0600
From: Flora Cui <flora.cui@amd.com>
To: <guchun.chen@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: check atomic flag to differeniate with legacy
 path
Date: Wed, 24 Nov 2021 10:43:02 +0800
Message-ID: <20211124024302.1493100-3-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211124024302.1493100-1-flora.cui@amd.com>
References: <20211124024302.1493100-1-flora.cui@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e74ae08c-cefb-4cc8-1879-08d9aef42ea0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3947:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39478580039A58E0D7505518FA619@DM6PR12MB3947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+OgZPCrZ6I5alcz4oLWTnIS0aopRzk6OKo9xImYwckoPd3KIHw10AYcJ/wZoPfftrfX+jdI457Kz0YffzTsWH739db0mEVEDu9mesUbRVjIH/c2SN3f4B4m/2x4v0TFueOkAdXrKluQLF8NN1hfZnskGVNK4DY2mykFxYcJ6tTeyP/LrnxCHyqNvShpw4ctz1Bmb4fmP2d8tPBYmhZaUZIiOP9uWT+9HEZmplRry0Mup31AH6YorAam4oAMZayOmjpvHoLeFzQucybBUk6xHMlXRCaQ4+UYFl+OBAWj0d91m/DvzhbToEjkAEnxBSEOIeq6A5HDTREIyZfITP+C/s/7+NoZYxrf6Gl0zBeWpZ/DjVVQOYnRxSv1auhgHytZtzlOJSwFu9vOayHCFYAto897ZOSJIdMUL05+B0QuE8ds82aBk347Lg19r7jlSC95slRY7l8ol668HQRHWCCQI/pMJxJtMD3CM7YbfHGVt8zdsSVrnxm2cKHy99MR2mo+oZF8rAfFmmeOZNvW5rPvrlgSRvGnyfxLulpu2gskr7U9r8ey2OPxbVO2GK9IpsyWNOjZmAfrBFe3Vq4Ls1laan+T8pzclP4kKfykGg0OUQesFWxoAkdKKR32Q0JSfBbQy7+oBTaXOVD21S1SIPvIejtkJNB41hb4HwdJhRsyXzdjX9VH3kwgi5/XhciohTZ4ukjX6AY2WC8mbBaMOiGsve27TeusZgddzQCxtqe119Dh1B8ICfYjFGu3aPqbPMp1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(4326008)(2616005)(81166007)(8676002)(47076005)(186003)(5660300002)(8936002)(7696005)(426003)(336012)(44832011)(36756003)(356005)(36860700001)(6666004)(316002)(70206006)(508600001)(2906002)(86362001)(110136005)(83380400001)(1076003)(82310400004)(6636002)(26005)(70586007)(54906003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 02:43:22.6623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74ae08c-cefb-4cc8-1879-08d9aef42ea0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
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
Cc: Alex Deucher <aleander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

since vkms support atomic KMS interface

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Acked-by: Alex Deucher <aleander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7d4115d52523..8e9e50aa4a95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3830,7 +3830,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
 	if (adev->mode_info.mode_config_initialized){
-		if (!amdgpu_device_has_dc_support(adev))
+		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
 			drm_helper_force_disable_all(adev_to_drm(adev));
 		else
 			drm_atomic_helper_shutdown(adev_to_drm(adev));
@@ -5124,7 +5124,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
 		}
 
-		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) {
+		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled) {
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 		}
 
-- 
2.25.1

