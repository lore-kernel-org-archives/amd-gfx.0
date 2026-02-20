Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8F5C561E6
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9332B10E835;
	Fri, 20 Feb 2026 19:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nvAJ9l+Z";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCD310E831
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQa1fQowywXu0EO+wLkObvn6tnaAxo5RsxrW2OYoPOX5lXHn3Lr07zhW+g7ilzJt8Uuc5a3ktD/CjeE6IfPOdDQNvwf2QkR8mxu3JP5T6ZZLSEx9OBzyiutesAJZSF6+C6MX14b05TXYT+0MRXyXIjgf4tGGYF7HLfMFhYIJrPurW0ZnxlgiDSjcQx+HjZOTr30U+ti5U1lktsT5DXugFlTFjuoOeV3rKybRGbKBllTC6w3ZZfVg8S9Zmrol+Ks85tadR+BlKVfa9COkQR/9l+Lg85/XDKPN0JlprngEKrigcSMDWqB2EnSkFwfMhiKGxP8iCqnReuqrlLu2ulcY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfCiHOn/2Zvow6V6TpkEEhe6f3ht6mzJwYtc8/ez5yw=;
 b=gIa5b1ju4cnOs64wpblAp05UKdGZ8nl8B9UslIgRcPbUx7v93W3XTguo4zKuxSu0F3ur7fIeUFze2JH1AywjPtPnJmjgguIPfRaUFDDskTz/CkcipndYO0PxlLkRmWYya9d0TQ+xLugE3M4DiUoeC7wa0eCT9F0PVQVG0VXJ5NPyssyS52Uv4UfrQqOaeIzAgPsOsG2/enYLPKoQf/KLMdn59kP0PzKNMIcKS02avUJgHmIlM/fIF6zFspIalsrmZs25M0M2EROEKDJDwgrT/ghcL5+A+eiRa7mC5a/XG3E/WBdmaeA2RrxWAgbTGeDeKONwwmMujZVQ/8LFwF6xAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfCiHOn/2Zvow6V6TpkEEhe6f3ht6mzJwYtc8/ez5yw=;
 b=nvAJ9l+ZJ/uNXeXPkNRcTVFzqJGvTeUmIsUGcTQSJW9tSOybVWsnUFRmT+4Bba2WxRmrLvp5k63LnPXpymGijOY+7iXUiuwcnRsi3At69DTjcSS81J7WH2Aw65YcdwGSMYvGR3iizrIBROUuIYZVC5pWeajXcbCoDOAxcm4BlTw=
Received: from PH8P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::32)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:23:09 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::8f) by PH8P221CA0014.outlook.office365.com
 (2603:10b6:510:2d8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:09 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:56 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 14/17] drm/amdgpu: workaround for spm ring buffer overflow
