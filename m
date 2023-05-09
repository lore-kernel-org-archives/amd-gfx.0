Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31247C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 09:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B6110E35E;
	Tue,  9 May 2023 09:16:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B89710E35E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 09:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPhtgKITGKvQ3zZY16gJBblfun8kCSt8crueh6bz9hXgTs4jhGa3xVzagGsbJNFHvkLTG5CE+6vl0u3Ie8yWCeZH6egr+0Wyfo+uPEd/iO9hHO48Gq3Pj07ZIcfelGPIHWh+xQ+Hh0HVjcMiAk+IIEPfg++kfAohTbNZ4LcGm8KVcNWMrN1lFwU8rnSbS9pW/3FCSfj7M64YgOfGuvM9FGQXS1EY8FcHyOA8DqLRp6znnp82JkGJl2HKtxTgiF6w1UWyj3Y9OQjhc6urbFTIzq/uBurONh7FBMpgH2ZqVUCsV9jh2vB0Q5v8VkDG6SQbxlcKnjf0ee23KnOexvoVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLuzTr1yNdlhXFEhgToLs0W/Q2qkMEGt40pAdjXtSGU=;
 b=dkUB8MlRKv9RhdeqlrJnNoVyuSW+aH/jrVSmB3bDUGK8EFz8L5+1puL/jqBKohN9COdNx8+oJ1D148akk0cZVS0+/3uVI7c4AZ+YbF03HMPj33J9TH7CljJHP/HSbFvOxGUNgPK7gwfRFVJ3BkOQEOCkQ7Na25FmrJUDj9X+x4XzoATHWfNuiStllaiMxQs1hT5YRdUuc7iSDl2InNGapPkSQoWb6SDbSy3jYXgjovwd837O6BB4qW+9JMgMXAkx3G1dCfqoG8u44Fz24+OYm0ssq9ZRvDYV2z5OMWMOQy7tNtqyR8zHRSzPunCd3FnHWPBSWHdECDonmLEH7lYvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLuzTr1yNdlhXFEhgToLs0W/Q2qkMEGt40pAdjXtSGU=;
 b=HyW4kIgT3tdNGIjIx0FK7i+/Gic0FK2dDp2HDjbRL38U2alyTK+bni6GvPULh8mOcCS0eHcBSmsHRQTQLGiM6WCgvFkF3MprbEHVSo5xj38lW4/g1jP6JKunF73ter+eOeAlfVOLCQdE8wu4JdPOzfDpc4H+qCHzMlT6vGL2exA=
Received: from BN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:408:ee::8)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 09:16:42 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::f0) by BN0PR04CA0003.outlook.office365.com
 (2603:10b6:408:ee::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 09:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 09:16:42 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 04:16:39 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove IMU ucode in vf2pf
Date: Tue, 9 May 2023 17:16:16 +0800
Message-ID: <20230509091616.958180-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d186691-cd39-411a-6e93-08db506e1a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: minv84+m0+dw/dAd/LC/T4CxluKN2NWpY9wKsLdir81XrBtLASt50LgNVNw4KYCGJHsdT/dTYVkZAeROrzTYP0kuWsPQYW8qf2uaWyVQh3A+YmJW3YLnCvSfeUDeQ7eZpJIGgv/c4HrUwtrN/7JrlWrAuWl5Qsz8J+m1e31IpuE3EVMwO7afZnXut9bgscS7pNGWe/GhduvI/9bdFHkSTc51jRpJ05BuUau5WtSwmGrHKY7kC7deBBFf+/TQaJ2/oQIOu4gD5/L+yEHfCxpHdNhfvoaEEQH0Ay45F5uJau/iWSlnmh85ToeuaWYmXp+dQl0s2L6bCgYii5cQabL/RkmKwHPkpT0b37CkEBFu6F+bT8WuFRBvPAN+w9jBtjNHtxk6BpfOq3cYRUURoAMYiNTwi7M8fFZvqnIXHD2hROOR/LiFu/aWZUMgu4Z9qdBnbjm6BuSGixUkQRjy3UaXNHUhHnS0hQ5gpFaxccYbSrgUxRShqFEvtXd0UhUXYQQfQaRgSVYC8w38hlkGptJ9AFdF34m2kgvsIzCfyXYP+WlcSQoclocCEP87R1Sgbmrv09HQdRll3+o285Ts0Xwnn9qVu6JS6LVM2lYCsg5TYgDMLWDml1O88R+snYdCmQIwHDFrpAAFY3hZoR13Ewy1188G8m3Fe8sSpOSnN/2HSlXDUiZtu6n1M0HQpJNbFx460rcFAWmyv7FR+b1YDXDEk/0HEg3MnifuAwkLtAajhBM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(40460700003)(6916009)(2906002)(316002)(5660300002)(40480700001)(8936002)(86362001)(8676002)(81166007)(70586007)(70206006)(356005)(41300700001)(4326008)(82740400003)(426003)(47076005)(336012)(83380400001)(186003)(26005)(16526019)(1076003)(478600001)(7696005)(6666004)(2616005)(82310400005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 09:16:42.1765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d186691-cd39-411a-6e93-08db506e1a5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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
Cc: ZhenGuo.Yin@amd.com, Horace.Chen@amd.com, YuanShang <YuanShang.Mao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The IMU firmware is loaded on the host side, not the guest.
Remove IMU in vf2pf ucode id enum.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 1311e42ab8e9..0af871735a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -557,7 +557,6 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.mec_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
-	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_IMU,      adev->gfx.imu_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.sos.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
 			    adev->psp.asd_context.bin_desc.fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 24d42d24e6a0..104a5ad8397d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -70,7 +70,6 @@ enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID_RLC_SRLS,
 	AMD_SRIOV_UCODE_ID_MEC,
 	AMD_SRIOV_UCODE_ID_MEC2,
-	AMD_SRIOV_UCODE_ID_IMU,
 	AMD_SRIOV_UCODE_ID_SOS,
 	AMD_SRIOV_UCODE_ID_ASD,
 	AMD_SRIOV_UCODE_ID_TA_RAS,
-- 
2.25.1

