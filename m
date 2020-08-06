Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5874C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 01:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B977B2173E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 01:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xb13MIGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B977B2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E5B6E10C;
	Thu,  6 Aug 2020 01:32:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420EB6E10C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 01:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCe1u5emcBeMsctOxRNx66jefsr/d0fXDDVtlz/DLLeLu/Jpf4GQXf16jCA4bORCKgz7n4KAxatIflff+mChR3OEpRsHZZTfnUlYImQowmt1Re8wnX0kHbRlLCQaJFInTsq4R8aDx7fO3sOk3fpmRDsXVOctotAClen7GAnUUU030RPwDFmBJsp2kSKh7S47/9Kdv1ILdi9O3qmSDV4Ka28M+F5HHOIiwVBgKUe1xP2wN6O2HL97vIvc9387P+oap0oFGB+st14ACIqaRjOGJHY4FJIPUQb9fIWhYj31v7kKkt3kdlHIvBwN3Zwn/SSwGwGW99fpBD7K9EGHAKERBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ja0BTQ8zjeSrDkum1OkeVPgOyKDHCTMvfiPp/AVazo=;
 b=BdOQS6TAHnl3i2gNl/XXke4hLVP1F6eyiHXCgdgP1e3iSIva1lEX9jZekvres9NNq4yOjR5Mg4WeFzXMIPLhaBU35jJrFtzdq9qv1jo+OChxayNtL4haQ/ZImmhDtRm4gCZm+71j0M/zoE8XL6IqpYrmnE5FHrmeeAsVH6fDLLv3yrPxZvXQ3M3sOBUfHOKzAM3IAmIA8JNLUUQSnbPszAEbObDE/aQzYKVOcuZGk8Po0sFx5W/ZuVAG+HUYC4e4v1o9fEGnDhKam2Nu+T3+6pmjhPKDO10yzYcjJHUyD4g6o3zr/RBZ7ctLp/IgGTfAp3NkQb9gNiCl+fE9zOSwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ja0BTQ8zjeSrDkum1OkeVPgOyKDHCTMvfiPp/AVazo=;
 b=xb13MIGN2CezUFiDT/89TQHdCVTJ0GgPbl9j5mZtcsulpPtyHFjDUYnxqoo2RYkBpyViPvMCvOIkuJXuY9PaOSsE/9Cz9VeuxO/er8ZiYOOLtI9HPuJ/1SL295eVttLrwjEdTB+nY9C3CDzuc0bpK3LNLSY5kJK+XVgpTjO6GDk=
Received: from BN6PR16CA0011.namprd16.prod.outlook.com (2603:10b6:404:f5::21)
 by BN6PR12MB1251.namprd12.prod.outlook.com (2603:10b6:404:1a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Thu, 6 Aug
 2020 01:32:02 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::3b) by BN6PR16CA0011.outlook.office365.com
 (2603:10b6:404:f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Thu, 6 Aug 2020 01:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Thu, 6 Aug 2020 01:32:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 20:32:02 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 20:32:01 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 20:32:00 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <luben.tuikov@amd.com>
Subject: [PATCH v2] drm/amdgpu: unlock mutex on error
Date: Thu, 6 Aug 2020 09:31:52 +0800
Message-ID: <20200806013152.32747-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2a23739-816b-4aa1-e272-08d839a88538
X-MS-TrafficTypeDiagnostic: BN6PR12MB1251:
X-Microsoft-Antispam-PRVS: <BN6PR12MB125143B24698E394908CAE85ED480@BN6PR12MB1251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmeyxTugxUXPSpizLKy0/kYCD9oRF5O2jdiQ/EvXtrMsvRZRuD7PLEu2X//GxAse7fOEYM5Yxv9Xsk7OYod3ifOuxjH3jqWn9Hnh/fNuda9bLwbEtNRZdJBuxpKUtduozKM21S/C08FWQcvsETZffTuL+9ymTRnu/BSVw8Inl1cwxDMGeckAOvJ05t82Rf1gejwF/5s+tbkiNA1zbVSZYvwEwsfs7xRWu6LLowX7UYfU2mBVGLle9QY4U2xPYdO3WMps9Rd7zU0dJ5bSLH8Hk2jfNAkDEVYFYm+9OWc83VZMmc4fKa6dCPSqxPLpaUeRdoNqRJqv03KfrKPRGGFtdNlrXIWP8AVq8troFwmYub790qb98Lrz2If9uhfsaXkNH0X9UF7ci/nxY7Cmgk/APg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966005)(336012)(2616005)(426003)(478600001)(47076004)(8936002)(70586007)(5660300002)(6666004)(70206006)(7696005)(82740400003)(316002)(86362001)(1076003)(110136005)(36756003)(186003)(2906002)(356005)(26005)(83380400001)(82310400002)(4326008)(8676002)(81166007)(6636002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 01:32:02.4892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a23739-816b-4aa1-e272-08d839a88538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1251
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

Make sure to unlock the mutex when error happen

v2:
1. correct syntax error in the commit comment
2. remove change-Id

Acked-by: Nirmoy Das <nirmoy.das@amd.com>
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

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
