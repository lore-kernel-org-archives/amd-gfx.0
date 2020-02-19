Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2CC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 10:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5F3207FD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 10:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nuhsuM4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5F3207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F796E58B;
	Wed, 19 Feb 2020 10:15:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E0B6E58B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 10:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH/D8D9si330UtFri1rSC3L2STBNoVmykW80kV6mr2ogqtFUYYlohWRPDSYnEiP+CXra5n2M4JMJ58qNIeQ+tGXnGg6ShrrZbAhZiv6iAAmg0KDz5vMuA2qMj10OW//yFNFLuyPJTpoblR6q77VEJJ8UquMLnAWQ4W7T/tYsnCiDuuE36S/dFhwDptvHl+6NXVGHEx2fXmKjG5cil2EZQvtAtiOsxM+I3Y17JuhaJqEkeQw0plotxBmMJ4uT+vg0YM43eI+8ZovKXEsriTiC/3SYrMuso3jueIVS//eyjmgyKObL3LkwD6rYxtZ+ZI1CLU67Uj5AR7MHV5wWizQZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivgX7bVYOedHlwMSD0pXDouPFMoSi92hzwcMcRia4Zo=;
 b=EObbzzZ2X9tzMn/P8aSnQ/UlUFcM79s/bIaoiKJLe71QZSdyCSP8LAjagOCK/pX4utZqFp4s/Yt57S1wo394HR/AKmkIG3ObcEgPUezMOlef7iGqpgehMmtrOX6xKhdHTJa7h6MksewS7erG73HzSI/AURND46VlNHXO9kUanukKnOj4YbXWj7RUQ1gBGu8dWhKg/7QskSTNQQR79vcvN+BNxYyo0YQ379ovyJVtV942yXUqFj39LovUoL4G3C5ghsACSC+uxCn1/eprxVxf7jIxmKF3sFqD0eFWvGNvzIAYWQ75YkdyLxq1SMIzyteX/ghs0aNi3iKUoc+s+7io0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivgX7bVYOedHlwMSD0pXDouPFMoSi92hzwcMcRia4Zo=;
 b=nuhsuM4UEQrmMnjX5AdGe3SnRsggxq6+CMQWcWXqUtvrkWWpyN7pRRjsPfZ6Im6oJP+Hw4m2o/313DaKgUCctSq2IlCEQOujNtzHS1aWlLr0LnA1QVNyNPITwBOdqB6eUD8vxeU9sumxjG30Gegxgi5a+jlzEvTNVGtu7glc63E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (20.178.240.148) by
 MN2PR12MB4336.namprd12.prod.outlook.com (52.135.51.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 10:15:31 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:15:31 +0000
From: Jacob He <jacob.he@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Date: Wed, 19 Feb 2020 18:15:06 +0800
Message-Id: <20200219101506.16779-1-jacob.he@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0055.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::19) To MN2PR12MB3376.namprd12.prod.outlook.com
 (2603:10b6:208:c2::20)
MIME-Version: 1.0
Received: from jacob-Linux.amd.com (180.167.199.189) by
 HK0PR01CA0055.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 19 Feb 2020 10:15:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23ef6f1b-15d6-4ba7-86fa-08d7b524a64b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4336:|MN2PR12MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43365B8B1737B64BB54F80809B100@MN2PR12MB4336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(2616005)(52116002)(86362001)(4326008)(1076003)(956004)(8936002)(6666004)(478600001)(44832011)(2906002)(16526019)(6916009)(186003)(26005)(6486002)(316002)(36756003)(66556008)(7696005)(66946007)(5660300002)(81156014)(8676002)(66476007)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4336;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ly/QcRj3MvO+8ogYhJl6LvflB6EhrvT3vn7vklLLHF3YoRxK0cejNfuNBC0BRTJ2gYUddXOdJVGdJNwGcl+9tQI9/FhkHC456PSbMWILPy7YasKVliGWmA7wMsKjcV99TYizIzirYD7FLzM/jYUtZplBrNv8efmOtoV8Dyex3k2aG8R2mcqg/4bDZr9UNUiyWcMq57+Fk0TxXKsWdBw/f61HI42kPWa/nCNwIVMkxJ0Bj+Me7g5Eam7d3WG39OcpfqWg5DNmVo0f+NXV3/XkPg72foCsCfpeEfrg8EzWRSrE66jfUc3rbfmG+4cCynODyiQhYArEMachLjIR89OjHrDU9blvmEmVoBYmqjtgK7h8YjoZ1fx5/CtmGQwXIvHf7g4d0Wgfe2n82QLuMbXQaZR2/224et/rwfIgC/VSG3/Jd2XJwke9GG33NDURQNVQ
