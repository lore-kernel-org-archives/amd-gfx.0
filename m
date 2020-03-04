Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA83C3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 04:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9152120CC7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 04:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uQQhnaPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9152120CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9886E11A;
	Wed,  4 Mar 2020 04:07:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979916E11A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 04:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuOXnu2MKwOl8QxJEomV64iUbtQdj09ShPnbx8MpzKSBCxAqDrmV4keLHzTlfTq5BP2tdFBM02ET10lnI7qizY83cDyUqycMYTvRoqQQ3P6eHCQcfaQfX5qE5xcqHKopFDEg8B/sY3B5tXD/oAQKxVXkwEv5bWOAZQ5KUgt2Zio1XNMfBqpYpGjNw69+FR6ZFQSRfQfj1hpQseIFQ6R7+IIsNqvKvKLTEJmHWkLeRec34vxAMAsNQh0dMoaXgnm9TxNQsLPV4T4DVumWQh6AwXlK2StOYitHJH2hei5c4Gew2iFyGtCY+9hB2laq9mk35r9uda5Xy6EG8XSH1wdZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FEP6FBA/nQJGSjO6d6+XuKP6mgftBtwQHKLq76LLwU=;
 b=DknGKo+uwEMJYB7fXSeJh8xj/+b0HZKJoSUQNkUZQ4meGMtdZmMHlgpBzGPjXApUfyikASw1VLSWFy009ieFIf8/GNK0qyx6knX9klQYWkgk+rsthOhj1f7vSjBOxwOlANVwMje42Eehx9aPP9eYC2/bDF28rSQAGlQetp6htzPMJAA0ANOYQe2NaHSiIhdesVKBlmGRlChT20KC0cEB9OHswdrc3/l2x9PS1JVl4NHUBTRmiEOvNbQN8LjTJwUcdzyngYNhtMvWA1sm5vR70n2O/FzLFIL7YgJpkWyzARM5BQ00UoblxAodyuYvC5UHfEcRdzkFZYfgVaQ8ZCPQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FEP6FBA/nQJGSjO6d6+XuKP6mgftBtwQHKLq76LLwU=;
 b=uQQhnaPKgZGs9uIXzzc2eMvDBlXyhNtLpKTU3Tjry1Xmt6/X6F4BPeDjMyfWStXAn7FlruWtHFY8mFJPM0ryPJ33Ynv5OZuJaM9ZVnuf+UyI+eU21iZiG/ahjfnRD+b1cTqq6E1MObWlFZELatcx2hLb/wuzI6hVPZOpJnlQjLM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 by MN2PR12MB3471.namprd12.prod.outlook.com (2603:10b6:208:c8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 04:06:57 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 04:06:57 +0000
From: Jacob He <jacob.he@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Date: Wed,  4 Mar 2020 12:06:36 +0800
Message-Id: <20200304040636.5280-1-jacob.he@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To MN2PR12MB3376.namprd12.prod.outlook.com
 (2603:10b6:208:c2::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jacob-Linux.amd.com (180.167.199.189) by
 HK2PR06CA0018.apcprd06.prod.outlook.com (2603:1096:202:2e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 04:06:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1bfb4a4e-58bd-48a3-22c0-08d7bff17b2d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3471:|MN2PR12MB3471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3471F3DC9F53EB8CB6800D1C9BE50@MN2PR12MB3471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(7696005)(956004)(52116002)(2906002)(316002)(2616005)(478600001)(16526019)(6666004)(44832011)(26005)(186003)(36756003)(66946007)(86362001)(15650500001)(5660300002)(8936002)(6486002)(66476007)(66556008)(81156014)(4326008)(8676002)(6916009)(1076003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3471;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vE0rQA2UIMl1JevsKs8ZAlF8Db4KR4lQQgzbpsO15TO3klZFFe1CWuwwMxbpWWF3iHgs8nhwoGRYJPCqvWGxuY6QEx3p0FXDKeAOJmK/pLxsG8y3rc3eDq9hzZyRU8Ye0Lq+fY9RDfWZYUkyq2FI7tq+bRs1I8c6rJ2N01Yra2cEBwG3BEYY/vmtW193Mw2U/Xm9IICr84nPr3nOSbSgsYjp7S0VFe7zBYivZmaKQh33WU2YPJMztC+4nCrjdnRaf8clwLUNtUnpJpbHp4sB90CI7LPErm8M2Lb7LiFA5fAnY9RGzXFR/Refqd26YGEj85OJEroujyPZgybGwkp+WgEp75znB7csmMKJvhrhWFZcGYrukM3lNB6OddAp0ZH/B2nT1rxkq9Okw3JmI1t0VFSIcRCJ7GX1+lQsoZGZGva0lxzz65zs1CVrXyz66exH
X-MS-Exchange-AntiSpam-MessageData: i7TcVtrAXU+iKKAD83HnyMIgrxVqJmEB3xfwOturQFlyHLIKR0Wu9B3DexFbFIqyKSjV+/9gEDJbXcZaM8we0HS9iquns7aOwKwbZATWaOWO10DoUyLea2VLUjzHuEwzgTisNBAW2X2pPP+FGMfAvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfb4a4e-58bd-48a3-22c0-08d7bff17b2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 04:06:57.4161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+ev6BOIPCPC2zBWKOvf00fCS6HF2XTFR2t0XdYMIpWcPUk6qXdvtO32SWQfod/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3471
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

SPM access the video memory according to SPM_VMID. It should be updated
with the job's vmid right before the job is scheduled. SPM_VMID is a
global resource

Change-Id: Id3881908960398f87e7c95026a54ff83ff826700
Signed-off-by: Jacob He <jacob.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c00696f3017e..f08effb033a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1080,8 +1080,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct dma_fence *fence = NULL;
 	bool pasid_mapping_needed = false;
 	unsigned patch_offset = 0;
+	bool update_spm_vmid_needed = (job->vm && (job->vm->reserved_vmid[vmhub] != NULL));
 	int r;
 
+	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
+
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
 		gds_switch_needed = true;
 		vm_flush_needed = true;
@@ -3213,6 +3217,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	union drm_amdgpu_vm *args = data;
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	long timeout = msecs_to_jiffies(2000);
 	int r;
 
 	switch (args->in.op) {
@@ -3224,6 +3229,15 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return r;
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
+		if (amdgpu_sriov_runtime(adev))
+			timeout = 8 * timeout;
+
+		/* Wait vm idle to make sure the vmid set in SPM_VMID is
+		 * not referenced anymore.
+		 */
+		r = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
+		if (r < 0)
+			return r;
 		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB_0);
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
