Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B52C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 09:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E7F64F33
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 09:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E7F64F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65D96E0EA;
	Thu, 25 Feb 2021 09:17:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980356E0EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 09:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCldXBzf8Co/JUeVHODOfzSLiXDXL/j6ziSk4pVB939kXt3fhlGv1GHtyS02NJibJrWKmKPu7Nwaja6J63C+J7dvG1S7oi+od0A1RYtGWLElKTfQ/MbG/4YYv/jPSufCkmMdYp8Gc7R1iffgn6+R6E3jxLq3+atyyC7dMOhjMbus7NbWOui8Tsekp+pVdL120kB7B2MSWiHIdXyI83gH7dhqyXvKvgfvtrQAmoFxg0eTVl3agK73wRaoix+RxPAKglJ87ffXrvwtAOovPyF/BKQfbDYqOc3cPC5cYtkbfBqKsgaXn3wC8yvr3F+yvoC05Z4Gii0vB7XVIr9TbtLfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJlG54t1M+AvepFxuQTZboeGPBeyTrGf5M00nifEvXw=;
 b=ezpT1W8hLWxR5gIjorc/lM/M1pn2+bUhlpy5idW7c+sPR5N8T1pZ1eU2WbG4+8ekCKMnbxsEFA+ggPQFkkH3BELV6rX4ebh53gEOYgOvHMyj7E/XtX2FAyOz2pQfQcan70Oxh0m5RBkeZURdLoCXD5VrwvL8NIRUgNVkXpjxBcJLU5uq0tV9oeSZwLOdryXy6jqNQ+Tern11C1GgDU6+QwH2KqBjISCsjYla+zJ/YMotw3xHwCJ3YZ9DBu4betPt0qFRHXJ13bbhoSrkAzF8WKH+ePm8501ciZQi7YfUniarLFB4O7aKB4HN2uiE3FrBXW6TKTlu972D9/nc7eEbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJlG54t1M+AvepFxuQTZboeGPBeyTrGf5M00nifEvXw=;
 b=fbB9aUD4Dl0uebk6B0ZKAC5CuMrQpEA9VuxcB1+Ii9PB/bvgwIKhbG2Ptd5YeEanhySkgtn1STzgXjxWZXRh4mjdnkIVd0eIHpEjq0V9oxtI2OMyjkZ2YILDZXU7bN32Zo6pCrd+ir+DkIueL+xdIeVCr+7D/a3q+zMntWBt57A=
Received: from MWHPR14CA0060.namprd14.prod.outlook.com (2603:10b6:300:81::22)
 by DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 25 Feb
 2021 09:17:11 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::ae) by MWHPR14CA0060.outlook.office365.com
 (2603:10b6:300:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Thu, 25 Feb 2021 09:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 09:17:08 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 25 Feb
 2021 03:17:08 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 25 Feb 2021 03:17:06 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: move inc gpu_reset_counter after
 drm_sched_stop
Date: Thu, 25 Feb 2021 17:16:46 +0800
Message-ID: <20210225091645.677055-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7fc4c96-71cc-410f-ead3-08d8d96e20b2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1771:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17716BE00B5D9D97E6DAC6C3B79E9@DM5PR12MB1771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dp2G8YWmnJDLD2kl4iRUC9H2UqtqqW25du7I/TXmj9D18IAOasWVmXBOJ7d+pN7LWHD3ZZUNPDEUlOt8xZsSjoAhPF+jWXRNVHNKqxzgG5uBvJ83g6ui6Etj15uPS0I7pHa0yBHC1VKC7GwdAh9pgU81B1pQmP5ysuOocEyU9jJhKQm+fKk3IIaJFP4M6AwhLEu0VeRc6ANCRD7CggRzY63XoxHx/tMM1NcJ2lNaVKrmD5eS3zvhpcU6LWHPA4GtjqqmvABAJ37Sn/Dd3gdR/iLEd/cAZIU/Ow1Asr3bv5GmR+X71yDVdcUvHQKCBYjpuKE0DVKtjdccHlzApmiuFWP429w3fk67VOfd/Nq21B0EdCwPx0zZalqReax7azHDNC0ymvgxifbPG228uRst4gLTAOGCWARFzKc22zKTnDUpSH0G8cbQb9C6BOmAOJKkYqDqeBHusdJJGnpDaqhQKOwGvIqd64R/nIA1YBDyqR28j42ojJMJw5VwPax2t7y7YcSkQ/kVep3LjUg3zd/dN/2lzOw67ozQYbzDYybw+uI56OwY3JqztA0NAg9xy0MhAquCPc9agl44koQ3h5cbZQ/8VOqrV4ezT0s7pu2/yON8cperxB2/HrLkrWaS2I+O1TEbMgdBdrEw2ebvLT9F1gFEcw+unzWDRdYUgSU4qoY7sxLIGH5tl0lBQ/38OEK6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(47076005)(70586007)(82740400003)(26005)(7696005)(4326008)(70206006)(36860700001)(36756003)(6666004)(316002)(2906002)(5660300002)(81166007)(186003)(1076003)(356005)(6916009)(83380400001)(426003)(86362001)(8676002)(8936002)(336012)(54906003)(2616005)(478600001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 09:17:08.9502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fc4c96-71cc-410f-ead3-08d8d96e20b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, christian.koenig@amd.com,
 monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move gpu_reset_counter after drm_sched_stop to avoid race
condition caused by job submitted between reset_count +1 and
drm_sched_stop.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f0f7ed42ee7f..703b96cf3560 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4447,7 +4447,6 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev,
 		down_write(&adev->reset_sem);
 	}
 
-	atomic_inc(&adev->gpu_reset_counter);
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_MODE1:
 		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
@@ -4708,6 +4707,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
 		}
+		atomic_inc(&tmp_adev->gpu_reset_counter);
 	}
 
 	if (need_emergency_restart)
@@ -5050,6 +5050,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 			drm_sched_stop(&ring->sched, NULL);
 		}
+		atomic_inc(&adev->gpu_reset_counter);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		/* Permanent error, prepare for device removal */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
