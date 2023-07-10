Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DBCEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 22:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA75B10E0F7;
	Mon, 10 Jul 2023 22:09:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0AB10E0F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 22:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVfgcX2iEzXIe/DmI9V1r82pc6CXx3G1bNRtdTk7t/OR6g3qiSpZyPDtKG/5O6CBEPF4Zi6uKmGXqIE6EFpjBloIaf8aKp4D0lW90cjhA6I2wQw4Sdru7rZWbVNKrbXPd6lY2mqSXy4hQy9imq7Y+lAEnHSEEyPgmLtFxHarviR4f9wDm4akuol935IPlGMVAwyy+c362/V6ABHKbDAiHlieNiWWjofMMzX+RkKlZBGDVtca9pDO/wmgqH4zG9BhCm4aix7tGL5Az9cw+Bi6A9Zo+JNqiDEX0c4IjZriCAiHTowXlcZDpCen+AacdGxNWo/gN0+m56ukEvIobkVcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRArF/CnalNRd2VFiQBXEgZ4Xju8nbhrkvb/sIIcHnk=;
 b=j+NH8cYBV4Ez35IIDFC6IXz4uw5yaW9/YEJke4d0zghLcKO5nLWL0iASPWE6UzHfZW6wLq72CrezwWspX8jCkF/YXbPN058JpJwbgcs7sHuR3nu5QFC/tt6W2IPBJFz4xF+Ap6UciWhwn0gTdO06AjBcQnFyvyyjFPFIRrMF4txFoPPtpd0kuFgCMhsTMrvZcV+Y+VaKP0bfk+FBdC+oN8Yk95CG/mHU1BCTXa6jZHeQFOb3X/v3szcQXnZWIkJxd41sSSR2nPVIbVLHPtigxjFKe4hO+fiTVo/590nXZDs/UY8uxMcUVkkzP+ZOb541o7lT0M7Q7TAjo2dw+JAXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRArF/CnalNRd2VFiQBXEgZ4Xju8nbhrkvb/sIIcHnk=;
 b=iRJtQoMNyVBErtm3RNBNQrjI0VKx+y1PAi+7CosR1MKh/uHRV9jfJ1JQgnELwBgnnw5K6Dch+vRGyG2f3nvo5Z01ms0fbQpFDpvdBIsmxMxXr28it9mV27TGqETybqrwU0+ULGrPQ2m/j2wW9oDBUzGzXWNfldx80rYyhFV9U20=
Received: from DM6PR14CA0059.namprd14.prod.outlook.com (2603:10b6:5:18f::36)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 22:09:12 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::e5) by DM6PR14CA0059.outlook.office365.com
 (2603:10b6:5:18f::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 22:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 22:09:12 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 17:09:11 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Update CWSR grace period for GFX9.4.3
Date: Mon, 10 Jul 2023 18:08:54 -0400
Message-ID: <20230710220854.2361633-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 048afc3e-594c-4c49-e2bb-08db81924b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCDhmaOWN4MAknS4z7qYtoV/0mBEnpVcWjITfYTUetwiecq4xWzWaIjm3SEJ20Q5ISI2kNwFxLAaiaGXaZC0VLAlQykZaa/m4+jCJ6woKFOGckzBurB0D/ABk4cmtO0h97GxiQXh9blFSSXwduUXndpeXtQXdIn/fRvwtF1p9Yz4G9Tjxdvkz08vNnW/Dma0b/hQRhsBCK9CB+pDdxOUJBXkgx7DJ5J48b/4G+7XrHZEC0DzWtRR+sxmjFsMYC+H+AwcH7Hj6KiLxAMhXuqphuzJ3Gp71BDlzLwRtAgisCBNyRi/0Y8YlExXRhgzYdSCEOLoRgx8rvSDq2FFk2J5UTj8OgYFLhGkE9bmiyqxbvcLTKbLUyhr6z3eCnQOIfkgGppXNaaAmgg6yKtLPTJN5/vyHCVok59XeYVpW5BgAp3laKmte6wEIBa2Jveqw+veKAlRjowq+Ux+jWMDXKI3eCrDYMcBZb/pB8YKpXEZGaYtL8KSulgZrqoVPmJwkMfSbYFEeeO5uGJb8FQFdzUAZbX0mu2Bo28C+J+7GEydaXcQ1SLSQ2UVXnmDPU3ouxFs4H4tjoAvCxf33qBEY5O1wH/p8cnvAkznOKEQmRr6nXk3Djz18Y6IAUOgagNuE40gcIrFsmZBnt/DOdfKQBIBlwTE8dB0aLat1Agbj+9nMKKviI3dfag6BHuGvkMb8c2FvCLqMh2boSPQp9gpFtwZBLNPp1qRo1+ucl5llknvM1Rh+CRo0BB3aPmhXFIfYcmRuw5x3DeIjdQgzmgh2VfG2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(478600001)(6666004)(54906003)(36860700001)(47076005)(426003)(83380400001)(36756003)(40460700003)(86362001)(40480700001)(2616005)(2906002)(70206006)(82310400005)(336012)(16526019)(70586007)(26005)(1076003)(186003)(81166007)(8676002)(82740400003)(356005)(5660300002)(4326008)(316002)(6916009)(41300700001)(15650500001)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 22:09:12.6292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048afc3e-594c-4c49-e2bb-08db81924b07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GFX9.4.3, setup a reduced default CWSR grace period equal to
1000 cycles instead of 64000 cycles.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 22 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 7b1eea493377..28963726bc97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1109,7 +1109,7 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 	*reg_data = wait_times;
 
 	/*
-	 * The CP cannont handle a 0 grace period input and will result in
+	 * The CP cannot handle a 0 grace period input and will result in
 	 * an infinite grace period being set so set to 1 to prevent this.
 	 */
 	if (grace_period == 0)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index de83eccdd9de..31cac1fd0d58 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1622,7 +1622,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	if (dqm->dev->kfd2kgd->get_iq_wait_times)
 		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
 					&dqm->wait_times,
-					0);
+					ffs(dqm->dev->xcc_mask) - 1);
 	return 0;
 }
 
@@ -1664,6 +1664,26 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
 		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
+
+	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
+	if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
+	    (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))) {
+		uint32_t reg_offset = 0;
+		uint32_t grace_period = 1;
+
+		retval = pm_update_grace_period(&dqm->packet_mgr,
+						grace_period);
+		if (retval)
+			pr_err("Setting grace timeout failed\n");
+		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
+			/* Update dqm->wait_times maintained in software */
+			dqm->dev->kfd2kgd->build_grace_period_packet_info(
+					dqm->dev->adev,	dqm->wait_times,
+					grace_period, &reg_offset,
+					&dqm->wait_times,
+					ffs(dqm->dev->xcc_mask) - 1);
+	}
+
 	dqm_unlock(dqm);
 
 	return 0;
-- 
2.35.1

