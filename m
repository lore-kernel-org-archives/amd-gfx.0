Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD08C54FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EFB2076C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="34XOvBSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EFB2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A656E888;
	Tue, 21 Apr 2020 05:24:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68916E888
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 05:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVWG2fAO4cklwtwLyiofcGwPUeXij9DaauGx4CFAE7WuRPsbzg2DT2qFR+klhhi15SSBAQcQqQ2muVErAC83pEbqXXfLaipVTzZaE9dLsyQddD4tpjK5B9e0QJaLXz53R44CvgGEZhMGnXL50gfLOv5rt45CdFL+erHtlr60kUd3ZAVrK6lNdGXV33CVKjyizbstdHuQv7lnjzXiXIUXCU4yF0B0vkTj/mdG2LbnMJnd039BWlt9VStvNvZcxCFTmAh0YHbDC2UP+ACzT/gsZe6/Wnrd7Tm9Cn+ibHiv3hBiCe4FBMV4sH5NVf1YkxCmpBGJCZyTX5vC6WvNpkAmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQwFLXxUvi+dDBuAvg1+a20IIIDJDC3c7fCVGrCbiG0=;
 b=nHCz4JZ5kWUg5u6xOvweaPodYYigr0k2UPZLp/g0ERZJm0BM2rll6JtJkvBIdAxOJJwYoeEbbxOSmCCNOA029jCBXnaz1EgllhqD9RCA83L9vSGfidfwzn/S8A0zqwt63X0Hh4MuugjJyCafPg6I6zLQGeSLdr0+Lb6s/DIkXyojbEJ/nvaYYE3uHaxtAjKi5PJdH8Adv7JGnvgg5c8fn7JklmnozktNzSP8cPUEqnK9CKEUqIGbF+MNj5JW+K7m+4Ea/g3+FTfJM6BfRx7+76HNlqbwCxul+xzW9vP1ujFtLeWlWcWa+AALYVAc44UvGOUAIDktoPK8OFxR/mgTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQwFLXxUvi+dDBuAvg1+a20IIIDJDC3c7fCVGrCbiG0=;
 b=34XOvBSQVATDr7b6iB0FuVImb6G93naZRYldEc/QglwuFH2NwBKMxgm+UVesrbFa3vapprErm3SE4pyZTgjsTIbCfIMYqCj8tFQyPlH2zP2rH3agQMhzVBLg+O6xmeEjCDMP7PTFRw9h5+I6vm7vdPeo/DNexc8YIzsTJAvt20E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 05:24:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 05:24:49 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: code cleanup around gpu reset
Date: Tue, 21 Apr 2020 13:23:42 +0800
Message-Id: <20200421052342.23037-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200421052342.23037-1-evan.quan@amd.com>
References: <20200421052342.23037-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:202::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.6 via Frontend Transport; Tue, 21 Apr 2020 05:24:47 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ee113f6-c30a-4bed-850e-08d7e5b45006
X-MS-TrafficTypeDiagnostic: DM6PR12MB3164:|DM6PR12MB3164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3164978BB9BAF566EC6BE29DE4D50@DM6PR12MB3164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(2906002)(2616005)(956004)(6666004)(44832011)(6916009)(36756003)(8936002)(81156014)(8676002)(86362001)(7696005)(16526019)(5660300002)(186003)(26005)(316002)(4326008)(478600001)(66476007)(66556008)(52116002)(1076003)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aPn7/DHxeJgfJ/Q4AafjbezxKjkjBjGdUlwXJW64llrhZpD1TJMTEU3aBxcuDMktiitVA4BWI6kL0PTcRRVRXmnjEkUoE8wpYnDg0CnVaaOdeMn0D2uXHGlciLYneP6/caGxY+g2D+4pNMIhzYifYgAURA1oOVT4dDuexKHkXaxHQc2kqQPNwYMsoPy9n0BLI9tmPG/JIX9Etvm5EpJBHhQNvUri/my21iNi2KZxDhHKImPTrstfYjsC8PP+gNUb1pUmOSRlD0IKOxSLNP5z7cURRyt96Zgxb5WOq+aLDeubacGEbmTTXB5lez+ieXt4UCJZBRV/Os0MVi3efgLDaTdNGniJVTwLoaClsSFdv3CcNZmlvUlvgJzHQxD6dpyiOcauD63pmY8JyVlOPPvA6u3Dnz/Lt8Vsx2plhLBXDuhUSHvvsd8Nd3zSO7Fvk8n
X-MS-Exchange-AntiSpam-MessageData: YoAGoyzpCo0sFibYAGyUwFE0FfA5jsZB+WynQPXW3f2y9xk8Rdi12a8z0sIhn38+lkvQwcooRJ7LtQjWZb7w95Q8n6Noh7LKzL3kLZ8HuWyZJBSAkNHfT63RU9MN9MxPAM3ARD/1rNiGJd9U8KwC8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee113f6-c30a-4bed-850e-08d7e5b45006
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 05:24:49.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31jSCZbqZ3NzDf4rcrkGeRqbv1F2ABQJoXRXKsdEPhmAEoqhlaAr4hltIv5qmlgH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
Cc: Alexander.Deucher@amd.com, Andrey.Grodzovsky@amd.com, Jonathan.Kim@amd.com,
 Evan Quan <evan.quan@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make code more readable.

Change-Id: I28444f285b23aac16be421e3447d0de6c3a57ee8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b415c1e5ea0d..349c8f85fc8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4160,7 +4160,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job *job)
 {
 	struct list_head device_list, *device_list_handle =  NULL;
-	bool need_full_reset, job_signaled;
+	bool need_full_reset = false;
+	bool job_signaled = false;
 	struct amdgpu_hive_info *hive = NULL;
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
@@ -4181,13 +4182,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		emergency_restart();
 	}
 
-	need_full_reset = job_signaled = false;
-
 	dev_info(adev->dev, "GPU %s begin!\n",
 		(in_ras_intr && !use_baco) ? "jobs stop":"reset");
 
-	hive = amdgpu_get_xgmi_hive(adev, true);
-
 	/*
 	 * Here we trylock to avoid chain of resets executing from
 	 * either trigger by jobs on different adevs in XGMI hive or jobs on
@@ -4195,7 +4192,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-
+	hive = amdgpu_get_xgmi_hive(adev, true);
 	if (hive && !mutex_trylock(&hive->reset_lock)) {
 		DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 			  job ? job->base.id : -1, hive->hive_id);
@@ -4262,7 +4259,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		}
 	}
 
-
 	if (in_ras_intr && !use_baco)
 		goto skip_sched_resume;
 
@@ -4273,10 +4269,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * job->base holds a reference to parent fence
 	 */
 	if (job && job->base.s_fence->parent &&
-	    dma_fence_is_signaled(job->base.s_fence->parent))
+	    dma_fence_is_signaled(job->base.s_fence->parent)) {
 		job_signaled = true;
-
-	if (job_signaled) {
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
 	}
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
