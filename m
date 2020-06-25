Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1181C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 03:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764E320789
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 03:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gzYIADOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764E320789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321DB6E32F;
	Thu, 25 Jun 2020 03:19:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8052C6E32D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 03:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGeAWPnINARqlPsDvTRGMf4arG5/75pjBvSOnNmImd4p9ttdRz1Pop+mUL0C2w+mYoTZlFdDCrMsVs/Ol0WzGXPpFXUWUUMJ3ZxWpd5RClwiPKbNQzCIf2Kf51/MyMAbn+5UN7eFA5EH8urujM+loJoxtLmud69ejasUjpDm4zepxCsHKiDbCyQnNVBqDlYuIuoyPNjKF6ox34jLvVvANthtSjYzhqQA/XCtlA7fKFsLPV3lqgGRZgQ8WqNdYmVXOzpPFAsCvMCTWPagBxOF9WQMAalVsVvNiohGgW2W7o2r4s6guFoWZu6YxShiGXjgF785cd2qfItGILSbIMqyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNKU7+Ox61mVeCQY1k0ulLSAnpMJXiTpx8tBuqHpcoo=;
 b=BLj+PUROuM3IHa4frFS+tBlvUre2RPjNfyRan+0fUEr0/GaaQ1XoX4E0koLZ8tYAZHaloHz3vmlNRLjwnxM4XXS+X9gMB7LN7YgixIj+ilN7ARMOMFBkBX8YasgXU+uOmKk9/kBhjN5t1VbRe1WhlB786G09m/HR3WKBWq9DvO3Oz9LEpO0U6TrG5To0lDByb8YS0T1Ao/sIiQ2BYRSIrCK1eHwCUed0oXZjNatEmBAoVK/GNlKdIMiM0HCMznxWWibHwJsyANEhjbshxx9usseb50FBp57hPvYK0ewOyCE8+cZQ7T3CBU5YTQOJN7U6O8pf1Qc2MtxjdoUW8rEUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNKU7+Ox61mVeCQY1k0ulLSAnpMJXiTpx8tBuqHpcoo=;
 b=gzYIADOA/KMXJhzhXkqEx00g/vSfS+jGbkCq7sGYQBIHc1igi/Nn5NYr28YaZQ9woBaUMTFvSUvN3w/pNv6EL/InY69lDt1T4ZLZMS6DYTGvf9pnbcZtUCY3lWWieX7uZ7Htn3169MKfsXTjBCCMUthwSJsku60FcPt42Ca2RuQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 03:19:01 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Thu, 25 Jun 2020
 03:19:01 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
Date: Wed, 24 Jun 2020 23:18:34 -0400
Message-Id: <20200625031834.16122-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200625031834.16122-1-Felix.Kuehling@amd.com>
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::43) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 03:19:01 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d10cc214-be72-4dab-7541-08d818b681dd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44308BFB304FA2EFA082AE8092920@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTFYSfcFLGmJJ3BV2JvzQxMb/KpXV+VYUPnttqfwf/P5DlBOrkHSWMHdEiEzfTgl1eB92xBcWGWS8NsoGDid/cDwyaTjuV+eCo+PPAP60L97J4Dl9e7RXGhYDAJSArkJf4SHqn7JieMkwDY1uPShaskNWRqnDBR8uT3sFI8LnSgc/Qx1RuScwFaUx5KI9w+r12LTvNPRJyJiogUC7zo+ZYn+bbHmykwt6xqXvoYVmkEYhpmdUwZv/dI7p4oZEJUobwDwO0KhGqFFd9tw4HEonQ9BPtJH8SW47u0mTZDtqBR+oN7DTWheqIx1d7q/oQC2pGmkRSFxr+/nxX4vJ96mnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(36756003)(5660300002)(2616005)(26005)(6666004)(66476007)(478600001)(956004)(2906002)(16526019)(83380400001)(66946007)(66556008)(6486002)(186003)(1076003)(316002)(52116002)(7696005)(6916009)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3DOL0jAMBFBOZAcOhSrQvuYjF8XU7WJfF0LEyOYPUXNJfdm4f1a77byo9J2jrHME5BXWSbuOOEqYaMz4O5iO9AS/WnLjHP0hlmLfFmAEi6dmeWneWhc6t7h3y/A2edbfRJu7Tk4hYrFaqIZu4c+8nA//0B35lpu+8rQP27EQWNQJWOof0s5BPZEdbx0vrP7ANOladkOOb0ZoaMws3EIpx1dE7QvX4OfyKUIRv40Ig50bIjcyAe2FX4ag9pWgSsKg8JDauo9CohrygkD5FmgL1axC5k3ayLxvL2BbvYbbslYUXGITEs9iSGIUOoZZ2E5WmZmXuXnIR39VGrI8Bc8zc9hyp1ekOgoHjcTPofb0pKZ8nbNcnYrdxrlc9rgzjzPBs9DknmY9rWNz5Xhm6heZyj5goim20uwe3cbhAqVzj937WeLW1C70FSHG7Do9L2OPDwUoNBngmI1k/5r5Sl7KxmsvmQGpM5gwPhXdoQOLOt9jqs/0Ur6BlQWdVpK5bl04
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10cc214-be72-4dab-7541-08d818b681dd
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 03:19:01.7882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XblljjI8+3InrX2mONBYXnsprdNHz/TFB6uUXp+CV7t8vHNwFKNQQIeD1f6spoO9ZmzcKjaKRPzW2gGyN0tqgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When there is no graphics support, KFD can use more of the VMIDs. Graphics
VMIDs are only used for video decoding/encoding and post processing. With
two VCE engines, there is no reason to reserve more than 2 VMIDs for that.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6e10b42c57e5..3470929e5b8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1245,10 +1245,15 @@ static int gmc_v9_0_sw_init(void *handle)
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
-	 * amdgpu graphics/compute will use VMIDs 1-7
-	 * amdkfd will use VMIDs 8-15
+	 * amdgpu graphics/compute will use VMIDs 1..n-1
+	 * amdkfd will use VMIDs n..15
+	 *
+	 * The first KFD VMID is 8 for GPUs with graphics, 3 for
+	 * compute-only GPUs. On compute-only GPUs that leaves 2 VMIDs
+	 * for video processing.
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid =
+		adev->asic_type == CHIP_ARCTURUS ? 3 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
