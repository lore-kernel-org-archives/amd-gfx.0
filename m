Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE610C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 14:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F21461370
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 14:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F21461370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DACE36EEA1;
	Fri, 14 May 2021 14:42:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48856EEA1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 14:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLRcP2oFTL8zgglq2ckKPHuC44eLugEdNhn27sWlPW22rX5vQ2+Da5ZfEE+r66al6usLpwM1Hi+ifhkXJBGubLIqtA84RosN6B1C4M6OVcr5nUyaNQCqoJ28kQws23h6Kw78t9Ytgi0Zgq5CJnBMTWDPlxuhahNOly+H5B9148CBXKjKeIn/ZM1NDXXHfp/RnNh8Lpbd24IZsI1iOIxu3kxdPuEQlLTRdhARw8ZBJfhnbsb+530ZgEcSIfgE+JkjBuA/yHippcQRLTtZMccXRklkZGTCXdq1T/FNr60DCSAoafREnFXxlQ2O2JnuBaoyfGr57JFehY9bI1bIPODBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTrgjm52vQt8P/OKC8fuwoGQH67QCe/67NE94udjdIE=;
 b=XmkYTIkTu0rhFS8HULJSVYFkeDWDscgQfYsCoueBgpGucNC9ftq6xao6B/RLQbnrPfaXyV41pUL9fz9nrEHkOy9uGqON/fyKflZFfgEEu24BH+WgOLXACiWRTgo6+2ZEz9X9cRICbRZ53PZZwOIdzG5sR3OojCrYA4WS1W3V4X7T3LZzZ05mQqf2sXAwa3yfzXnBaxb2aUIJFi/Hn0/ig2UQGwImKTNtU97p/e2XK8YB03bhMTdZnqJ7GqTDaAybXJcSZCSozgcjHuGga1u3s7OQY/DFV9B970eJRQOyvkJrV/AQfg+bGZOtgnaRULCNBoQInp/obqlfXRskX9aUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTrgjm52vQt8P/OKC8fuwoGQH67QCe/67NE94udjdIE=;
 b=XLEx/E/OAbiJbTpDgalIGjqGJ/RcsEoY6I4mNM4DuDNL5p5k4Z0e7RSLkbivttT3fVDj4pqAWbSZ+r6v++7VcLEsWZvwSp0MXj85ydsV8yebGlMznTZZ0mfw1NIwwNmCu6HgErwL/a1CgnSTuZSii7jbasRatq+YyrcGxrxyhzo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Fri, 14 May 2021 14:42:35 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Fri, 14 May 2021
 14:42:35 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdkfd: heavy-weight flush TLB after unmap
