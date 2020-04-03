Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42879C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 18:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C5A206F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 18:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A+ThNQlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C5A206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06A36EC69;
	Fri,  3 Apr 2020 18:45:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9216EC69
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 18:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMJrTjZBfk24e5STKO3HKhKnyfbEIamdDXLYvSHqTaGtHVN3ynOy4OMF7ExBtM72UnyoIuWZHwEnnRL4M8zbTGl/RQ+9Q2OE+5fEFBTEG2DuP8c6UR4UhrkenDTbgh4SdOnGIBLR2MQfjsLTbzrSKVZjsCijQee+yQYFLHC5Wl7GcWDcxMHRb9hU6ZDcY8NkgCJXZOTtN4hIeScDuEPXOSsSd0AEugLG322b0jJuRzcj12JsO5di0zsVIoRBFTt5a93l1WcOfs7ikqMgpdR5I5S0MWfDivoW9PStEsCGDFLr2AT2x+U9Cx9WpkCEBeQpsVnyD6v6VoUaLr2pY/uJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2RKJLvAH+GZoaIBgkOwUq8OW6dU4d0KI1ITWp51G4Y=;
 b=WDGrz1PKid6N76pL7xQUX7ComNXpkLIASSNjTXTmu+RIJ57FDRsB3HHUocPCIcmNX6rtGQcukYIU5tIaNPsFr8kTaexgOEvSw4tT23Dj/xzBtlKNIXzTnRwWxPPzZQcFhkL+2zzkszY2b6W/U3LcLXZ1umrsXnTA70MUXUShznFPFIz6HxlkVmNf06liubmBiuU7Q8rUIhfkJsMtDJp0Fhf6mND05ZgVLqzISu+5Z3T0E1oU3Rag/xOj0CHD0SaLjFK6hdAkxpUL5zO+KFnJwvuTVYMJUU9Ta2ew7WLv3Qg/XFmSBC9srJl/iUCsE8668KkVsaJUa0Y2i5u1P4fSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2RKJLvAH+GZoaIBgkOwUq8OW6dU4d0KI1ITWp51G4Y=;
 b=A+ThNQlFtD1snQvsuksybhufEg1UCV0XDa4mpZ+A/lTSAN6KisIyFJt/1HW6f6tUM3v54u504xJULSXoYZ4v1igff15WbWfZfhZpKSSD6cPRusjaSUEXHzoOQkyhMQDlCZ3HLwcEvqy6VUFPcG70l1LtHsWWfsMroZ0tUkt04FQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1563.namprd12.prod.outlook.com (2603:10b6:4:a::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19; Fri, 3 Apr 2020 18:45:48 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 18:45:48 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu/vcn: add shared menory restore after wake up
 from sleep.
Date: Fri,  3 Apr 2020 14:45:36 -0400
Message-Id: <1585939536-27177-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585918324-16780-1-git-send-email-James.Zhu@amd.com>
References: <1585918324-16780-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::25) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 18:45:47 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9d720b8-31c4-4812-7c87-08d7d7ff39a5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1563:|DM5PR12MB1563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1563E9FD48234E3447F38E20E4C70@DM5PR12MB1563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(956004)(2616005)(5660300002)(86362001)(81166006)(66476007)(66556008)(81156014)(8676002)(6916009)(66946007)(8936002)(2906002)(36756003)(6666004)(26005)(6486002)(186003)(16526019)(4326008)(478600001)(52116002)(7696005)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuQxFunuXfNdbvtfSLuAKKtOT0o/lzfx7xQPbWX7x9pA1TQsubMPrVJ59lz2H9I18U8wk/6DofNQvOAL53BjPK7msUXa7dbrXhabtNUT4oGjAvPVsyqELjxtRlcFk1VOv4nFMoXPb50Zsrj4Y9xorYPxFU7TrIdKAQJ8qEHxA3fQZ6tTA9eU/0rlqwfMWqlxOcb+Z9u/UTLUAPa7MaqwgH0/nYegsl11jl255Gls+LChX3/RF5BLGH7ogp8xFLcIrhodTFjGNxceMmm0gnO4mtChkqh2VDsdCbG2sdLrcW1FZ3G+9ferbLrq3cGV/Nu7FkYdrVlj/34V5mSDABjrfxImg+kG+hJ66oi81RxVj6qZMIJ46wfh5+EZOeBXZdFjpdZ55wc8sb2J6ZDeMHbZsXtnGaZWGte8b6x/yLe2UcvFnsARUvYHGcwon/Yuwted
X-MS-Exchange-AntiSpam-MessageData: ayOCHffQLE8evWJyN5mWhv+eFB1VBrO1BkqyKFndanPnRMk2FrMGov5APYjBeWxE+MRJ98ltd9FNV0s0ZX/JGUGLPX5rAF/vt/32yB6KbkPrRoF45JyHqOMmanMmm2RikvJaIoaho7oXwuuM8ZAPhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d720b8-31c4-4812-7c87-08d7d7ff39a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 18:45:48.2921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMoUXlmLTKbTEoZMKC7peKZmpQYuD9avIaNj/nbY6uaUwgSmCL5UFZo+WbCSHfNn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1563
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
Cc: Pauline.Li@amd.com, jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN shared memory needs restore after wake up during S3 test.

v2: Allocate shared memory saved_bo at sw_init and free it in sw_fini.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 +++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d653a18..dab34f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -56,7 +56,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 {
-	unsigned long bo_size;
+	unsigned long bo_size, fw_shared_bo_size;
 	const char *fw_name;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
@@ -190,6 +190,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			dev_err(adev->dev, "VCN %d (%d) failed to allocate firmware shared bo\n", i, r);
 			return r;
 		}
+
+		fw_shared_bo_size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
+		adev->vcn.inst[i].saved_shm_bo = kvmalloc(fw_shared_bo_size, GFP_KERNEL);
 	}
 
 	return 0;
@@ -205,6 +208,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 
+		kvfree(adev->vcn.inst[j].saved_shm_bo);
 		amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
 					  &adev->vcn.inst[j].fw_shared_gpu_addr,
 					  (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
@@ -254,6 +258,17 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 			return -ENOMEM;
 
 		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
+
+		if (adev->vcn.inst[i].fw_shared_bo == NULL)
+			return 0;
+
+		if (!adev->vcn.inst[i].saved_shm_bo)
+			return -ENOMEM;
+
+		size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
+		ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
+
+		memcpy_fromio(adev->vcn.inst[i].saved_shm_bo, ptr, size);
 	}
 	return 0;
 }
@@ -291,6 +306,17 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 		}
+
+		if (adev->vcn.inst[i].fw_shared_bo == NULL)
+			return -EINVAL;
+
+		size = amdgpu_bo_size(adev->vcn.inst[i].fw_shared_bo);
+		ptr = adev->vcn.inst[i].fw_shared_cpu_addr;
+
+		if (adev->vcn.inst[i].saved_shm_bo != NULL)
+			memcpy_toio(ptr, adev->vcn.inst[i].saved_shm_bo, size);
+		else
+			memset_io(ptr, 0, size);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f739e1a..bd77dae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -194,6 +194,7 @@ struct amdgpu_vcn_inst {
 	atomic_t		dpg_enc_submission_cnt;
 	void			*fw_shared_cpu_addr;
 	uint64_t		fw_shared_gpu_addr;
+	void			*saved_shm_bo;
 };
 
 struct amdgpu_vcn {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
