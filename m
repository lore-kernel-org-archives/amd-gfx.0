Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59E0C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 05:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840E124697
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 05:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wSZDajDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840E124697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609356E049;
	Mon,  2 Mar 2020 05:36:00 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680082.outbound.protection.outlook.com [40.107.68.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCC96E049
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 05:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqFCbllBoYa8N42hM8ZlAJr0SvNCZ4pfJ56dj6B5yCNJVrG2xWxkSRGzMQ+IwtbgMiQ2EhsY9U3+Pwb6/WF6FrugTwoLtvReeq51R5YPegIPsH5IM4csLsNYemuQqQJhp54+qyjuBCmDA6bonRFGrUFEbKL/P16lkB5MSUMq5GEog0UUS3nLtFPFq8JUqIsMPeOd8OZfC9yXoOSwnMfbmEoGYTwRaMPsOB7NyTubKduyqswbu1O/BLfSl02Xq7jC4IgLlezDKqeGLQgPPHw3kUk+qKh9NYqGrrF4cq/3hEm2b75bl1mw9yLHKxIPEXZ8qB8+d1aTflSO3539Q46oTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ve1GG3g28AaXzgrrHqcqxpqY+n7PLv6OVleG+PzEOQ=;
 b=mjXQJ40eXJhcKbp6P41Z7gk7izaaqGqDoUrO3TJ6BdZXORy+rK1vnJ9FVWCsZJNJKgsTpGubgJzSbeOE6xFZ6VMMnNVGBEwkAduOplvxMMgwPNAysmz2n9WXMsESpNw8Z2oCqUXxp0l8qWh8jWGdQACoGdVfeuxsYZGZJBDzYzYLVUHrg22T5oChADdMA+v/S1yRYbYNJnjDHj08BFPVVOBZaLyheCMqYBLIdtoWWOC6Prk1094j+XfcQvmf9mAdNHe80dEHB5RztCvkUqe6370aLk6gBNwJTYv/akNv6ePJabOgWZHnBCNxXYake6epVVmMuATBdCHuUA73aelDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ve1GG3g28AaXzgrrHqcqxpqY+n7PLv6OVleG+PzEOQ=;
 b=wSZDajDbN7qg5rj3VY9QhdydBeFPAz32TlJAauwbIoXjC1AbfmqOr0DTsaiZyVy/k0KTOI/oZHWwu0eLdnKvLb6f6ePdr7nU/sukktfcKlAFpxUG4tFIG5sL7JsMAsrempkRDo/C0lYyRc0VhFzXgH7NZWpH/t5k77ygQjf9g8E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 by MN2PR12MB3790.namprd12.prod.outlook.com (2603:10b6:208:164::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 05:35:57 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 05:35:57 +0000
From: Jacob He <jacob.he@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Date: Mon,  2 Mar 2020 13:35:29 +0800
Message-Id: <20200302053529.5736-1-jacob.he@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To MN2PR12MB3376.namprd12.prod.outlook.com
 (2603:10b6:208:c2::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jacob-Linux.amd.com (180.167.199.189) by
 HK2PR02CA0221.apcprd02.prod.outlook.com (2603:1096:201:20::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16 via Frontend Transport; Mon, 2 Mar 2020 05:35:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6455099-bf16-4c47-a6f7-08d7be6b9519
X-MS-TrafficTypeDiagnostic: MN2PR12MB3790:|MN2PR12MB3790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3790EA72BD0BF66C36DA60229BE70@MN2PR12MB3790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(52116002)(316002)(7696005)(8936002)(6486002)(86362001)(44832011)(6666004)(36756003)(6916009)(81166006)(81156014)(1076003)(8676002)(5660300002)(2616005)(4326008)(16526019)(15650500001)(2906002)(186003)(956004)(478600001)(66476007)(26005)(66556008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3790;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/nh2+5PmuGhZTcED0+NhFeQSr/eebi+aICXrPDt4eTl8ke8JIeANKAPx4sAG2AFgLRJ1tB+RdCkZ+SYqv2d7VLfSQtUGJKK3frWh7FMkVRe+HSPIA/n71gfvybxTzfc/mrM0ohQ8mvhqH9dW0eOXSy7ch7l8e1nkXRFKWSg2nPnam42tXdFdFQFo0mXKkXGJ+wyv1lRCqwdGY96Puaf7T46ILl9VEHfbKmDgDyhqlwv4eHb+43IUlFr3JMdUNduYf9+iHUOR6aIrkMXmWpU7q1DvUAdmYnAvYZeCBMyb+vETlxMTNG7HoW0tbjXx9rrsG+d2g3Zd1DGPCABwUJJU9xSxU51fOPv1nESccg75YbYIrgriJSegUthNqPXiZS9qEKlXYlZBNkHtLH3EkjaYVftf9MxLxzxg76r08JTCvCuyZ5SgQWo0P2i170ajzEC
X-MS-Exchange-AntiSpam-MessageData: 6VG6rTXJy2BFXu87yMK89wGA3C8cqWkOj7nRikGkLBySqm0t0cmNilRNyBHeAJPV1MxJA8+z5NCxIq2r26RbSys01ccnwc0KngvZrOc/eqDpcD94Yt/trUJvbdI90dVY8aXiX6rn7iSBTPONqABUEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6455099-bf16-4c47-a6f7-08d7be6b9519
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 05:35:57.2296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfgCdVlLe6gmb3cVVk6ivkAkdEPlAyFM/VOz7sIM9crQTQ+0Zrg75ZpEZ2DfwxZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3790
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c00696f3017e..c761d3a0b6e8 100644
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
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