Date: Fri, 14 May 2021 10:42:22 -0400
Message-Id: <20210514144222.24206-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210513165855.16395-2-Philip.Yang@amd.com>
References: <20210513165855.16395-2-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::18)
 To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 14:42:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddf8e87e-8809-478f-489a-08d916e68360
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4250A7F3E4BD41761949E875E6509@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWifz+gubdjyfhX8N/nrQDenHgOgGQfWSORuACPFFsvtl+qi5MFKTxOgW5QcJCopMS/sxhl52ek4zW534yWSIwrnHfq7s68jIp384RYrfD1RM5ZMf1d7ReNwepMIOlolNBMVC48LOCBJr2T3lsJp3oKLttYf/wncOGOzG2zsthVqJ/r0BOT5PdyA+cwL2GODsicBMPVAica1MIjkxuoEvh1FbCBuc3+TMnpH7yo1uvRpG53yYXYLE+gRU91hcw2y1J+UXdltaOsg92KgWo1uNHe/5ytye4n8B0YuvWLSFMbCM6fxCpE/WKW5KXqMdMUXiwlmd5BuOks/mQMHEyyhLXbm5ps6mtN1iM8lASWKfRHgdDbg8kXOA1kcFUfYc73fVI+Qor811nkUlZ4KtcCiXq/+ESb84aCEhxSVZdYCprm8AZGgsOdkDE+CVBogqvxsxElbWvkvrQ/g7umTZmewaosujnd/Y+41rKpn4gBPcbF50pAwDGCRIyL8Z25wCazEUeAPu8RjzduBsESWINX9fLKq9tvMD/3gfgnngeELhdg4QS3ROct6oPGpOfH2FnOOrs4OGNqz+t26qhxQ2GKot9NdzG++LqxizjMV0/9OzoyvWD1rGvNZx0AetbT0NhUgT7gTBkMP8q2gfFJ57ytOFCliDejp6qFmZbOQjlgZq7SMooC9e0DAb3FoQtRY8xnH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(83380400001)(38350700002)(38100700002)(8936002)(6486002)(4326008)(36756003)(6666004)(5660300002)(66946007)(26005)(316002)(66476007)(1076003)(86362001)(66556008)(186003)(16526019)(2616005)(956004)(478600001)(2906002)(7696005)(6916009)(52116002)(8676002)(16393002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BvbxOFA0yjlDyWvH12Er/F42N4L6VJUmY7ZqMxTzLCk3DvjD4g+x2MLomUcm?=
 =?us-ascii?Q?OyZQxCl2yzKzH0Sii3UvGi2czL/txaFgsJzCSuEVTCy9ihdAPF4gXBM4yu4U?=
 =?us-ascii?Q?p+00G0PTXpAw1jtCzyRPT6ZWDyPneKsPYcvjBmyg1T+qzGrROeQAWUctutAx?=
 =?us-ascii?Q?cCu0asiRd2KnKCB/RNHLd4zBj42QljdcIg1Szb+0vvpizFWfU0XUWPvogM3Y?=
 =?us-ascii?Q?f8sqtWjx+DTJtRuG5dZ48Qln5nOEh1ppG3mD+sFnC2zCkGggUJ+fUUq5UnCS?=
 =?us-ascii?Q?PoubyTA2lmHnFe93cNsmCaQU+nNsiyYIrzbxRzp5tRtT4vWNn7YpOOw1BZyc?=
 =?us-ascii?Q?/PtrasobsBpyQ1xHXlRulu9Jo58LQECR93H1Jm6huf30mwEL1AQYf5LUkZln?=
 =?us-ascii?Q?uuwNkMNtsPAAXNActTEyCjZKmEP889fiyU9Qy3Jk2wu117zWXnUJShMfttEx?=
 =?us-ascii?Q?DYzQr8rjhZWLP+5BBA6WHH8MSDwoxgT2bHKvl308TTCP7WnK0w4K3RNd6WhY?=
 =?us-ascii?Q?CHa6YMR1FzXFVe785PZzQmv7wnIjK9YaTRhY5OXyelJ0F+9iQcLy3I5tPZ/z?=
 =?us-ascii?Q?Q8+rFMPWdQ0yEfsO37sCVKORNH/ptFhToWpH3rFy1wo7wJr9DkwpPzJGpPHj?=
 =?us-ascii?Q?/1iNjJRG30HW6unWqWiu1hoZ4xPNj+JuYmYt1x3One0VB4G1HADcO0/pthv+?=
 =?us-ascii?Q?cehY9iOKS9Q39ihJb94pzWjx2c8BFPpJGksxV25zYYVh6GQtE3k/ncoxSvLp?=
 =?us-ascii?Q?t8JZMDGXef6TSaEamI/gakHqkYNJuWig+YYBdhHxgnFP/efkuXt3UU+4TJfB?=
 =?us-ascii?Q?rtQ0wpv9oJsQMlLJvPaTH6wMTIGZT3szENoZLB20zAjzcvZW1zFqjK6a38SY?=
 =?us-ascii?Q?cK6dWHOhI1shxe4gJVw7ti3vr2fcRWw85ndgvTUMw58Tl9auzQVSPz799dgB?=
 =?us-ascii?Q?FXLxF76X/acXblHkqdJiMjytrzG2KroeL353pJyr+/dpM+kto3s0K/jsfBCD?=
 =?us-ascii?Q?BKn12jL90JrvfPUxMEPDw0YI9pjaikeI/4vSN2A4GeKq5/amU51KDiTeqjr1?=
 =?us-ascii?Q?8RHC112LQ2KlVZaM4nvlh8u42MBzi2N3403qvyTtACBszJ30KgbA9T1ZL9dg?=
 =?us-ascii?Q?giWXri4zol/JIfkiZcFbIe3+HgvsoeqccB6aiLMWhrLwixKk4yH2JlJBHhId?=
 =?us-ascii?Q?zRfEatq5Pqsd6sWN4mV08Mmk31jwj2DXNbwAcPltUu/uaoFe+2yW4m95UfWU?=
 =?us-ascii?Q?yFWn5vE61eQw/dLfZM8vVOHk4MlTtI8/Bb++UNKXnlqOrZe9blH1Pn79z1xl?=
 =?us-ascii?Q?kyUr7u8EBB7WHW1A0x91VNRk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf8e87e-8809-478f-489a-08d916e68360
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 14:42:35.4039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O07OAfXibnSA2Rx/8JFI1hwvybbIO/+PVfFgHGv9sHKIobJeeuyP5m977hrNRYQ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need do a heavy-weight TLB flush to make sure we have no more dirty data
in the cache for the unmapped pages.

Define enum TLB_FLUSH_TYPE, add flush_type parameter to
amdgpu_amdkfd_flush_gpu_tlb_pasid.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 9 ++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 4 ++--
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 5f6696a3c778..bfab2f9fdd17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -670,10 +670,10 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
 	return 0;
 }
 
-int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
+int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
+				      enum TLB_FLUSH_TYPE flush_type)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	const uint32_t flush_type = 0;
 	bool all_hub = false;
 
 	if (adev->family == AMDGPU_FAMILY_AI)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 313ee49b9f17..f4de50de359b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -36,6 +36,12 @@
 
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
+enum TLB_FLUSH_TYPE {
+	TLB_FLUSH_LEGACY = 0,
+	TLB_FLUSH_LIGHTWEIGHT,
+	TLB_FLUSH_HEAVYWEIGHT
+};
+
 struct amdgpu_device;
 
 struct kfd_bo_va_list {
@@ -135,7 +141,8 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
 bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
 int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid);
-int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid);
+int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
+				      enum TLB_FLUSH_TYPE flush_type);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9d4f527bda7c..5b6c5669c03d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1853,7 +1853,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
 							pdd->qpd.vmid);
 	} else {
 		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
-						pdd->process->pasid);
+					pdd->process->pasid, TLB_FLUSH_LEGACY);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a52e4594785f..f2901e7a993e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1127,7 +1127,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 				break;
 		}
 		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
-						  p->pasid);
+					p->pasid, TLB_FLUSH_HEAVYWEIGHT);
 	}
 
 	return r;
@@ -1183,7 +1183,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 		p = container_of(prange->svms, struct kfd_process, svms);
 		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
-						  p->pasid);
+						p->pasid, TLB_FLUSH_LEGACY);
 	}
 out:
 	prange->mapping.bo_va = NULL;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