Date: Fri, 20 Feb 2026 14:22:33 -0500
Message-ID: <20260220192236.3121556-14-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 176a39c9-4225-4f54-ee64-08de70b57b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ttNqPxGrUd6YutNfuJQPdbgdJGSygUD2S3pielIFka5kbvsSnp6Ubwz6PK6v?=
 =?us-ascii?Q?OGrOSA/54hufU4qHToFAkcavvzbQqEljXGd0YOMmNAiCe/aoSz91KdsZmwU8?=
 =?us-ascii?Q?w9XPU8xAdpf31uF46zzEMYnFx9QVT4qjVmYOPR1oyLRJSSHJipQvdsmmUf52?=
 =?us-ascii?Q?M3aQOcmvjljQB++jhwVdDGVmVjDEYjmuFUGNBzDcku82LlGYy1ZX8juWzTse?=
 =?us-ascii?Q?2mx4t+cE6U7nAvS94ahWq84fZT7qQHthlWIst4FU90y9QM3dcaetKRpR1m8L?=
 =?us-ascii?Q?fZNzjwCyKOBqLYanmERip2TsOdYbxFpqTPZdr66yg7lasyEVVNAnvzU3mt27?=
 =?us-ascii?Q?M94kpLFCEhZZXWuKa1QmkAFjdJizHETcEfgtIuEht9xkLFIXATSG02yBdyFk?=
 =?us-ascii?Q?rfpxdteFwFpmhMZhh7GAwmqYTrPtV36rFr1qIBhXmyMIKrxeYbRk/V6TRZup?=
 =?us-ascii?Q?k4e6m9erZdn78vwyWC+ZXSAfwr0ypsebqieay+MRvaS+UV2zyMeCZ7+1AN/q?=
 =?us-ascii?Q?MpOov+v8Zpbf3ZrK4oFQy1+53VdC/IFP6Mg700NwCw0sbpEG4PDzhrG0UjyA?=
 =?us-ascii?Q?ODCLxU8GfnLACM97YenfEyU0NNPYeoAcOdRvhUq5/9C+bypFN1tGeolaMbVJ?=
 =?us-ascii?Q?kXSQvEQRV1dgaQee/zAwgODAwPwZad7iS8t3erU/YiWx86Hq3nXcHxWgGBkZ?=
 =?us-ascii?Q?n4rWwxA4iaXa8WvXuhil+NRW+8v2eIZ2sE6gGRruODF3/CB7gG1s9A1sP5dY?=
 =?us-ascii?Q?75Weg1WaQkPw09eZnKyVe7ecf23GBaGZil/XHIihTBZT/267gEgT8ifW6KEF?=
 =?us-ascii?Q?s3uMX3MvQ5MCKI3GSAyHR1SIt8W3n27eVAU8hNTOt48+Q5bzotsW2e1wSgKf?=
 =?us-ascii?Q?iexUBmXljbR0yyCA3QqE/sl0clXAMbflmWkrxqFuthhWZdrLg8KPoKsBoL7x?=
 =?us-ascii?Q?oQnq5YIvjWBxyFLR3/XG6L+Yfj/TSbjE3ZCqGRbSC8lWHpwsHv7LcPamV7RW?=
 =?us-ascii?Q?6Uhf3IH3TuuPP20vr/CZZ8WH0Azr7FXGahpIdR4O41lQDFAxGt2bxJZBXYqW?=
 =?us-ascii?Q?fPWt13X6yEi6GZSYYiyFm9BDgsEjVdYvGpxEdGV6vzk9iyLandFV/1AHvsY+?=
 =?us-ascii?Q?ATNzagrc9/+YPtzjFPfyUHYnmSw8zjwrDLuoLEBnl+S6POI0HvxdReXKm48J?=
 =?us-ascii?Q?ojt7IX7x0CXPgilrMNNGsRVlA/uAKpEC7rg8jWDDJEn18ubPicgPUbApvSs+?=
 =?us-ascii?Q?6vSmIWZdVOixQU1zfXfVgsuFQIpSWqLCr4zlptfWVTtHKrqO3WXl3Mj2c5cr?=
 =?us-ascii?Q?NsA1h5k2V8UR0DLHaS2Xo159QFxFgJbeV0cnLgcKyzQeXempT4z/ZDwmHssd?=
 =?us-ascii?Q?7UAGGvmGMdmlsopsqL9jfdT/kSotgb8Kk08boTOxIQO31IFL9al7lp5D36ue?=
 =?us-ascii?Q?LX5rDPPhfTi+Eg8CJ5tmdwfPrFw+mcy6I1bTyLHHlIT51DeHkOSavpHKFvtO?=
 =?us-ascii?Q?rc3hvA9SYfobfkGSQWeICUvGELqzZybZxs0ZeI29H6a3+dP+4CyCZveIeerY?=
 =?us-ascii?Q?+5BtmBKJRUMKziFdS1lLMdGKyi2sk6v1s/bGJ8ql0PZWz277j2G4oNTuMwer?=
 =?us-ascii?Q?gC8a2X1N6llfx3YBbIw3k2wrby/lO9yPHWi3nrGqCNikBiaxtSgOK6MlBGrf?=
 =?us-ascii?Q?d/jU5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DkzM5UpfVe3cxbpv/GlVW0Pa3Xy+4eovWGz0wVV+/298ltaRq1SQLy3dq8+ItcBMsJgzroL7WBTcPLJJ/SUCuV7oMGnmicWN6UA8tmlmQ6ln2FA34xxlRYxkg9FpKxbnGzeAt7jtrusSY/jc15QV2ttWCN92/QpkG5Fvfj/XEt0RsiDO6uhW1zwH3nPLUYTldxZnP3Jc9Su7VTef2lvyOW0Qde005v+iU8FgVLznnyx1PW9MHNd38nhgVyP6jDqGpXoigHc5Pgfwmni35ZDPtkR+p5AoIS2u5D0+SHG5s6mfJCrWvfNGkl0dflRJCIyNtraKV9F90DcXiJqrwYuSpwZdqJKS2o9GYD8gT2cASACksDQ2y4527ul2fVTqLI+gsapoLjKnP9Q4MsMwVGKDz2INBUqQ4g1necVpeM0lRrB8+EbVXUIYwnnAadhes/ut
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:09.0059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176a39c9-4225-4f54-ee64-08de70b57b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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

