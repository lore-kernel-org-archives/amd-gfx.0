Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB9AC5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 04:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA02C10E5DC;
	Tue, 25 Aug 2026 04:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T4cSWamZ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CA210E122
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 04:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzVucwYFsqyP45CBAZJClddwF5eQT03tyMoEj6PG8TvJAqo2glpUlF1qrOEikz/zsNF5HaFkeJ5/dVKLDmOBZsPaAL6pdZooQ2w62ojH1PEEKklSovvw+yMO8Qumd0jYTKmE69rG/WOM4CsRbkSuwK9BS6W1irkIDnZfu3YnyNTLKBaRN958CFrc75Iki3AKFxfZBBRRzfmvHUBabYKv2xoQwwVx04IU6rS0kKYF73zy2wJiprkoXcsGyhLGfG7dwTm+x13mWG6sXB01MR4dcR7mXs0fXU9RpiLg9gJkD5UBGNZ8RZw+ADrrzuI8/Qlk6EsiiJld/ZLSRLoS4oxLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NGtNT8zqz2wIklmvZ1V2sKMALcXePWawTAfD4DcyOE=;
 b=HnpwUlUgs8ominMAaKCqhAXPp77HtIsE6UhnJTnPC3AgznpQ2r7Da9Xl0Ly/j57jTi9zncTp31LXQgwFskS+ZwT5WGCtOnGMBzNpUE5KA8oVKBZfbn4afH+lPVmZfWkP4VsJaaTxoxyJYlq64B0UeYCWy9hPybwzoXWrJ2fToSYVH6fvElmpdaMsBhB4YuYFGGIN6agPTO1r84gC78SG+vGJzj7w9ZL8z6S3SSLCZrOG0UabTs3LfonW78ezLfTxpa/711Sx7nCoCqdKLq5nN8skkv9rAs5HZRT2yjchi4b9tnWM02p7sr1050GoNTJt7OK8uypOcoMtG+Thvo/STQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NGtNT8zqz2wIklmvZ1V2sKMALcXePWawTAfD4DcyOE=;
 b=T4cSWamZ3YYTtLiOC5WYujeZmu4ZhVLG7LgyF26+hIHO5UuyOMaQ6aYf1jOPEYhu5/VeaDTso0jxSVF7KO9MW8SqNI3aHCAB0quVee0Fzt4lvBmuns4s+wytknACGiYuMOJ7lrCps85Ym5lYW7C5+8sRZ53a1qJsGlHNC/WIN8k=
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 04:23:03 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::7f) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 04:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:23:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 18:30:55 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 18:30:54 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/psp: skip firmware.mutex in psp_resume during
 GPU reset
