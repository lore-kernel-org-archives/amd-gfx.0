Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EB4C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 14:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54F210E608;
	Thu,  8 Sep 2022 14:39:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CDD10E647
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 14:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+vv3p6MmHH2EVVdapVYyTYMvHsvZfiYA5ibkUPod1eRy3SD4vSQL8XAXRceR0XspXVXKolrZrOLNZRMXGeayHlL9dsRWtCOEdAZmlg6TnjCQaVIVBCmbRC/PdKZeFTQrcSuEirALIPC6DoORavFNanBIqhtmhnatKo/9N4wpTEcA4fD9PaHOhxNhJnCAqStFDzeY1FYoJNipAUn/k8Q6g2Tux1gI6n2NqLnIaEm+rlBs7nV/0q1GD7zf7pMuiMUNUOP0S53Xs6H+XnzK0lEjIOGQl3mhOaRyvVsmsVH3Fb0d34eRJ2BcQ84eeDlsp2qw/SN7jcXrLuaVDEHu2QfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oavR01a4x19Vv5Okf6mBoWIbQxIJmXnvkLeppEn1uQ=;
 b=KDwytEY2CHrRlxeEtauUEd+dWdb2/KdDiGpO4XakQj70VXVIq8zNQYIUkvUtJv6HZGHR1RQxi/dWcR2EU3O1ANYlEzwPbVpcjcpOYZbyGDCrJ6y7Cuy6TOLRNpbaIONsLTmCJiJRRGUngaePCKAI1YyZFx7MDSPz5YfvsVYa2Ay3H/lGs/7OjGlNo+oJBHHillFfypErbWW719GNwWSuROMge0SKCCggTmP0KETALYIE5sgW5xndExGTiqZt06tyTCvaG6mAj5jHsrwjJxL5gWz1N66eeluUC7bfnY2cDT466xfZWJlYS6SxQ/spr41V8fmaaSvne5wDNQqspnrb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oavR01a4x19Vv5Okf6mBoWIbQxIJmXnvkLeppEn1uQ=;
 b=OyNvy3hmPuCE253EQ/pUzlcKH45nLTUO0vfpRfPF1jNmMdAOiNA0Hv2eeJD3CozEQd8kN4tfNFtblpSA1mfuhqh5MbGZRkXLUNjM4lzXW5gwMi8qhi1S8qt6WiBNCjKKqQGrsLYeBo088SqbtQKvGdljAcnVn+VJ/jnHAUBgYp4=
Received: from BL1PR13CA0101.namprd13.prod.outlook.com (2603:10b6:208:2b9::16)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 14:38:58 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::40) by BL1PR13CA0101.outlook.office365.com
 (2603:10b6:208:2b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Thu, 8 Sep 2022 14:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Thu, 8 Sep 2022 14:38:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 09:38:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: use proper DC check in
 amdgpu_display_supported_domains()
Date: Thu, 8 Sep 2022 10:38:05 -0400
Message-ID: <20220908143808.53981-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cf92b7-b7b7-49e3-27bd-08da91a7dce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlWIePtTzKXUwd5EHm5tnvMe+ZfaiT+haNkyC+LWxd3gPIplR4JXSMA8ozdRijZGflrxPx5y9O4KF4IM0eRW6KHxROphG9IqTP/ZOen7UecvmfzUkYZPIgTqKZXY6Pf7bvSthNhXyVEnPqtmWZtl58kZYEG6JOCE2V1mYLWGhbTEQd6rw1POzUlMY7gJdMSLOg2LI05jOrXov4yE7qi6mrBgO4RRx5zQXqs5b/P21mEj+f3D89jfNzkZHafDVytQODZOAKZKF1aZwI/U9LK1MxhopZX9dUSwnZLO+8tMFJRHM7n45UO8VAH+pS4tfbHdk2hIJH5xAYZ0iaqAd5z9xWtnR4JB87pecGvOHnKfApXv/qh23rSYfnZj7GSxMVZEEzInjtu/6Jkr52VeO82qdvGUJj9+ABbYXvgMSgfLKqaM9uqs27ISoff1xxtkji9alB0udBo9dC4DrkT9Cues/2OoMBkZ/64O2RjGgzsP+WGGoOARmjtCuA56KMgu04nrLdX0FwtkOQX7vzo5un8pqwg/R1Pl+GcCCt/e00H1D9m3d0ApSUP1afqXvNiJBirursLDXeJt8usZocDPSLeN7wpKmmkMcvmv5VyUrUs4kIBOIUmg3JBH4trn3EKLQRdl+HX5sve2Smdf+/4RPnfliDADH4USzI6EczthYGkZdAQY6wvut7CKp5PIBKWkh8vOTAp++voRn6GSrEnb2CV4Po7xkii+mHqRFKLlwUjmzc5Bgjfdvub+mNCJvP5Qy45AX7x9+zIkl8nqxim11j7i02fQFAlnAwam0PW5uGmsqR0khKAFYi+/HVL2eJlsj7AZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(40470700004)(36840700001)(82310400005)(82740400003)(478600001)(26005)(86362001)(41300700001)(7696005)(6666004)(2616005)(81166007)(40480700001)(16526019)(336012)(356005)(1076003)(83380400001)(186003)(5660300002)(70206006)(36860700001)(47076005)(40460700003)(36756003)(4326008)(8936002)(426003)(6916009)(2906002)(70586007)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 14:38:57.4465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cf92b7-b7b7-49e3-27bd-08da91a7dce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

amdgpu_device_asic_has_dc_support() just checks the asic itself.
amdgpu_device_has_dc_support() is a runtime check which not
only checks the asic, but also other things in the driver
like whether virtual display is enabled.  We want the latter
here.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index c20922a5af9f..b0fa5d065d50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -514,7 +514,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type) &&
+	    amdgpu_device_has_dc_support(adev) &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
-- 
2.37.2