reserve space to avoid page fault and data loss.`

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 41 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 7acbd966cd3e..f09c237cc8f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -60,9 +60,24 @@ struct amdgpu_spm_cntr {
 	bool  are_users_buf_filled;
 };
 
+/* used to detect SPM overflow */
+#define SPM_OVERFLOW_MAGIC        0xBEEFABCDDEADABCD
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 
+static void amdgpu_spm_preset(struct amdgpu_spm_base *spm, u32 size)
+{
+	uint64_t *overflow_ptr, *overflow_end_ptr;
+
+	overflow_ptr = (uint64_t *)((uint64_t)spm->cpu_addr
+				+ spm->ring_size + 0x20);
+	overflow_end_ptr = overflow_ptr + (size >> 3);
+	/* SPM data filling is 0x20 alignment */
+	for ( ;  overflow_ptr < overflow_end_ptr; overflow_ptr += 4)
+		*overflow_ptr = SPM_OVERFLOW_MAGIC;
+}
+
 static int amdgpu_spm_data_copy(struct amdgpu_spm_mgr *spm_mgr, u32 size_to_copy, int inst)
 {
 	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
@@ -141,6 +156,22 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
 		size_to_copy = ring_wptr - spm->ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
 	} else {
+		uint64_t *ring_start, *ring_end;
+
+		ring_start = (uint64_t *)((uint64_t)spm->cpu_addr + 0x20);
+		ring_end = ring_start + (spm->ring_size >> 3);
+		for ( ; overflow_size < spm_mgr->spm_overflow_reserved; overflow_size += 0x20) {
+			uint64_t *overflow_ptr = ring_end + (overflow_size >> 3);
+
+			if (*overflow_ptr == SPM_OVERFLOW_MAGIC)
+				break;
+		}
+		if (overflow_size)
+			dev_dbg(adev->dev,
+				"SPM ring buffer overflow size 0x%x", overflow_size);
+		/* move overflow counters into ring buffer to avoid data loss */
+		memcpy(ring_start, ring_end, overflow_size);
+
 		size_to_copy = spm->ring_size - spm->ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
 
@@ -159,6 +190,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
 	}
 
 exit:
+	amdgpu_spm_preset(spm, overflow_size);
 	amdgpu_rlc_spm_set_rdptr(adev, inst, spm->ring_rptr);
 	return ret;
 }
@@ -198,6 +230,12 @@ static void amdgpu_spm_work(struct work_struct *work)
 
 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
 {
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+
+	/* pre-gfx11 spm has a hardware bug to cause overflow */
+	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, 0, 1))
+		spm_mgr->spm_overflow_reserved = 0x400;
+
 	spm_mgr->spm_cntr = NULL;
 }
 
@@ -224,6 +262,8 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 	if (ret)
 		goto out;
 
+	/* reserve space to fix spm overflow */
+	spm->ring_size -= spm_mgr->spm_overflow_reserved;
 	ret = amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
 			spm->gpu_addr, spm->ring_size);
 
@@ -236,6 +276,7 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 	if (ret)
 		goto rlc_spm_acquire_failure;
 
+	amdgpu_spm_preset(spm, spm_mgr->spm_overflow_reserved);
 	goto out;
 
 rlc_spm_acquire_failure:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 075ad7eaad01..f3d812fa4e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -32,6 +32,8 @@ struct amdgpu_spm_mgr {
 	struct amdgpu_spm_cntr *spm_cntr;
 	struct work_struct spm_work;
 	spinlock_t spm_irq_lock;
+	/* reserve space to fix spm overflow */
+	u32    spm_overflow_reserved;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, void __user *data,
-- 
2.34.1

