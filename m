Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E98C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 12:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB5B2073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 12:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NLiuTVXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB5B2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF22F6E2E1;
	Thu,  5 Mar 2020 12:09:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5496E2E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 12:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTNNCJnMCQQykALO405EKYTKtA5ps9PRQaibEO8aUMB2lsE70Lz0JLMWJF/VBB5gYUt5CShCMy5AeL+OcU9TA8mK12B9HsWYRLILSGA3Ud+TKl98Alw45ONfeuCFW/Vb4CO3uBY+eGWiVvhcamfvTrhTmIeHQX02FjknOTTgtHgFwSn+fgmZnaQivP8epE345kOM9YOVjrjK07a+cFjeWHv5NWzEy9rs8F2NvbNS0AqJ5GDvrJOMwRK/8SXe8tyd32YYLeWhWepDvqN0q0qGNSNE4VAD6fN/gnkd9PXio554MP+cLZOsiutwKy/zyz0Xr6bMWdVq3N12MjoP8PjXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZtj1OgLD1ea2eGqkv6Q1l0it+Y5p18cc53h9jlv3fM=;
 b=BJw34ALiSHEpdL6XxTT8iSoVSA90Gk2PoKGQS7VIvylVGbjn+pzWQmviVWFdyFpBrjYOJ0tkVdiYAt5UvMYOTcOlcYxLiXqYg4C4Jo6R9nLUcekCkdM08TRId9VE/9yYGqCOCILCqVx4jNbU76nEKsJAxv6n7A50xS8xwdp15mydKCrpFJpO4dh48kb2eZRi4Rms0cTO58NLlthGUNNy0WgwXD7elNxOVCRTcBfVmURpBZB1BCQEIDyk5ADumwXOgbUjqymBP87rsTH3OIe+Sp2zdM19AeIRYm47P/VylAhFxaZKZ4xzQbGzNJaq3eEy/hDh8K6lSlLMmicczMC+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZtj1OgLD1ea2eGqkv6Q1l0it+Y5p18cc53h9jlv3fM=;
 b=NLiuTVXS85yIs2GjTo4xad+1vmx2kEnEqlKCvN0zEnPk8yBgVCRzkZcWyoWLBr9SqoDr3CUqyUQCkJT6KqSU2k1wz+y22wajzvyism7vUtcqr4QG+s8gwblAP88N+KFaWevVcbNRjJuWkOuQCVIBfTRSfPBeF8YcqrWG908xXk0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 by MN2PR12MB3007.namprd12.prod.outlook.com (2603:10b6:208:d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 5 Mar
 2020 12:09:19 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 12:09:19 +0000
From: Jacob He <jacob.he@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Date: Thu,  5 Mar 2020 20:08:53 +0800
Message-Id: <20200305120853.27739-1-jacob.he@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To MN2PR12MB3376.namprd12.prod.outlook.com
 (2603:10b6:208:c2::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jacob-Linux.amd.com (180.167.199.189) by
 HKAPR04CA0015.apcprd04.prod.outlook.com (2603:1096:203:d0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 5 Mar 2020 12:09:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c00f662-3bee-4307-73d9-08d7c0fe0877
X-MS-TrafficTypeDiagnostic: MN2PR12MB3007:|MN2PR12MB3007:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3007749303B9DA4EBB8210E09BE20@MN2PR12MB3007.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(81166006)(81156014)(8676002)(186003)(16526019)(478600001)(26005)(956004)(44832011)(2616005)(15650500001)(36756003)(1076003)(6666004)(8936002)(52116002)(7696005)(86362001)(5660300002)(6916009)(316002)(66476007)(66946007)(2906002)(66556008)(6486002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3007;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Lu//27EDmALOOrt39By0vQJ6UaSAJhzgtLS5sHPyPVV7RUzTLk8/V/OgJLcYZFsZwMHm4NScgSFO/SZpoNcdtNszJrpX1jCFFZ1rUXKvTyL9usygqAnrpdSzllZFy+Fv1JL15jhjIBIbWf+d1W29nxIqChAurq0tnePQkcti7t7538ranEIx/wCaiQHY/JWkBNX98+EdKA8Pk6vBjMhzb7B9uzDod0WETt+BJwzsHiQoi1P59eU+btOh0lbOLi1K7dL30Sda7+aGbFr/iKplxoEohRxaZpUi9Qjv/uJlyVisnCRdOomMoh5p7DuRKNExrfK0kW0oJHLNP3G1hZQ71UPWAGFFtyiXH7XdZ6WloQnp8HxQ1neoz5AXzL2jxKOboooTKrPdZ2JyYEegLUJAD4I1HWgunEh0JYLvBl45KkAo+CY3Ensy06duGjr43lO
X-MS-Exchange-AntiSpam-MessageData: TbcrnMzOs353Y4scouAlh/l8vnZMW996y3dBB0MIN4qY+dWvOZ0irjKaX3WtvruRyBhbNbwX2StQhK9pXXnCqs6mvSOyc2NUG/PRGfMr+bE5D211tbp/2lNPyeqyDfjsbA3A71htjA2F7tnB7h/mDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c00f662-3bee-4307-73d9-08d7c0fe0877
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 12:09:19.6194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fo565tNtDWsw0Xx/HY0bQ/1jf4l+L0nOuSG03MfGZYUeksXQ1kC10haPQINlui/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3007
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c00696f3017e..73398831196f 100644
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
@@ -3224,6 +3229,21 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return r;
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
+		if (amdgpu_sriov_runtime(adev))
+			timeout = 8 * timeout;
+
+		/* Wait vm idle to make sure the vmid set in SPM_VMID is
+		 * not referenced anymore.
+		 */
+		r = amdgpu_bo_reserve(fpriv->vm.root.base.bo, true);
+		if (r)
+			return r;
+
+		r = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
+		if (r < 0)
+			return r;
+
+		amdgpu_bo_unreserve(fpriv->vm.root.base.bo);
 		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB_0);
 		break;
 	default:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