X-MS-Exchange-AntiSpam-MessageData: ZBFdvJN3+2+QLkEYIo5yDTNHucwHmbFltPQTv0FaGspZgajGWG8Jjx5tKhZI5C+xQBLhHnKQlYKoFyxnTJzLFv2i+RnJZjXv2CQj25Lm8MtM0PXF25du8IwCrZtd+gPs+TFZhb5dgi9HpcdNZmBBzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ef6f1b-15d6-4ba7-86fa-08d7b524a64b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 10:15:31.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib4iXXkHwU6DczQ6mzQn2jvk/j1/ElSYypu6CKyOPgYdNHqgb9i71FhBue8F8x7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
Cc: Jacob He <jacob.he@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
When SPM trace enabled, SPM_VMID should be updated with the current
vmid.

[HOW]
Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us
which job should update SPM_VMID.
Right before a job is submitted to GPU, set the SPM_VMID accordingly.

[Limitation]
Running more than one SPM trace enabled processes simultaneously is
not supported.

Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666
Signed-off-by: Jacob He <jacob.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 ++++++++++++++-
 8 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index f9fa6e104fef..3f32c4db5232 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	uint32_t uf_offset = 0;
 	int i;
 	int ret;
+	bool update_spm_vmid = false;
 
 	if (cs->in.num_chunks == 0)
 		return 0;
@@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
 			break;
 
+		case AMDGPU_CHUNK_ID_SPM_TRACE:
+			update_spm_vmid = true;
+			break;
+
 		default:
 			ret = -EINVAL;
 			goto free_partial_kdata;
@@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	if (ret)
 		goto free_all_kdata;
 
+	p->job->need_update_spm_vmid = update_spm_vmid;
+
 	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
 		ret = -ECANCELED;
 		goto free_all_kdata;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index cae81914c821..36faab12b585 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		return -EINVAL;
 	}
 
-	if (vm && !job->vmid) {
-		dev_err(adev->dev, "VM IB without ID\n");
-		return -EINVAL;
+	if (vm) {
+		if (!job->vmid) {
+			dev_err(adev->dev, "VM IB without ID\n");
+			return -EINVAL;
+		} else if (adev->gfx.rlc.funcs->update_spm_vmid && job->need_update_spm_vmid) {
+			adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
+		}
 	}
 
 	alloc_size = ring->funcs->emit_frame_size + num_ibs *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 2e2110dddb76..4582536961c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -52,6 +52,7 @@ struct amdgpu_job {
 	bool                    vm_needs_flush;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
+	bool			need_update_spm_vmid;
 	unsigned		pasid;
 	uint32_t		gds_base, gds_size;
 	uint32_t		gws_base, gws_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index d3d4707f2168..52509c254cbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
 	void (*stop)(struct amdgpu_device *adev);
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
+	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
 };
 
 struct amdgpu_rlc {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5e9fb0976c6c..91eb788d6229 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4214,6 +4214,18 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	u32 data;
+
+	data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
+
+	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
+	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+
+	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+}
+
 static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v10_0_set_safe_mode,
@@ -4224,7 +4236,8 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.resume = gfx_v10_0_rlc_resume,
 	.stop = gfx_v10_0_rlc_stop,
 	.reset = gfx_v10_0_rlc_reset,
-	.start = gfx_v10_0_rlc_start
+	.start = gfx_v10_0_rlc_start,
+	.update_spm_vmid = gfx_v10_0_update_spm_vmid
 };
 
 static int gfx_v10_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 8f20a5dd44fe..b24fc55cf13a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
 	.resume = gfx_v7_0_rlc_resume,
 	.stop = gfx_v7_0_rlc_stop,
 	.reset = gfx_v7_0_rlc_reset,
-	.start = gfx_v7_0_rlc_start
+	.start = gfx_v7_0_rlc_start,
+	.update_spm_vmid = NULL
 };
 
 static int gfx_v7_0_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fa245973de12..66640d2b6b37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs iceland_rlc_funcs = {
 	.resume = gfx_v8_0_rlc_resume,
 	.stop = gfx_v8_0_rlc_stop,
 	.reset = gfx_v8_0_rlc_reset,
-	.start = gfx_v8_0_rlc_start
+	.start = gfx_v8_0_rlc_start,
+	.update_spm_vmid = NULL
 };
 
 static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9b7ff783e9a5..df872f949f68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4704,6 +4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	u32 data;
+
+	data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
+
+	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
+	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+
+	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+}
+
 static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v9_0_set_safe_mode,
@@ -4715,7 +4727,8 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.resume = gfx_v9_0_rlc_resume,
 	.stop = gfx_v9_0_rlc_stop,
 	.reset = gfx_v9_0_rlc_reset,
-	.start = gfx_v9_0_rlc_start
+	.start = gfx_v9_0_rlc_start,
+	.update_spm_vmid = gfx_v9_0_update_spm_vmid
 };
 
 static int gfx_v9_0_set_powergating_state(void *handle,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
