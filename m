Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A68C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 08:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A955E21744
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 08:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hIu094Rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A955E21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F2C89C28;
	Wed,  5 Aug 2020 08:42:05 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680064.outbound.protection.outlook.com [40.107.68.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4FF89C07
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 08:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY+pzU7reynFOUQ1/f3x2/JMKwpL4RE7j+01A1miPxMLsCY7/BJv2v5wxZIHfqcWRoBgyNcIX++32ppQ5inJ507xBTzdlSw+oSGyt9ny98J/OzFA8vEKPVX5mplCcOFRHy5FKg7tSGV3crI2p0lTpGMiJHXyxOTb1OyvbamY/P18Ua4fRe04Si94/nwA+kU/X334tQOQNAfYI6/2DM622PFDx/47h5gRRVrUN5Ousrel6/QBJC+q/o3ZT7uzmCZ1ZLCvb02QYcZd1iwWUYOqPORyXtjoq+8SIkNyb+haSgqrSXABJWzwfVpu0oH1iXNw4aCLOEPFcayzgRNwjDu29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdiL2nvkO5GTThHu9SbK1O52g6gBWAK5RG5PG2r83CE=;
 b=jhPhLzhX70bWPSYZdZuzmEE3ZY17xzLILXQMM3HsczecE5EeQbFRVh6frKR1sf4vLZnsVrJ+7wQiSJIQ+N6bblDwVWqm2N2YbKpW5WuHp/qnLal3wCdyeBFVo2QeEcMm8/w9zSx3ynjGs2LMu6zKBzCQUVs2Le+2cNCcbRgwxn5sPU/rLudefa5nzhWTnQu4jEsoB36TF5Rr6OQLt6knLD/EZAf5xthXPs58jvmmUsEznMZbqVAiqVbHCXERLqSY5VSJLxYBDIGGys5hZUG0rY2RUl/AD8k8ajybKCnPMhve/mWSNWFJ/poA5QCgi1rn3ayHubhnw6UA02ee5SFEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdiL2nvkO5GTThHu9SbK1O52g6gBWAK5RG5PG2r83CE=;
 b=hIu094RjJ3QrlNNSiyKChPAPi7LsmKuM86JPJAyIGpH7VvE0uEKEjBAVurnidhaqaIu4En++1M3/0KDIywQWHhF3njs7FlgTG5mHp6tOlsmDz0kpeI5n6cunyqCBVECnLte5SA2CdWbZ77mJO/cfwZ1mZq3G9sUhNnjx5MP4B9U=
Received: from BN0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:408:e4::35)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Wed, 5 Aug
 2020 08:42:01 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::9e) by BN0PR02CA0030.outlook.office365.com
 (2603:10b6:408:e4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Wed, 5 Aug 2020 08:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 08:42:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 03:42:01 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 03:42:00 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 03:41:59 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: unlock mutex on error
Date: Wed, 5 Aug 2020 16:41:46 +0800
Message-ID: <20200805084146.25788-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b8e3df1-6d4a-4d95-b1d4-08d8391b6c22
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27650C13E997D202382851ECED4B0@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVQlKweRKuWjPqHaaobM9dgc1T1tLVkxN96yu3yQLK30ztj55CV2EUkIx2T9IsRrTTOHd5LFjJ5aDr1sHqnaOYhuzMHvN2bBYRFaXFOcGpkZV4M2ZKndMejdER0RzKUWoGzba4dL5NZEhrPztdClf98GpBmZsyCQxNzuEr9e0+QadFRDfhs7eZN9yeEEU2Uq23CSXlhmoMytxLOSLXQKvW/h+6KrSe/OWq3HFsK8Td3bBA22rdmPX8eZz2h/AFMnhZo++2yT63qm8hvgV6gtok4abWJIG8V1y3LxyKr7N74nhBlFjhuydd/jQl0FFyqAIxgh/UsEY9/LQrclSmgEZT1vOW4vpe8uXK5nj9XPa2w9jHncq/n4Kjr1eqoCo7s8SuAL8RpBzkdEGDTR1RqDAKIcbe4JoOal3PpWg8m3L3w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(2616005)(4326008)(26005)(426003)(82740400003)(6666004)(86362001)(336012)(36756003)(83380400001)(82310400002)(8676002)(2906002)(5660300002)(47076004)(186003)(8936002)(110136005)(316002)(70586007)(7696005)(1076003)(6636002)(81166007)(356005)(478600001)(70206006)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 08:42:01.3608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8e3df1-6d4a-4d95-b1d4-08d8391b6c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure unlock the mutex when error happen

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I6c36a193df5fe70516282d8136b4eadf32d20915

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a0ea663ecdbc..5e5369abc6fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -632,13 +632,14 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 	}
 
 	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
+
+	up_read(&adev->reset_sem);
+
 	if (ret) {
 		DRM_ERROR("amdgpu: failed to schedule IB.\n");
 		goto err_ib_sched;
 	}
 
-	up_read(&adev->reset_sem);
-
 	ret = dma_fence_wait(f, false);
 
 err_ib_sched:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 4e017f379eb6..67a756f4337b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -545,7 +545,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 			}
 			ret = amdgpu_xgmi_update_topology(hive, tmp_adev);
 			if (ret)
-				goto exit;
+				goto exit_unlock;
 		}
 
 		/* get latest topology info for each device from psp */
@@ -558,7 +558,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 					tmp_adev->gmc.xgmi.node_id,
 					tmp_adev->gmc.xgmi.hive_id, ret);
 				/* To do : continue with some node failed or disable the whole hive */
-				goto exit;
+				goto exit_unlock;
 			}
 		}
 	}
@@ -566,7 +566,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!ret)
 		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
 
-
+exit_unlock:
 	mutex_unlock(&hive->hive_lock);
 exit:
 	if (!ret)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