Date: Mon, 24 Aug 2026 19:30:04 -0400
Message-ID: <20260824233040.125300-5-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824233040.125300-1-vitaly.prosyak@amd.com>
References: <20260824233040.125300-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: c2632ec2-d977-4619-44c7-08df02608e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HQKb+1LSs9cwJMBvtSnknbP7Kgoh7/DaEcW92f3tCBmj0I0wAjIrpnqJqgEcbJY3n/Nb5/bkzo2QKrBjwVqfcOTERDO3NsDfw2UW1aTgvHGY3WB8VR3CM3u0u4hOtm3XAgBsEtZ5A8HbGZNXJDpKQimlx65X344txWiN+rgfs9GTQqr1xQ7BYfe6JxHGF4V79MVCLV3aC6lLCfJBjC69PAp1qcXMmKly7MGr+jWV4ol3wHJHHCszPrHW+wVtoh8HrEnAyBMODK4e5jkeN3RWnhAmPTsdTlUTN3INV+e3JXYNgGHCnj0GJzqDNkaaHAFat60u4lqO0k2Pw+bb995Wx5oVZ5WEb5+J58W9oLHmW0cDJwUSH5t+k1x1IA5reZPeOM54wkmQj5sQP5B7MRW0BzZ0G0t2ju1Q8kMMf4J37oinamLsfsyLFljwgQb5CnNYwyiBZaIi2jT/myQOWybZoNSv8bbXb3E7QiFYy6Ji1nWgXjr4CmqJX/XvvrgqPW+1oru4HwhmIm/+7Hda/uc7UJZd9MQXFlzP99DOZ0wEkWEN6Bx2kFzefyznJOs0dbkfuVjXa8K7jJ6wFfQVTKi7QR/beM+uWDjaAEGTrI9bnFUWf1kZUJepxfMh/Q2lQAQIUB5/QiJxdq+Bmue22b+KKca2a/YITUEFF2c9JYSxYxVlAX1Wy+CLmhiXrmdhZ01M2HyisAdsnjxfC0eiddiZsg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qsq3DVfdmc8ASu5e9//sxexo+WmsFxJWkci9eW6OceOXpLsyve4avxngAL+fS+JA4CP2ZBc6xf9yHJUbzBoQChJKI3w/J0/YNbyDBuL5Vr8r+F09OYavbV5WGLz5LkMamRNvp7Z7EW+dd4g2u0W8tNmbA0Bokd3lp6U9UEtBYFQEnWwgL0z2qhl7KNn7oTQSL4wupSFdcVsCVUbXGdoZtQv5bzqF/Il8gqhoDCHSToo2ArAOWEyLG4CvwbGtHBOQCXAqzksATVxDDaFqwvG/Z8R/nUcfrR32gfOXjE+Y9DfMDKCLlX25jQ1qXNxm4l/aE/u8rE9+q2q3LwP837CWrjOb8Em0CgpS3JGyPeQGCAdBQN4Ebx5OpeinV1JLIsXj7rcsOoFEbIOLrIY9lzH+81b7J/E38jEREC2+lqoRUTYfPCPN6gOUP+306+R1EoXn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:23:03.1692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2632ec2-d977-4619-44c7-08df02608e10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

During GPU reset, reset_domain->sem is held exclusively (down_write)
for the entire reset sequence, which prevents any concurrent firmware
operations - they all require down_read of reset_sem before running.

However psp_resume() unconditionally takes firmware.mutex, which
inverts the lock ordering that lockdep has learned from the init path:

  firmware.mutex -> reservation_ww_class_mutex
                 -> userq_mutex -> reset_domain->sem

Lockdep reports a circular dependency when psp_resume() tries to
acquire firmware.mutex while reset_domain->sem is already held
(via amdgpu_device_lock_reset_domain).

Since down_write(reset_domain->sem) already provides the necessary
mutual exclusion against concurrent firmware operations during reset,
skip firmware.mutex when called from a GPU reset context.

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: Ie4c3093269d473b9859b36f67c832ad8143627cc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a0f6df5067e6..da344a21063c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3954,7 +3954,12 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	mutex_lock(&adev->firmware.mutex);
+	/* reset_domain->sem is held exclusively during GPU reset, so no
+	 * concurrent firmware operations can run; skip firmware.mutex to
+	 * avoid inverting the firmware.mutex -> reset_domain->sem ordering.
+	 */
+	if (!amdgpu_in_reset(adev))
+		mutex_lock(&adev->firmware.mutex);
 
 	ret = amdgpu_ucode_init_bo(adev);
 	if (ret)
@@ -4017,13 +4022,15 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 				"SECUREDISPLAY: Failed to initialize SECUREDISPLAY\n");
 	}
 
-	mutex_unlock(&adev->firmware.mutex);
+	if (!amdgpu_in_reset(adev))
+		mutex_unlock(&adev->firmware.mutex);
 
 	return 0;
 
 failed:
 	dev_err(adev->dev, "PSP resume failed\n");
-	mutex_unlock(&adev->firmware.mutex);
+	if (!amdgpu_in_reset(adev))
+		mutex_unlock(&adev->firmware.mutex);
 	return ret;
 }
 
-- 
2.43.0

