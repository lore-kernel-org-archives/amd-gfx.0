Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550BCC77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D0610E33A;
	Thu, 30 Mar 2023 19:27:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1034C10E3BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdWxqWvQ5IR5x5/NjQNdtSrT6FrskOpom/c6tvL9O2i6CoSRT2atNHzKy+0BW0Bhp7Ns3zc6ANG9cUBgnYgob+Wg6IRDaRO/yAXhP6/PDSJjE9ZI3L9sm2ZPRDNFbupdUhueyo5aM53wy8fd4igrZ2MeBavnp6UBBqLj2iwNnTN0IwwUcu6DIZVza9flTvvB+sw0Cjc4AvEKDd112w5ju3fw49h+hh3CbJ/wbQm5Ihce6opXNQKk4sWF5g6DvmcDOuT++Vda48eLc2R8FDR0g9xGp630YEcY4nmqVggGE7/9eVs5YYB60XsIIx4xey7ejb5qshr4q2FApolmpT46UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf0I7WNPqLAWXwZnAfMuMTfHKKDsVTPrt6fYJIHM6fo=;
 b=DoH2Wozn3F4A23NYR2D+gpv78FQgRIjLaXU/uT8FYnpaEgmwVTEIY1cUDoSZNE9xv2iKfNiRFbOU4L8IAIO+xaq8gfXSz8MXnB9YoERyLiq+x0eHrgpgKYwlIrQYMJk/7omWai0AyZegE3Tw0v6NVewj143fsFSFUrSrsY4QgR9aCu6Vw2UWC7nq4bmw+er3/MbOzs19TVwdI01jRJAGziIAXErqi6JLHgEesqC80tV5Qm6Ub8zj90fr6QKflDjQWQ+3Dh4sJ1TXDB2xY9WZcr+80JKqIHi+ofSono4/gYQFjTkQU2aWNrPUhiP36mruBtwmFTRHA73hTv9zxAbUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf0I7WNPqLAWXwZnAfMuMTfHKKDsVTPrt6fYJIHM6fo=;
 b=BYRZQSX2EbUiUv9f2OiCYLg1wtKj5hzbCZfsmcgnelVs6m2JqPAd7BaLErlJTlT+c9/XECIOIkeRXZikbjnq1e/v1L2XupLrBkTztgwakwpGS1ICySf8uRdQm+LASL3/v5dYdYT6TgmX7520fmxbCZyYMg9HGn9KcKbGJwRJSqU=
Received: from BN8PR12CA0034.namprd12.prod.outlook.com (2603:10b6:408:60::47)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:27:14 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::db) by BN8PR12CA0034.outlook.office365.com
 (2603:10b6:408:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/9] drm/amdgpu: remove partition attributes sys file for
 gfx_v9_4_3
Date: Thu, 30 Mar 2023 15:26:54 -0400
Message-ID: <20230330192657.1134433-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330192657.1134433-1-alexander.deucher@amd.com>
References: <20230330192657.1134433-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: f22319ee-9fe9-46be-d11c-08db3154c423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kOmyK8nrUNgGfC1+Q/Ik92CL9ZrAOfIN4mkHM+0AbrjXhfFYyJHMI4wML3Wm3McID530fQdrF2OY1V6QehIbjvSyNbQV0n9LrBfvAt0SLhvO5Y0qky1SCL9sZHDodPjpyGDLVAvD+a/5WGr545BkJdyA2eJY/SXvx0uxZ+ioNX9D1LUjiBwy9QSP7A5LJfi3rxPXRgf1iZrpgEKVQvEAAfgAi/k5XihHGkXwHHyAVia2/f8uDavD0lBCs8dujTxZc4Eqekyo+recwDEJpWBUZlCZX23DoY++lm54GvMXN8yA3ViGAOWsxUXkwqF0dDLYdXeTj4NUK3FdgBLluyPTIi7bRUU0TMH1VJaxXvasMUm6WLEQx7RDU4fMzaVYrcXXHXFYiSzCPjazFCNK00ywE2jx8q4aQYsJyW0GF/M6s3Ph7NTVSanebGsgv8titqJjuGYtg7mPafTVqK+N5Nsm0E6TkeAFkfxzhUH8BCKntnszQoFhsCVlkLOhlk95UwBWXYey7EbpXUEY9VK3bND04pSrpeFOI3oq3vSTZOdeZ8Zxj7083RBOgF1Kw5Ecjcp+26QK8wiSQScCy2/KRVbIV5yS1vVnHEv4Rjf7CtiNO3py+pKuR6uZ84eo6g6gz3MKk0qrzHDIauCWYc89YbaA6EmidGBekg0hyyWmzIBz/u+0BVFh/+IPdQm4rdl+JTnoaLePlx4jScWLijRTEWK77PBvZMfYdiK7sURTnFsyQQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(8936002)(41300700001)(5660300002)(70586007)(8676002)(70206006)(6916009)(4326008)(40460700003)(81166007)(316002)(82310400005)(478600001)(7696005)(54906003)(40480700001)(36756003)(426003)(2616005)(336012)(47076005)(26005)(186003)(16526019)(1076003)(36860700001)(356005)(6666004)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:14.0283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22319ee-9fe9-46be-d11c-08db3154c423
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

For driver de-init like rmmod operations those partition specific
attributes need to be removed accordingly.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f14de1c579e6..7d036a94a557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1267,3 +1267,10 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+{
+	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
+	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
+	device_remove_file(adev->dev, &dev_attr_current_memory_partition);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 0b4057753a4b..e48be6031c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -488,4 +488,5 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8d1f7d995830..4450377adfa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -900,6 +900,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 	gfx_v9_4_3_mec_fini(adev);
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
+	amdgpu_gfx_sysfs_fini(adev);
 
 	return 0;
 }
-- 
2.39.2

