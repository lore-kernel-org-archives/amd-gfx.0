Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EBDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46786E950;
	Thu,  2 Dec 2021 03:10:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655666E950
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQURi+7u6LkFot8D+H0MA1Ql+/3cTIdvLO9OetPi6vo9f/rgY1shna/2C47UmyGtck2d9NFSx7kkEZB3COLOLSuEWmu4ynT1pyp0bIFDgP02+jajtOJ+J5UcqYFaFMNR1OeUCkF9pa80ZrG83y1nLicS86ktxevGy3Qkoow3+WbYolD2mWTJeRdih1uY5TvlGaFtzCuNyGL8NLuuKd6hwAQTYApHpQIOFHx6pMlIHmKtKW2E/kKppRAYWdS5VAuWwYlNP4rtdBSoANlBl3cCW8ECQfl4gXm/qSos8/dLPunBcn6KfxzW/GF2bHr17nOF6eRuEmz4k8aep1m9SplK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT94wBRiPimh3kOJ0YOA4PmwesGerAx5w4JKBVp4fUA=;
 b=NwYaN1eQurgroxHcYSiVseZpp2jhse40PfRV5WSUn6aSe9ngjPsM5h2JEjiI33rxZVawPx3kFeW3uQTxwln/xEUCxwq+S/timpqsGLzyREXsMbjm34qNf16javpvkoh+Rxqe2NWHxmrBQJbl/pakxHfdWfreoz1sx4L/AKrr687txzCYIKd6c5bWL4Y0sRFmm5CKI4YRVqxMY/UL1PemR2FxVCBgAGc6L7ApiOS2flx5lcivrMSLk4G7q5JY3qx8QlaRt3YsWgZ0tY3yZCZAl9UUvabu6V9esChMMv5xGH5KeC8WxRaIjvJrRxYr3NSjPx0K4jPVjaLpA7wCDPdwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT94wBRiPimh3kOJ0YOA4PmwesGerAx5w4JKBVp4fUA=;
 b=WWJ26dbLxDlPpkQB4CGGk3D0cuq6LSwQOIEYF7c9GomBb6XILEnbRniaBR48HwmP6TpJ0O7RGCXVtcSb+ml5hpPVRByz7IwjIFFIPuBxwjCnGQ0LdQ3mKOskSh3JKEfY3rfEz4exZY/N1obzv1Kmn4i6x1nZywIUwJ0iWxFzzX8=
Received: from DM5PR06CA0056.namprd06.prod.outlook.com (2603:10b6:3:37::18) by
 DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Thu, 2 Dec 2021 03:10:18 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::77) by DM5PR06CA0056.outlook.office365.com
 (2603:10b6:3:37::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:17 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:15 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 08/17] drm/amd/pm: move pp_force_state_enabled member to
 amdgpu_pm structure
Date: Thu, 2 Dec 2021 11:09:21 +0800
Message-ID: <20211202030930.1681278-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d682e81-797c-42c0-faf4-08d9b54144ad
X-MS-TrafficTypeDiagnostic: DM5PR12MB2469:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24694B578131FA740DEDB6FDE4699@DM5PR12MB2469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3d3ljtTb8XikPP8VzdPFxL7L3h3+XIX+O91ZxHDLKv9M4PmhlwCLEUGxNDu+MC6KrvAFNysn3LRU4Trb7MruTlZ3Ru1/9sRk7ue7fZXRzRORYT1m8n4OX0AKW7OJZlTuXph1+hQMwMApDU32Tfv4bO0YiCxvp18qyk11LdT0E7dx7ULKJYvjnh2890gvlWOZRofpTAEaf8LAgVYDh2981Jm+GVCrlkjoMIxOIkv3rUU1ppNsMWArnP4jCU/BchQb5bRL4YJxW6JvFaKT+CIu5Y/x4eOD8/Fta0BqVKUyFBzyWVucI56B51UFMSNm63wRpZHwGMbCVzoVZwcEhai9aGThTWBtVRAwlHvKtTAn+lIFzxHxhKK4aLSfBCx2TrUGkeFKFZLCsqIxYg0YKXHLYXZJs+GlKWRqC5/psD9tzDd7JWfyMaBlBxXahSJt7GIjdqeNhvhNMekMRX7qq/3+af8meE75bUjQB9QGLTEGbCRTxjVMewne809c9oIJ4G7fYZLnqKipmWyIjesf4jnKdvdR2h6HpjwBeG95iJWzFCJ5RrivcjI8x8v9LlRqhtPmsm8h+TX1DuHyJYNSBlDiyI4sljPuuTLzN1VG3Le3HLnJ2sVzcDY2f1XXhwqkmS13A1osUtrH8UioaxbHRD0VpLkTUUhz0P3M7hVWg+0h4/RXLgKX/IinBzMD6teWADqQnLrnWXfguV/aJackbzj7vTnJiuNbDWASwaSDG+kJjVswUHvY4XjCZI6VjcW/S9YxFGR5nZoeaa61PusRu36/4p6s9L/LLa5OJ3Ft3MShJfI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(336012)(47076005)(4326008)(5660300002)(40460700001)(54906003)(6916009)(1076003)(426003)(83380400001)(6666004)(356005)(7696005)(81166007)(16526019)(186003)(316002)(70586007)(70206006)(8676002)(2906002)(44832011)(508600001)(2616005)(82310400004)(36860700001)(8936002)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:17.8609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d682e81-797c-42c0-faf4-08d9b54144ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2469
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As it lables an internal pm state and amdgpu_pm structure is the more
proper place than amdgpu_device structure for it.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I7890e8fe7af2ecd8591d30442340deb8773bacc3
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 6 +++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5cfe2926ca1..c987813a4996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -950,7 +950,6 @@ struct amdgpu_device {
 
 	/* powerplay */
 	struct amd_powerplay		powerplay;
-	bool				pp_force_state_enabled;
 
 	/* smu */
 	struct smu_context		smu;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3382d30b5d90..fa2f4e11e94e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -469,7 +469,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	if (adev->pp_force_state_enabled)
+	if (adev->pm.pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
 		return sysfs_emit(buf, "\n");
@@ -492,7 +492,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	adev->pp_force_state_enabled = false;
+	adev->pm.pp_force_state_enabled = false;
 
 	if (strlen(buf) == 1)
 		return count;
@@ -523,7 +523,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 		if (ret)
 			goto err_out;
 
-		adev->pp_force_state_enabled = true;
+		adev->pm.pp_force_state_enabled = true;
 	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 89caece4ab3e..b7841a989d59 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -335,6 +335,8 @@ struct amdgpu_pm {
 	struct list_head	pm_attr_list;
 
 	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
+
+	bool			pp_force_state_enabled;
 };
 
 #define R600_SSTU_DFLT                               0
-- 
2.29.0

