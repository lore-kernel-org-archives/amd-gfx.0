Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8165C64ED6
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 04:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40E810E477;
	Tue, 28 Feb 2023 04:43:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F9810E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 04:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsR/FOeD19c9tub7mUVWwcMYIOLIUD+bT/1AtGXCIOIcCJ3tdYBxxxSYr7EccCPUtcGIXFCXwZwBqJvohF0hU64DFeyOUiutVTdojbyuiZW1qoQ0DPSX61+ReBc0YM/s/dLmVMpb2asxUFiJMWU3nyUJzO3JSW0kUwX+zKRkXsukL82bRuMAzdOENRrIBepOt4G1IAte6/7wJgaeXnCOP6J/70MyrYjWeQPb5xljt3pBRHD762B4HwozcUQdbmTOdvh+FslqMai7BSWS1j5LdX4t0o0Y4XVsM8cT3uoYjXBpELhqnEXexT/+GQRQ5ybextpUpnm3bgXIQKNHJ0Vf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNFnZ+EarrA/VPG61dBoWygE/C6QWgRDU6Jtrq3ZWYA=;
 b=ijZRdadfsCLo4TuhTAfEnJuoKvKM2Jbg3kGGK5846v+AtsBcqq0rTTgkOtFePYb/i4tlggVyIpDT+dLkfEZw+zU3SmtGGmBqAAVIvIR3Gdtp5DVb7qTvvWlbjZiWlDbPX5Z0ppxak+7QvK7vhTa3Arb0C75elhpx65sgcgjeUX2r2+XFYskQoX6h9pzSaT2Y7rL/1nSHwFg0Pnx/WY9YlPQ+y0j4KEWKsKJNpq4MFW4qZBHRNV9Ad5jQIDDt/xqTbzPQOoGtG4CXhO/9bx6koS/O1CLKFUhuojXzIivMN1/k4sexClEK/ONIiBryZ9m8HfEQeZmWfbA/kweB6l7Q6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNFnZ+EarrA/VPG61dBoWygE/C6QWgRDU6Jtrq3ZWYA=;
 b=IOdNuI7UizkbdI3FilKJbJWArPSazLY/dYCaAF6j68O3/K+nt+PpO2TOCHxxIU8ZC6FlkLrVgGW1x22ovsfGS9So9MAAgK17CDOhYAA3dVRxz3Rr7GApuSvH8yZIT6euG1tHef+5zI1FAv88aEAurBfYG8UQnQr4ckKFLw3Pg7U=
Received: from BN9PR03CA0414.namprd03.prod.outlook.com (2603:10b6:408:111::29)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 04:43:29 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::93) by BN9PR03CA0414.outlook.office365.com
 (2603:10b6:408:111::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Tue, 28 Feb 2023 04:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.14 via Frontend Transport; Tue, 28 Feb 2023 04:43:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:43:24 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd: Add special handling for system s0ix state w/
 dGPUs
Date: Mon, 27 Feb 2023 22:43:04 -0600
Message-ID: <20230228044304.27940-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228044304.27940-1-mario.limonciello@amd.com>
References: <20230228044304.27940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f54655-51a4-4aba-c2d0-08db19465655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFHbV4GA21SGdqpK+DE9fYFOoHXL0OPn8FOv/l3CmQN4hcMFzze7Bye02lVTxKi+8ATde8dvfek5AthN3T0SR7t1g1y3btCIVJj6OOLFXsyK/zT505SmRyaAHI8muDiKId72UQt4QIVTk8QSdg/LqguA1RLwd0BPdl0UyJCX7D2ZzxHYfcflc2boTX2AZlcV/oU6XVIisZmh0poC0vNe+jySCpGXbrsbvl/X4VkHABhiDc5GXk5BQjXjjgTPP7Ng1sZ0UGjdvzPEUrEI26/IdOoRNvok8ZBtvjOk0kNFoaQ2+Toe7rtRMe9vxBSfT8o9L0GYnU3sNl5l623adNIoaG8TTsHTUhknPY7OIIH+rPI5zu14wSbw3ZpIDOdH1mxgdMnuHADIw86m1ENy6r3e4L27G1MpEfGZ80QJbjstyOpnZ1BmIbRG/6oYtAcB2nTIRxHV90iyUywUjEyZh1p/JCpXzT3oB2N27+CDV5VmnQWQs9CbQamagcpqerig/kjc86I59vLyOIckEsxNubZHZk5573zFkC0TtKuE5ZTpbWI8x2PCQ3Jpvp2T44JXY65EsYF/JIjjDmWCHlbd8UmQ3CXW8E4AFqFVyTQjrBux/lgN542r3zCY4ql5B7B9Lx/SV0WCmjx+h/sV7DQ9ts93utb96JHhOyDAGw1iAFDtfZQXLSTsY34tv4TEHZp2ll70n/gLCsBo2EYMV1cxbptUfOX9lMYNEeLADzpbGk8G4X5tOoc23TOFBiNWoItdj+M+3WGOJX7HbbRA4QPNgOj+Cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40480700001)(70206006)(8676002)(5660300002)(6916009)(4326008)(41300700001)(8936002)(2906002)(44832011)(356005)(82740400003)(81166007)(36860700001)(7696005)(6666004)(478600001)(316002)(54906003)(70586007)(82310400005)(83380400001)(47076005)(426003)(2616005)(40460700003)(16526019)(186003)(26005)(336012)(1076003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:43:28.9454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f54655-51a4-4aba-c2d0-08db19465655
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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
Cc: Peter Kopec <pekopec@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With dGPUs that support BACO or BOCO we want them to go into those
states when the system goes to s2idle.  Detect that the system will
be targeting this state and force the call into runtime suspend.

If the runtime suspend call fails for any reason, then fallback to
standard suspend flow.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * New patch
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 12 +++++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 711f2a1bf525..7c3c6380135a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1073,8 +1073,7 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
  */
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
-	if (!(adev->flags & AMD_IS_APU) ||
-	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
+	if (pm_suspend_target_state != PM_SUSPEND_TO_IDLE)
 		return false;
 
 	if (adev->asic_type < CHIP_RAVEN)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 750984517192..acc032c4c250 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2415,8 +2415,18 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	if (amdgpu_acpi_is_s0ix_active(adev))
+	if (amdgpu_acpi_is_s0ix_active(adev)) {
+		/* try to explicitly enter runtime suspend for s2idle on BACO/BOCO */
+		if (dev_pm_test_driver_flags(drm_dev->dev, DPM_FLAG_SMART_SUSPEND)) {
+			int ret;
+
+			ret = pm_runtime_suspend(dev);
+			if (!ret)
+				return 0;
+			DRM_WARN("failed to enter runtime suspend, running system suspend: %d\n", ret);
+		}
 		adev->in_s0ix = true;
+	}
 	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
 	if (!adev->in_s0ix && !adev->in_s3)
-- 
2.34.1

