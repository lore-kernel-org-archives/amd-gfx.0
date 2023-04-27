Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91C3C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7334510EB83;
	Thu, 27 Apr 2023 15:27:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89CD10EB5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=memNe7EvqwFrDEH10SFp/dVu7SnNWeS3yLeWgSepk9JBQ7T6xznZwz/Gp6HpHdwXOWEwOXvXl8hURIgEqVLaiZrjXvh7l6eMMIUfi5TrxGsW4BgCIbMuicRwcREntpKr2YYRfVZU0l8xoVpqRNNqc680L74nBOsXUKpWLJwHPwJwXR32RyA50xoBcxCer1CzOMhWGh3nYBx0ALPSp12pieXwFAeHMZ+ysBEWDuJvtob6uJrFsWH+WAdT5Zv6LVDW6c+9TpBJfHx2CC058Rjro1kc29fcYLRQYJcPAjjX+YGyCUaoe5wcieaCsHvaxLS9HX//ZgHhrf/sbeY4d+x3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIClAD6WsQZeJsGmkq9g2Q+Txonju2bhjoUuSzxkFaU=;
 b=glOgBqNQW3qxKIRw6eA8p6l4dd5OvItlC7kjdHQtjH3u5DclpVvdB1zUE4jN+Zx+sNuAeJsADXxYh7CKO+zQosg8Pt5LGmr1zBMLKhAW8PQtdfD4U7I33GIGncjcHK0QQ0x4/jjwpY0U/Gl2no73lyCn5uoUUl4OHr9IjPTVKCg49Cj2tti2wKMRrmlM60lSqL31/3M6y7yRtNtagA8gQMMzeTcmAbTorPsoT6fRpsLVNIpFyNhJa6AU/pt8dM0HDIU8XiAsfdwNe0EFTSPaU4yZZG47U3ynsAXDJ3MIruxbdQ+BzD8RerwrsLUc82L+rIG18NO0bADaCf/svj37WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIClAD6WsQZeJsGmkq9g2Q+Txonju2bhjoUuSzxkFaU=;
 b=YUbRx+I+X/909HZFEmShycGy4Hc1d9xOPAb362jtcedTJJVzbaB4tGq3ZbN/hAnHdV0t1TGG3IhFmdXBozgmkTvbmPhl0qPQRbZH865kapEm4gnez6uxgY3tMf++iwmwvhRoCFAgrGjCH/7NohxhL2zc3CpFlWOpgTSiMwccSRk=
Received: from BN9PR03CA0451.namprd03.prod.outlook.com (2603:10b6:408:139::6)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 15:27:40 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::36) by BN9PR03CA0451.outlook.office365.com
 (2603:10b6:408:139::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 15:27:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amdgpu/gfx11: always restore kcq/kgq MQDs
Date: Thu, 27 Apr 2023 11:27:08 -0400
Message-ID: <20230427152709.7612-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7e9ff9-a788-4d7f-801e-08db4733f008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftyTxiT6Mrq5/+8G0Zyhlv7U0RNaPfY5wpMuD2/z9QlZHfKEGEx/hvn2q5l4b1DLLmKLkXlHNWnt+HpgzySvxHy04YJ6Twu6v/58j8DQUOIivhwxkhImAbL+urnXqC1TBbCQ7Xh54n1Dogm0zc4BV5vQ+RcXCFOA1E4xpAV60pAHR9bzDB3FS6aUx2Hj2g9wK/JOAvMI+LcwpVrO0ltDDCL8rNpfZYUSSCuHfDmJFSYyVohKaQiSFzjFpvPaEParOzdKu0n+QROhxrrfL/qe33qe/Yq/d02CQ2s0avJ489I+xIdo+vYBuvUGMkMaMZXhOwJgar4D2C9NSGbA/R0tmR3GbL5xLKPd805NJNXBzDgCa+D4ovaKxUlyEg/jOe2/NqZCdl4ErYqy4mXbzatF8HdfAdBfExwn9hOQmJ/Ms+OWPMdTGSYaOPHDIk5Yc/d5x1NQuHT0n2BrPT6DLer1dmN/IBxMdPVMjCDgILySVUWno8BH8zefc4/wxXW8LaZoelApvyNEfNCnvnCk/N/Zeoch1BKxCyC68UVz/knbFrPVLAwt8K2ruFKqmae5IomcrZQ7LAxddaTPkbhi7IQstXLoe5gblXEK8zXc/CBYyk/aD+WVFhAmvetUE4VgUgfri0vKMiVE9SQ4SDtO0+Or1UfLFdTwXTktnC4EAiF25cwAH9jnG2u4JIwArUHdO9SxwXAFDeAdCfu1GJXEbcJE85+qaDgxKvu6/m4PW6q9wp0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(86362001)(47076005)(336012)(426003)(40460700003)(6916009)(83380400001)(186003)(2616005)(6666004)(478600001)(16526019)(1076003)(26005)(7696005)(5660300002)(356005)(40480700001)(36756003)(81166007)(8676002)(41300700001)(82740400003)(2906002)(70206006)(4326008)(82310400005)(70586007)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:39.8581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7e9ff9-a788-4d7f-801e-08db4733f008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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

Always restore the MQD not just when we do a reset.
This allows us to move the MQD to VRAM if we want.

v2: always reset ring pointer as well (Christian)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 256014a8c824..f09e2558e73b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3695,16 +3695,14 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (amdgpu_in_reset(adev)) {
-		/* reset mqd with the backup copy */
+	} else {
+		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
 		*ring->wptr_cpu_addr = 0;
 		amdgpu_ring_clear_ring(ring);
-	} else {
-		amdgpu_ring_clear_ring(ring);
 	}
 
 	return 0;
@@ -4043,17 +4041,14 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
-
 		/* reset ring buffer */
 		ring->wptr = 0;
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
-	} else {
-		amdgpu_ring_clear_ring(ring);
 	}
 
 	return 0;
-- 
2.40.0

