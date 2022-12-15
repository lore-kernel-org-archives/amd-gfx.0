Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90709C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8524410E589;
	Thu, 15 Dec 2022 22:11:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCE010E581
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTRffnfc0mVjk98E18K6v5hxmox1myJJsqPk0TZYjCBkoMc2g74EF/WGfJV7tjwowJ3LqAmwTDvCp4M+8sDQXLc5BA6nEBnZxm1QGrfSeps3oh/LU4A4M2CgbxIllRC9r52aYlsxU2v7QTs2UE9DUQPJ+ikKnYfEOGrzRoqtnWTsOGyDJWyJeuaRT/68tkeMco4iDsr9PMxntxmHa/PV+GPG9ijtz7Gn5L5MyLTrJv9g1UvBBAgK3pZAkTIpFl0NxsbHXRT8wTKTv7eMMtWXYnYwFDJ3w/PZxa69s9FPq20PnnAqDBZRvphoOHg7b9mlBB2NMRamhOOLOt9K81eD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g3ZD+va75tdyGZvpRUQrvViovRdwTlNp6syFqdCUyM=;
 b=FKZTtrDPHtk8uKUPsjutIRaeVsS03K0hQ3SMd91aEJhGsb/BXoTEz0D8q1F1VKgGgkP7oKKqInxZyPqinqd7a6+4KQ6rocz6BkmEwoOkgO74lcSBaDJMLuVAaRdJ2FowvikQDHWr72wsH/6keBXIDAzJVNZ1kNEO4EhV++SvNZEGiEeTqdyWdChK5CpgNhHDABBHnp2LxTtQjfaA4ZpyspU5XkN6tw10KMDuRmtbLnbfxDVbHJqZRzYNj7LEl3fG/FmTSQ9DNLYpVjmmg3l/x72g8b04ZQ7K0wOd46LEP+OrfPC0nxHkTyiAZvwTPqBOHxPwtioW1diaTYMH69h7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g3ZD+va75tdyGZvpRUQrvViovRdwTlNp6syFqdCUyM=;
 b=Zma4u1yKr0oKzPUu2s+BD0Fj4v0vWU/JUfdyzoOQn78tngYO70uTftJstbJU5FRmF12byJMS0mtd+E3YNToyBwPyofgiMurKpUuj6XTp2eQtjCiDsZTwntX5xrGd3PCOttNj8XYLiwhFOpUtOYg3TbWzE3vfHb7fMiEqUtth4zQ=
Received: from BL1PR13CA0322.namprd13.prod.outlook.com (2603:10b6:208:2c1::27)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 22:11:18 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::dc) by BL1PR13CA0322.outlook.office365.com
 (2603:10b6:208:2c1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 22:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.10 via Frontend Transport; Thu, 15 Dec 2022 22:11:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:11:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] Revert "drm/amdgpu: disallow gfxoff until GC IP blocks
 complete s2idle resume"
Date: Thu, 15 Dec 2022 17:10:58 -0500
Message-ID: <20221215221059.509565-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215221059.509565-1-alexander.deucher@amd.com>
References: <20221215221059.509565-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6eb265-19e0-4fbb-bac8-08dadee94a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kr8QRH2oI2d9+KCD04F14S+mDhQTRa/q2E797fdVNkAgK958l+PSoDrEh9RaLhq+jdmraiOaQPf9144/aCHNgTxNB5AJRjUFoudC+0nNdCEpl9hRp0xMj7VIcdABY3YPDxjg+QsYwzK7T+v3j3wEnSNcwVDjiDZ3bnr1E6a8l0TIVNEjsd6GOcaA4FWHU04kKRMhG9nIfzrXW7M+eOiIFC8s04J1THx+odwHGV8xyrAyLfJyUF72CTmW7uGKW6aqOD9ZuU0SLOZwUcJ4AluBuylfiP72zwEUZ3Doa8elBjgw2aLtaQCbDjqwbhm0ENCdpVNchD6Ec5ZFaWhIVHQSXb9ggB3OFI2pzaHVuhXyctIoEk2aSOJYUgE8uh1s8AySiqLn8pl2tzxWyNmwTuWdCOzK/IGTG49FZ7ibaeNcvvU+F3DXL6C298GHhCsRyn0SxwGKtPdU7N2mm5Zj4oB+f7Zm3t3DX4PYgWAvm6lWYLClL0m+mkPG7eSuAiGXFLrJVcl8DuLCpQrSnBvHafdVtc/jUHHrIEhMGfCOA9Nw5Z++1xX7kdlvq5RejmKLwL3XWlDY85J2v0dijkttkbzpRrMteAqtTs+UKV8lCd53lxd0q92bjSui0QOIizg4BXSt2VClqmWKg17bhZRr007wk3BytwOsOGiQfXYsPvkCbcfwK4cozj5wGmtFsGQJFYUDAvLheLzDgRSNo7fCuVSfWD4uuKcQjv4JRKMrfUFC3zk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(86362001)(4326008)(70586007)(186003)(16526019)(8676002)(26005)(1076003)(70206006)(2616005)(478600001)(336012)(316002)(6916009)(7696005)(6666004)(82740400003)(81166007)(356005)(36860700001)(47076005)(5660300002)(8936002)(83380400001)(40460700003)(2906002)(426003)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:11:18.0445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6eb265-19e0-4fbb-bac8-08dadee94a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

This reverts commit f543d28687480fad06b708bc6e0b0b6ec953b078.

This is no longer needed since we no longer touch SDMA 5.x for s0i3.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c0719c03c37..582a80a9850e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3234,15 +3234,6 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 			return r;
 		}
 		adev->ip_blocks[i].status.hw = true;
-
-		if (adev->in_s0ix && adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
-			/* disable gfxoff for IP resume. The gfxoff will be re-enabled in
-			 * amdgpu_device_resume() after IP resume.
-			 */
-			amdgpu_gfx_off_ctrl(adev, false);
-			DRM_DEBUG("will disable gfxoff for re-initializing other blocks\n");
-		}
-
 	}
 
 	return 0;
@@ -4230,13 +4221,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
 
-	if (adev->in_s0ix) {
-		/* re-enable gfxoff after IP resume. This re-enables gfxoff after
-		 * it was disabled for IP resume in amdgpu_device_ip_resume_phase2().
-		 */
-		amdgpu_gfx_off_ctrl(adev, true);
-		DRM_DEBUG("will enable gfxoff for the mission mode\n");
-	}
 	if (fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
 
-- 
2.38.1

